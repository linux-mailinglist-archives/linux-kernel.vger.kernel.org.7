Return-Path: <linux-kernel+bounces-792344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3E7B3C2F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500F017F404
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 19:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACA523A9B0;
	Fri, 29 Aug 2025 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z7qfq6Kk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E52233134
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756495287; cv=none; b=RChrjfwmfnlp7DdWBUytn8f8nU/BziNemVqTiPOPSogM6dWgzdFJ5UFJSFftjSNtderlWzTf/PKjsECaf2174KddYaFq+VpWyyAzD/yAWykZUaF1ro9Fhe/DFx1rYI16ud18bQhs2xrV+SJGAtARtDCv4B3NmKD36KlGf5EIWag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756495287; c=relaxed/simple;
	bh=hK17IfEkQPKPDjCpfxZ5JVNVvlsbIV7qS2oZLI8Q3Tw=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=BPFXWOkTP+4igYuyAwWpxUZDXYhUeNyNkMMWj9fNy9CQ1HulMH9JFFwRLoGUcdoH2sDOC83pDZP3gmJ6QaW6s97Y8ox2Qy5ZE8jIjEgXlArJVpuKoYUTk6nRlERh90ZQbgIzuYVIzR8CEBzSYvLfJdAfpRrwuPsZ34yExqcmeRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z7qfq6Kk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756495284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XCaI/X8aeKRskP+b5t1n4+81zkWLAo/N0Osp8Y6VlhE=;
	b=Z7qfq6KkZCQm3e6R74eG31dluCiWm7g3KONAetEZIXXJz/0MOd97WuKNdlfzI67CtSk7DA
	NMNwj9si8iKFUpyQujjybx8V+ZFb8LwnX9S0TIEL9rZ4fojwZK/RbEIQgU6j7d5XCc4J0O
	NCZt78w/ECEhjS8buw3O+A3Tz5wqSwg=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-ztKiWJGIM_iHawBDyyP6Rw-1; Fri, 29 Aug 2025 15:21:23 -0400
X-MC-Unique: ztKiWJGIM_iHawBDyyP6Rw-1
X-Mimecast-MFC-AGG-ID: ztKiWJGIM_iHawBDyyP6Rw_1756495283
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7f7ff7acb97so358024085a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 12:21:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756495283; x=1757100083;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XCaI/X8aeKRskP+b5t1n4+81zkWLAo/N0Osp8Y6VlhE=;
        b=QmQJw8j8FAo5IV5AofDc1IRoouqm1n5ujhPjCoLuxl2LmKhLgfS6A4YY1kpGhNmNcA
         wf7RbJNV6aV/hmNKlyN/dy78oWuz9Aurr1EJ3MFw3Ac/sKzafZxMBs8Jpsf/pe3F9PYa
         FDbMKuZL+r5W/xQHFiqmJJBvTlLlffWXLwNNac92Rkai1p5rXLUZpYLsMBAtsQcZhfDk
         UGmM2QloqfRb6Vqxuljx4JrCDF2tykYD11jHcpCRAHFbx3VnEE0gC3ANKYvbVuSOGy7b
         4zH8xzdZ6pSaZ9mke0jd++CzJ5J/vUwdO1iwb/P1rbSgE7XQgztseUjbsXskPaZqz+n3
         A9Jg==
X-Forwarded-Encrypted: i=1; AJvYcCVc3B0I02Yue37MTPGf7R6aM+wgCW180dOyDxNqIDN4M3AzVRPgEYxrKvzaTD3NO1t9SJopYdLacHLkUBE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzanx/pw3AIVdiwU26JLtvo6ZgcgsyAC77TvSPD1tLdDrf+HvPN
	6MTJjyKASactd0OfIrZk3p+Mt8c79J9PsUnYcy/p2emO2hwaCx1HsUwys3lREYUtbOmzL5SoDtW
	AVSru2rU7+IYojfdv48wTS36OB55PdTcj/9qWfwSVelMgC2QQorjLw50d7RM7PdJPsg==
X-Gm-Gg: ASbGncuS2/0bv7wJ8GBuMGMEbvlQHn4vnjU7PQ9rY+euw7Y8rmdz9aMrdyKpYDiaNzj
	3kTG1Za2/LyJFpU8zYjK3G3rYC6wpxJRcWbTe3RsPiSDScNwGD4/U52r1xz0PeKuGu5illAsgOl
	ExKhR7Zr+Or+8jgFpuq5F3glW0x7dyJDWAhMT9tewzqTlNVmvuCtE3Ml7yZnCwd8sdDdo/M0zkU
	uZAd3HpcvAAQckxOU4ZywrH47ESXEWSIkORokhtUHMFQlN4BgXijZXnsGdHGaimaNrD688Pkngv
	bvmGgLTC9/B1jJ2lG8yysenDSaXDB0MYloO9bwVXqwS3heWea31RY155AFNcdFb2pBjCDWl9XRZ
	tcGXgo43g+g==
X-Received: by 2002:a05:620a:c51:b0:7ea:38b:9bca with SMTP id af79cd13be357-7ea11075b20mr3290210185a.69.1756495283006;
        Fri, 29 Aug 2025 12:21:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcX6A58rjCSp6Jxt7PGZZgXeT2tZeDBtT/FBp3FFU8n7BGDi8emJG8OVjlbjfcQI6MHyAdfA==
X-Received: by 2002:a05:620a:c51:b0:7ea:38b:9bca with SMTP id af79cd13be357-7ea11075b20mr3290207885a.69.1756495282598;
        Fri, 29 Aug 2025 12:21:22 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484e8e8sm233378085a.40.2025.08.29.12.21.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:21:21 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <e02b9c35-c51e-45c0-a2ca-3d1f0492af23@redhat.com>
Date: Fri, 29 Aug 2025 15:21:21 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 01/11] cpuset: move the root cpuset write check
 earlier
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-2-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-2-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> The 'cpus' or 'mems' lists of the top_cpuset cannot be modified.
> This check can be moved before acquiring any locks as a common code
> block to improve efficiency and maintainability.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 22 +++++++++-------------
>   1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index a78ccd11ce9b..7e6a40e361ea 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -337,6 +337,11 @@ static inline bool cpuset_v2(void)
>   		cgroup_subsys_on_dfl(cpuset_cgrp_subsys);
>   }
>   
> +static inline bool cpuset_is_root(struct cpuset *cs)
> +{
> +	return (cs == &top_cpuset);
> +}
> +
>   /*
>    * Cgroup v2 behavior is used on the "cpus" and "mems" control files when
>    * on default hierarchy or when the cpuset_v2_mode flag is set by mounting
> @@ -2334,10 +2339,6 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
>   	bool force = false;
>   	int old_prs = cs->partition_root_state;
>   
> -	/* top_cpuset.cpus_allowed tracks cpu_active_mask; it's read-only */
> -	if (cs == &top_cpuset)
> -		return -EACCES;
> -
>   	/*
>   	 * An empty cpus_allowed is ok only if the cpuset has no tasks.
>   	 * Since cpulist_parse() fails on an empty mask, we special case
> @@ -2783,15 +2784,6 @@ static int update_nodemask(struct cpuset *cs, struct cpuset *trialcs,
>   {
>   	int retval;
>   
> -	/*
> -	 * top_cpuset.mems_allowed tracks node_stats[N_MEMORY];
> -	 * it's read-only
> -	 */
> -	if (cs == &top_cpuset) {
> -		retval = -EACCES;
> -		goto done;
> -	}
> -
>   	/*
>   	 * An empty mems_allowed is ok iff there are no tasks in the cpuset.
>   	 * Since nodelist_parse() fails on an empty mask, we special case
> @@ -3257,6 +3249,10 @@ ssize_t cpuset_write_resmask(struct kernfs_open_file *of,
>   	struct cpuset *trialcs;
>   	int retval = -ENODEV;
>   
> +	/* root is read-only */
> +	if (cpuset_is_root(cs))
> +		return -EACCES;
> +
>   	buf = strstrip(buf);
>   	cpuset_full_lock();
>   	if (!is_cpuset_online(cs))

The (cs == &top_cpuset) check is pretty straight forward. So if the 
cpuset_is_root() helper is only used once, I don't think we need a new 
helper here.

Cheers,
Longman


