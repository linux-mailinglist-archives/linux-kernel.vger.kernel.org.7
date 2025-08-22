Return-Path: <linux-kernel+bounces-781164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E79B30E55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 07:54:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9B951893AF4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC2279DAF;
	Fri, 22 Aug 2025 05:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="QQOgfpAj"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691F7284B25
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755842078; cv=none; b=Xt31Qi8+6MxKh40/TZWFT0PKv9mCRsZ234fp+ds4BYUYyZaeR3asdmLDuihLG4trZhGCZG46c2ozh/YBO0iD4G/AQMVNuugorLr7CVfb1nGw10f3giW2n1hs2s2xYUrEnbdhEoPaxKrTVDEpKTiQBOkyJJnqr4av0k1uv6xvJek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755842078; c=relaxed/simple;
	bh=YBIkwGhwAzZ31SWhTlQUE97IjzGhGgi5KDupVlWpDuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D4+GAHBgyCeaIUaqURj9DTAXtui8P6RkhYLcXMEfHP9J/FFJFExjVLFndlEiw9QLkFvfzF+UKUyJ8Cdkg+E4ZR5hJJgX0tfdgOa9kmgrjJ8eN8OaOkBoP9ib74jduRGKYzdfevuuKYi0AIss9NTijt3SZoT1FotQNkq8HzV3vmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=QQOgfpAj; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=KcLze6kbolgzoPiY7cjF2F70M12vK9bK55NO9ofqS9Q=; b=QQOgfpAjSJBXGftp6CPTQjy8a1
	ljXDYeTVyG36NEVo7P6kKyyJuVwRZTSg2F2GJHapWL0hANvy02upYtz4GDyDn2XLjZ7jcdp0bxTed
	LLvNQ7qIU/UNBKFZ8szLq351UibenvNrNmUvOPeZU7OfO5mKnjPcfCtROJPJpG1fBLqknOMzsTwBM
	/Afko595hAEeRXtFs9+kZzm+GkU6r4uhPh4b6cL3N+01b/w9tyEyAFjHIzJedG2XanAeOFd/2mFFA
	SPE/CkwMdAwDNf8pJ612t4SXRSQjg9FPkfJN1JSmO4qcRwR1f2gWCzqAGDMn93Rl/z/BL2gHnpSuR
	EvJrYrXA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1upKTa-00GJV4-0O;
	Fri, 22 Aug 2025 13:54:07 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Aug 2025 13:54:06 +0800
Date: Fri, 22 Aug 2025 13:54:06 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: SeongJae Park <sj@kernel.org>, Chris Li <chrisl@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
Message-ID: <aKgF_uJT99rBiyDd@gondor.apana.org.au>
References: <CAF8kJuM++mc5PjcN_bxjZjbByT7QpVdOqRQte=vGJnuQxSTVfw@mail.gmail.com>
 <20250821213630.1771-1-sj@kernel.org>
 <CAGsJ_4xLKVM+1LqKzbwjd0vB_OYnb2E-h-Wb_C2bBxiSdU=3WA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xLKVM+1LqKzbwjd0vB_OYnb2E-h-Wb_C2bBxiSdU=3WA@mail.gmail.com>

On Fri, Aug 22, 2025 at 12:48:27PM +1200, Barry Song wrote:
>
> Is it even possible for crypto_wait_req() to return -EINPROGRESS, since
> crypto_req_done() will not call complete(&wait->completion) in that case at
> all?

Of course crypto_wait_req cannot return -EINPROGRESS.  However,
I was responding to a request to make the crypto_acomp_compress
call return a boolean instead of an error code.  That is not
possible because it has to be able to return -EINPROGRESS.

Nor is it possible to change crypto_wait_req to be boolean since
other Crypto API operations (including decompression) can indeed
fail.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

