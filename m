Return-Path: <linux-kernel+bounces-849032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B20BCF0B0
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 08:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DFCA734BF83
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 06:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A89221FB2;
	Sat, 11 Oct 2025 06:56:30 +0000 (UTC)
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162A0C8F0
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 06:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760165790; cv=none; b=MXc4JkkzpC3jL5xk75LMg+0g931/duiahLyQI9hGFB9sEqLe/M6QN8P1LW04npw5RVimxlg2xktPAAxwv5aJeXEW5QdUGbk3HoGoY8IVhr6SabFEE+9xZ/9Lb4b8i5Lm2KwtyHbxepHDENZ38VAT39Vt4y2OtOZKwpHLg9RwhH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760165790; c=relaxed/simple;
	bh=F/9fYjaX5yRuGUwdkmYdvjFG3VtpbeM4JlWnWuc/UmM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JAG95Jxrw/H5aE3u8nGqLEZFHMEmRUoaeN/b5/ntUKfm7q1Eyg/sJxF1HyZKqgeInbEEWSyW0U8fckv1hJRDkeK+vONM3vmmAxygpJnQW4U1N5jK5EjbQf2m/pcQSwteRIba/t9PKe01Tt904W1qiZPSd9pjmSb49wrqHDe/XDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <cyphar@cyphar.com>, <vmalik@redhat.com>, <kees@kernel.org>,
	<brauner@kernel.org>
CC: <linux-kernel@vger.kernel.org>, Fushuai Wang <wangfushuai@baidu.com>
Subject: [PATCH] uaccess: Add copy_from_user_nul helper
Date: Sat, 11 Oct 2025 14:55:46 +0800
Message-ID: <20251011065546.54457-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc2.internal.baidu.com (172.31.3.12) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

Many places call copy_from_user() to copy a buffer from user space,
but then must manually add a NULL terminator to the destination buffer,
e.g.:

	if (copy_from_user(dest, src, len))
		return -EFAULT;
	dest[len] = '\0';

This is repetitive and error-prone. Add a copy_from_user_nul() help to
simplify such patterns. It copied n bytes from user space to kernel space,
and NUL-terminates the destination buffer.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 include/linux/uaccess.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1beb5b395d81..642a6a7e5a06 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -213,6 +213,25 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 #endif
 }
 
+/*
+ * copy_from_user_nul - Copy a block of data from user space and NUL-terminate
+ *
+ * @to:   Destination address, in kernel space. This buffer must be at least
+ *        @n+1 bytes long!
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Return: 0 on success, -EFAULT on failure.
+ */
+static __always_inline int __must_check
+copy_from_user_nul(void *to, const void __user *from, unsigned long n)
+{
+	if (copy_from_user(to, from, n))
+		return -EFAULT;
+	((char *)to)[n] = '\0';
+	return 0;
+}
+
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-- 
2.36.1


