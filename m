Return-Path: <linux-kernel+bounces-793647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 79DE4B3D66D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59C744E1564
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B73B21254B;
	Mon,  1 Sep 2025 02:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEvM2nkw"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E68A1487E9
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756692038; cv=none; b=CjvJyXY/VPfRYeyZP5YnFA2wIakQdEyrbBQiAOKL4sui7zeEsa+WsSUw7upFmF5J5KzXhbKs1wVpSRzDG5z9wGrpdG87XoHbQ6mbFvEgW3oohKyZ4RfMeUh3QRo2RezWu+1dHu32RC9WlOIx1ZqM6a/5ayEK8Thl++oy+wz4F9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756692038; c=relaxed/simple;
	bh=1aWTBAdS4PB+lh6dnTRs/ku6VxyVPsJAiRIyLMSDIL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pMEyLimzkp0wWggukOZTAlZPyahr2XJTLnqllDNxzB0gQvD8po5RZhbip0dNuJslp8PUJsCqlXBNHE9gT7OkJz2Y+pZO0CtF7aPhB9Oqh5F9gSkshCL0feh+eml+GzgidgK4l1zWt+uIo85VZ4C1qWhk89KnOaDnlANDwrvAdWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UEvM2nkw; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109c58e29so69580431cf.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 19:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756692036; x=1757296836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KD5oP3Sp6/nJlHDS88G+RVK/pDe+DHoDDcESnyvvqMA=;
        b=UEvM2nkw+KfCcTVSdsTu2pKJ6pmafBAppfr2yXOn8cdG/FxacMopTwddXTosboew3z
         m1WtDkIw8/VH6wUuKRVSI3R8HK2HS16qg38n4YISKZG35MVhn7d7Px5jOOlL6yoeYh1t
         xLz0yCzh/XDxLNa+BggYHM/jXIDiSEHpv6jzHgSZpiDZYmpZ5r3V7I9HwFmYII5Ij1iv
         /nUgooDUN/yJtIA2UgE/36vDuK99H1LArCxE5/NEduTUU9md/XNfziK/nPUB9LeYFcSi
         dY2hGcrcEesJLdgxrSf7XhTFF6Os40YEO4xtus+iKHKXgbAQ5GfpehJII1HfRQRocNkz
         PGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756692036; x=1757296836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KD5oP3Sp6/nJlHDS88G+RVK/pDe+DHoDDcESnyvvqMA=;
        b=uE02qVYdOVRdCyD9WQzj7P1o6uwl0BzdCQlOfbZev9mxQ4KkXzJQOdMF7oBlETCZDr
         d6X6z4g5GI6/n6lTqZujEzB2n+GvFVmtT87ZXkVaZ2q2KH8yHT5b4mjJr0zgI7fj+FZL
         pR+Ff/y7wp12uBEhHtVXexJh1dW6GV7nlZdqcY9KGEdDBakPFpMLJvtTG7sT8+s0OXze
         /sJ78TimAAKSwCChn3MKsB6J0J4gNBs8Y6kXNy4gBky1B1TWxHxu8+AAXrwWL9ij1zF7
         MyhV1xqgbeaGKSfHrocw38CColGNGlGpOziSBbdJnqRQX66VZ58BbDWmeDNOG99Xs+yf
         ingg==
X-Gm-Message-State: AOJu0YzOMeK5LaHbw5vla0Jo6678Ojs8nZ4hKpR3Ec8lBtmL6Abf9Ktr
	RgziAcmmTRA+fYrw2WrG4yx6rgiGg3w5btXp5ljorn5PRST3A+j6oZxM
X-Gm-Gg: ASbGncs+Za20sxO6ZcFmsWdpLRjDFM1+EGSv1nyHtWmlsaB01wS/vv6L47Hxcr6Gotw
	YtdcYGfqoMi+QpH4mrB7z24oX/kjOaKXgC4OoDOCJZ8H7rBQ8UjVlFoCBb2FHsaDWmNABhW/Ws1
	wjzl5T84QCrG1dLDTpgUzwOp8pf/rmWZ7oJcQbNfHeWB05eHJxcooEe3GVEroM7DSISZMW8H4tQ
	N3XpDbGxigcA3ksGnJ5XR7o4TF/xWS0WnJZBfvSqYvC6PE5o+AHpbNpNcUvaRLivoBTuKvI1s5M
	kDw4M/fM+ubEWlaG65K6CTt2mGKxQEozNj++2PVqKJgU269vAtqnR/ezRacAAiT7Kz2OIzZgtss
	Zh9tXjc0T/7va50Drk9QaN++POoROZhCemWuexjZB+QklVap9s5nR/g6tP4ud2pkuRrwDIik3D+
	RXXAc=
X-Google-Smtp-Source: AGHT+IEEEhOHJHKVo9c2qoDwUkUfdgrICndDqLDF0Y9QKv018f7khAYv85uhvdgp1+VXtxmxOp873A==
X-Received: by 2002:a05:622a:2cb:b0:4b3:d28:c96 with SMTP id d75a77b69052e-4b31d7f062emr76822691cf.13.1756692035726;
        Sun, 31 Aug 2025 19:00:35 -0700 (PDT)
Received: from localhost (modemcable197.17-162-184.mc.videotron.ca. [184.162.17.197])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b30b584340sm53060731cf.17.2025.08.31.19.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 19:00:35 -0700 (PDT)
From: =?UTF-8?q?Jean-Fran=C3=A7ois=20Lessard?= <jefflessard3@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] auxdisplay: linedisp: encapsulate container_of usage within to_linedisp
Date: Sun, 31 Aug 2025 22:00:25 -0400
Message-ID: <20250901020033.60196-2-jefflessard3@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901020033.60196-1-jefflessard3@gmail.com>
References: <20250901020033.60196-1-jefflessard3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Replace direct container_of() calls with a to_linedisp() helper function
throughout the line-display auxdisplay library module. This abstraction
prepares for upcoming dual-mode support where linedisp context retrieval
will need to handle both dedicated child devices and attached parent
auxdisplay devices.

No functional changes in this patch.

Signed-off-by: Jean-François Lessard <jefflessard3@gmail.com>
---
 drivers/auxdisplay/line-display.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/auxdisplay/line-display.c b/drivers/auxdisplay/line-display.c
index 8590a4cd2..e44341b1e 100644
--- a/drivers/auxdisplay/line-display.c
+++ b/drivers/auxdisplay/line-display.c
@@ -31,6 +31,11 @@
 
 #define DEFAULT_SCROLL_RATE	(HZ / 2)
 
+static struct linedisp *to_linedisp(struct device *dev)
+{
+	return container_of(dev, struct linedisp, dev);
+}
+
 /**
  * linedisp_scroll() - scroll the display by a character
  * @t: really a pointer to the private data structure
@@ -133,7 +138,7 @@ static int linedisp_display(struct linedisp *linedisp, const char *msg,
 static ssize_t message_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 
 	return sysfs_emit(buf, "%s\n", linedisp->message);
 }
@@ -152,7 +157,7 @@ static ssize_t message_show(struct device *dev, struct device_attribute *attr,
 static ssize_t message_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	int err;
 
 	err = linedisp_display(linedisp, buf, count);
@@ -164,7 +169,7 @@ static DEVICE_ATTR_RW(message);
 static ssize_t scroll_step_ms_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 
 	return sysfs_emit(buf, "%u\n", jiffies_to_msecs(linedisp->scroll_rate));
 }
@@ -173,7 +178,7 @@ static ssize_t scroll_step_ms_store(struct device *dev,
 				    struct device_attribute *attr,
 				    const char *buf, size_t count)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	unsigned int ms;
 	int err;
 
@@ -195,7 +200,7 @@ static DEVICE_ATTR_RW(scroll_step_ms);
 
 static ssize_t map_seg_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	struct linedisp_map *map = linedisp->map;
 
 	memcpy(buf, &map->map, map->size);
@@ -205,7 +210,7 @@ static ssize_t map_seg_show(struct device *dev, struct device_attribute *attr, c
 static ssize_t map_seg_store(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	struct linedisp_map *map = linedisp->map;
 
 	if (count != map->size)
@@ -232,7 +237,7 @@ static struct attribute *linedisp_attrs[] = {
 static umode_t linedisp_attr_is_visible(struct kobject *kobj, struct attribute *attr, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 	struct linedisp_map *map = linedisp->map;
 	umode_t mode = attr->mode;
 
@@ -263,7 +268,7 @@ static DEFINE_IDA(linedisp_id);
 
 static void linedisp_release(struct device *dev)
 {
-	struct linedisp *linedisp = container_of(dev, struct linedisp, dev);
+	struct linedisp *linedisp = to_linedisp(dev);
 
 	kfree(linedisp->map);
 	kfree(linedisp->message);
-- 
2.43.0


