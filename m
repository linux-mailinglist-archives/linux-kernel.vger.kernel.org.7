Return-Path: <linux-kernel+bounces-827513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0B7B91F23
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 17:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B561904952
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C2292E9731;
	Mon, 22 Sep 2025 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAb746ai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E1D2E765E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555123; cv=none; b=FrX5I+Ftc3bBA7KT7n3B7Zcd+q0LoHWFXkcC7mL3+IN55n9MMfmU352lq/dnI+yF8Njap6J4YFWBDn5EZuFCQDsPqFL9M9LV05Izj+zsCMZE6gCjlG2qBhfaTfW2j1jdiYWj6QdEobCtXteGRJ9xsRDX7b404I69pbHwD8ztpWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555123; c=relaxed/simple;
	bh=/46VNVTt4hRRDh5qNYXbGvkTgn2zbGiWAxCXIl/j0UM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Exbzt/1Vlqbkst9BR5SCwShmG/22h9mjUADSFiGdd8vL1i6POSi6E8V/BWgDGt+Q+dxnze2toKuXTkJISs2rD8sU6vCwpkZcO+nBFG2A0uL+kaxiOlX4ggzUrHh6TNy16F47q94uWOt0QloOqrBGtPGatRIY4xG838RwJ8Vyubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAb746ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C1DC4CEF0;
	Mon, 22 Sep 2025 15:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758555123;
	bh=/46VNVTt4hRRDh5qNYXbGvkTgn2zbGiWAxCXIl/j0UM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qAb746ait+z7U0VtEUwrdGoN50aXNUR2tNbPZA1ft84qr0fGqd+96zVb/GPcdmyzO
	 FV7h66ZEcbdsclu20Yq52/2I747nwx878AgDhQDtDHXgmIRrPkLg6dmcLh/449UuaU
	 VId6JLnKV5QQP24bu9APR9QPYVYH7CIdOSwCN9aNZrdrNHRMgFxKvllI4ZNtzB4hID
	 p9pa+Hg61tQvX/O4ruXL2fb+IHje3+qJqgXdpnqExUiiY6WMHjB18A7QoWqXEgzRak
	 l6VYm7y/pgrdb5bX+DTB6+S7nqxsrq0u9/F4++8I0mt/Gjg8vQm19t8RAulX6JLBYM
	 nNaWxWTLTenOw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0iWC-000000004Hs-2I78;
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
Subject: [PATCH 6/8] mtd: rawnand: rockchip: drop unused module alias
Date: Mon, 22 Sep 2025 17:31:05 +0200
Message-ID: <20250922153107.16381-7-johan@kernel.org>
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
 drivers/mtd/nand/raw/rockchip-nand-controller.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/rockchip-nand-controller.c b/drivers/mtd/nand/raw/rockchip-nand-controller.c
index c5d7cd8a6cab..9444ba02696d 100644
--- a/drivers/mtd/nand/raw/rockchip-nand-controller.c
+++ b/drivers/mtd/nand/raw/rockchip-nand-controller.c
@@ -1505,4 +1505,3 @@ module_platform_driver(rk_nfc_driver);
 MODULE_LICENSE("Dual MIT/GPL");
 MODULE_AUTHOR("Yifeng Zhao <yifeng.zhao@rock-chips.com>");
 MODULE_DESCRIPTION("Rockchip Nand Flash Controller Driver");
-MODULE_ALIAS("platform:rockchip-nand-controller");
-- 
2.49.1


