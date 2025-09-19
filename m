Return-Path: <linux-kernel+bounces-825166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC61B8B27A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 21:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DDD617CD26
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 19:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FEB322C85;
	Fri, 19 Sep 2025 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOjAr48V"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655BA3191A1
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311776; cv=none; b=PEOdr5QZcPblN/9l2Y3dNH5QyNDJx47z7vKiz8b6vql2E71eOBMZqgHM50rDJQHomQSdUH1tXTsdBFtb2Nm+1KMRM4efpGjTfMBQOP/RnKxH5O+HtR4Afwxp84kGWPD/wzqvODlgtKG9mo1CE849jw+ubbU/e4y8H8Cp4tQJWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311776; c=relaxed/simple;
	bh=XIFSWOnikm++UnePJHJSK8rjFjeh/6wDwVLqw2o1BJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOi2LI6bdc8GSrzQRhwfjC4B4dP1y13CEYHHq9yO2Jdt+rq5Q0Y/ZrOLMNFcAgxG3qL2un7d19v2CA+GRQBb3ZWZ2BAKheCaYgWmeS2lgioPe2LkFm/FR5S2Hm6hrDfhrYcAss8ZiM9PnEY5DrncYn13u9pQIBVeFMoB8sH0sU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOjAr48V; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso19809115e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758311773; x=1758916573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WvYL0C0uvrDUWWSUgqdp7j7WVAXOj8GbBxx6ogc4GMo=;
        b=fOjAr48VfWjGVrO/2vy6FdjsY04uALS1grHZfKBXhEVQ/gQqAAy0hRHXEjaH7BQwra
         djxzOuCm5hAZrrN6FPZaE3VcF3YbKakHERbIb5xTXJY+uDzpzkebbGGCxaIZ5viGdZQs
         sWMFCpqFdLK1s4FgTZaeVafoFjNvyV4GSkaEYOTmjeTr2lj4A9K6n1NOrtAbqbkVnayf
         Qcmbe20eQN160WZq+AQvskS81h3QQZJk+1ZpUU5zV8rCZkqoQQLEcbyUhdNiOrjueoIG
         R7ios06+SqjtlktLC+pjoY2Rv/dSpacuraPO4py8i250OLctC3BN7tBFny9ZDRdgIxm0
         njwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758311773; x=1758916573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WvYL0C0uvrDUWWSUgqdp7j7WVAXOj8GbBxx6ogc4GMo=;
        b=SxwLuDehKCn7scBpxpUmABpZCuXAGV1xWav6cRe17aIA3DyZDnj4WOb+AczkNRFWNC
         IQcLRQ9tbbQx6DWwUOpqTm3JHEi3nyGHR9ykihmD6WYW0iHw8lPYKpQiUQChxKdrGT6w
         2dgiUAcb3Jhr+5VQIUnVAZiLXq6QVyfUJrbfLPvku9JUx4p4fd3hTDzpqMaOR8srnckg
         2u1nxdVuLSIC7nwURziXl1OG1rhZIhkwwwOsQniwJ9w7M8KTUOLrqGhLCCYFijyiL7HD
         if4nSm/Qc25C5vLCPq+aOoa80aF9lW5gPIbQ6pwG2mFs3NwdLQ/LeNoIfcI5iKnzxXAO
         uXYA==
X-Forwarded-Encrypted: i=1; AJvYcCUWzvyEg1Yk5A78Lp/tPRUiQhBmyOkQtIZ1Qvlpm902L1tVwgp9ooFR/j1ZqhA3aewKF45cYZBehYBijKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfX9R2vaHAdCA86X9V0Bf+7wtagpqqdGl2jy80B4lpgZDffDEY
	1/m9Y+jBfT4eUSY1PRe9TACtKHKGewdBCvaVSTpEbgAZgf+/tNnidT0S
X-Gm-Gg: ASbGncv9iIcjfsv7ChQ/3K0E7yhcmy+IwbXqyUeFEQ/vIwd8A2AxXxs4Uzd0vAdqx80
	GNfqo/swoZKPL/vG+yVFCCohHX5N41qSohXvJXHHy3OkMfezNRCCpE357j/BHioFZ9Ve/al1nGg
	rJj5mKQ+KoZFSA4gporWu9uoN52LhQE5JgZ5O2ru8LABKPSRq0ppsaxdhYXPOTwgMm111vWMQDD
	1+5J2WXWaRDPh/qs1oO4tFNDLG/BCzqEw+npuLN0p4S3FqRprp16fvdlDfE1O2YbkuTJVYHtD/6
	WwjvKd8FH1ci1IFqisW1Udn+/jn9AF+7W+gEfsgCFO9rrXQrGd5trsUK7hFNpFlrljd9FaKGOSB
	X6TBdqJUGcCZgGUHH94/agGhseuPi4FxVWw==
X-Google-Smtp-Source: AGHT+IFfy8KKTT05+miEzBxcobLWuJt6fWd263QV1GFJvMsOr+uiT5pE+o/nlGraya5H19++K9S26A==
X-Received: by 2002:a05:600c:528e:b0:45f:2d2a:e323 with SMTP id 5b1f17b1804b1-46825c1255fmr44598325e9.0.1758311772469;
        Fri, 19 Sep 2025 12:56:12 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f162726bsm97025485e9.7.2025.09.19.12.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 12:56:12 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 5/6] staging: axis-fifo: drop redundant read/write_flags from axis_fifo
Date: Fri, 19 Sep 2025 22:53:59 +0300
Message-ID: <20250919195400.3180039-5-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
References: <20250919195400.3180039-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver stores file flags (read_flags/write_flags) in the axis_fifo
struct, duplicating information already available in struct file.

Switch to using f->f_flags directly in read/write paths and open(),
removing the unnecessary fields.

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 30 +++++++--------------------
 1 file changed, 8 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 21fcc9150d7e..881abd61cefd 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -129,8 +129,6 @@ struct axis_fifo {
 	struct mutex read_lock; /* lock for reading */
 	wait_queue_head_t write_queue; /* wait queue for asynchronos write */
 	struct mutex write_lock; /* lock for writing */
-	unsigned int write_flags; /* write file flags */
-	unsigned int read_flags; /* read file flags */
 
 	struct device *dt_device; /* device created from the device tree */
 	struct miscdevice miscdev;
@@ -187,7 +185,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
 	int ret;
 	u32 tmp_buf[READ_BUF_SIZE];
 
-	if (fifo->read_flags & O_NONBLOCK) {
+	if (f->f_flags & O_NONBLOCK) {
 		/*
 		 * Device opened in non-blocking mode. Try to lock it and then
 		 * check if any packet is available.
@@ -322,7 +320,7 @@ static ssize_t axis_fifo_write(struct file *f, const char __user *buf,
 		return -EINVAL;
 	}
 
-	if (fifo->write_flags & O_NONBLOCK) {
+	if (f->f_flags & O_NONBLOCK) {
 		/*
 		 * Device opened in non-blocking mode. Try to lock it and then
 		 * check if there is any room to write the given buffer.
@@ -431,27 +429,15 @@ static int axis_fifo_open(struct inode *inod, struct file *f)
 {
 	struct axis_fifo *fifo = container_of(f->private_data,
 					      struct axis_fifo, miscdev);
+	unsigned int flags = f->f_flags & O_ACCMODE;
+
 	f->private_data = fifo;
 
-	if (((f->f_flags & O_ACCMODE) == O_WRONLY) ||
-	    ((f->f_flags & O_ACCMODE) == O_RDWR)) {
-		if (fifo->has_tx_fifo) {
-			fifo->write_flags = f->f_flags;
-		} else {
-			dev_err(fifo->dt_device, "tried to open device for write but the transmit fifo is disabled\n");
-			return -EPERM;
-		}
-	}
+	if ((flags == O_WRONLY || flags == O_RDWR) && !fifo->has_tx_fifo)
+		return -EPERM;
 
-	if (((f->f_flags & O_ACCMODE) == O_RDONLY) ||
-	    ((f->f_flags & O_ACCMODE) == O_RDWR)) {
-		if (fifo->has_rx_fifo) {
-			fifo->read_flags = f->f_flags;
-		} else {
-			dev_err(fifo->dt_device, "tried to open device for read but the receive fifo is disabled\n");
-			return -EPERM;
-		}
-	}
+	if ((flags == O_RDONLY || flags == O_RDWR) && !fifo->has_rx_fifo)
+		return -EPERM;
 
 	return 0;
 }
-- 
2.50.0


