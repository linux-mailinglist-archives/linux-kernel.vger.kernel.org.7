Return-Path: <linux-kernel+bounces-899953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 18813C591BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2404343FFC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A010B3596F6;
	Thu, 13 Nov 2025 17:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJ9567t9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E519B2877FA;
	Thu, 13 Nov 2025 17:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763053705; cv=none; b=aDr2PThovf+22YY3Gd5NYml23BogYnnfFShjn8MN9Z/xlc8t+DU7CwxlK5T+A4irP55aG+kym33QrBjkWvZvCochDq2piIjgO6or9yAm/c4r/lh+GC6asSSQdzx7hqK8RRKNC2xynfJu/6R7LemjOGrJKJN2JyVF6L4mRIeEgi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763053705; c=relaxed/simple;
	bh=VaN/Uzv+luxCc8nrlRCto4s7AqsMNKrYTytzQNxFrzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWJceYsTQYDijKW+dic7egQsgMKaZFmGhNZerkRCTigXjbP7J3YidX27A9GTfMmo8ByT8jinJHcF+BxLJlnxEUskr5BvrR5uk5mbKFltuTf2EcRWRW1HZlHcAnI1dfiyK4NnatARxTR7ffJp/OW3AZuKKXVBDnowQaSbn0HCHNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJ9567t9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F1BC4CEF8;
	Thu, 13 Nov 2025 17:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763053704;
	bh=VaN/Uzv+luxCc8nrlRCto4s7AqsMNKrYTytzQNxFrzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJ9567t9JOy3iz4MU9JfnRat9ocmmInbEyeQJVvSNv3iLhKUFKnK47RsXzdhUlgAT
	 jdJWv1Z2L8sfKt647pBVjYxi5w5lmKZGycqn9nZU/PRi54av1LjzjJ5bZuprF9fMQz
	 TyCrffNcWvc4vvHyp7oTn8tkxxzvbkoaV805RkaYWAmFkRm03Btzc5g94/hM/Fwyj/
	 Yw0O3oHcozhill/CY86IcB9urrwJgRADbW5bzTdX2XaNpxbjUbNUMnkf7sqnRzfh5G
	 o+EC4BgG7rms9pFTsWf6xVY8/WznUDEZ8IjQLPvF24de6tXi7CRGuEiZ73GI11/Wq6
	 XBsOiQbixdyRg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vJao1-0000000BX2g-39Xb;
	Thu, 13 Nov 2025 18:08:21 +0100
Date: Thu, 13 Nov 2025 18:08:21 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] scripts: docs: kdoc_files.py: don't consider symlinks as
 directories
Message-ID: <xrekus333iar5zod65ffvcv5fz2rf657dmqbl6npc5jyff4iro@6cdqfudzlbdp>
References: <73c3450f34e2a4b42ef2ef279d7487c47d22e3bd.1763027622.git.mchehab+huawei@kernel.org>
 <878qg9ucmx.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878qg9ucmx.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Thu, Nov 13, 2025 at 09:21:26AM -0700, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > As reported by Randy, currently kdoc_files can go into endless
> > looks when symlinks are used:
> >
> > 	$ ln -s . Documentation/peci/foo
> > 	$ ./scripts/kernel-doc Documentation/peci/
> > 	...
> > 	  File "/new_devel/docs/scripts/lib/kdoc/kdoc_files.py", line 52, in _parse_dir
> > 	    if entry.is_dir():
> > 	       ~~~~~~~~~~~~^^
> > 	OSError: [Errno 40] Too many levels of symbolic links: 'Documentation/peci/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo/foo'
> >
> > Prevent that by not considering symlinks as directories.
> >
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Closes: https://lore.kernel.org/linux-doc/80701524-09fd-4d68-8715-331f47c969f2@infradead.org/
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> This looks the same as yesterday's version?

I haven't changed it (but I was assuming yesterday's version was not sent). I had some bugs related to smtp proxy at the office....

> 
> Applied, anyway, thanks.

Thanks!
> 
> jon

-- 
Thanks,
Mauro

