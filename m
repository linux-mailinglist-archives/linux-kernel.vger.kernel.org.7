Return-Path: <linux-kernel+bounces-782466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF072B320AF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:44:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C99189F712
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9704E3054E5;
	Fri, 22 Aug 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Juqfm1fJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04BB280335
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881062; cv=none; b=LAHG5xa42oMMlynizKw/uP1k6MOXz498tivbPZ/oOUzBtJI9VAt8riTWgq6GUlKRjAFCzOm392bVUyYMKQsyT2wX33F2s/3eFuiJwTfOlmjBznIq+d28ijsOBy1WydLOYolXNIgPm7QirzrRSSpvYNTLRnGilmnnG/LeCdBJemM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881062; c=relaxed/simple;
	bh=k1cK3Xue+HD3m7URxYZ8fT3eh0OpuLIIwinvJH3zioM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tYJE6D5cFpXdgX7moEsjXZCk9DSre8jLem74yUJH7Ql4TMFGQf3FUNH0q2SGYciIRbvB5mbArUTbeH6S2tSYbj6ONAVPsI1dH5hhL6qWyFDsorS/oimMd7/SLkFs7M9qQ7rJ2tDO3AlIxcbufkoiDyfpJtoPp0QtGmoefUlZsXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Juqfm1fJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4328AC4CEED;
	Fri, 22 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755881058;
	bh=k1cK3Xue+HD3m7URxYZ8fT3eh0OpuLIIwinvJH3zioM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Juqfm1fJRNO3ABVAETXZytIvmf535GRaCb+cbkSlgeNhd9xtSDNs+2dBL7vSGlB02
	 1Z9zIhoBqW7uG9ep8bRXLd/57/FlY8gxMG1/lSKs6/k7IW5PgHx0Gy/av57PE5DZPa
	 vbQdOIYRZvkkLiHn4wUZRfdNfiSfkFa9kzPQzT3l+RXnRoWXUAeK4ei9JgqumMJqtV
	 6H0olStRqs5gvsaxkNEKQ5OHDjPqTbd3F41Nuow1w9cZupyss27jLPXiUxQ3ywWs5e
	 Yq4LgEbhEWXZ1MGtWMVpF3qG8ZeP4wBwwxzU8TzgZ9qIRnqyJYCwh8JuYINrWbhODA
	 t+rqQa32fN/VQ==
From: SeongJae Park <sj@kernel.org>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
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
Date: Fri, 22 Aug 2025 09:44:15 -0700
Message-Id: <20250822164415.52517-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAGsJ_4xLKVM+1LqKzbwjd0vB_OYnb2E-h-Wb_C2bBxiSdU=3WA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 22 Aug 2025 12:48:27 +1200 Barry Song <21cnbao@gmail.com> wrote:

> > > >
> > > > 1. remove it,
> > > > 2. keep it as is, or
> > > > 3. keep it, but account only -EINPROGRESS[1]
> > > >
> > > > If I'm not missing other options, I'm tempted to the first option (remove it)
> > > > since it doesn't change any existing things, and we can revisit later.
> > >
> > > I am fine with 1) removing it. Maybe add a log once print error on the
> > > error code if -EINPROGRESS, just to know such extreme error has been
> > > triggered.
> > > >
> > > > Please let me know if I'm missing other options or if you have other preferences.
> > >
> > > I just don't want to hide the extreme error case but I am also fine
> > > with just removing it. It is your call.
> >
> > Thank you for your opinion, Chris!  Unless others have different opinions, I
> > will only remove the counter (option 1), since it is simplest and we can
> > consider adding another counter or error logs on top of it.
> 
> Yes, that seems the best option—to remove the counter for now.

Thank you for making your opinion clear, Barry.  I will post v5 soon.


Thanks,
SJ

[...]

