Return-Path: <linux-kernel+bounces-851473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2793FBD6945
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7B5189296D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E57713DBA0;
	Mon, 13 Oct 2025 22:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z0Z6Ywi9"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EA81A5BA2
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760393386; cv=none; b=qSfN2p9IqTfEF3ebmj5SN/ohhBuA8mqLZe37jDKEojHCxiQyWpe/PiU9JBOOv96AyHNFL5JJCVjYSdXMoFDYp7V9kcP9+luz6R/QUD2n3VEpkqqPbEWZjwQB81W7UYNwJTis6j5JWv3YmQWjevVWejvRD0Hs+KzSzGhyZHs8xEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760393386; c=relaxed/simple;
	bh=6CbsHzRPntu8PYGWfta/OwgJfcxx2k8V/VHtqyNe5ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1EyQ8PCj6qVDrxqEs/oL2S130WUFFSkQyRByjX9x6l4f3ojEzk9C9LBp9VGWck5aKCla5bLJpqyUkGSFaLyat7gr7h8B/7jybhb7mTWWx/82maQ28vrN+7beR605O07B30x+EfKYB5we3qfkt/foBFQNQZopBvccfGID8EmzWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z0Z6Ywi9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6CbsHzRPntu8PYGWfta/OwgJfcxx2k8V/VHtqyNe5ic=; b=Z0Z6Ywi9TwANu5werxBaTPjieH
	P5q3LByKFWKgNpxe4AQigUhJrcGSto+Vn2Mye+JFgCm9mleket2XaJS5kIMfrrQZGr55X5uBYKQ12
	spfs+o8TO/Cet4PhB2dB0eCt0egqUU79qQfR0q09ogSALltb+96L12pUKvT5aPHxrJBjKlBzOVwNm
	DdhwcYI/eHHvMic0ixUwiYcJPqjU2aoKHPeaMZjbbfNVn3CNWALATfiKNFCUdQB9XSOdEBQ0qgmqY
	dU8Oz2KWztkJeT1vjg/wzuDbZbaJJc6dJ6j3j7FQp4A2zZ91cfM/HjOVGMa5M1Ja1jlVy1/bQZuHv
	khnT7Log==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8Qjd-0000000EoED-1Svk;
	Mon, 13 Oct 2025 22:09:41 +0000
Date: Mon, 13 Oct 2025 23:09:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Feng Chen <feng.chen@amlogic.com>, Jeff Layton <jlayton@kernel.org>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: Linux 6.18-rc1
Message-ID: <aO14pXe2F7RFjM6B@casper.infradead.org>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>

On Mon, Oct 13, 2025 at 10:08:22AM -0700, Guenter Roeck wrote:
> arch/csky/abiv2/inc/abi/cacheflush.h: In function 'flush_dcache_folio':
> arch/csky/abiv2/inc/abi/cacheflush.h:23:39: error: passing argument 2 of 'const_test_bit' from incompatible pointer type

Message-Id: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>

buildbot doesn't test any configs that include v2abi.

