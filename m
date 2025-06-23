Return-Path: <linux-kernel+bounces-698279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67CAE3F66
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 14:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C67F37A2117
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 12:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74312475E8;
	Mon, 23 Jun 2025 12:05:39 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6460E24500A;
	Mon, 23 Jun 2025 12:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750680339; cv=none; b=UxKCIOcLdo++HOcuRXDNIwSJhFj+DMabsD86VOpfZHVWpzdIcpfXzw951CuH4EHD3za0mEIKuk8YHqWsmSyz0BTkBuqeVPTkirjiXNTWIu1lk9BQriHYcBYqQPH/nrD4e4z1r7/QGxs3juzqhRDGyZvjrlckr7HxutyECV5SJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750680339; c=relaxed/simple;
	bh=C4nD934od7cf67JreIH2S5Gge4424XKMw3Bdg1FoFmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DLMwcjNaNH6TcVwXYAVSvU1zYC/uQr7O5aF88sX3/SEBhdcxLiv4dpANSyhAtAS7V6XFWLD858wr/aXySEo0GtQJcK+qYSG3p001grkeNxQE1aMY8VJ0+wIWcG4QTs9xkmy//SgFmf2hZIaarHy+OssmLq3G52Pq7/m2OfeyBjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEC8C113E;
	Mon, 23 Jun 2025 05:05:17 -0700 (PDT)
Received: from [10.57.29.116] (unknown [10.57.29.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 374713F58B;
	Mon, 23 Jun 2025 05:05:33 -0700 (PDT)
Message-ID: <61011213-8916-4634-997a-f9c5fd06460a@arm.com>
Date: Mon, 23 Jun 2025 13:05:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iommu: Add verisilicon IOMMU driver
To: Lucas Stach <l.stach@pengutronix.de>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, joro@8bytes.org,
 will@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 heiko@sntech.de, nicolas.dufresne@collabora.com, jgg@ziepe.ca
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com
References: <20250619131232.69208-1-benjamin.gaignard@collabora.com>
 <20250619131232.69208-4-benjamin.gaignard@collabora.com>
 <43276c9a-5434-467c-abb2-dd2806ab81d0@arm.com>
 <c7dd8ac53170cafab5489f98d3da13f65cd67a1a.camel@pengutronix.de>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <c7dd8ac53170cafab5489f98d3da13f65cd67a1a.camel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-06-20 9:45 pm, Lucas Stach wrote:
> Am Freitag, dem 20.06.2025 um 20:37 +0100 schrieb Robin Murphy:
>> On 19/06/2025 2:12 pm, Benjamin Gaignard wrote:
>>> The Verisilicon IOMMU hardware block can be found in combination
>>> with Verisilicon hardware video codecs (encoders or decoders) on
>>> different SoCs.
>>> Enable it will allow us to use non contiguous memory allocators
>>> for Verisilicon video codecs.
>>>
>>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>>> ---
>>
> [...]
>> I'm especially curious what this "pta" really is - is the comment above
>> just wrong, and you've actually got a 3-level pagetable supporting
>> somewhere between 33 and 42 bits of VA? If not, then the additional
>> level of indirection would very much seem to imply some kind of
>> mechanism for accommodating multiple pagetables at once, and in that
>> case, is it like a PASID table where the client device gets to choose
>> which entry to use, or a StreamID table to disambiguate multiple client
>> devices? (Where in the latter case it should most likely belong to the
>> IOMMU rather than the domain, and you probably want nonzero #iommu-cells
>> in the DT binding for the client IDs).
>>
> PTA is short for page table array and it's another level of indirection
> to select the page tables to be used for the specific translation. On
> the Vivante GPU, where this MMU IP originated, the GPU can select the
> index into this array to be used for a specific command stream to
> implement GPU client isolation, so it's much like a PASID table.

Thanks for the clarification!

(Although, similarly to panfrost, does this mean we should at least 
break out an io-pgtable implementation to share between the two drivers 
rather than duplicate code between here and etnaviv_iommu?)

> I have no idea if and how the integration with the video codecs can
> select the PTA index.

Yeah, that's really the thing - it may smell like a PASID table for the 
GPU use-case, but AFAICS that still wouldn't necessarily rule it out 
from turning up in some codec block with, say, all the decode 
functionality hard-wired to index 0 and encode to index 1, then all of a 
sudden we start needing different driver behaviour and potentially a 
different DT binding. I guess the door is still open to support 
"#iommu-cells = 1" to specify explicit PTA indices without breaking the 
implicit "#iommu-cells = 0" behaviour, so I don't think we're painting 
ourselves into a corner at this point, it's more just something to be 
wary of for the future.

Thanks,
Robin.

