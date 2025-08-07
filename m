Return-Path: <linux-kernel+bounces-758732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6053B1D339
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 09:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2501167922
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37016238D22;
	Thu,  7 Aug 2025 07:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jGi1Vs0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C8C21FF38;
	Thu,  7 Aug 2025 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754551366; cv=none; b=lJWWMDF7QzsrsVYdKb3G2alcPVcmOv2H41sih9cvq2cyZpuVRVGSurpjeS+4vSuZxlZzLzoNAcipyF6IMxmFA8/asJ5PgxmREoEcdzNlzlxqe1UkyuZ9beVCJn+G5zZ0qEzPxD42s4FWQ5zn6AkoxJZ/rzziuthU3jOxhzzS9LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754551366; c=relaxed/simple;
	bh=Ln9J9actxLc5xAPkKcOUzVs/qhtgBmwzriztB3+/cmE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jzB3Oq4hvvZBXb0lEzq12HZd0mxJa3tq78W3mH+s3wejbRoF4y/dyN7h7ZxUsAVhgx7g7gbU1LSVcB57Wypydl8xVnjRyN6l/9WbWzvI14rTXAJqR3JdvSnTA5c/GTuAy7fM6JLBWJWozNKxB7jF6dCx0vYSNR0sDFPtKWW/+5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jGi1Vs0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA492C4CEED;
	Thu,  7 Aug 2025 07:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754551366;
	bh=Ln9J9actxLc5xAPkKcOUzVs/qhtgBmwzriztB3+/cmE=;
	h=From:To:Cc:Subject:Date:From;
	b=jGi1Vs0QAHh2DtPS3WJ3u84vyALTfZW3h9vlITtAezquX5Z42LSXN08ReZ6+JWi11
	 HqBo31+LKEGCk2TiZ2Dp88+Y16ZojTXlcr4vQSoF9CyFxqJpoyju1tZa/FtTN1p2UN
	 EYQDXNceougVgyj+pm+/j3NuS3w5k5lxOHIPKWdWlahKmQ5e8eDqsMGrkDpE7NT9rY
	 MVCWvq+UBqkmgrw/suERUYoU1kJ4jGkAVAmpJzwyOYRzDrB3g62b7beM2+UQCzPmAd
	 UZd9N2xQA7JIvVvX6BgMvD1FtpkmA/pyHywD0ccd8ij0MfcwPRVkXSINU3ZQTm19Zi
	 R99ylN4DJVOlQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Tomer Maimon <tmaimon77@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Yixun Lan <dlan@gentoo.org>,
	Sven Peter <sven@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Andrea della Porta <andrea.porta@suse.com>,
	Robert Marko <robert.marko@sartura.hr>,
	=?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Nikita Shubin <nikita.shubin@maquefel.me>,
	Andreas Kemnade <andreas@kemnade.info>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] clk: npcm: select CONFIG_AUXILIARY_BUS
Date: Thu,  7 Aug 2025 09:22:37 +0200
Message-Id: <20250807072241.4190376-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

There are very rare randconfig builds that turn on this driver but
don't already select CONFIG_AUXILIARY_BUS from another driver, and
this results in a build failure:

arm-linux-gnueabi-ld: drivers/clk/clk-npcm8xx.o: in function `npcm8xx_clock_driver_init':
clk-npcm8xx.c:(.init.text+0x18): undefined reference to `__auxiliary_driver_register'

Select the bus here, as all other clk drivers using it do.

Fixes: e0b255df027e ("clk: npcm8xx: add clock controller")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 4d56475f94fc..b1425aed6593 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -364,6 +364,7 @@ config COMMON_CLK_LOCHNAGAR
 config COMMON_CLK_NPCM8XX
 	tristate "Clock driver for the NPCM8XX SoC Family"
 	depends on ARCH_NPCM || COMPILE_TEST
+	select AUXILIARY_BUS
 	help
 	  This driver supports the clocks on the Nuvoton BMC NPCM8XX SoC Family,
 	  all the clocks are initialized by the bootloader, so this driver
-- 
2.39.5


