Return-Path: <linux-kernel+bounces-768630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C71B26372
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 180A15C1E9F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90E1301012;
	Thu, 14 Aug 2025 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MtR1aJML"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2AD2FC899
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168688; cv=none; b=lru5zg8EPMlRQya8jpIfEiP/8v9a7OyDHnPsjBpBJQZboFIUZzebgifyQBUtVNdxAGsv+vU8FOnTtaCAn0LDmDPfA48GZ+xTmfcCm/JTAoV7lALi3hHzLgWbL6CuHokmPc3WyCPUfVppSwlqKqyFqJlH//WY0fTquPEsXwbkxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168688; c=relaxed/simple;
	bh=AGQlaXNKIOkbmOaAcaSIjJPEbPTH5PtLNFnrZRHqrcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Soq87knj55H3tkHcZwhhBDcZ+YeX8rqBlZ/0W9VBdJqY/f6/+erJTWXflriw0VEQEVt47xx9rGAjoST/llNTrDSuClRIUA5lP/Dp+Wbk4LDd+cj6GgMDIUejOz5jNsM6s/to9BXyFoNx0Mmaptk/7tNy+TBgVkxAlHKUYRQnivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MtR1aJML; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so3886705e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755168685; x=1755773485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DqVfHeCT5TjsbIyweENQ6jJYwaBKt/ltAWn8RP0BaME=;
        b=MtR1aJMLDT2aMOioG7HIj3p7HNe/kS1RhEcX4Enh7cHN8bkZH+ysKyqdfnxsj37wD6
         W6+ghVaClwSiRTiPGo2wxlTvGGD6Z+C4ykKHByJWwAkPqVIreW8av4HcOWPHBbrNqJT2
         7TLowg17h//JhDXOEYyONws74RJzRjVjfKJETnhpUYshWGdYDyIevRE/O2FAsadRTtxJ
         OFsBWcoDu67QF4RocLvbCN5MX4Wdotg39M+8vr1R449b1MnYdDI3JsBl04192EpmJTfO
         sSfqPKuoul96TVrDu/awZZsgepD8gKxeDrJyVM0h8wOJNPB6EnR+kFptkffR3T1ZdUez
         3sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168685; x=1755773485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqVfHeCT5TjsbIyweENQ6jJYwaBKt/ltAWn8RP0BaME=;
        b=s8M7aiaYUAmawPlGdmI0o1pGTf3S9qMvKJ5yU3/U3ARvv8y1r4fk9GutQMLcDpaow8
         wzXQjQl5tUalmnj9lxthPInSegP/AoayA4mY21fqqIQK0mrLdaSKeGeCrSDrDN6l4r0j
         2CryCOddGrwSuanfw2cxb+2me/cNb0zosKMfblSeu4iv9Rmzg2pJNGr6Mg9ZORT27jJV
         4LgHb4c05C16XICEnORBiO2s6DpOLsp33E7ahPHRlBxXd5Eh5OsmzBJmw913PnwyiIn0
         TAySBxj8wK7BObv6dmQZnOeVZXdA0iLvNgQ6X4miAL/U/9CElmnHULodYrzanrJrHmlH
         HTMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGvJKJQb5vMej85JWFyfCG2QXn3j5xOh344tdntXXjMM1YGBXWjQoFHLypZr3ihYuGMkirwFaKd+4rQ6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyY2aUBcxe9bhZZ9MG2ix7+GvFcKCqQHoR01HvXGnxPVBqiZ5G2
	4Q7hWvvgsBzoGwsg4vAatoNyvF/2IbPK5ojrJq4YhtgPRLeEppMjpYktT+sZMECgkhI=
X-Gm-Gg: ASbGncsF8dyaiIB5XO5yLLI/frJekBhujlvQFCHbz36WQrj/3vP129D26+gBdhxJzSU
	xkWYYtdsFnc3tGPCfefLW2bxgSTsJFPgHnfHAB+4VadWOHc7Vq5tupYb/YY0tbI/hSX3O548m+W
	yEcMfEloHjXUjOWodY4fVCbBhgi60ltGMwPrkYtNvvhf37tSasTAqpjJdVAdle7rlFpOn4ma3vn
	x7IyYvzE8ifSXYAJyLqtDh9qgsTWcYfIXFo/11r7Gm0VHGY43p5K5267BQ7ZR/llYDwtu8G9vRm
	JXZW1zb7lXKlz2SNK7pxwReGrTQmPMx73NWve7LmZerANhSZ1V47vi3JOeUejGLQlYHeqlMRIT0
	URCXGdZCQYEq4Y7t/38GDZoc8P/yOsE3mUmqPiaIxXw==
X-Google-Smtp-Source: AGHT+IHDChGA1M3koaJTPEReHQ1naKvyBQUGZKbVCxvANx+2eQKbWPeXZwN0lTI5x4qlNeP7iC6e4w==
X-Received: by 2002:a05:600c:35ca:b0:459:dc99:51bf with SMTP id 5b1f17b1804b1-45a1b656c57mr17079495e9.25.1755168684997;
        Thu, 14 Aug 2025 03:51:24 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm14228345e9.1.2025.08.14.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:51:24 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 11:49:56 +0100
Subject: [PATCH v2 5/6] coresight: Add format attribute for setting the
 timestamp interval
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-cs-syncfreq-v2-5-c76fcb87696d@linaro.org>
References: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
In-Reply-To: <20250814-james-cs-syncfreq-v2-0-c76fcb87696d@linaro.org>
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

Only show this attribute for ETM4x because timestamps aren't configured
in the same way for ETM3x. The attribute is only ever read in
coresight-etm4x-core.c.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c   | 13 ++++++++++++-
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 21 ++++++++++++---------
 drivers/hwtracing/coresight/coresight-etm4x.h      |  6 ++++++
 3 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f677c08233ba..af937bbb933c 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -25,6 +25,11 @@
 #include "coresight-syscfg.h"
 #include "coresight-trace-id.h"
 
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+#include <linux/perf/arm_pmu.h>
+#include "coresight-etm4x.h"
+#endif
+
 static struct pmu etm_pmu;
 static bool etm_perf_up;
 
@@ -69,7 +74,10 @@ PMU_FORMAT_ATTR(sinkid,		"config2:0-31");
 /* config ID - set if a system configuration is selected */
 PMU_FORMAT_ATTR(configid,	"config2:32-63");
 PMU_FORMAT_ATTR(cc_threshold,	"config3:0-11");
-
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+/* Interval = (2 ^ ts_level) */
+GEN_PMU_FORMAT_ATTR(ts_level);
+#endif
 
 /*
  * contextid always traces the "PID".  The PID is in CONTEXTIDR_EL1
@@ -103,6 +111,9 @@ static struct attribute *etm_config_formats_attr[] = {
 	&format_attr_configid.attr,
 	&format_attr_branch_broadcast.attr,
 	&format_attr_cc_threshold.attr,
+#if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
+	&format_attr_ts_level.attr,
+#endif
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


