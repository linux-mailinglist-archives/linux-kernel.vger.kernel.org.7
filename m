Return-Path: <linux-kernel+bounces-759804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 783B1B1E2E3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 776544E2D0D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 07:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1CE22126C;
	Fri,  8 Aug 2025 07:13:41 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB64717AE11
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754637221; cv=none; b=m6R8YJE7hIjsLpvQLZZNSGQ9KPaPTi6q0bZMUSD6jSf+roILdb/gD7ISRroTldiLugM3ANAT+AAIu5jWKyQnWVHPAOqTtJjp3GhUrMyLYfoZcKoCV/P/oj/zMH5mDRYfLihACv5rtpgIk6qK76M0FMPfkujDGnQtTHdRhBgwhds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754637221; c=relaxed/simple;
	bh=dSrlBIDohcelleUlg+dNJ2zb61ibqX3uyLoA9OK82do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gs8UGPqMRbHDPkkXzB94Q8JYpVNowj+SOm87rACBVN6gsRgyYzt1rDz2AVy5gFicbrYQiW0+qCixadgzQfzMfAtDetfxjlJAwfMIMnOkXTFnF0Rv0sD5/j7bl23x0lMFAVfbaOVx/Aks3JCUpJY7w48Jn5bNNWJ+HlEcsOo+emE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 142CE16F8;
	Fri,  8 Aug 2025 00:13:30 -0700 (PDT)
Received: from [10.57.5.99] (unknown [10.57.5.99])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E1C53F673;
	Fri,  8 Aug 2025 00:13:32 -0700 (PDT)
Message-ID: <563d88c1-a598-451d-a3ad-437d91d68f1b@arm.com>
Date: Fri, 8 Aug 2025 08:13:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 27/36] arm_mpam: Allow configuration to be applied and
 restored during cpu online
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Ben Horgan <ben.horgan@arm.com>,
 Rohit Mathew <rohit.mathew@arm.com>,
 Shanker Donthineni <sdonthineni@nvidia.com>, Zeng Heng
 <zengheng4@huawei.com>, Lecopzer Chen <lecopzerc@nvidia.com>,
 Carl Worth <carl@os.amperecomputing.com>,
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 "lcherian@marvell.com" <lcherian@marvell.com>,
 "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
 "baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
 "peternewman@google.com" <peternewman@google.com>,
 "dfustini@baylibre.com" <dfustini@baylibre.com>,
 "amitsinght@marvell.com" <amitsinght@marvell.com>,
 David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>,
 Dave Martin <dave.martin@arm.com>, Koba Ko <kobak@nvidia.com>
References: <20250711183648.30766-1-james.morse@arm.com>
 <20250711183648.30766-28-james.morse@arm.com>
 <OSZPR01MB8798812D121619E9BB9BDF2A8B56A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Language: en-US
From: James Morse <james.morse@arm.com>
In-Reply-To: <OSZPR01MB8798812D121619E9BB9BDF2A8B56A@OSZPR01MB8798.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Shaopeng,

On 16/07/2025 07:49, Shaopeng Tan (Fujitsu) wrote:
>> When CPUs come online the original configuration should be restored.
>> Once the maximum partid is known, allocate an configuration array for each
>> component, and reprogram each RIS configuration from this.
>>
>> The MPAM spec describes how multiple controls can interact. To prevent this
>> happening by accident, always reset controls that don't have a valid
>> configuration. This allows the same helper to be used for configuration and
>> reset.
>> diff --git a/drivers/platform/arm64/mpam/mpam_devices.c
>> b/drivers/platform/arm64/mpam/mpam_devices.c
>> index bb3695eb84e9..f3ecfda265d2 100644
>> --- a/drivers/platform/arm64/mpam/mpam_devices.c
>> +++ b/drivers/platform/arm64/mpam/mpam_devices.c

>> @@ -909,51 +913,90 @@ static void mpam_reset_msc_bitmap(struct
>> mpam_msc *msc, u16 reg, u16 wd)
>>  		__mpam_write_reg(msc, reg, bm);
>>  }
>>
>> -static void mpam_reset_ris_partid(struct mpam_msc_ris *ris, u16 partid)
>> +/* Called via IPI. Call while holding an SRCU reference */ static void
>> +mpam_reprogram_ris_partid(struct mpam_msc_ris *ris, u16 partid,
>> +				      struct mpam_config *cfg)
>>  {
>>  	u16 bwa_fract = MPAMCFG_MBW_MAX_MAX;
>>  	struct mpam_msc *msc = ris->vmsc->msc;
>>  	struct mpam_props *rprops = &ris->props;
>>
>> -	mpam_assert_srcu_read_lock_held();
>> -
>>  	mutex_lock(&msc->part_sel_lock);
>>  	__mpam_part_sel(ris->ris_idx, partid, msc);
>>
>> -	if (mpam_has_feature(mpam_feat_cpor_part, rprops))
>> -		mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
>> rprops->cpbm_wd);
>> +	if (mpam_has_feature(mpam_feat_cpor_part, rprops)) {
>> +		if (mpam_has_feature(mpam_feat_cpor_part, cfg))
>> +			mpam_write_partsel_reg(msc, CPBM, cfg->cpbm);
>> +		else
>> +			mpam_reset_msc_bitmap(msc, MPAMCFG_CPBM,
>> +					      rprops->cpbm_wd);
>> +	}
>>
>> -	if (mpam_has_feature(mpam_feat_mbw_part, rprops))
>> -		mpam_reset_msc_bitmap(msc, MPAMCFG_MBW_PBM,
>> rprops->mbw_pbm_bits);
>> +	if (mpam_has_feature(mpam_feat_mbw_part, rprops)) {
>> +		if (mpam_has_feature(mpam_feat_mbw_part, cfg))
>> +			mpam_write_partsel_reg(msc, MBW_PBM,
>> cfg->mbw_pbm);
>> +		else
>> +			mpam_reset_msc_bitmap(msc,
>> MPAMCFG_MBW_PBM,
>> +					      rprops->mbw_pbm_bits);
>> +	}
>>
>>  	if (mpam_has_feature(mpam_feat_mbw_min, rprops))
>>  		mpam_write_partsel_reg(msc, MBW_MIN, 0);
>>
>> -	if (mpam_has_feature(mpam_feat_mbw_max, rprops))
>> -		mpam_write_partsel_reg(msc, MBW_MAX, bwa_fract);
>> +	if (mpam_has_feature(mpam_feat_mbw_max, rprops)) {
>> +		if (mpam_has_feature(mpam_feat_mbw_max, cfg))
>> +			mpam_write_partsel_reg(msc, MBW_MAX,
>> cfg->mbw_max);
>> +		else
>> +			mpam_write_partsel_reg(msc, MBW_MAX,
>> bwa_fract);
>> +	}

> 0 was written to MPAMCFG_MBW_MAX. [HARDLIM].
> Depending on the chip, if [HARDLIM] is set to 1 by default, it will be overwritten.

Hardlimit was shoe-horned into the architecture as a backward-compatible thing. It's not too
surprising it gets stamped on here - it was previously RES0. Again, the architecture doesn't
say what the reset value of the register is - generally you can't rely on bits being preserved
if the OS doesn't know what they are.

For the full picture - we don't have a way of getting a hard-limit hint from resctrl. Currently
its just ignored as the behaviour will then be 'the same' on platforms that do or don't have
hardlimit. If we add something like that to the user-space interface - then we can plumb it in.
Enabling it on platforms that have it now will make that a murky picture as the 'old' behaviour
would need to be preserved.

Yes, mpam_devices.c should give its callers a way of setting hardlim - but today resctrl can't.



Thanks,

James

