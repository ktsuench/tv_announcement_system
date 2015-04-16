
<!--Off Canvas Navigation-->
<!--Nav Public-->
<%verified=session("verified")%>
<%if not verified then%>
<ul class="nav-offcanvas">
	<li>
		<div class="panel-group">
			<div class="panel panel-default"><a href="announcements.asp" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">View Announcements</h4>
					</div></a></div>
		</div>
	</li>
	<li>
		<div class="panel-group">
			<div class="panel panel-default"><a href="login.asp" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">Login</h4>
					</div></a></div>
		</div>
	</li>
	<!--+nav-item("javascript:$('#email').val('guest@rciann.com');$('#pass').val('l0ck3d_0u7!');$('#loginfrm').submit();",'Demo Dashboard')-->
	<li>
		<div class="panel-group">
			<div class="panel panel-default"><a href="page_under_construction.asp" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">About</h4>
					</div></a></div>
		</div>
	</li>
</ul>
<%else%>
<!--Nav Dashboard-->
<ul class="nav-offcanvas">
	<li>
		<div class="panel-group nav-offcanvas-accordion">
			<div class="panel panel-default"><a data-toggle="collapse" data-parent=".nav-offcanvas-accordion" href="#nav-offcanvas-menu-1" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">Announcements</h4>
					</div></a>
				<div id="nav-offcanvas-menu-1" class="panel-collapse collapse">
					<div class="panel-body">
						<ul class="nav nav-pills nav-stacked">
							<li><a href="ann_add.asp" target="content_container">Add Announcements</a></li>
							<li><a href="ann_list.asp?action=verify" target="content_container">Verify Announcements</a></li>
							<li><a href="ann_list.asp?action=list" target="content_container">List Announcements</a></li>
							<li><a href="announcements.asp" target="_blank">View Announcements</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li>
		<div class="panel-group nav-offcanvas-accordion">
			<div class="panel panel-default"><a data-toggle="collapse" data-parent=".nav-offcanvas-accordion" href="#nav-offcanvas-menu-2" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">Members</h4>
					</div></a>
				<div id="nav-offcanvas-menu-2" class="panel-collapse collapse">
					<div class="panel-body">
						<ul class="nav nav-pills nav-stacked">
							<li><a href="mem_add.asp" target="content_container">Add Members</a></li>
							<li><a href="mem_list.asp" target="content_container">List Members</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li>
		<div class="panel-group nav-offcanvas-accordion">
			<div class="panel panel-default"><a data-toggle="collapse" data-parent=".nav-offcanvas-accordion" href="#nav-offcanvas-menu-3" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">Profile</h4>
					</div></a>
				<div id="nav-offcanvas-menu-3" class="panel-collapse collapse">
					<div class="panel-body">
						<ul class="nav nav-pills nav-stacked">
							<li><a href="mem_list.asp?action=profile&ID=<%=session("id")%>" target="content_container">View Profile</a></li>
							<li><a href="mem_add.asp?action=editExisting&ID=<%=session("id")%>" target="content_container">Change Password</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li>
		<div class="panel-group nav-offcanvas-accordion">
			<div class="panel panel-default"><a data-toggle="collapse" data-parent=".nav-offcanvas-accordion" href="#nav-offcanvas-menu-4" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">Settings</h4>
					</div></a>
				<div id="nav-offcanvas-menu-4" class="panel-collapse collapse">
					<div class="panel-body">
						<ul class="nav nav-pills nav-stacked">
							<li><a href="page_under_construction_dash.asp" target="content_container">Announcement Display</a></li>
							<li><a href="page_under_construction_dash.asp" target="content_container">Dashboard</a></li>
							<li><a href="page_under_construction_dash.asp" target="content_container">Messages</a></li>
							<li><a href="page_under_construction_dash.asp" target="content_container">About</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</li>
	<li>
		<div class="panel-group">
			<div class="panel panel-default"><a href="logout.asp" class="panel-default">
					<div class="panel-heading">
						<h4 class="panel-title">Logout</h4>
					</div></a></div>
		</div>
	</li>
</ul>
<%end if%>
<!--end Off Canvas Navigation-->