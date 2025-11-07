Return-Path: <linux-kernel+bounces-890046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE85C3F242
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4725188E340
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB72BDC00;
	Fri,  7 Nov 2025 09:24:38 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065F71EE033
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507477; cv=none; b=QHFz6jUWFumvbLX7ua1iKEnaFg30/cyfq1u3mmJu2zsMor394sFW+dh84FwEOptiJ8LJIzV3nsVNhRG8FUfMwGP4c6ue7vkMdgT6qp84cn7i9akUYxa4Ge1gGvh0hbjPk2CeEQQfmCehYw+roVI12YNzGkc+MSt5bTp80TW8NAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507477; c=relaxed/simple;
	bh=skp9P7Drz50bN4jaSLK+mnXwvhJ7EBjzCtaY6zhs544=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbL7t2ar/vvDCZTC0CAIwYyHVyAUzeOhDzynbWymp6qkxCGxpu8t1pBsBqw5aZFA4t27gtZcvbWnjL/nSO0o5E2cIlTcCPbnHsWpS4WA0gqS7yfB02jy5RKTeMRuPyuAj8MXT1q2B5TnnZNWUTMkSGAf9Uhlfrm/Wi8wtedMlHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13F721007;
	Fri,  7 Nov 2025 01:24:26 -0800 (PST)
Received: from [10.57.72.216] (unknown [10.57.72.216])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B59683F63F;
	Fri,  7 Nov 2025 01:24:31 -0800 (PST)
Message-ID: <93055453-1177-4840-86cf-1a6fc8836470@arm.com>
Date: Fri, 7 Nov 2025 09:24:29 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] drm/panthor: Add arch-specific panthor_hw binding
To: Liviu Dudau <liviu.dudau@arm.com>, Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20251027161334.854650-1-karunika.choo@arm.com>
 <20251027161334.854650-2-karunika.choo@arm.com>
 <aQDsW3xf2NNUvBN-@e110455-lin.cambridge.arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <aQDsW3xf2NNUvBN-@e110455-lin.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 28/10/2025 16:16, Liviu Dudau wrote:
> Hello,
> 
> On Mon, Oct 27, 2025 at 04:13:27PM +0000, Karunika Choo wrote:
>> This patch adds the framework for binding to a specific panthor_hw
>> structure based on the architecture major value parsed from the GPU_ID
>> register. This is in preparation of enabling architecture-specific
>> behaviours based on GPU_ID. As such, it also splits the GPU_ID register
>> read operation into its own helper function.
>>
>> This framework allows a single panthor_hw structure to be shared across
>> multiple architectures should there be minimal changes between them via
>> the arch_min and arch_max field of the panthor_hw_entry structure,
>> instead of duplicating the structure across multiple architectures.
>>
>> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

>> ---
>> v2:
>>  * merged GPU_ID refactoring patch with the arch-specific panthor_hw
>>    binding patch (PATCH 01/10 and PATCH 02/10 in v1).
>> ---
>>  drivers/gpu/drm/panthor/panthor_device.h |  4 ++
>>  drivers/gpu/drm/panthor/panthor_hw.c     | 65 +++++++++++++++++++++++-
>>  drivers/gpu/drm/panthor/panthor_hw.h     |  6 +++
>>  3 files changed, 74 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
>> index a764111359d2..1457c1255f1f 100644
>> --- a/drivers/gpu/drm/panthor/panthor_device.h
>> +++ b/drivers/gpu/drm/panthor/panthor_device.h
>> @@ -26,6 +26,7 @@ struct panthor_device;
>>  struct panthor_gpu;
>>  struct panthor_group_pool;
>>  struct panthor_heap_pool;
>> +struct panthor_hw;
>>  struct panthor_job;
>>  struct panthor_mmu;
>>  struct panthor_fw;
>> @@ -122,6 +123,9 @@ struct panthor_device {
>>  	/** @csif_info: Command stream interface information. */
>>  	struct drm_panthor_csif_info csif_info;
>>
>> +	/** @hw: GPU-specific data. */
>> +	struct panthor_hw *hw;
>> +
>>  	/** @gpu: GPU management data. */
>>  	struct panthor_gpu *gpu;
>>
>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.c b/drivers/gpu/drm/panthor/panthor_hw.c
>> index 4f2858114e5e..b6e7401327c3 100644
>> --- a/drivers/gpu/drm/panthor/panthor_hw.c
>> +++ b/drivers/gpu/drm/panthor/panthor_hw.c
>> @@ -8,6 +8,28 @@
>>  #define GPU_PROD_ID_MAKE(arch_major, prod_major) \
>>  	(((arch_major) << 24) | (prod_major))
>>
>> +/** struct panthor_hw_entry - HW arch major to panthor_hw binding entry */
>> +struct panthor_hw_entry {
>> +	/** @arch_min: Minimum supported architecture major value (inclusive) */
>> +	u8 arch_min;
>> +
>> +	/** @arch_max: Maximum supported architecture major value (inclusive) */
>> +	u8 arch_max;
> 
> I'm not a big fan of this [min, max] range definition. I would expect that,
> unless a new panthor_hw_entry is defined, the one covering arch X will also
> cover arch X+1 automatically. With the current implementation we will have
> to add a patch extending arch_max for an existing panthor_hw_entry when a new
> GPU architecture is released that is compatible with the previous one at the
> panthor_hw level *and backport the patch* for older kernels if they can
> support that hardware.

I see your point, but I'm not sure it's necessarily a good idea for
kernels to pretend to support architectures that haven't been released
yet. Historically we haven't been great at keeping compatibility with
newer hardware and we might otherwise end up backporting patches just to
explicitly break compatibility if we didn't have a max.

Of course you have a much better idea of what's in the pipeline and
whether future GPUs are going to be better at backwards compatiblity...

> My suggestion is to drop this structure entirely and change panthor_hw_bind_device()
> to a cascade of if()s starting with the latest arch to have a struct panthor_hw
> defined. For this patch the function will actually just set ptdev->hw to panthor_hw_arch_v10
> without any ifs.

I'm not a fan of cascades of if()s. If we can express it as a simple
table it will be much easier to read and maintain.

> Also (this is my personal preference) I would merge patch 1/8 and 2/8 so that we
> don't have just empty structures defined.

I'd usually agree, but there's a rename in the following patch which I
think should be kept separate from these changes. So I think you'd still
need a rename patch (panthor_gpu_soft_reset => panthor_hw_soft_reset
etc) separate.

Thanks,
Steve

> Best regards,
> Liviu
> 
>> +
>> +	/** @hwdev: Pointer to panthor_hw structure */
>> +	struct panthor_hw *hwdev;
>> +};
>> +
>> +static struct panthor_hw panthor_hw_arch_v10 = {};
>> +
>> +static struct panthor_hw_entry panthor_hw_match[] = {
>> +	{
>> +		.arch_min = 10,
>> +		.arch_max = 13,
>> +		.hwdev = &panthor_hw_arch_v10,
>> +	},
>> +};
>> +
>>  static char *get_gpu_model_name(struct panthor_device *ptdev)
>>  {
>>  	const u32 gpu_id = ptdev->gpu_info.gpu_id;
>> @@ -62,7 +84,6 @@ static void panthor_gpu_info_init(struct panthor_device *ptdev)
>>  {
>>  	unsigned int i;
>>
>> -	ptdev->gpu_info.gpu_id = gpu_read(ptdev, GPU_ID);
>>  	ptdev->gpu_info.csf_id = gpu_read(ptdev, GPU_CSF_ID);
>>  	ptdev->gpu_info.gpu_rev = gpu_read(ptdev, GPU_REVID);
>>  	ptdev->gpu_info.core_features = gpu_read(ptdev, GPU_CORE_FEATURES);
>> @@ -117,8 +138,50 @@ static void panthor_hw_info_init(struct panthor_device *ptdev)
>>  		 ptdev->gpu_info.tiler_present);
>>  }
>>
>> +static int panthor_hw_bind_device(struct panthor_device *ptdev)
>> +{
>> +	struct panthor_hw *hdev = NULL;
>> +	const u32 arch_major = GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id);
>> +	int i = 0;
>> +
>> +	for (i = 0; i < ARRAY_SIZE(panthor_hw_match); i++) {
>> +		struct panthor_hw_entry *entry = &panthor_hw_match[i];
>> +
>> +		if (arch_major >= entry->arch_min && arch_major <= entry->arch_max) {
>> +			hdev = entry->hwdev;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (!hdev)
>> +		return -EOPNOTSUPP;
>> +
>> +	ptdev->hw = hdev;
>> +
>> +	return 0;
>> +}
>> +
>> +static int panthor_hw_gpu_id_init(struct panthor_device *ptdev)
>> +{
>> +	ptdev->gpu_info.gpu_id = gpu_read(ptdev, GPU_ID);
>> +	if (!ptdev->gpu_info.gpu_id)
>> +		return -ENXIO;
>> +
>> +	return 0;
>> +}
>> +
>>  int panthor_hw_init(struct panthor_device *ptdev)
>>  {
>> +	int ret = 0;
>> +
>> +	ret = panthor_hw_gpu_id_init(ptdev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = panthor_hw_bind_device(ptdev);
>> +	if (ret)
>> +		return ret;
>> +
>>  	panthor_hw_info_init(ptdev);
>>
>>  	return 0;
>> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
>> index 0af6acc6aa6a..39752de3e7ad 100644
>> --- a/drivers/gpu/drm/panthor/panthor_hw.h
>> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
>> @@ -6,6 +6,12 @@
>>
>>  struct panthor_device;
>>
>> +/**
>> + * struct panthor_hw - GPU specific register mapping and functions
>> + */
>> +struct panthor_hw {
>> +};
>> +
>>  int panthor_hw_init(struct panthor_device *ptdev);
>>
>>  #endif /* __PANTHOR_HW_H__ */
>> --
>> 2.49.0
>>
> 


