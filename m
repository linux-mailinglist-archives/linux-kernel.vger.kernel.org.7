Return-Path: <linux-kernel+bounces-750634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4D2B15F06
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:08:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A268C18C75BA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E90293C45;
	Wed, 30 Jul 2025 11:01:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47C6280312
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873290; cv=none; b=BthkZ+aU9I8oWIcxww0GHGVAEl5QQcrU4wa3sgMZ1/ZAZkU/bi/hxubHTMPCVpR0LlAlacGgb46wUs/SNzHLIEN94nE0Ehhiv2IQ0g5UIvzOOzt68lbeB99/5Dr7hm4REx1b56SVebuB8Jtn/wYbIPgf7udpwsBRGPQbIghIX9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873290; c=relaxed/simple;
	bh=WIHSoj9U5zVplPJU+/BW3aOS3qX5DTcD2U34zANRbns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cyf7araJ1UFtUHY5PaK/NFuf4mAgM3DGt1+x/aRbi59Wpi5jxhyrSOFxQx6vsVKEYG/87Liocq6mMjXLF+wKxck8aiEP5vXz+ViWJpRQmjFi0EL4F21LrBUrUN7SY3bvv2X3kL27uXoCbfcutpXaNWiYk3LMwIgdZbfeYRQHhDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 188D21BC0;
	Wed, 30 Jul 2025 04:01:20 -0700 (PDT)
Received: from [10.57.3.117] (unknown [10.57.3.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 618343F673;
	Wed, 30 Jul 2025 04:01:26 -0700 (PDT)
Message-ID: <cd250adb-61e7-414f-bf17-6cc960e44f7b@arm.com>
Date: Wed, 30 Jul 2025 12:01:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/10] coresight: Appropriately disable programming
 clocks
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>
Cc: Mark Brown <broonie@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
 <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
 <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
 <15370a42-8e92-4f57-9ff2-f283d9fd30bd@arm.com>
 <20250730085637.GB143191@e132581.arm.com>
 <caffdde4-fad4-4462-ba92-84416726a12d@arm.com>
 <20250730105432.GC143191@e132581.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250730105432.GC143191@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/07/2025 11:54, Leo Yan wrote:
> On Wed, Jul 30, 2025 at 10:27:48AM +0100, Suzuki Kuruppassery Poulose wrote:
>> On 30/07/2025 09:56, Leo Yan wrote:
>>> On Tue, Jul 29, 2025 at 01:30:28PM +0100, Suzuki Kuruppassery Poulose wrote:
>>>> On 29/07/2025 12:31, Mark Brown wrote:
>>>>> On Mon, Jul 28, 2025 at 05:45:04PM +0100, Mark Brown wrote:
>>>>>> On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:
>>>>>>
>>>>>> Previously we would return NULL for any error (which isn't super great
>>>>>> for deferred probe but never mind).
>>>>>>
>>>>>>> +	pclk = devm_clk_get_enabled(dev, "apb_pclk");
>>>>>>> +	if (IS_ERR(pclk))
>>>>>>> +		pclk = devm_clk_get_enabled(dev, "apb");
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>>     	return pclk;
>>>>>>>     }
>>>>>>
>>>>>> Now we pass errors back to the caller, making missing clocks fatal.
>>>>>
>>>>> Thinking about this some more I think for compatiblity these clocks need
>>>>> to be treated as optional - that's what the original code was
>>>>> effectively doing, and I can imagine this isn't the only SoC which has
>>>>> (hopefully) always on clocks and didn't wire things up in DT.
>>>>
>>>> You're right. The static components (funnels, replicators) don't have
>>>> APB programming interface and hence no clocks. That said, may be the
>>>> "is amba device" check could be used to enforce the presence of a clock.
>>>
>>> I was wondering how this issue slipped through when I tested it on the
>>> Hikey960 board. The Hikey960 also has one static funnel, but it binds
>>> pclk with the static funnel node. That's why I didn't detect the issue.
>>>
>>> I don't think using optional clock API is right thing, as DT binding
>>> schema claims the pclk is mandatory for dynamic components. My proposal
>>> is to enable the clocks only when IORESOURCE_MEM is available, something
>>> like:
>>>
>>>     if (res) {
>>>         ret = coresight_get_enable_clocks(dev, &drvdata->pclk,
>>>                                           &drvdata->atclk);
>>
>> That may not work, as they may need the ATCLK enabled to
>> push the trace over ATB. They may skip the APB, as there
>> is no programming interface.
> 
> If so, I will use an extra patch to skip pclk enabling for static funnel
> and replicator, as a result, patch 04 will be:
> 
>    if (res) {
>        drvdata->pclk = coresight_get_enable_apb_pclk(dev);
>        if (IS_ERR(drvdata->pclk))
>            return PTR_ERR(drvdata->pclk);
>    }
> 
> Then, when consolidation in patch 07, it will have a code:
> 
>    /* Only enable pclk for a device with I/O resource */
>    ret = coresight_get_enable_clocks(dev, res ? &drvdata->pclk : NULL,
>                                      &drvdata->atclk);

Can we not differentiate the error code in devm_get..() for

  ENOENT (not found) vs Some other failure ?

I would recommend using that and don't force the use of apb_clk/apb
for AMBA devices. If the firmware doesn't specify a clock, but does
specify the CoreSight components, it knows it better.

Suzuki



> 
> This turns out to be the case for both static funnel and replicator
> devices — regardless of whether the DT binding includes "apb_pclk" or
> not, the driver will always skip enabling it. Any concerns?
> 
> Thanks,
> Leo


