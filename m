Return-Path: <linux-kernel+bounces-739219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D502B0C37B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA5A188649A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DE12D3ECD;
	Mon, 21 Jul 2025 11:40:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FAA2C375E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098042; cv=none; b=uPaQKwWaDUzcEJD3V2AN8lnhmNWaRXsv2ZehsyZX5THvS0/5ce8cfM2Ee79buR9/yDO8SbDlfpywRWBv2yelj1Sn2mVfQFrpAh9PteoR0mTf7VLxZvfn4XS2NAlMcuVLjYKuR6lGZMrXCO63IzHad6YU5uqvqTqJVCAqkEmW3WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098042; c=relaxed/simple;
	bh=qelmWF1xTMaYUjMsXWHlO7TF7AQn04EJmRk+xOhjksM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=te3tfsV8chX5Q2MqKnyNdenQ52mYuoT66oOfNZaLBpq8fPP2H5V/DBZxEWSMu8wCO6VELx7Fzv+C6aRlEzRXTK3LVMoQku7kYvMLIygy4uoS1WtVZzqpLWYolsK4fDNWFDKRzALBEF4S89rL06RWLMbXvHg+R5GtJi4DPSST7Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6DD54153B;
	Mon, 21 Jul 2025 04:40:34 -0700 (PDT)
Received: from [10.57.30.25] (unknown [10.57.30.25])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 265A13F6A8;
	Mon, 21 Jul 2025 04:40:39 -0700 (PDT)
Message-ID: <607c03a2-267c-46e6-a7fa-e733c1970e60@arm.com>
Date: Mon, 21 Jul 2025 12:40:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] coresight: Appropriately disable programming
 clocks
Content-Language: en-GB
To: Leo Yan <leo.yan@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250627-arm_cs_fix_clock_v4-v4-0-0ce0009c38f8@arm.com>
 <20250627-arm_cs_fix_clock_v4-v4-4-0ce0009c38f8@arm.com>
 <5a5f1355-563d-498a-9dec-3479a257b3e6@arm.com>
 <20250721104834.GC3137075@e132581.arm.com>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20250721104834.GC3137075@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/07/2025 11:48, Leo Yan wrote:
> On Mon, Jul 21, 2025 at 10:15:22AM +0100, Suzuki Kuruppassery Poulose wrote:
> 
> [...]
> 
>>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>>> index 4ac65c68bbf44b98db22c3dad2d83a224ce5278e..dd2b4cc7a2b70cf060a3207548fe80e3824c489f 100644
>>> --- a/include/linux/coresight.h
>>> +++ b/include/linux/coresight.h
>>> @@ -480,26 +480,16 @@ static inline bool is_coresight_device(void __iomem *base)
>>>     * Returns:
>>>     *
>>>     * clk   - Clock is found and enabled
>>> - * NULL  - clock is not found
>>
>> This is still valid, right ?
> 
> No. Since this patch uses devm_clk_get_enabled() to get a clock, if the
> pclk is not found, it returns -ENOENT (see of_parse_clkspec()).
> 
> Only the optional clock APIs (e.g., devm_clk_get_optional_enabled())
> return a NULL pointer instead of -ENOENT when the clock is not found.

This will break ACPI based systems, as we may not have a "pclk" 
described for them. We should be able to tolerate "no pclk"

Suzuki


> 
> Thanks,
> Leo


