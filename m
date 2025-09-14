Return-Path: <linux-kernel+bounces-815681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7114AB569C4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042A417ACBC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2D6D1F5435;
	Sun, 14 Sep 2025 14:38:13 +0000 (UTC)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6D1198851
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757860693; cv=none; b=ji+VAVqecu/0L9ZuaDEDbKmoQCzwnp8atvLa+/QgcUnsld1z7GTBa8yjDWVAvL1OUN/2EfNsAPVCL8WDcTLValPEDqYVN6nhk2gUUjvJveJZ414l6VVawaefAdc8TA3CGW9dcQXBcnXvxe505XHk9rR8lEeY/HaPEoZz3O58Bsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757860693; c=relaxed/simple;
	bh=22fXo1JxvKYKi41UuqLqIPUSHXuBWiFsOfVDn7AId5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKUi0RSNMqSAfeHfJZo4vYVKo57aXSXvGnf5Z3LAPxl9TM4m6mdMnCSE1Pzd+JgixIXZNarpYXHICOV/GnspEfzlpTTJjcsw3W5OV74eD3suJqfkJrRpqv4p8wDFETnikqaj6556p+qM/MIuR/lVbThxLRepFiTLii9arUbws7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2570bf605b1so31195375ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757860691; x=1758465491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dc2ToHGvqgetretFJ5TWWHKSy1o0O/m6boNyeBXRweQ=;
        b=qhrvhH+D1hqvwTE13motowiGhNDFsyQ3LONu0kGiX5naQPBMYbJ8wfRxfniBhsssnb
         gvGW+LbCgYyscalch6G6qSUvvxlX6K01Dol7SQhWhMH+rgdQV3f1xOPz2Swrl7exE1cN
         cHt1Ub4covXe9sfuwuK/dDSgQtD/E+3Qjv3fg+s45+SPvvzjNiaGcoB3VKoVRDv4vrbT
         RVCNzChrthyv3fXEM1rDh4ylA1rDRd64lucn+oXq3SiIdHu3jWSheZQpQrYsViPS1Z5X
         CVohaa54YvJ9+A5B2z9Yomydni37ddbK0SvsFHBySpcI55IhA9acB8QrdVPav2QJAvnt
         4yag==
X-Forwarded-Encrypted: i=1; AJvYcCXJcKpCq7knmS/RJv5IdjW8jG1b7AM++eAbVpiUvohVJw3eZ5CrqbX7NHlNzDx40Sr1VVitoclAxOwmYLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+INSNM7SC66635XCYoWtoVmfPXQfolU/bLM9D6YMVblFSkxcL
	C/Ig5VC1XZ04JaAwdIPvM5hv4gKAC8MhJ3WTybUuS93uT62a/Riw3HeH
X-Gm-Gg: ASbGncsSYeUljp5nFj6jWOR8X6HVPpmfviT3KR0NwjMeBypcSOmFHeavpDtTHdjS6Gr
	Ws+ixiIwzMm9TOM97hiOzd7ojK99Ynfp27PI/Qdvu/lArvZSPPofJQ5PFfyCMz1miJQaqv8mOtC
	3J2B8xvEmkqv+QUSQp/EtaFuePL8Ntj0FWlnbKJuiWvl2QqvPYF4hzgUdFBU+AWBEMKytCyHfzL
	YaOnI0G+ePLjT1r1RAw25psrDwDctfcaahFCzmfpfEB9KlbX27pvfgl/sVAq7phO1klrOM77Nz7
	V9mAAjwQFFM5X/0NIMySKFcnG8xBAaCMP7rPfeXk+Ww8Pu8qHgAxeTOTsZceaWcuXotFQfwPlvi
	bcUTV6ZfwWCw=
X-Google-Smtp-Source: AGHT+IEr2DMCdCdoOyIsL92HGAQ+R3HSje6j05Zrq3wRDfxpMSO6h+wpKjwZO7jrA4WHFzd1zkhsiQ==
X-Received: by 2002:a17:902:ce90:b0:264:4e4a:904e with SMTP id d9443c01a7336-2644e4a928bmr38635145ad.23.1757860691127;
        Sun, 14 Sep 2025 07:38:11 -0700 (PDT)
Received: from localhost.localdomain ([2a11:3:200::10b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm102571545ad.123.2025.09.14.07.38.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 14 Sep 2025 07:38:10 -0700 (PDT)
From: Lance Yang <lance.yang@linux.dev>
To: akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com
Cc: ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	ioworker0@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH mm-new 1/3] mm/khugepaged: skip unsuitable VMAs earlier in khugepaged_scan_mm_slot()
Date: Sun, 14 Sep 2025 22:35:45 +0800
Message-ID: <20250914143547.27687-2-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250914143547.27687-1-lance.yang@linux.dev>
References: <20250914143547.27687-1-lance.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lance Yang <lance.yang@linux.dev>

Let's skip unsuitable VMAs early in the khugepaged scan; specifically,
mlocked VMAs should not be touched.

Note that the only other user of the VM_NO_KHUGEPAGED mask is
 __thp_vma_allowable_orders(), which is also used by the MADV_COLLAPSE
path. Since MADV_COLLAPSE has different rules (e.g., for mlocked VMAs), we
cannot simply make the shared mask stricter as that would break it.

So, we also introduce a new VM_NO_THP_COLLAPSE mask for that helper,
leaving the stricter checks to be applied only within the khugepaged path
itself.

Signed-off-by: Lance Yang <lance.yang@linux.dev>
---
 include/linux/mm.h |  6 +++++-
 mm/huge_memory.c   |  2 +-
 mm/khugepaged.c    | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index be3e6fb4d0db..cb54d94b2343 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -505,7 +505,11 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_REMAP_FLAGS (VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP)
 
 /* This mask prevents VMA from being scanned with khugepaged */
-#define VM_NO_KHUGEPAGED (VM_SPECIAL | VM_HUGETLB)
+#define VM_NO_KHUGEPAGED \
+	(VM_SPECIAL | VM_HUGETLB | VM_LOCKED_MASK | VM_NOHUGEPAGE)
+
+/* This mask prevents VMA from being collapsed by any THP path */
+#define VM_NO_THP_COLLAPSE	(VM_SPECIAL | VM_HUGETLB)
 
 /* This mask defines which mm->def_flags a process can inherit its parent */
 #define VM_INIT_DEF_MASK	VM_NOHUGEPAGE
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index d6fc669e11c1..2e91526a037f 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -134,7 +134,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
 	 * Must be checked after dax since some dax mappings may have
 	 * VM_MIXEDMAP set.
 	 */
-	if (!in_pf && !smaps && (vm_flags & VM_NO_KHUGEPAGED))
+	if (!in_pf && !smaps && (vm_flags & VM_NO_THP_COLLAPSE))
 		return 0;
 
 	/*
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 7c5ff1b23e93..e54f99bb0b57 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -345,6 +345,17 @@ struct attribute_group khugepaged_attr_group = {
 };
 #endif /* CONFIG_SYSFS */
 
+/**
+ * khugepaged_should_scan_vma - check if a VMA is a candidate for collapse
+ * @vm_flags: The flags of the VMA to check.
+ *
+ * Returns: true if the VMA should be scanned by khugepaged, false otherwise.
+ */
+static inline bool khugepaged_should_scan_vma(vm_flags_t vm_flags)
+{
+	return !(vm_flags & VM_NO_KHUGEPAGED);
+}
+
 int hugepage_madvise(struct vm_area_struct *vma,
 		     vm_flags_t *vm_flags, int advice)
 {
@@ -2443,7 +2454,8 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
 			progress++;
 			break;
 		}
-		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
+		if (!khugepaged_should_scan_vma(vma->vm_flags) ||
+		    !thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
 skip:
 			progress++;
 			continue;
-- 
2.49.0


