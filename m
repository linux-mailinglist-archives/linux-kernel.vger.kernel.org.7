Return-Path: <linux-kernel+bounces-737965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9AB0B2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 00:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3761117014C
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24140239082;
	Sat, 19 Jul 2025 22:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j0w09xLy"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EDA21B8F7
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 22:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752965192; cv=none; b=joeMacasWA/7hvaNiAs1DSLZGhbY6aWVrV/mEu4DLchHiSpjXuNVAGWZdwCcQlCB9XMf+Z23vsWO5Bj53wecQP86mE9akJ2/gdFkpktE3muiykpK9ld0LnO89B22R+fxlhBYc/E+Q9IjLT+s/KADZFjNo3/IGomZ4PFJMy/sjzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752965192; c=relaxed/simple;
	bh=qBfsGAXUX5HUn23TjbGOF/IOMvh8h30KJBGbf0VaBGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SIQmXvpOJVLomZik7Y2BgJqsPCpQfiY53U1mGd3UHS/usK+W3oNdHOQZSf59gU2dt0m0LTu2YSa1o1wDrD2nK01T1dFproRgY8hD+frYtnE/1iZydgu1QV3AxIRmmsvv62hsyea45AUpMB2yKZljkvZCZ+vKrC6EHw5IMLCy+yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j0w09xLy; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7e182e4171bso351496885a.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752965188; x=1753569988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRhGUan9tpWaaqsf9KJqYybyCOMFvarHB1XBp9ZZ7xw=;
        b=j0w09xLybGEXMrf2cNe0r6f1BKSdTx34/Xv4nGM0yBUHISn7csgKz/9AaHRe8/GA0R
         TBc9jlfMp9MQ7VoDLq2UqbmrjVNnxgL0xMqpddr2p24VAscdzBkyXk/XjjZuotrE73jR
         qauDsqUNsNh5NOfDaFHOokpwkOMidOVvcvEtb2cB31TqxYD4vFsiP67lMupfGZzd56qt
         NMKqjpNi+g/M0TFpy96dmr1olFy71e9dO+OOjgzlzgsEeZ/5WGLe7wHs5ZWY42wVGP6t
         yG0U40UJugAOi5YO5I6AXqmZntQfD/iqfPajVOszjUqUSYhofFpRtV2mqlwlG+hBxGuX
         EWFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752965188; x=1753569988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRhGUan9tpWaaqsf9KJqYybyCOMFvarHB1XBp9ZZ7xw=;
        b=aa7zVNYsXYEquiMsx709M4LSZe3LkjIu87zmwu6cEQEs0kz9TI6CCY5f8upCNcP9Nx
         RRU/1i2RPs4bCBigz3OyDDNTMirPG5bJDR9C4oE3Q4Lm4E2FBGI/eh8qwIOWGg+R4KSV
         EQaBPmR7KSobMyaNpe33hGjWv4aq4QlCVQM6nI2v4Q/HFsetEOkKX+boULUfq6e+qhFz
         a9B2bWSYKevOqtS+11viDa7kbcTkO4dUdymHWTgdXmhU3hWn4pqlJLXVn++C5EjoV1yz
         sOiRQaxj0+uInFhVaa3HaP9DYuOHawix92ksIdXKfq7iznpAvrFXqRxux6ojHuwiccbv
         aScA==
X-Forwarded-Encrypted: i=1; AJvYcCWu77UjwsR+O29bQdq135Y5jf57kbDL3xitcAZcDsjaoQUT/1mIRsvFC8K7021p1QpRs5O1BMn+afoZGzc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw2LqH76Y9fZc/jRGbT+sOPusGutRkkU6TuJVudFDk487jl0W/
	xqmepRTurbR0piB1z/ld78h2fEjj9ksJ+zHB3V67IWfU1D2DSBt9Np2V
X-Gm-Gg: ASbGncul+WRB94JJSSVZS5W6Aettiz601vsUnwFEAWJYhr3IB9FAuJh+mWZ+FNYWcD9
	Ueh2QTvJ40KmE3FzPSJxnF7OQhHPxicPqz4PJsJHgN1RW5wPr9w/JfZ7MVycIZxh2CZtq6HCWh/
	qXrTJqHS2csocsCc+YGKiZixTzmC2D03nMt+60GoDsUBmW3+jxpOQny9bsNQAoQlb7Ka9JiAmtd
	ILp3jE07RuygQjq2cBcDGeJaO/OUpJiGALTIDLtlcrp83rRcMmbbCa3L7EwNSb7BiFRcW7zscHj
	J3wdzLA3jxyU6ssucDLZu5DmA6SVs1PIc5Jav52j4QCUX/s2APSgDdis29loh5ibVK8qhku2sx9
	mAuaVowOn8SJX1fkhwX0Fo8lOsF8sBLkue/0pbDus7MwLAyjb++T/iXskTkYG
X-Google-Smtp-Source: AGHT+IEiHYEVzBA68crovop6fol2sTaneHYnWLPDeCRJUxxK18uv8jxfvsq2j3Vkrot0glvdK6lmZQ==
X-Received: by 2002:a05:6214:c2f:b0:704:9bc2:be36 with SMTP id 6a1803df08f44-704f69fdcefmr302099226d6.7.1752965187687;
        Sat, 19 Jul 2025 15:46:27 -0700 (PDT)
Received: from fyre-x-redhat96-nsd-1.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc2f1sm22626096d6.19.2025.07.19.15.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:46:27 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: suzuki.poulose@arm.com,
	alexander.shishkin@linux.intel.com,
	mike.leach@linaro.org
Cc: mcoquelin.stm32@gmail.com,
	james.clark@linaro.org,
	alexandre.torgue@foss.st.com,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v4] coresight: Replace scnprintf() with sysfs_emit() in sysfs show functions
Date: Sat, 19 Jul 2025 15:45:47 -0700
Message-ID: <20250719224547.2389642-1-chelsyratnawat2001@gmail.com>
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
---
Changes in v4:
- Applied changes to 5  more files to replace sprintf/scnprintf with
  sysfs_emit() and sysfs_emit_at()
- No functional changes intended

 .../hwtracing/coresight/coresight-cti-sysfs.c |  40 +++---
 drivers/hwtracing/coresight/coresight-etb10.c |   2 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   6 +-
 .../coresight/coresight-etm3x-sysfs.c         |  66 +++++-----
 .../coresight/coresight-etm4x-sysfs.c         | 122 +++++++++---------
 .../hwtracing/coresight/coresight-funnel.c    |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  10 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   6 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |   6 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |   4 +-
 10 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index 572b80ee96fb..534f78539fb3 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -91,9 +91,9 @@ static ssize_t enable_show(struct device *dev,
 	raw_spin_unlock(&drvdata->spinlock);
 
 	if (powered)
-		return sprintf(buf, "%d\n", enabled);
+		return sysfs_emit(buf, "%d\n", enabled);
 	else
-		return sprintf(buf, "%d\n", !!enable_req);
+		return sysfs_emit(buf, "%d\n", !!enable_req);
 }
 
 static ssize_t enable_store(struct device *dev,
@@ -138,7 +138,7 @@ static ssize_t powered_show(struct device *dev,
 	powered = drvdata->config.hw_powered;
 	raw_spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%d\n", powered);
+	return sysfs_emit(buf, "%d\n", powered);
 }
 static DEVICE_ATTR_RO(powered);
 
@@ -147,7 +147,7 @@ static ssize_t ctmid_show(struct device *dev,
 {
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	return sprintf(buf, "%d\n", drvdata->ctidev.ctm_id);
+	return sysfs_emit(buf, "%d\n", drvdata->ctidev.ctm_id);
 }
 static DEVICE_ATTR_RO(ctmid);
 
@@ -157,7 +157,7 @@ static ssize_t nr_trigger_cons_show(struct device *dev,
 {
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	return sprintf(buf, "%d\n", drvdata->ctidev.nr_trig_con);
+	return sysfs_emit(buf, "%d\n", drvdata->ctidev.nr_trig_con);
 }
 static DEVICE_ATTR_RO(nr_trigger_cons);
 
@@ -334,7 +334,7 @@ static ssize_t inout_sel_show(struct device *dev,
 	struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = (u32)drvdata->config.ctiinout_sel;
-	return sprintf(buf, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t inout_sel_store(struct device *dev,
@@ -368,7 +368,7 @@ static ssize_t inen_show(struct device *dev,
 	index = drvdata->config.ctiinout_sel;
 	val = drvdata->config.ctiinen[index];
 	raw_spin_unlock(&drvdata->spinlock);
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t inen_store(struct device *dev,
@@ -407,7 +407,7 @@ static ssize_t outen_show(struct device *dev,
 	index = drvdata->config.ctiinout_sel;
 	val = drvdata->config.ctiouten[index];
 	raw_spin_unlock(&drvdata->spinlock);
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t outen_store(struct device *dev,
@@ -609,7 +609,7 @@ static ssize_t chan_gate_enable_show(struct device *dev,
 	int size = 0;
 
 	if (cfg->ctigate == 0)
-		size = sprintf(buf, "\n");
+		size = sysfs_emit(buf, "\n");
 	else
 		size = bitmap_print_to_pagebuf(true, buf, &ctigate_bitmask,
 					       cfg->nr_ctm_channels);
@@ -684,7 +684,7 @@ static ssize_t trig_filter_enable_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = drvdata->config.trig_filter_enable;
 	raw_spin_unlock(&drvdata->spinlock);
-	return sprintf(buf, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 }
 
 static ssize_t trig_filter_enable_store(struct device *dev,
@@ -785,7 +785,7 @@ static ssize_t chan_xtrigs_sel_show(struct device *dev,
 	val = drvdata->config.xtrig_rchan_sel;
 	raw_spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%ld\n", val);
+	return sysfs_emit(buf, "%ld\n", val);
 }
 static DEVICE_ATTR_RW(chan_xtrigs_sel);
 
@@ -801,10 +801,10 @@ static ssize_t chan_xtrigs_in_show(struct device *dev,
 
 	for (reg_idx = 0; reg_idx < nr_trig_max; reg_idx++) {
 		if (chan_mask & cfg->ctiinen[reg_idx])
-			used += sprintf(buf + used, "%d ", reg_idx);
+			used += sysfs_emit_at(buf, used, "%d ", reg_idx);
 	}
 
-	used += sprintf(buf + used, "\n");
+	used += sysfs_emit_at(buf, used, "\n");
 	return used;
 }
 static DEVICE_ATTR_RO(chan_xtrigs_in);
@@ -821,10 +821,10 @@ static ssize_t chan_xtrigs_out_show(struct device *dev,
 
 	for (reg_idx = 0; reg_idx < nr_trig_max; reg_idx++) {
 		if (chan_mask & cfg->ctiouten[reg_idx])
-			used += sprintf(buf + used, "%d ", reg_idx);
+			used += sysfs_emit_at(buf, used, "%d ", reg_idx);
 	}
 
-	used += sprintf(buf + used, "\n");
+	used += sysfs_emit_at(buf, used, "\n");
 	return used;
 }
 static DEVICE_ATTR_RO(chan_xtrigs_out);
@@ -914,7 +914,7 @@ static ssize_t con_name_show(struct device *dev,
 		container_of(attr, struct dev_ext_attribute, attr);
 	struct cti_trig_con *con = (struct cti_trig_con *)ext_attr->var;
 
-	return sprintf(buf, "%s\n", con->con_dev_name);
+	return sysfs_emit(buf, "%s\n", con->con_dev_name);
 }
 
 static ssize_t trigin_sig_show(struct device *dev,
@@ -969,9 +969,9 @@ static ssize_t trigin_type_show(struct device *dev,
 
 	for (sig_idx = 0; sig_idx < con->con_in->nr_sigs; sig_idx++) {
 		name = cti_sig_type_name(con, sig_idx, true);
-		used += sprintf(buf + used, "%s ", name);
+		used += sysfs_emit_at(buf, used, "%s ", name);
 	}
-	used += sprintf(buf + used, "\n");
+	used += sysfs_emit_at(buf, used, "\n");
 	return used;
 }
 
@@ -987,9 +987,9 @@ static ssize_t trigout_type_show(struct device *dev,
 
 	for (sig_idx = 0; sig_idx < con->con_out->nr_sigs; sig_idx++) {
 		name = cti_sig_type_name(con, sig_idx, false);
-		used += sprintf(buf + used, "%s ", name);
+		used += sysfs_emit_at(buf, used, "%s ", name);
 	}
-	used += sprintf(buf + used, "\n");
+	used += sysfs_emit_at(buf, used, "\n");
 	return used;
 }
 
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index d5efb085b30d..dd1c37c0bd72 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -672,7 +672,7 @@ static ssize_t trigger_cntr_show(struct device *dev,
 	struct etb_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->trigger_cntr;
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t trigger_cntr_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index f1551c08ecb2..af4546850140 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -85,7 +85,7 @@ static ssize_t format_attr_contextid_show(struct device *dev,
 #if IS_ENABLED(CONFIG_CORESIGHT_SOURCE_ETM4X)
 	pid_fmt = is_kernel_in_hyp_mode() ? ETM_OPT_CTXTID2 : ETM_OPT_CTXTID;
 #endif
-	return sprintf(page, "config:%d\n", pid_fmt);
+	return sysfs_emit(page, "config:%d\n", pid_fmt);
 }
 
 static struct device_attribute format_attr_contextid =
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
index 762109307b86..2dd80dd0c1bf 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -17,7 +17,7 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_addr_cmp;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_addr_cmp);
 
@@ -27,7 +27,7 @@ static ssize_t nr_cntr_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_cntr;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_cntr);
 
@@ -38,7 +38,7 @@ static ssize_t nr_ctxid_cmp_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_ctxid_cmp;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ctxid_cmp);
 
@@ -58,7 +58,7 @@ static ssize_t etmsr_show(struct device *dev,
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(etmsr);
 
@@ -101,7 +101,7 @@ static ssize_t mode_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->mode;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t mode_store(struct device *dev,
@@ -186,7 +186,7 @@ static ssize_t trigger_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->trigger_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t trigger_event_store(struct device *dev,
@@ -216,7 +216,7 @@ static ssize_t enable_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->enable_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t enable_event_store(struct device *dev,
@@ -246,7 +246,7 @@ static ssize_t fifofull_level_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->fifofull_level;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t fifofull_level_store(struct device *dev,
@@ -276,7 +276,7 @@ static ssize_t addr_idx_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->addr_idx;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_idx_store(struct device *dev,
@@ -326,7 +326,7 @@ static ssize_t addr_single_show(struct device *dev,
 	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_single_store(struct device *dev,
@@ -385,7 +385,7 @@ static ssize_t addr_range_show(struct device *dev,
 	val2 = config->addr_val[idx + 1];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t addr_range_store(struct device *dev,
@@ -447,7 +447,7 @@ static ssize_t addr_start_show(struct device *dev,
 	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_start_store(struct device *dev,
@@ -501,7 +501,7 @@ static ssize_t addr_stop_show(struct device *dev,
 	val = config->addr_val[idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_stop_store(struct device *dev,
@@ -547,7 +547,7 @@ static ssize_t addr_acctype_show(struct device *dev,
 	val = config->addr_acctype[config->addr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_acctype_store(struct device *dev,
@@ -579,7 +579,7 @@ static ssize_t cntr_idx_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->cntr_idx;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_idx_store(struct device *dev,
@@ -620,7 +620,7 @@ static ssize_t cntr_rld_val_show(struct device *dev,
 	val = config->cntr_rld_val[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_rld_val_store(struct device *dev,
@@ -655,7 +655,7 @@ static ssize_t cntr_event_show(struct device *dev,
 	val = config->cntr_event[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_event_store(struct device *dev,
@@ -690,7 +690,7 @@ static ssize_t cntr_rld_event_show(struct device *dev,
 	val = config->cntr_rld_event[config->cntr_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_rld_event_store(struct device *dev,
@@ -725,7 +725,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	if (!coresight_get_mode(drvdata->csdev)) {
 		spin_lock(&drvdata->spinlock);
 		for (i = 0; i < drvdata->nr_cntr; i++)
-			ret += sprintf(buf, "counter %d: %x\n",
+			ret += sysfs_emit_at(buf, ret, "counter %d: %x\n",
 				       i, config->cntr_val[i]);
 		spin_unlock(&drvdata->spinlock);
 		return ret;
@@ -733,7 +733,7 @@ static ssize_t cntr_val_show(struct device *dev,
 
 	for (i = 0; i < drvdata->nr_cntr; i++) {
 		val = etm_readl(drvdata, ETMCNTVRn(i));
-		ret += sprintf(buf, "counter %d: %x\n", i, val);
+		ret += sysfs_emit_at(buf, ret, "counter %d: %x\n", i, val);
 	}
 
 	return ret;
@@ -768,7 +768,7 @@ static ssize_t seq_12_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_12_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_12_event_store(struct device *dev,
@@ -797,7 +797,7 @@ static ssize_t seq_21_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_21_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_21_event_store(struct device *dev,
@@ -826,7 +826,7 @@ static ssize_t seq_23_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_23_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_23_event_store(struct device *dev,
@@ -855,7 +855,7 @@ static ssize_t seq_31_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_31_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_31_event_store(struct device *dev,
@@ -884,7 +884,7 @@ static ssize_t seq_32_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_32_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_32_event_store(struct device *dev,
@@ -913,7 +913,7 @@ static ssize_t seq_13_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->seq_13_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_13_event_store(struct device *dev,
@@ -956,7 +956,7 @@ static ssize_t seq_curr_state_show(struct device *dev,
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	pm_runtime_put(dev->parent);
 out:
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_curr_state_store(struct device *dev,
@@ -989,7 +989,7 @@ static ssize_t ctxid_idx_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->ctxid_idx;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ctxid_idx_store(struct device *dev,
@@ -1038,7 +1038,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	val = config->ctxid_pid[config->ctxid_idx];
 	spin_unlock(&drvdata->spinlock);
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ctxid_pid_store(struct device *dev,
@@ -1089,7 +1089,7 @@ static ssize_t ctxid_mask_show(struct device *dev,
 		return -EINVAL;
 
 	val = config->ctxid_mask;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ctxid_mask_store(struct device *dev,
@@ -1125,7 +1125,7 @@ static ssize_t sync_freq_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->sync_freq;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t sync_freq_store(struct device *dev,
@@ -1154,7 +1154,7 @@ static ssize_t timestamp_event_show(struct device *dev,
 	struct etm_config *config = &drvdata->config;
 
 	val = config->timestamp_event;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t timestamp_event_store(struct device *dev,
@@ -1182,7 +1182,7 @@ static ssize_t cpu_show(struct device *dev,
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->cpu;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 
 }
 static DEVICE_ATTR_RO(cpu);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index ab251865b893..863342d7dd5d 100644
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
@@ -1325,17 +1325,17 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 	}
 	raw_spin_unlock(&drvdata->spinlock);
 	if (addr_type) {
-		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] %s %#lx", idx,
-				 addr_type_names[addr_type], addr_v);
+		size = sysfs_emit(buf, "addr_cmp[%i] %s %#lx", idx,
+				  addr_type_names[addr_type], addr_v);
 		if (addr_type == ETM_ADDR_TYPE_RANGE) {
-			size += scnprintf(buf + size, PAGE_SIZE - size,
+			size += sysfs_emit_at(buf, size,
 					  " %#lx %s", addr_v2,
 					  exclude ? "exclude" : "include");
 		}
-		size += scnprintf(buf + size, PAGE_SIZE - size,
+		size += sysfs_emit_at(buf, size,
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
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b1922dbe9292..2b6009bb7a3b 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -157,7 +157,7 @@ static ssize_t priority_show(struct device *dev,
 	struct funnel_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->priority;
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t priority_store(struct device *dev,
@@ -200,7 +200,7 @@ static ssize_t funnel_ctrl_show(struct device *dev,
 
 	pm_runtime_put(dev->parent);
 
-	return sprintf(buf, "%#x\n", val);
+	return sysfs_emit(buf, "%#x\n", val);
 }
 static DEVICE_ATTR_RO(funnel_ctrl);
 
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index e45c6c7204b4..81fa4b24e300 100644
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
@@ -617,7 +617,7 @@ static ssize_t traceid_show(struct device *dev,
 	struct stm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->traceid;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(traceid);
 
diff --git a/drivers/hwtracing/coresight/coresight-sysfs.c b/drivers/hwtracing/coresight/coresight-sysfs.c
index feadaf065b53..8c7bfaae0cbd 100644
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
 
@@ -416,7 +416,7 @@ static ssize_t nr_links_show(struct device *dev,
 {
 	struct coresight_device *csdev = to_coresight_device(dev);
 
-	return sprintf(buf, "%d\n", csdev->nr_links);
+	return sysfs_emit(buf, "%d\n", csdev->nr_links);
 }
 static DEVICE_ATTR_RO(nr_links);
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 88afb16bb6be..a95712fb48b7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -480,7 +480,7 @@ static ssize_t trigger_cntr_show(struct device *dev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->trigger_cntr;
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t trigger_cntr_store(struct device *dev,
@@ -505,7 +505,7 @@ static ssize_t buffer_size_show(struct device *dev,
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	return sprintf(buf, "%#x\n", drvdata->size);
+	return sysfs_emit(buf, "%#x\n", drvdata->size);
 }
 
 static ssize_t buffer_size_store(struct device *dev,
@@ -537,7 +537,7 @@ static ssize_t stop_on_flush_show(struct device *dev,
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	return sprintf(buf, "%#x\n", drvdata->stop_on_flush);
+	return sysfs_emit(buf, "%#x\n", drvdata->stop_on_flush);
 }
 
 static ssize_t stop_on_flush_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 8267dd1a2130..0ba5ea6abe50 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1203,7 +1203,7 @@ static ssize_t align_show(struct device *dev, struct device_attribute *attr, cha
 {
 	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%llx\n", cpudata->trbe_hw_align);
+	return sysfs_emit(buf, "%llx\n", cpudata->trbe_hw_align);
 }
 static DEVICE_ATTR_RO(align);
 
@@ -1211,7 +1211,7 @@ static ssize_t flag_show(struct device *dev, struct device_attribute *attr, char
 {
 	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", cpudata->trbe_flag);
+	return sysfs_emit(buf, "%d\n", cpudata->trbe_flag);
 }
 static DEVICE_ATTR_RO(flag);
 
-- 
2.47.1


