Return-Path: <linux-kernel+bounces-751135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1137FB1659A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22520620308
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C052E0407;
	Wed, 30 Jul 2025 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mteuIjP7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F80826772C;
	Wed, 30 Jul 2025 17:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896987; cv=none; b=cXCCq0oiYiWzHk/z9MP5GcWRTzDtvlUMCmHNQZpyTL1Go6T8kPS+cTrksabhWBGB9+IDR6AkLXRaStjyx5FXeCOcf9pka0Po3JMnVqSk+61VNvEPmfyBwQm2/0Klqh0ub0PIiQ0NXVJHEL+wBf/xuFVmX3u15Tu76ls9r8ffOIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896987; c=relaxed/simple;
	bh=L71sYbk+olCwkb4z6+myg8QodwOVdyj+zp0NqOJSi3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkD0wpEfj8MdRR7TuLM/KbRBN+zYUlu1pZFoMlTsVozua4z8DTGgdt7XUrG0exabMQp45OLb1lffQh6ne6K7XySe643goGn5Rn0l6/u0RBgMroxE2ADK7AxdGMq9zjhZQ+y0qPm95qfQA5FQA3B2fISqN16RTHzgTHymZ43vzt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mteuIjP7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C053EC4CEE3;
	Wed, 30 Jul 2025 17:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753896986;
	bh=L71sYbk+olCwkb4z6+myg8QodwOVdyj+zp0NqOJSi3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mteuIjP7788mdkdK0qr0Z+wqTeqZWAF3Taq2NMhx71+dI0yXBQX4kCiJPs69nwH0p
	 DureNuvqkWS+cf+Qj4Cb/8wo0G1gnpv4IMVXNflbhKwKwgnSb1iwPDeLOGOkGv7lHf
	 4KkBFc64/hbCaWaGNhFO8Y/Hh8JgEdThg2gHTvor9Gw7gtljljje2Wp9u9wWwQZ7rn
	 O5TG/FpSRu4CQcvQt/OECuJ0nu+z63k9Sbah1DGbirXRhyFgSnb8XPsrJ1tyXk/pKB
	 OEbrh5vikVEYt6FkoA4T9SSbewHvdnI1Sg8Qxgr1OXiPJ/NuKjvagNlYVcGRWQEAGl
	 pG25KaJMP4rug==
Date: Wed, 30 Jul 2025 10:36:26 -0700
From: Kees Cook <kees@kernel.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	Greg KH <greg@kroah.com>, corbet@lwn.net, linux-doc@vger.kernel.org,
	workflows@vger.kernel.org, josh@joshtriplett.org,
	konstantin@linuxfoundation.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <202507301008.E109EB0F@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
 <2025072854-earthen-velcro-8b32@gregkh>
 <df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
 <20250730112753.17f5af13@gandalf.local.home>
 <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
 <20250730121829.0c89228d@gandalf.local.home>
 <aIpKCXrc-k2Dx43x@lappy>
 <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>

On Wed, Jul 30, 2025 at 05:59:25PM +0100, Lorenzo Stoakes wrote:
> On Wed, Jul 30, 2025 at 12:36:25PM -0400, Sasha Levin wrote:
> > Some sort of a "traffic light" system:
> >
> >  1. Green: the subsystem is happy to receive patches from any source.
> >
> >  2. Yellow: "If you're unfamiliar with the subsystem and using any
> >  tooling to generate your patches, please have a reviewed-by from a
> >  trusted developer before sending your patch".
> >
> >  3. No tool-generated patches without prior maintainer approval.
> 
> This sounds good, with a default on red. Which would enforce the opt-in
> part.

This is way too draconian. The human is still responsible for sending
patches -- their reputation is on the line if things go badly.

I think we can capture the essence of "don't send bad patches, regardless
of tool" without saying "if you use this class of tool, you are banned
from sending anything that it helped you with." That's not useful,
realistic, nor enforceable.

I get a sense that many people in this thread haven't actually used
these tools themselves. It requires active management like anything else:
Coccinelle isn't going to get things 100% right based on your first stab
at a script. Neither is an LLM. It still requires the human to DTRT. And
just as some examples, here are my LLM assisted patches so far:

https://lore.kernel.org/lkml/20250717085156.work.363-kees@kernel.org/
https://lore.kernel.org/lkml/20250724030233.work.486-kees@kernel.org/
https://lore.kernel.org/lkml/20250724080756.work.741-kees@kernel.org/

Even the latter I had to walk it through the analysis and suggest a style
edit. With the KUnit tests, I had to do significant editing/adjustment/etc
to all of these.

-- 
Kees Cook

