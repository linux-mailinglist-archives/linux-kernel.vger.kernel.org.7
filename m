Return-Path: <linux-kernel+bounces-645308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B58AB4B71
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 07:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 152387B1FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 05:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FF91EA7C2;
	Tue, 13 May 2025 05:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yPtWkgdT"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0B11E834A;
	Tue, 13 May 2025 05:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747115440; cv=none; b=YV77+7iPMjes36HXw5DBGhvoqDndJ7jcS+yAOU0MzEylpn4DjVNwSJTZNX8ltJ4MSEc1wqZjmq4UoKAmjBknOZDzAsRCNRJMWdaw/V1gq19gbcR2TfKP5L4j+il88It5vj+qLNd/UYIpFgAm8EM5p8y15oj6xNZNKmSp6I+1638=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747115440; c=relaxed/simple;
	bh=hXb4E/zwsZxWTwB2VSuwpSk9cjzWGfIAsOSWikai4h4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O8EzyUZ40X0/34HT+ocO8jQHTfsDTGDzO8WW+VJ3Eu6Mk58v4BtyOPLy15Q8/3siqCFJHcHvEb6g7u8N5exFF/xplMyNLz5PF+d+WgPO8SIhZhGiITHc+aEEaS1e21xUPOxmYoyp61hmeJOpWlTaIdWmyYUQDVEjyuvVn7iVz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=yPtWkgdT; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hXb4E/zwsZxWTwB2VSuwpSk9cjzWGfIAsOSWikai4h4=; b=yPtWkgdTISimlnKrzc4Sy3RwA/
	MQSt1Dtr6TTANVZcoRUtT8v91LSZA6VjMtY/LIqRh5dP0ISqAvECU4JXIJpu6ufVJhqatYp/tnqOY
	CN+POts0I/SiIfkbC+W+IhdilLhQtIgppm5INeoJTmKIJ+gWtXry3o4SjSjMDd50ISepn5wxtRvPD
	xZIQktHltqa9jQ7ocrE8/KZ/80TydwxUJaefitArgHNBqfPZtQH8xgn2+l6Snxrpl3tiuCIo+YCWk
	GfwrbSA39T76IDt1Sb6DR+Rpp1paZ/6pDuAnQqEabyskG1bSW7OKXj6Br9nviMDSH041PCm/ZYsvd
	3/nu6WDg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEiX7-0000000BQmd-0vXU;
	Tue, 13 May 2025 05:50:29 +0000
Date: Mon, 12 May 2025 22:50:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org,
	lyude@redhat.com, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 0/2] scatterlist rust bindings
Message-ID: <aCLdpXp6RzvPuSET@infradead.org>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <aCKsQSob4TNDZb99@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCKsQSob4TNDZb99@gondor.apana.org.au>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, May 13, 2025 at 10:19:45AM +0800, Herbert Xu wrote:
> You should cc Christoph Hellwig on the DMA mapping API.

I'm not going to use my scare time to let this cancer creep further.


