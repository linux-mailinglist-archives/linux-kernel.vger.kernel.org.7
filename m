Return-Path: <linux-kernel+bounces-844455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0845BC1F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2AE189722D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218D2DECB9;
	Tue,  7 Oct 2025 15:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="mWJpFAiJ"
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D3120C01C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851628; cv=none; b=lRa5znkST1gPJyjF716NH/rtMOrsV7+IeZhUXPKFub2GBLNaoyL0takfVa5SVsa0QDnpPdC0Iv8KpRRrolNEIpfDN9bioLv7CP+TM7HGU1Pm8BgcxslNqow3ZnxHGBfB9SMBwVv0oeBnXNeRi05cp24dAuTx8fFx+Xz68M7d7+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851628; c=relaxed/simple;
	bh=a3JkyrbodJ9ulJ/3FReYIPAfUh2ATRYUq78BeE7PCdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsOUvcLKt1uFs94uWyAPLL9DDmjo4RsA+4ZVCdBix77UNY1PyzRxVB7m49pw830kiOTpqV/MHttgm9T0er2JkeXJo70TmjlRcLg2swjTQwuPcMShFzjsmEbuPOUD7s1KKfnD+Q/YRVl3rW7/wus+68lg2Fcj3dclS1XPecYtt6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=mWJpFAiJ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=bqng5mq5BhNin/
	JT5zY3F6JM9lm6hYjnIYJx7nGIuQw=; b=mWJpFAiJuz3FmfhwpGYARp4F82wUKo
	OwyfMKU3YNTKgaDxsOvhN3jvOyzL2q8SJY3ymwmF8u8+vAFJkSw2WTlPlIyaEZZ/
	DU0dNy7kqtgAylUsEFJhYRryf5l6/4xk6MLaTKDGDTMVTsczE1S97mPq4yGPXEwv
	dpzPZKZIaHr4tTsTBU8FfJOlRJiEOwZsJiMl50+CxvPasLRN44n95T08Ef9NRxDH
	o0BFjKrc6RiwrcUQJjxX+wgdGQxt8nF51aghLOV1A7/hfzC87vQxFA6A/6RXQOGD
	dB16w5YpFdrWAZTch0rv2e8RbCi9NgG0Tf6ZQSCFB8gaLp+NUwIdF+Cg==
Received: (qmail 319510 invoked from network); 7 Oct 2025 17:40:24 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 7 Oct 2025 17:40:24 +0200
X-UD-Smtp-Session: l3s3148p1@Q3jnYpNAJOMujntU
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-renesas-soc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Peter Rosin <peda@axentia.se>,
	Bartosz Golaszewski <bgolaszewski@baylibre.com>,
	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
	Support Opensource <support.opensource@diasemi.com>,
	Lee Jones <lee@kernel.org>
Subject: [PATCH v2] mfd: da9063: occupy second I2C address, too
Date: Tue,  7 Oct 2025 17:40:06 +0200
Message-ID: <20251007154016.25896-2-wsa+renesas@sang-engineering.com>
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

Change since v1: reworded commit message

 drivers/mfd/da9063-i2c.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
index 1ec9ab56442d..12f3dd927aba 100644
--- a/drivers/mfd/da9063-i2c.c
+++ b/drivers/mfd/da9063-i2c.c
@@ -469,6 +469,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c)
 		}
 	}
 
+	devm_i2c_new_dummy_device(&i2c->dev, i2c->adapter, i2c->addr + 1);
+
 	return da9063_device_init(da9063, i2c->irq);
 }
 
-- 
2.47.2


