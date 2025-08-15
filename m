Return-Path: <linux-kernel+bounces-770927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 329ACB2807D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 15:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BBAF1BC8A6B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D4003019DB;
	Fri, 15 Aug 2025 13:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Oz2w6BgX"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1EF3019C4;
	Fri, 15 Aug 2025 13:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755263940; cv=none; b=WrYKTG3P65pGyldzrQLAucdvh+CNhtF6M73BeSGNYeFvZLDP3brIC+YcdZELTCL/FvhkBha7+U2it08wWzEaEtivj2lCd0foO7w4I+AzJC8LV95KDXPmKsHiBMWn8ot15XcByYEfY8jDMZsSiZUE0CfotQGwyVeHl57ZY7JJ2nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755263940; c=relaxed/simple;
	bh=t8N+HXNl2JNKsVXxcJ8ZFOUyTihZhTb77YL1GHR13ik=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hbmGGXGhPf2uHIpPr20JnCsHmOvU7y8smUs4OTaLTSICh6dnl6XJMhyLbCVXheYfjJhMt+jVDC74LttsimN8eeqkMG7iUEUmwxZS+71eD3GalN6BkZYluHmj/jQYW6si3WbWAhwQj4hrLNH/dY9sw+1o1GDaQ8k9myvkWIj9YR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Oz2w6BgX; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 509E840AE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755263932; bh=PM+Z8veN76HmwT0wGJKQE7XB5+VdNOMJ+QMOyijcm4A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Oz2w6BgXxN0rGkWlLrHuSLutQadCVcFyJYxTH4YwY5iz8gzlzD7fvbf28KM69tW3I
	 qra2U0BouviWaC0dfpJ8GQJxK7kW7FtQIGOKPfCGmW2KI7T3Aytf5qDit0PtCSmk8k
	 uqN5F3xsepQiKp9mcgVs0tsbZYcBoT4upLH87YysdxQYb+I6QbxoXZaXENfa3G9sCc
	 8rJegfFF83x6IKqSmTiF1wY5Zc4sVdtCbbzyF2onh/goO5s124Mmpkm3owZ2S7vhon
	 nao492nGv5aRH5kMqoDcC9jsBcoZuV41prROw99h32nE4zqN5MuT93HExDfwHNLfa4
	 zxiK0EmtDNbvw==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 509E840AE3;
	Fri, 15 Aug 2025 13:18:52 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
In-Reply-To: <20250815071829.3d5163fc@foz.lan>
References: <20250813213218.198582-1-corbet@lwn.net>
 <20250813213218.198582-8-corbet@lwn.net> <20250814013600.5aec0521@foz.lan>
 <871ppehcod.fsf@trenco.lwn.net> <20250814080539.2218eb4e@foz.lan>
 <87wm76f1t5.fsf@trenco.lwn.net> <20250815071829.3d5163fc@foz.lan>
Date: Fri, 15 Aug 2025 07:18:51 -0600
Message-ID: <87sehsen9g.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> Between "tools/doc" and "tools/docs" I don't really have overly strong
>> feelings; if you work has the latter we can just stick with that.  If
>> you propose "tools/Documentation", though, expect resistance :)
>
> <joke>
> Heh, I'm tempted to propose:
> 	/Documentation -> /docs
> or
> 	/Documentation -> /Docs
> </joke>

I proposed the former at a maintainers summit a few years ago ... the
response was less than fully positive.  I guess the fact that docs have
the longest and only capitalized top-level directory name shows their
relative importance :)

> Ok, so let's keep tools/docs then. We need to decide about python
> lib. On my series, I'm placing at tools/docs/lib, but I guess we
> can change it later.
>
> From my side, I would prefer to have a single directory for tools,
> as we may place there things that aren't specific to docs.
>
> For instance, I have my own class that I use for command execution,
> using asyncio. The rationale is that it allows output messages in
> real time without needing to wait for the entire process to end(*).
>
> (*) I recently discovered a way to do that without needing asyncio,
>     which makes the code a little bit simpler.

This is just flushing the output buffer?  Asyncio seems like a heavy
tool for that; I guess I'm missing something.

> Either using asyncio or not, a class for such purpose is something
> that multiple tools could use. So, a generic dir like tools/lib, 
> lib/python, ... IMO makes sense.

I agree with this, anyway.  "tools/python" might end up as the winning
suggestion. 

>> As I said, my series was an RFC to see what it would look like; it did't
>> take all that long the first time around, and will be even quicker to
>> redo on top of a new base, whatever that turns out to be.
>
> With regards to the RFC, IMO we still may need to discuss how we'll end 
> placing libraries under a LIBDIR. IMO, your RFC should also propose
> a directory structure. I mean, we could have something like:
>
> 	LIBDIR     # either tools/docs/lib, tools/lib, lib/python or whatever
> 	|
> 	+---> common
> 	\---> docs
> 		|
> 	    	+---> kdoc
> 	    	\---> abi
>
> We could instead do:
> 	- flatten "common" to LIBDIR; or:
> 	- flatten "docs" to LIBDIR; or:
> 	- flatten both but keeping kdoc, abi, ... directories inside
> 	  LIBDIR; or:
> 	- have a completely flatten directory with everything
> 	  under LIBDIR.

I'm not sure we need the common/docs intermediate directory.

Meanwhile, I had a related, possibly unpopular idea...  Start with
.../tools/python/kernel and put a basic __init__.py file there;
everything else would go into that directory or before.  The imports
would then read something like:

  from kernel import abi_parser

That would make it clear which modules are ours and which come from
elsewhere.

I was planning to toss together another RFC with that scheme, again to
see what it would look like in practice.

Thoughts?

jon

