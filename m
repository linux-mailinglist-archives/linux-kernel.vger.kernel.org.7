Return-Path: <linux-kernel+bounces-887114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B7BC37508
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:31:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00F0F3B6ABA
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAB529898B;
	Wed,  5 Nov 2025 18:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="QvaGwuQz"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC2283FD8;
	Wed,  5 Nov 2025 18:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762367343; cv=pass; b=WmUdh2zb6KYc/HCEa7QZMK5F0hToZXQxCkHweC0lL8NrhamUssy/rydJjRfw1zqVBtpJSVoVU/ML5vxn7QtGUardxa+aDksIVgeLZ6ovwrC3Xh6jIgNdpSYOAFiHoF/nx9LXgK8noUzn1W/PkeEsWKyeJvr98+ZRZ6QwJl5Vh54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762367343; c=relaxed/simple;
	bh=0M/zSniN3qMu1HqTBrGFXjVoSi/2BAL580AJHmFGo+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teeOwpbPv5unEY6rY/ZbAkjmAm7dwtsxe2OudGGWw1sDJ0sGRJ9ucT5JK5Ng2tcdIkgSkN7o7ogSZgzHTddxV5wFbi/YaYCOvg0nIfI2IieVqbqdku0Y1Vyl+cmci7MP0jAzbils6/2z46aNkZvj8LYTC2LevvyOWS9nHfkCLg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=QvaGwuQz; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1762367333; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JsadDCogTFRyfmCdsQX6ElAsNmxl3+JaALVUToeIcophndSMQSv9rAUspcw5bluClSG3Zz8uXBscbUXChF4ateY2yqpoOA7lJvh/3+2yzJxPmDa+u93vS1nAJqGwIpbQ5axbaQj0PuZbc5WNPY/Ro4VSL/jkGJnFkSaw1b18hYc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762367333; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jTIQjW75WnSAB3hTzD784oNiqNOk9Cf0wbfrxh9ebBw=; 
	b=nspvj9rvWTtPlLy9l4yU6fCgTecQrQbhTROHIUuwtpmMYOSp1cB9EFMWUgp5KD91OVOVohGnRWhre9N1Yalcmu0i/naRg8g4NZlUzpx4htBrZBt/rXH8DYIvn/qdPHIJDx0wZg5+It9CmtT5Ibn69XM9GPKXTyXJGn2xYL53JXc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762367332;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=jTIQjW75WnSAB3hTzD784oNiqNOk9Cf0wbfrxh9ebBw=;
	b=QvaGwuQzdlJz76mmOHOP1bWes5Ra5hn1iHFAY+2mv480urJBE1N3Y2OOpBqRxjWu
	j7ZswpV07i85zxT8E2lVlZijLumxxIkCXaeeK76e605B47Vn19ijfTYKfVn9CKcm5VV
	F16ECX4w59cQWOnXJMQgx0HRf+AmZRTRGUHjA00U=
Received: by mx.zohomail.com with SMTPS id 1762367330314783.5958658807923;
	Wed, 5 Nov 2025 10:28:50 -0800 (PST)
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
Subject: [PATCH v2 3/4] platform/x86: ideapad-laptop: Support multiple power_supply_ext definitions
Date: Thu,  6 Nov 2025 02:28:26 +0800
Message-ID: <20251105182832.104946-4-i@rong.moe>
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

Some recent devices supports more charge_types. To properly support
these device without breaking the existing ones, we need to define
multiple power_supply_ext for different GBMD/SBMC interface revisions.

No functional change intended.

Signed-off-by: Rong Zhang <i@rong.moe>
---
Changes in v2:
- New patch in the series.
---
 drivers/platform/x86/lenovo/ideapad-laptop.c | 35 +++++++++++++-------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c b/drivers/platform/x86/lenovo/ideapad-laptop.c
index 141de6335740..af89063108be 100644
--- a/drivers/platform/x86/lenovo/ideapad-laptop.c
+++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
@@ -168,6 +168,7 @@ struct ideapad_private {
 	struct ideapad_dytc_priv *dytc;
 	struct dentry *debug;
 	struct acpi_battery_hook battery_hook;
+	const struct power_supply_ext *battery_ext;
 	unsigned long cfg;
 	unsigned long r_touchpad_val;
 	struct {
@@ -2070,29 +2071,36 @@ static const enum power_supply_property ideapad_power_supply_props[] = {
 	POWER_SUPPLY_PROP_CHARGE_TYPES,
 };
 
-static const struct power_supply_ext ideapad_battery_ext = {
-	.name			= "ideapad_laptop",
-	.properties		= ideapad_power_supply_props,
-	.num_properties		= ARRAY_SIZE(ideapad_power_supply_props),
-	.charge_types		= (BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
-				   BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE)),
-	.get_property		= ideapad_psy_ext_get_prop,
-	.set_property		= ideapad_psy_ext_set_prop,
-	.property_is_writeable	= ideapad_psy_prop_is_writeable,
-};
+#define DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(_name, _charge_types)			\
+	static const struct power_supply_ext _name = {					\
+		.name			= "ideapad_laptop",				\
+		.properties		= ideapad_power_supply_props,			\
+		.num_properties		= ARRAY_SIZE(ideapad_power_supply_props),	\
+		.charge_types		= _charge_types,				\
+		.get_property		= ideapad_psy_ext_get_prop,			\
+		.set_property		= ideapad_psy_ext_set_prop,			\
+		.property_is_writeable	= ideapad_psy_prop_is_writeable,		\
+	}
+
+DEFINE_IDEAPAD_POWER_SUPPLY_EXTENSION(ideapad_battery_ext_v1,
+	(BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
+	 BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE))
+);
 
 static int ideapad_battery_add(struct power_supply *battery, struct acpi_battery_hook *hook)
 {
 	struct ideapad_private *priv = container_of(hook, struct ideapad_private, battery_hook);
 
-	return power_supply_register_extension(battery, &ideapad_battery_ext,
+	return power_supply_register_extension(battery, priv->battery_ext,
 					       &priv->platform_device->dev, priv);
 }
 
 static int ideapad_battery_remove(struct power_supply *battery,
 				  struct acpi_battery_hook *hook)
 {
-	power_supply_unregister_extension(battery, &ideapad_battery_ext);
+	struct ideapad_private *priv = container_of(hook, struct ideapad_private, battery_hook);
+
+	power_supply_unregister_extension(battery, priv->battery_ext);
 
 	return 0;
 }
@@ -2118,6 +2126,9 @@ static int ideapad_check_features(struct ideapad_private *priv)
 
 	if (acpi_has_method(handle, "GBMD") && acpi_has_method(handle, "SBMC")) {
 		priv->features.conservation_mode = true;
+
+		priv->battery_ext = &ideapad_battery_ext_v1;
+
 		priv->battery_hook.add_battery = ideapad_battery_add;
 		priv->battery_hook.remove_battery = ideapad_battery_remove;
 		priv->battery_hook.name = "Ideapad Battery Extension";
-- 
2.51.0


