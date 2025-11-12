Return-Path: <linux-kernel+bounces-897556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D07AEC531BF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71DF6503EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CF53446BB;
	Wed, 12 Nov 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v4EcFteb"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C9D33D6F1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960963; cv=none; b=r13UYwVoe9bQXnh9TvxwE4XuO3liqH+Or1nIGhwHWfWAojCZyAQ6CtPLFvaXB+AH1m+n18zNXOKOG2jvn+rmx+3/wc8OMscZ3N7N3RGKAbAjE4EiZ05CIIipCCYabCPpDIBCIKIMVutmIlg/wlj3RmhvJjptncy1iZ/kF+/WZgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960963; c=relaxed/simple;
	bh=CVyCyQt/4XeVwaXkLI2sx+lGIsU0DfdrUUdJXTKDH1Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FthrGdYqh6+2chi77doJNAtk2Fk2As17gQXr/W3tygfyJvwc/G/EAGXmvAS1S41gLDX3OAxVEAWk24UKeD0zv+Zp2RhGT6AZ+4u15fSqd2qTC/QN+Lxppondm4WgsfD4BsxQTjBrhrLwBbUJwetHkkLHeanXGeNnOC/ESk/xlAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v4EcFteb; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-477442b1de0so6917215e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960959; x=1763565759; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wh23cgVTrsuEAgMOdQ2R3Fyv92omKUsnmPcgOaLOE0w=;
        b=v4EcFteb08qZVC3aLlY70Wkgt1laK5PAgaNzSjgDyiuchshVod/s261Hw5z80pEfly
         jDacIWjWomdVtH2yaczchch1SCbyQdf9hb8SgSmNYv4EW8hT92I82wy6larPUoy5t0K5
         rqRnUemsFJ+ns63+osNF6jecJ3zmuBeSiQEThL1cqCkLi4hqSAoW7pxXofWYZwXy5pmi
         HEO4YkU7ab6CosdIv9Jf4p1tf4O9DHkoquIrxTtPNF/4lbzPDIJBfyioAtU7e76VocRw
         jMaAmmfs9RLLLinCWqdxjT/LzYBV6+9Lcwn2upgV1uCUeOsdb601/DLQFQlf83d/FPxb
         DWOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960959; x=1763565759;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wh23cgVTrsuEAgMOdQ2R3Fyv92omKUsnmPcgOaLOE0w=;
        b=Wo0aVilMRCmuSuMldIAetZGtVBtg375UwYvCeG4NjxvGHqJftw73zlTnlxp3BBzIvZ
         W0nLduj3SeKfJ5dZZ9rxYR3Q3T/RppKkVbYZ8v9cjrDyoHo7Nzltjb+HVx9L/dIo4Kje
         +nM2uZMe5NrynknwMyPbU8U0lSwD9T3ID+OdpASdw6hkSkxDJ04zVhaa7JvqLm6Lt3dP
         e4gajt3Gt9btHADIb3BS0PawzQy9AKtprS1QrLbUSBAzQYruWWKCg5RabNuOskBtx9Gx
         53pqCcsSQ0J59hoMVJ5VoYVGHbAfStvx320PJvTP9WW25GnGqJVToXs1zw2ZGtw1W/3p
         Aoww==
X-Forwarded-Encrypted: i=1; AJvYcCVmAzVYORVidFgcG/issgBxfer0wmUgpAdRn3WHuZ9k2yHRPKsm332QCGFVxwNseRv/5C8GCuMT0Cwmk9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuTwusKEzI5DDNagi0jFZ+liwjZomKKgU5wnt2GW+ggXyCtK+e
	9rbBG6UskKYbh4hSe8adaLVZTtv/5rOiFEfXuCdwq+eSxuv12OX9VRws/a1MTAcuUR9n7arr0OO
	sv19zsTY=
X-Gm-Gg: ASbGncvXA48vFkm6dI+/YSMv3cCWa5YNk69IRlmnFVev2MdG/GiqkSb2De+inKWgwfk
	waX6B0MeJbA3hauuFVeFDw2lAwpsMzlG6jGR4qCbY62FMYGHINA3hL0Oh57E8IJHoWSLu39pWf0
	jCqm3Go5e2LgcIDYYvNcyiTIrVFi0Dta4qHlp1z0IwwjzX369E1ChFlYjyMlRLdcBRF8v5NjCcH
	oCiVR/q5w3r8JLWws5z+eAYFR++vc48p2AnsFMcVH0LsoP87N9RHEhxxf+kM200yNWPTq+7CbeT
	z5MYRMNIfjkz7+u/ItYtQmIQFodGuFD7OJbl5vt8abEfb94w5q6WuF3HnPL67lMUTN78CiJsDVk
	Pg9+oLyIPZSgVbkExLgudWS/4rLblk2WSZCEJYuYf0Tvy3hbkmJkEH7osM2lCvqKTtME6usxNGm
	s1H3FUNbfKRg==
X-Google-Smtp-Source: AGHT+IF+L/8DtFqvQEmvBjAnJLhDcKijbfYq7KDpw5oNA46EuTEQqeHPWKCbNq+YJQfVY3elkWIKSQ==
X-Received: by 2002:a05:600c:3b11:b0:477:6b4f:3fbd with SMTP id 5b1f17b1804b1-477870b935dmr27757175e9.38.1762960958765;
        Wed, 12 Nov 2025 07:22:38 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:38 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:17 +0000
Subject: [PATCH v4 11/13] coresight: Extend width of timestamp format
 attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-11-165ba21401dc@linaro.org>
References: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
In-Reply-To: <20251112-james-cs-syncfreq-v4-0-165ba21401dc@linaro.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 Mike Leach <mike.leach@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@arm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 James Clark <james.clark@linaro.org>
X-Mailer: b4 0.14.0

'timestamp' is currently 1 bit wide for on/off. To enable setting
different intervals in a later commit, extend it to 4 bits wide. Keep
the old bit position for backward compatibility but don't publish in the
format/ folder. It will be removed from the documentation and can be
removed completely after enough time has passed.

ETM3x doesn't support different intervals, so validate that the value is
either 0 or 1.

Tools that read the bit positions from the format/ folder will continue
to work as before, setting either 0 or 1 for off/on. Tools that
incorrectly didn't do this and set the ETM_OPT_TS bit directly will also
continue to work because that old bit is still checked.

This avoids adding a second timestamp attribute for setting the
interval. This would be awkward to use because tools would have to be
updated to ensure that the timestamps are always enabled when an
interval is set, and the driver would have to validate that both options
are provided together. All this does is implement the semantics of a
single enum but spread over multiple fields.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm-perf.h   | 13 ++++++++++---
 drivers/hwtracing/coresight/coresight-etm3x-core.c |  9 ++++++++-
 drivers/hwtracing/coresight/coresight-etm4x-core.c |  4 +++-
 3 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index c794087a0e99..24d929428633 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -23,6 +23,9 @@ struct cscfg_config_desc;
 #define ATTR_CFG_FLD_preset_CFG			config
 #define ATTR_CFG_FLD_preset_LO			0
 #define ATTR_CFG_FLD_preset_HI			3
+#define ATTR_CFG_FLD_timestamp_CFG		config
+#define ATTR_CFG_FLD_timestamp_LO		4
+#define ATTR_CFG_FLD_timestamp_HI		7
 #define ATTR_CFG_FLD_branch_broadcast_CFG	config
 #define ATTR_CFG_FLD_branch_broadcast_LO	8
 #define ATTR_CFG_FLD_branch_broadcast_HI	8
@@ -35,9 +38,13 @@ struct cscfg_config_desc;
 #define ATTR_CFG_FLD_contextid2_CFG		config
 #define ATTR_CFG_FLD_contextid2_LO		15
 #define ATTR_CFG_FLD_contextid2_HI		15
-#define ATTR_CFG_FLD_timestamp_CFG		config
-#define ATTR_CFG_FLD_timestamp_LO		28
-#define ATTR_CFG_FLD_timestamp_HI		28
+/*
+ * Old position of 'timestamp' and not published in sysfs. Remove at a later
+ * date if necessary.
+ */
+#define ATTR_CFG_FLD_deprecated_timestamp_CFG	config
+#define ATTR_CFG_FLD_deprecated_timestamp_LO	28
+#define ATTR_CFG_FLD_deprecated_timestamp_HI	28
 #define ATTR_CFG_FLD_retstack_CFG		config
 #define ATTR_CFG_FLD_retstack_LO		29
 #define ATTR_CFG_FLD_retstack_HI		29
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index 584d653eda81..d4c04e563bf6 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -338,9 +338,16 @@ static int etm_parse_event_config(struct etm_drvdata *drvdata,
 	if (ATTR_CFG_GET_FLD(attr, cycacc))
 		config->ctrl |= ETMCR_CYC_ACC;
 
-	if (ATTR_CFG_GET_FLD(attr, timestamp))
+	if (ATTR_CFG_GET_FLD(attr, deprecated_timestamp) ||
+	    ATTR_CFG_GET_FLD(attr, timestamp))
 		config->ctrl |= ETMCR_TIMESTAMP_EN;
 
+	if (ATTR_CFG_GET_FLD(attr, timestamp) > 1) {
+		dev_dbg(&drvdata->csdev->dev,
+			"timestamp format attribute should be 0 (off) or 1 (on)\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * Possible to have cores with PTM (supports ret stack) and ETM (never
 	 * has ret stack) on the same SoC. So only enable when it can be honored
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1aa0357a5ce7..d4e294cd48ae 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -28,6 +28,7 @@
 #include <linux/amba/bus.h>
 #include <linux/seq_file.h>
 #include <linux/uaccess.h>
+#include <linux/perf/arm_pmu.h>
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/platform_device.h>
@@ -800,7 +801,8 @@ static int etm4_parse_event_config(struct coresight_device *csdev,
 			cc_threshold = drvdata->ccitmin;
 		config->ccctlr = cc_threshold;
 	}
-	if (ATTR_CFG_GET_FLD(attr, timestamp)) {
+	if (ATTR_CFG_GET_FLD(attr, deprecated_timestamp) ||
+	    ATTR_CFG_GET_FLD(attr, timestamp)) {
 		/*
 		 * Configure timestamps to be emitted at regular intervals in
 		 * order to correlate instructions executed on different CPUs

-- 
2.34.1


