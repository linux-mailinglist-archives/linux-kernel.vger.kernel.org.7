Return-Path: <linux-kernel+bounces-760763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D979B1EFDE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 22:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3733BFC60
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 20:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A81C2367C1;
	Fri,  8 Aug 2025 20:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9wXUlrM"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA721CC56
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754686139; cv=none; b=iGYr8LSOnjXdW5SN/NClZgp5LBp6Yb8ChdNoq2BFRzbafqQYKb+AY47U92IH+xkNHs4/vuq2tMOLRK4eMKGVHlv8CUNJpWOVuOSVplpwJ+N/UevqGZghPwAX9UmUqN9TKCHNv/hXK5kFzjoUVItAAxK4h7NEOgVNEZVsENr7s3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754686139; c=relaxed/simple;
	bh=aFLGwrKXkKiDJqwVr4jZIU+eApLQHJ1frFbyUU1xJus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxUbyxOmwzL1ojfC2BFABv5S5kZvkwJMF7Qgd6uCNFw17ldu3aLMgVt1tSebJDW4OO+ql7N5lweercZ58+iIFhp9qgx40On9fXr1rypQ+v9L+Izsq+/jMzl5CDX+o/tjf8Wk1NtGRrpcyFntA95ppxFRsFT+hEzhzSZrjgeX6yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9wXUlrM; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-458ba079338so19078745e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754686136; x=1755290936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p7ziBuQ1vTW5WB/7L4QBYJ42H/q4ZCWd+CAfqSHV47I=;
        b=l9wXUlrM9zZZvOcIxNkbEhbIzVieM3z1bojtwyDrZuPRQr2UVG6kK8m4BkAR+4uWCu
         SSJR/PuC4bbgF2a4B0Qoalir3ukjuMsWXeD7IaKAcKRkFGnS67o3GGezICygi/CjtQCQ
         O4NlqheR7y4TmRBu7ETYEuHOHwCv4QDY9PpYiScjmno75FXNLlHzh0g4fGAHvVFhyELB
         9KKyv7SRQsHTN+egUmdJ4clY8Q3xIDy6C40omu+NfabVqUTr+vp2rHfDdpJgvsXzJ50v
         KaPhqHAXNBBieOzD0oF5S4os8tUkziWghKVLoPoP8q2toK9qicZNAE4MJ7ORDvDf8DX7
         d41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754686136; x=1755290936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p7ziBuQ1vTW5WB/7L4QBYJ42H/q4ZCWd+CAfqSHV47I=;
        b=Kj4z6PoET+9HUKKtznxuMXxb3GbH0qEmYVUYxH1RjEQCSP+WdzBsR+ijpUIetFCJSG
         /YqJGIjVfZELgZl+FpmlfjhC9jyQ21zHefqbO7jZKpcmxn2wqtfPdXgL+tVtQFicgB8Q
         N1GpfzoYuiQj9RKxvik6/tXAiJpLDZeU81gf4aNffalkiIWtuyIvS0OkBxm5Gcgu5o1N
         70LYtqcu7EcFh0NwaQljv2ubHNtKJ5MHzKX4XMU8EMqw3mNXBNNa+BV7MbahIopgf9u/
         GfhF6gt0I+znBxjBbsXa3Fg/bIyorsShaZfkXVMjzVFADwGzqURWfdZVw6E9QkIDvWpQ
         XjOA==
X-Forwarded-Encrypted: i=1; AJvYcCUbcUQTVXqaGOfZ6Sgnvl8bROLpHqG51QByMnyZSNA6N1x0VCno2YJxSXkKlWDFOVYNH2BN5OUiKg9iWTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDFmV/0rvVz9faN9kkHI3ShqzMNOvL+V7WnLkgf8LlBB4E+kr
	ADjRUNuWxYIoKm5iyint+k96gmSRSGRfILLewbPEYSrSzW0jgbY+SmXU
X-Gm-Gg: ASbGncuxIlSeieVdIJKJQXc10KDmXsMetDHzrzSR5Bu2PwNNb/8JXcSeH9RQdavcOMO
	xS/gA7XWJrDoXBtaflphjNVp5QrAJi/v13LqDhEKb5Mebkp0n70RfCI4mDx6XDLq/UNuW8/Bioh
	L4HL4moOnVWYjDAW4E5GzIfTuCJLwxHTkqh+kl/9lULcM3hve7YGfIUP9S/DqGbnYgDp4dt+JJ1
	IWoX1OJLqnuN91U9EDbxrFPNy1lkxFTpS8Cgr3KfkfLb5bwVdBrnOInKNYjB6F1kfAH0bqxuaYn
	ptcHnw9oKkXsZ/vaaUzFjOuYvKpvGykIZhnea/l17nXZAK4xOMeR+6AlBragfs3IwOrcWjoPweh
	TiGyIzZrxWEb0ckfHvdBvawJWNkozzxu24psV2Ij2NkZf
X-Google-Smtp-Source: AGHT+IEB8DG7xrFf8jvYLcxLQJXvP5Kp1Udkw4Ki44C4wWQrGHPxi4K8SAPJbeByCDCyegshsvwZbQ==
X-Received: by 2002:a05:600c:6211:b0:458:b4a9:b024 with SMTP id 5b1f17b1804b1-459ee0a9cb0mr92601495e9.11.1754686136196;
        Fri, 08 Aug 2025 13:48:56 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4533f1sm31815003f8f.42.2025.08.08.13.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 13:48:55 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH 2/2] staging: axis-fifo: use unique identifiers in device names
Date: Fri,  8 Aug 2025 23:48:31 +0300
Message-ID: <20250808204831.2618122-2-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250808204831.2618122-1-ovidiu.panait.oss@gmail.com>
References: <20250808204831.2618122-1-ovidiu.panait.oss@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Axis-fifo devices use physical addresses in their name, for example
'axis_fifo_0x43c00000'. This is generally frowned upon and it does not
follow the usual naming scheme that uses unique identifiers.

Therefore, use ida_alloc()/ida_free() to implement unique identifiers
for axis-fifo device names (i.e. axis-fifo0, axis-fifo1, etc.).

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
 drivers/staging/axis-fifo/axis-fifo.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 06f7cfab4c6a..27e12af25bc7 100644
--- a/drivers/staging/axis-fifo/axis-fifo.c
+++ b/drivers/staging/axis-fifo/axis-fifo.c
@@ -107,6 +107,8 @@
 static long read_timeout = 1000; /* ms to wait before read() times out */
 static long write_timeout = 1000; /* ms to wait before write() times out */
 
+static DEFINE_IDA(axis_fifo_ida);
+
 /* ----------------------------
  * module command-line arguments
  * ----------------------------
@@ -123,6 +125,7 @@ MODULE_PARM_DESC(write_timeout, "ms to wait before blocking write() timing out;
  */
 
 struct axis_fifo {
+	int id;
 	int irq; /* interrupt */
 	void __iomem *base_addr; /* kernel space memory */
 
@@ -698,10 +701,6 @@ static int axis_fifo_probe(struct platform_device *pdev)
 
 	dev_dbg(fifo->dt_device, "remapped memory to 0x%p\n", fifo->base_addr);
 
-	/* create unique device name */
-	snprintf(device_name, 32, "%s_%pa", DRIVER_NAME, &r_mem->start);
-	dev_dbg(fifo->dt_device, "device name [%s]\n", device_name);
-
 	/* ----------------------------
 	 *          init IP
 	 * ----------------------------
@@ -737,6 +736,11 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	 *      init char device
 	 * ----------------------------
 	 */
+	fifo->id = ida_alloc(&axis_fifo_ida, GFP_KERNEL);
+	if (fifo->id < 0)
+		return fifo->id;
+
+	snprintf(device_name, 32, "%s%d", DRIVER_NAME, fifo->id);
 
 	/* create character device */
 	fifo->miscdev.fops = &fops;
@@ -744,8 +748,10 @@ static int axis_fifo_probe(struct platform_device *pdev)
 	fifo->miscdev.name = device_name;
 	fifo->miscdev.parent = dev;
 	rc = misc_register(&fifo->miscdev);
-	if (rc < 0)
+	if (rc < 0) {
+		ida_free(&axis_fifo_ida, fifo->id);
 		return rc;
+	}
 
 	axis_fifo_debugfs_init(fifo);
 
@@ -759,6 +765,7 @@ static void axis_fifo_remove(struct platform_device *pdev)
 
 	debugfs_remove(fifo->debugfs_dir);
 	misc_deregister(&fifo->miscdev);
+	ida_free(&axis_fifo_ida, fifo->id);
 }
 
 static const struct of_device_id axis_fifo_of_match[] = {
-- 
2.50.0


