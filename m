Return-Path: <linux-kernel+bounces-859993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 994BABEF1BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD9943BD7DD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA4029CB57;
	Mon, 20 Oct 2025 02:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A05EDRN7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4C629D265
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760927871; cv=none; b=Ru6bc0rikyLcdFYmiLS8lqCmkVzBt93NXh52s00C/wirTXddegJPEzlui8+3nkGBXWuOZULpJVvaJKaXNwn1Y4NP2ccQjyp2cly7uoTtwEVKfXNZc1aCn3L4noMiU6EeoQ+jSNTV4VJIdOa3J8HcRftDgOUfsITL5xV7udIDbGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760927871; c=relaxed/simple;
	bh=nuCaYM2iI9yASTsjSbVBVSd+SbnKrCEkUizGXuN2jpw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ow5eKV8bYVVJ43QDwzUJmJLE4mPMZGOHqPCEQdwgHGBWWABDGN7iXmGv4TamomwVwL+COH5bdvzc9B9nJPUK/mXXIQlOCowtQRcHfiYwojp/2ngJgLQcwMRPmHrV569atDjBXErTg8zyqdbsWjsDdrg/4ant3VDxo7rllRew19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A05EDRN7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760927868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ShnczUqurhBnD1lxAnkvI5a32ss7EfrVRt58Oh4wPVg=;
	b=A05EDRN7TILflykTjcxYBToyi7w4up4FausnQst3U2fD3L9v+zj48l5V07hAzq01uYvKQP
	QIHQIcYN8WQsC4zECxZF7AjjtR1vGC6Dnix/6jF9UnlhdUisgtOpxEuWB/kyfSS25gViJe
	KVLWWjzlzbNH5KHMQc5cIvhp9OjsmlI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-ufMl4mDJMZST-V-4x4s56Q-1; Sun, 19 Oct 2025 22:37:47 -0400
X-MC-Unique: ufMl4mDJMZST-V-4x4s56Q-1
X-Mimecast-MFC-AGG-ID: ufMl4mDJMZST-V-4x4s56Q_1760927866
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-891504015e5so509536485a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:37:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760927866; x=1761532666;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShnczUqurhBnD1lxAnkvI5a32ss7EfrVRt58Oh4wPVg=;
        b=khRrmCl45h+q7T/xYc551EW+VwL3waAzmf66AZTLrGh9NziycqeNPp2iV+9z3eMY5j
         ZPr+AYS8AnvZouJURFVhk6Bz4GK7Ahv/WjpH7+y/dz75mdEiLN4hQoUmFCsdHFKoq+07
         kTs8pmIsXT/Nq7zk2T0cAQhrFdv0fXYnUcMHwva16BjX43uU1Re93vplx9Es8VqJ55WQ
         nUUXeTo68nCuydSSgPFw/9W2/VSi6Z0vvzfKiUcxZgL+nznAzhXhHCpk4UIfA7o/eo5c
         t42V5hR+quq3KnSuwUagUCMJMk5mILZC4lcGrPt1N5OOoBXN0N16hNSu8+BwIzirLUGV
         p/cw==
X-Forwarded-Encrypted: i=1; AJvYcCV/RKUO32zPoh861wQgDlfl2mYyQf2PTlmGbW7Z4jMmuurZRLEy8Lq0lV3KtCzvBsirmh38ffqkqfxJre4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6+NRopsoeSc2+HyKuMipBcY07+4iUkWXhvMWbdCYLxDLlKqrN
	My7cLWDbG0Gculnoo3QjZnP5FUnJBkM4THerhy5qHjytrqZOwKoHTyDx6jIqiGwfq6j1/pYf4M7
	NaLyTLSQ2BgenS/4eV6X40/VwNyMLQg3086dAhOCyfjHaBqGhsyVfMK38WF4RGKe4uQ==
X-Gm-Gg: ASbGncsSP9C/y2gBMwHvYc4V5sEHXEgpvjwatIiexzPvq8j70NH+a48cvbExsFSjJ5M
	y7i6Y5np2aUhSCE+F9INW93J8xDEIX+fU4q2CjDnsKcI6nP5NDB83c2lp74CeMdixBosnj1mNYh
	KRwJmsGHdwlXs2biMkrHx7Yseykt7oXW172B5ZYcthETJzSpdGo+nkyyd8Cmvf5/xPoXmZL2VwR
	Fm1i6kOzRsJM2iQsLKAc1pgaGKn7tvjYc+VZQxgvnIxERdUUAV3ql2nDmGwY78PcXstS6GyTSGX
	k5O/90yhpLDAiBuNS9L23r8PfOh+996Sy3p7BJWH1p6YVSqQX+GtAPF4s5RsnKtGLYkRF3kG021
	Q7XT2wMWO1ycQE40UXJtbZU7F1xAGXbr6yZGJxYDJTx4kbA==
X-Received: by 2002:a05:620a:1a8d:b0:892:2a05:168 with SMTP id af79cd13be357-8922a0502f5mr721439785a.89.1760927866377;
        Sun, 19 Oct 2025 19:37:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6fiTSZ3Kv00FBJUMak+rwG8aek9eqsCkjIU+mIquIIQrid751J4rCT/3au3WawZqysb0apg==
X-Received: by 2002:a05:620a:1a8d:b0:892:2a05:168 with SMTP id af79cd13be357-8922a0502f5mr721438785a.89.1760927866066;
        Sun, 19 Oct 2025 19:37:46 -0700 (PDT)
Received: from ?IPV6:2601:600:947f:f020:85dc:d2b2:c5ee:e3c4? ([2601:600:947f:f020:85dc:d2b2:c5ee:e3c4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf9cc1bsm45751111cf.18.2025.10.19.19.37.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 19:37:45 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <c40f7e09-3262-4de3-86e6-31a4a6a5338f@redhat.com>
Date: Sun, 19 Oct 2025 22:37:43 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 01/16] cpuset: use update_partition_sd_lb in
 update_cpumasks_hier
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250928071306.3797436-1-chenridong@huaweicloud.com>
 <20250928071306.3797436-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250928071306.3797436-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/28/25 3:12 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> For cgroup v2, when a cpuset is not a valid partition root, it inherits
> the CS_SCHED_LOAD_BALANCE flag from its parent. The existing logic in
> update_cpumasks_hier() manually handled this inheritance condition.
>
> This patch replaces the inline implementation with a call to the dedicated
> update_partition_sd_lb() helper function, which already encapsulates the
> same logic. The helper function comprehensively handles both the load
> balance flag update and the necessary scheduling domain rebuild decision.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 16 +++-------------
>   1 file changed, 3 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 52468d2c178a..052f9e0c7a65 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -1257,6 +1257,8 @@ static void update_partition_sd_lb(struct cpuset *cs, int old_prs)
>   	bool rebuild_domains = (new_prs > 0) || (old_prs > 0);
>   	bool new_lb;
>   
> +	if (!cpuset_v2())
> +		return;
>   	/*
>   	 * If cs is not a valid partition root, the load balance state
>   	 * will follow its parent.
> @@ -2276,19 +2278,7 @@ static void update_cpumasks_hier(struct cpuset *cs, struct tmpmasks *tmp,
>   			!cpumask_equal(cp->cpus_allowed, cp->effective_cpus));
>   
>   		cpuset_update_tasks_cpumask(cp, cp->effective_cpus);
> -
> -		/*
> -		 * On default hierarchy, inherit the CS_SCHED_LOAD_BALANCE
> -		 * from parent if current cpuset isn't a valid partition root
> -		 * and their load balance states differ.
> -		 */
> -		if (cpuset_v2() && !is_partition_valid(cp) &&
> -		    (is_sched_load_balance(parent) != is_sched_load_balance(cp))) {
> -			if (is_sched_load_balance(parent))
> -				set_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
> -			else
> -				clear_bit(CS_SCHED_LOAD_BALANCE, &cp->flags);
> -		}
> +		update_partition_sd_lb(cp, old_prs);
>   
>   		/*
>   		 * On legacy hierarchy, if the effective cpumask of any non-
Calling update_partition_sd_lb() directly from update_cpumasks_hier() 
may incorrectly force rebuidling sched domain when it is not really 
necessary.

Cheers,
Longman


