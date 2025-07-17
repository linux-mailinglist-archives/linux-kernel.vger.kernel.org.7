Return-Path: <linux-kernel+bounces-735206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2A3B08C26
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE3DC3BE45D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9822BEFE4;
	Thu, 17 Jul 2025 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z/3AM0dM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DA82BE64A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752753161; cv=none; b=GRp1pfBeeKPNP/vwW8oVDF85pOiyOpRA3eHTJ2lGnQVQDzmzYBlxz6RZAVSD3UyJ9w3+Yxn70Bc2NR/ujdL+0gsCf4NGF5gioZCeYeuR/exNurzhG1nQHCltK7Q1UNPx9cvOyIeINNBQJwXIjY8OM9Klz65PL3tkgE41+urvcNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752753161; c=relaxed/simple;
	bh=6/jjLRxyu6Gk21aB2ScFk9YQfi5MLdI3W8BYCgHrJ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlGESsmWWQOR9vTfU3o+6xKggv9XdVR8AcoGJUA99qqEKyxmrafaL6jFMPI/Iu4fvOp6XrJIW1XA/HeRAssD8CwzhDthqrd7rf/X+rTOsceyF8nyegUBGidM9736esOsDpGqIUNTIPSaVjfTUNDS+jBck/0nDCE9wgPvD52KXf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z/3AM0dM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752753157;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y93PTvMkvM029q6ldi/06ftGqYZT07G8pbjSDy6T3hs=;
	b=Z/3AM0dM5PwCbQza5Oi9+FpboGpcxweZx2NtowW27M5UhR5onZVY8DPTvVx1R9rXCKHCGD
	cGf6KEQnzIRL2qpu7X+9C2U3XunC6EfTFGo2rxDZZdU0fI+PLoIXrHoqpas6hQg4EGeyQt
	I4t069yR+tzwPp7pTNag29Pmddd+kQk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-vJd0IpIGOWifGNhvpVK7qw-1; Thu, 17 Jul 2025 07:52:36 -0400
X-MC-Unique: vJd0IpIGOWifGNhvpVK7qw-1
X-Mimecast-MFC-AGG-ID: vJd0IpIGOWifGNhvpVK7qw_1752753155
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4eb6fcd88so525464f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:52:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752753155; x=1753357955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y93PTvMkvM029q6ldi/06ftGqYZT07G8pbjSDy6T3hs=;
        b=XAc35ZZgQHFu0EvGmdY/982U7/8DHtipil0vCPWnVCJB3ciyWKHtDfnKSjy8M6RcfH
         N+MbvO0FRmCh4PMTTPasuU/oF5Kxqc5qZdW5pnGsy6LgXUgy+5GfgyqPfoaZ/HY/tOIb
         Ss4H7jkv7gW9K3pZmjJGVr2O41K7YyYpSDwKtykJ4Hb3jJ0q4N6Ue2b2/0OcCif9bpDG
         DCT8zT6Cg+yOvDoFAAE5Y30ZDglCcFxS+vlvOEq35VPtpNoVHFYYePe3bJOfUBWsH5Zf
         yBBS63VUz1C002B+4+5JENkncfwBrA6HCjGGFo3W0t1azV+tVmeqbI5UIAYACD1clKCO
         kd8w==
X-Gm-Message-State: AOJu0YwgAOdgvzbnL96ckWqYxtVa7r+P+L8k57EDY049q9WCo+xMJa4F
	zAF6HQzlaJs35ZOziri2k9cEHST6SU4riNgsH/U/Xa0TS0ZnQci74OU5gIk2TYhZONdKNEBZU8S
	CK6gvbJZRbq1ZP+SQpyCA+OiPGc0Q4wIYlBmFdkvLmXlKN21/Ur15ycG8OlhLWD3Dw11AwPYJCI
	rLfsK7eBGFiNfhTL2g6Vg+Wu8zVDuEvSA+c7HGTND9AofrUpea
X-Gm-Gg: ASbGncux1N5Bibhuk1tCRB0a3ub4Hpn6KjkHymqQo4C800pza5ENpJQVGszSrtpU2gT
	ivXS8hW50mxMjC88vA8ZGRlRk8rY4Nkx79MTxJa4qYOdZZyBNc0hl7UBZWyHztApZNqEPE6Mu6p
	seJqVeWkqPi11rwNw8POPLuv6oZc1Znen+oOiYBMxS+wlSgp7s2DT0AB+yMF8IixE1DHzGAL9jo
	EAF1dZG9FJKQrbiwvV/L9k3BkEK+nDKZzHxZqkcUHSsJ9VbdLAEh797YBpbfzCzVkEXJo5MkxVw
	ugGlFl87G7ZlhsNjlFVHo8Suzq9Kbo0FvxN5iRnlg5n2hgm7BvpFiav7+L5uTyeEzeigFunpsCg
	ZlhKOcS2jMph7Egb8081aHDI=
X-Received: by 2002:a5d:6f14:0:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b60e510baamr4180698f8f.45.1752753155028;
        Thu, 17 Jul 2025 04:52:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAqQmPlaR0MqxERo3NRLrhaU4oEs8iGAGrgiheQNLTojFB3jUgPbGxNACr3plB8i5Bf9h92A==
X-Received: by 2002:a5d:6f14:0:b0:3a4:f661:c3e0 with SMTP id ffacd0b85a97d-3b60e510baamr4180643f8f.45.1752753154425;
        Thu, 17 Jul 2025 04:52:34 -0700 (PDT)
Received: from localhost (p200300d82f1f36000dc826ee9aa9fdc7.dip0.t-ipconnect.de. [2003:d8:2f1f:3600:dc8:26ee:9aa9:fdc7])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b5e8bd18ffsm20281626f8f.9.2025.07.17.04.52.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 04:52:33 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>,
	Barry Song <baohua@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Hugh Dickins <hughd@google.com>,
	Oscar Salvador <osalvador@suse.de>,
	Lance Yang <lance.yang@linux.dev>
Subject: [PATCH v2 8/9] mm: introduce and use vm_normal_page_pud()
Date: Thu, 17 Jul 2025 13:52:11 +0200
Message-ID: <20250717115212.1825089-9-david@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250717115212.1825089-1-david@redhat.com>
References: <20250717115212.1825089-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's introduce vm_normal_page_pud(), which ends up being fairly simple
because of our new common helpers and there not being a PUD-sized zero
folio.

Use vm_normal_page_pud() in folio_walk_start() to resolve a TODO,
structuring the code like the other (pmd/pte) cases. Defer
introducing vm_normal_folio_pud() until really used.

Reviewed-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h |  2 ++
 mm/memory.c        | 27 +++++++++++++++++++++++++++
 mm/pagewalk.c      | 20 ++++++++++----------
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index abc47f1f307fb..0eb991262fbbf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2349,6 +2349,8 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 				  unsigned long addr, pmd_t pmd);
 struct page *vm_normal_page_pmd(struct vm_area_struct *vma, unsigned long addr,
 				pmd_t pmd);
+struct page *vm_normal_page_pud(struct vm_area_struct *vma, unsigned long addr,
+		pud_t pud);
 
 void zap_vma_ptes(struct vm_area_struct *vma, unsigned long address,
 		  unsigned long size);
diff --git a/mm/memory.c b/mm/memory.c
index c43ae5e4d7644..00a0d7ae3ba4a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -796,6 +796,33 @@ struct folio *vm_normal_folio_pmd(struct vm_area_struct *vma,
 		return page_folio(page);
 	return NULL;
 }
+
+/**
+ * vm_normal_page_pud() - Get the "struct page" associated with a PUD
+ * @vma: The VMA mapping the @pud.
+ * @addr: The address where the @pud is mapped.
+ * @pud: The PUD.
+ *
+ * Get the "struct page" associated with a PUD. See vm_normal_page_pfn()
+ * for details.
+ *
+ * Return: Returns the "struct page" if this is a "normal" mapping. Returns
+ *	   NULL if this is a "special" mapping.
+ */
+struct page *vm_normal_page_pud(struct vm_area_struct *vma,
+		unsigned long addr, pud_t pud)
+{
+	unsigned long pfn = pud_pfn(pud);
+
+	if (unlikely(pud_special(pud))) {
+		if (vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP))
+			return NULL;
+
+		print_bad_page_map(vma, addr, pud_val(pud), NULL);
+		return NULL;
+	}
+	return vm_normal_page_pfn(vma, addr, pfn, pud_val(pud));
+}
 #endif
 
 /**
diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 648038247a8d2..c6753d370ff4e 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -902,23 +902,23 @@ struct folio *folio_walk_start(struct folio_walk *fw,
 		fw->pudp = pudp;
 		fw->pud = pud;
 
-		/*
-		 * TODO: FW_MIGRATION support for PUD migration entries
-		 * once there are relevant users.
-		 */
-		if (!pud_present(pud) || pud_special(pud)) {
+		if (pud_none(pud)) {
 			spin_unlock(ptl);
 			goto not_found;
-		} else if (!pud_leaf(pud)) {
+		} else if (pud_present(pud) && !pud_leaf(pud)) {
 			spin_unlock(ptl);
 			goto pmd_table;
+		} else if (pud_present(pud)) {
+			page = vm_normal_page_pud(vma, addr, pud);
+			if (page)
+				goto found;
 		}
 		/*
-		 * TODO: vm_normal_page_pud() will be handy once we want to
-		 * support PUD mappings in VM_PFNMAP|VM_MIXEDMAP VMAs.
+		 * TODO: FW_MIGRATION support for PUD migration entries
+		 * once there are relevant users.
 		 */
-		page = pud_page(pud);
-		goto found;
+		spin_unlock(ptl);
+		goto not_found;
 	}
 
 pmd_table:
-- 
2.50.1


