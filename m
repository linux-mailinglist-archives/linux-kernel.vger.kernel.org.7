Return-Path: <linux-kernel+bounces-887115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAFAC374E4
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA934FAA0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED352BD033;
	Wed,  5 Nov 2025 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="rP8EPIxh"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6041729B20A;
	Wed,  5 Nov 2025 18:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367347; cv=pass; b=IJ5WYkegSz5Z+uUQu8Dd5FfCnWZ6MGDo1XNE9sjk2i6x1sU2hsJFDt7RDIE5Q3gxR8ILSML1vgkNnPsI+EF7bMid9q+t/vrUB77Xvufq1m/f65n2n9GPMzSvve0ris/c6ITEm+flY5L4aVLdf/k+sH+E9cquZSFaA8jJXN25lqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367347; c=relaxed/simple;
	bh=SP9DJtu7N8EqjJ5q4+cKj9Sp14WcXw2riWPPvAqiZNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cgsxot8C+VuMDlNxZzEDQE/NqcRaVR7bMtkE39FneWV9htOUVLPJtuLUDprvj98VS2NvdHhfqK059XUmYoAAXXyTtZvsubHz7EOncsOGtlFUIo5aXHyiyxJYt3pw+5M+nuEQE4O9LJPBldPPRF6+F3lfuXO7kCp0WAGYAQOWRBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=rP8EPIxh; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1762367335; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=BILcZYVYuugZKFGOIyJ5cWA8gYjtYiCRuEp0rU/ZpK/CllzJI6VhmDOKXo2pETMamkGIyjZV+0uV004cMkLuz1L9uJrJpzPjP34ghyeeRQ1gxxpfK61WrjEIjNpkJus6n22ogfROuiQwYhU07XDtXt5BZzSONmxo+d9rDotyHV8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762367335; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=heRqixjpdK13FLzt14CVLv05ZUNb4t7GiTIZBNsJ1mg=; 
	b=M4uXLJaKLMciTAbXgHwzCH9gUqqQAGgvaxyZEgfbNTxY5Wcm3lrgsM/Hje6WM2p1Q8k6QdWcC3Z8iFGzrinlOceNGD7dgBpZXvWRWk39IMgCw2KmVKnVNCKius+4W72aqDAKL5z3E/gqvOGOj2vTPYS5gsOK2pMfuqy/M9gM6d0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762367334;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=heRqixjpdK13FLzt14CVLv05ZUNb4t7GiTIZBNsJ1mg=;
	b=rP8EPIxh1zcXwauqenyraeTcjbq+8AMxEJEsVuAPIpfJDAibgAZPj8vgsRGL5U/x
	eVcPOjRR/vS1yQffEGvn/xTXoi8xIHMEMKSEyiou0uRI6ovX9wssg3ChUFXmeQsqUYz
	4qMVqATAosyj7bRWuU/Dc/om1ZJvezCt7Zj7guq0=
Received: by mx.zohomail.com with SMTPS id 1762367332867537.8609062000411;
	Wed, 5 Nov 2025 10:28:52 -0800 (PST)
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
Subject: [PATCH v2 4/4] platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)
Date: Thu,  6 Nov 2025 02:28:27 +0800
Message-ID: <20251105182832.104946-5-i@rong.moe>
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

The GBMD/SBMC interface on recent devices supports Rapid Charge mode
(charge_types: Fast) in addition to Conservation Mode (charge_types:
Long_Life).

Query the GBMD interface on probe to determine if a device supports
Rapid Charge. If so, expose these two modes while carefully maintaining
their mutually exclusive state, which aligns with the behavior of
manufacturer utilities on Windows.

Signed-off-by: Rong Zhang <i@rong.moe>
Acked-by: Ike Panhc <ikepanhc@gmail.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2:
- Only expose Rapid Charge on devices that support it (thanks Jelle van
  der Waa)
- Reword commit message
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 105 ++++++++++++++++---
 1 file changed, 89 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index af89063108be..5171a077f62c 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -63,13 +63,27 @@ enum {
 	CFG_OSD_CAM_BIT      = 31,
 };
 
+/*
+ * There are two charge modes supported by the GBMD/SBMC interface:
+ * - "Rapid Charge": increase power to speed up charging
+ * - "Conservation Mode": stop charging at 60-80% (depends on model)
+ *
+ * The interface doesn't prohibit enabling both modes at the same time.
+ * However, doing so is essentially meaningless, and the manufacturer utilities
+ * on Windows always make them mutually exclusive.
+ */
+
 enum {
+	GBMD_RAPID_CHARGE_STATE_BIT = 2,
 	GBMD_CONSERVATION_STATE_BIT = 5,
+	GBMD_RAPID_CHARGE_SUPPORTED_BIT = 17,
 };
 
 enum {
 	SBMC_CONSERVATION_ON  = 3,
 	SBMC_CONSERVATION_OFF = 5,
+	SBMC_RAPID_CHARGE_ON  = 7,
+	SBMC_RAPID_CHARGE_OFF = 8,
 };
 
 enum {
@@ -172,6 +186,7 @@ struct ideapad_private {
 	unsigned long cfg;
 	unsigned long r_touchpad_val;
 	struct {
+		bool rapid_charge         : 1;
 		bool conservation_mode    : 1;
 		bool dytc                 : 1;
 		bool fan_mode             : 1;
@@ -634,6 +649,10 @@ static ssize_t conservation_mode_show(struct device *dev,
 			return err;
 	}
 
+	/*
+	 * For backward compatibility, ignore Rapid Charge while reporting the
+	 * state of Conservation Mode.
+	 */
 	return sysfs_emit(buf, "%d\n", !!test_bit(GBMD_CONSERVATION_STATE_BIT, &result));
 }
 
@@ -653,6 +672,16 @@ static ssize_t conservation_mode_store(struct device *dev,
 
 	guard(mutex)(&priv->gbmd_sbmc_mutex);
 
+	/*
+	 * Prevent mutually exclusive modes from being set at the same time,
+	 * but do not disable Rapid Charge while disabling Conservation Mode.
+	 */
+	if (priv->features.rapid_charge && state) {
+		err = exec_sbmc(priv->adev->handle, SBMC_RAPID_CHARGE_OFF);
+		if (err)
+			return err;
+	}
+
 	err = exec_sbmc(priv->adev->handle, state ? SBMC_CONSERVATION_ON : SBMC_CONSERVATION_OFF);
 	if (err)
 		return err;
@@ -2017,14 +2046,24 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
 				    const union power_supply_propval *val)
 {
 	struct ideapad_private *priv = ext_data;
-	unsigned long op;
+	unsigned long op1, op2;
+	int err;
 
 	switch (val->intval) {
+	case POWER_SUPPLY_CHARGE_TYPE_FAST:
+		if (WARN_ON(!priv->features.rapid_charge))
+			return -EINVAL;
+
+		op1 = SBMC_CONSERVATION_OFF;
+		op2 = SBMC_RAPID_CHARGE_ON;
+		break;
 	case POWER_SUPPLY_CHARGE_TYPE_LONGLIFE:
-		op = SBMC_CONSERVATION_ON;
+		op1 = SBMC_RAPID_CHARGE_OFF;
+		op2 = SBMC_CONSERVATION_ON;
 		break;
 	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
-		op = SBMC_CONSERVATION_OFF;
+		op1 = SBMC_RAPID_CHARGE_OFF;
+		op2 = SBMC_CONSERVATION_OFF;
 		break;
 	default:
 		return -EINVAL;
@@ -2032,7 +2071,14 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
 
 	guard(mutex)(&priv->gbmd_sbmc_mutex);
 
-	return exec_sbmc(priv->adev->handle, op);
+	/* If !rapid_charge, op1 must be SBMC_RAPID_CHARGE_OFF. Skip it. */
+	if (priv->features.rapid_charge) {
+		err = exec_sbmc(priv->adev->handle, op1);
+		if (err)
+			return err;
+	}
+
+	return exec_sbmc(priv->adev->handle, op2);
 }
 
 static int ideapad_psy_ext_get_prop(struct power_supply *psy,
@@ -2042,6 +2088,7 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
 				    union power_supply_propval *val)
 {
 	struct ideapad_private *priv = ext_data;
+	bool is_rapid_charge, is_conservation;
 	unsigned long result;
 	int err;
 
@@ -2051,7 +2098,19 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
 			return err;
 	}
 
-	if (test_bit(GBMD_CONSERVATION_STATE_BIT, &result))
+	is_rapid_charge = (priv->features.rapid_charge &&
+			   test_bit(GBMD_RAPID_CHARGE_STATE_BIT, &result));
+	is_conservation = test_bit(GBMD_CONSERVATION_STATE_BIT, &result);
+
+	if (unlikely(is_rapid_charge && is_conservation)) {
+		dev_err(&priv->platform_device->dev,
+			"unexpected charge_types: both [Fast] and [Long_Life] are enabled\n");
+		return -EINVAL;
+	}
+
+	if (is_rapid_charge)
+		val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
+	else if (is_conservation)
 		val->intval = POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
 	else
 		val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
@@ -2087,6 +2146,12 @@ DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v1,
 	 BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
 );
 
+DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v2,
+	(BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
+	 BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
+	 BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
+);
+
 static int ideapad_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
 	struct ideapad_private *priv = container_of(hook, struct ideapad_private, battery_hook);
@@ -2125,17 +2190,25 @@ static int ideapad_check_features(struct ideapad_private *priv)
 		priv->features.fan_mode = true;
 
 	if (acpi_has_method(handle, "GBMD") && acpi_has_method(handle, "SBMC")) {
-		priv->features.conservation_mode = true;
-
-		priv->battery_ext = &ideapad_battery_ext_v1;
-
-		priv->battery_hook.add_battery = ideapad_battery_add;
-		priv->battery_hook.remove_battery = ideapad_battery_remove;
-		priv->battery_hook.name = "Ideapad Battery Extension";
-
-		err = devm_battery_hook_register(&priv->platform_device->dev, &priv->battery_hook);
-		if (err)
-			return err;
+		/* Not acquiring gbmd_sbmc_mutex as race condition is impossible on init */
+		if (!eval_gbmd(handle, &val)) {
+			priv->features.conservation_mode = true;
+			priv->features.rapid_charge = test_bit(GBMD_RAPID_CHARGE_SUPPORTED_BIT,
+							       &val);
+
+			priv->battery_ext = priv->features.rapid_charge
+					    ? &ideapad_battery_ext_v2
+					    : &ideapad_battery_ext_v1;
+
+			priv->battery_hook.add_battery = ideapad_battery_add;
+			priv->battery_hook.remove_battery = ideapad_battery_remove;
+			priv->battery_hook.name = "Ideapad Battery Extension";
+
+			err = devm_battery_hook_register(&priv->platform_device->dev,
+							 &priv->battery_hook);
+			if (err)
+				return err;
+		}
 	}
 
 	if (acpi_has_method(handle, "DYTC"))
-- 
2.51.0


