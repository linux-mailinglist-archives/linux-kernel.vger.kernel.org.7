Return-Path: <linux-kernel+bounces-895338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7DEC4D8A7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0A0D4F925A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88046333739;
	Tue, 11 Nov 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZxl9dPV"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0202D97AF
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861854; cv=none; b=lI7lcVOTeZODSArIokWAaMzuYA1s1K79put17+iV22ULv9uvcweKCuZH3eiWaaGV3acNvgejQUQg80FVvW9afU5bSVneo9raqFevjTRoZVNUEW7Jd72LMr1PnQhXCspIZqznf1c2msRCf+2JB8TRKNDxJpLSCfBr/mt+XStsgmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861854; c=relaxed/simple;
	bh=+XIJiU4GwN4u7iXICtBpRcSFrGSAAupuGFVPE5WJPKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mka7Tn9OAzXfgWNOs2JMpNa1b2egmvRD7u3XxfGpbKqSB/XoZo3+7lwaBFGvqy2r1hz29jgJ+TEiAFFpjIAas6lrahpXv4RqgDtyWqxgieCASx7wMqkA/i4inhgSrma7wU0RvE6kTV9i0PD7y+Svj429nTICLB5Z00SoxCeisrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZxl9dPV; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5943b62c47dso3685142e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762861851; x=1763466651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mv5b/xw8gYFcuSk4kaCj42BkeJNohwR9re6S4f8Ipq0=;
        b=EZxl9dPVlm2kv09762BKbSZm/R8zgUcIsc1Xy6DM4iMBCK+HhOKiESw8DHuirsy24G
         tO6YwOjr3Vt+yIA0tXpYAp/B7sEOSIP8tMaAjn4ZSenczhrhETDEko8rRPrwYsN685Ar
         bXxEncumeZrxktTgIkPm3zFvHojLADg2E3oplH3KiIGcJVHU9+c6q2GdvA4OVKtQmMth
         6o2pVKZS32goC3MR1AfxMFtiSORDRvF3z8bwrc9r/NqtTyeeBCcMcubmT0gKZ/xXcG9p
         bTDJu0UYJjduB9fOw/tYTZ+yWnihZq8AW+ff/MIk0dqad5wYAQaonZ7mI3w0fDwJXcaF
         k10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762861851; x=1763466651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mv5b/xw8gYFcuSk4kaCj42BkeJNohwR9re6S4f8Ipq0=;
        b=u+j22BMeLUgxJ3pDKVkhLHrT4y3VG/FAIQ3SYiqVc5am3V5wWSimlOHZFr8GPUJooE
         dMG8zSDw7RFRBOH6aKikbeHmzkMgQj3MsT2y+f5sXHTzNRiKX0Gi4X2vUNCmoCtvMaYN
         B8ezAj8GqYaxyzbKy4AxLM+ajn28PXpC3bSX0Mx1LjaHRcjiSkrTaqNn+sXNqTUzaYjq
         l3gdZkD2w8/G4Zo2uoFHxWjk9KHXb5mY/5ud81ors1wOtUKmdrl1laQMZL1Kohw/9U0I
         td7Dm6ilSycsiujC2y5uJ98wlZOCwI8QWwFww3TsymnFLb87w74pKZ1MkWCqvXCIeGHu
         hONA==
X-Forwarded-Encrypted: i=1; AJvYcCWa2RGMioCFjl38FjorsJPuvJvfGaXECLUsgOERFRQTUj9vywxg1+NxJLkg5E8Or7RYb1IZAsx+FzEAVAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwchO0u6LVs6ycUiNo5Has9obT8YTp537+Fio3lqVxDbrUEYVtN
	iZ1RTUBK66nMtXDQJLhyI+eiLqxaitH5rkI/T4OC9ZYP3q2v47Z73HTHmXnxkFaLMdzBjPOkjAy
	cN9j12R8eDW2T1RB/Y85G+fjmHyXP3rk=
X-Gm-Gg: ASbGncuQhz/8rE6gUPuOC5qmW2sWhb+2maK37qPVNeAGYBKvNrTSbT9gyIlcOJM4BDS
	KY43zybXTlNI6eKu87IFqTGp1I7g+Dzz7wgEn/hiWNi3glaQvrF4xhsgLqyrDiZVpg5tIqiycQ5
	fyc1sl1n/Kf1g25J/HPOLRq4kfjdvGK5QPNEvJF0rZEWBUIFaiB3T6P3D8emryvIIJEWRIMOraw
	CxfuTwTomeV34G8GdVJz0erJ9YioEJIXGYolTZvY2IkFPBqdz4bZUe2UOw/zEnlWCZkhbeMd2oY
	bVpVrfUiKpAWqYwM
X-Google-Smtp-Source: AGHT+IF88z5at8UsnN1rJmg2IhGaaNFuSng3Rlf9evtFG8rtfKiEGAp8AmRAUYBfUbuGiUayIKhWFzPcbtLj8c4U6/A=
X-Received: by 2002:a05:6512:3b06:b0:594:4e03:2be2 with SMTP id
 2adb3069b0e04-5945f19c023mr3782490e87.14.1762861851172; Tue, 11 Nov 2025
 03:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com> <9d48a54c-0585-4524-b9d5-30696f5ecc8b@kernel.org>
 <CAEnQRZCvpXzGt=7NGv7-s+y0gvOg7Jx4OqbfbW3uv8jDp-jroQ@mail.gmail.com>
In-Reply-To: <CAEnQRZCvpXzGt=7NGv7-s+y0gvOg7Jx4OqbfbW3uv8jDp-jroQ@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 11 Nov 2025 08:50:39 -0300
X-Gm-Features: AWmQ_blgZMv3waf3DojzBGgJUKYe7alAx5RXa_SxBDQp7LxHHOXCa8N82h9a1G8
Message-ID: <CAOMZO5CU09fcBB8oUOO=qC=Du3Q9gnJOQacK=6v+pnSQViex3g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Daniel Baluta <daniel.baluta@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, 
	alexander.stein@ew.tq-group.com, dario.binacchi@amarulasolutions.com, 
	marex@denx.de, Markus.Niebel@tq-group.com, y.moog@phytec.de, 
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaofeng Wei <xiaofeng.wei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Nov 11, 2025 at 5:45=E2=80=AFAM Daniel Baluta <daniel.baluta@gmail.=
com> wrote:

> In addition to that, Rogerio please read:
>
> https://docs.kernel.org/process/submitting-patches.html
>
> At this moment I think you should keep the original author of the
> patch.

Right, but NXP makes a total mess with authorship.

Please see this version from February that states the original author
as Xiaofeng Wei <xiaofeng.wei@nxp.com>:

https://github.com/nxp-imx-support/meta-imx-frdm/blob/lf-6.6.36-2.1.0/meta-=
imx-bsp/recipes-kernel/linux/linux-imx/0023-arm64-dts-Add-i.MX8MP-FRDM-boar=
d-support.patch

Then this one from July states the original author as Joseph Guo
<qijian.guo@nxp.com> and it also has:

Signed-off-by: Steven Yang <steven.yang@nxp.com>
Signed-off-by: Lei Xu <lei.xu@nxp.com>

https://github.com/nxp-imx/linux-imx/commit/fd8010b46bb00344fa519c73b643fad=
71da5887b

How are we supposed to know the correct authorship tags from the NXP
commit, then?

> Then mark your contribution as follows. If you just picked the patches
> tested them and made minor modifictions only add your S-o-b
>
> e.g
>
> Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
> Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
>
> If you made significant changes add your C-d-b like this:
>
> Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
> Co-developed-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
> Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>

Rogerio's changes are significant as the dt-schema passes now.

The NXP commit has all the dt-schema warnings found in downstream BSPs.

For example, it makes the old mistake of describing:

 spidev1: spi@0 {
   reg =3D <0>;
    compatible =3D "lwn,bk4";
    spi-max-frequency =3D <1000000>;
 };

Which is totally wrong.

