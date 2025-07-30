Return-Path: <linux-kernel+bounces-750460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA16B15B84
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C91B7A7A93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 09:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5CD27144C;
	Wed, 30 Jul 2025 09:27:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84E6270547
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 09:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753867673; cv=none; b=nImVXqVaaK+TCq3fKNvcqi8+hqyiuZvFb5sRh9pHSGg7zrariS8V6UIkPr9Elp638HuY+B61Umnro0AKiA7/ROctYmZzDzBJ7hsekeiN7whVkCvo24G7bG7FIgaa30D5abMPixFvQCc/vPM3s6acYq4ZAf2z+rl1NsPcGJqHsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753867673; c=relaxed/simple;
	bh=c7AIysZNcrfvy35oCEtgXqbLD0jXeTE0uwc0NLXQmWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NyrAXWy9/Sub1mlvo+o2KKMJxGRzBHvkBs1pZsxJ8s0jxPRP1tTSdZ5GUbo+Nk+nwmfByzjoJBCxYvPRlPcehCf9dYtvyKTw88iw2slIZwrteXt1zx9H457/oEsIQb8mBC5XnafAIEP64/waufaz8W9iNvt4RS+ecknEgU0heIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B6FC1BC0;
	Wed, 30 Jul 2025 02:27:43 -0700 (PDT)
Received: from [10.57.3.117] (unknown [10.57.3.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B06933F66E;
	Wed, 30 Jul 2025 02:27:49 -0700 (PDT)
Message-ID: <caffdde4-fad4-4462-ba92-84416726a12d@arm.com>
Date: Wed, 30 Jul 2025 10:27:48 +0100
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
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250730085637.GB143191@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30/07/2025 09:56, Leo Yan wrote:
> On Tue, Jul 29, 2025 at 01:30:28PM +0100, Suzuki Kuruppassery Poulose wrote:
>> On 29/07/2025 12:31, Mark Brown wrote:
>>> On Mon, Jul 28, 2025 at 05:45:04PM +0100, Mark Brown wrote:
>>>> On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:
>>>>
>>>> Previously we would return NULL for any error (which isn't super great
>>>> for deferred probe but never mind).
>>>>
>>>>> +	pclk = devm_clk_get_enabled(dev, "apb_pclk");
>>>>> +	if (IS_ERR(pclk))
>>>>> +		pclk = devm_clk_get_enabled(dev, "apb");
>>>>
>>>> ...
>>>>
>>>>>    	return pclk;
>>>>>    }
>>>>
>>>> Now we pass errors back to the caller, making missing clocks fatal.
>>>
>>> Thinking about this some more I think for compatiblity these clocks need
>>> to be treated as optional - that's what the original code was
>>> effectively doing, and I can imagine this isn't the only SoC which has
>>> (hopefully) always on clocks and didn't wire things up in DT.
>>
>> You're right. The static components (funnels, replicators) don't have
>> APB programming interface and hence no clocks. That said, may be the
>> "is amba device" check could be used to enforce the presence of a clock.
> 
> I was wondering how this issue slipped through when I tested it on the
> Hikey960 board. The Hikey960 also has one static funnel, but it binds
> pclk with the static funnel node. That's why I didn't detect the issue.
> 
> I don't think using optional clock API is right thing, as DT binding
> schema claims the pclk is mandatory for dynamic components. My proposal
> is to enable the clocks only when IORESOURCE_MEM is available, something
> like:
> 
>    if (res) {
>        ret = coresight_get_enable_clocks(dev, &drvdata->pclk,
>                                          &drvdata->atclk);

That may not work, as they may need the ATCLK enabled to
push the trace over ATB. They may skip the APB, as there
is no programming interface.

Suzuki




>        if (ret)
>                return ret;
> 
>        base = devm_ioremap_resource(dev, res);
>        ...
>    }
> 
> The static components don't bind I/O resources, it is naturally not to
> enable clocks for them. Please let me know if this is reasonable
> solution.
> 
> @Mark, thanks a lot for testing and bisection.
> 
> Leo


