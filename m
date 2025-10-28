Return-Path: <linux-kernel+bounces-873267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D4C1388B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1C14A4FB10D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2352D739C;
	Tue, 28 Oct 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZYmP26s"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063102D8384
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 08:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639796; cv=none; b=DL351A9z5pjYS0yPethpXdWPweNAK1DJlSA/0erhGkLqIz2Mrus3/oiFFLlZSksDw3IUdpWq1dQ9J/fqaCUnP0NEnuk1Uz8AKXYuJGBbAzKLrbBez+jFZ9AGdxZoUCnZOKKWebSSl7noQFDDmK1jeKGjF4zNRlNm6dooY4Y+wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639796; c=relaxed/simple;
	bh=VryWymEyQYFv7D2Zu/J+9UBUYXQJGOTKKyDXEDfPJII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lETr5bs87glA4nFHx0p8ePsSh+7V6yVsP4gRnFxcDVA5nT75ZczVxhSKNu0ZKsoZFkTedQPZEYc1UBIsyk80y/36oQSVttbVyZReLyvzJ3OkPn7c4pvoNzfMRL+MYKj+K/xH+Etq2af3QIpg8KGQ47IT2ziwLs28JfoEB/CiYXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZYmP26s; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b3f5e0e2bf7so1258616066b.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 01:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761639792; x=1762244592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uYkrsJvRY/M4MaFVJOdOGBIZ0zXWhOCmDqeRXw+U7YE=;
        b=eZYmP26sEkOWnMMN+ZiKnSkpfWhxbLnSe34P+HbCurEZkvYgEYLY0THNyaxEApnalM
         4tatyrX6Z/D+lDs+4xFiN8d2T4AoUKmgyt/iCNXoShHnDQJ1+hqDMBFQODLwCsiDuwvm
         8tMlraXpcLqbZkq9ifEJNIvQnbQrV7OurLCGPJtvtxo0nANDd/bTh/nvedJuRCdh0ERu
         4d+rwfbG+QgUxSw2W2ubQJgyvnE6QY+hShQI+sKqX9GhuezNM1ev3NQDFt/scef1Bcf4
         3BY0qrJ0k3xe6DQUkSutqymhaupYyw/Ufwu9nOwLeQJjqmuCyjAZYnHMg0wZVIe8wZKi
         KSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761639792; x=1762244592;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYkrsJvRY/M4MaFVJOdOGBIZ0zXWhOCmDqeRXw+U7YE=;
        b=o0NXl6lwR0xBgUECAG2fF0jckrsLAZ+htB7WcrDPuwfyHUTOogc8BLrOjJGRbsT3qi
         GLjzV4bQSc7FFVH0NI/aqY2NBN/3w7zOWrSOswHst4ROUN5r1f8mKqCBM/lazgXUDl3D
         Ur801YpxfyViNtniwHRP0tjq2MtwXyHUMC28fyGXzv79QIVl+MP13DgAhedooaAKpETo
         3F/HA4MaTzAAeCvv3BY5YvocgXCqqSQoqBdR7LvoWVdfPSmxtk1R2Uc4/RdIF5lj2eYg
         guo2/XBBqI3k1B85AmJSSCWDDPPBX2Yerli5xuFyb8m5/0ysvGao1t5FxiI1XKznGgKk
         CiKA==
X-Forwarded-Encrypted: i=1; AJvYcCW6DIVMrH9El1FKVAAKyCIFEFRUtqw3r26HNOs5ggJ6XeekNfIZbGOKJF78Mal+e8X613g9ZhViWHU27qc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdE/QNU1gJbckdLyrHyhWGLzVjyHfpiRp5cFiVhBKCiCt+4m7F
	bHKnQXuqsF568z8wI067aF+7WAsAPCWV4ptcWmaoV13DXUptZLNXbOIy
X-Gm-Gg: ASbGncuvJxsunmOkVj29WB7+6o7j0WnGxVl1xheQVxy3e38E/RYnzhB0jNXJ5aPpwXS
	rOG0MQMvPjC6ToqTuQCJrWZj6P9e/wrSC4XYI4Dx3aEvmWnS88lCq+bvoOwAODBZMqDc9r63yQL
	AAsR2c1EcaTMACW5iOZ30wurCPlV+aB3aH2rmY944WA7DJbv26ApRa9x1otfiSMvuMDM+WROcAE
	AgdT8kVEHoryzvrcLnvAXr9+30a1WRFTIls1BoTmbiGX0FEwB/Sp+0+InQ9Xbbx6a/7NecgxQMp
	auq7+AvA6XBoCB8x6YFZEqkuju09Xdo0LurQ2V9GcTfJ+I7g2oBlxWWNTmhhC4LFhvi8dWzWy6S
	3fSusFHFZOKng5OsIk9uY8c6SOwq84h896KDKXB6V4NzIoDChQt8Tt4TBYW/BOjgEOjgLxW4+Ne
	Npbp/TN8DALd/rTRkLtDtkLcPnGwHRdXZKEZA7oLR3GS6TNwgWW4RwXhoKoTO/NRLvSyC0S0CBn
	w==
X-Google-Smtp-Source: AGHT+IFRsX11i6ttykwzSTE1MX3XcVT7zdJoHg0PldYmpaU3ps1bn6uVFu1p5RX3UmY4D7yABarLgw==
X-Received: by 2002:a17:907:6ea9:b0:b41:c602:c746 with SMTP id a640c23a62f3a-b6dba48c5ddmr306520266b.20.1761639791192;
        Tue, 28 Oct 2025 01:23:11 -0700 (PDT)
Received: from alb3rt0-ThinkPad-P15-Gen-1 (host-81-118-90-13.business.telecomitalia.it. [81.118.90.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d853077e8sm1024064566b.14.2025.10.28.01.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:23:10 -0700 (PDT)
Date: Tue, 28 Oct 2025 09:23:07 +0100
From: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Frank Li <Frank.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: Re: [PATCH 1/2] arm64: dts: freescale: imx93-phyboard-nash: Add jtag
 overlay
Message-ID: <aQB9azDkYN4RLU6+@alb3rt0-ThinkPad-P15-Gen-1>
References: <20251007084028.1125185-1-primoz.fiser@norik.com>
 <aPt/d9svTeUIRljW@lizhi-Precision-Tower-5810>
 <aPuO+FCeeIFv3bQm@alb3rt0-ThinkPad-P15-Gen-1>
 <aPuvYwwG5N84MwGA@lizhi-Precision-Tower-5810>
 <658fa62e-cc80-436a-9812-c67b0dc8de03@norik.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <658fa62e-cc80-436a-9812-c67b0dc8de03@norik.com>

On Tue, Oct 28, 2025 at 07:23:57AM +0100, Primoz Fiser wrote:
> Hi both,
> 
> On 24. 10. 25 18:54, Frank Li wrote:
> > On Fri, Oct 24, 2025 at 04:36:40PM +0200, Alberto Merciai wrote:
> >> On Fri, Oct 24, 2025 at 09:30:31AM -0400, Frank Li wrote:
> >>> On Tue, Oct 07, 2025 at 10:40:27AM +0200, Primoz Fiser wrote:
> >>>> Add overlay to enable JTAG pins on the board's JTAG (X41) connector.
> >>>>
> >>>> Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> >>>> ---
> >>>>  arch/arm64/boot/dts/freescale/Makefile        |  2 ++
> >>>>  .../freescale/imx93-phyboard-nash-jtag.dtso   | 26 +++++++++++++++++++
> >>>>  2 files changed, 28 insertions(+)
> >>>>  create mode 100644 arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> >>>>
> >>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile b/arch/arm64/boot/dts/freescale/Makefile
> >>>> index 525ef180481d..c72a6fdc5412 100644
> >>>> --- a/arch/arm64/boot/dts/freescale/Makefile
> >>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
> >>>> @@ -356,10 +356,12 @@ dtb-$(CONFIG_ARCH_MXC) += imx93-kontron-bl-osm-s.dtb
> >>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash.dtb
> >>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
> >>>>
> >>>> +imx93-phyboard-nash-jtag-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-jtag.dtbo
> >>>>  imx93-phyboard-nash-peb-wlbt-07-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-nash-peb-wlbt-07.dtbo
> >>>>  imx93-phyboard-segin-peb-eval-01-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-eval-01.dtbo
> >>>>  imx93-phyboard-segin-peb-wlbt-05-dtbs += imx93-phyboard-segin.dtb imx93-phyboard-segin-peb-wlbt-05.dtbo
> >>>>  imx93-phycore-rpmsg-dtbs += imx93-phyboard-nash.dtb imx93-phyboard-segin.dtb imx93-phycore-rpmsg.dtbo
> >>>> +dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-jtag.dtb
> >>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-nash-peb-wlbt-07.dtb
> >>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-eval-01.dtb
> >>>>  dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin-peb-wlbt-05.dtb
> >>>> diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> >>>> new file mode 100644
> >>>> index 000000000000..4744eabf95f3
> >>>> --- /dev/null
> >>>> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-nash-jtag.dtso
> >>>> @@ -0,0 +1,26 @@
> >>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> >>>> +/*
> >>>> + * Copyright (C) 2025 PHYTEC Messtechnik GmbH
> >>>> + * Author: Primoz Fiser <primoz.fiser@norik.com>
> >>>> + */
> >>>> +
> >>>> +#include "imx93-pinfunc.h"
> >>>> +
> >>>> +/dts-v1/;
> >>>> +/plugin/;
> >>>> +
> >>>> +&gpio2 {
> >>>> +	pinctrl-names = "default";
> >>>> +	pinctrl-0 = <&pinctrl_jtag>;
> >>>> +};
> >>>
> >>> Use gpio to set pinctrl to no-gpio mode is strange. I am not sure if there
> >>> are better method, but at need comments here to show why have to do that.
> >>>
> >>
> >> In old imx6 platform we use pinctrl_hog for that purpose, is not?
> > 
> > It'd better than gpio, but I am not sure if pinctrl_hog still be supported
> > because I have not seen it for the long time.
> > 
> 
> I am OK with both suggestions:
> 
> 1) adding an explanation comment
> 2) Using pinctrl_hog method
> 
> Personally however, I would prefer method 1) since it would be better in
> this case because base customer dts can already contain default
> pinctrl_hog which would be overwritten by this overlay.

Good point, that is true.

> 
> Not that common, but can still happen.
> 
> What do you suggest for v2? 

I would say 1, IMO explaining that with a comments is the most
explicit way to do that.

BR,
Alberto

> 
> BR,
> Primoz
> 
> > Frank
> >>
> >>> Frank
> >>>> +
> >>>> +&iomuxc {
> >>>> +	pinctrl_jtag: jtaggrp {
> >>>> +		fsl,pins = <
> >>>> +			MX93_PAD_GPIO_IO24__JTAG_MUX_TDO	0x31e
> >>>> +			MX93_PAD_GPIO_IO25__JTAG_MUX_TCK	0x31e
> >>>> +			MX93_PAD_GPIO_IO26__JTAG_MUX_TDI	0x31e
> >>>> +			MX93_PAD_GPIO_IO27__JTAG_MUX_TMS	0x31e
> >>>> +		>;
> >>>> +	};
> >>>> +};
> >>>> --
> >>>> 2.34.1
> >>>>
> >>>
> 
> -- 
> Primoz Fiser
> phone: +386-41-390-545
> email: primoz.fiser@norik.com
> --
> Norik systems d.o.o.
> Your embedded software partner
> Slovenia, EU
> phone: +386-41-540-545
> email: info@norik.com
> 

