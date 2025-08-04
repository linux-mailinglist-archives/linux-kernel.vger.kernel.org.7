Return-Path: <linux-kernel+bounces-755206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EE1BB1A2FE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E883A4813
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 13:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E124323A989;
	Mon,  4 Aug 2025 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AsMQKEGF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDBA2441AA;
	Mon,  4 Aug 2025 13:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754313316; cv=none; b=nQSNHStN/G1FpaQxFX7gDcAvesDspjIBxWUZdLpiBJNmE5HVgAMTdVjO4lrnvPv69ccT9HCZa3pEhFWA9uiOr/7JfoctdpHPeCG8vHOi8tpO6+kqU7HzXMg7bMBjXZ/BvjIoG5jeLuSP+1SlsVrQIKtRFklrlSJbB96pmXb3P1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754313316; c=relaxed/simple;
	bh=QQXJ4NR1uMu1IgN3dl3PuSK8BLu/j4cxH3A+dzF6q9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drXEeFz/ZzVHQAf7btkX/1k7xjs1HJFBGhQxfw7wcb6y8RoY9ClcSrzQGrdmo/cJQYHVNcavgsfyip22wQEwSEKCERvsHjp0mHCJTLa+pbChKuI1K8xHjRMm/iAoPSw5yV3SCERZFgilc365nuj9Lb6WBcjsZ3Vb65X3MzzhitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsMQKEGF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7BFC4CEE7;
	Mon,  4 Aug 2025 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754313315;
	bh=QQXJ4NR1uMu1IgN3dl3PuSK8BLu/j4cxH3A+dzF6q9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AsMQKEGFwZNq2l5woPe55/esgSkEYeIaPOIMktIPP6W7AHtIWuXM8PDvAPwtYIDTD
	 Kp3MA6oCztFzWcDXqFSJzXS0P+izV5aHaDnxSD70IIJW8iLfklMreXe8IqnqXI6iYW
	 6C+jFKI2ChiBLzdGQ8CCLtrSP3HTtFRR4Y4Gfhk6bH6SgnvfPirhtCDyNFehg57tqX
	 fC03I7uEVJ3mjsjGSH8zqwmGD/dCmV6MdQqSEtg3RhzN93YB+tcbzbt8dK4r4Y8DQH
	 fLotzguyw2IAxOfvvqOV5COCs3b8CRQ+/i1/0aFIsMDSlsVHtg7kUk62ZyXA4oZVOC
	 O0vaaGP3zdkLQ==
Date: Mon, 4 Aug 2025 15:15:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: further rewrite_struct_members()
 cleanup
Message-ID: <20250804151511.73ffb949@foz.lan>
In-Reply-To: <87v7n6pscu.fsf@trenco.lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-11-corbet@lwn.net>
	<20250801080744.14f83626@foz.lan>
	<87v7n6pscu.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 01 Aug 2025 16:52:33 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Thu, 31 Jul 2025 18:13:24 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> >> Get rid of some single-use variables and redundant checks, and generally
> >> tighten up the code; no logical change.
> >> 
> >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> >> ---
> >>  scripts/lib/kdoc/kdoc_parser.py | 89 ++++++++++++++++-----------------
> >>  1 file changed, 42 insertions(+), 47 deletions(-)
> >> 
> >> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> >> index 20e0a2abe13b..2b7d7e646367 100644
> >> --- a/scripts/lib/kdoc/kdoc_parser.py
> >> +++ b/scripts/lib/kdoc/kdoc_parser.py
> >> @@ -673,73 +673,68 @@ class KernelDoc:
> >>          while tuples:
> >>              for t in tuples:
> >>                  newmember = ""
> >> -                maintype = t[0]
> >> -                _ids = t[5]s
> >> -                content = t[3]  
> >
> > The reason I opted for this particular approach...  
> >> -
> >> -                oldmember = "".join(t)
> >> -
> >> -                for s_id in s_ids.split(','):
> >> +                oldmember = "".join(t) # Reconstruct the original formatting
> >> +                #
> >> +                # Pass through each field name, normalizing the form and formatting.
> >> +                #
> >> +                for s_id in t[5].split(','):  
> >
> > ... is that it is easier to understand and to maintain:
> >
> > 	for s_id in s_ids.split(','):
> >
> > than when magic numbers like this are used:
> >
> > 	for s_id in t[5].split(','):  
> 
> Coming into this code, I had a different experience, and found the
> variables to just be a layer of indirection I had to pass through to get
> to the capture groups and see what was really going on.  That was part
> of why I put the group numbers in the comments next to that gnarly
> regex, to make that mapping more direct and easier to understand.
> 
> I will not insist on this change either - at least not indefinitely :)
> I do feel, though, that adding a step between the regex and its use just
> serves to obscure things.
> 
> (And yes, I don't really think that named groups make things better.
> I've found those useful in situations where multiple regexes are in use
> and the ordering of the groups may vary, but otherwise have generally
> avoided them).

I'd say that, when the magic number is within up to 3-lines hunk
distance - e.g. if all of them will appear at the same hunk, it is 
probably safe to use, but when it gets far away, it makes more harm 
than good.

Perhaps one alternative would do something like:

	tuples = struct_members.findall(members)
        if not tuples:
            break

	maintype, -, -, content, -, s_ids = tuples

(assuming that we don't need t[1], t[2] and t[4] here)

Btw, on this specific case, better to use non-capture group matches
to avoid those "empty" spaces, e.g. (if I got it right):

	# Curly Brackets are not captured
        struct_members = KernRe(type_pattern +	        # Capture main type
				r'([^\{\};]+)' +
				r'(?:\{)' +
				r'(?:[^\{\}]*)' +	# Capture content
				r'(?:\})' +
				r'([^\{\}\;]*)(\;)')	# Capture IDs
	...
	tuples = struct_members.findall(members)
        if not tuples:
            break

	maintype, content, s_ids = tuples

Btw, a cleanup like the above is, IMHO, another good reason why not using
magic numbers: people may end fixing match groups to use non-capture
matches, but end forgetting to fix some hidden magic numbers. It is hard
for a reviewer to see it if the affected magic numbers aren't within the
3 lines range of a default unified diff, and may introduce hidden bugs.

Thanks,
Mauro

