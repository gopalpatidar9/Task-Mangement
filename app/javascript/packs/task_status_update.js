$(document).ready(function () {
	update_task_s = (e) => {
	  let task_id = $(e).attr('id');
	  let task_status = e.checked ? 1 : 0;
  
	  jQuery.ajax({
		type: 'get',
		url: '/update_task_status',
		data: { "task_status": task_status, "task_id": task_id },
		success: function(data) {
		  // Update the task list
		  $('#show-tasks').html(data);
		}
	  });
	};
  });
  
