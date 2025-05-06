Return-Path: <linux-kernel+bounces-634815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAB2AAB4B1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 07:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3617E1BC3D2E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 05:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F040480B5A;
	Tue,  6 May 2025 00:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Smvkm8fb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E5B2F2306;
	Mon,  5 May 2025 23:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486792; cv=none; b=BUwAW3uzzzB3y1MOWmulgaJzCs7C8pb5rnFDOOc3p2C5evko0u8HrStXc6qvDI34D5GKy1eV2OtbtiNxTcu6FcFM3amBV4lEhTb4W9r3t7AHcv7waj6r8IA5zd0x4Pa84Ru/rlflC8hYSQ0Y8HInVth3cnfQFy179VIjrt8pOGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486792; c=relaxed/simple;
	bh=zERVQQNvuOQinF99ex3FLAIPNtpSUKafbHMHhaIZqb0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VyW/EUWaghRF6HVuwD3L9jk1zL2wNIGjWo2zaZkmUBZVcAkkSmom8+qnUgWp+wxse/8yYeaecYt6LgTrtfmIYvuJXnUA5a9sEd4o0r+OOldBEzohCZb/8+MH4VXeMxq2OFfa2DIcF6wIPR6zsAQBJ0cYgLaNhlW4LbrVNpWmEPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Smvkm8fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9523AC4CEEE;
	Mon,  5 May 2025 23:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486792;
	bh=zERVQQNvuOQinF99ex3FLAIPNtpSUKafbHMHhaIZqb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Smvkm8fb7sO/BzHtbCdY8QIV0bnGkL5Qgs3akWIlkY10eF9eXQWKeCJiNqL92CanN
	 ZA9Bv0QnlDKB+L7ilaNh8JwkrZcb9NxvBLMN42X+P+hwEIbHruIOdQ6nVVwl5NrP+f
	 B62KDlh3EaNO+tLffqScb7LSELCFlih5oix2JNrY5p9V1lbbVtr93D94yS9jxtmyL3
	 HivQAh1tlTJN/mxg1VPZTHX/MGJlPqneV7jWzo4ukaAf9+HDHQ/C1FgHfuiOsxD+cd
	 FU8NhF0iOh6hNq3gZsqb/iEtf8IIPPsT70eBI1qROUEsIOlZ6antv20Grjn3Gp+skb
	 +vKg+rms1nFlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Isaac Scott <isaac.scott@ideasonboard.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com
Subject: [PATCH AUTOSEL 6.1 208/212] regulator: ad5398: Add device tree support
Date: Mon,  5 May 2025 19:06:20 -0400
Message-Id: <20250505230624.2692522-208-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505230624.2692522-1-sashal@kernel.org>
References: <20250505230624.2692522-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.136
Content-Transfer-Encoding: 8bit

From: Isaac Scott <isaac.scott@ideasonboard.com>

[ Upstream commit 5a6a461079decea452fdcae955bccecf92e07e97 ]

Previously, the ad5398 driver used only platform_data, which is
deprecated in favour of device tree. This caused the AD5398 to fail to
probe as it could not load its init_data. If the AD5398 has a device
tree node, pull the init_data from there using
of_get_regulator_init_data.

Signed-off-by: Isaac Scott <isaac.scott@ideasonboard.com>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
Link: https://patch.msgid.link/20250128173143.959600-4-isaac.scott@ideasonboard.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/ad5398.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
index 75f432f61e919..f4d6e62bd963e 100644
--- a/drivers/regulator/ad5398.c
+++ b/drivers/regulator/ad5398.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/regulator/driver.h>
 #include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
 
 #define AD5398_CURRENT_EN_MASK	0x8000
 
@@ -221,15 +222,20 @@ static int ad5398_probe(struct i2c_client *client,
 	const struct ad5398_current_data_format *df =
 			(struct ad5398_current_data_format *)id->driver_data;
 
-	if (!init_data)
-		return -EINVAL;
-
 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
 	config.dev = &client->dev;
+	if (client->dev.of_node)
+		init_data = of_get_regulator_init_data(&client->dev,
+						       client->dev.of_node,
+						       &ad5398_reg);
+	if (!init_data)
+		return -EINVAL;
+
 	config.init_data = init_data;
+	config.of_node = client->dev.of_node;
 	config.driver_data = chip;
 
 	chip->client = client;
-- 
2.39.5


