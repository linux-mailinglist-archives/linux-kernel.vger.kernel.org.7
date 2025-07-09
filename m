Return-Path: <linux-kernel+bounces-724181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC84AFEFAB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D211C465ED
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6BF21FF4A;
	Wed,  9 Jul 2025 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+BsnMtQ"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6593156F4A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081474; cv=none; b=hhqj6VnHsckwO7ln4kV8jdH0cAI9T0/odUe1UASSMpN6v5ooV3Gkr9iGDyRJQR3Y7V8Bc22lRwZKe52hJdOAFwXfH7mZi39voO9ufMZK60VZhqhUI7Myvj7L/1qAxveCCH30gV9Ngy/m6Pf3YZp/WW/QEQGRHa9GV7bTwD64sLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081474; c=relaxed/simple;
	bh=NIwd8JXiZGCIjVz4GS0TO5O9H9rx71zZY6S8K73Nl0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=in6yXR6zcfhM62xTPZOa5L8VVXcLMM9NnlhRoIes/Hb0WwQTlip3T7JLCb9J0TYs1y5FI30l4pvfzBWE++uQqVGetu6wpyndlft6XY+NI5S1A7VdwosefmpPfJLIt9URP+Gp6+znicV9/NXGzj51LPME1Y/8WUIDtOqOLkIgNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+BsnMtQ; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7d2107eb668so17080685a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 10:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752081471; x=1752686271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aHdX3CSfue/m3/kt/dPbNz+FIQl6EVMspXvXyxqMLdA=;
        b=Z+BsnMtQc3J/QOku2Z7rygX5FjhKpWCH/fYi7bgv7XKvFyqUQ5zSOSgoXAKniABTiL
         VF1GeI+sDn8Ma8GYSfqQB6YAMkPUA9eUR0NcK01qjHNh2LkpIlAI/IO9rptwjocumwTJ
         M3aqCbeiL5zBreSyuksWqInyjU3E+T7A9LVOUm74bwFe6YPJfY8JuzcHvVYBaG8RXEEW
         /+SlI+Dxb0hxqj7MmUd4STCoFSaVT9/uwpPDaVjXe5rG0UtFQlD2fd7hZ7ko0MKnFT/y
         5EB9akY1No19RALlk72Jw98fwU1hhfttmoWdcYaRnxHaybVU1gA+ty9DiMW5J3YMICIU
         KtqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752081471; x=1752686271;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aHdX3CSfue/m3/kt/dPbNz+FIQl6EVMspXvXyxqMLdA=;
        b=gwBXnLLRcTsliRC7L0S+ykUIQOEcfD3K6R96P1KXr+YK5mXtm7PP7667DOJFll65EP
         q76sfle4qlib3SEtd0A7qyzLGPoS9tkXrLncLUUZW6gCkCbEHXl0inanMfmTdLOoa+Tm
         aQXVvhDHUPqq+AfWxY/+utJZvUjSsqcDyverTZezKZ3oKtjNhma2jWf5SVzk4CCZoyGi
         sUc2Rm4JjN1Yk4o3Qy6+SpGcjrncUnglf8GnzV0tT6iMikU6Q5+HLzPstrApXaNphGnr
         LtUpBKBEcepfg04DZzipBcVte4Zhae2ihWkDDVLAB8AZsD7fWZDNd+wMgnyK0BXTDz4v
         wJoA==
X-Forwarded-Encrypted: i=1; AJvYcCVaTxQr7fEi2WdvE3X8UCiw3+jPu2/vHyV7sQdgIHM6KmX2m2npNqyS/TM2eLmm+ifz7tjfuYT3yc78oEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwicZxgFikTxvzm0ky8crJqFuu94G9KuSfLQeZLW01ziGUC9Wqg
	7YkxWxn3brNAPiIS/x8VkZl1gaqhXKZPe8It10WyQr4UxiDhgdpcd7mQ
X-Gm-Gg: ASbGncsODAe1A92HSSTityAU0m6zhsiGadJAyDvoyvs6rDB4mPD0mAmcIe9T40opDif
	UnYUAuoc2uR2oTcR49uBOoIBmLiqU1ZYTvZn3vDkCbxBaE/wZ81+3y8UQGySN/HTVcZ75dcewJa
	xEY1R4gW/2ULOFCTWzQqx0d7Yw2Pcf7Tvzo1y2byVG+CXjupTWP8jDbmUmqRku4elntKDBTGyoI
	IVwjbXKdM3IEKnfU5E7cb22Uaq7S+INlCkC090kb9ma/jQrKfLs1cl9lxp1XB9qm/qmctVi+htt
	awP/nYs+ntzHaDh0wk9gPr1UjLdObuKwUJ2o40DoI0giaj8qF9Amv0hOAJJ/nlRF5ZjCWXgX2fH
	utIJuWjid9OZ7IelZWFnRcg1slQ==
X-Google-Smtp-Source: AGHT+IFyo9Srr/PXWJqOwCu+w7JjiunHszi5Ked3rjKmNIKWjnrm7o66h8G3fWaB8PXaJR9/0zFBhQ==
X-Received: by 2002:a05:620a:318f:b0:7d4:5361:bb7e with SMTP id af79cd13be357-7dc999b2d07mr45969085a.8.1752081470416;
        Wed, 09 Jul 2025 10:17:50 -0700 (PDT)
Received: from fyre-x-redhat96-nsd-1.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbdb0aebsm971824085a.33.2025.07.09.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 10:17:49 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com
Cc: mike.leach@linaro.org,
	james.clark@linaro.org,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v3] coresight: Replace scnprintf() with sysfs_emit() in sysfs show functions
Date: Wed,  9 Jul 2025 10:17:30 -0700
Message-ID: <20250709171730.14786-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/filesystems/sysfs.rst mentions that show() should only
use sysfs_emit() or sysfs_emit_at() when formating the value to be
returned to user space. So replace scnprintf() with sysfs_emit().

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Reviewed-by: James Clark <james.clark@linaro.org>
---
Changes in v3:
 - fixed warnings from checkpatch.pl

 .../hwtracing/coresight/coresight-etm-perf.c  |   4 +-
 .../coresight/coresight-etm3x-sysfs.c         |   2 +-
 .../coresight/coresight-etm4x-sysfs.c         | 118 +++++++++---------
 drivers/hwtracing/coresight/coresight-stm.c   |   8 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   4 +-
 5 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f1551c08ecb2..8cfdcbc2f8f6 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -851,7 +851,7 @@ static ssize_t etm_perf_sink_name_show(struct device *dev,
 	struct dev_ext_attribute *ea;
 
 	ea = container_of(dattr, struct dev_ext_attribute, attr);
-	return scnprintf(buf, PAGE_SIZE, "0x%lx\n", (unsigned long)(ea->var));
+	return sysfs_emit(buf, "0x%lx\n", (unsigned long)(ea->var));
 }
 
 static struct dev_ext_attribute *
@@ -943,7 +943,7 @@ static ssize_t etm_perf_cscfg_event_show(struct device *dev,
 	struct dev_ext_attribute *ea;
 
 	ea = container_of(dattr, struct dev_ext_attribute, attr);
-	return scnprintf(buf, PAGE_SIZE, "configid=0x%lx\n", (unsigned long)(ea->var));
+	return sysfs_emit(buf, "configid=0x%lx\n", (unsigned long)(ea->var));
 }
 
 int etm_perf_add_symlink_cscfg(struct device *dev, struct cscfg_config_desc *config_desc)
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 762109307b86..4868eb05a312 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -1182,7 +1182,7 @@ static ssize_t cpu_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->cpu;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 
 }
 static DEVICE_ATTR_RO(cpu);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index ab251865b893..4ddc0d344b61 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -63,7 +63,7 @@ static ssize_t nr_pe_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_pe_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_pe_cmp);
 
@@ -75,7 +75,7 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_addr_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_addr_cmp);
 
@@ -87,7 +87,7 @@ static ssize_t nr_cntr_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_cntr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_cntr);
 
@@ -99,7 +99,7 @@ static ssize_t nr_ext_inp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_ext_inp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ext_inp);
 
@@ -111,7 +111,7 @@ static ssize_t numcidc_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->numcidc;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numcidc);
 
@@ -123,7 +123,7 @@ static ssize_t numvmidc_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->numvmidc;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numvmidc);
 
@@ -135,7 +135,7 @@ static ssize_t nrseqstate_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nrseqstate;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nrseqstate);
 
@@ -147,7 +147,7 @@ static ssize_t nr_resource_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_resource;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_resource);
 
@@ -159,7 +159,7 @@ static ssize_t nr_ss_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_ss_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ss_cmp);
 
@@ -287,7 +287,7 @@ static ssize_t mode_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->mode;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t mode_store(struct device *dev,
@@ -453,7 +453,7 @@ static ssize_t pe_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->pe_sel;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t pe_store(struct device *dev,
@@ -488,7 +488,7 @@ static ssize_t event_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->eventctrl0;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_store(struct device *dev,
@@ -537,7 +537,7 @@ static ssize_t event_instren_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = FIELD_GET(TRCEVENTCTL1R_INSTEN_MASK, config->eventctrl1);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_instren_store(struct device *dev,
@@ -593,7 +593,7 @@ static ssize_t event_ts_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ts_ctrl;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_ts_store(struct device *dev,
@@ -623,7 +623,7 @@ static ssize_t syncfreq_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->syncfreq;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t syncfreq_store(struct device *dev,
@@ -653,7 +653,7 @@ static ssize_t cyc_threshold_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ccctlr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cyc_threshold_store(struct device *dev,
@@ -686,7 +686,7 @@ static ssize_t bb_ctrl_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->bb_ctrl;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t bb_ctrl_store(struct device *dev,
@@ -726,7 +726,7 @@ static ssize_t event_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = FIELD_GET(TRCVICTLR_EVENT_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_vinst_store(struct device *dev,
@@ -758,7 +758,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = FIELD_GET(TRCVICTLR_EXLEVEL_S_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t s_exlevel_vinst_store(struct device *dev,
@@ -793,7 +793,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 
 	/* EXLEVEL_NS, bits[23:20] */
 	val = FIELD_GET(TRCVICTLR_EXLEVEL_NS_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ns_exlevel_vinst_store(struct device *dev,
@@ -827,7 +827,7 @@ static ssize_t addr_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->addr_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_idx_store(struct device *dev,
@@ -866,11 +866,11 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n",
-			val == TRCACATRn_TYPE_ADDR ? "instr" :
-			(val == TRCACATRn_TYPE_DATA_LOAD_ADDR ? "data_load" :
-			(val == TRCACATRn_TYPE_DATA_STORE_ADDR ? "data_store" :
-			"data_load_store")));
+	len = sysfs_emit(buf, "%s\n",
+			 val == TRCACATRn_TYPE_ADDR ? "instr" :
+			 (val == TRCACATRn_TYPE_DATA_LOAD_ADDR ? "data_load" :
+			 (val == TRCACATRn_TYPE_DATA_STORE_ADDR ? "data_store" :
+			 "data_load_store")));
 	raw_spin_unlock(&drvdata->spinlock);
 	return len;
 }
@@ -918,7 +918,7 @@ static ssize_t addr_single_show(struct device *dev,
 	}
 	val = (unsigned long)config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_single_store(struct device *dev,
@@ -974,7 +974,7 @@ static ssize_t addr_range_show(struct device *dev,
 	val1 = (unsigned long)config->addr_val[idx];
 	val2 = (unsigned long)config->addr_val[idx + 1];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t addr_range_store(struct device *dev,
@@ -1049,7 +1049,7 @@ static ssize_t addr_start_show(struct device *dev,
 
 	val = (unsigned long)config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_start_store(struct device *dev,
@@ -1104,7 +1104,7 @@ static ssize_t addr_stop_show(struct device *dev,
 
 	val = (unsigned long)config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_stop_store(struct device *dev,
@@ -1152,7 +1152,7 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	idx = config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
 	val = FIELD_GET(TRCACATRn_CONTEXTTYPE_MASK, config->addr_acc[idx]);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
+	len = sysfs_emit(buf, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
 	raw_spin_unlock(&drvdata->spinlock);
@@ -1219,7 +1219,7 @@ static ssize_t addr_context_show(struct device *dev,
 	/* context ID comparator bits[6:4] */
 	val = FIELD_GET(TRCACATRn_CONTEXT_MASK, config->addr_acc[idx]);
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_context_store(struct device *dev,
@@ -1262,7 +1262,7 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_EXLEVEL_MASK, config->addr_acc[idx]);
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_exlevel_s_ns_store(struct device *dev,
@@ -1325,8 +1325,8 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 	}
 	raw_spin_unlock(&drvdata->spinlock);
 	if (addr_type) {
-		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] %s %#lx", idx,
-				 addr_type_names[addr_type], addr_v);
+		size = sysfs_emit(buf, "addr_cmp[%i] %s %#lx", idx,
+				  addr_type_names[addr_type], addr_v);
 		if (addr_type == ETM_ADDR_TYPE_RANGE) {
 			size += scnprintf(buf + size, PAGE_SIZE - size,
 					  " %#lx %s", addr_v2,
@@ -1335,7 +1335,7 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 		size += scnprintf(buf + size, PAGE_SIZE - size,
 				  " ctrl(%#lx)\n", addr_ctrl);
 	} else {
-		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] unused\n", idx);
+		size = sysfs_emit(buf, "addr_cmp[%i] unused\n", idx);
 	}
 	return size;
 }
@@ -1352,7 +1352,7 @@ static ssize_t vinst_pe_cmp_start_stop_show(struct device *dev,
 	if (!drvdata->nr_pe_cmp)
 		return -EINVAL;
 	val = config->vipcssctlr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
 					     struct device_attribute *attr,
@@ -1383,7 +1383,7 @@ static ssize_t seq_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->seq_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_idx_store(struct device *dev,
@@ -1419,7 +1419,7 @@ static ssize_t seq_state_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->seq_state;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_state_store(struct device *dev,
@@ -1453,7 +1453,7 @@ static ssize_t seq_event_show(struct device *dev,
 	idx = config->seq_idx;
 	val = config->seq_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_event_store(struct device *dev,
@@ -1486,7 +1486,7 @@ static ssize_t seq_reset_event_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->seq_rst;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_reset_event_store(struct device *dev,
@@ -1516,7 +1516,7 @@ static ssize_t cntr_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->cntr_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_idx_store(struct device *dev,
@@ -1556,7 +1556,7 @@ static ssize_t cntrldvr_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntrldvr[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntrldvr_store(struct device *dev,
@@ -1594,7 +1594,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_val_store(struct device *dev,
@@ -1632,7 +1632,7 @@ static ssize_t cntr_ctrl_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntr_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_ctrl_store(struct device *dev,
@@ -1664,7 +1664,7 @@ static ssize_t res_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->res_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t res_idx_store(struct device *dev,
@@ -1708,7 +1708,7 @@ static ssize_t res_ctrl_show(struct device *dev,
 	idx = config->res_idx;
 	val = config->res_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t res_ctrl_store(struct device *dev,
@@ -1746,7 +1746,7 @@ static ssize_t sshot_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ss_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t sshot_idx_store(struct device *dev,
@@ -1780,7 +1780,7 @@ static ssize_t sshot_ctrl_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_ctrl[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t sshot_ctrl_store(struct device *dev,
@@ -1815,7 +1815,7 @@ static ssize_t sshot_status_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_status[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(sshot_status);
 
@@ -1830,7 +1830,7 @@ static ssize_t sshot_pe_ctrl_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_pe_cmp[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t sshot_pe_ctrl_store(struct device *dev,
@@ -1864,7 +1864,7 @@ static ssize_t ctxid_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ctxid_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ctxid_idx_store(struct device *dev,
@@ -1911,7 +1911,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	idx = config->ctxid_idx;
 	val = (unsigned long)config->ctxid_pid[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ctxid_pid_store(struct device *dev,
@@ -1972,7 +1972,7 @@ static ssize_t ctxid_masks_show(struct device *dev,
 	val1 = config->ctxid_mask0;
 	val2 = config->ctxid_mask1;
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t ctxid_masks_store(struct device *dev,
@@ -2090,7 +2090,7 @@ static ssize_t vmid_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->vmid_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t vmid_idx_store(struct device *dev,
@@ -2135,7 +2135,7 @@ static ssize_t vmid_val_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t vmid_val_store(struct device *dev,
@@ -2187,7 +2187,7 @@ static ssize_t vmid_masks_show(struct device *dev,
 	val1 = config->vmid_mask0;
 	val2 = config->vmid_mask1;
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t vmid_masks_store(struct device *dev,
@@ -2303,7 +2303,7 @@ static ssize_t cpu_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->cpu;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 
 }
 static DEVICE_ATTR_RO(cpu);
@@ -2461,7 +2461,7 @@ static ssize_t coresight_etm4x_reg_show(struct device *dev,
 	val = etmv4_cross_read(drvdata, offset);
 	pm_runtime_put_sync(dev->parent);
 
-	return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);
+	return sysfs_emit(buf, "0x%x\n", val);
 }
 
 static bool
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index e45c6c7204b4..fa09a43889d7 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -470,7 +470,7 @@ static ssize_t hwevent_enable_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->stmheer;
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t hwevent_enable_store(struct device *dev,
@@ -499,7 +499,7 @@ static ssize_t hwevent_select_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->stmhebsr;
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t hwevent_select_store(struct device *dev,
@@ -534,7 +534,7 @@ static ssize_t port_select_show(struct device *dev,
 		spin_unlock(&drvdata->spinlock);
 	}
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t port_select_store(struct device *dev,
@@ -581,7 +581,7 @@ static ssize_t port_enable_show(struct device *dev,
 		spin_unlock(&drvdata->spinlock);
 	}
 
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t port_enable_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index feadaf065b53..547f4970e1e5 100644
--- a/drivers/hwtracing/coresight/coresight-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-sysfs.c
@@ -315,7 +315,7 @@ static ssize_t enable_sink_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	return scnprintf(buf, PAGE_SIZE, "%u\n", csdev->sysfs_sink_activated);
+	return sysfs_emit(buf, "%u\n", csdev->sysfs_sink_activated);
 }
 
 static ssize_t enable_sink_store(struct device *dev,
@@ -343,7 +343,7 @@ static ssize_t enable_source_show(struct device *dev,
 	struct coresight_device *csdev = to_coresight_device(dev);
 
 	guard(mutex)(&coresight_mutex);
-	return scnprintf(buf, PAGE_SIZE, "%u\n",
+	return sysfs_emit(buf, "%u\n",
 			 coresight_get_mode(csdev) == CS_MODE_SYSFS);
 }
 
-- 
2.47.1


