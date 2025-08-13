Return-Path: <linux-kernel+bounces-767131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8214B24F97
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203F29A3E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9402BD033;
	Wed, 13 Aug 2025 16:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="ISvYTgWh"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA40B1F582E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101801; cv=none; b=jessD/GliIPuqidGuq5A3qUvyANgSib6prXLJKJD0e3b67V/ImqLN55JN/QLHWQEquk1p00AF6HZC8COsfYZGRPmfUKh6iPQ1VyldpkcI4IcaYjykhtWnexXCzuYhtZyJ4UwZbaTQdNMCe3g8xp7iuSI1fSTjAqXy7vE+sddWss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101801; c=relaxed/simple;
	bh=dXAFOJV0SGBUatGoNYRvGk5QTJnQjgRKttoy4t0T+eg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HElOCl8sG57QZJRSNTwLMXYNB5Y+5+Xhw2ZYDQRa595N0P0/hG4WrLYdKZALb9bvYLrKOq6TBwcQEVdFsoWxDcia7KAsauUt6i44Imy+Q4ZaZVfV/kZ6ga7HIE7m/ElXwkoaFJw6cnQqKmMhcJS4efZYwP6+xnaxPNlvcXOd0bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=ISvYTgWh; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=rSNYE0+8wGItL53UywO960XlXbzNXz6cVLTWx6ycvcQ=; b=ISvYTg
	WhDGx+Wy35plAXwYUFhPtCCl8PJ7ohyke+YARSl/rdaBMTQW3aCYHG03tjxQ3RL5
	lS+Qt6fczyFDZiUyiSsLcOqjcPnHweE45GquDtv3yDwOOfJeYqX+FO04280N2not
	qNchAZ5650rZh7EQu6rRzKGoSADIcpQhBz80xUCVduS4Du5I+EMJhGuv8Yq0Z39i
	5J72ESW08BF/zWZ9VMrTzGrzFYsdgA8xRK1ieDgD1AMY0mQvc1NIvwMO8n3wT90R
	7v2ibIbmJc/R/xdY1JWKehrd2NVpNVmXDKcn9IwCnPHabtpqVE+Y8XbYFgnTkCz+
	TRfrV52Gre5fOrPA==
Received: (qmail 695845 invoked from network); 13 Aug 2025 18:16:32 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:32 +0200
X-UD-Smtp-Session: l3s3148p1@1HHeekE8Er1tKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 20/21] thermal: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:15:06 +0200
Message-ID: <20250813161517.4746-21-wsa+renesas@sang-engineering.com>
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

 drivers/thermal/armada_thermal.c | 1 -
 drivers/thermal/sun8i_thermal.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/thermal/armada_thermal.c b/drivers/thermal/armada_thermal.c
index c2fbdb534f61..252d5afecea1 100644
--- a/drivers/thermal/armada_thermal.c
+++ b/drivers/thermal/armada_thermal.c
@@ -722,7 +722,6 @@ static const struct regmap_config armada_thermal_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 };
 
 static int armada_thermal_probe_legacy(struct platform_device *pdev,
diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index 22674790629a..284684137c43 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -149,7 +149,6 @@ static const struct regmap_config config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 	.max_register = 0xfc,
 };
 
-- 
2.47.2


