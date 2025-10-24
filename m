Return-Path: <linux-kernel+bounces-869062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B4C06D91
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 17:02:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C662402D4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039531A2547;
	Fri, 24 Oct 2025 15:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="sARijzM0"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984771DE2A0
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 15:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761318039; cv=none; b=BIJaITyArOMc4KSQgusPyEUN0aVFVfZzVKjYYXs9G9tY0nhzNzkgNKaECEdBAuGUl/rC1jO/XqpdVKpyrm6FRvEBcvnYXX6m8WBnzp9bVKN07UyAXJSYo4p2g5ixT0nxgDUkCQOiWgY3JcWkIyrAMQO8w6IUSFnQ+NF31X43bB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761318039; c=relaxed/simple;
	bh=Ryn0HEkLr2Xrw4pTwGffNJsijGlsoA1oAQoum9PLTJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJ7TZ82Uxd95/hqmfim/LrlJjl3ZRxrYxjmF/vUtWHpwjUBI1zk35pMOc9UtpU0Q5KMUz4uE2DskYlnXfSkJQvZWBAo7hguaMtwfeNTm27DNEKdWQUyDCgqt4xZ950v+g/fSgVNPsqNfYN557evm0MLTr6Dj8bG+4t940tq1PjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=sARijzM0; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=iApNwy79Xhwc7ZbQC/KcB24stUF96WDTyZoLm13t8Gs=; b=sARijzM0Pkedaawl
	8PRl0Qo1rc7y481jmDS8wZz+W3EVxVcQCRcmQH237vqbA06b/y+1J8y1zyarsP0uyuXMdPjkhFDj0
	tlSsWfmEgBlCW5XgfeDeOIF6xr9Lj2PXkpJP7AUHxHTXN6SUDGjpmOdqhdhD8kbZJ6kKroSH7YGUh
	C5Y5rebK/JjXL9O/SF8sN8feyneW0tKIehMcqmoussDWe6wU9OMneVec0PiRhZasauxwN/pSHV2Hy
	iNRMdYMwqwnt0B0gSvt1nVfdG4uw9eKksAoPneM+i67aVq2UkEEnc1D7igg/u1dA0YvkL3AJlLZ9t
	wyVlMlVvovLKCnOJEg==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1vCJHF-000zpo-1X;
	Fri, 24 Oct 2025 15:00:25 +0000
Date: Fri, 24 Oct 2025 15:00:25 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, terrelln@fb.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] lib/xxhash: Remove unused functions
Message-ID: <aPuUiVkTdLiCnXD9@gallifrey>
References: <20250716133245.243363-1-linux@treblig.org>
 <aHezAgl9CE5RBPxE@infradead.org>
 <aPZPOIfOSUamfyzH@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aPZPOIfOSUamfyzH@infradead.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 14:48:16 up 179 days, 23:01,  1 user,  load average: 0.05, 0.01,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Christoph Hellwig (hch@infradead.org) wrote:
> On Wed, Jul 16, 2025 at 07:11:14AM -0700, Christoph Hellwig wrote:
> > Looks good:
> > 
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Btw, with this, xxh32_reset, xxh32_copy_state and xxh64_copy_state are
> entirely unused now, and with that struct xxh32_state as well.

Oh, so they are - I'm on it.

Dave

-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

