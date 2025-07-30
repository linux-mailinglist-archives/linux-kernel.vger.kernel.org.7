Return-Path: <linux-kernel+bounces-751061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9D3B164D4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F08718929BB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E932DECC2;
	Wed, 30 Jul 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iIEgK7+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB0D2DEA7E;
	Wed, 30 Jul 2025 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753893388; cv=none; b=OCJIOC7smTJUTG7PnA5/RqrrjWC41nS/vlxBDWE3OTNF+AALaEXzwUYFfo28iRMDSXd+r8HhcuT8YOMDJ5xc90D5c7aNz6tNkerN5ziR78IBO+EAZc0xxw+GZMh3ZookA2n9NwKOyjvgiPyJdkg8lpUzOaWGBQBNv938tDvXchY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753893388; c=relaxed/simple;
	bh=EbzS9qxr4044gou9sOfKn3+VkxrbSWebgv8HUG3wG/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3JU96lnaBajI7zNTgLnzwX+rInCu80fBkWMcVb82hDYmzL1HFoxh42/H6/nQxaM4W5sp1vcQFTtMYp2OPZLJS/7nCF6+CGFiUkca3n5ljGoz3M+yQIU5+YGMOIB0vKTPqGfN3nqXH5K7G6Xp7HnEij20/D2fgj1brbit9nBuKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iIEgK7+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F1DC4CEE3;
	Wed, 30 Jul 2025 16:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753893387;
	bh=EbzS9qxr4044gou9sOfKn3+VkxrbSWebgv8HUG3wG/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iIEgK7+quxrKcwAsvi8hcCC3oU39CNB9ww/ykBMJgWiRNBQg/54dRleiiINGqsQju
	 t7icxMM66oH/18cP2sr0pAgOnlqk1/nxW/WMz6a32k/eDVct6b046NMtDNnyDub/ah
	 2WLYxnzg3X4zeM2g2TfGTfWWHa1owT9oUWLBgkZsEe/pY2oObax8anqmrJnj4LWoUW
	 wNFvhQ0IPQ3E9uQl3REJp/MnpO8fArfxOJCioDQE2Wkvu26Gq4zLswGqZVdmJ6bv5x
	 WLvZ2r2sWZ1R2h8gFCwsf42SA88lPQZLSL+Z4EBPqAfx52zzJSL9+Uc0Wf7/M5jor3
	 vU8oVoPT2f9hw==
Date: Wed, 30 Jul 2025 12:36:25 -0400
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
Message-ID: <aIpKCXrc-k2Dx43x@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250730121829.0c89228d@gandalf.local.home>

On Wed, Jul 30, 2025 at 12:18:29PM -0400, Steven Rostedt wrote:
>On Wed, 30 Jul 2025 16:34:28 +0100
>Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
>> > Which looked like someone else (now Cc'd on this thread) took it public,
>> > and I wanted to see where that ended. I didn't want to start another
>> > discussion when there's already two in progress.
>>
>> OK, but having a document like this is not in my view optional - we must
>> have a clear, stated policy and one which ideally makes plain that it's
>> opt-in and maintainers may choose not to take these patches.
>
>That sounds pretty much exactly as what I was stating in our meeting. That
>is, it is OK to submit a patch written with AI but you must disclose it. It
>is also the right of the Maintainer to refuse to take any patch that was
>written in AI. They may feel that they want someone who fully understands

This should probably be a stronger statement if we don't have it in the
docs yet: a maintainer can refuse to take any patch, period.

>what that patch does, and AI can cloud the knowledge of that patch from the
>author.

Maybe we should unify this with the academic research doc we already
have?

This way we can extend MAINTAINERS to indicate which subsystems are
more open to research work (drivers/staging/ comes to mind) vs ones that
aren't.

Some sort of a "traffic light" system:

  1. Green: the subsystem is happy to receive patches from any source.

  2. Yellow: "If you're unfamiliar with the subsystem and using any
  tooling to generate your patches, please have a reviewed-by from a
  trusted developer before sending your patch".

  3. No tool-generated patches without prior maintainer approval.

-- 
Thanks,
Sasha

