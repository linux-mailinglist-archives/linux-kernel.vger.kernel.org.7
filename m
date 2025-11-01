Return-Path: <linux-kernel+bounces-881346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F634C280C9
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 15:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 574394E6274
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 14:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04352F90DC;
	Sat,  1 Nov 2025 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Vn2y9h4m"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF0F214A9B
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762007019; cv=none; b=fBGf9FLGJvXJOsSYGKGwlNkRcMpjVPxld18jYM9r58RnK4p9sfkaUL7hPF1NEh/NMayNtyZtscrpCEC+agJ4yvdmI6LxaeX09MmHtPYmWXr3jMohVmJIYua4DtCUz5YM4BDHK2PgXHamFILUuPRSgcupEiulpldKX6P4Vu9RBC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762007019; c=relaxed/simple;
	bh=QII1LaRqcceKkOy011EbkwamvpGeFjwigCsLK8szwCk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cG0y0nmp/nqBznp9yawwwKJsZZPBXkDdxB5pRgIGz1tS17fraIjAYanYb3BP32eA4+F3MB8/YE4qUFKkhYF8l/BM755kIO1Jy9CI1ygwbLrqV0FijNYRsg8TUtzlHoJecQ8noqnptWVrN3OmRtzoPA90VvADA+R9Sv8Xx/0xdwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=Vn2y9h4m; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-556a4651cfcso1149793e0c.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1762007017; x=1762611817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rpi1Z/2DyRVkKnxEHwYxahLzSNsmpU8z1Poo2lMWpYA=;
        b=Vn2y9h4mSl7FT0REVdf5xAOC+m1+BLUlz3PgfWB48dtEzjfw0pS8goROfXDrIfKiP/
         ynXAjyj4D3KJE1blU3GWAndhPUQ8bKvR/O+KurHHuiQIHXmjZgvPs8Sv0NJLlIfHfDkR
         HW92lXr0t5tqcuXB9EuL+blXIni3tNW38viWVqgQFdwyWwncXV6SjGhGmqN0ZB0myjKJ
         vCPcVr9MpFaj9bf9KtiDWOxqkf7h8KQeromsQDzbA22R8ZmSDn5KB4zX9TNqHSNSRrDP
         5CvARIrvGHgaXQ+yKsoBM/fEhUHTfH9wqhgJOWFc3RXPYOwd2QS/vTKYi+Si8zbFsTv4
         IihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762007017; x=1762611817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rpi1Z/2DyRVkKnxEHwYxahLzSNsmpU8z1Poo2lMWpYA=;
        b=sEQwjr7+ftRB9OYSXyV+yLxvi0UE/vQnU9O/lxEhEazlqnZemvcysk5/cdngD8Qnrw
         0/trQ6Q/kxgKJ+4/9mk1JHK4Fnegpt+5TDT02G/54y25z+ljX/lIuwVx/DQJDfudiw7t
         YhtdpuaTjSQHvAAQgSTq688slYu2CFi5IqGZDc9rDewIiHRkr+HrUyU+0SwUIa1aTOek
         2Tj/8QdVgq4pYUuHwBLG37RAPwnx3oIbmlxdCqKlZa+17oxOIPOhb6z2VXJuMoyXF+fn
         NTwjx8oiPh8cO/FF/PYm3BzvxxM/RLG46YJGAAVpoGHMFtycxMq8dU5EmQkc8CzA8Cqc
         2c9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbsC2ZJCZQmpHblY5onzTIj3edKJ4JXTWYbmjptSYU7afRz+1EautpRvIK8u8XSNXFi0zzsf1iV4mX0e4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEEf4AuaQFPVg+B23675ee+EK/1CvryFQuZINaTt5i1wnDlxii
	lUJ794XFetp5WAQg19GssTJrgmBVRZgSzwTIBe4A2kcVA+UQPUb9qaXLi7ZJSQApixU=
X-Gm-Gg: ASbGnculHjv06EGuNEDDlNBl6VEnqUnwKf8AE1cvBNeCUy7Wg+/o1eSQ4XVjq4+C1UH
	vFc2q/LNML3VA8DLvVfE9nbUVAtpufunl6RzxaQZU4dcT50ihbuYw5MymPATvj1dePZtmz+4xEB
	NVVuyzyaxI4MeHFBfFXe5KksajHXR8H3uMW76lCyJlNJrqRpJYvnGIJ5w0f/PzLPqegKLgrNCTu
	AZjaMid6NFhuL/BCUZfftp/x+KVFf6YhlEFRn3KaPvnihf3MHjXgV7KPHa+/Vfr6gNLeh9jgQ4x
	znIbG0hYOxFqkv1U1EhDrQ6aNxFOfd5Cdy6DqatS9dDbTedw2z4qYiDHGGT5yLO3KLfZlmL9LlW
	HTfq3Cqrne5qkDsgdGX556ci3n4KTb1ppUmAOA59hvK7bT+lumgWMKeqKx2KbSOzocIqlAD5mnI
	L0gums1n8IqzjJRnzMgwdZVsmOhwLjmy8+iZ+P4o8kfrkNie6/Rz70f1xl9fsjxUma9kPaUGs=
X-Google-Smtp-Source: AGHT+IEMu4ntr1ofdj6Iu9NM0kSW7ODJm45DTBvuQgzydqOGurQZxTtybUZHECZqoshEfoiQa/oT9Q==
X-Received: by 2002:a05:6122:4591:b0:558:251:f0e8 with SMTP id 71dfb90a1353d-5593e4ef501mr2376540e0c.11.1762007016891;
        Sat, 01 Nov 2025 07:23:36 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-559449647e0sm1776242e0c.3.2025.11.01.07.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 07:23:35 -0700 (PDT)
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
	tj@kernel.org,
	yanjun.zhu@linux.dev
Subject: [PATCH v9 3/9] kho: add interfaces to unpreserve folios, page ranges, and vmalloc
Date: Sat,  1 Nov 2025 10:23:19 -0400
Message-ID: <20251101142325.1326536-4-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.1.930.gacf6e81ea2-goog
In-Reply-To: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
References: <20251101142325.1326536-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow users of KHO to cancel the previous preservation by adding the
necessary interfaces to unpreserve folio, pages, and vmallocs.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/kexec_handover.h |  18 ++++++
 kernel/kexec_handover.c        | 104 ++++++++++++++++++++++++++++-----
 2 files changed, 109 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index 0d860d793b66..80ece4232617 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -43,8 +43,11 @@ bool kho_is_enabled(void);
 bool is_kho_boot(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_pages(struct page *page, unsigned int nr_pages);
+int kho_unpreserve_pages(struct page *page, unsigned int nr_pages);
 int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation);
+int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation);
 struct folio *kho_restore_folio(phys_addr_t phys);
 struct page *kho_restore_pages(phys_addr_t phys, unsigned int nr_pages);
 void *kho_restore_vmalloc(const struct kho_vmalloc *preservation);
@@ -72,17 +75,32 @@ static inline int kho_preserve_folio(struct folio *folio)
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
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 82137eba1474..c514b300ebe6 100644
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
 
-		physxa = xa_load(&track->orders, order);
-		if (!physxa)
-			continue;
+	bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
+	if (!bits)
+		return;
 
-		bits = xa_load(&physxa->phys_bits, pfn_high / PRESERVE_BITS);
-		if (!bits)
-			continue;
+	clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+}
+
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	unsigned int order;
+
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
@@ -949,6 +1007,26 @@ int kho_preserve_vmalloc(void *ptr, struct kho_vmalloc *preservation)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_vmalloc);
 
+/**
+ * kho_unpreserve_vmalloc - unpreserve memory allocated with vmalloc()
+ * @preservation: preservation metadata returned by kho_preserve_vmalloc()
+ *
+ * Instructs KHO to unpreserve the area in vmalloc address space that was
+ * previously preserved with kho_preserve_vmalloc().
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_vmalloc(struct kho_vmalloc *preservation)
+{
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	kho_vmalloc_free_chunks(preservation);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_vmalloc);
+
 /**
  * kho_restore_vmalloc - recreates and populates an area in vmalloc address
  * space from the preserved memory.
-- 
2.51.1.930.gacf6e81ea2-goog


