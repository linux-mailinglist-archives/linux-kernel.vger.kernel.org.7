Return-Path: <linux-kernel+bounces-805618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E99DEB48B1A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3DE51883398
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9E52F7468;
	Mon,  8 Sep 2025 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="knbz9wFO"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34AB1EEF9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 11:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329570; cv=none; b=hsJfKMH/u6okT8/+UtE0Czf8JdA1kXPcFtbiyUhu7xZMPMSS1XF70jTQfv1APJeNdjrJrwqi1pUc99K2xgqhhrULkcG0dvVPM51dEuJRZC7DP9qTJ5M4JctYljd96Uk9XUtVaqIxit9k9ytk7yYnILm+95KIEzO+BG2NsPyv2Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329570; c=relaxed/simple;
	bh=DwHlZZS8THjJnnybA1ROod50V8TCwnGaZA2re1zrxkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8miT1xtYjLo986To3ZfBeyEHNWVgy+lXI/PZlorVMBQH+6KXdMhlblhx1tBde+Mz/hpLCbCH80FOT6jMjByuWK6vGTFf2FGD00adWid0XQr6KqlXnOvQRd86KaNMK4NSxiZOQuo/LeecQVxb516E3dH8L5FKgt0GhdRFdaNiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=knbz9wFO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-772488c78bcso4175026b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 04:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757329567; x=1757934367; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a5z7oRLV+rv9lhtVY8xGAI75n4kGxuWW9OkodWGuSCQ=;
        b=knbz9wFOH/vF2UF+96G2BF36qAJttGROrRYgSQdRYDNei0AS5YjOsiPigdDr92XhiL
         jYg7RfXAZOnf/9PWdwhBo3uOQddLazijOxy9t3/c/xM2CI4f5YggCxoan6WpG0ELNoSw
         MNF/Vdj3ujTUxn8aj/YYBFIWZXqsQIxkRCf7lr8ngsU7tDUb0jYRlGy615D5golnH2/o
         WXOmHjSP2cyaFKMEHNhX++jFk2RCNvARPkYqy6n/luwwrWY+IGMtK4gIgLxas+OpvcUS
         UR2MNgCuPRiRRJY/HBqWydNWGxYYSWGoEeZu7Llx8jiWbNZOSqoeUSwSh8QkVtfS1mqw
         cPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757329567; x=1757934367;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5z7oRLV+rv9lhtVY8xGAI75n4kGxuWW9OkodWGuSCQ=;
        b=Twocw+R+6LJWzqsNwpiivvQehDhuvCFF+hylVhRVkFyhNoJPWSHivDZfMzg9RDfYPD
         SFiQp1tl+ixi1jVje3Z+/HaRY7fb6Sg3t0HgJWe4JYUEDq7hoU2qf+DG/x8TSZ7SQW08
         DW1jjnNov9Jzty98ceilIJfabi0gNkzxQgSFTKzyBymhzrdwyfvpiolLW9iCkXQq3dMH
         Auo3QsDA5wfki5WyCpLqLtHAYCMrYQk392uh992McX2Wa7SQQbn5S621zRccyyBPz4zB
         XtlG+d5MzwC4sQDvjwFEq5rIOhHyWcSSb4xxLaX4Ea9m900uP/XLBvm6Dixm30s8wceP
         Kmxw==
X-Forwarded-Encrypted: i=1; AJvYcCVYhh2A07K0ftgmFqkkQy60r8YDVxm+/5acVr31UGrZCjhaibcbb5X2HZW4eZWrWn8QAFlOBUiTsFXQG+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTBVNAkPWKFPovvUjqfnYqYcQN5aTLP0FEDJe2ua8rmk+Hu2A7
	pJYXly/ke7Y3qnw+1xRqL7iAJP3O2WMJJbrBkzsB6cXTas6cSmaQ0GZC26BqyQinJw==
X-Gm-Gg: ASbGncugJ3rWxK4piNuIGGyKPZUv+JVjYYANch7kQs1fDEU6AyOarG5MVCqN5cuSUjf
	BD2SoWyjBZ5QXWHU3oB0XHNnruNmWblP7Atlbk1rSiMX6vHn9nX4FJPsepZAvKDOdXCm35C+Vno
	0qZ0/c1JlMAawYKGzD65+zRcKg3AFRadVR3Wvp1OMVC5FmAdVfn+DXnrsdDa/At/LJdeyZCmogU
	fDpR0MdAi+RE42Hkzxvjkw1XDZXMetpVihBou97Y284wyYyVeI0gHAwRrK5pZovmw7FZUVMVgvE
	F0XsgXh2lmLhdLoM6tsTKc49ELD1ujB1JZXTj4IUCk4BEdmNt7VZecZNvgVg/0WqQK5b5umK7gT
	lVT37gi3doEqvV3MJDLq/SgS4oz1W+wYdN0zciQ8R8sUoUI/jUw==
X-Google-Smtp-Source: AGHT+IEWqaUVtQyA9/I+ImWAeXqHEsrbOo/XARMC/s6iOa1zVXp4KLi0zKP78GF8iumAP1Xa5BjgGA==
X-Received: by 2002:a05:6a20:430b:b0:24e:84c9:e990 with SMTP id adf61e73a8af0-2533f8c4d01mr11106498637.15.1757329567031;
        Mon, 08 Sep 2025 04:06:07 -0700 (PDT)
Received: from bytedance ([61.213.176.57])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4edf7ed519sm22606759a12.28.2025.09.08.04.05.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 04:06:06 -0700 (PDT)
Date: Mon, 8 Sep 2025 19:05:48 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Xi Wang <xii@google.com>, linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>,
	Chuyi Zhou <zhouchuyi@bytedance.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	Songtang Liu <liusongtang@bytedance.com>,
	Chen Yu <yu.c.chen@intel.com>,
	Matteo Martelli <matteo.martelli@codethink.co.uk>,
	Michal Koutn?? <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] sched/fair: Propagate load for throttled cfs_rq
Message-ID: <20250908110548.GA35@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <20250903202703.GP4067720@noisy.programming.kicks-ass.net>
 <ddd2f979-43d5-43e8-a95c-37a1654189e5@amd.com>
 <20250904070407.GD42@bytedance>
 <20250905113719.GL42@bytedance>
 <20250905125328.GU3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250905125328.GU3245006@noisy.programming.kicks-ass.net>

On Fri, Sep 05, 2025 at 02:53:28PM +0200, Peter Zijlstra wrote:
> On Fri, Sep 05, 2025 at 07:37:19PM +0800, Aaron Lu wrote:
> > Hi Peter,
> > 
> > On Thu, Sep 04, 2025 at 03:04:07PM +0800, Aaron Lu wrote:
> > > On Thu, Sep 04, 2025 at 11:14:31AM +0530, K Prateek Nayak wrote:
> > > > On 9/4/2025 1:57 AM, Peter Zijlstra wrote:
> > > > > So this is mostly tasks leaving/joining the class/cgroup. And its
> > > > > purpose seems to be to remove/add the blocked load component.
> > > > > 
> > > > > Previously throttle/unthrottle would {de,en}queue the whole subtree from
> > > > > PELT, see how {en,de}queue would also stop at throttle.
> > > > > 
> > > > > But now none of that is done; PELT is fully managed by the tasks
> > > > > {de,en}queueing.
> > > > > 
> > > > > So I'm thinking that when a task joins fair (deboost from RT or
> > > > > whatever), we add the blocking load and fully propagate it. If the task
> > > > > is subject to throttling, that will then happen 'naturally' and it will
> > > > > dequeue itself again.
> > > > 
> > > > That seems like the correct thing to do yes. Those throttled_cfs_rq()
> > > > checks in propagate_entity_cfs_rq() can be removed then.
> > > >
> > > 
> > > Not sure if I understand correctly, I've come to the below code
> > > according to your discussion:
> > >
> > 
> > Does the below diff look sane to you? If so, shall I send a separate
> > patch on top or fold it in patch3 and send an updated patch3?
> 
> Yeah, I suppose that works. Please send a follow up patch. It would also
> be good to have a comment that explains why we need that list_add_leaf
> thing. I think I see, but I'm sure I'll have forgotten all next time I
> see this code.

Here it is.

From d88c2d2be31bb3970708f9b78e1725b0e25824be Mon Sep 17 00:00:00 2001
From: Aaron Lu <ziqianlu@bytedance.com>
Date: Fri, 5 Sep 2025 14:21:50 +0800
Subject: [PATCH] sched/fair: Propagate load for throttled cfs_rq

Before task based throttle model, propagating load will stop at a
throttled cfs_rq and that propagate will happen on unthrottle time by
update_load_avg().

Now that there is no update_load_avg() on unthrottle for throttled
cfs_rq and all load tracking is done by task related operations, let the
propagate happen immediately.

While at it, add a comment to explain why cfs_rqs that are not affected
by throttle have to be added to leaf cfs_rq list in
propagate_entity_cfs_rq() per my understanding of commit 0258bdfaff5b
("sched/fair: Fix unfairness caused by missing load decay").

Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
---
 kernel/sched/fair.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index df8dc389af8e1..03f16f70bff8a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5729,6 +5729,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttled;
 }
 
+static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
+}
+
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
@@ -6721,6 +6726,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return 0;
 }
 
++static inline bool cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return false;
+}
+
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
 	return 0;
@@ -13151,10 +13161,13 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
-	if (!throttled_hierarchy(cfs_rq))
+	/*
+	 * If a task gets attached to this cfs_rq and before being queued,
+	 * it gets migrated to another CPU due to reasons like cpuset change,
+	 * we need to make sure this cfs_rq stays on leaf cfs_rq list to
+	 * have that removed load decayed or it can cause faireness problem.
+	 */
+	if(!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
@@ -13165,10 +13178,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
-		if (!throttled_hierarchy(cfs_rq))
+		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }
-- 
2.39.5


