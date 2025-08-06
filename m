Return-Path: <linux-kernel+bounces-758147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4EDB1CB9C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:05:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14C2D62789B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06421B960;
	Wed,  6 Aug 2025 18:05:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D671990A7
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754503514; cv=none; b=rJmsp3qdP2gn8DFD/e/143hhTV5QuKUGbhRuSA1mJ3xrqp5q8vxwXpesRCTrNtIozC2C08TeM3lQBTnIIYKua1k52aKoT/tYlo5wvhuZsW5CDdW3nbiAXoBwO5VifOUyLDjB1VXDPT0s1vebN0priXYbux/YTRqfQlKw+LKCRsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754503514; c=relaxed/simple;
	bh=0odYW7NrJf/7bf5B9VU2KsGbVt4XzOOmDlQQWtZXDFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lc41MT74ngTMQjQR296YVGgi91NZBUM2dPDL+Ow0w5nmYxPQRgmtyyW6Fr4Se73muW6QRV+6WG+8xU6fSjgxcQ//UjtYo6DKO0AbDgIddZqweBVHuqIXR1egnc1n25sAHz99LON+lXu+QsMBuYLNbGRkdhisDpKKtNY4drAb1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071A6176C;
	Wed,  6 Aug 2025 11:05:04 -0700 (PDT)
Received: from [10.1.197.43] (eglon.cambridge.arm.com [10.1.197.43])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDF313F738;
	Wed,  6 Aug 2025 11:05:08 -0700 (PDT)
Message-ID: <8860287d-3f3c-4079-b72a-63e8569e8f9a@arm.com>
Date: Wed, 6 Aug 2025 19:05:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/36] arm_mpam: Add MPAM MSC register layout
 definitions
To: Ben Horgan <ben.horgan@arm.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh@kernel.org>, Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-17-james.morse@arm.com>
 <45acead9-d734-42b2-a1cc-a565dbf5fe60@arm.com>
Content-Language: en-GB
From: James Morse <james.morse@arm.com>
In-Reply-To: <45acead9-d734-42b2-a1cc-a565dbf5fe60@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Ben,

On 24/07/2025 15:02, Ben Horgan wrote:
> On 11/07/2025 19:36, James Morse wrote:
>> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
>> (MSCs) with an identity/configuration page.
>>
>> Add the definitions for these registers as offset within the page(s).

>> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/
>> mpam_internal.h
>> index d49bb884b433..9110c171d9d2 100644
>> --- a/drivers/platform/arm64/mpam/mpam_internal.h
>> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
>> @@ -150,4 +150,272 @@ extern struct list_head mpam_classes;
>>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>>                      cpumask_t *affinity);
>>   +/*
>> + * MPAM MSCs have the following register layout. See:
>> + * Arm Architecture Reference Manual Supplement - Memory System Resource
>> + * Partitioning and Monitoring (MPAM), for Armv8-A. DDI 0598A.a

> I've been checking this against https://developer.arm.com/documentation/ihi0099/latest/ as
> that looks to be the current document although hopefully the contents are non-
> contradictory.

Yeah, A.a was the first release, they then split that document up and the CPU half got
consumed by the arm-arm. (pacman, but in pdf form).
I've updated this comment to point to the more modern 'system component specification',
aka "all the mmio stuff".


>> +/* MPAMF_IDR - MPAM features ID register */
>> +#define MPAMF_IDR_PARTID_MAX            GENMASK(15, 0)
>> +#define MPAMF_IDR_PMG_MAX               GENMASK(23, 16)
>> +#define MPAMF_IDR_HAS_CCAP_PART         BIT(24)
>> +#define MPAMF_IDR_HAS_CPOR_PART         BIT(25)
>> +#define MPAMF_IDR_HAS_MBW_PART          BIT(26)
>> +#define MPAMF_IDR_HAS_PRI_PART          BIT(27)
>> +#define MPAMF_IDR_HAS_EXT               BIT(28)

> MPAMF_IDR_EXT. The field name is ext rather than has_ext.

Making it the odd one out!
I'll change this in the hope that one day this sort of thing can be generated.


>> +#define MPAMF_IDR_HAS_IMPL_IDR          BIT(29)
>> +#define MPAMF_IDR_HAS_MSMON             BIT(30)
>> +#define MPAMF_IDR_HAS_PARTID_NRW        BIT(31)
>> +#define MPAMF_IDR_HAS_RIS               BIT(32)
>> +#define MPAMF_IDR_HAS_EXT_ESR           BIT(38)

> MPAMF_IDR_HAS_EXTD_ESR. Missing D.

Fixed.


>> +#define MPAMF_IDR_HAS_ESR     BIT(39)
>> +#define MPAMF_IDR_RIS_MAX               GENMASK(59, 56)
>> +
>> +/* MPAMF_MSMON_IDR - MPAM performance monitoring ID register */
>> +#define MPAMF_MSMON_IDR_MSMON_CSU               BIT(16)
>> +#define MPAMF_MSMON_IDR_MSMON_MBWU              BIT(17)
>> +#define MPAMF_MSMON_IDR_HAS_LOCAL_CAPT_EVNT     BIT(31)
>> +
>> +/* MPAMF_CPOR_IDR - MPAM features cache portion partitioning ID register */
>> +#define MPAMF_CPOR_IDR_CPBM_WD                  GENMASK(15, 0)
>> +
>> +/* MPAMF_CCAP_IDR - MPAM features cache capacity partitioning ID register */
>> +#define MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM         BIT(31)
>> +#define MPAMF_CCAP_IDR_NO_CMAX                  BIT(30)
>> +#define MPAMF_CCAP_IDR_HAS_CMIN                 BIT(29)
>> +#define MPAMF_CCAP_IDR_HAS_CASSOC               BIT(28)
>> +#define MPAMF_CCAP_IDR_CASSOC_WD                GENMASK(12, 8)
>> +#define MPAMF_CCAP_IDR_CMAX_WD                  GENMASK(5, 0)

> nit: Field ordering differs from the other registers.

Fixed,

[..]

>> +/* MPAMF_ESR - MPAM Error Status Register */

>> +#define MPAMF_ESR_PARTID_OR_MON GENMASK(15, 0)

Probably a better name but PARTID_MON is in the specification.

Fixed,

[..]

>> +/*
>> + * MSMON_CFG_CSU_CTL - Memory system performance monitor configure cache storage
>> + *                    usage monitor control register
>> + * MSMON_CFG_MBWU_CTL - Memory system performance monitor configure memory
>> + *                     bandwidth usage monitor control register
>> + */
>> +#define MSMON_CFG_x_CTL_TYPE           GENMASK(7, 0)
>> +#define MSMON_CFG_x_CTL_OFLOW_STATUS_L BIT(15)

> No OFLOW_STATUS_L for csu.

You're suggesting there shouldn't be an 'x' in the middle? Sure.

Overflow is nonsense for the CSU 'counters' as they don't count up, so can't overflow.
(and yet they have an overflow status bit!)


>> +#define MSMON_CFG_x_CTL_MATCH_PARTID   BIT(16)
>> +#define MSMON_CFG_x_CTL_MATCH_PMG      BIT(17)
>> +#define MSMON_CFG_x_CTL_SCLEN          BIT(19)

>> +#define MSMON_CFG_x_CTL_SUBTYPE        GENMASK(23, 20)
> GENMASK(22,20)> +#define MSMON_CFG_x_CTL_OFLOW_FRZ      BIT(24)
>> +#define MSMON_CFG_x_CTL_OFLOW_INTR     BIT(25)

(Are you using Outlook?)


>> +#define MSMON_CFG_x_CTL_OFLOW_STATUS   BIT(26)
>> +#define MSMON_CFG_x_CTL_CAPT_RESET     BIT(27)
>> +#define MSMON_CFG_x_CTL_CAPT_EVNT      GENMASK(30, 28)
>> +#define MSMON_CFG_x_CTL_EN             BIT(31)
>> +
>> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU            0x42
>> +#define MSMON_CFG_MBWU_CTL_TYPE_CSU            0x43
>> +
>> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_NONE                 0
>> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_READ                 1
>> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_WRITE                2
>> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_BOTH                 3

> I'm not sure where these come from? SUBTYPE is marked unused in the spec. Remove?> +

Looks like an earlier version of RWBW feature. I'll rip these out.


>> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_MAX                  3
>> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_MASK                 0x3

> Remove for same reason.


>> +
>> +/*
>> + * MSMON_CFG_MBWU_FLT - Memory system performance monitor configure memory
>> + *                     bandwidth usage monitor filter register
>> + */
>> +#define MSMON_CFG_MBWU_FLT_PARTID               GENMASK(15, 0)
>> +#define MSMON_CFG_MBWU_FLT_PMG                  GENMASK(23, 16)
>> +#define MSMON_CFG_MBWU_FLT_RWBW                 GENMASK(31, 30)
>> +
>> +/*
>> + * MSMON_CSU - Memory system performance monitor cache storage usage monitor
>> + *            register
>> + * MSMON_CSU_CAPTURE -  Memory system performance monitor cache storage usage
>> + *                     capture register
>> + * MSMON_MBWU  - Memory system performance monitor memory bandwidth usage
>> + *               monitor register
>> + * MSMON_MBWU_CAPTURE - Memory system performance monitor memory bandwidth usage
>> + *                     capture register
>> + */
>> +#define MSMON___VALUE          GENMASK(30, 0)
>> +#define MSMON___NRDY           BIT(31)
>> +#define MSMON_MBWU_L_VALUE     GENMASK(62, 0)

> This gets renamed in the series. I think all registers layout definitions can be added in
> this commit.

Yup, I've pulled that hunk in. (and spotted there is another)
Adding them all here was the plan. (and there will be a few that don't get used)


Thanks for going through all those!

James

