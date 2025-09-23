Return-Path: <linux-kernel+bounces-829466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 333EDB97228
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5933E19C5E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C090B2E0902;
	Tue, 23 Sep 2025 17:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OaimkZI8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8442DFA2A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 17:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650117; cv=none; b=H5TCOUYNORs/qgC5TYGrt5nv/CAx9hCmyVa2E+3Zl4n3i6amhV/gMNPOZNfWDrsuUtiUPJOuYyv8Pu5n+4Bn2p6PloZnAQoFPmLfWc9tEjueEP2EPmuMo0AwxVefnBaqR4l+TU5gswv5kmSXXVQ0/5oCc22Ia1BMy+XFdDFI7kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650117; c=relaxed/simple;
	bh=Z2C+Zr9rO4Hy0wmre+SBKLxQGtpKfYh9uDkWGglQ+E0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sk7ZU532wL3vfF3C7xVXa2WDIhv4EN08q8xRmxfBHk2lOdHGogsD+1ZbbpqRrwudOy/GmOo1D4DFVXzKCGXdU+wmHYUdXIFnuw9lgA/GTq9yFlYuGbNJaSLSbLh/xgRuDNNLrOEZrjwzk1FH0foHZuDOYFKXgfK+SMUGuflb2Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OaimkZI8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758650114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ctyVGN3kd42WN2TVq7DlGowdyVegERHybspGJtbOnv8=;
	b=OaimkZI8q8vaD8okVQe5756TkmzuCrKbJJinxP6fVpffKvv5hhGKiAUwM2fOcUhUGKUact
	47b1gxPmgmFJrASns7IugvvGt0fTUMq6D1/iD4HF0fWYZmHt6Cnn8C1i3a+RJMhk/cpn2o
	iqZ5avjOHdP6N4gPb40f8F6sUnz3quk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-imjkDBftNHmoayfGJ6Yakw-1; Tue,
 23 Sep 2025 13:55:11 -0400
X-MC-Unique: imjkDBftNHmoayfGJ6Yakw-1
X-Mimecast-MFC-AGG-ID: imjkDBftNHmoayfGJ6Yakw_1758650110
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46F921800578;
	Tue, 23 Sep 2025 17:55:09 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.81.189])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AEEE53000198;
	Tue, 23 Sep 2025 17:55:04 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Nico Pache <npache@redhat.com>,
	Phil Auld <pauld@redhat.com>,
	John Coleman <jocolema@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH 2/2] fs/proc: Show the content of task->user_cpus_ptr in /proc/<pid>/status
Date: Tue, 23 Sep 2025 13:54:47 -0400
Message-ID: <20250923175447.116782-2-longman@redhat.com>
In-Reply-To: <20250923175447.116782-1-longman@redhat.com>
References: <20250923175447.116782-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The task->user_cpus_ptr was introduced by commit b90ca8badbd1 ("sched:
Introduce task_struct::user_cpus_ptr to track requested affinity") to
keep track of user-requested CPU affinity. With commit da019032819a
("sched: Enforce user requested affinity"), user_cpus_ptr will
persistently affect how cpus_allowed will be set. So it makes sense to
enable users to see the presence of a previously set user_cpus_ptr so
they can do something about it without getting a surprise.

Add new "Cpus_user" and "Cpus_user_list" fields to /proc/<pid>/status
output via task_cpus_allowed() as the presence of user_cpus_ptr will
affect the cpus_allowed cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 Documentation/filesystems/proc.rst | 2 ++
 fs/proc/array.c                    | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 2971551b7235..fb9e7753010c 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -311,6 +311,8 @@ It's slow but very precise.
  SpeculationIndirectBranch   indirect branch speculation mode
  Cpus_allowed                mask of CPUs on which this process may run
  Cpus_allowed_list           Same as previous, but in "list format"
+ Cpus_user                   mask of user requested CPUs from sched_setaffinity(2)
+ Cpus_user_list              Same as previous, but in "list format"
  Mems_allowed                mask of memory nodes allowed to this process
  Mems_allowed_list           Same as previous, but in "list format"
  voluntary_ctxt_switches     number of voluntary context switches
diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa93..30ceab935e13 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -405,10 +405,19 @@ static inline void task_context_switch_counts(struct seq_file *m,
 
 static void task_cpus_allowed(struct seq_file *m, struct task_struct *task)
 {
+	cpumask_t *user_cpus = task->user_cpus_ptr;
+
 	seq_printf(m, "Cpus_allowed:\t%*pb\n",
 		   cpumask_pr_args(&task->cpus_mask));
 	seq_printf(m, "Cpus_allowed_list:\t%*pbl\n",
 		   cpumask_pr_args(&task->cpus_mask));
+
+	if (user_cpus) {
+		seq_printf(m, "Cpus_user:\t%*pb\n", cpumask_pr_args(user_cpus));
+		seq_printf(m, "Cpus_user_list:\t%*pbl\n", cpumask_pr_args(user_cpus));
+	} else {
+		seq_puts(m, "Cpus_user:\nCpus_user_list:\n");
+	}
 }
 
 static inline void task_core_dumping(struct seq_file *m, struct task_struct *task)
-- 
2.51.0


