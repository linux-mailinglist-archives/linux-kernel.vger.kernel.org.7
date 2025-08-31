Return-Path: <linux-kernel+bounces-793290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 523E3B3D197
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 11:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EBC3165E9E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 09:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84BE24418E;
	Sun, 31 Aug 2025 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZNiKo4Sj"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11A34C79
	for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 09:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756631926; cv=none; b=eW06/JgISliEfKO0r/FWQrjOcjQStNvKTHHV/koy4bjcIaPKWlQV2PEONEdTuzKeZE3q1SrggQG1tjlELOz270O1ipxbIwlexH5DHn2T/6K0Hhz5V/PH44Y4OMDZe+zJTMkGbLS0RYTYU27g0p0sL/+AwwNfaidwFnfPJFHIdFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756631926; c=relaxed/simple;
	bh=+NuMP3LEn2b85FBHF78bjPjh3jGPBvBI0QJhiJVBQo4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=aAWN0R2dNfax0ldT7RgI/w9mH+0igG8RweFH+w8mTbeqs6mzEdwETvuCWqDUCXkoQWI0gdbXtQUA32/3jXiVZLELUXkRGkutBiz1J6Cb7dYFNGGu2sYwb1LTbxHq6/ZEc9RGNSoz0CGyDRBzefx1wStK8hgStOdRHt9Tkj2YwpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZNiKo4Sj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcab69so26906717b3.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Aug 2025 02:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756631924; x=1757236724; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wrk7aQbqVPPZjpKsq8t4LHCu/svkZR7eKtEEBTzldw=;
        b=ZNiKo4SjBddh6DbW7utMihAlHRqco9mBT4nP/t/eRtsxlZQSwgFxuGbz4vfrxxnXjx
         BNFaucOdyeqjvlH/IyYCjzGMCTUzHP9Wld4Jmk0hsLJ/cuT/PZxGcIjGv8vjK29X8n4S
         uyz0LlrjeA2acK9UdUb6N4+uhB0PLsAlzyd/CY8gi4YuRnTo60SkLU4McGxECouTjOl+
         GpvVhBaKhLFk7+dMaDfUuf83s4irCcpqJruBY88M9Z/klGrnx8mx3VXbPWMJgVqpeuOq
         3Rz/KyHfRiHRL43993nLUodayeiTDWxslHpTL/RpLax2zTnpxCF7Gfpn52/h0l0kZgXX
         TX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756631924; x=1757236724;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Wrk7aQbqVPPZjpKsq8t4LHCu/svkZR7eKtEEBTzldw=;
        b=vHUskB93bzh6el6Bl5ATZdYgmJIWuwyGWpF6Mc3yu/sO4qPMAHG7YVkNdcVegVJFFb
         BhKKSxKZxvN2hA4b43gzNR+tScnFQVtEGYs+CRBTL/vffDs6l+WyPf8cYTiqoyzqmyl1
         /A5GLeUAw3g03BLkuUesQjBLcb11WbmDJHPZ/KCc/0Sponu2Zs1Sd0adFLmHax4gn5Fs
         7WxKznJShDo8her7GTYA2RIxEyrkCyCZeoXsylvo+gHmq2kXqv4EoItiEhQBFEZrOW9Q
         l1sPyFkdpKHxzn+oichLk3EvlaXLjABTC5TuCzOIfQGXvpPWLO3WdgZKbDMETvyT+InJ
         gZhg==
X-Forwarded-Encrypted: i=1; AJvYcCUTOet9xbYigOvhgsIBydHJNu15J4e9OdTKeU9aOK1yyJ882UkELPpr9IPIKK2t49Dqj5LQX5Ne5hKgjpc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdHO1/tk2NhuN5eGpiNt4mlZq/HqnMqbEVRyCFS9UMwH5/JWm
	iWCEHCuxeaq5wXMITnWmnDeyl2BfiupmjcjH71N0Be6tRiVsPN+58jMFy36eNsGJeA==
X-Gm-Gg: ASbGnctPPGhrx2oUBYjg4KR5fOXB+qFuJ8oDdAdLysUmM+v3bKx99VQBb09Fr4iZJAd
	XNUclAbquBgnXeczrLQUOaIlIhp/R6fTci/Fe6udhhBK9a+pQ+B2PQIm8sp4lb2gmaRW0jgv1VY
	z0qc8QYDAPjG3Dv6ze0s9Srl19CxNBIWnaEnArYYT0X0MAd/82HBleMOI02+Y2T/6VIEKGCYF6W
	ng/gUtHiufIOBqIOpqW4epNrOzUvIqaAhOQlBce4q+nhyGXkJim8TKj27NCFI0q96ZgI3N79vUH
	nxT9VgDS23CbmL9lF2Wvf1O0ZPe18GfKOggqZtsgxOnxSVdBp387zdaUzisndkSZbA2DP4SLHNj
	+W0CAtBWJM9lzAwI8uyIImerxSiR4D3SGi4S5mH+AP2wBq5E1fU4aJagTkaDD1GHqBu2dOozqgE
	oB+W9kSnNL3flBKw==
X-Google-Smtp-Source: AGHT+IHx6UhN3JFnLmA4ryZLPJj6CdNI7qFb0bgmOG1cBhBLd0nyN429j6qnz3FhDBHZpgqIj4sp6Q==
X-Received: by 2002:a05:690c:9a0f:b0:70e:142d:9c6e with SMTP id 00721157ae682-722764f3c47mr40781987b3.32.1756631923476;
        Sun, 31 Aug 2025 02:18:43 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d8cc1c0sm7065297b3.34.2025.08.31.02.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 02:18:42 -0700 (PDT)
Date: Sun, 31 Aug 2025 02:18:39 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Will Deacon <will@kernel.org>, David Hildenbrand <david@redhat.com>, 
    Shivank Garg <shivankg@amd.com>, Matthew Wilcox <willy@infradead.org>, 
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
Subject: [PATCH 7/7] mm: lru_add_drain_all() do local lru_add_drain() first
In-Reply-To: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Message-ID: <c50129a4-a07e-869e-604e-3952f8530316@google.com>
References: <a28b44f7-cdb4-8b81-4982-758ae774fbf7@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

No numbers to back this up, but it seemed obvious to me, that if there
are competing lru_add_drain_all()ers, the work will be minimized if each
flushes its own local queues before locking and doing cross-CPU drains.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/swap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/swap.c b/mm/swap.c
index 17438fd1f51a..4951f4d35e40 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -834,6 +834,9 @@ static inline void __lru_add_drain_all(bool force_all_cpus)
 	 */
 	this_gen = smp_load_acquire(&lru_drain_gen);
 
+	/* It helps everyone if we do our own local drain immediately. */
+	lru_add_drain();
+
 	mutex_lock(&lock);
 
 	/*
-- 
2.51.0


