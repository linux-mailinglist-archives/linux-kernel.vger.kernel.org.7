Return-Path: <linux-kernel+bounces-850456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DF0BD2DCA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB162189A792
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33452266560;
	Mon, 13 Oct 2025 11:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FGIlVqU1"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B148264F85
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 11:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760356617; cv=none; b=S2NAFYcUPRfAvrFy0T7wZStzaAtenYUpdqZ8N11NTpBkcbXhwMu8oSHT3flY9V+AuV2XKM6RCw/99UGNXk1PeB2HjOEBaiCkLgJk/9Z4RWO8gLRwgh1Y9T2yyhK4bWxse1Rf8o2QeHpMwZeknUsqkTig4jflzyk4mLkzKwubMko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760356617; c=relaxed/simple;
	bh=TTxjQ5UmV1gm/V1SVo0FHtEUWPWjbpxIaGVn41OcS/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nyaPIgYrON6U0XLGcqzafhkzuaeYPrwq2lZL9T6gJAZMYp1zuJTfVXvrpzZsrmbLYyVP6sy4/c6Ao/USG/UBqt1vVf5zOxaNsPb7wMun73ndmhjL2XNuvXiNmT/YsDS44xv7mRHJrDVARpzJarYIYudIMgVSUJYBab+mz7XJDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FGIlVqU1; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 843E4C093AA;
	Mon, 13 Oct 2025 11:56:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 640BC606C6;
	Mon, 13 Oct 2025 11:56:48 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1241A102F225F;
	Mon, 13 Oct 2025 13:56:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760356607; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=kSqZsCaeyifb+phyADiRq9RCwi01zTsrsstZYJCLh5I=;
	b=FGIlVqU1ARC0txcIqhMgTCjEbnmOVsxYuNtwj3DQgf8sZXgaaZOsT+IH5cYN8NFKOjFq0W
	8tFHXq6dBMsgZuEjA5cKfs8KAtznSjE6zYK2fVYypXpbZY72lOeTXsU9MyXsH4J11LceJs
	qryByDgxrbQ5xXcCBMtpxA5iy3zlB8ubkI5SRUh+Zy8FeDMcpoWK7cDOH81KUy+TC/28vI
	ujo/wDRKpM6yH2Bnljp9vqrHB8lLAEVQpN0G4FLS2WBFnzl3s0qbZyrokDatVIEAKWRJeC
	r7mB0cIXaQF03TFJh+8YEw4lxrZVMZQ82D7MgU9nAr3WF6ML27205iTmBE7pkQ==
Message-ID: <1753a54d-907c-4861-b83b-89a6b77b589e@bootlin.com>
Date: Mon, 13 Oct 2025 13:56:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] dt-bindings: mtd: sunxi: Add new compatible
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20251010084042.341224-1-richard.genoud@bootlin.com>
 <02864e41-cbf7-42e1-87ba-95bdac6d9e6d@kernel.org>
 <195f3b01-93d9-41da-aa9e-826e82889d83@bootlin.com>
 <12756400.O9o76ZdvQC@jernej-laptop>
From: Richard GENOUD <richard.genoud@bootlin.com>
Content-Language: en-US, fr
Organization: Bootlin
In-Reply-To: <12756400.O9o76ZdvQC@jernej-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Le 11/10/2025 à 12:27, Jernej Škrabec a écrit :
> Hi,
> 
> Dne petek, 10. oktober 2025 ob 12:18:56 Srednjeevropski poletni čas je Richard GENOUD napisal(a):
>> Le 10/10/2025 à 10:49, Krzysztof Kozlowski a écrit :
>>> On 10/10/2025 10:40, Richard Genoud wrote:
>>>> +
>>>>    properties:
>>>>      compatible:
>>>>        enum:
>>>>          - allwinner,sun4i-a10-nand
>>>>          - allwinner,sun8i-a23-nand-controller
>>>> +      - allwinner,sun50i-h616-nand-controller
>>>
>>>
>>> Also:
>>> 1. missing new line - why did you remove it?
>>> 2. Keep existing sunxi preferred order of entries. In other platforms it
>>> is alphanumerical, not natural. In case sunxi uses something else, just
>>> be sure you use sunxi order.
> 
> Sunxi order is from oldest generation to newest and then alphabetically
> by soc name.
> 
> This is already correctly ordered.
Ok.

Thanks!

> 
> Best regards,
> Jernej
> 
>> ok, make sens
>>
>> Thanks!
>>
>>>
>>> Best regards,
>>> Krzysztof
>>

