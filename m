Return-Path: <linux-kernel+bounces-762232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB40DB203CF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91EF73AFB3F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48D02DECCB;
	Mon, 11 Aug 2025 09:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RYtj4f+E"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C78C2DEA73
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904769; cv=none; b=KdlnCE531yXPs5fR3bCfUP2CmDrjLRVhiH9IS166gwhtuYepU8/S/hxG+ogtNP/g5ABgZKdtJB+HHjH2Hv5THBOo29zSqGE+aC8jFMrqVJG7DNkEq7jPfNT+WzAAdQaPAywZH11YCE9KKrpf7EI2Ze8QlNn+bZSw0z8Z3vF61og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904769; c=relaxed/simple;
	bh=wpvKm03JgBns8SErxtyGsvGNWNV6pSmX+F+F8Bl1AxQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sXF19lBef0bX5H3eY3CY3Vc65X1JZQm1rJJoTFjvG5zq0sLxjJ4ev1Hd6RO9tX4E1FHJylIk38ZzDM/FCBoL0Htcf0cvJz7laf9yfsoc7VFZdu/QrYlcSnHc7SZgSs5wGNDPUhJYAd0bozxze9SXep3UjbKrrVJuzxZSm7NV+Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RYtj4f+E; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459fdc391c6so14820725e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904765; x=1755509565; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+wY/wlxwOBKXlk5tbUQnKyA0OI06WJcUCTjg68F176k=;
        b=RYtj4f+EAXTN9pt/1sGOhvJj6fWfqjMgHUWdjrqQCaGpcmrgpNFFvcpQtCz0febv5z
         U86qJBdkRipOj0mjipLi30Dr9f0EqWB5tRYYWJDu0LI5J6bwmOZOVC1yP71JINEYNzY4
         Sp2cbc/OiUruq+CdGzYxBR6AKho2j8mdeHB/iGzzqpCxBvU1BWmWfkdXNtmP7sIzIZqX
         yGcxWWscysoxVr+aT+N0Xk6ozLu9XL7QuYmgugByXPFAF5W/6QxqRmvGUbYxUzD2KOVM
         qwcQ4ysrmaxzC8iC1z0nz4B4pEmynCOrr0OcxH/4A5FEmk4Qo0v8C7+ddvc7MgUdeFLG
         6DBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904765; x=1755509565;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+wY/wlxwOBKXlk5tbUQnKyA0OI06WJcUCTjg68F176k=;
        b=QyL43tOYsmFl7i1Dtj6Go4AQfbn9H/UCLopNBs3joEvged3s1ZrZKy7CVLwaZcfPC6
         AoH6ftfpmjtXp7pBdwrphLi8cz8Az1BkR34c1g1pagcCFlMWKk6JlDOe2WkrFi1R94I3
         LmLLteREiapua+ZVZoWjY64nJSZfj0iclRK4jGQnMbT3Li3STgWBH7Z3gsAH1uM2Y/aL
         nd/Cy5DCh/HWM3WnVRQyMcIlwWnxL5UzJZnZ+XJpxie4Eyp0/6HBGj6JVmj3+3MG+VYg
         Rv2F8O5oQPOe6KV/Gzzf8/Y65HSWWpIcPCSaN42zD6fb916ioHNQigMcKN8SPUAUcxRy
         RnhA==
X-Forwarded-Encrypted: i=1; AJvYcCUjD9dXL6JSDrfOprV270QhxkNb8a81ZB8gQSBRVblFEkIcEuoQvm2bxJ1l1RrBaj3bYgL4jDIiWBCLqP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYqhPdshtdALdsOQb3TNApjE6KoSfupoTkVVqBYigt9SlECK0y
	Yleff/t3CtZotis0YbQb6C5X39eu5HmRuCa+rUu73Q3EnygNchEApFkDA5fQ/nOiSQ/hSrkBAGg
	luoiIZKA=
X-Gm-Gg: ASbGncvHdFoGQSIrJWJ6vOCxcFknuf8gI5ADv2d+f/Gqg5E0dwI8BURHLJI5BlJSBQI
	wpHs04NBXldaL0c1rebTaVIdBsSyJzunMABHG/EC4a+t3gWDVvZBUdrnaMif7cRoncBirT0BRcW
	ENBAo3Em8xDGZgEXRnp4Hloy4yixWDI12PjksCJNDNuNPvOZg+bJD5PFdJYacdobva9xyIYsd0p
	IYetnzK+Xkv/6gaUzTLuhjTLzJxDhEiR9WqnXzcOR8+Pnm/k0GEaV7YN8W/jkDaYj4JR+U9F9Qq
	hxRauyJYEz0JrD86+Qs55WNA+ZEQ2/5sgnsFiNIIJt9XOwBWICoZCF+U/9Tr4RIBNiMGUDB1Cdd
	OsohC3n4l3laXdQaeg4IpGCYj3iPpbTY=
X-Google-Smtp-Source: AGHT+IF8WeH/oU2owgkUTiVQJ1UjH7XhvycJlh2P4qsYEEoxnO+VLtTmDk7n5fyagJVi0TbZzJM7jA==
X-Received: by 2002:a05:600c:4588:b0:458:f70d:ebdd with SMTP id 5b1f17b1804b1-459f4f9b74cmr107921215e9.16.1754904765407;
        Mon, 11 Aug 2025 02:32:45 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm39904799f8f.39.2025.08.11.02.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:32:44 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 11 Aug 2025 10:32:10 +0100
Subject: [PATCH 5/6] coresight: Add format attribute for setting the
 timestamp interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-james-cs-syncfreq-v1-5-b001cd6e3404@linaro.org>
References: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
In-Reply-To: <20250811-james-cs-syncfreq-v1-0-b001cd6e3404@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

Timestamps are currently emitted at the maximum rate possible, which is
much too frequent for most use cases. Add an attribute to be able to set
the interval. Granular control is not required, so save space in the
config by interpreting it as 2 ^ ts_interval. And then 4 bits (0 - 15) is
enough to set the interval to be larger than the existing SYNC timestamp
interval.

No sysfs file is needed for this attribute because counter generated
timestamps are only configured for Perf mode.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c   |  6 +++++-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 21 ++++++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  6 ++++++
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f677c08233ba..c28ed6e63550 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -12,6 +12,7 @@
 #include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/init.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/perf_event.h>
 #include <linux/percpu-defs.h>
 #include <linux/slab.h>
@@ -21,6 +22,7 @@
 
 #include "coresight-config.h"
 #include "coresight-etm-perf.h"
+#include "coresight-etm4x.h"
 #include "coresight-priv.h"
 #include "coresight-syscfg.h"
 #include "coresight-trace-id.h"
@@ -69,7 +71,8 @@ PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 /* config ID - set if a system configuration is selected */
 PMU_FORMAT_ATTR(configid,	"config2:32-63");
 PMU_FORMAT_ATTR(cc_threshold,	"config3:0-11");
-
+/* Interval = (2 ^ ts_level) */
+GEN_PMU_FORMAT_ATTR(ts_level);
 
 /*
  * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
@@ -103,6 +106,7 @@ static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_configid.attr,
 	&format_attr_branch_broadcast.attr,
 	&format_attr_cc_threshold.attr,
+	&format_attr_ts_level.attr,
 	NULL,
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1a2d02bdcb88..42277c201d4f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -28,6 +28,7 @@
 #include <linux/amba/bus.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/perf_event.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -615,7 +616,7 @@ static void etm4_enable_hw_smp_call(void *info)
  *  +--------------+
  *         |
  *  +------v-------+
- *  | Counter x    |   (reload to 1 on underflow)
+ *  | Counter x    |   (reload to 2 ^ ts_level on underflow)
  *  +--------------+
  *         |
  *  +------v--------------+
@@ -626,11 +627,17 @@ static void etm4_enable_hw_smp_call(void *info)
  *  | Timestamp Generator  |  (timestamp on resource y)
  *  +----------------------+
  */
-static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
+static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata,
+				       struct perf_event_attr *attr)
 {
 	int ctridx;
 	int rselector;
 	struct etmv4_config *config = &drvdata->config;
+	u8 ts_level = ATTR_CFG_GET_FLD(attr, ts_level);
+
+	/* Disable when ts_level == MAX */
+	if (ts_level == FIELD_GET(ATTR_CFG_FLD_ts_level_MASK, UINT_MAX))
+		return 0;
 
 	/* No point in trying if we don't have at least one counter */
 	if (!drvdata->nr_cntr)
@@ -666,12 +673,8 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
 		return -ENOSPC;
 	}
 
-	/*
-	 * Initialise original and reload counter value to the smallest
-	 * possible value in order to get as much precision as we can.
-	 */
-	config->cntr_val[ctridx] = 1;
-	config->cntrldvr[ctridx] = 1;
+	/* Initialise original and reload counter value. */
+	config->cntr_val[ctridx] = config->cntrldvr[ctridx] = 1 << ts_level;
 
 	/*
 	 * Trace Counter Control Register TRCCNTCTLRn
@@ -761,7 +764,7 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 		 * order to correlate instructions executed on different CPUs
 		 * (CPU-wide trace scenarios).
 		 */
-		ret = etm4_config_timestamp_event(drvdata);
+		ret = etm4_config_timestamp_event(drvdata, attr);
 
 		/*
 		 * No need to go further if timestamp intervals can't
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index aaa6633b2d67..54558de158fa 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -598,6 +598,12 @@
 #define ETM_CNTR_MAX_VAL		0xFFFF
 #define ETM_TRACEID_MASK		0x3f
 
+#define ATTR_CFG_FLD_ts_level_CFG	config3
+#define ATTR_CFG_FLD_ts_level_LO	12
+#define ATTR_CFG_FLD_ts_level_HI	15
+#define ATTR_CFG_FLD_ts_level_MASK	GENMASK(ATTR_CFG_FLD_ts_level_HI, \
+						ATTR_CFG_FLD_ts_level_LO)
+
 /* ETMv4 programming modes */
 #define ETM_MODE_EXCLUDE		BIT(0)
 #define ETM_MODE_LOAD			BIT(1)

-- 
2.34.1


