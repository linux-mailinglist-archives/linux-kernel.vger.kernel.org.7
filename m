Return-Path: <linux-kernel+bounces-881807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59520C28F6A
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9414A3B13BE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 13:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5A822156B;
	Sun,  2 Nov 2025 13:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQqncrOL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259E71DDDD;
	Sun,  2 Nov 2025 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762088988; cv=none; b=CG/w9nhYx0fcJdTVl2wa56Z/FlFFMrLffkYNUYRzFsvSpZ+Eu7hyc4uKgGYLqMYntPB7ZKzzOGmVcI223yLfmf7CdcVwgXxJ7YuBUEDalBbmbof/owryru/Vek5iftEqIcAqWaSXtqUuUC2UHxIAa59tBGYbwfobdeEp5MgUUDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762088988; c=relaxed/simple;
	bh=JsNDhf+4sb8rTXxkI79UStDqc65YrKO9bboNIQAYcd8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=G23XpTGdVASZjIs6iJD3WjA03+iWpOW88tfiv2Bso3YoGo8yBrW+c7sp3MRaTgbI2EMuhHGgPmCv9DtgJ9mC/QnUVrmJxSquOPu+zCEmxDM7AIFuxdFqY28GxML5x+EqsnMvouhEtm19yKbQdGAL6K0HFI8HIXmNSEhPXOMD+Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQqncrOL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6412C4CEF7;
	Sun,  2 Nov 2025 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762088987;
	bh=JsNDhf+4sb8rTXxkI79UStDqc65YrKO9bboNIQAYcd8=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=WQqncrOLfQR2JjAKh9LI6nIQ0Nm8RyfBKSYY0XY1ViSxUoG4bDIQKz7BCAPFNuxYo
	 37AZpcki5Jg9997/go8g0gPMS1D0AydB16zygbVzdjYkIx6Hcr8p/yj61IQCGp6mZx
	 TUwk7oJ6HzF4NzDXRUybthVJFsXPIrHXg44ygchSBz4HJTdFo7zC/V0mthPMx8V8cs
	 cYSNJ1vmaEGgUS8bBvCF35SEmVoG/sL3XFNj/HjTup/56kPtAmMLPe9sYRfwP1tq2n
	 srd7Ml97o1NrZv90JoPohUvFimC6JylFikVOD8MopGAsH8/d/D0Z+GX/g4hXsfjOBs
	 qIVOO7cRcWLGg==
Message-ID: <c8a88007-aaa0-4f8c-bf47-186b41428502@kernel.org>
Date: Sun, 2 Nov 2025 14:09:42 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sven Peter <sven@kernel.org>
Subject: Re: [PATCH 1/3] soc: apple: Add hardware tunable support
To: Janne Grunau <j@jannau.net>
Cc: Neal Gompa <neal@gompa.dev>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20251026-b4-atcphy-v1-0-f81b1225f9c6@kernel.org>
 <20251026-b4-atcphy-v1-1-f81b1225f9c6@kernel.org>
 <20251029192101.GA458701@robin.jannau.net>
Content-Language: en-US
In-Reply-To: <20251029192101.GA458701@robin.jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 29.10.25 20:21, Janne Grunau wrote:
> Hej,
> 
> On Sun, Oct 26, 2025 at 01:52:01PM +0000, Sven Peter wrote:
>> Various hardware, like the Type-C PHY or the Thunderbolt/USB4 NHI,
>> present on Apple SoCs need machine-specific tunables passed from our
>> bootloader m1n1 to the device tree. Add generic helpers so that we
>> don't have to duplicate this across multiple drivers.
>>
>> Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>> Signed-off-by: Sven Peter <sven@kernel.org>

[...]

>> +
>> +	tunable = devm_kzalloc(dev,
>> +			       sizeof(*tunable) + sz * sizeof(*tunable->values),
> 
> There is a struct_size macro in linux/overflow.h for this calculation.
> We do not have to care about overflows as as struct property.length
> remains (signed) int. I would expect there is a much smaller limit for of
> properties in place anyway. The macro looks nicer though:
> 
> struct_size(tunable, values, sz)

Nice, I'll use that!

> 
>> +			       GFP_KERNEL);
>> +	if (!tunable)
>> +		return ERR_PTR(-ENOMEM);
>> +	tunable->sz = sz;
>> +
>> +	for (i = 0, p = NULL; i < tunable->sz; ++i) {
>> +		p = of_prop_next_u32(prop, p, &tunable->values[i].offset);
> 
> Does it make sense to add an size argument either here or in
> apple_tunable_apply() to check that the offset is within the expect MMIO
> region? Not really important but might catch a bug someday.

I would've usually said this was overkill but given that we just found a 
bug in our bootloader which caused us to copy random memory as tunables 
a week or two ago because of a stale fdt node id I'll add some sanity 
checks here.

> 
>> +		p = of_prop_next_u32(prop, p, &tunable->values[i].mask);
>> +		p = of_prop_next_u32(prop, p, &tunable->values[i].value);

[...]

>> +/**
>> + * Apply a previously loaded hardware tunable.
>> + *
>> + * @param regs: MMIO to which the tunable will be applied.
>> + * @param tunable: Pointer to the tunable.
>> + */
>> +void apple_tunable_apply(void __iomem *regs, struct apple_tunable *tunable);
>> +
>> +#endif
> 
> Reviewed-by: Janne Grunau <j@jannau.net>

thanks!


Sven



