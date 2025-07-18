Return-Path: <linux-kernel+bounces-737186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F94B0A8DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:49:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A64A8808A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BB82E92AF;
	Fri, 18 Jul 2025 16:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A5eH/FPM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F522E8E06
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857083; cv=none; b=MugYMNfX6rrDd6en0DhjXOTC8jVsUh3EQL9xuAG3QyHOFM84gy8KLrxJLyDCepHxxy/MKVE2dZbbrqYeEmE1RN0GByuA5pnhXnq6TemJiWuXk3FUpj2yKD32G5vSET8202TR2JNU9cm6X+eKqkcZ4xitDpedxTimumW1akjYeLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857083; c=relaxed/simple;
	bh=MUPT5uXqaIAkdRIv9xWwGPD8mLeeQZBbR0yFXSEW6jU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=C4bdmqLQUgtOxPOgNtFFBaRNmYnnCPeHr0lm1hj+w+TGgr0IzkzYaH8vbM7cLNNNaifPEo1g5puEvXYuNYinLPmcuxHQtvRuqoZw74tpVAVLNtdAnurogBZJegauMitkDlUMTqzRBk6uXQ4P3MInFRtL/GPU2aeYH8XhDDoSE30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A5eH/FPM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752857080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JERhiZO1FqB+6NSKGdBNKdwEhTOU9waM9GCpnMyUFCw=;
	b=A5eH/FPMcEdpN7CXqHHzM450UC9RU8m9jQDLcYmkQMg/T52L0t0oSRAmWoRlwQBvqdEihi
	6XwGh1UA2EgC2hUu4sM7HnzID/ZSPxrEVNx47Iq1rCSKGC8t1UMOKu09f1Devfg1l5f+vt
	1CEvCz0+MThWJMvtGbR2t8FHHW5dpQE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-ggcu6rS1MOyg0RTmHieJdw-1; Fri, 18 Jul 2025 12:44:39 -0400
X-MC-Unique: ggcu6rS1MOyg0RTmHieJdw-1
X-Mimecast-MFC-AGG-ID: ggcu6rS1MOyg0RTmHieJdw_1752857079
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6fb3bb94b5cso33092046d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:44:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857079; x=1753461879;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JERhiZO1FqB+6NSKGdBNKdwEhTOU9waM9GCpnMyUFCw=;
        b=KOOgfCicrVzbgBb2gs5H7iU856k7SpDxA+piK2k7wyt9H9QbXAmRzfpymD87KHOMs5
         Q4Riv8+BJYQOaZmE54/DntAF7w+GIcmw2H612dLSri+dYPbQqQpPMKR6sYZEXVdf79Ll
         roKsQeAakXA9VgKDp/QUwwb9BvZtbbhiJiP4ahdrQ1wVe4flCZlqESssE3LT/QyVRC0T
         3bkJcl2FqC9LoS8uPaCmWJR1MJBnUu0KZu/8UGM0TXNWb9vfZLHqqUUbONRovjzVtsGw
         qQTdRHM/+ec5G5kb0lAEGWRtku0h9CjH6QKHJN7eHRaDSBP8EQLP4ockwmat8WWKKXLZ
         Ij5g==
X-Gm-Message-State: AOJu0YzWRJ9KejPUQHoBrHUU6qD0jD37EYm8ecEC0me1LlzWu6RO13uA
	F/0BJAkj6HlupZMbeJcQDrCXsMTjeshrO4gcEfDaMzLykYw4GHGHnbEyXnJFac3v2Dc+y7fjU44
	mFNW1a8BLTEbq1bQRDnIaX12NwQ+EABj6qJPHYmD5MJjXz/jJ5tSwX0GB62uRijibnA==
X-Gm-Gg: ASbGnctnej5ItWGBYnZdwCl/1Zwzjh1kfWY8JTnZB0dIIwgFB76X7qnIP2oEMES6hHf
	fhwdzlZRj48JNSw3r9fJs4rpxatTq2RIb69kQb4nxSxTXcSUOtPRvtsBl2lP79OcSkWydCqV9Hg
	UZ5Jw0sEvdVp8yQLPrlT7TWUDkVRDHfZKrrJ8TJqCJ/gIAPkttXpswV+Rmolz9qykLorTO1Xjx1
	DgTczms+SCSC+HeTQqlEzxZhknkV2RRl0RodLTJpX7FY7TCTkqXbtgXBG65oOohSDale5l/ETTS
	ZnBSVpK4SS2cT2IiBhs/RuHIFnwSFIncs5hScCs8DbfwTqNgGBRLSxA7Z65EUQyzsGEBVic41c/
	E/ENz4GWKOw==
X-Received: by 2002:a0c:f410:0:b0:6fd:609d:e924 with SMTP id 6a1803df08f44-704f4b02165mr217575126d6.36.1752857078740;
        Fri, 18 Jul 2025 09:44:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4no08gFB65n1oCHwJbCCu9Qlg673ZDju2Ue/tovZEXpylDXZ4tExTNcCJYzuMmD4eWzzOdg==
X-Received: by 2002:a0c:f410:0:b0:6fd:609d:e924 with SMTP id 6a1803df08f44-704f4b02165mr217574346d6.36.1752857078137;
        Fri, 18 Jul 2025 09:44:38 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8f0842sm9557946d6.30.2025.07.18.09.44.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:44:37 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ab63352e-3a15-4f04-bd87-96eb88943520@redhat.com>
Date: Fri, 18 Jul 2025 12:44:35 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] sched/core: Mask out offline CPUs when user_cpus_ptr
 is used
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
 Chen Ridong <chenridong@huaweicloud.com>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>
References: <20250718164143.31338-1-longman@redhat.com>
Content-Language: en-US
In-Reply-To: <20250718164143.31338-1-longman@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/18/25 12:41 PM, Waiman Long wrote:
> Chen Ridong reported that cpuset could report a kernel warning for a task
> due to set_cpus_allowed_ptr() returning failure in the corner case that:
>
> 1) the task used sched_setaffinity(2) to set its CPU affinity mask to
>     be the same as the cpuset.cpus of its cpuset,
> 2) all the CPUs assigned to that cpuset were taken offline, and
> 3) cpuset v1 is in use and the task had to be migrated to the top cpuset.
>
> Due to the fact that CPU affinity of the tasks in the top cpuset are
> not updated when a CPU hotplug online/offline event happens, offline
> CPUs are included in CPU affinity of those tasks. It is possible
> that further masking with user_cpus_ptr set by sched_setaffinity(2)
> in __set_cpus_allowed_ptr() will leave only offline CPUs in the new
> mask causing the subsequent call to __set_cpus_allowed_ptr_locked()
> to return failure with an empty CPU affinity.
>
> Fix this failure by skipping user_cpus_ptr masking if there is no online
> CPU left.
>
> Reported-by: Chen Ridong <chenridong@huaweicloud.com>
> Closes: https://lore.kernel.org/lkml/20250714032311.3570157-1-chenridong@huaweicloud.com/
> Fixes: da019032819a ("sched: Enforce user requested affinity")
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>   kernel/sched/core.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)

Sorry, I forgot to change the patch title. Will send out a v3.

Cheers,
Longman

> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 81c6df746df1..208f8af73134 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3170,12 +3170,13 @@ int __set_cpus_allowed_ptr(struct task_struct *p, struct affinity_context *ctx)
>   
>   	rq = task_rq_lock(p, &rf);
>   	/*
> -	 * Masking should be skipped if SCA_USER or any of the SCA_MIGRATE_*
> -	 * flags are set.
> +	 * Masking should be skipped if SCA_USER, any of the SCA_MIGRATE_*
> +	 * flags are set or no online CPU left.
>   	 */
>   	if (p->user_cpus_ptr &&
>   	    !(ctx->flags & (SCA_USER | SCA_MIGRATE_ENABLE | SCA_MIGRATE_DISABLE)) &&
> -	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr))
> +	    cpumask_and(rq->scratch_mask, ctx->new_mask, p->user_cpus_ptr) &&
> +	    cpumask_intersects(rq->scratch_mask, cpu_active_mask))
>   		ctx->new_mask = rq->scratch_mask;
>   
>   	return __set_cpus_allowed_ptr_locked(p, ctx, rq, &rf);


