Return-Path: <linux-kernel+bounces-806860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84AF0B49CC6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C2CC1B26A07
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFBC2E8B77;
	Mon,  8 Sep 2025 22:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BZqkNvXr"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCDD17E0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370079; cv=none; b=i33xuPk0Cmwv6QvZoOBEhJCZmrpUQe1P2dTi5TSAuGerLcJhDTJix2VTSdn8szmP8D3iLqyiH4DjE6hPrZq9o4fdEubfBPUb5uEQoelLb21ZhG2EZYdr5Hx2cfRrJIW1A3kR2Ox3AnS/AqKr8CUOBDXt3HxNrds9ma8PFgnUQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370079; c=relaxed/simple;
	bh=a1cTgHh2wNZem/UsEDdb6RrTDvlVPYb97vp4Xn8wEoU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=X5VmA7blnAGRPEEF5ykcwHnlmyHssbyHkFXMdyXABnfboB564PxmQfDgWv8HUzmU8Q5ODLnrZBbuKVZ9AjZjC2vc1kN7aUd5XAKLRvPcsp9+Zu7646tS5rF3vu7pTtS5e1J1/HoOs58556cWzu6bnBBNowL4veZvD/cqs4aTZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BZqkNvXr; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e96dc26dfa2so4157998276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757370077; x=1757974877; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=c9ddMlnJhgesFyfarJvyfx08wlzy1kwgyyy3+aP4EDU=;
        b=BZqkNvXrdhdVa3JRUfQgFntehnrmGrUuRTitqPvVFxXTKGmGwsQpIkwi/LzU1Jyi/z
         k0nV4r0SLsiRsyY9JJ9HTEiCnxpqEcprvDqEev0ytC+jrkAM98Ys3W1t+pYKmQ4Ar2Ye
         vpcCocbwkv23v/x9DC++3WirsA99UX43BFZWHPiPswu/MzK0QTZhDzHAylMDoVkzmI78
         URRDptbCj4WVNwvPoKNDGZbkemQa0gzpDDqrcQwBkl41cFfQDeo6RpvK34S4ZayA7/MO
         hoa2PMjBt0LsRepJW4dy/VyLgu7XUz34B5BLM/n6awr5lab1Sobi4ZiiK3W4t/Q7fMzp
         F2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370077; x=1757974877;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c9ddMlnJhgesFyfarJvyfx08wlzy1kwgyyy3+aP4EDU=;
        b=pmjxb9aqevz7vvQeBjadVGh/MaQjHvhtHsq8vy9YXv5yQD6iEXD9d30hqnye1RiPRm
         qn2AOghLVU4mb7MuCDyZsXrGhuboGQjAPXssFiBegeDYi2wBNwDevKOI/zCw1cNRpe+I
         t7VYTrdD/XKgN0Y5lI5EOyiUtSjeZec81hdwvB2yHapq1JdNoe5D0WATwN3oA/QS3P53
         G5OWDzfk/lKc9imu7DWWrDNtVzBWTdko56gfHT5b6PaA9oZlkyE78HMgjyrcc5yqgPol
         sMAAxgfdM09qCb++xMYfXOrhyzuUwcDzHWxEVSWyqNa+JJhD0+HPXo/kjzugRsJTI44k
         U1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEhwwU8rfvuJXIXmz4QDneD8tDvhNHHsz3Lb+384gW3jWe/L1LjcNAVdS2TDtSg93EHcgBME4T4jdJTKU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLQJX9w2SD67VkjIEyME2iv8kgyu7S2OQU0c5yjfEAo2l86veQ
	RICc/VnApCmjvexJ7917Ma/ymYGB66DPiNM+KwoiBNWONSas7ui98ESRHDMZytXcSA==
X-Gm-Gg: ASbGncvVau9D8osdHUMRqKixw1OifCGwVb42AAfrpNPNBxVwNGgYHlzUQXdsvV2mcxF
	EpAQ5FQRKVpzYfnYPXOssHuOcwrZMBLbHQcnRNu3qGiaDx/LnRgKITR96M55wEPuT5MBEFAFX5j
	tUpLboJWTUZaTz+TQggiXyWCd2xO44ncDrFc1yvMiuLCVTfG2AA2yoV6P0qFe1xpngMefoTo8Xc
	egaWrFvaHJjWKw8Py5WTxYTE5Nm1Fg2qz8iwRnQEzB4fxLTD81ulE4bRBLK4Yxoxom/CbMX5f8f
	cjIVgozjM/FpwENIm6L+/rH2ENOErWLVLbe/ysSWVQWTCfe7gS4ajzGalMw8xIkMKYUfRpxOxU6
	g9KvMzx6shjt5srQ3exmyfRB0NNcMLSh7jcacGBDc0nB39KWbSfxtphWhABwZIZhPdchiEyHYZT
	0STnBASdU=
X-Google-Smtp-Source: AGHT+IGM8fYhE9A3qchntfUnqur0lqvaNoCalamMqRl5+gg2Onz6zfisAMxx2108yKC4pC3/UUNzNQ==
X-Received: by 2002:a05:6902:4282:b0:e9d:6879:5fe3 with SMTP id 3f1490d57ef6-e9f67ea672emr7444113276.39.1757370076366;
        Mon, 08 Sep 2025 15:21:16 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9d4019d53csm4681153276.7.2025.09.08.15.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:21:15 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:21:12 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Alexander Krabler <Alexander.Krabler@kuka.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Axel Rasmussen <axelrasmussen@google.com>, Chris Li <chrisl@kernel.org>, 
    Christoph Hellwig <hch@infradead.org>, 
    David Hildenbrand <david@redhat.com>, Frederick Mayle <fmayle@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, Johannes Weiner <hannes@cmpxchg.org>, 
    John Hubbard <jhubbard@nvidia.com>, Keir Fraser <keirf@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Matthew Wilcox <willy@infradead.org>, Peter Xu <peterx@redhat.com>, 
    Rik van Riel <riel@surriel.com>, Shivank Garg <shivankg@amd.com>, 
    Vlastimil Babka <vbabka@suse.cz>, Wei Xu <weixugc@google.com>, 
    Will Deacon <will@kernel.org>, yangge <yangge1116@126.com>, 
    Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 4/6] mm: Revert "mm: vmscan.c: fix OOM on swap stress
 test"
In-Reply-To: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Message-ID: <aa0e9d67-fbcd-9d79-88a1-641dfbe1d9d1@google.com>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

This reverts commit 0885ef4705607936fc36a38fd74356e1c465b023: that
was a fix to the reverted 33dfe9204f29b415bbc0abb1a50642d1ba94f5e9.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: <stable@vger.kernel.org>
---
 mm/vmscan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a48aec8bfd92..674999999cd0 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4507,7 +4507,7 @@ static bool sort_folio(struct lruvec *lruvec, struct folio *folio, struct scan_c
 	}
 
 	/* ineligible */
-	if (!folio_test_lru(folio) || zone > sc->reclaim_idx) {
+	if (zone > sc->reclaim_idx) {
 		gen = folio_inc_gen(lruvec, folio, false);
 		list_move_tail(&folio->lru, &lrugen->folios[gen][type][zone]);
 		return true;
-- 
2.51.0


