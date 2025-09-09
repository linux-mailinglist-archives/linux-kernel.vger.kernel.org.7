Return-Path: <linux-kernel+bounces-808599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DEBFB50218
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0C41C605D6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08898335BDA;
	Tue,  9 Sep 2025 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAiroQU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5678732CF76;
	Tue,  9 Sep 2025 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757433966; cv=none; b=SMAYAOVK6rnE77k7uDT+v8jUZ7ba30VVRb6RfUAHn+0ABJFUGXGCk+XjkvJrweUjRQgvU9BDdleqPYgUGWs/TAjPYvcbobiCnw19tYID7swxQ/vurAWPHJ6bkVb7HDNTDomlwPbT47rZN+fOGMJQ8K6mjJXoI0DRopiwsiZqBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757433966; c=relaxed/simple;
	bh=yLXnwV0Lr+ukJOtN0GH9/mtWBrSyvC0+N3bNoAnY6fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gfgFSt2qhd0IJ3dqoUnQr3NGuhZtxrG3XalCXwKR0o+LLPfLxJ/HIj5J1iu02ZciyuJypHN9Y374/gqdeuOCOVNF71tnvnqHF4oWwQzZglgE7Kdre6FruLWVt7Y+7xapCzimOJp0amdfnEhjJdUPvPN/FBij4nu09rgjQUvTdmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAiroQU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2A39C4CEF4;
	Tue,  9 Sep 2025 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757433965;
	bh=yLXnwV0Lr+ukJOtN0GH9/mtWBrSyvC0+N3bNoAnY6fI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZAiroQU9lXfGs7BSKQnsGnLowIO8JZ3XaxTenBhvfr+8kuBqohhuVEbIw0mWYs4y7
	 q5s4TQ8TiiGGvcSIN4zwf50ExVa7TZEOfTocnEHBtgTi95xTfxJjSt++ZbJY+A2iQH
	 8U+LfDH5MNFPieN2XLrafJBubLxiaEkgj5QIJrGSF4q5BIY0M4JLYNr3h76FdMNree
	 8CjHM0ZgjV4SWYVur+nMPkjLnjf68ak9uZRyAM3bIR04pbn1KYy7+6RL5neeoHDX1n
	 JK6CYx2i5rzgYXQLI7D26SnLYUlvvQ+WRwJflG/A/G9TUJW31feJRgMGAACQHRW+Gl
	 LDkLw/6KpDqjQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uw0r5-00000000Qv1-3Koo;
	Tue, 09 Sep 2025 18:06:03 +0200
Date: Tue, 9 Sep 2025 18:06:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Message-ID: <vag4cx3hivodurkpmcblu46oqnodnxrber336p24tay65q2eq7@vfm775dishdv>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <e019f951190a732f9ac0b21bcda7e49af3bd5cbd.1756969623.git.mchehab+huawei@kernel.org>
 <87ldmnwt1c.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldmnwt1c.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Tue, Sep 09, 2025 at 09:21:35AM -0600, Jonathan Corbet wrote:
> Another nit:
> 
> >         # sphinxdirs can be a list or a whitespace-separated string
> >         #
> >         sphinxdirs_list = []
> >         for sphinxdir in sphinxdirs:
> >             if isinstance(sphinxdir, list):
> >                 sphinxdirs_list += sphinxdir
> >             else:
> >                 for name in sphinxdir.split(" "):
> >                     sphinxdirs_list.append(name)
> 
> That inner loop just seems like a complicated way of saying:
> 
> 	sphinxdirs_list += sphinxdir.split()

Yeah, it sounds so ;-)

At the development code version, I had some prints there to be sure
all cases were picked, so I ended coding it as a loop. I forgot to
return it to the much nicer "+=" syntax after finishing debugging it.

-- 
Thanks,
Mauro

