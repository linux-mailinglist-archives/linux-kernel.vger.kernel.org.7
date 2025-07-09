Return-Path: <linux-kernel+bounces-723609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C621AFE912
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17BAF5A5F1F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFA2DCBEB;
	Wed,  9 Jul 2025 12:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="fOBEATeX"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513D32D8372
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064541; cv=none; b=r2dfg1n3jzR5MOTfSfCwiBRd5wcoBzhZToieUK4IG93aNTgCmYnaMX3d/+8OxtYtrhCwPradyw1K+g0zakAsek+itqMXvYctKklYqIaBHQtYIAtLNrxRGQ/jhARN2EPLyXaxwzGgzdzH1SIe4x9uDAoOKZCua5xm5jonx4GyrrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064541; c=relaxed/simple;
	bh=z0pEcaFdX1yd9IHupt7wmviVD2op/A2i/iHGuBD69Vk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gdyt2mEOK80KJaoUGMxd1qOJcsscHyKZydSC2jJ/XjEDErbYa5SBo6wq1I2nBvrkTLd7sGJB4+icjqU5aoB3WXlsfR7Hb80+2DMBWE9v/JGirDtmAXvaxZBCmUWLVmlu+jV7oHo1G1k9m+uqkbSFJXhj3njGZdjxBi469zNpDmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=fOBEATeX; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752064523; x=1752323723;
	bh=QFLdHZPsiVDuudhP2SAE0d2N2Vdy6GOZKJjRx5dgUhA=;
	h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
	 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fOBEATeXFfuKhBnt5G0HpABcM1ohZziLrHCy5EelR+VwwbJZKTrI08fX/PfpFlV+T
	 TCs8rs2NpEBtcViaIM4sq1fM/spBaVqeMaJMzmGik+oXQwH5LYMA0sK8phBPxvd/kI
	 NlBfMrKlVvL6sS30hyhecXLNE7l8I3GjFbKpjlKIb4tv+tF6yrwm08Cwg6dyr34kdj
	 NisG68WY6SRMOKqMB3DgcLh0rG2KAO0sIsZqwn+YuXKUXgFNK1du0zvnM3DmO+XNPy
	 NRYU/qrZTOY9kXgJkBzuQQ1m4sct/aX3h6gmFWf+MlTm0r9BEE6hjsKqegrUF5Vw/6
	 vBYEAxsAj7HIw==
X-Pm-Submission-Id: 4bccrT6J61z1DDrW
From: Sean Nyekjaer <sean@geanix.com>
Date: Wed, 09 Jul 2025 14:35:10 +0200
Subject: [PATCH 2/6] iio: imu: inv_icm42600: Use
 devm_regulator_get_enable() for vdd regulator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-icm42pmreg-v1-2-3d0e793c99b2@geanix.com>
References: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
In-Reply-To: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

The vdd regulator is not used for runtime power management, so it does
not need explicit enable/disable handling.
Use devm_regulator_get_enable() to let the regulator be managed
automatically by devm.

This simplifies the code by removing the manual enable and cleanup
logic.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 25 ++++--------------------
 2 files changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
index 1430ab4f1dea5d5ba6277d74275fc44a6cd30eb8..c8b48a5c5ed0677bb35201d32934936faaf7a1a6 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
@@ -167,7 +167,6 @@ struct inv_icm42600_state {
 	enum inv_icm42600_chip chip;
 	const char *name;
 	struct regmap *map;
-	struct regulator *vdd_supply;
 	struct regulator *vddio_supply;
 	int irq;
 	struct iio_mount_matrix orientation;
diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
index 69496d1c1ff73132f5e7bd076d18a62c293285a2..35f7c66d77790829a739d2c54ba77e53903a9297 100644
--- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
+++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
@@ -697,17 +697,6 @@ static int inv_icm42600_enable_regulator_vddio(struct inv_icm42600_state *st)
 	return 0;
 }
 
-static void inv_icm42600_disable_vdd_reg(void *_data)
-{
-	struct inv_icm42600_state *st = _data;
-	const struct device *dev = regmap_get_device(st->map);
-	int ret;
-
-	ret = regulator_disable(st->vdd_supply);
-	if (ret)
-		dev_err(dev, "failed to disable vdd error %d\n", ret);
-}
-
 static void inv_icm42600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm42600_state *st = _data;
@@ -773,23 +762,17 @@ int inv_icm42600_core_probe(struct regmap *regmap, int chip,
 		return ret;
 	}
 
-	st->vdd_supply = devm_regulator_get(dev, "vdd");
-	if (IS_ERR(st->vdd_supply))
-		return PTR_ERR(st->vdd_supply);
+	ret = devm_regulator_get_enable(dev, "vdd");
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to get vdd regulator\n");
 
 	st->vddio_supply = devm_regulator_get(dev, "vddio");
 	if (IS_ERR(st->vddio_supply))
 		return PTR_ERR(st->vddio_supply);
 
-	ret = regulator_enable(st->vdd_supply);
-	if (ret)
-		return ret;
 	msleep(INV_ICM42600_POWER_UP_TIME_MS);
 
-	ret = devm_add_action_or_reset(dev, inv_icm42600_disable_vdd_reg, st);
-	if (ret)
-		return ret;
-
 	ret = inv_icm42600_enable_regulator_vddio(st);
 	if (ret)
 		return ret;

-- 
2.50.0


