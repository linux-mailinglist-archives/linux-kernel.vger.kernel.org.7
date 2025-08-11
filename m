Return-Path: <linux-kernel+bounces-762233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E7B203CC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 11:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B619617ACCF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051F2DECCD;
	Mon, 11 Aug 2025 09:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WaPV97H/"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291D68248B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 09:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904769; cv=none; b=AwhRlC7Y2eUxTV/bVCNSgwO0+oPIvfsMmsaKCFup8tsaE6WCynjGn+MiZWE32WXo0rxb3HUY8xAVFt+Xi1UgN7GGoYmekCD+oLTyE7yCOkAxQtaf6hUxbh48jWMrxqSuReq2DOWDoJrY/+/82HZdBbnzWqpqPSZh8VsONo/cEMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904769; c=relaxed/simple;
	bh=U8TkMqWfDTBWjb8GRi9+VCChj3K0XOJrpYPU0RGTnw8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cECiy8kRK7dgnokArbjdXwEPDI6pKl7KLYujz+s7EogMN2KiY3GgXjwriaFA4AwFUoYFHPZ2GnZNNdTTIAGVI021LqUHD9yugyN0g4PDr/HDOKL8oLCuW0Hrd+MXYrICQ7jGsksJpib5zUsBt40raxF9tVa5KIgNFEnCdPE2JSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WaPV97H/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so2508392f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754904764; x=1755509564; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCFJWq6hVWDLLnb3WEoK3x2DCujP3OgS7K9EwJG0Zgk=;
        b=WaPV97H/1HVJobO0jHweb5V7XspdUpfj+yWdrWKqhrFT7c2jh40RueECwPR6ijJPgi
         iWlHxaqkpgsPsw1nnbhw4uWt+O5uy+RParOlQU8or98tTgd+qQ/Q6FFO9Aauygz5hdnl
         vO2iK1X8rH78rhbsbCI1xUPA8yD5aLK8qwek8ukiQAfaEHZei2NkwuQRPpddsgG8fRz4
         1nM0Vi3cgpSVRo7IxfqlMieyVsLzsxw+eYskWvgDW90Id3Ql9zNYcUH9I3WeJ87qNQV8
         /tePCpy2Az/lvt3laqPj45j3K5xPzUmNHVMZzLcRzECt/4pm6yrAgTraL7bzc1wIqC1D
         eEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754904764; x=1755509564;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UCFJWq6hVWDLLnb3WEoK3x2DCujP3OgS7K9EwJG0Zgk=;
        b=wjAlEu1JptwDhNjIjaTgLZi0TujGJrZG5sDpN0t7AqFvqFdF8ir44tFipgIaP4fzL2
         2qXU3c23rn73Soyx46KNbMjI03h1lEdehlwt2e1fPOqZ0TOJuxwDNCNkCNYYUSYLsCI4
         IChme4zr4OUO0NDoQtQkrznYHkMPqKiTyf+Gt6h+yAAIYzhpBhJfgv0RAR+FUavc0R3T
         YWeYCPeH+RB+iJnuoXUgB4xhuS79tXHV4kJijCyZbGFdCYaVeGdKL8p4FHusOHl0mY8B
         gB2HlhmOvPf+Yy1WMPqcvF/j6HvogDVozX3Sm92Es2raAhtHfXzGYm9Ban9hpv9pwv0b
         exKg==
X-Forwarded-Encrypted: i=1; AJvYcCV0BAPMyUNhpWhsuWJnkopaexAarikP87J50fUPJHNA+vGvFblUN71YZUiH0zjrdkKsrBu67H6r4ry1pKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU+jFQ7gSE/84+8thY7rhqiOuVYHI1RRewk74l7y/YUd2noe7A
	SVctaughvrfQZXdcxa2gPSr7BiPtHGRq1T6880Fslmj/G7zrGiEvvnxyWfMaEI89ObUTYQdLUCd
	XL7SPaZA=
X-Gm-Gg: ASbGncuzGJgyj+pF7k3yzLKiUvoFFQf36ay0B3hpH5WvS+yyFVFbK3HR575ALOX3F4r
	toBPhzE+fgsLwCPYnlN1F3yP/YUy914BerX/cbtl6TwzGmxTQjGSyD2415FD4IZkjWA6bXGCX8m
	u2PE7pUt65e+5Nx3FGEvjRy+87GICoQ+XIUajV7938tREVuaPm/0ywDNPeI3hGGfwv2ncPBrQHg
	5zfYmgh4D6RBUp85VEqjuLCqM5URBamFrAHyvU/NnZYO7WadlfW3cBoZAyNxfdc7LwPY5NWH7Oc
	J/4XSOMqJlvrErAavhr0a1C3CfjDOThQQtiv/AX/3Aujtfan8AiM1+SS8Xlq8anqCiOloyB3+Pw
	juA8ZLdXeXD8aYDscPBj5ZjWHscogSJA=
X-Google-Smtp-Source: AGHT+IGwXBJru7lzSvqSg6s6aOA3Q/MWqjAM+gI5z5Pyj6soY54J04BAuUaaiohr/CZ2BO2EaR5SGw==
X-Received: by 2002:a05:6000:430e:b0:3b8:d12f:67ef with SMTP id ffacd0b85a97d-3b900b5060fmr9681173f8f.31.1754904764235;
        Mon, 11 Aug 2025 02:32:44 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c45346asm39904799f8f.39.2025.08.11.02.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 02:32:43 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Mon, 11 Aug 2025 10:32:09 +0100
Subject: [PATCH 4/6] coresight: Refactor etm4_config_timestamp_event()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-james-cs-syncfreq-v1-4-b001cd6e3404@linaro.org>
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


