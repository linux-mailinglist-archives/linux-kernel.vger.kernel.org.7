Return-Path: <linux-kernel+bounces-793280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631C4B3D182
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005233BDE38
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441D239E88;
	Sun, 31 Aug 2025 09:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MweJnoqR"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76518EB0
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756630883; cv=none; b=mtrGm+o6NZJ+jkGuyauYKoVTyXVqSUQCqq074f9zlVWMZiAGk+dCtuyK1165KaWbmprtiuSCT0qHG3yV8desaOP7HofiKwHVyBTtdBtmJ7kTkfEiWNVGIyy+vEXK6l5SACUMIeCGX5swDV1JPwiws1UOZ6I4v5ubbrZWBPgWMck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756630883; c=relaxed/simple;
	bh=Uf1uVShRR8vNo6b19Nwa8ZjRQHJBlZANUYBbgbNySJc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tWQLGuSpaHf0url3Hoi+C9XKORbl2rMksJtKqZ4Iy3j0Bdmgzd0ycp5rZms4BBURfrz8Ura27l63F1Hi6T2EjJlqgvYg3GcoQKg9WUnYe/YAhIAu7+MGOtiLBfe1n5bR4O7QRN+xVN+pe/jeIpKl7ST7A10DQO0PTci1nBPs1+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MweJnoqR; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e970acf352fso2726689276.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756630881; x=1757235681; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzarj1jXPwwihpFc52AKHrUnyJlvNlaBP1cTsUIn51w=;
        b=MweJnoqRJCCnU4EZSExqdmuCUvE5cCEpoGJHVkXdz2mZj5Y8P7QIsxuXTMy08lbWpd
         5tZ2JjQ07dDs3TvnT3ovKhox7+C/bohaDU4hy8NMKq+gmqiuCstkgliSd6IPdQrZtvii
         Z7e7sjHzEhGUMnycDDOssHOmfIkNZK+UyL2URKnMQXIGu24nNBjolRyAeNWJ4DC+VgEw
         clModHgajeAZYFcGR+fV+A2YUkcL/yURsX+sgjuublYS/pH87xszyhHLcwLEa1RBrr2r
         10yQQfxnZrJax1CJtwbPoE2pHJhupiH9rwlG+5AOFWvrwROZjX5geGejJ04FVWdGxGKr
         wGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756630881; x=1757235681;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xzarj1jXPwwihpFc52AKHrUnyJlvNlaBP1cTsUIn51w=;
        b=o9lHdwHU1rjh0O22Pz7plixP2DfsAbh3+xYc1jB9QlUJWvKGNopK7fgZlDhJjZ0Y4I
         F7ugMkCb6D/aGrpA/GPi70nkUqEdTAul/EvIarlRWw9g6Xq3DOEv8qnUNqlNjw4iMSfM
         2hfwmV1VbktU3HTFsv7XfQPUGukdrOe7OtYjroimPjZic4/alYHcDIQAXrv7FPsT+O4m
         Jf2YIOU6A9X1U/KSE3DUMJ2J10HZgZ+cGxkYN9TC3MSVhkLf0bA20Q72gSMKT3E8+eTq
         mYkQSNsJ2fz71+QsVG0v+erdRLKs2NROkQvaCDHBaKkyN1f75/SJkxZ3DhahoiwFzjHe
         eiVA==
X-Forwarded-Encrypted: i=1; AJvYcCWiha1NM1ulM+0ETRmxmBi+EM3y/Hjugxwsior5EsGIEm8vonzkafvBWDa6eB06ceTG7ahnZe5L4nw2zYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQUVqHDZDE2GjJyZ8HH+8BFZdeS4jMOz/wjr7EqN1TzgkiwwS
	rKhqgBSjFQzXlOg8pkI2BSUQS5QLm9Sca8/cz9D3PstwV7sc8n6Qrw8ts0j8TqdGkw==
X-Gm-Gg: ASbGnctwb/mRgnGTKB4U8hpQxutiv8A87JP2QwfjGcjGzzfVH8f0uKdUKvIK3EwPlet
	K6dMkASOLadN46ps3GdrMfV+42QYzbOrKqOtnZ7sZ4D/9YSXKePA1GVME8v1zdqbeNyhpehQCk1
	2ggmHlWoclUNK/YzIOAr6y01Yo65ZB6yKe4yFYgi64pHtEqgalQH8LnK7HhhxG+RgemOw2p2TL4
	apuf7MHgDhTsmyVD6Id/AXVZ4hQlRFnxA/0FhZSXkgl3FPq5NrZK11Lt0yxUgKdpBcyIutALNXh
	vT2mEQmdyRkyyWB4HXXH3FRNkwnq/8sfY4rMk9QzLFj7FT/v6TkCXjJUnD5x+m0WMzVvbbov6XZ
	B/HngE7XKOcgy5ebzuEU8g1ojtcVYhzMbLkmZYwffCURShATpIrDubUBzhiutzQ5i5a7ubz9al2
	6JW0pl4T+tl9y9Tw==
X-Google-Smtp-Source: AGHT+IGpRZTOsrv6OWnEdL6eZ2XWJIrkP0gSOahOzxZcUPGdu6xAkpdJXXS2GNMzOEVXcPVlQWvbAQ==
X-Received: by 2002:a05:6902:158f:b0:e97:276:400d with SMTP id 3f1490d57ef6-e98a583baf1mr5704848276.36.1756630880977;
        Sun, 31 Aug 2025 02:01:20 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e98ac4458c7sm985933276.8.2025.08.31.02.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:01:19 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:01:16 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: David Hildenbrand <david@redhat.com>, Shivank Garg <shivankg@amd.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Christoph Hellwig <hch@infradead.org>, Keir Fraser <keirf@google.com>, 
    Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
    Frederick Mayle <fmayle@google.com>, Peter Xu <peterx@redhat.com>, 
    "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Alexander Krabler <Alexander.Krabler@kuka.com>, 
    Ge Yang <yangge1116@126.com>, Li Zhe <lizhe.67@bytedance.com>, 
    Chris Li <chrisl@kernel.org>, Yu Zhao <yuzhao@google.com>, 
    Axel Rasmussen <axelrasmussen@google.com>, 
    Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
    Konstantin Khlebnikov <koct9i@gmail.com>, linux-kernel@vger.kernel.org, 
    linux-mm@kvack.org
Subject: [PATCH 1/7] mm: fix folio_expected_ref_count() when PG_private_2
In-Reply-To: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Message-ID: <f91ee36e-a8cb-e3a4-c23b-524ff3848da7@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

6.16's folio_expected_ref_count() is forgetting the PG_private_2 flag,
which (like PG_private, but not in addition to PG_private) counts for
1 more reference: it needs to be using folio_has_private() in place of
folio_test_private().

But this went wrong earlier: folio_expected_ref_count() was based on
(and replaced) mm/migrate.c's folio_expected_refs(), which has been
using folio_test_private() since 6.0 converted to folios(): before
that, expected_page_refs() was correctly using page_has_private().

Just a few filesystems are still using PG_private_2 a.k.a. PG_fscache.
Potentially, this fix re-enables page migration on their folios; but
it would not be surprising to learn that in practice those folios are
not migratable for other reasons.

Fixes: 86ebd50224c0 ("mm: add folio_expected_ref_count() for reference count calculation")
Fixes: 108ca8358139 ("mm/migrate: Convert expected_page_refs() to folio_expected_refs()")
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 include/linux/mm.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 1ae97a0b8ec7..ee8e535eadac 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2180,8 +2180,8 @@ static inline int folio_expected_ref_count(const struct folio *folio)
 	} else {
 		/* One reference per page from the pagecache. */
 		ref_count += !!folio->mapping << order;
-		/* One reference from PG_private. */
-		ref_count += folio_test_private(folio);
+		/* One reference from PG_private or PG_private_2. */
+		ref_count += folio_has_private(folio);
 	}
 
 	/* One reference per page table mapping. */
-- 
2.51.0


