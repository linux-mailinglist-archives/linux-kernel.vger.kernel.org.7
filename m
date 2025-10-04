Return-Path: <linux-kernel+bounces-842174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3065BB9247
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 00:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4D9794E211F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7F4D2367BA;
	Sat,  4 Oct 2025 22:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KW5xuc1u"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6FA1DFDE
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 22:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759616536; cv=none; b=Kd6r+/VoZ72DjKL/FeCtlXfzOn/UvD6UgsQesF95CEklS2C/NRFxlACZ7O0khoLI0LpIi7uSbC7gRF108tou5QDf7DeyH0oJQQz4xowqYwxeoDlPFbvAbNbA5drKGP92SvxF+sh7PCTAJ6YCkTsVj5Rv+iv6q7lIIkjFmpPYEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759616536; c=relaxed/simple;
	bh=39YoiNSMDCxDpfLooP8sflP3UvQv1utCoUo6Zqj4C/c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cu/wzqWI857b+ce8Td4jFXzC1jSrRdtcjV5HR0UBglcPITSZm+V5NriVz/sf4HFu+05XgzQ2yJSdUvh2YSdOjhHzl+kzLBsHUvH9mUEwQcOZyz0ecXnAdwbrWzoIZWHZDGErtLXrw46pen/doHfYg8nJpsyxJbuiVoi6UwYFgdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KW5xuc1u; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-856cbf74c4aso441019485a.2
        for <linux-kernel@vger.kernel.org>; Sat, 04 Oct 2025 15:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759616533; x=1760221333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1r2clqBFSV7dqpj1DVDfxAqCqC1OU5kGTIJ6Q5R1gBs=;
        b=KW5xuc1u21WuhkWEhTor5qCkO2lle2+KJgfYa0jFdWsXSEqtO+V4esDpX0oBFZbfGa
         CbZfwP3BA1CYObDRQAdBrY28uBDy3mD5SzbSxAOvb5xneP/6SDwWQOB9cR6cCH3Shxdk
         ko8wajmvw2iCaS8U7E2oZEqaUH2sliaJxYGzZ6JL2SGVM8Z/QUSuEKEqg9glXcIN+9qy
         zD7WlYkkcqJgLApT9kIsm57/SPxceM0ZyvViIeR1jbRK8qBJ6zePI8iXZsKeikGn3I/y
         s+Nv9WXyonp+U1VW3uo7GQSGw1ACzQUiH4ycXjWIDVgDpj1dWHbatylwdM8QnnaQEoip
         72Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759616533; x=1760221333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1r2clqBFSV7dqpj1DVDfxAqCqC1OU5kGTIJ6Q5R1gBs=;
        b=arRCOwylkVmV43McFQHoQ9S5lvRsJxkYr2xMJiC4T6qcvfCfcJnCTala6EnnxEMZ8G
         iLOjgZOa/d2URgPMHcwvdKT2EDTu0i/A2KJSnHSYMFPpKGISMykDuJPRXQIHPaV45gj7
         LAGjQJECblS8v0X7FPBMSLJWG9dNH5iobnMrhLCJS1BldS98vNagE50Fexhi5bFY3IeB
         NjakxSj/1bwZea1dIx010UWNpIR65+ROn0k1NxTx9v44KXZuHbt9VsWDj+3p/lZVbsKi
         v68QZyp/nhh4rohYVmktRCKg77IWigYkbG9BkLZ9rrt3zrtLotrQ9n9++ItoEz1+KG6+
         ixiA==
X-Forwarded-Encrypted: i=1; AJvYcCUUvJAivtuGQDceMTNQbLU7v9iviZuODu8x2YP4/viflaNt7mutwgAcD/PWGkAPBXO0Xf80ixGAslc43MQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXuSiuRZZgMtSFT1dwxSbqWbL09+SRcBcoiW86mjNv/pFhBa/J
	M3/ua7Sx4d66Cig+Zjci4Pxwo4fOsGT3zKXcwxdrgmjol7CbCXl/d3fp
X-Gm-Gg: ASbGncvAu9mrhXS/kgsxf8unPvwrsYU7gAxMbwp2NCBtxK8APjhCh5tcp+s5IgsWWFn
	61MozYXwwzaHhCupZBAaa2nZc3NtKv+lX6mMZgIK+k23KHmStTsBOtzZUeXpQuH7+1QvJYnEZaZ
	VXs559mhcisDFGtJMd7+1mhOvDBT7I4J0jhodRiNPqsJcWtZOdi24QVrysmgFMzFhH0RXDsVjxj
	YNosIOgkRjsGNyxgq1LP03dmMb+tM2NXd3XdgBBijXgIGXH/aTYYwiD8Rkdv8oC+n6u5AL4gsXP
	uBKL9woB7xqbBT624CSlmXeiptAwMJI+8SY08oumaAQHpCZZ/Ay5aCc6mq/9h1SxH1NMEHm/ETp
	qIcXA72iie0ZHldrVreqAi+5syTm7Sfqf6OjwYXCd/0UCcO0JD9kfMzohFbsc/WEkRjZE90V1wj
	FR+lQ=
X-Google-Smtp-Source: AGHT+IHwiWUwYA3GGqG3Xzu99skiXQi5N6aLzx7bABxV+faWK4cEQIdZmIZk5vDEmGMDX81YYkusmA==
X-Received: by 2002:a05:620a:488e:b0:84c:1d25:890d with SMTP id af79cd13be357-87a3adf2cb5mr917330885a.57.1759616533549;
        Sat, 04 Oct 2025 15:22:13 -0700 (PDT)
Received: from kernel-internship-machine.. ([143.110.209.46])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777979704csm775779785a.50.2025.10.04.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Oct 2025 15:22:12 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: krzk@kernel.org
Cc: w1-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	vivek.balachandhar@gmail.com
Subject: [PATCH] w1: use sysfs_emit() in sysfs show() callbacks
Date: Sat,  4 Oct 2025 22:21:28 +0000
Message-Id: <20251004222128.4105173-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace sprintf in sysfs show() paths with sysfs_emit(),
per Documentation/filesystems/sysfs.rst.
No functional changes.

Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
---
 drivers/w1/w1.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/w1/w1.c b/drivers/w1/w1.c
index d0474a0532ec..002d2639aa12 100644
--- a/drivers/w1/w1.c
+++ b/drivers/w1/w1.c
@@ -86,7 +86,7 @@ static ssize_t name_show(struct device *dev, struct device_attribute *attr, char
 {
 	struct w1_slave *sl = dev_to_w1_slave(dev);
 
-	return sprintf(buf, "%s\n", sl->name);
+	return sysfs_emit(buf, "%s\n", sl->name);
 }
 static DEVICE_ATTR_RO(name);
 
@@ -207,7 +207,7 @@ static ssize_t w1_master_attribute_show_name(struct device *dev, struct device_a
 	ssize_t count;
 
 	mutex_lock(&md->mutex);
-	count = sprintf(buf, "%s\n", md->name);
+	count = sysfs_emit(buf, "%s\n", md->name);
 	mutex_unlock(&md->mutex);
 
 	return count;
@@ -243,7 +243,7 @@ static ssize_t w1_master_attribute_show_search(struct device *dev,
 	ssize_t count;
 
 	mutex_lock(&md->mutex);
-	count = sprintf(buf, "%d\n", md->search_count);
+	count = sysfs_emit(buf, "%d\n", md->search_count);
 	mutex_unlock(&md->mutex);
 
 	return count;
@@ -276,7 +276,7 @@ static ssize_t w1_master_attribute_show_pullup(struct device *dev,
 	ssize_t count;
 
 	mutex_lock(&md->mutex);
-	count = sprintf(buf, "%d\n", md->enable_pullup);
+	count = sysfs_emit(buf, "%d\n", md->enable_pullup);
 	mutex_unlock(&md->mutex);
 
 	return count;
@@ -288,20 +288,20 @@ static ssize_t w1_master_attribute_show_pointer(struct device *dev, struct devic
 	ssize_t count;
 
 	mutex_lock(&md->mutex);
-	count = sprintf(buf, "0x%p\n", md->bus_master);
+	count = sysfs_emit(buf, "0x%p\n", md->bus_master);
 	mutex_unlock(&md->mutex);
 	return count;
 }
 
 static ssize_t w1_master_attribute_show_timeout(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", w1_timeout);
+	return sysfs_emit(buf, "%d\n", w1_timeout);
 }
 
 static ssize_t w1_master_attribute_show_timeout_us(struct device *dev,
 	struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", w1_timeout_us);
+	return sysfs_emit(buf, "%d\n", w1_timeout_us);
 }
 
 static ssize_t w1_master_attribute_store_max_slave_count(struct device *dev,
@@ -328,7 +328,7 @@ static ssize_t w1_master_attribute_show_max_slave_count(struct device *dev, stru
 	ssize_t count;
 
 	mutex_lock(&md->mutex);
-	count = sprintf(buf, "%d\n", md->max_slave_count);
+	count = sysfs_emit(buf, "%d\n", md->max_slave_count);
 	mutex_unlock(&md->mutex);
 	return count;
 }
@@ -339,7 +339,7 @@ static ssize_t w1_master_attribute_show_attempts(struct device *dev, struct devi
 	ssize_t count;
 
 	mutex_lock(&md->mutex);
-	count = sprintf(buf, "%lu\n", md->attempts);
+	count = sysfs_emit(buf, "%lu\n", md->attempts);
 	mutex_unlock(&md->mutex);
 	return count;
 }
@@ -350,7 +350,7 @@ static ssize_t w1_master_attribute_show_slave_count(struct device *dev, struct d
 	ssize_t count;
 
 	mutex_lock(&md->mutex);
-	count = sprintf(buf, "%d\n", md->slave_count);
+	count = sysfs_emit(buf, "%d\n", md->slave_count);
 	mutex_unlock(&md->mutex);
 	return count;
 }
-- 
2.34.1


