Return-Path: <linux-kernel+bounces-895125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B13CC4D007
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 169CB4FF003
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 10:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06FD33B6D9;
	Tue, 11 Nov 2025 10:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JaXCfXUf"
Received: from mx-relay106-hz1.antispameurope.com (mx-relay106-hz1.antispameurope.com [94.100.133.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D9233C520
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=94.100.133.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762856048; cv=pass; b=uchBOBcZhYKNnHiqdnd2W0UT33FYtBptmeF66+QQBvGvT65i7pXa8VMGod50DL3hxPMKma8sMVy/Ydnqgma3vtdV1EW01qJv86lsKaSy/ol92fqNk1gVn9OTyY7zxv23qjgeL9+7MQAKtdiDdDuHJOCfySH/S4x7g/sjwgnwFS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762856048; c=relaxed/simple;
	bh=qffjGVKHGKbLT2g/i1slYDW6JONYYo+k1+ICy3WTD/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KXwlXl0Z79s7lmg6pwYi/VWIhJpzewjdEasZE9rLBV+odpYKHvf4aMiS3bm9Hw74Ib3STYk5fjeJvsJ83/mv9t3sAcgHbzcbxtWTE2dOhmWfZR2XHqgZpRyXbHLtYF7ap2r/Mj6IdI+Kc7DCFrfS2E+hPe4i7wKBKgzRlVAu74A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JaXCfXUf; arc=pass smtp.client-ip=94.100.133.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate106-hz1.hornetsecurity.com 1;
 spf=pass reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com
 smtp.helo=hmail-p-smtp01-out04-hz1.hornetsecurity.com; dmarc=pass
 header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=5cd8tiR4oA2bomVQnghj6XdfSPPBJKKlunliO1VnFlM=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1762856024;
 b=dnA4vK/iExr2Bz1ts5+8urawnN7DbULmYucYCCA9e6BlOCJrdPWVW+iOKEYFOBxEiyKo4G4f
 eM+jXwv1AU4e/hcQYeOOXNvl7N/BokpeM5f8VqCRbAovOSJrvbhrDLBE094pMLzBuNcnkdemaWs
 adPpwoxbpMtZ+aqwN84W5Lah2+vgaR/RhmLGD0qtVP7P+3/ykBRGeUEt5KeTdCKavH22mh/Mtx7
 WZdaSOveJokz+fcLiBPUTFnokfpZtolTedQmqEQXorU9Ih5pEcghdEd2PDqRjvNh0YMSludJji3
 QxFGIfSQydCHd2L/bE1kFGbA8W0s+lPnnTWsEo0GbNyEw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1762856024;
 b=LTqSEBG/4KnUBwWIrPqhNX/lr5a+os07SuP/O+NKNHVMrugLJWV+V7iI/Mbqn5NDwBPpH7bq
 KXN263m3IQLqDfuVns+3LJ5NQR5PrL3d3xMzzdv12arHrNw3xOdQpGN4Un8HdIWmo8aedVtDX4K
 aQq7sjJP39fPstkMvNJvx6KYWiGoMe7T0bFPs2vYDWHHg1hN0bzdiiRdIO2f0y8GkCtaiY2Mjjr
 /2/ZogCjPwgsAXV+qqdSowXrb5yo/UQSKi2V13DlaR0jjjyE6bWF6Tcty/gSId32Jhik55Nny/U
 jDHMtkp03a6pPW5xE114IGFHSMyl2sV113q0hhHLLfY2A==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay106-hz1.antispameurope.com;
 Tue, 11 Nov 2025 11:13:44 +0100
Received: from steina-w.localnet (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by hmail-p-smtp01-out04-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 3B9AC220C9E;
	Tue, 11 Nov 2025 11:13:26 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nsc@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, Frank Li <Frank.Li@nxp.com>,
 Li Jun <jun.li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 4/9] arm64: dts: imx8mm-evk: add wakeup-source for usb phy
Date: Tue, 11 Nov 2025 11:13:25 +0100
Message-ID: <2809731.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20251110-misc_dts-v1-4-7564b9f69a18@nxp.com>
References:
 <20251110-misc_dts-v1-0-7564b9f69a18@nxp.com>
 <20251110-misc_dts-v1-4-7564b9f69a18@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay106-hz1.antispameurope.com with 108FA11C9E97
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:98cd9670ad177dc9a441365add1c322b
X-cloud-security:scantime:1.834
DKIM-Signature: a=rsa-sha256;
 bh=5cd8tiR4oA2bomVQnghj6XdfSPPBJKKlunliO1VnFlM=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1762856023; v=1;
 b=JaXCfXUf4kuRxxIDTV6fruQG/6iKs2QguiwXNX4ioq4Dr0Jz3z0UqtwZPt0XXoMNoWAT2QQ9
 a3sMQ2KwgTSoSFr3SJKoifH5/IKUcW4/2lI2SJ2vMUx6Wr8RGC6d+aloN9pXDEmgMyaMpemc+Sa
 nFnQXVTmMtoSeEGpHopMD3R7hlETCNP9xrDGlfqAleF3tjVtbJmgeNpz7aLR2/8hApbQJe/MzEa
 W0ypWxt8o3rZlmcbTSaEgS9/NED/hOgAomMhkEg6pmyYVB9raNbQLz5ukOP2693Qp2fdogCxpHH
 aJwnx0N823dhREh/Ky4eyOz7MQb2krXGt21tkYKCUui5Q==

Am Montag, 10. November 2025, 21:54:44 CET schrieb Frank Li:
> From: Li Jun <jun.li@nxp.com>
>=20
> USB phy can be wakeup source to support wakeup system from USB.
>=20
> Signed-off-by: Li Jun <jun.li@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Typo in subject: Just imx8mm. Remove the '-evk'

Best regards,
Alexander

> ---
>  arch/arm64/boot/dts/freescale/imx8mm.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/=
dts/freescale/imx8mm.dtsi
> index ed8b4843acb4804379ba025e83a63fe962c2937e..dfff164db827e80ef8822ae33=
0fa604d1642f6f9 100644
> --- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
> @@ -274,6 +274,7 @@ usbphynop1: usbphynop1 {
>  		assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL1_100M>;
>  		clock-names =3D "main_clk";
>  		power-domains =3D <&pgc_otg1>;
> +		wakeup-source;
>  	};
> =20
>  	usbphynop2: usbphynop2 {
> @@ -284,6 +285,7 @@ usbphynop2: usbphynop2 {
>  		assigned-clock-parents =3D <&clk IMX8MM_SYS_PLL1_100M>;
>  		clock-names =3D "main_clk";
>  		power-domains =3D <&pgc_otg2>;
> +		wakeup-source;
>  	};
> =20
>  	soc: soc@0 {
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



