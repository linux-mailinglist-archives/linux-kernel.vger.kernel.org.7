Return-Path: <linux-kernel+bounces-855790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806DCBE2545
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D364253D1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0846730100A;
	Thu, 16 Oct 2025 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="lfBfHtS+"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6493254BC
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606267; cv=none; b=CXi/gbjRz357iH6cfPfO1j7X5uVGy+YwRZXjU/TIsjHOLMhBlsX9x456O2fdzhjVGToCKMp+cmUp1D7i2gLZhQWtJY34iDdWr4yQ3wbJ8LuUNveGE0xiDMpxccctu/z92A3y0/iq/Q2ufW6FhJ+UrxMmXIgLs6W4paUPjJszEAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606267; c=relaxed/simple;
	bh=0TaMUuOpNvxesYh/jBprYtOcZs+49A4CFlq3+lu+Fmc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=mfK0G9Mq05kDnofwIVFOCJxzbUdfUJvyqQyvFveB4zfx/K6616iasfyuV4L1Epd26nh4TIY5UDTDqKLI0PgI1Wd9dpzv04RsBqcHhbPrGwDKsr3hLCl6h+7S/AmRAE6qtiGD/5E279k2MrYSlwAQshXGtdFzvUctWSDZavgOAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=lfBfHtS+; arc=none smtp.client-ip=117.135.210.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:To:Subject:Date:Message-Id; bh=45e/C/Y1u5j+v/O
	/pm3lDrXdyxiM2QtQtB+MmvdCD00=; b=lfBfHtS+B4nMbart+XAW0oMXSrpX1dW
	tjsDS5NNb0Ijjbsx0wEG1uki1O4/LpNV2vGR//o0VZlYYKhgdg4WSEsdvgB2jCun
	wvPFdAFnFRFFEpQEQWFbw4Rlmv1A5bXU+tEmvgDrq/LzQ3zoQxcjkfY4cN+Mu17r
	CzoLSmrfMWJ0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PikvCgD3n0DBtfBoo1JkAA--.53082S2;
	Thu, 16 Oct 2025 17:07:20 +0800 (CST)
From: XueBing Chen <chenxb_99091@126.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	XueBing Chen <chenxb_99091@126.com>
Subject: [PATCH] lib/bsearch: add mutex protection for thread-safe binary search
Date: Thu, 16 Oct 2025 17:06:40 +0800
Message-Id: <20251016090640.6331-1-chenxb_99091@126.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:PikvCgD3n0DBtfBoo1JkAA--.53082S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF4xGFW7tw45Gry7Zw4fZrb_yoW8Zr1UpF
	Z5Cr43GF4kJrZ3uF4fWr12q3sxWa93KF45t3sIka4fZF4UXw1kKrZ5KFy5uF4fGrZrJFWj
	kryDWr90kF4rZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_jg4xUUUUU=
X-CM-SenderInfo: hfkh05lebzmiizr6ij2wof0z/1tbiihLoxWjwr0CGgQAAsF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Replace the __inline_bsearch() wrapper with a full implementation
that includes mutex protection to ensure thread safety when
multiple threads call bsearch() concurrently.

The original implementation lacked synchronization, which could
lead to race conditions in multi-threaded environments when
accessing shared arrays or using non-atomic comparison functions.

Signed-off-by: XueBing Chen <chenxb_99091@126.com>
---
 lib/bsearch.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/lib/bsearch.c b/lib/bsearch.c
index bf86aa66f..9a5a2e949 100644
--- a/lib/bsearch.c
+++ b/lib/bsearch.c
@@ -1,9 +1,12 @@
-// SPDX-License-Identifier: GPL-2.0-only
 /*
  * A generic implementation of binary search for the Linux kernel
  *
  * Copyright (C) 2008-2009 Ksplice, Inc.
  * Author: Tim Abbott <tabbott@ksplice.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License as
+ * published by the Free Software Foundation; version 2.
  */
 
 #include <linux/export.h>
@@ -28,9 +31,29 @@
  * the key and elements in the array are of the same type, you can use
  * the same comparison function for both sort() and bsearch().
  */
-void *bsearch(const void *key, const void *base, size_t num, size_t size, cmp_func_t cmp)
+DEFINE_MUTEX(cmp_mutex);
+void *bsearch(const void *key, const void *base, size_t num, size_t size,
+	      int (*cmp)(const void *key, const void *elt))
 {
-	return __inline_bsearch(key, base, num, size, cmp);
+	const char *pivot;
+	int result;
+
+	while (num > 0) {
+		pivot = base + (num >> 1) * size;
+		mutex_lock(&cmp_mutex);
+		result = cmp(key, pivot);
+		mutex_unlock(&cmp_mutex);
+		if (result == 0)
+			return (void *)pivot;
+
+		if (result > 0) {
+			base = pivot + size;
+			num--;
+		}
+		num >>= 1;
+	}
+
+	return NULL;
 }
 EXPORT_SYMBOL(bsearch);
 NOKPROBE_SYMBOL(bsearch);
-- 
2.17.1


