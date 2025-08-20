Return-Path: <linux-kernel+bounces-776772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A3B2D157
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 03:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A70E1C42AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 01:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999DF19E7D1;
	Wed, 20 Aug 2025 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Nq5l+gI1"
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1568F35334D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 01:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755652870; cv=none; b=ukmfGGhYvmf/P3xva9neUMq927ung2SY4WMl9pIDqfn9TX5nA109ssqCGpaIBnSylwgdw5Z4m6GeX/98yAY7KVzkIWS8v3GLTZUFCTRZx1jaaUQPeIGv0iJEV/HZ/E7xeio/MXaLLp/aF52AoKDIRr405RVKhYvuj0vBSLcxx0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755652870; c=relaxed/simple;
	bh=wztx4Oa+sw57Q3J2ckj3glX1BVW4PUyOdi8zgcL6trU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCKkBWG91Lz8MMOBMt7EBmkw7bS8w19vznTVmcdawGzaVadKP0bPgDXOIyouh3yKTY6d/fqF5dGNDmmuyC+wLQ6Wdq93Mz9R36OLYtO8DryACWuzt3qscTL69kXrqGaGLsTe2cXqVDXmeD+nf/ezc/Yh6Two8tDjS1VvNrCmGqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Nq5l+gI1; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QZMvR5QVzbNn1ZOikn+6fLVoCGoDcvmbRo5dA3O2AFA=; b=Nq5l+gI1HtFSguosgBSX/Fylrt
	KaHEcYe2NywPqF5xFCA0fmbq8xdoJn5wfzv384L0LKwUiREJ5hB4YkFixTpf95tVvwcH2Dc8w3Lrg
	m3eVFjbzZPCNu8aqZqq6C67EMMkok7/7ozw2Hq74t6l7XthKRToiow8WQDUtK/x7lI7DWk07Do06f
	fCUNjke6lwuNclHxpNR/A6fu0zrvxKnAyIhsNm6e8H9o4t/q9gHi9TqeFN75IwnRHXcwyG5+fzCZL
	Um7JL4strIP7r3fxNQRUbkaRrhd0fCz+VKrqXq7meXH0f+w5NI5QHyYv3xKI0C+7RV2keS0HVTjxh
	70F8Ozeg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uoXFx-00FfnT-2n;
	Wed, 20 Aug 2025 09:20:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Aug 2025 09:20:46 +0800
Date: Wed, 20 Aug 2025 09:20:46 +0800
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
Message-ID: <aKUi7hvcaK0h0oMg@gondor.apana.org.au>
References: <20250819193404.46680-1-sj@kernel.org>
 <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGsJ_4ygTv1tCJeuF43NhRR4E0kiMLpk6i8c+UHoUMt6LXykww@mail.gmail.com>

On Wed, Aug 20, 2025 at 01:13:13PM +1200, Barry Song wrote:
>
> Let’s sync with Herbert: have we reached the stage where all drivers
> reliably return -ENOSPC when dst_buf is PAGE_SIZE but the compressed
> size would exceed it?

It doesn't matter.  Software compression should never fail, and
if it does fail due to a bug, that's not something that the user
of the API should worry about.

Hardware compression should always fall back to software compression
in case of failure.

IOW all compression errors should be treated as incompressible
data.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

