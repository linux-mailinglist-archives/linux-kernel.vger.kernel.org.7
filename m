Return-Path: <linux-kernel+bounces-817744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AFDEB585EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B894E7B3E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 20:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B1B295DA6;
	Mon, 15 Sep 2025 20:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iCkFRapy"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54573286412
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 20:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757967489; cv=none; b=LYvhWvVbXeV45cxWkznHBG8Bt3xgWuT6eTGDnPxkrVkJ96QAA6q95JgBZBDsvrz12zLrurV4mPVP32jxH0cz/ZPhS7P6skQsp5XIP3YECi+EA1ZmMzhj5TNQTZmTxoah9bMppZjaefhSpkFgo5NjiwLRq+dYU+2gwQcMFdvEbJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757967489; c=relaxed/simple;
	bh=YXaaX3mBSOFz58cOFHytlBQDl2+gkOkHQg6V+LkPG0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LElTR5A3Ln22oXC4dH0lTLnp3ZbHnURp/UD4LodqvtDedC2XWpvP4N6dqu1/I8rOQvFWNR/BGNxGHmDE5/KsBE73cedWAXChp2YfFMwc3sRjGanTUhXbj9CRUOskxWfM2MQYlEBxpQnzuQMFG2dknDJqjwZD/9fdPhH6f7eA/sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=iCkFRapy; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3eb08d8d9e7so939086f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1757967484; x=1758572284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BnyiKj9WXXr1bimeuPTNBfAohINHJ8FArmWULmp0E20=;
        b=iCkFRapy2GSOjfgYqfvVENJ0EZArICNGsREIL27ftogNW94N5Ams/SsDNmh6zGamXW
         CM26MF9T7x3XjSp8EeD7WdZcaWRnpVOhs8waXIrTNlBTzZQcFvvzkO5T2eVYwz00awMn
         DvaxZ80DwUG6Np4z7Lw6DxH2I0dwcX5sduDxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757967484; x=1758572284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BnyiKj9WXXr1bimeuPTNBfAohINHJ8FArmWULmp0E20=;
        b=Z3pifum2wm2UN1goTYVE5WQtW+syoIg/ZS4w9tDvAOP/AlVbB5FRfFYxhLL1kz9GHf
         gKlkcWEPO/ilrQe45t/qrWFTUX9vx84BkcDzT2zgbW/Qe7jwIV1OK/KB77oZirK4l5mq
         FJ3m2wACK6ZF3XYCM3FS4H4ltsP94/ioe9xcG5+PcTHhLnk8qjYqH5goDWfd9p/IMFOx
         RmESYpiIekswJJ3TL7EuAIiAG3fOb1RRIHwRgO7lLuY/eE/DyjrHsPwwD7FWRmrZygB4
         doogiRmhRLf3mJItCsIxzwSzpG2uuoim9oH+Fu+Wb2jp19509/SKUU7rqhhsst1CCJAS
         hBWw==
X-Gm-Message-State: AOJu0YznGsfludbdvODhFensQgKY6SqbnvWmqSx8eyynlbesLmZwh+0G
	cTdSx8cW6meVZmXL7lZNB2Woj8lgRBsHl1cQfFWMTck9CgzAy4Y5wCQYE1m6P4BBX/bPNd8AaB+
	ZVyEW
X-Gm-Gg: ASbGncvMGbgcLWYfHjNFsOEqa4mEJrsBuh+n1ofSY1I3MRGa0K6gENi1FKOEVVwu71i
	X3CRXu0YhUoLKHtg1jMzVDs1Gn1aLennX2qtPawDq0BrtGrqGMjV+81qtKwN1N2p4Wclzqei9k2
	qx2wjexYz8+H3BGevtvuB+rRFKUrYAzbe5hZaBja8K/ZtyHaNfI8zY/cE5wP3u7MJEzivFmHG4r
	Ft9ylDZaIeweXv+BTwSXV9Q6fJEVK67OTwEGC7z8bUc482ugnZoC9eqD+1YSKsxbMSDMJs7gbA+
	HuxtWsnJgxX66NeczQvHY0WjfL5XWQsONGQ+HfwrftMDmMXSsL4s0Cck8c9hFNIGav17DkPP5Ui
	yE/aK1UYRoMreNC1d0bL6/dVOOb1iRn8RZxMBslg1iZFPPgRckzWmwu4hor0hI4k=
X-Google-Smtp-Source: AGHT+IGgz5/4PpeM2ZEskqCLV1CUsr/izY7yyFiGM+CZhKSCuokZSQ4DbBnIzkYpZQMuQl8ogknAVQ==
X-Received: by 2002:a05:6000:2887:b0:3ec:1b42:1fa4 with SMTP id ffacd0b85a97d-3ec1b422126mr1277877f8f.14.1757967484587;
        Mon, 15 Sep 2025 13:18:04 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.. ([2.196.40.230])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7d369ea3bsm13724160f8f.0.2025.09.15.13.18.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 13:18:04 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Oliver Graute <oliver.graute@kococonnector.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Yu Jiaoliang <yujiaoliang@vivo.com>,
	linux-input@vger.kernel.org
Subject: [PATCH 2/2] Input: edt-ft5x06 - rename sysfs attribute report_rate to report_rate_hz
Date: Mon, 15 Sep 2025 22:16:32 +0200
Message-ID: <20250915201748.1712822-2-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250915201748.1712822-1-dario.binacchi@amarulasolutions.com>
References: <20250915201748.1712822-1-dario.binacchi@amarulasolutions.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysfs attribute has been renamed to report_rate_hz to match the
report-rate-hz property from device tree, making it clear that the same
parameter can be set via sysfs or device tree and behaves identically.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

 drivers/input/touchscreen/edt-ft5x06.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index d7a269a0528f..c23cf3817664 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -543,8 +543,8 @@ static int edt_ft5x06_report_rate_get(struct edt_ft5x06_ts_data *tsdata)
 	return 0;
 }
 
-static ssize_t report_rate_show(struct device *dev,
-				struct device_attribute *dattr, char *buf)
+static ssize_t report_rate_hz_show(struct device *dev,
+				   struct device_attribute *dattr, char *buf)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
@@ -597,9 +597,9 @@ static int edt_ft5x06_report_rate_set(struct edt_ft5x06_ts_data *tsdata,
 			    val);
 }
 
-static ssize_t report_rate_store(struct device *dev,
-				 struct device_attribute *dattr,
-				 const char *buf, size_t count)
+static ssize_t report_rate_hz_store(struct device *dev,
+				    struct device_attribute *dattr,
+				    const char *buf, size_t count)
 {
 	struct i2c_client *client = to_i2c_client(dev);
 	struct edt_ft5x06_ts_data *tsdata = i2c_get_clientdata(client);
@@ -645,7 +645,7 @@ static ssize_t report_rate_store(struct device *dev,
 	return error ?: count;
 }
 
-static DEVICE_ATTR_RW(report_rate);
+static DEVICE_ATTR_RW(report_rate_hz);
 
 static ssize_t model_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
@@ -699,7 +699,7 @@ static struct attribute *edt_ft5x06_attrs[] = {
 	&edt_ft5x06_attr_offset_x.dattr.attr,
 	&edt_ft5x06_attr_offset_y.dattr.attr,
 	&edt_ft5x06_attr_threshold.dattr.attr,
-	&dev_attr_report_rate.attr,
+	&dev_attr_report_rate_hz.attr,
 	&dev_attr_model.attr,
 	&dev_attr_fw_version.attr,
 	&dev_attr_header_errors.attr,
-- 
2.43.0

base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
branch: edt-ft5x06-report-rate

