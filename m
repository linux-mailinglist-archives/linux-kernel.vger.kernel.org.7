Return-Path: <linux-kernel+bounces-680949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA33AD4C22
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 08:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE8D13A782F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jun 2025 06:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEC422F742;
	Wed, 11 Jun 2025 06:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T8ksuFaP"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431E11D89FD;
	Wed, 11 Jun 2025 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625022; cv=none; b=pqDQU5h8PZhbNEHaVtFcooeg8DBbk4t9U25eX7tSVXLkDd3OGBKOpkZ/ncRghDRZC/PV/Q3ssVp7W1XyWmLnqe2fho7NACE6kCE4kfoGw5t9l0pMNwOWPYfh2CNHe7NV1ckn4kGAmdl+Dge34IzKMjBoZmCsBcgfqu/Od+9bAd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625022; c=relaxed/simple;
	bh=m5/oWYfaDlJS/XOllZ3iPuZvKNN93VNwVhPmc7Cy5v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AB/xs0KP0xOfsq2jWAltgMjoArzmiiVVpUm/PA8KmsXd0bLoOkyeKVWv74CG/TyVVb88+LAUmYR5/o1+mbIt9dglZeVoNILT+6S07AZ1aKOH8lqRYyGnIyg8NQsqUMJk6WZcHupNMLXDoZf7345WhsyyjcBJDG1meacbtGO+kxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T8ksuFaP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vMKx1CsM/qVgloX7kLCl5wAJTlBEkxfPpTfrY4IX8co=; b=T8ksuFaPQWpsarPaNbqYzwU6Wx
	9xXVghdMfNSBtPEi8ztYOS7mQ9Q5aqxLWRfM/hYdqYDJ98TvhPaH7P6JDgJPkIVdM9qSu+ZVjlkMd
	ISGQ05myShzQ7iAwsLnV3XGq1PJmPgDV8S+pch55t35tbZnA0aANnqnApt7O/U3vZ1vxTrdAe1s6O
	LKKTeKGw7m+K45z9FXjrDO9KjDDUUhslDRfLIgWcaQid+74xoX//3HgsQJeS6DHgXjpKW3wbp8sj6
	JzGwepHTb3zWleyDgFqzMTKhp3/LUTB8OfRKoN6LDP+Yngrw56orGSIaUzLigxH4JrzICACBdD0/m
	e3YDv3OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPFOM-0000000937L-3PKl;
	Wed, 11 Jun 2025 06:56:58 +0000
Date: Tue, 10 Jun 2025 23:56:58 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Sergey Bashirov <sergeybashirov@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	Konstantin Evtushenko <koevtushenko@yandex.com>
Subject: Re: [PATCH v2] nfsd: Implement large extent array support in pNFS
Message-ID: <aEkouh-uedz1_c4m@infradead.org>
References: <20250610011818.3232-1-sergeybashirov@gmail.com>
 <1da1e7db-c091-44b0-b466-cb8aaa6431ff@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1da1e7db-c091-44b0-b466-cb8aaa6431ff@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 02:10:46PM -0400, Chuck Lever wrote:
> > +	if (xdr_stream_decode_u32(argp->xdr, &len) < 0)
> > +		return nfserr_bad_xdr;
> > +	if (!xdr_stream_subsegment(argp->xdr, &lcp->lc_up_layout, len))
> >  		return nfserr_bad_xdr;
> 
> The layout is effectively an opaque payload at this point, so using
> xdr_stream_subsegment() makes sense to me.

Btw, when trying to switch XDR to work with bvec backing,
xdr_stream_subsegment has been a very painful primitive.  I also don't
really understand what the benefit of it is vs just keeping on decoding
the subsegment normally.  That might just be me not understanding the
code, though.


