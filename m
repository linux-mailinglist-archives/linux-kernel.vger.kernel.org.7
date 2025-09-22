Return-Path: <linux-kernel+bounces-827900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C4B93622
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 23:36:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA9B7AB7C9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 21:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBDA1B423C;
	Mon, 22 Sep 2025 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YCZr8/+X"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A3D288D0;
	Mon, 22 Sep 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758576989; cv=none; b=DjNLgxkuzTywzdAOH9+PBMJvKH1OGFIw5HeG66pGIBpUkDJQWh6eVjKxSF0H2ad8FIM2lHgl8vO5Gtc5Yo70aKdpzA1srWokVJTpQ2aLwZQGwxd85tN/XMhc49R7sGhHot5fOQexH2EQYXDT8Pi5rOGoDFLuo3gJ34iQn5lRNZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758576989; c=relaxed/simple;
	bh=Z/dcgfZ9+LRLYcmR5yrJHPsYlzUHtfBehHv/hUtwMGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eKMIYMqU1/TLNxpqOaQd9a7cbenBeSwzZQ0/Bj2xRbwVhdD4Ryo/6NE2QuwKoYkxjmalaASQAL2uWQdoGQsO66YnVsKBlp2TlsqtVKGmprPQGQ5OXahkDQ+yH9DOgCbe9EfIhIA8wIayEdQoRyundSIHaNpOJx1f7R/AQPw4I00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YCZr8/+X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3pT42O3ALLdCjivxUa4nPm2rNjCok+zUCphhUS9RBqQ=; b=YCZr8/+X7HAem/+HkyusW68aIw
	GThVTee7I05x7xYEZ+8T+9h92OBw0gw2qrO4B7izQTysTBYiO7My9gCoLFM82EcdKPX2LlVHZq66P
	o8X7muui3AprZT4818FRc8VXpDvzPmnG+CGbq8qywbjUYaiL7lz4S7VAB6RVNDDdCBoGq2bUFjLZB
	ywyHkKeE4Uzfu2kMKYSWo2DXAyCLpUMG9jHOqNZM42Hbde8hK47YsBKEtar21GCZVhw++V5DZ7TU8
	n2lDtit5ChDWlhKxVHIe71XLonsKstOHsFTAE2YbmtlZk+PmLT1ZESug+wpMVEnDj3S6v42QvUAdg
	2pCJJS2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0oCm-0000000FUDX-1i4C;
	Mon, 22 Sep 2025 21:36:16 +0000
Date: Mon, 22 Sep 2025 22:36:16 +0100
From: Matthew Wilcox <willy@infradead.org>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: vbabka@suse.cz, akpm@linux-foundation.org, cl@gentwo.org,
	rientjes@google.com, roman.gushchin@linux.dev, harry.yoo@oracle.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org, david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Subject: Re: [RFC PATCH] mm/slab: Add size validation in kmalloc_array_*
 functions
Message-ID: <aNHBUJxAs-vomIF3@casper.infradead.org>
References: <20250922170357.148588-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922170357.148588-1-viswanathiyyappan@gmail.com>

On Mon, Sep 22, 2025 at 10:33:57PM +0530, I Viswanath wrote:
> This occurs when the size argument fits into a u32 but is too large 
> to allocate, i.e., when it's between KMALLOC_MAX_SIZE + 1 
> and UINT_MAX (both limits included)

Is it really a good idea to support 2^28 vclocks?  Surely there's a
limit that makes sense to the PTP driver.

Beyond that, this should probably be using kvmalloc_array rather than
kcalloc_array().

