Return-Path: <linux-kernel+bounces-806931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BE9B49D92
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:43:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907881B23B39
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390912FF65D;
	Mon,  8 Sep 2025 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="dGMNdmrd"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8792C2EB849
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 23:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375020; cv=none; b=Tc3+NIVi2YpCjpcF2IbST8+6NGEvKlC2Xd0eJvkr2cjDpQ5xUTgSWpuzcmW2uiWUvzVTdBRm6MkXIt7oc7bVXahaTn7i/JqnncHmSxAW4p1Bwaqb8xwbRVI+1YQxlTlBcMoVBdXH5xpezUQXSyK0UF+q3vnZNzvKDA34tY+zVFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375020; c=relaxed/simple;
	bh=Xf+o5luAHatCq/dTDCApLoFgBaeG3YyqdSkFJuMacwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsFTkE/7zOGbF87V4GPcgTTbL9d62bTlPRHStJApm0xoB9CxSlmgFJOCOpWUslDj2fvUwKqhdDebE6EOk6hEabzUJzRR18mpK/8M9UzgaEQXGBQxi0wnvnJ1eBWiGTpgwnSvUqu1Y2LAQB7kDgnG+H+0PjY0ohuN+uoSS7bFB64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=dGMNdmrd; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7459fa1ef2aso4903266a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 16:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1757375016; x=1757979816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TZ31nFbpBywr5LWV7R5R4cpzaC/84WhWlclxZ1iDl8w=;
        b=dGMNdmrdxj74AMlG0q0iDTOmERjw+ac28EpGKG+MSLspaGJQ0vEWC3wTe9Jnx96xeU
         e2DJ1dGjxfKLQtcX1cSWlsL5p4nBPcOKlkjmBggzzhf2T954jKw5rrtrvjcGTd0ajkcD
         H445lwk9Q07hsowbK8NGP1KZaYWX8OVULc5czaJAPnieVpXY4QNUZ5Qz5y1VrWH3WtUQ
         iwUe0QisOlw0pXJ1Z6TI3PTp0KO+34i32oCCP8KbRi7fvcg23hQRC0stzEblh0qE7uUx
         DWfDSiECuzmO2iJEbq15JHO/f6QbVtq3HFYDG9DKKh+EfPX3Px9mLtP8UW3rgfMPMo1P
         A4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757375016; x=1757979816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TZ31nFbpBywr5LWV7R5R4cpzaC/84WhWlclxZ1iDl8w=;
        b=cgGoJmowHO+uEPLQdQHd4S8D6G4hqQDUCgC0rR42nOZwDGbL81lRhIpg+Rv7JkOY+g
         UmIc6+kmYenjhsjVjGqj8mwlIR9lCY635E1f3VLm/FQXxs+9hciJpVqxTXWRsUVP8hae
         PjPqqOZXcGo84Qpu8oyhh9WQQOKOESQKl57JC/RDyi7lCN4fiNx13nejPzFlvDQDD+ML
         onDCvSdTwpfmpS4BJVOtKMiv23MCQbuddHGD0+0LBRGKSXgTmliZDMO2suTGHLkUwmin
         sw0w0fiTndKDcieKV4gzD5TfO+P7P0nwDJa8ZzDk3bds+N5FjR/rvRed9c2gPiX2sggk
         Xwqg==
X-Forwarded-Encrypted: i=1; AJvYcCWRxgqmVI7JfeLZz4As9SRU4hEetfQhmuUq/a+hrt/Dml4vfX43t1xLnD0++S9jQFkMXsc5/IExk2a1rps=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwpDJFX9v7vGP21bh81hm64tIybTwHMUe4o1JmF64ZsHdUJFr3
	XNRNEChJfISq2virR7gFUJC+seMzhoX+HVDEO/mVXvzz9lhWCuJUAyy4GHayDOT3khpGlXwLE7D
	5pqAHVhfdfRIdoAdtGjAh9BIBxRuTImrKon1cQh+pzg==
X-Gm-Gg: ASbGncsML0BntVPXgltu4T1RovtwJBe2wcEgNCjavNlpIupQSS9s3uVMVryXeqCVtfd
	3neX1CQsgeoG1MVZ7i1dM0aHaWHc6VVVoHjPidctnQpaOemdAGA38Qeq6WBsml6L/GyJ7KqSnVI
	DhJeBwXqB1qk4n353Wtlw5qJxs+fc6fR7XhTzyWpt2945xufI83z/D0KiG5x5E757nnzh1cT5Q6
	YxUOSP24G6NRJnvOQ==
X-Google-Smtp-Source: AGHT+IFz9G3l1NgBkuI646j9EnzDEEYlshmM1HaRnKUWjXTHPYCEEDbgvsYhJH8t3TMOXGnJoUgXdZIdCebMwUfCQhE=
X-Received: by 2002:a05:6830:4885:b0:745:52d3:947c with SMTP id
 46e09a7af769-74c71eff9demr5731156a34.11.1757375016543; Mon, 08 Sep 2025
 16:43:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-imx9-dts-v1-0-e609eb4e3105@nxp.com> <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
In-Reply-To: <20250815-imx9-dts-v1-8-e609eb4e3105@nxp.com>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 8 Sep 2025 16:43:25 -0700
X-Gm-Features: Ac12FXzVP_2vJkdlY1v1O3gS6w0Yd5KqydILTTKyUiWG6S13pVl8pRj4kS7eaz0
Message-ID: <CAJ+vNU2hro_ZoRvmQ9yowKsX25AnrgZdGMn2D-RCkyJA02CEhA@mail.gmail.com>
Subject: Re: [PATCH 08/13] arm64: dts: imx95-19x19-evk: Add phy supply for netc
To: Peng Fan <peng.fan@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 4:50=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> Add phy supply for netc emdio on board.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts | 20 +++++++++++++++++=
+++
>  1 file changed, 20 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts b/arch/arm=
64/boot/dts/freescale/imx95-19x19-evk.dts
> index 39815b21d235d2f8cfa49720d3be49d056ea039a..feee6da65d37cae7413b09216=
014d6fe2b76b032 100644
> --- a/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> +++ b/arch/arm64/boot/dts/freescale/imx95-19x19-evk.dts
> @@ -226,6 +226,25 @@ sound-wm8962 {
>                                 "IN3R", "AMIC",
>                                 "IN1R", "AMIC";
>         };
> +
> +       reg_aqr_stby: regulator-aqr-stby {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "aqr-stby";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               gpio =3D <&i2c5_pcal6408 1 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
> +
> +       reg_aqr_en: regulator-aqr-en {
> +               compatible =3D "regulator-fixed";
> +               regulator-name =3D "aqr-en";
> +               regulator-min-microvolt =3D <3300000>;
> +               regulator-max-microvolt =3D <3300000>;
> +               vin-supply =3D <&reg_aqr_stby>;
> +               gpio =3D <&i2c5_pcal6408 0 GPIO_ACTIVE_HIGH>;
> +               enable-active-high;
> +       };
>  };
>
>  &adc1 {
> @@ -502,6 +521,7 @@ &netc_blk_ctrl {
>  &netc_emdio {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_emdio>;
> +       phy-supply =3D <&reg_aqr_en>;
>         status =3D "okay";
>
>         ethphy0: ethernet-phy@1 {
>
> --
> 2.37.1
>
>

Hi Peng,

I'm not sure where you are with regards to this patch but it indicates
to me that you may have the enetc_port2 10G port with the AQR113 PHY
working on the imx95-19x19-evk with upstream Linux. If so I would be
interested in knowing what other patches you have for that. I'm seeing
the interface fail to register with:
nxp_enetc4 0002:00:10.0 eth2: PHY has no common interfaces

I'm wondering if there is some support missing from enetc or the
aquantia phy required to work with 10gbase-r.

Best Regards,

Tim

