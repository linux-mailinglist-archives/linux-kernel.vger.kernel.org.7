Return-Path: <linux-kernel+bounces-776971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 865D7B2D39B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5F1623FB3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69062BEC23;
	Wed, 20 Aug 2025 05:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SfHxbELZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF61429CB57
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755668187; cv=none; b=ENZnVAoBmIWizouqFp4Vb/N5psO0pCEDH3nS4ZOVS72X7R3u++d9l3FQUlFF1RrGV0fdP0B4B9PgyzW0ZNYB+gFc4OoxXsWz/iw2xI7hAnoDE5U9uTkDxHvTJDAw0kOtISMZOKTfrL7YHasyy1tX4ugfq9X9m4vrLDvE023mKQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755668187; c=relaxed/simple;
	bh=/MdD+V0VX+trwP/NryjRZw851pjrj5UmxzyJv35uL5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=FgCDzt6yUc953D3IK/2nEAlw2VP3SQfQhVpe4JTm/czSQIJUhZ7c+sUitU9EGXKQUBzCcULSHyiiqrEaFvJSNqgSKccNxDnFgOCEhRxc6GNqfG8kUdyZey2cz5036edPtNMS4OGmqtxTzsbtoaL0k1jDIJrY5VRL1CactiultaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SfHxbELZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755668184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ffaqmFj6s7jEE3FagcYbQXUNvNizOaxd5L//WV57Tuw=;
	b=SfHxbELZ1oI6J5SdQ35iEFUObuOIO2zde8J+z1raq2DhBRwF5OjiBmDJHXV/zFEDFVCW9V
	YIWy7kSkBjAZ+fjbzyClmF3pziF9i16a7ivnCgs1d6vRBTDIS5o84eQY9V/OxBph3cWf/0
	tiG5JZyiKTQspmFPQK0ueBq970PSrKU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-ljSlvNsWPGC2J3sVaEdsMA-1; Wed,
 20 Aug 2025 01:36:18 -0400
X-MC-Unique: ljSlvNsWPGC2J3sVaEdsMA-1
X-Mimecast-MFC-AGG-ID: ljSlvNsWPGC2J3sVaEdsMA_1755668176
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0057919775E8;
	Wed, 20 Aug 2025 05:36:16 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.112.99])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0B83A19560B0;
	Wed, 20 Aug 2025 05:36:07 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org
Cc: ryabinin.a.a@gmail.com,
	andreyknvl@gmail.com,
	glider@google.com,
	dvyukov@google.com,
	vincenzo.frascino@arm.com,
	akpm@linux-foundation.org,
	kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	sj@kernel.org,
	lorenzo.stoakes@oracle.com,
	elver@google.com,
	snovitoll@gmail.com,
	christophe.leroy@csgroup.eu,
	Baoquan He <bhe@redhat.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 07/12] arch/powerpc: don't initialize kasan if it's disabled
Date: Wed, 20 Aug 2025 13:34:54 +0800
Message-ID: <20250820053459.164825-8-bhe@redhat.com>
In-Reply-To: <20250820053459.164825-1-bhe@redhat.com>
References: <20250820053459.164825-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This includes 32bit, book3s/64 and book3e/64.

And also add code to enable kasan_flag_enabled, this is for later
usage.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/mm/kasan/init_32.c        | 8 +++++++-
 arch/powerpc/mm/kasan/init_book3e_64.c | 6 ++++++
 arch/powerpc/mm/kasan/init_book3s_64.c | 6 ++++++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
index 03666d790a53..b0c465f3fbf5 100644
--- a/arch/powerpc/mm/kasan/init_32.c
+++ b/arch/powerpc/mm/kasan/init_32.c
@@ -141,6 +141,9 @@ void __init kasan_init(void)
 	u64 i;
 	int ret;
 
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_mem_range(i, &base, &end) {
 		phys_addr_t top = min(end, total_lowmem);
 
@@ -163,6 +166,9 @@ void __init kasan_init(void)
 
 	clear_page(kasan_early_shadow_page);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* At this point kasan is fully initialized. Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KASAN init done\n");
@@ -170,7 +176,7 @@ void __init kasan_init(void)
 
 void __init kasan_late_init(void)
 {
-	if (IS_ENABLED(CONFIG_KASAN_VMALLOC))
+	if (IS_ENABLED(CONFIG_KASAN_VMALLOC) && kasan_enabled())
 		kasan_unmap_early_shadow_vmalloc();
 }
 
diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
index 60c78aac0f63..1e1c10467a2b 100644
--- a/arch/powerpc/mm/kasan/init_book3e_64.c
+++ b/arch/powerpc/mm/kasan/init_book3e_64.c
@@ -111,6 +111,9 @@ void __init kasan_init(void)
 	u64 i;
 	pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL_RO);
 
+	if (kasan_arg_disabled)
+		return;
+
 	for_each_mem_range(i, &start, &end)
 		kasan_init_phys_region(phys_to_virt(start), phys_to_virt(end));
 
@@ -125,6 +128,9 @@ void __init kasan_init(void)
 
 	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KASAN init done\n");
diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
index 7d959544c077..9c5cf2354c8b 100644
--- a/arch/powerpc/mm/kasan/init_book3s_64.c
+++ b/arch/powerpc/mm/kasan/init_book3s_64.c
@@ -56,6 +56,9 @@ void __init kasan_init(void)
 	u64 i;
 	pte_t zero_pte = pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL);
 
+	if (kasan_arg_disabled)
+		return;
+
 	if (!early_radix_enabled()) {
 		pr_warn("KASAN not enabled as it requires radix!");
 		return;
@@ -94,6 +97,9 @@ void __init kasan_init(void)
 
 	static_branch_inc(&powerpc_kasan_enabled_key);
 
+	/* KASAN is now initialized, enable it. */
+	static_branch_enable(&kasan_flag_enabled);
+
 	/* Enable error messages */
 	init_task.kasan_depth = 0;
 	pr_info("KASAN init done\n");
-- 
2.41.0


