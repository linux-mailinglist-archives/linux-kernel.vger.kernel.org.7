Return-Path: <linux-kernel+bounces-887481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E42C38574
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97144EFBDD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9392F5A3F;
	Wed,  5 Nov 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b290bynC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB3423D7DA;
	Wed,  5 Nov 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384970; cv=none; b=AHmWSI9rbvW8ULohGzYyu5XSEa/N8ki/+iSozzcbBQSrtlvsf70fuVdXzpL1wChOscd+vVJ5H5rWWoDyXceOTIvb6eBll+hA9+Xf9x4MEn1D4DUP1FQmJqREzTFxMfOHmm0KrwoLizIDaww8jP+bTjSA27nnkLdNveBQKkTN1tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384970; c=relaxed/simple;
	bh=8vNtLMJW7sfLRG69Q7Ef3VqR5cfx+nfcbE6oqTigqlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mqcyHU3Dtci1YwpSRaN7s8lkhhjog+ySyvXVWYamMW1Z9xeldW95YUDpRaQGnWu6wsi6mkaKlNLo6gbiGxkJ3y5RGQm52L2a5OiWNVyjjY1Ghhr3kP8fYYJuQfiihpdh9glcLJJVlZTT86IbqoLVssFpbO+pZ0BeJ2v3FG+0R/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b290bynC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD985C19422;
	Wed,  5 Nov 2025 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762384970;
	bh=8vNtLMJW7sfLRG69Q7Ef3VqR5cfx+nfcbE6oqTigqlg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=b290bynCIAD6N4jh8Rwy39MO6jdV8s2FtQ/jvdHr5Vm+BgU2R0gm9hAlRG5WA4xaY
	 2zo1o367oxUbgPN7Zo78u+ImhtSfqLbxlrsnrZ6/V5F1UEvEH0yaX0SY8/Ul7Xa3YY
	 /mMN+oEiSYNNrsEQljgHQkmDR2h0Wmj1i7WyStDt3jqxEFgA2Dcg6JLAE5MNjfdbk+
	 9Rw/50qrnGEv5bx59T0QaQbNtyXdrH7Y3ZaoviqGoRy+39kNny7IUdwRVY9zwGRgHg
	 9oEmMEO63b8/05aWyoE2iYclSk8182A1PGThjqBn8rw3mDO+SBmMJrFA5jGqwE9bdX
	 EeYBnD/aVZWnw==
Received: by venus (Postfix, from userid 1000)
	id 442B61802FE; Thu, 06 Nov 2025 00:22:45 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
Date: Thu, 06 Nov 2025 00:22:40 +0100
Subject: [PATCH 1/4] platform: arm64: thinkpad-t14s-ec: fix IRQ race
 condition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-thinkpad-t14s-ec-improvements-v1-1-109548ae75c0@collabora.com>
References: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
In-Reply-To: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=8vNtLMJW7sfLRG69Q7Ef3VqR5cfx+nfcbE6oqTigqlg=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBpC9xD1AgyIQqyoF/XbjkPDWyo4oX9Umr/XgcFA
 b+ov2HKL8aJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaQvcQwAKCRDY7tfzyDv6
 mo2RD/0a2ZM60/zbuXgcoGTVmC2PdUelh3SW4sFUvqCU+CZjJFmpNtOR0KgUD2nCN+5LczsZPPZ
 cQQgufJ3l9O4zhRp0oDxwkxz2rmaOBOUS+FK+YpLSd9yoN02rcS+OrSXvKGBMbjBMKDe8P+9kbm
 6M2mN0aiiS3QoNuOI9x4BfMfzfUXVL7yf+GuD8O1cmowhaHlSa1cu1YTm0QlTZ6T3erY3kNf9bS
 rymGxIpdZ2F0k1VU6GoQ9qZ7kdGovnD/WWJf0TrSTT4pXIiAsp0Vejx0eCfHPofLjXDFFBNJKfu
 hfdBwqPyoo3CqGoirfUmiEZNPD/j2rhOkq+U4b2j1H491o2ihvgYM3QCS8r9tEwOfCrW+6mHa8k
 +39WNYLcnpmjcnw5kKbnBOpM9jA++Ddc0SDNWa7NkBgT4n/1WSpVmXZPW0vMQ/chA5BI2qMBoJj
 0fjmkp7EAQq1RX+WURi6HYvNA8T8Kg44XmqUWxo0Ik+/1LTPG2Zpwtyj2SVLjb8VnEHAhFUzHVD
 lVmP9WK8pK8k94osOn0Cu8qbabvcWeCWzuj81Py3miKgy5+b7kJHMFL4qJALRCXtxC4X40u2vSE
 6TlZT4oh3zYdD1p0AiVUocUTW7nsm7DKVIIMBgSXRnFjI8OdvlLZaXPfUnpwzthlaAkDfGAoYT5
 uGQ/safzmlBFk/Q==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Fix a race condition, that an input key related interrupt might be
triggered before the input handler has been registered, which results
in a NULL pointer dereference. This can happen if the user enables
the keyboard backlight shortly before the driver is being probed.

Fixes: 60b7ab6ce030 ("platform: arm64: thinkpad-t14s-ec: new driver")
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/platform/arm64/lenovo-thinkpad-t14s.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
index 1d5d11adaf32..c1c01b977f2b 100644
--- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
+++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
@@ -557,12 +557,6 @@ static int t14s_ec_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(ec->regmap),
 				     "Failed to init regmap\n");
 
-	ret = devm_request_threaded_irq(dev, client->irq, NULL,
-					t14s_ec_irq_handler,
-					IRQF_ONESHOT, dev_name(dev), ec);
-	if (ret < 0)
-		return dev_err_probe(dev, ret, "Failed to get IRQ\n");
-
 	ret = t14s_leds_probe(ec);
 	if (ret < 0)
 		return ret;
@@ -579,6 +573,12 @@ static int t14s_ec_probe(struct i2c_client *client)
 	if (ret < 0)
 		return ret;
 
+	ret = devm_request_threaded_irq(dev, client->irq, NULL,
+					t14s_ec_irq_handler,
+					IRQF_ONESHOT, dev_name(dev), ec);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get IRQ\n");
+
 	/*
 	 * Disable wakeup support by default, because the driver currently does
 	 * not support masking any events and the laptop should not wake up when

-- 
2.51.0


