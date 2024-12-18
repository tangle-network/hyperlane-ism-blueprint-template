use color_eyre::Result;
use hyperlane_ism_blueprint_template as blueprint;
use gadget_sdk as sdk;
use gadget_sdk::runners::tangle::TangleConfig;
use gadget_sdk::runners::BlueprintRunner;

#[sdk::main(env)]
async fn main() -> Result<()> {
    // Create your service context
    // Here you can pass any configuration or context that your service needs.
    let context = blueprint::ServiceContext {
        config: env.clone(),
    };

    // Create the event handler from the job
    let say_hello_job = blueprint::SayHelloEventHandler::new(&env, context).await?;

    tracing::info!("Starting the event watcher ...");
    let tangle_config = TangleConfig::default();
    BlueprintRunner::new(tangle_config, env)
        .job(say_hello_job)
        .run()
        .await?;

    tracing::info!("Exiting...");
    Ok(())
}
