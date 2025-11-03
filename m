Return-Path: <linux-kernel+bounces-882781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F837C2B7A9
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 12:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5FF0D4F5624
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE3230217F;
	Mon,  3 Nov 2025 11:38:10 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751A2ECD34;
	Mon,  3 Nov 2025 11:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762169890; cv=none; b=pw3avdkEBRndeNwYteq/jNgGPHtLvacLzhJj+Y8v76fVjL7rvNqwc+jjHf0knP3xty2R3Q8hvpBHknTfuXcnHmAP5VPigpkv9Yy/AxP94HuH43edLvr5s7PN7mQ8i1H+KyfC1E0fujMduij5OPitMKhiVHQ3XyGBXHkulFrFqfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762169890; c=relaxed/simple;
	bh=exqkU2W4405iLdMUWHXw5BM2kfwhHK0Qe+hJF0tu1AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q80UFmlHHAqdLDSe8MLhyxeOZF7qxlAPidujA0J4oBqNXc8oIYozlWnaRupYD5qCo1uvh8hYLP/C9dFsYPCmIGq/wSC8BeI9eWJQ2vmXv3kG1ohFQWuKyOFiWtkDj9rj6U1ylfo3klGXx4obRCUP+0n55dEgRZ/9J/dqXieGcIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Mon, 3 Nov
 2025 12:22:55 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Mon, 3 Nov 2025 12:22:55 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Frank Li <Frank.Li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, "Sascha
 Hauer" <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/12] arm64: dts: imx8qxp: add readonly for ocotp
Thread-Topic: [PATCH 02/12] arm64: dts: imx8qxp: add readonly for ocotp
Thread-Index: AQHcTLQz74YmS54d7E+9okQ8t4TKIA==
Date: Mon, 3 Nov 2025 11:22:55 +0000
Message-ID: <aQiQiIaVH3TTVLHV@w447anl.localdomain>
References: <20251029-8qxp_dts-v1-0-cf61b7e5fc78@nxp.com>
 <20251029-8qxp_dts-v1-2-cf61b7e5fc78@nxp.com>
In-Reply-To: <20251029-8qxp_dts-v1-2-cf61b7e5fc78@nxp.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2955B14451667462
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAFE1A0430C1E4479033CF0A8528C49B@actia.se>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Frank,

On Wed, Oct 29, 2025 at 03:54:38PM -0400, Frank Li wrote:
> Add readonly for ocotp because i.MX8QXP only support program fuse by scu.

This is not true? The driver supports writing the fuses via the SCFW API,
and we are using this way to populate the MAC fuses.

Best regards // John Ernberg
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot=
/dts/freescale/imx8qxp.dtsi
> index def6de8d579d40919e4bf7f88e119611ae4cb69a..cc82cc319159c2558400fa641=
570cddd3ad3083d 100644
> --- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
> @@ -234,6 +234,7 @@ ocotp: ocotp {
>  			compatible =3D "fsl,imx8qxp-scu-ocotp";
>  			#address-cells =3D <1>;
>  			#size-cells =3D <1>;
> +			read-only;
> =20
>  			fec_mac0: mac@2c4 {
>  				reg =3D <0x2c4 6>;
>=20
> --=20
> 2.34.1
>=20

