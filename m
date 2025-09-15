Return-Path: <linux-kernel+bounces-816254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AF7B57191
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:34:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1233189D943
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CDC2882CE;
	Mon, 15 Sep 2025 07:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cCAyuxC5"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7882D660C;
	Mon, 15 Sep 2025 07:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757921637; cv=none; b=Rdf1LrZ4Mg+68ObnTGHOkjOHRQaP8s9WPQ0xjMoUVHwYn3jY32x+nFpCRgpGpIxPEjPoaXVCrMTeIgao99ddAp9tCLOfRKTfrYHpRETTN32gursZKh4bs7XSK+w3NP8M3dNYYF5uUqwDeXmAcKTSuq+TJpHXajwsPwtDiD7hRzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757921637; c=relaxed/simple;
	bh=DvSKAixkF9WiInHcecdF9r++YQfiD7ysh0j9y+sXxTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjLlFrH9JMOgWZNnh7+FEXzv953ErhcjOQihdXvs080ot9cL+sbmmwQCvDEd36bNHuwgIAduvcNcpLxHuzVPwzXg0ypyqamXQmFbcRnT4FcT5NCaVfQ2w+jxAWArflZXv5Wr/UO9nJt3fiNebLr5L0LZy7Rs1HaqXqYgcJehnVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=cCAyuxC5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rkpsss2z2H/w4p1k/6I9vrNo/EjRurZRDUMrR20n0EQ=; b=cCAyuxC54/f29XMk0QmhvUtjT0
	to13Ka/dLEKj/oxdsL8sCx4dW71Bu5X79chkCFeweqvWfQQoHgri6YQc3peonBygp2V2Y7xmxHuR/
	VjPy4QIq0LLo3yO5XJu8n/yeYfo2xAue3WxkgbxALnQQn0qopIrg0aX30yV4O2x1NfI1MwizNXjsW
	hHuZuOREBTeL+cUvjayvIVzua2i+97/TKWnfTb0cFKRyTfuKktJAKikNiIdqk4DEBcOAQn/WJzUSy
	GT+1P3YeDXOQRwBGzuMChyBI9QS2w9m7r2bJnQ3ZLxgN+cLOL7HCTko9AEsdN4Ey8mqhPp0EYm0W/
	l68yokgg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uy3id-0000000AN4o-0H9x;
	Mon, 15 Sep 2025 07:33:47 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 90A1C302E03; Mon, 15 Sep 2025 09:33:45 +0200 (CEST)
Date: Mon, 15 Sep 2025 09:33:45 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>
Subject: Re: [tip:locking/core 1/13] error[E0425]: cannot find function
 `atomic_add` in crate `bindings`
Message-ID: <20250915073345.GR3419281@noisy.programming.kicks-ass.net>
References: <202509131610.IPwv7fy3-lkp@intel.com>
 <aMWMVQiZxE_mv7va@tardis.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMWMVQiZxE_mv7va@tardis.local>

On Sat, Sep 13, 2025 at 08:23:01AM -0700, Boqun Feng wrote:
> Hi Peter,
> 
> On Sat, Sep 13, 2025 at 04:00:27PM +0200, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
> > head:   502ae97746ab6d7b7b48d54b6a85a11815f390d0
> > commit: eb57133305f61b612252382d0c1478bba7f57b67 [1/13] rust: sync: Add basic atomic operation mapping framework
> 
> I think we are missing this patch:
> 
> 	https://lore.kernel.org/rust-for-linux/20250905044141.77868-2-boqun.feng@gmail.com/
> 
> in locking/core. It should be applied before all atomic patches.

Ah, let me go fix things.

