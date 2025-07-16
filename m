Return-Path: <linux-kernel+bounces-733066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0944B06FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA0983B40EF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797AA29AAFD;
	Wed, 16 Jul 2025 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hWJV2eJz"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F08299AA1;
	Wed, 16 Jul 2025 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652425; cv=none; b=JNwuopDdYpQ9m+zOjXYLHbfwGwQXUZnoVGavYHntRbPpgiGBVNDP/0XM7bZRy1nYaZE3bKRz94H6LnDaYNpPspeuhazF59xrLdgiCOY8slrLQ5THW98XddYvkY5vqKLMEP6cis4+g+X8VqSXuosDHTeqeY5NMSzxw3w1f+UmSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652425; c=relaxed/simple;
	bh=yQ8W4tKOBbaufyGXUPlSLQSpRGy76Xnn+ki5/AS1c7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IPcIy8h2odml/m2syBt6gR9O/AHZr2UWtzJqSWQ65r0tGic+ya1tQOih8UqeXk9ztgtmvUulL+CJuyVgc5ZfSV8iUOBWzUEfQWrvp3+O30tx1Yj6CQ6XCt2bTHjaICwQ6qt7p335l0ewf2nVTENS6l2muL0pEIbrtR4a7JLBi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hWJV2eJz; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso7221955a12.2;
        Wed, 16 Jul 2025 00:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752652424; x=1753257224; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mQSIMibFZ/TMYlkn3NP86VdyjZyUtByzAEI5AQ5uT8=;
        b=hWJV2eJzH877DhOrvwVUtyh6qhmaWrcxP76QzF2SJx9eCGiIkQYas0hT7B670FfQRH
         Gs1CiJBnU1dSy/AuUJ+7Q0xJN2Ew8cEcfqXOsYixyyh+tIY/a3ZAcayALTL+mD6U0DRE
         OAyEjiJoIQ/FYAUzVDCQRTUFjK00ORd5aihJrqs3LmkQDl/fr4F/ejxhQAdp+fcky9aV
         2A5C4Q3fAY2JxcD3HxcqJ5NmNqLtT6vC+BesVGcHR5qPmZWbP+WkwQkDmPs4MwskKOQu
         nN2oNlaFN9AtbUl+IB9MEiHRdsJFLcTyxk5lHWa6b0Utq9Y0XfS98EXJIMS3aMUowZQG
         RQbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752652424; x=1753257224;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mQSIMibFZ/TMYlkn3NP86VdyjZyUtByzAEI5AQ5uT8=;
        b=scevYzpy5YTxtg+RF/PfT0DE95gHOJHIsNMTLoiVPiN7EVel+VCowyXa7jXBSwazaG
         uE+xvbdYV/pIsSJIeS4fTeIiLYQOfAob7ezRMI4+BbIAFsd/aiAxBoowhQClNgDKHxO9
         XBaLtb2x8LhYeU5dvV98Gtb5q3Rx1gGNyG78bHGbqVgLOhn5mSTW91EBAKKljpEEONwQ
         S0ETjOpt9AcASimurNVrBBtxUOwD2fKfbisZTocPvsremet8a+gSag6Au23wOd27sc2u
         C3uWubDZfiSZed1DNSEa08ecXfW/tygG2i6KPghNaCl3Dlw5UP2kVKvGMWFozXur5Z5G
         JrEw==
X-Forwarded-Encrypted: i=1; AJvYcCV/4soYkOhZxTYqF3duAXXv3X9k/v5SZHxyemij1cXZJzrRqZHaIXZbcd07jtBeLBXn2AL9+aa8xoUa@vger.kernel.org, AJvYcCWy7M4Ryfp56f8Z+E3tRAsHD2teYb7P2VxdYPubV2g/09BSgaLc7N+sL5R95JYj5o5QflTrswYk45/VBAaR@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn1bxcQyLkCV4eSHSqoYm3tCoXogkFM9UYHfxepOs4PR82+qIS
	dvJuFI4xDCsAS0GyB9hRKyRZ+BROEVPHwV5my9AzU8Ss5WC82L230olHw83+N22Isa4Qpy1VipJ
	1sil9+uuv2ZvEkZTfQlWYLV3Lsm42u1M=
X-Gm-Gg: ASbGncuOEVO3PBP24sikgG2qfLiAwyUpvDoBfvCNacHk1aKYlFGxiF4DPkYEFBvcCxH
	4JTcO06dWNOvs4d9A7vtdT1EwH61xcecii5+jaog4fKdvfSY3M+EU/V4XLBJV9c5iwKKOxbqToa
	kx3pZmRv6micyZRpuzdSnrT/mupDfD70GLpql7vh4cwVeGolDH9VbDIhaU+/Z5ST7AVneYJ64C2
	Xgf
X-Google-Smtp-Source: AGHT+IEXwgMmdV6xEntZIOiDCK4p/KU6t+w3ykBD7q7iq7lKJ8kq6kVxuuaWbxPblQ1N02rsyHmz1iURll1P3lWiuoI=
X-Received: by 2002:a17:90b:1fc3:b0:311:e5b2:356b with SMTP id
 98e67ed59e1d1-31c9f3fbc0emr2790269a91.11.1752652423706; Wed, 16 Jul 2025
 00:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
In-Reply-To: <20250716061114.2405272-1-shengjiu.wang@nxp.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 16 Jul 2025 10:55:49 +0300
X-Gm-Features: Ac12FXz2s0GqTrCwZD5uR0yMTDXd0dpIYCyNX1v8FM1fPc4DXQYF5RSC8ANNnPs
Message-ID: <CAEnQRZC=qApo9C0zBDQoxpV56atLeXpoxZdyBuQ=o2y59YJEqA@mail.gmail.com>
Subject: Re: [PATCH 0/3] arm64: dts: imx8m: support more sample rates
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	shengjiu.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 9:11=E2=80=AFAM Shengjiu Wang <shengjiu.wang@nxp.co=
m> wrote:
>
> The wm8524 codec is connected to the SAI interface. There are two audio
> plls on i.MX8MQ, i.MX8MM, i.MX8MN, one pll can be the clock source of
> 44kHz series rates, another pll can be clock source of 48kHz series rates=
.
>
> Shengjiu Wang (3):
>   arm64: dts: imx8mm-evk: support more sample rates for wm8524 card
>   arm64: dts: imx8mq-evk: support more sample rates for wm8524 card
>   arm64: dts: imx8mn-evk: support more sample rates for wm8524 card

Hi Shengjiu,

I think it would be useful to specify which are the current supported rates
and which will be the ones supported after your patch  (in the commit messa=
ges).

On NXP BSP you can run:

../../unit_tests/Audio/mxc_alsa_hw_params.out hw:X,Y p r

to get the rates.

