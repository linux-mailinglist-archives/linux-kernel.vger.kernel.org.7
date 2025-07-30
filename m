Return-Path: <linux-kernel+bounces-751175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85018B1660E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BA06225A5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B62222C4;
	Wed, 30 Jul 2025 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ar0QA19a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B02A29;
	Wed, 30 Jul 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753899028; cv=none; b=iA0FVbApznrlMWYPBWK9ut1ZOwAs8lp+Nlu3yaWLTB88Qe5dQQF2iW/Ar484ItZMtjLRqkk35oAr+lWJSwx7piZIehK7HlGCeb/7vBZ9IvXnGIUq+t9OjLiLvpt/O6B4hITnHQN/4265nWCi3Bawl+Qwv/JFDQzBbReQ7udf5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753899028; c=relaxed/simple;
	bh=2+R6QBBiXLtCm2dPQUTelWWWq1hY2KaY+Tb24j6CjyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NcqKoJyQMKVXVPiMc1JBB6BeDfX11HOwlfvDFVLDDETHu2dBlgO10uFMNIRFYNiqQgIVT9kYGknWdst5rMfj1syKllqJ2kWsOEzh0jG+dpthVk12VnUts2QnqBpd/kOoqLtBmMQGKt6pi+sR8YAPBDgm6NGRm2p3+u7l+KUc+Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ar0QA19a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20FEEC4CEE3;
	Wed, 30 Jul 2025 18:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753899028;
	bh=2+R6QBBiXLtCm2dPQUTelWWWq1hY2KaY+Tb24j6CjyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ar0QA19asK/AQNJyoyOQ2w/sGosbf8SDpOd/P132AXVm+m7DJ9+LvKA0CavfA+2Hh
	 0isWY5jr6KLguy1gIVuiyWzN38cXhaXhFmTwTweWT2C5sSGNyAP0AHM9ruveKQnzfH
	 oad9ZbTEt/uka09a/9LAqWHtGP+J20Zb2P2Thz3jHt2OXVoLICf2v/p752KFREAcII
	 BfJvCrr8C+2rTagHHhu0aZE4/7N7nsuRK6TViK1Sz5YKrBtXASMfoo5R4CjSsYzIL2
	 NdxQaq7nO0dg2bguxXJU0uLe6xY1uUJfUxnK37Ve+k1iGZdghO8xeFqYC9ErnH4C/S
	 CGn+aNo5ErIVg==
Date: Wed, 30 Jul 2025 14:10:26 -0400
From: Sasha Levin <sashal@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIpgEpe6z2Ykyymh@lappy>
References: <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <20250730130531.4855a38b@gandalf.local.home>
 <aIpah6DTRd99mMqb@lappy>
 <20250730175909.GO222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250730175909.GO222315@ZenIV>

On Wed, Jul 30, 2025 at 06:59:09PM +0100, Al Viro wrote:
>On Wed, Jul 30, 2025 at 01:46:47PM -0400, Sasha Levin wrote:
>
>> Similarily the argument around not trusting the code is equivalent to
>> not trusting the person who sent the code in. AI doesn't send patches on
>> it's own - humans do. This is basically saying "I didn't even look at
>> your patch because I don't trust you".
>
>One name: Markus Elfring.  Ever tried to reason with that one?  Or Hillf
>Danton, for that matter.
>
>And I absolutely will refuse to take patches from somebody who would
>consistently fail to explain why the patch is correct and needed.  Sasha,
>this is the elephant in the room: we *ALREADY* get "contributions" that
>very clearly stem from "$TOOL says so, what else do you need?" kind of
>reasoning and some of that dreck ends up in the tree.  AI will serve as
>a force multiplier for those...  persons.

This is exactly my argument Al :)

You, as a maintainer, should be able to just reject patches without
having to provide a technical explanation for each patch you ignore.

If someone new comes along and bombards you with AI generated crap and
useless review comments, you should be able to just block him and point
to something under Documentation/ that will support that decision.

-- 
Thanks,
Sasha

