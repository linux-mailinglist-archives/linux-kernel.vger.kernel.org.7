Return-Path: <linux-kernel+bounces-744428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5A3FB10CB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 16:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF3A0B04DB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2972D8DBA;
	Thu, 24 Jul 2025 14:03:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579572E36ED
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 14:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753365785; cv=none; b=B9kCQupFXxGk+dp7c+Y3xcOrJk0TBRsr6UluprMUwOsdkXONZGcZU+JV55xsI0oWpvOcvblNa3ieqfuENJxwNRhk/WEuNXpaIYDmNMuSbvQQj67bcRRnx8vUYCSzR4nygC4FG0ZSeiplVxSLfrl6nNd2pY1SzaOahFEXPWYk5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753365785; c=relaxed/simple;
	bh=Lms1F2LL7lXU4Ksry1IIkZGA1UdmGyd6lV4pwPOAU/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kogf+IhMBp0WkaAI2ct1FPO2EBkYBFwoJXeVe724II+NZEePADMnqCVXUlUc/laKMFGfebAYdXHlguVv87iei8jFotOlR88xLlMH6EbPaDvSJ3vNi+Pt1pYjljFjBg0ZrstRHZ2X3v/pd24Uxjauu1w2SCquXsDt/9zejcOqi08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB21D1A00;
	Thu, 24 Jul 2025 07:02:55 -0700 (PDT)
Received: from [10.57.84.166] (unknown [10.57.84.166])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 01D7E3F66E;
	Thu, 24 Jul 2025 07:02:58 -0700 (PDT)
Message-ID: <45acead9-d734-42b2-a1cc-a565dbf5fe60@arm.com>
Date: Thu, 24 Jul 2025 15:02:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/36] arm_mpam: Add MPAM MSC register layout
 definitions
Content-Language: en-GB
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org,
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
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-17-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

Nit: The file uses a mixture of tabs and spaces.

On 11/07/2025 19:36, James Morse wrote:
> Memory Partitioning and Monitoring (MPAM) has memory mapped devices
> (MSCs) with an identity/configuration page.
> 
> Add the definitions for these registers as offset within the page(s).
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/platform/arm64/mpam/mpam_internal.h | 268 ++++++++++++++++++++
>   1 file changed, 268 insertions(+)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
> index d49bb884b433..9110c171d9d2 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -150,4 +150,272 @@ extern struct list_head mpam_classes;
>   int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   				   cpumask_t *affinity);
>   
> +/*
> + * MPAM MSCs have the following register layout. See:
> + * Arm Architecture Reference Manual Supplement - Memory System Resource
> + * Partitioning and Monitoring (MPAM), for Armv8-A. DDI 0598A.a

I've been checking this against 
https://developer.arm.com/documentation/ihi0099/latest/ as that looks to 
be the current document although hopefully the contents are 
non-contradictory.> + */
> +#define MPAM_ARCHITECTURE_V1    0x10
> +
> +/* Memory mapped control pages: */
> +/* ID Register offsets in the memory mapped page */
> +#define MPAMF_IDR               0x0000  /* features id register */
> +#define MPAMF_MSMON_IDR         0x0080  /* performance monitoring features */
> +#define MPAMF_IMPL_IDR          0x0028  /* imp-def partitioning */
> +#define MPAMF_CPOR_IDR          0x0030  /* cache-portion partitioning */
> +#define MPAMF_CCAP_IDR          0x0038  /* cache-capacity partitioning */
> +#define MPAMF_MBW_IDR           0x0040  /* mem-bw partitioning */
> +#define MPAMF_PRI_IDR           0x0048  /* priority partitioning */
> +#define MPAMF_CSUMON_IDR        0x0088  /* cache-usage monitor */
> +#define MPAMF_MBWUMON_IDR       0x0090  /* mem-bw usage monitor */
> +#define MPAMF_PARTID_NRW_IDR    0x0050  /* partid-narrowing */
> +#define MPAMF_IIDR              0x0018  /* implementer id register */
> +#define MPAMF_AIDR              0x0020  /* architectural id register */
> +
> +/* Configuration and Status Register offsets in the memory mapped page */
> +#define MPAMCFG_PART_SEL        0x0100  /* partid to configure: */
> +#define MPAMCFG_CPBM            0x1000  /* cache-portion config */
> +#define MPAMCFG_CMAX            0x0108  /* cache-capacity config */
> +#define MPAMCFG_CMIN            0x0110  /* cache-capacity config */
> +#define MPAMCFG_MBW_MIN         0x0200  /* min mem-bw config */
> +#define MPAMCFG_MBW_MAX         0x0208  /* max mem-bw config */
> +#define MPAMCFG_MBW_WINWD       0x0220  /* mem-bw accounting window config */
> +#define MPAMCFG_MBW_PBM         0x2000  /* mem-bw portion bitmap config */
> +#define MPAMCFG_PRI             0x0400  /* priority partitioning config */
> +#define MPAMCFG_MBW_PROP        0x0500  /* mem-bw stride config */
> +#define MPAMCFG_INTPARTID       0x0600  /* partid-narrowing config */
> +
> +#define MSMON_CFG_MON_SEL       0x0800  /* monitor selector */
> +#define MSMON_CFG_CSU_FLT       0x0810  /* cache-usage monitor filter */
> +#define MSMON_CFG_CSU_CTL       0x0818  /* cache-usage monitor config */
> +#define MSMON_CFG_MBWU_FLT      0x0820  /* mem-bw monitor filter */
> +#define MSMON_CFG_MBWU_CTL      0x0828  /* mem-bw monitor config */
> +#define MSMON_CSU               0x0840  /* current cache-usage */
> +#define MSMON_CSU_CAPTURE       0x0848  /* last cache-usage value captured */
> +#define MSMON_MBWU              0x0860  /* current mem-bw usage value */
> +#define MSMON_MBWU_CAPTURE      0x0868  /* last mem-bw value captured */
> +#define MSMON_CAPT_EVNT         0x0808  /* signal a capture event */
> +#define MPAMF_ESR               0x00F8  /* error status register */
> +#define MPAMF_ECR               0x00F0  /* error control register */
> +
> +/* MPAMF_IDR - MPAM features ID register */
> +#define MPAMF_IDR_PARTID_MAX            GENMASK(15, 0)
> +#define MPAMF_IDR_PMG_MAX               GENMASK(23, 16)
> +#define MPAMF_IDR_HAS_CCAP_PART         BIT(24)
> +#define MPAMF_IDR_HAS_CPOR_PART         BIT(25)
> +#define MPAMF_IDR_HAS_MBW_PART          BIT(26)
> +#define MPAMF_IDR_HAS_PRI_PART          BIT(27)
> +#define MPAMF_IDR_HAS_EXT               BIT(28)
MPAMF_IDR_EXT. The field name is ext rather than has_ext. > +#define 
MPAMF_IDR_HAS_IMPL_IDR          BIT(29)
> +#define MPAMF_IDR_HAS_MSMON             BIT(30)
> +#define MPAMF_IDR_HAS_PARTID_NRW        BIT(31)
> +#define MPAMF_IDR_HAS_RIS               BIT(32)
> +#define MPAMF_IDR_HAS_EXT_ESR           BIT(38)
MPAMF_IDR_HAS_EXTD_ESR. Missing D.> +#define MPAMF_IDR_HAS_ESR 
     BIT(39)
> +#define MPAMF_IDR_RIS_MAX               GENMASK(59, 56)
> +
> +/* MPAMF_MSMON_IDR - MPAM performance monitoring ID register */
> +#define MPAMF_MSMON_IDR_MSMON_CSU               BIT(16)
> +#define MPAMF_MSMON_IDR_MSMON_MBWU              BIT(17)
> +#define MPAMF_MSMON_IDR_HAS_LOCAL_CAPT_EVNT     BIT(31)
> +
> +/* MPAMF_CPOR_IDR - MPAM features cache portion partitioning ID register */
> +#define MPAMF_CPOR_IDR_CPBM_WD                  GENMASK(15, 0)
> +
> +/* MPAMF_CCAP_IDR - MPAM features cache capacity partitioning ID register */
> +#define MPAMF_CCAP_IDR_HAS_CMAX_SOFTLIM         BIT(31)
> +#define MPAMF_CCAP_IDR_NO_CMAX                  BIT(30)
> +#define MPAMF_CCAP_IDR_HAS_CMIN                 BIT(29)
> +#define MPAMF_CCAP_IDR_HAS_CASSOC               BIT(28)
> +#define MPAMF_CCAP_IDR_CASSOC_WD                GENMASK(12, 8)
> +#define MPAMF_CCAP_IDR_CMAX_WD                  GENMASK(5, 0)
nit: Field ordering differs from the other registers.> +
> +/* MPAMF_MBW_IDR - MPAM features memory bandwidth partitioning ID register */
> +#define MPAMF_MBW_IDR_BWA_WD            GENMASK(5, 0)
> +#define MPAMF_MBW_IDR_HAS_MIN           BIT(10)
> +#define MPAMF_MBW_IDR_HAS_MAX           BIT(11)
> +#define MPAMF_MBW_IDR_HAS_PBM           BIT(12)
> +#define MPAMF_MBW_IDR_HAS_PROP          BIT(13)
> +#define MPAMF_MBW_IDR_WINDWR            BIT(14)
> +#define MPAMF_MBW_IDR_BWPBM_WD          GENMASK(28, 16)
> +
> +/* MPAMF_PRI_IDR - MPAM features priority partitioning ID register */
> +#define MPAMF_PRI_IDR_HAS_INTPRI        BIT(0)
> +#define MPAMF_PRI_IDR_INTPRI_0_IS_LOW   BIT(1)
> +#define MPAMF_PRI_IDR_INTPRI_WD         GENMASK(9, 4)
> +#define MPAMF_PRI_IDR_HAS_DSPRI         BIT(16)
> +#define MPAMF_PRI_IDR_DSPRI_0_IS_LOW    BIT(17)
> +#define MPAMF_PRI_IDR_DSPRI_WD          GENMASK(25, 20)
> +
> +/* MPAMF_CSUMON_IDR - MPAM cache storage usage monitor ID register */
> +#define MPAMF_CSUMON_IDR_NUM_MON        GENMASK(15, 0)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_CAPT	BIT(24)
> +#define MPAMF_CSUMON_IDR_HAS_CEVNT_OFLW	BIT(25)
> +#define MPAMF_CSUMON_IDR_HAS_OFSR	BIT(26)
> +#define MPAMF_CSUMON_IDR_HAS_OFLOW_LNKG	BIT(27)
> +#define MPAMF_CSUMON_IDR_HAS_XCL	BIT(29)
> +#define MPAMF_CSUMON_IDR_CSU_RO		BIT(30)
> +#define MPAMF_CSUMON_IDR_HAS_CAPTURE    BIT(31)
> +
> +/* MPAMF_MBWUMON_IDR - MPAM memory bandwidth usage monitor ID register */
> +#define MPAMF_MBWUMON_IDR_NUM_MON       GENMASK(15, 0)
> +#define MPAMF_MBWUMON_IDR_HAS_RWBW      BIT(28)
> +#define MPAMF_MBWUMON_IDR_LWD           BIT(29)
> +#define MPAMF_MBWUMON_IDR_HAS_LONG      BIT(30)
> +#define MPAMF_MBWUMON_IDR_HAS_CAPTURE   BIT(31)
> +
> +/* MPAMF_PARTID_NRW_IDR - MPAM PARTID narrowing ID register */
> +#define MPAMF_PARTID_NRW_IDR_INTPARTID_MAX      GENMASK(15, 0)
> +
> +/* MPAMF_IIDR - MPAM implementation ID register */
> +#define MPAMF_IIDR_PRODUCTID    GENMASK(31, 20)
> +#define MPAMF_IIDR_PRODUCTID_SHIFT	20
> +#define MPAMF_IIDR_VARIANT      GENMASK(19, 16)
> +#define MPAMF_IIDR_VARIANT_SHIFT	16
> +#define MPAMF_IIDR_REVISON      GENMASK(15, 12)
> +#define MPAMF_IIDR_REVISON_SHIFT	12
> +#define MPAMF_IIDR_IMPLEMENTER  GENMASK(11, 0)
> +#define MPAMF_IIDR_IMPLEMENTER_SHIFT	0
> +
> +/* MPAMF_AIDR - MPAM architecture ID register */
> +#define MPAMF_AIDR_ARCH_MAJOR_REV       GENMASK(7, 4)
> +#define MPAMF_AIDR_ARCH_MINOR_REV       GENMASK(3, 0)
> +
> +/* MPAMCFG_PART_SEL - MPAM partition configuration selection register */
> +#define MPAMCFG_PART_SEL_PARTID_SEL     GENMASK(15, 0)
> +#define MPAMCFG_PART_SEL_INTERNAL       BIT(16)
> +#define MPAMCFG_PART_SEL_RIS            GENMASK(27, 24)
> +
> +/* MPAMCFG_CMAX - MPAM cache capacity configuration register */
> +#define MPAMCFG_CMAX_SOFTLIM            BIT(31)
> +#define MPAMCFG_CMAX_CMAX               GENMASK(15, 0)
> +
> +/* MPAMCFG_CMIN - MPAM cache capacity configuration register */
> +#define MPAMCFG_CMIN_CMIN               GENMASK(15, 0)
> +
> +/*
> + * MPAMCFG_MBW_MIN - MPAM memory minimum bandwidth partitioning configuration
> + *                   register
> + */
> +#define MPAMCFG_MBW_MIN_MIN             GENMASK(15, 0)
> +
> +/*
> + * MPAMCFG_MBW_MAX - MPAM memory maximum bandwidth partitioning configuration
> + *                   register
> + */
> +#define MPAMCFG_MBW_MAX_MAX             GENMASK(15, 0)
> +#define MPAMCFG_MBW_MAX_HARDLIM         BIT(31)
> +
> +/*
> + * MPAMCFG_MBW_WINWD - MPAM memory bandwidth partitioning window width
> + *                     register
> + */
> +#define MPAMCFG_MBW_WINWD_US_FRAC       GENMASK(7, 0)
> +#define MPAMCFG_MBW_WINWD_US_INT        GENMASK(23, 8)
> +
> +/* MPAMCFG_PRI - MPAM priority partitioning configuration register */
> +#define MPAMCFG_PRI_INTPRI              GENMASK(15, 0)
> +#define MPAMCFG_PRI_DSPRI               GENMASK(31, 16)
> +
> +/*
> + * MPAMCFG_MBW_PROP - Memory bandwidth proportional stride partitioning
> + *                    configuration register
> + */
> +#define MPAMCFG_MBW_PROP_STRIDEM1       GENMASK(15, 0)
> +#define MPAMCFG_MBW_PROP_EN             BIT(31)
> +
> +/*
> + * MPAMCFG_INTPARTID - MPAM internal partition narrowing configuration register
> + */
> +#define MPAMCFG_INTPARTID_INTPARTID     GENMASK(15, 0)
> +#define MPAMCFG_INTPARTID_INTERNAL      BIT(16)
> +
> +/* MSMON_CFG_MON_SEL - Memory system performance monitor selection register */
> +#define MSMON_CFG_MON_SEL_MON_SEL       GENMASK(15, 0)
> +#define MSMON_CFG_MON_SEL_RIS           GENMASK(27, 24)
> +
> +/* MPAMF_ESR - MPAM Error Status Register */
> +#define MPAMF_ESR_PARTID_OR_MON GENMASK(15, 0)Probably a better name but PARTID_MON is in the specification.> +#define 
MPAMF_ESR_PMG           GENMASK(23, 16)
> +#define MPAMF_ESR_ERRCODE       GENMASK(27, 24)
> +#define MPAMF_ESR_OVRWR         BIT(31)
> +#define MPAMF_ESR_RIS           GENMASK(35, 32)
> +
> +/* MPAMF_ECR - MPAM Error Control Register */
> +#define MPAMF_ECR_INTEN         BIT(0)
> +
> +/* Error conditions in accessing memory mapped registers */
> +#define MPAM_ERRCODE_NONE                       0
> +#define MPAM_ERRCODE_PARTID_SEL_RANGE           1
> +#define MPAM_ERRCODE_REQ_PARTID_RANGE           2
> +#define MPAM_ERRCODE_MSMONCFG_ID_RANGE          3
> +#define MPAM_ERRCODE_REQ_PMG_RANGE              4
> +#define MPAM_ERRCODE_MONITOR_RANGE              5
> +#define MPAM_ERRCODE_INTPARTID_RANGE            6
> +#define MPAM_ERRCODE_UNEXPECTED_INTERNAL        7
> +
> +/*
> + * MSMON_CFG_CSU_FLT - Memory system performance monitor configure cache storage
> + *                    usage monitor filter register
> + */
> +#define MSMON_CFG_CSU_FLT_PARTID       GENMASK(15, 0)
> +#define MSMON_CFG_CSU_FLT_PMG          GENMASK(23, 16)
> +
> +/*
> + * MSMON_CFG_CSU_CTL - Memory system performance monitor configure cache storage
> + *                    usage monitor control register
> + * MSMON_CFG_MBWU_CTL - Memory system performance monitor configure memory
> + *                     bandwidth usage monitor control register
> + */
> +#define MSMON_CFG_x_CTL_TYPE           GENMASK(7, 0)
> +#define MSMON_CFG_x_CTL_OFLOW_STATUS_L BIT(15)
No OFLOW_STATUS_L for csu.> +#define MSMON_CFG_x_CTL_MATCH_PARTID   BIT(16)
> +#define MSMON_CFG_x_CTL_MATCH_PMG      BIT(17)
> +#define MSMON_CFG_x_CTL_SCLEN          BIT(19)
> +#define MSMON_CFG_x_CTL_SUBTYPE        GENMASK(23, 20)
GENMASK(22,20)> +#define MSMON_CFG_x_CTL_OFLOW_FRZ      BIT(24)
> +#define MSMON_CFG_x_CTL_OFLOW_INTR     BIT(25)
> +#define MSMON_CFG_x_CTL_OFLOW_STATUS   BIT(26)
> +#define MSMON_CFG_x_CTL_CAPT_RESET     BIT(27)
> +#define MSMON_CFG_x_CTL_CAPT_EVNT      GENMASK(30, 28)
> +#define MSMON_CFG_x_CTL_EN             BIT(31)
> +
> +#define MSMON_CFG_MBWU_CTL_TYPE_MBWU			0x42
> +#define MSMON_CFG_MBWU_CTL_TYPE_CSU			0x43
> +
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_NONE                 0
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_READ                 1
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_WRITE                2
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_BOTH                 3
I'm not sure where these come from? SUBTYPE is marked unused in the 
spec. Remove?> +
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_MAX                  3
> +#define MSMON_CFG_MBWU_CTL_SUBTYPE_MASK                 0x3
Remove for same reason.> +
> +/*
> + * MSMON_CFG_MBWU_FLT - Memory system performance monitor configure memory
> + *                     bandwidth usage monitor filter register
> + */
> +#define MSMON_CFG_MBWU_FLT_PARTID               GENMASK(15, 0)
> +#define MSMON_CFG_MBWU_FLT_PMG                  GENMASK(23, 16)
> +#define MSMON_CFG_MBWU_FLT_RWBW                 GENMASK(31, 30)
> +
> +/*
> + * MSMON_CSU - Memory system performance monitor cache storage usage monitor
> + *            register
> + * MSMON_CSU_CAPTURE -  Memory system performance monitor cache storage usage
> + *                     capture register
> + * MSMON_MBWU  - Memory system performance monitor memory bandwidth usage
> + *               monitor register
> + * MSMON_MBWU_CAPTURE - Memory system performance monitor memory bandwidth usage
> + *                     capture register
> + */
> +#define MSMON___VALUE          GENMASK(30, 0)
> +#define MSMON___NRDY           BIT(31)
> +#define MSMON_MBWU_L_VALUE     GENMASK(62, 0)
This gets renamed in the series. I think all registers layout 
definitions can be added in this commit.> +/*
> + * MSMON_CAPT_EVNT - Memory system performance monitoring capture event
> + *                  generation register
> + */
> +#define MSMON_CAPT_EVNT_NOW    BIT(0)
> +
>   #endif /* MPAM_INTERNAL_H */
Thanks,

Ben


