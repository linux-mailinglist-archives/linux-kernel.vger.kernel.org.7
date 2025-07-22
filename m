Return-Path: <linux-kernel+bounces-741399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26CBB0E39C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C2E3566376
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723692820B7;
	Tue, 22 Jul 2025 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nSANLFSR"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DFE283141
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209716; cv=none; b=gbNL1/unI/bqMm/HpWzL8VSUr0/J2cSPdSaxCnOtQprUC+dZlkGgFcMnAQkYxXafQOIF18Sy1388cAsje8dYWpxY9ikiI9MbFQfvcRCzFTaEcMlL7LBoJjWENivjyPpDqYpp5bEHI3Zo5v7BD7TIuN4NbZwGOpfArpLv0LUCJUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209716; c=relaxed/simple;
	bh=HJAE4rSQL1fbtEeKnUoLdTpK6i2S5LjIBrk+iAQGc1c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QEHkJNOqNjp5sShUlWFQPImrQhIDW2aNM/Pht2SyoLT3mcKqKNlpWuhxNqVT9HR4F2YkdWPdIEF4uo+Evhaf/t1JneAMY6XoWvnnU2LcDnpiQO/hh8CHVnlB6OoVVJLAL8Tz6uG7m5/wdlihrJkBIgTyMBvMHKHWnl8+Cgol0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nSANLFSR; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6fb0eb0f0fbso2529536d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753209712; x=1753814512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+hPuEGTMJ0xqN07MD5FVIRet5pxlysjM5rV0ObnFuw=;
        b=nSANLFSR3biSuAEFbIIFYW2w80v5q8yZDuFQQDpmkleFsLRhUTA44Pl2D8qiuHTDOe
         DTBPdWkziFFsI1CfmJTzgD8VhwO7Qnc0n9ssQiqFCStZ5la0WQ9RdIorvuOQcrlPwxjH
         5+Xr6eLB/0gWNc50gHhbdnk1sQYHRL5kATbRtDhwj5mlxUujkUGFCxGcRlmQX9fT3yEV
         iewPuA5t6dm2lX/bPSBdcneVgdupvzKmtA6ZNwwYpRnDGRkVBJI/nutbh65FK/rvYo40
         1MlymNwMVEe9hprbUx20taAPO7oZmCfnppp2GTfuhQ8YxKv5BVuHSBFFL4Kmzjm8bKhM
         7q1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209712; x=1753814512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+hPuEGTMJ0xqN07MD5FVIRet5pxlysjM5rV0ObnFuw=;
        b=uqKld38DonTTzsQPkJZ5p+1q99jMEQYwyNnPVM0fPSDX4iMLMbra6QCuwmG9pBhNCr
         QfD/tkDfJi8sQYzo4kCkCOqeFRvOPtXv2cH0H4k9IX89zrCzKwLZ2F/zAmXqrFUcbf66
         oXgmrPGQR4+ob9xgEfhhzh001L1ku4sdBy3cYC1VoH4VvmuidxLHFzTSlB1HQOAN+/sb
         Ymdwu0/NARUjQG7v32HhLIyE3fqxHO8W+XIU93TtGXDTgNWZFTq+e21wx0aeXxRFG/nI
         LQWxG0GZYdptW2qVLOXZJYWuMZ0bDlrSshDosLDV1AM/Va2pro826Q+uR2cS5dXZtrNz
         OZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCWgDGs+c635Is5IfcF5nXlvRscRHk15r5m7uVZ5Ta6qcPm2Cs+f2K8RFr/5RPMaxhvz/4zVz5XCpCpBfc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9vJO+L27YkkXfKPih1+a32QxlASrxohtt/syyDFD3t1yjPG2t
	GUpV2wgPZTtl5NFrxg+bOH/UW8vR/bHOUW1cP8d+gtZrCZU7LmJRvzWH
X-Gm-Gg: ASbGnctdkd+oNVKvCOPG6zaFjMriNJVbKNjTj5EtJJOioHMLgIrWSzJD1z1mzqHeeAO
	GDsqswVp8x8bCs/vJxIAiD8+782A3labVzIdyU5/DFbtK+vN0EXoVD4utrDOtxlO99KAljResYi
	BRjLouyvrwLSLKu/kHz71IFpOd3ksZLJkL7eIgkjP/RpIsl/rlzRS1mUY9N6NSoaCwQD1CPvafK
	ASbBwXcbFsmtHas0miYLkNBAoo/ejl5/ypACp/iJeTgYw7EydD1H74osnX2jnqHMF3S9GXwxxhQ
	7wf+1U3RJYXipflvxWnhupOUsWTG3vZGtGuAtTgdnKM4OEIRmDa5HoEivPgvCGCgYVuivzi9a17
	P/QeqUI6boQaYMWTM7kepMr3NSLNRGQQPwoXM+vAq66h+0F9OE1XTVXILITbA
X-Google-Smtp-Source: AGHT+IGkbcy2D3a2+W2oZY6QDQV3WW4DSbzOCbuOC1vbNduzhmZPFbh490grX9R4fNkS6vRRXZpJ9A==
X-Received: by 2002:a05:6214:2486:b0:705:1bb5:376d with SMTP id 6a1803df08f44-706eb6f45a0mr50455336d6.11.1753209711650;
        Tue, 22 Jul 2025 11:41:51 -0700 (PDT)
Received: from fyre-x-redhat96-nsd-1.fyre.ibm.com ([129.41.87.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b8bc2f1sm53606406d6.19.2025.07.22.11.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 11:41:51 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: suzuki.poulose@arm.com,
	mike.leach@linaro.org,
	alexander.shishkin@linux.intel.com,
	alexandre.torgue@foss.st.com
Cc: james.clark@linaro.org,
	mcoquelin.stm32@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH v5] coresight: Replace scnprintf/sprintf with sysfs_emit()/sysfs_emit_at()
Date: Tue, 22 Jul 2025 11:41:06 -0700
Message-ID: <20250722184106.3290455-1-chelsyratnawat2001@gmail.com>
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
returned to user space. So replace scnprintf() with sysfs_emit()

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
Changes in v5: 
 - Added changes to coresight/coresight-tnoc.c
 - Rebased to coresight/next
 - No functional changes intended

 .../hwtracing/coresight/coresight-cti-sysfs.c |  40 +++---
 drivers/hwtracing/coresight/coresight-etb10.c |   2 +-
 .../hwtracing/coresight/coresight-etm-perf.c  |   6 +-
 .../coresight/coresight-etm3x-sysfs.c         |  66 +++++-----
 .../coresight/coresight-etm4x-sysfs.c         | 117 +++++++++---------
 .../hwtracing/coresight/coresight-funnel.c    |   4 +-
 drivers/hwtracing/coresight/coresight-stm.c   |  10 +-
 drivers/hwtracing/coresight/coresight-sysfs.c |   6 +-
 .../hwtracing/coresight/coresight-tmc-core.c  |   6 +-
 drivers/hwtracing/coresight/coresight-tnoc.c  |   2 +-
 drivers/hwtracing/coresight/coresight-trbe.c  |   4 +-
 11 files changed, 130 insertions(+), 133 deletions(-)

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
index f677c08233ba..fe1d3bfde370 100644
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
-	return scnprintf(buf, PAGE_SIZE, "0x%px\n", ea->var);
+	return sysfs_emit(buf, "0x%px\n", ea->var);
 }
 
 static struct dev_ext_attribute *
@@ -943,7 +943,7 @@ static ssize_t etm_perf_cscfg_event_show(struct device *dev,
 	struct dev_ext_attribute *ea;
 
 	ea = container_of(dattr, struct dev_ext_attribute, attr);
-	return scnprintf(buf, PAGE_SIZE, "configid=0x%px\n", ea->var);
+	return sysfs_emit(buf, "configid=0x%px\n", ea->var);
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
index e9eeea6240d5..df6adf8ed3fc 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -64,7 +64,7 @@ static ssize_t nr_pe_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_pe_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_pe_cmp);
 
@@ -76,7 +76,7 @@ static ssize_t nr_addr_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_addr_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_addr_cmp);
 
@@ -88,7 +88,7 @@ static ssize_t nr_cntr_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_cntr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_cntr);
 
@@ -100,7 +100,7 @@ static ssize_t nr_ext_inp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_ext_inp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ext_inp);
 
@@ -112,7 +112,7 @@ static ssize_t numcidc_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->numcidc;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numcidc);
 
@@ -124,7 +124,7 @@ static ssize_t numvmidc_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->numvmidc;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(bu, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(numvmidc);
 
@@ -136,7 +136,7 @@ static ssize_t nrseqstate_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nrseqstate;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nrseqstate);
 
@@ -148,7 +148,7 @@ static ssize_t nr_resource_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_resource;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_resource);
 
@@ -160,7 +160,7 @@ static ssize_t nr_ss_cmp_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->nr_ss_cmp;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(nr_ss_cmp);
 
@@ -288,7 +288,7 @@ static ssize_t mode_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->mode;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t mode_store(struct device *dev,
@@ -454,7 +454,7 @@ static ssize_t pe_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->pe_sel;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t pe_store(struct device *dev,
@@ -489,7 +489,7 @@ static ssize_t event_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->eventctrl0;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_store(struct device *dev,
@@ -538,7 +538,7 @@ static ssize_t event_instren_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = FIELD_GET(TRCEVENTCTL1R_INSTEN_MASK, config->eventctrl1);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_instren_store(struct device *dev,
@@ -594,7 +594,7 @@ static ssize_t event_ts_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ts_ctrl;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_ts_store(struct device *dev,
@@ -624,7 +624,7 @@ static ssize_t syncfreq_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->syncfreq;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t syncfreq_store(struct device *dev,
@@ -654,7 +654,7 @@ static ssize_t cyc_threshold_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ccctlr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cyc_threshold_store(struct device *dev,
@@ -687,7 +687,7 @@ static ssize_t bb_ctrl_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->bb_ctrl;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t bb_ctrl_store(struct device *dev,
@@ -727,7 +727,7 @@ static ssize_t event_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = FIELD_GET(TRCVICTLR_EVENT_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t event_vinst_store(struct device *dev,
@@ -759,7 +759,7 @@ static ssize_t s_exlevel_vinst_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = FIELD_GET(TRCVICTLR_EXLEVEL_S_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t s_exlevel_vinst_store(struct device *dev,
@@ -794,7 +794,7 @@ static ssize_t ns_exlevel_vinst_show(struct device *dev,
 
 	/* EXLEVEL_NS, bits[23:20] */
 	val = FIELD_GET(TRCVICTLR_EXLEVEL_NS_MASK, config->vinst_ctrl);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ns_exlevel_vinst_store(struct device *dev,
@@ -828,7 +828,7 @@ static ssize_t addr_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->addr_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_idx_store(struct device *dev,
@@ -867,8 +867,7 @@ static ssize_t addr_instdatatype_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_TYPE_MASK, config->addr_acc[idx]);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n",
-			val == TRCACATRn_TYPE_ADDR ? "instr" :
+	len = sysfs_emit(buf, "%s\n", val == TRCACATRn_TYPE_ADDR ? "instr" :
 			(val == TRCACATRn_TYPE_DATA_LOAD_ADDR ? "data_load" :
 			(val == TRCACATRn_TYPE_DATA_STORE_ADDR ? "data_store" :
 			"data_load_store")));
@@ -919,7 +918,7 @@ static ssize_t addr_single_show(struct device *dev,
 	}
 	val = (unsigned long)config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_single_store(struct device *dev,
@@ -975,7 +974,7 @@ static ssize_t addr_range_show(struct device *dev,
 	val1 = (unsigned long)config->addr_val[idx];
 	val2 = (unsigned long)config->addr_val[idx + 1];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t addr_range_store(struct device *dev,
@@ -1050,7 +1049,7 @@ static ssize_t addr_start_show(struct device *dev,
 
 	val = (unsigned long)config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_start_store(struct device *dev,
@@ -1105,7 +1104,7 @@ static ssize_t addr_stop_show(struct device *dev,
 
 	val = (unsigned long)config->addr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_stop_store(struct device *dev,
@@ -1153,7 +1152,7 @@ static ssize_t addr_ctxtype_show(struct device *dev,
 	idx = config->addr_idx;
 	/* CONTEXTTYPE, bits[3:2] */
 	val = FIELD_GET(TRCACATRn_CONTEXTTYPE_MASK, config->addr_acc[idx]);
-	len = scnprintf(buf, PAGE_SIZE, "%s\n", val == ETM_CTX_NONE ? "none" :
+	len = sysfs_emit(buf, "%s\n", val == ETM_CTX_NONE ? "none" :
 			(val == ETM_CTX_CTXID ? "ctxid" :
 			(val == ETM_CTX_VMID ? "vmid" : "all")));
 	raw_spin_unlock(&drvdata->spinlock);
@@ -1220,7 +1219,7 @@ static ssize_t addr_context_show(struct device *dev,
 	/* context ID comparator bits[6:4] */
 	val = FIELD_GET(TRCACATRn_CONTEXT_MASK, config->addr_acc[idx]);
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_context_store(struct device *dev,
@@ -1263,7 +1262,7 @@ static ssize_t addr_exlevel_s_ns_show(struct device *dev,
 	idx = config->addr_idx;
 	val = FIELD_GET(TRCACATRn_EXLEVEL_MASK, config->addr_acc[idx]);
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t addr_exlevel_s_ns_store(struct device *dev,
@@ -1326,17 +1325,15 @@ static ssize_t addr_cmp_view_show(struct device *dev,
 	}
 	raw_spin_unlock(&drvdata->spinlock);
 	if (addr_type) {
-		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] %s %#lx", idx,
-				 addr_type_names[addr_type], addr_v);
+		size = sysfs_emit(buf, "addr_cmp[%i] %s %#lx", idx,
+				  addr_type_names[addr_type], addr_v);
 		if (addr_type == ETM_ADDR_TYPE_RANGE) {
-			size += scnprintf(buf + size, PAGE_SIZE - size,
-					  " %#lx %s", addr_v2,
+			size += sysfs_emit_at(buf, size, " %#lx %s", addr_v2,
 					  exclude ? "exclude" : "include");
 		}
-		size += scnprintf(buf + size, PAGE_SIZE - size,
-				  " ctrl(%#lx)\n", addr_ctrl);
+		size += sysfs_emit_at(buf, size, " ctrl(%#lx)\n", addr_ctrl);
 	} else {
-		size = scnprintf(buf, PAGE_SIZE, "addr_cmp[%i] unused\n", idx);
+		size = sysfs_emit(buf, size, "addr_cmp[%i] unused\n", idx);
 	}
 	return size;
 }
@@ -1353,7 +1350,7 @@ static ssize_t vinst_pe_cmp_start_stop_show(struct device *dev,
 	if (!drvdata->nr_pe_cmp)
 		return -EINVAL;
 	val = config->vipcssctlr;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static ssize_t vinst_pe_cmp_start_stop_store(struct device *dev,
 					     struct device_attribute *attr,
@@ -1384,7 +1381,7 @@ static ssize_t seq_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->seq_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_idx_store(struct device *dev,
@@ -1420,7 +1417,7 @@ static ssize_t seq_state_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->seq_state;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_state_store(struct device *dev,
@@ -1454,7 +1451,7 @@ static ssize_t seq_event_show(struct device *dev,
 	idx = config->seq_idx;
 	val = config->seq_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_event_store(struct device *dev,
@@ -1487,7 +1484,7 @@ static ssize_t seq_reset_event_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->seq_rst;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t seq_reset_event_store(struct device *dev,
@@ -1517,7 +1514,7 @@ static ssize_t cntr_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->cntr_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_idx_store(struct device *dev,
@@ -1557,7 +1554,7 @@ static ssize_t cntrldvr_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntrldvr[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntrldvr_store(struct device *dev,
@@ -1595,7 +1592,7 @@ static ssize_t cntr_val_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntr_val[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_val_store(struct device *dev,
@@ -1633,7 +1630,7 @@ static ssize_t cntr_ctrl_show(struct device *dev,
 	idx = config->cntr_idx;
 	val = config->cntr_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t cntr_ctrl_store(struct device *dev,
@@ -1665,7 +1662,7 @@ static ssize_t res_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->res_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t res_idx_store(struct device *dev,
@@ -1709,7 +1706,7 @@ static ssize_t res_ctrl_show(struct device *dev,
 	idx = config->res_idx;
 	val = config->res_ctrl[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t res_ctrl_store(struct device *dev,
@@ -1747,7 +1744,7 @@ static ssize_t sshot_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ss_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t sshot_idx_store(struct device *dev,
@@ -1781,7 +1778,7 @@ static ssize_t sshot_ctrl_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_ctrl[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t sshot_ctrl_store(struct device *dev,
@@ -1816,7 +1813,7 @@ static ssize_t sshot_status_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_status[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(sshot_status);
 
@@ -1831,7 +1828,7 @@ static ssize_t sshot_pe_ctrl_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = config->ss_pe_cmp[config->ss_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t sshot_pe_ctrl_store(struct device *dev,
@@ -1865,7 +1862,7 @@ static ssize_t ctxid_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->ctxid_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ctxid_idx_store(struct device *dev,
@@ -1912,7 +1909,7 @@ static ssize_t ctxid_pid_show(struct device *dev,
 	idx = config->ctxid_idx;
 	val = (unsigned long)config->ctxid_pid[idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t ctxid_pid_store(struct device *dev,
@@ -1973,7 +1970,7 @@ static ssize_t ctxid_masks_show(struct device *dev,
 	val1 = config->ctxid_mask0;
 	val2 = config->ctxid_mask1;
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t ctxid_masks_store(struct device *dev,
@@ -2091,7 +2088,7 @@ static ssize_t vmid_idx_show(struct device *dev,
 	struct etmv4_config *config = &drvdata->config;
 
 	val = config->vmid_idx;
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t vmid_idx_store(struct device *dev,
@@ -2136,7 +2133,7 @@ static ssize_t vmid_val_show(struct device *dev,
 	raw_spin_lock(&drvdata->spinlock);
 	val = (unsigned long)config->vmid_val[config->vmid_idx];
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t vmid_val_store(struct device *dev,
@@ -2188,7 +2185,7 @@ static ssize_t vmid_masks_show(struct device *dev,
 	val1 = config->vmid_mask0;
 	val2 = config->vmid_mask1;
 	raw_spin_unlock(&drvdata->spinlock);
-	return scnprintf(buf, PAGE_SIZE, "%#lx %#lx\n", val1, val2);
+	return sysfs_emit(buf, "%#lx %#lx\n", val1, val2);
 }
 
 static ssize_t vmid_masks_store(struct device *dev,
@@ -2304,7 +2301,7 @@ static ssize_t cpu_show(struct device *dev,
 	struct etmv4_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->cpu;
-	return scnprintf(buf, PAGE_SIZE, "%d\n", val);
+	return sysfs_emit(buf, "%d\n", val);
 
 }
 static DEVICE_ATTR_RO(cpu);
@@ -2462,7 +2459,7 @@ static ssize_t coresight_etm4x_reg_show(struct device *dev,
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
index 464b0c85c3f7..ba5f8e69ffdc 100644
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
index be964656be93..42316bd19056 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -481,7 +481,7 @@ static ssize_t trigger_cntr_show(struct device *dev,
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 	unsigned long val = drvdata->trigger_cntr;
 
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 
 static ssize_t trigger_cntr_store(struct device *dev,
@@ -506,7 +506,7 @@ static ssize_t buffer_size_show(struct device *dev,
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	return sprintf(buf, "%#x\n", drvdata->size);
+	return sysfs_emit(buf, "%#x\n", drvdata->size);
 }
 
 static ssize_t buffer_size_store(struct device *dev,
@@ -538,7 +538,7 @@ static ssize_t stop_on_flush_show(struct device *dev,
 {
 	struct tmc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	return sprintf(buf, "%#x\n", drvdata->stop_on_flush);
+	return sysfs_emit(buf, "%#x\n", drvdata->stop_on_flush);
 }
 
 static ssize_t stop_on_flush_store(struct device *dev,
diff --git a/drivers/hwtracing/coresight/coresight-tnoc.c b/drivers/hwtracing/coresight/coresight-tnoc.c
index d542df46ea39..67fd5f60b86c 100644
--- a/drivers/hwtracing/coresight/coresight-tnoc.c
+++ b/drivers/hwtracing/coresight/coresight-tnoc.c
@@ -140,7 +140,7 @@ static ssize_t traceid_show(struct device *dev,
 	struct trace_noc_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
 	val = drvdata->atid;
-	return sprintf(buf, "%#lx\n", val);
+	return sysfs_emit(buf, "%#lx\n", val);
 }
 static DEVICE_ATTR_RO(traceid);
 
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 10f3fb401edf..9f3041d537bb 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -1204,7 +1204,7 @@ static ssize_t align_show(struct device *dev, struct device_attribute *attr, cha
 {
 	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%llx\n", cpudata->trbe_hw_align);
+	return sysfs_emit(buf, "%llx\n", cpudata->trbe_hw_align);
 }
 static DEVICE_ATTR_RO(align);
 
@@ -1212,7 +1212,7 @@ static ssize_t flag_show(struct device *dev, struct device_attribute *attr, char
 {
 	struct trbe_cpudata *cpudata = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", cpudata->trbe_flag);
+	return sysfs_emit(buf, "%d\n", cpudata->trbe_flag);
 }
 static DEVICE_ATTR_RO(flag);
 
-- 
2.47.1


