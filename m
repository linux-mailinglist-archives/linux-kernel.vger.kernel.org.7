Return-Path: <linux-kernel+bounces-792422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC618B3C3A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 22:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D57DD7C2218
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CD7253F2B;
	Fri, 29 Aug 2025 20:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OEAbGD/4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69C2494FF
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756498352; cv=none; b=Vk+urvkObck7dpkAFqw2jPRNqyHZfC9qccCYnUZxwlOv7D+a6z0jyg+sqCgLQ7tlZSThYNFh2xB2QD7q7PefBD02FmTKvOoIb4aXceEjForayCMGIYpcqxYAeTavCsVpOnZK/67FiQE2vd76Hbk6sxhVKqul2bP7DaYiCvJuymE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756498352; c=relaxed/simple;
	bh=WUKFCfzEQIecsUfn03qUxdeTfr6N7kWQTIklobLyuo4=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=D02V1RCHajY3NiATxVhNAMgh3mclgHdgezHlxbX7k7qXG64sa73QxllNYhd6vz9UGckTZrrySq6JPyrrKUntJ/MiJf/GNMr7jrvseiD4wlT4rGoYmKKb4cMYMxhg9GLPn6mdKEl7/fkzQ0wvl90RMXbncvScIbbwTXut01xJZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OEAbGD/4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756498349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9rmuHyT0KcZrdRyc50Eyd5M0OE5Q+EdTIaRuRiJIYIo=;
	b=OEAbGD/4VLN1cRaVJF1dqA42AplMRGSuaJb5unwlKKeuGOwJrTro6N7EgUk2phBl5amFs6
	14OeRwdLWK4M2s+2WGhnPkinxNF6Tq/897yaQEXeui0p6492Myjsli16TQznz+ne+AAw7k
	cAoZULoVe392BkD6p91bqowYu1oDeAM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-bsGtXwb7MqGdX5HX5eAr4Q-1; Fri, 29 Aug 2025 16:12:27 -0400
X-MC-Unique: bsGtXwb7MqGdX5HX5eAr4Q-1
X-Mimecast-MFC-AGG-ID: bsGtXwb7MqGdX5HX5eAr4Q_1756498347
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7fe08605c34so107798785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756498347; x=1757103147;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rmuHyT0KcZrdRyc50Eyd5M0OE5Q+EdTIaRuRiJIYIo=;
        b=O6omjXW5bjoYDpcQAUkGnSQTFbxPuG/bcbccPxS7Thd5nUpDpdbJCW5HMtS4EZmo0h
         Irj1uR6gQDAS1vkqVn+d7bz3EDmqtByS9LDfIQqrRu1oPCPru2OvzUo1ln7MKTTvu4by
         RqEl55J7/DIaezpJcFVS4U0yNqYHrWhHW5s1C1UYTHe3cBNrUTpERqpIbUIb53DgUKtL
         MvqqvGlz30xVGQIV4lrkmevnheZDU2cxnLhSMNmN2t3Tk+xAaQdOmfLLRfQPV+szRsRm
         OurjdRwz0HY6BmbhJkoxtFBG1+KiIrCLbLBiIf7lYN3R3iQWfIxq0DmcsC9FfhXeoqd/
         5RqA==
X-Forwarded-Encrypted: i=1; AJvYcCWvbnGYpXwnRbDD5wCLdC6/91FQuKGbDHUCi76uF0EhKZ5CJ6XrEWtEn8zyincUKYwIUiGkWLoCWtibvN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwolB7jVQMirG5eBt0GR2u25FfJxEuQfeGTDFK7zKKX+lxSo6vC
	JNUpHZBd0xLyhy6F0x/4rU5sXLIqZr9xVJjzCgeTu1Btz96oZ2Sf6ljmWuP+BTJJr4OMLqJYqaR
	OVFAdewe5V3WqFfh7S5Spc9gd0EbRI260OdD13oVhpu05o5LUPbLjZ2/n7wZCOGf7zA==
X-Gm-Gg: ASbGncssDdCJHRDZWwdP9TqY9dN00/3UqcwxP8IKra/0jpmLgFfh9Z32Qe0Sh5mILDy
	nOfM/T0F4BFb0gWJ1sFMNirBlTuUIVBVf2XF5N0vIbrNgB8nRuLUblUH8szzzarEK1TOctZeCiI
	WKNGK5OUZt4GRfTRZ2gvDYAdSmmhiaKNBZ1jGrAWwiB3ATqwmYxwQ6rvBlMoZoUUk/GJx9vF/g3
	1F59srgOKd+eNvL3t4HpnKtnLxMgrWABoMCxPPQ7cLCLacG8NqC2+ly50S5qW52/Pcq5O+VZMed
	vLCyXyNGOn4bDEM6y/BIYbuGRWEhFwDcMvqWl2bksd9RMESax6QIdgoVBa7eGWsr6heEbEoScJh
	RsLAGVorhgg==
X-Received: by 2002:a05:620a:3902:b0:7f9:b87f:212c with SMTP id af79cd13be357-7f9b87f23f9mr954920385a.20.1756498347254;
        Fri, 29 Aug 2025 13:12:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFA7fYPqivxZa0nwJ4I4Zi1pIaXNPPOHdBA1vCUTZhYrmfMgXx7WxOATxzDYa+my+y3Ry9L6w==
X-Received: by 2002:a05:620a:3902:b0:7f9:b87f:212c with SMTP id af79cd13be357-7f9b87f23f9mr954916685a.20.1756498346695;
        Fri, 29 Aug 2025 13:12:26 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc1484ac70sm239229785a.36.2025.08.29.13.12.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:12:26 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <ca3bcede-2289-4e51-a2db-0da75d85fcbc@redhat.com>
Date: Fri, 29 Aug 2025 16:12:23 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next RFC 08/11] cpuset: refactor acpus_validate_change
To: Chen Ridong <chenridong@huaweicloud.com>, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
 lujialin4@huawei.com, chenridong@huawei.com
References: <20250828125631.1978176-1-chenridong@huaweicloud.com>
 <20250828125631.1978176-9-chenridong@huaweicloud.com>
Content-Language: en-US
In-Reply-To: <20250828125631.1978176-9-chenridong@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/28/25 8:56 AM, Chen Ridong wrote:
> From: Chen Ridong <chenridong@huawei.com>
>
> Refactor acpus_validate_change to handle the special case where
> cpuset.cpus can be set even when violating partition sibling CPU
> exclusivity rules. This differs from the general validation logic in
> validate_change. Add a wrapper function to properly handle this
> exceptional case.
>
> Since partition invalidation status can be determined by trialcs->prs_err,
> the local variable 'bool invalidate' can be removed.
>
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>   kernel/cgroup/cpuset.c | 83 +++++++++++++++++++++++-------------------
>   1 file changed, 45 insertions(+), 38 deletions(-)
>
> diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> index 71190f142700..75ad18ab40ae 100644
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> @@ -2410,43 +2410,11 @@ static bool invalidate_cs_partition(struct cpuset *cs)
>   	return false;
>   }
>   
> -/**
> - * update_cpumask - update the cpus_allowed mask of a cpuset and all tasks in it
> - * @cs: the cpuset to consider
> - * @trialcs: trial cpuset
> - * @buf: buffer of cpu numbers written to this cpuset
> - */
> -static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
> -			  const char *buf)
> +static int acpus_validate_change(struct cpuset *cs, struct cpuset *trialcs,
> +					struct tmpmasks *tmp)

What does "acpu" stand for? I suppose it means cpus_allowed. I will 
suggest to use a more descriptive name even if it is longer. I did use 
xcpus for exclusive_cpus, but 'x' is a seldomly used English alphabet 
that can associate with exclusive_cpus rather easily, but 'a' is not.

Cheers,
Longman


