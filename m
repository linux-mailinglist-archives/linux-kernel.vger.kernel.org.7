Return-Path: <linux-kernel+bounces-581768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E165A764B2
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 13:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634851887DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Mar 2025 11:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2291E0DCB;
	Mon, 31 Mar 2025 11:02:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DE51DF73A
	for <linux-kernel@vger.kernel.org>; Mon, 31 Mar 2025 11:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418959; cv=none; b=UZBVDYY/H9RuFPgbQxTpIvOwLFXiogs4/C4+pr83zDF5yjCoHwDTHxRUONXZXeLjnVfUmNOiRMZCi2y88XNjgAgUwhdoxEcR5c0u98S6Dy3p3q3E9TwsltUKa6RClehISFwDJymxCZwGbtZwQ+ViIiyOax0lot6Dniqw4arwv74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418959; c=relaxed/simple;
	bh=x3pt2GCi759wFRMswPd2uGvtjFdGX/ocM/cmOyk6ZDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkOy/kcb3qNk72W0/4M3oIA8ahGZEw6ayb/EcAAhIj1FPfj4LY8qWXRXG00E/hgbHjRpgSTUNtbaqUarpgh/9h/WBrApBsEkY7rLeMfrdYRMJefMtcfMxcxMBEefzh7SS/Nh5lixP0NeLSbdRtCK8tVyJ4bWeaLX5ZNBCWcrqnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10B6B1F02;
	Mon, 31 Mar 2025 04:02:41 -0700 (PDT)
Received: from [10.57.15.213] (unknown [10.57.15.213])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60DF93F694;
	Mon, 31 Mar 2025 04:02:34 -0700 (PDT)
Message-ID: <c4620199-79da-413f-807d-f99a751c1e43@arm.com>
Date: Mon, 31 Mar 2025 12:02:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/panfrost: Add PM runtime flags
To: Philippe Simons <simons.philippe@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
 =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
References: <20250312232319.25712-1-simons.philippe@gmail.com>
 <20250312232319.25712-2-simons.philippe@gmail.com>
 <20250327123628.3d33c68e@donnerap.manchester.arm.com>
 <d102aa1b-61cf-4dcc-851e-fc56adf9fab8@arm.com>
 <edf101e3-c638-45fa-8f5d-48247b9e0c9d@gmail.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <edf101e3-c638-45fa-8f5d-48247b9e0c9d@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 31/03/2025 11:49, Philippe Simons wrote:
> 
> On 3/31/25 12:32, Steven Price wrote:
>> On 27/03/2025 12:36, Andre Przywara wrote:
>>> On Thu, 13 Mar 2025 00:23:18 +0100
>>> Philippe Simons <simons.philippe@gmail.com> wrote:
>>>
>>> Hi Rob, Boris, Steven,
>>>
>>>> When the GPU is the only device attached to a single power domain,
>>>> core genpd disable and enable it when gpu enter and leave runtime
>>>> suspend.
>>>>
>>>> Some power-domain requires a sequence before disabled,
>>>> and the reverse when enabled.
>>>>
>>>> Add PM flags for CLK and RST, and implement in
>>>> panfrost_device_runtime_suspend/resume.
>>> So some Mali configuration and integration manual I am looking at says
>>> that this sequence should be always observed, as the powerdown sequence
>>> would include disabling the clocks first, then asserting the reset, then
>>> turning the power switches off (and the inverse sequence on powerup).
>>>
>>> So should we make this unconditional, not depending on implementation
>>> specific flags?
>> I think you're right, this probably should be unconditional. My only
>> reservation is that "it works" currently and we'd need to test this
>> doesn't cause regressions on existing platforms. So unless someone with
>> a reasonable board farm is able to do that testing I think this solution
>> is reasonable. So:
> 
> Should I merge both flags together then ? something like GPU_PM_RT ?

Yes, that would probably be a good idea and might simplify things a little.

Thanks,
Steve

>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
>>
>>> And also I am wondering if panfrost_device_init() gets this wrong as
>>> well?
>>> As I see it enabling clock first, then reset, then pm_domain, where it
>>> should be exactly the opposite?
>> I agree, that looks very wrong - the power needs to be enabled before
>> reset is deasserted. I'm somewhat surprised we've got away with that.
>> Fancy writing a patch? ;)
>>
>> Steve
>>
>>> Cheers,
>>> Andre
>>>
>>>> Signed-off-by: Philippe Simons <simons.philippe@gmail.com>
>>>> ---
>>>>   drivers/gpu/drm/panfrost/panfrost_device.c | 37 ++++++++++++++++++
>>>> ++++
>>>>   drivers/gpu/drm/panfrost/panfrost_device.h |  4 +++
>>>>   2 files changed, 41 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/
>>>> gpu/drm/panfrost/panfrost_device.c
>>>> index a45e4addcc19..189ad2ad2b32 100644
>>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
>>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
>>>> @@ -406,11 +406,38 @@ void panfrost_device_reset(struct
>>>> panfrost_device *pfdev)
>>>>   static int panfrost_device_runtime_resume(struct device *dev)
>>>>   {
>>>>       struct panfrost_device *pfdev = dev_get_drvdata(dev);
>>>> +    int ret;
>>>> +
>>>> +    if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT)) {
>>>> +        ret = reset_control_deassert(pfdev->rstc);
>>>> +        if (ret)
>>>> +            return ret;
>>>> +    }
>>>> +
>>>> +    if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS)) {
>>>> +        ret = clk_enable(pfdev->clock);
>>>> +        if (ret)
>>>> +            goto err_clk;
>>>> +
>>>> +        if (pfdev->bus_clock) {
>>>> +            ret = clk_enable(pfdev->bus_clock);
>>>> +            if (ret)
>>>> +                goto err_bus_clk;
>>>> +        }
>>>> +    }
>>>>         panfrost_device_reset(pfdev);
>>>>       panfrost_devfreq_resume(pfdev);
>>>>         return 0;
>>>> +
>>>> +err_bus_clk:
>>>> +    if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS))
>>>> +        clk_disable(pfdev->clock);
>>>> +err_clk:
>>>> +    if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT))
>>>> +        reset_control_assert(pfdev->rstc);
>>>> +    return ret;
>>>>   }
>>>>     static int panfrost_device_runtime_suspend(struct device *dev)
>>>> @@ -426,6 +453,16 @@ static int
>>>> panfrost_device_runtime_suspend(struct device *dev)
>>>>       panfrost_gpu_suspend_irq(pfdev);
>>>>       panfrost_gpu_power_off(pfdev);
>>>>   +    if (pfdev->comp->pm_features & BIT(GPU_PM_RT_CLK_DIS)) {
>>>> +        if (pfdev->bus_clock)
>>>> +            clk_disable(pfdev->bus_clock);
>>>> +
>>>> +        clk_disable(pfdev->clock);
>>>> +    }
>>>> +
>>>> +    if (pfdev->comp->pm_features & BIT(GPU_PM_RT_RST_ASRT))
>>>> +        reset_control_assert(pfdev->rstc);
>>>> +
>>>>       return 0;
>>>>   }
>>>>   diff --git a/drivers/gpu/drm/panfrost/panfrost_device.h b/drivers/
>>>> gpu/drm/panfrost/panfrost_device.h
>>>> index cffcb0ac7c11..f372d4819262 100644
>>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.h
>>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.h
>>>> @@ -36,10 +36,14 @@ enum panfrost_drv_comp_bits {
>>>>    * enum panfrost_gpu_pm - Supported kernel power management features
>>>>    * @GPU_PM_CLK_DIS:  Allow disabling clocks during system suspend
>>>>    * @GPU_PM_VREG_OFF: Allow turning off regulators during system
>>>> suspend
>>>> + * @GPU_PM_RT_CLK_DIS: Allow disabling clocks during system runtime
>>>> suspend
>>>> + * @GPU_PM_RST_ASRT: Allow asserting the reset control during
>>>> runtime suspend
>>>>    */
>>>>   enum panfrost_gpu_pm {
>>>>       GPU_PM_CLK_DIS,
>>>>       GPU_PM_VREG_OFF,
>>>> +    GPU_PM_RT_CLK_DIS,
>>>> +    GPU_PM_RT_RST_ASRT
>>>>   };
>>>>     struct panfrost_features {


