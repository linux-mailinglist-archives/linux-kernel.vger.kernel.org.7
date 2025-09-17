Return-Path: <linux-kernel+bounces-821003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 025A0B80047
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C481B2041A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F692D8375;
	Wed, 17 Sep 2025 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="iPeTG/S7"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB942BE7CC;
	Wed, 17 Sep 2025 14:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758119183; cv=none; b=dT11vjdY8vI8FQeFq2j7z00Enfqa+KfG0msV96IrjuYU/eJzxxjjzKYmkx1kdVWRMs1N2CExWkzdh1tV/H/epEbJQzqZa0uxkMYl7W4WTdMvrKL3b7WRzEq59ILgHuyFdJ1dQvngngK0AgQkazFYGD0b0Xrf5O6z43mMOKuj+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758119183; c=relaxed/simple;
	bh=TR78DtXxPqTbF32P0w4pzB/KzzVQFhn8kipZmGGzaKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FmQL7xN09dJii1tmugaoRi8nKN2ymiQdXA2pd7X6V7ND0ZDNRNrRuCUQMujyWs2CnoRP++0U1LXm3PSH6EbtrKhrTfgj7jh1x4nkn74auclcGaZ1+ZVf06tFyPsWuWjH7njo0cOiWiZ5wL+AFYRB2XnPbT10WhihS8p69YMOUgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=iPeTG/S7; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=XBxKHfRCGcE5Q/eepg5aPjxUu8diqcOmzAvEs6SS1gU=; b=iPeTG/S7BlbqBcsqvb6s5BzW8C
	+K5i7IF5xnqnky7+WluHCxzTVYLW/nX5SZ4xz1RRqfPrwlRCIPUb2l7VwS8EZtUMDFXIBh3I1HiUV
	v6hOiPZ6kgUyWn/QyT7HAVCmge5ATcGHua9nehvN3uHnUDWteZpHXyEn6D5RGt1RDNxDKovDDrJIc
	gJg9Nsh5XBjMoTJjI3znoDVX2LidNsR2MS/d43s+VfKZ+LKV3CvGmQqADqCP5zowN84MEkKpPt0q3
	zY+XFX1H7akSvKHeWA5keKDUxePGwWuDjYuqh8Al6wqSXQWXEdYAh1OLPVtTVu1XKLDVFvdfAi6sP
	fktAFmTw==;
Received: from i53875a9d.versanet.de ([83.135.90.157] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1uyt6e-0000pg-Tg; Wed, 17 Sep 2025 16:26:00 +0200
From: Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
To: Ed Wildgoose <lists@wildgooses.com>, Dragan Simic <dsimic@manjaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/2] rockchip: dts: Enable UART DMA by adding default dma-names
 property
Date: Wed, 17 Sep 2025 16:25:59 +0200
Message-ID: <4007782.fW5hKsROvD@diego>
In-Reply-To: <7c8576e3d9fc73ba45830833f5281706@manjaro.org>
References:
 <20250917114932.25994-1-lists@wildgooses.com>
 <20250917114932.25994-3-lists@wildgooses.com>
 <7c8576e3d9fc73ba45830833f5281706@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Am Mittwoch, 17. September 2025, 14:22:52 Mitteleurop=C3=A4ische Sommerzeit=
 schrieb Dragan Simic:
> Hello Ed,
>=20
> On 2025-09-17 13:49, Ed Wildgoose wrote:
> > Kernel appears to need a dma-names set for DMA to actually enable. Set=
=20
> > a
> > default dma-names property for all UARTs defined in the base=20
> > rk356x-base
> > dtsi
> >=20
> > This is tested on a Radxa Zero 3W (which has 5x UARTs) and removes the
> > warnings and enables DMA on this platform
>=20
> Thanks for the patches.
>=20
> We should (still) stay away from defining the "dma-names" property
> at the SoC level, because doing that causes serious issues in certain
> cases.  Thus, I'd suggest that this patch is dropped, and that the
> "dma-names" property is defined instead at the board level, where
> it's needed and tested to work as expected.
>=20
> Please see commit bf6f26deb0e8 (arm64: dts: rockchip: Add dma-names
> to uart1 on quartz64-b, 2024-06-28) for further explanation.
>=20
> If/when the underlying issues are debugged and resolved, we can get
> back to defining the "dma-names" property at the SoC level.

And apart from the whole stability thing, on a number of socs the pl330
dma controller has more possible sources for dma operations than it
has available channels ... and right now the driver does not support
handling this.

So you can (and if I remember correctly we did) end up with some uart
requesting dma channels (and not needing them) and then sound not
getting any.


Heiko



