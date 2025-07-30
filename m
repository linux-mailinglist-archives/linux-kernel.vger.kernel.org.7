Return-Path: <linux-kernel+bounces-751229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA446B166AA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4AF623F92
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05DB82E2672;
	Wed, 30 Jul 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2xmh5F7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04E18DB0D;
	Wed, 30 Jul 2025 18:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901970; cv=none; b=tE7FSYwMSv0K5UZ6J5TAsbCzo8/0zgtXqt227cfluhYoV80jNl+23icw7uBxz8+qL3Fd7jTsHUutRu3rGlxoRYkrUFOg9QAPKm3P6eMd8/zYLf/Y4OWPslkT08TbYpUnhAqlXUv4O///IpwcdZB0lEqzUhws8kBqVYWBH6449Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901970; c=relaxed/simple;
	bh=zUi6+hvnnojo5SL2vIkde3UuDJG8e0E2JNKftV/OqZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJSt1UvAkBqrBZjIWs5uMQr5Shz4nhDoHz9SeqQkiVvs0EtpTzZ+muwZfIusizBTmTOVpLpTqQXfsLIXt3VlkC4T/idKAitAT8lS2pHfZfDlCGXHhkrn/XW5OIZ5ATxIwIJTHE7MUZHR+nQp4DR2iKVDotp+Ou/g+IaXSXAQaME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2xmh5F7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 642FAC4CEE3;
	Wed, 30 Jul 2025 18:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753901969;
	bh=zUi6+hvnnojo5SL2vIkde3UuDJG8e0E2JNKftV/OqZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2xmh5F7xnqCUQVwwufx4Mpz6GTshhz0oQKJKmjn2q960Jin5mhuyI4XrQnSj/Qyx
	 TdVeShowZDEN7h4jj6C9+QU9cR/DgEs4S14uBfe0pwxA2YiPPvxv4WoSMWSTAPyKpV
	 CSN1x6ZTV+El0nPc2C6kCNtOoLWlrRvLliAas80AJLGy17F8YPY2kEaI6eM6qmwcCL
	 qXA7WYtlkSCLmeRr/40+1qPovVxbNl2BIJES3WL/2x7hP++sC6BjE5ytnb9s1sB4WT
	 Fxtvt8OcIrSFhDnkVhi78NN8AJkW9I9hQjWCOJXibIqX62w7Du1SND3Q+Ykh6QeBmH
	 OJNDJCJAf1OHA==
Date: Wed, 30 Jul 2025 14:59:27 -0400
From: Sasha Levin <sashal@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIprj_SFsYv2ABRo@lappy>
References: <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <20250730130531.4855a38b@gandalf.local.home>
 <aIpah6DTRd99mMqb@lappy>
 <20250730175909.GO222315@ZenIV>
 <aIpgEpe6z2Ykyymh@lappy>
 <9e471218-35a2-4e22-8826-40576919e737@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9e471218-35a2-4e22-8826-40576919e737@lucifer.local>

On Wed, Jul 30, 2025 at 07:24:13PM +0100, Lorenzo Stoakes wrote:
>On Wed, Jul 30, 2025 at 02:10:26PM -0400, Sasha Levin wrote:
>> On Wed, Jul 30, 2025 at 06:59:09PM +0100, Al Viro wrote:
>> > On Wed, Jul 30, 2025 at 01:46:47PM -0400, Sasha Levin wrote:
>> >
>> > > Similarily the argument around not trusting the code is equivalent to
>> > > not trusting the person who sent the code in. AI doesn't send patches on
>> > > it's own - humans do. This is basically saying "I didn't even look at
>> > > your patch because I don't trust you".
>> >
>> > One name: Markus Elfring.  Ever tried to reason with that one?  Or Hillf
>> > Danton, for that matter.
>> >
>> > And I absolutely will refuse to take patches from somebody who would
>> > consistently fail to explain why the patch is correct and needed.  Sasha,
>> > this is the elephant in the room: we *ALREADY* get "contributions" that
>> > very clearly stem from "$TOOL says so, what else do you need?" kind of
>> > reasoning and some of that dreck ends up in the tree.  AI will serve as
>> > a force multiplier for those...  persons.
>>
>> This is exactly my argument Al :)
>>
>> You, as a maintainer, should be able to just reject patches without
>> having to provide a technical explanation for each patch you ignore.
>>
>> If someone new comes along and bombards you with AI generated crap and
>> useless review comments, you should be able to just block him and point
>> to something under Documentation/ that will support that decision.
>
>I'm in alignment with Al and your view here FWIW!
>
>Though I do think Steven has a point in that there must be a _good reason_
>that aligns with the community for doing so, and it shouldn't be arbitrary.

I don't disagree with Steve: Ideally there is a technical reason to
block submissions, but as this is a judgement call I'd rather defer it
to the maintainer (usually people don't become maintainers by making bad
decisions :) ).

The tricky part is that this is all subjective... What's "good enough"?

As a compromise, what about allowing a maintainer to block submissions
without having to provide a technical reason, but then offer a path of
escalation with the TAB to mediate between the developer and the
maintainer?

-- 
Thanks,
Sasha

