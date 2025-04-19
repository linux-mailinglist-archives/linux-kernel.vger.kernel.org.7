Return-Path: <linux-kernel+bounces-611696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A67A9450A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 20:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FFFE17648A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 18:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D401DEFFC;
	Sat, 19 Apr 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="stT8Fsw3"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074821F5F6
	for <linux-kernel@vger.kernel.org>; Sat, 19 Apr 2025 18:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745087787; cv=none; b=IVLvBAg6zhb9M5Uu1Ybx1mTPXG2DpGU8wkqS8L/sd9omyJJEH3g9JL0dDaPB/+RKbu2KsphhAHLtATK1pO34qRsTjntVSqS6M/WL+DNrcRE8I9B4lAVXYA0k2SKJQxXPpbuvEM3BqiZFCGXpKNN20tIfvo0Nd/chKznhQLe5sVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745087787; c=relaxed/simple;
	bh=bZkc/I7fe2xcKgWX+n5gpzXuMyOzLo3TRy+jHaAGpYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZDOhAdoGGqO93YfEpGM2WR5H/vxKaP6uq+6MtECGJsYnuu/QTm6uTO83/C7WjCnhQ6X9aXeeGWVfZ+slZyPhkuQfxEAs9oeIzS3pehs1p1954Jt9cInXqT/KY3YPdCR5goIj1OqF1dm17GF/O8/quNFjtRO+AvY4IHESBo09P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=stT8Fsw3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745087781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Ya7lL/93PZYOwN+LH6VIpy/eVtlPQUR8w4DByMzkNPg=;
	b=stT8Fsw3OeLFsuvpIKoKrdDGNAmI/jiPzv3L2tRdrqxlCqUNJ5sh3W3ttGBF7VsIj2PAgw
	QKXjn/X0AZfmFpnhmnVDgihx+fI79TjPeOVmQ+RqC8nLcpvHj8KRhi5RGbqd7RvS/mf6va
	DnLs4mYHEy5Zkeh0cah3wGZJKQWfx0M=
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Tejun Heo <tj@kernel.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Greg Thelen <gthelen@google.com>,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Meta kernel team <kernel-team@meta.com>
Subject: [PATCH v2] memcg: introduce non-blocking limit setting option
Date: Sat, 19 Apr 2025 11:35:45 -0700
Message-ID: <20250419183545.1982187-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Setting the max and high limits can trigger synchronous reclaim and/or
oom-kill if the usage is higher than the given limit. This behavior is
fine for newly created cgroups but it can cause issues for the node
controller while setting limits for existing cgroups.

In our production multi-tenant and overcommitted environment, we are
seeing priority inversion when the node controller dynamically adjusts
the limits of running jobs of different priorities. Based on the system
situation, the node controller may reduce the limits of lower priority
jobs and increase the limits of higher priority jobs. However we are
seeing node controller getting stuck for long period of time while
reclaiming from lower priority jobs while setting their limits and also
spends a lot of its own CPU.

One of the workaround we are trying is to fork a new process which sets
the limit of the lower priority job along with setting an alarm to get
itself killed if it get stuck in the reclaim for lower priority job.
However we are finding it very unreliable and costly. Either we need a
good enough time buffer for the alarm to be delivered after setting
limit and potentialy spend a lot of CPU in the reclaim or be unreliable
in setting the limit for much shorter but cheaper (less reclaim) alarms.

Let's introduce new limit setting option which does not trigger
reclaim and/or oom-kill and let the processes in the target cgroup to
trigger reclaim and/or throttling and/or oom-kill in their next charge
request. This will make the node controller on multi-tenant
overcommitted environment much more reliable.

Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
Changes since v1:
- Instead of new interfaces use O_NONBLOCK flag (Greg, Roman & Tejun)

 Documentation/admin-guide/cgroup-v2.rst | 14 ++++++++++++++
 mm/memcontrol.c                         | 10 ++++++++--
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 8fb14ffab7d1..c14514da4d9a 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -1299,6 +1299,13 @@ PAGE_SIZE multiple when read back.
 	monitors the limited cgroup to alleviate heavy reclaim
 	pressure.
 
+        If memory.high is opened with O_NONBLOCK then the synchronous
+        reclaim is bypassed. This is useful for admin processes that
+        need to dynamically adjust the job's memory limits without
+        expending their own CPU resources on memory reclamation. The
+        job will trigger the reclaim and/or get throttled on its
+        next charge request.
+
   memory.max
 	A read-write single value file which exists on non-root
 	cgroups.  The default is "max".
@@ -1316,6 +1323,13 @@ PAGE_SIZE multiple when read back.
 	Caller could retry them differently, return into userspace
 	as -ENOMEM or silently ignore in cases like disk readahead.
 
+        If memory.max is opened with O_NONBLOCK, then the synchronous
+        reclaim and oom-kill are bypassed. This is useful for admin
+        processes that need to dynamically adjust the job's memory limits
+        without expending their own CPU resources on memory reclamation.
+        The job will trigger the reclaim and/or oom-kill on its next
+        charge request.
+
   memory.reclaim
 	A write-only nested-keyed file which exists for all cgroups.
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 5e2ea8b8a898..6f7362a7756a 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -4252,6 +4252,9 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 
 	page_counter_set_high(&memcg->memory, high);
 
+	if (of->file->f_flags & O_NONBLOCK)
+		goto out;
+
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 		unsigned long reclaimed;
@@ -4274,7 +4277,7 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
 		if (!reclaimed && !nr_retries--)
 			break;
 	}
-
+out:
 	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
@@ -4301,6 +4304,9 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 
 	xchg(&memcg->memory.max, max);
 
+	if (of->file->f_flags & O_NONBLOCK)
+		goto out;
+
 	for (;;) {
 		unsigned long nr_pages = page_counter_read(&memcg->memory);
 
@@ -4328,7 +4334,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
 			break;
 		cond_resched();
 	}
-
+out:
 	memcg_wb_domain_size_changed(memcg);
 	return nbytes;
 }
-- 
2.47.1


