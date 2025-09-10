Return-Path: <linux-kernel+bounces-809346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D713AB50C3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 05:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C983460A06
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 03:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794492580EE;
	Wed, 10 Sep 2025 03:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KABHcOun"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C118F4A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 03:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757474063; cv=none; b=SqLAeZo1NLn3BOmOn10TgfT1b3UFH/L0a5uWwCT2KTR0PfKzusnjCjkrqeE45A5gxgWdNbNoRqEhG7WR7qcVhCE8jqX5Rz9fPzGJ4QWFMvOWpvZY6P0uOX2sWKF91LEgVLsot+Xnj6567lFT04GdDh8nIpf36k++LRDFY/iGbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757474063; c=relaxed/simple;
	bh=TcwTT74aQaPaV63W1C7OeqMDunCWPhOwjwEsGuRKoKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TyHKtqFd1eIFy5wfJHcehZ980+0m3AO2anyontkKZkPrGDdJPpm0zqRDqA7Bk7cp0sR9lkm86seROXggufHTXuMZVm+FD/+qwea8vC4SwHx6wGkHMHodYO/Sn+IRJPiJySLwXdC0o9E4dMpN4nwSJQvI8uoPEzHkWTq58s2aEgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KABHcOun; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4421BC4CEF0;
	Wed, 10 Sep 2025 03:14:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757474063;
	bh=TcwTT74aQaPaV63W1C7OeqMDunCWPhOwjwEsGuRKoKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KABHcOun1fxqcw3tG8NUUO83OuhFEK5DBYCADvm5MMT6Cru3LTtfsldFv3IADKp/D
	 IGCWOTNHR1i5NviYpacgIfrN+sMIi5omdZKeabU26YVruspNDCjr79DWCt+kGgpN19
	 0ePH7yrG4+HRhdaGTNFLd8ZB26zTx2WGJ6WJ44x7JvesO1TodiZQUzW7+Zu2KXHOEN
	 j7a7jz+9d/4NqJFPC0gSbE8PbtTq8FTbL8s+1ui6RPl5psyfOD3QpUiUbi6MNf7tG3
	 XlrrJfeFu/0wEE+wbX4tlEsvIcSf8298CD388zkXg72fu1IpUEtYl453JyBPJYyQdF
	 BY1fOqk3RTtFQ==
From: SeongJae Park <sj@kernel.org>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yosry Ahmed <yosryahmed@google.com>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: remove unused zpool layer
Date: Tue,  9 Sep 2025 20:14:21 -0700
Message-Id: <20250910031421.166611-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250909151345.GE1474@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 9 Sep 2025 16:13:45 +0100 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Fri, Aug 29, 2025 at 12:07:28PM -0700, SeongJae Park wrote:
> > On Fri, 29 Aug 2025 17:15:27 +0100 Johannes Weiner <hannes@cmpxchg.org> wrote:
> > 
> > > With zswap using zsmalloc directly, there are no more in-tree users of
> > > this code. Remove it.
> > > 
> > > Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> > [...]
> > > --- a/Documentation/admin-guide/mm/zswap.rst
> > > +++ b/Documentation/admin-guide/mm/zswap.rst
> > [...]
> > >  When a swap page is passed from swapout to zswap, zswap maintains a mapping
> > > -of the swap entry, a combination of the swap type and swap offset, to the zpool
> > > -handle that references that compressed swap page.  This mapping is achieved
> > > -with a red-black tree per swap type.  The swap offset is the search key for the
> > > -tree nodes.
> > 
> > Nit.  s/red-black tree/xarray/ ?
> 
> Yeah, I just kept the changes scoped to the removal of zpool.

Makes sense to me :)

> 
> But this file indeed needs a general update beyond the changes in this
> series. I'll send a separate patch to clean this up.

Looking forward to!

> 
> > Acked-by: SeongJae Park <sj@kernel.org>
> 
> Thanks SJ

:)


Thanks,
SJ

