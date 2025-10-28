Return-Path: <linux-kernel+bounces-873186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 52651C13553
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 08:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE6815051BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 07:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E877494;
	Tue, 28 Oct 2025 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="e628aea8"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A73333EC;
	Tue, 28 Oct 2025 07:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761636964; cv=none; b=Yr8L68hdkuu8r12q/lq6NTTyphC9243NKeAE9g5rkYQJSC9p/sXxyo83T4Vzv8MMdbnGLsa9ou7RpHyl7DEcqkpud2JfRn7xM6UwSZBGH8/ozMPHAFPYtDUwX9jbf4FcZo3NHscXTIZ3JGhSRiXXz/Q0eYxyvMjmhbzG3bd1mww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761636964; c=relaxed/simple;
	bh=h7w/ic9gTMqbzdnV/XQveAogdifZfGOQM4hvalaGnew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yt6/lepeJEoWWFALRdtKYB9Vtn/AyzyUt4KS5yFqCqPAyedA2uzNmylaIGHPylo3Pf68dLjTaJ9WG7f93SRAWVrLsXApYYvTYApKHJrEb1uto3g07Ev5VtDWt/91Ihr6LeuiGLgcz0rtONi7S7Wdot5kEqe76f9MkyMOpRdl2OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=e628aea8; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C49F91A16F4;
	Tue, 28 Oct 2025 07:36:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8FF69606AB;
	Tue, 28 Oct 2025 07:36:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0AE70102F2511;
	Tue, 28 Oct 2025 08:35:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761636959; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=kS+v7UxhH3NIRfcFBUgh9cjGXshVr2JyUKKPIyxO3A0=;
	b=e628aea8rtzS7HMfOueonC377QxRQ8Kym+dGULqdTzFtYF6atHkETnXomz5YoWuTMq0eZL
	tk41px3Vj9dCl5lttpveLS1T9Q2/ex3MRuF8np9QSc/c+A9P5aNZz/Re0fWt8f+B36M0e7
	J1o0Sp0TEOEePjWxBdfjfn0xAVd9kOSOVRcMUIm2OoSVUSBYtno7/CD/b0dG+IUyvV5Yig
	Qi7vLyjP5a9K5eNSwSSrzOTkw7XyTB26L0hlYFwgLK7kXgKRXP0kJgu0ZJkpd/Gk9NhVOw
	RywNA517kYC0l8fZRxpXa++PSHGtQB7fomey5bqpUgapWnGYV3di6OcciGdEQg==
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
Subject: [PATCH v4 00/16] Introduce Allwinner H6/H616 NAND controller support
Date: Tue, 28 Oct 2025 08:34:53 +0100
Message-ID: <20251028073534.526992-1-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Patch 1 introduces allwinner,sun50i-h616-nand-controller compatible
in order to differentiate from the A10 and A23.

Patch 2 removes a superfluous call, and is independent from the others.

Patch 3 replaces the hard coded value '4' used for user data length by
a more meaningful define

Patches 4-14 are paving the way to the introduction of H616 NAND
controller support.
They are small, without functional change and easier to review than a
big patch.
They move a fixed value (register offset, field mask, SRAM size) into
the struct sunxi_nfc_caps when this value is different on H6/H616.

Patch 15 introduces the support for H6/H616 NAND controller.

Patch 16 adds the NAND controller node to sun50i-h616.dtsi

Changes from v3:
- fix patches order by beginning with binding patch and finishing with
  dts patch
- add a patch to replace user data length hard coded value by a define
  as suggested by Miquèl
- un-break a line in patch 5 as suggested by Miquèl
- update Geert's series link to v5
- update patch 8 commit message with a mention to Geert's series
- address Miquèl remarks on patch 15:
  - change // to /* */
  - remove statics set to false

Changes from v2:
- add missing 'status = "disabled";' in nand controller node.
- factorize back clock/clock-names in binding.
- pick-up reviewed-by

Changes from v1:
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
- pick-up reviewed-by

Thanks Krzysztof, Jernej, Chen-Yu and Miquèl for the reviews!

Regards,
Richard

Richard Genoud (16):
  dt-bindings: mtd: sunxi: Add H616 compatible
  mtd: rawnand: sunxi: Remove superfluous register readings
  mtd: rawnand: sunxi: Replace hard coded value by a define
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
  arm64: dts: allwinner: h616: add NAND controller

 .../mtd/allwinner,sun4i-a10-nand.yaml         |  41 +-
 .../arm64/boot/dts/allwinner/sun50i-h616.dtsi |  52 +++
 drivers/mtd/nand/raw/sunxi_nand.c             | 407 +++++++++++++++---
 3 files changed, 426 insertions(+), 74 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
-- 
2.47.3


