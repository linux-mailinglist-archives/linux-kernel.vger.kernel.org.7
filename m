Return-Path: <linux-kernel+bounces-861618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0352CBF3322
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C85F14F93C7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74144331A44;
	Mon, 20 Oct 2025 19:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="qwoFX9sV"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD152D9ED5;
	Mon, 20 Oct 2025 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988307; cv=pass; b=cXDEsK4nS11gxlzYRUUVxGT4NbNkvATBd4WMZuZUqeK6tY/blQQJ5fe3/aYwkAcskO5xYH8wyiwuRyual478cDfQ1U61CMgojU63rdOo+Fr5WDVyqQbbN3+mc0nchUlBCloh7vgn8U//aq4rcfhndTdHncFe9oTkL/QTMY8dTjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988307; c=relaxed/simple;
	bh=mbuCJmrn1zxddZb8HBPFRKrtcmwvNXXgDoKpwL10W+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iBbnIL/UKMjTQKePJXDfMlay1TmJwfxDctPG4d0YaUmIUzYUKELpHRfgjQ7ShYG10edsqbEwxrOwxqmwZFsDJPFYfcZ/+L9mL+ShWxqjl1APL3DHAf3RA6B2xEKKgbb/xxQVm7Jrk7qxomhSxtLwIYE65k3+/UEoHjaIuW9LYwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=qwoFX9sV; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1760988297; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=HFFzkEqD4v2/0MmD1YxfUfEHWiYX/lDLv/Qxi9+VOm+9JWJSF8/e5YvJmAmdVdQozCOBYJj8do1VPtHwOrEvd0C5iF30tvP+hYg69ngsMXINHDLgye8GcPGyb2WZzqIa77vvLAmRxwiBhX0Zi5z0ckH90lUqWxDsddErbjCWPtw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760988297; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Jfs9qm98itI/ML/yRbHJ6/qx7PP5MLRZCmJO7XYwdvI=; 
	b=QHBfe0JfpwtBcOIqmYnssybik39mvqN6sXsgMJPcELG3B1sUM1//ERDXiO3lFfPumF4+WPsWUjG0iuZ6U3MuQ8AZfz9M1lYA7YIf2SkWnQdUSauhQA+ENpAfIQkf01yRq+xTBJSW4rWOZ34u6g4ylO687ZIABqwadsWSxNqFDw8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760988297;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Jfs9qm98itI/ML/yRbHJ6/qx7PP5MLRZCmJO7XYwdvI=;
	b=qwoFX9sVRg7Pgbw0+GoBESPFz7L1SzKz16Nxiji9YpM1/z2MXo8rxkYjDW3uZIqB
	SoDGmTCPhZiBtXcwedZCwcBtj/EMjCbaM0X9QN4u6k8wlxy6O16bwzaEiCDYDf7Uu5B
	Ypw2QCp+78tuHz0RrbPjwscBBCi8O5rR6akSOoRQ=
Received: by mx.zohomail.com with SMTPS id 1760988296748941.0431977433706;
	Mon, 20 Oct 2025 12:24:56 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid Charge)
Date: Tue, 21 Oct 2025 03:24:34 +0800
Message-ID: <20251020192443.33088-3-i@rong.moe>
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

The GBMD/SBMC interface supports Rapid Charge mode (charge_types: Fast)
in addition to Conservation Mode (charge_types: Long_Life).

Expose these two modes while carefully maintaining their mutually
exclusive state, which aligns with the behavior of manufacturer
utilities on Windows.

Signed-off-by: Rong Zhang <i@rong.moe>
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 61 ++++++++++++++++++--
 1 file changed, 56 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 9f956f51ec8db..d2bfaa532020a 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -62,13 +62,26 @@ enum {
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
 };
 
 enum {
 	SBMC_CONSERVATION_ON  = 3,
 	SBMC_CONSERVATION_OFF = 5,
+	SBMC_RAPID_CHARGE_ON  = 7,
+	SBMC_RAPID_CHARGE_OFF = 8,
 };
 
 enum {
@@ -632,6 +645,10 @@ static ssize_t conservation_mode_show(struct device *dev,
 			return err;
 	}
 
+	/*
+	 * For backward compatibility, ignore Rapid Charge while reporting the
+	 * state of Conservation Mode.
+	 */
 	return sysfs_emit(buf, "%d\n", !!test_bit(GBMD_CONSERVATION_STATE_BIT, &result));
 }
 
@@ -651,6 +668,16 @@ static ssize_t conservation_mode_store(struct device *dev,
 
 	guard(mutex)(&priv->gbmd_sbmc_mutex);
 
+	/*
+	 * Prevent mutually exclusive modes from being set at the same time,
+	 * but do not disable Rapid Charge while disabling Conservation Mode.
+	 */
+	if (state) {
+		err = exec_sbmc(priv->adev->handle, SBMC_RAPID_CHARGE_OFF);
+		if (err)
+			return err;
+	}
+
 	err = exec_sbmc(priv->adev->handle, state ? SBMC_CONSERVATION_ON : SBMC_CONSERVATION_OFF);
 	if (err)
 		return err;
@@ -2015,14 +2042,21 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
 				    const union power_supply_propval *val)
 {
 	struct ideapad_private *priv = ext_data;
-	unsigned long op;
+	unsigned long op1, op2;
+	int err;
 
 	switch (val->intval) {
+	case POWER_SUPPLY_CHARGE_TYPE_FAST:
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
@@ -2030,7 +2064,11 @@ static int ideapad_psy_ext_set_prop(struct power_supply *psy,
 
 	guard(mutex)(&priv->gbmd_sbmc_mutex);
 
-	return exec_sbmc(priv->adev->handle, op);
+	err = exec_sbmc(priv->adev->handle, op1);
+	if (err)
+		return err;
+
+	return exec_sbmc(priv->adev->handle, op2);
 }
 
 static int ideapad_psy_ext_get_prop(struct power_supply *psy,
@@ -2042,6 +2080,7 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
 	struct ideapad_private *priv = ext_data;
 	unsigned long result;
 	int err;
+	bool is_rapid_charge, is_conservation;
 
 	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
 		err = eval_gbmd(priv->adev->handle, &result);
@@ -2049,7 +2088,18 @@ static int ideapad_psy_ext_get_prop(struct power_supply *psy,
 			return err;
 	}
 
-	if (test_bit(GBMD_CONSERVATION_STATE_BIT, &result))
+	is_rapid_charge = test_bit(GBMD_RAPID_CHARGE_STATE_BIT, &result);
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
@@ -2074,6 +2124,7 @@ static const struct power_supply_ext ideapad_battery_ext = {
 	.properties		= ideapad_power_supply_props,
 	.num_properties		= ARRAY_SIZE(ideapad_power_supply_props),
 	.charge_types		= (BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
+				   BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
 				   BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE)),
 	.get_property		= ideapad_psy_ext_get_prop,
 	.set_property		= ideapad_psy_ext_set_prop,
-- 
2.51.0


