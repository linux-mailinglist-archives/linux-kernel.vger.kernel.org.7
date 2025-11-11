Return-Path: <linux-kernel+bounces-895475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56053C4E0E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F83A7A2B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4443AA1BD;
	Tue, 11 Nov 2025 13:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="R20VSPiA"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADB7324705
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762866564; cv=none; b=UhkflZPE2xQgzGl5NrXZKX+uAQlvcNRcIignsjQiIMcy+yb1qv7wyPuTV4EybqMo5AQUO5eWWHMJvEpyd8uAIo+EZJghXYuEDjCgTi2WzN5USadniaZ+otlwTAZGYVVYe2Y1bd16XoN/gONYqqPAqNV/Wke7LWz/gvlmUFTfGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762866564; c=relaxed/simple;
	bh=P8QSnF9cHhQkGs1VCcaMb6B4xrloT45QP+6e1bZT/v0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZR3SnCAugDPp+8nZAKxbMlZl1PlUgZkoAKiLPYZzJHntu/BDAxvcMa+2Yl//Y7TphxsUoizCE11Fr0Mf/0ckF/53WbC32d+hSkXoD462WuUG4fJlXPor9pcNGgPy5cTgQ9KrxFc0nEAsoc5lYwxC+uN+G1E6XAgTKcN1ZHVb1lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=R20VSPiA; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5ABD89u3016803
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Nov 2025 08:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762866494; bh=jQdDg8n/Au5TS/d1fg4OZe2j+2EezOUxUqKVSpu6yGU=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=R20VSPiA7ksYyAalbxHzN76ne8XkfasqZtrg2KEBVCso6Kyw6mUxAxpyG4bKeez6D
	 DTD3/48BIq3sMdWHnfQZa+JIY6CiHUwYGWImaacVNuD+YvfrXRXDzUi9kAHNZ6oLaG
	 AQx95In+MWzIwHwL/asnj+in0G3XRRJvjRy7RguiDCcB8cNixaImz99NnWK+CCoe5y
	 tvZTOOf+UuYoFYAzSwxpkBTB+O9UT8FYbggKRj0IH6Ujiwq2yBr29HinlUElfIUejn
	 HJ4UO2lSLayz99mJ0niPjd48xpgSYikz4UySLeSK3j1FH6QkQHKqLST17BzhT3pd+I
	 w5uM7jwCF0xRw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id A302C2E00D9; Tue, 11 Nov 2025 08:08:09 -0500 (EST)
Date: Tue, 11 Nov 2025 08:08:09 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Christian Brauner <brauner@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
        "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <kees@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miguel Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251111130809.GB3131573@mit.edu>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
 <653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
 <20251110-weiht-etablieren-39e7b63ef76d@brauner>
 <20251110172507.GA21641@pendragon.ideasonboard.com>
 <CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
 <aRIxYkjX7EzalSoI@kernel.org>
 <CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
 <A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
 <CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
 <8bc25747-fcf0-4e45-b10a-566c5cfe771a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bc25747-fcf0-4e45-b10a-566c5cfe771a@lucifer.local>

On Tue, Nov 11, 2025 at 09:35:18AM +0000, Lorenzo Stoakes wrote:
> 
> Now 'any idiot' can fire off hundreds of patches that look at a glance as
> if they might have some validiity.
> 
> The asymmetry of this is VERY concerning.
> 
> I also hate that we have to think about it, but the second the press put
> out 'the kernel accepts AI patches now!' - and trust me THEY WILL - we are
> likely to see an influx like this that maintainers will have to deal with.

Yeah, that's an argument for not requiring any kind of AI tagging.
One of my concerns is that there's no guarantee that people flooding
the kernel with AI slop won't disclose that they used an LLM.

> 1. Maintains MUST have the ability to JUST SAY NO, go away _en-masse_ to
>    regain symmetry on this.

Maintainers do have this already.  There are certain people who are
known to be sending low priority patches, and people just quietly
ignore those patches.

The risk of AI slop is that this will just happen a *lot* more often,
which means that patches from known high quality controllers will get
far more attention than patches from newer contributors --- because we
won't know whether it's a new contributor who is coming up to speed,
or someone who is sending AI slop.  So the more AI slop we get, the
more this dynamic will accelerate, to the point where people who
accuse us of having an old "boys/girls" club will become true, and
people will accuse us of not being welcoming to new contributors.

There *will* be a solution to the symmetry; so I wouldn't consider it
"unworkable".  It's just that we (and especially newcomers) might not
like the solution that naturally comes out of it.  As you put it,
"throw out the baby with the bath water"; the system will survive, but
it might suck to be the baby.

> 2. Those who submit patches MUST UNDERSTAND EVERY PART OF IT.
> 
> 'that which can be proposed without understanding can be dismissed without
> understanding'.

Yeah, it might be that all we can do is to say that people who use
LLM's without understanding all parts of it, my result in their
blackening their reputation, wiht the result that *all* their patches
might get ignored.

And we can warn that if a company has many of its employees sending
lower quality contributions, maintainers might decide to address the
denial of service attack by ignoring *all* patches from a particular
company / domain.  We've done this before, with the University of
Minnesota, due to gross abuse leading to lack of trust of the
institution.

Hopefully things won't come to that, but maybe explicitly warning
people that *is* a possibility might be useful as a deterrent factor.

And I think it's important to say that it's low quality contributions
from AI is no different from any other kind of low quality
contributions.  And just as judges in courts of law have sanctioned
lawyers for submitting legal briefs that contained completely
hallucinated court cases, there will be costs to sending cr*p no
matter what the source.

> I think as long as we UNDERLINE these points I think we're good.
> 
> TL;DR: we won't take slop.

Agreed, completely.

						- Ted

