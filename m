Return-Path: <linux-kernel+bounces-869171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61380C07357
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873173BAEB1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 16:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71253376BC;
	Fri, 24 Oct 2025 16:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="VsXSr9Yj"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA83375A0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761322211; cv=none; b=sVTu3a6RoP0EHSZ2hTIr9kTZk7wGUQHwYlwmGojeuAHtX5YP/kg0FcFF6T2IrxRuXuWME/yv3XFrezlQcURwRYcyGMBC7C2H+f65v59wwcO/QO+38vpKIJ0rGeWkct5d6gu6Ph+2Iz/OawwmMlFVS9ZGwDX8w+ERw+hf6/JBa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761322211; c=relaxed/simple;
	bh=YWFg/uFSNJCNeAz1R08CPTi95zQcLFxIUIFTBMGCGzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNGyBLDUtu5xf+tWndF5Khi7CfC6bvE3U/Xi1umihB/U6Pugi3cHFnvP1Uv/uHzYTx4Cssw1iecyVEgUeFf/vPO0ErGU8g9hFDyF9oL49i8eiCFPkTihy/ulAlKe4r1ZCreGYB9sSkat6nq99R5do4Frhzw7E1GEyNj80N13+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=VsXSr9Yj; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7815092cd0bso27090067b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761322209; x=1761927009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wl2EF5uWhoTCG3S4g09Ne4AB8gBDQLqMsfh4TvH+1zA=;
        b=VsXSr9YjBn5SugJ1H2WAPxlah7SgnvQho/Tl4TTKSmTKztFzZg7L8oSPI74df9rakD
         oaHja1ZM9Lbzl7nedpKdfA+fwGwAsJd87HobSrBYfzzN91FEqb02F7htVh+OkIaVPM5u
         fCCU+Zi6QxBsz+FdvQNIlAwMK5BuYWMlWJaxLuA93O6jbvBMVmxSVcmwkbPfQa7Hyjei
         PJlAJXhKHz4WYA1Q4vbWrnrh3109ASiTQH/o5V9YTDCzsfIa4phBXnsgzCxzRNyjsh6c
         5CtPr0MfyH6ABBUEL5IhKE9o6oSkDa/T2fjVLJ1sWidXBwXbED1rkZt5Ro3BmASz9AvC
         bYAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761322209; x=1761927009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wl2EF5uWhoTCG3S4g09Ne4AB8gBDQLqMsfh4TvH+1zA=;
        b=YUNz9b4Z1xF7zayAuPDa2HBZ3ywTzZmgHp8dvMjeDbl5ujUCtF9q+OjBPVY5MzY7Ih
         A8KTbE8XlkkRcLGkyrePo5EDENrO3Ofnj8l/2f9UnTSFE8MC2pDcBxRP8Ihev5t4J8xf
         pU6+a02rMNcwVWWWkVXsZtjZCv2wRo5wPcDAN+P9K2dgE9Av+8jFm5F4cDgJzL3Pbzbh
         wW6aHak0YEab0hKmLXmHnje146iEOKudUL43BAKU9yIM8avkS4mWkCLs65pmLfl2xJ9t
         A+qRqg2y3zydViyh1U+Tfuc9YH1SANKAT5/8FkQ1JTLlkU23+csD90T4ZU69yBPAMY93
         qaAg==
X-Forwarded-Encrypted: i=1; AJvYcCXQlkrqdaMp54iiVXX9mjREn9c+rsS8Da+4QOPLeS7VxskjXfSPgNWoWfMvJ/Q2VhLPzj/e59UDxB/1uKg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTOUzdmqQq+/0glNZ7H/UfBjXkUZ6BZwJyhjvnGTUZEPev3JUA
	SNVW26Dm2GotT1pUajwKaNk4+mf6cF6caR2Us3FIrsgu7H/GBiryIzB4ott/jgoZTL7Skjd+mOd
	M7CEY
X-Gm-Gg: ASbGncsAhE79Y5Q64f+2Wdh7ygpuHPonIYonFGdv6VQc8MbK5j9T9b/RvFpqbY5iy++
	AcCIZBdEOF2+hAIuRQFshCjkkaq7Et+3VnZni1Rd01Et8pJ+JzGLNiflLzxreAD77aDzm5w1Qsb
	Gct9PCtP9tfArT0KkyF7bZMmebGQV2GhJjoJfAQgUJ/M1NAQb/ECWxMdZ+MnsRElByH4oOMRxVu
	fBfNbxZlnAqBP438MtkslIe59Nonx41YVQN/2/f93zwc6f2YW99704q01nW5q7xq+e94EOEUGrf
	FgCj4zSLCqnTaW4M0ZP5xcm/SPJPlC3IgYrlee2a6d8UZFGXk7bMLZX62g6MBXNnZF80MI3RatQ
	kRooNvRz/EsxNgAnuHu3I9quq1NZfo4GSPVEkYvpUM+HZ6a2mYl+HCoXEFlvl3Vd8LBb4qxjZ2o
	oouKWNWaXTCbmcOcWqUPZzsUU/6xJ86c7fdZBqWFs0uQq92NQD8jVJFQpNgY5IAjcuYDnFr6ugv
	K4mnB5YiB9KufSqD8wB6aOa7LAfA0vFEw==
X-Google-Smtp-Source: AGHT+IEOPbBvm+lExMBK1VGNT5FBczDOJCWJOjmYu7xROX/4TrUbJOB5wagHwsMhLi4jdkRspXck2w==
X-Received: by 2002:a05:690c:4b13:b0:783:7266:58ee with SMTP id 00721157ae682-78372666210mr456748687b3.7.1761322208709;
        Fri, 24 Oct 2025 09:10:08 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785cd6edd87sm14099197b3.51.2025.10.24.09.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 09:10:07 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: akpm@linux-foundation.org,
	brauner@kernel.org,
	corbet@lwn.net,
	graf@amazon.com,
	jgg@ziepe.ca,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	masahiroy@kernel.org,
	ojeda@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	rdunlap@infradead.org,
	rppt@kernel.org,
	tj@kernel.org
Subject: [PATCH v8 4/8] kho: add interfaces to unpreserve folios and page ranges
Date: Fri, 24 Oct 2025 12:09:58 -0400
Message-ID: <20251024161002.747372-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
In-Reply-To: <20251024161002.747372-1-pasha.tatashin@soleen.com>
References: <20251024161002.747372-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users of KHO to cancel the previous preservation by adding the
necessary interfaces to unpreserve folio and pages.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kexec_handover.h | 12 +++++
 kernel/kexec_handover.c        | 84 ++++++++++++++++++++++++++++------
 2 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 2faf290803ce..4ba145713838 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -43,7 +43,9 @@ bool kho_is_enabled(void);
 bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned int nr_pages);
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
@@ -76,11 +78,21 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_folio(struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_vmalloc(void *ptr,
 				       struct kho_vmalloc *preservation)
 {
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 82137eba1474..994ee0b70757 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -157,26 +157,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index)
 	return no_free_ptr(elm);
 }
 
-static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
-			     unsigned long end_pfn)
+static void __kho_unpreserve_order(struct kho_mem_track *track, unsigned long pfn,
+				   unsigned int order)
 {
 	struct kho_mem_phys_bits *bits;
 	struct kho_mem_phys *physxa;
+	const unsigned long pfn_high = pfn >> order;
 
-	while (pfn < end_pfn) {
-		const unsigned int order =
-			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
-		const unsigned long pfn_high = pfn >> order;
+	physxa = xa_load(&track->orders, order);
+	if (!physxa)
+		return;
+
+	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
+	if (!bits)
+		return;
 
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+}
+
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	unsigned int order;
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+	while (pfn < end_pfn) {
+		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+		__kho_unpreserve_order(track, pfn, order);
 
 		pfn += 1 << order;
 	}
@@ -745,6 +752,30 @@ int kho_preserve_folio(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
 
+/**
+ * kho_unpreserve_folio - unpreserve a folio.
+ * @folio: folio to unpreserve.
+ *
+ * Instructs KHO to unpreserve a folio that was preserved by
+ * kho_preserve_folio() before. The provided @folio (pfn and order)
+ * must exactly match a previously preserved folio.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_folio(struct folio *folio)
+{
+	const unsigned long pfn = folio_pfn(folio);
+	const unsigned int order = folio_order(folio);
+	struct kho_mem_track *track = &kho_out.track;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve_order(track, pfn, order);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_folio);
+
 /**
  * kho_preserve_pages - preserve contiguous pages across kexec
  * @page: first page in the list.
@@ -789,6 +820,33 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
+/**
+ * kho_unpreserve_pages - unpreserve contiguous pages.
+ * @page: first page in the list.
+ * @nr_pages: number of pages.
+ *
+ * Instructs KHO to unpreserve @nr_pages contiguous pages starting from @page.
+ * This must be called with the same @page and @nr_pages as the corresponding
+ * kho_preserve_pages() call. Unpreserving arbitrary sub-ranges of larger
+ * preserved blocks is not supported.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages)
+{
+	struct kho_mem_track *track = &kho_out.track;
+	const unsigned long start_pfn = page_to_pfn(page);
+	const unsigned long end_pfn = start_pfn + nr_pages;
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	__kho_unpreserve(track, start_pfn, end_pfn);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_pages);
+
 struct kho_vmalloc_hdr {
 	DECLARE_KHOSER_PTR(next, struct kho_vmalloc_chunk *);
 };
-- 
2.51.1.821.gb6fe4d2222-goog


