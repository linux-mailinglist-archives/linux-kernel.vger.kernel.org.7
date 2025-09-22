Return-Path: <linux-kernel+bounces-827510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BE3B91F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:33:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 743367A87EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC752E972C;
	Mon, 22 Sep 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uyq2eQkc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7E72E7BDC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555123; cv=none; b=KQq2OiYswy2nyCRe5Lpf3Da3eT8yrAx3saYNpW9f+LoU6gKa4Vn988SpM+YjSvQik5E2u98mDx7awYDKVGrmDALzZUKeYCylLqUIrk4EPoWyG7NzxY7DtnxhYQSdu1eQtl7QeJW89C80TG8S2XOC2RP4RV1EnptbNLwMdO6Zj/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555123; c=relaxed/simple;
	bh=bClmoRfRjjOnU9fmAIB3gBoOykMbWx45Ktd4MD4g5Ew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hhr5NFyEdAG2YaZkx9FRDg7UEbjZPKwF6nYjwAXpJ9tWMR1msf6tY+1mQ1LcnV+gki8prbIPqhKZBMqTrIiKUKVPpJfzNnyd0FDNXNMCmyhdeMzJJoZFQwn4tattoUw3lt7rcNkZnhol8tsHjco3iZg6nEaO4weuX8I/yiyOIrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uyq2eQkc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8EDC19425;
	Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555122;
	bh=bClmoRfRjjOnU9fmAIB3gBoOykMbWx45Ktd4MD4g5Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uyq2eQkc8WJECeQgTxdjUWWuCtoxtnjjeTtJbwif/K+LgqdFe6CdNrek2IIRAzCEc
	 5EeeQ5lZJsSWJDSD60fzTU1EfkjBvcjrhlCchYrUOmRKatPjWV+xVGHS/7UYH+oBnR
	 qqTaQmPKmtunFKo3hNNIE6xGAKEeOO4TOGyId7paV3+F1O+1+6WUE9TMSDW2jRNGJt
	 tAihBprq3oqUSDSf+6C3CiH9G8hjhibigfm6PNlmNsjU5vOMxAcXCc6OfwrPWMMKdx
	 QFtjUaKVew8XFyWKpBh93zLcFgX0a4mAq8PmxMlfQg93OoPMDgfCaOxxjw7FNe+SzJ
	 5ImZrgw3fdaHg==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hm-1Tv3;
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
Subject: [PATCH 4/8] mtd: rawnand: omap2: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:03 +0200
Message-ID: <20250922153107.16381-5-johan@kernel.org>
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

The driver only supports OF probing since commit 086c321ec57b ("mtd:
nand: omap2: Remove omap_nand_platform_data") so drop the unused
platform module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mtd/nand/raw/omap2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/omap2.c b/drivers/mtd/nand/raw/omap2.c
index 61fd98ad5c78..39e297486721 100644
--- a/drivers/mtd/nand/raw/omap2.c
+++ b/drivers/mtd/nand/raw/omap2.c
@@ -2332,6 +2332,5 @@ static struct platform_driver omap_nand_driver = {
 
 module_platform_driver(omap_nand_driver);
 
-MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Glue layer for NAND flash on TI OMAP boards");
-- 
2.49.1


