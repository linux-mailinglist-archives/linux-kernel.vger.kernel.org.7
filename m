Return-Path: <linux-kernel+bounces-863042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1FABF6DB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7ADEE4EE7E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1599D3385BA;
	Tue, 21 Oct 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t8o4u0mj"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E27F355043
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054339; cv=none; b=TC+a4lD3Y1Z18D2RBHZ96bx2g3l9cHufWYqD+Gm7gpVYQc8QqbgOtaNK7qJIdHSQPxnXaU4tS+qu0A+NbYyTGmahON7b/rwOVtPEoEgSyvIQGMUiKoawZtPEQfVKmBRIiUauXfjx1xkd+kbeL3+1+oeszOpmGQ1fUPAMkveGBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054339; c=relaxed/simple;
	bh=EuTJjp5jzqeBwSzytp1reSaUtXEQ6kUKH2/OcDCdijk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V82o4mNc0icPdHOBhMo4Lt8xUHMQtvuv81Tg6/YPn9PQAZx4YlngQEyMfJ2sRHH25/RzmHDdcsUh5qtgF7Ny+86+kCYuHu9rGIDvQfQCHhJbMYnpYEVisc/rZISejQZS3qRHxoOIRqDclWksO5v9EkfylSi4suwoyscX78anx5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t8o4u0mj; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761054332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=U3IAMZcKI0CNuYk+5K7fOPsEQkH4wvzXZfY4YoK+dkg=;
	b=t8o4u0mjO5fMJbKLrCBGg0yMIR+ZV58xYt0Ro2LpIlpKGKOwpHiskWUe91eeejMB8y0B4K
	FoBvZgWO1n0NaLJBwdLQxQKRkBvJ7tvNpBvOFFanEga5FGFVTFl+FK5BwEXFP4DXdmheWB
	gnPssnYFuD4R4tfD76xHYFhzags6N/Y=
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
Subject: [PATCH mm-new v2] mm/khugepaged: Factor out common logic in [scan,alloc]_sleep_millisecs_store()
Date: Tue, 21 Oct 2025 21:44:31 +0800
Message-ID: <20251021134431.26488-1-leon.hwang@linux.dev>
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

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
v1 -> v2:
  - Simplify callsites of __sleep_millisecs_store() (per Lorenzo).
  - Collect Reviewed-by from Lorenzo, Zi and Lance - thanks!
  - https://lore.kernel.org/linux-mm/20251020115350.8175-1-leon.hwang@linux.dev/

 mm/khugepaged.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6f2ae2238b5b..5b7276bc14b1 100644
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
@@ -140,12 +139,19 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
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
+	return __sleep_millisecs_store(buf, count, &khugepaged_scan_sleep_millisecs);
+}
 static struct kobj_attribute scan_sleep_millisecs_attr =
 	__ATTR_RW(scan_sleep_millisecs);

@@ -160,18 +166,7 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
 					   struct kobj_attribute *attr,
 					   const char *buf, size_t count)
 {
-	unsigned int msecs;
-	int err;
-
-	err = kstrtouint(buf, 10, &msecs);
-	if (err)
-		return -EINVAL;
-
-	khugepaged_alloc_sleep_millisecs = msecs;
-	khugepaged_sleep_expire = 0;
-	wake_up_interruptible(&khugepaged_wait);
-
-	return count;
+	return __sleep_millisecs_store(buf, count, &khugepaged_alloc_sleep_millisecs);
 }
 static struct kobj_attribute alloc_sleep_millisecs_attr =
 	__ATTR_RW(alloc_sleep_millisecs);
--
2.51.0


