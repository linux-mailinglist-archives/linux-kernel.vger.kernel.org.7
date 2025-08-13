Return-Path: <linux-kernel+bounces-767129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376DB24FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697061C81196
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ACA29BD93;
	Wed, 13 Aug 2025 16:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="RIu9fjhs"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981329A9EE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 16:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755101799; cv=none; b=AhtEv21SkBWMsb7126ESpG5TQ3NSbz4Gb6fKwMbAzC9Hs4p+jLwQJi6lN3N2wLpAR8K3fVCLPfDPw+CAhwD22Z9/D3Cl9bX9PDau69GSQWLzSG4zMX4LXHx2gySczHD2HyRHuGG+FAkzor1hLaElYtjRcRFt/GnLd2V/TCst7Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755101799; c=relaxed/simple;
	bh=yNHnQdRrQY0EJizz/F+i0VWd+t2xPQYzgWsHv04urcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OVrVbG5G0PweZuH20Llz06UvUbxO/1mdF6HbKvZk7jDOzfHjbSSB0WuGPp6J7vJNiYjyvT7nDBW+DWfwPIxATpHlrEYgP5Kz3SMQPnrkuUXcys1t9/sjGrOSE7iaRkqWtemqr7+gx1g4PvqSPphSX9D+Og+MDckQ4qyd/ZleDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=RIu9fjhs; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ZIKoY28P9xyeTGnAymD0PpIblwBi/y6fshQk+4ZVNI0=; b=RIu9fj
	hs39H82sfWB3B8MOF4bq7butH2yhRKVfC6Dfm6qZx90N3Wb+PYvsFCs9rxpbX3Xl
	ItQFS6shpM1rQTZjPO83U0wjV55nj9MhxYc4J8DUd+lzIV/dUpzExbNn7uaK2Lwu
	UuS67u/JYagvVlZvB8MQ25r26CbcTyNYcH2wyr2PEdHwNVYFt5g/i8FVKjY5i9Ws
	5NyWN/96xoaiZn4IczVeEXuWiXnAGyIHWDxMWnwWAyKhHIFL/IwNrW2Tw0VmnEC1
	R1iO8h9QK3XN+/0xGlM32EEeWMHH7aqAY3E1RVEoEdQhqfSWq53vGYoCu40mMmN/
	Ra7bADsdXC725gxA==
Received: (qmail 695693 invoked from network); 13 Aug 2025 18:16:29 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 13 Aug 2025 18:16:29 +0200
X-UD-Smtp-Session: l3s3148p1@DZWpekE8DL1tKLKq
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 18/21] soc: remove unneeded 'fast_io' parameter in regmap_config
Date: Wed, 13 Aug 2025 18:15:04 +0200
Message-ID: <20250813161517.4746-19-wsa+renesas@sang-engineering.com>
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

 drivers/soc/qcom/llcc-qcom.c       | 1 -
 drivers/soc/qcom/ramp_controller.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 192edc3f64dc..857ead56b37d 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -4409,7 +4409,6 @@ static struct regmap *qcom_llcc_init_mmio(struct platform_device *pdev, u8 index
 		.reg_bits = 32,
 		.reg_stride = 4,
 		.val_bits = 32,
-		.fast_io = true,
 	};
 
 	base = devm_platform_ioremap_resource(pdev, index);
diff --git a/drivers/soc/qcom/ramp_controller.c b/drivers/soc/qcom/ramp_controller.c
index 349bdfbc61ef..15782bed2925 100644
--- a/drivers/soc/qcom/ramp_controller.c
+++ b/drivers/soc/qcom/ramp_controller.c
@@ -229,7 +229,6 @@ static const struct regmap_config qrc_regmap_config = {
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register =	0x68,
-	.fast_io = true,
 };
 
 static const struct reg_sequence msm8976_cfg_dfs_sid[] = {
-- 
2.47.2


