Return-Path: <linux-kernel+bounces-798357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D46B41CDF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC90C174C9A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988A2D47EF;
	Wed,  3 Sep 2025 11:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwythlQV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5432727E3
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898159; cv=none; b=ox7N8/zF80GsCTqQvKRYLSdkJPHR4TzDXunIyqVVnqVccluupq50IymMdDRYBcB67+iyFovpjHyif9PKYD7Ux0J4qYol5LJyUPBXoVTcG3SIEvGybVDJyGjxME+8X7G3E181cdxkd7QhOGGcWO/NcFIB1x+vlionGY21eZfyotI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898159; c=relaxed/simple;
	bh=O5Kl27XB553N7cmeBmXq/uiaTLYFFfTmRY6zD5Qm2IA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ShccA6KdbQVXcw7oJnGz0TI+n0yfO2FmEuUAiljVFUdRk2oJrSegyjaYJokR0qZD1RLvEuxGLV7C+gZjnqxMFZyIm3yO9g8D4BHyGSw2xLMJcGQbH8dDzvZyizLZlId+c+Xqkfc3suqo7BnABdJekfoEMTTNj6a9wknvJ/rmBoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YwythlQV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756898156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVBqAzXRtaGdVaqdIdbidkD/s0lTNKoOEws6COnY9ko=;
	b=YwythlQVxvQcs54IB9cQyVHcXm5eyuNI4507+mzd5drvfaWRPaMOKTLmw+X/HK3nTHchSz
	jsEiPxepjB/9XaDgg9ujIe29NodO6NO22IJgrXKuwjyttwmtya6bNSv7pvrXnxVMl0WJVa
	krtQkNacD4ir+5TVN53RcOotRW8MV9M=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-WB_lj6c-MaqiFE65ntw75A-1; Wed, 03 Sep 2025 07:15:55 -0400
X-MC-Unique: WB_lj6c-MaqiFE65ntw75A-1
X-Mimecast-MFC-AGG-ID: WB_lj6c-MaqiFE65ntw75A_1756898154
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7724ff1200eso2927735b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756898154; x=1757502954;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kVBqAzXRtaGdVaqdIdbidkD/s0lTNKoOEws6COnY9ko=;
        b=jK4vC+sKdMGHl3ZFtHQuM7WKHSulh81EyTXPTIuK/Rrm24wHBuoVpT7RKrnxXaQm0m
         pyE/AFXw/cD+QpqzVWD1yr3ebLyKAb04RNYHohobdRvRc9S3RhLqHxIHgCe0+NUZAKoE
         kUu8oMpvRiD87so3jQdi9xAciQ+y2ydeR9I/HTVm6JsvhjqHxNaFcBkn0t0b3ilILsGc
         yQNgr2sfDt4j0rK493ToUSkpBQJoZu80yqe+la9PdqbOrdzUARq/LZnJN8BLg2KjaH6f
         hCjuTQgkFr6N/vThcxT8NeU+odUBVIowulzB7LFHAjAbUXE+ch7hsHiFuy3f5nQLJdtZ
         buUA==
X-Forwarded-Encrypted: i=1; AJvYcCV+RMMcmc/HjpxBGod9BRAttZKhpF+TCn/iyMVufJBTLUb39bbvXR1t1BcJICFq8Bf8naeUE0ghLdOmiGs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBnag5VqmgFC68OyaQelA5nBpB2scfXg/WljZWZeKQdzyxYCXz
	xXGNTUAwYbZ5wKWwZZKW83ANPSe6OIoTPSK0zK2oiLFNYlLBRA+ZZvui1c8kEMZqIyuznJD4eGQ
	SIbZ76f6lKQktacUOu2nwTH+Qsou17Ik+vX3Hss+7qVmjuqpvifDAnP9wWB40AbB+bw==
X-Gm-Gg: ASbGnct2vCATfZxjboVrMI3gjvz2q/KpxImLBuwfXxQOiVZxHHuw1XVK54rmF0Ue6ed
	rVp23I4WAA3qmok/L216m/Yc2v13bfIX6FYJwar52VBIAbEB9NgnmF5027ajqA7RfAr6U0h6Tpo
	6JO/eXvJiZYwh52fpVR7xmksSC/h+NE/2z+FzkLxQPlkipeOOgYE46YOdU/7UBSbFogwCKqlNCL
	Ct3nsRg131ce2kTk5FAlflJ5VOWCqb9inPwihMsstBd4aaXvRDFgXwLQIqrF2w1TxB/Y5Wg/9Yl
	HeA3zjZCjEIIA1JlRBMYbc6KhceM5X8YyF0GkBOf8jcjqemuq+POwqqzmo3Bqzhyc/nuDOcQn7+
	ARWnq
X-Received: by 2002:a05:6a00:2d13:b0:772:2fad:ff64 with SMTP id d2e1a72fcca58-7723e257daamr16145036b3a.8.1756898154310;
        Wed, 03 Sep 2025 04:15:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEehFXhizd/XBGs6lPLajyy1rp0g+vzzGOhiFu//IuUVahDT7Y1/d6xBov7/G/ROyWBDy0Hlg==
X-Received: by 2002:a05:6a00:2d13:b0:772:2fad:ff64 with SMTP id d2e1a72fcca58-7723e257daamr16144978b3a.8.1756898153626;
        Wed, 03 Sep 2025 04:15:53 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269e9csm16651516b3a.17.2025.09.03.04.15.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 04:15:52 -0700 (PDT)
Message-ID: <0481109b-769f-464b-aa72-ad6e07bdfa78@redhat.com>
Date: Wed, 3 Sep 2025 21:15:43 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 05/43] arm64: RME: Check for RME support at KVM init
To: Steven Price <steven.price@arm.com>, kvm@vger.kernel.org,
 kvmarm@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
 Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
 Oliver Upton <oliver.upton@linux.dev>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Joey Gouly <joey.gouly@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>,
 Christoffer Dall <christoffer.dall@arm.com>, Fuad Tabba <tabba@google.com>,
 linux-coco@lists.linux.dev,
 Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Alper Gun
 <alpergun@google.com>, "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 Emi Kisanuki <fj0570is@fujitsu.com>, Vishal Annapurve <vannapurve@google.com>
References: <20250820145606.180644-1-steven.price@arm.com>
 <20250820145606.180644-6-steven.price@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250820145606.180644-6-steven.price@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/21/25 12:55 AM, Steven Price wrote:
> Query the RMI version number and check if it is a compatible version. A
> static key is also provided to signal that a supported RMM is available.
> 
> Functions are provided to query if a VM or VCPU is a realm (or rec)
> which currently will always return false.
> 
> Later patches make use of struct realm and the states as the ioctls
> interfaces are added to support realm and REC creation and destruction.
> 
> Reviewed-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> Changes since v8:
>   * No need to guard kvm_init_rme() behind 'in_hyp_mode'.
> Changes since v6:
>   * Improved message for an unsupported RMI ABI version.
> Changes since v5:
>   * Reword "unsupported" message from "host supports" to "we want" to
>     clarify that 'we' are the 'host'.
> Changes since v2:
>   * Drop return value from kvm_init_rme(), it was always 0.
>   * Rely on the RMM return value to identify whether the RSI ABI is
>     compatible.
> ---
>   arch/arm64/include/asm/kvm_emulate.h | 18 +++++++++
>   arch/arm64/include/asm/kvm_host.h    |  4 ++
>   arch/arm64/include/asm/kvm_rme.h     | 56 ++++++++++++++++++++++++++++
>   arch/arm64/include/asm/virt.h        |  1 +
>   arch/arm64/kvm/Makefile              |  2 +-
>   arch/arm64/kvm/arm.c                 |  5 +++
>   arch/arm64/kvm/rme.c                 | 56 ++++++++++++++++++++++++++++
>   7 files changed, 141 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/include/asm/kvm_rme.h
>   create mode 100644 arch/arm64/kvm/rme.c
> 

[...]

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 888f7c7abf54..76177c56f1ef 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -40,6 +40,7 @@
>   #include <asm/kvm_nested.h>
>   #include <asm/kvm_pkvm.h>
>   #include <asm/kvm_ptrauth.h>
> +#include <asm/kvm_rme.h>
>   #include <asm/sections.h>
>   

Nit: The header file <asm/kvm_rme.h> has been included to <asm/kvm_host.h> and
<linux/kvm_host.h>, which has been included to arm.c. So this explicit inclusion
can be dropped.

>   #include <kvm/arm_hypercalls.h>
> @@ -59,6 +60,8 @@ enum kvm_wfx_trap_policy {
>   static enum kvm_wfx_trap_policy kvm_wfi_trap_policy __read_mostly = KVM_WFX_NOTRAP_SINGLE_TASK;
>   static enum kvm_wfx_trap_policy kvm_wfe_trap_policy __read_mostly = KVM_WFX_NOTRAP_SINGLE_TASK;
>   
> +DEFINE_STATIC_KEY_FALSE(kvm_rme_is_available);
> +
>   DECLARE_KVM_HYP_PER_CPU(unsigned long, kvm_hyp_vector);
>   
>   DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_base);
> @@ -2836,6 +2839,8 @@ static __init int kvm_arm_init(void)
>   
>   	in_hyp_mode = is_kernel_in_hyp_mode();
>   
> +	kvm_init_rme();
> +
>   	if (cpus_have_final_cap(ARM64_WORKAROUND_DEVICE_LOAD_ACQUIRE) ||
>   	    cpus_have_final_cap(ARM64_WORKAROUND_1508412))
>   		kvm_info("Guests without required CPU erratum workarounds can deadlock system!\n" \
> diff --git a/arch/arm64/kvm/rme.c b/arch/arm64/kvm/rme.c
> new file mode 100644
> index 000000000000..67cf2d94cb2d
> --- /dev/null
> +++ b/arch/arm64/kvm/rme.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2023 ARM Ltd.
> + */
> +
> +#include <linux/kvm_host.h>
> +
> +#include <asm/rmi_cmds.h>
> +#include <asm/virt.h>
> +
> +static int rmi_check_version(void)
> +{
> +	struct arm_smccc_res res;
> +	unsigned short version_major, version_minor;
> +	unsigned long host_version = RMI_ABI_VERSION(RMI_ABI_MAJOR_VERSION,
> +						     RMI_ABI_MINOR_VERSION);
> +
> +	arm_smccc_1_1_invoke(SMC_RMI_VERSION, host_version, &res);
> +
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return -ENXIO;
> +
> +	version_major = RMI_ABI_VERSION_GET_MAJOR(res.a1);
> +	version_minor = RMI_ABI_VERSION_GET_MINOR(res.a1);
> +
> +	if (res.a0 != RMI_SUCCESS) {
> +		unsigned short high_version_major, high_version_minor;
> +
> +		high_version_major = RMI_ABI_VERSION_GET_MAJOR(res.a2);
> +		high_version_minor = RMI_ABI_VERSION_GET_MINOR(res.a2);
> +
> +		kvm_err("Unsupported RMI ABI (v%d.%d - v%d.%d) we want v%d.%d\n",
> +			version_major, version_minor,
> +			high_version_major, high_version_minor,
> +			RMI_ABI_MAJOR_VERSION,
> +			RMI_ABI_MINOR_VERSION);
> +		return -ENXIO;
> +	}
> +
> +	kvm_info("RMI ABI version %d.%d\n", version_major, version_minor);
> +
> +	return 0;
> +}
> +
> +void kvm_init_rme(void)
> +{
> +	if (PAGE_SIZE != SZ_4K)
> +		/* Only 4k page size on the host is supported */
> +		return;

Nit: The comment can be moved before the check, something like below. Otherwise,
{} is needed here.

	/* Only 4kB page size is supported */
	if (PAGE_SIZE != SZ_4K)
		return;

> +
> +	if (rmi_check_version())
> +		/* Continue without realm support */
> +		return;

Nit: same as above.

> +
> +	/* Future patch will enable static branch kvm_rme_is_available */
> +}

Thanks,
Gavin


