Return-Path: <linux-kernel+bounces-745775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0650B11E61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C18947AB4E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8B8248F67;
	Fri, 25 Jul 2025 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OZdJCH6T"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DC24679B
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 12:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753446095; cv=none; b=rSkDfZPL5XGGvtR1mnNT761r+aKpbQyX1X2UDTC/9GBI7uAr6AFyBdPNOaOddQ+QF0JI2do/6e+LHOYBE4ceMh6dxsM0kLEhpqkvoCqKCKqjKqmfcTyiHSuxZeQ7+IxTWpamQtsrsvh2qWcZ+qg9E51RVOjtGmo2ak3oAJFYveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753446095; c=relaxed/simple;
	bh=IU7jvnAwzmp5GuJHgplXAk58lqyd9tH4hjc214tIw4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZzLmvQw2v4eZZxVzay1cFwIUvRYtOE27rCGUvzrjAfDQxutjEjROKWd65ZiIgbTSW+eqTQ6fTyHtf+BBpke5QhMpA48Bkh4b+ttxFz/weCwzVs1L315xQObSBkOSPNkRoC6wcOeeIso35T1J8ob4UAq8OhiXSjL/gdr7nvAhx+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OZdJCH6T; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8d713e64c5so2011522276.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753446093; x=1754050893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liSvRWA4OuPhKZFuMFSYIULFcTNts/JUeGi4znSdmNM=;
        b=OZdJCH6TvEUA2ixO1587TFylKj8CCv1rHtCXBX5+lAjJyIeuflDwatSK0U8cVy6EmW
         9McVVd0unXPpKHO4LgkqKCf2M29jT64U8YAyTMsYzaMN3AVQZdIfiHkoKeKIxdtsDU3Q
         F82ggCW/G1GfZg3QG4Ru0SxLWmKC1a/okBJRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753446093; x=1754050893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liSvRWA4OuPhKZFuMFSYIULFcTNts/JUeGi4znSdmNM=;
        b=QFQ2FEadKgiQo6vVS952WRFpXc3alp+mVekpdvrt+RbNuwihzhglIHSY7Fhq0yZlh3
         us2m0iDTow15mY7I26R8aCVezaxS67v5yJjFh6NyvVXVorZ5I023UM4S/45rzCO6XoDK
         LV1TOIRVUPHJQPIPGc/tE/yUqFQcjU9QNu1J2vJVgqPVA5YmAM08fKcOMz/K8r+KamdH
         kaLHu/m55hKKRq7Xx+J/qmCl0RJ86y9CdvbPRyWGoaVtyEfD85gdGfmAiW7r85nmRsKP
         DEXNg5PiGEm1zyVlyyxF/9DyZUR3/LZwcyLG+73AtaVXC/yAC+bog3Vob04EJrLWrPtx
         D8VA==
X-Forwarded-Encrypted: i=1; AJvYcCUJpkFrvopN1URHqR/VQLUDFCSnLsxuekPHlLoa6DTgjBkpNPTCazJfAaj/D0gXfuhvnf6QnBBohLTeUd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYNb2mtRJtUUrBLvH+zXDWQwe5JAjvLF1NpNkDO34O3MRCE+Uw
	bX7665cZuUaqddLdGReDW9XNmi7iY22YVxVxeN0EjbXhEA6H9mqq4WzdLSjg7EhP75mGrWnNchD
	1LXs=
X-Gm-Gg: ASbGncvoQTbusw/D49Ylosc+CwAy6XLXL4TzGosbCkJYy7kABB1RflaEfxJ/i3BfZCM
	p7MJh5k1xGVT6niCl0WcSAfTGJl9a8MRcrEn+NAk8lFKHizlTsqkx80zZV2Fy1rkq1d1VbdtaJu
	CKk7N2FkjmfrBZZjRfu2tp7pNEIc8mNdH4C8PVI5gGpm882cemYUFsN56U1Sy30mJxRKH6Gj2iW
	4BiNXXzjnZFHfaUlaanH/NWx3lQBd66nFAqzNtLwuCfTKqxd0D0IBjZfPcdeJm++KHUzMpXK3U7
	QWu1qVlCueMzV5QbrmQ1UbBYCrSeijNKcpfwedZTZuEZH4D6FLjP06y1e+8tnY7eLqLsPot6o+U
	IHsRSNZMVbQvDxZh0IJB3sYiVGzmBFwgHUhTeWNJd0EXTl98638Y3tB6eMoAv1g==
X-Google-Smtp-Source: AGHT+IE03STTaZPW7ZTnj+67wv49H9TW07gQQW20uFRMve6PTN8hvLFViFzbH9dxeAlrEKhJHl90MA==
X-Received: by 2002:a25:1106:0:b0:e85:1e91:562c with SMTP id 3f1490d57ef6-e8df1135441mr1287931276.14.1753446092479;
        Fri, 25 Jul 2025 05:21:32 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8ddf54ee4asm1110231276.49.2025.07.25.05.21.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:21:32 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e8d157c946eso2067974276.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 05:21:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3Z6nsEjS7xUC5ZLAn1u6hcNkrRkt63ykTnwNUxPpMEsk1SscPnUbr07QfJ71zWYN/PJU6v/nmGppbV5U=@vger.kernel.org
X-Received: by 2002:a05:6102:6891:b0:4dd:b82d:e0de with SMTP id
 ada2fe7eead31-4fa3ff44195mr308667137.17.1753440019738; Fri, 25 Jul 2025
 03:40:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-38-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-38-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:39:43 +0800
X-Gmail-Original-Message-ID: <CAC=S1njv7qrL0LyhZsp=HVdxxDo2bA7FbCkMVqJ9R9qpg-0hMw@mail.gmail.com>
X-Gm-Features: Ac12FXzAeqGgOrEJjRR1J4ryO0U3L8RJWv4_H_TyT4RYPsIpmGY3ViSbTr41uno
Message-ID: <CAC=S1njv7qrL0LyhZsp=HVdxxDo2bA7FbCkMVqJ9R9qpg-0hMw@mail.gmail.com>
Subject: Re: [PATCH 37/38] arm64: dts: mediatek: mt8395-kontron-i1200: Fix
 MT6360 regulator nodes
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-mediatek@lists.infradead.org, robh@kernel.org, 
	daniel.lezcano@linaro.org, mwalle@kernel.org, devicetree@vger.kernel.org, 
	linus.walleij@linaro.org, linux-remoteproc@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	olivia.wen@mediatek.com, shane.chien@mediatek.com, linux-gpio@vger.kernel.org, 
	linux-phy@lists.infradead.org, airlied@gmail.com, simona@ffwll.ch, 
	herbert@gondor.apana.org.au, jassisinghbrar@gmail.com, jiaxin.yu@mediatek.com, 
	andy.teng@mediatek.com, chunfeng.yun@mediatek.com, jieyy.yang@mediatek.com, 
	chunkuang.hu@kernel.org, conor+dt@kernel.org, jitao.shi@mediatek.com, 
	p.zabel@pengutronix.de, arnd@arndb.de, kishon@kernel.org, 
	kyrie.wu@mediatek.corp-partner.google.com, maarten.lankhorst@linux.intel.com, 
	tinghan.shen@mediatek.com, mripard@kernel.org, ck.hu@mediatek.com, 
	broonie@kernel.org, eugen.hristev@linaro.org, houlong.wei@mediatek.com, 
	matthias.bgg@gmail.com, tglx@linutronix.de, mchehab@kernel.org, 
	linux-arm-kernel@lists.infradead.org, granquet@baylibre.com, 
	sam.shih@mediatek.com, mathieu.poirier@linaro.org, fparent@baylibre.com, 
	andersson@kernel.org, sean.wang@kernel.org, linux-sound@vger.kernel.org, 
	lgirdwood@gmail.com, vkoul@kernel.org, linux-crypto@vger.kernel.org, 
	tzimmermann@suse.de, atenart@kernel.org, krzk+dt@kernel.org, 
	linux-media@vger.kernel.org, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 24, 2025 at 5:51=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> All of the MT6360 regulator nodes were wrong and would not probe
> because the regulator names are supposed to be lower case, but
> they are upper case in this devicetree.
>
> Change all nodes to be lower case to get working regulators.
>
> Fixes: 94aaf79a6af5 ("arm64: dts: mediatek: add Kontron 3.5"-SBC-i1200")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  .../mediatek/mt8395-kontron-3-5-sbc-i1200.dts    | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dt=
s b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> index 4985b65925a9..d16f545cbbb2 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8395-kontron-3-5-sbc-i1200.dts
> @@ -352,7 +352,7 @@ regulator {
>                         LDO_VIN2-supply =3D <&vsys>;
>                         LDO_VIN3-supply =3D <&vsys>;
>
> -                       mt6360_buck1: BUCK1 {
> +                       mt6360_buck1: buck1 {
>                                 regulator-name =3D "emi_vdd2";
>                                 regulator-min-microvolt =3D <600000>;
>                                 regulator-max-microvolt =3D <1800000>;
> @@ -362,7 +362,7 @@ MT6360_OPMODE_LP
>                                 regulator-always-on;
>                         };
>
> -                       mt6360_buck2: BUCK2 {
> +                       mt6360_buck2: buck2 {
>                                 regulator-name =3D "emi_vddq";
>                                 regulator-min-microvolt =3D <300000>;
>                                 regulator-max-microvolt =3D <1300000>;
> @@ -372,7 +372,7 @@ MT6360_OPMODE_LP
>                                 regulator-always-on;
>                         };
>
> -                       mt6360_ldo1: LDO1 {
> +                       mt6360_ldo1: ldo1 {
>                                 regulator-name =3D "mt6360_ldo1"; /* Test=
 point */
>                                 regulator-min-microvolt =3D <1200000>;
>                                 regulator-max-microvolt =3D <3600000>;
> @@ -380,7 +380,7 @@ mt6360_ldo1: LDO1 {
>                                                            MT6360_OPMODE_=
LP>;
>                         };
>
> -                       mt6360_ldo2: LDO2 {
> +                       mt6360_ldo2: ldo2 {
>                                 regulator-name =3D "panel1_p1v8";
>                                 regulator-min-microvolt =3D <1800000>;
>                                 regulator-max-microvolt =3D <1800000>;
> @@ -388,7 +388,7 @@ mt6360_ldo2: LDO2 {
>                                                            MT6360_OPMODE_=
LP>;
>                         };
>
> -                       mt6360_ldo3: LDO3 {
> +                       mt6360_ldo3: ldo3 {
>                                 regulator-name =3D "vmc_pmu";
>                                 regulator-min-microvolt =3D <1800000>;
>                                 regulator-max-microvolt =3D <3300000>;
> @@ -396,7 +396,7 @@ mt6360_ldo3: LDO3 {
>                                                            MT6360_OPMODE_=
LP>;
>                         };
>
> -                       mt6360_ldo5: LDO5 {
> +                       mt6360_ldo5: ldo5 {
>                                 regulator-name =3D "vmch_pmu";
>                                 regulator-min-microvolt =3D <3300000>;
>                                 regulator-max-microvolt =3D <3300000>;
> @@ -404,7 +404,7 @@ mt6360_ldo5: LDO5 {
>                                                            MT6360_OPMODE_=
LP>;
>                         };
>
> -                       mt6360_ldo6: LDO6 {
> +                       mt6360_ldo6: ldo6 {
>                                 regulator-name =3D "mt6360_ldo6"; /* Test=
 point */
>                                 regulator-min-microvolt =3D <500000>;
>                                 regulator-max-microvolt =3D <2100000>;
> @@ -412,7 +412,7 @@ mt6360_ldo6: LDO6 {
>                                                            MT6360_OPMODE_=
LP>;
>                         };
>
> -                       mt6360_ldo7: LDO7 {
> +                       mt6360_ldo7: ldo7 {
>                                 regulator-name =3D "emi_vmddr_en";
>                                 regulator-min-microvolt =3D <1800000>;
>                                 regulator-max-microvolt =3D <1800000>;
> --
> 2.50.1
>
>

