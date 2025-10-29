Return-Path: <linux-kernel+bounces-877240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D590C1D88A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E50813BA3FB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD2F2FFDC1;
	Wed, 29 Oct 2025 21:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pmxwawsr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FD3148AC
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761774989; cv=none; b=a5K1cuRlax/Qr7++GdXkEWjnxdZ/VO937jryaugH5oqek5I8XXlSPCM3TtqEggtJR9RoBusnXiFgqGYlRuT16CB6ic4b26OWlojFCT2MxuwtH+6pWthXI63fx7lxFR5xjLzUSZ58KOfimtwT+YlKSM64A4WVAjcyAqjmPs5qU6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761774989; c=relaxed/simple;
	bh=OOv8D4S4daNqwl3E/EMT55ZkCdNav8iq00JBI+SPh9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9iAJdXjoXPZp5goB5h5dzugMCt3bIZ/Vvvgvgl07NrIiZlKrnUoHx14no6NhYcoDdf0cPJLJd/JyvGW4D2ZU9KfCjIZs3drsHj/eK3N6K/jTHfXlCz9o5e8lKDqYV9PK34jlLW5HXUR9YKaIdt7fcc/VMcqU1aKVTtib6e/QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pmxwawsr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761774987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ip150q/jg/OC8vs7auZBSRpRPZ/5ZbR1ifScO9CYqkQ=;
	b=PmxwawsrzwpYcbP20PvXfostkOYJcMrxXLTM+kDZx2nqwU4I3XZfFhrrqDhsvYauDgghE0
	RtgLeFFZ+UYADfJ94K9XHL7EuNh7azz2UCKfQ7GKn3YQ+JI/NyShxvwNsGgQRIceFvxxsF
	tfoGJYzOZmfbVH9Z8T4FmYo/s9qDbQw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-CV4d3-VlOnW_JJ8BEG1I6w-1; Wed,
 29 Oct 2025 17:56:23 -0400
X-MC-Unique: CV4d3-VlOnW_JJ8BEG1I6w-1
X-Mimecast-MFC-AGG-ID: CV4d3-VlOnW_JJ8BEG1I6w_1761774982
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D6BF18001E4;
	Wed, 29 Oct 2025 21:56:21 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.westford.csb (unknown [10.22.64.105])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ED22319560B4;
	Wed, 29 Oct 2025 21:56:16 +0000 (UTC)
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
Subject: [PATCH v2 1/2] sched/core: Enable full cpumask to clear user cpumask in sched_setaffinity()
Date: Wed, 29 Oct 2025 17:55:54 -0400
Message-ID: <20251029215555.1006595-2-longman@redhat.com>
In-Reply-To: <20251029215555.1006595-1-longman@redhat.com>
References: <20251029215555.1006595-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Since commit 8f9ea86fdf99 ("sched: Always preserve the user requested
cpumask"), user provided CPU affinity via sched_setaffinity(2) is
perserved even if the task is being moved to a different cpuset.
However, that affinity is also being inherited by any subsequently
created child processes which may not want or be aware of that affinity.

One way to solve this problem is to provide a way to back off from
that user provided CPU affinity.  This patch implements such a scheme
by using a full cpumask (a cpumask with all bits set) to signal the
clearing of the user cpumask to follow the default as allowed by
the current cpuset.  In fact, with a full cpumask in user_cpus_ptr,
the task behavior should be the same as with a NULL user_cpus_ptr.
This patch just formalizes it without causing any incompatibility and
discard an otherwise useless cpumask.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/sched/syscalls.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 77ae87f36e84..d68c7a4ee525 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -1229,14 +1229,22 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 		return retval;
 
 	/*
-	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
-	 * alloc_user_cpus_ptr() returns NULL.
+	 * If a full cpumask is passed in, clear user_cpus_ptr and reset the
+	 * current cpu affinity to the default for the current cpuset.
 	 */
-	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
-	if (user_mask) {
-		cpumask_copy(user_mask, in_mask);
+	if (cpumask_full(in_mask)) {
+		user_mask = NULL;
 	} else {
-		return -ENOMEM;
+		/*
+		 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
+		 * alloc_user_cpus_ptr() returns NULL.
+		 */
+		user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
+		if (user_mask) {
+			cpumask_copy(user_mask, in_mask);
+		} else {
+			return -ENOMEM;
+		}
 	}
 
 	ac = (struct affinity_context){
-- 
2.51.0


