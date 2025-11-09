Return-Path: <linux-kernel+bounces-891950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0840EC43E41
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 14:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 682F84E4975
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 13:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 823162F39B4;
	Sun,  9 Nov 2025 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rfV0/aVQ"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C6C133
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 13:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762693216; cv=none; b=YvqEJQ1RjSFl1RS6uXb/6lh/3p3Bq/oE1/k2wW9GL6ZaLWDp59Dc5o7aspsRfKMHwYsprAQzx6ceXWQ5mlnn8hBKsdqnnR8TDbJG8euKxlgxE9ax6pWQFfgpSN/4PMPDWfIrUwZvHvwfWTy0UqHbyQjSQWmRA0s6cn9QxqIKDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762693216; c=relaxed/simple;
	bh=E9WRGnkno3lDzIRl+uICSC0YZ0B7rxBaWeMBisyPAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOCF1vSg0oBKQRfkHO1yCoIFCroytb7yODS12UKpZXnDr6z1mqgwZZvkXyIMdGNNCAe0aMpMjtnZzI9wcS3V7Jlgz5MxcxXG6HhR171tzLD6UnhzI55QadzcIFFbIQmX2lRPQwQbES6pidRhccN3xhZLWWwWHFZryrESStqw6RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rfV0/aVQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762693211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i+I3Jeh1sNuH7+V8R1j5hA1zsKwyPco0WKcK+vaAXJ4=;
	b=rfV0/aVQQL/aWap3s5046F9YlN4cBAPCd0BIGDe9eNEwRGU9iHZIwQ+4fpOSAXoBlY/GDj
	gidJ9Sksl+Abm0oPX2Ajk0yu98Ubz8TmnlTSBOq4u6g4J8VGy4eUGTiXQ0qiBZ3+u080ZA
	lcoiIKQ5WRJ524lxyvCP7PVkqb0DwfM=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Huisong Li <lihuisong@huawei.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] w1: therm: Use clamp_t to simplify int_to_short helper
Date: Sun,  9 Nov 2025 13:59:55 +0100
Message-ID: <20251109130000.406691-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use clamp_t() instead of manually casting the return value.

Replace sprintf() with sysfs_emit() to improve sysfs show functions
while we're at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/w1/slaves/w1_therm.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
index 9ccedb3264fb..cf686e6ba3d5 100644
--- a/drivers/w1/slaves/w1_therm.c
+++ b/drivers/w1/slaves/w1_therm.c
@@ -961,9 +961,8 @@ static inline int temperature_from_RAM(struct w1_slave *sl, u8 rom[9])
  */
 static inline s8 int_to_short(int i)
 {
-	/* Prepare to cast to short by eliminating out of range values */
-	i = clamp(i, MIN_TEMP, MAX_TEMP);
-	return (s8) i;
+	/* Cast to short by eliminating out of range values */
+	return clamp_t(s8, i, MIN_TEMP, MAX_TEMP);
 }
 
 /* Interface Functions */
@@ -1702,7 +1701,7 @@ static ssize_t temperature_show(struct device *device,
 		return 0;
 	}
 
-	return sprintf(buf, "%d\n", temperature_from_RAM(sl, info.rom));
+	return sysfs_emit(buf, "%d\n", temperature_from_RAM(sl, info.rom));
 }
 
 static ssize_t ext_power_show(struct device *device,
@@ -1724,7 +1723,7 @@ static ssize_t ext_power_show(struct device *device,
 			"%s: Power_mode may be corrupted. err=%d\n",
 			__func__, SLAVE_POWERMODE(sl));
 	}
-	return sprintf(buf, "%d\n", SLAVE_POWERMODE(sl));
+	return sysfs_emit(buf, "%d\n", SLAVE_POWERMODE(sl));
 }
 
 static ssize_t resolution_show(struct device *device,
@@ -1746,7 +1745,7 @@ static ssize_t resolution_show(struct device *device,
 			__func__, SLAVE_RESOLUTION(sl));
 	}
 
-	return sprintf(buf, "%d\n", SLAVE_RESOLUTION(sl));
+	return sysfs_emit(buf, "%d\n", SLAVE_RESOLUTION(sl));
 }
 
 static ssize_t resolution_store(struct device *device,
@@ -1827,7 +1826,7 @@ static ssize_t alarms_show(struct device *device,
 			__func__, ret);
 	}
 
-	return sprintf(buf, "%hd %hd\n", tl, th);
+	return sysfs_emit(buf, "%hd %hd\n", tl, th);
 }
 
 static ssize_t alarms_store(struct device *device,
@@ -1969,7 +1968,7 @@ static ssize_t therm_bulk_read_show(struct device *device,
 		}
 	}
 show_result:
-	return sprintf(buf, "%d\n", ret);
+	return sysfs_emit(buf, "%d\n", ret);
 }
 
 static ssize_t conv_time_show(struct device *device,
@@ -1982,7 +1981,7 @@ static ssize_t conv_time_show(struct device *device,
 			"%s: Device is not supported by the driver\n", __func__);
 		return 0;  /* No device family */
 	}
-	return sprintf(buf, "%d\n", conversion_time(sl));
+	return sysfs_emit(buf, "%d\n", conversion_time(sl));
 }
 
 static ssize_t conv_time_store(struct device *device,
@@ -2024,7 +2023,7 @@ static ssize_t features_show(struct device *device,
 			 "%s: Device not supported by the driver\n", __func__);
 		return 0;  /* No device family */
 	}
-	return sprintf(buf, "%u\n", SLAVE_FEATURES(sl));
+	return sysfs_emit(buf, "%u\n", SLAVE_FEATURES(sl));
 }
 
 static ssize_t features_store(struct device *device,
-- 
2.51.1


