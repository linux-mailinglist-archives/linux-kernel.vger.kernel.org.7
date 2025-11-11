Return-Path: <linux-kernel+bounces-895393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4692C4DA55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3B1188CFA7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB02357A5F;
	Tue, 11 Nov 2025 12:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="QLukUYCJ"
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176F43396E4
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 12:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762863721; cv=none; b=ccbHmxI7fzUcWllU+cTYYSCd/LRTU3dmRPNPHWH71jUZEDxqVOTKES6egWrrNI0GkgrkfcoztgZtJP/Z86hFyszL1u5Uk3ZLvYVTsqjUWx5XpdipVbJzSh/JuMIk6JTHHP9QZoesaYA428sSbMiOHrGKXApNaDq/+qYWuQrflLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762863721; c=relaxed/simple;
	bh=7UlBtPEuf7HdJX/3Dcm1ey8twKOpCQX2UDBDrC+VFDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6E/IBhvSamOJgb1Ts41u+d/Mpltg6OeGUfltoTeZSBEVsKfgQaFRJL685YJwk97BaBHp0Xr9D6kThd2jHv5bYgkwIalK0KwaJDo0RnFrxkWD+k5rQIo3Mu8c6n+CvjdXVGQ3SENudRS5ISZhbXY2HI2UBOY8bCeWsmqni5RMtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=QLukUYCJ; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6DahaM2WUifhF4vcS+2MyAvZ4flM/F4X3U9WpeTtaWE=;
	b=QLukUYCJOuN23gML4HqxtSMVzH2IV2tWHMFdl2Y6xOLWbK0mVQJDOOML3KWaiYYodhW8aU6Ak
	pnR6cTAqsUFyY193W0NVEZoOCpHqqNN/80GGS2mDAeFLkFWykeU5Yv1CVntaBqNUoBVkttTdrre
	vAyOMiPRqVA7HLtVqhkfiiY=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4d5QbM6Mg1zRhQj;
	Tue, 11 Nov 2025 20:20:15 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5ED61180237;
	Tue, 11 Nov 2025 20:21:54 +0800 (CST)
Received: from kwepemn500004.china.huawei.com (7.202.194.145) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 20:21:54 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemn500004.china.huawei.com (7.202.194.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 11 Nov 2025 20:21:52 +0800
From: Junhao He <hejunhao3@h-partners.com>
To: <suzuki.poulose@arm.com>, <james.clark@linaro.org>,
	<anshuman.khandual@arm.com>, <yeoreum.yun@arm.com>, <mike.leach@linaro.org>,
	<leo.yan@arm.com>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>, <hejunhao3@h-partners.com>
Subject: [PATCH v4 2/3] coresight: tmc: refactor the tmc-etr mode setting to avoid race conditions
Date: Tue, 11 Nov 2025 20:21:48 +0800
Message-ID: <20251111122149.1981162-3-hejunhao3@h-partners.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251111122149.1981162-1-hejunhao3@h-partners.com>
References: <20251111122149.1981162-1-hejunhao3@h-partners.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemn500004.china.huawei.com (7.202.194.145)

From: Junhao He <hejunhao3@huawei.com>

When trying to run perf and sysfs mode simultaneously, the WARN_ON()
in tmc_etr_enable_hw() is triggered sometimes:

 WARNING: CPU: 42 PID: 3911571 at drivers/hwtracing/coresight/coresight-tmc-etr.c:1060 tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc]
 [..snip..]
 Call trace:
  tmc_etr_enable_hw+0xc0/0xd8 [coresight_tmc] (P)
  tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc] (L)
  tmc_enable_etr_sink+0x11c/0x250 [coresight_tmc]
  coresight_enable_path+0x1c8/0x218 [coresight]
  coresight_enable_sysfs+0xa4/0x228 [coresight]
  enable_source_store+0x58/0xa8 [coresight]
  dev_attr_store+0x20/0x40
  sysfs_kf_write+0x4c/0x68
  kernfs_fop_write_iter+0x120/0x1b8
  vfs_write+0x2c8/0x388
  ksys_write+0x74/0x108
  __arm64_sys_write+0x24/0x38
  el0_svc_common.constprop.0+0x64/0x148
  do_el0_svc+0x24/0x38
  el0_svc+0x3c/0x130
  el0t_64_sync_handler+0xc8/0xd0
  el0t_64_sync+0x1ac/0x1b0
 ---[ end trace 0000000000000000 ]---

Since the sysfs buffer allocation and the hardware enablement is not
in the same critical region, it's possible to race with the perf

mode:
  [sysfs mode]                   [perf mode]
  tmc_etr_get_sysfs_buffer()
    spin_lock(&drvdata->spinlock)
    [sysfs buffer allocation]
    spin_unlock(&drvdata->spinlock)
                                 spin_lock(&drvdata->spinlock)
                                 tmc_etr_enable_hw()
                                   drvdata->etr_buf = etr_perf->etr_buf
                                 spin_unlock(&drvdata->spinlock)
 spin_lock(&drvdata->spinlock)
 tmc_etr_enable_hw()
   WARN_ON(drvdata->etr_buf) // WARN sicne etr_buf initialized at
                                the perf side
  spin_unlock(&drvdata->spinlock)

A race condition is introduced here, perf always prioritizes execution, and
warnings can lead to concerns about potential hidden bugs, such as getting
out of sync.

To fix this, configure the tmc-etr mode before invoking enable_etr_perf()
or enable_etr_sysfs(), explicitly check if the tmc-etr sink is already
enabled in a different mode, and simplily the setup and checks for "mode".
To prevent race conditions between mode transitions.

Fixes: 296b01fd106e ("coresight: Refactor out buffer allocation function for ETR")
Reported-by: Yicong Yang <yangyicong@hisilicon.com>
Closes: https://lore.kernel.org/linux-arm-kernel/20241202092419.11777-2-yangyicong@huawei.com/
Signed-off-by: Junhao He <hejunhao3@huawei.com>
Tested-by: Yicong Yang <yangyicong@hisilicon.com>
Signed-off-by: Junhao He <hejunhao3@h-partners.com>
---
 .../hwtracing/coresight/coresight-tmc-etr.c   | 106 +++++++++---------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index b07fcdb3fe1a..fe1d5e8a0d2b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1263,11 +1263,6 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 		raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 	}
 
-	if (drvdata->reading || coresight_get_mode(csdev) == CS_MODE_PERF) {
-		ret = -EBUSY;
-		goto out;
-	}
-
 	/*
 	 * If we don't have a buffer or it doesn't match the requested size,
 	 * use the buffer allocated above. Otherwise reuse the existing buffer.
@@ -1278,7 +1273,6 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 		drvdata->sysfs_buf = new_buf;
 	}
 
-out:
 	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	/* Free memory outside the spinlock if need be */
@@ -1289,7 +1283,7 @@ static struct etr_buf *tmc_etr_get_sysfs_buffer(struct coresight_device *csdev)
 
 static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 {
-	int ret = 0;
+	int ret;
 	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct etr_buf *sysfs_buf = tmc_etr_get_sysfs_buffer(csdev);
@@ -1299,23 +1293,10 @@ static int tmc_enable_etr_sink_sysfs(struct coresight_device *csdev)
 
 	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
 
-	/*
-	 * In sysFS mode we can have multiple writers per sink.  Since this
-	 * sink is already enabled no memory is needed and the HW need not be
-	 * touched, even if the buffer size has changed.
-	 */
-	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
-		csdev->refcnt++;
-		goto out;
-	}
-
 	ret = tmc_etr_enable_hw(drvdata, sysfs_buf);
-	if (!ret) {
-		coresight_set_mode(csdev, CS_MODE_SYSFS);
+	if (!ret)
 		csdev->refcnt++;
-	}
 
-out:
 	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 
 	if (!ret)
@@ -1729,39 +1710,24 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 {
 	int rc = 0;
 	pid_t pid;
-	unsigned long flags;
 	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
 	struct perf_output_handle *handle = data;
 	struct etr_perf_buffer *etr_perf = etm_perf_sink_config(handle);
 
-	raw_spin_lock_irqsave(&drvdata->spinlock, flags);
-	 /* Don't use this sink if it is already claimed by sysFS */
-	if (coresight_get_mode(csdev) == CS_MODE_SYSFS) {
-		rc = -EBUSY;
-		goto unlock_out;
-	}
-
-	if (WARN_ON(!etr_perf || !etr_perf->etr_buf)) {
-		rc = -EINVAL;
-		goto unlock_out;
-	}
+	if (WARN_ON(!etr_perf || !etr_perf->etr_buf))
+		return -EINVAL;
 
 	/* Get a handle on the pid of the session owner */
 	pid = etr_perf->pid;
 
 	/* Do not proceed if this device is associated with another session */
-	if (drvdata->pid != -1 && drvdata->pid != pid) {
-		rc = -EBUSY;
-		goto unlock_out;
-	}
+	if (drvdata->pid != -1 && drvdata->pid != pid)
+		return -EBUSY;
 
-	/*
-	 * No HW configuration is needed if the sink is already in
-	 * use for this session.
-	 */
+	/* The sink is already in use for this session */
 	if (drvdata->pid == pid) {
 		csdev->refcnt++;
-		goto unlock_out;
+		return rc;
 	}
 
 	rc = tmc_etr_enable_hw(drvdata, etr_perf->etr_buf);
@@ -1773,22 +1739,60 @@ static int tmc_enable_etr_sink_perf(struct coresight_device *csdev, void *data)
 		csdev->refcnt++;
 	}
 
-unlock_out:
-	raw_spin_unlock_irqrestore(&drvdata->spinlock, flags);
 	return rc;
 }
 
 static int tmc_enable_etr_sink(struct coresight_device *csdev,
 			       enum cs_mode mode, void *data)
 {
-	switch (mode) {
-	case CS_MODE_SYSFS:
-		return tmc_enable_etr_sink_sysfs(csdev);
-	case CS_MODE_PERF:
-		return tmc_enable_etr_sink_perf(csdev, data);
-	default:
-		return -EINVAL;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int rc;
+
+retry:
+	scoped_guard(raw_spinlock_irqsave, &drvdata->spinlock) {
+		if (coresight_get_mode(csdev) != CS_MODE_DISABLED &&
+		    coresight_get_mode(csdev) != mode)
+			return -EBUSY;
+
+		switch (mode) {
+		case CS_MODE_SYSFS:
+			if (drvdata->reading)
+				return -EBUSY;
+
+			if (csdev->refcnt) {
+				/* The sink is already enabled via sysfs */
+				csdev->refcnt++;
+				return 0;
+			}
+
+			/*
+			 * A sysfs session is currently enabling ETR, preventing
+			 * a second sysfs process from repeatedly triggering the
+			 * enable procedure.
+			 */
+			if (coresight_get_mode(csdev) == CS_MODE_SYSFS && !csdev->refcnt)
+				goto retry;
+
+			/*
+			 * Set ETR to sysfs mode before it is fully enabled, to
+			 * prevent race conditions during mode transitions.
+			 */
+			coresight_set_mode(csdev, mode);
+			break;
+		case CS_MODE_PERF:
+			return tmc_enable_etr_sink_perf(csdev, data);
+		default:
+			return -EINVAL;
+		}
+	}
+
+	rc = tmc_enable_etr_sink_sysfs(csdev);
+	if (rc) {
+		guard(raw_spinlock_irqsave)(&drvdata->spinlock);
+		coresight_set_mode(csdev, CS_MODE_DISABLED);
 	}
+
+	return rc;
 }
 
 static int tmc_disable_etr_sink(struct coresight_device *csdev)
-- 
2.33.0


