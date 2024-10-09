plan:
	terraform plan

create:
	zip -j mark_in_progress.zip mark_in_progress.js
	terraform apply --auto-approve

destroy:
	terraform destroy --auto-approve
	rm -drf mark_in_progress.zip

