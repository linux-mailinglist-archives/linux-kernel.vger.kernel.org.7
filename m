Return-Path: <linux-kernel+bounces-780733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E11CB30885
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E77958804D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9012D837E;
	Thu, 21 Aug 2025 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fZvB6nlq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215842D7DF3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812513; cv=none; b=fgwXPI4Mu3NdYGNymQXeZskjT5HfPm6KGTMEjLfQfJ+mjqPMA0YPYtSXQzrRbDqlXac8LbeysbcKBWx3gdPR7W0SWlVogic1h7TVjPON9zD774KW4RsgLf7YEQv/x0H0IrlYsKDyANn+g+FI3UgEXmNTCdze7+lifnOZaUE0hwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812513; c=relaxed/simple;
	bh=dN2haf/5HOTLTD8G28EiqnCMdgRUmDTwnhod7N/s36k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2wnLaGJr2hHywvnv8MULmH8LYk4NgECUmTIAC+Ov6lOzW4VOAqDajeH//p4NEGS1g0mytaZiy1ySE2dhgM8jO7wNKmxTYUdoMLKaPpID8r+cLLLefWGjqdASP6gM8tV6TDEn9Air7JnFx3JLqq++TuCNpe9+KI58ZW9B3bYFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fZvB6nlq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8962AC4CEEB;
	Thu, 21 Aug 2025 21:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755812512;
	bh=dN2haf/5HOTLTD8G28EiqnCMdgRUmDTwnhod7N/s36k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fZvB6nlq1xfjgHLIGy2a+G5b3O1Vf62M+K3G0ySm9RFVhVvORhyqGntOIHjF2lyWq
	 CWD0h1c9HfC/YrcxGWGFKBRLIEmwWOhcAEoUnnFAES7bj/ZaQoOSZDIaRvVERvj6B/
	 jpwjmyqTh3ZrH/HGWqqw2WT/YwSPUQIj+ZUA07AzkzH0TpRESnpETMzjltIUSjhKD7
	 MAIfCiwHW9Ho/WdX5yxqi69kkBSvlnBnkIkOIetdrRHwmHSQnVPaLlZAZN4fsgT4eW
	 G3NUAf10RQpWUg18T/hTt/2U+H+c548KnRu/lwyBzf8koyJL6QLiXVBvfBGMelm7db
	 bfq7/OBLD1Xuw==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>,
	Baoquan He <bhe@redhat.com>,
	Barry Song <baohua@kernel.org>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu, 21 Aug 2025 14:41:50 -0700
Message-Id: <20250821214150.1911-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAF8kJuO7vQS3TB34dDZ6reTfeDpfSL9CNQqEwZWjZsGdhirs7Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 14:21:11 -0700 Chris Li <chrisl@kernel.org> wrote:

> On Tue, Aug 19, 2025 at 12:34 PM SeongJae Park <sj@kernel.org> wrote:
[...]
> > Historically, writeback disabling was introduced partially as a way to
> > solve the LRU order issue.  Yosry pointed out[4] this is still suboptimal
> > when the incompressible pages are cold, since the incompressible pages
> > will continuously be tried to be zswapped out, and burn CPU cycles for
> > compression attempts that will anyway fail.  One imaginable solution for
> > the problem is reusing the swapped-out page and its struct page to store
> > in the zswap pool.  But that's out of the scope of this patch.
> >
> > [1] https://github.com/sjp38/eval_zswap/blob/master/run.sh
> > [2] https://lore.kernel.org/20231017003519.1426574-3-nphamcs@gmail.com
> > [3] https://lore.kernel.org/20240706022523.1104080-6-flintglass@gmail.com
> > [4] https://lore.kernel.org/CAJD7tkZXS-UJVAFfvxJ0nNgTzWBiqepPYA4hEozi01_qktkitg@mail.gmail.com
[...]
> > +       /*
> > +        * If a page cannot be compressed into a size smaller than PAGE_SIZE,
> > +        * save the content as is without a compression, to keep the LRU order
> > +        * of writebacks.  If writeback is disabled, reject the page since it
> > +        * only adds metadata overhead.  swap_writeout() will put the page back
> > +        * to the active LRU list in the case.
> > +        */
> > +       if (comp_ret || !dlen) {
> 
> Looks good other than the feedback provided by Barry as well. Need to
> handle the -ENOSPC.
> Other errors will depend on your plan to drop this counter or not. I
> will wait for your next version.

Ack.  The next version will keep -ENOSPC comp_ret value so that
reject_compress_poor counter is not broken, like I replied to Barry.

> 
> 
> > +               zswap_crypto_compress_fail++;
> > +               dlen = PAGE_SIZE;
> > +       }
> > +       if (dlen >= PAGE_SIZE) {
> > +               if (!mem_cgroup_zswap_writeback_enabled(
> > +                                       folio_memcg(page_folio(page)))) {
> > +                       comp_ret = -EINVAL;
> > +                       goto unlock;
> I saw you mention this in the cover letter, so just to confirm we are
> on the same page. Current patch still has the issue [4] of write back
> disabled cases, the incompressible page will stay in the page LRU and
> possibly attempt to reclaim over and over again, right?

You are correct.  This patch is not making a change for writeback disabled
cases.


Thanks,
SJ

[...]

