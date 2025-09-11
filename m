Return-Path: <linux-kernel+bounces-811284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9938B526FE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 05:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FB3188C79B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 03:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CEC22CBE6;
	Thu, 11 Sep 2025 03:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GYOZJ9Vp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C382367A8
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 03:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757560930; cv=none; b=Pk4aRbIa9rt/lKEn73liOFkh4wbDF4VR36YYplmDDgLcf8f4ng6sJDd3narregpn2PDXjEZpLOaC7w/83a2snal695dYbcU/zS663kAxUjE1sRyRVKdkOs45GK5cQM3alqWte+Z4C9nTyXgTaK6oL8Y4kcXQrUR8aJJzF+9hFr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757560930; c=relaxed/simple;
	bh=+Z8QomStjHp20zopj4gbng+cuHhjPRazDXDh4UGFg4A=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IHQYRsUXQpSpEZsjaUtImlmjfslRR2McRHyFcX+U6MHGb+tadM3pb34rCXnB8Irs3d1PtuEQ4MQsn1v6HH5r2tR2x/eLjPqLCglQhfj312zqXDlt1PkZJJftB2zWvfpd0Pi6uK44KeG8gko6eATl3CfjeLpPY5Y5WcRqexVeOmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GYOZJ9Vp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757560927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+zUXNHK5jTe8K1SbWnZOWeRa/Xg+geoh26Woq/IY2Vg=;
	b=GYOZJ9VpkqP+s+ekz1Ts4aI6CrPt3ID6Uid3NHzd7blUKF5iIQ9gdy1MLHEKZYeLAt/u/W
	mfQDhYRemqi4NjQUxUX0+0n0A16TbzDOYW3Rrtory53HvE5vJy6q6L5Lnuu0NCJSHtNLq8
	2fmAbviJ7L3Grb+LjLeOIzv7d6DDuxY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-494-WuqH-Rd1N4KY39szDkpPEw-1; Wed, 10 Sep 2025 23:22:05 -0400
X-MC-Unique: WuqH-Rd1N4KY39szDkpPEw-1
X-Mimecast-MFC-AGG-ID: WuqH-Rd1N4KY39szDkpPEw_1757560925
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-80acebb7cb7so59922585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 20:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757560925; x=1758165725;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zUXNHK5jTe8K1SbWnZOWeRa/Xg+geoh26Woq/IY2Vg=;
        b=UcWa5JocxKGG7affTIzFM0RLrYDTvpqLWZBedC/7xOgdtJ2udIHUjVd4/hz9C10H5k
         izzUGD4W+3EOsDzGs56DRrg75DKKNwa7C/gsWs0O1pw6tlPIf+kEBSw8pgvd7igXKLqH
         zHjnAR3TLjLkRKa/twUQM5TKqZJeAS22ESeuBr/YJ3XKLK+EBi35oUz6GSOZ+VVl+7qx
         5ItcK6iaFoQ880BMdYo9XTRXfnjSiPaPYJsNtWQImE/WlJhO9a2byavRVveQ1DSDbpvc
         fUg+ifzaK8oWilNrM3BB4vI3Gfd93vDP1CGGgHxHbbZ9BWxyTAlt2owRGWvQN2/vwodv
         Pw4g==
X-Forwarded-Encrypted: i=1; AJvYcCXSwGDd00CVfjvOAZXxMZOQmQee9XR/AR+Em6R9Vm5/259rCBxF82ppC/2jwfEiJ4SY7pTekBPxhZibWbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YydZa3+zfDFIMJluwXLUb1ZV6qUYOAMtJKFZgkkP1hucaR4dXax
	RuGaTfGWY5DZEu3E4d6AvSkUbNCYaKJGpuzFVpPIDeM9MH3yn7Ex3ZiL74iJcn14O3PjRCTaMR+
	ozJAYO3aA549hW9zD8aiXZBMsr6Zmz98EynsYzqgXrxDl1tCr3tuVDTx4KkIkUnZGFg==
X-Gm-Gg: ASbGnctpSbXTauMlb18OLEAQETgbN+QUf/dtC88m2sX+M33kqMsUg1vk+hFnVyTkGs5
	f4FEQBtSVZyZINgBtBa5i50jSHpBdDaM6Plk8WzgVxH1Xr6IFqDQGaWYWAvHIeOHR9CH/FZm/BS
	fznLDtNEmd0eWZ3bkSuC4PpnEQSVm2t869MJOob5uNjIrdiMEZRF5sVlWct969nPn+qfx9FnElp
	6RUsEiAU2x1a4wIShG52BcsxIzFU1iaVv1+4+BqKkqrEbR16T/RFx3iF/qVyLCFFKLKkaUKHRtk
	f+Xp5b+g6AlGD/tUjFbfixm3UqchO/uiFBQO18ub+UwTzn00bHiZjvhIEKsA8S05t8MyEookrJj
	CqJyX9ln7CA==
X-Received: by 2002:a05:620a:44c5:b0:81d:25c2:2c4e with SMTP id af79cd13be357-81d25c22cedmr807575185a.46.1757560925194;
        Wed, 10 Sep 2025 20:22:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6wIOxn+qzor+UFLMAx2tye8L0X7/ZJxBN9Pud85Nk4+Sk0PWu/AUbUjuFuG0tNMUXDzD8sQ==
X-Received: by 2002:a05:620a:44c5:b0:81d:25c2:2c4e with SMTP id af79cd13be357-81d25c22cedmr807573685a.46.1757560924769;
        Wed, 10 Sep 2025 20:22:04 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c9846379sm32341485a.18.2025.09.10.20.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Sep 2025 20:22:04 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <b547fd22-4363-403a-a427-c20526fcf063@redhat.com>
Date: Wed, 10 Sep 2025 23:22:03 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/3] cgroup: relocate cgroup_attach_lock within
 cgroup_procs_write_start
To: Yi Tao <escape@linux.alibaba.com>, tj@kernel.org, hannes@cmpxchg.org,
 mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <f460f494245710c5b6649d6cc7e68b3a28a0a000.1756896828.git.escape@linux.alibaba.com>
 <cover.1757486368.git.escape@linux.alibaba.com>
 <324e2f62ed7a3666e28768d2c35b8aa957dd1651.1757486368.git.escape@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <324e2f62ed7a3666e28768d2c35b8aa957dd1651.1757486368.git.escape@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/10/25 2:59 AM, Yi Tao wrote:
> Later patches will introduce a new parameter `task` to
> cgroup_attach_lock, thus adjusting the position of cgroup_attach_lock
> within cgroup_procs_write_start.
>
> Between obtaining the threadgroup leader via PID and acquiring the
> cgroup attach lock, the threadgroup leader may change, which could lead
> to incorrect cgroup migration. Therefore, after acquiring the cgroup
> attach lock, we check whether the threadgroup leader has changed, and if
> so, retry the operation.
>
> Signed-off-by: Yi Tao <escape@linux.alibaba.com>
> ---
>   kernel/cgroup/cgroup.c | 61 ++++++++++++++++++++++++++----------------
>   1 file changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index 2b88c7abaa00..756807164091 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2994,29 +2994,13 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>   	if (kstrtoint(strstrip(buf), 0, &pid) || pid < 0)
>   		return ERR_PTR(-EINVAL);
>   
> -	/*
> -	 * If we migrate a single thread, we don't care about threadgroup
> -	 * stability. If the thread is `current`, it won't exit(2) under our
> -	 * hands or change PID through exec(2). We exclude
> -	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
> -	 * callers by cgroup_mutex.
> -	 * Therefore, we can skip the global lock.
> -	 */
> -	lockdep_assert_held(&cgroup_mutex);
> -
> -	if (pid || threadgroup)
> -		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
> -	else
> -		*lock_mode = CGRP_ATTACH_LOCK_NONE;
> -
> -	cgroup_attach_lock(*lock_mode);
> -
> +retry_find_task:
>   	rcu_read_lock();
>   	if (pid) {
>   		tsk = find_task_by_vpid(pid);
>   		if (!tsk) {
>   			tsk = ERR_PTR(-ESRCH);
> -			goto out_unlock_threadgroup;
> +			goto out_unlock_rcu;
>   		}
>   	} else {
>   		tsk = current;
> @@ -3033,15 +3017,46 @@ struct task_struct *cgroup_procs_write_start(char *buf, bool threadgroup,
>   	 */
>   	if (tsk->no_cgroup_migration || (tsk->flags & PF_NO_SETAFFINITY)) {
>   		tsk = ERR_PTR(-EINVAL);
> -		goto out_unlock_threadgroup;
> +		goto out_unlock_rcu;
>   	}
>   
>   	get_task_struct(tsk);
> -	goto out_unlock_rcu;
> +	rcu_read_unlock();
> +
> +	/*
> +	 * If we migrate a single thread, we don't care about threadgroup
> +	 * stability. If the thread is `current`, it won't exit(2) under our
> +	 * hands or change PID through exec(2). We exclude
> +	 * cgroup_update_dfl_csses and other cgroup_{proc,thread}s_write
> +	 * callers by cgroup_mutex.
> +	 * Therefore, we can skip the global lock.
> +	 */
> +	lockdep_assert_held(&cgroup_mutex);
> +
> +	if (pid || threadgroup)
> +		*lock_mode = CGRP_ATTACH_LOCK_GLOBAL;
> +	else
> +		*lock_mode = CGRP_ATTACH_LOCK_NONE;
> +
> +	cgroup_attach_lock(*lock_mode);
> +
> +	if (threadgroup) {
> +		if (!thread_group_leader(tsk)) {
Nit: You can combine the 2 conditions together to avoid excessive indent.

  if (threadgroup && !thread_group_leader(tsk)) {

> +			/*
> +			 * a race with de_thread from another thread's exec()
Should be "de_thread()" to signal that it is a function.
> +			 * may strip us of our leadership, if this happens,
> +			 * there is no choice but to throw this task away and
> +			 * try again; this is
> +			 * "double-double-toil-and-trouble-check locking".

This "double-double-toil-and-trouble-check" is a new term in the kernel 
source tree. I will suggest to use something simpler to avoid confusion.

Cheers, Longman


