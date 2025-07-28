Return-Path: <linux-kernel+bounces-747611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2FDB135E7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B5E7A5F04
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635382356C7;
	Mon, 28 Jul 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdplxBJm"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52224224896
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689234; cv=none; b=YqvIpvhyUMfkvS8AeuyqdIAIbRVmsE283RPRUlyJS3AxxIUpvZ55i2Bv3OkN73+9XFoWPmfxzrYd6EsH29NJdMMf/gsy1Wpfd7n5wjkSHA+COlpRSWM5SGX8FVjK50+OkErjuOAeeymZ8+0pu1SSaWgEt0Lsj9mpkQmGi5u8SaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689234; c=relaxed/simple;
	bh=y25xOKLjcc1KaRLZ/aeRVfADsfXsQIX/tXqpvnvmC94=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9vOmUJ0+MIYdnk4GAT6e5+w3ZuZM5teZ9GVv2Jr8k8xScDYqlqN2yLlxZ/FcAgKqQO6p0lHIEMNSu0Y6MmU+YCEo/BqGOzpPQIoTpKFD79zKWRIkdzhrg7SQgwXfIz1iZA8ERMJahIYCB2/nF/1kUwLULemg5JgAzx61In9Ojg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdplxBJm; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-23fe9a5e5e8so9968885ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 00:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753689233; x=1754294033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NRCznFcp7ajBKMuky7QQKQFuElaZNk3oJWmbVbFTaP8=;
        b=hdplxBJm914/b4DkCFnwMamw7yuCUSJraXX9b/Pr+rvqGkBcgye0zKYmDB/DNNzk3d
         6fx0+eAfLcDJtkaiLqZsC3obwCSHGhnr3M84V2Q4DDyE4T3B3W4qVgsOW+NP+FdAWPai
         tlLDFY6YmLm7+nlU5pMXlhKbM7v6ZknAAONFdb5GkE6Bch6C0bBKFKMJa+ZrvLwKf6qc
         4A5j5ZX5ldt8mbnYurp/dzwRWfh2KhqXXN3Vu1nHpW0RoHBtxeHJB+mTbbekfnDFf8Ep
         Y9CHJgDq8wYZkG0T6FSlHpXeb8gFM47OdRikQxzwIN8qgIsyHyvGO66pGINB8qY1rsXv
         MOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753689233; x=1754294033;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NRCznFcp7ajBKMuky7QQKQFuElaZNk3oJWmbVbFTaP8=;
        b=wi/i0QMHkP0qzP9oFh+IhuX2qS9Y5/bq0q07gJ1GVkG4ZUGPwwD7zV10J8T38DSuDY
         ZrxR2FO9JVOAf9YmXceLMjmjTcZdYXGmOubZGKuldN8jMdPC9NOMU6K3d/3V2bqxK4rh
         gxEcVT0wyLEemmwk+VmtDd4I9QPuIbX8InOKIDofCA64LsuFt0SAK0fh2z34GSuNDpt3
         rIK0Fk0o/9/x8lp6EOtjJkfyKb4WTAQ8PVdoZZHD72X7h43hS61lOnP3TucWt13rXwP4
         WhWCI48UeSCGJkoY3l0vIsV0xEyipCe1pXOf6KZBjg32hZ9HjW2X+ZcObJaLdbs/+2vA
         9TpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVE9YbaZkyPX73JupMfVEAz/tJVGGnBfZY6i7zozdunEULvmksMLSrR2VKDP80+3Q6yjRwWHwLmeaQKzcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3bKrA5mdtWUhcMx3DcujtMrC0RCCI2aof24JqeNbq8ja8XGu
	VV0Q7ZiBP13rQ32EwFftDHMlGamHEs5bgax2JWIAorkVT4PUd1IBq3xT
X-Gm-Gg: ASbGncuUzsQm+EP1zBn/t6Y+QRb1sRe8itpKgJnKX9THlpb0u9g+RKiVlc4QMeMLB1X
	92W1rRGcUGQIBKva/adhJjhML+59cVlZDX5CyTUFvpqN+QZIZuIod05iwfFv6WfrypLmLG8lITe
	mZFteEgy283IErszFC0ia/fnN/tltUN81AcExhArDwAy780DXTQ9rQZ2KgnjKWc3080wLSa/nBt
	8PlVDri0jwEpwR+/bzXwljl1WG3agdVW6d5AZMTvHnLxlr0LGrCxE9ld8UDyLuL3CpWb1THpfLy
	AsfGJomYFlGsstvuAU4rYv28zzzaNLsBH+x7y9AgRZsiGquS3FP8V6I3wUZS26txTfzg8gFEtez
	AzgcwbeY6k9ODrKQpTi61uV9DSKdtBc44wI5G
X-Google-Smtp-Source: AGHT+IGiECmYwQYBMKW+4rvl77EBjR2Rh1tffl26z0E8srbfzcXh6dA6NKxkvHgnif+njR7LnfGVPw==
X-Received: by 2002:a17:902:d504:b0:240:3f3d:fd37 with SMTP id d9443c01a7336-2403f3dfffemr12207345ad.27.1753689232485;
        Mon, 28 Jul 2025 00:53:52 -0700 (PDT)
Received: from KASONG-MC4 ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2401866c2a1sm20272305ad.4.2025.07.28.00.53.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Jul 2025 00:53:51 -0700 (PDT)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Matthew Wilcox <willy@infradead.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v6 5/8] mm/shmem, swap: never use swap cache and readahead for SWP_SYNCHRONOUS_IO
Date: Mon, 28 Jul 2025 15:53:03 +0800
Message-ID: <20250728075306.12704-6-ryncsn@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250728075306.12704-1-ryncsn@gmail.com>
References: <20250728075306.12704-1-ryncsn@gmail.com>
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

For SWP_SYNCHRONOUS_IO devices, if a cache bypassing THP swapin failed due
to reasons like memory pressure, partially conflicting swap cache or ZSWAP
enabled, shmem will fallback to cached order 0 swapin.

Right now the swap cache still has a non-trivial overhead, and readahead
is not helpful for SWP_SYNCHRONOUS_IO devices, so we should always skip
the readahead and swap cache even if the swapin falls back to order 0.

So handle the fallback logic without falling back to the cached read.

Signed-off-by: Kairui Song <kasong@tencent.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 mm/shmem.c | 41 ++++++++++++++++++++++++++++-------------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e089de25cf6a..6bcca287e173 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2019,6 +2019,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	int nr_pages = 1 << order;
 	struct folio *new;
+	gfp_t alloc_gfp;
 	void *shadow;
 
 	/*
@@ -2026,6 +2027,7 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	 * limit chance of success with further cpuset and node constraints.
 	 */
 	gfp &= ~GFP_CONSTRAINT_MASK;
+	alloc_gfp = gfp;
 	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
 		if (WARN_ON_ONCE(order))
 			return ERR_PTR(-EINVAL);
@@ -2040,19 +2042,22 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 		if ((vma && unlikely(userfaultfd_armed(vma))) ||
 		     !zswap_never_enabled() ||
 		     non_swapcache_batch(entry, nr_pages) != nr_pages)
-			return ERR_PTR(-EINVAL);
+			goto fallback;
 
-		gfp = limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
+		alloc_gfp = limit_gfp_mask(vma_thp_gfp_mask(vma), gfp);
+	}
+retry:
+	new = shmem_alloc_folio(alloc_gfp, order, info, index);
+	if (!new) {
+		new = ERR_PTR(-ENOMEM);
+		goto fallback;
 	}
-
-	new = shmem_alloc_folio(gfp, order, info, index);
-	if (!new)
-		return ERR_PTR(-ENOMEM);
 
 	if (mem_cgroup_swapin_charge_folio(new, vma ? vma->vm_mm : NULL,
-					   gfp, entry)) {
+					   alloc_gfp, entry)) {
 		folio_put(new);
-		return ERR_PTR(-ENOMEM);
+		new = ERR_PTR(-ENOMEM);
+		goto fallback;
 	}
 
 	/*
@@ -2067,7 +2072,9 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	 */
 	if (swapcache_prepare(entry, nr_pages)) {
 		folio_put(new);
-		return ERR_PTR(-EEXIST);
+		new = ERR_PTR(-EEXIST);
+		/* Try smaller folio to avoid cache conflict */
+		goto fallback;
 	}
 
 	__folio_set_locked(new);
@@ -2081,6 +2088,15 @@ static struct folio *shmem_swap_alloc_folio(struct inode *inode,
 	folio_add_lru(new);
 	swap_read_folio(new, NULL);
 	return new;
+fallback:
+	/* Order 0 swapin failed, nothing to fallback to, abort */
+	if (!order)
+		return new;
+	entry.val += index - round_down(index, nr_pages);
+	alloc_gfp = gfp;
+	nr_pages = 1;
+	order = 0;
+	goto retry;
 }
 
 /*
@@ -2350,13 +2366,12 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			}
 
 			/*
-			 * Fallback to swapin order-0 folio unless the swap entry
-			 * already exists.
+			 * Direct swapin handled order 0 fallback already,
+			 * if it failed, abort.
 			 */
 			error = PTR_ERR(folio);
 			folio = NULL;
-			if (error == -EEXIST)
-				goto failed;
+			goto failed;
 		}
 
 		/*
-- 
2.50.1


