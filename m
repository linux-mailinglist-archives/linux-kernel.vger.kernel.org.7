Return-Path: <linux-kernel+bounces-674220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5A9ACEB64
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 10:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDC8189B059
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jun 2025 08:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C88951F5617;
	Thu,  5 Jun 2025 08:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f5A91PJC"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 670EA1C32
	for <linux-kernel@vger.kernel.org>; Thu,  5 Jun 2025 08:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749110482; cv=none; b=ZeNp6NXvbAaQTJ+jZpSJxEo1Aj4Y0Jk/EUJfGwZ2fjKmxquMuA1i1u2x9NtXP08f9SsqepGjd8b+y59rfKyQEM2evgqaphUbotnEIpyTCnOmbo2HTVVUVdcA5fjEZAeXMbqxfTijBMRrKAreM2/63vS95UQjhxTfSs3pzWlEpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749110482; c=relaxed/simple;
	bh=r6E3rglfRLSqSLXHR+V3IXnb3kPvV51qptkCoiFWZdo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OP/fQ1wM7AQwsXkh8n7VUkoVgolkFb80gwJCRggLHUEspNIxqyP9oUdLGfpQBTi3fhVWntvGTPzG8z0GkLsrv8qTn9vpoOQPbrmyutpjYaJq1CuhsEul7/8AWWJTrY9mVxk9ZB93rdH7NAXvYNj4vRLr2BupayFygPkzgz+m3xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f5A91PJC; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1749110474; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=jCGzSGCdqXE9W9t2gnUeBiPltG2v3zMxn7QoZ0xpXD4=;
	b=f5A91PJCmZzJLnNaTWPX6XjknLVdaE4FSLwdzMYaQ+xIU+PlTzNDo0cNrRZoN22/+Rr3w8yHhr2vA8hOtpLslrufCE9Xik5tUtbS4fmhHJx1sUc55PhKAPwOltuLPZcQ9XO/4DNcLIGstbbBEYJhfwUK0+RK/Tf0Z0+dsdhF9vo=
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wd7WSL6_1749110473 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 05 Jun 2025 16:01:14 +0800
From: Baolin Wang <baolin.wang@linux.alibaba.com>
To: akpm@linux-foundation.org,
	hughd@google.com,
	david@redhat.com
Cc: lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] mm: huge_memory: disallow hugepages if the system-wide THP sysfs settings are disabled
Date: Thu,  5 Jun 2025 16:00:58 +0800
Message-ID: <8eefb0809c598fadaa4a022634fba5689a4f3257.1749109709.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1749109709.git.baolin.wang@linux.alibaba.com>
References: <cover.1749109709.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The MADV_COLLAPSE will ignore the system-wide Anon THP sysfs settings, which
means that even though we have disabled the Anon THP configuration, MADV_COLLAPSE
will still attempt to collapse into a Anon THP. This violates the rule we have
agreed upon: never means never.

Another rule for madvise, referring to David's suggestion: “allowing for collapsing
in a VM without VM_HUGEPAGE in the "madvise" mode would be fine".

To address this issue, should check whether the Anon THP configuration is disabled
in thp_vma_allowable_orders(), even when the TVA_ENFORCE_SYSFS flag is set.

In summary, the current strategy is:

1. If always & orders == 0, and madvise & orders == 0, and hugepage_global_enabled() == false
(global THP settings are not enabled), it means mTHP of that orders are prohibited
from being used, then madvise_collapse() is forbidden for that orders.

2. If always & orders == 0, and madvise & orders == 0, and hugepage_global_enabled() == true
(global THP settings are enabled), and inherit & orders == 0, it means mTHP of that
orders are still prohibited from being used, thus madvise_collapse() is not allowed
for that orders.

Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 include/linux/huge_mm.h | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..199ddc9f04a1 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -287,20 +287,35 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
 				       unsigned long orders)
 {
 	/* Optimization to check if required orders are enabled early. */
-	if ((tva_flags & TVA_ENFORCE_SYSFS) && vma_is_anonymous(vma)) {
-		unsigned long mask = READ_ONCE(huge_anon_orders_always);
+	if (vma_is_anonymous(vma)) {
+		unsigned long always = READ_ONCE(huge_anon_orders_always);
+		unsigned long madvise = READ_ONCE(huge_anon_orders_madvise);
+		unsigned long inherit = READ_ONCE(huge_anon_orders_inherit);
+		unsigned long mask = always | madvise;
+
+		/*
+		 * If the system-wide THP/mTHP sysfs settings are disabled,
+		 * then we should never allow hugepages.
+		 */
+		if (!(mask & orders) && !(hugepage_global_enabled() && (inherit & orders)))
+			return 0;
+
+		if (!(tva_flags & TVA_ENFORCE_SYSFS))
+			goto skip;
 
+		mask = always;
 		if (vm_flags & VM_HUGEPAGE)
-			mask |= READ_ONCE(huge_anon_orders_madvise);
+			mask |= madvise;
 		if (hugepage_global_always() ||
 		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
-			mask |= READ_ONCE(huge_anon_orders_inherit);
+			mask |= inherit;
 
 		orders &= mask;
 		if (!orders)
 			return 0;
 	}
 
+skip:
 	return __thp_vma_allowable_orders(vma, vm_flags, tva_flags, orders);
 }
 
-- 
2.43.5


