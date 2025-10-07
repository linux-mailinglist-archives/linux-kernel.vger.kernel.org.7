Return-Path: <linux-kernel+bounces-843728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508DCBC0186
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FC1189AAB0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7018A208994;
	Tue,  7 Oct 2025 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="P/xT3tRZ"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831B2218AD1
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759807874; cv=none; b=nWUxaIfDG0HALtTTD0HQXUBdSr+P694qE+7lDz7T7aSAdjnCKHftzgMJU07ogTKy35vrhaWZzoV584YF4kieLosQ8l7qep9z0oazZAMa/45sgbm1RN+WJwmfOju8dEiUHr+jzJNZfZWPbvb5uMFBLvdJ6Et4Y31bl7nkrVxmj/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759807874; c=relaxed/simple;
	bh=7rwOb8p11Fksxm3ge+XkaEBcZqh7fpI8ewXvuhI4bgY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IAEYaL2DyejLbZjhhxNCeQ83eFVQWaTQTDfyQ1EjHRR4bolWATPl1sFEuDcIbCouebKUrt6qEmyRluvGokWzsGtjlJ4iePCJtwGeWO5JWmqy3ET6Qz19q7fA9xjq8ngaQXHkzJoXUuA8L3T+70gnGZPQyMedO3ZrhY8wHpntofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=P/xT3tRZ; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-54aa789f9b5so4366981e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1759807871; x=1760412671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d75MC7yX8fTJ3DXLRKGrsbPruNC6LGxufxG+WL9vn/A=;
        b=P/xT3tRZgLa9EwMvlLuS35/cGd2UZD/wyfTjmP9HG8VdLLXGxyBxKB/3ftfiWAFBKK
         qFe0ivJBTKxL34I/ehujZQA5DN8504P40lUrDFo5YvTrjGQxcaDf0c53t48E4I6AfefN
         XtVLA7KU5mEtvPpS69JLwhcM+ccnCGRzl28ytWuhkF82o7hhuUaKwNuqc2hlLmKvdiOn
         UJEIEmp/dnzHQvJXGsMJBP7MUR4Yeb+bU0sg6DGrx/HJy1ZpDQcCNg21bA0+1Y9oUfbe
         8yTILitv7lxyhSJ/Nl1c3I109Z52jodZfUMZ4IBZdPoLghJfGPUR0rM8B0HjucTpScAJ
         ljEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759807871; x=1760412671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d75MC7yX8fTJ3DXLRKGrsbPruNC6LGxufxG+WL9vn/A=;
        b=cWS4Y+/0yzoV+NUm/f3Grn2HbLUYSdgEyz6inyJC3iUlMYU4Gbs4HicCBzB1mLploe
         Vz4xK6xVEFXSyunymUpyAyU15zFaCERBx5Ts1Wd78pXOqagA1rBvhdzCajLSeYOo3C3m
         LLg2rfYxErJTzcCq7mhmHXS1WNr/badylCblZqtUXIj4ja2mUnrfzPhlOWxBoisY8C9Z
         WBlxEBjBlcWBBGOsOJozk3hAAh1CY0MPihfEKfsJrOM/IMIkTM2QzksWq7VZWKzJPcHF
         VHJd1U2Mofyg7hX/bHNX0TfzRS3JM6xHQczHlGd3kS4cN7MN9XabA17I1LMA5BEOjh2j
         RO+g==
X-Forwarded-Encrypted: i=1; AJvYcCV/AE577bF9HKYQu+OHBN+gkTM2BqxM/cpHgvNSecMduxRKsD1rlhWNPVy7sgcAc+jG5vwREmPs/MO5MiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyoh85wiWxjdXCuY5ApbZYBoU1iDuYUqKFjdkQpVRoDItFOpgUS
	9AHh78N3vEHatDGH7NpGoWj+1ldp1r3SaVjIHlfpkFn8Pz2lIMCK4kD+TLuzHXCRAoU=
X-Gm-Gg: ASbGncvPwrRA1jDTy7zF9CqSmYA1A5jaQ+12Kb9Q42KhZoQwkUbj2AYy371/WooH3qQ
	MitUp9X//3JpXhIQ6d6kv9ccLjt2TeEhF7YEpqNM5E4JjZ3n+4EuirnkTWSiXENNEfT3GCnVdVN
	btY9npJarDcfHweHA/IILz5271Xy5q27hVf/wxD4/bJbnJVCF3nViikQzXXVKPWPILGYl6Y0+n/
	QBSx0uD5AWnnxbCSjrQu79z8H8PApl4ISpZA4OKxHaX2dkZqqbW/pjgaqtu43WCt/qwzOGpO90u
	hg9e+8RTsEtOWIghaKssb/BIzoouU/DIqoUa++luJQeqSgERsGy8jRBH883TSQOSNtM9vZGKcp+
	xEStpiMinHqpQZ8nvT/nixCk1BYWidK/jz2suPKDJraXWeAryeRCiz0nbOCmZ6v36wuZpdl2efX
	RNPOhfOWkMutMc2ghwbemZKTXj7NfqFEA=
X-Google-Smtp-Source: AGHT+IFIriag8/rRrhYuf3ipZRqogDe9fVyFCNEZ9cflZH8v8IsXkHoHC8oknMO6yF3MW6LcKWyWVA==
X-Received: by 2002:a05:6122:1823:b0:539:44bc:7904 with SMTP id 71dfb90a1353d-5524e8b6931mr5202328e0c.5.1759807871292;
        Mon, 06 Oct 2025 20:31:11 -0700 (PDT)
Received: from soleen.c.googlers.com.com (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-552ea335f07sm2446030e0c.15.2025.10.06.20.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:31:10 -0700 (PDT)
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
Subject: [PATCH v5 4/7] kho: add interfaces to unpreserve folios and page ranes
Date: Tue,  7 Oct 2025 03:30:57 +0000
Message-ID: <20251007033100.836886-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
In-Reply-To: <20251007033100.836886-1-pasha.tatashin@soleen.com>
References: <20251007033100.836886-1-pasha.tatashin@soleen.com>
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
---
 include/linux/kexec_handover.h | 12 +++++
 kernel/kexec_handover.c        | 85 ++++++++++++++++++++++++++++------
 2 files changed, 84 insertions(+), 13 deletions(-)

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
index 846fb4aa6948..77fd7dd991d2 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -153,26 +153,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 	return elm;
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
@@ -734,6 +741,30 @@ int kho_preserve_folio(struct folio *folio)
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
@@ -773,6 +804,34 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_pages);
 
+/**
+ * kho_unpreserve_pages - unpreserve contiguous pages.
+ * @page: first page in the list.
+ * @nr_pages: number of pages.
+ *
+ * Instructs KHO to unpreserve @nr_pages contigious  pages starting from @page.
+ * This call must exactly match a granularity at which memory was originally
+ * preserved by kho_preserve_pages, call with the same @page and
+ * @nr_pages). Unpreserving arbitrary sub-ranges of larger preserved blocks is
+ * not supported.
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
2.51.0.618.g983fd99d29-goog


