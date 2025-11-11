Return-Path: <linux-kernel+bounces-894919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59362C4C723
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:45:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32CDE189A5BB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6DF253932;
	Tue, 11 Nov 2025 08:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL+37iUB"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0AD4A01
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762850734; cv=none; b=osKJw1Si8lGRMdLKok1WfJxNr7OE9/CT+DPxI7qrWV7Qa66ImBYwFfsnKyrDdybov9YYdXsrsjrNuFDmESiUfOxs+Oo9jQvaKhY+X8BiNYWQJxINu2hEAri8dodIwcOOZnoG7oBun6fvICLa5cUIHGNm1VnoEReTzMW0FViqJ4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762850734; c=relaxed/simple;
	bh=3nnAWyr034dlww4gOSVC0sm7Af2ZgKc/X5ULm9PEN7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rni8bNYru6VcPT2iMikve8KFrE5w284dY3PWe1/CE54VeSWW1jCDOPgByrYrNUnTVpEQo1NklIMW++jsd6+gAcYIXESX6UPvpWdkXZYCNmLOti7AlER/Ar3MidyH2cxr0xlK1rsGaOq1OIEvPeVEL0+tuRSra/UrJoH4HNdDh0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL+37iUB; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b550eff972eso2329679a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762850733; x=1763455533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5+hmxQBj7IsYd1S8pXVYnG/VuhGQ2SVQVtQG6+CGoaw=;
        b=DL+37iUBYq2NC6GuDj5QbS9dmtbIAcXH7TR4+r8D8Ta5XT+EKK8+zFIPF76wicuL9T
         +u1q9o9w/zmluGvs+gan7Q4YSWeI9txAKet7Dr8gP8z+aWdaq6/A0uJZWXvEnc3lqU85
         rKOyCz0WVMwUmV/WUfvi0ZTRQ+rbOkrS0nhDtrl3C2NNz2+Y19GBcaAG5B4XNmOS9zfW
         dH5E/IJ0NHcnmR0Kvo6Pnamh6gSS2psh+qlV8fTKRjRlARJ+uQ6dZ189IuT5XJAjOGOQ
         A197/pSNPbMXRR5azjSNyLxqu+hRf8EM92kVav3oNdlGUYo9spv91kfRQCjGMjCSeUn3
         r8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762850733; x=1763455533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5+hmxQBj7IsYd1S8pXVYnG/VuhGQ2SVQVtQG6+CGoaw=;
        b=xPJYoqrfk4mtMTaKcYExMfNkfCZcq/lZTFBHY50vsL9cU1KXe+6YMHIbdf4ZmpyqYo
         ax6TvGT4I/IqYkDjmt+kW+HqpzfeYdshnZG3ZgUm0MJuUdhbJOQ+ahD5tACuT6oUi71m
         jwMXioILiKWUB12sBE0cUflXskroItAnXONePShYdX0U5Se3/58sIEscLSPXsOppnqOx
         a7YvDkXAUQxGYedTMZ1u2ebd3IMs2PKPH7vFM0uzse/M4eQIbEmt9XN7axBHMbwsmpJE
         nuihcsXSe6hW0uv7zClcYMR0e5Dsc5ooWwetMWZlItXnRcArLBWb+uYmccu8ApxAZJKb
         /8Gg==
X-Forwarded-Encrypted: i=1; AJvYcCUbapR7ppR1hCW5xK96D+IBt2ZHjZ8scjPTBLefe4lGvVCC+l205pN7SZSXbsKcAXRw1RAV57Qt1O866y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYsTLd0sV9sA/pFwqgxl8VMX97Hq5vYGKEZaHOvVewKrIY8LzG
	Y+7ivj9lx0xpfHtl/bdJKbLYQ68QeyxQS2JACO+k+26bIuzlywBwSlhHMk5pcG4kvqCOsfTuG6h
	/47V+bGrsNWyb6I1vO1YOmvvF9sc0PBM=
X-Gm-Gg: ASbGnctTNjsf2Wz6ZoiOf0ZTfgnmWOMN/lB7SbXk0u4T1oGroWnjFksQrN3ASTpiRzo
	6tKLuAoSEL4MpUg3qY4xlRRsjowQKRu8aidDmTep9psYkhIbVQ2GDkobNSWc+ok964SILajd7Na
	jgaApaQt5MfXTcObW4rsjgB6l1nhcj9yV68K2PH63DD4KUBEQX/mUyBHGEcAJO4H3nyeOg+2Pcd
	F/TCGGW2VIolggIWGxt9sJEVxpHQB3c1RipOvzLuHjPtL4dV2fkBStSklwWPCKkx8di
X-Google-Smtp-Source: AGHT+IEbIBPvg62Y1Iztl106EfvgBmmryD6TUmDM5qu02qmAT6MmSP20+OStlbhgquJhSpSV9FwS3gQC37Rdo9EXvMw=
X-Received: by 2002:a17:902:e80b:b0:295:7453:b580 with SMTP id
 d9443c01a7336-297e5715410mr146810455ad.58.1762850732603; Tue, 11 Nov 2025
 00:45:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com> <9d48a54c-0585-4524-b9d5-30696f5ecc8b@kernel.org>
In-Reply-To: <9d48a54c-0585-4524-b9d5-30696f5ecc8b@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Tue, 11 Nov 2025 10:47:56 +0200
X-Gm-Features: AWmQ_bkje38QBVH41X3V5QeZd3T9fbYsWDLt3kUsgCWuUpLG1ylXQ7gyr6WQwdA
Message-ID: <CAEnQRZCvpXzGt=7NGv7-s+y0gvOg7Jx4OqbfbW3uv8jDp-jroQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, alexander.stein@ew.tq-group.com, 
	dario.binacchi@amarulasolutions.com, marex@denx.de, 
	Markus.Niebel@tq-group.com, y.moog@phytec.de, joao.goncalves@toradex.com, 
	frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaofeng Wei <xiaofeng.wei@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 10, 2025 at 10:12=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 09/11/2025 22:45, Rogerio Pimentel wrote:
> > The FRDM-i.MX8MP is an NXP development platform based on the i.MX8M Plu=
s
> > SoC, featuring a quad Cortex-A53, Cortex-M7 co-processor, 4GB LPDDR4,
> > 32GB eMMC, Wi-Fi 6/Bluetooth 5.4/802.15.4 tri-radio, Ethernet, HDMI/MIP=
I
> > display interfaces, camera connectors, and standard expansion headers.
> >
> > Based on the device tree found in the NXP repository at github
> > https://github.com/nxp-imx-support/meta-imx-frdm and on imx8mp-evk
> > board kernel mainline device tree.
> >
> > This is a basic device tree supporting:
> >
> >  - Quad Cortex-A53
> >  - 4GB LPDDR4 DRAM
> >  - PCA9450C PMIC with regulators
> >  - Two NXP PCAL6416 GPIO expanders
> >  - RGB LEDs via GPIO expander
> >  - I2C1, I2C2, I2C3 controllers
> >  - UART2 (console) and UART3 (with RTS/CTS)
> >  - USDHC3 (8-bit eMMC)
> >  - SNVS power key (onboard power button)
> >
> > Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
> > Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
>
> Incorrect DCO chain. Please look at submitting patches which explain
> what is DCO and how it should be organized.

In addition to that, Rogerio please read:

https://docs.kernel.org/process/submitting-patches.html

At this moment I think you should keep the original author of the
patch.

Then mark your contribution as follows. If you just picked the patches
tested them and made minor modifictions only add your S-o-b

e.g

Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>

If you made significant changes add your C-d-b like this:

Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>
Co-developed-by: Rogerio Pimentel <rpimentel.silva@gmail.com>
Signed-off-by: Rogerio Pimentel <rpimentel.silva@gmail.com>

