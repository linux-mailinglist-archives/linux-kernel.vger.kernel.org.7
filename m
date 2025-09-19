Return-Path: <linux-kernel+bounces-824273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F5B888AF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 11:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B9F74E09F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024D52F3600;
	Fri, 19 Sep 2025 09:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EX+HMF8D"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60C92F0C4F
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 09:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758273938; cv=none; b=O9JN3obaY+rzZ45R8Wie/xz5EEuBBjW7Xy2ugsZsqqKEYBgQNA8VEKCAqB5MnNpi0tZvxg+F89y6CV+Igrx/V6JHPkyKj/O8G+C77jY93sa2VQWPF8ZMxLAkT0ZeUd4RJoA81srUZhPa2FhsNVms2rrI6JDLxty4LJvcjgtXpmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758273938; c=relaxed/simple;
	bh=Dmbh77xafPSCDkuUaQbh55O29LCOs4niw9GS8J2zo+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UO/4/1H+eTcCNJ8f/CYtlPmjCQ8ABgSi/RVKe9GLckp5Q9CzjlVCy5j6TrR/GXbcQ0LN6RmHQQuTWh27tx5F3rpu5NaRL4mXxerQN7l4ThURF5RzDETyhomVo/2F/mE1l0BF6HVu8JbxwUN99WL70Jrqudf4Af0HW3F1rdVap9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EX+HMF8D; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-32e1c8223d3so1590081a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 02:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758273935; x=1758878735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oB0ZWPbK+ZLVMGEIgwgPI2hlWSIgxfz6oD2rkNKtFKE=;
        b=EX+HMF8DS80s7NYZDmEpf3s7CD74E/mKD6DQgXBLawXyjd/eU/QVdumMwjKY/o/0c+
         DwvfP0C3637anP9bvRpAl0FzfrvHe8FofaacGoICoULKiwN+kOyOYFLDdfY5y88TW5IB
         un1+i5ZxgP9Gv1nl3Kg6KPXx5h7Z+/cW0lWALRkyREI6loLs0VRXg3lKWR9UOA2bixT9
         Y134KA1T7gN5XFobPkcd/F7yMhRxs+w+4FM+Tv+7XN7KUeCi7YwfBY5epBEcvKD4dEe4
         yT73pMrgkfq/rT4ijIMNFV6j3SnrvXt24+hFxTGFlORxReC2+TU9EcyFKsDNZhoVtOpB
         uthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758273935; x=1758878735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oB0ZWPbK+ZLVMGEIgwgPI2hlWSIgxfz6oD2rkNKtFKE=;
        b=ZNyUg/g17IRZWgZxDGSV4r7WXJQnX/C1BQHvwqN5IDIQZ+H6U0GkdKUR8hq7dAwX83
         Ad/0TKLxnzSWnE6/JZaBoLvonaAEZmY0psE9zR1g0WijhXJMBH4TCLTsW9rByB8rxoFG
         ZOL87mfpgZWW2wUG2tgqy2mr8jk47AeiGf1HCMIzXYCgXZGdG2R/vSGsFEvQ48OeO5Xi
         EyHByjbupRRxLybu45PAMtwMmi4KPEfeB+BTLl00TiGREx39SDMCowaxVFeHdXXwIU2/
         pZQID6bXxGIelQI3U6ofN3skZ7nVKw5ylcraCisXp/dLhlbmNtJv5Fwk/cKFGcFCZ3qp
         SX0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXX2bn2ES8Vn+gp9IWIEbVKc0ICg0qGCmMqlSeV1VffNUpMwqZd1HOj7P6pIf1CtIa6Vg27d6FeF7rbpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylw4BzHOgci4BLbN3QpwXKYQgPDDzdGwJBLKtSqCD2AucUB+vK
	oazuVuammc/PNGIcFwZlyizPyFSc0YBQTMKtDxfaZMmbhGd3MQIZJNEwQ0yFkldhg74iee+Vmlp
	7qmM1
X-Gm-Gg: ASbGncsi3kC2C+TbzjjJAmOFiBcZBSgym2h/JKUtTaW6Ew0UUpkq7mFzCBkT6L4fbGA
	ifpuLUaRfs/3UDJkYqHdcHYk7c7okMTym31y3buzK0tsuw+DO9sWUJYWMEwPVbFvxIrs6HzwXiF
	TqiSM275WP4NZGsf48WHVgEfYGAIxUF4Kmg/uaGDRrrWUvZmr7igrugd3KhAcV4M4hkChGVLRuY
	BIjj8mTEAEel+NxtLWtEogYqPbumUZc+m8XZPtn/3XoRLUeMTyXhKM+yaJx4FcVPLWI7p90qu1Q
	lRCtAENaj7XOu0FVyd7wd7pf0wyvvYnRe/NjpXAlBtugp3yt/3Fr2JGtsXjzxHHcbX9kb8JbALO
	XRHIFqT8v3kqubpiOAuzY170ij1EA0Z5vz/SrnHVAKwEWMVfunA==
X-Google-Smtp-Source: AGHT+IFddFvkF2BlBIc4LZkzrbMcxGq/6wzM3FTHdUvbu+vJro5USlOZqK6qwg7qJ92ZmKgdLsf5DA==
X-Received: by 2002:a17:90a:ec83:b0:330:797a:f504 with SMTP id 98e67ed59e1d1-33097fce4c3mr3315076a91.3.1758273935039;
        Fri, 19 Sep 2025 02:25:35 -0700 (PDT)
Received: from localhost.localdomain ([203.208.189.11])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306061925esm4958387a91.2.2025.09.19.02.25.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Sep 2025 02:25:34 -0700 (PDT)
From: lizhe.67@bytedance.com
To: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lizhe.67@bytedance.com
Subject: [PATCH] hugetlb: increase number of reserving hugepages via cmdline
Date: Fri, 19 Sep 2025 17:23:53 +0800
Message-ID: <20250919092353.41671-1-lizhe.67@bytedance.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Li Zhe <lizhe.67@bytedance.com>

Commit 79359d6d24df ("hugetlb: perform vmemmap optimization on a list of
pages") batches the submission of HugeTLB vmemmap optimization (HVO) during
hugepage reservation. With HVO enabled, hugepages obtained from the buddy
allocator are not submitted for optimization and their struct-page memory
is therefore not released—until the entire reservation request has been
satisfied. As a result, any struct-page memory freed in the course of the
allocation cannot be reused for the ongoing reservation, artificially
limiting the number of huge pages that can ultimately be provided.

As commit b1222550fbf7 ("mm/hugetlb: do pre-HVO for bootmem allocated
pages") already applies early HVO to bootmem-allocated huge pages, this
patch extends the same benefit to non-bootmem pages by incrementally
submitting them for HVO as they are allocated, thereby returning
struct-page memory to the buddy allocator in real time. The change raises
the maximum 2 MiB hugepage reservation from just under 376 GB to more than
381 GB on a 384 GB x86 VM.

Signed-off-by: Li Zhe <lizhe.67@bytedance.com>
---
 mm/hugetlb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index eed59cfb5d21..fd44690878a1 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3554,7 +3554,14 @@ static void __init hugetlb_pages_alloc_boot_node(unsigned long start, unsigned l
 	nodes_clear(node_alloc_noretry);
 
 	for (i = 0; i < num; ++i) {
-		struct folio *folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
+		struct folio *folio;
+
+		if (hugetlb_vmemmap_optimizable_size(h) &&
+		    (si_mem_available() == 0) && !list_empty(&folio_list)) {
+			prep_and_add_allocated_folios(h, &folio_list);
+			INIT_LIST_HEAD(&folio_list);
+		}
+		folio = alloc_pool_huge_folio(h, &node_states[N_MEMORY],
 						&node_alloc_noretry, &next_node);
 		if (!folio)
 			break;
-- 
2.20.1


