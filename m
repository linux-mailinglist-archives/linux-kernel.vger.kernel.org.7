Return-Path: <linux-kernel+bounces-730033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8661B03F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1A351A624FA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84188248883;
	Mon, 14 Jul 2025 13:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cMzjG29r"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652B02F22
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499038; cv=none; b=flN7nb5yXcaduU2C+tYu6xYkCL1p2TPi9eK/HGI1/ceJ+8IlDROZPmtySnfzCBZqtOtRrhiBhF75Z+jn1iolPVes+9nKFDjTCDgLlW0Iwu66hvbONM8r/vyNgSEbMiVt+MzIDJmsck6kF7f28eWSetzrJAICjnElsF/+XBQDw2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499038; c=relaxed/simple;
	bh=e9V2W1eJzVV6zWm35TffsJfx2D9Kv0OhKkXnyzMbG7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9JNZqunm2Yo2o8lazIzJwPoaiMzEf5xOSY+t+6aC46p6n7t1ZNYsxUiC3fTOVjRJ+0Mm8Dh/ILiA5bkcxirR2i2R5Q3l3sNjkZmPmMR6GUtVVx/kyUTlMwIVueBHhRApZK282o1iJ0pr6DVcsDU9Zkn7/emi4zmCGC0kocTRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cMzjG29r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752499036;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nsd6AfgXSp7nEfOg4lyDom0iMtgQzhUt3vvT3lAeFQ=;
	b=cMzjG29rn06U5vF12dMGFALf2UQ/S5/rvsHB7mXSQZXSwcBVvYyH977SijUIMrIn0+hzOl
	rMiL7ZnjHAGweoNTXXZPl48SwlWNjUBtQvaAUmzp32tLTyymjm6XMk5IiJzIPzvj89AFK9
	8qQvQJy3RqFbLWkfcyUyR9Mgdjaaz+g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-582-X42RbnBUM9mJmbfIthzxuw-1; Mon,
 14 Jul 2025 09:17:12 -0400
X-MC-Unique: X42RbnBUM9mJmbfIthzxuw-1
X-Mimecast-MFC-AGG-ID: X42RbnBUM9mJmbfIthzxuw_1752499030
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 540BA1801210;
	Mon, 14 Jul 2025 13:17:10 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.22.80.96])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9041F18002B5;
	Mon, 14 Jul 2025 13:17:08 +0000 (UTC)
From: Luiz Capitulino <luizcap@redhat.com>
To: david@redhat.com,
	willy@infradead.org,
	akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	shivankg@amd.com,
	sj@kernel.org,
	harry.yoo@oracle.com
Subject: [PATCH v3 1/4] mm/memory: introduce is_huge_zero_pfn() and use it in vm_normal_page_pmd()
Date: Mon, 14 Jul 2025 09:16:51 -0400
Message-ID: <4940826e99f0c709a7cf7beb94f53288320aea5a.1752499009.git.luizcap@redhat.com>
In-Reply-To: <cover.1752499009.git.luizcap@redhat.com>
References: <cover.1752499009.git.luizcap@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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


