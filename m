Return-Path: <linux-kernel+bounces-827508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4D4B91F11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 431AB7A7425
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80772E888A;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLleysYm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BF22E764A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555123; cv=none; b=CwF3iPd0mH9UNy77ulS4E+2gIxrZZOe9MHMdk4twrHW9xzyFsBcW8/xXO0MNXnXu4WAvpPz+KdM2Pdqsk3zeap3+Fu+XMqShlJ5AHOqtNhhnInPRtJ3+3uIpiZVuCeJ2wZKi53llmljPexAUXAoxTrlkJV1hnLIB0t3v9vdQ1lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555123; c=relaxed/simple;
	bh=K2Jx9BZnG+1brk58AH7l9lttwi2IYYooNAGrB6W3v7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA+fCQtRjAzsLcu9LwEAAfVdo2/rL3VaS5ARzT86D5hGNz7nLnLAil1lX17TtVRMjvi5hmI3ZtxHb2y0q+h4R7X5Gp8ZvTspXd8Ce1HA8U7eRt2kyM2MONm5Ce8jDBTjsi3h/vM80iNt2Q314wHo0bf1mwfZq4xs+fTM8vkxY70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLleysYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D70C116D0;
	Mon, 22 Sep 2025 15:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555122;
	bh=K2Jx9BZnG+1brk58AH7l9lttwi2IYYooNAGrB6W3v7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oLleysYm8tMn61SqI+EdCtDkI4JMBll4THA8PsVy6EqflzIUEQ6pWTa72KiQKMSQX
	 DJWTq9yxyV5gQP7NpfLfyJKPU6YkdDEZPw3MY2EJhe+ey6CtNeURoqAEAUDzKDnVsI
	 dSzKw8R+4AnQ/T3goBgbLApDfw2TLRDrrwkxytTeRWIiq3QoEkf7e6aYDSeNDcrXTf
	 HX6mek7Rz3VUSmKt8flauLFkHXZVQQfgkKtX8pgBEYrygobKuGjZ79rz520mJBOHgW
	 KhyUhADPJ+045pswEj0uaKXAB7IdaT6n8fMILFLPm14SIsdoR1J1eqjWJtKwFmvyqD
	 TzwbTuF/VOgBQ==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hk-13sj;
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
Subject: [PATCH 3/8] mtd: rawnand: atmel: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:02 +0200
Message-ID: <20250922153107.16381-4-johan@kernel.org>
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

The driver only supports OF probing since commit f88fc122cc34 ("mtd:
nand: Cleanup/rework the atmel_nand driver") so drop the unused platform
module alias.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/mtd/nand/raw/atmel/pmecc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/atmel/pmecc.c b/drivers/mtd/nand/raw/atmel/pmecc.c
index 0b402823b619..1d0e93e4edb1 100644
--- a/drivers/mtd/nand/raw/atmel/pmecc.c
+++ b/drivers/mtd/nand/raw/atmel/pmecc.c
@@ -1010,4 +1010,3 @@ module_platform_driver(atmel_pmecc_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Boris Brezillon <boris.brezillon@free-electrons.com>");
 MODULE_DESCRIPTION("PMECC engine driver");
-MODULE_ALIAS("platform:atmel_pmecc");
-- 
2.49.1


