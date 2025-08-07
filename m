Return-Path: <linux-kernel+bounces-758524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E33B1D04E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 03:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E318C6A21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3808A20E71D;
	Thu,  7 Aug 2025 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="aY17lsS7"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98691F76A8
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 01:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754531101; cv=none; b=orv41Czu45AM59iAmQQyczxFsW+YxduepOYjaYybvomrRKhiRuorgvnkfUWIF8l+a3VJiLLAEkvq2YG2zBspDyOYOH+MBv99KwwunEtatyFYt79MnAt6+dSFN5zyhdZxeXiqN6PIGfL5KEI8MFdKw+AYmaxYYPbyBthgoInj9uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754531101; c=relaxed/simple;
	bh=1D7JJh7HzPnlfEMFGjJk71iWrGihfks9VCV0ygwxBoM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz5YIQjShbSbs3agGUst6XIXZpcOuPp9oxVs18HITJm19B6UxzuHo5GZC5gW+O3jWGX6FbWVig9wKnxEMfRWoCYtLXcoDcTYJHNSahgumq37TIOkUEYbrtxppLoeCaM5fO848gm9oHTqDaJh1DENBEOBgtjYkoVuIduQbc7KjZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=aY17lsS7; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-7073075c767so6815116d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 18:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1754531098; x=1755135898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s+B2pqucc9Fmko4Lv5M93Olp+poBlrEG0AoODeQS2z8=;
        b=aY17lsS7jsngqvql3ro45AGZyeWrvlEq+Gf7+yl6HpzkERZliHgIWFRrYAOviBhkzb
         mO02ClxmGh3nqhGuxyPb2fxsxF022xHfFEykIHsXft8Q6eFDQnKKMVXuVXPouipBnLDE
         8lity8N437B7XWpZQ7HlEVyn5kZRhuthhUG5PH3Qmae3o45b9aBnX4wCLAQqyacQpELo
         ke72YlComU75XmNm4Q/dMkNGpGj4La+m1bQhOJfKLIfetfHOEo4cGTMnR29LGXlUiYMS
         Gzejaovhwgr2PlC3iNB8a6muoluRmXtczwlHkT+gvZdH+vlgUzlOmrLMnHPQgP1A9Phv
         7TNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754531098; x=1755135898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s+B2pqucc9Fmko4Lv5M93Olp+poBlrEG0AoODeQS2z8=;
        b=JNe1MmZuWPBkrpput9lDkMLEBqC8IxmFvVfXfDn0jDXeXHpRF04Ie5x3bui0MdW0d4
         bQTeXHPHYhnXy1orycXfVXW1Z1vdtElNUXSRPXm2piMk8/tXM1leTzBTwfZfd10Jn/E1
         EJ22IFEIwxIpXogyOqxa3lFg1dbmEjeXShbSA53gHVt5i48CmXIU0HCKqY48/L++1wyi
         7kztRPRl/b2Sj/XHovwBqdGTeP4T/JZStX/c3oYzb/Zzs2lrvt+aftSlIPeiW663+U/y
         47+ljZLXAk0hdnVUL4e6TFD9j+tJMgwty6vODPqLoEj6ml0zWHKTfbZKshw1MG8J8tJj
         wQgA==
X-Forwarded-Encrypted: i=1; AJvYcCUMHR7iFgPMrBHnS5WyUDu0q4aPaDPIPmXn77mqJnwko6uS/cjBaV5MHEBg04VW2FQLzaeftXiwwoDYLGY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywejc0wmspTzTYC3HyyEy8Uq2PJQaFuRrTMHDdv+bzulZveoPqX
	9+Lo/C1rcg9lNNSd03mic1nmp7V+cv6OTCSkdC3vO8gEPUXhPndEr5cbejS0VEItn5s=
X-Gm-Gg: ASbGncsAYPetpsLlHfY2tCI9jKMm4vsrq362/CKv0D9oiNs2JwePnrp2ytdUvhdvlMH
	HHn0eyFeC8tQuxaptVv0GzIiv/6Qizmqhnavd1WQ/JIxk2g2o7rV8JiXEn7XOhFD6XNI4KUZ8HH
	UyacBpMFdkwRcurGKx9qz0ejlQXpfgFnw0gl9u5QNGgJFbudDrk9GmADmXDfoh8sYpqr0AohOzI
	aaENA3snPcUIzO2dwU+ijvEWGmizQMx/ap1nprY1rZLfZBOhaHOiARvNZGIoOlpzDuG843gEAaW
	4Pb7me4VN5X16pBC2ExAEhc94yZlWTlRbW89ODB78jU/4fIyDmBJDqMDjrsNeIeKugleitzFTCE
	cKNbV2VYJO1DeF+LTCgGI02AktR2rW2zxlEr10oMEVgGnkEQ48Mb0QN0TO4S/moc2R9+QKOWRQi
	tysJPubDlbOikKAWE/rCaQEZ4=
X-Google-Smtp-Source: AGHT+IGAEOC4X/n5iybE9j8P6hUMRBMLG9Syy/4PfWc1CO2/gkmjV3XW7jEAwKFIXrmXPPP2oTU9ug==
X-Received: by 2002:a05:6214:5081:b0:707:415b:c13a with SMTP id 6a1803df08f44-70979539363mr72512306d6.22.1754531097555;
        Wed, 06 Aug 2025 18:44:57 -0700 (PDT)
Received: from soleen.c.googlers.com.com (235.247.85.34.bc.googleusercontent.com. [34.85.247.235])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cde5a01sm92969046d6.70.2025.08.06.18.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 18:44:56 -0700 (PDT)
From: Pasha Tatashin <pasha.tatashin@soleen.com>
To: pratyush@kernel.org,
	jasonmiu@google.com,
	graf@amazon.com,
	changyuanl@google.com,
	pasha.tatashin@soleen.com,
	rppt@kernel.org,
	dmatlack@google.com,
	rientjes@google.com,
	corbet@lwn.net,
	rdunlap@infradead.org,
	ilpo.jarvinen@linux.intel.com,
	kanie@linux.alibaba.com,
	ojeda@kernel.org,
	aliceryhl@google.com,
	masahiroy@kernel.org,
	akpm@linux-foundation.org,
	tj@kernel.org,
	yoann.congal@smile.fr,
	mmaurer@google.com,
	roman.gushchin@linux.dev,
	chenridong@huawei.com,
	axboe@kernel.dk,
	mark.rutland@arm.com,
	jannh@google.com,
	vincent.guittot@linaro.org,
	hannes@cmpxchg.org,
	dan.j.williams@intel.com,
	david@redhat.com,
	joel.granados@kernel.org,
	rostedt@goodmis.org,
	anna.schumaker@oracle.com,
	song@kernel.org,
	zhangguopeng@kylinos.cn,
	linux@weissschuh.net,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	rafael@kernel.org,
	dakr@kernel.org,
	bartosz.golaszewski@linaro.org,
	cw00.choi@samsung.com,
	myungjoo.ham@samsung.com,
	yesanishhere@gmail.com,
	Jonathan.Cameron@huawei.com,
	quic_zijuhu@quicinc.com,
	aleksander.lobakin@intel.com,
	ira.weiny@intel.com,
	andriy.shevchenko@linux.intel.com,
	leon@kernel.org,
	lukas@wunner.de,
	bhelgaas@google.com,
	wagi@kernel.org,
	djeffery@redhat.com,
	stuart.w.hayes@gmail.com,
	ptyadav@amazon.de,
	lennart@poettering.net,
	brauner@kernel.org,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	saeedm@nvidia.com,
	ajayachandra@nvidia.com,
	jgg@nvidia.com,
	parav@nvidia.com,
	leonro@nvidia.com,
	witu@nvidia.com
Subject: [PATCH v3 07/30] kho: add interfaces to unpreserve folios and physical memory ranges
Date: Thu,  7 Aug 2025 01:44:13 +0000
Message-ID: <20250807014442.3829950-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Changyuan Lyu <changyuanl@google.com>

Allow users of KHO to cancel the previous preservation by adding the
necessary interfaces to unpreserve folio.

Signed-off-by: Changyuan Lyu <changyuanl@google.com>
Co-developed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 include/linux/kexec_handover.h | 12 +++++
 kernel/kexec_handover.c        | 90 +++++++++++++++++++++++++++++-----
 2 files changed, 89 insertions(+), 13 deletions(-)

diff --git a/include/linux/kexec_handover.h b/include/linux/kexec_handover.h
index cabdff5f50a2..383e9460edb9 100644
--- a/include/linux/kexec_handover.h
+++ b/include/linux/kexec_handover.h
@@ -33,7 +33,9 @@ struct folio;
 bool kho_is_enabled(void);
 
 int kho_preserve_folio(struct folio *folio);
+int kho_unpreserve_folio(struct folio *folio);
 int kho_preserve_phys(phys_addr_t phys, size_t size);
+int kho_unpreserve_phys(phys_addr_t phys, size_t size);
 struct folio *kho_restore_folio(phys_addr_t phys);
 int kho_add_subtree(const char *name, void *fdt);
 void kho_remove_subtree(void *fdt);
@@ -58,11 +60,21 @@ static inline int kho_preserve_folio(struct folio *folio)
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_folio(struct folio *folio)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline int kho_preserve_phys(phys_addr_t phys, size_t size)
 {
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_unpreserve_phys(phys_addr_t phys, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline struct folio *kho_restore_folio(phys_addr_t phys)
 {
 	return NULL;
diff --git a/kernel/kexec_handover.c b/kernel/kexec_handover.c
index 8a4894e8ac71..b2e99aefbb32 100644
--- a/kernel/kexec_handover.c
+++ b/kernel/kexec_handover.c
@@ -136,26 +136,33 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
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
 
-		clear_bit(pfn_high % PRESERVE_BITS, bits->preserve);
+static void __kho_unpreserve(struct kho_mem_track *track, unsigned long pfn,
+			     unsigned long end_pfn)
+{
+	unsigned int order;
+
+	while (pfn < end_pfn) {
+		order = min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
+
+		__kho_unpreserve_order(track, pfn, order);
 
 		pfn += 1 << order;
 	}
@@ -667,6 +674,30 @@ int kho_preserve_folio(struct folio *folio)
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
  * kho_preserve_phys - preserve a physically contiguous range across kexec.
  * @phys: physical address of the range.
@@ -712,6 +743,39 @@ int kho_preserve_phys(phys_addr_t phys, size_t size)
 }
 EXPORT_SYMBOL_GPL(kho_preserve_phys);
 
+/**
+ * kho_unpreserve_phys - unpreserve a physically contiguous range.
+ * @phys: physical address of the range.
+ * @size: size of the range.
+ *
+ * Instructs KHO to unpreserve the memory range from @phys to @phys + @size.
+ * The @phys address must be aligned to @size, and @size must be a
+ * power-of-2 multiple of PAGE_SIZE.
+ * This call must exactly match a granularity at which memory was originally
+ * preserved (either by a `kho_preserve_phys` call with the same `phys` and
+ * `size`). Unpreserving arbitrary sub-ranges of larger preserved blocks is not
+ * supported.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int kho_unpreserve_phys(phys_addr_t phys, size_t size)
+{
+	struct kho_mem_track *track = &kho_out.track;
+	unsigned long pfn = PHYS_PFN(phys);
+	unsigned long end_pfn = PHYS_PFN(phys + size);
+
+	if (kho_out.finalized)
+		return -EBUSY;
+
+	if (!PAGE_ALIGNED(phys) || !PAGE_ALIGNED(size))
+		return -EINVAL;
+
+	__kho_unpreserve(track, pfn, end_pfn);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_unpreserve_phys);
+
 static int __kho_abort(void)
 {
 	int err = 0;
-- 
2.50.1.565.gc32cd1483b-goog


