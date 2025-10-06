Return-Path: <linux-kernel+bounces-843588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94F30BBFC83
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 01:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D6963BEBD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 23:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA4F208994;
	Mon,  6 Oct 2025 23:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxoFQz1a"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4041A2547
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759793175; cv=none; b=EaURVPd+gun/p5J2hdWYCfkLgYHtiwTOkbFRB4A3R6j1XH4SbU0Eb9iEQ+nUnZLjrMWHZq9cp410dKS9331Wl10MNLMgsNMDJnPDfvxvy9w51wCP5bPhAmDNFPn/jrF7bvLtbY68H5rkEDJxgIaFsvV85aKp+KbOwehOqr7t3ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759793175; c=relaxed/simple;
	bh=cUxTi5HF8VOvBv7tRC5vMBxPjQKykV1ubt5L5qkzgiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OX8F4G+83hb+bcYlbymy8RSnEPk4pvyvBwZuPXgk10QwSYuwXnRzSVCM6XRtn40HfDYh1do26lT/uQkh6SvCu8uVf9LfyGVQg6X26h9A7zN+1Ojj5wp48UNz4+m2QHzVxGfmnR2B5D6P38jSKslS/f7ptT2hlCcwOuMw0JNbcAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxoFQz1a; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759793171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NyB/2Pk5wijagVYBD6/smx6bBOT8c4NVWW3i8n/rIkA=;
	b=SxoFQz1aRlv7/99mogA+lNCh8OCkqOOf2oOeTJdcnxqBgTB0xQQy6VO9nL4E96UXFogbPX
	KF9kNin9bFVVmcPYbuHCDJ7vj1RTvB33zR7Gu+jSB3skgBXhp7u94GflgT7Y0vf+rP9QhM
	cIhQOVywQZF27QZuiKJrWdTTstJL3aI=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-jA42I1BwNpe9516Y5QqSfw-1; Mon, 06 Oct 2025 19:26:10 -0400
X-MC-Unique: jA42I1BwNpe9516Y5QqSfw-1
X-Mimecast-MFC-AGG-ID: jA42I1BwNpe9516Y5QqSfw_1759793168
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32eb864fe90so7541053a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 16:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759793167; x=1760397967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyB/2Pk5wijagVYBD6/smx6bBOT8c4NVWW3i8n/rIkA=;
        b=MHsq/BQDvmOiJiuvPVN5HCTnKYJa/x0T9VRIpGIWg3+cDzTo8IYPRIYZHm20eySrkc
         haxo/unDZdOu9E8drMPwXiTr9NBLAzumaAT2EhAU+sumKO+s/VdwNjF0Od0dJ+oGIE3Y
         8ZgqaYJ9XVbFT4Qe9giHvOE3DlqfSWyrTR4YKd/OovqjwVnl+g9Czk5bTHMJPAtjaaaq
         dutDHdbOnNY3HhKuH3VWnZQY6b1j4AoWLegbMEAhGgZ52H6VbgpsiGk5/CUkC7iG25Nw
         7ejzlBGwaMl94PkIWKJbknW23BCgDP9+zgBB9J60+fU/T7sv6eMgV6tzvS5UE2aXCoQv
         G1IA==
X-Forwarded-Encrypted: i=1; AJvYcCX47hUgccFWRZ0ROZcHsSyen+UNawkuiUtoG0eVebzaS4gIOQyw15F51RCyOOoajesvSlgj3wWuFfVrp9o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOBguyGgL16YS8Q/BbxcnTcCx69FtwnsCrRdwGK1ix0jH9lex/
	yRgwavr84+koGLPKjkWKHwwzy7qFQXxCWMYFgvRoR/r3I2hfucgTTBaTLslE6S6jj1+wd/Q5E+x
	n5uxAatecLo8J0FYpThgQgzct/S5/XE52cRCQAzKFZmewS6jaiTi3yJ1ERli9ZcA1IHqXullcNw
	==
X-Gm-Gg: ASbGncvnWv3ChbVz7WLlTZxuPXWo2trfNgch35XzUcKr3EwyUOKaVsqY9HKYeYxluCe
	ONllZHbLW6Xk1B30tFQ5fpWMBPo6UaCsB1U6msEXdbtrpGsBEWaZCEID4vMiAC+LsQJaG+3DkKX
	ZYMqSBCw3nXYw/8y6QlG/sy90E7eVh5ONTAC0tiTojn708T4OMNhWI7Lv3AiawOzhcuaXb2Q7tU
	wjbwlCZVz7TZ9MTdcX/jn5O7A1udd9RIg0cjWNPPQa+/jSdRkMqjB34kDrD2kHb+ok3WTtkWz0B
	R/bhp29s3KEj/auuoNV8V7A8tV4MRPNqYUDU5NATWpZiTAqYX41A5p01fPMvjO6jmT92Qlxx/up
	fsqQ9MoaApQ==
X-Received: by 2002:a17:90b:4a8c:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-339c27bc475mr17899840a91.29.1759793167291;
        Mon, 06 Oct 2025 16:26:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERIFLl8GkviCDqbLVDIbfSKCg91e+HAkaXDPlbRbY5H7aG5yx3n7cRQWkYPRFuLdo2BGpp1g==
X-Received: by 2002:a17:90b:4a8c:b0:32b:cb05:849a with SMTP id 98e67ed59e1d1-339c27bc475mr17899797a91.29.1759793166872;
        Mon, 06 Oct 2025 16:26:06 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff256dsm17874793a91.16.2025.10.06.16.25.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:26:06 -0700 (PDT)
Message-ID: <92e05ef2-356b-4c1f-99c3-1e7482775cdc@redhat.com>
Date: Tue, 7 Oct 2025 09:25:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/29] arm_mpam: Add MPAM MSC register layout
 definitions
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org
Cc: D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Dave Martin <dave.martin@arm.com>,
 Koba Ko <kobak@nvidia.com>, Shanker Donthineni <sdonthineni@nvidia.com>,
 fenghuay@nvidia.com, baisheng.gao@unisoc.com,
 Jonathan Cameron <jonathan.cameron@huawei.com>, Rob Herring
 <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Rafael Wysocki <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Ben Horgan <ben.horgan@arm.com>
References: <20250910204309.20751-1-james.morse@arm.com>
 <20250910204309.20751-10-james.morse@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20250910204309.20751-10-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 9/11/25 6:42 AM, James Morse wrote:
> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
> 
> Add the definitions for these registers as offset within the page(s).
> 
> Link: https://developer.arm.com/documentation/ihi0099/latest/
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v1:
>   * Whitespace.
>   * Added constants for CASSOC and XCL.
>   * Merged FLT/CTL defines.
>   * Fixed MSMON_CFG_CSU_CTL_TYPE_CSU definition.
> 
> Changes since RFC:
>   * Renamed MSMON_CFG_MBWU_CTL_TYPE_CSU as MSMON_CFG_CSU_CTL_TYPE_CSU
>   * Whitepsace churn.
>   * Cite a more recent document.
>   * Removed some stale feature, fixed some names etc.
> ---
>   drivers/resctrl/mpam_internal.h | 267 ++++++++++++++++++++++++++++++++
>   1 file changed, 267 insertions(+)
> 
> diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
> index 02e9576ece6b..109f03df46c2 100644
> --- a/drivers/resctrl/mpam_internal.h
> +++ b/drivers/resctrl/mpam_internal.h
> @@ -152,4 +152,271 @@ extern struct list_head mpam_classes;
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
> + * Component Specification.
> + * https://developer.arm.com/documentation/ihi0099/latest/
> + */
> +#define MPAM_ARCHITECTURE_V1    0x10
> +
> +/* Memory mapped control pages: */

":" seems unnecessary.

> +/* ID Register offsets in the memory mapped page */
> +#define MPAMF_IDR		0x0000  /* features id register */
> +#define MPAMF_MSMON_IDR		0x0080  /* performance monitoring features */
> +#define MPAMF_IMPL_IDR		0x0028  /* imp-def partitioning */
> +#define MPAMF_CPOR_IDR		0x0030  /* cache-portion partitioning */
> +#define MPAMF_CCAP_IDR		0x0038  /* cache-capacity partitioning */
> +#define MPAMF_MBW_IDR		0x0040  /* mem-bw partitioning */
> +#define MPAMF_PRI_IDR		0x0048  /* priority partitioning */
> +#define MPAMF_CSUMON_IDR	0x0088  /* cache-usage monitor */
> +#define MPAMF_MBWUMON_IDR	0x0090  /* mem-bw usage monitor */
> +#define MPAMF_PARTID_NRW_IDR	0x0050  /* partid-narrowing */
> +#define MPAMF_IIDR		0x0018  /* implementer id register */
> +#define MPAMF_AIDR		0x0020  /* architectural id register */
> +
> +/* Configuration and Status Register offsets in the memory mapped page */
> +#define MPAMCFG_PART_SEL	0x0100  /* partid to configure: */

":" seems unnecessary.

> +#define MPAMCFG_CPBM		0x1000  /* cache-portion config */
> +#define MPAMCFG_CMAX		0x0108  /* cache-capacity config */
> +#define MPAMCFG_CMIN		0x0110  /* cache-capacity config */
> +#define MPAMCFG_CASSOC		0x0118  /* cache-associativity config */
> +#define MPAMCFG_MBW_MIN		0x0200  /* min mem-bw config */
> +#define MPAMCFG_MBW_MAX		0x0208  /* max mem-bw config */
> +#define MPAMCFG_MBW_WINWD	0x0220  /* mem-bw accounting window config */
> +#define MPAMCFG_MBW_PBM		0x2000  /* mem-bw portion bitmap config */
> +#define MPAMCFG_PRI		0x0400  /* priority partitioning config */
> +#define MPAMCFG_MBW_PROP	0x0500  /* mem-bw stride config */
> +#define MPAMCFG_INTPARTID	0x0600  /* partid-narrowing config */
> +

[...]

Thanks,
Gavin


