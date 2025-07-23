Return-Path: <linux-kernel+bounces-742834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BDBB0F726
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E01D71C81C12
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A11F5827;
	Wed, 23 Jul 2025 15:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2ku0l8X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C531A1FDE19;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753284963; cv=none; b=PnxXV3SEt+W4goGf42M5LQ8nzidMz7vwOXEDdG8fOMB6tlkFRuf5xipfP0iTKEc6kICu+8aRQfup64h2nNrn5DHoqpdfz3X1I+lMKPAQ8Gfx06+VPdjv5HDnhvGiUjXcOgcnAWhEyYOqErqHK8e7ilD2gOALNeu/ZaqjzqstYyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753284963; c=relaxed/simple;
	bh=rTQGugShZti2f9v7pSRRbFs59pGwLmOlLKMGN2HNkLQ=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=IY1t6gcQTY1LJZaQJEP6LZtV9XVOU8yOtdHY+ALZ7EOrw+unNoBS1zdU8SFOa9I9i2FMIITSW9oazJ2bJlpMuvJ0LHeuiLT46b0/WFqnMouHNj/ISebq43uvKwfYLOGqBcrYeiMsnM5F9c7h/E1+faCQCV0lviAkVwO5O0i6uWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2ku0l8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0BBC4CEFB;
	Wed, 23 Jul 2025 15:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753284963;
	bh=rTQGugShZti2f9v7pSRRbFs59pGwLmOlLKMGN2HNkLQ=;
	h=Date:From:To:Cc:Subject:References:From;
	b=e2ku0l8Xot3BTlM+bKXeTKYeDdHOvzhAjhX0bmKmhbGLs5MgVAoSQ4qzrJaqTS8Sp
	 8CRc3qyzAf5RiQ95rHQq9rnTi5baoNjB7Ruo2QXvzjtUWZec/ru0gbuuJQJ4bTjVug
	 Ix+slT4C51qR8b3l9+0pziT9Yi8yZWQ0bL/S1L3bBgOydTR3gkA4fFyatxWv2rdxYp
	 LJ/fBq9VRImcJ3FqGhXQte8oq5KGhnEdlvhw1W0ZUugiBoEpB4qmWNIivb8W0yOEJ2
	 F7szrQamhp0sFjboHM/H9JSkS/IYTbmgCVdv6zNIUVFRCf55mR4SyRTZc6qrJ8anyM
	 63vyBTdYiZUxQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1ueame-00000000LSg-3QMA;
	Wed, 23 Jul 2025 10:49:28 -0400
Message-ID: <20250723144928.669828393@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 23 Jul 2025 10:49:15 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
  <linux-trace-users@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Namhyung Kim <namhyung@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Al Viro <viro@ZenIV.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Frederic Weisbecker <fweisbec@gmail.com>,
 Jiri Olsa <jolsa@kernel.org>,
 Ian Rogers <irogers@google.com>
Subject: [for-next][PATCH 8/8] tracing: Deprecate auto-mounting tracefs in debugfs
References: <20250723144907.219256132@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

In January 2015, tracefs was created to allow access to the tracing
infrastructure without needing to compile in debugfs. When tracefs is
configured, the directory /sys/kernel/tracing will exist and tooling is
expected to use that path to access the tracing infrastructure.

To allow backward compatibility, when debugfs is mounted, it would
automount tracefs in its "tracing" directory so that tooling that had hard
coded /sys/kernel/debug/tracing would still work.

It has been over 10 years since the new interface was introduced, and all
tooling should now be using it. Start the process of deprecating the old
path so that it doesn't need to be maintained anymore.

A new config is added to allow distributions to disable automounting of
tracefs on debugfs.

If /sys/kernel/debug/tracing is accessed, a pr_warn() will trigger stating:

"NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030"

Expect to remove this feature in 5 years (2030).

Cc: <linux-trace-users@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Link: https://lore.kernel.org/20250722170806.40c068c6@gandalf.local.home
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../ABI/obsolete/automount-tracefs-debugfs    | 20 +++++++++++++++++++
 kernel/trace/Kconfig                          | 13 ++++++++++++
 kernel/trace/trace.c                          | 14 +++++++++----
 3 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/automount-tracefs-debugfs

diff --git a/Documentation/ABI/obsolete/automount-tracefs-debugfs b/Documentation/ABI/obsolete/automount-tracefs-debugfs
new file mode 100644
index 000000000000..a5196ec78cb5
--- /dev/null
+++ b/Documentation/ABI/obsolete/automount-tracefs-debugfs
@@ -0,0 +1,20 @@
+What:		/sys/kernel/debug/tracing
+Date:		May 2008
+KernelVersion:	2.6.27
+Contact:	linux-trace-kernel@vger.kernel.org
+Description:
+
+	The ftrace was first added to the kernel, its interface was placed
+	into the debugfs file system under the "tracing" directory. Access
+	to the files were in /sys/kernel/debug/tracing. As systems wanted
+	access to the tracing interface without having to enable debugfs, a
+	new interface was created called "tracefs". This was a stand alone
+	file system and was usually mounted in /sys/kernel/tracing.
+
+	To allow older tooling to continue to operate, when mounting
+	debugfs, the tracefs file system would automatically get mounted in
+	the "tracing" directory of debugfs. The tracefs interface was added
+	in January 2015 in the v4.1 kernel.
+
+	All tooling should now be using tracefs directly and the "tracing"
+	directory in debugfs should be removed by January 2030.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..93e8e7fc11c0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -199,6 +199,19 @@ menuconfig FTRACE
 
 if FTRACE
 
+config TRACEFS_AUTOMOUNT_DEPRECATED
+	bool "Automount tracefs on debugfs [DEPRECATED]"
+	depends on TRACING
+	default y
+	help
+	  The tracing interface was moved from /sys/kernel/debug/tracing
+	  to /sys/kernel/tracing in 2015, but the tracing file system
+	  was still automounted in /sys/kernel/debug for backward
+	  compatibility with tooling.
+
+	  The new interface has been around for more than 10 years and
+	  the old debug mount will soon be removed.
+
 config BOOTTIME_TRACING
 	bool "Boot-time Tracing support"
 	depends on TRACING
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0dff4298fc0e..06ab5b7a8711 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6296,7 +6296,7 @@ static bool tracer_options_updated;
 static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
-	if (!tr->dir)
+	if (!tr->dir && !(tr->flags & TRACE_ARRAY_FL_GLOBAL))
 		return;
 
 	/* Only create trace option files after update_tracer_options finish */
@@ -8977,13 +8977,13 @@ static inline __init int register_snapshot_cmd(void) { return 0; }
 
 static struct dentry *tracing_get_dentry(struct trace_array *tr)
 {
-	if (WARN_ON(!tr->dir))
-		return ERR_PTR(-ENODEV);
-
 	/* Top directory uses NULL as the parent */
 	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return NULL;
 
+	if (WARN_ON(!tr->dir))
+		return ERR_PTR(-ENODEV);
+
 	/* All sub buffers have a descriptor */
 	return tr->dir;
 }
@@ -10249,6 +10249,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
+#ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
 static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 {
 	struct vfsmount *mnt;
@@ -10270,6 +10271,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
+	pr_warn("NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2030\n");
+
 	ret = vfs_parse_fs_string(fc, "source",
 				  "tracefs", strlen("tracefs"));
 	if (!ret)
@@ -10280,6 +10283,7 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	put_fs_context(fc);
 	return mnt;
 }
+#endif
 
 /**
  * tracing_init_dentry - initialize top level trace array
@@ -10304,6 +10308,7 @@ int tracing_init_dentry(void)
 	if (WARN_ON(!tracefs_initialized()))
 		return -ENODEV;
 
+#ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
 	/*
 	 * As there may still be users that expect the tracing
 	 * files to exist in debugfs/tracing, we must automount
@@ -10312,6 +10317,7 @@ int tracing_init_dentry(void)
 	 */
 	tr->dir = debugfs_create_automount("tracing", NULL,
 					   trace_automount, NULL);
+#endif
 
 	return 0;
 }
-- 
2.47.2



