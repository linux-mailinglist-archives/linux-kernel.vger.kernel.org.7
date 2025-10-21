Return-Path: <linux-kernel+bounces-863784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A0BF91D5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38F0C502D19
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647C2ECE87;
	Tue, 21 Oct 2025 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GWWqnetq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3A2ECD2E
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761086592; cv=none; b=QdaRmBJnEWuqR3PsmbR9z3Q/nxEeJlCWGCzxBPEcI8P2tFiaOg6hBYpDEZUYWhk47I+0d2jeJ5hwcESpUBKfpP03/0qtdMtBY3OhsebY5XGUSszytTg6E7/elLL0+kznEYW9N/lQJOFObMxSRlInblJ7F5TphcfVWYAdAbhcbEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761086592; c=relaxed/simple;
	bh=jS5ISZwEtvLLzIR+81DH+JOC73WFTyMLIhKyND3d1RY=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ccJvYz2HUQWXY5zINCZ9hiQtpcWI/YvvjS1TgZ/FkCPpp4DhQh0nSerbK8R1WKrckYVYWyWHcUmZCCQZgcdj51A5K50eE6MDBEFNfJu3J5rY+QNWEZ5bQEhwGmQfCPuz78vCfEpzgErY657PIElSuKFnLwC7usO0iLkTueVK4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GWWqnetq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761086586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1ufi8hzAWdR5ZvtubHPkIBiveTzx8KWYjOx6TAX45A=;
	b=GWWqnetqwfnAMuYbv5aI8RZ4FMT+Uz8nv4rFYSBrkiFvT+6KGQELiVgAO2Z0IWiPgeLlrK
	Wrv7UNaJ3na6xCs4wNATZUUhqqhrUQe9w9qFR8yOgFI8h5FIbW+8lP6X32fd+qnY0JI0J8
	AbgPV+3vwou+ahbAl+qeZ1rZFU2JHCE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-TPWl38xhO-S5GDQCXUb8jA-1; Tue, 21 Oct 2025 18:43:05 -0400
X-MC-Unique: TPWl38xhO-S5GDQCXUb8jA-1
X-Mimecast-MFC-AGG-ID: TPWl38xhO-S5GDQCXUb8jA_1761086585
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-88f81cf8244so3566611285a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:43:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761086585; x=1761691385;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J1ufi8hzAWdR5ZvtubHPkIBiveTzx8KWYjOx6TAX45A=;
        b=kn+15Co9EDrPLHHv0JAL7WRtpCMe7XFfEY1tVFz7EBCECeBKRfZdaNPI1GTYONeylz
         Ov3nLrEKpbRvFbTtEOcEIMeW/GK0ky9dzTwywCNtd0PaRWbM23tJwHuQBMTFUxNB/TWY
         ntmuuk5tTfNdj7zygAs4oYCsiqH+Vyg61rQoVxPdWUnS9YwtwwgJVYf4Xkfvw+YjmbTv
         XUHuMufeI0zlAmFii4jU+EiHqLGzmwQNMk7hAyjaf17mnrcH7emlyu6wkvQ/zXrkaeQB
         kX1fcNBslik/zzFaXtj69tKCEndsQM5waib/zJ9PXabXSYH7PqyZe6CkpAM3EfEwMe7K
         cPQw==
X-Forwarded-Encrypted: i=1; AJvYcCWscXj0B4nVAL3woqWEre3KCVdVvrdv6vFZvRUsM5cW5Tg43DUo5WbgkRR5gWiJUWr/JXxyoGsAv7g8ibc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQHBTl9uJUl1bd+7Y4OPAlLx5RtA3kAqg2Y5u1pSrD612InFxf
	gIkAw4eyXRA6jbk+CCo5oydQwEgskhEqp/OJjVQc4TfBJOehmBJKx9Ztpn0I5J1FTw1cpGsasnl
	mKcd0EuoOrbO9Rb2sDMeujmByAsxyPcrG9VBkamqWvdfB8+CFsvyJVx9OI9CA7t/BkQ==
X-Gm-Gg: ASbGncuxpDKTx3ebeC9CnOxAMcL00u2H0ZeGwrh+340vGraUGjOy8WiqM7CtcAjoV/s
	AUC+nzh7eAwdSY4oMxd0q7dEG4HneZoDhugvI0sLjTFmUvISyNuTwNQyrGar7FnF/Uh22xk+H7X
	UuVw3CBibPStnMFKYGyISZNk07gUumnWuMOKUSKMpZMI7KJTObo/YjaRnVz4OAo3mFrVchxls0g
	Ztqx/JZnfjlJuy21kvIY8kxJqEDbfS51ynmeRKJ+xtkwE6XZQigSskPJvQAUmWbbrRgH4n24NvQ
	5yehRRYDyQ2Qppz3OvN2+v8bUPHjiGtyzcCHrh5p/YfNY7iuylfilK5UjnrOkoedvV8PXyhUQ+l
	R6EMARwGhlLmU37h6nflKWxGRamd7FSiLN/b2HNr2AXBcBA==
X-Received: by 2002:a05:620a:2892:b0:886:ea5d:9273 with SMTP id af79cd13be357-8906e6ba4b1mr2387617585a.28.1761086585025;
        Tue, 21 Oct 2025 15:43:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKKo/21Swm4z17XlE0/ydMbQxCAbbChu7Z8fNIxB6CZQJ6hcePBsIiw2WUviotKsZ3CeiiMA==
X-Received: by 2002:a05:620a:2892:b0:886:ea5d:9273 with SMTP id af79cd13be357-8906e6ba4b1mr2387614585a.28.1761086584536;
        Tue, 21 Oct 2025 15:43:04 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba728sm848019085a.38.2025.10.21.15.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 15:43:03 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ba437129-062a-4a2f-a753-64945e9a13ff@redhat.com>
Date: Tue, 21 Oct 2025 18:42:59 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 22/33] kthread: Include unbound kthreads in the managed
 affinity list
To: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Danilo Krummrich
 <dakr@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Gabriele Monaco <gmonaco@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>,
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Michal Hocko
 <mhocko@suse.com>, Muchun Song <muchun.song@linux.dev>,
 Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Phil Auld <pauld@redhat.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Simon Horman <horms@kernel.org>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
 cgroups@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 netdev@vger.kernel.org
References: <20251013203146.10162-1-frederic@kernel.org>
 <20251013203146.10162-23-frederic@kernel.org>
Content-Language: en-US
In-Reply-To: <20251013203146.10162-23-frederic@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/13/25 4:31 PM, Frederic Weisbecker wrote:
> The managed affinity list currently contains only unbound kthreads that
> have affinity preferences. Unbound kthreads globally affine by default
> are outside of the list because their affinity is automatically managed
> by the scheduler (through the fallback housekeeping mask) and by cpuset.
>
> However in order to preserve the preferred affinity of kthreads, cpuset
> will delegate the isolated partition update propagation to the
> housekeeping and kthread code.
>
> Prepare for that with including all unbound kthreads in the managed
> affinity list.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> ---
>   kernel/kthread.c | 59 ++++++++++++++++++++++++------------------------
>   1 file changed, 30 insertions(+), 29 deletions(-)
>
> diff --git a/kernel/kthread.c b/kernel/kthread.c
> index c4dd967e9e9c..cba3d297f267 100644
> --- a/kernel/kthread.c
> +++ b/kernel/kthread.c
> @@ -365,9 +365,10 @@ static void kthread_fetch_affinity(struct kthread *kthread, struct cpumask *cpum
>   	if (kthread->preferred_affinity) {
>   		pref = kthread->preferred_affinity;
>   	} else {
> -		if (WARN_ON_ONCE(kthread->node == NUMA_NO_NODE))
> -			return;
> -		pref = cpumask_of_node(kthread->node);
> +		if (kthread->node == NUMA_NO_NODE)
> +			pref = housekeeping_cpumask(HK_TYPE_KTHREAD);
> +		else
> +			pref = cpumask_of_node(kthread->node);
>   	}
>   
>   	cpumask_and(cpumask, pref, housekeeping_cpumask(HK_TYPE_KTHREAD));
> @@ -380,32 +381,29 @@ static void kthread_affine_node(void)
>   	struct kthread *kthread = to_kthread(current);
>   	cpumask_var_t affinity;
>   
> -	WARN_ON_ONCE(kthread_is_per_cpu(current));
> +	if (WARN_ON_ONCE(kthread_is_per_cpu(current)))
> +		return;
>   
> -	if (kthread->node == NUMA_NO_NODE) {
> -		housekeeping_affine(current, HK_TYPE_KTHREAD);
> -	} else {
> -		if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> -			WARN_ON_ONCE(1);
> -			return;
> -		}
> -
> -		mutex_lock(&kthread_affinity_lock);
> -		WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> -		list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> -		/*
> -		 * The node cpumask is racy when read from kthread() but:
> -		 * - a racing CPU going down will either fail on the subsequent
> -		 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> -		 *   afterwards by the scheduler.
> -		 * - a racing CPU going up will be handled by kthreads_online_cpu()
> -		 */
> -		kthread_fetch_affinity(kthread, affinity);
> -		set_cpus_allowed_ptr(current, affinity);
> -		mutex_unlock(&kthread_affinity_lock);
> -
> -		free_cpumask_var(affinity);
> +	if (!zalloc_cpumask_var(&affinity, GFP_KERNEL)) {
> +		WARN_ON_ONCE(1);
> +		return;
>   	}
> +
> +	mutex_lock(&kthread_affinity_lock);
> +	WARN_ON_ONCE(!list_empty(&kthread->affinity_node));
> +	list_add_tail(&kthread->affinity_node, &kthread_affinity_list);
> +	/*
> +	 * The node cpumask is racy when read from kthread() but:
> +	 * - a racing CPU going down will either fail on the subsequent
> +	 *   call to set_cpus_allowed_ptr() or be migrated to housekeepers
> +	 *   afterwards by the scheduler.
> +	 * - a racing CPU going up will be handled by kthreads_online_cpu()
> +	 */
> +	kthread_fetch_affinity(kthread, affinity);
> +	set_cpus_allowed_ptr(current, affinity);
> +	mutex_unlock(&kthread_affinity_lock);
> +
> +	free_cpumask_var(affinity);
>   }
>   
>   static int kthread(void *_create)
> @@ -924,8 +922,11 @@ static int kthreads_online_cpu(unsigned int cpu)
>   			ret = -EINVAL;
>   			continue;
>   		}
> -		kthread_fetch_affinity(k, affinity);
> -		set_cpus_allowed_ptr(k->task, affinity);
> +
> +		if (k->preferred_affinity || k->node != NUMA_NO_NODE) {
> +			kthread_fetch_affinity(k, affinity);
> +			set_cpus_allowed_ptr(k->task, affinity);
> +		}
>   	}

My understanding of kthreads_online_cpu() is that hotplug won't affect 
the affinity returned from kthread_fetch_affinity(). However, 
set_cpus_allowed_ptr() will mask out all the offline CPUs. So if the 
given "cpu" to be brought online is in the returned affinity, we should 
call set_cpus_allowed_ptr() to add this cpu into its affinity mask 
though the current code will call it even it is not strictly necessary. 
This change will not do this update to NUMA_NO_NODE kthread with no 
preferred_affinity, is this a problem?

Cheers,
Longman


