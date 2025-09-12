Return-Path: <linux-kernel+bounces-813211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15443B54205
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 07:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7C5567454
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 05:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEB8227511F;
	Fri, 12 Sep 2025 05:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oj6uZAMe"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E325271450
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757654682; cv=none; b=IQqdmuliX1RtxOqAAMJeXQgzqwmIMVcl9BEk/1yHZPmANqlrR2oWNA94EzO3CTTTDUvKFQh8wPhvX9SKJGp7mAKx2bkfsayJT7kkknoE/AHCtD4NGgyqf4avUCAFQd4r0TaYZbJS/QscxXNk3eDBF2/DqPoWkDU6R2WxkD+xsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757654682; c=relaxed/simple;
	bh=yf8IKIU0ATSVMRFacKuWq/EKMuRkLon8R1m9r0jtgW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rBnomYCy75Yatznj9o7dgkSfPF2uj7tTiDYzSVlrj3r+UBsyRv0B8kwds32RwNXwjZVLJJMZh5tlTHPAchJYwjEBRSl3rpmiGt2S3+UYTG+XZZbs3BQ/bhAtaAtz72o44Erraaguos7MwECZDdRGDo2U1ENjOvx6+0z3sZzFt9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oj6uZAMe; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id B21E51A0DDC;
	Fri, 12 Sep 2025 05:24:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 759F160638;
	Fri, 12 Sep 2025 05:24:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 497E3102F2833;
	Fri, 12 Sep 2025 07:24:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757654674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bOuJIl5jH5w0bJhhr/fG3QSJrybAdR7bz58Ih+9yIBw=;
	b=oj6uZAMeRU86ySa3dYaj3uhMj9lSFjdaVDg8pxBN8qjlH3go9bYu/MsJwNpzp5CTYnZtFH
	2IRxGoq9ua5LU9fhsu4yWtm/Oe46UCwav5KzGcuA3ml4iZbky28O/mBiQGIQtxv1PKtqll
	VWQ5MaeA/Xc9X/JKVc5qooxiG7FDluuSU2jGEGs9476RsuKbeIoweAp5xfsMO3ikFBzuJB
	gzmX0wI0N1alUvQrXtnxyI2YiOkTzVQrqadVp0rkisCyWk06RC+rZ0jqHgiZgSfOJ/xpxd
	aKcm11BHH7/lh54OVM9W54+oCxxIJcx/NGGNlr3yTX1LYuHB0SWvGX/ytQLieA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Jihed Chaibi <jihed.chaibi.dev@gmail.com>, andrew@lunn.ch,
 sebastian.hesselbarth@gmail.com, robh@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, shuah@kernel.org, jihed.chaibi.dev@gmail.com
Subject: Re: [PATCH] ARM: dts: kirkwood: Fix sound DAI cells for OpenRD clients
In-Reply-To: <20250830203750.239890-1-jihed.chaibi.dev@gmail.com>
References: <20250830203750.239890-1-jihed.chaibi.dev@gmail.com>
Date: Fri, 12 Sep 2025 07:24:27 +0200
Message-ID: <87348sp7jo.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Jihed Chaibi <jihed.chaibi.dev@gmail.com> writes:

> A previous commit changed the '#sound-dai-cells' property for the
> kirkwood audio controller from 1 to 0 in the kirkwood.dtsi file,
> but did not update the corresponding 'sound-dai' property in the
> kirkwood-openrd-client.dts file.
>
> This created a mismatch, causing a dtbs_check validation error where
> the dts provides one cell (<&audio0 0>) while the .dtsi expects zero.
>
> Remove the extraneous cell from the 'sound-dai' property to fix the
> schema validation warning and align with the updated binding.
>
> Fixes: e662e70fa419 ("arm: dts: kirkwood: fix error in #sound-dai-cells s=
ize")
> Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

Applied on mvebu/fixes

Thanks,

Gregory
> ---
>  arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts b/arch/=
arm/boot/dts/marvell/kirkwood-openrd-client.dts
> index d4e0b8150a8..cf26e2ceaaa 100644
> --- a/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
> +++ b/arch/arm/boot/dts/marvell/kirkwood-openrd-client.dts
> @@ -38,7 +38,7 @@ sound {
>  		simple-audio-card,mclk-fs =3D <256>;
>=20=20
>  		simple-audio-card,cpu {
> -			sound-dai =3D <&audio0 0>;
> +			sound-dai =3D <&audio0>;
>  		};
>=20=20
>  		simple-audio-card,codec {
> --=20
> 2.39.5
>

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

