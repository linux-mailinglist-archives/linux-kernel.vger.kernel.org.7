Return-Path: <linux-kernel+bounces-897543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4B5C530EE
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3A1135385A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A4333BBA5;
	Wed, 12 Nov 2025 15:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AighG2nT"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF872BEC31
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762960955; cv=none; b=lxUCU0I9+25/a9uW3WkGpqDnfm46AiOheNETkxGfGqN4MsgzTXHcENZiwsM7QD1O2GJ7SRpV6PdxDOg5/pX8dU74cpO1PCaR7WpPXpMi6MzPb8DOCCzcZiZukQCpH7tMDlfFlQMLbnhNoTL661N1mguQHsdJ0OorJ/FQYyeh6Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762960955; c=relaxed/simple;
	bh=S/F+Q8EHvKO9iseD/uYd6QcoJRU9qpbbRgMtnDRy1DQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sOdibg0Q3RUne7qnGLQJLiKubx99jZdEuq0/2e0H7SAqqRuGaIzOOkKaK1aMvPVF/6HuywCehnAo1ENn6yem+e/PeECcpNHPMXymPVfggd9pzsah0Sjnv9D33EU7VJBuGJgWbGwyMcypB2ZdIAwmIm0aE0a9bAN5a5u0hqWu/O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AighG2nT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47118259fd8so7084215e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:22:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762960952; x=1763565752; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2uusonc4IVmEmKIwyNSABzF5dmeq8W3J1RDTb9RhE1k=;
        b=AighG2nTC4EFpU//Fi0suUurF2WWtNHHGL+cwg93mgZTBUfMSZDs39Y11rItRd7Mn/
         WBtOm2CV1ryWyv/vRxJh62sXTi5w+itBsFPr+qww/WGTFdIfNNl8Ht1f/x+aQ+CKZM/C
         RpnfXz+ti92wLao8f1mmaxEf4Qm58iSxrcRjA3ipFC6rFdBgIVkkjqxdEt+0qURSR7Sg
         UFIRX8wahEBt+Hhrv4QdyyDb4d9sTpol71KTOMhI3MM0tq/ZzLEjMl44waP2aMl0/NHg
         UsSNbS3zYaS1S9sCvKcGAwx6MgrQXogSWAUltLn0q/QXSHzPOORXH0tL92mKZC9eCeeo
         KXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762960952; x=1763565752;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2uusonc4IVmEmKIwyNSABzF5dmeq8W3J1RDTb9RhE1k=;
        b=LEPK+KQD5/XSV9a+0E4kRxsr352OhEm0EeTU14fAA2UeWocEtmiGAdu7tiyOSgY9ZE
         aakwc5uDeyoS/rkHBEIEH6hsLKlI6N4WA6Y8B0zcOIXt8QRkGoB31zPSFYSfkRbEc2DJ
         45kMJSDmPRGqZIPUr4l1N9boJAtIix3R20gpurgw6WexAUVqxTVupZsxUkDqmSURgX98
         QCbylAwfYRlQOM7GrVb4Yn/d1U5vMiadHWW+ybaUKP0s5spvCL07xAmU+Sp3ccffP1vp
         xGJdbX6L5Pb4OgmDelI5hlZaYcVBU/YPMeqNebTjROMq4REiHKWAZtXTvudUmvhTTmIg
         20MA==
X-Forwarded-Encrypted: i=1; AJvYcCWjPl638qV7XyLu5mLwzVI7rpBtau9UtQ0TUCGm3VCJ+ckZwYBDdlP866d5FLNx14fyPFdeSe+2CqqKwl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMLZN79OwzBCIfFm0x3qQY04OexrfG93SUO2ljVJna0iQsdfZ
	z8ZKSK8swyXXVsQZNpsLjBB68J+Utc/5n4ANBCW7YH9kyKsDbqsQv0z/Ox5qdpDrPbuNaCN+aBF
	DvcBEeiE=
X-Gm-Gg: ASbGnctSdhv4uKLm1WmBXilSfyQMqI3RBndVLTsd7oirM1tXXB3tAoh8E0JoQ/THcc+
	usqQdsReMJI6kGg8gaVmRBR0G7YpB656tQuiq721NmqP50JgvUg6YTTjvYQhaSV57Iufqp3+YGb
	YYJi+lnIym31REq9bZd21x2VgNa/l4TaWT0MO8D6epRFo0bVzNphN1xm5LO7PtyoL0MjH+OAp4k
	gQaX4/v+0V6gFMzktz4fQxfFe0/ioN5p0HRHXNDzGCVmSHsnRNLWPJzPxCG8HPLXReZNBR0A5pd
	ZQiO2iB0pZTuUtVdqCNzfARIxIV/tmRVFrbXtgMsJ21MT1dgFyImLTWZEAt5n5ipfJm4jqZ2agU
	LddhaquQHfVUelc2tVT8zJDPCZnUXCon5HFfQuGYylSpfoSn2WBTfI1kWqlyGZVeTdcBiwV2cgw
	MiYhKfMurtIg==
X-Google-Smtp-Source: AGHT+IE9sB9s/FnD51s9bvHKIuSCDAZDLn+Lwu16yVjVYz52tbr9N0U5pqNtEoKseunsJWxOI0/4tA==
X-Received: by 2002:a05:600c:a43:b0:477:73cc:82c2 with SMTP id 5b1f17b1804b1-4778707ba5bmr33877885e9.9.1762960951695;
        Wed, 12 Nov 2025 07:22:31 -0800 (PST)
Received: from ho-tower-lan.lan ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac677ab75sm33573485f8f.35.2025.11.12.07.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:22:31 -0800 (PST)
From: James Clark <james.clark@linaro.org>
Date: Wed, 12 Nov 2025 15:22:09 +0000
Subject: [PATCH v4 03/13] coresight: Refactor etm4_config_timestamp_event()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-james-cs-syncfreq-v4-3-165ba21401dc@linaro.org>
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

Remove some of the magic numbers and try to clarify some of the
documentation so it's clearer how this sets up the timestamp interval.

Return errors directly instead of jumping to out and returning ret,
nothing needs to be cleaned up at the end and it only obscures the flow
and return value.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c | 96 ++++++++++++++--------
 drivers/hwtracing/coresight/coresight-etm4x.h      | 23 ++++--
 2 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 1c17d5472920..380a7840adb8 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -651,18 +651,33 @@ static void etm4_enable_sysfs_smp_call(void *info)
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
@@ -672,15 +687,19 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
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
+	 * TRCRSCTLRn, Resource Selection Control Registers, n=2-31'. If there
+	 * are no resources, there would also be no counters so wouldn't get
+	 * here.
+	 *
+	 * ETMIDR4 gives the number of resource selector _pairs_, hence multiply
+	 * by 2.
 	 */
 	for (rselector = 2; rselector < drvdata->nr_resource * 2; rselector++)
 		if (!config->res_ctrl[rselector])
@@ -689,13 +708,9 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
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
@@ -703,26 +718,41 @@ static int etm4_config_timestamp_event(struct etmv4_drvdata *drvdata)
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
+	 * RLDSEL = RES_SEL_FALSE (0), reload on false resource (never reload)
+	 * CNTTYPE = 0, one count input resource
+	 * CNTSEL = RES_SEL_TRUE (1), count fixed 'always true' resource (always decrement)
+	 */
+	config->cntr_ctrl[ctridx] = TRCCNTCTLRn_RLDSELF |
+				    FIELD_PREP(TRCCNTCTLRn_RLDSEL_MASK, ETM_RES_SEL_FALSE) |
+				    FIELD_PREP(TRCCNTCTLRn_CNTSEL_MASK, ETM_RES_SEL_TRUE);
 
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
index 8f546764908c..0f83a29320e6 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -225,6 +225,19 @@
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
+#define ETM_RES_SEL_FALSE 0 /* Fixed function 'always false' resource selector */
+#define ETM_RES_SEL_TRUE  1 /* Fixed function 'always true' resource selector */
+
 /*
  * System instructions to access ETM registers.
  * See ETMv4.4 spec ARM IHI0064F section 4.3.6 System instructions
@@ -825,7 +838,7 @@ struct etmv4_config {
 	u32				eventctrl0;
 	u32				eventctrl1;
 	u32				stall_ctrl;
-	u32				ts_ctrl;
+	u32				ts_ctrl; /* TRCTSCTLR */
 	u32				ccctlr;
 	u32				bb_ctrl;
 	u32				vinst_ctrl;
@@ -838,11 +851,11 @@ struct etmv4_config {
 	u32				seq_rst;
 	u32				seq_state;
 	u8				cntr_idx;
-	u32				cntrldvr[ETMv4_MAX_CNTR];
-	u32				cntr_ctrl[ETMv4_MAX_CNTR];
-	u32				cntr_val[ETMv4_MAX_CNTR];
+	u32				cntrldvr[ETMv4_MAX_CNTR]; /* TRCCNTRLDVRn */
+	u32				cntr_ctrl[ETMv4_MAX_CNTR];  /* TRCCNTCTLRn */
+	u32				cntr_val[ETMv4_MAX_CNTR]; /* TRCCNTVRn */
 	u8				res_idx;
-	u32				res_ctrl[ETM_MAX_RES_SEL];
+	u32				res_ctrl[ETM_MAX_RES_SEL]; /* TRCRSCTLRn */
 	u8				ss_idx;
 	u32				ss_ctrl[ETM_MAX_SS_CMP];
 	u32				ss_status[ETM_MAX_SS_CMP];

-- 
2.34.1


