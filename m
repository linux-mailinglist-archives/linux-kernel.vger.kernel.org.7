Return-Path: <linux-kernel+bounces-861808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9601ABF3B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 23:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 186F848049F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4EE333751;
	Mon, 20 Oct 2025 21:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ShB6Swg7"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9B1494A8;
	Mon, 20 Oct 2025 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760995227; cv=none; b=nh18AMfVrKMh1ocJ5jQKJ8vYBNY22GvwWAlIA87Rv5SEXCkFcAxiRKye4dukkTMBvnIsB5P7FzuwBvL2GmIqjkpXDpXjCHCFHr0AC7+sil13Y8kFuCxWi2PG5+dbAbxJ6gyzktLj5CUbyF2xxbg6IQxKNpXxYRm0NIAhh/5ciHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760995227; c=relaxed/simple;
	bh=M3lIp+cKelh2O4BMlSXcu2sgi0P54b6jr5d4gpqzweg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PJfTqgCoCZQ1iMEXr2Do4gKnHfnE1hMpdksFGqX9keCPDPSUOcqKA1nc/OaZz7i/uBKDT5kblC54WGLmJX8L7sGrEk2i6O824vepwrMECm6NeQ0c+e+rATcI+TLYE8X4k5g0wmzGsnlB9PP1GejT1gX3HLdQHN9L253XPM1QpXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ShB6Swg7; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760995223;
	bh=M3lIp+cKelh2O4BMlSXcu2sgi0P54b6jr5d4gpqzweg=;
	h=From:To:Cc:Subject:Date:From;
	b=ShB6Swg7D9NzKVB3AJxHIEZbUFqjlvfvdmQih1OxuV8JY4am4EZfpnjKLkbTO1mUI
	 7L4Ne4Q16+t1S/hBCovhPzVa1Vnq5kQtTKc7imAQFJpTp/SVdgAq9LEDHdE/8abCZH
	 LCj8FMkxt8Hn2L0iP8Jk48Zvdt7JXXafs6azc/GkGLSq3CUiCdGDxN/sbQXRUMh65G
	 lBSIJvmgK+x1FDDxsTzd2wKPorbHBzbxg8U0CC9hIpMPdYRTtvauHujCG9DwwL48lT
	 WMluUNAfkviXBF/c7E2okPaFqfhqBbFG/thp2/pghwta7ZPhhL0JOlp/Y5r/LRFHx0
	 a4i7XUKQW/qGw==
Received: from trenzalore (unknown [23.233.251.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: detlev)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BC1117E02B0;
	Mon, 20 Oct 2025 23:20:20 +0200 (CEST)
From: Detlev Casanova <detlev.casanova@collabora.com>
To: linux-kernel@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Dragan Simic <dsimic@manjaro.org>,
	Damon Ding <damon.ding@rock-chips.com>,
	Alexey Charkov <alchark@gmail.com>,
	Chukun Pan <amadeus@jmu.edu.cn>,
	Patrick Wildt <patrick@blueri.se>,
	Diederik de Haas <didi.debian@cknow.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Alexander Shiyan <eagle.alexander923@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	kernel@collabora.com
Subject: [PATCH v3 0/2] arm64: dts: rockchip: Add vdpu 381 and 383 nodes
Date: Mon, 20 Oct 2025 17:20:07 -0400
Message-ID: <20251020212009.8852-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.51.1.dirty
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the nodes for vdpu 381 and 383, respectively RK3588 and RK3576.
To keep compatibility with older variants, the reg ranges order is not
in register order so that the function reg range is kept first.

Also adds the corresponding iommu nodes.

Note that on RK3588, both cores are added as it represents the hardware,
but the driver, later will only register the first one.

Regards,
Detlev.

Changes since v2:
 - Set the correct IRQ number for the second rk3588 core

Changes since v1:
 - Set node name to match first reg range

Detlev Casanova (2):
  arm64: dts: rockchip: Add the vdpu381 Video Decoders on RK3588
  arm64: dts: rockchip: Add the vdpu383 Video Decoder on rk3576

 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 36 +++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi | 74 +++++++++++++++++++
 2 files changed, 110 insertions(+)

-- 
2.51.1.dirty


