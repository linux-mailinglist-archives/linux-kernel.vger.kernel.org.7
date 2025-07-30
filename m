Return-Path: <linux-kernel+bounces-751270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36557B1671D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDE617314E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711811FFC46;
	Wed, 30 Jul 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ehggk69P"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325942AE74;
	Wed, 30 Jul 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753905092; cv=none; b=mRFmsx7mZJa0XPOG3SrMsqh1SbvKwt5iexzaq54rh3MGLn7drlajkS5DL+jzzqWYut+zIAnUBBQmzGBl2ON05scspl/k57Grnhmd9QYP3mFFfnMI43mJLqfpC4y8ulgUN8uu4w5f7X5FHgTHW8alNI79jyGhRfhK6xpdkTjxnQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753905092; c=relaxed/simple;
	bh=HRmlGequ1LXrIu7n3uye0HPDUx5nJmaiQl8qQDmhvlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LARj58H5iUuBytnqJ55Jk2ZvihT0SuQXU/ptxXczPfH99x2arRNQ98+TNJvkcSGGQePlX16cCc9zKzcQ8XICewVgZXlkRB3PB5G1TwTR4HWMSEXGwlORRTTuYIA9CG6iP0mOdLC2Rw2vKLSyYMGR0DUjOT+A0I73tX9nc0Kua7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ehggk69P; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Jr5B5Ll2MRZRBpBtBio3FhZl8qNTMZZnmZQZPad8Q1I=; b=Ehggk69PxvvfwAmIKHzgU3Ntnt
	xh0diAW7aZOgPsYwKpYPgutCwu9jV9Xbqf5xidgJAJgIY8pkYeshm6praQ0ZDuTNM2qLwVCh5mAXb
	9eS3UWwB2S+AD3C7cLhRTxqawMYiyJrLtJ0N9ydr3AO2vPOahNFDPbDK1Nn4KHyNOFQSjxgrKMeNO
	XeA/nui1+aqm4yA9wIU/kmVMm72vQit7Z8iS03rbrggWVsOtjisgN8p4D8WXED6oEM0JGyna+vCam
	KJJbyGMMHrrqxjexDAksBXnzkrfJ6bK/Q3q3kAkbvN1jlRWbKzlivkE5SQkwaUQU4dpVMP/r7tk1S
	sqe/MU7A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhCpe-0000000G8yV-3jpp;
	Wed, 30 Jul 2025 19:51:22 +0000
Date: Wed, 30 Jul 2025 20:51:22 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Sasha Levin <sashal@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730195122.GP222315@ZenIV>
References: <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <20250730130531.4855a38b@gandalf.local.home>
 <aIpah6DTRd99mMqb@lappy>
 <20250730175909.GO222315@ZenIV>
 <20250730191033.GA441972@mit.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250730191033.GA441972@mit.edu>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Wed, Jul 30, 2025 at 03:10:33PM -0400, Theodore Ts'o wrote:
> On Wed, Jul 30, 2025 at 06:59:09PM +0100, Al Viro wrote:
> > 
> > And I absolutely will refuse to take patches from somebody who would
> > consistently fail to explain why the patch is correct and needed.  Sasha,
> > this is the elephant in the room: we *ALREADY* get "contributions" that
> > very clearly stem from "$TOOL says so, what else do you need?" kind of
> > reasoning and some of that dreck ends up in the tree.  AI will serve as
> > a force multiplier for those...  persons.
> >
> 
> Any tool can be a force multipler, either for good or for ill.
> 
> For example, I suspect we have a much greater set of problems from
> $TOOL's other than Large Language Models.  For example people who use
> "git grep strcpy" and send patches (because strcpy is eeeevil), some
> of which don't even compile, and some of which are just plain wrong.
> Ditto people who take a syzbot reproducer, make some change which
> makes the problem go away,

The "problem" being defined as "The Most Holy Tool Is Making Unhappy
Noises; Must Appease It".

> and then submit a patch, and only for
> maintainers to point ut that the patch introduced bugs and/or really
> didn't fix the problem.

IME the real PITA is getting them to understand what the problem is.
And dealing with them without CoC getting overexcited, of course,
but that's not all that hard.

> I don't think that we should therefore forbid any use of patches
> generated using the assistance of "git grep" or syzbot.  That's
> because I view this as a problem of the people using the tool, not the
> tool itself.  It's just that AI / LLM have been become a Boogeyman
> that inspires a lot of fear and loathing.

LLM has some uniquely unpleasant properties in that area - it is designed
to generate a plausibly-sounding line of bullshit, after all...

