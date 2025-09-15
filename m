Return-Path: <linux-kernel+bounces-817128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E11B57E41
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5DBD3BF2CE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AE52FC007;
	Mon, 15 Sep 2025 13:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAj6E/Ir"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20E02EA482
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757944682; cv=none; b=KRXWCM4gbJ1VzFmucp5zj6Y49iqODaDyYTwmSO4eOXZwtbYYhyRsmoYn4Ph6m+R60RD6uLpCwKiHVEz68Fi9ZJ805Bzph7JD1s3DAECyNhAszLyh0fEItR9maEXKzzhv1vdgwvzKg7wZCXRgwGRrw662Go75fwWM/5PZ8ztNtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757944682; c=relaxed/simple;
	bh=zfhyJFbpd+KywjV+fUeZ4MHJ3acyIVGXF5VDrBR3oqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5sTt8u7sMuIUIigtLKbHGYT15xxUqJTEkO6KHECikkpLO/MKZZf7+Lbp0rfwCpGvjufsjKAd/q1PvAp8S45A8kJFR/83XjtgtAX4lRiR8U50XQoYkPkP22oG1Po9XGv+GAzg/hn5xgJ7eCor3DewxnS7bcbWMeHPmyoLyl3qnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAj6E/Ir; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB065C4CEF1;
	Mon, 15 Sep 2025 13:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757944682;
	bh=zfhyJFbpd+KywjV+fUeZ4MHJ3acyIVGXF5VDrBR3oqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAj6E/Ir4AcO15gg4WswXPYafaVEjYoICbCA8Ag7OHWX6rZwizZktjF1JXf7VU6xd
	 CEUGAByV8DTlJ+KHyVddNKEdEmTI4oj4QL/FLCdjtOUkliPSnyRG6jVALUuzJj1VP6
	 CSLvcbzXRP4PWdf0ExQYFaIC3Km4yAfiJiV7PblSZUJj5iwtiXA3UfdP8UJ3kRQEIC
	 sbhpRwwwW5KgSgMQqG40XiL37ebky3DEBtTGVte+j4bIbtbTh8GweS7XL5GB97BkTO
	 cLM1lqDdieaRdNRGieHhWZNXbMwPsXIeBxXGo1M70cjoPlE+RCLHHI5xoe0eoU/aHj
	 /kAJkO4XoPTUg==
Date: Mon, 15 Sep 2025 16:57:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kho: add support for preserving vmalloc allocations
Message-ID: <aMgbYrYwxKjiW6Pd@kernel.org>
References: <20250903063018.3346652-1-rppt@kernel.org>
 <20250903063018.3346652-2-rppt@kernel.org>
 <20250903125620.GG470103@nvidia.com>
 <aLhg2Jli0KUe-CXC@kernel.org>
 <20250903170631.GK470103@nvidia.com>
 <aLiWDl3sq3RTkdfJ@kernel.org>
 <20250904123032.GM470103@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904123032.GM470103@nvidia.com>

On Thu, Sep 04, 2025 at 09:30:32AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 03, 2025 at 10:25:02PM +0300, Mike Rapoport wrote:
> 
> > It seems that our major disagreement is about using 'folio' vs 'page' in
> > the naming.
> 
> It is a folio because folio is the name for something that is a high
> order page and it signals that the pointer is the head page. Which is
> excatly what KHO preservation works on.

kmalloc_large() and vmalloc(VMAP_HUGE) are not folios and won't be.
 
> I don't know what the next step is when folio is split - presumably we
> will get a new type to represent an abstract memdesc head of a high
> order allocation that the lowest KHO primitives will change over to.
> 
> > I'd rather stick to the good old 'page' and when the time comes we can
> > 's/page/memdesc/g' supposing Matthew actually plans for it.
> 
> I think you should just convert from the vmap page to folio for now
> and most likely vmap will stop using page someday..

This is wrong. vmalloc is not a folio and according to memdesc plan [1] it
will be be page until it becomes memdesc.
  
> > There is a struct page for everything that's memblock_alloc()ed. And we can
> > do page list, but for large  physically contiguous allocation it does not
> > make sense. 
> 
> Arguably you could make them into high order pages and preserve those..

They are not aligned by order and they may be partially freed starting at
arbitrary page. Making them high order pages will be a mess.

[1] https://kernelnewbies.org/MatthewWilcox/Memdescs

-- 
Sincerely yours,
Mike.

