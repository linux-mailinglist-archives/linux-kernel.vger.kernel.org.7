Return-Path: <linux-kernel+bounces-745653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 383BCB11C91
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 527A4586CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FBA2E5432;
	Fri, 25 Jul 2025 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FzXxnfWQ"
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1532E1C5D
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439657; cv=none; b=Xgk2toKN3H8Id8YEOvwUU5OSYp6D5QLjdsfVQpxQBYoEwm2LcjikJVd/RPjZj72afsxNLKxgvYEz6JA0jsR24VCYbRtaM8AXfuqGRLNM3sA6JDmIcEHpwi92tS4xc+2CcG08rdcBiNBPPgf0nN1+7tOsllxFDjGHxDO0ar5IaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439657; c=relaxed/simple;
	bh=yYEFudnuqhhtZ+sqQ+TFTlE2skKtiAAPYNG8FKAlAuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QxnuNEsuWG3DQor14jdkd6L9iW51qhZqf4DuXbttdh5D0dJSXd61tjRVLpfIuJS9hdO9Rojs5w5aM8tti+bXazP/v/8D5apmCbkXtZAWVAhs1iroq5NllCIl2RGlpgmHfOj3j3I68k1HD2YFh2qTiMUXxu4o0ywTJ/UWT54NjFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FzXxnfWQ; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-87f161d449dso1258785241.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753439654; x=1754044454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=29HDb0CStjqCTbdMTaT8ki881uLabi0viRhzF0Cw5Io=;
        b=FzXxnfWQmrcrnzl2wVEnHwMDIGsJFF86UzbsoTWK2z0V61FS4G7tWsyz2lDY6Vk1fM
         3JEvuqSx8PlAVp+FIH0lDzStc3fBUVeCbowVswPSNMJHhnOcwuq+4fPtmPL8xWAe36iy
         bZOhzaR2E/B2de6MR3KctMBbs1OUsim77wvaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753439654; x=1754044454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=29HDb0CStjqCTbdMTaT8ki881uLabi0viRhzF0Cw5Io=;
        b=ZDNm2pRdnB+hwqHw3u2No1rQh2nomXwv+NFlj0TLi7rmeaRZlWBr6R1qvi2iaNPHj3
         AAiPMo5Jp9mcz1q/CQhvlGX6AcAN0uInbxe/BScybpH4S7inVy8t9iNVKHTNNMqLBTmK
         +ap9R6m4ud3XqA6fOOKrSHy+wihyRZ4cE7UqmHjafWgxp1MZjCXoI9VVKdozCf2Mi0Jo
         JIgiP1N0MBP4j/IAxOw/q9DNiL8SVRddnl+kYS3QtePIy9fjM3qEl3Fi1O9srHiWZcxY
         HFMpyHVklZ0XGfDfxepth6BSgN6fFyEepZ13oRizaFNuhwM9jQAXctVnagsKLFsgtQ55
         O8IQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBQC+tOherXxGtGDfTpr5hka9pU7xsCUKFEq4ZrC/LfHEzB04UJWKGvNmXjlYsenP/Ux5n9ahNXJi3mbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YywzsYMnU3tAf4V4wU/9IGWw64EpmsY+blTXxLQG8cOo0mWIc7Z
	aRQmcxY0hgb3Icb3yAQ2BJSCdrjjfqO7JMYDwKmsWa5jHhNSCwbmhsKZWTwx+D4+jFtGwHOEcc7
	gJxNW/A==
X-Gm-Gg: ASbGnctiZ0N3hU4IpmKrCkCAjhlny4Gam/4mwRhIBSI/t3Qcp79P5JqXv3CNkm+czuk
	D6tKcV2cQ6kbxj0nk37aMgTQir4GnQdFYk+l3PeYFb7wwpgAYY86t9I9uhBp4wUUd6kZeACpJxH
	TIxhBZU/Ie4bk+tHWfvRupdgPNm+F3qM5kmdwOl5SfDEaVC4SXrq/Bfq5cOQn99rYN0gq67os8s
	bqsHCnTDErfMyWsdE+7HyOraeZV2gCJSQHigzCe6kr1XVz2eFVgyXRxCeuTbSOa8ERfFhBF0zMh
	a36KaSQSlC5ak+W6HwfgJNCr5pegnYXhHrSh2VxAQu5Cyk1acY/M9PDzj0NkeCjcHWF6WCuLNz3
	IezBdWUaVJgCFd8EozCUcmyc4QCjX5COxuczoufnxaBQL77AECA0JrouzOZaunYUF1XRX
X-Google-Smtp-Source: AGHT+IEURzKma6heiBr+o5aqFRfDrxWmNMqSa1rlI/+4xE917asax5WIoUoywRoapqpZYZswYdTI5A==
X-Received: by 2002:a05:6102:3ca1:b0:4e7:866c:5cd2 with SMTP id ada2fe7eead31-4fa3fa677bbmr309300137.2.1753439653214;
        Fri, 25 Jul 2025 03:34:13 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-537bf605ad6sm897466e0c.6.2025.07.25.03.34.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 03:34:12 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e9a109035bso1411654137.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:34:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUj73kHvnxdwRkZu3jRKurDXFj/T2KN9RGERhUphITbLJ+dlKTf+3o/qzA2mIVs8603grMCgUsCHNyJw0Y=@vger.kernel.org
X-Received: by 2002:a05:6102:5799:b0:4e5:ade7:eb7c with SMTP id
 ada2fe7eead31-4fa3fac29femr330925137.12.1753439652105; Fri, 25 Jul 2025
 03:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250724083914.61351-1-angelogioacchino.delregno@collabora.com> <20250724083914.61351-35-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250724083914.61351-35-angelogioacchino.delregno@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Fri, 25 Jul 2025 18:33:36 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhfg_qD044bO8EOV=MckoNVtJXQ47XBeDFMPwJ9goHg-A@mail.gmail.com>
X-Gm-Features: Ac12FXyYX3cOTb6n6096sUC59Z8DCV1ifB6_qbpW9gH46tmstAs2fiwwoJYhrGs
Message-ID: <CAC=S1nhfg_qD044bO8EOV=MckoNVtJXQ47XBeDFMPwJ9goHg-A@mail.gmail.com>
Subject: Re: [PATCH 34/38] arm64: dts: mediatek: mt8195: Fix ranges for jpeg
 enc/decoder nodes
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
> The jpeg decoder main node is under the soc bus but currently has
> no ranges or reg specified, while the children do, and this is
> wrong in multiple aspects.
>
> The very same is also valid for the jpeg encoder node.
>
> Rename the decoder and encoder nodes to "jpeg-decoder@1a040000"
> and to "jpeg-encoder@1a030000" respectively, and change their
> children to use the newly defined ranges.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Despite now jpeg-encoder isn't sorted in order, I guess we all agree
it's much easier to read in this way, so

Reviewed-by: Fei Shao <fshao@chromium.org>

> ---
>  arch/arm64/boot/dts/mediatek/mt8195.dtsi | 30 +++++++++++++-----------
>  1 file changed, 16 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/d=
ts/mediatek/mt8195.dtsi
> index dd065b1bf94a..35b10082bb89 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -3014,7 +3014,7 @@ venc: video-codec@1a020000 {
>                         #size-cells =3D <2>;
>                 };
>
> -               jpgdec-master {
> +               jpeg-decoder@1a040000 {
>                         compatible =3D "mediatek,mt8195-jpgdec";
>                         power-domains =3D <&spm MT8195_POWER_DOMAIN_VDEC1=
>;
>                         iommus =3D <&iommu_vdo M4U_PORT_L19_JPGDEC_WDMA0>=
,
> @@ -3025,11 +3025,12 @@ jpgdec-master {
>                                  <&iommu_vdo M4U_PORT_L19_JPGDEC_BUFF_OFF=
SET0>;
>                         #address-cells =3D <2>;
>                         #size-cells =3D <2>;
> -                       ranges;
> +                       ranges =3D <0 0 0 0x1a040000 0 0x20000>,
> +                                <1 0 0 0x1b040000 0 0x10000>;
>
> -                       jpgdec@1a040000 {
> +                       jpgdec@0,0 {
>                                 compatible =3D "mediatek,mt8195-jpgdec-hw=
";
> -                               reg =3D <0 0x1a040000 0 0x10000>;/* JPGDE=
C_C0 */
> +                               reg =3D <0 0 0 0x10000>;/* JPGDEC_C0 */
>                                 iommus =3D <&iommu_vdo M4U_PORT_L19_JPGDE=
C_WDMA0>,
>                                          <&iommu_vdo M4U_PORT_L19_JPGDEC_=
BSDMA0>,
>                                          <&iommu_vdo M4U_PORT_L19_JPGDEC_=
WDMA1>,
> @@ -3042,9 +3043,9 @@ jpgdec@1a040000 {
>                                 power-domains =3D <&spm MT8195_POWER_DOMA=
IN_VDEC0>;
>                         };
>
> -                       jpgdec@1a050000 {
> +                       jpgdec@0,10000 {
>                                 compatible =3D "mediatek,mt8195-jpgdec-hw=
";
> -                               reg =3D <0 0x1a050000 0 0x10000>;/* JPGDE=
C_C1 */
> +                               reg =3D <0 0 0x10000 0x10000>;/* JPGDEC_C=
1 */
>                                 iommus =3D <&iommu_vdo M4U_PORT_L19_JPGDE=
C_WDMA0>,
>                                          <&iommu_vdo M4U_PORT_L19_JPGDEC_=
BSDMA0>,
>                                          <&iommu_vdo M4U_PORT_L19_JPGDEC_=
WDMA1>,
> @@ -3057,9 +3058,9 @@ jpgdec@1a050000 {
>                                 power-domains =3D <&spm MT8195_POWER_DOMA=
IN_VDEC1>;
>                         };
>
> -                       jpgdec@1b040000 {
> +                       jpgdec@1,0 {
>                                 compatible =3D "mediatek,mt8195-jpgdec-hw=
";
> -                               reg =3D <0 0x1b040000 0 0x10000>;/* JPGDE=
C_C2 */
> +                               reg =3D <1 0 0 0x10000>;/* JPGDEC_C2 */
>                                 iommus =3D <&iommu_vpp M4U_PORT_L20_JPGDE=
C_WDMA0>,
>                                          <&iommu_vpp M4U_PORT_L20_JPGDEC_=
BSDMA0>,
>                                          <&iommu_vpp M4U_PORT_L20_JPGDEC_=
WDMA1>,
> @@ -3088,7 +3089,7 @@ vdosys0: syscon@1c01a000 {
>                 };
>
>
> -               jpgenc-master {
> +               jpeg-encoder@1a030000 {
>                         compatible =3D "mediatek,mt8195-jpgenc";
>                         power-domains =3D <&spm MT8195_POWER_DOMAIN_VENC_=
CORE1>;
>                         iommus =3D <&iommu_vpp M4U_PORT_L20_JPGENC_Y_RDMA=
>,
> @@ -3097,11 +3098,12 @@ jpgenc-master {
>                                         <&iommu_vpp M4U_PORT_L20_JPGENC_B=
SDMA>;
>                         #address-cells =3D <2>;
>                         #size-cells =3D <2>;
> -                       ranges;
> +                       ranges =3D <0 0 0 0x1a030000 0 0x10000>,
> +                                <1 0 0 0x1b030000 0 0x10000>;
>
> -                       jpgenc@1a030000 {
> +                       jpgenc@0,0 {
>                                 compatible =3D "mediatek,mt8195-jpgenc-hw=
";
> -                               reg =3D <0 0x1a030000 0 0x10000>;
> +                               reg =3D <0 0 0 0x10000>;
>                                 iommus =3D <&iommu_vdo M4U_PORT_L19_JPGEN=
C_Y_RDMA>,
>                                                 <&iommu_vdo M4U_PORT_L19_=
JPGENC_C_RDMA>,
>                                                 <&iommu_vdo M4U_PORT_L19_=
JPGENC_Q_TABLE>,
> @@ -3112,9 +3114,9 @@ jpgenc@1a030000 {
>                                 power-domains =3D <&spm MT8195_POWER_DOMA=
IN_VENC>;
>                         };
>
> -                       jpgenc@1b030000 {
> +                       jpgenc@1,0 {
>                                 compatible =3D "mediatek,mt8195-jpgenc-hw=
";
> -                               reg =3D <0 0x1b030000 0 0x10000>;
> +                               reg =3D <1 0 0 0x10000>;
>                                 iommus =3D <&iommu_vpp M4U_PORT_L20_JPGEN=
C_Y_RDMA>,
>                                                 <&iommu_vpp M4U_PORT_L20_=
JPGENC_C_RDMA>,
>                                                 <&iommu_vpp M4U_PORT_L20_=
JPGENC_Q_TABLE>,
> --
> 2.50.1
>
>

