Return-Path: <linux-kernel+bounces-793197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A8B3D03E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 01:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 203E97B4158
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 23:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B975261B71;
	Sat, 30 Aug 2025 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4wQYuTV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572242065;
	Sat, 30 Aug 2025 23:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756598190; cv=none; b=rvvjX0kKH4ejGy7nwB1GVERPhtm7n8+Phw1cgK9k9NuzzZHbvIERaYPng2Ez0Sa3nU9d4mm48aGpjYKMHO/0Isx+ajbEsS7YWLikq5rpckSuKww6O3iHoR5BtEv6VmQacXSe2jaGoBnyLlDWs86/0KzU3Q+lFvsMve+B4w2gvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756598190; c=relaxed/simple;
	bh=HcA7hQOCanekiWRbytTisPxE68CIh4YqbIk883mOrU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DB5Wv1IPYC0Sq8voIJRVVaIM2plya5SNyjXaSgXQrEIRmyiKBtdYXVRBCIxzZdQAnpVkc990CyYqdCyGlkDIEkYqJaIzCDJpQ6pWWIjGH+FLptGQyTMr85gkbKqv9752y6nMpLlEE6srmD3x0+p3CZhLDF+f17LsKNW5VPHeoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4wQYuTV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897B8C4CEEB;
	Sat, 30 Aug 2025 23:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756598188;
	bh=HcA7hQOCanekiWRbytTisPxE68CIh4YqbIk883mOrU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c4wQYuTVeU6pZgntmAIEg+Ilxrkg83c7N6YNsJQXHIiFve1f6+ynSSNKTY+xkFLhU
	 ikJhara5FWPaIbNvvqfYM4ZFCziBmigjIcinPmiH4cP0iz58jpXjHoTGVtnFNGVqOj
	 UMRWRMVAzZu7BsiZ/6aM/RXPmDT/XatbZXvxZuw++N5mR96pjTazlg8Uvtds7e1MzM
	 j5qDfK3zjFuEJuvHTJFgYZw6ZJERm31oTo+QHJ0GfdkRD+PJN7KSFOeg+oJfV7EjKc
	 0aNEaiguPrB5vIlX+dyTzx92k8j8/7O77ty0Zs+tidUanbzvoL9Qhxrput143LZj5y
	 3Xr4Xi2+lwJUg==
Date: Sat, 30 Aug 2025 23:56:27 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux F2FS <linux-f2fs-devel@lists.sourceforge.net>,
	Chao Yu <chao@kernel.org>, Daeho Jeong <daehojeong@google.com>,
	Yuanye Ma <yuanye.ma20@gmail.com>, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH 0/6] f2fs: documentation formatting cleanup and
 improvements
Message-ID: <aLOPq_zLap9PuMrW@google.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
 <87qzwt3glo.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87qzwt3glo.fsf@trenco.lwn.net>

On 08/29, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
> 
> > Hi,
> >
> > Here are documentation formatting cleanup for f2fs. This also includes
> > docs retitle at the end of series ([6/6]) as a bonus.
> >
> > This series is based on docs-next tree.
> >
> > Enjoy!
> >
> > Bagas Sanjaya (6):
> >   Documentation: f2fs: Separate errors mode subtable
> >   Documentation: f2fs: Format compression level subtable
> >   Documentation: f2fs: Span write hint table section rows
> >   Documentation: f2fs: Wrap snippets in literal code blocks
> >   Documentation: f2fs: Indent compression_mode option list
> >   Documentation: f2fs: Reword title
> >
> >  Documentation/filesystems/f2fs.rst | 88 +++++++++++++++++-------------
> >  1 file changed, 50 insertions(+), 38 deletions(-)
> 
> Jaegeuk, are you going to pick this up, or would you like me to?

Hi, I applied them in the f2fs tree, if you don't mind.

> 
> Thanks,
> 
> jon

