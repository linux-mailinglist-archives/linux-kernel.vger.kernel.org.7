Return-Path: <linux-kernel+bounces-760880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDC2B1F173
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0A517A33E8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1DC1E1DFE;
	Sat,  9 Aug 2025 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLGz7YjA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D11E24B29
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754698711; cv=none; b=plRgio0Ijf1/e9eY8ExxA9TUOha+H4ZoYR/7QZkZD+cL0x6oFKXQ5ipTEFGJgMM4jWH4IjvJjGMeXEnnfyDFKuuydbC9tQKB53ra/E1q8AVMk7la9hIIWt2K9D2LhJ97QcLDn51VhUQ2R5h9MYvFnbZ0XgUeG3jKFVLUONdFSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754698711; c=relaxed/simple;
	bh=8doMMvey/cAn6n5o7Hp9cEa5vwfjbJoKSTQWo7Z5reM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qc8Q1ofz2YPgX/PX1N1MfsTjP1XcXZYshaJq93nOMkLtqMXRvNM9mEGJAlLveYjS18KLQKrHV+Kiq6ftEIl7HisHdQAwohozo1PtARz2yKAPjb3uJ7RqWY27QBUG9cCKMCw5m2ulneXXXmDNybVxQBcYn13GT9ufVP/JhO94NGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLGz7YjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDABEC4CEED;
	Sat,  9 Aug 2025 00:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754698711;
	bh=8doMMvey/cAn6n5o7Hp9cEa5vwfjbJoKSTQWo7Z5reM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QLGz7YjAk8ddG5N5SfJAwWnXN0IJ5tMZGuITqwd6OGIXH/3Zf9WH3B0Je3kq89oj5
	 1AyotAOAaRvrcV+aNCdDqZWtcQEYYfH59RTJgMnyWTBFDpyBYD6A8uj1bicNtogtXy
	 TaHoXKXXmBLqpVPF4Ey/JVh6H9iqOQshwyvO7npSrp4RMEFpmtTQaK4uiMFIPt1nd3
	 nddIUGgtvpirpJAhP2PV2bdZdlxW6/kvY5U8iiPVMyM/j0uGoyW1BqqWj3XsLEwaqw
	 88ntL7uHRXxx9oXpMQy6ZD0NoRQjceFmUlj39yplZTeUyJg9aSPfZ3qoW23NxO9IL9
	 0co8f8fl4JJHQ==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>
Subject: Re: [PATCH] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Fri,  8 Aug 2025 17:18:28 -0700
Message-Id: <20250809001828.51611-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAKEwX=NF-HBs_sMMm5v82SHFnv5SUrNjOR-=6KJcxQsNt=26Rw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 8 Aug 2025 16:37:15 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Thu, Aug 7, 2025 at 4:54 PM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 7 Aug 2025 16:03:54 -0700 Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > > On Thu, Aug 7, 2025 at 11:16 AM SeongJae Park <sj@kernel.org> wrote:
[...]
> > > Also, can we fix the counter value?
> > >
> > > I assume we want:
> > >
> > > else if (comp_ret || dlen = PAGE_SIZE)
> > >      zswap_reject_compress_fail++;
> > >
> > > or something like that.
> >
> > I'm not very clearly getting your point.
> >
> > I was thinking we should increase the counter if we "reject" the page (does not
> > save the content in the zpool) due to failing at compressing the page's content
> > into a size smaller than PAGE_SIZE.  This patch implements the behavior.
> >
> > Am I missing a mis-implementation of the behavior in this patch, or the
> > behavior is not what you think it should be?  More elaboration of your point
> > would be helpful for me.
> 
> Ah yeah, maybe "reject compress fail" is not a good name here. But
> sometimes I like to know how many times we fail to compress, even if
> we do save them.

Thank you for clarifying, that makes sense to me.

> 
> We can rename it to just "zswap_compress_fail", but that's breaking
> API, so it's kind of annoying. Maybe "zswap_stored_uncompressed_pages"
> suffices (see comment below).

The suggested name sounds good to me.

> 
> Johannes, any suggestions on what to do here?

+1

> 
> >
> > >
> > > And what happened to the incompressible page stored counter? :)
> >
> > I don't get what counter you are asking about.  Could you please elaborate?
> 
> I meant "zswap_stored_uncompressed_pages" in your RFC v1.

Thank you for kindly elaborating this.  I implemented that not to provide an
additional observability, but only for keeping zswap_total_pages() account the
pages including the uncompressed pages, though, since the version was not using
zpool.  The internal counter has dropped from RFC v2, since we started using
zpool, thanks to feedbacks from reviewers including you.

> 
> That could give us a nice breakdown of how much memory in zswap is
> actually compressed memory, and how much is uncompressed.

I agree it could be useful information.  Unless others raise different
opinions, I will implement this in the next version, with your suggested name.



Thanks,
SJ

[...]

