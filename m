Return-Path: <linux-kernel+bounces-755048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092F4B1A096
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6DC3BD653
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 11:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59882561B6;
	Mon,  4 Aug 2025 11:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdT+Vb57"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328124DCEC
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 11:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307005; cv=none; b=DvIsmyBmcZdsr5t/ZGgRlK+AbHnoQ09jwgCtWgO0MkkUiuA0+yk0GOTUtqR7BrwZj2A6f+/FbXfc4TKAbFFC99w+17lb0ITPAxdK9y7QI6fMi5EApALjjhaMCHSqhVX8fk5416ibONvsn19ePUd5QMokF4KrWZriC4ie5u3S3oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307005; c=relaxed/simple;
	bh=tTDUsBXsPeQGzlryvB0NPAsroThBBrNMmq8k5cEQFwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R4pj5LWyUo8CIXloIqWXLshuv5r5geri4JrQpUqUZGftkNtgDNKJM8a2Af1YBs3g6JqTGM8LjFyGS/18kUnRpqt0i2CE4lECmtHO0MIH+Jr1nv5MiaXSe5GepkRNLtGNdqMlprLerPlv+43Dpa8FayOrR+bAczRmipWcCWTaFbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdT+Vb57; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-76bc55f6612so3617110b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 04:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754307003; x=1754911803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wvgE21mt8Nkxs3REibthkNPZrx5ubt1AxIt2mJnpkqw=;
        b=XdT+Vb57ARdXcI/vaAzwbY6V+eB26P0vJiB6dEdfLNiKwbfyBx4e4K6CJYT53TfCZE
         fS88dJgxi6+L7wYOXYACHNjsOZWjqIDS6zwpSEgydfGBQeltM38XTumxEvAEECjkWlTM
         xOu/qsF7XnbJ7kNmXKzRxKLXMQFZbfGxGqE49O2dXA3FpN+iBpNg7qVhxeGDLFSgen1P
         QKyCjyHmax6i1Xv5tdhobrYJYRJVKxpkje4g4AF5HhlMbs8BnjdcYnOfn+yR2j5Ytuvl
         Rkwljrsd/5/gL+FSMQ9iUcGEuKypoVtfT0ToJlsisgS6pVJOAX2fRNxbkF2hb5trkBTj
         2X0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754307003; x=1754911803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvgE21mt8Nkxs3REibthkNPZrx5ubt1AxIt2mJnpkqw=;
        b=dEHz7zALdGn6HZLlhiCnVOwVMkbEOq9ZJyDtBY6uQptPp6s4R+YE+IUkYrNNHTV3jh
         5Vc5iQZwY2ZfQCFGObXvi29lZyO2HakoYqLK/i2FuVeRm5LwjU1PtoLn4DCrQ8TeN1WF
         oMD1d1pJwu/KhjUNxegnN9nS8gvD/FOltk47VfhEKeKAf3l9F9NEECuxJE6opwuA00PM
         S7zZnOHMS/+P/EJT7K71LfdXrxswMdNyJrKEp9MoMPVqINvHfKr7ktvmctRAyCkz1QGH
         +2f7jOA1pl5NMn+TV0KNKIgrt3Vh90s0T4hW2l2Xy3pehG2wS9ULLsiY0htAPR3DVXO+
         l2WA==
X-Forwarded-Encrypted: i=1; AJvYcCXLE4UxMKXoDDp80tkbO0N40uAJSWL/sLYsHwJTuXbKdh21iuLCbL/9yyvLTP+G2cRhT+Dr/LRFz8lXPRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YycvB2aGC5e41j273CxHFzQD+wz3LwNvkc9AaP4MSVtyfqMqMmG
	QNQttn1KbORyj9eDe7BNsOG90CcOJs0+NmLwhaD65KsmfSpeDyD3DJGa
X-Gm-Gg: ASbGncvM4znGxASZwTcjtDbZELxhc0CCTzm+wzFKJJKBLgdqRideJ7Dt7UOYmhsTeIn
	4MHQ5wdv84bA0s23yZTPxp6UZd7FodXvm6BbsHk9dwzAkc8VuJILP2NnteClQCqZjmhHmD4lCR8
	mrBCBdURh6gQiRT6MJ+qnLtgbPOObY1stRpOac+TxMRWFlBMp7sV/0qKEU0bG6M7ytJGSlYx2Eg
	kDc47g96ioJn6/cguyDRU3+ZYWqerz3+JMtFfsO63Va+XpTTPUkSx7YRlvEu0MfZBnSqZfhE8g8
	czx2l0jyIKl3AQxoElneoCpZX4mscsQlu188eMXSdz2VB56RpUkNn4G9TmhePf6TOsVgZDWAd10
	k95PLIGTFfQZHhJSnv5lGqFWONT5PInHG
X-Google-Smtp-Source: AGHT+IGzu6hKk4pv2fmINX8NvSw0SR6b16DoazjKoD+x2PNZOZIigvNZIun/V7bREmyAtP2VlzWf6g==
X-Received: by 2002:a05:6a00:2d0a:b0:76b:ea1e:78b9 with SMTP id d2e1a72fcca58-76bea1e7b6cmr10521687b3a.1.1754307003180;
        Mon, 04 Aug 2025 04:30:03 -0700 (PDT)
Received: from avinash ([2406:8800:9014:d938:f647:9d6a:9509:bc41])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bf8f12c95sm3999526b3a.2.2025.08.04.04.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 04:30:02 -0700 (PDT)
From: Abinash Singh <abinashsinghlalotra@gmail.com>
To: amit@kernel.org
Cc: arnd@arndb.de,
	gregkh@linuxfoundation.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Abinash Singh <abinashsinghlalotra@gmail.com>
Subject: [PATCH] drivers/char/virtio_console : refactor resource cleanup to use scope-based helpers
Date: Mon,  4 Aug 2025 17:00:20 +0530
Message-ID: <20250804113020.620352-1-abinashsinghlalotra@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This refactors the 'alloc_buf' function to replace traditional goto-based
error handling with scope-based cleanup helpers.

No functional changes intended.

Signed-off-by: Abinash Singh <abinashsinghlalotra@gmail.com>
---
 drivers/char/virtio_console.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 088182e54deb..9875f5f07b32 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/dma-mapping.h>
 #include <linux/string_choices.h>
+#include <linux/cleanup.h>
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
@@ -404,7 +405,7 @@ static void reclaim_dma_bufs(void)
 static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size,
 				     int pages)
 {
-	struct port_buffer *buf;
+	struct port_buffer *buf __free(kfree) = NULL;
 
 	reclaim_dma_bufs();
 
@@ -414,7 +415,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 	 */
 	buf = kmalloc(struct_size(buf, sg, pages), GFP_KERNEL);
 	if (!buf)
-		goto fail;
+		return NULL;
 
 	buf->sgpages = pages;
 	if (pages > 0) {
@@ -432,7 +433,7 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 		 */
 		buf->dev = vdev->dev.parent;
 		if (!buf->dev)
-			goto free_buf;
+			return NULL;
 
 		/* Increase device refcnt to avoid freeing it */
 		get_device(buf->dev);
@@ -444,16 +445,11 @@ static struct port_buffer *alloc_buf(struct virtio_device *vdev, size_t buf_size
 	}
 
 	if (!buf->buf)
-		goto free_buf;
+		return NULL;
 	buf->len = 0;
 	buf->offset = 0;
 	buf->size = buf_size;
 	return buf;
-
-free_buf:
-	kfree(buf);
-fail:
-	return NULL;
 }
 
 /* Callers should take appropriate locks */
-- 
2.50.1


