Return-Path: <linux-kernel+bounces-799850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2CB430F5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 06:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964CE1C23ED0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 04:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A107242D86;
	Thu,  4 Sep 2025 04:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="HiqyRxhO"
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B4423770A;
	Thu,  4 Sep 2025 04:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756959073; cv=none; b=s/iCkZsmBnIkLpxEnin/q0InrnMx5FZre7ZpbtDissu1pcUO9yoeO3RMASBBhuG3dZZa7o5UShqtCoZ+3SZSMZndSk03n/WrKoCVdylZDFkVOctSpM6Ajbffhpu/4HTxkN5oRWv5gNQR6kyJfP80F0AlRkb6rIeozlwKXN0yFgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756959073; c=relaxed/simple;
	bh=MC5EokR8vqP0hQaPL2ptdiADa44yU0cE3N8XJ9LEkXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nIJajHhu4lO7KQth06tnyoIay5Rv3aUar6agz1ha0zfEaRj8k3fHdX9YMUGi7SJWiF4K4PV4qqx2qtM08/yd0Df7ZVnloEsAaZCvoq9Al9zUoPSTosH3gp/vLM9ev7Q20+55xLq3u94m/jzp6wZlW357bD7v6VI1OMlJErMilpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=HiqyRxhO; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 144D3101BCF;
	Thu,  4 Sep 2025 06:10:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1756959063;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=r6c256qQf2+lPChQleNTabNgjDZ9HCjDllbpACt/4yQ=;
	b=HiqyRxhOZSloSKrX3V2oCouTXLKNM9m8vCwl+6zFdCKeAnk+4lP4fAyHCdMZ5i7Ijb07K6
	hS01N3VoLh8XMft6KSEJ8zkPTX2afsGtRmcrfUQaCl2f4HOFEsIpnWLL53uM4nazS2E//n
	oLzPhzCY5/h6h4zzwDwyejealvEkIBqtOs1NQ9C44ALAtajWB2YYXhlGHTAAtdjfcdq1YW
	eAEy6c55Qf6guCZtrIz5ph81l9higMj5woX4bk+hg4qCNvYL71M5AcMDUfN5gdX1jstU86
	HVPu8ZC5/Qk1blAkjPEIiKnHg6tI13scsYivM/QYwwFk0j9wKUVluvLzqX5hVA==
Message-ID: <9b32b7f6-637e-000a-63ab-642022ad5b8d@nabladev.com>
Date: Thu, 4 Sep 2025 06:11:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 05/16] ARM: dts: imx6qdl-aristainetos2: rename
 ethernet-phy to ethernet-phy@0
Content-Language: en-US
To: Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Russell King <linux@armlinux.org.uk>, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250903-imx6_dts_warning-v1-0-1e883d72e790@nxp.com>
 <20250903-imx6_dts_warning-v1-5-1e883d72e790@nxp.com>
 <CAOMZO5AGv2ykKmL631A6O2yas-1ffmFaZdHFGMxrFx93G9t8XA@mail.gmail.com>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <CAOMZO5AGv2ykKmL631A6O2yas-1ffmFaZdHFGMxrFx93G9t8XA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hello Fabio, Frank,

On 04.09.25 01:37, Fabio Estevam wrote:
> Hi Frank,
> 
> Thanks for working on this series.

+1

> On Wed, Sep 3, 2025 at 5:20 PM Frank Li <Frank.Li@nxp.com> wrote:
>>
>> Rename ethernet-phy to ethernet-phy@0 to fix below CHECK_DTB warnings:
>>    arch/arm/boot/dts/nxp/imx/imx6dl-aristainetos2_4.dtb: ethernet@2188000 (fsl,imx6q-fec): mdio: Unevaluated properties are not allowed ('ethernet-phy' was unexpected)
> ....
> 
>> -               ethphy: ethernet-phy {
>> +               ethphy: ethernet-phy@0 {
>>                          compatible = "ethernet-phy-ieee802.3-c22";
>> +                       reg = <0>;
> 
> Are you sure the Ethernet PHY is actually at address 0?
> 
> The board schematics are often needed to get this information.
> 
> I'm adding Heiko on CC in case he can confirm.

Yep, Frank was lucky, phy is @0

So, I am fine with that change.

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic

