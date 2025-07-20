Return-Path: <linux-kernel+bounces-738385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884FAB0B7B6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 20:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F155E3A54EF
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 18:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D1722422A;
	Sun, 20 Jul 2025 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbES5PP/"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACF4522A
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 18:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753036769; cv=none; b=Mh++KaAVu0mvVbAI+sqpQCtG6j7a65X6Wn8+zWtnLcU+3JbNSfEjAjAUOU1VehdDE3A+9kn5EQfZB/C7jWbEt/cJIGGJuPOnBogCW2SP8eM0HVPFu9VsSCYffNiuJIgBO0eB72oRt2Ryi5HJePn9ZGlXPpgIJsECv24lGF0LQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753036769; c=relaxed/simple;
	bh=RKWMvO/fU/WNbKhEbWzWLXnCbkLXkt7iP1OUIspJ5CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ryV75ba94CoIRtfEATiQrEn0AYIYD9Y876kPnil1F2JFMM1lZ1lh+aecPqcySDRQE3741BthADW376UGPEY+fzwpCivrOX1TZoHAnxblkKJSmamaDFard8WtUuOYV6NpRh67I5dmDOAtv4/ecRv0j6fmSzM8EfLj323aFkMMbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbES5PP/; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60c51860bf5so6564557a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 11:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753036765; x=1753641565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8HXTUbomF0Mo0J64mxyhOwMmyRS3EiCAcZKo6eJmSg=;
        b=HbES5PP/cp4pF2Bf7TXABY80mbu4eI5I7eMK4hyRli6xGbbYcnN8Gy/CcL79sJPOwm
         AU4EVcF23tMMJwvbYhbiW8tk6kjgw1LUBjq8GXfk/Fuz//2qoxmIxsSWC0dUT5JebO+X
         7vUNu6ApYkeALH5t6y2MLB+mOnxf6sEcImo/bc8KBNLLw6V6WLlIx0RCyINFEOLbCOGj
         p2dRu6ra3zbs0/VG41G623+pyhqiTtmUhM0vWrkLpNndBg9T92OR3vwUaJg2LAkvYcRr
         29q54MUiuI+MTyozpicoowjuG6hTdM/JizhYz0m7GXid2TL8aqJs0IMzRus4OWBZyatc
         ip6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753036765; x=1753641565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8HXTUbomF0Mo0J64mxyhOwMmyRS3EiCAcZKo6eJmSg=;
        b=qpqmkDMKaeWY/48tB12KHtZhKR/8jf1YtN1I7ebk7q8kivHOnou1N3cm6gMmftLB2K
         x6f+60GOYB9jW7mIsCfqzTNWcUgkXTNUwXsA2MnovVwarfNov7Yt7jG3IcdJrQDGv5Tv
         VVxRB2FtdB25T+IJud0txUpTCAkwceaNY0UXUkIigOiE77GkBhBbxrWaD01t8LDcBYk7
         BKynZpXBl6nz4/iCkx+OruWI+r6xeRZKmRuP0TJfXKelBTQ6J24Gafl+UfYzB2pAeqeN
         Ko+0qpoq3+cxpo4jbgzlSN1X5bx0Q01Uvq0B+Oc8tzZ2rTLP2TfGr+JmRu78oZ3uHYd5
         +k4g==
X-Forwarded-Encrypted: i=1; AJvYcCXu0P/qZWEj1TAywHBEvMKVg20BCcqoI/AYkWjocZcrmwIGptp0TVAuSvyjfJeswXtR2Z2Xh6aa9Vd/JgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJzpEK4uMJ+kfppvD7NgUBluN/dmqObO3Xg2xa71IKa0/szqwP
	KKjy7rp8IRb56YGAdiJBNaDywqSyzJLvh9FO9qEfI4RWxHOjThlElj+6
X-Gm-Gg: ASbGnctU+Oe5yeGajbUcM69h+DtgwIqaeRWogc+QIDypv2fXf1BpL/OV7qH0u09bW6H
	KGF94UxH+HZK6EI9LGBXJjneDFv46e+AGwTujkL8k6KlF4XQ8+rSjT7QFjIhJaAYUrKjgicGe+2
	UPOcD9Y3uS4LRH4yTGEoVyb7MMwNBBcqOiF+2O/Zxiz8AgLpDHIKVxojkkGbgcL9QU0znHuI2Qd
	yLOVUXSQ3xm3iu+tgjkBzAoZu6bPXiTCPINwgzhWrHe1wFiJavH5Ucou1w1mOxIQ8gz9qQEJArm
	3GVDRX/aqslcQ0CD+jSEVblvqcKS3GQA6JAdPPASMR/+U5o44SmaLPbzlYVgrx24b8rL5PlWSRI
	VjuVBQS22OcZtCxNp+oSD2fmZx4BseYkZ4os=
X-Google-Smtp-Source: AGHT+IHhhas8FsUsqJ6j67fNaXZBQPkxFiyb2zLje7llhnSBFbWAr4qyV+hOsdj+z7+wjEqYzgGNqA==
X-Received: by 2002:a17:906:4789:b0:ae3:eed1:d018 with SMTP id a640c23a62f3a-ae9c9982735mr1752341666b.9.1753036764679;
        Sun, 20 Jul 2025 11:39:24 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c703:7100:a4d7:50f8:78a7:9bfc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca5a029sm533406366b.75.2025.07.20.11.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 11:39:24 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 2/2] staging: axis-fifo: add debugfs interface for dumping fifo registers
Date: Sun, 20 Jul 2025 21:38:33 +0300
Message-ID: <20250720183833.3570345-2-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250720183833.3570345-1-ovidiu.panait.oss@gmail.com>
References: <20250720183833.3570345-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For debugging purposes, add a simple, read-only debugfs interface to dump
the following fifo registers:
ISR  - Interrupt Status Register
IER  - Interrupt Enable Register
TDFV - Transmit Data FIFO Vacancy
RDFO - Receive Data FIFO Occupancy

$ cat /sys/kernel/debug/43c00000.axi_fifo_mm_s/regs
 isr: 0x00000000
 ier: 0xfe000000
tdfv: 0x000001fc
rdfo: 0x00000000

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 7897434f2441..57ed58065eba 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -33,6 +33,7 @@
 #include <linux/uaccess.h>
 #include <linux/jiffies.h>
 #include <linux/miscdevice.h>
+#include <linux/debugfs.h>
 
 /* ----------------------------
  *       driver parameters
@@ -44,6 +45,8 @@
 #define READ_BUF_SIZE 128U /* read buffer length in words */
 #define WRITE_BUF_SIZE 128U /* write buffer length in words */
 
+#define AXIS_FIFO_DEBUG_REG_NAME_MAX_LEN	4
+
 /* ----------------------------
  *     IP register offsets
  * ----------------------------
@@ -137,6 +140,13 @@ struct axis_fifo {
 
 	struct device *dt_device; /* device created from the device tree */
 	struct miscdevice miscdev;
+
+	struct dentry *debugfs_dir;
+};
+
+struct axis_fifo_debug_reg {
+	const char * const name;
+	unsigned int offset;
 };
 
 /* ----------------------------
@@ -537,6 +547,37 @@ static const struct file_operations fops = {
 	.write = axis_fifo_write
 };
 
+static int axis_fifo_debugfs_regs_show(struct seq_file *m, void *p)
+{
+	static const struct axis_fifo_debug_reg regs[] = {
+		{"isr", XLLF_ISR_OFFSET},
+		{"ier", XLLF_IER_OFFSET},
+		{"tdfv", XLLF_TDFV_OFFSET},
+		{"rdfo", XLLF_RDFO_OFFSET},
+		{ /* Sentinel */ },
+	};
+	const struct axis_fifo_debug_reg *reg;
+	struct axis_fifo *fifo = m->private;
+
+	for (reg = regs; reg->name; ++reg) {
+		u32 val = ioread32(fifo->base_addr + reg->offset);
+
+		seq_printf(m, "%*s: 0x%08x\n", AXIS_FIFO_DEBUG_REG_NAME_MAX_LEN,
+			   reg->name, val);
+	}
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(axis_fifo_debugfs_regs);
+
+static void axis_fifo_debugfs_init(struct axis_fifo *fifo)
+{
+	fifo->debugfs_dir = debugfs_create_dir(dev_name(fifo->dt_device), NULL);
+
+	debugfs_create_file("regs", 0444, fifo->debugfs_dir, fifo,
+			    &axis_fifo_debugfs_regs_fops);
+}
+
 /* read named property from the device tree */
 static int get_dts_property(struct axis_fifo *fifo,
 			    char *name, unsigned int *var)
@@ -708,6 +749,8 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	if (rc < 0)
 		goto err_initial;
 
+	axis_fifo_debugfs_init(fifo);
+
 	return 0;
 
 err_initial:
@@ -720,6 +763,7 @@ static void axis_fifo_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct axis_fifo *fifo = dev_get_drvdata(dev);
 
+	debugfs_remove(fifo->debugfs_dir);
 	misc_deregister(&fifo->miscdev);
 	dev_set_drvdata(dev, NULL);
 }
-- 
2.50.0


