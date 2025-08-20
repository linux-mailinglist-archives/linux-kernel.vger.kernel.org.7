Return-Path: <linux-kernel+bounces-776943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 118C2B2D34A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 07:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B08D71BA5BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 05:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867CB23BF91;
	Wed, 20 Aug 2025 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="bwkG0iRb"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8329D219301
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 05:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755666651; cv=none; b=nNYV3175qiDTcR1wpxZESPhwL3ltIrvPB02hPO7yuOJ7UvWppufq9Of8/A3pRul7xFHfJOuEukrijD5+QS95o7HaUfsW/GlERQjLuH54tYjJOvSAydhYa+om8GaoF63l95XjmjGTp4Opb2YdJXYIw7QjsdfIO8xHYEtet3VQtr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755666651; c=relaxed/simple;
	bh=i3VVH/wienBMACyhAZc4IlCQt/+Bx4ZTTxF0wVFBEuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ldS0QLE3Gf85q+nL56NQ4rikP7k8qm2c3XZTfr8heUG0abGUCsxbmR9Y82uQLCySe7F6bUOVUC/YxdhQpbxz+KUSpLX/nuUU42u6hAHfw2VNmRfLzxAymc/c7qUJpShFjXDQgnfCB9R7jf4P2wGZpjEM9UmWhCWRgKq0csev7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=bwkG0iRb; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Pn4NalMMn4Jin9v8qpHCQzOPlQZJKwiK8VwjOAPeQaM=; b=bwkG0iRbHDSOt6auGT0C4z/tWP
	UFOqSMgc0xa3YTjpqG/LcYtlOeV/6fpiFpEjd4F50EwxhL80RCDCGYH0E+Z507LOwKiKhy8q0utAg
	1oAqX+wpGO6o4CislU2dAFi4a94NwIoXggPOsWpkGg5PZG7s4vZ7ME0tAXhJpyzmCdNEq6vlRrhuS
	Ripg4IQUE2JLOXbv9XrOdaM5xcAXQSq08r6kDsPQSUbEoqJl6Y6LETva8K2MGn1tgKYgPL9g/dmXN
	K/w8EXQ4Wg0Ij5vG5nm6F7B7eawDhDGsE+Uq+++1B+Hiix18j5MYrn9OH1sqGSkEg+3/yM7VaazbX
	LO/83aJw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uoaqK-00Fi3M-0f;
	Wed, 20 Aug 2025 13:10:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Aug 2025 13:10:32 +0800
Date: Wed, 20 Aug 2025 13:10:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Chris Li <chrisl@kernel.org>
Cc: Barry Song <21cnbao@gmail.com>, SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>,
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	David Hildenbrand <david@redhat.com>, Baoquan He <bhe@redhat.com>,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v4] mm/zswap: store <PAGE_SIZE compression failed page
 as-is
Message-ID: <aKVYyGWiWRYgxfE-@gondor.apana.org.au>
References: <20250819193404.46680-1-sj@kernel.org>
 <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
 <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
 <CAGsJ_4z6YvQULrEmNjFjLNrJ4RK6w0+d9uF2-7v06gOYirrYRw@mail.gmail.com>
 <CAF8kJuNJ8s2D9NBdXDQ4vpBP0a-5k7r_=DdFuJJ95nMKmm6LBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAF8kJuNJ8s2D9NBdXDQ4vpBP0a-5k7r_=DdFuJJ95nMKmm6LBg@mail.gmail.com>

On Tue, Aug 19, 2025 at 10:07:57PM -0700, Chris Li wrote:
>
> But if that error case can never happen, we should convert the crypto
> compression from returning error number to bool instead. It does not
> make sense to return a free form error code and also demand the caller
> does not check on it. If you insist that the caller should check
> return value like a boolean, just let the API return a boolean.

No we need the error value for other things, such as asynchronous
return -EINPROGRESS.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

