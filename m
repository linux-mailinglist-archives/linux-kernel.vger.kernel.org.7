Return-Path: <linux-kernel+bounces-854448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2EDBDE67F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 14:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7793935780A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 12:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D635326D4C;
	Wed, 15 Oct 2025 12:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fXrwPuT6"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7EC3233ED;
	Wed, 15 Oct 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760530180; cv=none; b=S0y33D8jBeDzic/38ZTEygwXgdUFHcS14xIEEmA8YrQ/IeEGiaRKGf9LFSaIxr3tDzgOtV/uzyTPMWsr8psEvtQLIUKBr+xzB7+nR59iLwvSdSrx5bKx0yy6koy8fOkfNiXdGyr2nF6hsOz1N2gqvyzwc4XDBwcNQ47FXICFx3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760530180; c=relaxed/simple;
	bh=f9Fjl7F3VFzXC0O48M5wncgrl7psHc5HnBqdo1yCEm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYGH7mHZhp6DgGDxRo7Pjz33WyNVIZ4I+lrhbcJ1S2bXqnNTev8F14kAqxoSnw90sDYofA83YCgKOXY2yORGrgbm1d9jmXrB0rWUb0AbTxTeoCtZmqm5zKI3B0sEDZZ0UKrJmfAycBpJWkFpR4vetXtc0lpj/P9iTfuuhsuZTok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fXrwPuT6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f9Fjl7F3VFzXC0O48M5wncgrl7psHc5HnBqdo1yCEm8=; b=fXrwPuT6D6NXjiEVl+QjBGjMhZ
	AS1I9IN66rWe6YhNQDOmQ0rvfm8FzszVFXWhrLrz5IbriMPLxINEhtc5OimwSOCU5tzWqQ03V+IBP
	F8OtuPSePY4QAxn9qo80PEAEZDZhO/+k6sHLjEfz4V3CG1wKodBvYTB5HiL4JarqvdRDE7OfJUfmt
	qQaUOj+87E62ZC/sDwzNNjQVEu30qM2/bwdCDYsUzvSEebjJ9pFtqASBfSeAoyPQ3kLecj3amW0JF
	0vgv7kuKoIH/k/hgcBhBFYP1UhHTeypycpIPuk0gyN3vM6N+h8+yfb3ypwP3zvjaI7fZpAppYRvox
	ztMLJw8A==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v90Jz-0000000Elb2-34Jb;
	Wed, 15 Oct 2025 12:09:35 +0000
Date: Wed, 15 Oct 2025 13:09:35 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Guo Ren <guoren@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] csky/mm: fix build errors cause by folio flags changes
Message-ID: <aO-O_2lhxZ8I78cl@casper.infradead.org>
References: <20251015064759.2993842-1-rppt@kernel.org>
 <CAJF2gTTgG2DhqLC2B6URsNusjzcwCaxi-k=MUZTc1FTEHbaf+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTTgG2DhqLC2B6URsNusjzcwCaxi-k=MUZTc1FTEHbaf+g@mail.gmail.com>

On Wed, Oct 15, 2025 at 03:51:53PM +0800, Guo Ren wrote:
> Thanks for the fixup. If you want to go through your tree, please add the tag:
> Acked-by: Guo Ren <guoren@kernel.org>

Why haven't you merged the original patch from October 6th?

Message-Id: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>


