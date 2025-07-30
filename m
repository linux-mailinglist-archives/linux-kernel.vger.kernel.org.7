Return-Path: <linux-kernel+bounces-751087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0560B16523
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:05:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29A431738EF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3460C2DE216;
	Wed, 30 Jul 2025 17:05:22 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556041DFDAB;
	Wed, 30 Jul 2025 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895121; cv=none; b=jeb64ItbfDILyaJFAHL5gBk98MJcOYNnDh3orK9GmS0Z6CzgydcpXcFqa2qxgLYlna8xhZJlb7Go/95/Ls2akmJ8XCE0E8mZtfA5Z9/onh+EGRWoj/o80nuFs1Mr22UPhagVqEmMg86SZAc8PfE81au0Mw7ZLd8udMrEJzcaC0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895121; c=relaxed/simple;
	bh=Fz9AmItsSE1gQvYxIaSsn8ZhUticrdNuFl7P2+VOuo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=karARQpfRdCvimQQ2fV8a0U+6oJVhcM5p/KpDqZ1CihYgFij45Ki4LCwqNBMD9quzu5cFdyhgpUDOnznXI7+xNnJwg2Wcj+GbvZrqbMqUKEjZwPhRd/xHGDyOKcDmvQ/vNjfj3nLGiOXhKfGp2qJewgmXg5yOCziMgUuFHo6sVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2F1B2593DB;
	Wed, 30 Jul 2025 17:05:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A1ED230;
	Wed, 30 Jul 2025 17:05:14 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:05:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730130531.4855a38b@gandalf.local.home>
In-Reply-To: <aIpKCXrc-k2Dx43x@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
	<aIpKCXrc-k2Dx43x@lappy>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ntgnn1j57rcamjw4pf3r96jnx45bu66s
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A1ED230
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19dTV0CfTG6wTPdg8qBFlf7zLOvV2ojrNQ=
X-HE-Tag: 1753895114-634474
X-HE-Meta: U2FsdGVkX1/hx5wyE7EefGyESyhBxTHzA6Du3wDY4KWgk0CBQqzFge6OybgrVWuEAjuOnojzW/rX3g0+ZM3T4qbCEm8ZbcpLlzM+l6C6Z5Bowm1UfXkfrZRAe7pa8HtZp/UI+VadRmxwa2Gjsiv5OYjZXDpiq894ddKZNz9K1CippgOZjR/1itAB/CFZcT/GxkNWWxO6qkBgyK+lSwvXjyn+etHmNxbg4WhpfPjHHC+AtAiv64dh2+2Bb74BOcEotuVxtdRhzCo7AkJgTPZQyC1lkJmrr7EeKPZIBYIVCdIcU5+ZfSD7blGBGOWkdZ5Xy8F7qUskanRDCK0hb3CYmfZOebO0E4SXGkQPIjo7uYPaYldLc1N8E9yLve/inluZ

On Wed, 30 Jul 2025 12:36:25 -0400
Sasha Levin <sashal@kernel.org> wrote:

> >
> >That sounds pretty much exactly as what I was stating in our meeting. That
> >is, it is OK to submit a patch written with AI but you must disclose it. It
> >is also the right of the Maintainer to refuse to take any patch that was
> >written in AI. They may feel that they want someone who fully understands  
> 
> This should probably be a stronger statement if we don't have it in the
> docs yet: a maintainer can refuse to take any patch, period.

I disagree with that. They had better have technical reasons to refuse to
take a patch. I would have big qualms if a maintainer just said "I don't
like you and I'm not going to take any patches from you".

This is a community project, and maintainers have been overridden before.
Luckily, Linus has been pretty good at getting changes into the kernel when
there was no clear technical argument that they should not be accepted.

I believe the policy is that a maintainer may refuse any patch based on
technical reasons. Now, patches can and are delayed due to maintainers just
not having the time to review the patch. But that is eventually resolved if
enough resources come into play.

My point here is that AI can now add questions that maintainers can't
answer. Is it really legal? Can the maintainer trust it? Yes, these too can
fall under the "technical reasons" but having a clear policy that states
that a maintainer may not want to even bother with AI generated code can
perhaps give the maintainer something to point to if push comes to shove.

> 
> >what that patch does, and AI can cloud the knowledge of that patch from the
> >author.  
> 
> Maybe we should unify this with the academic research doc we already
> have?

I wouldn't think so. This is about submitting patches and a statement there
may be easier found by those about to submit an AI patch. Just because they
are using AI doesn't mean they'll think it's an academic research.

> 
> This way we can extend MAINTAINERS to indicate which subsystems are
> more open to research work (drivers/staging/ comes to mind) vs ones that
> aren't.

I wouldn't call it research work. Right now people who may be playing with
AI models may think it's "research", but that's not going to be the
majority of AI submissions.

> 
> Some sort of a "traffic light" system:
> 
>   1. Green: the subsystem is happy to receive patches from any source.
> 
>   2. Yellow: "If you're unfamiliar with the subsystem and using any
>   tooling to generate your patches, please have a reviewed-by from a
>   trusted developer before sending your patch".
> 
>   3. No tool-generated patches without prior maintainer approval.

Perhaps. Of course there's the Coccinelle scripts that fix a bunch of code
around the kernel that will like be ignored in this. But this may still be
a good start.

-- Steve

