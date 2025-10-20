Return-Path: <linux-kernel+bounces-860785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 858F1BF0F19
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 74B7F4EE0D9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8416302CA4;
	Mon, 20 Oct 2025 11:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mAbichEG"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047322F6929
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760961285; cv=none; b=XHLzLZtRB0Xp5rfKIyl6Ph1C7D0Kk2Sxfs6/kBajdebkSBDx8rL4qcImLJrsTUJ1JhD7PsmDO6t2Lqwpn3Y8oK4WftR6v4UlJC+u2IGpPu8rdJmwE9lFeXEV7Ua3O4l9EdGas4JDDmyr75No7NlSkjJZJoZT7nkgtPbI+Tv8thw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760961285; c=relaxed/simple;
	bh=/+k/ydkWWXSRlJrlPe8mgKWLDONdbtZS1hYkWojMoHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vkk6wrnNBLKBi8NOu0ZnrI6QYM4fJMrjtOId6FAu/W1+rTBA9MKmuuZmhEyaWDf7m0hJwEssloyOAm8U8E10fEA5Ja+DWF5MgOnDu/GjrAUD6maHZt30pnjBENXLvKLHG+7UQ0/wpOes3lI2cyFU3rSWbhHiToDgBVvsAh0YsC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mAbichEG; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760961278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JfZtgTFC2xLW8JG3Sq6LW+Xtc+Hd2xSva1xfVO5ocOM=;
	b=mAbichEGPv3VKI6LwexBRgoU/QSVuP1fYQO99ezWI1n1Y9z7jBmcwlKAgQZ369iGYvMc++
	014QRmCT4doHj8SYo0rib32gNQFkfqMJqxuEDFuTRhbHnMboLzF7GyB5AoxXJ6zZgSN4Vc
	DuOZJ1lnrFVNM4rrDwQKvRMgcc9/LiM=
From: Leon Hwang <leon.hwang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>
Subject: [PATCH mm-new 1/1] mm/khugepaged: Factor out common logic in [scan,alloc]_sleep_millisecs_store()
Date: Mon, 20 Oct 2025 19:53:50 +0800
Message-ID: <20251020115350.8175-1-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Both scan_sleep_millisecs_store() and alloc_sleep_millisecs_store()
perform the same operations: parse the input value, update their
respective sleep interval, reset khugepaged_sleep_expire, and wake up
the khugepaged thread.

Factor out this duplicated logic into a helper function
__sleep_millisecs_store(), and simplify both store functions.

No functional change intended.

Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 mm/khugepaged.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 0341c3d13e9e..0b7915015e9e 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -129,9 +129,8 @@ static ssize_t scan_sleep_millisecs_show(struct kobject *kobj,
 	return sysfs_emit(buf, "%u\n", khugepaged_scan_sleep_millisecs);
 }
 
-static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
-					  struct kobj_attribute *attr,
-					  const char *buf, size_t count)
+static ssize_t __sleep_millisecs_store(const char *buf, size_t count,
+				       unsigned int *millisecs)
 {
 	unsigned int msecs;
 	int err;
@@ -140,12 +139,21 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
 	if (err)
 		return -EINVAL;
 
-	khugepaged_scan_sleep_millisecs = msecs;
+	*millisecs = msecs;
 	khugepaged_sleep_expire = 0;
 	wake_up_interruptible(&khugepaged_wait);
 
 	return count;
 }
+
+static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
+					  struct kobj_attribute *attr,
+					  const char *buf, size_t count)
+{
+	unsigned int *millisecs = &khugepaged_scan_sleep_millisecs;
+
+	return __sleep_millisecs_store(buf, count, millisecs);
+}
 static struct kobj_attribute scan_sleep_millisecs_attr =
 	__ATTR_RW(scan_sleep_millisecs);
 
@@ -160,18 +168,9 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   const char *buf, size_t count)
 {
-	unsigned int msecs;
-	int err;
-
-	err = kstrtouint(buf, 10, &msecs);
-	if (err)
-		return -EINVAL;
+	unsigned int *millisecs = &khugepaged_alloc_sleep_millisecs;
 
-	khugepaged_alloc_sleep_millisecs = msecs;
-	khugepaged_sleep_expire = 0;
-	wake_up_interruptible(&khugepaged_wait);
-
-	return count;
+	return __sleep_millisecs_store(buf, count, millisecs);
 }
 static struct kobj_attribute alloc_sleep_millisecs_attr =
 	__ATTR_RW(alloc_sleep_millisecs);
-- 
2.51.0


