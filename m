Return-Path: <linux-kernel+bounces-866305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A37C5BFF6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 08:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B32F84F0AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8679929DB61;
	Thu, 23 Oct 2025 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jymTsv0p"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CC229BD87
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761202584; cv=none; b=XbPj90+pqReGtTRSIUPm1dYDRFyafMpi7FDeTO7ReosSRxhTT45HYAHJGlIvlan6X62eZP0bxfB6KrCgeRDmRfty1YPfoI0VbAAV0mcuS3iYYn843VLaEjuI1z8NO9Yt0IY7gtGdlaA9Tpnn/aRcAmJv35i13Bqz+Cp0zBDGLIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761202584; c=relaxed/simple;
	bh=Gjd8j2/DIwjkc0A/jP6a2ujhrsI7hHy2Hy/bJ0HdPHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lNkCGT434peLD27LK68G2WhymnBQq4Hwdu4am6XNZljH6cH8qgGKzP1YkRPXVa+/hRrdOFgpK0yQKJTJdke7AXG+tzmk5ZN1XvDS6EczErn8VjboXLoGRykOb/Q2H5OZu2KmIS1SXayV3O58RSJXUBve9KWMQXR2o39mWB4pk4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jymTsv0p; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=L7woAfdKTTz32O
	hWPBwBTKEj4mFzE3FP4tRQ+CWXn44=; b=jymTsv0pb4ks33zEq/NTTmpCCxVhL5
	2io4mPNESfC2x6oGYAvOxJeeP1GF0Kr6X2xBlz3Wa1onubmv4q166jpRtjhxsy3g
	tJduXQPCob3KQqWB10TkqCdTD6v9YljaU2atCu06EVyvfpcSBgn+FqQHwdfrjW0T
	hArroO3WeIUvhIYvIhmifnB6PJukdPoj6ljxk8WoarhmVc1KXE74uLu2+vMc5p99
	nkJfkzN41uCCEkFI1l+EJa/a4UYwN8xcy0aG2gvz0Kske6KjBRjmA0jwlv+TqSdO
	rLMELp/u5jcewRrz0sjG2LZnOyrabXpYmBvFT5TYt6UeBDLeFAM8thwA==
Received: (qmail 2097683 invoked from network); 23 Oct 2025 08:56:18 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 23 Oct 2025 08:56:18 +0200
X-UD-Smtp-Session: l3s3148p1@36sI7s1B3V5tKPAY
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v3] mfd: da9063: occupy second I2C address, too
Date: Thu, 23 Oct 2025 08:55:59 +0200
Message-ID: <20251023065610.2855-2-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The second address can be used as a shortcut to access register pages
2+3. The driver does not use this feature yet. The second address should
still be marked as used, otherwise userspace could interfere with the
driver.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Peter Rosin <peda@axentia.se>
Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
---

Change since v2: add comment in the code as well

 drivers/mfd/da9063-i2c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 1ec9ab56442d..a803b7440f09 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -469,6 +469,9 @@ static int da9063_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
+	/* Reserve our unused second address so userspace won't interfere */
+	devm_i2c_new_dummy_device(&i2c->dev, i2c->adapter, i2c->addr + 1);
+
 	return da9063_device_init(da9063, i2c->irq);
 }
 
-- 
2.47.2


