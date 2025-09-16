Return-Path: <linux-kernel+bounces-817983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F13B58AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 03:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 783943204DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 01:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228DC1E3DCD;
	Tue, 16 Sep 2025 01:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7uaZg3/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788BD27707;
	Tue, 16 Sep 2025 01:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757985724; cv=none; b=gBm36uGtue+r4JPGreGQrphzotHsBfos9uEfWbVlu2idjtto6dKWaV5GXFjjuoXQj+zyJPID81Gbr3nLomDJYXyYy1V90Gd8UbLwdaK16I4ZwfY2sdYCCO6b20S6TC6tDLjlEJcBPdfOXLPdoVbYGVZmLiyJiJk3PEPExx6cGIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757985724; c=relaxed/simple;
	bh=ibKrn2mc/fR0T5tFKwJolutZB/nooDTAjYESNCRVuvA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=q7PQx2RjYvwvtLCAWdVywCLQ8KV79JwvYuMOrF3PrvO/WOY5Z3xE6tgECcf8iCvZLoC/GRNVw1FoO2i1rpfJGJBowdXfgZPyPzaP+fr2009RZIDFwWfbI58NIdjUvDO7oXv3WBndYwsVrLJaVDg+hMDjCXh9taZcNQVW1hRl+cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7uaZg3/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF4FC4CEF1;
	Tue, 16 Sep 2025 01:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757985722;
	bh=ibKrn2mc/fR0T5tFKwJolutZB/nooDTAjYESNCRVuvA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=u7uaZg3/QT6HzAHdYt6EPB6CyYkwTxBX235X92B+1a5Qn7l4ZcNt59scn7gJPKSYA
	 zapGiBToT/OEDOVGchYetXRKlOXVfXV8Cz690RIWMyTKubenI4SSHIA9kfoy2IK6ft
	 oSF2peswNX1FwnnU7MvcrG+0+87lGpYzRsD7Vm7RlXeXi+s1WlFjKP46lStrLy59mQ
	 xpd58Hh5GcCdOv0xvsHFQmFbVPs0WSHtRMew796RJkExB192e4AosiDjbK6TzN3f5F
	 ZUb2+9tf4Bhzcc01WIgqibpu6Wx41UiF680uMVUnWfDCgsH2pMn+E3X8idpq5VE0lC
	 eTpWLyrEGr12w==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <212df54b-b3b8-454e-8d4b-e79bd9b69349@tuxon.dev>
References: <cover.1752176711.git.Ryan.Wanner@microchip.com> <f3ef0275345578c504b41710c67bfe1238c44c21.1752176711.git.Ryan.Wanner@microchip.com> <212df54b-b3b8-454e-8d4b-e79bd9b69349@tuxon.dev>
Subject: Re: [PATCH v3 01/32] clk: at91: pmc: add macros for clk_parent_data
From: Stephen Boyd <sboyd@kernel.org>
Cc: varshini.rajendran@microchip.com, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, robh@kernel.org
To: Ryan.Wanner@microchip.com, alexandre.belloni@bootlin.com, claudiu beznea <claudiu.beznea@tuxon.dev>, mturquette@baylibre.com, nicolas.ferre@microchip.com
Date: Mon, 15 Sep 2025 18:21:49 -0700
Message-ID: <175798570907.4354.6724058613129324221@lazor>
User-Agent: alot/0.11

Quoting claudiu beznea (2025-09-06 11:33:34)
> On 7/10/25 23:06, Ryan.Wanner@microchip.com wrote:
> > +})
> > +
> > +#define AT91_CLK_PD_HW(h) ((struct clk_parent_data){ .hw =3D (h) })
>=20
> Could you please update this one, something like:
>=20
> #define AT91_CLK_PD_HW(h) ((struct clk_parent_data){ \
>         .hw =3D (h), .name =3D NULL, .fw_name =3D NULL, .index =3D -1, \
> }

If you're only using a struct clk_hw * then just use clk_hws member and
not clk_parent_data member of struct clk_init_data.

