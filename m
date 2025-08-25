Return-Path: <linux-kernel+bounces-784060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D191CB33624
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71193200EC4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B121627AC31;
	Mon, 25 Aug 2025 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="W3iMRjnD";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="TJu4Y3Gh"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AB23D7E2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756101882; cv=none; b=AyEv4cDDUV11T+IfNJy1IukmKDUd1wmXDSJXGlwcm6UWhpfFSELPpHlcLO64cuPhGcSm+fXjsFBZr8E5MlBIiXadqXJtG0aKkwLc+y33rUjOhWEyh3aGNKnprWjZEi33l6bj6FyJz17rNz+ijYNp5fYAyaTdi6QPkb8EkEU9onw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756101882; c=relaxed/simple;
	bh=WwuiwhnCU/RM5H6kq6QXxgiXpOYCGBr6wqd24SBdV+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9RfU4B4ckNXYjn5mqACJeizhrXu2eMRChpdgtIyFkWdbcqrdKj0te1CYmkElQoLrn3UoofBf2VmmzyPAQt/lYuPHpnJ8pQOkmCMLJOR64ai174iT3WMZcyqNQwwL+vwJbzULyEN9GXIL0XpvEftmQO38oDqLkXw71mVQ4Lr5pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=W3iMRjnD; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=TJu4Y3Gh reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1756101879; x=1787637879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ahcojl+A6ntFnOChIODr49z1OKuZ64mcv5dRgxrqT/E=;
  b=W3iMRjnDr//kPGn1joOAZXGwZDyA86y3xr6z93I/DJmWHhbu9qCrEuOu
   8S1cVYHXXpcWpTmMKJ3NuqstS/kv1UEgJDe4MaTwxJlkQYf4ZYCGjbDrv
   hBXtURAY3EzNMt3ndP7T8Cw24StfWufJgX2KZ4XM7l2XNfelIBoVj6CI5
   RHrkwMNYCb+v4GHPsqHybBaWiZVxqMw8/UdoENDIoSx4rOh1ewK4GbXiD
   4u9e2dovsXpRrLIs6qcwwJWWT6QXIZ+BwSdSMNFC64KBzQQ8fLf0yi83g
   N6hCQ3hxo1Oj8EIb7bi0NCjaioiWLey52vO25RtIj5096ALaWhAt5zKcb
   w==;
X-CSE-ConnectionGUID: eYXtE4gxRt2fo178KhMmRg==
X-CSE-MsgGUID: xloUEWyOQDS5nhRBjgVz5g==
X-IronPort-AV: E=Sophos;i="6.17,312,1747692000"; 
   d="scan'208";a="45884087"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 25 Aug 2025 08:03:26 +0200
X-CheckPoint: {68ABFCAE-C-20CAA7DA-EC9DC758}
X-MAIL-CPID: 8FDA0A8C775CAFACFD752DE80AB64A2D_0
X-Control-Analysis: str=0001.0A002101.68ABFCAF.0075,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F3D58166F33;
	Mon, 25 Aug 2025 08:03:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1756101802;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ahcojl+A6ntFnOChIODr49z1OKuZ64mcv5dRgxrqT/E=;
	b=TJu4Y3GhOjRZs63dqoFYNkLsTObb3F581GDE3GRgJbOt00TmHkQxj7g3QbFb9TMrrVnDYL
	q60DCmI4I1PUjRHoIGgxZ4jrdL3Se+wXjABYlNv0YnmAovfCuDyfaZPzWyrCqvhnlHDtD8
	8JVDBIdxkJ+wDcx2pE3kCFl4sfUege7EUg7vEPGG7hioaxP5RFCRaMjp/hnopuL/+mAJiL
	0ujtYovNiA9giSiEM/ngzhM1JouznmkwIx3xtS50HaNXbOxw/TKFb2l9zu3WbjTn78x8QC
	bfx5RGl8/rHuJ2CY/fpi4OqKv+qIBKJWdCE8pA56NxE0tWaEz6ehpdH30EI/XA==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, Pengutronix Kernel Team <kernel@pengutronix.de>
Subject:
 Re: [PATCH v3 1/1] arm64: defconfig: Enable Marvell WiFi-Ex USB driver
Date: Mon, 25 Aug 2025 08:03:19 +0200
Message-ID: <2800962.mvXUDI8C0e@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <dc6af2fc-5e7f-4ec8-a7aa-6bde6518a83b@kernel.org>
References:
 <20250822135715.3335023-1-alexander.stein@ew.tq-group.com>
 <dc6af2fc-5e7f-4ec8-a7aa-6bde6518a83b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Sonntag, 24. August 2025, 13:26:43 CEST schrieb Krzysztof Kozlowski:
> On 22/08/2025 15:57, Alexander Stein wrote:
> > MBa91xxCA (imx93-tqma9352-mba91xxca.dts) features a USB attached WiFi
> > module. lsusb says:
> >  ID 1286:204e Marvell Semiconductor, Inc. Bluetooth and Wireless LAN Co=
mposite Device
> > Enable the corresponding driver.
>=20
> This does not answer my questions. You can plug there something else...

It's not pluggable, it's soldered on the mainboard.

Best regards,
Alexander
=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



