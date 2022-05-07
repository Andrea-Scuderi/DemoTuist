import ProjectDescription

extension Project {
  public static func featureFramework(name: String, dependencies: [TargetDependency] = []) -> Project {
    return Project(
        name: name,
        targets: [
            Target(
                name: name,
                platform: .iOS,
                product: .app,
                bundleId: "io.tuist.\(name)",
                sources: ["Sources/\(name)/**"],
                resources: ["Resources/\(name)/**",],
                dependencies: dependencies
            ),
            Target(
                name: "\(name)Tests",
                platform: .iOS,
                product: .unitTests,
                bundleId: "io.tuist.\(name)Tests",
                sources: ["Sources/\(name)Tests/**"],
                resources: [],
                dependencies: [.target(name: name)]
            ),
            Target(
                name: "\(name)UITests",
                platform: .iOS,
                product: .uiTests,
                bundleId: "io.tuist.\(name)UITests",
                sources: ["Sources/\(name)UITests/**"],
                resources: [],
                dependencies: [.target(name: name)]
            )
        ],
        schemes: [
            Scheme(
                name: name,
                shared: true,
                hidden: false,
                buildAction: .buildAction(
                    targets: ["\(name)", "\(name)Tests", "\(name)UITests"]
                ),
                testAction: .targets(
                    ["\(name)Tests",
                     "\(name)UITests"]
                ),
                runAction: .runAction(executable: "\(name)")
            ),
            Scheme(
                name: "\(name)Tests",
                shared: true,
                buildAction:  .buildAction(
                    targets: ["\(name)", "\(name)Tests"]
                ),
                testAction: .testPlans(
                    [.relativeToRoot("TestPlan/\(name)Tests.xctestplan")],
                    configuration: .debug,
                    preActions: [],
                    postActions: []
                )
            ),
            Scheme(
                name: "\(name)UITests",
                shared: true,
                buildAction:  .buildAction(
                    targets: ["\(name)", "\(name)UITests"]
                ),
                testAction: .testPlans(
                    [.relativeToRoot("TestPlan/\(name)UITests.xctestplan")],
                    configuration: .debug,
                    preActions: [],
                    postActions: []
                )
            )
        ]
    )
  }
}
