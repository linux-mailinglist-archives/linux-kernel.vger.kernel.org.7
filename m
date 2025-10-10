Return-Path: <linux-kernel+bounces-847964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F384BCC2C4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 10:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 98EAC4E9A56
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 08:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1863E265CC2;
	Fri, 10 Oct 2025 08:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Lj2r5OGq"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB23262FC7;
	Fri, 10 Oct 2025 08:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760085692; cv=none; b=PPIiGBWhpxpUi4DQKtjQi08rcRSUjqNrilFj4cqY+olIggs35ClPa5fj6G4Qb6AE7CPOTxPrjZIrzvYArU4hZcptkWNDeJ7qPQdjjidNcW0iz1SUKSe6En+kzOlQVT1wXaYw60jHAYsZyh2+vRHn+4D9XsLVfrSwKIDYUcxo1Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760085692; c=relaxed/simple;
	bh=N0jaLxs10v/mZlLsQ6XLvJPnyxIcUayb+m47AW552WY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dli11/7PkNU/WPhLspZ3dvfTOTgP2poPk2wUbg2dDz6qKv7Os5yh6KaSSh6Ib0xbpFmfxyUJkTEXXa/EsNNT49MvHtmUxFxeuWqhhI7boYxd5No6k0bQYkIXynG1Wq4KaTv5RGRYIELGYTp1X5lU7xiVrNAc1drzYttvEB7bwvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Lj2r5OGq; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4CA104E40FCC;
	Fri, 10 Oct 2025 08:41:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20FCE60667;
	Fri, 10 Oct 2025 08:41:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 35FFF102F21F6;
	Fri, 10 Oct 2025 10:41:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760085686; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=VlNW7Be15vPzXytv5j+MryEbpzdAb9uI6s31TlFZlxk=;
	b=Lj2r5OGqlb6pAwKRb6ymYRsKb/WCiIrt5ExubUC7yOt0wyvxJ4w5iJ869x5DHqNWvNQfeM
	FSMCV7eBLKWlcScPxqAP1b4FEOL+DhOZbiFAkIO5S3aPcPLeN3oQKTqWiejlZn5KINLrwc
	06GDruTOHWg7A0NCjy81rtgJQ51o04bogC/WcemZEN+KSpKFOg7NAqm5E1WA3dK9E46eZe
	OdzyxpaKVs5qz4L/zKgsoN04U+iVN2Hb9O+nUGld5CydqxL0fT1Cgo5PaI+67AxwVNYYZd
	UDAaaqKmaVkiy/VUGMUvRhZPAP2Myzata1cZvomNiapd06GgqUaZdyEc6oSuag==
From: Richard Genoud <richard.genoud@bootlin.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH 00/15] Introduce Allwinner H6/H616 NAND controller support
Date: Fri, 10 Oct 2025 10:40:27 +0200
Message-ID: <20251010084042.341224-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

This patch series introduce H6/H616 NAND controller support (but not yet
the DMA/MDMA part).

All the work was done on a H616 board with a Kioxia TC58NVG1S3HTA00 NAND
chip.
ECC is supported, as well as scrambling.

H6 SoC has not been tested, but it shares all registers with H616, plus
some registers dedicated to Embedded Crypto Engine that H616 lacks.

This IP has quite some register fields modified from the A10/A23, but in
the end, it works more or less the same.
Main differences with A10/A23 are:
- The need for 2 more clocks (for ECC and MBUS)
- The use of a new USER_DATA_LEN register
- More ECC strengths (44, 52, 68, 72, 76 and 80 bits / 1KB)
- MDMA based on chained buffers
- some registers layouts have changed (mainly due do the stronger ECC)

Patch 1 removes a superfluous call, and is independent from the others.

Patch 2 introduces allwinner,sun50i-h616-nand-controller compatible
in order to differentiate from the A10 and A23.

Patch 3 adds the NAND controller node to sun50i-h616.dtsi

Patches 4-14 are paving the way to the introduction of H616 NAND
controller support.
They are small, without functional change and easier to review than a
big patch.
They move a fixed value (register offset, field mask, SRAM size) into
the struct sunxi_nfc_caps when those values are different on H6/H616.

Patch 15 introduce the support for H6/H616 NAND controller.

Regards,
Richard

Richard Genoud (15):
  mtd: rawnand: sunxi: Remove superfluous register readings
  dt-bindings: mtd: sunxi: Add new compatible
  arm64: dts: allwinner: h616: add NAND controller
  mtd: nand: sunxi: move ecc strenghts in sunxi_nfc_caps
  mtd: nand: sunxi: introduce reg_ecc_err_cnt in sunxi_nfc_caps
  mtd: nand: sunxi: introduce reg_user_data in sunxi_nfc_caps
  mtd: nand: sunxi: rework pattern found registers
  mtd: nand: sunxi: add has_ecc_block_512 capability
  mtd: nand: sunxi: introduce ecc_mode_mask in sunxi_nfc_caps
  mtd: nand: sunxi: introduce random en/dir in sunxi_nfc_caps
  mtd: nand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
  mtd: nand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
  mtd: nand: sunxi: introduce ecc_err_mask in sunxi_nfc_caps
  mtd: nand: sunxi: introduce sram_size in sunxi_nfc_caps
  mtd: rawnand: sunxi: Add support for H616 nand controller

 .../mtd/allwinner,sun4i-a10-nand.yaml         |  56 ++-
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  50 +++
 drivers/mtd/nand/raw/sunxi_nand.c             | 342 +++++++++++++++---
 3 files changed, 390 insertions(+), 58 deletions(-)

-- 
2.47.3


