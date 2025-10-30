Return-Path: <linux-kernel+bounces-878438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F0CC209A4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDB1D4ED71F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CC71DE2BF;
	Thu, 30 Oct 2025 14:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKkfnCNM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFE1433A6;
	Thu, 30 Oct 2025 14:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761834615; cv=none; b=cZBkPY/LuYcvlM7VT7tawVOjCvmH0YJRxAcz60W7ZrtsyuEV5a151Dq8wmznWkEV2yEIidxV1Jw5M1WJEJq7DhroBv0hiagoYonW9qblZZUDPrrlnBRfjMk0i/zymLoU/82C0EaOFWBtD3s+oi3iiva0EAtcaW0E2PDQea3GC5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761834615; c=relaxed/simple;
	bh=LtxAZVDWp3qPa2hvmM/6DvgAIPTSv0AZgSDBh3OhXaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UKBV6EPFKN55yFDfYGgZnbKVsX9R1redJU55HlpkUmNvYO+NknClL5GwxuasM13hHM/cGwTltD8pasxyQ97fC153pcsDldtKKAYHNvNIcHIoq5IX9qIFQwCtTZuXheyHwJbOCQ3J2yEU+TnG/2LFEPICNia7sZGbcWYKicTpNTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKkfnCNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A14DC4CEF1;
	Thu, 30 Oct 2025 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761834614;
	bh=LtxAZVDWp3qPa2hvmM/6DvgAIPTSv0AZgSDBh3OhXaI=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=iKkfnCNMpOgNTipLJYjt7YksFBYH/KwJXi+mcl1cDQWxD32ybqv3ED2JevY+JHja7
	 8t8DcwGSOVF+9wLF8edabMjJTzm33MHzF9Wi/2meUHeMxDjGmNSeTvNNAkwy8btD8X
	 KMTuTecciQkXb36z/w03xy/zJbl+2wwzLFZlHRmqnwGkt1l7JGKYjBiKJscTjP2e1R
	 JadvXYhta+w+RJHNe3tHvu+iySXm/dVuMt/rq5MWyqfn/jd4A6FhBqHq4HDWZ6dtWW
	 vz/oQ2E4mP1ntCKi4nIsg5YuLKmeLemmYLolHVb9ER7+hIlnc43Li6gqRDVaDCOcL5
	 HdnNDI7JmvZpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 802A1CCF9E3;
	Thu, 30 Oct 2025 14:30:14 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Date: Thu, 30 Oct 2025 22:30:06 +0800
Subject: [PATCH] hwmon: (gpd-fan) initialize EC on driver load for Win 4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-win4-v1-1-c374dcb86985@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAG12A2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA2MD3fLMPBNds2RzS/M0c0Njy2RjJaDSgqLUtMwKsDHRsbW1AFWYAzx
 WAAAA
X-Change-ID: 20251030-win4-6c797f7139c3
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 niecheng1@uniontech.com, zhanjun@uniontech.com, 
 kylon <3252255+kylon@users.noreply.github.com>, 
 Cryolitia PukNgae <cryolitia@uniontech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761834613; l=3221;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=t9JHAfOJItGPrnrOdS2gWLJmFHa2xGmsXuMmQl261Mc=;
 b=VJe5rhI5SINpl2JRyT2gfD/kTIfCcZhnjPEjVNBEvAczGJAK/pU/tvII8a51AFt+LFH0z1wcm
 bLoGxuRsI5LB0OLOsb8G1ZQ3O7RQXL7XEZZzgzFtqera1QEDHc9FF2k
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

From: Cryolitia PukNgae <cryolitia@uniontech.com>

The original implement will re-init the EC when it reports a zero
value, and it's a workaround for the black box buggy firmware.

Now a contributer test and report that, the bug is that, the firmware
won't initialize the EC on boot, so the EC ramains in unusable status.
And it won't need to re-init it during runtime. The original implement
is not perfect, any write command will be ignored until we first read
it. Just re-init it unconditionally when the driver load could work.

Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
Co-developed-by: kylon <3252255+kylon@users.noreply.github.com>
Signed-off-by: kylon <3252255+kylon@users.noreply.github.com>
Link: https://github.com/Cryolitia/gpd-fan-driver/pull/20
Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
 drivers/hwmon/gpd-fan.c | 52 ++++++++++++++++++++++++-------------------------
 1 file changed, 25 insertions(+), 27 deletions(-)

diff --git a/drivers/hwmon/gpd-fan.c b/drivers/hwmon/gpd-fan.c
index 57caae9a23eb..43ec092fc26e 100644
--- a/drivers/hwmon/gpd-fan.c
+++ b/drivers/hwmon/gpd-fan.c
@@ -273,31 +273,6 @@ static int gpd_generic_read_rpm(void)
 	return (u16)high << 8 | low;
 }
 
-static void gpd_win4_init_ec(void)
-{
-	u8 chip_id, chip_ver;
-
-	gpd_ecram_read(0x2000, &chip_id);
-
-	if (chip_id == 0x55) {
-		gpd_ecram_read(0x1060, &chip_ver);
-		gpd_ecram_write(0x1060, chip_ver | 0x80);
-	}
-}
-
-static int gpd_win4_read_rpm(void)
-{
-	int ret;
-
-	ret = gpd_generic_read_rpm();
-
-	if (ret == 0)
-		// Re-init EC when speed is 0
-		gpd_win4_init_ec();
-
-	return ret;
-}
-
 static int gpd_wm2_read_rpm(void)
 {
 	for (u16 pwm_ctr_offset = GPD_PWM_CTR_OFFSET;
@@ -317,11 +292,10 @@ static int gpd_wm2_read_rpm(void)
 static int gpd_read_rpm(void)
 {
 	switch (gpd_driver_priv.drvdata->board) {
+	case win4_6800u:
 	case win_mini:
 	case duo:
 		return gpd_generic_read_rpm();
-	case win4_6800u:
-		return gpd_win4_read_rpm();
 	case win_max_2:
 		return gpd_wm2_read_rpm();
 	}
@@ -577,6 +551,28 @@ static struct hwmon_chip_info gpd_fan_chip_info = {
 	.info = gpd_fan_hwmon_channel_info
 };
 
+static void gpd_win4_init_ec(void)
+{
+	u8 chip_id, chip_ver;
+
+	gpd_ecram_read(0x2000, &chip_id);
+
+	if (chip_id == 0x55) {
+		gpd_ecram_read(0x1060, &chip_ver);
+		gpd_ecram_write(0x1060, chip_ver | 0x80);
+	}
+}
+
+static void gpd_init_ec(void)
+{
+	// The buggy firmware won't initialize EC properly on boot.
+	// Before its initialization, reading RPM will always return 0,
+	// and writing PWM will have no effect.
+	// Initialize it manually on driver load.
+	if (gpd_driver_priv.drvdata->board == win4_6800u)
+		gpd_win4_init_ec();
+}
+
 static int gpd_fan_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -604,6 +600,8 @@ static int gpd_fan_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(region),
 				     "Failed to register hwmon device\n");
 
+	gpd_init_ec();
+
 	return 0;
 }
 

---
base-commit: 65bc97a5e49ea4174ba7e89afdada3e30e6e39c0
change-id: 20251030-win4-6c797f7139c3

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



