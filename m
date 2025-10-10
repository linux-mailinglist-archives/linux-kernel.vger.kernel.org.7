Return-Path: <linux-kernel+bounces-848097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A10BCC83B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A5864F65AD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB7D28466A;
	Fri, 10 Oct 2025 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ksoo2ILU"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F189A26A0F8;
	Fri, 10 Oct 2025 10:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760091743; cv=none; b=MeAFhh+wvGH+ZIounlL0JNo4W6naC0gbghZK+bxrpKr9g53S74HtUck5f/tdzsVSp+ZeRqFeMIcXpdJHqcxH0kI07UgMXMWCXkTZpD3wOeDkRFrmydooa4r+ZPMQ2uScuLvxs4kos1K3iaaED/pQiw7pvGpaByLbcJontrjXSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760091743; c=relaxed/simple;
	bh=NMynMGbKCGoXa3+zfRY4wTd8ZErpDMWLsVJVcoFNU5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiRGjYZLhfFeGsOW93mcR6pI77s4y/Gl1NoWX5c/IDH36ZeuHvQB6qrEE81nccgTkn0RMrR/65g/VFrG/IL7mP1ki+yPAx464N3hJ0QDceZGVIK7sQtdIeqqzsJ/L579IqwSXk4qdi6O3MF8CkqcMb08zRhYzqzMs1PjKnncWe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ksoo2ILU; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 87F4CC08CC7;
	Fri, 10 Oct 2025 10:21:59 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 28C3B60667;
	Fri, 10 Oct 2025 10:22:18 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 581C7102F220E;
	Fri, 10 Oct 2025 12:22:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760091737; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LVAJyNJ/atriVmfO2odOrzCoxOhZwl6Ix4PMrqVToYk=;
	b=ksoo2ILUKZ/ObF21JtYOUO92T+BCdn2ME3maRCv+7sMurv6VEfraalOYLbpMQ0EjylyjBy
	WSTKA30jtDXWGYPIHWrBKYrwe3m2XDMq7maal7YBMI7cz9ycXn+pxMlr1VGgRR0nRjsly7
	hXK69PIxeuPJ5mH29t35/QtLoAmMV59TS8V4pJzoJuZZdJrGk7Jz/dFwIcKYDD9gTG+alr
	K2GnEemfK10+4rzRvNMtk9M68xllsp32Vh4XDqhEcyXBCSLGq0GZuWFrWO050Th0dh5yy4
	ajEW4kvqmx7w7KzVSpcPZ6XJ+yZjmVuxZovTWslvdn0E2RMkY9G0HBHXrk3VGQ==
Message-ID: <00f6ec33-bd86-4f57-8011-1c067e9321b4@bootlin.com>
Date: Fri, 10 Oct 2025 12:22:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/15] arm64: dts: allwinner: h616: add NAND controller
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251010084042.341224-1-richard.genoud@bootlin.com>
 <20251010084042.341224-4-richard.genoud@bootlin.com>
 <82bcd40f-7e94-43ca-99c9-234458011b9b@kernel.org>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <82bcd40f-7e94-43ca-99c9-234458011b9b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 10/10/2025 à 10:47, Krzysztof Kozlowski a écrit :
> On 10/10/2025 10:40, Richard Genoud wrote:
>> The H616 has a NAND controller quite similar to the A10/A23 ones, but
>> with some register differences, more clocks (for ECC and MBUS), more ECC
>> strengths, so this requires a new compatible string.
>>
>> This patch adds the NAND controller node and pins in the device tree.
> 
> 
> Please do not use "This commit/patch/change", but imperative mood. See
> longer explanation here:
> https://elixir.bootlin.com/linux/v6.16/source/Documentation/process/submitting-patches.rst#L94
You're right, I'll reformulate that.


> 
>>
>> Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
>> ---
> 
> Confusing order of patches. Driver code cannot depend on DTS.
> 
> See submitting patches in DT. It is VERY explicit about it. Please also
> read maintainer soc profile.
Indeed, it's quite explicit in
Documentation/devicetree/bindings/submitting-patches.rst
Sorry for that.

But I don't know what you are referring to as "maintainer soc profile"
I guess soc here doesn't stand for system on chip :)

Thanks!

> 
> Best regards,
> Krzysztof


-- 
Richard Genoud, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

