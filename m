Return-Path: <linux-kernel+bounces-876626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135BFC1BE65
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DCE119C08AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D6350297;
	Wed, 29 Oct 2025 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGWOPl/f"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B432634FF69
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761753592; cv=none; b=HH77Iq2AgIHQB3y5PdJJo8e5guF0RW6Z70CsxYcFMk1CO3AINLCwTO7bD3/NtTMiqMqPNvyDZi7g3cm1sWdwTXNHsUn+FjVhD0AOYiIflm7yY8EucqKFhGjB432QqNDeAHp+Dc6nGWL1PC852bAJ/YBYpw18qyMbcEJKusmtNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761753592; c=relaxed/simple;
	bh=3ptaXN+GAGoCho1TfU0eVUutT5FBhLQ1N3F5bH4ARsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YSGRrUG49B+wGKUmPy+IJOsv23zn4/8HPEy2xvDaavNBiqySF3fSAw/O0zP0At5VW7esGMd9sngcH3mEDJ/zJ/8MVlHjNj3CYr4lImTJTgv0L6OcjwcU5/fo/9PwJcpIkxkE2jey2vKIb0BvsbcfnjaSqxjRkbMoQLHn5HayUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGWOPl/f; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-34029cd0cbdso84293a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761753590; x=1762358390; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hEBe93+AqDqbmzUn4tECC01fE40N0PwOlnrL0O+c5gY=;
        b=fGWOPl/fFTEnj35SGpei98lgx5vkrhaylfXEqvKBflfbgchru3ENfNXjwwrC68qyDW
         Q7+I8JZ/NO3aaCq4BKuvKypgP9NDrzDp5PuwKlpEoJaqPMXQ5YaETe8KB0m32hgH55c2
         dYSOn68GnK2w2+Fk1Q1skVn5qkfmo8fGWCmTIzQ29RwMgwzpR51t/n9Ij30NrgfFUZm1
         KZH9wkrfLRtGwwMnB7aqzxKjNr4O7dwd1lqHF9Id9kkdkNZqHkXKP7/HG6ONiYRuG0MD
         72l2q3hYtGqqOu2o0mGlVuTPuZUwz1oefFGwc9Rsi12Z507wHNM0ZnBNuHqisIPp8Sr8
         ayEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761753590; x=1762358390;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEBe93+AqDqbmzUn4tECC01fE40N0PwOlnrL0O+c5gY=;
        b=UDwtTfg8w3dTMLDMNaiHWg4Z2kTUxG8QPKye4wj9xP8qGDOYw2ZBaLiw4GpE8upWur
         qANoQSklS3kvyRB6P+yf3IM3A+i73ZxnMvFTuvN00n1ohMmOBmFSKxQce8s8aZNeRDym
         DxeE258l2/l+rG5Yq1jLp+gpuNDK+NnHmm1tqpez61FAVr5RNHmshQc+cEDiQpQ17Vwj
         vR3ZeJmbjk4l0ePgtQ/IRk+aVhgw6W7rkpj0urxNdCyM8UFw+FGyd8IXssZIx8uuh3fh
         sfohCJVySnrCMZ9Hsrle9KBlS21xPcaur/dP8XyWg+kDa26I/juokTWBY8Q2HHpbHdNi
         NYBg==
X-Forwarded-Encrypted: i=1; AJvYcCXWZk7csop4A4YqfnkfJ0r6bVm9wPgiKFCIkPtxfZbde7jUZUVptiS7Y7kYQaQ/m0rmkMx5DBjH+oSEUTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa3ByE/XdJ6xY/MibZ/7eOCgx14TwlvG4iVRZWjWmQU3tpjsn+
	l6+SQRaOqVip9oCwcXmNyshcYQ8ATQFqkTC3E2X9//gopTJqnm+e4hQL
X-Gm-Gg: ASbGncuOB1kBabzye7+oW40sMp501Xm63F4JLWnllDVcz5xYxa1Mxczd/SUfavF68ZT
	rwzbEr+0DTwmAQs1BjcFvzyRnd5rfrbtvbF5DMkiOWK5Qe/d+jaNYlKzQmj721BjGovurcfumfF
	SgFKPKO1Rn1HcA/0NLzBEsNP63RRMYGMs/WaVLZi4mGCZWiUf+U4y4oVduh/Dqnp+nv3xO/zRsL
	97Q33IsYRWb0rbklj7/oarIzyt+Tsgeq1aGdsNX6c1c8LLo6B/yCYEU8n/27q7yQ6fWIg9qIruY
	vIyjjv3Cfu1B9zZ6ncoIjLs2xpaIOeSNwwFAnEdvtWFZDAOfnZCAnhF+JEZR3cUbF98CCf7kkNI
	TpE0z3CPHWRDTIXKqvMABLzizyziXygoqVTKGFOiZVPPHhIstEoMzvuJsux0ZNbBOZpLXoo5jZu
	COL01SSUyRZw==
X-Google-Smtp-Source: AGHT+IE3wJlrEK8Y4HOI8VQFwkEg3x3geQZauMd9eO5Geg4rfGwAJlYNO9WbP0RB4Wfto3M74+vZpg==
X-Received: by 2002:a17:90b:254b:b0:32b:9bec:158f with SMTP id 98e67ed59e1d1-3403a2f1625mr3442455a91.29.1761753589772;
        Wed, 29 Oct 2025 08:59:49 -0700 (PDT)
Received: from [127.0.0.1] ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e95aasm16087366a91.8.2025.10.29.08.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:59:49 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 29 Oct 2025 23:58:37 +0800
Subject: [PATCH 11/19] mm, swap: split locked entry duplicating into a
 standalone helper
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-swap-table-p2-v1-11-3d43f3b6ec32@tencent.com>
References: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
In-Reply-To: <20251029-swap-table-p2-v1-0-3d43f3b6ec32@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
 Barry Song <baohua@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Nhat Pham <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Yosry Ahmed <yosry.ahmed@linux.dev>, David Hildenbrand <david@redhat.com>, 
 Youngjun Park <youngjun.park@lge.com>, Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Huang, Ying" <ying.huang@linux.alibaba.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
X-Mailer: b4 0.14.3

From: Kairui Song <kasong@tencent.com>

No feature change, split the common logic into a stand alone helper to
be reused later.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swapfile.c | 62 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index e4c521528817..56054af12afd 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3646,26 +3646,14 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOENT
  * - swap-mapped reference requested but needs continued swap count. -> ENOMEM
  */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
+static int swap_dup_entries(struct swap_info_struct *si,
+			    struct swap_cluster_info *ci,
+			    unsigned long offset,
+			    unsigned char usage, int nr)
 {
-	struct swap_info_struct *si;
-	struct swap_cluster_info *ci;
-	unsigned long offset;
-	unsigned char count;
-	unsigned char has_cache;
-	int err, i;
-
-	si = swap_entry_to_info(entry);
-	if (WARN_ON_ONCE(!si)) {
-		pr_err("%s%08lx\n", Bad_file, entry.val);
-		return -EINVAL;
-	}
-
-	offset = swp_offset(entry);
-	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
-	ci = swap_cluster_lock(si, offset);
+	int i;
+	unsigned char count, has_cache;
 
-	err = 0;
 	for (i = 0; i < nr; i++) {
 		count = si->swap_map[offset + i];
 
@@ -3673,25 +3661,20 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 		 * Allocator never allocates bad slots, and readahead is guarded
 		 * by swap_entry_swapped.
 		 */
-		if (WARN_ON(swap_count(count) == SWAP_MAP_BAD)) {
-			err = -ENOENT;
-			goto unlock_out;
-		}
+		if (WARN_ON(swap_count(count) == SWAP_MAP_BAD))
+			return -ENOENT;
 
 		has_cache = count & SWAP_HAS_CACHE;
 		count &= ~SWAP_HAS_CACHE;
 
 		if (!count && !has_cache) {
-			err = -ENOENT;
+			return -ENOENT;
 		} else if (usage == SWAP_HAS_CACHE) {
 			if (has_cache)
-				err = -EEXIST;
+				return -EEXIST;
 		} else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX) {
-			err = -EINVAL;
+			return -EINVAL;
 		}
-
-		if (err)
-			goto unlock_out;
 	}
 
 	for (i = 0; i < nr; i++) {
@@ -3710,14 +3693,31 @@ static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
 			 * Don't need to rollback changes, because if
 			 * usage == 1, there must be nr == 1.
 			 */
-			err = -ENOMEM;
-			goto unlock_out;
+			return -ENOMEM;
 		}
 
 		WRITE_ONCE(si->swap_map[offset + i], count | has_cache);
 	}
 
-unlock_out:
+	return 0;
+}
+
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage, int nr)
+{
+	int err;
+	struct swap_info_struct *si;
+	struct swap_cluster_info *ci;
+	unsigned long offset = swp_offset(entry);
+
+	si = swap_entry_to_info(entry);
+	if (WARN_ON_ONCE(!si)) {
+		pr_err("%s%08lx\n", Bad_file, entry.val);
+		return -EINVAL;
+	}
+
+	VM_WARN_ON(nr > SWAPFILE_CLUSTER - offset % SWAPFILE_CLUSTER);
+	ci = swap_cluster_lock(si, offset);
+	err = swap_dup_entries(si, ci, offset, usage, nr);
 	swap_cluster_unlock(ci);
 	return err;
 }

-- 
2.51.1


