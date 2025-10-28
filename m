Return-Path: <linux-kernel+bounces-873107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4CB1C131FE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FA458076B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 06:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C244261581;
	Tue, 28 Oct 2025 06:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="DzpX4aL2"
Received: from cp2.siel.si (cp2.siel.si [46.19.12.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9D8286430;
	Tue, 28 Oct 2025 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.12.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761632642; cv=none; b=snb8odlHRwICkLMuPO6CYusAoualZ4TIVq458Ih9/YkizSy4fIPQGQ9CJnvWVa3Ht8T0bdF2yUe83nGX4BP3NrNu0JutEcsVX0i3WnLmAcLj7scFc8VmDxaSaF/wcmI+NSfZRL5i751+xFq4PbSHuwjPElTTu+Rsws8eTiXxdxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761632642; c=relaxed/simple;
	bh=qF862YQMhxHIqNRrfdOcFjxmmmh3u96he0/heE39e9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrEXllt4DV0eDy8ny5w4BTJ/mN0picNkgF9TePv9BUbaqTjz/FVZwebjDy0ysg79C4xYawtgjJC0rui6SWUJ/IviCk3uL9dJkm3dEZIKQQPqLmKGk7C4/ESGoQ1UsMnCky5HAiFYa7BfPEdGlBSRaDhTTCN42+OW63BFicldH90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=DzpX4aL2; arc=none smtp.client-ip=46.19.12.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=/bwZX8NaNeCjNz5xtFo8tTrg/X/6uhvhX7RQ2Ckv/pw=; b=DzpX4aL2ITM/2aTmP4HaOK3Skk
	wTcJ89CRbii5D/gvPXFoKNH5Ab8K7X8773FNTdXsHUY7Drthck2gkZIFWLJO9pNh+z0wZJZqm4Cuh
	E3iUhLZiFJQ8xQysNymfEPT96bzPdRhOU0dd3Nuut8Z459Zz0xLn+OQID2z0MtFXFJflKKQXRt3UT
	M1WxICLWC3tkgyuohcLxdPpSzwLOChJ0inZiXFu1isLMkEWE/D3kN31ytbxWXMiRnMC+RVBwm3s/f
	Etbagn0/Unb064upBEmBd5HffwW3zmgeZnkLKunyWs6NiF8JmF1UY1Qv+9tB2yobUfGrHssH9SlwT
	1avj86Ew==;
Received: from 89-212-21-243.static.t-2.net ([89.212.21.243]:46904 helo=[192.168.69.116])
	by cp2.siel.si with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1vDd7h-00000009FJT-023f;
	Tue, 28 Oct 2025 07:23:59 +0100
Message-ID: <658fa62e-cc80-436a-9812-c67b0dc8de03@norik.com>
Date: Tue, 28 Oct 2025 07:23:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add jtag
 overlay
To: Frank Li <Frank.li@nxp.com>, Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de
References: <20251007084028.1125185-1-primoz.fiser@norik.com>
 <aPt/d9svTeUIRljW@lizhi-Precision-Tower-5810>
 <aPuO+FCeeIFv3bQm@alb3rt0-ThinkPad-P15-Gen-1>
 <aPuvYwwG5N84MwGA@lizhi-Precision-Tower-5810>
Content-Language: en-US
From: Primoz Fiser <primoz.fiser@norik.com>
Autocrypt: addr=primoz.fiser@norik.com; keydata=
 xjMEZrROOxYJKwYBBAHaRw8BAQdAADVOb5tiLVTUAC9nu/FUl4gj/+4fDLqbc3mk0Vz8riTN
 JVByaW1veiBGaXNlciA8cHJpbW96LmZpc2VyQG5vcmlrLmNvbT7CiQQTFggAMRYhBK2YFSAH
 ExsBZLCwJGoLbQEHbnBPBQJmtE47AhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQagttAQducE+T
 gAD+K4fKlIuvH75fAFwGYG/HT3F9mN64majvqJqvp3gTB9YBAL12gu+cm11m9JMyOyN0l6Os
 jStsQFghPkzBSDWSDN0NzjgEZrROPBIKKwYBBAGXVQEFAQEHQP2xtEOhbgA+rfzvvcFkV1zK
 6ym3/c/OUQObCp50BocdAwEIB8J4BBgWCAAgFiEErZgVIAcTGwFksLAkagttAQducE8FAma0
 TjwCGwwACgkQagttAQducE8ucAD9F1sXtQD4iA7Qu+SwNUAp/9x7Cqr37CSb2p6hbRmPJP8B
 AMYR91JYlFmOJ+ScPhQ8/MgFO+V6pa7K2ebk5xYqsCgA
Organization: Norik systems d.o.o.
In-Reply-To: <aPuvYwwG5N84MwGA@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp2.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cp2.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cp2.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi both,

On 24. 10. 25 18:54, Frank Li wrote:
> On Fri, Oct 24, 2025 at 04:36:40PM +0200, Alberto Merciai wrote:
>> On Fri, Oct 24, 2025 at 09:30:31AM -0400, Frank Li wrote:
>>> On Tue, Oct 07, 2025 at 10:40:27AM +0200, Primoz Fiser wrote:
>>>> Add overlay to enable JTAG pins on the board's JTAG (X41) connector.
>>>>
>>>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
>>>> ---
>>>>  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
>>>>  .../freescale/imx93-phyboard-nash-jtag.dtso   | 26 +++++++++++++++++++
>>>>  2 files changed, 28 insertions(+)
>>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
>>>> index 525ef180481d..c72a6fdc5412 100644
>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>> @@ -356,10 +356,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>>>>
>>>> +imx93-phyboard-nash-jtag-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-jtag.dtbo
>>>>  imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
>>>>  imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
>>>>  imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
>>>>  imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
>>>> +dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-jtag.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
>>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
>>>> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
>>>> new file mode 100644
>>>> index 000000000000..4744eabf95f3
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
>>>> @@ -0,0 +1,26 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
>>>> + * Author: Primoz Fiser <primoz.fiser@norik.com>
>>>> + */
>>>> +
>>>> +#include "imx93-pinfunc.h"
>>>> +
>>>> +/dts-v1/;
>>>> +/plugin/;
>>>> +
>>>> +&gpio2 {
>>>> +	pinctrl-names = "default";
>>>> +	pinctrl-0 = <&pinctrl_jtag>;
>>>> +};
>>>
>>> Use gpio to set pinctrl to no-gpio mode is strange. I am not sure if there
>>> are better method, but at need comments here to show why have to do that.
>>>
>>
>> In old imx6 platform we use pinctrl_hog for that purpose, is not?
> 
> It'd better than gpio, but I am not sure if pinctrl_hog still be supported
> because I have not seen it for the long time.
> 

I am OK with both suggestions:

1) adding an explanation comment
2) Using pinctrl_hog method

Personally however, I would prefer method 1) since it would be better in
this case because base customer dts can already contain default
pinctrl_hog which would be overwritten by this overlay.

Not that common, but can still happen.

What do you suggest for v2?

BR,
Primoz

> Frank
>>
>>> Frank
>>>> +
>>>> +&iomuxc {
>>>> +	pinctrl_jtag: jtaggrp {
>>>> +		fsl,pins = <
>>>> +			MX93_PAD_GPIO_IO24__JTAG_MUX_TDO	0x31e
>>>> +			MX93_PAD_GPIO_IO25__JTAG_MUX_TCK	0x31e
>>>> +			MX93_PAD_GPIO_IO26__JTAG_MUX_TDI	0x31e
>>>> +			MX93_PAD_GPIO_IO27__JTAG_MUX_TMS	0x31e
>>>> +		>;
>>>> +	};
>>>> +};
>>>> --
>>>> 2.34.1
>>>>
>>>

-- 
Primoz Fiser
phone: +386-41-390-545
email: primoz.fiser@norik.com
--
Norik systems d.o.o.
Your embedded software partner
Slovenia, EU
phone: +386-41-540-545
email: info@norik.com


