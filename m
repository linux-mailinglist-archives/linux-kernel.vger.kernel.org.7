Return-Path: <linux-kernel+bounces-887112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD04C374F9
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DD303B592A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED65283FEA;
	Wed,  5 Nov 2025 18:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="5Cdjip2e"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D727F015;
	Wed,  5 Nov 2025 18:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367341; cv=pass; b=Nmc4Fl1ULCcj3zwsnpzQNZAZFVjZbVlLhRSpXnwVpts7bMhrW1lZ7JgET+A2reellxQYFkw48c5qdMy5FlzxukOOMhocRdbcCVMx9rrXQChq7+PI9dRNYlca+BBP8jzTPfwoS5VRjabF/xNT63wgueRQYcO/M1CAe6TYNwqjs6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367341; c=relaxed/simple;
	bh=cMSGx8V60nHc34s+S/0joZ3mCb4GZB5oKc+z5R+RlWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1Youk0iGHPZVqzHKOE1ApYV6pXU6By+7Z820XYO3OavC3YpyMSkt6g7HtdvhcHHd7c96Rsm5XM+vB7KxYAoZDiCCP0NBr0CJQvdc0P8jJJOWWsh8SftnNPqcCvxjCp30W54WzEATCIw1huXQhYkuKgSbkiYnVtwuQupBuA4VhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=5Cdjip2e; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1762367329; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eXS3l8nmW2GhEuYdyhWaSbFNfxPoDQLuhDeYTmWznyoXGU4/gjwmSS/BF7x1Q6jWWaBrct8mxnaRz+1Fr2pTM9B2voNyu1wwoxUwKddA9heCTDyW/t1kyrhS1kvAATJASOn4JsD0G33ax4g8/hHWtb+fRbPU0yghEkK8wjtkp/Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762367329; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CYHMVlgKRsRYa2COI4q7NL+gqe5epB4h6Z/tKVtbD9w=; 
	b=bV68SoJT5UG/q/BkMD5/bH9CSY8GtrW6Emg8iOe5iVggKnV69vysX50XnYeveubVJx4Ri46KgO3xS/4XsIhKnfhviM3PO0tXgkQKgdKND0tX6TXlhNtCdeOQ3kIHxQtbhS/0U6tIataXsyuynOUQnyaIoSMuVgeZYkdtGrPuzok=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762367328;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=CYHMVlgKRsRYa2COI4q7NL+gqe5epB4h6Z/tKVtbD9w=;
	b=5Cdjip2ezyFufOBH9HSYH5yKbQD0vc8UGhPG1dO/hRMAvR+LTUDzW4iVS2A5YEjf
	Z7K7MmwT0okJg8BMnjmKaxd5konGGSeabWDDnhKcZx7aEAAd016EcWFB9EuZgHbGm6h
	c8KD2BgStgi2pa1eP4gYLcsNvI8hv7n7qXki6bbI=
Received: by mx.zohomail.com with SMTPS id 1762367327796540.5222222982911;
	Wed, 5 Nov 2025 10:28:47 -0800 (PST)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	Jelle van der Waa <jelle@vdwaa.nl>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: ideapad-laptop: Protect GBMD/SBMC calls with mutex
Date: Thu,  6 Nov 2025 02:28:25 +0800
Message-ID: <20251105182832.104946-3-i@rong.moe>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105182832.104946-1-i@rong.moe>
References: <20251105182832.104946-1-i@rong.moe>
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

No functional change intended.

Signed-off-by: Rong Zhang <i@rong.moe>
Acked-by: Ike Panhc <ikepanhc@gmail.com>
---
Changes in v2:
- Rebase on top of the newly added [PATCH v2 1/4]
- Reword commit message
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 91 ++++++++++++--------
 1 file changed, 56 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index b61ed6993990..141de6335740 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -159,6 +159,7 @@ struct ideapad_rfk_priv {
 struct ideapad_private {
 	struct acpi_device *adev;
 	struct mutex vpc_mutex; /* protects the VPC calls */
+	struct mutex gbmd_sbmc_mutex; /* protects GBMD/SBMC calls */
 	struct rfkill *rfk[IDEAPAD_RFKILL_DEV_NUM];
 	struct ideapad_rfk_priv rfk_priv[IDEAPAD_RFKILL_DEV_NUM];
 	struct platform_device *platform_device;
@@ -456,37 +457,40 @@ static int debugfs_status_show(struct seq_file *s, void *data)
 	struct ideapad_private *priv = s->private;
 	unsigned long value;
 
-	guard(mutex)(&priv->vpc_mutex);
-
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
-		seq_printf(s, "Backlight max:  %lu\n", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
-		seq_printf(s, "Backlight now:  %lu\n", value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
-		seq_printf(s, "BL power value: %s (%lu)\n", str_on_off(value), value);
-
-	seq_puts(s, "=====================\n");
-
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
-		seq_printf(s, "Radio status: %s (%lu)\n", str_on_off(value), value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
-		seq_printf(s, "Wifi status:  %s (%lu)\n", str_on_off(value), value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
-		seq_printf(s, "BT status:    %s (%lu)\n", str_on_off(value), value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
-		seq_printf(s, "3G status:    %s (%lu)\n", str_on_off(value), value);
+	scoped_guard(mutex, &priv->vpc_mutex) {
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_MAX, &value))
+			seq_printf(s, "Backlight max:  %lu\n", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL, &value))
+			seq_printf(s, "Backlight now:  %lu\n", value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BL_POWER, &value))
+			seq_printf(s, "BL power value: %s (%lu)\n", str_on_off(value), value);
+
+		seq_puts(s, "=====================\n");
+
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_RF, &value))
+			seq_printf(s, "Radio status: %s (%lu)\n", str_on_off(value), value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_WIFI, &value))
+			seq_printf(s, "Wifi status:  %s (%lu)\n", str_on_off(value), value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_BT, &value))
+			seq_printf(s, "BT status:    %s (%lu)\n", str_on_off(value), value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_3G, &value))
+			seq_printf(s, "3G status:    %s (%lu)\n", str_on_off(value), value);
+
+		seq_puts(s, "=====================\n");
+
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
+			seq_printf(s, "Touchpad status: %s (%lu)\n", str_on_off(value), value);
+		if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
+			seq_printf(s, "Camera status:   %s (%lu)\n", str_on_off(value), value);
+	}
 
 	seq_puts(s, "=====================\n");
 
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_TOUCHPAD, &value))
-		seq_printf(s, "Touchpad status: %s (%lu)\n", str_on_off(value), value);
-	if (!read_ec_data(priv->adev->handle, VPCCMD_R_CAMERA, &value))
-		seq_printf(s, "Camera status:   %s (%lu)\n", str_on_off(value), value);
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
 
@@ -623,9 +627,11 @@ static ssize_t conservation_mode_show(struct device *dev,
 
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
@@ -644,6 +650,8 @@ static ssize_t conservation_mode_store(struct device *dev,
 	if (err)
 		return err;
 
+	guard(mutex)(&priv->gbmd_sbmc_mutex);
+
 	err = exec_sbmc(priv->adev->handle, state ? SBMC_CONSERVATION_ON : SBMC_CONSERVATION_OFF);
 	if (err)
 		return err;
@@ -2008,15 +2016,22 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
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
@@ -2029,9 +2044,11 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
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
@@ -2293,6 +2310,10 @@ static int ideapad_acpi_add(struct platform_device *pdev)
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


