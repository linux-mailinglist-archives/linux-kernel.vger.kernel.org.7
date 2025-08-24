Return-Path: <linux-kernel+bounces-783717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B6E4B33196
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 19:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03C0F202C1F
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE8E2DA749;
	Sun, 24 Aug 2025 17:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5WYlxhn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C28F1F4CB3
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 17:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756055251; cv=none; b=tvmFsFs6SMEP9vKBPx85SLbz6DETv9cxI/hCyA8auPwQVEfM0Fzj/engbNbSMyoOLNOoL6qQvT5dLxdQDMFKhXmPih6zRuzjMvAx3rkkGLw9HgOL8O2ohSGfHxaVZKxlNXil0xZHgkgFlhoxLpmtnBHI74dCiAYOb4JIsqIfMi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756055251; c=relaxed/simple;
	bh=Q1L1yzZ7ud94WvojabMeOWCugIEPeRROO5DXpiq1gpk=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FOFBMStYwtV0OQOhOGgHoe6nEimuH05+fFhRE0K6iFlTCe2FqxsXSs6j/L0003neBFaZn33f0Tf7CdkXQ7cv8Jn/xzCQxLp9NUnqlk5H3Zprx6zfrRXVPf90gVzpZ+aaG+s2I8UEFoBVmz/nezatNheWLoLAaW7VT5d0RdGxGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5WYlxhn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756055249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1KblgusdaX44GtEkaStJj875tSXGSeuFJK6BC8mzxMA=;
	b=S5WYlxhnrLtPrZEdxTUSLV/ltbA1sTkWWKXJNzA8cUK9C/YpXTzcbgOS9Pjj7yxxhI9rUQ
	gDUyLvVeuJcuh6v5I7BwYI+rSN/+/h3qNpGc69ccdDlN9oJPA0CRH3qvl+9lLWIp8ULZdP
	fRpoIhMec3H0NT7E5KzD0ld87cwogmc=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-E1dTIOrxMamg8V4EVWPAEg-1; Sun, 24 Aug 2025 13:07:27 -0400
X-MC-Unique: E1dTIOrxMamg8V4EVWPAEg-1
X-Mimecast-MFC-AGG-ID: E1dTIOrxMamg8V4EVWPAEg_1756055247
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7210d5b05dbso991037b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 10:07:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756055247; x=1756660047;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KblgusdaX44GtEkaStJj875tSXGSeuFJK6BC8mzxMA=;
        b=dufcQqypQt5+YNSSGHKJJAZBY75rJNht6pCGnGcqOPIUWHD2eCQ99DsyEuHnRcRkwC
         BYLFuAjEVgQsi4m2+vL1yVi15R/B3G/z0M1wD7Xp4mPbqWxu0pS4GXv8TXTQs/LJJ73B
         2Jl+nQXqy1MQmKBUUen+MR5m5uAS9T4sZ1/3adSPUx3vXlEZl5r3xsX08PCbgLHh3M8X
         trqbfCGs/gkguhZRxQKTXU1qTYdlvFgJ9G7ZqUDOenFoaD4K6Xhp8phSAThZeeAT3+00
         Gaqs59XymZKkHn+CMK9w936+OA6d9SkftH0pgK1wrx1v8H8mk8leS0aHEXD2eeoEx8OW
         hWMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHZKmgMBdKw9T5eHNuldX89FtD/xPgIJp5L1XCJ1uK+whUSo+XQ0S7MhIrxgq475yprVt/qsMm7Pb1IuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1VxWbrxG2lklqtLffLGrR2vCaWgyHJYhyOSedgNz1OLc7y7ig
	GUZso4cfeJtbLCpJDOfRUVhrFWJZd4Hg0yJveaUBn6b2xYaBNkH63O7/e2+BcunXhcWGlzrIo97
	Fg5ZuNb9SGQI6msDa+h+8HMtfpJcgP6ydlhEEizrtIl6dcT0tWew0kcJlz9sNaMc9sw==
X-Gm-Gg: ASbGncsFX1DUrrzyKaQb+Tdju0Fg62Su2ndqsv02njQAo/Hxiiq3ZHsb2LiDkELNoL/
	+lkEskA0OCil7i7nuOtnF3mg96AM8jb4/REQkwhRUrRxUhKa6PWfZasrPuBcvUZ9Xsgte3sqHBk
	aORxDC/OBIG9+5aWjGAOqcqcJPUkS+2+2sQyQX8JLi+8J9IvFYr4CTazUUvBoI08v0cqytbAGai
	LT+QjyOLTZS6Hstr9jKMWGFsod3MPEszwebP5SGCigBh0pgvZPtW+8dYaCf+e7GgPJIqRhYk+KX
	UWQxOBCJyUn+en81g+3BcismcVb4t+pztcjGJkke5ZzG5nip2Exu/q/g5YBVbESanMFX6T/iOk+
	ntuay4CKwGA==
X-Received: by 2002:a05:690c:6c83:b0:71c:1a46:48f9 with SMTP id 00721157ae682-71fdc3d0a53mr101822937b3.33.1756055246701;
        Sun, 24 Aug 2025 10:07:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIIbv6oJnhRcILnVA8ypDDZjI/HQujg/Yk0MBJjauaxWq7ni+ri5OU2DLYTcQ5PTa66rkPVQ==
X-Received: by 2002:a05:690c:6c83:b0:71c:1a46:48f9 with SMTP id 00721157ae682-71fdc3d0a53mr101822457b3.33.1756055246185;
        Sun, 24 Aug 2025 10:07:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff1734ac3sm12269037b3.23.2025.08.24.10.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Aug 2025 10:07:25 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <36685999-17f1-479e-9895-a22ef28bce67@redhat.com>
Date: Sun, 24 Aug 2025 13:07:24 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v4 3/3] cpuset: add helpers for cpus read and
 cpuset_mutex locks
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250818064141.1334859-1-chenridong@huaweicloud.com>
 <20250818064141.1334859-4-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250818064141.1334859-4-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/25 2:41 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> cpuset: add helpers for cpus_read_lock and cpuset_mutex locks.
>
> Replace repetitive locking patterns with new helpers:
> - cpuset_full_lock()
> - cpuset_full_unlock()
>
> This makes the code cleaner and ensures consistent lock ordering.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset-internal.h |  2 ++
>   kernel/cgroup/cpuset-v1.c       | 12 +++----
>   kernel/cgroup/cpuset.c          | 60 +++++++++++++++++++--------------
>   3 files changed, 40 insertions(+), 34 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset-internal.h b/kernel/cgroup/cpuset-internal.h
> index 75b3aef39231..337608f408ce 100644
> --- a/kernel/cgroup/cpuset-internal.h
> +++ b/kernel/cgroup/cpuset-internal.h
> @@ -276,6 +276,8 @@ int cpuset_update_flag(cpuset_flagbits_t bit, struct cpuset *cs, int turning_on)
>   ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   				    char *buf, size_t nbytes, loff_t off);
>   int cpuset_common_seq_show(struct seq_file *sf, void *v);
> +void cpuset_full_lock(void);
> +void cpuset_full_unlock(void);
>   
>   /*
>    * cpuset-v1.c
> diff --git a/kernel/cgroup/cpuset-v1.c b/kernel/cgroup/cpuset-v1.c
> index b69a7db67090..12e76774c75b 100644
> --- a/kernel/cgroup/cpuset-v1.c
> +++ b/kernel/cgroup/cpuset-v1.c
> @@ -169,8 +169,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>   	cpuset_filetype_t type = cft->private;
>   	int retval = -ENODEV;
>   
> -	cpus_read_lock();
> -	cpuset_lock();
> +	cpuset_full_lock();
>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> @@ -184,8 +183,7 @@ static int cpuset_write_s64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		break;
>   	}
>   out_unlock:
> -	cpuset_unlock();
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return retval;
>   }
>   
> @@ -454,8 +452,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   	cpuset_filetype_t type = cft->private;
>   	int retval = 0;
>   
> -	cpus_read_lock();
> -	cpuset_lock();
> +	cpuset_full_lock();
>   	if (!is_cpuset_online(cs)) {
>   		retval = -ENODEV;
>   		goto out_unlock;
> @@ -498,8 +495,7 @@ static int cpuset_write_u64(struct cgroup_subsys_state *css, struct cftype *cft,
>   		break;
>   	}
>   out_unlock:
> -	cpuset_unlock();
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return retval;
>   }
>   
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index d5588a1fef60..d29f90a28e1e 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -250,6 +250,12 @@ static struct cpuset top_cpuset = {
>   
>   static DEFINE_MUTEX(cpuset_mutex);
>   
> +/**
> + * cpuset_lock - Acquire the global cpuset mutex
> + *
> + * This locks the global cpuset mutex to prevent modifications to cpuset
> + * hierarchy and configurations. This helper is not enough to make modification.
> + */
>   void cpuset_lock(void)
>   {
>   	mutex_lock(&cpuset_mutex);
> @@ -260,6 +266,24 @@ void cpuset_unlock(void)
>   	mutex_unlock(&cpuset_mutex);
>   }
>   
> +/**
> + * cpuset_full_lock - Acquire full protection for cpuset modification
> + *
> + * Takes both CPU hotplug read lock (cpus_read_lock()) and cpuset mutex
> + * to safely modify cpuset data.
> + */
> +void cpuset_full_lock(void)
> +{
> +	cpus_read_lock();
> +	mutex_lock(&cpuset_mutex);
> +}
> +
> +void cpuset_full_unlock(void)
> +{
> +	mutex_unlock(&cpuset_mutex);
> +	cpus_read_unlock();
> +}
> +
>   static DEFINE_SPINLOCK(callback_lock);
>   
>   void cpuset_callback_lock_irq(void)
> @@ -3233,8 +3257,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	int retval = -ENODEV;
>   
>   	buf = strstrip(buf);
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> +	cpuset_full_lock();
>   	if (!is_cpuset_online(cs))
>   		goto out_unlock;
>   
> @@ -3263,8 +3286,7 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	if (force_sd_rebuild)
>   		rebuild_sched_domains_locked();
>   out_unlock:
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	flush_workqueue(cpuset_migrate_mm_wq);
>   	return retval ?: nbytes;
>   }
> @@ -3367,12 +3389,10 @@ static ssize_t cpuset_partition_write(struct kernfs_open_file *of, char *buf,
>   	else
>   		return -EINVAL;
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> +	cpuset_full_lock();
>   	if (is_cpuset_online(cs))
>   		retval = update_prstate(cs, val);
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return retval ?: nbytes;
>   }
>   
> @@ -3497,9 +3517,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   	if (!parent)
>   		return 0;
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> -
> +	cpuset_full_lock();
>   	if (is_spread_page(parent))
>   		set_bit(CS_SPREAD_PAGE, &cs->flags);
>   	if (is_spread_slab(parent))
> @@ -3551,8 +3569,7 @@ static int cpuset_css_online(struct cgroup_subsys_state *css)
>   	cpumask_copy(cs->effective_cpus, parent->cpus_allowed);
>   	spin_unlock_irq(&callback_lock);
>   out_unlock:
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   	return 0;
>   }
>   
> @@ -3567,16 +3584,12 @@ static void cpuset_css_offline(struct cgroup_subsys_state *css)
>   {
>   	struct cpuset *cs = css_cs(css);
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> -
> +	cpuset_full_lock();
>   	if (!cpuset_v2() && is_sched_load_balance(cs))
>   		cpuset_update_flag(CS_SCHED_LOAD_BALANCE, cs, 0);
>   
>   	cpuset_dec();
> -
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> +	cpuset_full_unlock();
>   }
>   
>   /*
> @@ -3588,16 +3601,11 @@ static void cpuset_css_killed(struct cgroup_subsys_state *css)
>   {
>   	struct cpuset *cs = css_cs(css);
>   
> -	cpus_read_lock();
> -	mutex_lock(&cpuset_mutex);
> -
> +	cpuset_full_lock();
>   	/* Reset valid partition back to member */
>   	if (is_partition_valid(cs))
>   		update_prstate(cs, PRS_MEMBER);
> -
> -	mutex_unlock(&cpuset_mutex);
> -	cpus_read_unlock();
> -
> +	cpuset_full_unlock();
>   }
>   
>   static void cpuset_css_free(struct cgroup_subsys_state *css)
Reviewed-by: Waiman Long <longman@redhat.com>


