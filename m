Return-Path: <linux-kernel+bounces-752305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73646B173CA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 17:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5663B1AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 15:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B20A1BE238;
	Thu, 31 Jul 2025 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PDz3jrGJ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253FC190477
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 15:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753974574; cv=none; b=BapsSlIyO2U11d4es6umQXnwdckhw8NG+S3T4sAsyUTgyJjY4rJdW/c8ROTtvIR1oPVy5D2+q/HXm/uSfmiv+cl82V/DxZayQMN3G6608YfCDTlO5SVfNF6VSrkKSZXMlZPA9YgFBl72GUI4g0YDSaglJbt972pYwNCOF6ts0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753974574; c=relaxed/simple;
	bh=fCuw5VSMaFxOncBL8qcL1+BlKHdU1UQHjPv0zjIe5qQ=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:References:
	 In-Reply-To:Content-Type; b=XjtvVME07b92yxDEPrwXL9E+EqIsptu7NcYRwx9/WEDm7BfF40g1WXcRs7kv0FeYzUQl7naMS2ZHk3GRrveF0nGGw7upPwVnnqBn5rTMeIe5F2CPkT7XlEoOHOUy1EeJa1hOHd7zdUi1I9GzpVSj+uK88t85DIEqyUysLnA8FVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PDz3jrGJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753974572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CpKKEROOgajok5N4lefBtA1GQK/aQGU0LZBxXOFiqE=;
	b=PDz3jrGJXSLMGHkzqWiYsBDjIuBxWAOUt7fS4ski66TuFdTVpNKm3W094zinLDB/sHH+dZ
	OGySEIA66i/CD5Wjsxhtf5vhxYq7IiKDlzqqXYeKTkSMWP65ae5WP8nXEY8Xjk9BLFTwVF
	1Oj7po01/4d49Qu/Uo3Ik1UWQ95EJWM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-T44dMou1MCS1e0_kPuDmjA-1; Thu, 31 Jul 2025 11:09:30 -0400
X-MC-Unique: T44dMou1MCS1e0_kPuDmjA-1
X-Mimecast-MFC-AGG-ID: T44dMou1MCS1e0_kPuDmjA_1753974570
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-7074bad03d5so10822176d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 08:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753974569; x=1754579369;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+CpKKEROOgajok5N4lefBtA1GQK/aQGU0LZBxXOFiqE=;
        b=prsbU2AuLFYIVimmNkpxmMH4KloMGowI3saCofDkKWEk/UTAlBMCwisUhTAzzhQlCB
         38idTlEMv8FET93PJSlTItfJYY0pVW6e9l7fIDJqQtZTMMKCmj3Taxv0yaKIieIReFnF
         6n5aPrLowB0uumnHXaqo5c0fIf6MvKZW81X8m1Aiu3k733gjtx+kTJJl7B1NwWMX/+X+
         KMdaMAsIYf4hIy+TJqT62zzMpog737aSxxCY8cC3u8P7FkzvI4fwRu7JtK8qlBK5CUNh
         htGCrRb6oaEDeYxV/MX0LKLdzgr17ixrz3SARtHsl+MQ55G/V0JKFpxNqUM7M0U7bK7K
         0A7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIx+PT9RlQclpZtq6UtKC76mn/qJqbt9yfF/KjRbVeZhZm3Z9YQsMn3WobKO6mERZHp3SiOIbXKAPt9xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqFC07Dx94b5RWmJg9iXgRmTpmPEa4XJXVPI4gQedeEQ+Iw1vn
	PQiTq2Pbgqh08eoGNw6Ionn8SjYZ2PTaBPRWPUQKcStBIfoAfYAXNbNYgGsX7/v4n/YmflDvS50
	T7/s8xb/1t7PprGwU3h86NMKYLzyQas0gMwfR/1GW5/cfxJ/FQ7VDB6R+z+gvCH2fmmk/DTcT/w
	vC
X-Gm-Gg: ASbGnctIEvXfZp1HrFfUTWnjt6m7bFTL3SoXsTVtMKulfrRHGCv/qon6gfIfaAzBE2O
	I6zXD62YuTKOsf18SoripI7tugty6DedQp+3ikC4K1bOfzIdHfTR0pH0Snej8DVAsz6xR+/DPxM
	xgN2e1oh/OXBdqH2ABdJNFXTNVf9/t59et1FzkVtgG4R7lXAY5Blh37u1ezh32pXBiSApLhwHnO
	wm8x/djpiE2Ci+7mmsNljbORdYsgXv445rm5ITkpatFk8JfJmBvEDgQ8PC5v8wewE4qDRm5J4rQ
	nKEC7t4uYY4qfKsbQBkI4xwD+xt0nHY/av/NOAV+20Y7elJ8cBFpx5oPRMfNqImMWwnK9CpFNiB
	x7BtGKfbWgg==
X-Received: by 2002:a0c:e017:0:b0:707:71dc:a382 with SMTP id 6a1803df08f44-70771dcbec0mr66037346d6.25.1753974568876;
        Thu, 31 Jul 2025 08:09:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyMfLJOaevBPUMOTNm2stmUhsA01M4ErI+iDS+eNSXueVY0l7nQYHQn1JCEF9CEfqq3aX/6Q==
X-Received: by 2002:a0c:e017:0:b0:707:71dc:a382 with SMTP id 6a1803df08f44-70771dcbec0mr66036966d6.25.1753974568420;
        Thu, 31 Jul 2025 08:09:28 -0700 (PDT)
Received: from ?IPV6:2601:188:c180:4250:ecbe:130d:668d:951d? ([2601:188:c180:4250:ecbe:130d:668d:951d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cd56226sm8271966d6.44.2025.07.31.08.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 08:09:27 -0700 (PDT)
From: Waiman Long <llong@redhat.com>
X-Google-Original-From: Waiman Long <longman@redhat.com>
Message-ID: <a2ef7773-bec6-466f-81b3-e1d8f6cbe7b6@redhat.com>
Date: Thu, 31 Jul 2025 11:09:27 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 6/8] sched/isolation: Force housekeeping if isolcpus
 and nohz_full don't leave any
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20250730131158.101668-1-gmonaco@redhat.com>
 <20250730131158.101668-7-gmonaco@redhat.com>
Content-Language: en-US
In-Reply-To: <20250730131158.101668-7-gmonaco@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/30/25 9:11 AM, Gabriele Monaco wrote:
> Currently the user can set up isolcpus and nohz_full in such a way that
> leaves no housekeeping CPU (i.e. no CPU that is neither domain isolated
> nor nohz full). This can be a problem for other subsystems (e.g. the
> timer wheel imgration).
>
> Prevent this configuration by invalidating the last setting in case the
> union of isolcpus and nohz_full covers all CPUs.
>
> Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
> ---
>   kernel/sched/isolation.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 93b038d48900..0019d941de68 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -165,6 +165,18 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
>   			}
>   		}
>   
> +		/* Check in combination with the previously set cpumask */
> +		type = find_first_bit(&housekeeping.flags, HK_TYPE_MAX);
> +		first_cpu = cpumask_first_and_and(cpu_present_mask,
> +						  housekeeping_staging,
> +						  housekeeping.cpumasks[type]);
> +		if (first_cpu >= nr_cpu_ids || first_cpu >= setup_max_cpus) {
> +			pr_warn("Housekeeping: must include one present CPU neither "
> +				"in nohz_full= nor in isolcpus=, ignoring setting %s\n",
> +				str);
> +			goto free_housekeeping_staging;
> +		}
> +
>   		iter_flags = flags & ~housekeeping.flags;
>   
>   		for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)

I do have a question about this check. Currently isolcpus=domain is bit 
0, managed_irq is bit 1 and nohz_full is bit 2. If manage_irq come first 
followed by nohz_full and then isolcpus=domain. By the time, 
isolcpus=domain is being set, you are comparing its cpumask with that of 
manage_irq, not nohz_full.

Perhaps you can reuse the non_housekeeping_mask for doing the check, e.g.

         cpumask_and(non_housekeeping_mask, cpu_present_mask, 
housekeeping_staging);
         iter_flags = housekeeping.flags & ~flags;
         for_each_set_bit(type, &iter_flags, HK_TYPE_MAX)
                 cpumask_and(non_housekeeping_mask, 
non_housekeeping_mask, housekeeping.cpumasks[type]);
         if (cpumask_empty(non_housekeeping_mask)) {
                 pr_warn(...

Regards,
Longman


