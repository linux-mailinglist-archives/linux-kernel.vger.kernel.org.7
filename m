Return-Path: <linux-kernel+bounces-898729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA19C55DFE
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4710B349775
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5030CDB1;
	Thu, 13 Nov 2025 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A6txQA0w"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F34930C606
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013620; cv=none; b=LUmqHWuksdFLg4116F8HFypo38p7vUArjnxA+5VxpvG/UFwVANIyjIUGJwzMgB15sN+GM82nj+/hbCLiqb+RHcs/5WwS1db7geAgleJuT0qoItIuY0FIphPVOP3r6tgcMiEbQ4CxF3eGWCPMvxyRVB1hJCtmZv9pKMMmdZIKd3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013620; c=relaxed/simple;
	bh=og+duor6kTVv6EdXoUr9GWbzs5DxLFBqI5Qqzo4J2ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mABmjyYOktvE53f6KvtFoNouP09tN1atA4l84Mh8eRQYJc6Wnatsd2SEIEJodMO6RspTPH0u70pZUMaoDmMFSGWZ32hKRoEuxHJTlikpSkmSjEmTROEpaVIT6w58wKoOYcFuuk0CwJ8mXhDcSbLTg9xZoKdo5iFNZv6ZtqNvtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A6txQA0w; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc09b3d3b06so254837a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763013618; x=1763618418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2MsKwRjHGet0iZdm+L439mos6s82lSRuz+v4AoCdTkQ=;
        b=A6txQA0wvi1e6I6pqr8fQvNjJTsDYP7Xhw4xcCvCNB838qVAtJ3ycKGetY35VTucLH
         WCGkspvG04Vw5FfUFsOj8dZU+OKmUtOpgTJUoClTmJjm5W5Ftmlz3tHbcynWWD992dvg
         4CjQzi6jkqNKp/64ptveelAknCgKDAcuIONcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013618; x=1763618418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2MsKwRjHGet0iZdm+L439mos6s82lSRuz+v4AoCdTkQ=;
        b=Mx6CbBPpjCwMp0GYgmFopch3AYr5KaYVAWqdCsP92H9zrfBZJF7XB0VgmstavE33r/
         PDkaqIFXGYNrwnd3IQhqRkvfoTDSBYCb0I5NcuCigpddU/kfda6QO0YZXEvyieZJ9QIS
         6LH2GlPph8XPivY647mS9u09PBThNrw+F/wI60/Q1ITtLZBXeXOJ+CBUyXXeKEHR1VUy
         916dHZge66OH6XCCHSXVaGrBtnwBgF8Ni3iyU+K4fryr/jpAeJGebOdRlh2/YxJ0h72i
         0QiqstjsAWT+U2W+CgRBLRph37QyHcxOTS14bWAapo8wQIaYkK3fXpTYZpcq5M9cZ8Da
         0XXg==
X-Forwarded-Encrypted: i=1; AJvYcCXhdgRcNceKF3v61imY7BW8w7Q2mo19TTvFxrX5CtL/rVydsJXa8oRYDUF/kw8RcGUEyR7x98XzwtBKAyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJpb2Z5mHdqYCMF7sECtPz4CgG4lJcCX3hjhriUn91LfpgxWhC
	gRdCE0RaIm4eKjd1ajkCKMex/+PceeBZb2dtSpK3gpACXMTuGF4LIJkrUdDQJbu6hw==
X-Gm-Gg: ASbGnctBAJ+w+d2O9rtJC7yzNR6j7EP7g7NJlDaRrA/t6Zhf//Y4OQJ8l/Wn1WbW6ae
	NVHPAI5OULFtTvtiWv6AAO3GPr74TjvRa1nerEdcg0Yr0rJZI2j3gOG8Ju5ZuEjIVwyRbk/916i
	O4c4XcCDQ9xT0+ttHec5/wPpVwV/EMf8Xdm2ZGALzOitkRticTW9mWej+4FAIQtDPj/ilv0oaxB
	MWYDO80+gtfgLtojD896QmN6XQt9k7pevWpRtt37MaUpDWJuCAa8rGAW1pYBXpdmxkAFzZT3kKH
	6KhN+h+sxyrqTnFYa+4Q0lvvV3sPcGYYitXWS0Tgu0gIdKtZk+NC4wfqdUI9KJ+7Hb18bDcC7Be
	wNShRHuViCVEnSY78VVB0bfduC7mkShDgJ1nAv9UvLZeHJJE+80ZDdyK/Lce7VfhY04lbehuSgW
	Q8L3ipmDnqmPyf5ij5TMl5jTiwCOg=
X-Google-Smtp-Source: AGHT+IHKwqOTdz8fSIHFxYzQn2PnYKM/6MOyoWIZGjd+D6fPeGOjbUoj6EnnIIRSeDn2FCLZmBDA1Q==
X-Received: by 2002:a17:903:2385:b0:295:1a63:57b0 with SMTP id d9443c01a7336-2984ed9d5a9mr75947175ad.23.1763013617796;
        Wed, 12 Nov 2025 22:00:17 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2376f6sm11463145ad.21.2025.11.12.22.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:00:17 -0800 (PST)
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
Subject: [PATCH 2/2] zram: add writeback batch size device attr
Date: Thu, 13 Nov 2025 14:59:39 +0900
Message-ID: <4b7b8f9c68f1a05ec6ada8aa7be9b735eae57446.1763013260.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
In-Reply-To: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
References: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
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
 drivers/block/zram/zram_drv.c | 50 ++++++++++++++++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 92af848d81f5..d5afe5956a1f 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -570,6 +570,44 @@ static ssize_t writeback_limit_show(struct device *dev,
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
+	spin_lock(&zram->wb_limit_lock);
+	val = zram->wb_batch_size;
+	spin_unlock(&zram->wb_limit_lock);
+	up_read(&zram->init_lock);
+
+	return sysfs_emit(buf, "%u\n", val);
+}
+
 static void reset_bdev(struct zram *zram)
 {
 	if (!zram->backing_dev)
@@ -776,10 +814,7 @@ static void release_wb_ctl(struct zram_wb_ctl *wb_ctl)
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
@@ -793,7 +828,7 @@ static struct zram_wb_ctl *init_wb_ctl(void)
 	atomic_set(&wb_ctl->num_inflight, 0);
 	init_completion(&wb_ctl->done);
 
-	for (i = 0; i < ZRAM_WB_REQ_CNT; i++) {
+	for (i = 0; i < zram->wb_batch_size; i++) {
 		struct zram_wb_req *req;
 
 		/*
@@ -1156,7 +1191,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2797,6 +2832,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2818,6 +2854,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2879,6 +2916,7 @@ static int zram_add(void)
 
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


