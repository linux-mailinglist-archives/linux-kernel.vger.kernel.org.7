Return-Path: <linux-kernel+bounces-729272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90796B03427
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97591899F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 01:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C6B418FDD2;
	Mon, 14 Jul 2025 01:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FN9Ed2VK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4501CD0C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 01:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752456113; cv=none; b=Xec4Dle4YOZXlnkSuBZEK0FxoEZiEff8gG/WT9QrEgWhlWzrCZ0D7O5Vv9OcH83HR3Eo5tez0/nbXH35usRmM0a5gnuXDR0nV1adV7sHp+ryxjDRoSaJbq0iPFkqHLr2JKarEpfwJeJjGG9Ci+WNBYYVdUeJ9yqLLyA1gYhJSUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752456113; c=relaxed/simple;
	bh=XAud1Pv31eLsYz+orMn2BbAo72VanMQHTQvVzidaRao=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S69OvxrScSxw8slG/MeDUtqgkl4OIou0ahEY8OolBAZXl5FJVmhbFDbCTp6av3OYHpDGlwiWKwKnmTfn2I3XaAYacmMtxdU/8fQTLH94QayhV0dkCuXa10nnUnDtyWzPzKzMF2EGKok2NShBl0U0opYGhTuS42SRlImhrrfd5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FN9Ed2VK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F455C4CEE3;
	Mon, 14 Jul 2025 01:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752456113;
	bh=XAud1Pv31eLsYz+orMn2BbAo72VanMQHTQvVzidaRao=;
	h=From:To:Cc:Subject:Date:From;
	b=FN9Ed2VKhjH7gbh0whR3mxRzJOjpRohYEyP8bcQG72SRSuFeX1H/n0QQ52V6JlHAK
	 eiUW9veLRJT+3cd3vf74uw/YkDPqOW9diLJ6TpZx0RklfvA9BKt7yqDZUNnYcXxT8H
	 Jbyc5VQIY0xwgJ7R556tGlg1sfQTIMhNPIUHVYAZEUrTmohWsPAPU/NLA1Rjrj/bvm
	 vAzSRtQ2rvndv+pnys5XaDalo5qWvfkLwI5cz1od8u7Mpj58sTKVg6Xf5XTo+UlQ1n
	 A9VF4IgNifjJOVSERFB+iu0Zv3SoGeVrBLYzWLQALy7o+IVXIKEkwo55Ot3BqGc97+
	 rHWHrxclyYF2g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: tps6286x-regulator: Fix a copy & paste error
Date: Mon, 14 Jul 2025 09:04:56 +0800
Message-ID: <20250714010456.4906-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The volatile_reg function is named as tps6287x_volatile_reg by mistake
when enabing the REGCACHE_MAPLE support.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/regulator/tps6286x-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/tps6286x-regulator.c b/drivers/regulator/tps6286x-regulator.c
index 778f169b0acc..e29aab06bf79 100644
--- a/drivers/regulator/tps6286x-regulator.c
+++ b/drivers/regulator/tps6286x-regulator.c
@@ -25,7 +25,7 @@
 #define TPS6286X_MAX_MV		1675
 #define TPS6286X_STEP_MV	5
 
-static bool tps6287x_volatile_reg(struct device *dev, unsigned int reg)
+static bool tps6286x_volatile_reg(struct device *dev, unsigned int reg)
 {
 	return reg == TPS6286X_STATUS;
 }
@@ -34,7 +34,7 @@ static const struct regmap_config tps6286x_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.cache_type = REGCACHE_MAPLE,
-	.volatile_reg = tps6287x_volatile_reg,
+	.volatile_reg = tps6286x_volatile_reg,
 };
 
 static int tps6286x_set_mode(struct regulator_dev *rdev, unsigned int mode)
-- 
2.50.0


