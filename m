Return-Path: <linux-kernel+bounces-759239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1E4B1DACE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 17:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B46D1899A5E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 15:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB9226C39F;
	Thu,  7 Aug 2025 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioBU/uA8"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAC226B2DB
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754580469; cv=none; b=f5ehuAnnctVP5JhH1UiSdH97U5H+Shx8PIxMtDswZOYYUymO41QZBoXhwqBs/gMsxjEVPdvP/eUt9SZg4mzl4yNvQzAvhc2Fj6B6kgwIJUqmO2CCQR6h9sb8xoDhgKmiYTF1XrgSK0skGFtr8XIdMiibNx5BPf6c7CTlH6ICyzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754580469; c=relaxed/simple;
	bh=l1HykbPMuIDjGSGihvgSNI2MrNRWddPpGPG1+EG6GXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCosC4aUnPT0RDoU8QUZP4y7xKIeUs5GoKrJ30vaBYCHOhNE/PaAERcoZcDFecbWxE9MSaRd3U7Z6KIkmJFOUjjtYPKIGhQyLBskDpP5Zq8YGrNzJUOOLrYif+ovexdVBkaZ9SRyvkJ6SChDK/jGJaHF8KVwzRVxhC6XPntvXKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ioBU/uA8; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76bf3dafaa5so2272546b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754580466; x=1755185266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V4HgnHp/VUMkLIl9/1CszxaTlnI+Qqu+k/nd2ePzpfU=;
        b=ioBU/uA8NpWb+1rbvxuhSGXhy5pKJBDvO8Exp+owwLEOnpHjRVfKMv9pM/oco11s0o
         MOm4/ptbgF/GafXpBwcDfRT57aywtefWbdvswsIi0S/UACD/Gpigq6YDBqBNuvBszzZU
         g3GF1vDpDd4jmBDV3j+BMBTFcz1uYRThwv+0pVzUyk6q3VDsPrDQqA/eLq1OFz6kXd4h
         Dfg83xz0USwRGAWOkdoNTQDfDI5EiIVnV/66neL0vNsGDmddMbzVs+mcyb27mZa/MHPB
         k9PNsBJAd+vovh0v8ovy/wgJl+iVrcHLgYguigGR00aw4wv4C6pZ9FaTxg4RtZ9EKfyx
         QOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754580466; x=1755185266;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V4HgnHp/VUMkLIl9/1CszxaTlnI+Qqu+k/nd2ePzpfU=;
        b=IzzSASm2rw7kIFR2GtWljQESQSnDMmb/tcQ4iVOXsDQFULHv6geKs7RadEI9dzO+EL
         K2z+/1+p+UK66UIfoiQthfGteqkDaYkZta3joAXAZ5JZkE7VNTTrpOkfLH7okzH2d/le
         clfSBpvMhGED4fcDxYjRyS5VRRWKUhqFGKmJF9bAaxmf490EyF/pBqi/487AVhJzLK2Z
         5zRc+Uz57W4YfJirkAtncILzwU0XgM9Nhu0rNApaH4JOI4pFa3nE+k+6OQa+oJwDRRb7
         G86stJ8TWdRE0zkTh5zu4NSJXtsIjvlCdSYXVonw0Cm3mCax3q/rzQcGxVhHZw04KQoK
         cofg==
X-Forwarded-Encrypted: i=1; AJvYcCUmn82PDSONcE9D6we8921WS0o/+AHXDTegJjM7l2jvVH5SAMXWc8qMYfqWawiDEhLXUby8wyVoXGQ3j1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31SiPFFMCNj7oNPTYtOK4AyyEDxWRlCP4gm6P/B22ij7/8cqV
	mTizQUqXz/Z23n+zgTSM5CUegrw/FGzb9oUbzFY2mXZnyDfSs9IYTCCw
X-Gm-Gg: ASbGncvWvklR3w0FqSH/sQyO62lP3pEBwAmelFyNDn5XT3/qa8iZZMaL63/KKsHbf6J
	CfS9OaUk+B5/DWgEn4UVgzNWJDzKTt6Q3LSEDPlXPvf4ie/jxreW9PkZTOw/+nowzberTybveIg
	ahQ1HYXr0Lnq1EQt2v5/FplgsfZfjNtwvxZRCl4UGJ1DhyULyKhFf5X6DwkSIu+Gb9y4S18wlc8
	ZbRk8a4QrE2IUZMMKenHsdUt2OZUOQ9++bb+888WiTJqUYN9l0jwlFw9ISOUO2Trwh2mMl9NfvX
	//ttdGVe17OPIKfLU9wVQpcApaO0TlsuI3LuLyN7ga7zBe/bxIeRQv+/qRR/7W5UhX/DBvE0vBN
	DGsPTUbICqoKBAnPAJmaHv8CJEYY7s7kBcKAECQ==
X-Google-Smtp-Source: AGHT+IGRbQlMmFmrGlSgAAFMHCRTu3alRXN12IXyPHDZLhr3a/gmmz3hDLUgm15BOyTlhRlzVYIBmg==
X-Received: by 2002:a05:6a20:3d06:b0:240:17b3:3838 with SMTP id adf61e73a8af0-240412a3734mr6406970637.20.1754580466093;
        Thu, 07 Aug 2025 08:27:46 -0700 (PDT)
Received: from KASONG-MC4 ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcce6f319sm18430540b3a.18.2025.08.07.08.27.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:27:45 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [RFC PATCH 2/3] mm/mincore: use a helper for checking the swap cache
Date: Thu,  7 Aug 2025 23:27:19 +0800
Message-ID: <20250807152720.62032-3-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807152720.62032-1-ryncsn@gmail.com>
References: <20250807152720.62032-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

Introduce a mincore_swap helper for checking swap entries, seperate it
from page cache checking.

The new helper will only be called on swap address space, so it always
grab the swap device before checking the entry, caller won't need to
lock anything.

The sanity WARN_ON check will also cover all use case now, previously it
only worked for PTE checking.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/mincore.c | 58 ++++++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/mm/mincore.c b/mm/mincore.c
index f0d3c9419e58..1ac53acac239 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -47,6 +47,31 @@ static int mincore_hugetlb(pte_t *pte, unsigned long hmask, unsigned long addr,
 	return 0;
 }
 
+static unsigned char mincore_swap(swp_entry_t entry)
+{
+	struct swap_info_struct *si;
+	struct folio *folio = NULL;
+	unsigned char present = 0;
+
+	if (!IS_ENABLED(CONFIG_SWAP)) {
+		WARN_ON(1);
+		return 1;
+	}
+
+	si = get_swap_device(entry);
+	if (si) {
+		folio = filemap_get_folio(swap_address_space(entry),
+					  swap_cache_index(entry));
+		put_swap_device(si);
+		if (folio) {
+			present = folio_test_uptodate(folio);
+			folio_put(folio);
+		}
+	}
+
+	return present;
+}
+
 /*
  * Later we can get more picky about what "in core" means precisely.
  * For now, simply check to see if the page is in the page cache,
@@ -64,33 +89,18 @@ static unsigned char mincore_page(struct address_space *mapping, pgoff_t index)
 	 * any other file mapping (ie. marked !present and faulted in with
 	 * tmpfs's .fault). So swapped out tmpfs mappings are tested here.
 	 */
-	if (IS_ENABLED(CONFIG_SWAP) && shmem_mapping(mapping)) {
-		folio = filemap_get_entry(mapping, index);
-		/*
-		 * shmem/tmpfs may return swap: account for swapcache
-		 * page too.
-		 */
+	folio = filemap_get_entry(mapping, index);
+	if (folio) {
 		if (xa_is_value(folio)) {
-			struct swap_info_struct *si;
 			swp_entry_t swp = radix_to_swp_entry(folio);
 			/* There might be swapin error entries in shmem mapping. */
 			if (non_swap_entry(swp))
 				return 0;
-			/* Prevent swap device to being swapoff under us */
-			si = get_swap_device(swp);
-			if (si) {
-				folio = filemap_get_folio(swap_address_space(swp),
-							  swap_cache_index(swp));
-				put_swap_device(si);
-			} else {
+			if (shmem_mapping(mapping))
+				return mincore_swap(swp);
+			else
 				return 0;
-			}
 		}
-	} else {
-		folio = filemap_get_folio(mapping, index);
-	}
-
-	if (folio) {
 		present = folio_test_uptodate(folio);
 		folio_put(folio);
 	}
@@ -177,13 +187,7 @@ static int mincore_pte_range(pmd_t *pmd, unsigned long addr, unsigned long end,
 				 */
 				*vec = 1;
 			} else {
-#ifdef CONFIG_SWAP
-				*vec = mincore_page(swap_address_space(entry),
-						    swap_cache_index(entry));
-#else
-				WARN_ON(1);
-				*vec = 1;
-#endif
+				*vec = mincore_swap(entry);
 			}
 		}
 		vec += step;
-- 
2.50.1


