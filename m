Return-Path: <linux-kernel+bounces-806864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7309CB49CD0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 00:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762383A361A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 22:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EB52EAB7F;
	Mon,  8 Sep 2025 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FZlhya5d"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23572D9EFE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757370301; cv=none; b=OTxnJ7JbyKmpU6IFyWf7uwytFz9FFze1SMUdMRDVhQt1h7RbMq85igxNov2pza4jgSwXk0k2gBEST/kA9hugJESkc8YUWbaIDwWd1Glr7QSKW1IS8dRVw5QtwsRUJ4aO3Xthltl4bTkRN6nAQQbt8DEhCxnzcCKyeq/a1EVQdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757370301; c=relaxed/simple;
	bh=BdczHDV3B3ZeupLMxai1XjM4O/IqMSbhh9GDyX4NZaY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HayFgIP/clFA3ZUDOHLykcgahlM8b/RbdDOGECyQ0pS4rcPJRCbm7ndT8Bw1ynG55vWkgcdTIysHJl6WmpAG4LDpsxx40tsjT8NSV7mtf/XE6+5FwPbv7Z3QGO5RdHRLXxiDrjnzSvgFJWHXhYLRhCpOemHF8KKA95Vms22atfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FZlhya5d; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e96e987fc92so4071765276.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 15:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757370299; x=1757975099; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rv8hMh0LMqevWYFZ+srlns+vtAjMl4A4z3f9Z1Buf8k=;
        b=FZlhya5da51rJMcBjRhOeBD/8Lqz872VYUGB6HA6JsoItDmsjTgPzZvCBpcZ6t0Mo+
         GvPbg1fwoR9vNO7y6/Yp2q490W1JXm4Gb69r0PG6GMLRccqqUtF/m6if2yQ1+j97kVlE
         SlfnJokC1GviymKcOlquFtLX/o2RVFa6I8s+XOu0BvlAfgfpfgw7MePZCSr20WySbdIa
         Obz4qaYuNOD3K3cO15pzm1h4BP0rZMHy4dgIOuBfklJItbn5/eBRzk6/NBpIBBuIwyCm
         tT2hGWQXRh45vzv2q7iWghwU0TkfAJqju+/E7I2/4w6ZWVS5Zd1lRiLq9sQe2K+AKYXJ
         3tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757370299; x=1757975099;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rv8hMh0LMqevWYFZ+srlns+vtAjMl4A4z3f9Z1Buf8k=;
        b=JGjNTc6r26vABv8Vt2//U0q2l3QwIs9uMcfjL9UdtdTulPn78GbtQS8L2aqvKjihZZ
         bdFTTAyBVOSIeyZUEOdgCLzbAux5QblskaIN8tozqt0oxrgNFjPVzS8gRfrOs311r7WM
         NYqFoPCYIXTg2H1zsetqwyejK2Z8hQAmTiWFvpuNUf3Qrjb/vlReGhxOd6cafThrcLPl
         Lyfj10wZu1g8c7mKXrFMhE9mosYIbt/be0Wl0OfIq/B2NAog9BT5obZ7JxwNv961z/m0
         EWL368Bg1ILmB1dKzM6trg++wIdZJN2aAfqSJR2DNsTcSmEwYhy8JogpJdGSjgHHqHps
         vM5w==
X-Forwarded-Encrypted: i=1; AJvYcCXVpQogv68yJFpJ5nSFulgYlngN9YIlK+A2G+k/Xh6XOARgxsOq19E+tVPi4iwysv7ekueih4EBM2xKtV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyDA7OnMv8AOYAs12whINnbyCP7bq34l6Lo3BrKHfK15VVqfAF
	gOd6rrBDvpR99eA7/YB7wG8NbILd4Zr313lJ9EMVePglNkd4J3/tsxOa+SORa2adHw==
X-Gm-Gg: ASbGnct+K/NzsCiztYHFGrGxon4F/9HaxjAEzGSJ65ckqLpn9hoDJOFKUPATHfVrv9f
	7x5GN4/hv40uE1N13wm/a18e4rJpYNftNZZv4JbkxUqD7q0ay26GKX3t+4OYHUMEGo7pomRHqAJ
	Ryv1wzBr9ZfDPDFjXKFBCrm281WzgzMicm804cLmf6aBeEU4c9b+Kc98yCtWbLhL9jAGM30GN9A
	C6J/TB+SuflC6MEgp5hpEdGC2sRvcAbP7MSQWcdb7DNMTumSJAeJrorjx0jn0+B0WNVvyB5mPeE
	ZbgtYowPTbjnXnDnRSp6+nkVoI9usyFDr6igTWH9ENK4EwFrh97sk1ICl+v+dAinCypiGEEg8fK
	BDmDNbY6D6Z53T1kbQyJ4goKmVV3dVf2BYOnwo/J1DWTrc78GKQ35uw5Ps1QrZbibicTDMpESK/
	ISEbjL+gaiqq+aKXTu8sgssMO6
X-Google-Smtp-Source: AGHT+IHz12RLu2qSx6kJKbJC54vlA6AVMAsAUr7Wd4XmRnv8FjgUsgD4d7k9E9m4cnAD0yWlnXIlxA==
X-Received: by 2002:a05:6902:27c8:b0:e95:1dc3:8838 with SMTP id 3f1490d57ef6-e9f66fca8a0mr9322667276.21.1757370298464;
        Mon, 08 Sep 2025 15:24:58 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-ea14b2e7ac4sm1647569276.35.2025.09.08.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 15:24:57 -0700 (PDT)
Date: Mon, 8 Sep 2025 15:24:54 -0700 (PDT)
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
Subject: [PATCH v2 6/6] mm: lru_add_drain_all() do local lru_add_drain()
 first
In-Reply-To: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
Message-ID: <33389bf8-f79d-d4dd-b7a4-680c4aa21b23@google.com>
References: <41395944-b0e3-c3ac-d648-8ddd70451d28@google.com>
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
Acked-by: David Hildenbrand <david@redhat.com>
---
 mm/swap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/swap.c b/mm/swap.c
index b74ebe865dd9..881e53b2877e 100644
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


