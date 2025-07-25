Return-Path: <linux-kernel+bounces-745686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A081B11D14
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:04:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1E18846FD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 11:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ABA2D374E;
	Fri, 25 Jul 2025 11:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="T5mdr6k7"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC489217F33
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753441446; cv=none; b=ENsolz46rxQznKLPz3hQ1d3xe76Vi4um6H78pANfCHSAdX/ec8K4Eo28afdjbzuBrc59DvpbUKOWRuYv4+hauMx7qhlisHM7hhA5GQFJ1D/4EK10PaB+R5XXwSMS2h6CPZ0BPThObEVQPTSJYOPX+Vx+n3A2h6TjA9NTj1tUwb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753441446; c=relaxed/simple;
	bh=FrmVuUO8YGheljp2+zSpl/rMINmRFl6XWGZKsNk7LgU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pIb73Bwi6EzJcD+K3zWVOjYZR9TrIGmOhFV0gQpf/ri/oPQ1V8AR/VoRy1X4pAv5/RlJMgPKliI1Br8uro3AQJe+lvZCUMaX0rmpBVHKrakzS+FvL3TS8Nvs43pgAL8oAdm5kZl73nXy/9GN+ncmb9Mzgzlzw/vLQ0FqI32lWT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=T5mdr6k7; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=uMJvuQ4Jf1U4b0
	UH+tMMYWcDtn6l0ea5T6mZIYEFjoo=; b=T5mdr6k7WrRFeqPMACogSqKxLCw4xS
	X8yC55tK5ETsVbL906n1v4+rBkeFe/3dLqp8uWe++hdqmC5ANSWEe3HedU5cyxoI
	74xqhw6w9BrwI72y1LBEOW/ISzsnK5SGcaLYV2434lotYEcN9N7Ih6+74xSUiI20
	9G/592L+mDnpdIce4CgXFf4MOmSOQg/LRkJL2vDlr9KhYXhKbgY9/xAX8Q8pdtTO
	E0hnu/buuXok3FWWm3gn89qszVmKyUw50zfrDaz1bUnd1ih/JtOnaW4Vv8bZqunm
	HajptmwJIpxk5MgHtgbHNGuM7K/DaJgnQI28hu+fjVfdu6T91MmH97Aw==
Received: (qmail 2408209 invoked from network); 25 Jul 2025 13:03:49 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 25 Jul 2025 13:03:49 +0200
X-UD-Smtp-Session: l3s3148p1@pn+F5b46MpwujntZ
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH] regmap: Annotate that MMIO implies fast IO
Date: Fri, 25 Jul 2025 13:03:27 +0200
Message-ID: <20250725110337.4303-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document that using the MMIO helpers will automatically enable the
'fast_io' parameter. This makes the used locking scheme more transparent
and avoids superfluous setting of this parameter in drivers.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

If this is approved, then I'd send out a series removing the unneeded
'fast_io' setting from drivers in the tree.

 include/linux/regmap.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 02b83f5499b8..4e1ac1fbcec4 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -913,7 +913,7 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
  * @config: Configuration for register map
  *
  * The return value will be an ERR_PTR() on error or a valid pointer to
- * a struct regmap.
+ * a struct regmap. Implies 'fast_io'.
  */
 #define regmap_init_mmio_clk(dev, clk_id, regs, config)			\
 	__regmap_lockdep_wrapper(__regmap_init_mmio_clk, #config,	\
@@ -927,7 +927,7 @@ int regmap_attach_dev(struct device *dev, struct regmap *map,
  * @config: Configuration for register map
  *
  * The return value will be an ERR_PTR() on error or a valid pointer to
- * a struct regmap.
+ * a struct regmap. Implies 'fast_io'.
  */
 #define regmap_init_mmio(dev, regs, config)		\
 	regmap_init_mmio_clk(dev, NULL, regs, config)
@@ -1138,7 +1138,7 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
  *
  * The return value will be an ERR_PTR() on error or a valid pointer
  * to a struct regmap.  The regmap will be automatically freed by the
- * device management code.
+ * device management code. Implies 'fast_io'.
  */
 #define devm_regmap_init_mmio_clk(dev, clk_id, regs, config)		\
 	__regmap_lockdep_wrapper(__devm_regmap_init_mmio_clk, #config,	\
@@ -1153,7 +1153,7 @@ bool regmap_ac97_default_volatile(struct device *dev, unsigned int reg);
  *
  * The return value will be an ERR_PTR() on error or a valid pointer
  * to a struct regmap.  The regmap will be automatically freed by the
- * device management code.
+ * device management code. Implies 'fast_io'.
  */
 #define devm_regmap_init_mmio(dev, regs, config)		\
 	devm_regmap_init_mmio_clk(dev, NULL, regs, config)
-- 
2.47.2


