Return-Path: <linux-kernel+bounces-774895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC5DB2B8EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:45:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17924681E24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:45:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFBC421ADAE;
	Tue, 19 Aug 2025 05:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="bFJkWlin";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Hj+nbwMM"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED8A3451C7;
	Tue, 19 Aug 2025 05:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582349; cv=none; b=GKiQYPNJVKo/HWX4ImlDU3wc8nx6EBxghNLZG5I39TPDaCQVbNaCDg/inWFwkSaMLTZrpFFW+XyrLnJZrAuXo5Lmg7yXiV0SmTybnNyz6kjCitV0p4w71zN+Z9ZN0ZB3mDvdPFliyQRd8fEYAwC2foK12+JJk3tjgKntse+NR1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582349; c=relaxed/simple;
	bh=yKXEHt3a6AvjoI8aEePyaFocSTjZismbWvZ2xxaGB6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WsQyA7DBH8Qols0HnCALeVWxhE13aHBLrdbLNjH2F6MvFwfGBNHDKatHNmnFINPtcMGZ+0hiqsRRhucYiCPlKltcPREJk85QLcC/YnWs3mNHJARuL7cJMNjaLKrSxGC7P14GcTB4T5ZVuYSsh1RrsIcaDLDxc7L90Ph2+gt2ZSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=bFJkWlin; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Hj+nbwMM reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1755582346; x=1787118346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WsYp5szV0xyNktXKyNpHlGjtRi7D/yzfr9+tShTScEo=;
  b=bFJkWlinTzfPzsn+cgkH0BcWA0msiywkFN1cOxtYb9xciDWE+xwjQVW3
   UgNmYp3VYaGkk/uOR/py9nHofcuzpmjpTNBwyOpI05k0ECAtxD9YRikY5
   /OlJ5XN8kFzF16I7rD1TeeSwvJeqbTw2u7PV2klHZxfFFh/E2rYMUQq6f
   Bgfsde/TG6YBOSAN0UAplNX7p8DCcmvfJ2NF7clB5ocXLj2hlNVbTVk4K
   pYh2adid9AaV9QkX2TdjCqNiDRi+K5jfuXMZce3rAt1t9HjybDha+gHfq
   6ewrqLIOrZWayWftsw/ePCEmEYfrQEBlr0CMGoyCuua3NgVSEnsMEyS+U
   w==;
X-CSE-ConnectionGUID: pIE3H7EkSU2KpnRbqdg2tw==
X-CSE-MsgGUID: gemojgD+SnG0Uwlr5Nqd3g==
X-IronPort-AV: E=Sophos;i="6.17,300,1747692000"; 
   d="scan'208";a="45794411"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 19 Aug 2025 07:45:33 +0200
X-CheckPoint: {68A40F7C-3A-9821D066-F5C64F68}
X-MAIL-CPID: FA256BEDB6305F126D1DB31ADA1A04C9_2
X-Control-Analysis: str=0001.0A002115.68A40F37.0061,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07F281632DA;
	Tue, 19 Aug 2025 07:45:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1755582328;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=WsYp5szV0xyNktXKyNpHlGjtRi7D/yzfr9+tShTScEo=;
	b=Hj+nbwMMZTxOWhrFndQYU6J6dMbz9J1u6gZvEnOsZDeCrIb+B1baPv04ofFHNq/N7Mu3QE
	2Bwf0kq5lUEfkNNWZ6HAaU9pro+LVN0e4uHZHFl11iRTUYV7XVs8No3AqkyYNy1KmwIjDq
	0ubTNQiWSi+0RTc3rpZVp6fbrSBJAe5wqu918FhSsb6UeIitZBq9r5gbEeUOaUCCx6ktYc
	+FatrOfHiLglLTztecpGNemEPGJ3W4VRR2lobspHaWq2QxJeprw0Y+M/bitj29ybf/LnIT
	W9lmSFHQCqS2dYizdttwa14Txx/yuIFOG560yt2A390b1lcXzhaxjcYFWC0lFg==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 Frank Li <Frank.Li@nxp.com>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 00/15] ARM: dts: clean up most ls1021a CHECK_DTB warning
Date: Tue, 19 Aug 2025 07:45:26 +0200
Message-ID: <2800197.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
References: <20250818-ls1021a_dts_warning-v1-0-7a79b6b4a0e2@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi Frank,

thanks for the series.
I've already sent a similar one at [1]. But I haven't check which are
duplicates and which are not.

Best regards
Alexander

Am Montag, 18. August 2025, 22:48:11 CEST schrieb Frank Li:
> clean up most ls1021a CHECK_DTB warning.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Frank Li (15):
>       ARM: dts: ls1021a: swap dma tx/rx channel to fix DTB_CHECK warning
>       ARM: dts: ls1021a: correct node name "timer0" to 'rtc' and remove r=
eg-names
>       ARM: dts: ls1021a: remove redundant snps,host-vbus-glitches
>       ARM: dts: ls1021a: remove big-endian for memory-controller node
>       ARM: dts: ls1021a: Rename node name nor to flash
>       ARM: dts: ls1021a: Remove redundant #address-cells for queue-group@=
* of fsl,etsec2
>       ARM: dts: ls1021a: Rename esdhc@1560000 to mmc@1560000
>       ARM: dts: ls1021a: Rename node name power-controler to wakeup-contr=
oller
>       ARM: dts: ls1021a-qds: Rename node name at45db021d@0 to flash@0
>       ARM: dts: ls1021a: remove big-endian for mmc modes
>       ARM: dts: ls1021a: add fsl,ls1021a-wdt for watchdog node
>       ARM: dts: ls1021a-tsn: Remove redundant #address-cells for ethernet=
=2Dswitch@1
>       ARM: dts: ls1021a-tqmls1021a-mbls1021a-rgb-cdtech: Remove fallback =
compatible string edt,edt-ft5x06
>       ARM: dts: ls1021a-qads: Add fallback compatible string mdio-mux
>       ARM: dts: ls1021a-qds: rename 'nor' to 'flash' and 'mdio-mux-emi1' =
to 'mdio-mux@54'
>=20
>  arch/arm/boot/dts/nxp/ls/ls1021a-qds.dts           |  8 ++---
>  ...1021a-tqmls1021a-mbls1021a-rgb-cdtech-dc44.dtso |  2 +-
>  ...1021a-tqmls1021a-mbls1021a-rgb-cdtech-fc21.dtso |  2 +-
>  arch/arm/boot/dts/nxp/ls/ls1021a-tsn.dts           |  2 --
>  arch/arm/boot/dts/nxp/ls/ls1021a-twr.dts           |  2 +-
>  arch/arm/boot/dts/nxp/ls/ls1021a.dtsi              | 38 ++++++----------=
=2D-----
>  6 files changed, 17 insertions(+), 37 deletions(-)
> ---
> base-commit: 3ede6e44fad31f1c80dd01188683f0caa0f19247
> change-id: 20250818-ls1021a_dts_warning-fff933bd83da
>=20
> Best regards,
> --
> Frank Li <Frank.Li@nxp.com>
>=20
>=20
>=20


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



