Return-Path: <linux-kernel+bounces-747421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3685AB133A5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DFCB16C737
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60315213E66;
	Mon, 28 Jul 2025 04:19:43 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3821C36;
	Mon, 28 Jul 2025 04:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753676383; cv=none; b=iR5SKwspVtB5Lmy8xfchFaNrnpNytMRsiTK7R1Al2eo6aXvWpR/NNUUBD5lHcBZW9ksPtZ5SNpgdg/9FFQyaAhXWXBuxRutfr7J8l+ig5nVfVIH8CsDT1MpnUxcCl8y9gNxf3/v8tSE/GMvS45dck/egtOsYrB6/sJd3isSz+Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753676383; c=relaxed/simple;
	bh=+21c/5kfzRyWQ9mGcHPND0dXCpuIpbvrRxN47140bqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gYlzPuTdIB8kR5o9OyCheBBPfanJctNZaWI4lXCE9WoDiFjT9K7BlxeuCDCnO2nPcG4fITklF7aUu9AZOhmOt8A8r+MqH/4hBy4d18J8tvm99sSqa/JEsfRj4BOVkHNM+rdYKDi1xv4yIa8p9UlWzKbMrUBejHaV5VL9B/dDAN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8D2461A147C;
	Mon, 28 Jul 2025 06:19:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 4F79A1A1480;
	Mon, 28 Jul 2025 06:19:34 +0200 (CEST)
Received: from lsv03900.swis.in-blr01.nxp.com (lsv03900.swis.in-blr01.nxp.com [10.12.177.15])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D78B01800079;
	Mon, 28 Jul 2025 12:19:32 +0800 (+08)
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: linux-kernel@vger.kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: vikash.bansal@nxp.com,
	priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com,
	Lakshay Piplani <lakshay.piplani@nxp.com>
Subject: [PATCH v2 2/2] hwmon: (lm75) Add NXP P3T1750 support
Date: Mon, 28 Jul 2025 09:49:13 +0530
Message-Id: <20250728041913.3754236-2-lakshay.piplani@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728041913.3754236-1-lakshay.piplani@nxp.com>
References: <20250728041913.3754236-1-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

Add support for lm75 compatible NXP P3T1750
temperature sensor.

Signed-off-by: Lakshay Piplani <lakshay.piplani@nxp.com>
---
Changes in v2:
- None. Patch unchanged.

 Documentation/hwmon/lm75.rst |  6 ++++--
 drivers/hwmon/lm75.c         | 13 +++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/lm75.rst b/Documentation/hwmon/lm75.rst
index c6a54bbca3c5..84e690824fee 100644
--- a/Documentation/hwmon/lm75.rst
+++ b/Documentation/hwmon/lm75.rst
@@ -121,9 +121,9 @@ Supported chips:
 
          https://www.ti.com/product/TMP1075
 
-  * NXP LM75B, P3T1755, PCT2075
+  * NXP LM75B, P3T1755, PCT2075, 'P3T1750'
 
-    Prefix: 'lm75b', 'p3t1755', 'pct2075'
+    Prefix: 'lm75b', 'p3t1755', 'pct2075', 'p3t1750'
 
     Addresses scanned: none
 
@@ -135,6 +135,8 @@ Supported chips:
 
                https://www.nxp.com/docs/en/data-sheet/PCT2075.pdf
 
+               https://www.nxp.com/docs/en/data-sheet/P3T1750DP.pdf
+
   * AMS OSRAM AS6200
 
     Prefix: 'as6200'
diff --git a/drivers/hwmon/lm75.c b/drivers/hwmon/lm75.c
index 9b4875e2fd8d..979057f02748 100644
--- a/drivers/hwmon/lm75.c
+++ b/drivers/hwmon/lm75.c
@@ -40,6 +40,7 @@ enum lm75_type {		/* keep sorted in alphabetical order */
 	max31725,
 	mcp980x,
 	p3t1755,
+	p3t1750,
 	pct2075,
 	stds75,
 	stlm75,
@@ -229,6 +230,13 @@ static const struct lm75_params device_params[] = {
 		.num_sample_times = 4,
 		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
 	},
+	[p3t1750] = {
+		.clr_mask = 1 << 1 | 1 << 7,	/* disable SMBAlert and one-shot */
+		.default_resolution = 12,
+		.default_sample_time = 55,
+		.num_sample_times = 4,
+		.sample_times = (unsigned int []){ 28, 55, 110, 220 },
+	},
 	[pct2075] = {
 		.default_resolution = 11,
 		.default_sample_time = MSEC_PER_SEC / 10,
@@ -806,6 +814,7 @@ static const struct i2c_device_id lm75_i2c_ids[] = {
 	{ "max31726", max31725, },
 	{ "mcp980x", mcp980x, },
 	{ "p3t1755", p3t1755, },
+	{ "p3t1750", p3t1750, },
 	{ "pct2075", pct2075, },
 	{ "stds75", stds75, },
 	{ "stlm75", stlm75, },
@@ -920,6 +929,10 @@ static const struct of_device_id __maybe_unused lm75_of_match[] = {
 		.compatible = "nxp,p3t1755",
 		.data = (void *)p3t1755
 	},
+	{
+		.compatible = "nxp,p3t1750",
+		.data = (void *)p3t1750
+	},
 	{
 		.compatible = "nxp,pct2075",
 		.data = (void *)pct2075
-- 
2.25.1


