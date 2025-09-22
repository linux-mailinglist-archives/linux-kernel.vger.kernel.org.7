Return-Path: <linux-kernel+bounces-827506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72F0B91F0E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFE0162B85
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BB62E7F2D;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrUriq6d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBCB2E7197
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555122; cv=none; b=LrmUaOqPeIVPWYk39+ZKBFtRSojulif7+xRFlvGxul93zGyTqLPZvfLkXunvRbKwTibbLa2ybUliKRE8lPs0CYbmVHP47HdV41pei8KdcfmHyp/o9wwzxUt/g06SUljenr3xL3teKrPDmzKuTDTtJ5CvgRjyzh4rmlh/LyHfpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555122; c=relaxed/simple;
	bh=ddj8UKH4huUFJGE9FKRdTHGDb0ml3M9Cy1EDisYFHSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lw6pgiGGmeffCCTI5U54tUwgITlOEgwt28MXgkz929EdnNTpt0AICBuxFcFU18JeYbAd5xY2XWlgmTkC/us2Oe2kdeEP/ewptm9J/qcHnB5Uv1apmdsaNGNm9t+/LtwQGgL6xoPl7cl3zHlBazrtq4Vx6j8US+ps0G51C/Wti8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrUriq6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89129C113D0;
	Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555122;
	bh=ddj8UKH4huUFJGE9FKRdTHGDb0ml3M9Cy1EDisYFHSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FrUriq6dOL/U5p1ZoLTASDcX/reFEHmxCrFfd4GeEJ6vo/si7FzS9T//a2p0ZMI+n
	 XthIUEbWDO28X37aAONIIHYiHpGmq92fNuXlrFYu0Fk6wVgyHuZGK/euI5bYIbdZ2Y
	 ZR/DujimGuVWfrd3Bk1oqk5Lq7WlG3MZM6+gaBufmGKC0416lFmhWMpbYdcq3t7t5+
	 /JZGksW3IOgiTjOYeE6v890sYL4m2Q8K3KQDZ/88rpsET52bYLH5uCpgGf6jE92/NU
	 YhFGXIVGPGMIGSEysQWC9f5WrH8o0hJDtVXfBwTG6bnt3gvrhR6imTMsyzOHq4Vo0x
	 xVexMxioj8S3A==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hg-0DB6;
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
Subject: [PATCH 1/8] mtd: hyperbus: hbmc-am654: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:00 +0200
Message-ID: <20250922153107.16381-2-johan@kernel.org>
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
 drivers/mtd/hyperbus/hbmc-am654.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/hyperbus/hbmc-am654.c b/drivers/mtd/hyperbus/hbmc-am654.c
index 82a1e7b7e4d8..9d31464046b2 100644
--- a/drivers/mtd/hyperbus/hbmc-am654.c
+++ b/drivers/mtd/hyperbus/hbmc-am654.c
@@ -272,5 +272,4 @@ module_platform_driver(am654_hbmc_platform_driver);
 
 MODULE_DESCRIPTION("HBMC driver for AM654 SoC");
 MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:hbmc-am654");
 MODULE_AUTHOR("Vignesh Raghavendra <vigneshr@ti.com>");
-- 
2.49.1


