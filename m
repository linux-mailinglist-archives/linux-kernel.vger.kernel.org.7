Return-Path: <linux-kernel+bounces-703585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 922EDAE92C2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 01:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02E018890F0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jun 2025 23:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06582FC01F;
	Wed, 25 Jun 2025 23:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="g6eIHZCw"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AE42FEE34
	for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 23:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750893538; cv=none; b=A54bWCET91ekOsSmf/CA4qEQ85rtF/bdb6Zlh7PKLjhHAzwUTJ+FS1R+iObj7p5tDgpoiyXpQl+LvLyd9eGVYKXVX53MlA+anZQdscDk8bGT6OGY0tdhheMpPfKGePVQEGduMw0NGP7sx/+cIeEnAFoN0o2UH4csFMkNE5EDbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750893538; c=relaxed/simple;
	bh=zakCa3JDr5KNv1gJv0s94oXiSv6hJeRHKFuGzzdgwsE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJwbLdD2+yyGOIIvWqj0HQ4mjAT+I0qvLGNghYocE65SF8nFkwz5MpwtDlvaxGvLDxcqzf3606RJV62Z9Ro8TKMuIxRIETjgjCD2PIHTwpf4c3Jqnkzh7ifxxClxPo2FZPF+mpQTQbsZPH2wOemd2WdlPFjo8M3f8ndVs526TD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=g6eIHZCw; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso318364276.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jun 2025 16:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1750893535; x=1751498335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZDu7RJqPXAY2ruR1j/0614GYveU9RxRfC4eQg5qP6Q=;
        b=g6eIHZCw/IQYXZR2hLvsVboU097FxqRzJtuqCc45DXz52ytibgVqEXFfDiR0rb5USg
         JVLPA6LsQMcyH0Hd7trnM/LviQikhprKSBTRW+YqAdlufLfh3GjyzAdRNzXyuDDu7SE9
         AmyXU/paEGrjwMN7kJls1iPZmNkYOsBz6sdvCx72x4NNyeziI1C1JmnMjUioLeo/DKNS
         WJ0u4oJLqf/xv1yNFa/VeGWIrRqvxXD2ZI2Rmg+pLRsPJwDRAKUmyyWJRnUMwsAcv4BY
         2knK99g9tdlU+ID1ZC4tzR7QMSO43RrKbkbSY2Um1E65WoqS0kOJpAjYJaiFnbwre46z
         Pu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750893535; x=1751498335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SZDu7RJqPXAY2ruR1j/0614GYveU9RxRfC4eQg5qP6Q=;
        b=awUbPCMucrY8dejp3Fhvll6u7wqwVsVP/wrFMgRgyLqYkUPEa+c8w2f4sbX80kMsp2
         0tbgbwXVuoh5I3qd62N9R3MNVRVkFfN465K2ZesMuHRfpO50tsmrSh5oxeuJ+TgzX668
         eebBaKjBHK5BF8t28rFQn8CFIUEEfK0AobO3Jupnax5LDck6XTsLm4I2KltOIPC1AtfZ
         AGbC7cdgs7hldyMdR2ytmw5Sg8Hj4Fi0o4mr9IvgAgLeBtrKGr0Fvtc0pf8UNIq6zBCh
         Gab6Ei+Lumr3nv4zfdfk6zDFdnMQ7zbvhovGwMMX/WZSqIc+/nskS89f8ceAxz6nQHUF
         akxw==
X-Forwarded-Encrypted: i=1; AJvYcCUgg80eFs0txAE2NCNiw10bJfPnmkvIfPf3IUkvl3BY4hvQo0A2r6nA+5oWjaHCrPDI1C/n4Lj+smA2JYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrseEgQUFGitFTPMnr/dLB9hETlfeue61HKrcaOVDF+HDnTmXL
	Ok0Woz4ldTeIJIumlX+WOtUFjCbmvfYEL0UfcDS+0a7hPKyowXORAqYul0A5GmS5M3I=
X-Gm-Gg: ASbGnctkkCOgnr9M0REZ6dcxuQ85ksxbk3Ctwx0WW9fqWE/Ko0dY4Wm3Wf9pfdprPxM
	nHQc2m+GiV0HGSYpdsgmW/yc+AwOlZgmhbgHvnhI9cxTzmLfkT4RfS8y1xU0S/iWNrUCOyhifhN
	qZU390xWAHCeJaBE/f/O2IFOD1iKZFbG+VfdzRTaJNfGNbOgoMPlOcqm62cuYDJ89b29UmMrny9
	2SEKTcScRoEA4XP9Bmb3VIy5bBGBOa75wpgHpwvItpuUvyjtGSUlA7XVzjynMD+ovRhujEaHtr3
	pkmW2ifd/svoGqRqQsGt5e8foVIoGpOs5kIaoLgMnSiC/FMURtEsaHu+jTgE4rXWnFv33O56vdk
	ppTFUJTD5B4woi20E7Ax5mqIi1cLfnCxMqaCLPpgAMRPYoSsd0eWU6IIna+NWvS8=
X-Google-Smtp-Source: AGHT+IF6d+wQdJueaL+2XDR+0IAu1dQMzIzIZ7VLaIY39ujjcBBrFSOUIoGsCEOL7tdAla+chMnDaQ==
X-Received: by 2002:a05:6902:2182:b0:e84:46f2:8233 with SMTP id 3f1490d57ef6-e879b98cebdmr2790163276.45.1750893535364;
        Wed, 25 Jun 2025 16:18:55 -0700 (PDT)
Received: from soleen.c.googlers.com.com (64.167.245.35.bc.googleusercontent.com. [35.245.167.64])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842ac5c538sm3942684276.33.2025.06.25.16.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 16:18:54 -0700 (PDT)
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
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 07/32] kho: add interfaces to unpreserve folios and physical memory ranges
Date: Wed, 25 Jun 2025 23:17:54 +0000
Message-ID: <20250625231838.1897085-8-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
References: <20250625231838.1897085-1-pasha.tatashin@soleen.com>
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
index e1f0b7a9f5e5..d9e947eac041 100644
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
2.50.0.727.gbf7dc18ff4-goog


