Return-Path: <linux-kernel+bounces-889414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E5DC3D808
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 22:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE3C188BA58
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 21:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E44307AF5;
	Thu,  6 Nov 2025 21:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gNQsYRa2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7394130748C
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762464566; cv=none; b=Zh5zamQEhZrK55kS9BzfwCxQWthIqUbmKk2VJr2vUmc6qjwuuEMdO/gJrRGyywRoTHi59FKIlT7bcgX4TYjah+x/Onj8VWDobRqnLWfSnrnpVRGmZJT6kbR9bWCHeFadsUcCU/9AVhflpe/yQwfvUzxyCxuiYdqDHsbzIAzNppk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762464566; c=relaxed/simple;
	bh=hpAbJa4FrRw64WEVicBwSTMoiNiDFlcvF/Gja/aj4jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcCjPvQXFQM94f1mnrOwAayybNWA0sTU3BcC5VAJthc493iKTco9npjrT/P10JlauwIc25dVqzTbqzNa4waPGWHmeFalqxIQFNrhO+Ux9L7R4BReK19Rldi3WVx78yQOao/kJXp1TnIvl/BIsLsSIWIgOAAVtImp8EBp7qoxrTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gNQsYRa2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762464563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zUO+xVShs8OiZifdHLWjxbQxTWazvLbIeIkNNKtnLDQ=;
	b=gNQsYRa20nMYBLf15LkURgy9l7qsNG/YeF1F5BXkgmwOcIUjrqneALa6dP4S2Kh9ms0IdF
	791eKSdq00+/GFMzAPjXBQUAGImUUFRyDVkYcI0CAKjwaivKUT0JSzsZF42BrSegZCD+g7
	iIDZxN5XJBJ9sz6wx5kjbh+i67c0X6Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-5_-hiZhPM0Ofg5aLSYqB9Q-1; Thu,
 06 Nov 2025 16:29:20 -0500
X-MC-Unique: 5_-hiZhPM0Ofg5aLSYqB9Q-1
X-Mimecast-MFC-AGG-ID: 5_-hiZhPM0Ofg5aLSYqB9Q_1762464558
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B988A1956094;
	Thu,  6 Nov 2025 21:29:17 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.65.101])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C160519560B2;
	Thu,  6 Nov 2025 21:29:16 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: ryan.roberts@arm.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com
Subject: [RFC 02/10] mm: introduce pgtable_has_pmd_leaves()
Date: Thu,  6 Nov 2025 16:28:49 -0500
Message-ID: <50fc95b4c806eb4bfcdb578f2ce8d634faf93d57.1762464515.git.luizcap@redhat.com>
In-Reply-To: <cover.1762464515.git.luizcap@redhat.com>
References: <cover.1762464515.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This is a new helper which can be used to check if the architecture
supports PMD-sized pages. It's intended to replace two existing helpers:

- has_transparent_hugepages(): it's used to check for PMD-sized pages
  (not exactly THP support), but it may perform a hardware check so it's
  not intended to be used in fast paths

- thp_disabled_by_hw(): also checks for PMD-sized pages support, but
  uses a cached value

pgtable_has_pmd_leaves() implementation is split in two parts:

1. init_arch_has_pmd_leaves(): runs at boottime as early_initcall as a
   wrapper to has_transparent_hugepages(). The result is cached

2. pgtable_has_pmd_leaves(): just returns the cached value

The next commits will convert users of both has_transparent_hugepages()
and thp_disabled_by_hw() to pgtable_has_pmd_leaves().

Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 include/linux/pgtable.h | 10 ++++++++++
 mm/memory.c             | 10 ++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 32e8457ad535..e4c5f70b0a01 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -2001,6 +2001,16 @@ static inline const char *pgtable_level_to_str(enum pgtable_level level)
 	}
 }
 
+/*
+ * IMPORTANT: pgtable_has_pmd_leaves() can only be called after
+ * early_initcall, since that's when __arch_has_pmd_leaves is set
+ */
+extern bool __arch_has_pmd_leaves;
+static inline bool pgtable_has_pmd_leaves(void)
+{
+	return __arch_has_pmd_leaves;
+}
+
 #endif /* !__ASSEMBLY__ */
 
 #if !defined(MAX_POSSIBLE_PHYSMEM_BITS) && !defined(CONFIG_64BIT)
diff --git a/mm/memory.c b/mm/memory.c
index 74b45e258323..7b50f3ec9b37 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -176,6 +176,16 @@ static int __init init_zero_pfn(void)
 }
 early_initcall(init_zero_pfn);
 
+bool __arch_has_pmd_leaves __read_mostly;
+EXPORT_SYMBOL(__arch_has_pmd_leaves);
+
+static int __init init_arch_has_pmd_leaves(void)
+{
+	__arch_has_pmd_leaves = has_transparent_hugepage();
+	return 0;
+}
+early_initcall(init_arch_has_pmd_leaves);
+
 void mm_trace_rss_stat(struct mm_struct *mm, int member)
 {
 	trace_rss_stat(mm, member);
-- 
2.51.1


