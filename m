Return-Path: <linux-kernel+bounces-817399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC85B581BB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0B34C25C3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E423258EF4;
	Mon, 15 Sep 2025 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0Lw7dm+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA2213B280
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757952681; cv=none; b=LPBcckr/J8lylBrnPT6fYsK4hhJNYh6INbIiASHiA66BEoGCasEuh3e7g8w070DcQPVAMX6DUuwEiB1QRGPl/xOwucWrQ+weecY71hNg1XyNA8Haum8G7uXV5DfhzTNlXtLrrKCMO1NXqFjvZ1wQEg4WmOdsPqHriPDgLCvMtZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757952681; c=relaxed/simple;
	bh=HIvRsMJVPNoUvvqUEpteOLKzrNYK7pX2CMDYd4CRrSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVhjh7unVD3MNwNIIUjzVzNlU38gLjUDBBM3DCYKZbk+UX7TAWx3QhVD2YzHqlCKa9g8EvSPJ2be+tP7Mje19E5DV7ahI2E2M5hfAU88EDpQpLXTpRtlDCSf97FMHjPcvkoN+y436jar7bUQLrDkGEBfb2RYLkwTfWkDs24x+ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0Lw7dm+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2521C4CEFA;
	Mon, 15 Sep 2025 16:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757952680;
	bh=HIvRsMJVPNoUvvqUEpteOLKzrNYK7pX2CMDYd4CRrSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o0Lw7dm+WDNqh8UKtgSTrRp1KEGb1+HzQ25D4x3Qlj1zY0y+wipo4fB8Ut2CDs2Kt
	 EO504uFug0dUTpMEOA1YXEr1kOvaK7TM+zIB6iX9Pesk0ENVyuV/l/QR6C7yl28g0F
	 DzZWd4AH4VUK9GRcDdbvRb83Yk25ik7CisUQLJDDV6pT/Uir6R7B7a/RmEqsT0KjDr
	 T+BMOqi0YSOW5RLQ6B25Gbm/IYwjC0uhlhNW+1nAhV1W02NEjCDc0+GFOPRkKyXs7d
	 ROxvsJAhIAUu99ziG6QNm1/eYdnihmAeW60wrWqK+Gd0DQzapA/1ZH4yF+Wh0g3fCF
	 6exIA62+ATVwQ==
Date: Mon, 15 Sep 2025 19:11:12 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Changyuan Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>, kexec@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kho: add support for preserving vmalloc
 allocations
Message-ID: <aMg6oK6gaUfU9ol2@kernel.org>
References: <20250908103528.2179934-1-rppt@kernel.org>
 <20250908103528.2179934-2-rppt@kernel.org>
 <20250908141423.GJ616306@nvidia.com>
 <aMgcHWxsEWnKzzcN@kernel.org>
 <20250915143730.GK1024672@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915143730.GK1024672@nvidia.com>

On Mon, Sep 15, 2025 at 11:37:30AM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 15, 2025 at 05:01:01PM +0300, Mike Rapoport wrote:
> > > kzalloc() cannot be preserved, the only thing we support today is
> > > alloc_page(), so this code pattern shouldn't exist.
> >  
> > kzalloc(PAGE_SIZE) can be preserved, it's page aligned and we don't have to
> > restore it into a slab cache. But this maybe indeed confusing for those who
> > copy paste the code, so I'll change it.
> 
> It really isn't. The kzalloc should be returning frozen pages for that
> allocation and the restoration will not put frozen pages back.

But we don't care here, we free that page immediately to buddy on
restoration.
 
> Jason

-- 
Sincerely yours,
Mike.

