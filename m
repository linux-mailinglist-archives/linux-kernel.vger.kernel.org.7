Return-Path: <linux-kernel+bounces-813678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B111B5493D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:18:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB911CC35E3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E42E5402;
	Fri, 12 Sep 2025 10:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dys+1hov"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1E32E2EEF
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672056; cv=none; b=Bn6H3I9l33AElUKi5AIKg/ij9LdxSFXxRqDkRDJO5YOo5RpwpxQ5+gquhzGtIth00anLmHz8s7XEF76D9OUBELoZYSIrTeaJ/jHfA2+H2bRjPUcOmszw2WEG0/bzbxvCTestZrdop6rWYTi6BjbHGzPoneIdBfrcRdm340lP6NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672056; c=relaxed/simple;
	bh=S0CYNS8Szt1T/6CxlU/rD4KtR5pqM3gNqPSUty5uqQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M1TCxfppnncbMmm2OT4i3OIY216z/saIn9d6PJUmeAHuWw3Va5OT2uSxDqu5HB2xYeqRmdmNxVLcKAiMAyX+fOIIBmL1U2ChFcI1Gwfr6qp8MNQRcdutGsfN9llMaFw4NQCyAPI7KCRnL3GkJNxfdzvHI+OGpDGMk7v2Gu1Frmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dys+1hov; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so12585765e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757672053; x=1758276853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SJ8f3Qn/TyGlr/n0NexKSayuju02h7Q6FXYl3EBTkXU=;
        b=Dys+1hov+bQkgmud6086PXk6vd2zpACrbUoIjZyvkDglQ4GW5iTKlx1HBeWGs6LA6q
         gsW3kVkMX4TdK8CaTI1hHxu27PhT5uK0j+RUfuur0QYnTFstrcbdJperY5wcCA+8PYOO
         R8tuASbdVJD6tSpfDp2TODc4NzFvO83O8sYJrTXmnvuS4eMfLuDYl3pR7Ouvy9gJEJtF
         XMShxbmwQfFmbJutcBdAeLsxMxwWOozYCkomeQ/J8YqCT6QI0tSRh/AWImdBaisSt5ao
         4v86hnfmBdvzRLZLYqqYSeH+dp3ZR29fxeehtLrdDvnJkfLqqEcG3ZqFfjFPi96jSngx
         VU2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672053; x=1758276853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SJ8f3Qn/TyGlr/n0NexKSayuju02h7Q6FXYl3EBTkXU=;
        b=Pthlw6PH8HB6q65PAkFPL7yGSQY62u5ujYAg7J4bbXJgxHF0Ace1EuBQHZmggH4AXO
         lKldy0vLWESz9QJwDRjyPHC6KMQ7OO8sMRBsgiqqJn+f4u/bZTmhULDgNq5aBnnlCYGP
         8e3VAMDM1vA6fxasf4gbBx0jBFIICpCvkoXIla3YfJowI0mNOQNlYw4VDY97DeaVsN4Y
         5NZpnN1xgVMvqBfqgjLECaZwPDoOOG5lJl6yxm8AUvXJjzCxNiY6kRXcOLt3VS3uCF1O
         ziANiy/7NxlP5oejRXhNPHCXzEnlTFIyw1A3OcoAbGnYQvPJ0gOSRPcHvCfKftGTTOer
         AnBA==
X-Forwarded-Encrypted: i=1; AJvYcCWhzkeiUSlDy/BTvI3Yco26RSv4XKG+QxmZheJrXWUvJrX9RNYpezLR0lnNi9XsjHyKX6Tz4lpxtaAEcuM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyccUmT83LXDkBKH1+6qzy07J8GveUaHNztsz8J4pzO8ykavOu4
	e2fdg3i2cjtMEtF8TyO0h+pM8HLr6l5lhXM69Dbr/3D20O6UQgfDbBxp1NnhSA==
X-Gm-Gg: ASbGnctOEQUyShaNkmRnCoBM7eGeWa8chhsX4pF5gI+iNmu6nWv+B6atx6yKQda/w49
	D/mPZeuKYUDsT2RxL9I89CP2DeMQI9OucTPA1re2VxYBl2EmptmyJ6oQTidtZjnCgFlprKjHZok
	RBxY/AUE6Mts60V2ryWk8GXEXgBObybWhnXxwIZ3joUgQOSvjFA5kBfiSlh78A7TgRlIde7a5yK
	OGSx0rEzkbUXeBxVYXKp50frQO6VWabHIAI3/lRgY4cw42kF9p5MNFTy9ay9WxxNhCHigv5qZ9r
	tjVZExwQnNOK9VZ8DnbDkFdMyA64DCZKp1qQW0rvmvkcyAaajhmgvzUH8/sNLfJcXxrqFxY/nrd
	CcbzhvNZPEkBXqmRAGu7wZy8i0z5aq07I5g==
X-Google-Smtp-Source: AGHT+IFYtoJgSByXetv839cGOJvOKyTq/Qw00RovSeH57gD7S6jTJAoFmT89063appVm2NhMPpwCJg==
X-Received: by 2002:a05:600c:45c4:b0:45b:9912:9f30 with SMTP id 5b1f17b1804b1-45f211ca9a5mr25520265e9.6.1757672053190;
        Fri, 12 Sep 2025 03:14:13 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0372b983sm56542395e9.9.2025.09.12.03.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 03:14:12 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: gshahrouzi@gmail.com,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] staging: axis-fifo: fix TX handling on copy_from_user() failure
Date: Fri, 12 Sep 2025 13:13:21 +0300
Message-ID: <20250912101322.1282507-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If copy_from_user() fails, write() currently returns -EFAULT, but any
partially written data leaves the TX FIFO in an inconsistent state.
Subsequent write() calls then fail with "transmit length mismatch"
errors.

Once partial data is written to the hardware FIFO, it cannot be removed
without a TX reset. Commit c6e8d85fafa7 ("staging: axis-fifo: Remove
hardware resets for user errors") removed a full FIFO reset for this case,
which fixed a potential RX data loss, but introduced this TX issue.

Fix this by introducing a bounce buffer: copy the full packet from
userspace first, and write to the hardware FIFO only if the copy
was successful.

Fixes: c6e8d85fafa7 ("staging: axis-fifo: Remove hardware resets for user errors")
Cc: stable@vger.kernel.org
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 36 ++++++++-------------------
 1 file changed, 10 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index f54614ba1aa8..c47c6a022402 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -43,7 +43,6 @@
 #define DRIVER_NAME "axis_fifo"
 
 #define READ_BUF_SIZE 128U /* read buffer length in words */
-#define WRITE_BUF_SIZE 128U /* write buffer length in words */
 
 #define AXIS_FIFO_DEBUG_REG_NAME_MAX_LEN	4
 
@@ -305,11 +304,8 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 {
 	struct axis_fifo *fifo = (struct axis_fifo *)f->private_data;
 	unsigned int words_to_write;
-	unsigned int copied;
-	unsigned int copy;
-	unsigned int i;
+	u32 *txbuf;
 	int ret;
-	u32 tmp_buf[WRITE_BUF_SIZE];
 
 	if (len % sizeof(u32)) {
 		dev_err(fifo->dt_device,
@@ -374,32 +370,20 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		}
 	}
 
-	/* write data from an intermediate buffer into the fifo IP, refilling
-	 * the buffer with userspace data as needed
-	 */
-	copied = 0;
-	while (words_to_write > 0) {
-		copy = min(words_to_write, WRITE_BUF_SIZE);
-
-		if (copy_from_user(tmp_buf, buf + copied * sizeof(u32),
-				   copy * sizeof(u32))) {
-			ret = -EFAULT;
-			goto end_unlock;
-		}
-
-		for (i = 0; i < copy; i++)
-			iowrite32(tmp_buf[i], fifo->base_addr +
-				  XLLF_TDFD_OFFSET);
-
-		copied += copy;
-		words_to_write -= copy;
+	txbuf = vmemdup_user(buf, len);
+	if (IS_ERR(txbuf)) {
+		ret = PTR_ERR(txbuf);
+		goto end_unlock;
 	}
 
-	ret = copied * sizeof(u32);
+	for (int i = 0; i < words_to_write; ++i)
+		iowrite32(txbuf[i], fifo->base_addr + XLLF_TDFD_OFFSET);
 
 	/* write packet size to fifo */
-	iowrite32(ret, fifo->base_addr + XLLF_TLR_OFFSET);
+	iowrite32(len, fifo->base_addr + XLLF_TLR_OFFSET);
 
+	ret = len;
+	kvfree(txbuf);
 end_unlock:
 	mutex_unlock(&fifo->write_lock);
 
-- 
2.50.0


