Return-Path: <linux-kernel+bounces-827507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C14DCB91F12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE98A190456A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAA12E7F3E;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FGwUgvxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4E62E7631
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555123; cv=none; b=XD5ktecOrIozkQg349LDgdsTojEqI+x7/y1ScLiMhzEMu24crpe1WKIxzxfhqHbA34xgvyG5/B0UDFGjyielooL49brEmhwPolSFlGTpEtCiO7N/WybJLouxdxcyU5vSHM4Gg5LjW/cLbVaK74I9DAGAgiJSZmVJXsYT+wplKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555123; c=relaxed/simple;
	bh=F/QqHKTdDoP1uBZAZZjnrrOZP/fFFhBzGoiYO8vzUdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UE3SXZhSEra9X17pXHGrMMR1cLejX1VvPqVd02HzOKMHo9YwGU1StcpTwfOM2f0+6Vy5XBp7Ac6z+n3qXoxgxHuJHe+eLJL1sKNXFr7jasek4dNOVA1ZxzaqqEl3UycYaVzVBvfzdbfHQpSl1MHo26rlSEDRNtHyrcOG5g0aNj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FGwUgvxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C545C4CEF7;
	Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555122;
	bh=F/QqHKTdDoP1uBZAZZjnrrOZP/fFFhBzGoiYO8vzUdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FGwUgvxIZtJT38NmYLl9PjbwLyElyqNSTIz1Fdp9HXKdVD2eDrzuibq2qz2bI/Q1N
	 rHJstbynpjUW23il3TUbAiCd8ETSiFHwSRb3VKlFyRgVSV18Nuc2RKnEkz3Htmw4qz
	 tagOr2QMpvnmg0qs1VJQcOBlVjQOFdvj6B5qpZfHn6U5GVfITY6byi3YDI5vIpqRDk
	 6TWsr0ZPZS+XBtBVNI2l5FlL5KJYQeenyInL11YD72HicHr4vmbu1m74oYr43RWNk7
	 Lkjh4KGbsy7rSsFhD6FQfK7F9V/iOnyjlzRPrbV4nxhYCHq9qQydjEmjFmEkx3oDyI
	 nN2FrUNsjRfqA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hi-0e4V;
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
Subject: [PATCH 2/8] mtd: onenand: omap2: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:01 +0200
Message-ID: <20250922153107.16381-3-johan@kernel.org>
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

The driver only supports OF probing since commit a758f50f10cf ("mtd:
onenand: omap2: Configure driver from DT") so drop the unused platform
module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mtd/nand/onenand/onenand_omap2.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/onenand/onenand_omap2.c b/drivers/mtd/nand/onenand/onenand_omap2.c
index f9a386b69050..0793251ada3b 100644
--- a/drivers/mtd/nand/onenand/onenand_omap2.c
+++ b/drivers/mtd/nand/onenand/onenand_omap2.c
@@ -603,7 +603,6 @@ static struct platform_driver omap2_onenand_driver = {
 
 module_platform_driver(omap2_onenand_driver);
 
-MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jarkko Lavinen <jarkko.lavinen@nokia.com>");
 MODULE_DESCRIPTION("Glue layer for OneNAND flash on OMAP2 / OMAP3");
-- 
2.49.1


