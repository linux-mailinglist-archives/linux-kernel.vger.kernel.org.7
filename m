Return-Path: <linux-kernel+bounces-780320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FEFB30064
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 18:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E212C5A1C97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452882E2F0F;
	Thu, 21 Aug 2025 16:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtigyZr5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A152DFA2A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 16:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755794577; cv=none; b=iBthLyY9muPR+a+ZQfseFtSNHaoyR84DSMvb0fnV2GxCTEGmVsYPwFSX4K/KL9F++oXTSHVVCLin0uQojM/ZimNne6VCUCmA2wgMFXnl7VjNQkgjOc2uu2b+hm2c/dCKk+4vV/GuuAzGZPzjCfWe5FNBMTprkL8LMydUHtIzf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755794577; c=relaxed/simple;
	bh=+7mhn9TtTfm/kyXTVM/gPpkPWNTyUYagzUfpYWDVCno=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SDqHx2JEAXLzvYbjz+bpta77udBYffto0tLsWctwxwUrZlTc6K+nra3Lji6g/yEkS6UPfTLOSPYaMbJibomd0yvAXcZfSoOpfZk3+leY5glGz0xv1q3Kd58p+dR9skcVYDIb0Lyy2aFVlH0Zk6/e1dNTgClmpZa7sU+jgdqhnRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtigyZr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0797C4CEEB;
	Thu, 21 Aug 2025 16:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755794576;
	bh=+7mhn9TtTfm/kyXTVM/gPpkPWNTyUYagzUfpYWDVCno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtigyZr5UtnLZHybJXh+Bmm2p4gSlJQ0+l5TzEB8yopkOAr5ZxK3Hzbywf9nU41LS
	 H4JuCSgzb/6x+rV7uuuDiU0d+Azyp7qMHIr2NyCpoRanWpXM3qNxmuX3UR0gSYSCQ8
	 EgO9BPEGAjAPzl5oAF87lTunOEosNg7DI9JjVwGZOwf1P/K3YOkcQYriJPzwUz9iZw
	 5kEjo68MIHENuqtemNC9786yK0I75BN5i3jCjQUdJBvlnbrJuKI5nHFdReLvgjJn2D
	 YZcym0uBv6nrkjkfjFnLkscUgzqoI4xA1gQWBtILJ/SB+BDygvf1Vsr2crkSHL/y9m
	 gh03F2HfSasFA==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu, 21 Aug 2025 09:42:55 -0700
Message-Id: <20250821164255.78596-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGsJ_4yLDLvOZ2=3iVcQhu2jnbWQ+iTQsqVefJsx4_YT4bnEZg@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 18:27:52 +0800 Barry Song <21cnbao@gmail.com> wrote:

> On Thu, Aug 21, 2025 at 1:33 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > On Tue, Aug 19, 2025 at 6:37 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > >
> > > On Wed, Aug 20, 2025 at 01:34:01PM +1200, Barry Song wrote:
> > > >
> > > > We might want to revisit the old thread to check whether it is now safe for us
> > > > to move to PAGE_SIZE in zswap now.
> > >
> > > It's perfectly safe as LZO was fixed months ago.
> >
> > Perfect. Then I'll revive Chengming's patch (see [1]) to reduce the
> > compression buffer :)
> 
> Nice!
> 
> But perhaps we should wait until SeongJae sends a new version that
> addresses the counter issue?

Is there a reason to wait?  I was thinking those are orthogonal problems?

Anyway, for the counter (crypto_compress_fail), I don't have a strong opinion.
To my understanding, the options for path forward are...

1. remove it,
2. keep it as is, or
3. keep it, but account only -EINPROGRESS[1]

If I'm not missing other options, I'm tempted to the first option (remove it)
since it doesn't change any existing things, and we can revisit later.

Please let me know if I'm missing another options or you have other preferrence
on what option to take.

> Also, I noticed the following code may
> have problems with the patch:
> 
>         if (comp_ret == -ENOSPC || alloc_ret == -ENOSPC)
>                 zswap_reject_compress_poor++;
> 
> Can we still reach the code comp_ret == -ENOSPC since we already
> handled comp_ret by ...
> 
> +       if (comp_ret || !dlen) {
> +               zswap_crypto_compress_fail++;
> +               dlen = PAGE_SIZE;
> +       }
> +       if (dlen >= PAGE_SIZE) {
> +               if (!mem_cgroup_zswap_writeback_enabled(
> +                                       folio_memcg(page_folio(page)))) {
> +                       comp_ret = -EINVAL;
> +                       goto unlock;
> +               }
> +               comp_ret = 0;
> +               dlen = PAGE_SIZE;
> +               dst = kmap_local_page(page);
> +       }

Nice catch, thank you Berry.  Actually there was a check for keeping the code
reachable, but I forgot keeping it while updating the version from v3[2] to
this one.  I will make below change on the next version to restore it.

    @@ -992,7 +992,7 @@ static bool zswap_compress(struct page *page, struct zswap_entry *entry,
            if (dlen >= PAGE_SIZE) {
                    if (!mem_cgroup_zswap_writeback_enabled(
                                            folio_memcg(page_folio(page)))) {
    -                       comp_ret = -EINVAL;
    +                       comp_ret = comp_ret ? comp_ret : -EINVAL;
                            goto unlock;
                    }
                    comp_ret = 0;

[1] https://lore.kernel.org/CAF8kJuPPsLzWu8+xm2A_UPHMBhb7OTjJNErM1Kp3hPmvHXNDUQ@mail.gmail.com
[2] https://lore.kernel.org/20250815213020.89327-1-sj@kernel.org


Thanks,
SJ

