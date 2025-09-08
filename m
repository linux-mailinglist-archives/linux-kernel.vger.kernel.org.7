Return-Path: <linux-kernel+bounces-806856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E69B49CBE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4CDC4E5833
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925772D94A7;
	Mon,  8 Sep 2025 22:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IRHDSvBR"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC2C1DFF7
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369820; cv=none; b=S3ggx3yLOeVtdnrdTA78fhI8uzDtBIo/LoMZPA+YZBloiGHUW/cdsYZZePk/Rhw0L9fn7f9ctnrQ75gYg7HwHU1W1A0nIDEo/bhFRChzUQQs6SAor1hb4nkfwPVgPjH0atw9t4PPmSZx2pZ1LuJacEz3z3hxQRQKFjjIkXmNlD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369820; c=relaxed/simple;
	bh=H42CHv/0ozdq1Ls2/9Wm26l9P0ywjQmPNMk/fPUfx3A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=e5dSz34x7c/uVFuWMLADR+1SDs7a7ezqp+QHTWQU64YSCTJRzTQareAyZDeHBaRb+ybHDpay3AS9Wy3rRegYkhUY78GdGP/LB0MCyBwaKSA31Hc//ieiU306sEp/qcbhPTPQ/dsGEw2GjrPzjzUn3bhwELWDvM1QvwBKIP1sI+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IRHDSvBR; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-724b9ba6e65so39316357b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757369817; x=1757974617; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zVYLSetMwrX/VynVtA83hBzGTxxW5OBc+rZUcVQE0NA=;
        b=IRHDSvBRZ3z0hjkZyZTJtNj2OshQ8Z4uM0wIzui3vNc624IOBNYUHFNQSUmjhJFmW8
         Yds8MevmmwVpuyNm+8y64No2X76dNKfIu/z6ytPs6Krx/ctSro7N1wNBs84vLT0MmmIt
         SHoO/VlfMLJ+evs8fao1KgT/znW8UNpYp3KifgioJIVgiA5M6xTHWOTHSWiKH/wfB9xz
         OP7m4K+R/pIDzjvG75lhzjMSoiB0ydQZDKIOo2F/14E3l2+uSS1ZayHbSb+byI0nPQUG
         hmneh9tymyc9m6bkLsEWEmjteNw9SKWrwgIQgo2mYu+x92DRqI/gZe2qpa/VpW3yXp0o
         Lodg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757369817; x=1757974617;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zVYLSetMwrX/VynVtA83hBzGTxxW5OBc+rZUcVQE0NA=;
        b=WxKFK7E/YidjSuLL21J0N050CSXV7x2atewGFvs0/xRSI1d/4/SncY2KT9l7DGoCLZ
         ybLqGs956zXNp0yfnfiMvWOUC98enidV6bPdkR4JLLBF5jsKX4jPiRgmTSmvDyA7ca7M
         v/uY/PQZcRRKVxa6cmOR0ieBjoEjGgrSIwCRzRdR6jTvlS1bVY7vav4CCfzFRxPMVJ+o
         Fgct7/Bm0clnwAbHrhqMt20/3xm6w/3mzxkRis9Hu4Lm3ONWD3NjSxZS+iVtKL/Grs4t
         gW7ocx10PxOKevvIQgdmVcn2+BqUMN6XUNC55aEv8jKCeWrlDMN20ZKxS62G8Xr/cKU2
         NdPg==
X-Forwarded-Encrypted: i=1; AJvYcCXM+dXXIwHA0IFZhHStRwu2unP95Ccf/cWhD7szu/llRXW8MZGM7IBurVSwG10rRW78yaVzFwKXxb5+bRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj5Zb2iameanP+hjns7xoa5WQ+pHHzSfvYzBDjaDGHplmMSWB7
	b6LL8jIvLgqOd5a9YGZ47qw66ORZT5LxlbyUqbWaDRHDe23068+cEsUVhs080c/l5w==
X-Gm-Gg: ASbGnct2U/v0rQ2gJj4LqVASjfbyRcS0e4fw5ppbTvUNswuWObZ3d41UF1spcy/J1tM
	dTC4B0TCmKDfcy8aI2rUhGDoZxVBcIiMICr341pF33eIjGoRyMR7qp2X1+iJWnoqBDwAWIpYAhj
	FZZ9fjK2mmKKxzc+0gssP3j7DGdeSnqvu2J76UWf6HB/GK6rFkEcs6StbAK6SmhxiS/raj5oGKS
	4ca6BfkLiFRGYWuJF1Lm1ABGO29DUC+oRfhToj2t8jMIloCBYQOIYC6QUS5gs6BnUNvoGxnma/T
	wsY9DaYggLsbEqgXusl5vSE5xFSv6p8D+747naMBS5wghcyQEvzZHSnbk/MhHfatS8rKurywfh/
	1GpTdn1CFqtBAh4KYx/Jjr0qlU+ICJ3KL+TAzViTQQu6Zfkk9ZGtOQXYfG9ogLWJubjYS71+Rpn
	stNO50Nzovo8ez2gxEEoeFeKbH7RCT
X-Google-Smtp-Source: AGHT+IEFGtIXAPyyGQ3/HR/zcX4Kvh/xfXBtsgo7O+saKjkOvxNMfjk5bY+RsPrpYJS0IY8LbDuMMQ==
X-Received: by 2002:a05:690c:4d88:b0:724:2cad:8df6 with SMTP id 00721157ae682-727f2ebd695mr84968267b3.16.1757369817188;
        Mon, 08 Sep 2025 15:16:57 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-608110cabd6sm5167388d50.8.2025.09.08.15.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:16:56 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:16:53 -0700 (PDT)
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
Subject: [PATCH v2 2/6] mm/gup: local lru_add_drain() to avoid
 lru_add_drain_all()
In-Reply-To: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Message-ID: <66f2751f-283e-816d-9530-765db7edc465@google.com>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

In many cases, if collect_longterm_unpinnable_folios() does need to
drain the LRU cache to release a reference, the cache in question is
on this same CPU, and much more efficiently drained by a preliminary
local lru_add_drain(), than the later cross-CPU lru_add_drain_all().

Marked for stable, to counter the increase in lru_add_drain_all()s
from "mm/gup: check ref_count instead of lru before migration".
Note for clean backports: can take 6.16 commit a03db236aebf ("gup:
optimize longterm pin_user_pages() for large folio") first.

Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
 mm/gup.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 82aec6443c0a..b47066a54f52 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2287,8 +2287,8 @@ static unsigned long collect_longterm_unpinnable_folios(
 		struct pages_or_folios *pofs)
 {
 	unsigned long collected = 0;
-	bool drain_allow = true;
 	struct folio *folio;
+	int drained = 0;
 	long i = 0;
 
 	for (folio = pofs_get_folio(pofs, i); folio;
@@ -2307,10 +2307,17 @@ static unsigned long collect_longterm_unpinnable_folios(
 			continue;
 		}
 
-		if (drain_allow && folio_ref_count(folio) !=
-				   folio_expected_ref_count(folio) + 1) {
+		if (drained == 0 &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
+			lru_add_drain();
+			drained = 1;
+		}
+		if (drained == 1 &&
+				folio_ref_count(folio) !=
+				folio_expected_ref_count(folio) + 1) {
 			lru_add_drain_all();
-			drain_allow = false;
+			drained = 2;
 		}
 
 		if (!folio_isolate_lru(folio))
-- 
2.51.0


