Return-Path: <linux-kernel+bounces-775563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676CB2C0A4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:38:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8631188AD22
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 11:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DDA732BF30;
	Tue, 19 Aug 2025 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FvkjlBNV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35232A3F1;
	Tue, 19 Aug 2025 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755603284; cv=none; b=SgtNjT7gJIzTTPhMPn8ByP9xbMPSkVHzA1OVIiqKQiK8xlfV44PSvOj5bzJKPBjg7DQlw+6xQfnIh5NhQFInoEhJssNGD+uprMfi14ktp63DyZNgRLpBtWv8dTzPgdr57iU+MpAbOMEHJESlF7QlHL33Js7A5Vnl58iRnDTjmfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755603284; c=relaxed/simple;
	bh=Q4yaDrURk+Xr79ZeU1JXAex3xPCQZk+Adyf7jM4uRnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GJsrPeC0NG9KThR2wyJCIhFTvf70kfZgwk4LsNvrGSX5P7O1qguMcBetjUPva2B7X+KZt/0VZBdsPLShgVtdsOUX8Gv51lXOT+oCPl0fdfZCFID3Bajs5oACJ49vJ142wvUsRS4CRr33GhQTQx1n9dxAct+5UfOa3K2ipy5IxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FvkjlBNV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 454EAC4CEF1;
	Tue, 19 Aug 2025 11:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755603283;
	bh=Q4yaDrURk+Xr79ZeU1JXAex3xPCQZk+Adyf7jM4uRnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FvkjlBNV/ifyaYBf6CsubgRXO/iXF3ryhUwL+dv1tXG0efYvc4T2bR+gEw7udoG4o
	 DYvCzvpCnV2zWiNqPHHIC2govsxhVk26GlYK2dxFnh36vNb5vpPa1+hPRMyIhvvsGd
	 VCSwwBbmoufcYsKZqem18+p7KUqVWCtYVN7qWH4lJQbTdxnFxLEcs8qmPe0XNI2g0c
	 ewecxxIdRFjg5c4sAIcCwW4svHN4OmDPI0sTpyx7w9qWwmtrCYHgijREoyEIQHLAv7
	 TdCeFBW0GIq6/Tzy4OcPLDfEgv98ZsAgzcu4dRpOImSPkQ3RHgbXjz3h+6Fv9YaAIB
	 n9/6gdci1DAeA==
Message-ID: <b3cd1b3f-fa0e-4a98-84c7-e4271f262795@kernel.org>
Date: Tue, 19 Aug 2025 13:34:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
To: Sven Peter <sven@kernel.org>, Nick Chan <towinchenmi@gmail.com>
Cc: Janne Grunau <j@jannau.net>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-6-65648cd189e0@gmail.com>
 <20250819-polite-papaya-catfish-1a9d1a@kuoka>
 <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <8ac418ae-7ff0-4d5c-9f11-c24e36618ac1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/08/2025 12:01, Sven Peter wrote:
> On 19.08.25 11:18, Krzysztof Kozlowski wrote:
>> On Mon, Aug 18, 2025 at 04:42:59PM +0800, Nick Chan wrote:
>>> Add ANS2 NVMe bindings for Apple A11 SoC.
>>>
>>> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
>>> ---
>>>   .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
>>>   1 file changed, 9 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>> index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
>>> --- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>> +++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
>>> @@ -11,12 +11,14 @@ maintainers:
>>>   
>>>   properties:
>>>     compatible:
>>> -    items:
>>> -      - enum:
>>> -          - apple,t8103-nvme-ans2
>>> -          - apple,t8112-nvme-ans2
>>> -          - apple,t6000-nvme-ans2
>>> -      - const: apple,nvme-ans2
>>> +    oneOf:
>>> +      - const: apple,t8015-nvme-ans2
>>> +      - items:
>>> +          - enum:
>>> +              - apple,t8103-nvme-ans2
>>> +              - apple,t8112-nvme-ans2
>>> +              - apple,t6000-nvme-ans2
>>> +          - const: apple,nvme-ans2
>>
>> When some months ago this pattern of generic fallback appeared, I
>> believe I commented it is bad idea. So now months later we have a proof
>> - generic fallback is useless and you should have been using SoC
>> specific compatibles from the start.
>>
>> Now it is just confusing and this broken pattern will be spreading more
>> and more, because you folks put generic compatibles everywhere.
> 
> I haven't commented on the dt-bindings yet because I suspect this patch 
> is wrong but haven't had time to test this yet.
> 
> I believe we want "apple,t8015-nvme-ans2", "apple,nvme-ans2" here and
> then use the code Nick added for "apple,nvme-ans2" by default and only
> enable additional features (NVMMU, linear submission queue) when we see
> the SoC-specific compatibles for t8103, t8112, and t6000. IIRC these
> newer SoCs still support the old way of submitting commands just fine
> and the new way was added at some point to add support for this weird
> integrated IOMMU.
> 
> I've already seen some strings about ANS3 somewhere which I suspect
> will be the controller in some future SoC (or maybe M3/M4 which we 
> haven't reverse engineered yet) that actually breaks compatibility.


This was 99% predictable and expected months/years ago when first Apple
M1 generic compatibles appeared. I just do not understand why so much
effort from reviewers has to go into explaining this and for arguing
over that, and eventually we are right.

> 
> It's too late to drop them here but if you're strongly opposed to these
> generic fallbacks we can just switch to only use tXXXX-nvme-ans3 at that
> point without making anything confusing. Same for any other new hardware
> blocks we reverse engineer and upstream.



Best regards,
Krzysztof

