Return-Path: <linux-kernel+bounces-621006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E701EA9D28A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 21:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A36A7B814C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Apr 2025 19:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4F21D3ED;
	Fri, 25 Apr 2025 19:59:38 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26A121ABB0
	for <linux-kernel@vger.kernel.org>; Fri, 25 Apr 2025 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611177; cv=none; b=D3hU2OFHMaYB8cLm6sfuTfteSTCghSrN84xAbgCa59f1yfckUxpUF6SAg2gfMxt4w+Evd+GXl97YPgr53UIR0sGy8SfzQS/xsLTa/jfGT20VY3zaS8E3EfsSbuhCs8S0QlKnhnxFBWZK15cpCghXRW2N8rIFqt29Xakb7C+uedY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611177; c=relaxed/simple;
	bh=dv5nrRDQ024hclXCIrsYeTX+noYKL7nkO+/IfBNfyUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PECPiQ+5eUqsxayJNFXNuV1i9/ITCc75VhhfSl0y05vKPesg2sHMspjPvCk2isRo+HyiBR27eX3x6H5MEEJbjUfphhdEIXRgro5SGWC93OE9s/MNZ98fEScahxPiGpqw0cWlwyRNjRq64te7mMxoES3eAWsub5VinpUDXH43tcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from macsyma.thunk.org ([76.232.5.185])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 53PJxBYU027224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Apr 2025 15:59:11 -0400
Received: by macsyma.thunk.org (Postfix, from userid 15806)
	id D43D0346177; Fri, 25 Apr 2025 14:59:10 -0500 (CDT)
Date: Fri, 25 Apr 2025 14:59:10 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <20250425195910.GA1018738@mit.edu>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>

The resaon why I pushed for case folding was because Android userspace
needed it, for backwards compatibiliy with previous implementationsm
(which did use FAT), and the alternative we were replacing was this
horrific wrapfs implementation which Al refused to accept because it a
mess from a locking perspective; I could trivially lock up the kernel
or cause file system corruptions using fsstress when wrapfs was in the
picture.

Another use case was Valve who wanted to support Windows games that
expcted case folding to work.  (Microsoft Windows; the gift that keeps
on giving...)  In fact the engineer who worked on case folding was
paid by Valve to do the work.

That being said, I completely agree with Linus that case insensitivity
is a nightmare, and I don't really care about performance.  The use
cases where people care about this don't have directories with a large
number of entries, and we **really** don't want to encourage more use
of case insensitive lookups.  There's a reason why spent much effort
improving the CLI tools' support for case folding.  It's good enough
that it works for Android and Valve, and that's fine.

As far as Unicode changing over time, in practice, we don't really
need to care.  Unicode has promised not to make backwards incompatible
changes; they might add new characters, for some ancient Mesopotamian
script that only some academic care about, or a new set of emoji's.
Fortunately, either the case folding tables aren't getting extended
(emoji's don't have case to be folded; the ancient sumarian script
might note have the concept of case in teh first place) or we just
don't care (even if said sumarian script did *have* case folding, it's
unlikely that a cell phone user or a Valve gamer would likely to
care).

I will readily admit that Unicode is something we didn't completely
understand; never in my worst nightmares that someone would be
silly/insane enough to add the concept of zero-width characters,
including zero-width characters that end up changing how the character
is displayed (e.g., a red heart versus a black spade differs only by
adding a zero-width selector/shift character.   Sigh....)

Perhaps if we were going to do it all over, we might have only
supported ASCII, or ISO Latin-1, and not used Unicode at all.  But
then I'm sure Valve or Android mobile handset manufacturers would be
unhappy that this might not be good enough for some country that they
want to sell into, like, say, Japan or more generally, any country
beyond US and Europe.

What we probably could do is to create our own table that didn't
support all Unicode scripts, but only the ones which are required by
Valve and Android.  But that would require someone willing to do this
work on a volunteer basis, or confinuce some company to pay to do this
work.  We could probably reduce the kernel size by doing this, and it
would probably make the code more maintainable.  I'm just not sure
anyone thinks its worthwhile to invest more into it.  In fact, I'm a
bit surprised Kent decided he wanted to add this feature into bcachefs.

Sometimes, partitioning a feature which is only needed for backwards
compatibiltiy with is in fact the right approach.  And throwing good
money after bad is rarely worth it.

Cheers,

						- Ted

