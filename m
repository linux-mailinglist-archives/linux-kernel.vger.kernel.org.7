Return-Path: <linux-kernel+bounces-804143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE89B46AB4
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 11:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16767C6B4C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 09:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448542E613A;
	Sat,  6 Sep 2025 09:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="HWbXybSY"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D827A315D4A;
	Sat,  6 Sep 2025 09:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757151815; cv=none; b=iUzzlgqi+F+7zUA+T769c2DHLTrcGSs8y3qHUkHRXwImNAjjxp3f14cEGTiXYD5cvZQMF+mhIefXSFS/Rs6bgxSyV/et2ybO/O7CKIV3bJLOxIUqvD+ka43pxKQyiSnybUSVqhR+h/huWQXBkSW6azWSxGX3gSSCWSyG86wZNWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757151815; c=relaxed/simple;
	bh=mxbiQr2zYz1f312pbi30Clce1CDJurKdqtmz9FIyUZM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hL3ffIQTUWZ4GjU4p+k3ilgvJONOwJV/9J4iGU+IDxnSbx2jgjUrM8i6nCcrD69O7Pf0YNB6V0J2TeTtOq7FAxUxYJ+PMhxr7ub/9m5mreN71F4OcMuDi2ruw/ks60K7zAcCPCqdXvAffiCLXnAmkeVsuHoAGvk3RbHi6Y7+N0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=HWbXybSY; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=4mWTGCWEOX7pumrAaEPe6n0XdIQTYf6x4wm6OpHMv1Q=; b=HWbXybSY3sY7AyDGTKc8mMAAiQ
	kuZbvztgK3ILhFlZiQYCjQuCv8eCIHyGb1apPPSCQO7PD2ynFGXDlq2Ee3dJAMaf6CKDWRbA/Oig+
	+K+66zXrR6GPdlX71twf9rKbO5rMgSRtq+RbMfHbeXhY/iFpfuCTMndnqb843hb7Jrr+j3dKSRPAc
	zKFBpPZ6hoEjW2LDjMcCsAGsTKr2bWf1ctwIFFBq4UrqP8Mi3wurpPNEY/9F1i/5O/pedZrD7PMD4
	oV30pqL2URvirD2RFaJVbuAv9oaJumVxX2/yszd6jYVuonOBACEiDg7do06IgEG7LT0id9KUQXP6L
	ma029YjA==;
From: Andreas Kemnade <andreas@kemnade.info>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH] hwmon: sy7636a: add aliases
Date: Sat,  6 Sep 2025 11:43:08 +0200
Message-Id: <20250906094308.11129-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module aliases via module devicetable to have it autoloaded.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/hwmon/sy7636a-hwmon.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
index ed110884786b4..74ee0e756ffdc 100644
--- a/drivers/hwmon/sy7636a-hwmon.c
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -12,6 +12,7 @@
 #include <linux/hwmon.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/regulator/machine.h>
@@ -94,11 +95,18 @@ static int sy7636a_sensor_probe(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct platform_device_id sy7636a_sensor_idtable[] = {
+	{ "sy7636a-temperature" },
+	{ },
+};
+MODULE_DEVICE_TABLE(platform, sy7636a_sensor_idtable);
+
 static struct platform_driver sy7636a_sensor_driver = {
 	.probe = sy7636a_sensor_probe,
 	.driver = {
 		.name = "sy7636a-temperature",
 	},
+	.id_table = sy7636a_sensor_idtable,
 };
 module_platform_driver(sy7636a_sensor_driver);
 
-- 
2.39.5


