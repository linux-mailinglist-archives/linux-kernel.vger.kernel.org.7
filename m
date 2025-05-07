Return-Path: <linux-kernel+bounces-637166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A05AAD58C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 07:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B09F07AD2AD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 May 2025 05:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1FA1F8676;
	Wed,  7 May 2025 05:55:56 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599FE1E7C3B
	for <linux-kernel@vger.kernel.org>; Wed,  7 May 2025 05:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746597356; cv=none; b=kq94uHFtFKG43YIDVKEy2vuTuot/QIiDMAnkLzT6vgM0tmXMJSgk/ZUGRSVpI9JFEEot2Usps4hSY3DoB4Qszhul7g04+NDMTNe1yULJ0+QpWy4g7JK24hp4vg/vImaOI+cDIl1Wkcux1avP7HCjmKtI1hLkHo4Va8lqNwRsFRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746597356; c=relaxed/simple;
	bh=XuiAf506Fax0XyampY/Ivi4BEdeVl6Y6hgJ58wAbgvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XMrtdsq1PjlZnTETSsVUaKFrFBKDm6dq9AmIZ2DrTZNhcDFnNFXjNDUtcBWxdGLgs+UCoji/KEJ/7kq/yosm1U/U0kCTwE6Oq1axAtfLh+6s2zSACU3uBkFiP7yBfTLzEeXkWgKRUGUfD3wBe+rl4hJ4nCdOoZGRNfFA0e1CSxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 72D9A2F;
	Tue,  6 May 2025 22:55:40 -0700 (PDT)
Received: from [192.168.0.12] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9C4983F5A1;
	Tue,  6 May 2025 22:55:45 -0700 (PDT)
Message-ID: <eee538cf-d1ce-4444-97f4-450e4604f1ff@arm.com>
Date: Wed, 7 May 2025 11:25:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] coresight: Avoid enable programming clock
 duplicately
To: Leo Yan <leo.yan@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20250423151726.372561-1-leo.yan@arm.com>
 <20250423151726.372561-7-leo.yan@arm.com>
 <063577a4-1530-4658-9838-934b0606e8e0@arm.com>
 <20250506091841.GA177796@e132581.arm.com>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20250506091841.GA177796@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/6/25 14:48, Leo Yan wrote:
> Hi Anshuman,
> 
> On Fri, May 02, 2025 at 12:08:55PM +0530, Anshuman Khandual wrote:
>> On 4/23/25 20:47, Leo Yan wrote:
>>> The programming clock is enabled by AMBA bus driver before a dynamic
>>> probe.  As a result, a CoreSight driver may redundantly enable the same
>>> clock.
>>
>> Are you sure AMBA bus driver always enables such clocks in all scenarios ?
> 
> Yes.  I confirmed that AMBA bus driver enables the programming clock
> prior to calling CoreSight device's probes (see amba_probe()).
> 
> I checked other AMBA device drivers (e.g., drivers/dma/amba-pl08x.c)
> never touch APB programming clock and the clock by default is covered
> by AMAB bus driver.

Alright.

> 
>> Even if that is true - why cannot coresight_get_enable_apb_pclk() ensured
>> to be called only for the platform drivers cases via code re-organization,
>> rather than changing the coresight_get_enable_apb_pclk() helper itself.
> 
> The purpose is to unify the clock enabling for both static probe and
> dynamic (AMBA) probe.
> 
> Let us take funnel driver as an example.  With the change in this patch,
> the clock operations will be consolidated in a central place
> (e.g., funnel_probe()).  Therefore, we can avoid to spread the drvdata
> allocation and clock operations into dynamic probe and static (platform)
> probe separately.
> 
>   funnel_probe()
>   {
>       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> 
>       drvdata->pclk = coresight_get_enable_apb_pclk();
>   }
> 
>   dynamic_funnel_probe()
>   {
>       funnel_probe();
>   }
> 
>   funnel_platform_probe()
>   {
>       funnel_probe();
>   }

Makes sense.

> 
> Thanks,
> Leo
> 
>>> To avoid this, add a check for device type and skip enabling the
>>> programming clock for AMBA devices.  The returned NULL pointer will be
>>> tolerated by the drivers.
>>>
>>> Fixes: 73d779a03a76 ("coresight: etm4x: Change etm4_platform_driver driver for MMIO devices")
>>> Signed-off-by: Leo Yan <leo.yan@arm.com>
>>> ---
>>>  include/linux/coresight.h | 11 +++++++----
>>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>> index b888f6ed59b2..26eb4a61b992 100644
>>> --- a/include/linux/coresight.h
>>> +++ b/include/linux/coresight.h
>>> @@ -476,15 +476,18 @@ static inline bool is_coresight_device(void __iomem *base)
>>>   * Returns:
>>>   *
>>>   * clk   - Clock is found and enabled
>>> + * NULL  - Clock is not needed as it is managed by the AMBA bus driver
>>>   * ERROR - Clock is found but failed to enable
>>>   */
>>>  static inline struct clk *coresight_get_enable_apb_pclk(struct device *dev)
>>>  {
>>> -	struct clk *pclk;
>>> +	struct clk *pclk = NULL;
>>>  
>>> -	pclk = devm_clk_get_enabled(dev, "apb_pclk");
>>> -	if (IS_ERR(pclk))
>>> -		pclk = devm_clk_get_enabled(dev, "apb");
>>> +	if (!dev_is_amba(dev)) {
>>> +		pclk = devm_clk_get_enabled(dev, "apb_pclk");
>>> +		if (IS_ERR(pclk))
>>> +			pclk = devm_clk_get_enabled(dev, "apb");
>>> +	}
>>>  
>>>  	return pclk;
>>>  }

