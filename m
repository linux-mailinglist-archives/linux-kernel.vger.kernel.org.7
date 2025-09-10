Return-Path: <linux-kernel+bounces-811087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 097EAB52443
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 031787A81E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 22:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A02F3C35;
	Wed, 10 Sep 2025 22:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MN9wBiof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B011A83F9
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 22:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757544060; cv=none; b=bnvojMQ+dCGC7fyKsGOUznH5V1QQGFX5hjEBZm+ksBR9aJGSK1OvJZ4GobMdiH5tqMk+YbE0GrbF8+v1ubso3TTrixT8lc98UtDuREiHfN6u/FizFhCMHi6nlXjbOrtoiXsxbhyhvEzkzeNfATDr5fH8BsS6Guv4zSfRIooVWhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757544060; c=relaxed/simple;
	bh=TMJqa8O8IQsauMof+lR/u1sGz9Yy4baUV6tf/oB6K5g=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RcJW63zyukUN0ebMu8jnDSILkqPE8y//NU0CnPnKFr3azC3/9kIKbsr0Sk9gSmYNebPM8wEY0B6V+ImlpO2dd+jCjhLmXmG720E66DnT4PryhuXdo2dPycBnVprN/Kpcx8HQTBQKCt/i8j8zmrwxpBQ58L1D/tFIisuDXiMY++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MN9wBiof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B79CC4CEEB;
	Wed, 10 Sep 2025 22:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757544060;
	bh=TMJqa8O8IQsauMof+lR/u1sGz9Yy4baUV6tf/oB6K5g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MN9wBiof4cTGyl3Cc2xv1mj4goUe6R7u5v+Ite63exIxpE3VTY2FG4t3t1YBSfzI2
	 OGpPMqUnWkxwZtepa1IrS7MOMT/b8ukY/7RxyH8XKk/GiyJOWoZShrmVrhBM/WwgNl
	 kP1s8uL1xiEqg5XgPwIS67G6HkJvaCc2GjTaXHU4=
Date: Wed, 10 Sep 2025 15:40:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, Hugh Dickins
 <hughd@google.com>, Chris Li <chrisl@kernel.org>, Barry Song
 <baohua@kernel.org>, Baoquan He <bhe@redhat.com>, Nhat Pham
 <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>,
 Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>,
 linux-kernel@vger.kernel.org, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v3 00/15] mm, swap: introduce swap table as swap cache
 (phase I)
Message-Id: <20250910154058.5947c4b4ff6dac6cc4f89007@linux-foundation.org>
In-Reply-To: <20250910160833.3464-1-ryncsn@gmail.com>
References: <20250910160833.3464-1-ryncsn@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 00:08:18 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> V3 changes:
> There is basically no code change, mostly clean up and comment changes.
> - Renames a few variable and functions [ David Hildenbrand, Chris Li ]
> - Move the folio_matches_swap_entry check under unuse_pte in patch 5
>   [ David Hildenbrand ].
> - Remove two redundant function params for the folio replace helper in
>   patch 10, and add comment about folio setup [ David Hildenbrand ].
> - Move the shmem clean up patch after the API rename patch to fix build
>   error, no code change. [ Baolin Wang ]
> - Fix build error with !SWAP and !SHMEM config. [ Klara Modin, SeongJae Park ]
> - Fix a few typo and blank lines [ David Hildenbrand ]
> - Minor code style change [ Chris Li ].
> - Fix documentation warning from bot. [ Chris Li ]

Thanks, I updated mm-unstable to this v3 series.



