Return-Path: <linux-kernel+bounces-720405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A73AFBB28
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 20:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2843318919E0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBB70265281;
	Mon,  7 Jul 2025 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XGd0Ibwd"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0782253B4C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 18:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751914272; cv=none; b=thQQ//shLhvybbBA2+DXjqhrcDLPJsADPcgFoSMfqd6H6CUO26pQAy9Fjg1Q3vJrPp8hveKXsy6pbUwfXnlBAwjrBMszJPMYFN/oTCltgfEVB/QI7xYn7hHn8kdBnxWiyd7RmcC05H+fb/9fPYCKSmyLMnXot5wtDDV3AT/xpMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751914272; c=relaxed/simple;
	bh=e9V2W1eJzVV6zWm35TffsJfx2D9Kv0OhKkXnyzMbG7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fUB3ZaYW78+MuhAie81ICkeJop2Bp1ocijAE0j0F1y87kU5HxWyiePAlIIICt87l85iRB+MfJI6eaD+jXropExxamE5jMVoNw2qoIJRPH9Tlg34popuvf55wyN6yw5MDH1qoB7L7NOdATfkYCzervjwOFeW65v72ttCCj9KnEoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XGd0Ibwd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751914269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nsd6AfgXSp7nEfOg4lyDom0iMtgQzhUt3vvT3lAeFQ=;
	b=XGd0IbwdFeYPXoWBCCnjXDNBQDumxnkPs+6ZQKe15v1gyh/AuFI5niGZTK6vh/Yrin4bXo
	1+NDowdAPrANpSL+UMUpkkNZM+CJjB66e7UqIXqagQgOLBPiGtMgxSv6lKyOX3eNT7ZP5h
	c9cf3FtQzyJcCpYZFEPYcwjhCXOE9VU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-39-puodWzYmPnWtPJi8IF8K7w-1; Mon,
 07 Jul 2025 14:51:06 -0400
X-MC-Unique: puodWzYmPnWtPJi8IF8K7w-1
X-Mimecast-MFC-AGG-ID: puodWzYmPnWtPJi8IF8K7w_1751914265
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE6A619560A6;
	Mon,  7 Jul 2025 18:51:04 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B03A19560AB;
	Mon,  7 Jul 2025 18:51:03 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org
Subject: [PATCH v2 1/4] mm/memory: introduce is_huge_zero_pfn() and use it in vm_normal_page_pmd()
Date: Mon,  7 Jul 2025 14:50:43 -0400
Message-ID: <0e343f6f088fc79f625161b5d74567d696f2228e.1751914235.git.luizcap@redhat.com>
In-Reply-To: <cover.1751914235.git.luizcap@redhat.com>
References: <cover.1751914235.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

From: David Hildenbrand <david@redhat.com>

Let's avoid working with the PMD when not required. If
vm_normal_page_pmd() would be called on something that is not a present
pmd, it would already be a bug (pfn possibly garbage).

While at it, let's support passing in any pfn covered by the huge zero
folio by masking off PFN bits -- which should be rather cheap.

Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: Luiz Capitulino <luizcap@redhat.com>
---
 include/linux/huge_mm.h | 12 +++++++++++-
 mm/memory.c             |  2 +-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
index 2f190c90192d..59e93fba15f4 100644
--- a/include/linux/huge_mm.h
+++ b/include/linux/huge_mm.h
@@ -486,9 +486,14 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
 	return READ_ONCE(huge_zero_folio) == folio;
 }
 
+static inline bool is_huge_zero_pfn(unsigned long pfn)
+{
+	return READ_ONCE(huge_zero_pfn) == (pfn & ~(HPAGE_PMD_NR - 1));
+}
+
 static inline bool is_huge_zero_pmd(pmd_t pmd)
 {
-	return pmd_present(pmd) && READ_ONCE(huge_zero_pfn) == pmd_pfn(pmd);
+	return pmd_present(pmd) && is_huge_zero_pfn(pmd_pfn(pmd));
 }
 
 struct folio *mm_get_huge_zero_folio(struct mm_struct *mm);
@@ -636,6 +641,11 @@ static inline bool is_huge_zero_folio(const struct folio *folio)
 	return false;
 }
 
+static inline bool is_huge_zero_pfn(unsigned long pfn)
+{
+	return false;
+}
+
 static inline bool is_huge_zero_pmd(pmd_t pmd)
 {
 	return false;
diff --git a/mm/memory.c b/mm/memory.c
index b0cda5aab398..3a765553bacb 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -687,7 +687,7 @@ struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 
 	if (pmd_devmap(pmd))
 		return NULL;
-	if (is_huge_zero_pmd(pmd))
+	if (is_huge_zero_pfn(pfn))
 		return NULL;
 	if (unlikely(pfn > highest_memmap_pfn))
 		return NULL;
-- 
2.50.0


