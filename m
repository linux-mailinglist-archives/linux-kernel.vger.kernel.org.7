Return-Path: <linux-kernel+bounces-827512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33AB91F26
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1D242397C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5242E9735;
	Mon, 22 Sep 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0v40rMt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D89A2E7F22
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555123; cv=none; b=tusZeBPEzhG/qew3yJZ+iGnH604Bo1oXs/S+M3zCjcRYqDIpI3L7UT8XFSlOF5XFpOXkAOCz5j9oFSoZbcnTX7IYfV5lrfktzwd3CA2Qnfsmb5cyBJNChUjkp/qqeEQrXNsAGou/VEZ7wz3jz1Hh8WufCVGbap7ql3gVpShBnp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555123; c=relaxed/simple;
	bh=I9Zhr/ncIXq/m3dpt8T77ukTpAxt82yNYfe1wjICwFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ApwCkDLJocyaY07IpRbdzc9uDwccki2bVPOzwJStfDhDAm9WDeGW3i3Y2rWHFj2jXMcn0gXtFad4THp+Nw+BALipPY+CpO/T+cd9jskoE/eC52fcAdH31l6t9ID/DIzq2wUqgMjAxFwzOnIeorDlfH6S+AAHlgZY/kH7U4TQZZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0v40rMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBADC19421;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555123;
	bh=I9Zhr/ncIXq/m3dpt8T77ukTpAxt82yNYfe1wjICwFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0v40rMtUuCWItO0Sc01keGjKU8iGrhe5gVrS4BiJ48e1TdRGzdaRNq2EJDeVm2QV
	 AjSPfqG0lk4YclZhLk8YioWPhrD+7YnGJRKSfbi/ghPLhE6wYs00Py+TbXTb66tf6+
	 x2S28vHktHwCTYoHhY+ghoUhRMNHW4nHg0y7kLLp9doZbLeklnUpLxbEebpJ39fU7r
	 TnApx1atpPeIyv9xaBZ/8Ox2f8ow1Q4LkDp1wIzp54MK5VZMLFAu/cbKfu8tJbRo4O
	 jsXUW9+OKLdv6lMmnHKmjHNjkxXD5ILlaz9Gu3ZViy79BdJywHqdKNqH6xwWgJS5Sf
	 h5ugw+9h7brEA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hy-34zZ;
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
Subject: [PATCH 8/8] mtd: rawnand: sunxi: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:07 +0200
Message-ID: <20250922153107.16381-9-johan@kernel.org>
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
 drivers/mtd/nand/raw/sunxi_nand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 162cd5f4f234..f6a8e8ae819d 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -2205,4 +2205,3 @@ module_platform_driver(sunxi_nfc_driver);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Boris BREZILLON");
 MODULE_DESCRIPTION("Allwinner NAND Flash Controller driver");
-MODULE_ALIAS("platform:sunxi_nand");
-- 
2.49.1


