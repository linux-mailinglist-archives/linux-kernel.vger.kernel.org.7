Return-Path: <linux-kernel+bounces-748043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0415B13BD5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 15:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E10A3A510A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 13:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE7D26B2DC;
	Mon, 28 Jul 2025 13:46:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292AA26B2D7
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753710368; cv=none; b=ULniAnZx5/QPTigbhbzrL9PyXFju6nOB6fbe9XC0+Ag6HM7cUKM0WvK7BxZKNh4huMxUnNH9HY0owWh3Ha6buW6piyT2s8ZUuIlfmwVCg5xg+cxjTiJkfUyKpQkdHEcxzTZnjwYFHz1pkTnW6FVWTxe95C92Sy8zXvS81NyhM1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753710368; c=relaxed/simple;
	bh=Y2Fpy8QA+6CKKrIZYqKTGBCXOqwMy0KKtJvsSrJ+2y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Gc0dtLb4aurlQezw08Ren5UbeX5lnmPbgq7SqEY0daiMsIufStgC21I7Q9IvdPilASRhYgfWbq1RGHddjda8RBs7wwg7THa3kQLYfSYvihCB75wyfN3KGhDy7RX2u8OlZjEr4I2iw2mGfY2Eb2vgsTU3FaDyk8aTEeXT5YqRYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 70A35153B;
	Mon, 28 Jul 2025 06:45:57 -0700 (PDT)
Received: from [10.1.196.46] (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31E763F66E;
	Mon, 28 Jul 2025 06:46:02 -0700 (PDT)
Message-ID: <b0e5db1b-e4cc-4f11-a81d-40f942eff78d@arm.com>
Date: Mon, 28 Jul 2025 14:46:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 33/36] arm_mpam: Use long MBWU counters if supported
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
 <20250711183648.30766-34-james.morse@arm.com>
Content-Language: en-US
From: Ben Horgan <ben.horgan@arm.com>
In-Reply-To: <20250711183648.30766-34-james.morse@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 7/11/25 19:36, James Morse wrote:
> From: Rohit Mathew <rohit.mathew@arm.com>
> 
> If the 44 bit (long) or 63 bit (LWD) counters are detected on probing
> the RIS, use long/LWD counter instead of the regular 31 bit mbwu
> counter.
> 
> Only 32bit accesses to the MSC are required to be supported by the
> spec, but these registers are 64bits. The lower half may overflow
> into the higher half between two 32bit reads. To avoid this, use
> a helper that reads the top half twice to check for overflow.

Slightly misleading as it may be read up to 4 times.
> 
> Signed-off-by: Rohit Mathew <rohit.mathew@arm.com>
> [morse: merged multiple patches from Rohit]
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   drivers/platform/arm64/mpam/mpam_devices.c  | 89 ++++++++++++++++++---
>   drivers/platform/arm64/mpam/mpam_internal.h |  8 +-
>   2 files changed, 86 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c b/drivers/platform/arm64/mpam/mpam_devices.c
> index 774137a124f8..ace69ac2d0ee 100644
> --- a/drivers/platform/arm64/mpam/mpam_devices.c
> +++ b/drivers/platform/arm64/mpam/mpam_devices.c
> @@ -989,6 +989,48 @@ struct mon_read {
>   	int				err;
>   };
>   
> +static bool mpam_ris_has_mbwu_long_counter(struct mpam_msc_ris *ris)
> +{
> +	return (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props) ||
> +		mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props));
> +}
> +
> +static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
> +{
> +	int retry = 3;
> +	u32 mbwu_l_low;
> +	u64 mbwu_l_high1, mbwu_l_high2;
> +
> +	mpam_mon_sel_lock_held(msc);
> +
> +	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +	do {
> +		mbwu_l_high1 = mbwu_l_high2;
> +		mbwu_l_low = __mpam_read_reg(msc, MSMON_MBWU_L);
> +		mbwu_l_high2 = __mpam_read_reg(msc, MSMON_MBWU_L + 4);
> +
> +		retry--;
> +	} while (mbwu_l_high1 != mbwu_l_high2 && retry > 0);
> +
> +	if (mbwu_l_high1 == mbwu_l_high2)
> +		return (mbwu_l_high1 << 32) | mbwu_l_low;
> +	return MSMON___NRDY_L;
> +}
> +
> +static void mpam_msc_zero_mbwu_l(struct mpam_msc *msc)
> +{
> +	mpam_mon_sel_lock_held(msc);
> +
> +	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
> +	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
> +
> +	__mpam_write_reg(msc, MSMON_MBWU_L, 0);
> +	__mpam_write_reg(msc, MSMON_MBWU_L + 4, 0);
> +}
> +
>   static void gen_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>   				   u32 *flt_val)
>   {
> @@ -1045,6 +1087,7 @@ static void read_msmon_ctl_flt_vals(struct mon_read *m, u32 *ctl_val,
>   static void clean_msmon_ctl_val(u32 *cur_ctl)
>   {
>   	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS;
> +	*cur_ctl &= ~MSMON_CFG_x_CTL_OFLOW_STATUS_L;
>   }
>   
>   static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
> @@ -1067,7 +1110,11 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>   	case mpam_feat_msmon_mbwu:
>   		mpam_write_monsel_reg(msc, CFG_MBWU_FLT, flt_val);
>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val);
> -		mpam_write_monsel_reg(msc, MBWU, 0);
> +		if (mpam_ris_has_mbwu_long_counter(m->ris))
> +			mpam_msc_zero_mbwu_l(m->ris->vmsc->msc);
> +		else
> +			mpam_write_monsel_reg(msc, MBWU, 0);
> +
>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, ctl_val | MSMON_CFG_x_CTL_EN);
>   
>   		mbwu_state = &m->ris->mbwu_state[m->ctx->mon];
> @@ -1082,8 +1129,13 @@ static void write_msmon_ctl_flt_vals(struct mon_read *m, u32 ctl_val,
>   
>   static u64 mpam_msmon_overflow_val(struct mpam_msc_ris *ris)
>   {
> -	/* TODO: scaling, and long counters */
> -	return GENMASK_ULL(30, 0);
> +	/* TODO: implement scaling counters */
> +	if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, &ris->props))
> +		return GENMASK_ULL(62, 0);
> +	else if (mpam_has_feature(mpam_feat_msmon_mbwu_44counter, &ris->props))
> +		return GENMASK_ULL(43, 0);
> +	else
> +		return GENMASK_ULL(30, 0);
>   }
>   
>   /* Call with MSC lock held */
> @@ -1125,10 +1177,24 @@ static void __ris_msmon_read(void *arg)
>   		now = FIELD_GET(MSMON___VALUE, now);
>   		break;
>   	case mpam_feat_msmon_mbwu:
> -		now = mpam_read_monsel_reg(msc, MBWU);
> -		if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> -			nrdy = now & MSMON___NRDY;
> -		now = FIELD_GET(MSMON___VALUE, now);
> +		/*
> +		 * If long or lwd counters are supported, use them, else revert
> +		 * to the 32 bit counter.
> +		 */
32 bit counter -> 31 bit counter
> +		if (mpam_ris_has_mbwu_long_counter(ris)) {
> +			now = mpam_msc_read_mbwu_l(msc);
> +			if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> +				nrdy = now & MSMON___NRDY_L;
> +			if (mpam_has_feature(mpam_feat_msmon_mbwu_63counter, rprops))
> +				now = FIELD_GET(MSMON___LWD_VALUE, now);
> +			else
> +				now = FIELD_GET(MSMON___L_VALUE, now);
> +		} else {
> +			now = mpam_read_monsel_reg(msc, MBWU);
> +			if (mpam_has_feature(mpam_feat_msmon_mbwu_hw_nrdy, rprops))
> +				nrdy = now & MSMON___NRDY;
> +			now = FIELD_GET(MSMON___VALUE, now);
> +		}
>   
>   		if (nrdy)
>   			break;
> @@ -1421,8 +1487,13 @@ static int mpam_save_mbwu_state(void *arg)
>   		cur_ctl = mpam_read_monsel_reg(msc, CFG_MBWU_CTL);
>   		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
>   
> -		val = mpam_read_monsel_reg(msc, MBWU);
> -		mpam_write_monsel_reg(msc, MBWU, 0);
> +		if (mpam_ris_has_mbwu_long_counter(ris)) {
> +			val = mpam_msc_read_mbwu_l(msc);
> +			mpam_msc_zero_mbwu_l(msc);
> +		} else {
> +			val = mpam_read_monsel_reg(msc, MBWU);
> +			mpam_write_monsel_reg(msc, MBWU, 0);
> +		}
>   
>   		cfg->mon = i;
>   		cfg->pmg = FIELD_GET(MSMON_CFG_MBWU_FLT_PMG, cur_flt);
> diff --git a/drivers/platform/arm64/mpam/mpam_internal.h b/drivers/platform/arm64/mpam/mpam_internal.h
> index fc705801c1b6..4553616f2f67 100644
> --- a/drivers/platform/arm64/mpam/mpam_internal.h
> +++ b/drivers/platform/arm64/mpam/mpam_internal.h
> @@ -178,7 +178,6 @@ enum mpam_device_features {
>   	mpam_feat_msmon_csu,
>   	mpam_feat_msmon_csu_capture,
>   	mpam_feat_msmon_csu_hw_nrdy,
> -
>   	/*
>   	 * Having mpam_feat_msmon_mbwu set doesn't mean the regular 31 bit MBWU
>   	 * counter would be used. The exact counter used is decided based on the
> @@ -457,6 +456,8 @@ int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>   #define MSMON_CSU_CAPTURE       0x0848  /* last cache-usage value captured */
>   #define MSMON_MBWU              0x0860  /* current mem-bw usage value */
>   #define MSMON_MBWU_CAPTURE      0x0868  /* last mem-bw value captured */
> +#define MSMON_MBWU_L		0x0880  /* current long mem-bw usage value */
> +#define MSMON_MBWU_CAPTURE_L	0x0890  /* last long mem-bw value captured */
>   #define MSMON_CAPT_EVNT         0x0808  /* signal a capture event */
>   #define MPAMF_ESR               0x00F8  /* error status register */
>   #define MPAMF_ECR               0x00F0  /* error control register */
> @@ -674,7 +675,10 @@ int mpam_get_cpumask_from_cache_id(unsigned long cache_id, u32 cache_level,
>    */
>   #define MSMON___VALUE          GENMASK(30, 0)
>   #define MSMON___NRDY           BIT(31)
> -#define MSMON_MBWU_L_VALUE     GENMASK(62, 0)
> +#define MSMON___NRDY_L		BIT(63)
> +#define MSMON___L_VALUE		GENMASK(43, 0)
> +#define MSMON___LWD_VALUE	GENMASK(62, 0)
> +
As mentioned on an earlier patch. These could be added with all the 
other register definition.
>   /*
>    * MSMON_CAPT_EVNT - Memory system performance monitoring capture event
>    *                  generation register

-- 
Thanks,

Ben


