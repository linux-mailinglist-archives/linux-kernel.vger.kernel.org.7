Return-Path: <linux-kernel+bounces-754221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEA9B19005
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82BA217749D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 21:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA44248F7D;
	Sat,  2 Aug 2025 21:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OJX1QcY1"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CBC14B959
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 21:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754168421; cv=none; b=GAPuXkiN55VgaI00odheug8tyizP7Q6NuIiUCxj1MFtx9krbRa5FcZZ2Yb0/aNviAUiwRd+jrscBIXKNyMoobNQdH3upnNwAop2c1AS6rH3T2uc6Fc7INHguQqgF4c9Ies00r5/ml9p17j6zd89hwNdn5JRxc+KPGQ0cbYlMIp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754168421; c=relaxed/simple;
	bh=9liRjyy+k0N/Xr5gNi17GL3XB7VDEFFc+FY54aY9CWE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZBFyFpEYHGRnEdQBULtfe8i9doPHiftovOg+TBlfwrLulXbEFoee6wmXtvog5wZ2J7871GA4cszjs7Mo+ZYxGXYNUgLLH/5520chgTDzT/Oc/nG1BME9Ps6z4gE+VLOrVKacqfQncqc7sPa7MWWnJibUXtlzL6iHj9M2ur2wORY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OJX1QcY1; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-acb5ec407b1so437815866b.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Aug 2025 14:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754168416; x=1754773216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EqFvlTdkE/lLHwjCr384R3lKi7iIttlwXzx7wFAXJMg=;
        b=OJX1QcY10kfO6RporXW/nYv4HVrA0CKgUfEJ7t2miOSb+u0XtWQDWNnIWbDhiLSjVM
         VHbAnW4vpcSd8oHMBr5WHJv/9KMyH1dyhMncrwjWw6Xbpwut4nUCw57sUlEGlVCUNcE3
         Ae4i0RAqQDdS+QYhiSU47F0NOqCcoT0tP+EiVtBkS+XJzYphrNwAgpp+hKA/dXPxYSzJ
         azxNC2tr/bwL5jKSrruvhXQczIJkjzGnkbhS31sQKsey+KF2amYrF6O32vNZ/G8RkxIN
         pUU/TBLeFBYibcG4W4PWCScjy57CCLB/kLUraQiwlI4uotzHEYtOCCELNU5LitJpKxSR
         1DiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754168416; x=1754773216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EqFvlTdkE/lLHwjCr384R3lKi7iIttlwXzx7wFAXJMg=;
        b=KRS4ayJaJ+XgG9/24gD4aYWJGyx4pVKPJnx7MGth6yHP4Y8OfGSjvZ/xktV8juAnSK
         zk839mdCcJz1lEAvQL+eRd/mb5Ub5+duanGixWji8ZO+1HYT4bUavBHw3ih/HiVYHLml
         AJSnKHjbHANubRo82ui+kDd/moG3tXBl3Yu1ROv5oHutd23n43QFBbUDcmnfrvjGzCyK
         FUEXf17jXzv4NfZdlgUo+PgA7I7VTmWUyRAkoiGGsfK7IVjpQvxV61bhyKOSJVRGuzu3
         SiWxbdZTxDJDNIgmbI1JPEkRo3vkRZAR/57wnwYcNvsZLCIhVVs1DSVX3yl2CLPNTRba
         Jifw==
X-Forwarded-Encrypted: i=1; AJvYcCWOvIxXjCzgSqsu7eZXwzW8NSPGj/xPgnEA+D7oaMWu3FdOHh34srG4Zwknt2Ly/BI+Kb8qQKmGUORCqAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVf5fpCJ+c7s9imm/ObLFckjUsCPq0R9OZcSJ8hVyS4ZJArb7y
	dsR00C9j7qwqVuqAwSPEMM6KTFZBvtdZazK4gj/ewTE/+7YadmU/jgchXUSIAA==
X-Gm-Gg: ASbGncuVDzwthfORPFinyTvR3OOxTb0t4XaAtMaE5+R/D7vANGf/nL3aS1aVVPDtCbq
	VxtPOM55nyJ8jFbkjDuhInGdIt1CTQ4SyWjvuBJ3T0pz08FTNEzT+vjquKvX/q0AmxJP0wp3YfA
	7SbNnErHm7i1W2uFPaiXoq1Jyn00hUDSjqLXApEYKyIdK5m2+T5X5fLF+fKPB2nSVHh3rdNw0o5
	AX6Fa8vAmvs9QUe4sGW+x91Qc9ChaI0dRt4FGWo61TNqL+KCRyj2tMfK0kKm8O7ycJM1gF54Kq+
	mQV0EF8R8INzYNq0z3cVqoLWcSYIReVVMeN97ZNBSX4VKont34I2mMqk9TdqKKtVpNXmPYK8jfL
	16hh4mIpj1xTvpEJn/IPM6aXexQBiaoa/yG2Qx1Nvtwjm
X-Google-Smtp-Source: AGHT+IGTEl90wg4WrpQW0TdHrmGpxUVo//Z/YNxDsBB9jYyNI+4TaXABT4xWLIe39HheMQaiSSufyg==
X-Received: by 2002:a17:907:6096:b0:ae3:74be:4998 with SMTP id a640c23a62f3a-af93ffc15ffmr397716466b.11.1754168416200;
        Sat, 02 Aug 2025 14:00:16 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:ca0d:f700:1210:b727:adc8:716])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c157sm476788366b.100.2025.08.02.14.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Aug 2025 14:00:15 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gshahrouzi@gmail.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH] staging: axis-fifo: fix maximum TX packet length check
Date: Sat,  2 Aug 2025 23:59:43 +0300
Message-ID: <20250802205943.958071-1-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since commit 2ca34b508774 ("staging: axis-fifo: Correct handling of
tx_fifo_depth for size validation"), write() operations with packets
larger than 'tx_fifo_depth - 4' words are no longer rejected with -EINVAL.

Fortunately, the packets are not actually getting transmitted to hardware,
otherwise they would be raising a 'Transmit Packet Overrun Error'
interrupt, which requires a reset of the TX circuit to recover from.

Instead, the request times out inside wait_event_interruptible_timeout()
and always returns -EAGAIN, since the wake up condition can never be true
for these packets. But still, they unnecessarily block other tasks from
writing to the FIFO and the EAGAIN return code signals userspace to retry
the write() call, even though it will always fail and time out.

According to the AXI4-Stream FIFO reference manual (PG080), the maximum
valid packet length is 'tx_fifo_depth - 4' words, so attempting to send
larger packets is invalid and should not be happening in the first place:

> The maximum packet that can be transmitted is limited by the size of
> the FIFO, which is (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.

Therefore, bring back the old behavior and outright reject packets larger
than 'tx_fifo_depth - 4' with -EINVAL. Add a comment to explain why the
check is necessary. The dev_err() message was removed to avoid cluttering
the dmesg log if an invalid packet is received from userspace.

Fixes: 2ca34b508774 ("staging: axis-fifo: Correct handling of tx_fifo_depth for size validation")
Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 25c0fa8c415d..0f244f80c368 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -322,11 +322,17 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		return -EINVAL;
 	}
 
-	if (words_to_write > fifo->tx_fifo_depth) {
-		dev_err(fifo->dt_device, "tried to write more words [%u] than slots in the fifo buffer [%u]\n",
-			words_to_write, fifo->tx_fifo_depth);
+	/*
+	 * In 'Store-and-Forward' mode, the maximum packet that can be
+	 * transmitted is limited by the size of the FIFO, which is
+	 * (C_TX_FIFO_DEPTH–4)*(data interface width/8) bytes.
+	 *
+	 * Do not attempt to send a packet larger than 'tx_fifo_depth - 4',
+	 * otherwise a 'Transmit Packet Overrun Error' interrupt will be
+	 * raised, which requires a reset of the TX circuit to recover.
+	 */
+	if (words_to_write > (fifo->tx_fifo_depth - 4))
 		return -EINVAL;
-	}
 
 	if (fifo->write_flags & O_NONBLOCK) {
 		/*
-- 
2.50.0


