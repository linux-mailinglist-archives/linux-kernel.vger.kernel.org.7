Return-Path: <linux-kernel+bounces-887483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 967A2C3857A
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAD0D4F02D0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8452F60C4;
	Wed,  5 Nov 2025 23:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF8ue5D/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBB529992A;
	Wed,  5 Nov 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762384970; cv=none; b=UMg9H16Y6FEZbac1t33kmW0Fpf9B7+4vAYPtHmw2wLEbQOP5VIFiWZA0dBY8Dpu6mItRv0S2p0JFS0j1upXK4YjCd8qlspO6hAS6VnQuDM7HfgwbY5J7eeVIGeeytAxXRJrq9bPEzj3xYx8gipPMhQXWKilT6hzdDDOxPlU+sVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762384970; c=relaxed/simple;
	bh=wj2z/mQnfovd4mP9FQv1DsT4dhdiICn6n0XvPLhdE/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D6BPsxj3OS/mgbtn2/FFArNPWN69/XS9F92P61HM5ABZ2TCHvOFWDG+gZjwBk/3f80tECnIfJwSik5SyGQkyFllRdn3GsU3iG67SSP3gOcOEBqzIdMCGL3tTgNIrZtk1dqq7xMjpEdk22itfJgnydDQFFZ3f9ntdFIH2kOmJlBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF8ue5D/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB33DC19421;
	Wed,  5 Nov 2025 23:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762384970;
	bh=wj2z/mQnfovd4mP9FQv1DsT4dhdiICn6n0XvPLhdE/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YF8ue5D/mWqg+gZAN9XDYeFgvB9yfhdbs9c2sUGmJ5GNzsJWuDULhW9z/8uI33mmv
	 bgcrWqZAFLOmJp7lEW63jQSgh25HcbzKBqY9L7Crv5w72Do9n90AmEJBfgyWMzqBwL
	 YmbXDX+Ml2jJGVQ7IRDtv9RTUcELplw1KPXIfZUOg5iTdb/F1SRO2D8PSr6Bm0EEka
	 I7Pbq4hB1HUhx/UkynBcHGY4tfrRqJLo4lMDkjVW1uCAHFE/6qI7WW+JyHxGMdZy5X
	 ADwm3AW1fRcTxWMuRrndKhLHiEKftRzqWER8lQK6q3j5GO8jvM4GLrO1vsF0ERZEbU
	 UrsHywWI3RxLQ==
Received: by venus (Postfix, from userid 1000)
	id 46B98182F6E; Thu, 06 Nov 2025 00:22:45 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
Date: Thu, 06 Nov 2025 00:22:42 +0100
Subject: [PATCH 3/4] platform: arm64: thinkpad-t14s-ec: add system PM hooks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-thinkpad-t14s-ec-improvements-v1-3-109548ae75c0@collabora.com>
References: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
In-Reply-To: <20251106-thinkpad-t14s-ec-improvements-v1-0-109548ae75c0@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3686;
 i=sebastian.reichel@collabora.com; h=from:subject:message-id;
 bh=wj2z/mQnfovd4mP9FQv1DsT4dhdiICn6n0XvPLhdE/Y=;
 b=owEBbQKS/ZANAwAKAdju1/PIO/qaAcsmYgBpC9xEa130x60Pmp4qujfQYqDArzhM7qW819UBt
 mNoGe4gJPyJAjMEAAEKAB0WIQTvZg0HRj+Lcmp5VBPY7tfzyDv6mgUCaQvcRAAKCRDY7tfzyDv6
 motfD/4v5NHB4HJ66cutp+pZYAbZjZwMn1HHtV/T/2GHcHb8jr47d8n7vmqP9eSx5wjH4JiAen2
 WzujZOfQbtbi3lN6glyNz5ns7EihxRmptvJ68z1oXPR4/5/CDmaRpqomGaPxmQLeYI69JC32sb/
 7yHtFtm5lmP6iWl3Gl+G9+4/T8o/y5mmQy/AVr8qjGQdZ7LWyRHnAuHyr/gooVgll+z/YVATInu
 4eCKNFv6WdLMSkEUx53j4IXZV5yAmmmtGLS3PBrfuVCC0h2WySxH7g/V5sIpEfRyqahirIF7eBB
 g0d8LhOsl95FM5duXxxzDMiAP7IV/27aEkF4uGKcl3e2vBbrwQ619OmtbHVmjMFxC71NJxdlChz
 ixyARudQ1O4KnmylVekw1gwPb3B716IRhIteGi8omnlJexJWKG2s0arBdtAdU1BzX7KixeR3B9z
 APEc9GGIt69qJbsE9o/RFikoi22QOqhDC5xOUgc5nVsdM+hAhmR+vN8i3/2tcOHRHEKFQcEtG1z
 GW1Hf+1gZ3eOmCKsVqwSuPqAKapbq82kFjHhFT4VZ2+wZcMzbeSjefs6KM7qFGX3tZ/NSxZKSO6
 6qXgzMsuvY/kbfIm8tbSKqA0CF9tQ1V8p1c/fKOmEPwvV0pPXdFGR5GKi0U36FZiB/6J5jVtfj1
 DdnfHr1FidFLFsw==
X-Developer-Key: i=sebastian.reichel@collabora.com; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

Improve support for system suspend. The register information has been
extracted from the ACPI DSDT code handling Windows Modern Standby. In
addition to writing to the 0xE0 register, the ACPI function also does
some changes to the thermal configuration. This part is not implemented.

After this patch the laptop's power and LID LEDs will switch into the
typical breathing animation when the system is suspended and enabled
normally again after resuming.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 drivers/platform/arm64/lenovo-thinkpad-t14s.c | 53 +++++++++++++++++++++++----
 1 file changed, 45 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/arm64/lenovo-thinkpad-t14s.c b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
index cf6a1d3b2617..066074a1314b 100644
--- a/drivers/platform/arm64/lenovo-thinkpad-t14s.c
+++ b/drivers/platform/arm64/lenovo-thinkpad-t14s.c
@@ -25,14 +25,17 @@
 #define T14S_EC_CMD_ECWR	0x03
 #define T14S_EC_CMD_EVT		0xf0
 
-#define T14S_EC_REG_LED		0x0c
-#define T14S_EC_REG_KBD_BL1	0x0d
-#define T14S_EC_REG_KBD_BL2	0xe1
-#define T14S_EC_KBD_BL1_MASK	GENMASK_U8(7, 6)
-#define T14S_EC_KBD_BL2_MASK	GENMASK_U8(3, 2)
-#define T14S_EC_REG_AUD		0x30
-#define T14S_EC_MIC_MUTE_LED	BIT(5)
-#define T14S_EC_SPK_MUTE_LED	BIT(6)
+#define T14S_EC_REG_LED				0x0c
+#define T14S_EC_REG_KBD_BL1			0x0d
+#define T14S_EC_REG_MODERN_STANDBY		0xe0
+#define T14S_EC_MODERN_STANDBY_ENTRY		BIT(1)
+#define T14S_EC_MODERN_STANDBY_EXIT		BIT(0)
+#define T14S_EC_REG_KBD_BL2			0xe1
+#define T14S_EC_KBD_BL1_MASK			GENMASK_U8(7, 6)
+#define T14S_EC_KBD_BL2_MASK			GENMASK_U8(3, 2)
+#define T14S_EC_REG_AUD				0x30
+#define T14S_EC_MIC_MUTE_LED			BIT(5)
+#define T14S_EC_SPK_MUTE_LED			BIT(6)
 
 #define T14S_EC_EVT_NONE			0x00
 #define T14S_EC_EVT_KEY_FN_4			0x13
@@ -202,6 +205,14 @@ static int t14s_ec_read_evt(struct t14s_ec *ec, u8 *val)
 	return ret;
 }
 
+static void t14s_ec_write_sequence(struct t14s_ec *ec, u8 reg, u8 val, u8 cnt)
+{
+	int i;
+
+	for (i = 0; i < cnt; i++)
+		regmap_write(ec->regmap, reg, val);
+}
+
 static int t14s_led_set_status(struct t14s_ec *ec,
 			       struct t14s_ec_led_classdev *led,
 			       const enum t14s_ec_led_status_t ledstatus)
@@ -554,6 +565,7 @@ static int t14s_ec_probe(struct i2c_client *client)
 		return -ENOMEM;
 
 	ec->dev = dev;
+	i2c_set_clientdata(client, ec);
 
 	ec->regmap = devm_regmap_init(dev, &t14s_ec_regmap_bus,
 				      ec, &t14s_ec_regmap_config);
@@ -593,6 +605,26 @@ static int t14s_ec_probe(struct i2c_client *client)
 	return 0;
 }
 
+static int t14s_ec_suspend(struct device *dev)
+{
+	struct t14s_ec *ec = dev_get_drvdata(dev);
+
+	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
+			       T14S_EC_MODERN_STANDBY_ENTRY, 3);
+
+	return 0;
+}
+
+static int t14s_ec_resume(struct device *dev)
+{
+	struct t14s_ec *ec = dev_get_drvdata(dev);
+
+	t14s_ec_write_sequence(ec, T14S_EC_REG_MODERN_STANDBY,
+			       T14S_EC_MODERN_STANDBY_EXIT, 3);
+
+	return 0;
+}
+
 static const struct of_device_id t14s_ec_of_match[] = {
 	{ .compatible = "lenovo,thinkpad-t14s-ec" },
 	{}
@@ -605,10 +637,15 @@ static const struct i2c_device_id t14s_ec_i2c_id_table[] = {
 };
 MODULE_DEVICE_TABLE(i2c, t14s_ec_i2c_id_table);
 
+static const struct dev_pm_ops t14s_ec_pm_ops = {
+	SYSTEM_SLEEP_PM_OPS(t14s_ec_suspend, t14s_ec_resume)
+};
+
 static struct i2c_driver t14s_ec_i2c_driver = {
 	.driver = {
 		.name = "thinkpad-t14s-ec",
 		.of_match_table = t14s_ec_of_match,
+		.pm = &t14s_ec_pm_ops,
 	},
 	.probe = t14s_ec_probe,
 	.id_table = t14s_ec_i2c_id_table,

-- 
2.51.0


