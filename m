Return-Path: <linux-kernel+bounces-749387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F059B14DAA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C650754519D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 12:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88672741CE;
	Tue, 29 Jul 2025 12:30:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74155156CA
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753792235; cv=none; b=UHg8gXqU8pS9nYgzYLaGit9pW5gWrklVN4tIRJ4Cr7xl6N6R5CbQNs5nBGGb9pFc7wcuY7kY8NC5Bbr06B9tFmq34+FTtef1yb94tAbIXjDSa7mJ90xUPcdGUneCsDc2StCpY4arX5hQk2JnoH5UEbOn+/HWZewnxvDYY2ic4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753792235; c=relaxed/simple;
	bh=9vb4V+SmHdhBB1ciIih+ObKeJ6ZbJVKQrUlwx3xtQQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fhUp9GuxclQceVhBjm4AQ3SVJBhPjYcZjr1p2R0mp3Gqcwhh2kPQWeQUIFD7jytcTLdSpCUrhLUoXLEdQingGvBdTkRkzQIAVBxcATKPt3xlt8B4fM86J7Di4V4PAxmKXiH9HAsTaAhuyqRt5mw8Q3OFnXUkaQaFWaYfDYNdPz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E72C1516;
	Tue, 29 Jul 2025 05:30:23 -0700 (PDT)
Received: from [10.57.3.117] (unknown [10.57.3.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E11703F673;
	Tue, 29 Jul 2025 05:30:29 -0700 (PDT)
Message-ID: <15370a42-8e92-4f57-9ff2-f283d9fd30bd@arm.com>
Date: Tue, 29 Jul 2025 13:30:28 +0100
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
To: Mark Brown <broonie@kernel.org>, Leo Yan <leo.yan@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Yeoreum Yun <yeoreum.yun@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250724-arm_cs_fix_clock_v4-v5-0-63f648dae021@arm.com>
 <20250724-arm_cs_fix_clock_v4-v5-4-63f648dae021@arm.com>
 <b3782b8f-8c09-4fb8-bec6-186102cc66a8@sirena.org.uk>
 <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <f9fb2174-5bc5-4c7b-b74b-8542b4f7cbe0@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/07/2025 12:31, Mark Brown wrote:
> On Mon, Jul 28, 2025 at 05:45:04PM +0100, Mark Brown wrote:
>> On Thu, Jul 24, 2025 at 04:22:34PM +0100, Leo Yan wrote:
>>
>> Previously we would return NULL for any error (which isn't super great
>> for deferred probe but never mind).
>>
>>> +	pclk = devm_clk_get_enabled(dev, "apb_pclk");
>>> +	if (IS_ERR(pclk))
>>> +		pclk = devm_clk_get_enabled(dev, "apb");
>>
>> ...
>>
>>>   	return pclk;
>>>   }
>>
>> Now we pass errors back to the caller, making missing clocks fatal.
> 
> Thinking about this some more I think for compatiblity these clocks need
> to be treated as optional - that's what the original code was
> effectively doing, and I can imagine this isn't the only SoC which has
> (hopefully) always on clocks and didn't wire things up in DT.

You're right. The static components (funnels, replicators) don't have
APB programming interface and hence no clocks. That said, may be the
"is amba device" check could be used to enforce the presence of a clock.

I will let Leo sort this out

Suzuki

