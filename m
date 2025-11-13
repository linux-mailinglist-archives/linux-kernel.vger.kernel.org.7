Return-Path: <linux-kernel+bounces-898685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C29C55C3F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AC003345B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 05:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE2E3054C8;
	Thu, 13 Nov 2025 05:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j6+jjynw"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCF329D29E
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010615; cv=none; b=U6CzLVzBhxnBCfSKBDTFna281tVUiguDtG3N2FAf84ITo+rZMzwSYAVD0SF8vPbvMO/6aUZ1alSrLE7v2xU7yRBbLFENECU+jZneMDbv3YLFsBsoVXGR202yxszMagYQ33Gn6Rn7Kyemp471fBEdNq6SkUytR9wGaPOCrF6QW8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010615; c=relaxed/simple;
	bh=cMx4qen1C9cTMSARxh2QYlJlXXgdR4BaF7yclib3aXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4nOp7DEi05lP0C9eRAC2Bv89TGVnTW+b0c+ble/kQN3ULrAOlMcnCIYzfL0O/gQzKPILrRWr7N3soVe2PxgBWR6E643Hm5PQdJP3TbJUme9W2Rv+Yl8gkZDT4Rqq8+/K1sKszZ2acTFwphAgxKyaTDGSO64WNvnKOBSVnGN0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=j6+jjynw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-297d4ac44fbso11463665ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763010613; x=1763615413; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQMe04Yi7xRdtm756UdrAtfkVrI3s7FJjDivoW7Ul4k=;
        b=j6+jjynwqgDyrbdE6uHsFWQoXLsY0dXHLaCShP9kEZQzUAroEwXURRZdgUAMfX6S8+
         ePhznHm78xeAhfNzIDiCOJe9r00XbikWtZxWQ4pJnCqF97SYmzeNK0nleHbSPIr+HpL/
         2FUXHDA8bPDMWLXSh6GdQY0uxPTPrGm7Dt5tE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763010613; x=1763615413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQMe04Yi7xRdtm756UdrAtfkVrI3s7FJjDivoW7Ul4k=;
        b=hHhJBlmE05Nre/mmFkeA7Jte6gOlEKvhIJYgSA//kDDDjILqRGcUeYVxxToCgdOxX7
         biqcu5XHsSnEKvn1fT5ofwgT2/3G7KNiq7h1JUsiTbgvSo4ET6hS6HFH7xHwn2aQpYb9
         PMaOOr8NRxUlSkhkNRzuVNQW9bZDJA4EPvoWBzxEi+dSbCvNDVpqCxZFz94oqO8FX5Se
         qFJo2vobx6TWb+DSIGhnfZbtfvj2Susso2nFpk/3tHgHPdZzBFA4kWyas1AaTcc0Z69M
         md5DiJtER9YaYO9rZKjHLV0E/DVeyAzKU7qrTUaJLO7pjxUrmgDNAjpphXoED3NB48Yd
         72Tg==
X-Forwarded-Encrypted: i=1; AJvYcCXfxKQ8w6r13Z4RI/Cugt7q6oDbbnju/R/aAyXq8/CP6+Xfg2Klt6fkS9/iKYQ57H4xr6diJYMowe3zMKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJE2fsrXHwgK6KB/Dn1r1y4Mg5sTK/o6F6FH0TcGyYGY/1N2vo
	DBD7LMvrnb05BeUhIgucDeZI1fusruNKg3ANKRk9OVM2oNAfjvxYk6uqWGBYe5xu1g==
X-Gm-Gg: ASbGncvhOx72A86zRyQI10s2gxAaB6KdY7F/G9wKNCieh8LYZFtJH/gD+acnx1xuJNO
	j0FjQMGNt7hwt1jf7YTg0bE1JczTYHZSdFhNQlsSK9kFCkLB0x3wq7zmZ5FdlXuh5SoCOPIsYxr
	wRjqK+VVc8Drt3SUUpZwBYRJJq60KcuG+xpSK+1U1PW0hWXFv6i6TI29/65M0xHqryBfbHbX9uz
	gA8UjTOlwh1ALw9cIxegtC291Xs7iY7Y5OhMbO1kU9xNe8HSjyaWCYjinvFP2pX4lpy2tDhqLSi
	g7WpwNklPKyE7sNlwvXK9p5gFAFA/iw41BPAS9VuIUhYcFHbnfZL5SbfEZk2RBYGPVVmpT7xxeV
	o0/mnsUC8y5TbpxmweF4QlsflAMv/X22kWA7MxLQo11KbRLysxVdrGs94DaE2kkFVlRRSru93ku
	xnRZI2
X-Google-Smtp-Source: AGHT+IFaLW8GEDBcsoapOHe3wZi+rPMM3f3HSMv0BD1FRNhd+sUeimcHYmWoETvZ4VyiSFWPGjfTLA==
X-Received: by 2002:a17:902:ce07:b0:24b:1585:6350 with SMTP id d9443c01a7336-2985a4dd2b8mr29219475ad.11.1763010613390;
        Wed, 12 Nov 2025 21:10:13 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm9713465ad.18.2025.11.12.21.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 21:10:12 -0800 (PST)
Date: Thu, 13 Nov 2025 14:10:07 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Yuwen Chen <ywen.chen@foxmail.com>
Cc: axboe@kernel.dk, akpm@linux-foundation.org, bgeffon@google.com, 
	licayy@outlook.com, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, liumartin@google.com, minchan@kernel.org, richardycc@google.com, 
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v4] zram: Implement multi-page write-back
Message-ID: <mc5ww2wi6islokdc4kwu2pw4a7l5ufwigsfw4b626okq5uk2ic@f5x2otsnarws>
References: <83d64478-d53c-441f-b5b4-55b5f1530a03@kernel.dk>
 <tencent_0FBBFC8AE0B97BC63B5D47CE1FF2BABFDA09@qq.com>
 <rjwycg4sfzuroi3yzsovtebwocabyoq4vq4fuc2cbh3w4n3uo3@o7dpmtvqr7fe>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rjwycg4sfzuroi3yzsovtebwocabyoq4vq4fuc2cbh3w4n3uo3@o7dpmtvqr7fe>

On (25/11/13 11:04), Sergey Senozhatsky wrote:
> On (25/11/06 09:49), Yuwen Chen wrote:
> > +
> > +#define ZRAM_WB_REQ_CNT (32)
> > +
> 
> How was this number chosen?  Did you try lower/higher values?
> I think we might want this to be runtime tunable via sysfs, e.g.
> writeback_batch_size attr, with min value of 1.

So I think something like this should work:

---
 drivers/block/zram/zram_drv.c | 50 ++++++++++++++++++++++++++++++-----
 drivers/block/zram/zram_drv.h |  1 +
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 10b6e57603a0..cf92d4e8ca9b 100644
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
 
-/* should be a module param */
-#define ZRAM_WB_REQ_CNT (32)
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
 
 		req = kmalloc(sizeof(*req), GFP_KERNEL);
@@ -1145,7 +1180,7 @@ static ssize_t writeback_store(struct device *dev,
 		goto release_init_lock;
 	}
 
-	wb_ctl = init_wb_ctl();
+	wb_ctl = init_wb_ctl(zram);
 	if (!wb_ctl) {
 		ret = -ENOMEM;
 		goto release_init_lock;
@@ -2786,6 +2821,7 @@ static DEVICE_ATTR_RW(backing_dev);
 static DEVICE_ATTR_WO(writeback);
 static DEVICE_ATTR_RW(writeback_limit);
 static DEVICE_ATTR_RW(writeback_limit_enable);
+static DEVICE_ATTR_RW(writeback_batch_size);
 #endif
 #ifdef CONFIG_ZRAM_MULTI_COMP
 static DEVICE_ATTR_RW(recomp_algorithm);
@@ -2807,6 +2843,7 @@ static struct attribute *zram_disk_attrs[] = {
 	&dev_attr_writeback.attr,
 	&dev_attr_writeback_limit.attr,
 	&dev_attr_writeback_limit_enable.attr,
+	&dev_attr_writeback_batch_size.attr,
 #endif
 	&dev_attr_io_stat.attr,
 	&dev_attr_mm_stat.attr,
@@ -2868,6 +2905,7 @@ static int zram_add(void)
 
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

