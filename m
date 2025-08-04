Return-Path: <linux-kernel+bounces-755167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B777B1A269
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2123B0083
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 12:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EAD258CD8;
	Mon,  4 Aug 2025 12:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WeHU/SnZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DEB1B4F2C;
	Mon,  4 Aug 2025 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754312304; cv=none; b=hGisyMsyUA8A59lZfjcDLjZqtF6Ax6p2j/KmJ57C6d/+sQFKlh1YSbmzOMarbfXWJJRTPgFgnlCY0vXPXrRLLYaB1SXNwrTApySLOmTucsOgVJYi2ERIWBOzohBgr3wS3cMI3p7JMWv4RM8v+xh8Mlat2MfPx/XriQxqYa9DEM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754312304; c=relaxed/simple;
	bh=2W68ZxzxwmCvFJTFLMvFHvXt1mr9ikcmL/BnDPMrVfU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bn4JJbuALryZIdCzqh13LT8fQGfSHUqflhogc++Xj5mvHJsvaihyHa1d4JQqNuwBTkikMgrRP42IXjFUrZ0pI03NfXHJemFT3LCRAq78Sy5N9/qy4StJzEInYdmdzQwkHGoRS9UEyjeQ38zQISzEymNdPI3zSzFYmd1Q3ldZlcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WeHU/SnZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8093EC4CEE7;
	Mon,  4 Aug 2025 12:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754312303;
	bh=2W68ZxzxwmCvFJTFLMvFHvXt1mr9ikcmL/BnDPMrVfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WeHU/SnZ3/5HQC+zk1mcc+LcR/R5fePSziWknJaBQ1efLA0028ho6tniZDft09X8V
	 KJnDGr6vO21tiNMWyvbtHXtaI1AmuICJw1It5BhEKPK9ITvY0V8X8PPtVeD8kmOYd7
	 /CkoUc8U93m9PnQ4Wc227SDtfAtSpciJ5hd08fkiXyfXgpQ5Jqvqya3gE7NzzTohsy
	 fXm6R/b41BFx0GSa9yXvkXGahqmWeYU2fQiARTc4jI62GwldaPNu1OkFIhXvlZXviU
	 V/ygsgjfml7TevO3lF6XDOjZTt4hysCTK1daBsca8P5dg4FgGyt6d205AdVFr9XE1N
	 U75gWS/eSAu4g==
Date: Mon, 4 Aug 2025 14:58:18 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 03/12] docs: kdoc: backslashectomy in kdoc_parser
Message-ID: <20250804145818.3cc73ca2@foz.lan>
In-Reply-To: <87h5yrruki.fsf@trenco.lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-4-corbet@lwn.net>
	<20250801062710.552dac5a@foz.lan>
	<87h5yrruki.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 01 Aug 2025 08:21:49 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Thu, 31 Jul 2025 18:13:17 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> >> A lot of the regular expressions in this file have extraneous backslashes  
> >
> > This one is a bit scary... It could actually cause issues somewhere.  
> 
> What kind of issues?

I caught several issues in the past due to the lack of it. Don't
recall the specific cases, but using reserved symbols without
backslashes have giving me enough headaches.

Yet, see POSIX rules for some cases:

	https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_03

like this one:

	"The character sequences "[.", "[=", and "[:" shall be special
	 inside a bracket expression"

Basically, if you don't know exactly what you're doing, and just
place special characters there without extra case, you may be
in serious troubles. And see, this is just for BRE (basic regular
expressions). There are also other weirdness with ERE (extended
regular expressions):

	"The <period>, <left-square-bracket>, <backslash>, and 
	 <left-parenthesis> shall be special except when used 
	 in a bracket expression"

> > Also, IMHO, some expressions look worse on my eyes ;-)  
> 
> Here I think we're going to disagree.  The extra backslashes are really
> just visual noise as far as I'm concerned.
> 
> >> that may have been needed in Perl, but aren't helpful here.  Take them out
> >> to reduce slightly the visual noise.  
> >
> > No idea if Perl actually requires, but, at least for me, I do prefer to
> > see all special characters properly escaped with a backslash. This way,
> > it is a lot clearer that what it is expecting is a string, instead of
> > using something that may affect regex processing.  
> 
> I guess my point is that, in the given cases, the characters in question
> *aren't* special.

They are special in the sense that we're using characters that
have meanings in regular expressions and even placing them on
a random order may cause POSIX violations (and eventually cause
troubles if, for instance, we need to use "regex" instead of "re",
or if someone fixes python native "re" to be more POSIX compliant.

> >> -        param = KernRe(r'[\[\)].*').sub('', param, count=1)
> >> +        param = KernRe(r'[)[].*').sub('', param, count=1)  
> >
> > This one, for instance, IMHO looks a lot worse for my eyes to understand
> > that there is a "[" that it is not an operator, but instead a string.
> > The open close parenthesis also looks weird. My regex-trained eyes think
> > that this would be part of a capture group.  
> 
> ...and mine say "that's in [brackets] why are you escaping it?" :)

Heh, all those years writing and reviewing kernel code, for me
seeing unmatched parenthesis/brackets really bugs me... perhaps
it starts some sort of TOC syndrome ;-)

Perhaps one alternative would be to have a separate var, like:

	# Before touching this, see:
	# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html#tag_09_04
	# As some char sequences inside brackets have special meanings
	escape_chars = ")["

	param = KernRe(rf'[{escape_chars}].*').sub('', param, count=1)  

or to use re_escape().

> >>          if dtype == "" and param.endswith("..."):
> >>              if KernRe(r'\w\.\.\.$').search(param):
> >> @@ -405,7 +405,7 @@ class KernelDoc:
> >>  
> >>          for arg in args.split(splitter):
> >>              # Strip comments
> >> -            arg = KernRe(r'\/\*.*\*\/').sub('', arg)
> >> +            arg = KernRe(r'/\*.*\*/').sub('', arg)  
> >
> > A pattern like /..../ is a standard way to pass search group with Regex
> > on many languages and utils that accept regular expressions like the
> > sed command. Dropping the backslash here IMHO makes it confusing ;-)  
> 
> ...but it is definitely not any such in Python and never has been, so
> escaping slashes looks weird and makes the reader wonder what they are
> missing.

After re-reading, this specific change is actually ok, but yeah, I
still need to read it twice or three times, as on sed, perl and other
languages that are more POSIX compliant, /re/ means a regex delimiter:

	https://en.wikipedia.org/wiki/Regular_expression

> > Seriously, IMHO this patch makes a lot worse to understand what brackets,
> > parenthesis and dots are strings, and which ones are part of the regex
> > syntax.   
> 
> So I guess I won't fight this one to the death, but I really do
> disagree.  Writing regexes in a non-canonical style just makes it harder
> for anybody else who comes along to figure out what is going on; it
> certainly made it harder for me.

Heh, for me, my main concerns are:
- unmatched brackets/parenthesis
- POSIX violations - it may work today, but future Python versions
  that fix "re" module will cause regressions. It is also annoying
  to write/understand regex that only works on Python.

I can live with the other ones.

Thanks,
Mauro

