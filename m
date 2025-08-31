Return-Path: <linux-kernel+bounces-793279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 056ABB3D181
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 10:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65C821899408
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81CF241690;
	Sun, 31 Aug 2025 08:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZZwVMBg"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F8168BD
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 08:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756630689; cv=none; b=c2XHR47mlYGkVSb5Y9e0Lk73hQBr08lBzrZ65/+gDPztI+UpZV25L4I4n5A2v4gAif2UfEomhNO08lrLhgN7lSQwjicIai+Ka6WAS4cP1wgoKs3l35Cga1CvJ8xvtwgHHWFjoGjGKYBRlvv+4Dn3rjToEG7Jao90VHEzUtXtgYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756630689; c=relaxed/simple;
	bh=txjzteEVXWmv1xAz7pMtMwXfOUi4Gjskn09N5aoRED8=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=IAKQUva85jJqno5u51XktBiK265Jj5WlHWfu0FmvdHIaTmD5MR6jWN6yyYl8X7Ab//11BkIFAvpjfYjs2BZRRX8fLWGjBBHSjD+84JLvN80RFiv0jdgdJPaL8CgdtAqsxnpB3L6/YMAbX56ih5c6TNrQUkE6wbju4E+EhtA73c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZZwVMBg; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e96fbf400c0so3769560276.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 01:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756630687; x=1757235487; darn=vger.kernel.org;
        h=mime-version:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5ZeU6lVaTvKgctWHbYTWm3oYBbzhyHIjCKCjF1PmS6I=;
        b=mZZwVMBgEIdNSRiBGrEQ+VsUShrGF3/l4wjyA6WUMdkDGXLMUOBJwt57fB0wadt5Vz
         rLGvQ4drBM160oh0Xo5GCeRz8dV0ZHFvJnW7ZOPOJYbNFIjS1MH95W3bI91izyKVkhnL
         wPE5dii+ukbn7k2dzf2/ewHbpjxtdRQWDDPrj7NuEVuE6a6BCy4SzmzExbWChlIeD28P
         k31iNUx/VVQ76PZxamZCN/UOD8DX7PY0ubWsGg4MsOfAWBNUAQ+D+m72auOk8qD7ofWs
         DTfqrweKOnIOBvUB3XrgBcg02oYgkCHfjJCzE0Y6rK3REszyGFTz9UHh09cqD8VSdjFA
         vh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756630687; x=1757235487;
        h=mime-version:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZeU6lVaTvKgctWHbYTWm3oYBbzhyHIjCKCjF1PmS6I=;
        b=RUFKl05dZ0ZrXGJzrAEeJCnxnb8WF5z4u0TrTTtHp8IOREa58PXl2b/15UnI2v593j
         AdKnp2ojmKh20nYMngcQq2xV5CsMHLnwfmghqOWoZyQTTcMoeUAebRSM92FLhO/oU5za
         4hAcPeggxlTlgWHz11cLYOJhlCjM5YSGsxVhTHJcPn433wp/1syq+vmM8JWutW6Je9ab
         DUboEz2QchWE3EBVyortHXC/c4Nj3vb9cDNupEzVuZd8krwXoBtwZ+m2Wo4vZHZI+ows
         YL9ll3ym+HvWc13AOPWPmVKyZX6uopCpS4wJbzAf7wfWuMeHQ9bJoiHsGFVIejw0ASoJ
         Lifw==
X-Forwarded-Encrypted: i=1; AJvYcCXZ5bxsxp+/pPsdtUwCafPnxEaLoS00NQyxZ0xcyfPbakgcFChsEaAQD9S93xojoxpa75J9riP87gujhvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7TEyuRnATpzovgrxF8G8+XL+NuoAqVljR2yW8dnTF3sShfUVo
	gEVPwjFlOlES100gPSb+lYkaohgXyyKIPf89rw/9GQDHe2X0B13uDlBe7eBya4ON3w==
X-Gm-Gg: ASbGncs5l+PKrdE8Z7ETg1A/DVJ16R2Zl5VwIl37difbh5BbYbaWu9NGmCq1lzXd7gT
	p+MqN0GPt6/EtiLjaqKbAHEUR/dVnXNNBGgpuLbH8bAMYQXWaJe5jJIzUHNHle56RUQejLHU1h+
	VJWwRQ96rEoHCDEYEx/6QYtqjMkB51gqrKqhQvpJOiJvwXd85wwswjXuai8ixdtKYazcHDBszS1
	H4OA89x5gFh3TM7e+FkbvmOEMg79o3q5qo/2UiiHk1HEgbfsKpUQy3IKhtL4TM7qCEpokyKApMx
	hX07WD3/DiF4caMzcJA6vhg+yJmSnKjXmV0pKCyE83gi/i33PVmjzA93s/6FQZLtuJuqVOHwOri
	HLZdglQzYqdAHgrXX1zhFMn5fdK+nyJV/qZdp0UZ+Rk69ArGhI6XFJ7yM//9jjVzJE/HV2yasdC
	sCSLeXWo4MqehHCWRt8JUj4/SI
X-Google-Smtp-Source: AGHT+IEhv+G8RBUzMh+8oocyhb+0JLA1GHE6vZtzTByY9E4gGylLDC6UdEPNzNuUx9tTfYuRYvL8PQ==
X-Received: by 2002:a05:6902:100b:b0:e97:e05:3260 with SMTP id 3f1490d57ef6-e98a581adcemr4810208276.14.1756630686478;
        Sun, 31 Aug 2025 01:58:06 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e98ac57b5fasm973601276.24.2025.08.31.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 01:58:05 -0700 (PDT)
Date: Sun, 31 Aug 2025 01:57:50 -0700 (PDT)
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
Subject: [PATCH 0/7] mm: better GUP pin lru_add_drain_all()
Message-ID: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Series of lru_add_drain_all()-related patches, arising from recent
mm/gup migration report from Will Deacon.  Based on 6.17-rc3 but apply
to latest mm.git.  I suggest all but 7/7 be hotfixes going to 6.17 and
stable, but you might not be persuaded by "counter the increase" ones.

1/7 mm: fix folio_expected_ref_count() when PG_private_2
2/7 mm/gup: check ref_count instead of lru before migration
3/7 mm/gup: local lru_add_drain() to avoid lru_add_drain_all()
4/7 mm: Revert "mm/gup: clear the LRU flag of a page before
5/7 mm: Revert "mm: vmscan.c: fix OOM on swap stress test"
6/7 mm: folio_may_be_cached() unless folio_test_large()
7/7 mm: lru_add_drain_all() do local lru_add_drain() first

 include/linux/mm.h   |  4 ++--
 include/linux/swap.h | 10 ++++++++++
 mm/gup.c             |  6 +++++-
 mm/mlock.c           |  6 +++---
 mm/swap.c            | 53 ++++++++++++++++++++++++++++------------------------
 mm/vmscan.c          |  2 +-
 6 files changed, 50 insertions(+), 31 deletions(-)

Thanks,
Hugh

