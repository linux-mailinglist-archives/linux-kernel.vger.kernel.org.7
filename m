Return-Path: <linux-kernel+bounces-817542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78132B58381
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 19:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384104C551C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C30B2E1EF5;
	Mon, 15 Sep 2025 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EethH6wk"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70327D786
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757956899; cv=none; b=s6N1f4ftYVleoPn5dxapO60iGH+2OEijgYrJU7cOd/sSEx16CopukfoIlaXu6Tm5cpLajV4TuJ9EDcuwuD6Bnj2AMfWTe7jIvnz4Dtg+5dCQmlcsRtdXgh4K7qQF61qvLPKzSQqn8GjC3V5rF24hS2iUfd5pezZ6aEkYTT47zEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757956899; c=relaxed/simple;
	bh=WpegXv7L2q5nce4QrwZYAf24Fffl8t42I/LKE6Fyr4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBUmc0QxIEw6wZjOOKaidnTcBuRzvDlBbDzRnXLZExxgfddDqEnNiDOzxzeCE5fIRTIOhV8XBoZwaPIxp2MB/czY19iUJ/Zmp1kC70LBnfhFsS+sJdBXUqaHOOnHn5prgmFFohcFrQeVxtxVOYFkhn7zq6CaGUjn84MZvtXbLwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EethH6wk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0411b83aafso671188966b.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 10:21:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757956896; x=1758561696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=td2chPrpcXRRriXk2X2/u7ClZFwh3i+z6PZKNphNpCI=;
        b=EethH6wkk7cgyOuoUMlKYXQJbmVUe82CqelgiPXhwoylPsR8pAx3+U31128Ur2zEr1
         J1mUtUrj3dWOlhdHcvN3NDtfTcYwLLt0oHrfMKJUfrIuohnvBLuvRMCUyTfn/ZoSn0vD
         Q15YZt8fiddkK2Aq/UFLUb1QfNkib4R8V/tpNPZFcltyfq5N6ErJBnsA5o53C4XE/BRN
         Unlykc7dudlYH1A7b/z6KsXm1EXtaoE4aeTuCs8v1mLpPEgHJFnlmWcCveDwKsNle9ZZ
         9zGOKFhZ6dZx3DIQK5uSVMS6Fj2uNLwcmFMHp5lvsmOSuuLHEtVnMC1LG/5is0asEwAG
         FPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757956896; x=1758561696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=td2chPrpcXRRriXk2X2/u7ClZFwh3i+z6PZKNphNpCI=;
        b=lvO4JAmZGrp9Q1fqMHVC1QHFVyZ4hLhGSiBzWrKDXK2xAlG9EnEWWjdAko0sXvMtSH
         zOg+ot8lMwsRCxl0bLcEnD8bLPEqm0rfdZFvjydy+xaSMOUWaprgQ/Jqsdbw8apNvk37
         hGmQBG5BW8QqKbHdLFx2jPCm+uBT2NoTKirw+bLR1hf4zkVHnXqlJ/on4mD2dvZm//J3
         Q/1MiYuPch90evvSqXACozsPr2zIeJKAQ8pb5JFqcymt895n+1HhUPGySAF+XRNVRJHR
         UdIbb1G55U7srJwnsCKGZ7zcPPhrD4sVEdPx1BWd39hfgQT3t+wdL4KUeXbtqAMEO+Z+
         OkBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV/EQvf5MqAfmFRLnBBB9fBbBi0tPl7CZWOYarxzIag4BcKIMb3uG0pUFYXIl1Ph5ionR4ciCLBW8EO7Tk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4Gpbn0YDJYOt1NmrUaEkTj2YzCXz1yQSM8S/7DXjwEtBFf0r7
	0TWxxiojUL3IoRK6rU6y+FU5tKz0m8936XxnxsezOLpiU+YbP0xGq+mG+ks4tOxw
X-Gm-Gg: ASbGncuJvJRdi6tZPf80qj27E34e8emoF6sCfsq6rcu/NhB3E7CFtYbox6xAyxpsXYJ
	bIGDdxm8hojOdeMGX0wai0KlMKJqui6umxIYzgru3/axemTRQdIha3bkWdTaRvmT2H28QPoqPdI
	KNxKk7kYPeQ3BPFrNs7q1B5L2OjjAiKAH3PfAB/mOCqnE3w6gAuR0lKGzpZlh14o4TSr82bG63t
	0CiNSfCLusuTx1TglkHEiEYsqBl9j8guRJPRtHVbijoR9/Var6CN7+tOVJcpJjAojpn1br+aepk
	zjPqkxLEH19ort7Qtmy4Y2YyH956AS1BOK4LjcCvQ7ay56hU1bm9FGvjscexUBgFRbeP3uulYj9
	BVquO3PWWps7xPfe6Rb+oy1x7bxiUQFKojV+xbKcijBumMlZgLiT0URMJWtQQVyDVYjm0ncLQYa
	kfK9I=
X-Google-Smtp-Source: AGHT+IHEKp0Y6D+z+isGpfnpSFCaAJkmdh1YHEFRSo5IN+59rFPuNBWBiHyIC/CFw3AzsE2P1eoOMQ==
X-Received: by 2002:a17:907:7ba1:b0:b04:5a68:8674 with SMTP id a640c23a62f3a-b07c37dc7e4mr1397201066b.35.1757956896016;
        Mon, 15 Sep 2025 10:21:36 -0700 (PDT)
Received: from reolab.localdomain ([83.120.241.83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b333437bsm972768566b.95.2025.09.15.10.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:21:35 -0700 (PDT)
From: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
To: rafael@kernel.org
Cc: lenb@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
Subject: [PATCH] ACPI: debug: fix signedness issues in read/write helpers
Date: Mon, 15 Sep 2025 20:51:19 +0330
Message-ID: <20250915172119.5303-1-a.jahangirzad@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the ACPI debugger interface the helper functions for read and write
operations use an `int` type for the length parameter. When a large
`size_t count` is passed from the file operations, this cast to `int`
results in truncation and a negative value due to signed integer
representation.

Logically, this negative number value propagates to the `min` calculation,
where it's selected over the positive buffer space value, leading to an
unexpected behavior. Subsequently, when this negative value is used in
`copy_to_user` or `copy_from_user`, it is interpreted as a large positive
value due to the unsigned nature of the size parameter in these functions
causing the copy operations to attempt handling sizes far beyond the
intended buffer limits.

This patch addresses the issue by:
- Changing the length parameters in `acpi_aml_read_user` and
  `acpi_aml_write_user` from `int` to `size_t`, aligning with the expected
  unsigned size semantics.
- Updating return types and local variables in acpi_aml_read() and
  acpi_aml_write() to 'ssize_t' for consistency with kernel file operation
  conventions.
- Using 'size_t' for the 'n' variable to ensure calculations remain
  unsigned.
- Adding explicit casts to 'size_t' for circ_count_to_end() and
  circ_space_to_end() to align types in the min() macro.


Signed-off-by: Amir Mohammad Jahangirzad <a.jahangirzad@gmail.com>
---
 drivers/acpi/acpi_dbg.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/acpi_dbg.c b/drivers/acpi/acpi_dbg.c
index d50261d05f3a1..72878840b4b75 100644
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
+	n = min(len, (size_t)circ_count_to_end(crc));
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
+	n = min(len, (size_t)circ_space_to_end(crc));
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


