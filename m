Return-Path: <linux-kernel+bounces-858817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDC5BEBEC4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 00:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BC69E4EBC96
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 22:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F012D8370;
	Fri, 17 Oct 2025 22:28:18 +0000 (UTC)
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC17C25F984
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 22:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.191.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760740097; cv=none; b=GQrWcMWsF4ymG2bRT2cNlb0zXGeQ5l8rQziT0SXcYHEKR2/JryZV3CpmDO19lMPJA2fQg7LB7q8VhcADf+bmzvt1sEe0JTIB5fiPo85NReMX6zKl5rHcDx81v5Y9jYqEXRqDZi3KMVKHplGtQiyag1MGl0xxfsgL4I7kVsUMZaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760740097; c=relaxed/simple;
	bh=ij6MUkJ9dU7E4kMTI/ySrTPmiZRkB6bStcg4mIU9zX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbivH7CaE7O0mQOciPy9nxV1R8yI+Gdl4ya/VAC9c/IK3c8Zo89HgmUkC2gqSYTQBGp0/68+EoT/a+UNSYBODA3xGX3ZdqvA6GTLhfcbACTGDx4RPM+yFYDPU5N7JEtZ2qkO1oFyekT8J2VugGhDxwTnGj5Rw+z4u/GwmhvbQ8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name; spf=pass smtp.mailfrom=kevinlocke.name; arc=none smtp.client-ip=107.191.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinlocke.name
Received: from kevinolos.kevinlocke.name (unknown [IPv6:2607:24c0:2300:9fc5:8482:3d29:9ba1:1a9d])
	(Authenticated sender: kevin@kevinlocke.name)
	by vulcan.kevinlocke.name (Postfix) with ESMTPSA id D76A045610B5;
	Fri, 17 Oct 2025 22:28:13 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
	id 382D21300146; Fri, 17 Oct 2025 16:28:12 -0600 (MDT)
Date: Fri, 17 Oct 2025 16:28:12 -0600
From: Kevin Locke <kevin@kevinlocke.name>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: remove unnecessary x suffix in test strings
Message-ID: <aPLC_HdznsRcJbjk@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
	David Laight <david.laight.linux@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
References: <20251016214707.5c3d373b@pumpkin>
 <a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
 <20251017151256.111f2669@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017151256.111f2669@pumpkin>

On Fri, 2025-10-17 at 15:12 +0100, David Laight wrote:
> On Thu, 16 Oct 2025 17:47:09 -0600 Kevin Locke <kevin@kevinlocke.name> wrote:
>> Remove the "x" suffixes which unnecessarily complicate the code.
> 
> The problems arise when $1 is (say) "-x", a simple LR parser will treat
> [ -x = -x ] as a check for the file "=" being executable and then give
> a syntax error for the second -x.
> I can't imagine why shellcheck should warn about a leading x (or any other
> character) provided field splitting is disabled (eg by "").
> The leading x has definitely been needed in the past.

Yep, it definitely has been.  The rationale on the wiki is that it's
not necessary for modern shells (and presumably that it unnecessarily
complicates the code): https://www.shellcheck.net/wiki/SC2268
However, it notes Zsh had issues as recently as 2015, which is not as
old as I would have expected.

> POSIX does require the three argument 'test' look for the middle argument
> being an operator - but there might be historic shells that don't so that.
> OTOH you are probably looking for code from the early 1980s!
> But the POSIX spec (last time I read it) does point out the problems
> with arbitrary strings being treated as operators causing complex expressions
> be mis-parsed - which a leading x fixes.

Good point.  I just reread it and can confirm that the current version
still notes issues mitigated by the X prefix with "historical shells"
and with greater than 4 argument cases:
https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html

>> I think they are safe to
>> remove to clean up the code a bit.  Here's a patch to do just that,
>> which can be applied on top of my previous patch.
>> 
>> Since -o is an XSI extension to POSIX, I've stuck with ||, but I think
>> you are right that x would not be required in that case either.
> 
> I'm not sure there are any common shells that don't support -o and -a.
> They get used quite a lot.
> I'm pretty sure they were supported by the pre-POSIX System-V shells
> (or the /bin/[ program they ran).

You are probably right.  I still remember when Debian policy allowed
them and posh added support in 2007/2008:
https://lists.debian.org/debian-devel/2006/11/msg00710.html
(I was corrected by Clint Adams about -a and -o being XSI extensions
some years before then when I noted posh lacked support, which is
probably why I still remember it.)

I find && and || more readable, but I'm open to changing it if you
feel strongly.

Do I understand correctly that you are in favor of using the x prefix?
I have a slight preference for leaving it off, but I'm open to adding
it if you (or others) feel strongly.

Thanks for the interesting discussion,
Kevin

