Return-Path: <linux-kernel+bounces-898973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D285EC56771
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5CD2934B599
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 08:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C69A033E372;
	Thu, 13 Nov 2025 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BqSw3m1E"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9105B33DEF1
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024072; cv=none; b=ISyYeAxOywYZeU12BYZKBKN1r6xhkmxi4ZwlzN5kl3lPCn8Ac3SWGGtw+XxFTS4OhwEvQm+OyBXY/e37hIJTmquokyq+UgCN3dHmh608cHnQPqXmlGEO+RBkglCfP/v5LOXfTfn+ASZ27/Fq1VDGQko4bsxZP7SlAfTCGAiYybU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024072; c=relaxed/simple;
	bh=G15zDhQSGXlkHBbvJ2D+mkyD9RCtv0j0QopfMySJkbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKAER6LDeuldd8NXEnnSOrbQWvJ219isXyR/MJNiNhYPVGQI6eBmr7tFM8FPui1ihTvrcxoYe7EP1WbZNc5RdpiR+IO+i4qSVHb1kpBfWACCMfctA8JXIXYUJX1RhzrreRmsgsnQRZ9Xkaf+qsXZYknVX0iwbPud2MO32DFx1aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BqSw3m1E; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bb7799edea8so425005a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 00:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763024070; x=1763628870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66o8xvNrn3Zh6yfKx4kveyWbQRFbxbGWIXOV/eFIVRM=;
        b=BqSw3m1EKNyFz1IuhOERx7JwslfTdwBEVb/7wYg1qGuPO1fJ6pC/SGWuvbwrobFaGe
         6uyDr0IaJ53bUv0KnSXcHT9+A3s/lkvIj/Vo3IsVQEM7D/KRWLlbAWydImper7Y3E4gH
         6vObSv3Iqc22iBjnDNCaZZq1jzL+SkTTqZfO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024070; x=1763628870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=66o8xvNrn3Zh6yfKx4kveyWbQRFbxbGWIXOV/eFIVRM=;
        b=bsC5gupndWXQz1ieHeb5nu5adwInwzYweVExKe+qVGRsSbVfvg9Ri631b+ZmQ61cFU
         IcOulKWr592lm+3SjHYop56oDVsQiZWpFkVW5r+TClnaYYy/x0azF8MCHNQlYsiRHCZ2
         1vZhp85ORPvFNojOJkIQnQYlyXTOwQgkBXoSszqetq3+4sAPNa5XY/eXFMHSwum02Kfs
         2Ytxqfw96eVjNO/Id65ujyj90XgQsSZzeNMjdyMpNdKODCmVwyObBNULRjM7e4j2/46x
         ehtRTfOXrQ+mDyaIDzIrYzQTwnE2fUPNfIvt/cBSy8JnWys5x9L6/MbJAfAPDzqQjwzt
         9+0w==
X-Forwarded-Encrypted: i=1; AJvYcCUVwFF+XS0TXhjWx6IYeMyeuOfx8aaVjq3QjMiDalyOYvEnV35q85qNRIbww8l06W9KVKhTi6RarVuCNYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMlNI9oZNNz5S063xSPod+rNxvbwoRF3OIosJEve+lJcipL7Bb
	vePgfPRuqYP7kWP+ODGuVBK8DTdbly7xj9qZAHh95mnFrUZX3+fMwl1EuA9kFbEoxw==
X-Gm-Gg: ASbGncs56BXgyGnNcXMP1VIFOgpBiefdjDqKDNCVcOP6tE2lOaI9c09NKNPSGuJunxd
	KDn5GQGs0WG0VGHIF7wTJUBzVZf4VtJjcFmNugOXVlDhk3w0oZsKM/RncWHXUsfrx08w4mn1bzC
	RsjOL18HiE/4jC1krrsTigVq+Cxrm3yX/Kyo+mie3WjwNm4BTrszZhooulHq+93g6YDEfnl4ssn
	45clUHwy2TotRCl+pM8aWb8L9whGacSQptSYyphal/A4zOJenn3gM7yjMQcTTI98cING75fbJWf
	3uub0GYFsDhDSPbJJXTJkm0fzWWG12eroG0RtvUDOUmiDdKFgJfPm7PHkrAn2KjsXfNoSaSmKvC
	rbQoV5409aF1M/rAqQGjJP+N5bXDCaNTLjHHXvy4+1suB45iF2eppkVyLvYEWg9VeBYK0jglFpP
	VD8puoj5gCP/WmfojsSTUV/2660DSsUgcjgLPq9Q==
X-Google-Smtp-Source: AGHT+IFCr46cECMeVud8wNJtWIGj5BffLnOQD6s1PPHNzh+xi7UWKBaPjYSgkMNd/Mok9dJQQjAbaw==
X-Received: by 2002:a17:903:1ce:b0:295:73ce:b939 with SMTP id d9443c01a7336-2984eda94dfmr81834785ad.39.1763024069976;
        Thu, 13 Nov 2025 00:54:29 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346f3sm17486465ad.18.2025.11.13.00.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 00:54:29 -0800 (PST)
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
Subject: [PATCHv2 3/4] zram: take write lock in wb limit store handlers
Date: Thu, 13 Nov 2025 17:54:01 +0900
Message-ID: <20251113085402.1811522-4-senozhatsky@chromium.org>
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

Write device attrs handlers should take write zram init_lock.
While at it, fixup coding styles.

Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 drivers/block/zram/zram_drv.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 238b997f6891..6312b0437618 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -501,7 +501,8 @@ static ssize_t idle_store(struct device *dev,
 
 #ifdef CONFIG_ZRAM_WRITEBACK
 static ssize_t writeback_limit_enable_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+					    struct device_attribute *attr,
+					    const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -510,18 +511,19 @@ static ssize_t writeback_limit_enable_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
-	down_read(&zram->init_lock);
+	down_write(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->wb_limit_enable = val;
 	spin_unlock(&zram->wb_limit_lock);
-	up_read(&zram->init_lock);
+	up_write(&zram->init_lock);
 	ret = len;
 
 	return ret;
 }
 
 static ssize_t writeback_limit_enable_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
+					   struct device_attribute *attr,
+					   char *buf)
 {
 	bool val;
 	struct zram *zram = dev_to_zram(dev);
@@ -536,7 +538,8 @@ static ssize_t writeback_limit_enable_show(struct device *dev,
 }
 
 static ssize_t writeback_limit_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
 {
 	struct zram *zram = dev_to_zram(dev);
 	u64 val;
@@ -545,11 +548,11 @@ static ssize_t writeback_limit_store(struct device *dev,
 	if (kstrtoull(buf, 10, &val))
 		return ret;
 
-	down_read(&zram->init_lock);
+	down_write(&zram->init_lock);
 	spin_lock(&zram->wb_limit_lock);
 	zram->bd_wb_limit = val;
 	spin_unlock(&zram->wb_limit_lock);
-	up_read(&zram->init_lock);
+	up_write(&zram->init_lock);
 	ret = len;
 
 	return ret;
-- 
2.51.2.1041.gc1ab5b90ca-goog


