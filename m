Return-Path: <linux-kernel+bounces-806854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F1B49CB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A9DD4445CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:12:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B872E9EA6;
	Mon,  8 Sep 2025 22:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WzrN3HAh"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F62E888F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757369561; cv=none; b=t7JLkINcMhyDk2WaEKYz4ay/e6ZIWkS6AzpgvVQBk0oiJC4WSpj4FHG02nqN7/eCMeWt/D6jr2y7SV52+Ma6AIIZ617WfHqxsOY9WoZo2DfcELL3o+cU0jk/lPyX+w3lbhZkcfgP4H6OkDhW4z8wq26os3xaGCSnlAArMv0oqk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757369561; c=relaxed/simple;
	bh=aW9TrZIZCm6w9hqqtXvopMP+o17f9SPySxa6MwJYh9o=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=s5/am4YJKZM9HWOZPWjuIG8TfppQTHWbzuoOci3mahHi/OR/pZfsBUAqvE0ghrYJf6VRuFy9nAtfA8YSLaK/hyNVQUvcPyoZbBcz5uNrLjpWC1NVeIYt/2DOBmRJtSXB/NQJrgnoAw/CL0E/dzFhKDGDSwd4JV55jV1t6b6mRCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WzrN3HAh; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d605c6501so44304267b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757369559; x=1757974359; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gNtbdDCHgk+DiPqbiXpsjFsPHOrdOzQKbMxRyjp9MVM=;
        b=WzrN3HAhk6i25N+7F92VYbQsPX2QJ/udpqaa/Cn3tA4FhNKu0byHG+wOszZ3Mm6W8g
         DBDecl3HSKKSK6K0hD8rJOdftBQadfkkQQjtsw5GR8Jt5wfpbfdOCd436OhGam2nWiMd
         kekx/WgKmaIajZhDsRE5G7k1jCmk4RcWhkUXnGj/WGekdAiPLLDC+ncjtpnmmu3zIG83
         kqhWm0C2nD3fOzLbDNFNggfSoBdSbw78AP6rYgu2dzxZ7rexsHQ/LIUCffoo7ZlsIffH
         PtTPrlgEYMXkoO6LjgKyciT1xeeU4xWE9oqi7gNYN02u+Xb4xC3ATY4ARrZQcOccKkWx
         Upmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757369559; x=1757974359;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gNtbdDCHgk+DiPqbiXpsjFsPHOrdOzQKbMxRyjp9MVM=;
        b=GotgkPTs6E452nscd/WZdE9qUx65Y1Eo499cfzKra3cAxoNNpKbcdsf2EH7oHKxr2/
         wayRf89eLpZpbIH8nPadFsRogjfIy8pNX3sTQbasRMsQDGXDxzypvwwdW2TZsW+KzRcB
         HO6F6RF3Cn012tSaYuirV43FSOL27r+9X+77+jdhWB2uM0FbPbH3FpMeBJ48/kJpjQ0/
         QhtGbZOrW0tJ0CSa+wyercbEZg2u0s3ybmxFQCDPlXSUVXb/z79bZnJrtrUsud3bNaaj
         fgoA/hAyy1gpcMMTuMvmeDiKbKd4Hpr3dGAML/kO2hF5G1sTTlB3yhKHEX1U5s3gmB66
         YArA==
X-Forwarded-Encrypted: i=1; AJvYcCVRd2uCqMxfpAeXwMJOAKHfiTMUnc9ulMNKZzUm2Q/At3tyBZ6aultOpDsOI/9rcTxyCduTTf+cgC+ovDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr1QuakHWTPh5TuplUaG9cfkbNqmKkXxv8qAmOMcIQ02K7JY29
	ri+liWqrzQxLO/pl9wzHcqmHUDrAqJNA7L0eiUYLbXxNyEqrdWwxCJsOu/ULPyrNgQ==
X-Gm-Gg: ASbGnctMLd+sxvdfc3cvSfRAXfyqdoONZzRkMkEQgE7lTOjF8N9VN+4ZSnmUHeyI3+u
	+TeuoA+0cWBTUAuJKTndOVhUX3pkrzRA41FWmQDHXXw+2WL2AGUkYUMI9Dnk5TiT1bIyOYcGyvR
	LNArhbgNyRo/y9FQ5pjBvio9VT6zZzQ2Tm3hLvfDMLmYV43/Wc+Q48r47EfthpVz9Kxk+eeXaVU
	vQOzP+L9C0ZQFC8KetF2hM5HD2K5nGqBYdlH8+oahqdFqx/f+6y3GTgCgE+OAvboKwu7wLnUwga
	77gKPM4tDuNR8hFjKldMAdVMipfyUrC29HgIkYJwlpUEdz7tWc5IsaOdjr0taS3iWsnee5UikJ/
	PFA7sy+nuUN5NMGorNR2si7AgExnMOHCuUelhuK/dBEXU20pmX+C6z3NwwjNKD9KzZvgFsXefAE
	Lyi+DdoP8=
X-Google-Smtp-Source: AGHT+IEcR9qj/dDVqywaUNohOEcHuvPXDWkQP4kYVA1b3P4MwbJPWFYGGqkq8v1AvH1FCx7J7AOhzw==
X-Received: by 2002:a05:690c:6087:b0:721:6b2e:a07a with SMTP id 00721157ae682-727f5f3e326mr79337167b3.51.1757369558683;
        Mon, 08 Sep 2025 15:12:38 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a85a0cd9sm56756867b3.69.2025.09.08.15.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:12:37 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:12:20 -0700 (PDT)
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
Subject: [PATCH v2 0/6] mm: better GUP pin lru_add_drain_all()
Message-ID: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Series of lru_add_drain_all()-related patches, arising from recent
mm/gup migration report from Will Deacon.  Based on 6.17-rc3 but apply
to replace v1 in mm.git.  I suggest all but 6/6 be hotfixes going to
6.17 and stable.

v1 was at
https://lore.kernel.org/linux-mm/a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com/
amd its
1/7 mm: fix folio_expected_ref_count() when PG_private_2
has been dropped from v2, per Matthew Wilcox.

1/6 mm/gup: check ref_count instead of lru before migration
    v1->v2: paragraph on PG_private_2 added to commit message
2/6 mm/gup: local lru_add_drain() to avoid lru_add_drain_all()
    v1->v2: lru_add_drain() only when needed, per David
3/6 mm: Revert "mm/gup: clear the LRU flag of a page before
    v1->v2: Acked-by David added
4/6 mm: Revert "mm: vmscan.c: fix OOM on swap stress test"
    v1->v2: Acked-by David added
5/6 mm: folio_may_be_lru_cached() unless folio_test_large()
    v1->v2: folio_may_be_lru_cached(): lru_ per David
6/6 mm: lru_add_drain_all() do local lru_add_drain() first
    v1->v2: Acked-by David added

 include/linux/swap.h |   10 ++++++++
 mm/gup.c             |   14 ++++++++---
 mm/mlock.c           |    6 ++--
 mm/swap.c            |   53 +++++++++++++++++++++++--------------------
 mm/vmscan.c          |    2 -
 5 files changed, 54 insertions(+), 31 deletions(-)

Thanks,
Hugh

