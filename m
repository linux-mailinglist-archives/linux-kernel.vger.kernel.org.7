Return-Path: <linux-kernel+bounces-665741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29137AC6D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 17:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6255C3ADE5D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 May 2025 15:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D4B28C5C1;
	Wed, 28 May 2025 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openpixelsystems-org.20230601.gappssmtp.com header.i=@openpixelsystems-org.20230601.gappssmtp.com header.b="aScVngs8"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DC774420
	for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748447011; cv=none; b=GX3f9CuUNNmh0vXQk1f3gDw4IqPqX/GCjDqHaPqUI6rr6F91bWNBb06c5ZfU0+NVH633i71iJdXn0m0yNvT5Fhz2xIrepKNgm41j64N79XXkRinPuPk5j76O/e77LnQW8wMl4/pJ7woIaZe+KuSSsfOpMnBD7dukVa/DUhwdIr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748447011; c=relaxed/simple;
	bh=BMRUJzr0/HLa3ogV5/HusC1YamEdyusN8YfIZyUZixE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZIz88asDfX1NDhZK9DiQbyVnIlm7GnXSB7k1NbcjoI0VXFXGypNmhfMynLmCnUQMDNY3BBTecA/FOo3kjsvsUUMHsINFnVKQdrM1AskILqM0Re2MqUKdfN4vQEuf/0EODUvzkmn7T2qcqILfMnw9c8DtopBZeA3iuAEIe5cpw+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openpixelsystems.org; spf=fail smtp.mailfrom=openpixelsystems.org; dkim=pass (2048-bit key) header.d=openpixelsystems-org.20230601.gappssmtp.com header.i=@openpixelsystems-org.20230601.gappssmtp.com header.b=aScVngs8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openpixelsystems.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=openpixelsystems.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-450cb2ddd46so42995e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 May 2025 08:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openpixelsystems-org.20230601.gappssmtp.com; s=20230601; t=1748447005; x=1749051805; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6yl6vUzUKKmJBwsdJArAjkBP/TBHxNgwshqS0VE0gt4=;
        b=aScVngs882WoC93xQwNq7Q2oSc1CtKNQesfcsZVLy3fELFT+14D06Qi1wSJ2UjU96a
         B2yiYtMfj0dlZi8t9CXm5TgaX1kK87HSYTMO6p8xCGHkgcQwzUhvERa+w9ztbpPsPp2P
         NuqUbBlvwKXJwSObGdaw7lqoyAcLvqRNRIYek/hlB0SKQV4L1qpQwKQc86EYdfrEJSui
         2AwN5AyEMkeAoWQAJg9nQb8G+YpCZps2L+PO1N2GmvEEeC12zRaDI/Mavu5QKZgo/pGM
         SqKq1TBq6pRJZu5VlC3rY9GS+oEjc50bVbeOnNigDgXGzjadKsPuEjrPUpFPEwNWew/0
         XpAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748447005; x=1749051805;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6yl6vUzUKKmJBwsdJArAjkBP/TBHxNgwshqS0VE0gt4=;
        b=I/sY/kMf8ojH/g158quHu1LQtwgmB+qvLAT7eTG2p3elqc4+Iu3ot6oU10vTsdEdiq
         E8+9w9PiwNaD76+Qfh6P0ZvNsSgwaF/Om/GC7PFDtvrcFjAUaOAuojJQ5qqf2n2VhjsU
         hhziOuioxog+mCAb8HZfrtf4NaILroScBkKbmpYDPDgMbNJOF+98qLqUmDFzAjK1LsQb
         5kbG8XRcuAvW1u+x1hM4v3e+l1KV/2YCeCkkWcGlYBWg+2UaOc74bd5XpsCNtLzy/ngr
         85TqmfZRcLhmOChRINL8InNGSAWOYxyXRJaLQRxAVfgw27DhjJbbY6KDXF3miybYo5Z9
         koJg==
X-Forwarded-Encrypted: i=1; AJvYcCXjvYYLu4GNX13erqH8tCFexV1TZJIx5kcG0p9KPuwMECi09LB9QIx25W5kysqCnmi3w7jCiWbMApiFzCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiEdSAMOUq5wbMD9qocvHluK+CkSllsh4lTnOQhbeV6fQJCSC1
	N3W1eSHJhOyij+n7B8BFRVOna+/x19/5019+P467MyYW3K3sz4NWawUsKwcwZFKcRH0=
X-Gm-Gg: ASbGncvkldAQ4WxfaCf7uwPnVI6stnhC0ZZt/et24d0T/ZLgZRvWUBLY7/ngVIoJEpI
	PyYQrasUZlmPYs5cXw67Dp0VlR7wn5lGpwRIPTdnPyCTsD6QSNCgCE8mCX2nq6tgsZG5qzwRRhr
	nURoLV8U28iF8sHLTc6+1Jl7N5F9+qc4Pt+2wdU9L7uY2k76Sgae2ZtJDH01Y8oitvLjsmiCSlp
	8U4URgllx3o6FDaLfhO7wHTQC4inzW1ptTbUVA6lELDcxKRi54ce9LH/MIZCeW+DLoJNqW95sCE
	vbz8mrjGzchpcI4rjfZETz8yPDwUT7SX5zt1c7qIu7S5wKgFAOk0xqZ7Lml0sibL5hN97ysSTnD
	9uxron4juTfAQaA5uObbTrX1JAFT2g2xNT08+glIphhQ=
X-Google-Smtp-Source: AGHT+IFbbv0BZAtT3+HnJDyyTNgCMRJZb9KZLNLH4dIHpFGSJZsnxop7uFuUlZaFtez53aVT2kI+Hg==
X-Received: by 2002:a05:600c:6214:b0:43c:e467:d6ce with SMTP id 5b1f17b1804b1-44cc05358b3mr170613645e9.4.1748447004994;
        Wed, 28 May 2025 08:43:24 -0700 (PDT)
Received: from [10.0.12.41] (253.124-78-194.adsl-static.isp.belgacom.be. [194.78.124.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4eacd6f1bsm1769856f8f.80.2025.05.28.08.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 08:43:24 -0700 (PDT)
From: Bram Vlerick <bram.vlerick@openpixelsystems.org>
Date: Wed, 28 May 2025 17:42:30 +0200
Subject: [PATCH] staging: fbtft: add invert display parameter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-ili9341-invert-dtb-v1-1-080202809332@openpixelsystems.org>
X-B4-Tracking: v=1; b=H4sIAOUuN2gC/x3MTQqAIBBA4avErBswS/u5SrSoHGsgLFQiCO+et
 PwW770QyDMFGIoXPN0c+HQZVVnAus9uI2STDVJIJZTskA/u66ZCdjf5iCYuKNpZaaVJG2sgh5c
 ny88/HaeUPolD9bRkAAAA
X-Change-ID: 20250528-ili9341-invert-dtb-07a5656e6dfd
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Bram Vlerick <bram.vlerick@openpixelsystems.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2995;
 i=bram.vlerick@openpixelsystems.org; h=from:subject:message-id;
 bh=BMRUJzr0/HLa3ogV5/HusC1YamEdyusN8YfIZyUZixE=;
 b=owEBbQKS/ZANAwAIAblauka9BQbwAcsmYgBoNy8chB2y8w5nbK9+RztKsMs3unwb1aVwo2U36
 FwTbirKHOeJAjMEAAEIAB0WIQQO7PtG7b77XLxuay25WrpGvQUG8AUCaDcvHAAKCRC5WrpGvQUG
 8GvpD/9SsZFzhvQs0gQHp72J5bWBgaHGOAaSW43Xne+PZMAjdUCH4O23F2Syc387TEDUe/FTeWZ
 kp5HtOO3HdadO8z0wT6nXXINzJfFLkXufNXmxFbHQ8x2VuSGTlIKYhuzla4BlFV+dJJ60/83RRX
 DKADQ1s4itlnkqEVyeD3cJad734FHh6ZjaqG7sZobZxqcZcGRO7LBBO2SSveqlUZO502Tp9b0MM
 LHZwjVFPUcDWZpBoJZUTg0Bw5calTX2Mh/Ibwzr1yERYLUO01KqWi2/01IGvu01G3ucNGq0RR2A
 n7LHuRVOZkJFaBjUx2XPi7bPBYD47fgBMRT5/uIeCM5gh/W/DXFUU+t6j5A6vOE7SF61jWbGrsY
 wBC3xLx+WDXCvrFhj9xAmV5L+TRjvCEWIsuOy7q88ge/SI7t4d913AWKAEvdvhnhllg+mOSH7Dc
 BZOo5wTDep2WxoScD9VgeqMv4v8QwkOGCv9H1fDhWZY1fxNCwvpQU9bH111ZD8aSHZPAEHgTdQN
 eKx6hZNtBFIjq40TAQ5zQnGnAa2NfisLBqVqKAFgaqFahnwB3bRj6EXC4ME4wuCKH1g2O8+xQKY
 LLKmSqiMsu+UM56ihNwxQ4hVpy5WeDercM0s+Fc2UdFzPNnzrSr1G4BS1YhpzNousCBK7vnlKwX
 dOZ+YVluePM0Drg==
X-Developer-Key: i=bram.vlerick@openpixelsystems.org; a=openpgp;
 fpr=0EECFB46EDBEFB5CBC6E6B2DB95ABA46BD0506F0

Add devicetree parameter to enable or disable the invert feature of the
ili9341 display

Signed-off-by: Bram Vlerick <bram.vlerick@openpixelsystems.org>
---
 drivers/staging/fbtft/fb_ili9341.c | 3 +++
 drivers/staging/fbtft/fbtft-core.c | 2 ++
 drivers/staging/fbtft/fbtft.h      | 3 +++
 3 files changed, 8 insertions(+)

diff --git a/drivers/staging/fbtft/fb_ili9341.c b/drivers/staging/fbtft/fb_ili9341.c
index 47e72b87d76d996111aaadcf5e56dfdfc1c331ab..a184f57df12b5ad6612a2e83b664a8911c7c79be 100644
--- a/drivers/staging/fbtft/fb_ili9341.c
+++ b/drivers/staging/fbtft/fb_ili9341.c
@@ -103,6 +103,9 @@ static int set_var(struct fbtft_par *par)
 		break;
 	}
 
+	if (par->invert)
+		write_reg(par, 0x21);
+
 	return 0;
 }
 
diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
index da9c64152a606dc4a176f5a37fa59f6a7d3a2af3..4e827e9899e32313f2e4a9bf12ff49283a63fed3 100644
--- a/drivers/staging/fbtft/fbtft-core.c
+++ b/drivers/staging/fbtft/fbtft-core.c
@@ -641,6 +641,7 @@ struct fb_info *fbtft_framebuffer_alloc(struct fbtft_display *display,
 	par->buf = buf;
 	spin_lock_init(&par->dirty_lock);
 	par->bgr = pdata->bgr;
+	par->invert = pdata->invert;
 	par->startbyte = pdata->startbyte;
 	par->init_sequence = init_sequence;
 	par->gamma.curves = gamma_curves;
@@ -1107,6 +1108,7 @@ static struct fbtft_platform_data *fbtft_properties_read(struct device *dev)
 	pdata->display.bpp = fbtft_property_value(dev, "bpp");
 	pdata->display.debug = fbtft_property_value(dev, "debug");
 	pdata->rotate = fbtft_property_value(dev, "rotate");
+	pdata->invert = device_property_read_bool(dev, "invert");
 	pdata->bgr = device_property_read_bool(dev, "bgr");
 	pdata->fps = fbtft_property_value(dev, "fps");
 	pdata->txbuflen = fbtft_property_value(dev, "txbuflen");
diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 317be17b95c1672404fc6aecda24d0a1f563685d..71c9c35e7548de314088ac3aeb160d6c6aaf75c9 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -125,6 +125,7 @@ struct fbtft_display {
  * @display: Display properties
  * @gpios: Pointer to an array of pinname to gpio mappings
  * @rotate: Display rotation angle
+ * @invert: Invert display colors
  * @bgr: LCD Controller BGR bit
  * @fps: Frames per second (this will go away, use @fps in @fbtft_display)
  * @txbuflen: Size of transmit buffer
@@ -135,6 +136,7 @@ struct fbtft_display {
 struct fbtft_platform_data {
 	struct fbtft_display display;
 	unsigned int rotate;
+	bool invert;
 	bool bgr;
 	unsigned int fps;
 	int txbuflen;
@@ -229,6 +231,7 @@ struct fbtft_par {
 	bool first_update_done;
 	ktime_t update_time;
 	bool bgr;
+	bool invert;
 	void *extra;
 	bool polarity;
 };

---
base-commit: 914873bc7df913db988284876c16257e6ab772c6
change-id: 20250528-ili9341-invert-dtb-07a5656e6dfd

Best regards,
-- 
Bram Vlerick <bram.vlerick@openpixelsystems.org>


