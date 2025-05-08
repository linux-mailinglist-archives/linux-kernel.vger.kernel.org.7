Return-Path: <linux-kernel+bounces-640348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D55AB03A0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 21:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA7CA1BA73DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 19:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60DE28A1CB;
	Thu,  8 May 2025 19:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ei2lNr0+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC9F1C3F0C
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 19:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746732290; cv=none; b=IntoHvMvKcoyxNgQzr8Uxomb7wutI8jMflnuGE2TMvIDvdTwDZmjDd164PX3ZD9MjYpEGiplmRs5cPYf1Jt9tAYbxbFzNJimVMw3YO46MMm9FDFFkWHAxVxoB/oiAdl8IjCd7H3sEtU493ksh1/Z4XFxflK9/O/4UcfulHFfi44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746732290; c=relaxed/simple;
	bh=kkV+F1ByaoKZGM9d+pbw2Ilzb3owLbh+EnVo+YHDRK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+6n/4oQz6Yzie7hiyItgs/1lWA/yEQOc3klYXmCMbAo9PJ0Ke9rg7VoITm4sQiedn26cSq/iqwHnwX2qhIkG4vsh54ZCzVZ9RyWPzMpSIwamyAm18PaAZZG5bK/N7LEfPJGzjLncTR2EM+HnhUCyb0biU1OaOxnFQqKFRFfu9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ei2lNr0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746732284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7Jk9BcAtjAQU7ACRspfJrIgdim0aAe9DgFo93JV5TtM=;
	b=Ei2lNr0+sDYaXhgh6RKKu8md2uMBxK1rF+3VRIG+z0fBz1XKq2ADb0xrkbay7frJyb35hr
	Bh3FE2nFZTu3+EETo1oj1P2Tx5yeuuusd+Ok/dHb5Nx8XY6MUMvL3hhcg/a63xHO5gbXcl
	M0WvvaUSfBPpwPEyID2gvTQWCIXNiSs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-7h6oFesUMZyGiv2dv63_-A-1; Thu,
 08 May 2025 15:24:39 -0400
X-MC-Unique: 7h6oFesUMZyGiv2dv63_-A-1
X-Mimecast-MFC-AGG-ID: 7h6oFesUMZyGiv2dv63_-A_1746732268
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D0A21955DB9;
	Thu,  8 May 2025 19:24:28 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.80.141])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 23D901955F24;
	Thu,  8 May 2025 19:24:25 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
Cc: cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xi Wang <xii@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] cgroup/cpuset: Extend kthread_is_per_cpu() check to all PF_NO_SETAFFINITY tasks
Date: Thu,  8 May 2025 15:24:13 -0400
Message-ID: <20250508192413.615512-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Commit ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask()
on top_cpuset") enabled us to pull CPUs dedicated to child partitions
from tasks in top_cpuset by ignoring per cpu kthreads. However, there
can be other kthreads that are not per cpu but have PF_NO_SETAFFINITY
flag set to indicate that we shouldn't mess with their CPU affinity.
For other kthreads, their affinity will be changed to skip CPUs dedicated
to child partitions whether it is an isolating or a scheduling one.

As all the per cpu kthreads have PF_NO_SETAFFINITY set, the
PF_NO_SETAFFINITY tasks are essentially a superset of per cpu kthreads.
Fix this issue by dropping the kthread_is_per_cpu() check and checking
the PF_NO_SETAFFINITY flag instead.

Fixes: ec5fbdfb99d1 ("cgroup/cpuset: Enable update_tasks_cpumask() on top_cpuset")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index d0143b3dce47..967603300ee3 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1130,9 +1130,11 @@ void cpuset_update_tasks_cpumask(struct cpuset *cs, struct cpumask *new_cpus)
 
 		if (top_cs) {
 			/*
-			 * Percpu kthreads in top_cpuset are ignored
+			 * PF_NO_SETAFFINITY tasks are ignored.
+			 * All per cpu kthreads should have PF_NO_SETAFFINITY
+			 * flag set, see kthread_set_per_cpu().
 			 */
-			if (kthread_is_per_cpu(task))
+			if (task->flags & PF_NO_SETAFFINITY)
 				continue;
 			cpumask_andnot(new_cpus, possible_mask, subpartitions_cpus);
 		} else {
-- 
2.49.0


