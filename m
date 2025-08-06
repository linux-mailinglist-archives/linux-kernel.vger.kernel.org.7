Return-Path: <linux-kernel+bounces-757501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C15B1C2E0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:07:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A20216B336
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6631FECD4;
	Wed,  6 Aug 2025 09:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAfQ2HUd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8081F9EC0;
	Wed,  6 Aug 2025 09:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754471143; cv=none; b=Cr/mKk2VWoWBEHqXE4jpWHO0NixCinO9rNICMBU37eZ5xt/R8SI2tGnnIJhu/jK4CHPfef5CeeOzQAMrBm5l71GSKDxgsQUtRPZK5AhX6M0TNDhFkgMZj0qswrEHQ3UhcMyZ5bG6dKuRPZAAjrZwYjYegFp5bZV87Kj6N+ipJwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754471143; c=relaxed/simple;
	bh=HJ2Vdqce5q53Z4X8gWRYDViukTz5Nztf0mQCr9Y9UE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYbxgLNTK/5fJYKOOzwK551t3FCThZ5Ub9tm6lkz8UttQTkzP2coHNIUf5xVi/T1CWLk3eTQgm81mXrbQJhZh9o/GEnnNposVbSFwZeFoPu/8QNJq4n35kS2yxTap+kuUm+jQ5ncxpJQprAZzvmI1VsATwGn/aH8yceryBaoDk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAfQ2HUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA70C4CEE7;
	Wed,  6 Aug 2025 09:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754471142;
	bh=HJ2Vdqce5q53Z4X8gWRYDViukTz5Nztf0mQCr9Y9UE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eAfQ2HUdQ+zar9zQIGr+7F6sQrrXTpbQ+Him7njvXYaBRgxEiMcSbh52S2xDmL1Xj
	 G4jkR7/Fi5BI5mL76Hcy1hPI6N60YDfrsvmxL0v6vT2NbBkR+NjXuvuDOCsCDZWZvE
	 jYUlZNx+pvNTAI/3ZPisoOavzwjR/WV6x8TFwPkVJvUZn5yU3wde8uUfg+rOi3Xzl4
	 Lo6+6S+q1fLThPOhM3OLW6HWDgJaskMrsGZNpe0L8elyqnoryAWEUYZam1KvlgYm5S
	 ZFwK71Xnsdq2P6Z3qigl1Lk70JDI51WU9kvSo3Ls1THBAf2K6ynSFKwfsgmR4ezKer
	 CbnkBV3YFCNMA==
Date: Wed, 6 Aug 2025 11:05:38 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: further rewrite_struct_members()
 cleanup
Message-ID: <20250806110538.35bcc127@foz.lan>
In-Reply-To: <87ms8djsjx.fsf@trenco.lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-11-corbet@lwn.net>
	<20250801080744.14f83626@foz.lan>
	<87v7n6pscu.fsf@trenco.lwn.net>
	<20250804151511.73ffb949@foz.lan>
	<87ms8djsjx.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Tue, 05 Aug 2025 16:46:10 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Perhaps one alternative would do something like:
> >
> > 	tuples = struct_members.findall(members)
> >         if not tuples:
> >             break
> >
> > 	maintype, -, -, content, -, s_ids = tuples
> >
> > (assuming that we don't need t[1], t[2] and t[4] here)
> >
> > Btw, on this specific case, better to use non-capture group matches
> > to avoid those "empty" spaces, e.g. (if I got it right):  
> 
> The problem is this line here:
> 
>                 oldmember = "".join(t) # Reconstruct the original formatting
> 
> The regex *has* to capture the entire match string so that it can be
> reconstructed back to its original form, which we need to edit the full
> list of members later on.
> 
> This code could use a deep rethink, but it works for now :)

well, we can still do:

	for t in tuples:
	    maintype, -, -, content, -, s_ids = t
	    oldmember = "".join(t)

this way, we'll be naming the relevant parameters and reconstructing
the the original form.

IMO, this is a lot better than using t[0], t[3], t[5] at the code,
as the names makes it clear what each one actually captured.

-

Btw, while re.findall() has an API that doesn't return match
objects which is incoherent with the normal re API, while looking
at the specs today(*), there is an alternative: re.finditer(). 
We could add it to KernRE cass and use it on a way that it will use
a Match instance. Something like:

	# Original regex expression
	res = Re.finditer(...)

	# Not much difference here. Probably not worh using it
	for match in res:
	    oldmember = "".join(match.groups())
            maintype, -, -, content, -, s_ids = match.groups()

Or alternatively:

	res = Re.finditer(...)

	# Not much difference here. Probably not worth using it
	for match in res:
	    oldmember = "".join(match.groups())

		# replace at the code below:
		#	maintype -> match.group('maintype')
		#	content -> match.group('content')
		#	s_ids -> match.group('s_ids')

No idea about performance differences between findall and finditer.
(*) https://docs.python.org/3/library/re.html

btw, one possibility that would avoid having tuples and t is
to do something like:

	struct_members = KernRe("(" +			# group 1: the entire pattern
				type_pattern +	        # Capture main type
				r'([^\{\};]+)' +
				r'(?:\{)' +
				r'(?:[^\{\}]*)' +	# Capture content
				r'(?:\})' +
				r'([^\{\};]*)(;)')	# Capture IDs
				")")

	match = struct_members.finditer(line)
	for match in res:
	    oldmember, maintype, content, s_ids = match.groups()

(disclaimer notice: none of the above was tested)
	

Thanks,
Mauro

