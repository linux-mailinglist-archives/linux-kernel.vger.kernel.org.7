Return-Path: <linux-kernel+bounces-767123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB93B24FAB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDBA01C26263
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889F292B2E;
	Wed, 13 Aug 2025 16:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Bl4jGz19"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8866928D8D8
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101793; cv=none; b=egJcWXwkYtBAfdwZEDdRSf9fFkkEje1LmIiKuNapRAtLYYYs1w9svZXMEpTA8EEV53WTyayuvqrEoMNX2lbbSBf7MkWEzjWD7p8WByBafRO+0zHcW3OkzT06aV0jj1iNHjo3m9h3Xa92pk01qhlwn56YXxDu5PnXHnLzyZOmjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101793; c=relaxed/simple;
	bh=39PKVORhdA0ROM18b/3hTAHTJu+9sSCEQ56R1UYWgeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oByOrbeI5V4R9+D4L7w7ww33FOaeupXbC8OQMdDmbM2eDTS6sE/WxZh4h1dGxs24ITB84ckCivdAOY5TyuXxlqPIGQy8UMg02ZbbnjBBcwhwz7XjTL6VkEoo+hCZcsrsXciJgWrSvfu0rDBhlyvJc2Jfq1W/sjWehw03N9j2ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Bl4jGz19; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=JM9SpV/fnrsLvvM+Go1VUM4DNlcYiERXiLNTjdx9OJo=; b=Bl4jGz
	19fCVHEkw3GF9z/XPPvj6W0oFoFPA4oyVLyTay1YOjYq/cUbOU0gz2M9cv/StJt5
	sYW/iA+17QUVaXMeCgsb4sRxA18MUEqjh6qY3z/cbwKNlRbkGIyujiz+1I4D1sLq
	4DSoO25xGzEBl7sAK8DKuVviOi2QncDrj6cgtzaUjjqwXHGlCLxNFww69Xuh6WG3
	4g2ibSfe63bjqBj/aVosx4tQH8z1d3UhPmKkwoDvcX0li5f0gjfFYJj6xlif6vLh
	BIrNJN8cBzoGFA2QuLwCB7LcO32aWRqp+xNwHBl/MiATlnMP2h1O83iqOm+hmI1c
	XJjkX/jq6h4NAOdA==
Received: (qmail 695217 invoked from network); 13 Aug 2025 18:16:19 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:19 +0200
X-UD-Smtp-Session: l3s3148p1@EGQLekE8npFtKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH 12/21] phy: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:14:58 +0200
Message-ID: <20250813161517.4746-13-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c | 1 -
 drivers/phy/rockchip/phy-rockchip-usbdp.c         | 1 -
 drivers/phy/ti/phy-am654-serdes.c                 | 1 -
 drivers/phy/ti/phy-j721e-wiz.c                    | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
index 79db57ee90d1..01bbf668e05e 100644
--- a/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
+++ b/drivers/phy/rockchip/phy-rockchip-samsung-hdptx.c
@@ -795,7 +795,6 @@ static const struct regmap_config rk_hdptx_phy_regmap_config = {
 	.val_bits = 32,
 	.writeable_reg = rk_hdptx_phy_is_rw_reg,
 	.readable_reg = rk_hdptx_phy_is_rw_reg,
-	.fast_io = true,
 	.max_register = 0x18b4,
 };
 
diff --git a/drivers/phy/rockchip/phy-rockchip-usbdp.c b/drivers/phy/rockchip/phy-rockchip-usbdp.c
index c066cc0a7b4f..010e9d2d6fac 100644
--- a/drivers/phy/rockchip/phy-rockchip-usbdp.c
+++ b/drivers/phy/rockchip/phy-rockchip-usbdp.c
@@ -1430,7 +1430,6 @@ static const struct regmap_config rk_udphy_pma_regmap_cfg = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.max_register = 0x20dc,
 };
 
diff --git a/drivers/phy/ti/phy-am654-serdes.c b/drivers/phy/ti/phy-am654-serdes.c
index 431b223996e0..5b6c27aa7e8b 100644
--- a/drivers/phy/ti/phy-am654-serdes.c
+++ b/drivers/phy/ti/phy-am654-serdes.c
@@ -99,7 +99,6 @@ static const struct regmap_config serdes_am654_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 	.max_register = 0x1ffc,
 };
 
diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index ab2a4f2c0a5b..a8b440c6c46b 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -1319,7 +1319,6 @@ static const struct regmap_config wiz_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 };
 
 static struct wiz_data j721e_16g_data = {
-- 
2.47.2


