Return-Path: <linux-kernel+bounces-803210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46460B45C28
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72FDF188D66B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FAE31B80D;
	Fri,  5 Sep 2025 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b="ZDEj1IOK"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D92F2E
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757085195; cv=none; b=Pp4Be3WPnIpYRMBUt1XQlNRRnM9ChCO9gn1A/uYC9J9k3QWqG5GrQdSvsDYKBGim4my29cvdjRP7niahoeR4O8mSVxoa91AE1imQnNE3DVn+g+dIbMvuUzVhoA7UCQpfy3Ahr5Y8sH65u7u4HO7RGOE9wUnwpunkFn2xIbRDzGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757085195; c=relaxed/simple;
	bh=vcbzZr+E02WokGut7C2c77Afxd5rpoCYAkJoIkII9d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDiPE6Mlumd+A3kWqg9OKdHcM61l/CaS+C7yl073UhspJCSFcU9NKQBAUV7iPmSMM8eu9jPTHIODLk90WZyE7sIjvnbQ7zuRRFvMvOakpAONR4eQXXxhTRpS9z6S3jGjYXoAkZjfFECXggMOkLEkXhu2GX70TajiW06BJc7CIuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org; spf=none smtp.mailfrom=nigauri.org; dkim=pass (2048-bit key) header.d=nigauri-org.20230601.gappssmtp.com header.i=@nigauri-org.20230601.gappssmtp.com header.b=ZDEj1IOK; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nigauri.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nigauri.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6228de280ccso566628a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nigauri-org.20230601.gappssmtp.com; s=20230601; t=1757085192; x=1757689992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHMIdxjHKuTqVD8SOr4IvDDg7ji1cX6ZfEw+vHDGWBo=;
        b=ZDEj1IOKepbUvHpZzM3m2lRtZAMUowMVafek24OUbq6KU2Yuk9ii+QaQXkAnYIQfxy
         dy9FuNETwTcYZFNdIWkYC+dGAS8toGAG6DIsn5cIHxHryC/+F7gMkkWtAapjeFtLx1VP
         I3wNPlt8z2s2OOaPvABV02Cs3iciXbstXd4dOVshdfCedPrgQmxytng1IeGb2LkZML1e
         kDiuTD+OlqBPqKOQY3qA4xVp1PzAb7YUVlT6Od9S3E9HjfP/GpRqljMBhTTtj+UX2yw9
         yFsMpTfLhX/gZ/IWde0k1nOXrsXESVYcG/g4vrVfQP0vZK/0pFrcK/raIhB9JFtF00d5
         efMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757085192; x=1757689992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHMIdxjHKuTqVD8SOr4IvDDg7ji1cX6ZfEw+vHDGWBo=;
        b=OiiaWn6l3hKtKuRw83CmrpTRUoJKvIbMFOqhS808kdgGG1Cw18wVG20eWcZc7/oJEO
         byeoIiHPaUdqWDqYxJpQQzaQMAdsUkqDy++gCKkljZqg6k+70rKkn+emlN0KrtiLzOyZ
         qUyjCUmGV6XPNtw1jLMKoKMYyKohp5sFyupFdUbHMNQcp+ZPFUhHrs6tyOpe4uzblKOQ
         gqAapXNGsjQgBr3/dDQWoTsxBjBeW/2w4pIfZ8A98WHNrPo4a8LyuTCuV6HK3Gf6rFc2
         i+Qyt9KY74/fZZd7vidBEB4p6JsW7AHU1mEefZXum3CE0aUvBeztZhf4U5rePAeHUgJe
         ovNg==
X-Forwarded-Encrypted: i=1; AJvYcCVKCOLU5W1TgAPpPduieLd+7N4eRmoJGaUkeX64eNfCVCVyGa9nB7swvCg9AwNVMZHOZ6jxL9fmSbPZcY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjMg/gGh1Y2yQIuocKti3ki/igkiHelGTWtV85chjYDCok4cwU
	KDXgJAITDNDCTg89U2wV4ihVi4SwYEIvhgrGs81yj85WJ9/eFN3jPnb5A8pkdzNVlFHxwLyzHCw
	/rHxSBYlJZ1o43z6WX7w2yUIGlFHlleiyxiT+ayY=
X-Gm-Gg: ASbGncuubY6JFylsd0XxpWJ3g2pDXU0hsCejB/OXgMf6q7lgF1BIZWtkmCj+nXyWtq8
	VLcC7GwTdBUA5swQKdkkG1wuhQMfq/1AAvq7gZh4tYP7ik+x3wm5vxBmX+zE+lqTHwoRhqGmeZD
	3Zf7orkL6JPbwP4esuZ/UtSnKVjda3x45wc3PAkXhCUC9/0hF16KHrU8Nl5RWesnlHVMeYSlA2
X-Google-Smtp-Source: AGHT+IE5RR3xHpHhW22PdOxC27cxpSABsoBUyfebHCL+SzRaex/Yg5PA4kv6ZoooBZkF06NN2M4yziw9mmi8ooK96Xw=
X-Received: by 2002:a05:6402:35d6:b0:61e:d34c:d1d3 with SMTP id
 4fb4d7f45d1cf-61ed34cd400mr10877470a12.19.1757085191500; Fri, 05 Sep 2025
 08:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241121071325.2148854-1-iwamatsu@nigauri.org> <CABMQnVJVTmnsx3RNYK01ikZ-jnn_y4pbrNAeZaKPzz0N_YFz5g@mail.gmail.com>
In-Reply-To: <CABMQnVJVTmnsx3RNYK01ikZ-jnn_y4pbrNAeZaKPzz0N_YFz5g@mail.gmail.com>
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Sat, 6 Sep 2025 00:12:44 +0900
X-Gm-Features: Ac12FXzTX4H5emedmc2ovwKAlGVEjYg6lVwTcyicNPf8FtCjYiYPI4wGLhju7oc
Message-ID: <CABMQnVJsK3wNRQfGjomggKcwL5zaqBchoAKajbVb+ZXmrwn2iQ@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: socfpga: sodia: Fix mdio bus probe and PHY address
To: dinguyen@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

ping?

2025=E5=B9=B41=E6=9C=8814=E6=97=A5(=E7=81=AB) 22:50 Nobuhiro Iwamatsu <iwam=
atsu@nigauri.org>:
>
> Hi Dinh,
>
> Could you check and apply this patch?
>
> Thanks,
>   Nobuhiro
>
> 2024=E5=B9=B411=E6=9C=8821=E6=97=A5(=E6=9C=A8) 16:13 Nobuhiro Iwamatsu <i=
wamatsu@nigauri.org>:
> >
> > On SoCFPGA/Sodia board, mdio bus cannot be probed, so the PHY cannot be
> > found and the network device does not work.
> >
> > ```
> > stmmaceth ff702000.ethernet eth0: __stmmac_open: Cannot attach to PHY (=
error: -19)
> > ```
> >
> > To probe the mdio bus, add "snps,dwmac-mdio" as compatible string of th=
e
> > mdio bus. Also the PHY address connected to this board is 4. Therefore,
> > change to 4.
> >
> > Cc: stable@vger.kernel.org # 6.3+
> > Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> > ---
> >  v2: Update commit message from 'ID' to 'address'.
> >      Drop Fixes tag, because that commit is not the cause.
> >
> >  arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts=
 b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> > index ce0d6514eeb571..e4794ccb8e413f 100644
> > --- a/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> > +++ b/arch/arm/boot/dts/intel/socfpga/socfpga_cyclone5_sodia.dts
> > @@ -66,8 +66,10 @@ &gmac1 {
> >         mdio0 {
> >                 #address-cells =3D <1>;
> >                 #size-cells =3D <0>;
> > -               phy0: ethernet-phy@0 {
> > -                       reg =3D <0>;
> > +               compatible =3D "snps,dwmac-mdio";
> > +
> > +               phy0: ethernet-phy@4 {
> > +                       reg =3D <4>;
> >                         rxd0-skew-ps =3D <0>;
> >                         rxd1-skew-ps =3D <0>;
> >                         rxd2-skew-ps =3D <0>;
> > --
> > 2.45.2
> >
>
>
> --
> Nobuhiro Iwamatsu
>    iwamatsu at {nigauri.org / debian.org / kernel.org}
>    GPG ID: 32247FBB40AD1FA6



--=20
Nobuhiro Iwamatsu
   iwamatsu at {nigauri.org / debian.org / kernel.org}
   GPG ID: 32247FBB40AD1FA6

