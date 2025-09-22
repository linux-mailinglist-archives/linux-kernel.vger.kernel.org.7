Return-Path: <linux-kernel+bounces-827511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02647B91F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B2616D942
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3F62E972B;
	Mon, 22 Sep 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gz62KBYA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728752E7F1D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555123; cv=none; b=H3/zOOyZPNqeTHcVpc+lqXndnb8rkNkRBMNCT76o0PRNjua0aJpgJGIPVQHU7ka4956oX+Ode9JCNQJ6AnGkrWvlqozhyEKbMF+tXU1vArV7XFGD/xqIgcHT8FpsFZuHH2xeHsUKfkrJAg6fjM3SsfvJbaW9RGV79Tltv65kr04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555123; c=relaxed/simple;
	bh=feNJQYv7PInY8I5BenFb+SjBP4yk4Vqx0u5EFIvIY3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utuma1Cddi6/7HFj+nxJDHtlk/8P9ett+sCZcdyEBr1SEQkvNodVX9FbhrNFZI8wmToCMFDybmKQ/xdil3EFHzeLkGu+8ziF0V8gJYnvxg46x2txsTP9bQx5Xx9NHdk2aOJN6IBMxfdHuZwTsnU8AoCfj7H/a5LwKG/f7eggXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gz62KBYA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9C3C113D0;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555123;
	bh=feNJQYv7PInY8I5BenFb+SjBP4yk4Vqx0u5EFIvIY3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gz62KBYA4icXkq8LRLecHE6hFGtBxR2ZKAkf74n7Yfm5t8WTKoQam2QUNVsE41lol
	 MnMykPy4iMoleAUuZB2Vugf2iHe3Ggzt52/ng/dg8VZNnGUg2XUj9HA/8FD7ORNc22
	 SU3VjwfxwwGKtSs2uGBd7kVKPIkMzeI1fCj6gvtt4AJEuIGpuq5/d54XMS65PMuM5f
	 zWyufuxmGw1ZDSW4gVfxvTW4IdWWRik0aMOKC1Ts+I4nF+KkI2qi/3V+rf4b9zg7i9
	 FxJTEPZloVjPxCd9LIvVDfe6VFrcpERCLx/rK68yPuhEIS0esYnvpzSuhGmDdddii6
	 ShTj+K7svTvHQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hv-2hcA;
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
Subject: [PATCH 7/8] mtd: rawnand: stm32_fmc2: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:06 +0200
Message-ID: <20250922153107.16381-8-johan@kernel.org>
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
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index d957327fb4fa..c08d6b176372 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -2158,7 +2158,6 @@ static struct platform_driver stm32_fmc2_nfc_driver = {
 };
 module_platform_driver(stm32_fmc2_nfc_driver);
 
-MODULE_ALIAS("platform:stm32_fmc2_nfc");
 MODULE_AUTHOR("Christophe Kerello <christophe.kerello@st.com>");
 MODULE_DESCRIPTION("STMicroelectronics STM32 FMC2 NFC driver");
 MODULE_LICENSE("GPL v2");
-- 
2.49.1


