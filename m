Return-Path: <linux-kernel+bounces-767390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CBE6B253B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93165C1E36
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 19:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A28D30AAA3;
	Wed, 13 Aug 2025 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eAnGV8WJ"
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0E02E11CB;
	Wed, 13 Aug 2025 19:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112133; cv=none; b=Sx1MKGk/ywOloD+0nXVcUqN6wujGLRzjCDsWC2J2Tbwk7MIpgV3IZ/SeInl5KQusJSPVJ/SYG+StuZIkPt6yeAu/vwVw+NfQKgTp558e94A2GWkD+E0IYh/+aQ3aULKjwWcLyHFaf51deU+I7007O6tHUXUFzeEMhnl0Ywf89DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112133; c=relaxed/simple;
	bh=oeCOzJCq5ymCC1NN6obQemLPT+ZVfIDgYygwYya08T8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGp5a+QXZaIr51dOqUYXqrzcqvEdaXU8L/Hk0t2O9jF+NrRAC2BrzSZtBL+VEDJl0C5Bbla8v+X6k5ybhZkwi39ir8TOj1hdcT+zhi1aQSsVMJRVu+NsS7d7ZCr5zNqjfOBiZIJWGv3NpH5QAvQ3FoIDXf+QBDmD/1LALzUr4CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eAnGV8WJ; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57DJ8aGX1712671;
	Wed, 13 Aug 2025 14:08:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755112116;
	bh=pSOgiMxGaSVA9ke+VrrlPNo38YxVrLbStu+LE7ZFCU8=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eAnGV8WJBPhMaujRZ9sva11eIG/GuUJxa366q5WMqRfWDEgxpnRry2ZeMrFASt6k2
	 x3vHJVLz3kHvi0u3302GRNFGtZVXWfOS3Hk+7w+osjFbqVI4n/LePi0COBjUBmBifZ
	 rdQD2L9xC/rBumsNJmyUnE4JE+w7/yvi+Rb05UCs=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57DJ8a7b601294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 13 Aug 2025 14:08:36 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 13
 Aug 2025 14:08:35 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 13 Aug 2025 14:08:35 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57DJ8ZdZ2450763;
	Wed, 13 Aug 2025 14:08:35 -0500
From: Nishanth Menon <nm@ti.com>
To: Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Rob Herring <robh@kernel.org>, David Airlie
	<airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Laurent Pinchart
	<Laurent.pinchart@ideasonboard.com>,
        Neil Armstrong
	<neil.armstrong@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Robert Nelson <robertcnelson@gmail.com>,
        Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] drm/bridge: it66121: Add it66122 support
Date: Wed, 13 Aug 2025 14:08:35 -0500
Message-ID: <20250813190835.344563-3-nm@ti.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250813190835.344563-1-nm@ti.com>
References: <20250813190835.344563-1-nm@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

The IT66122 is a drop in replacement for the IT66122. The part is
register compatible with what we use of the IT66121. The only relevant
change being the PID is now 0x0622 vs 0x0612. Add this extra PID so
probe does not fail during the PID check with these new parts.

Signed-off-by: Nishanth Menon <nm@ti.com>
---

Note: checkpatch --strict reports:
CHECK: No space is necessary after a cast
#45: FILE: drivers/gpu/drm/bridge/ite-it66121.c:1643:
+	{ "it66122", (kernel_ulong_t) &it66122_chip_info },

I chose to retain existing style - let me know if we want to clean this
up as well.

NOTE: .id = ID_IT66121 is explicitly used as indication of reuse of
existing it66121 compatibility.

 drivers/gpu/drm/bridge/ite-it66121.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
index aa7b1dcc5d70..329fa47a5701 100644
--- a/drivers/gpu/drm/bridge/ite-it66121.c
+++ b/drivers/gpu/drm/bridge/ite-it66121.c
@@ -1618,6 +1618,12 @@ static const struct it66121_chip_info it66121_chip_info = {
 	.pid = 0x0612,
 };
 
+static const struct it66121_chip_info it66122_chip_info = {
+	.id = ID_IT66121,
+	.vid = 0x4954,
+	.pid = 0x0622,
+};
+
 static const struct it66121_chip_info it6610_chip_info = {
 	.id = ID_IT6610,
 	.vid = 0xca00,
@@ -1626,6 +1632,7 @@ static const struct it66121_chip_info it6610_chip_info = {
 
 static const struct of_device_id it66121_dt_match[] = {
 	{ .compatible = "ite,it66121", &it66121_chip_info },
+	{ .compatible = "ite,it66122", &it66122_chip_info },
 	{ .compatible = "ite,it6610", &it6610_chip_info },
 	{ }
 };
@@ -1633,6 +1640,7 @@ MODULE_DEVICE_TABLE(of, it66121_dt_match);
 
 static const struct i2c_device_id it66121_id[] = {
 	{ "it66121", (kernel_ulong_t) &it66121_chip_info },
+	{ "it66122", (kernel_ulong_t) &it66122_chip_info },
 	{ "it6610", (kernel_ulong_t) &it6610_chip_info },
 	{ }
 };
-- 
2.47.0


