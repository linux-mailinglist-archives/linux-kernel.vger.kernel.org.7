Return-Path: <linux-kernel+bounces-861692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F35BF35DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 22:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541F34070F4
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 20:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD442D948F;
	Mon, 20 Oct 2025 20:18:46 +0000 (UTC)
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5585A29ACE5
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=107.191.43.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991526; cv=none; b=WjDlGb/3q6FSfubwtBOcGWLSr4beCX2yZrAVau8g/JDOITft/pzWUJ3l1Q7HF8yWOLGZCVJSh2ksDYuGJQSuhnOtb3/cBC5leKBbVZW6I0CkXeTb88SDHfR06PgBznnMfrT6tE4KHFvufO3kkVS7Ti3pnHXq0vpWBuJmH9Y+Tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991526; c=relaxed/simple;
	bh=mRsspvS4GSDk7FCyLt6d8jksX0zrgFXWBP1p98LUeJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HZi3PramNlsEUMCceLdKniFnEdWefYGIPlYcJzPrSoShASkv/QMCQsLGfJrEMLyejj4mqjsWEcGgUclsHvI7hsy0bnTzIQqh9O+NBZcvjSSeqhWIOJf41OxskVZW+rULJ3a6di3oLrRWiORecXNWr1f7JuoF7PotWfM8NqjDXdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name; spf=pass smtp.mailfrom=kevinlocke.name; arc=none smtp.client-ip=107.191.43.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kevinlocke.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kevinlocke.name
Received: from kevinolos.kevinlocke.name (unknown [198.60.113.91])
	(Authenticated sender: kevin@kevinlocke.name)
	by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 8EB484562BC5;
	Mon, 20 Oct 2025 20:18:34 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
	id 7D14713001C9; Mon, 20 Oct 2025 14:18:32 -0600 (MDT)
Date: Mon, 20 Oct 2025 14:18:32 -0600
From: Kevin Locke <kevin@kevinlocke.name>
To: David Laight <david.laight.linux@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: remove unnecessary x suffix in test strings
Message-ID: <aPaZGKyY_5ybTwda@kevinlocke.name>
Mail-Followup-To: Kevin Locke <kevin@kevinlocke.name>,
	David Laight <david.laight.linux@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
References: <20251016214707.5c3d373b@pumpkin>
 <a1fb08a30cbd6682e3ca218447573d4c62034003.1760658427.git.kevin@kevinlocke.name>
 <20251017151256.111f2669@pumpkin>
 <aPLC_HdznsRcJbjk@kevinlocke.name>
 <20251019111748.3d5ac8d9@pumpkin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251019111748.3d5ac8d9@pumpkin>

On Sun, 2025-10-19 at 11:17 +0100, David Laight wrote:
> On Fri, 17 Oct 2025 16:28:12 -0600 Kevin Locke <kevin@kevinlocke.name> wrote:
>> On Fri, 2025-10-17 at 15:12 +0100, David Laight wrote:
>>> On Thu, 16 Oct 2025 17:47:09 -0600 Kevin Locke <kevin@kevinlocke.name> wrote:  
>>>> Remove the "x" suffixes which unnecessarily complicate the code.  
>>> 
>>> The problems arise when $1 is (say) "-x", a simple LR parser will treat
>>> [ -x = -x ] as a check for the file "=" being executable and then give
>>> a syntax error for the second -x.
>>> I can't imagine why shellcheck should warn about a leading x (or any other
>>> character) provided field splitting is disabled (eg by "").
>>> The leading x has definitely been needed in the past.  
>> 
>> Yep, it definitely has been.  The rationale on the wiki is that it's
>> not necessary for modern shells (and presumably that it unnecessarily
>> complicates the code): https://www.shellcheck.net/wiki/SC2268
>> However, it notes Zsh had issues as recently as 2015, which is not as
>> old as I would have expected.
> 
> It doesn't really make much difference to the shell.
> I really doubt you'll notice any difference in the time it takes to run.

I agree.  However, I'm more concerned about readability and
understandability for developers less familiar with the quirks of old
shells.

>>> POSIX does require the three argument 'test' look for the middle argument
>>> being an operator - but there might be historic shells that don't so that.
>>> OTOH you are probably looking for code from the early 1980s!
>>> But the POSIX spec (last time I read it) does point out the problems
>>> with arbitrary strings being treated as operators causing complex expressions
>>> be mis-parsed - which a leading x fixes.  
>> 
>> Good point.  I just reread it and can confirm that the current version
>> still notes issues mitigated by the X prefix with "historical shells"
>> and with greater than 4 argument cases:
>> https://pubs.opengroup.org/onlinepubs/9799919799/utilities/test.html
> 
> The fact that the 'greater than 4 argument case' can still require
> a prefix character might be considered enough to make adding one all the
> time 'good practise' even though it (probably) isn't actually needed.

That seems reasonable to me, although I'd prefer omitting x and
prohibiting >3 argument cases, which appears to be the route
shellcheck takes with SC2268 + SC2166.

> While I wouldn't error not having a prefix, generating an error when
> there is one seems wrong.
> What does shellcheck do with [ "$a" = "$b" -o "$c" = "$d" ] ?

It only produces SC2166 (discouraging -o).  However, for 
[ "x$a" = "x$b" -o "x$c" = "x$d" ] it also produces SC2268.

> Or even [ "$a" "$b" "$c" "$d" "$e" "$f "$g" ] ??

This, and [ "$a" "$b" "$c" ] and [ "$a" "$b" ] produce parser error
SC1073.  Unfortunately, this appears to be a long-standing shellcheck
issue:  https://github.com/koalaman/shellcheck/issues/1645

>> I find && and || more readable, but I'm open to changing it if you
>> feel strongly.
> 
> They get parsed entirely differently and are likely to be measurably slower.
> Just FYI I tend not to use 'if' statements at all, just (eg):
> 	[ a = b ] && echo a == b
> 
>> Do I understand correctly that you are in favor of using the x prefix?
>> I have a slight preference for leaving it off, but I'm open to adding
>> it if you (or others) feel strongly.
> 
> I wouldn't take them out and consider shellcheck wrong, but the suffix
> were just stupid.

Are you opposed to the patch I posted removing the suffixes?  I had
tagged you as Suggested-by due to misreading your first post.  If the
change is not something you'd suggest, I can repost without it.

Thanks,
Kevin

