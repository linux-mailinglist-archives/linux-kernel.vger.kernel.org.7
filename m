Return-Path: <linux-kernel+bounces-774227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9529B2B018
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80349681B85
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 18:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F3FE2773FE;
	Mon, 18 Aug 2025 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGThcSp5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58024DD17
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 18:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755541083; cv=none; b=cNHYEudrG6vL+I/UP7Vv/BC1fB1UBujf5Blo14RAVB/WXfmd4j5JTFOmuQQlLrBnv/2Ae9Ou2Bjr0P/wO2Cq8AWwJrTXipoIylN2dKCe0MZ75RQm25ygRa7HfV+iTyoCBVgB4ZGzBCQmVk4yYV2pOA7bYGyXlODPVqnvhooqZFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755541083; c=relaxed/simple;
	bh=Si2VsEJ435Hpz9aDrpmWKX7tHYNWWnfoh3OSHQI95Lo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V697a52tJg7bptKdo59owNPF8CL45LdG3nhl3S9ehKYWtczhV11SGKm/JhMN28FHaJSiTKXKum2AstFfqwI2vmW+M/Y8tAvurRnUaQeoBU3YT2yJE+AKNy8H4Qy6wM37xrJrIClhqwtsC9GBK0YTV8QfCi4XAbBa/XljVSTz9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGThcSp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A39C4CEEB;
	Mon, 18 Aug 2025 18:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755541083;
	bh=Si2VsEJ435Hpz9aDrpmWKX7tHYNWWnfoh3OSHQI95Lo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DGThcSp5EmIH6OIMOMjHy5Sg+5LMsSPOLcKKceL23Y/OVokFATTs5cJKf92RMvu56
	 a0XGF/1YRoXq1FvcxPtc8A3Clr0Jl5z3JB7ycOMvDrbGHrIwYOGQUY7Z6+1swhcmts
	 hvkEvN1S8FFkFL4snSuIvPvSpCXWK6gS9JAnynaoX1kUJl/oi5ahZyxJwGo4Q6jkK+
	 QSWM+SP/HvkICyA8onfG7otTJ4eFby37lUIXgidh0CJdz3txJkOIJGU5kVnmhdZtAs
	 S4D6rFZD1J8LVmAxP1JtOy9mNM5amOc5owoUj2SBY5Fh4YFxdivYrFbwh9LcET+j6p
	 4x5kbQXeTStXw==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Mon, 18 Aug 2025 11:18:00 -0700
Message-Id: <20250818181800.59827-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAF8kJuPwfRVHpvNRr=1NT4z_3Pmr-1u4vfRYmkvh_Kh4uNGy9w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 19:23:10 -0700 Chris Li <chrisl@kernel.org> wrote:

> On Fri, Aug 15, 2025 at 5:14 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > Sounds good.  So in the next version (v4), I will drop compress_fail.  Instead,
> > I will add two new counters, namely compress_engine_fail and the new atomic
> > counter, say, stored_uncompressed_pages.  Please suggest better names or
> > correct me if I'm missing some of your points.
> 
> Sounds great. As I suggest in my other email, if up to me,
> 
> "crypto_compress_fail" and "stored_incompressible_pages"

Nice names, thank you!  I'll send the next verison soon, following all your
suggestions[1] together.

[1] https://lore.kernel.org/CAF8kJuPCpnGAoz=1CBwe46ytpcR0ZUMAEWLFQce7eUWkb+0ERA@mail.gmail.com


Thanks,
SJ

[...]

