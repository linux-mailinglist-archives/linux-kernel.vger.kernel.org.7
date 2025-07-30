Return-Path: <linux-kernel+bounces-750123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C424EB15787
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 04:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CED2D4E0D81
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 02:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CF31DF974;
	Wed, 30 Jul 2025 02:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXR7Pbje"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F601D54EE
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753842250; cv=none; b=fPGKqeF696UkO++i7qL96xFjMrHBdzNxisED5l/L6rKWNpIXxBjh8u70XyTLU1bO/8gz+mJ/pnYxumopcHOcPmnHolbdbge8CIlNoYa2jcC6lirF6HCVmLFnGUMIuqIin0c4fgnwD4to0+nbCr7fPpEVg7bFyCOiT3i+h29/6u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753842250; c=relaxed/simple;
	bh=9Ujt5KaGB2d5xYGZWoI/rd724qikJUaU1Yrwkr7rzPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B39KlCHu5b+QENKoBsFxVYSe0Vybo8SoPf++jHb4JYxd3rN58EbzP/ZCGLyOX+hEuwc0GgBdgU8wwcpLmj3apUGd23inzU2ONXBT5rklOQQhLK3sWCvRrFaPMhIITUspR36HEluj1xzz29H6MDBFImAwkAGS4zyxo2LIZ985JeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hXR7Pbje; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuzhuo.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2369dd58602so66631625ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 19:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753842248; x=1754447048; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=db7w+qlj3x6A30qhGk3svrDuPx+Id3qEqe7Z1wrV5Fc=;
        b=hXR7Pbjevb5yl4z410JO/4uNbP4zs2ic5lmmZvYQdEhYd4xdM6Ay3PoBi2TKgzyMhT
         7wJPpzjoLuse61ta58OwtGP6rwmxdDKK6qiBKKSLO0P+HRYnv3aq1JK+AxWYP0kvVWex
         Qzqm66JxUz3GdVICx1VfinwkwB+fi4rBnH4yBOlnzYDIinDRHHCl8wlTduORvrhk7RQJ
         ct8MwHk4ZQ4SJ7LXJwlnqWel/BGYMzaYIdRjrP2O0AaYd0zuiYK14egq/hDbvdECi0/f
         hjAApxTyp0DFGg714R/eeIZAaXHq+prSivwtmGpKJ/y2gEph5Nn4FHpBWKYdycL1HoIb
         TJcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753842248; x=1754447048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=db7w+qlj3x6A30qhGk3svrDuPx+Id3qEqe7Z1wrV5Fc=;
        b=Jzv0TYhnei93Y3tXwl3AF4dfGY3ldYIgXLHDieMgF0+lpdlYMy2729ZqGKKgcbP4+n
         3TVQqHIH7r/0mlv0xxWFlkEbbX8ijZYastLzbR9mS55O8uuiO+iauOOaYoJz+ZrOBfjX
         aEOyUl98KdrS8wdh6s4W0CAMBFuN7W4ByHBk0S02WrGbg1tKUUQZF22WKeqKLrC9387I
         1HR/ndH2rO0RtMiZq4V+aUcol9fO/dIOFln4RsSWSnStQKHpsjNadduMccPb+aJ2q1R/
         wWn1SLp/L19N73fYUW8HeVj0cCODbBx0NhqgHC7516UOMzbZ2u25AyVc/Km8LGGOI6fR
         83cg==
X-Forwarded-Encrypted: i=1; AJvYcCXpXi/DzeASM1j9uf79+FjItTbMekyAJKQaKQZGfmdD4DrcddIoVaC6fec//OQSB7w6pvw4h61HFSCEsAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNW8SWSskxneYw6417eOclQW1shI6bKEDcb2Fspc0W3KkLVHLd
	/8X/roNQgY4dO6g6U8bsQdnkpsU/pPtCs+FkDJ01acbKH4UPyOkLQK4QuN0HhU5YhE4hzslmZmi
	k124iAA==
X-Google-Smtp-Source: AGHT+IHhLv6xFPeOTg+DJUtO46sNQgxdk80iCLDRyCDBD5ZkpZjf8Is9Cy4z221p/h5t/aI4fA2UkVY4hWU=
X-Received: from plhk16.prod.google.com ([2002:a17:902:d590:b0:234:bca4:b7b3])
 (user=yuzhuo job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f790:b0:240:3239:21c7
 with SMTP id d9443c01a7336-24096ba6594mr16406855ad.37.1753842247994; Tue, 29
 Jul 2025 19:24:07 -0700 (PDT)
Date: Tue, 29 Jul 2025 19:23:45 -0700
In-Reply-To: <20250730022347.71722-1-yuzhuo@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250730022347.71722-1-yuzhuo@google.com>
X-Mailer: git-send-email 2.50.1.552.g942d659e1b-goog
Message-ID: <20250730022347.71722-3-yuzhuo@google.com>
Subject: [PATCH v1 2/4] rcuscale: Create debugfs files for worker thread PIDs
From: Yuzhuo Jing <yuzhuo@google.com>
To: Ian Rogers <irogers@google.com>, Yuzhuo Jing <yzj@umich.edu>, Jonathan Corbet <corbet@lwn.net>, 
	Davidlohr Bueso <dave@stgolabs.net>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Josh Triplett <josh@joshtriplett.org>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, 
	Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Frank van der Linden <fvdl@google.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rcu@vger.kernel.org
Cc: Yuzhuo Jing <yuzhuo@google.com>
Content-Type: text/plain; charset="UTF-8"

Creates {reader,writer,kfree}_tasks files in the "rcuscale" debugfs
folder.  Each line contains one kernel thread PID.

This provides a more robust way for external performance analysis tools
to attach to kernel threads than using pgrep.

Signed-off-by: Yuzhuo Jing <yuzhuo@google.com>
---
 kernel/rcu/rcuscale.c | 124 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index ad10b42be6fc..7c88d461ed2c 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -143,6 +143,9 @@ static unsigned long b_rcu_gp_test_finished;
 
 static struct dentry *debugfs_dir;
 static struct dentry *debugfs_writer_durations;
+static struct dentry *debugfs_reader_tasks;
+static struct dentry *debugfs_writer_tasks;
+static struct dentry *debugfs_kfree_tasks;
 
 #define MAX_MEAS 10000
 #define MIN_MEAS 100
@@ -1009,6 +1012,112 @@ static const struct file_operations writer_durations_fops = {
 	.release = seq_release,
 };
 
+/*
+ * Generic seq_file private data for tasks walkthrough.
+ */
+struct debugfs_pid_info {
+	int ntasks;
+	struct task_struct **tasks;
+};
+
+/*
+ * Generic seq_file pos to pointer conversion function, using private data
+ * of type debugfs_pid_info, and ensure it is within bound.
+ */
+static void *debugfs_pid_start(struct seq_file *m, loff_t *pos)
+{
+	loff_t worker = *pos;
+	struct debugfs_pid_info *info = m->private;
+
+	if (worker < 0 || worker >= info->ntasks)
+		return NULL;
+
+	return info->tasks[worker];
+}
+
+static void *debugfs_pid_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	(*pos)++;
+	return debugfs_pid_start(m, pos);
+}
+
+/*
+ * Each line of the file contains one PID from the selected kernel threads.
+ */
+static int debugfs_pid_show(struct seq_file *m, void *v)
+{
+	seq_printf(m, "%d\n", ((struct task_struct *)v)->pid);
+	return 0;
+}
+
+static void debugfs_pid_stop(struct seq_file *m, void *v)
+{
+}
+
+static const struct seq_operations debugfs_pid_fops = {
+	.start	= debugfs_pid_start,
+	.next	= debugfs_pid_next,
+	.stop	= debugfs_pid_stop,
+	.show	= debugfs_pid_show
+};
+
+/*
+ * Generic seq_file creation function that sets private data of type
+ * debugfs_pid_info.
+ */
+static int debugfs_pid_open_info(struct inode *inode, struct file *file,
+		int ntasks, struct task_struct **tasks)
+{
+	struct debugfs_pid_info *info =
+		__seq_open_private(file, &debugfs_pid_fops, sizeof(*info));
+	if (!info)
+		return -ENOMEM;
+
+	info->ntasks = ntasks;
+	info->tasks = tasks;
+
+	return 0;
+}
+
+static int debugfs_pid_open_reader(struct inode *inode, struct file *file)
+{
+	return debugfs_pid_open_info(inode, file, nrealreaders, reader_tasks);
+}
+
+static int debugfs_pid_open_writer(struct inode *inode, struct file *file)
+{
+	return debugfs_pid_open_info(inode, file, nrealwriters, writer_tasks);
+}
+
+static int debugfs_pid_open_kfree(struct inode *inode, struct file *file)
+{
+	return debugfs_pid_open_info(inode, file, kfree_nrealthreads, kfree_reader_tasks);
+}
+
+static const struct file_operations readers_fops = {
+	.owner = THIS_MODULE,
+	.open = debugfs_pid_open_reader,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations writers_fops = {
+	.owner = THIS_MODULE,
+	.open = debugfs_pid_open_writer,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
+static const struct file_operations kfrees_fops = {
+	.owner = THIS_MODULE,
+	.open = debugfs_pid_open_kfree,
+	.read = seq_read,
+	.llseek = seq_lseek,
+	.release = seq_release,
+};
+
 /*
  * Create an rcuscale directory exposing run states and results.
  */
@@ -1032,6 +1141,18 @@ static int register_debugfs(void)
 			debugfs_dir, NULL, &writer_durations_fops))
 		goto fail;
 
+	if (try_create_file(debugfs_reader_tasks, "reader_tasks", 0444,
+			debugfs_dir, NULL, &readers_fops))
+		goto fail;
+
+	if (try_create_file(debugfs_writer_tasks, "writer_tasks", 0444,
+			debugfs_dir, NULL, &writers_fops))
+		goto fail;
+
+	if (try_create_file(debugfs_kfree_tasks, "kfree_tasks", 0444,
+			debugfs_dir, NULL, &kfrees_fops))
+		goto fail;
+
 	return 0;
 fail:
 	pr_err("rcu-scale: Failed to create debugfs file.");
@@ -1052,6 +1173,9 @@ do {						\
 } while (0)
 
 	try_remove(debugfs_writer_durations);
+	try_remove(debugfs_reader_tasks);
+	try_remove(debugfs_writer_tasks);
+	try_remove(debugfs_kfree_tasks);
 
 	/* Remove directory after files. */
 	try_remove(debugfs_dir);
-- 
2.50.1.552.g942d659e1b-goog


