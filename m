Return-Path: <linux-kernel+bounces-800091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611DCB4334C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:04:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 296A4165D36
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29723288522;
	Thu,  4 Sep 2025 07:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="l422uGLn"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC452877CF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756969461; cv=none; b=fnHxOELB7JWQqaRycEMPuQt0D7jQuMs/EhzQbB94rjiEc2F6mNeCG3ZxGVl6e4j+jBbnc4A+BSYdtOgV7WQOuRinOxy3SpU8zzjcBudCNIQk0HECq7Fx1nfntKm8ThccW2CIKTBHAfm8U2ecYQ30otd/AqeNoVSRSyf1HjytLdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756969461; c=relaxed/simple;
	bh=r1hX7Z+yhoBaMjfcMdMHqZZ9ywVADNhx4XJ4GCKQntY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skAAFi17qBnJvrEg6ClBKk3MZvLZBiQN4mumoFsPXuNj+LcT9OVOQLCLoLYdKadVpYLAYNCXW7oGJ+vqeTmK5S49hbHnjpLEM9cDRVrhQCoxTjtLFeiAdx3yuMNmJqM3PPea9MnzWc7KECtAcNMNniWNBortFw4e44PRy+K32Fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=l422uGLn; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b47052620a6so1350812a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 00:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756969458; x=1757574258; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XShcqAeI8UkKWl2bpcgPi0BFlmvYm+zIID/2XctmDfg=;
        b=l422uGLnDEtv0qhiAmAufDAqhOE9jOExH8dgcp82KK+YeM4vgrkZo2tI0dItgGayHC
         TFwphJR9s91Yre7Zs7V2vSPzy3kfhtkoWiFYoM9HkB89U1vHaxn6ZkAx3I7jB3x2HQXH
         2t6CMS9GCQw0G/+In0lQJbDxD5Js50K0sixK5rPxACFtEH7lszS3WzTGW4l41Q/gWh05
         7RBZ4lo0VjCv4YaT3qBUK3dPMiUgJh0joj7szsYP3V/6U2B0OuRfAafupX2uPW5QB9xa
         OfUM2b17KIxdRRcsbyoNsBqJGHZvnvR8dclRVGup0uuwf8458j1TqiEFC7VpP8fYaMNh
         Xi6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756969458; x=1757574258;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XShcqAeI8UkKWl2bpcgPi0BFlmvYm+zIID/2XctmDfg=;
        b=bWigqzst2ggN9kyML0j9SMlo/1mqpejcE+irgCTNd4t7xvLXWv+jyXSB8TNMdtMXxN
         g2PG5KUi7NAeEWKg4XktHYjVYokjoWsr9oQjSbONsSfZAUNYddoRKj2UK1za4WS7GOwZ
         ebvMFRVOwWWFSBaMGKyqYp2hj5llO8lQs3Qn+9KRa/UFf12v1YqwL0zTGbNXCC7hcO3X
         u1ThcAbXcir5U7Ai6WyH5MfnvGqgx9Yh8KHK7XEZpF4ROqEwl5d3pNuoRs/IAE8YAvc5
         DJA8Xj73StCyzQdzzzwRAQiAcBBpLVjEjl1YpYCxPJNMbI2Td9H5TZv7BDB8zIYqNroO
         m3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCV4VrSqoHY993tav8Oy/My9V1TYzQLboBz9h/ZTfuEb6pTeJvCX5BJjbV7fncLJreyw8BR58ekHVtJgjQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPQKZvh2YU58jJx4hLTJqayEBf6jGe43JaWB10Ws/uvud/4nON
	HLdyAj1LzvpU+Oc0C/WgcycOzCenF7JfRblW5/sqJvQG6kkDJE+i8OYMDpBgFoko0A==
X-Gm-Gg: ASbGncs2pL8Lkt4xdYdSHlZCgXjkKawch+JD6xP2fmow1dSn4S1ck+LAW5u80v0y05k
	1MnVBJBppAdbveolnyAYcSJsNuJVqT2fIR6gh2MLjDWV+h74vZoulbGyV8VAzk9LL7vLpgtsmf2
	1JgTFbs16g4W8Ep2UZU0X3qB/sqvTjKimp/ojcijY2o6MOZ+Hd8g4iKy+F5cLLhVdE4BaCaTEWs
	MP3ksShk2/p/YBHrIP4didO6GZ1VhXFHw0YgZxvrxgaphzFqIg2uC7au5vN7eICuspcFA8XPNtl
	bsuD07ppeywcXRbVQB/VjXmODqoEL8Yvi7Fvti9eYpzdFS/RBy51iJNjy4Hp3Uvs3EFm1PzHVd0
	vRlPO+ARpAVvyUB7NSkuzw22pFlTLzknICVBRS0LFjj2h4gUuqXIslznmhjNK
X-Google-Smtp-Source: AGHT+IFlEKlycn8KOjk3U96gCkrdFJeZYxhvgM1MF9G7HXAMCMILyu2eDuCNwDb/BecIunADp/tMAQ==
X-Received: by 2002:a17:902:d506:b0:24c:8263:cda8 with SMTP id d9443c01a7336-24c8263d033mr84843515ad.22.1756969458347;
        Thu, 04 Sep 2025 00:04:18 -0700 (PDT)
Received: from bytedance ([61.213.176.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccc79a345sm7566695ad.132.2025.09.04.00.04.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 00:04:17 -0700 (PDT)
Date: Thu, 4 Sep 2025 15:04:07 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Valentin Schneider <vschneid@redhat.com>,
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
Subject: Re: [PATCH v4 3/5] sched/fair: Switch to task based throttle model
Message-ID: <20250904070407.GD42@bytedance>
References: <20250829081120.806-1-ziqianlu@bytedance.com>
 <20250829081120.806-4-ziqianlu@bytedance.com>
 <20250903145124.GM4067720@noisy.programming.kicks-ass.net>
 <14be66aa-e088-4267-ac10-d04d600b1294@amd.com>
 <20250903202703.GP4067720@noisy.programming.kicks-ass.net>
 <ddd2f979-43d5-43e8-a95c-37a1654189e5@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ddd2f979-43d5-43e8-a95c-37a1654189e5@amd.com>

On Thu, Sep 04, 2025 at 11:14:31AM +0530, K Prateek Nayak wrote:
> On 9/4/2025 1:57 AM, Peter Zijlstra wrote:
> > So this is mostly tasks leaving/joining the class/cgroup. And its
> > purpose seems to be to remove/add the blocked load component.
> > 
> > Previously throttle/unthrottle would {de,en}queue the whole subtree from
> > PELT, see how {en,de}queue would also stop at throttle.
> > 
> > But now none of that is done; PELT is fully managed by the tasks
> > {de,en}queueing.
> > 
> > So I'm thinking that when a task joins fair (deboost from RT or
> > whatever), we add the blocking load and fully propagate it. If the task
> > is subject to throttling, that will then happen 'naturally' and it will
> > dequeue itself again.
> 
> That seems like the correct thing to do yes. Those throttled_cfs_rq()
> checks in propagate_entity_cfs_rq() can be removed then.
>

Not sure if I understand correctly, I've come to the below code
according to your discussion:

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e927b9b7eeb6..97ae561c60f5b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5234,6 +5234,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq);
 
 static void
 requeue_delayed_entity(struct sched_entity *se);
@@ -5729,6 +5730,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return cfs_bandwidth_used() && cfs_rq->throttled;
 }
 
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return cfs_bandwidth_used() && cfs_rq->pelt_clock_throttled;
+}
+
 /* check whether cfs_rq, or any parent, is throttled */
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
@@ -6721,6 +6727,11 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 	return 0;
 }
 
+static inline int cfs_rq_pelt_clock_throttled(struct cfs_rq *cfs_rq)
+{
+	return 0;
+}
+
 static inline int throttled_hierarchy(struct cfs_rq *cfs_rq)
 {
 	return 0;
@@ -13154,10 +13165,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
-	if (cfs_rq_throttled(cfs_rq))
-		return;
-
-	if (!throttled_hierarchy(cfs_rq))
+	if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 		list_add_leaf_cfs_rq(cfs_rq);
 
 	/* Start to propagate at parent */
@@ -13168,10 +13176,7 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 
 		update_load_avg(cfs_rq, se, UPDATE_TG);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
-
-		if (!throttled_hierarchy(cfs_rq))
+		if (!cfs_rq_pelt_clock_throttled(cfs_rq))
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 }

So this means when a task left/joined a cfs_rq, we will do propagate
immediately, no matter if the cfs_rq is throttled or has its pelt clock
stopped or not; if cfs_rq still has pelt clock running, it will be added
to leaf cfs_rq list to make sure its load can be decayed. If cfs_rq's
pelt clock is stopped, it will be added to leaf cfs_rq list if necessary
by enqueue_task_fair() or when it's unthrottled.

