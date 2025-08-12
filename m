Return-Path: <linux-kernel+bounces-763961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9C8B21C17
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 06:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3F1467920
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 04:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA322DFA3E;
	Tue, 12 Aug 2025 04:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ORehQ+3V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCA2DEA90
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 04:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754972664; cv=none; b=MvCSVig2bSZMpmFcRiVlQ90UBKy/BAHJD0Kl2zr3bMbVFtX5ICtCv8Vdxr7G+lqQtkexM0RtsLKuLUYKTSGrPUtIh0Ozi2MKAUVVBIh5ibd1i72nggjDgDa2zVO5WdQvvtHuK4kcISZxE5U2+8nQOXSXqHvTFLVwRVl3ZCfDrHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754972664; c=relaxed/simple;
	bh=O9P/G1Ih8tTVtSV9YFM4J40omVsN3/KHtihc36JdYbw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=eLBXW4SiPacofMM5CXSI4646N/d9aO1S5NCr9FWU07ADXsgcBFhTeKriHMUTX7oCtcqgcknmMkeUSO9LHNKH8Lmy9cVEOT+r+hePKUgDkTD2/mYnr6R6hGuK2pV232S2giGAygfbys1/b9luf/ArB9fVAtx9tJtfKveqXehsRws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ORehQ+3V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEB3DC4CEF0;
	Tue, 12 Aug 2025 04:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754972664;
	bh=O9P/G1Ih8tTVtSV9YFM4J40omVsN3/KHtihc36JdYbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ORehQ+3Vxi69JooCCz4dg6o18FXa76u+r2DI44fok7luCDFxQFkUwP2U+B14cLtiU
	 jqyCJozhGoRtoMTZAiYEzJsTclsr+B4e0qb4b4Y1TzVpAGVVLfMELVz2xNfDazjlQl
	 +zsRFjh3ArCm4dxlxPi/06cR5uqhLDUfhKVQQJTY=
Date: Mon, 11 Aug 2025 21:24:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Barry Song
 <baohua@kernel.org>, "Huang, Ying" <ying.huang@linux.alibaba.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swapfile.c: introduce function
 alloc_swap_scan_list()
Message-Id: <20250811212423.5667183e69c373c1daf95ecc@linux-foundation.org>
In-Reply-To: <CAMgjq7DnniGUdpQQA0YF+LuMuL9+FCLQJP2Q04G_Hsd1sztv9A@mail.gmail.com>
References: <20250808-swap-scan-list-v2-1-d50e4758ecee@kernel.org>
	<CAMgjq7DnniGUdpQQA0YF+LuMuL9+FCLQJP2Q04G_Hsd1sztv9A@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sat, 9 Aug 2025 03:51:48 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> On Fri, Aug 8, 2025 at 3:48 PM Chris Li <chrisl@kernel.org> wrote:
> >
> > This the alloc_swap_scan_list() will scan the whole list or the first
> > cluster.
> 
> Hi Chris,
> 
> This sentence reads strange to me, but English is not my native
> language so I'm not very sure about it.

Yes, I rewrote this to


: alloc_swap_scan_list() will scan the whole list or the first cluster.
: 
: This reduces the repeat patterns of isolating a cluster then scanning that
: cluster.  As a result, cluster_alloc_swap_entry() is shorter and
: shallower.
: 
: No functional change.

Which is hopefully accurate.


LLMs do an awesome job of doing this, although one should carefully
review the output.  Here's gemini.google.com:

: alloc_swap_scan_list() now scans either the entire list or just the
: first cluster.  This change eliminates the repetitive pattern of
: isolating and then scanning a cluster.  As a result, the function
: cluster_alloc_swap_entry() is now shorter and less complex.  There are
: no functional changes to the code's behavior.

