Return-Path: <linux-kernel+bounces-850887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A7BD4714
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 17:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C01DC1884E18
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D6B28D83E;
	Mon, 13 Oct 2025 15:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QGFbD/jC"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8854D22157B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760369249; cv=none; b=qyB1s0DERXYvuWgKQmmejYxWOUkqRZtFFbP9Cy5xEGWQN8vcvDLqsHHH5Xyu1RQ1Zc1hTuZ02DQeOaPfMALrlrxhd4hSeX8TE0NQvEsn5nHm8BXZNvVZV/cwU9/mmL770U580dhzphioxLD/8iJAeVcHaJLYwFZ0g4J/WlhcALU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760369249; c=relaxed/simple;
	bh=0/9WuBOtVzbwvasIhv2yl9J8bXpAkxeZj97IdX6gANQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C04ZNhuBmAbRG7g8U1I2gB8DhNePhXLUvK1U7sLX2kn5dTRzBkZt6BG1Jmpv5+S9glaU6UKB+zkAn3VfInL9VYllxjX92Ngnoa3g9BX+IIZW/kmKdNqFCl198NWM7ZLjDY1NQMLduRgKx5Xz1V6z62ORsmKKlI4fHP4cF0Kdu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QGFbD/jC; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id BF3904E41063;
	Mon, 13 Oct 2025 15:27:24 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 923B86067B;
	Mon, 13 Oct 2025 15:27:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DA7AF102F226E;
	Mon, 13 Oct 2025 17:27:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760369243; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=IWdsfjj5jpQbVUBEF3JNVK8XtUjBuYa8SUR1XN8C/40=;
	b=QGFbD/jCtgA18dea4eicPYCp27fIQfV28kOkO5geNkZtVwVYY/OtySER9JAODMiCs2Wz8a
	pJJlYjsBDG4xCNGm6rh4j5VOXDoVAXJa0FbeoHIULkVsP7kd8BqFMdU8UAd9u7Nu26UsFG
	nhscsQS+FI5wQbqC+fYoPAPsc28qzFcUR127lQrWRH7ucpqjEvSViNfSyf13xTJmxh0rCW
	PWZH4DycrEAv5VS6+cuJOtPTfc8Kxx6GW4ZaRAAW4wGK909H+aBm5sDX6+iyQLWsaTkzuu
	5mHVVq2Yj/oKRwqMKfEW7U9C0s3ug5mFFj5Rb5Ch7j9OjIvIHYoj21mgd4h7fw==
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
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Wentao Liang <vulab@iscas.ac.cn>,
	Johan Hovold <johan@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-mtd@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Genoud <richard.genoud@bootlin.com>
Subject: [PATCH v2 00/15] Introduce Allwinner H6/H616 NAND controller support
Date: Mon, 13 Oct 2025 17:26:30 +0200
Message-ID: <20251013152645.1119308-1-richard.genoud@bootlin.com>
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

Patches 2-12 are paving the way to the introduction of H616 NAND
controller support.
They are small, without functional change and easier to review than a
big patch.
They move a fixed value (register offset, field mask, SRAM size) into
the struct sunxi_nfc_caps when this value is different on H6/H616.

Patch 13 introduces the support for H6/H616 NAND controller.

Patch 14 introduces allwinner,sun50i-h616-nand-controller compatible
in order to differentiate from the A10 and A23.

Patch 15 adds the NAND controller node to sun50i-h616.dtsi

Changes from V1:
- reorder patches to have dtsi/bindings patches at the end.
- reorder nand-controller and pins nodes to respect the order.
- add /omit-if-no-ref/ on pins that may be unused.
- remove pinctrl from nand controller node (this should be added to device
 DT).
- rework dt binding.
- fix H616 comment on chained descriptors support.
- add missing mbus_clk description.
- make ECC clock mandatory for H6 (because it's indeed mandatory).
- harmonize new clock retrieving error messages with older ones.
- harmonize commits subjects (mtd: rawnand: sunxi).
- reword commit messages to use imperative mood.

Thanks Krzysztof and Jernej for the reviews!

Regards,
Richard

Richard Genoud (15):
  mtd: rawnand: sunxi: Remove superfluous register readings
  mtd: rawnand: sunxi: move ECC strenghts in sunxi_nfc_caps
  mtd: rawnand: sunxi: introduce reg_ecc_err_cnt in sunxi_nfc_caps
  mtd: rawnand: sunxi: introduce reg_user_data in sunxi_nfc_caps
  mtd: rawnand: sunxi: rework pattern found registers
  mtd: rawnand: sunxi: add has_ecc_block_512 capability
  mtd: rawnand: sunxi: introduce ecc_mode_mask in sunxi_nfc_caps
  mtd: rawnand: sunxi: introduce random en/dir in sunxi_nfc_caps
  mtd: rawnand: sunxi: introduce reg_pat_id in sunxi_nfc_caps
  mtd: rawnand: sunxi: introduce reg_spare_area in sunxi_nfc_caps
  mtd: rawnand: sunxi: introduce ecc_err_mask in sunxi_nfc_caps
  mtd: rawnand: sunxi: introduce sram_size in sunxi_nfc_caps
  mtd: rawnand: sunxi: Add support for H616 nand controller
  dt-bindings: mtd: sunxi: Add H616 compatible
  arm64: dts: allwinner: h616: add NAND controller

 .../mtd/allwinner,sun4i-a10-nand.yaml         |  57 ++-
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  51 +++
 drivers/mtd/nand/raw/sunxi_nand.c             | 350 +++++++++++++++---
 3 files changed, 404 insertions(+), 54 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

