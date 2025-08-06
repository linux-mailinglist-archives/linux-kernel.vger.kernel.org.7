Return-Path: <linux-kernel+bounces-757404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EABB1C1C3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59401863A1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353E9221269;
	Wed,  6 Aug 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0cJ457d"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B834921FF51;
	Wed,  6 Aug 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754467360; cv=none; b=o0WGlwgi3ozqKngUj8W85cVMTqyFuMomte36jFIy1fqYNQjrJJRyE/JVwwe5kJPDj3tsStlO7z8lws3UW39RjOtpLHtMFG87di9Qol6Jb92dzCLJjeEoTeTVCBy0dDvhGw6rVvy5G1lkghIXbZf7N2sFGf2jAR0RXvAM4U/8sXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754467360; c=relaxed/simple;
	bh=g5Pp+VJlzgFB1+FSMT3UFu4fLoBCQz4aRzT3a+Kvg6k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kjC1kAqNsafQOOlNQFdp0fUis0i2vSehGx6sfJu1AO5g2Ii04Dy8nPGoZuY6Q88bS4AODBOjdX6Uk5EbtrXk8d2bhtiJJh25NkiqI9mhQLlVOPzFr/aW6eImLNkyOD+ihQKeGFCtKzGZKyHHWOfgQhfSTsoo2nXDQgWKNfdGNWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0cJ457d; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-615398dc162so11307185a12.3;
        Wed, 06 Aug 2025 01:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754467356; x=1755072156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+BQBZ9mG3r8g8Z8ux87XZsQLdiS0Ur33NaYL2k9WZM=;
        b=k0cJ457dp9eK+AS8recmIXBTjqGcVlPJtj62krfekuOJFF46wFhzIiy49bzW1mi+si
         /qfNbibw3nQsYhUoGO9XIUx8Hxa/euHlKoI8AFYdbJ1VHsHg2oy3KIHhbS+efBiLYI16
         eTXrCyyfDZtOeycSOxb9AXnwTKIdmYSmNv+8WgEc3X3KBjcIKXCn+xMkeebgkKk9VnEe
         KZ6iSbCT4pvZ0Tppnj09AkpAo7M2ivjob5m/dvJzLl9DJSS4hszq6XN7nek6Sw6pD8Ow
         rAb2H/0a9+YRdJyL493aF675c5Thn+9A3W6Kmjti48MkpaMJ1DRGONAaid4eGQN9S32o
         mgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754467356; x=1755072156;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+BQBZ9mG3r8g8Z8ux87XZsQLdiS0Ur33NaYL2k9WZM=;
        b=A80lrdHGvP/tDuZ/TrjbvxHwK0digbVHlravS/UXUReDu8SBFcjW3sYV10wbLMOU/Q
         n7dKWJTBOAEWzg6gAvhUytrwtf8atvvvy+DtB0qGd0at8B3rlSbrOjyg8nndUWVyl5V3
         wifzbNlAhISRqBhv3ejXM/PAzUV0b7rLNlP74na+VgF2qQuS5oAm0DyhLkiwcCVXqr1E
         UCdOSKc/TQyUoUQ7kQ32rCXC1uIA30sDpMbyri3QRmEEpjN9LoVF2c5PI0sTXt3eA0Fq
         2xz1/CisS7S+VPDu8rUY1vpnMK9BsyfdMx0EZliwQcSv0dQy8rE3BLLPfoJNy2c08P/X
         aUCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMmzAeONcQ1GBsdzxIPHuhxpGSoP1KlVqaP5rAozFq0OMdum3XRzjjWyWJ86M0GbaNuxr1LKn5glnc@vger.kernel.org, AJvYcCXdr/nIQCitcRlj+cvWSoI1JVpLAu8p9TarY9ZbbopEJOTK6EZngkeoTDFlbKaYZEWzL7QYW52zNe1Wre1o@vger.kernel.org
X-Gm-Message-State: AOJu0YzFgYHCXbv0438m7RKZi7TQDal/1yaIM7WC/yg9PfL2H86VYjht
	AzAgWW80h6uHhgm9P4LFoUgl5zh8HHk4n5EvtyZDx7aEitMv7pr1BcA/8gUQwcEMZ69dstGvGUJ
	/zSiCkqei0vrbuk1LcdqceHcRSOlriIg=
X-Gm-Gg: ASbGncv1jkdUzaxs7a4CFShlcW/oDnORoB6Cq36B5B7nURalKZ7P2MmZsxIB3bcY3V2
	KrOuCflHsqXTYonx8P139FTjF0qmAgBxGM5ZAfughJ6IlI8SW5By3dTqj+F5ip6x0wdPOoXpXz9
	hPeeOQUguDpA4XgEm/PhuHgb0RZmZB7znYqvwyNXyJ/4XO8AwyJTTp0pnBGe80VlAnkQh3hAhX9
	EiJUdPr
X-Google-Smtp-Source: AGHT+IFD4X0byf602nADPBsKiAQLFDAiRC9TUU40lAq/ZCTpU6bR09x0oY7ZhxA4B8X5VLMex/+d/Zi80UJ5Alpt8NI=
X-Received: by 2002:a05:6402:3591:b0:615:8ab1:9c92 with SMTP id
 4fb4d7f45d1cf-61796159531mr1447474a12.21.1754467355532; Wed, 06 Aug 2025
 01:02:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731-ums9230-drm-v3-0-06d4f57c4b08@abscue.de>
 <20250731-ums9230-drm-v3-2-06d4f57c4b08@abscue.de> <175424005938.523766.7181495703090197785.robh@kernel.org>
In-Reply-To: <175424005938.523766.7181495703090197785.robh@kernel.org>
From: Cixi Geng <gengcixi@gmail.com>
Date: Wed, 6 Aug 2025 16:01:57 +0800
X-Gm-Features: Ac12FXzzmyNFSW-GAa7ORzdn2Ncnq6gmb7eKB9qLWiH4giH7zpoSz4OF3UOCSYM
Message-ID: <CAF12kFtpXdw7UyFvdFOZ+kzfYrRLLOt4Cpeg54TC3rHMwefz6Q@mail.gmail.com>
Subject: Re: [PATCH v3 02/16] dt-bindings: display: sprd: use more descriptive
 clock names
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>, 
	Orson Zhai <orsonzhai@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, Kevin Tang <kevin3.tang@gmail.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Simona Vetter <simona@ffwll.ch>, 
	linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
	Conor Dooley <conor+dt@kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, 
	David Airlie <airlied@gmail.com>, Russell King <rmk+kernel@arm.linux.org.uk>, 
	Kevin Tang <kevin.tang@unisoc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Eric Anholt <eric@anholt.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Rob Herring (Arm) <robh@kernel.org> =E4=BA=8E2025=E5=B9=B48=E6=9C=884=E6=97=
=A5=E5=91=A8=E4=B8=80 00:54=E5=86=99=E9=81=93=EF=BC=9A
>
>
> On Thu, 31 Jul 2025 17:51:15 +0200, Otto Pfl=C3=BCger wrote:
> > Introduce new clock names that actually describe what the clock input i=
s
> > used for instead of referring to a specific clock source.
> >
> > The new clock input names are based on information from clock drivers
> > such as drivers/clk/sprd/ums512-clk.c. The 128M clock appears to be
> > CLK_DISPC0_DPI, the clock used for the DPI output from the DPU, while
> > the 384M clock is CLK_DISPC0, the actual DPU core clock. The DSI
> > controller's 96M clock is most likely CLK_DSI_APB, the APB clock used
> > for accessing its control registers.
> >
> > Since it seems possible to configure different frequencies for these
> > clocks, the old bindings do not even accurately describe the hardware.
> > Deprecate the old clock names.
> >
> > Signed-off-by: Otto Pfl=C3=BCger <otto.pflueger@abscue.de>
> > ---
> >  .../bindings/display/sprd/sprd,sharkl3-dpu.yaml         | 17 +++++++++=
++------
> >  .../bindings/display/sprd/sprd,sharkl3-dsi-host.yaml    | 11 ++++++++-=
--
> >  2 files changed, 19 insertions(+), 9 deletions(-)
> >
>
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
>
>
Reviewed-by: Cixi Geng <cixi.geng@linux.dev>

