Return-Path: <linux-kernel+bounces-863931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF10BF98AD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 02:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8FD5619FE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D4B1EB1AA;
	Wed, 22 Oct 2025 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="X0sPomhC"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7421E8342
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 00:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761094647; cv=none; b=hF276NaRxXkBncPjnWhjHRvWNjqMbyPEDqLf+8qJ13CzUpUt4PPWn3N+dEI4WKlFTSSlmTIGZN/Dohvr/oxYOp/Oa2mzs3Mw2/FjbgKQiB88AKffng0zKWXE3aElqO+8lQQRgpd6O808PsDUyVFJFY6O2J+hI6Qa9cbZg3bmwUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761094647; c=relaxed/simple;
	bh=ICrvdx6JwZ+a9++79jXeIGR5Tgq/AzAu/D2kWon/kzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8MjvfMu9NWjSPTC5tnDJjnYGZU6rCIQvVNhe2f53blVULuHZgv29wJeh3bvBRw99u2wC1ijZhWfvBPAxvj3x0gyMfeGHKqXC764s+1ZYMuwnPJW86AJkJK4SObXwxrqP7x6Z+WFZlUGprVN0bTi3v6t0FjMB/6f3Mltqyuzl68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=X0sPomhC; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4b109c6b9fcso5591061cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 17:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1761094645; x=1761699445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W+qadFBBotkNKd/oqO1HqvVbgecomYazxdkikuzLBKg=;
        b=X0sPomhCLY/za10BMUYzO3YCpBv6ifhfY5YBgblyYdNfZpp1rBTFv6KgMISA3PLC7n
         7wdjPzDyqJrdV/IleZW0OPDf1wvPxCJvWTbvOk508wBjbDbzBpQW4o4sZyFnevg/YoaW
         8Xr1aQVMKewz2KKzW/3w5ns7efMfeAR5xMKQ2cpFs/ZS+LcnzXJmcfbDY5W9TSGJ1rOJ
         XfG85lfKaoLqg6eeIoht5IF04oUbXOMH5ZoreFZhFqxVZnwNZl7Yn7QkRvCCP6HvjX5o
         Hxyh63ExI70DnHnv+vlqwa3HRt5wO06P/muW1aaI2Z6U4rnXfFKZAmQyjUZnKHSTuhvF
         qdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761094645; x=1761699445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+qadFBBotkNKd/oqO1HqvVbgecomYazxdkikuzLBKg=;
        b=tdUdILPIMmdKjKuZELYLb+JqfkHEKcbxK0c5u0Qs08ZKebY8zDw3+/LjyXktZBWB/6
         amchqzwgOkdWJt/oPJ+bWAl2N53TpWpudILNAjsFGUqRl0X3eec5tArOuPyZAHxwCX9n
         FrtPdg04R3amCI1NV+avmDcAXUTr1arLPB59QHjtxlssKTSmNTSPGLArx2+7TgBGGvdT
         aEL+MCjtHFcdMOWK0HMzDOCfor6sACuJJuM4GQt61dWnwW3z1LzeogjG8r2aiR75eAaz
         49Pb7thGJ23OR7zVGqwio8O3RcRQb30DsQnohnbN//X6C95kpfNE8OsIxqTSKywdIfv7
         h0Tw==
X-Forwarded-Encrypted: i=1; AJvYcCU3lVdtVw9IFy0a4IL3Tll2fZeJGJiKPKAM7AIVosfaknLzvOOpB5FNy5aNM3xWAQb3Pkts3k/XST2K9Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2Gt5wl/+IpJGKPN/bRZ2yN3uCPHNRLXD0+b16+9HQtTWlBHvr
	l0aMkMoJkGLbc1iDOTpKuqJQ8Ii6rRMe9gNs24lk6f0iBehfwWzqhxP3cEIVW+bzmGs=
X-Gm-Gg: ASbGncuS/W4SFu9vyTOT1kv1crpRqom4hHM2gUJa2GZEpt+E9tXABNJzgJV5NbwRgsa
	16iymDxIQIY+kzW/YxMdTat6TO0H5xhcibv0P5XB8faHruNYqWfreXVPK6JiRyCq/74fi/4leVu
	B7bSqHmr+NLSgt4rkEL19c6eWAb+yLK4if+D+QSyHFS3jW2+LbUUZkgi3IAxX0XCPKl9kgYAtKB
	c+b7KCXEweJ5menQ+plVwyLkQfRFluF5PgGTBcqHbJS/HpE5pyQYjdK+QEPlCBM5Kl7aqp3XLK7
	4DajCSzjRJL6AIL/2nvDmL6H8UbpaytMz2qnpoUG7putjMQtwWruN8HP8w6/XSTNGdUmGXBzQbP
	PZfEZs6B6XM+JyywgkpVZjey44Y4I1rDGaU4hlfRY4UeFbPBfXK05IKbZfRHadaM3Rwk+maD4OJ
	JCvZU/aOrH0Q35LT76cj+2VdqoqX+ZKwd4gHjQ2aL2fu614VlyyZxNr7OfLIplVTc6orJEYx2K8
	0AxzAerIImA/tJOyRyFuhaugTNU8z3l
X-Google-Smtp-Source: AGHT+IEbvWQwrifIahe6E5wZ3o39RE/3lexOa2z4QGwcdffIuvb1yOyb5Y/9vOdhLrPU2DTeJO1H3Q==
X-Received: by 2002:a05:622a:1206:b0:4e8:b23e:8558 with SMTP id d75a77b69052e-4ea0dea50e5mr93304831cf.77.1761094644824;
        Tue, 21 Oct 2025 17:57:24 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8aaf3432dsm84169501cf.2.2025.10.21.17.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 17:57:24 -0700 (PDT)
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
Subject: [PATCHv7 4/7] kho: add interfaces to unpreserve folios and page ranges
Date: Tue, 21 Oct 2025 20:57:16 -0400
Message-ID: <20251022005719.3670224-5-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.915.g61a8936c21-goog
In-Reply-To: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
References: <20251022005719.3670224-1-pasha.tatashin@soleen.com>
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
index 0a4234269fe5..8412897385ad 100644
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
@@ -749,6 +756,30 @@ int kho_preserve_folio(struct folio *folio)
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
@@ -793,6 +824,34 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
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
2.51.0.915.g61a8936c21-goog


