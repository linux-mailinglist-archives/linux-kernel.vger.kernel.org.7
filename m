Return-Path: <linux-kernel+bounces-816276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FFBB571C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B55C3AB497
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E092D6E4D;
	Mon, 15 Sep 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KmDPdVKI"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18992D6412;
	Mon, 15 Sep 2025 07:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922099; cv=none; b=fC7p4FSNAWKXJ56kmF0Lr0pnMonJtmH31IeH/RERXTsigFa/D39F5cM/Q3RY3GWjBTCFlv76iCu5WclUL6LbWxYUqJaleSaByMe2EwYl3rsYOI3NN576KbeKc16EwFjJpJTnttxz6n+u+FP3oxmJwFtGJotoJKw5SPrdlcN+wf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922099; c=relaxed/simple;
	bh=F1p/NlELP+3c4Wm5tfduvte6HIaky1MnOIhh0hdcSbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DV6uR/njda8f70MFRhtAW+99EcUT9ogVkx1i40JOg0A49Ibzl0nleda5HqwPMSZLKy8d49sgV5osEAWQTcn/IJbUm8jY5dFA5pzze1Mov6sQx2qRrf3C8BkZiyX0ygKICK51wEj2xNvFtaB4PuqloevpDzDYuzqUz2iSociqy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KmDPdVKI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8PuYd+ce3erTB6kb5L/aiJ/ZqstWZ32ViQLBFv/K0dA=; b=KmDPdVKIbdFec4xV6CgomN6Z3j
	PiMsNrLwV7bIYeSVJ6h0QqadFh0jt640X0Pcp9XoPB5xEOnZwy8ATQB+Rma3JBkcfM2akIaxSLjHq
	N3VaCIzTYvrNzig2fmAOOFFLZKLBuEqvxOuU7f8RKc0oORKQKnvWmEfq3O6D+lS2gTEbWnBpoaJX9
	fr1rZoM2zMR8+lg5OYnutaLP9yxnfZCPXFfP2v8gafZGj9mtI7yM/ZRnJgVvds3wzO7imFFoQVAd2
	L83fO89j0654V57wEVdOZm87WldC5AyIdwgWEBBXHrucdHrhp3IVHBG1gA+DKcWai4rfwM8xTYaJa
	erhGtHTQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3q9-0000000AUeB-3vOY;
	Mon, 15 Sep 2025 07:41:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 81A84300212; Mon, 15 Sep 2025 09:41:33 +0200 (CEST)
Date: Mon, 15 Sep 2025 09:41:33 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: Re: [tip:locking/core 1/13] error[E0425]: cannot find function
 `atomic_add` in crate `bindings`
Message-ID: <20250915074133.GF1386988@noisy.programming.kicks-ass.net>
References: <202509131610.IPwv7fy3-lkp@intel.com>
 <aMWMVQiZxE_mv7va@tardis.local>
 <20250915073345.GR3419281@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915073345.GR3419281@noisy.programming.kicks-ass.net>

On Mon, Sep 15, 2025 at 09:33:45AM +0200, Peter Zijlstra wrote:
> On Sat, Sep 13, 2025 at 08:23:01AM -0700, Boqun Feng wrote:
> > Hi Peter,
> > 
> > On Sat, Sep 13, 2025 at 04:00:27PM +0200, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> > > head:   502ae97746ab6d7b7b48d54b6a85a11815f390d0
> > > commit: eb57133305f61b612252382d0c1478bba7f57b67 [1/13] rust: sync: Add basic atomic operation mapping framework
> > 
> > I think we are missing this patch:
> > 
> > 	https://lore.kernel.org/rust-for-linux/20250905044141.77868-2-boqun.feng@gmail.com/
> > 
> > in locking/core. It should be applied before all atomic patches.
> 
> Ah, let me go fix things.

I've no idea how that first patch went walk-about. But hopefully I got
it right now..

