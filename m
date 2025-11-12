Return-Path: <linux-kernel+bounces-897661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6482BC53654
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237DC4FEC23
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F52733F372;
	Wed, 12 Nov 2025 15:58:26 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459E424E4A1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762963105; cv=none; b=KY4v/J7SDqSrXg3ZP0AVN7sQfBpGvps0apJSgToCUlnqmMqr+Cmnzq7Hf7pREuxFpK6pf96iOQEsVZaI9NQogQWqiEkfCg9+DBOI+8YVOkYbbA1V0ypXAPI4xsXuM8nQ6+gATIvyPlAYO7vcBgE5nXGk8vI7zKcErdvHpCn3Rpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762963105; c=relaxed/simple;
	bh=6gqaLp/197Oe9jzpDCuXt+a0n1eOBjRRgU0m/EKKi1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUGGqRR9o5dzDfRckmKAMYgog1m0ytZrJVmC2q9VMuAygRTqUBN0cwQRaZKfm1mBwl+AWRm6I2xANMoLnOrmulb0Cvv9hyppl3xvytPNIMV6vnkOLdtaIYgT0tZB+uexP+Bk4PEZ5a/X1eXn0oE8eifRy979caMoXBgot7Sh9Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D0ED96732A; Wed, 12 Nov 2025 16:58:18 +0100 (CET)
Date: Wed, 12 Nov 2025 16:58:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] mempool: add mempool_{alloc,free}_bulk
Message-ID: <20251112155818.GA9179@lst.de>
References: <20251111135300.752962-1-hch@lst.de> <20251111135300.752962-8-hch@lst.de> <c691c9c1-a513-4db3-95f6-3d24111680b7@suse.cz> <20251112154754.GB7209@lst.de> <4b72bcad-5174-49c7-ad90-63a9c312df0b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b72bcad-5174-49c7-ad90-63a9c312df0b@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 04:56:19PM +0100, Vlastimil Babka wrote:
> > and doesn't leave random holes?  That's what a quick look at the code
> > suggest, unfortunately the documentation for it totally sucks.
> 
> Yeah I think it's fine with alloc_pages_bulk. It would only be a concern is
> the bulk alloc+mempool user used up part of the allocated array, NULLing
> some earlier pointers but leaving later ones alone, and then attempted to
> refill it.

We could have a sanity check for that.  The cache line is hot anyway,
so another few NULL checks aren't going to cost us much.


