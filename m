Return-Path: <linux-kernel+bounces-731869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE86DB05ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 15:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04EE13B5521
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7292D63EB;
	Tue, 15 Jul 2025 13:04:40 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1600277CB5
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752584679; cv=none; b=Y0IiHOqGnuAAlON24jI1tApCNwlRYo6W78C5MoK7Io5kSiZ4NV2AYkyDdpA11fXw2XfNwaC73sbJToSsQpaSZJoBH0952dzLa32rBVEtGRu7D8xMduR/WKpjWYuW0VYGFg0qASsceaaEVPbzkQgsdN3Er3C+YQ8ktR+zl04HRfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752584679; c=relaxed/simple;
	bh=UooHWdbjwok23G1w7lyu5z/xDu2uKm62K3FAoZ+IEmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RB73sDQHvuEd2OKEoeDbZKJtb4gv6jp749omE9U63r82X3w/Ou7fvsliWc/07O1NQ2rdvS7kyDyzsmIBvFUPa5Dxfk1tOZp2pEg/5jj3QkxiuOkHoKTBvNuy5OfmlJWCRFZqyWSu4RtCZjsSYyjAz9OC2WHXs8I6TwphoIcrGLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <jre@pengutronix.de>)
	id 1ubfKZ-0001UL-5F; Tue, 15 Jul 2025 15:04:23 +0200
From: Jonas Rebmann <jre@pengutronix.de>
Date: Tue, 15 Jul 2025 15:02:41 +0200
Subject: [PATCH] hwmon: ina238: Report energy in microjoules
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250715-hwmon-ina238-microjoules-v1-1-9df678568a41@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAHBRdmgC/x3MTQqAIBBA4avErBswQ4quEi3EmWqiNJR+ILp70
 vJbvPdA4iicoCseiHxKkuAzqrIAN1s/MQplg1baqKYyOF9b8Cje6rrFTVwMSzhWTlhTy2StISY
 FOd8jj3L/63543w9yFH9dagAAAA==
X-Change-ID: 20250715-hwmon-ina238-microjoules-3d8edaa5ded0
To: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Wenliang Yan <wenliang202407@163.com>, 
 kernel@pengutronix.de, Jonas Rebmann <jre@pengutronix.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2677; i=jre@pengutronix.de;
 h=from:subject:message-id; bh=UooHWdbjwok23G1w7lyu5z/xDu2uKm62K3FAoZ+IEmw=;
 b=owGbwMvMwCF2ZcYT3onnbjcwnlZLYsgoC7ysoPezeNVf/tP389T05H65y87efO/C6xuHmjI77
 /H4btdJ7ShlYRDjYJAVU2SJVZNTEDL2v25WaRcLM4eVCWQIAxenAEzE6Dkjw74ZV1fcK4+7tkrs
 TMi9Wisj9/ZLi0uXTVyUGOZyP9lpuxQjw2PmvDY2/vr5W4RTGrwZZylz8F1PZ9P8VBQesLarK/w
 EMwA=
X-Developer-Key: i=jre@pengutronix.de; a=openpgp;
 fpr=0B7B750D5D3CD21B3B130DE8B61515E135CD49B5
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::ac
X-SA-Exim-Mail-From: jre@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The hwmon sysfs interface specifies that energy values should be
reported in microjoules. This is also what tools such as lmsensors
expect, reporting wrong values otherwise.

Adjust the driver to scale the output accordingly and adjust ina238
driver documentation.

Fixes: 6daaf15a1173 ("hwmon: (ina238) Add support for SQ52206")
Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
---
This is a fix for a bug introduced into ina238.c recently (6daaf15a1173
("hwmon: (ina238) Add support for SQ52206")) and merged into
v6.16-rc1.

Jean, Guenter, can you include this for 6.16, please?
---
 Documentation/hwmon/ina238.rst | 2 +-
 drivers/hwmon/ina238.c         | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/hwmon/ina238.rst b/Documentation/hwmon/ina238.rst
index d1b93cf8627f352612f17953c62efc5ef5596fe5..9a24da4786a43f7493b364b005b2ae9992c3b10d 100644
--- a/Documentation/hwmon/ina238.rst
+++ b/Documentation/hwmon/ina238.rst
@@ -65,7 +65,7 @@ Additional sysfs entries for sq52206
 ------------------------------------
 
 ======================= =======================================================
-energy1_input		Energy measurement (mJ)
+energy1_input		Energy measurement (uJ)
 
 power1_input_highest	Peak Power (uW)
 ======================= =======================================================
diff --git a/drivers/hwmon/ina238.c b/drivers/hwmon/ina238.c
index a4a41742786bd19e1c5dab34c7d71973527161a1..9a5fd16a4ec2a6d5a6cd5e8070d0442e1ef0135a 100644
--- a/drivers/hwmon/ina238.c
+++ b/drivers/hwmon/ina238.c
@@ -97,7 +97,7 @@
  *  Power (mW) = 0.2 * register value * 20000 / rshunt / 4 * gain
  *  (Specific for SQ52206)
  *  Power (mW) = 0.24 * register value * 20000 / rshunt / 4 * gain
- *  Energy (mJ) = 16 * 0.24 * register value * 20000 / rshunt / 4 * gain
+ *  Energy (uJ) = 16 * 0.24 * register value * 20000 / rshunt / 4 * gain * 1000
  */
 #define INA238_CALIBRATION_VALUE	16384
 #define INA238_FIXED_SHUNT		20000
@@ -500,9 +500,9 @@ static ssize_t energy1_input_show(struct device *dev,
 	if (ret)
 		return ret;
 
-	/* result in mJ */
-	energy = div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 *
-				data->config->power_calculate_factor, 4 * 100 * data->rshunt);
+	/* result in uJ */
+	energy = div_u64(regval * INA238_FIXED_SHUNT *	data->gain * 16 * 10 *
+				data->config->power_calculate_factor, 4 * data->rshunt);
 
 	return sysfs_emit(buf, "%llu\n", energy);
 }

---
base-commit: 155a3c003e555a7300d156a5252c004c392ec6b0
change-id: 20250715-hwmon-ina238-microjoules-3d8edaa5ded0

Best regards,
-- 
Jonas Rebmann <jre@pengutronix.de>


