Return-Path: <linux-kernel+bounces-751148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98012B165BD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 051CE1AA483D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF092DE6F8;
	Wed, 30 Jul 2025 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r55xUPYo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F451D61BC;
	Wed, 30 Jul 2025 17:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753897610; cv=none; b=uipxmH76F1nV9WV5etH0aAIFQ86nfjkeLoSOvfE5B4ZOkL5FLy3357M1zCK4N5+Lkmu2u4hnSGAEUxEN9A/WVZFktlnox8s/bcF5p/C0mlmzjmx7+qDaLf65B24maUEg18ff5ARk9Sq0M2LkPFXelaGLwFR7Uu9svOPG54aUKUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753897610; c=relaxed/simple;
	bh=i+Uks1c4IkNLAnAwsqqBNeCU8fqOP6LHnAxRYO6R5Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewRPidsNsIYeaZAVKxfmtCE/Ubctq8DAdLhOQHSzRIVxXeQpzkU+mNMz5Vv7XzZ2IDB8BjjxtTEcg/2oZysQ/9y0umQqH6VF1MxERphbxVQQOUPlxP2GNNru+cIcDCBjfVgO6IH9SiPiyHNKYeGIMWFyI6jhRHNgA6KwmSioscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r55xUPYo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BC1C4CEE3;
	Wed, 30 Jul 2025 17:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753897610;
	bh=i+Uks1c4IkNLAnAwsqqBNeCU8fqOP6LHnAxRYO6R5Ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r55xUPYoQBKrMvFJbaCUS4icLp82V/PFbAKYqVuEWgdrlcEbnrUoUFswm91yXOKAq
	 ZwiPYt9IwofA6H2e31IYXTpiMKQv9vViwW7/M45DcOHgJ0VSK2tsijkvQTywl3g165
	 l3rO/RMgmDlteAH7MMzyHnJXlI6aXQBnrvTq5/gnZmAxrqMuapZyVib3s0vFN7YPN2
	 K1YF8OVin2uMgZOQYBq9X0X2oVh3FC/wphfLSoZV4+4WivHuQlN5UN/w0vOOB0S2k4
	 Ipk3LAWcOeg0XkNwQwisVj9oOy+uVm6etfbP14O3lO/An9OoP9CuUQt7tRbzDxHCxs
	 6btvzQV8to/lw==
Date: Wed, 30 Jul 2025 13:46:47 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <aIpah6DTRd99mMqb@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <20250730130531.4855a38b@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250730130531.4855a38b@gandalf.local.home>

On Wed, Jul 30, 2025 at 01:05:31PM -0400, Steven Rostedt wrote:
>On Wed, 30 Jul 2025 12:36:25 -0400
>Sasha Levin <sashal@kernel.org> wrote:
>
>> >
>> >That sounds pretty much exactly as what I was stating in our meeting. That
>> >is, it is OK to submit a patch written with AI but you must disclose it. It
>> >is also the right of the Maintainer to refuse to take any patch that was
>> >written in AI. They may feel that they want someone who fully understands
>>
>> This should probably be a stronger statement if we don't have it in the
>> docs yet: a maintainer can refuse to take any patch, period.
>
>I disagree with that. They had better have technical reasons to refuse to
>take a patch. I would have big qualms if a maintainer just said "I don't
>like you and I'm not going to take any patches from you".
>
>This is a community project, and maintainers have been overridden before.
>Luckily, Linus has been pretty good at getting changes into the kernel when
>there was no clear technical argument that they should not be accepted.
>
>I believe the policy is that a maintainer may refuse any patch based on
>technical reasons. Now, patches can and are delayed due to maintainers just
>not having the time to review the patch. But that is eventually resolved if
>enough resources come into play.
>
>My point here is that AI can now add questions that maintainers can't
>answer. Is it really legal? Can the maintainer trust it? Yes, these too can
>fall under the "technical reasons" but having a clear policy that states
>that a maintainer may not want to even bother with AI generated code can
>perhaps give the maintainer something to point to if push comes to shove.

I don't think that those are technical aspects.

The legality question is answered by the DCO where a human represents
that he is allowed to submit the code. You should have the same concerns
with humans sending in non-GPL-compatible code.

Similarily the argument around not trusting the code is equivalent to
not trusting the person who sent the code in. AI doesn't send patches on
it's own - humans do. This is basically saying "I didn't even look at
your patch because I don't trust you".

>> Maybe we should unify this with the academic research doc we already
>> have?
>
>I wouldn't think so. This is about submitting patches and a statement there
>may be easier found by those about to submit an AI patch. Just because they
>are using AI doesn't mean they'll think it's an academic research.

Not in the sense that AI is research, but more that this is code coming
from someone who is unable to reliably verify the patch that is being
sent in.

The source can be academic research, AI, or whatever else comes along.

It'll just be nice to have a unified set of rules around it. Otherwise
the amount of combinations will explode (in which category do we put in
academic researchers sending in AI generated code?).

>> Some sort of a "traffic light" system:
>>
>>   1. Green: the subsystem is happy to receive patches from any source.
>>
>>   2. Yellow: "If you're unfamiliar with the subsystem and using any
>>   tooling to generate your patches, please have a reviewed-by from a
>>   trusted developer before sending your patch".
>>
>>   3. No tool-generated patches without prior maintainer approval.
>
>Perhaps. Of course there's the Coccinelle scripts that fix a bunch of code
>around the kernel that will like be ignored in this. But this may still be
>a good start.

It'll be hard to draw a line here, so I suggest we don't try.

Are AI generated .cocci semantic patches that are then transformed into
C patches and sent in by a human ok?

-- 
Thanks,
Sasha

