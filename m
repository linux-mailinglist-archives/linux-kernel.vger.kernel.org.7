Return-Path: <linux-kernel+bounces-783716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10280B33194
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D906A202D42
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D650A2D5C9E;
	Sun, 24 Aug 2025 17:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DTe4oXHB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FD71DF968
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055228; cv=none; b=GHSwvXqbfTZEVddTNCwmWsuQtrb/ON8YjEhMibDOwAbomqVeqT9BPpuns6CTQSddaa2Y9pvge7OkM9LDvwRYQSXjVFGzc+HJq4QrlqcsAZKfhEeLNE6C0L/4oBPqvaycwJVbJ2AnWp6CeDP3NHLSrgfY1rrQl+gcuDRtfrRZCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055228; c=relaxed/simple;
	bh=lDaltKtNEh/B3D1Afd8rwi6dnA/KnseN9WIhGSPgo7o=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LKws2ndnMocmqaGgupa89B1ejQdfDMQ58+nakvh12FniddAB9oMFoZQ6gCELMJNKWULa3fHRMuxrwnLi+3sa6xZXKpDAqFbjcJSiIIZeA4MmKn83yosk1iFGfz2F2mwhBs4BzUXcXNa9YYiADs7ayQpplQJO2m0eZTcqHMUwkmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DTe4oXHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756055225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RNrAqXg/v+cm7+zI5j2sPacYW1E0XzgSJ3O3WFJ2ZYo=;
	b=DTe4oXHBNMBiou7Nmk0kNhZcv7jeJ6s9BlEpEhnDnLDC3hgVitLvtRZpF62afwgwl7V7ux
	2+C1Ne+vXNArJ7+FNKTfYeVQaEiFleD3pvfFRLhKaknnFEIf+5lYsw6gH7a0OUS7NycpaR
	dhMwlAPWEHirco11CnXppBgcILvvuTg=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-DPkEtKHJPz-40l-GClFwIA-1; Sun, 24 Aug 2025 13:07:03 -0400
X-MC-Unique: DPkEtKHJPz-40l-GClFwIA-1
X-Mimecast-MFC-AGG-ID: DPkEtKHJPz-40l-GClFwIA_1756055222
Received: by mail-yb1-f197.google.com with SMTP id 3f1490d57ef6-e9524f59df1so2513575276.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055222; x=1756660022;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNrAqXg/v+cm7+zI5j2sPacYW1E0XzgSJ3O3WFJ2ZYo=;
        b=VSW5ssaClLG88rNKk5j5pALfLfJnug5yg2y00LxlrfJaa2Cj7zmSEiHbsV0ofulyqB
         npu09IQ14t7mt5sbyrYk/eWhBekgJtc0kpSZfOf+zpXs56nHp3awNCpFUa00I00NGJKB
         vjAL0DsH6lTPYIIzf1ri/RuMkiMwJFzUzjn77oPMKJq+PSZ3DQfKALMxVR7BAfwz+uhy
         8VkGPfDe5jS3sVrdCht8miubJ8EukJqEqdb1jR8fjtUigz3gP7uRoRPfvGPjeXzAtvS4
         nKF4goGBleiy6DNwf9KGCAiaEPB1upRm/oUpSUOkDSIToVmZVPv6nD46F+HBaspRzBwo
         9HfA==
X-Forwarded-Encrypted: i=1; AJvYcCWCbm/zFOPgjdt8RAAo+y81UmTC3UNhBLLG9iehI+BGxNtRfyCMaeKECyxNEAja7Nmbm7p1uk4hh7cJg7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLbFqaWW6c+phVJz5SNW8c+j5q0bGDkeKaiZBRqXVv8gUaYqVj
	ncWo+gzHcimDcwYl5xrUOKCZqgZZ1o894PdC4YjUzkJTjtCcyF8OJ7lIQBGmc4PDKlIVt/nQj6L
	WvOPreSo47MjQw2WTR26DC0M+5StX4Zf32xFTuXFKxXruiNH29Z7CPZgLrST3ylvGcA==
X-Gm-Gg: ASbGncvqsYxhxeS4QbKDHheWNdkzNshrgFRZgN9dtcXB/EBFLN7yv8ge4tLNEVJFq/w
	ewL6wZ+bbh1rHJGMGOUM64AFlB8NDUpVz0jDEaSzSI+Cl7MK1bWu7ybM7ok4NfHzVTDvLVB8UKx
	Sn/FRzoTaSRj9MdO5hobzdfZqO5ci0fVpWuzCki5U68EM2jMocbmkt+SBpFT9vrL7PocMHhYA1L
	G51qpFxEtwR1SU0LpJMLWpqK2auf5QJhW1jXzVAHo7u3/FlMyWd/rLYfXUDwUtDJBf+q/InMHi3
	0GYrEO3Xot3TXhDjLnKmSR1QEarkuilXpcdND2C2kq63m+DqwQ3QeOeG4VA9KtkSASJ6LmXIM10
	CkkRP7q/pcw==
X-Received: by 2002:a05:6902:33c5:b0:e90:637a:cb36 with SMTP id 3f1490d57ef6-e951c2cf43dmr8789883276.6.1756055222344;
        Sun, 24 Aug 2025 10:07:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlAMw/iT5DD8US/YGBjHap8VpxFfxypzkaG2QlsBxLEjQEgd+0LTI7IL8yRIgM8JIKNlfDHQ==
X-Received: by 2002:a05:6902:33c5:b0:e90:637a:cb36 with SMTP id 3f1490d57ef6-e951c2cf43dmr8789845276.6.1756055221861;
        Sun, 24 Aug 2025 10:07:01 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e952c358904sm1722045276.24.2025.08.24.10.07.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 10:07:01 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <54e1466c-8db7-4fd1-a60f-5590015afaf2@redhat.com>
Date: Sun, 24 Aug 2025 13:07:00 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 1/3] cpuset: decouple tmpmasks and cpumasks
 freeing in cgroup
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
 <20250818064141.1334859-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818064141.1334859-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 2:41 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Currently, free_cpumasks() can free both tmpmasks and cpumasks of a cpuset
> (cs). However, these two operations are not logically coupled. To improve
> code clarity:
> 1. Move cpumask freeing to free_cpuset()
> 2. Rename free_cpumasks() to free_tmpmasks()
>
> This change enforces the single responsibility principle.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 32 +++++++++++++-------------------
>   1 file changed, 13 insertions(+), 19 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 3466ebbf1016..aebda14cc67f 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -459,23 +459,14 @@ static inline int alloc_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
>   }
>   
>   /**
> - * free_cpumasks - free cpumasks in a tmpmasks structure
> - * @cs:  the cpuset that have cpumasks to be free.
> + * free_tmpmasks - free cpumasks in a tmpmasks structure
>    * @tmp: the tmpmasks structure pointer
>    */
> -static inline void free_cpumasks(struct cpuset *cs, struct tmpmasks *tmp)
> +static inline void free_tmpmasks(struct tmpmasks *tmp)
>   {
> -	if (cs) {
> -		free_cpumask_var(cs->cpus_allowed);
> -		free_cpumask_var(cs->effective_cpus);
> -		free_cpumask_var(cs->effective_xcpus);
> -		free_cpumask_var(cs->exclusive_cpus);
> -	}
> -	if (tmp) {
> -		free_cpumask_var(tmp->new_cpus);
> -		free_cpumask_var(tmp->addmask);
> -		free_cpumask_var(tmp->delmask);
> -	}
> +	free_cpumask_var(tmp->new_cpus);
> +	free_cpumask_var(tmp->addmask);
> +	free_cpumask_var(tmp->delmask);
>   }
>   
>   /**
> @@ -508,7 +499,10 @@ static struct cpuset *alloc_trial_cpuset(struct cpuset *cs)
>    */
>   static inline void free_cpuset(struct cpuset *cs)
>   {
> -	free_cpumasks(cs, NULL);
> +	free_cpumask_var(cs->cpus_allowed);
> +	free_cpumask_var(cs->effective_cpus);
> +	free_cpumask_var(cs->effective_xcpus);
> +	free_cpumask_var(cs->exclusive_cpus);
>   	kfree(cs);
>   }
>   
> @@ -2427,7 +2421,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cs->partition_root_state)
>   		update_partition_sd_lb(cs, old_prs);
>   out_free:
> -	free_cpumasks(NULL, &tmp);
> +	free_tmpmasks(&tmp);
>   	return retval;
>   }
>   
> @@ -2530,7 +2524,7 @@ static int update_exclusive_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	if (cs->partition_root_state)
>   		update_partition_sd_lb(cs, old_prs);
>   
> -	free_cpumasks(NULL, &tmp);
> +	free_tmpmasks(&tmp);
>   	return 0;
>   }
>   
> @@ -2983,7 +2977,7 @@ static int update_prstate(struct cpuset *cs, int new_prs)
>   	notify_partition_change(cs, old_prs);
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_locked();
> -	free_cpumasks(NULL, &tmpmask);
> +	free_tmpmasks(&tmpmask);
>   	return 0;
>   }
>   
> @@ -4006,7 +4000,7 @@ static void cpuset_handle_hotplug(void)
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_cpuslocked();
>   
> -	free_cpumasks(NULL, ptmp);
> +	free_tmpmasks(ptmp);
>   }
>   
>   void cpuset_update_active_cpus(void)
Reviewed-by: Waiman Long <longman@redhat.com>


