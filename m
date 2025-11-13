Return-Path: <linux-kernel+bounces-898972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E525FC567AB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2E602358E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A76433DEC0;
	Thu, 13 Nov 2025 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OBT17WO1"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D3233D6D9
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024068; cv=none; b=CQ+CIMOwppKqJyqtI9431w8aDkbsh3HZIl2C3TAzjyI3kqZGtqOCsuKEUMTo4qm1JxY/Qgfc9v6ivC8hUSBEeorJOT+RRqDfnCYmLVgxRpwil53/kTbztK26AHV0kpmWhI2rJWK8cGSQVZM3NMgdybhknz/GEP3I4JHbZaFCAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024068; c=relaxed/simple;
	bh=ldH7pRzrAo36eX2sXr7TZBqNdm9QeHPB/CJSrJctR1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5QdGsHhbjIs0z7RQILfAdw/uiEZVDgbwGKjJo+GMLRalUK7e5wz1AfhrxuKf06Cvajo3WApSqyiZpmf1hmq9XsBFhUrs0PypMm4p4V40i0aEMkB3zwyoIfHgRmtBBmMsCNEtIfnT/N6XXSZYrpFBDNbdkSidNvpyC5z3VggkYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OBT17WO1; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2956d816c10so6320985ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:54:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024066; x=1763628866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aPh7ilOkJcTxNjuYqTovUMBkJNBd0ZFj5iFNSZBggZc=;
        b=OBT17WO10C2XCNHg66/2dDbK+GzYwoCrlI/8jGjV5MAIKBDNW+ND4LBETe3Ya4YJfs
         qPH/hF10J4rSAvLmzAz8sVY+IVXahAfDpH4p9OzCOSHBWqzrEp0NT60V6ELR8/7VT94P
         dqIyaDUwLwypXoiRtTumvGzowfnB4qqbw7FyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024066; x=1763628866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aPh7ilOkJcTxNjuYqTovUMBkJNBd0ZFj5iFNSZBggZc=;
        b=brwJbBLi126SRjMUWHiABBnug2c+NssfQDrcLvuE5wf+XxUMGHmQVV/7wGKkVyCp7z
         CBjCbWADWJTUO7tt4vap934omZ72qUfH6ypC1fRevFk0d5Xy8jYWcqmIp4dlhDQ45bSt
         sLyM7U6j5nzvHDynlbC/IyQ7PL+cL9CUctr0piojafp5nA2fyEgc6WN4VRzeULjPtGOn
         IkSwh3oMNxrq23YmBkPJ7OEDsa2QIZXPtU1aW8mKLxHpo+VrySUlNTrRwqjmwM9LulKV
         ioDVMakSGRGopn3ApGzCKT+QwFjrYQRXEXtR/Awhl35RrA4xSPoDvqAWpnuUPyPFsQrD
         HAWg==
X-Forwarded-Encrypted: i=1; AJvYcCXE4Y3p6eKYDPx3cid3XGrkal9O6B2+vkxxZ89E4aLko2y12wRHWuHS7Sx8gYoD3D3bcvnVV3hWgQhTKyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIbY+x/6xr2MVo8G4NSZCS3j5OosPdr9fr3wPtVx5rgrwTVSJp
	MtUsrZLTM4DVW5oNhiycfB1Dvs3yUl/0Zgd8IMlTRwHDrJWWIRHWa2C15bMdytlGlQ==
X-Gm-Gg: ASbGncux6mCx7RBJK4qaDcV+4XBfd417NcR2yCYbqq/hLhx8AObwAGwQ6s5a0HWwnS2
	kNAL4sLx9eLMeAI7ia4CNCjG74YYr1EkPd2Fwu2FQBUEWKsAxaXm0EK8Nl2qrbUui7DdJep+7kJ
	6vT4Oad+C/s5vkFjDNSCsMSCGmPXs9sTK4cT24V186VaMU2QakNuvHp4hnj+zcFG+qP8TUg3jyP
	OFna/nGOacdbUjBTRKMuYsSqt4vW9dUZOMhyEb9f78TJMaxhi/A11dLzvx6M5J/+NmUtuQyxFJV
	LXDihS11vskFCIuhPAArRU9/hjq5EHD0u1SnBZDg1GyLEPQ7+dxNGZs07PluNmR4iyvRZT/BLip
	JG/8s/09k8CGpor/tWlfcnBCKJOFf37q2m91RPqLD3l67ivibwrdYEHg3mDbUFlpwHCybZsBQHk
	G1Edf4Qoj0w+2gdpcesgfCJav32Z529hiXMgDODQ==
X-Google-Smtp-Source: AGHT+IHDznvOsg6P+PZ5zeENKccT9BP5vgmm7k+qpOBrv2DZh+4wB1td4Wp2IINZJb4BaEgtt31Ibw==
X-Received: by 2002:a17:903:13c6:b0:295:4d50:aab6 with SMTP id d9443c01a7336-2984ed92f90mr78132405ad.18.1763024066402;
        Thu, 13 Nov 2025 00:54:26 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:25 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>,
	Yuwen Chen <ywen.chen@foxmail.com>,
	Richard Chang <richardycc@google.com>
Cc: Brian Geffon <bgeffon@google.com>,
	Fengyu Lian <licayy@outlook.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCHv2 2/4] zram: add writeback batch size device attr
Date: Thu, 13 Nov 2025 17:54:00 +0900
Message-ID: <20251113085402.1811522-3-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <20251113085402.1811522-1-senozhatsky@chromium.org>
References: <20251113085402.1811522-1-senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce writeback_batch_size device attribute so that
the maximum number of in-flight writeback bio requests
can be configured at run-time per-device.  This essentially
enables batched bio writeback.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 48 ++++++++++++++++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a0a939fd9d31..238b997f6891 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -570,6 +570,42 @@ static ssize_t writeback_limit_show(struct device *dev,
 	return sysfs_emit(buf, "%llu\n", val);
 }
 
+static ssize_t writeback_batch_size_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	u32 val;
+	ssize_t ret = -EINVAL;
+
+	if (kstrtouint(buf, 10, &val))
+		return ret;
+
+	if (!val)
+		val = 1;
+
+	down_read(&zram->init_lock);
+	zram->wb_batch_size = val;
+	up_read(&zram->init_lock);
+	ret = len;
+
+	return ret;
+}
+
+static ssize_t writeback_batch_size_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	u32 val;
+	struct zram *zram = dev_to_zram(dev);
+
+	down_read(&zram->init_lock);
+	val = zram->wb_batch_size;
+	up_read(&zram->init_lock);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
 static void reset_bdev(struct zram *zram)
 {
 	if (!zram->backing_dev)
@@ -776,10 +812,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
 	kfree(wb_ctl);
 }
 
-/* XXX: should be a per-device sysfs attr */
-#define ZRAM_WB_REQ_CNT 1
-
-static struct zram_wb_ctl *init_wb_ctl(void)
+static struct zram_wb_ctl *init_wb_ctl(struct zram *zram)
 {
 	struct zram_wb_ctl *wb_ctl;
 	int i;
@@ -793,7 +826,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
 	atomic_set(&wb_ctl->num_inflight, 0);
 	init_completion(&wb_ctl->done);
 
-	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
 
 		/*
@@ -1182,7 +1215,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2823,6 +2856,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2844,6 +2878,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2905,6 +2940,7 @@ static int zram_add(void)
 
 	init_rwsem(&zram->init_lock);
 #ifdef CONFIG_ZRAM_WRITEBACK
+	zram->wb_batch_size = 1;
 	spin_lock_init(&zram->wb_limit_lock);
 #endif
 
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 6cee93f9c0d0..1a647f42c1a4 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -129,6 +129,7 @@ struct zram {
 	struct file *backing_dev;
 	spinlock_t wb_limit_lock;
 	bool wb_limit_enable;
+	u32 wb_batch_size;
 	u64 bd_wb_limit;
 	struct block_device *bdev;
 	unsigned long *bitmap;
-- 
2.51.2.1041.gc1ab5b90ca-goog


