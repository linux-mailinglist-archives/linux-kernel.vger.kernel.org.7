Return-Path: <linux-kernel+bounces-853791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F6DBDC9AD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 07:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C5074E97D8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 05:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4ED305044;
	Wed, 15 Oct 2025 05:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="fNbMI6fA"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7203302760
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 05:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760506288; cv=none; b=RnpfzbZX0aysE43l+bkJfvu1KXHlknh6+/t/ggfpryLhCpEJ5tKnoC+qZes6hW9NWyp6w4oVUPq16qiiG12jmlPesbhWc4tNRiTN7LUM2nUH25XEhCwjIQHN2Pnu5o3dXthYlisO79CD0mpQIV5AgEOjjNMjCxatzxvQPe1h5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760506288; c=relaxed/simple;
	bh=vzQCmM1nNTE0ov7uCe2kVKV3jUZEwP58A/VqI2SEtck=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbKotKPc/PZdf1E+cq5y6chhfy/9spCV7ofL3WBxHWDtklbearPYqSCMq8NsydcSYvOKiUkr9l5hXNw3IBqXOGEVU39oLaqiMUEq5cklXnZpZpx6BfF7q0+FwLnrh9ExC8G/gs++uc9R7hg3dEe6i+QyxSOZUxc/yQPIX4u3fZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=fNbMI6fA; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-88e32ad012cso47493485a.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 22:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1760506285; x=1761111085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FX//HAu2ie94it+tD5SdOdZKlGHwRq6PauprKab6pa4=;
        b=fNbMI6fASX0jjWQzL0T4YgWrDNhf5xXo+h8fdNfKN6jc4gR0OKNkSjbpO4VBC9ZFQb
         sa2061VWeYl5Y+du11PLGhHsT+tjh9Zhyp/rfID0tGlckXu8lKVBrcdeov43fnfsoCUA
         WaqUcZNpxzS94w7WKo7sTBZFBE4gr2aoKzy56CvnnTlf65DqZeVS6pdM4Y3+IX288WCP
         0xmiNDwlZ1IvXyAoDQgw2XMQgQ4GwKC+hRm2w7/Se/BDfzunNvxEW1fzz8RTnzkMqpqX
         b9XA2QJHbWsRhJCkDpTohEtp/p4OP+DmX3mdVV+xj13yqd80xCW2vvLNym3BUHmGZ68f
         LqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760506285; x=1761111085;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX//HAu2ie94it+tD5SdOdZKlGHwRq6PauprKab6pa4=;
        b=Aos6G7L3ZSMF4HtbRwj0pw2o/bqavkoYFwh8QUrgbzDGqhxuU5A6+sID6BMJzb5XMw
         7GHfjnIRy0jHkYHtHJQJX3nLIMvR4LRIXJZEsPhbDT85JF9lgZkQCsQKUHxOMrjKK8U0
         oHLiu+x5VG0LcKo3b5GwjbHRqcuL7huuhsw4uWdtH4VIeNfaJVD9Qx11dwr6lp5uW80v
         Yg+LUpMNjeukXWBWebuMlpTlgqo0SJj48pmvGLXivxBbWqLCe7Qu+AAXWaPPP/AJP1cf
         hxp8odMiL/HEQ87FZwYQld2jGFcGj0sE3Rc8ubsHzEGCEzEqkOyw2Xb1xPwDx5EQgeNf
         m9/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuRR+C8Ph9q6ko4M4XfIeOY38s8txppkBA3ok/28dWVTrzCpTDkc7Tb1VRDi6D4qJCFq6OGuMjscEX8Vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYTcf3I6BcjuNzS62zENPzXJcExmoKKpEJeaPWzzOFuv4m+49+
	mdC24gwiwHWFYxT/dhWsWpX3iw0OKWJ1Ybp1mmM7TnRXQlGg0IiAZoHzjfxuqh4z1aI=
X-Gm-Gg: ASbGncszoDoKIqi50EubWzhJSZwr23WirENk/wXBMHTht3bkFJSjso4WNet/ILha+he
	3nYx5wOXheRtx5MiXhZmD6OmNF6BzR+CMpZpd3GuxE7boqspwb59Si9pXxWVUHF5zsGfK6I4quK
	U6BJYJzPsr//OcFbXyefj1TIDEiq+IsM2He8GXPg8N1kRo2gfDVkU9/mbdiEe1OegAmuYHcrRK7
	Yj2fi6VWFSoNjhEMhl1Cuw0YpDaN9IE5XnYciZlyeFI66qofN7o1I/j6ZRWhGo/alI7Cm7cvx1K
	wPcatmwxgb/ZOyz4C5D8Jccf5SBz2oFGcyj13om0qRgptDAiJUPHDFEFsxvmOR9zUr3QkvbI3Gx
	GDuGnFjpd+Lzfot6l9r5Gl40MXPtRjrJCvQVVKoFvpw+kI1c27yV5/syyGw+chOf92dz9UvQ2k/
	mz8FFE0TniFEDkKCJU8gPaCA+QV8JPEYXDEoDH+wJWtEm2rAuwz9Dyd5aSSWg=
X-Google-Smtp-Source: AGHT+IG4TVlyGj87gL4l3Cn5wFpTA6+9S0+DZSHD6GOiJNS/JWUuuuCXSPGMqGA/FDM8qzc6tZIhdg==
X-Received: by 2002:ac8:5a06:0:b0:4e8:85e8:8019 with SMTP id d75a77b69052e-4e885e8859amr10940541cf.78.1760506285490;
        Tue, 14 Oct 2025 22:31:25 -0700 (PDT)
Received: from soleen.us-east4-b.c.cloudtop-prod-us-east.internal (53.47.86.34.bc.googleusercontent.com. [34.86.47.53])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e881d01f5asm12572661cf.27.2025.10.14.22.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 22:31:25 -0700 (PDT)
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
	jasonmiu@google.com,
	dmatlack@google.com,
	skhawaja@google.com
Subject: [PATCH 1/2] liveupdate: kho: warn and fail on metadata or preserved memory in scratch area
Date: Wed, 15 Oct 2025 01:31:20 -0400
Message-ID: <20251015053121.3978358-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.51.0.788.g6d19910ace-goog
In-Reply-To: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is invalid for KHO metadata or preserved memory regions to be located
within the KHO scratch area, as this area is overwritten when the next
kernel is loaded, and used early in boot by the next kernel. This can
lead to memory corruption.

Adds checks to kho_preserve_* and KHO's internal metadata allocators
(xa_load_or_alloc, new_chunk) to verify that the physical address of the
memory does not overlap with any defined scratch region. If an overlap
is detected, the operation will fail and a WARN_ON is triggered. To
avoid performance overhead in production kernels, these checks are
enabled only when CONFIG_KEXEC_HANDOVER_DEBUG is selected.

Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
---
 kernel/liveupdate/Kconfig                   | 15 ++++++++++
 kernel/liveupdate/kexec_handover.c          | 32 ++++++++++++++++++---
 kernel/liveupdate/kexec_handover_debug.c    | 18 ++++++++++++
 kernel/liveupdate/kexec_handover_internal.h |  9 ++++++
 4 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/kernel/liveupdate/Kconfig b/kernel/liveupdate/Kconfig
index 522b9f74d605..d119f4f3f4b1 100644
--- a/kernel/liveupdate/Kconfig
+++ b/kernel/liveupdate/Kconfig
@@ -27,4 +27,19 @@ config KEXEC_HANDOVER_DEBUGFS
 	  Also, enables inspecting the KHO fdt trees with the debugfs binary
 	  blobs.
 
+config KEXEC_HANDOVER_DEBUG
+	bool "Enable Kexec Handover debug checks"
+	depends on KEXEC_HANDOVER_DEBUGFS
+	help
+	  This option enables extra sanity checks for the Kexec Handover
+	  subsystem.
+
+	  These checks verify that neither preserved memory regions nor KHO's
+	  internal metadata are allocated from within a KHO scratch area.
+	  An overlap can lead to memory corruption during a subsequent kexec
+	  operation.
+
+	  If an overlap is detected, the kernel will print a warning and the
+	  offending operation will fail. This should only be enabled for
+	  debugging purposes due to runtime overhead.
 endmenu
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 5da21f1510cc..ef1e6f7a234b 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -141,6 +141,11 @@ static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
 	if (!elm)
 		return ERR_PTR(-ENOMEM);
 
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(elm), sz))) {
+		kfree(elm);
+		return ERR_PTR(-EINVAL);
+	}
+
 	res = xa_cmpxchg(xa, index, NULL, elm, GFP_KERNEL);
 	if (xa_is_err(res))
 		res = ERR_PTR(xa_err(res));
@@ -354,7 +359,13 @@ static struct khoser_mem_chunk *new_chunk(struct khoser_mem_chunk *cur_chunk,
 
 	chunk = kzalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!chunk)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	if (WARN_ON(kho_scratch_overlap(virt_to_phys(chunk), PAGE_SIZE))) {
+		kfree(chunk);
+		return ERR_PTR(-EINVAL);
+	}
+
 	chunk->hdr.order = order;
 	if (cur_chunk)
 		KHOSER_STORE_PTR(cur_chunk->hdr.next, chunk);
@@ -379,14 +390,17 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 	struct khoser_mem_chunk *chunk = NULL;
 	struct kho_mem_phys *physxa;
 	unsigned long order;
+	int ret = -ENOMEM;
 
 	xa_for_each(&kho_out->track.orders, order, physxa) {
 		struct kho_mem_phys_bits *bits;
 		unsigned long phys;
 
 		chunk = new_chunk(chunk, order);
-		if (!chunk)
+		if (IS_ERR(chunk)) {
+			ret = PTR_ERR(chunk);
 			goto err_free;
+		}
 
 		if (!first_chunk)
 			first_chunk = chunk;
@@ -396,8 +410,10 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 
 			if (chunk->hdr.num_elms == ARRAY_SIZE(chunk->bitmaps)) {
 				chunk = new_chunk(chunk, order);
-				if (!chunk)
+				if (IS_ERR(chunk)) {
+					ret = PTR_ERR(chunk);
 					goto err_free;
+				}
 			}
 
 			elm = &chunk->bitmaps[chunk->hdr.num_elms];
@@ -414,7 +430,7 @@ static int kho_mem_serialize(struct kho_out *kho_out)
 
 err_free:
 	kho_mem_ser_free(first_chunk);
-	return -ENOMEM;
+	return ret;
 }
 
 static void __init deserialize_bitmap(unsigned int order,
@@ -737,6 +753,9 @@ int kho_preserve_folio(struct folio *folio)
 	const unsigned int order = folio_order(folio);
 	struct kho_mem_track *track = &kho_out.track;
 
+	if (WARN_ON(kho_scratch_overlap(pfn << PAGE_SHIFT, PAGE_SIZE << order)))
+		return -EINVAL;
+
 	return __kho_preserve_order(track, pfn, order);
 }
 EXPORT_SYMBOL_GPL(kho_preserve_folio);
@@ -784,6 +803,11 @@ int kho_preserve_pages(struct page *page, unsigned int nr_pages)
 	unsigned long failed_pfn = 0;
 	int err = 0;
 
+	if (WARN_ON(kho_scratch_overlap(start_pfn << PAGE_SHIFT,
+					nr_pages << PAGE_SHIFT))) {
+		return -EINVAL;
+	}
+
 	while (pfn < end_pfn) {
 		const unsigned int order =
 			min(count_trailing_zeros(pfn), ilog2(end_pfn - pfn));
diff --git a/kernel/liveupdate/kexec_handover_debug.c b/kernel/liveupdate/kexec_handover_debug.c
index eb47f000887d..294d1d290142 100644
--- a/kernel/liveupdate/kexec_handover_debug.c
+++ b/kernel/liveupdate/kexec_handover_debug.c
@@ -214,3 +214,21 @@ __init int kho_debugfs_init(void)
 		return -ENOENT;
 	return 0;
 }
+
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	phys_addr_t scratch_start, scratch_end;
+	unsigned int i;
+
+	for (i = 0; i < kho_scratch_cnt; i++) {
+		scratch_start = kho_scratch[i].addr;
+		scratch_end = kho_scratch[i].addr + kho_scratch[i].size - 1;
+
+		if (phys <= scratch_end && (phys + size) > scratch_start)
+			return true;
+	}
+
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
diff --git a/kernel/liveupdate/kexec_handover_internal.h b/kernel/liveupdate/kexec_handover_internal.h
index b3fc1957affa..92798346fa5a 100644
--- a/kernel/liveupdate/kexec_handover_internal.h
+++ b/kernel/liveupdate/kexec_handover_internal.h
@@ -44,4 +44,13 @@ static inline void kho_debugfs_fdt_remove(struct kho_debugfs *dbg,
 					  void *fdt) { }
 #endif /* CONFIG_KEXEC_HANDOVER_DEBUGFS */
 
+#ifdef CONFIG_KEXEC_HANDOVER_DEBUG
+bool kho_scratch_overlap(phys_addr_t phys, size_t size);
+#else
+static inline bool kho_scratch_overlap(phys_addr_t phys, size_t size)
+{
+	return false;
+}
+#endif /* CONFIG_KEXEC_HANDOVER_DEBUG */
+
 #endif /* LINUX_KEXEC_HANDOVER_INTERNAL_H */
-- 
2.51.0.788.g6d19910ace-goog


