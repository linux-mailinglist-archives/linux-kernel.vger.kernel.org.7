Return-Path: <linux-kernel+bounces-762124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A29AB20267
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48B42188FA4A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 08:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290C2DC34C;
	Mon, 11 Aug 2025 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFv9Z/Be"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4200B2DCBF2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902500; cv=none; b=Q9N5RUIfNZXHfjlGdr6NT6iJerk4fHmsVM5BZeeBYuYOiBkQU8ovbxfu+VxAXAUVXxj4WkaIhbhxE8Vk7JicdphI0Zss1wcWDjOJfz5DNRJXTbgs8v5u7GpIpgi9N3BO0C2SghryG2XZTtYLONZTi8ydNevknQ7BwuH10pH4lUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902500; c=relaxed/simple;
	bh=VG6PWBB/5tMPvLzF6xGjoyk6UV1hR54oWT9n+hvDuEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2rtu+CEa4Ss4T7gKI3dCkLruHAAXF86ixzEu00klOdW2ohYD3UTia3FFX47cYP+3HJro/nfrvEgMf1nUBTYvogP+hb6Ya0/hgUqbOU1rMNqFVXeH+f0uY6Nm9Z6lNHn+3GB9aC3/9NzHXwwJWmOtfqdxEfp8YYGPv0i5GWBDKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFv9Z/Be; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af95525bac4so739547266b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 01:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754902496; x=1755507296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR9qdCVqEjtc6+fwt52lhLQBEhkPHeI4a9cD0bCXdeQ=;
        b=YFv9Z/BejhV9p4ihFOQW+uPveGvjpXxWZekZqWIJneoSfJSw3swOgtMnQ9MHpEW/CM
         32qKHeLEXJe/0vRHvHek439VvC+Zcd/XvTEe5XcE9oKstR0B6hIQsfi9G5vI6kukSl4R
         pWG3MlNIUy7Ar7nHXemiVhz4zLvaZNFUO4i+enBch6yO5hLFMOBQFMC8uhPs9YWyssmh
         entM0fFUaQZJeEkE6cfreoi/bsVy7bwY4g6CarFBKyJoo0rJYZNnfy1JnIn7XD6R5fVm
         7fgejeh0pkMXgTLt8A2QdTXbftV3FO/pmRvMPxQsb+uKlIgAnE4yRhPKGYQQbYup8Lgz
         u8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754902496; x=1755507296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR9qdCVqEjtc6+fwt52lhLQBEhkPHeI4a9cD0bCXdeQ=;
        b=kdJLGFwS4Gieq7FskQZSKzJyrvVxe2A/dA1bWoWC2xtR8OE5CXDxfTZP4lBJ2lPsop
         P1OC27jdff71uc0ds7rNhUK9nPIfFqpMLlL9ZTAnL80Y/ZRxK8JBGQ9WVLCUDZgPHt97
         zEGmZkxLeodT3bx7zmxGS1bWkKeAUni24wfuvzLFcqNuk936fl2mlJJyklb1KU1Kzs8Z
         PNG6+Yh+HCFcJ3nDZQuP5N7ZDmFtGPwR/z1bme0SUI1aqbTCsNVqlSMrWPvLmawQlEsB
         kc6LiGqXme14oMTsErJjj1xE6iuROwwPYw9wq9qLtgVfYA//OHsciFyfFZKB9m2b9kZJ
         E2GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJK8bWW/forqiIHDmLf7FdJh26OfB0U9ku16Ey/i88Qbh3geXaNlNosmx6v4mU3rnr0/tZvwaT/iJMRag=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtajd8psoHgs78FaafUucyjEDESN+y09VIs3bUV08Up15oeu9S
	w4i1L3velgpdjbc/cM78vSojcM7DOEdycIXM3qLZedSawT7iIrqa60kzzgmNgg==
X-Gm-Gg: ASbGnctMrCaLNrmnLEx82kpP6H3+i4G1neuDo/py/VeP77qDNg1DEiQh9B/UKJoBn9Q
	dvotCyV8G1gqx3dl3yiuxI708X6INh/QLJQK9JPHNpZXLqGfKF9kpzRn5c1uXuG+BA7+t/UUNNC
	fOrb5uObA8Zh5mVaDtuBFA8n65O6aen1khitPec1Pc4+r9yTmeD76Y5x1SSYk3aNqiXjS/rb8wF
	odZbmajJ/BADVbQWn/BZxhqsdOOn77UfjFJhCu3hnp/8GUmM9+ATAUyq77uNl8TUEh+EI+N1/Ar
	ET7Z0pu045QVkjhizrc/HkSkR6tNOo8JaXPu8JgFQkM7wS0AmDDCZBw4HlPctEM3YyQd+gyY/Es
	ssXxzA0L3S/960c6APvcOSFjA7BSXiKoCzA==
X-Google-Smtp-Source: AGHT+IH8Fm7gghXlK13iQCuIgoR8rOQNScRMP/oXs3wdL9JIvaCNmWwrxdyN/oPIKqpBCVYGVdNpMg==
X-Received: by 2002:a17:907:972a:b0:ad8:8719:f6f3 with SMTP id a640c23a62f3a-af9c645b793mr1029294066b.22.1754902496483;
        Mon, 11 Aug 2025 01:54:56 -0700 (PDT)
Received: from ws-linux01 ([2a02:2f0e:c207:b600:978:f6fa:583e:b091])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91ee3c1f7sm1924687166b.68.2025.08.11.01.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 01:54:56 -0700 (PDT)
From: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev
Cc: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
Subject: [PATCH v2 2/2] staging: axis-fifo: use unique identifiers in device names
Date: Mon, 11 Aug 2025 11:54:17 +0300
Message-ID: <20250811085417.2641674-2-ovidiu.panait.oss@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250811085417.2641674-1-ovidiu.panait.oss@gmail.com>
References: <20250811085417.2641674-1-ovidiu.panait.oss@gmail.com>
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
for axis-fifo device names (i.e. axis_fifo0, axis_fifo1, etc.).

Signed-off-by: Ovidiu Panait <ovidiu.panait.oss@gmail.com>
---
Changes in v2:
 - add mising ida_destroy() call in module unload path

 drivers/staging/axis-fifo/axis-fifo.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
index 06f7cfab4c6a..e8aa632e0a31 100644
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
@@ -798,6 +805,7 @@ module_init(axis_fifo_init);
 static void __exit axis_fifo_exit(void)
 {
 	platform_driver_unregister(&axis_fifo_driver);
+	ida_destroy(&axis_fifo_ida);
 }
 
 module_exit(axis_fifo_exit);
-- 
2.50.0


