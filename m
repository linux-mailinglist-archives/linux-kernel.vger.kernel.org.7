Return-Path: <linux-kernel+bounces-744544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C622B10E54
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0786F1CE684E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB12E040C;
	Thu, 24 Jul 2025 15:08:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0ABC2E973A
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753369693; cv=none; b=NdHAslUArqP/uUgTMSYL067UDNeoR9lipTfIAVRek0RWXLQ31vaC7wNEt7NG64fDrHEnYSl02vG/2s0ytsxFdNZlgJRn4zX4dfO3+zJHxyIj5rB33G1vO10s/IPG9LU4ZnbP9aKmQN4lKio1FTt4A6RECcuQj/KiDLd6owpXiSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753369693; c=relaxed/simple;
	bh=hPs7kgn0sqUMrvPXcs+ygRaBmiQ6NUqhgNGpub5d/KI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P8e0Z/oRvlgI8+3ze9M+SKZ93JIP7Lf7oZkwebPo8o5g8viRc+N5iiAYm0Ro8gNRDhQBC750z6RFnwK9fZegOauYn6dx/6jJuoaU8Ov2KMQxHsVIbM+mxY4VEvxnNi7Vpf8yuIyAC9v8EoF5Y4ePpVcx964Ahsprq0TUALfmAAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D1571A00;
	Thu, 24 Jul 2025 08:08:03 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4524E3F6A8;
	Thu, 24 Jul 2025 08:08:06 -0700 (PDT)
Message-ID: <eb8a395c-ca21-43d2-a1f9-739dbdc26dc4@arm.com>
Date: Thu, 24 Jul 2025 16:08:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/36] arm_mpam: Probe the hardware features resctrl
 supports
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
 <20250711183648.30766-21-james.morse@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-21-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/11/25 19:36, James Morse wrote:
> Expand the probing support with the control and monitor types
> we can use with resctrl.
> 
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/platform/arm64/mpam/mpam_devices.c  | 154 +++++++++++++++++++-
>   drivers/platform/arm64/mpam/mpam_internal.h |  53 +++++++
>   2 files changed, 206 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index 8646fb85ad09..61911831ab39 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -102,7 +102,7 @@ static LLIST_HEAD(mpam_garbage);
>   
>   static u32 __mpam_read_reg(struct mpam_msc *msc, u16 reg)
>   {
> -	WARN_ON_ONCE(reg > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
>   	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
>   
>   	return readl_relaxed(msc->mapped_hwpage + reg);
> @@ -131,6 +131,20 @@ static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 va
>   }
>   #define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
>   
> +static inline u32 _mpam_read_monsel_reg(struct mpam_msc *msc, u16 reg)
> +{
> +	mpam_mon_sel_lock_held(msc);
> +	return __mpam_read_reg(msc, reg);
> +}
> +#define mpam_read_monsel_reg(msc, reg) _mpam_read_monsel_reg(msc, MSMON_##reg)
> +
> +static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
> +{
> +	mpam_mon_sel_lock_held(msc);
> +	__mpam_write_reg(msc, reg, val);
> +}
> +#define mpam_write_monsel_reg(msc, reg, val)   _mpam_write_monsel_reg(msc, MSMON_##reg, val)
> +
>   static u64 mpam_msc_read_idr(struct mpam_msc *msc)
>   {
>   	u64 idr_high = 0, idr_low;
> @@ -645,6 +659,137 @@ static struct mpam_msc_ris *mpam_get_or_create_ris(struct mpam_msc *msc,
>   	return found;
>   }
>   
> +/*
> + * IHI009A.a has this nugget: "If a monitor does not support automatic behaviour
> + * of NRDY, software can use this bit for any purpose" - so hardware might not
> + * implement this - but it isn't RES0.
> + *
> + * Try and see what values stick in this bit. If we can write either value,
> + * its probably not implemented by hardware.
> + */
> +#define mpam_ris_hw_probe_hw_nrdy(_ris, _mon_reg, _result)			\
> +do {										\
> +	u32 now;								\
> +	u64 mon_sel;								\
> +	bool can_set, can_clear;						\
> +	struct mpam_msc *_msc = _ris->vmsc->msc;				\
> +										\
> +	if (WARN_ON_ONCE(!mpam_mon_sel_inner_lock(_msc))) {			\
> +		_result = false;						\
> +		break;								\
> +	}									\
> +	mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, 0) |			\
> +		  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, _ris->ris_idx);		\
> +	mpam_write_monsel_reg(_msc, CFG_MON_SEL, mon_sel);			\
> +										\
> +	mpam_write_monsel_reg(_msc, _mon_reg, MSMON___NRDY);			\
> +	now = mpam_read_monsel_reg(_msc, _mon_reg);				\
> +	can_set = now & MSMON___NRDY;						\
> +										\
> +	mpam_write_monsel_reg(_msc, _mon_reg, 0);				\
> +	now = mpam_read_monsel_reg(_msc, _mon_reg);				\
> +	can_clear = !(now & MSMON___NRDY);					\
> +	mpam_mon_sel_inner_unlock(_msc);					\
> +										\
> +	_result = (!can_set || !can_clear);					\
> +} while (0)
It is a bit surprising that something that looks like a function 
modifies a boolean passed by value. Consider continuing the pattern you 
have above:
#define mpam_ris_hw_probe_hw_nrdy(_ris, _mon_reg, _result) 
_mpam_ris_hw_probe_hw_nrdy(_ris, MSMON##_mon_reg, _result)

with signature:
void _mpam_ris_hw_probe_hw_nrdy(struct mpam_msc *msc, u16 reg, bool 
*hw_managed);

and using the _mpam functions from the new _mpam_ris_hw_probe_hw_nrdy().

> +
> +static void mpam_ris_hw_probe(struct mpam_msc_ris *ris)
> +{
> +	int err;
> +	struct mpam_msc *msc = ris->vmsc->msc;
> +	struct mpam_props *props = &ris->props;
> +
> +	lockdep_assert_held(&msc->probe_lock);
> +	lockdep_assert_held(&msc->part_sel_lock);
> +
> +	/* Cache Portion partitioning */
> +	if (FIELD_GET(MPAMF_IDR_HAS_CPOR_PART, ris->idr)) {
> +		u32 cpor_features = mpam_read_partsel_reg(msc, CPOR_IDR);
> +
> +		props->cpbm_wd = FIELD_GET(MPAMF_CPOR_IDR_CPBM_WD, cpor_features);
> +		if (props->cpbm_wd)
> +			mpam_set_feature(mpam_feat_cpor_part, props);
> +	}
> +
> +	/* Memory bandwidth partitioning */
> +	if (FIELD_GET(MPAMF_IDR_HAS_MBW_PART, ris->idr)) {
> +		u32 mbw_features = mpam_read_partsel_reg(msc, MBW_IDR);
> +
> +		/* portion bitmap resolution */
> +		props->mbw_pbm_bits = FIELD_GET(MPAMF_MBW_IDR_BWPBM_WD, mbw_features);
> +		if (props->mbw_pbm_bits &&
> +		    FIELD_GET(MPAMF_MBW_IDR_HAS_PBM, mbw_features))
> +			mpam_set_feature(mpam_feat_mbw_part, props);
> +
> +		props->bwa_wd = FIELD_GET(MPAMF_MBW_IDR_BWA_WD, mbw_features);
> +		if (props->bwa_wd && FIELD_GET(MPAMF_MBW_IDR_HAS_MAX, mbw_features))
> +			mpam_set_feature(mpam_feat_mbw_max, props);
> +	}
> +
> +	/* Performance Monitoring */
> +	if (FIELD_GET(MPAMF_IDR_HAS_MSMON, ris->idr)) {
> +		u32 msmon_features = mpam_read_partsel_reg(msc, MSMON_IDR);
> +
> +		/*
> +		 * If the firmware max-nrdy-us property is missing, the
> +		 * CSU counters can't be used. Should we wait forever?
> +		 */
> +		err = device_property_read_u32(&msc->pdev->dev,
> +					       "arm,not-ready-us",
> +					       &msc->nrdy_usec);
> +
> +		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_CSU, msmon_features)) {
> +			u32 csumonidr;
> +
> +			csumonidr = mpam_read_partsel_reg(msc, CSUMON_IDR);
> +			props->num_csu_mon = FIELD_GET(MPAMF_CSUMON_IDR_NUM_MON, csumonidr);
> +			if (props->num_csu_mon) {
> +				bool hw_managed;
> +
> +				mpam_set_feature(mpam_feat_msmon_csu, props);
> +
> +				/* Is NRDY hardware managed? */
> +				mpam_mon_sel_outer_lock(msc);
> +				mpam_ris_hw_probe_hw_nrdy(ris, CSU, hw_managed);
> +				mpam_mon_sel_outer_unlock(msc);
> +				if (hw_managed)
> +					mpam_set_feature(mpam_feat_msmon_csu_hw_nrdy, props);
> +			}
> +
> +			/*
> +			 * Accept the missing firmware property if NRDY appears
> +			 * un-implemented.
> +			 */
> +			if (err && mpam_has_feature(mpam_feat_msmon_csu_hw_nrdy, props))
> +				pr_err_once("Counters are not usable because not-ready timeout was not provided by firmware.");
> +		}
> +		if (FIELD_GET(MPAMF_MSMON_IDR_MSMON_MBWU, msmon_features)) {
> +			bool hw_managed;
> +			u32 mbwumonidr = mpam_read_partsel_reg(msc, MBWUMON_IDR);
> +
> +			props->num_mbwu_mon = FIELD_GET(MPAMF_MBWUMON_IDR_NUM_MON, mbwumonidr);
> +			if (props->num_mbwu_mon)
> +				mpam_set_feature(mpam_feat_msmon_mbwu, props);
> +
> +			if (FIELD_GET(MPAMF_MBWUMON_IDR_HAS_RWBW, mbwumonidr))
> +				mpam_set_feature(mpam_feat_msmon_mbwu_rwbw, props);
> +
> +			/* Is NRDY hardware managed? */
> +			mpam_mon_sel_outer_lock(msc);
> +			mpam_ris_hw_probe_hw_nrdy(ris, MBWU, hw_managed);
> +			mpam_mon_sel_outer_unlock(msc);
> +			if (hw_managed)
> +				mpam_set_feature(mpam_feat_msmon_mbwu_hw_nrdy, props);
> +
> +			/*
> +			 * Don't warn about any missing firmware property for
> +			 * MBWU NRDY - it doesn't make any sense!
> +			 */
> +		}
> +	}
> +}
> +
>   static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   {
>   	u64 idr;
> @@ -665,6 +810,7 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   
>   	idr = mpam_msc_read_idr(msc);
>   	mutex_unlock(&msc->part_sel_lock);
> +
>   	msc->ris_max = FIELD_GET(MPAMF_IDR_RIS_MAX, idr);
>   
>   	/* Use these values so partid/pmg always starts with a valid value */
> @@ -685,6 +831,12 @@ static int mpam_msc_hw_probe(struct mpam_msc *msc)
>   		ris = mpam_get_or_create_ris(msc, ris_idx);
>   		if (IS_ERR(ris))
>   			return PTR_ERR(ris);
> +		ris->idr = idr;
> +
> +		mutex_lock(&msc->part_sel_lock);
> +		__mpam_part_sel(ris_idx, 0, msc);
> +		mpam_ris_hw_probe(ris);
> +		mutex_unlock(&msc->part_sel_lock);
>   	}
>   
>   	spin_lock(&partid_max_lock);
> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
> index 42a454d5f914..ae6fd1f62cc4 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -136,6 +136,55 @@ static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
>   		lockdep_assert_preemption_enabled();
>   }
>   
> +/*
> + * When we compact the supported features, we don't care what they are.
> + * Storing them as a bitmap makes life easy.
> + */
> +typedef u16 mpam_features_t;
> +
> +/* Bits for mpam_features_t */
> +enum mpam_device_features {
> +	mpam_feat_ccap_part = 0,
> +	mpam_feat_cpor_part,
> +	mpam_feat_mbw_part,
> +	mpam_feat_mbw_min,
> +	mpam_feat_mbw_max,
> +	mpam_feat_mbw_prop,
> +	mpam_feat_msmon,
> +	mpam_feat_msmon_csu,
> +	mpam_feat_msmon_csu_capture,
> +	mpam_feat_msmon_csu_hw_nrdy,
> +	mpam_feat_msmon_mbwu,
> +	mpam_feat_msmon_mbwu_capture,
> +	mpam_feat_msmon_mbwu_rwbw,
> +	mpam_feat_msmon_mbwu_hw_nrdy,
> +	mpam_feat_msmon_capt,
> +	MPAM_FEATURE_LAST,
> +};
> +#define MPAM_ALL_FEATURES      ((1 << MPAM_FEATURE_LAST) - 1)
> +
> +struct mpam_props {
> +	mpam_features_t		features;
> +
> +	u16			cpbm_wd;
> +	u16			mbw_pbm_bits;
> +	u16			bwa_wd;
> +	u16			num_csu_mon;
> +	u16			num_mbwu_mon;
> +};
> +
> +static inline bool mpam_has_feature(enum mpam_device_features feat,
> +				    struct mpam_props *props)
> +{
> +	return (1 << feat) & props->features;
> +}
> +
> +static inline void mpam_set_feature(enum mpam_device_features feat,
> +				    struct mpam_props *props)
> +{
> +	props->features |= (1 << feat);
> +}
> +
>   struct mpam_class {
>   	/* mpam_components in this class */
>   	struct list_head	components;
> @@ -175,6 +224,8 @@ struct mpam_vmsc {
>   	/* mpam_msc_ris in this vmsc */
>   	struct list_head	ris;
>   
> +	struct mpam_props	props;
> +
>   	/* All RIS in this vMSC are members of this MSC */
>   	struct mpam_msc		*msc;
>   
> @@ -186,6 +237,8 @@ struct mpam_vmsc {
>   
>   struct mpam_msc_ris {
>   	u8			ris_idx;
> +	u64			idr;
> +	struct mpam_props	props;
>   
>   	cpumask_t		affinity;
>   

-- 
Thanks,

Ben


