Return-Path: <linux-kernel+bounces-827509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F3E0B91F17
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DFAE7A7336
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24F22E8897;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSPOkrAw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76F2E764B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555123; cv=none; b=Xvrcac+MvfGnsk3adOnSgfh3v2uc96bO+UBIi7V5yX0S+WRooCKpuhJjuh6O10RTpKgoj7kalrput6IrHPjW1PVQiRpTSzBUubPjCTWmk6lvFG1crPY5Zo8em6ZHa96FLkbmqHLD9dW0hvGKQL+BWXsdpkoXikhOjk9EAbt97J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555123; c=relaxed/simple;
	bh=SfaFrl4QZz0bkddp7YAsKSPz8h9hoenE26+Qxca49Cg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNADlpOh/ScnWknTv56HOu8Wt8biH607I5QMM5vm31C5J5rNxsaDnjsK0UzYuw7E44DQMaHworCr/1TJI/rYkxjj6GFfONXT42Plo7Fhbfnj3Hc79XHAw06J4KdvFaeZD0NGEpRusjNJy/oE5tEtvkA3gw2D6SSPXY3YHyRUEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSPOkrAw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB861C19424;
	Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555122;
	bh=SfaFrl4QZz0bkddp7YAsKSPz8h9hoenE26+Qxca49Cg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RSPOkrAwxVhlLva+kII+0FJHAR0eNKTqECqic4+PAVCuE4eqk7ooafrFxWCnltglU
	 tMVsBTMGWAYkbapenkNHfeZef6UQJhu2w300uk+hEmCwGfxv2VXzbueMe1++4EU1Px
	 QFw1Kx4f25xVrmUEGsvK0AvqiENk5Lzj86gODINbeNV+hb3JkXkquSeEm1khf5usU8
	 mmiIyMuF3/0eK8PmV1veEFGDj16Z3md+IUbWyjj8YwWsW56B/NTPK4oDL6cyGsDW7e
	 qXvWEvsp6CCFAAsViFmxyybQrX0hvXH5w54S5sH+7L4ILJcPbC7Sa34uqFF+ywT5Ql
	 7Ir4Ztfd20jBg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hp-1rny;
	Mon, 22 Sep 2025 17:31:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Michal Simek <michal.simek@amd.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5/8] mtd: rawnand: pl353: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:04 +0200
Message-ID: <20250922153107.16381-6-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250922153107.16381-1-johan@kernel.org>
References: <20250922153107.16381-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver has never supported anything but OF probing so drop the
unused platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mtd/nand/raw/pl35x-nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/pl35x-nand-controller.c b/drivers/mtd/nand/raw/pl35x-nand-controller.c
index 09440ed4652e..a7dc45c7f214 100644
--- a/drivers/mtd/nand/raw/pl35x-nand-controller.c
+++ b/drivers/mtd/nand/raw/pl35x-nand-controller.c
@@ -1193,6 +1193,5 @@ static struct platform_driver pl35x_nandc_driver = {
 module_platform_driver(pl35x_nandc_driver);
 
 MODULE_AUTHOR("Xilinx, Inc.");
-MODULE_ALIAS("platform:" PL35X_NANDC_DRIVER_NAME);
 MODULE_DESCRIPTION("ARM PL35X NAND controller driver");
 MODULE_LICENSE("GPL");
-- 
2.49.1


