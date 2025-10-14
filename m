Return-Path: <linux-kernel+bounces-852495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4ECBD91C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 806013A25A1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3D230E849;
	Tue, 14 Oct 2025 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KGB2VGsv"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE861F4CB7
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760442630; cv=none; b=JQPo4okF5EJAqJKfyhrjfO90Mm4/JOY7bwjVq63lDT8oitXXW/nPtrYMMfHWwosDlSD/0NaZBYm60J+vcdZo2d8rXzwWTczHmgwER6pzecEPg5yJUFI+wxzAzfNXiZH+7x9+ivtjf4QYgHv8wYfPHBg4iWpj9Acvc64NZH135tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760442630; c=relaxed/simple;
	bh=hBt9prpoEbL2WzBxsoCf0czCboztZChsLdEIojFkB2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJe0OnQQyqubmaTkfULrY3muO4o+iaoT1yzSN5cLIdZssBXsefXGQH+w/HYXNdIxkepWq+CLOmlVcdUuVRtNtTIUHjiaQbg1KOKHrXSOEFc21jFwPmBEQocDhRyebMvbFP3QfGz3ZPAR7nNoSkdxiNkhPFaVw5VrluJDVio8/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KGB2VGsv; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so5079035a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760442628; x=1761047428; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5ExaGaGV2f8qUZJ5YB2hX3KqWvN9sB0CRJy3XH+aBs=;
        b=KGB2VGsv/xF42aNZR25I0smyPCV3vEm4tXGuXMxMXwd3n/wIfbu1yXYNtDs66O4G3R
         gUpbBwthMjuQIuQMOY+ZTHtPAYT6bAJ/fyuDKEweqjPUUoMr7lNeN9NUubWtS+995TFq
         WH1ibPeqGRMdCqWgHterje7I3d/OloQLRfwDlUrFB+I5JWbTkM8W/kD4R0+gITF9FHgf
         GpW1kz9TLHykKBZT41rUxSQO84wDbc+pWiFxHX40QgDaGrIPugzmBQAIaqTlPips0GuI
         1hJOEhq4EWQEpctcmOIALbdu/GENKWPGXD355A1hRSoWzkRMZb6daAN2gJts7LCytbmb
         b62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760442628; x=1761047428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b5ExaGaGV2f8qUZJ5YB2hX3KqWvN9sB0CRJy3XH+aBs=;
        b=TVOxt5w+XWAir2XjURiPtO+OhiWy27LCYTMkVEAqDaMlBBXpgqjoQ3oD2+w9CiITTT
         RBZKbMWIlQBWKaKSnu5yHFKk0FVyQXOFKJqZh+FdV8aKWZswiil7gPHkJbAWlmTMglKL
         YM3s97DlNIe2X0h7jrxcqUWIQG9xKz5Fbhj7K//95bv/byPTvzWtgXcMP7m1Q+TeM7IH
         SWZ3ws7e+Dz/zVizctvfj1gm3MHVBYOOcX8AHJmQGtPhs+d8EAeE2TK+/1K+l2oRcORY
         rTnlsSw64v3Bf0dcQ0ECOIJkdOoMWH7rnUjY7a3hEh5qLuBzd/2VZzZHA2kgD9sq6j8t
         bHkw==
X-Forwarded-Encrypted: i=1; AJvYcCXnmw12kRdkQ/TQVptdoghpSSPImNsXbAzOaQ7hNXt6YrKxsWUmC+c7dyNuLr5fukEQWU3OF9eH+fGIuQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL1wfckSF2YBULOmPWYZKZQWQHRvOt5aNiOzaJ3I1L4XCKIzaT
	74Y5Py9H4UFhIGz558WgKNfC2TTdQV5X1fnXm2woc75a999cs5duLHkQ9kfswb1fnQ==
X-Gm-Gg: ASbGnctri3qL7WRhF7J6iufM2LtKq/lwNKqiTs+vUvN88CUQAlTA/+rfjK/pLmEIIg0
	aXLMuNA8UsWQwxK8ZTKL9nfQap0Lr/h58cSQ0y6Z/qYEoe11B+sjrEZ1QkG52SnBdfIn+k2CC+G
	MOhjHlSMtgE87AKXQSVEC0bDzeO34JQyfpGq7loSz19PtACyNqgIYDm6sYpGLs9vUKGoMeUTjzw
	iau5wbdZcyGzDmy3hTT2CenKNqq0wFai9mrhH7R6JbOq+pMktQ8wkJbR1iCEfWB6a8PpQZvDXkj
	l9u6fS/MLLEJcSmE4QHjWskF3QzaUoiTklxWYo8oWJ+MZJ/BEbKmUNbZ+mjH1/1o5yPiFmZ/NKX
	M0SgwH+FM+WAthyq7ma3TJ7PsuxcYkf1xPyWhjlgzMNFT1mUWTN9Xo7fdfqEohr6LFCRpy7xu9m
	XtRbU=
X-Google-Smtp-Source: AGHT+IEyQ2NptffNy/9uBS6TubSDHfMETBx2ZG2cNFJj+sY3MRy0hlkfLQCYSFWa8vq3KA/txgLogg==
X-Received: by 2002:a17:90b:3b90:b0:32e:3830:65e1 with SMTP id 98e67ed59e1d1-33b513be284mr34584164a91.33.1760442628273;
        Tue, 14 Oct 2025 04:50:28 -0700 (PDT)
Received: from bytedance ([61.213.176.55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626ec2f9sm15320643a91.25.2025.10.14.04.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:50:27 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:50:18 +0800
From: Aaron Lu <ziqianlu@bytedance.com>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: Valentin Schneider <vschneid@redhat.com>,
	Ben Segall <bsegall@google.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] sched/fair: Prevent cfs_rq from being unthrottled with
 zero runtime_remaining
Message-ID: <20251014115018.GC41@bytedance>
References: <20250929074645.416-1-ziqianlu@bytedance.com>
 <c4a1bcea-fb00-6f3f-6bf6-d876393190e4@gmail.com>
 <20251014090728.GA41@bytedance>
 <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84382429-02c1-12d5-bdf4-23e880246cf3@gmail.com>

On Tue, Oct 14, 2025 at 07:01:15PM +0800, Hao Jia wrote:
> 
> Hello Aaron,
> 
> Thank you for your reply.
> 
> On 2025/10/14 17:11, Aaron Lu wrote:
> > Hi Hao,
> > 
> > On Tue, Oct 14, 2025 at 03:43:10PM +0800, Hao Jia wrote:
> > > 
> > > Hello Aaron,
> > > 
> > > On 2025/9/29 15:46, Aaron Lu wrote:
> > > > When a cfs_rq is to be throttled, its limbo list should be empty and
> > > > that's why there is a warn in tg_throttle_down() for non empty
> > > > cfs_rq->throttled_limbo_list.
> > > > 
> > > > When running a test with the following hierarchy:
> > > > 
> > > >             root
> > > >           /      \
> > > >           A*     ...
> > > >        /  |  \   ...
> > > >           B
> > > >          /  \
> > > >         C*
> > > > 
> > > > where both A and C have quota settings, that warn on non empty limbo list
> > > > is triggered for a cfs_rq of C, let's call it cfs_rq_c(and ignore the cpu
> > > > part of the cfs_rq for the sake of simpler representation).
> > > > 
> > > 
> > > I encountered a similar warning a while ago and fixed it. I have a question
> > > I'd like to ask. tg_unthrottle_up(cfs_rq_C) calls enqueue_task_fair(p) to
> > > enqueue a task, which requires that the runtime_remaining of task p's entire
> > > task_group hierarchy be greater than 0.
> > > 
> > > In addition to the case you fixed above,
> > > When bandwidth is running normally, Is it possible that there's a corner
> > > case where cfs_A->runtime_remaining > 0, but cfs_B->runtime_remaining < 0
> > > could trigger a similar warning?
> > 
> > Do you mean B also has quota set and cfs_B's runtime_remaining < 0?
> > In this case, B should be throttled and C is a descendent of B so should
> > also be throttled, i.e. C can't be unthrottled when B is in throttled
> > state. Do I understand you correctly?
> > 
> Yes, both A and B have quota set.
> 
> Is there a possible corner case?
> Asynchronous unthrottling causes other running entities to completely
> consume cfs_B->runtime_remaining (cfs_B->runtime_remaining < 0) but not
> completely consume cfs_A->runtime_remaining (cfs_A->runtime_remaining > 0)
> when we call unthrottle_cfs_rq(cfs_rq_A) .

Let me try to understand the situation here: in your described setup,
all three task groups(A, B, C) have quota set?

> 
> When we unthrottle_cfs_rq(cfs_rq_A), cfs_A->runtime_remaining > 0, but if
> cfs_B->runtime_remaining < 0 at this time,

Hmm... if cfs_B->runtime_remaining < 0, why it's not throttled?

> therefore, when enqueue_task_fair(p)->check_enqueue_throttle(cfs_rq_B)->throttle_cfs_rq(cfs_rq_B),

I assume p is a task of group B?
So when A is unthrottled, since p is a throttled task of group B and B
is still throttled, enqueue_task_fair(p) should not happen.

> an warnning may be triggered.
> 
> My core question is:
> When we call unthrottle_cfs_rq(cfs_rq_A), we only check
> cfs_rq_A->runtime_remaining. However,
> enqueue_task_fair(p)->enqueue_entity(C->B->A)->check_enqueue_throttle() does

According to this info, I assume p is a task of group C here. If
unthrottle A would cause enqueuing p, that means: either group C and B
do not have quota set or group C and B are in unthrottled state. 

> require that the runtime_remaining of each task_group level of task p is
> greater than 0.

If group C and B are in unthrottled state, their runtime_remaining
should be > 0.

> 
> Can we guarantee this?

To guarantee this, a warn like below could be used. Can you try in your
setup if you can hit it? Thanks.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3ef11783369d7..c347aa28c411a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5908,6 +5908,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_self_time += delta;
 	}
 
+	WARN_ON_ONCE(cfs_rq->runtime_enabled && cfs_rq->runtime_remaining <= 0);
+
 	/* Re-enqueue the tasks that have been throttled at this level. */
 	list_for_each_entry_safe(p, tmp, &cfs_rq->throttled_limbo_list, throttle_node) {
 		list_del_init(&p->throttle_node);

