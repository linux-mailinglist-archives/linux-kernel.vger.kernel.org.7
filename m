Return-Path: <linux-kernel+bounces-768628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E78FFB26356
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 12:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 183E17A62A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60E12FE059;
	Thu, 14 Aug 2025 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JpxeUPRT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA1028C009
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 10:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755168687; cv=none; b=nIAWMm1ubrprcY2iiVtB9nvhi0KdAakUqGIoBuht1h9JJ0nZbBZZ7OTtf1H7OeRklnuU1kFnS0AN04UdfNzUH7ooZkFsG70Ohx+vDAnereHLf6oxkNdIE7pmOvuQUI40N2DWajPtRGWZCzcwkAk0J1rvDTZVFx8r9KSSeTXKSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755168687; c=relaxed/simple;
	bh=U8TkMqWfDTBWjb8GRi9+VCChj3K0XOJrpYPU0RGTnw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6LlWu0r0DrY6eWH6qYlw+/qYrTPchqvnp1Mw1xD/4tbPIp0CDE9GxuOX/xQROQ/rFlB8Zb4ZcvhFNk9afcNIrtiNN/D6zkhjCslQQ61MPQIl2cVCP8l+UmohX5mfSry3f49lmtd8j/bL82TifOVqtqWkn+9hV8s9pbAHMMfBVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JpxeUPRT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b281d25so3005195e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755168684; x=1755773484; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCFJWq6hVWDLLnb3WEoK3x2DCujP3OgS7K9EwJG0Zgk=;
        b=JpxeUPRTUfJ0LWzhgQk/956rzEbCvFWFjIRJrrzAQapiaZ/xqyTfoihurrx9da3jN0
         Fis4fVleLxt9QZSszHkDedAxRluq06JlCJ3P7HizZkpbwshdpiKq4fJTrCpZV0tpMaB3
         kK475ZrxF6Bg9lfys/fXQY7bb59//rnx5KIIf5IsZtz81/yFCfVX/Tkc84ns8OHgz4aY
         imIcXkuEqje8bLKWnUKUOBYW2a3PdB75uIjf1ae8Fm35lgkWna3dWC0IQDt7RB3EuY/W
         p8+exz0tdEPZJcvcyhZlWOf3Q28/abEefiAUwmTF7+KKcyeOgLNe7sZp3bJCRP+Jgqqg
         N8zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755168684; x=1755773484;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCFJWq6hVWDLLnb3WEoK3x2DCujP3OgS7K9EwJG0Zgk=;
        b=pvQDQkuUepTl1Yxfqj39jGuqnkEFWkf3Rzc8bD1H/iyeyiEYhB7Dj9jJMgYJ2pYvn7
         /mJ9kC+CeXz7NSGuT3gYwRWqRmckFCDFDcJvo2N0eCEFvtDTrz/EV95kgdpsJej/WGJs
         3LamctZj0BUlbgFuqNgixHdmsMWP1qp5GNSfY2SN24qWZqN2CbzLvL9apCtuwghUhOKh
         SGbNi3rcqG2Rcc1uGnSS528hGW5f8xHPxwVby2ICVtPdH0G5qTSCfjacg5JSUim9+3vJ
         joVrLlA6OHsnZ0CnRhu9ewS/xxYI3t/c0T4y5nGggjDNQq2JiMdZjQ5Pt0hnpXJOZJVR
         Yzrw==
X-Forwarded-Encrypted: i=1; AJvYcCXFUldyZ/ZvNphYZdmzTotoeLLXeA2yjPSazYUENsn7YXK6i/03D1mVR8NLEueIhPt16qvL5ezLScr1QsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPUKvnkvhQY1Y59Lk1qsyYrHQJtSPFnW2P6B3RFGL1nWehGgXF
	JV2Mr/SxRGWiF7xjJhZBifkHSA7k22X+k62Cq+fG7tjFWJLBUrZ1b0DCkqMW3iB3kYE=
X-Gm-Gg: ASbGnctJNGfEe26nn44+ZGRzQS0I3FtabAExh061lHnuMmkH/R4NP2Sz9kCQAjyDNAy
	uvmGmJD8t9ww0dEFSs0S9ikKMt1mklrU1h4ewNsPGwl3VlsgjPFPe9nEX9hSNRPzUE2LlbS0+Ov
	sBP/iPzbV4ToiOhlpargyjV0mVZMPPoobTJQt5WyXpODpbL1p+J1J7a9I/v6ur7PnRJEBrmA8Fz
	8UEGFzLuZC/ePqi57sXhsMuNzRzh+T0vzNGe0Xij8ejdyoZkWAnfph1ec2tNweEOCQnKEtNqf3R
	PJ2zR8g+bTWog2JF9GQay23Mg9wyifSI8lOLYA+giDXu8DgU73EcIqmOzgZ9SJ25yr2ruj5smw7
	XnmJEXxo0W0sr+sP1SMDtOeurEzjOzdo=
X-Google-Smtp-Source: AGHT+IH7V3UbaGrUJe9fOSW+9cf1k9RfdPPJpO57OeoAxEN+FtVoytlc5UFLEqj9CTFJZLY7Ywq0nw==
X-Received: by 2002:a05:600c:1ca7:b0:456:285b:db24 with SMTP id 5b1f17b1804b1-45a1f8e2320mr1517955e9.28.1755168683865;
        Thu, 14 Aug 2025 03:51:23 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm14228345e9.1.2025.08.14.03.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 03:51:23 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 11:49:55 +0100
Subject: [PATCH v2 4/6] coresight: Refactor etm4_config_timestamp_event()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-cs-syncfreq-v2-4-c76fcb87696d@linaro.org>
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

Remove some of the magic numbers and try to clarify some of the
documentation so it's clearer how this sets up the timestamp interval.

Return errors directly instead of jumping to out and returning ret,
nothing needs to be cleaned up at the end and it only obscures the flow
and return value.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 95 ++++++++++++++--------
 drivers/hwtracing/coresight/coresight-etm4x.h      | 20 +++--
 2 files changed, 77 insertions(+), 38 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index cbea200489c8..1a2d02bdcb88 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -608,18 +608,33 @@ static void etm4_enable_hw_smp_call(void *info)
  * TRCRSCTLR1 (always true) used to get the counter to decrement.  From
  * there a resource selector is configured with the counter and the
  * timestamp control register to use the resource selector to trigger the
- * event that will insert a timestamp packet in the stream.
+ * event that will insert a timestamp packet in the stream:
+ *
+ *  +--------------+
+ *  | Resource 1   |   fixed "always-true" resource
+ *  +--------------+
+ *         |
+ *  +------v-------+
+ *  | Counter x    |   (reload to 1 on underflow)
+ *  +--------------+
+ *         |
+ *  +------v--------------+
+ *  | Resource Selector y |   (trigger on counter x == 0)
+ *  +---------------------+
+ *         |
+ *  +------v---------------+
+ *  | Timestamp Generator  |  (timestamp on resource y)
+ *  +----------------------+
  */
 static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
 {
-	int ctridx, ret = -EINVAL;
-	int counter, rselector;
-	u32 val = 0;
+	int ctridx;
+	int rselector;
 	struct etmv4_config *config = &drvdata->config;
 
 	/* No point in trying if we don't have at least one counter */
 	if (!drvdata->nr_cntr)
-		goto out;
+		return -EINVAL;
 
 	/* Find a counter that hasn't been initialised */
 	for (ctridx = 0; ctridx < drvdata->nr_cntr; ctridx++)
@@ -629,15 +644,17 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
 	/* All the counters have been configured already, bail out */
 	if (ctridx == drvdata->nr_cntr) {
 		pr_debug("%s: no available counter found\n", __func__);
-		ret = -ENOSPC;
-		goto out;
+		return -ENOSPC;
 	}
 
 	/*
-	 * Searching for an available resource selector to use, starting at
-	 * '2' since every implementation has at least 2 resource selector.
-	 * ETMIDR4 gives the number of resource selector _pairs_,
-	 * hence multiply by 2.
+	 * Searching for an available resource selector to use, starting at '2'
+	 * since resource 0 is the fixed 'always returns false' resource and 1
+	 * is the fixed 'always returns true' resource. See IHI0064H_b '7.3.64
+	 * TRCRSCTLRn, Resource Selection Control Registers, n=2-31'.
+	 *
+	 * ETMIDR4 gives the number of resource selector _pairs_, hence multiply
+	 * by 2.
 	 */
 	for (rselector = 2; rselector < drvdata->nr_resource * 2; rselector++)
 		if (!config->res_ctrl[rselector])
@@ -646,13 +663,9 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
 	if (rselector == drvdata->nr_resource * 2) {
 		pr_debug("%s: no available resource selector found\n",
 			 __func__);
-		ret = -ENOSPC;
-		goto out;
+		return -ENOSPC;
 	}
 
-	/* Remember what counter we used */
-	counter = 1 << ctridx;
-
 	/*
 	 * Initialise original and reload counter value to the smallest
 	 * possible value in order to get as much precision as we can.
@@ -660,26 +673,42 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
 	config->cntr_val[ctridx] = 1;
 	config->cntrldvr[ctridx] = 1;
 
-	/* Set the trace counter control register */
-	val =  0x1 << 16	|  /* Bit 16, reload counter automatically */
-	       0x0 << 7		|  /* Select single resource selector */
-	       0x1;		   /* Resource selector 1, i.e always true */
-
-	config->cntr_ctrl[ctridx] = val;
-
-	val = 0x2 << 16		| /* Group 0b0010 - Counter and sequencers */
-	      counter << 0;	  /* Counter to use */
-
-	config->res_ctrl[rselector] = val;
+	/*
+	 * Trace Counter Control Register TRCCNTCTLRn
+	 *
+	 * CNTCHAIN = 0, don't reload on the previous counter
+	 * RLDSELF = true, reload counter automatically on underflow
+	 * RLDTYPE = 0, one reload input resource
+	 * RLDSEL = 0, reload on resource 0 (fixed always false resource, never
+	 *	       reload)
+	 * CNTTYPE = 0, one count input resource
+	 * CNTSEL = 1, count on resource 1 (fixed always true resource, always
+	 *	       decrement)
+	 */
+	config->cntr_ctrl[ctridx] = TRCCNTCTLRn_RLDSELF |
+				    FIELD_PREP(TRCCNTCTLRn_CNTSEL_MASK, 1);
 
-	val = 0x0 << 7		| /* Select single resource selector */
-	      rselector;	  /* Resource selector */
+	/*
+	 * Resource Selection Control Register TRCRSCTLRn
+	 *
+	 * PAIRINV = 0, INV = 0, don't invert
+	 * GROUP = 2, SELECT = ctridx, trigger when counter 'ctridx' reaches 0
+	 *
+	 * Multiple counters can be selected, and each bit signifies a counter,
+	 * so set bit 'ctridx' to select our counter.
+	 */
+	config->res_ctrl[rselector] = FIELD_PREP(TRCRSCTLRn_GROUP_MASK, 2) |
+				      FIELD_PREP(TRCRSCTLRn_SELECT_MASK, 1 << ctridx);
 
-	config->ts_ctrl = val;
+	/*
+	 * Global Timestamp Control Register TRCTSCTLR
+	 *
+	 * TYPE = 0, one input resource
+	 * SEL = rselector, generate timestamp on resource 'rselector'
+	 */
+	config->ts_ctrl = FIELD_PREP(TRCTSCTLR_SEL_MASK, rselector);
 
-	ret = 0;
-out:
-	return ret;
+	return 0;
 }
 
 static int etm4_parse_event_config(struct coresight_device *csdev,
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index 1c67b263b01b..aaa6633b2d67 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -224,6 +224,16 @@
 #define TRCRSCTLRn_GROUP_MASK			GENMASK(19, 16)
 #define TRCRSCTLRn_SELECT_MASK			GENMASK(15, 0)
 
+#define TRCCNTCTLRn_CNTCHAIN			BIT(17)
+#define TRCCNTCTLRn_RLDSELF			BIT(16)
+#define TRCCNTCTLRn_RLDTYPE			BIT(15)
+#define TRCCNTCTLRn_RLDSEL_MASK			GENMASK(12, 8)
+#define TRCCNTCTLRn_CNTTYPE_MASK		BIT(7)
+#define TRCCNTCTLRn_CNTSEL_MASK			GENMASK(4, 0)
+
+#define TRCTSCTLR_TYPE				BIT(7)
+#define TRCTSCTLR_SEL_MASK			GENMASK(4, 0)
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -823,7 +833,7 @@ struct etmv4_config {
 	u32				eventctrl0;
 	u32				eventctrl1;
 	u32				stall_ctrl;
-	u32				ts_ctrl;
+	u32				ts_ctrl; /* TRCTSCTLR */
 	u32				ccctlr;
 	u32				bb_ctrl;
 	u32				vinst_ctrl;
@@ -843,11 +853,11 @@ struct etmv4_config {
 	u32				seq_rst;
 	u32				seq_state;
 
-	u32				cntrldvr[ETMv4_MAX_CNTR];
-	u32				cntr_ctrl[ETMv4_MAX_CNTR];
-	u32				cntr_val[ETMv4_MAX_CNTR];
+	u32				cntrldvr[ETMv4_MAX_CNTR]; /* TRCCNTRLDVRn */
+	u32				cntr_ctrl[ETMv4_MAX_CNTR]; /* TRCCNTCTLRn */
+	u32				cntr_val[ETMv4_MAX_CNTR]; /* TRCCNTVRn */
 
-	u32				res_ctrl[ETM_MAX_RES_SEL];
+	u32				res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
 
 	u32				ss_ctrl[ETM_MAX_SS_CMP];
 	u32				ss_status[ETM_MAX_SS_CMP];

-- 
2.34.1


