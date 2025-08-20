Return-Path: <linux-kernel+bounces-776790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B0BB2D180
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938D91C4293B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C342C21019C;
	Wed, 20 Aug 2025 01:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="oh5JW0GK"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE77286A1
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755653854; cv=none; b=FyBGgYFZQSlJ+5CmJiTsBlsz/fe2w8FzUAs1XlTDqwJsbZjeSbarUD87t53G9JOyJn8oliQde2zy+CVfFqZTG4hXOem9wqWZ7F7SaFu5rLwuzDRW0qdJ429Z19uXW3n001v0n+2iAG7ROjNDfTv8Vp6IFrySzyooHRVRTsji6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755653854; c=relaxed/simple;
	bh=n61ClpX5krz5Mpxd7+EYfGhex1h9nijeer/G+thJ/6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQDY2p/SoP1BBMkT/9BobXxlT5z8buYajOC8kbg5V5qdAXYleE1ZQPg9V7t9JRjhdHz0ushxW7fMBN8pdoJ+Zb+09tTPxtpz2K0uhNwNKF6cP7xNeAj682YzPS7D6t+UrvJ5v0QCzZaLKRmRJhj/dYqzgRJhCEuqRqn1Df7aq80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=oh5JW0GK; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=BsaNmFeTmmq2GRfNcvc+yPDBROOyO4EEuBRnYKRbDAQ=; b=oh5JW0GK0a0+MvHZCxmDOlPXnh
	nrq1IF2UbdTmiETHX+s/EFf/HdRvqEEyfYn4+nC1xIIU5g7ajXCPxuuQN0/E+0IWRHHhwlnmtwbCJ
	Gl18tTbVBF0LY5/upym+fV/kLf4xw8WLvmxrsI/gqDNMaZLJosVKM0FvVXh2zpcJ7eLkTP45qW137
	0XYKSv0PdZ7O1CvqDVofRwSj3V7myIlXI4oHE0G1yF14p4xvgMO28Aas43QQQYoU3fyQhcRJxsehG
	usM2EtNNXb1OpdFSkGt0c1DZNnITkhZO9Ln2o9Wm8SdInItoBE6YA4m+OqzWMC8ZNNZyfPUbbtwPq
	ai31HGuQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uoXVu-00FfzF-0f;
	Wed, 20 Aug 2025 09:37:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Aug 2025 09:37:14 +0800
Date: Wed, 20 Aug 2025 09:37:14 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
Message-ID: <aKUmyl5gUFCdXGn-@gondor.apana.org.au>
References: <20250819193404.46680-1-sj@kernel.org>
 <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
 <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>

On Wed, Aug 20, 2025 at 01:34:01PM +1200, Barry Song wrote:
>
> We might want to revisit the old thread to check whether it is now safe for us
> to move to PAGE_SIZE in zswap now.

It's perfectly safe as LZO was fixed months ago.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

