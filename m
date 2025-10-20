Return-Path: <linux-kernel+bounces-861617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 719CBBF331F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9F9C34EFF6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D833112BD;
	Mon, 20 Oct 2025 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="EssbVOlL"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B6421ABD7;
	Mon, 20 Oct 2025 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988306; cv=pass; b=VVS619WD3LRz2LddqDbEeEg4mmUzkbTKD+CH8rwKp/wSy2gxScE/t2Dkg0xuc81t7nGBzOqbKQe1Wgy74+3qNr4M05GeOV74cw2VKXaeeexUiG+VjD//38NCpV6u0mSACZ44mI4D5e3jw+uDXeO3/g3mrjvYPDmJ2fjWMV62M44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988306; c=relaxed/simple;
	bh=zQ/vNVFI31WoIhAZSn7izuOFvqff4NwI1zEJlvVF/4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnNi6ynmA+hxQ+zyygjy6Hc1O+0UjHgSyaFnz38af0io8havnnr4L9UN4gj0DdQyFHgtgywB3MIqjAZZnhpmf/phRQMCOuWhVYTnbkk75/gLJttXl3OZN6nQPvQz8Znc321Tpesr6Y7F95+EZwWL9EnrUNXOpvMnwfbarXVUz3I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=EssbVOlL; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760988296; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=e3dM/c86ZnXlpVVvrYa9R8vD0UPkbE7vS+k1JtlKidmD7rwxmuIC9FCl6pYzDBf55WVEuASxWA9wRvHJOnfaU6fo9zs2P9C1cCne7e32f8duRVD7bADV1blV7kJWehByDNZU9a9lmmYtWCOmR5xjmAH7kh5l7EdqvM06ZF9+g8Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760988296; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8edqjT6dBZ2S1RQE3PoymEqkIw4maJ1LUrinmkP1Dcs=; 
	b=VaVgorAo0wM17crk0Fmn5pTJgBb4m/XY2yb+JWfM59ivZUhCrgkdlUyZpIjSZ6XbdTcdt9tYtCWTtfB+/Bm7o5QedQNt6eUlBh9H4XcSU3x2g4KD7uQWV7e10xUBUKLB+LgyN/64M6pzRjjjmENwwyYD3fTYxlKBTUF2b/TYBCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760988296;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=8edqjT6dBZ2S1RQE3PoymEqkIw4maJ1LUrinmkP1Dcs=;
	b=EssbVOlLYXC9Eb8evZY9RbACqLGmiEHPLFiqZWons0Bcq7X81TVhNGU2ZTz7TMDs
	T3GJZAmSdPCzsbnCIRKv+rSSlZk/jaG6Axej/d26i21bc3JPNHcX1oBqiSeEa7iPGW/
	HDQ7R2odtY420duqitUVVyIoilUK7hDQ/KSAwWMc=
Received: by mx.zohomail.com with SMTPS id 176098829406155.51830365458795;
	Mon, 20 Oct 2025 12:24:54 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: ideapad-laptop: Protect GBMD/SBMC calls with mutex
Date: Tue, 21 Oct 2025 03:24:33 +0800
Message-ID: <20251020192443.33088-2-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020192443.33088-1-i@rong.moe>
References: <20251020192443.33088-1-i@rong.moe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The upcoming changes for Rapid Charge support require two consecutive
SBMC calls to switch charge_types. Hence, a mutex is required.

The reason for not using rw_semaphore for this purpose is that allowing
simultaneous GBMD calls is not really useful and doesn't deserve the
overhead.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 91 ++++++++++++--------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index fcebfbaf04605..9f956f51ec8db 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -158,6 +158,7 @@ struct ideapad_rfk_priv {
 struct ideapad_private {
 	struct acpi_device *adev;
 	struct mutex vpc_mutex; /* protects the VPC calls */
+	struct mutex gbmd_sbmc_mutex; /* protects GBMD/SBMC calls */
 	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
 	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
 	struct platform_device *platform_device;
@@ -455,37 +456,40 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 	struct ideapad_private *priv = s->private;
 	unsigned long value;
 
-	guard(mutex)(&priv->vpc_mutex);
-
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
-		seq_printf(s, "Backlight max:  %lu\n", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
-		seq_printf(s, "Backlight now:  %lu\n", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
-		seq_printf(s, "BL power value: %s (%lu)\n", value ? "on" : "off", value);
-
-	seq_puts(s, "=====================\n");
-
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
-		seq_printf(s, "Radio status: %s (%lu)\n", value ? "on" : "off", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
-		seq_printf(s, "Wifi status:  %s (%lu)\n", value ? "on" : "off", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
-		seq_printf(s, "BT status:    %s (%lu)\n", value ? "on" : "off", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
-		seq_printf(s, "3G status:    %s (%lu)\n", value ? "on" : "off", value);
+	scoped_guard(mutex, &priv->vpc_mutex) {
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
+			seq_printf(s, "Backlight max:  %lu\n", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
+			seq_printf(s, "Backlight now:  %lu\n", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
+			seq_printf(s, "BL power value: %s (%lu)\n", value ? "on" : "off", value);
+
+		seq_puts(s, "=====================\n");
+
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
+			seq_printf(s, "Radio status: %s (%lu)\n", value ? "on" : "off", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
+			seq_printf(s, "Wifi status:  %s (%lu)\n", value ? "on" : "off", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
+			seq_printf(s, "BT status:    %s (%lu)\n", value ? "on" : "off", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
+			seq_printf(s, "3G status:    %s (%lu)\n", value ? "on" : "off", value);
+
+		seq_puts(s, "=====================\n");
+
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
+			seq_printf(s, "Touchpad status: %s (%lu)\n", value ? "on" : "off", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
+			seq_printf(s, "Camera status:   %s (%lu)\n", value ? "on" : "off", value);
+	}
 
 	seq_puts(s, "=====================\n");
 
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
-		seq_printf(s, "Touchpad status: %s (%lu)\n", value ? "on" : "off", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
-		seq_printf(s, "Camera status:   %s (%lu)\n", value ? "on" : "off", value);
-
-	seq_puts(s, "=====================\n");
+	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
+		if (!eval_gbmd(priv->adev->handle, &value))
+			seq_printf(s, "GBMD: %#010lx\n", value);
+	}
 
-	if (!eval_gbmd(priv->adev->handle, &value))
-		seq_printf(s, "GBMD: %#010lx\n", value);
 	if (!eval_hals(priv->adev->handle, &value))
 		seq_printf(s, "HALS: %#010lx\n", value);
 
@@ -622,9 +626,11 @@ static ssize_t conservation_mode_show(struct device *dev,
 
 	show_conservation_mode_deprecation_warning(dev);
 
-	err = eval_gbmd(priv->adev->handle, &result);
-	if (err)
-		return err;
+	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
+		err = eval_gbmd(priv->adev->handle, &result);
+		if (err)
+			return err;
+	}
 
 	return sysfs_emit(buf, "%d\n", !!test_bit(GBMD_CONSERVATION_STATE_BIT, &result));
 }
@@ -643,6 +649,8 @@ static ssize_t conservation_mode_store(struct device *dev,
 	if (err)
 		return err;
 
+	guard(mutex)(&priv->gbmd_sbmc_mutex);
+
 	err = exec_sbmc(priv->adev->handle, state ? SBMC_CONSERVATION_ON : SBMC_CONSERVATION_OFF);
 	if (err)
 		return err;
@@ -2007,15 +2015,22 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
 				    const union power_supply_propval *val)
 {
 	struct ideapad_private *priv = ext_data;
+	unsigned long op;
 
 	switch (val->intval) {
 	case POWER_SUPPLY_CHARGE_TYPE_LONGLIFE:
-		return exec_sbmc(priv->adev->handle, SBMC_CONSERVATION_ON);
+		op = SBMC_CONSERVATION_ON;
+		break;
 	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
-		return exec_sbmc(priv->adev->handle, SBMC_CONSERVATION_OFF);
+		op = SBMC_CONSERVATION_OFF;
+		break;
 	default:
 		return -EINVAL;
 	}
+
+	guard(mutex)(&priv->gbmd_sbmc_mutex);
+
+	return exec_sbmc(priv->adev->handle, op);
 }
 
 static int ideapad_psy_ext_get_prop(struct power_supply *psy,
@@ -2028,9 +2043,11 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
 	unsigned long result;
 	int err;
 
-	err = eval_gbmd(priv->adev->handle, &result);
-	if (err)
-		return err;
+	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
+		err = eval_gbmd(priv->adev->handle, &result);
+		if (err)
+			return err;
+	}
 
 	if (test_bit(GBMD_CONSERVATION_STATE_BIT, &result))
 		val->intval = POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
@@ -2292,6 +2309,10 @@ static int ideapad_acpi_add(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	err = devm_mutex_init(&pdev->dev, &priv->gbmd_sbmc_mutex);
+	if (err)
+		return err;
+
 	err = ideapad_check_features(priv);
 	if (err)
 		return err;
-- 
2.51.0


