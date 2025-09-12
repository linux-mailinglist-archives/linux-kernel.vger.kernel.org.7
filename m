Return-Path: <linux-kernel+bounces-813437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E224B54564
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A80846590D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D122D77E0;
	Fri, 12 Sep 2025 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="heMrIWKO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B32D63E2;
	Fri, 12 Sep 2025 08:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665700; cv=none; b=dwSJSfZfUPmH5+Z8w/bQZYIE6PGg6YyuI7u/IaNIQnBn+UHSpcqZ4K793YM9+5ROgsJTy1M8783VDq1NxiWM5wqm+YNx4of2LOPM0qHeHPRuw93ynXEfBaYQJwP55RzxUcjaRCvx69vCOgSbM1yDUDNBpGp3MvxOrMFNEKgJjLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665700; c=relaxed/simple;
	bh=n1EW4vy65nSPoafSwWSgXqad37bTolvO1cf0oGnHTWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxNbQJF2wDwtSxuWVUAseb7lnVwWHLSOrFbWdCMB/6DqO0U7IeA6GkUTF1dmA3XEufPtSjzRQ8WQr3e6wstBG47pWP8A2cWs7fAG+MsOleaPtzf4MljDSvE+Awelm24UIhYfQwRZiHkEiDAVzn1yOSInzm/stqN3Vx0YNAdB9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=heMrIWKO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512A3C4CEF4;
	Fri, 12 Sep 2025 08:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757665698;
	bh=n1EW4vy65nSPoafSwWSgXqad37bTolvO1cf0oGnHTWA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=heMrIWKOSv80U/xz5fRNyHaY47UB3AKqXNR30TWBXKEuwFKKAihGB2Ts+rpO5w5Sv
	 SZolg0L0DOBn9xMMvDTsH+jfmQcn7ju81LlqMHVjQ68zo88sBz+vVDEUGKs4PAy8zs
	 JZiCbWaKIG1G4cCgexplVHiGWJAbcoANp4oiZ8c8XYe5B/N4UbN9+mIWf525PkgVj1
	 SFfE1WFslqHwslAkooJ8EpdkYgoN+mJKNBTbNJPPvBWUfkEfEB0uAkP+ESJYUfbvaC
	 XBUIjzFQcM639J5X/faL1nA5e27Czb9VArnJycIbjAUbK5FqcwNX9F+ltChMSjTTJx
	 Kqg3QiEnGDVsQ==
Date: Fri, 12 Sep 2025 10:28:13 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl
 <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a
 wrapper for sphinx-build
Message-ID: <20250912102813.6ea711ca@foz.lan>
In-Reply-To: <87zfb1p0r3.fsf@trenco.lwn.net>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
	<e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
	<e13837a0ac46dffe39c600d11fdf33f538bdc9c3@intel.com>
	<20250910145926.453f5441@foz.lan>
	<45888ca6c88071c754784495b4ef69460ea67b4f@intel.com>
	<fuv4p45tvjfdvwu2625s2l2kvcw64p4ohherlwyum3vmogmrfz@yb47nt66xgm6>
	<87zfb1p0r3.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 11 Sep 2025 07:38:56 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > On Thu, Sep 11, 2025 at 01:23:55PM +0300, Jani Nikula wrote:  
> >> > 1. SPHINXDIRS. It needs a lot of magic to work, both before running
> >> >    sphinx-build and after (inside conf.py);  
> >> 
> >> Makes you wonder if that's the right solution to the original
> >> problem. It was added as a kind of hack, and it stuck.  
> >
> > The problem is, IMHO, due to the lack of flexibility of sphinx-build:
> > It should have a way on it to do partial documentation builds.  
> 
> A couple of times I have looked into using intersphinx, making each book
> into an actually separate book.  The thing I always run into is that
> doing a complete docs build, with working references, would require
> building everything twice.  This is probably worth another attempt one
> of these years...

The big advantage of intersphinx is for PDF and LaTeX output, as
this is the only way to have cross-references there.

It is also good for subsystem-specific books (or "sub-"books) like:

	- Documentation/admin-guide/media/
	- Documentation/driver-api/media/
	- Documentation/userspace-api/media/

Right now, we create a single book with all those tree, but I would
prefer to build each of them as separate units, as they are for separated
audiences, but only if cross-references will be solved in a way that
html and pdf docs will point to the other books stored at linuxtv.org.

For html, this won't be any different, in practice, from what we have,
but for PDF and ePub, this would mean smaller books.

Thanks,
Mauro

