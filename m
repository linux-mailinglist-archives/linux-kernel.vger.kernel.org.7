Return-Path: <linux-kernel+bounces-817660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A33B4B58518
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 21:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 056144E02C4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205C280308;
	Mon, 15 Sep 2025 19:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TNNFNMYU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B74A23814D
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963128; cv=none; b=HuKnwgDiJcn9/96wxKRQHcepnSP9T5ZOv8acTs31aeuorn1cgX340udT4ukfp1fEirvo714/heFGoJGpmRc6rbMlp3XNAtZ2Qnszoj0+aQR/2EIMfb5AQsHX8WzTedY2Xe4eqKGNBC8UTTvspYiA3kG92YIvTz9pA/mEes+CqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963128; c=relaxed/simple;
	bh=x6OhxWHmpF7PMqdFWJh0kMOEKOF31oe1xsXGrZv/zjE=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OYlIFAi+17jJ69iiNGh5DFrRO97xqqjCozUkuPweMc7UJ89SSzwSaJ1exOMCF7kXreD7yoYMNhp4vWzDr5Jcs2ua8rUdS1QK8qM/ZzU4Fgby4Da3z4IF66X8LEK2YcsiNWrOOY6GiNDb0kwjNLxreHPbA6iI8XIw40o8n5/bM4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TNNFNMYU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757963125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zwQzTP3/YweAQfoN90LeDKpqr7TcbU4HuwusB3h9E/M=;
	b=TNNFNMYUc0m8qjKk3xMPz3GeVNWd7X9NDI8rWvYhVKDuNvOFFMOBcGk4ZT0NCHhQfnNV9H
	A83DumLYRvbOXVqNhbkMg46kATWxsVk01uiPyT2H0ee/SRfin7BBwkD7/+layC8iZOj9I/
	76WJ9lv/sVPPSSaRmWkCRJXajc9B/MQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-qcRxcApKMBqG_jpF7UyQbA-1; Mon, 15 Sep 2025 15:05:24 -0400
X-MC-Unique: qcRxcApKMBqG_jpF7UyQbA-1
X-Mimecast-MFC-AGG-ID: qcRxcApKMBqG_jpF7UyQbA_1757963123
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7fff4abc97cso1170567885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 12:05:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757963123; x=1758567923;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwQzTP3/YweAQfoN90LeDKpqr7TcbU4HuwusB3h9E/M=;
        b=DzK/n2u6ckyNm2KYT81WlL3YMRvZFbFTPhDZqU5B155CxvRzHTlN1g/qq8aJ1uXURU
         7iQy94kOA2wQp4LtkiQkZmYNuSUC3FRhZL/4PeJxLrCwe5lJ1UVe/QOLB/etnnzNz9KY
         NoqhJluYXR9PDZQ3YHzbThKcUvuUDdVQZnJBXKzArpJkYFhvRJQ17x1ZVqEPbXizJun8
         l+1v8VTRhKEyqITZiounHhGDqWknOcSNT6KY+HdcyyUcUCcSo8cXeCkz9KvcYfBqnzBb
         lLSno/TKx8/qRQpJ62rzha7TaFBGBunW/gLU9DYkK0D+CWmwP8grPtRM6oJ2V2PdTvwm
         0HrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL3ZWV7iFXCFOdt2WbgfRBbjXZ2eqFmKpA4GdvinPT8psX3dOO57Sc50ggXqDVZ0/9r4TgNjx6xNqoms0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNzPLRw1zAJEdrZxU+Pb/65cAlIdh+jYv3eKbO8Jw12YEhM/Fs
	TjhNkVRmiOIkfc9BR/OPve6BhdYa1cPgHtHNbJFQK05YBeSDc/DKnAkNpDhsXB8vjNKFoVsuEBJ
	4wFtSmmcuQYhoyvS+K6oLgB+Z0ydgjtbbVrgdUgjcLT4SDPQurVTuIn4XE/zq2pG2Rg==
X-Gm-Gg: ASbGncscSSybSxgGHiPjZ42nMzoQ2D+IMSg4FlBFrBe2t1ku0AH+NZWMw5GXg+bJN5C
	El2I+cS0PaCngtS9Ipj7KtMuE/Jl6XZt7G2h37VHa7RWqz12MM6z1B0iKbIPxq0jmSp6qPdem6J
	AvZSBPJJOjm9FxiMfi6WAMBLJ4eV9gCcesvrXyioOihwWnU+8yV3XXW0CFCO+YBfDmfGxI6bhz2
	RMrB3tvBuxPJlPxP/fXCx4drQtFErwgoGHiYl9YNKWv9hJl1f62CxGGhlhRh46W9lTDtsSBoLkn
	xczEXRZJxiH9BUB0KpVWxH5CrATRRU5SZZs+zol67jXOxNbYSB87TS8SUcWp5ZOSH3xT4NIPbRF
	8gLUaKVLauA==
X-Received: by 2002:a05:620a:4456:b0:827:7a5a:2dcb with SMTP id af79cd13be357-8277a5a2ee1mr841623185a.16.1757963123261;
        Mon, 15 Sep 2025 12:05:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzYtJqMF9JX58GAyWPQyWStp0AhvAUxOGTl8eJYqPP0E020LUH9d8N3IQLtC/yG54khQLKEw==
X-Received: by 2002:a05:620a:4456:b0:827:7a5a:2dcb with SMTP id af79cd13be357-8277a5a2ee1mr841617085a.16.1757963122617;
        Mon, 15 Sep 2025 12:05:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820ca1eaa00sm860868085a.29.2025.09.15.12.05.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Sep 2025 12:05:22 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <7a42945a-9d82-47ad-9175-cfc3c0c311c3@redhat.com>
Date: Mon, 15 Sep 2025 15:05:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC -v2 08/11] cpuset: refactor
 cpus_allowed_validate_change
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250909033233.2731579-1-chenridong@huaweicloud.com>
 <20250909033233.2731579-9-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250909033233.2731579-9-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 11:32 PM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor cpus_allowed_validate_change to handle the special case where
> cpuset.cpus can be set even when violating partition sibling CPU
> exclusivity rules. This differs from the general validation logic in
> validate_change. Add a wrapper function to properly handle this
> exceptional case.

That special rule is needed as setting v2 cpuset.cpus will never fail. 
For v1, it may only fails if the exclusivity rule set by the exclusive 
flag is violated. For v2, write failure may only happen on 
cpuset.cpus.exclusive. As a result, existing partitions may have to be 
invalidated if it will break exclusivity rule.

>
> The trialcs->prs_err field is cleared before performing validation checks
> for both CPU changes and partition errors. If cpus_allowed_validate_change
> fails its validation, trialcs->prs_err is set to PERR_NOTEXCL. If partition
> validation fails, the specific error code returned by validate_partition
> is assigned to trialcs->prs_err.
>
> With the partition validation status now directly available through
> trialcs->prs_err, the local boolean variable 'invalidate' becomes
> redundant and can be safely removed.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 84 ++++++++++++++++++++++--------------------
>   1 file changed, 45 insertions(+), 39 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 770b33e30576..6aa93bd9d5dd 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2416,6 +2416,42 @@ static enum prs_errcode validate_partition(struct cpuset *cs, struct cpuset *tri
>   	return PERR_NONE;
>   }
>   
> +static int cpus_allowed_validate_change(struct cpuset *cs, struct cpuset *trialcs,
> +					struct tmpmasks *tmp)
> +{
> +	int retval;
> +	struct cpuset *parent = parent_cs(cs);
> +
> +	retval = validate_change(cs, trialcs);
> +
> +	if ((retval == -EINVAL) && cpuset_v2()) {
> +		struct cgroup_subsys_state *css;
> +		struct cpuset *cp;
> +
> +		/*
> +		 * The -EINVAL error code indicates that partition sibling
> +		 * CPU exclusivity rule has been violated. We still allow
> +		 * the cpumask change to proceed while invalidating the
> +		 * partition. However, any conflicting sibling partitions
> +		 * have to be marked as invalid too.
> +		 */
> +		trialcs->prs_err = PERR_NOTEXCL;
> +		rcu_read_lock();
> +		cpuset_for_each_child(cp, css, parent) {
> +			struct cpumask *xcpus = user_xcpus(trialcs);
> +
> +			if (is_partition_valid(cp) &&
> +			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
> +				rcu_read_unlock();
> +				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, tmp);
> +				rcu_read_lock();
> +			}
> +		}
> +		rcu_read_unlock();
> +		retval = 0;
> +	}
> +	return retval;
> +}
>   
>   /**
>    * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
> @@ -2428,8 +2464,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   {
>   	int retval;
>   	struct tmpmasks tmp;
> -	struct cpuset *parent = parent_cs(cs);
> -	bool invalidate = false;
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   	enum prs_errcode prs_err;
> @@ -2446,12 +2480,10 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		return -ENOMEM;
>   
>   	compute_trialcs_excpus(trialcs, cs);
> +	trialcs->prs_err = PERR_NONE;
>   
> -	prs_err = validate_partition(cs, trialcs);
> -	if (prs_err) {
> -		invalidate = true;
> -		cs->prs_err = prs_err;
> -	}
> +	if (cpus_allowed_validate_change(cs, trialcs, &tmp) < 0)
> +		goto out_free;
>   
>   	/*
>   	 * Check all the descendants in update_cpumasks_hier() if
> @@ -2459,40 +2491,14 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	 */
>   	force = !cpumask_equal(cs->effective_xcpus, trialcs->effective_xcpus);
>   
> -	retval = validate_change(cs, trialcs);
> -
> -	if ((retval == -EINVAL) && cpuset_v2()) {
> -		struct cgroup_subsys_state *css;
> -		struct cpuset *cp;
> -
> -		/*
> -		 * The -EINVAL error code indicates that partition sibling
> -		 * CPU exclusivity rule has been violated. We still allow
> -		 * the cpumask change to proceed while invalidating the
> -		 * partition. However, any conflicting sibling partitions
> -		 * have to be marked as invalid too.
> -		 */
> -		invalidate = true;
> -		rcu_read_lock();
> -		cpuset_for_each_child(cp, css, parent) {
> -			struct cpumask *xcpus = user_xcpus(trialcs);
> -
> -			if (is_partition_valid(cp) &&
> -			    cpumask_intersects(xcpus, cp->effective_xcpus)) {
> -				rcu_read_unlock();
> -				update_parent_effective_cpumask(cp, partcmd_invalidate, NULL, &tmp);
> -				rcu_read_lock();
> -			}
> -		}
> -		rcu_read_unlock();
> -		retval = 0;
> +	prs_err = validate_partition(cs, trialcs);
> +	if (prs_err) {
> +		trialcs->prs_err = prs_err;
> +		cs->prs_err = prs_err;
>   	}
>   
> -	if (retval < 0)
> -		goto out_free;
> -
>   	if (is_partition_valid(cs) ||
> -	   (is_partition_invalid(cs) && !invalidate)) {
> +	   (is_partition_invalid(cs) && !trialcs->prs_err)) {
>   		struct cpumask *xcpus = trialcs->effective_xcpus;
>   
>   		if (cpumask_empty(xcpus) && is_partition_invalid(cs))
> @@ -2503,7 +2509,7 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   		 */
>   		if (is_remote_partition(cs))
>   			remote_cpus_update(cs, NULL, xcpus, &tmp);
> -		else if (invalidate)
> +		else if (trialcs->prs_err)
>   			update_parent_effective_cpumask(cs, partcmd_invalidate,
>   							NULL, &tmp);
>   		else
Reviewed-by: Waiman Long <longman@redhat.com>


