Return-Path: <linux-kernel+bounces-828075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6AB93E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 03:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8BF2E2DE4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 01:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B7026E6E5;
	Tue, 23 Sep 2025 01:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfRiUpBT"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0285F24169A
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758591115; cv=none; b=YGtLzwrSuRxjLo6/Kvm0U2Rh1mkDASdkQR1zqomRNajJCMa3CcRuWygduHnND3ulr5oMRdE+U29ORdPJ9nyqdheJVryvOUBG43ETBHq8rV8w5kYH71w5cc+u1NfCEphQqwQm5vuxl1xupAhOnUg+p9XOdErT3gDJQo/rJa+SMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758591115; c=relaxed/simple;
	bh=enRRJ9zI/Ygm2iee/WLxf+0en7DFxzk7Hvw3tz6BAp0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jArV742hWuYZIVDN99PIpOCj2HYthN/8c6LhNwDgF9tIniw5dWFHK0EtMyCcdEGs6h5VCMJ8CivIpqK9q68xGHgeSmZQgjjpfIrjKXnLLillLgeagFDYNNMV6aUDs+9ep3l1pmXOuw3op/L9GoedbB1ivcmwakJ96bgfr5MKjKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfRiUpBT; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-62fa99bcfcdso7280649a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758591112; x=1759195912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrKsh8c8RYPKamPFgYjCfgonF8SmGFx9zFPBcloUT7k=;
        b=HfRiUpBTSjkeALAVgQWQovcT4w/DOoK8ZN+ZaYh8wYNoB2yLGfOpkHMPihFGd3pKPN
         tEUira6i5i5hlwBB35LNFYQHadxpAvyYRDTcUDhSAZSN/pjqSzX0d563Ef7br8sD837w
         6j6/0CevfnP8rLAJALEQtn8i6tKCJGZdq9wn4u6/XwTRWw3sduTF6nlD89wBTTRzLvKF
         C4au0EecTJs4BEINSlvmk97Txz0NSNJWua5Gi8ZNiM/i8Klpy1qoV11f5Ns3lg7TnuXU
         rLjhi03fB9L0jjkKqlgyAQyhF+9CtDOiZN8DoGbTCj/J0/RAE05vvf5TdbDcZTHxCh4f
         0DKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758591112; x=1759195912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrKsh8c8RYPKamPFgYjCfgonF8SmGFx9zFPBcloUT7k=;
        b=b6FYlycSzRasZMfqOZWjOJK3/UqZHB29DKwOLdgphw3I6mkKsbI6x2ET75i1w4mr3r
         PRTieOaMaOJ+egLIuVbKceSdRJg+eqvkWnWXYsGJ4VO9mzmXezkRY23WtHLFIFkUp9ND
         BXDiOd+Tje4btLfiflqwjXY8MYbQEU7Lx6fKe15pJ5z7QkkIq1Xt2VCsRdNHupMsJq6V
         lcQB932e7k2L50WaYbW+YhGlxgW8LRmwkQbYR3gJn/Q9baRqf+s7hQuBkcFLMd+/kYjT
         U7lzRoh8uo1Xc2jBBq1Rpa3vT188vwGMnyQniCBeZMQ5o09CJz6ZiYjqunBX0lwj1YrJ
         Du9w==
X-Forwarded-Encrypted: i=1; AJvYcCUX1K9qoaWB3OHfqZV8z4d+3DKWQhgQJXYnM72wZeJKWWHZKuDsFt7En7+iq7PDyzrbxsVg24KVwf0rAow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEddAy1FmLPfXWlH7/cnD+i+HD7IxoiiwxquvlmNXA0UoedszH
	xI2huA4h9of0EMgNMmI9WST9XEc9KmgeT5QYfa2PwQ2UZ6I2DKMOUJAr9ksn/1tWOCI=
X-Gm-Gg: ASbGncvzVqaufYzFlJ1XVgL5AVdB7qw5dFubSV3pCyTPfOlX0rGzLChpfJRpiTRfvsL
	hY0QQSZt86Z0lrYevfpYFa4EjoRV1LbQxWz8xCepKR2fUr4FzEU6gX96g4EeXp3a5IYiVHjorXH
	6AB32iFrLQNImSXU3nqMaVhRpirZ4GMjDPkFwcU9XrTEtQ60dP4RoDk7lBzQ36ve/k+eT9v1BQ4
	ITJ+fv25SjNykeuivBIJkudiBK2FcjsRYsttN2qa18ye/OEjoFjzLvnw9y7nLt/n9QXS7fo6XGc
	cACcZhbu0/wZqgPmM6H1JSRXyijEsuLA1x07cK8m16GKRxS0/lDxg+orn/CL7DX5PUbyheUOS81
	Qu60VGnjBxprmkJZD9NqshDLw6fE4uiYB1ws=
X-Google-Smtp-Source: AGHT+IGtR6iWFZQQ5FHKwT9ILZ11FIvQFpLdt7hspCQzjGuPF9hoBiFvc7R9FVX/qQih2MVS6MW6Hg==
X-Received: by 2002:a05:6402:26c3:b0:633:fa32:b4ae with SMTP id 4fb4d7f45d1cf-63467801f74mr691751a12.31.1758591112151;
        Mon, 22 Sep 2025 18:31:52 -0700 (PDT)
Received: from reolab.localdomain ([83.120.18.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62fa5f28838sm9775823a12.45.2025.09.22.18.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 18:31:50 -0700 (PDT)
From: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Subject: [PATCH v2] ACPI: debug: fix signedness issues in read/write helpers
Date: Tue, 23 Sep 2025 05:01:13 +0330
Message-ID: <20250923013113.20615-1-a.jahangirzad@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ACPI debugger interface, the helper functions for read and write
operations use an "int" type for the length parameter. When a large
"size_t count" is passed from the file operations, this cast to "int"
results in truncation and a negative value due to signed integer
representation.

Logically, this negative number propagates to the min() calculation,
where it is selected over the positive buffer space value, leading to
unexpected behavior. Subsequently, when this negative value is used in
copy_to_user() or copy_from_user(), it is interpreted as a large positive
value due to the unsigned nature of the size parameter in these functions,
causing the copy operations to attempt handling sizes far beyond the
intended buffer limits.

Address the issue by:
- Changing the length parameters in acpi_aml_read_user() and
  acpi_aml_write_user() from "int" to "size_t", aligning with the
  expected unsigned size semantics.
- Updating return types and local variables in acpi_aml_read() and
  acpi_aml_write() to "ssize_t" for consistency with kernel file
  operation conventions.
- Using "size_t" for the "n" variable to ensure calculations remain
  unsigned.
- Using min_t() for circ_count_to_end() and circ_space_to_end() to
  ensure type-safe comparisons and prevent integer overflow.

Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
---
 drivers/acpi/acpi_dbg.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index d50261d05f3a1..0ec12007fad31 100644
--- a/drivers/acpi/acpi_dbg.c
+++ b/drivers/acpi/acpi_dbg.c
@@ -569,11 +569,11 @@ static int acpi_aml_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static int acpi_aml_read_user(char __user *buf, int len)
+static ssize_t acpi_aml_read_user(char __user *buf, size_t len)
 {
-	int ret;
+	ssize_t ret;
 	struct circ_buf *crc = &acpi_aml_io.out_crc;
-	int n;
+	size_t n;
 	char *p;
 
 	ret = acpi_aml_lock_read(crc, ACPI_AML_OUT_USER);
@@ -582,7 +582,7 @@ static int acpi_aml_read_user(char __user *buf, int len)
 	/* sync head before removing logs */
 	smp_rmb();
 	p = &crc->buf[crc->tail];
-	n = min(len, circ_count_to_end(crc));
+	n = min_t(size_t, len, circ_count_to_end(crc));
 	if (copy_to_user(buf, p, n)) {
 		ret = -EFAULT;
 		goto out;
@@ -599,8 +599,8 @@ static int acpi_aml_read_user(char __user *buf, int len)
 static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 			     size_t count, loff_t *ppos)
 {
-	int ret = 0;
-	int size = 0;
+	ssize_t ret = 0;
+	ssize_t size = 0;
 
 	if (!count)
 		return 0;
@@ -639,11 +639,11 @@ static ssize_t acpi_aml_read(struct file *file, char __user *buf,
 	return size > 0 ? size : ret;
 }
 
-static int acpi_aml_write_user(const char __user *buf, int len)
+static ssize_t acpi_aml_write_user(const char __user *buf, size_t len)
 {
-	int ret;
+	ssize_t ret;
 	struct circ_buf *crc = &acpi_aml_io.in_crc;
-	int n;
+	size_t n;
 	char *p;
 
 	ret = acpi_aml_lock_write(crc, ACPI_AML_IN_USER);
@@ -652,7 +652,7 @@ static int acpi_aml_write_user(const char __user *buf, int len)
 	/* sync tail before inserting cmds */
 	smp_mb();
 	p = &crc->buf[crc->head];
-	n = min(len, circ_space_to_end(crc));
+	n = min_t(size_t, len, circ_space_to_end(crc));
 	if (copy_from_user(p, buf, n)) {
 		ret = -EFAULT;
 		goto out;
@@ -663,14 +663,14 @@ static int acpi_aml_write_user(const char __user *buf, int len)
 	ret = n;
 out:
 	acpi_aml_unlock_fifo(ACPI_AML_IN_USER, ret >= 0);
-	return n;
+	return ret;
 }
 
 static ssize_t acpi_aml_write(struct file *file, const char __user *buf,
 			      size_t count, loff_t *ppos)
 {
-	int ret = 0;
-	int size = 0;
+	ssize_t ret = 0;
+	ssize_t size = 0;
 
 	if (!count)
 		return 0;
-- 
2.51.0


