Return-Path: <linux-kernel+bounces-780730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4833B30871
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 23:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CF86AA4BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1711F2C027C;
	Thu, 21 Aug 2025 21:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA5Y7U67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76229393DC3
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 21:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755812192; cv=none; b=ioyGJSwzwWu3QYzqD2VLSmu05y072oekFbWqjYfsogBBcYwBdqIj9qobzutwObRn5aOf86yjv/FCGEGasM+indBTnBZnzaCdIw247T/ya1dSWIZK3iU/VMelL8jx3VIsGq1YcgKX8dQx30Omlqgcx/gH980XFBgVwWgweyl7fDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755812192; c=relaxed/simple;
	bh=0ZrNqJZT2DaYZRgAJFFOa0xEYOpeRsDeFYBL6NuqxbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxfmP1Iu6fGicdfgdGdlV/SyjoSbFl2KAGwEI/2hkS0DcYg6hsKCrMaIx2xxDwJzbuhHKQ5Z6zbxl44rTWQ4/6BPVsfEZnB2T7hcPvLADvAvel2MytSGMHBY//FcmgzlKlRaDz5NvSzndzbCdiWO9CDeFjtay/ZlCausmwq7IdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA5Y7U67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2174C4CEEB;
	Thu, 21 Aug 2025 21:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755812192;
	bh=0ZrNqJZT2DaYZRgAJFFOa0xEYOpeRsDeFYBL6NuqxbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OA5Y7U673iMYZhUvNnMwFvQkUXKn9V2phc6Jy4na7rPmNy5W3Cb2nWXmb48SIC4/R
	 58wj17tMqHDq8VqLwvpKsRy940cBsvi96EJ+Z0VV8m9eiykR/GEkkbVXNgSRhhDgjf
	 esn/3gfCBl+giswZXHMhbrsiqEykeIdeLApqKrysRKVEBspeqtWcl3m19sqw+f9VZm
	 zDW8xM76bYQgSwop1GDGxe0VZRpOeZM6xO7ZBUY8RUuBFti0WPTgr4aPz5ik2TM4gS
	 Qakin0sXw1RQISlrvvR1RQiDME2JWDB2CvkXdF49ZbtSEfLQBg/j1yiId9nPVEetyI
	 fjIUeT8fWu7Hw==
From: SeongJae Park <sj@kernel.org>
To: Chris Li <chrisl@kernel.org>
Cc: SeongJae Park <sj@kernel.org>,
	Barry Song <21cnbao@gmail.com>,
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
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Thu, 21 Aug 2025 14:36:30 -0700
Message-Id: <20250821213630.1771-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAF8kJuM++mc5PjcN_bxjZjbByT7QpVdOqRQte=vGJnuQxSTVfw@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 13:49:31 -0700 Chris Li <chrisl@kernel.org> wrote:

> On Thu, Aug 21, 2025 at 9:43 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Thu, 21 Aug 2025 18:27:52 +0800 Barry Song <21cnbao@gmail.com> wrote:
> >
> > > On Thu, Aug 21, 2025 at 1:33 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > >
> > > > On Tue, Aug 19, 2025 at 6:37 PM Herbert Xu <herbert@gondor.apana.org.au> wrote:
> > > > >
> > > > > On Wed, Aug 20, 2025 at 01:34:01PM +1200, Barry Song wrote:
> > > > > >
> > > > > > We might want to revisit the old thread to check whether it is now safe for us
> > > > > > to move to PAGE_SIZE in zswap now.
> > > > >
> > > > > It's perfectly safe as LZO was fixed months ago.
> > > >
> > > > Perfect. Then I'll revive Chengming's patch (see [1]) to reduce the
> > > > compression buffer :)
> > >
> > > Nice!
> > >
> > > But perhaps we should wait until SeongJae sends a new version that
> > > addresses the counter issue?
> >
> > Is there a reason to wait?  I was thinking those are orthogonal problems?
> >
> > Anyway, for the counter (crypto_compress_fail), I don't have a strong opinion.
> > To my understanding, the options for path forward are...
> >
> > 1. remove it,
> > 2. keep it as is, or
> > 3. keep it, but account only -EINPROGRESS[1]
> >
> > If I'm not missing other options, I'm tempted to the first option (remove it)
> > since it doesn't change any existing things, and we can revisit later.
> 
> I am fine with 1) removing it. Maybe add a log once print error on the
> error code if -EINPROGRESS, just to know such extreme error has been
> triggered.
> >
> > Please let me know if I'm missing other options or if you have other preferences.
> 
> I just don't want to hide the extreme error case but I am also fine
> with just removing it. It is your call.

Thank you for your opinion, Chris!  Unless others have different opinions, I
will only remove the counter (option 1), since it is simplest and we can
consider adding another counter or error logs on top of it.


Thanks,
SJ

[...]

