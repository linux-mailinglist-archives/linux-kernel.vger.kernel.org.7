Return-Path: <linux-kernel+bounces-773906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C08B5B2AC1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 17:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 731A36837F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE0423C50F;
	Mon, 18 Aug 2025 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoRwPuDy"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA03423505E
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755529193; cv=none; b=f/AsdieEM6CrlJ2c2UC4pD0rDC347J1wlx0rf6l2PHvByuBrIr3V6iyQ161e3+RvBUI6GmnZnN1xCMFADjVmalTVbDgOjqGf0D0Qr6njuBP6wK8vnzS2RrZTueLsvTO0sz8B5hByoRxKy3irBR0lSFzHcci1tzgDh9bn3J1QACM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755529193; c=relaxed/simple;
	bh=kVDROe6uYjEgvnz+/DxRt1VD+3L5DqQc1xSLH8imjl4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9g5wrv/ZQoCCKFIr/w0mXPtQEspGy7kuAgVdh1nk+eha9A48X3rZa2N7imsHrbDlrJIrDhmMwAPcIoxCes0nh70SEET3Mn6FvVP07nlpNqTJdT+x55vRpTO/kjLuJw4Hp+aDSmCDHjWwVb0bzYxEThn50OlpUU9H6cMMmakUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoRwPuDy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755529190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IuCJIjC2Pw8zSNTBqGTV5c9Ih8GQtQh9o4q0qnDOCCo=;
	b=NoRwPuDyw8hm/6UOC8OEYIm0f84hKSy5wQ0SuB44fPuHRWUnF4E60mTcCd/jY56VOLC+dz
	QnT8+JxU5ngJrnenKyK0IzM5rZntnhQuSYdCOAqfT1n+IwDnJSGxq65+A7cZVMu5r/Tq0I
	I7AQEYY3NmvieAFJarMGlKveZ8aIQsA=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-0a8jGEuVPKiQ8URJHi4jvQ-1; Mon, 18 Aug 2025 10:59:49 -0400
X-MC-Unique: 0a8jGEuVPKiQ8URJHi4jvQ-1
X-Mimecast-MFC-AGG-ID: 0a8jGEuVPKiQ8URJHi4jvQ_1755529188
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e9347de126bso2483423276.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:59:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755529188; x=1756133988;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuCJIjC2Pw8zSNTBqGTV5c9Ih8GQtQh9o4q0qnDOCCo=;
        b=BJVC5zwwO8hxEs1jUY4SO96/ml/oxClf9zkBakMOARMvYGsVguLh/mYG+hYQFMp7gd
         oqzJ4ekITPIsh9CrJ3gTt/JTPAAv9YMXxr2P4Uod91rEdbXcTsi3HJ97bbHoX3ReVEt2
         m1y6VP7weU2zof8BK+ybohA7iPhuFiXezeNLhTpp1B9fZfqo8C3zHhOGUvfeIVZWohUC
         /3GjaVV9APcA3dJ3DTLNhIFLXQwVWBX6+D9G7/Q/389oXyVqLR7Fg5Rsh/ojAb/GKmpv
         yaChkeORj8Pc65MacFQ+KSiIHANstpLczaB//mWVOM/qwP+gI9mhwMcLbdofdG4QFdQ3
         WTmQ==
X-Gm-Message-State: AOJu0YwPj3Jso/AuUJiHByVvpVO/00Y41UudyEWMzPlRqnr4ovuU4gVx
	vngjeGWlgk19x/l3mUNx5fesiRdI6BhG1nSM4l88mSP3FtaamCh3r8wca11YjkQA3iw49kYYQeI
	ypyx8Y5WGWwvlj+wNqRcpN/sdvEYx6yYSAX6QPb3UjWiolWfu8EeWoYWi5rUhP2QkIg==
X-Gm-Gg: ASbGncto/9doVnhFKII1oTOY1sSox4+ZGmKEHkIJNQEUTkdhTD1IV70GWlaDnFF7x1C
	xg932+8mzfADgA7Yz4Xp0Al1LVeetuwPBNVt4sCAZA6r1XSZzrh8KYVkmREWFQPsGIc16mQXh2G
	c0OE24nTXdCHN6sgI6QBN/tTPthNQNMLtWSMm5uNiH9TA9MC8TtO5QvjvpuFpzO4166qvZbJsvk
	KhljIo4+LBwawPfpD1oBxEQCOTBpNdP7Ao/JO/lWqeq6nOyZHGAlVE80LDI9ybTVqxwPX4yxu5x
	sxdrU1K67iYjWfv9c8jt4/uRbprS1rl/KvJStwV+eUUz3FBEzVJM/woYqv0OL7nbPEga5r29xWx
	Z1CYC3tcTw2be7ZPCeipPZLPy
X-Received: by 2002:a05:6902:124d:b0:e93:47cc:f445 with SMTP id 3f1490d57ef6-e9347ccf580mr7891701276.22.1755529188416;
        Mon, 18 Aug 2025 07:59:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEloaoTeEWwHt/vHj6I5D929/RLDzYFPGVxgYCT14h0pzj4iL/cbBKhtBx2jd26dImjxUqxNg==
X-Received: by 2002:a05:6902:124d:b0:e93:47cc:f445 with SMTP id 3f1490d57ef6-e9347ccf580mr7891663276.22.1755529188034;
        Mon, 18 Aug 2025 07:59:48 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e933264aabcsm3210684276.9.2025.08.18.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 07:59:47 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Aaron Lu <ziqianlu@bytedance.com>, Ben Segall <bsegall@google.com>, K
 Prateek Nayak <kprateek.nayak@amd.com>, Peter Zijlstra
 <peterz@infradead.org>, Chengming Zhou <chengming.zhou@linux.dev>, Josh
 Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Xi Wang <xii@google.com>
Cc: linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
 <rostedt@goodmis.org>, Mel Gorman <mgorman@suse.de>, Chuyi Zhou
 <zhouchuyi@bytedance.com>, Jan Kiszka <jan.kiszka@siemens.com>, Florian
 Bezdeka <florian.bezdeka@siemens.com>, Songtang Liu
 <liusongtang@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v3 4/5] sched/fair: Task based throttle time accounting
In-Reply-To: <20250715071658.267-5-ziqianlu@bytedance.com>
References: <20250715071658.267-1-ziqianlu@bytedance.com>
 <20250715071658.267-5-ziqianlu@bytedance.com>
Date: Mon, 18 Aug 2025 16:57:27 +0200
Message-ID: <xhsmhbjociso8.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 15/07/25 15:16, Aaron Lu wrote:
> @@ -5287,19 +5287,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
>               check_enqueue_throttle(cfs_rq);
>               list_add_leaf_cfs_rq(cfs_rq);
>  #ifdef CONFIG_CFS_BANDWIDTH
> -		if (throttled_hierarchy(cfs_rq)) {
> +		if (cfs_rq->pelt_clock_throttled) {
>                       struct rq *rq = rq_of(cfs_rq);
>
> -			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
> -				cfs_rq->throttled_clock = rq_clock(rq);
> -			if (!cfs_rq->throttled_clock_self)
> -				cfs_rq->throttled_clock_self = rq_clock(rq);
> -
> -			if (cfs_rq->pelt_clock_throttled) {
> -				cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> -					cfs_rq->throttled_clock_pelt;
> -				cfs_rq->pelt_clock_throttled = 0;
> -			}
> +			cfs_rq->throttled_clock_pelt_time += rq_clock_pelt(rq) -
> +				cfs_rq->throttled_clock_pelt;
> +			cfs_rq->pelt_clock_throttled = 0;

This is the only hunk of the patch that affects the PELT stuff; should this
have been included in patch 3 which does the rest of the PELT accounting changes?

> @@ -7073,6 +7073,9 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
>               if (cfs_rq_is_idle(cfs_rq))
>                       h_nr_idle = h_nr_queued;
>
> +		if (throttled_hierarchy(cfs_rq) && task_throttled)
> +			record_throttle_clock(cfs_rq);
> +

Apologies if this has been discussed before.

So the throttled time (as reported by cpu.stat.local) is now accounted as
the time from which the first task in the hierarchy gets effectively
throttled - IOW the first time a task in a throttled hierarchy reaches
resume_user_mode_work() - as opposed to as soon as the hierarchy runs out
of quota.

The gap between the two shouldn't be much, but that should at the very
least be highlighted in the changelog.

AFAICT this is a purely user-facing stat; Josh/Tejun, any opinions on this?


