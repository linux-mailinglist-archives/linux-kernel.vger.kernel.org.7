Return-Path: <linux-kernel+bounces-854082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id EEBB8BDD7F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 10:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9186F350F09
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B949F319613;
	Wed, 15 Oct 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="U/SGEldZ"
Received: from relay11.grserver.gr (relay11.grserver.gr [78.46.171.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 444CA3191AC;
	Wed, 15 Oct 2025 08:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.171.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760518006; cv=none; b=kwJGzubE96RDNGxvbriuOTWweRrrJJKx+F0KiDaqJwKWhEPFFVguOcYfhVbokOtNCtzsZ+dS7rimyK86XRvbsF06raUrq0o7mSROqjmCJP7gyHhzIVatwmtOnUDRybGXRkTpu2tjnjaStEltJZ3ohwI9nPQo1gBoP0PuUpxhkGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760518006; c=relaxed/simple;
	bh=NZcpSWmslCYPg9Fwnn8NwnAcZphlhrTQ1AyiCMWCH1M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itBLCmRuEd+xcO3e/v3gDaN5sRVU8tZtSvWMNfXhg4PjoZtsltxCtWSj3PVuxrMvZZCL58SCSPtQifyygmuXjyyXARy+oM6Jzp0mZjbCB3H7DRIrCZztYVE+P444ueUc2nZsU0kTNWyd8y4C+wWDNCBjwYwp9+Qo3fBY4bd95rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=temperror (0-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=U/SGEldZ; arc=none smtp.client-ip=78.46.171.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from relay11 (localhost.localdomain [127.0.0.1])
	by relay11.grserver.gr (Proxmox) with ESMTP id 923AFC5C2F;
	Wed, 15 Oct 2025 11:46:42 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay11.grserver.gr (Proxmox) with ESMTPS id 273D2C5A7D;
	Wed, 15 Oct 2025 11:46:42 +0300 (EEST)
Received: from antheas-z13 (x5996a8de.customers.hiper-net.dk [89.150.168.222])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id 29AB6200A8C;
	Wed, 15 Oct 2025 11:46:40 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1760518001;
	bh=wFV3tYVcLSkZKq8Ul3B2tHS9V3H6ix/FNBiIRXbFmiU=; h=From:To:Subject;
	b=U/SGEldZy+Tz6jlGH1OWuAQV8D3xv8zjNdgPu6tzrX+uf5XSp78UU68oVR/fLWJZ6
	 gzb4JWeiS+/I8NNcXDaa+WwS0Wn5grioVKSt/qMOxlgoLpOQ4QQDXf7E21pWUiNVAf
	 p7xEUwOejylxj8Cfqv557Otsqja5U5shaciiA2FlWggYn11e4uFdv3eKkFVSCtKED2
	 JhB3+1PmmxoRkmEWdwmnmtPnzI/V2laVe7mXT3GLJ4y9rC7ooLbE+Vm4meiBvzpwZb
	 IYnZcsZYFOdzFUC6lMSWSkyCyd8AY62e5wuor0O38VPl4PF2wPMI8/QtkaIdJ7hV+U
	 Vwybwv3GHU0kw==
Authentication-Results: linux3247.grserver.gr;
	spf=pass (sender IP is 89.150.168.222) smtp.mailfrom=lkml@antheas.dev smtp.helo=antheas-z13
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Derek John Clark <derekjohn.clark@gmail.com>,
	=?UTF-8?q?Joaqu=C3=ADn=20Ignacio=20Aramend=C3=ADa?= <samsagax@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: [PATCH v2 6/6] platform/x86: ayaneo-ec: Add suspend hook
Date: Wed, 15 Oct 2025 10:44:14 +0200
Message-ID: <20251015084414.1391595-7-lkml@antheas.dev>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015084414.1391595-1-lkml@antheas.dev>
References: <20251015084414.1391595-1-lkml@antheas.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <176051800182.921133.2733718083934450324@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

The Ayaneo EC resets after hibernation, losing the charge control state.
Add a small PM hook to restore this state on hibernation resume.

The fan speed is also lost during hibernation, but since hibernation
failures are common with this class of devices, setting a low fan speed
when the userspace program controlling the fan will potentially not
take over could cause the device to overheat, so it is not restored.

Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
---
 drivers/platform/x86/ayaneo-ec.c | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/platform/x86/ayaneo-ec.c b/drivers/platform/x86/ayaneo-ec.c
index 73e9dd39c703..8529f6f8dc69 100644
--- a/drivers/platform/x86/ayaneo-ec.c
+++ b/drivers/platform/x86/ayaneo-ec.c
@@ -37,6 +37,8 @@
 #define AYANEO_MODULE_LEFT	BIT(0)
 #define AYANEO_MODULE_RIGHT	BIT(1)
 
+#define AYANEO_CACHE_LEN	1
+
 struct ayaneo_ec_quirk {
 	bool has_fan_control;
 	bool has_charge_control;
@@ -47,6 +49,8 @@ struct ayaneo_ec_platform_data {
 	struct platform_device *pdev;
 	struct ayaneo_ec_quirk *quirks;
 	struct acpi_battery_hook battery_hook;
+
+	u8 cache[AYANEO_CACHE_LEN];
 };
 
 static const struct ayaneo_ec_quirk quirk_fan = {
@@ -464,10 +468,48 @@ static int ayaneo_ec_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static int ayaneo_freeze(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
+	int ret, i = 0;
+
+	if (data->quirks->has_charge_control) {
+		ret = ec_read(AYANEO_CHARGE_REG, &data->cache[i]);
+		if (ret)
+			return ret;
+		i++;
+	}
+
+	return 0;
+}
+
+static int ayaneo_thaw(struct device *dev)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct ayaneo_ec_platform_data *data = platform_get_drvdata(pdev);
+	int ret, i = 0;
+
+	if (data->quirks->has_charge_control) {
+		ret = ec_write(AYANEO_CHARGE_REG, data->cache[i]);
+		if (ret)
+			return ret;
+		i++;
+	}
+
+	return 0;
+}
+
+static const struct dev_pm_ops ayaneo_pm_ops = {
+	.freeze = ayaneo_freeze,
+	.thaw = ayaneo_thaw,
+};
+
 static struct platform_driver ayaneo_platform_driver = {
 	.driver = {
 		.name = "ayaneo-ec",
 		.dev_groups = ayaneo_ec_groups,
+		.pm = &ayaneo_pm_ops,
 	},
 	.probe = ayaneo_ec_probe,
 };
-- 
2.51.0



