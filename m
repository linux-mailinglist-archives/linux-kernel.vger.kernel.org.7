Return-Path: <linux-kernel+bounces-747499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6497B13483
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F821883C19
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76BD722154D;
	Mon, 28 Jul 2025 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLRAZW2f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB52421765B;
	Mon, 28 Jul 2025 05:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753682385; cv=none; b=fSk33Gw4wGiZpGxPH/UrCmbXIJemG5SUtwUTlO90FusJoaiKpRnLx4aONUkIOXNt9o8s9u5Z/B4YXbCDLlacSnSXsVU3yM5v4JYjJh4WEa7BV1lJu8ApEIvfHA87dYPoYyYpv+wDq5BbvGx9l7huypS9Bhmd1p66mrN88i8rGlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753682385; c=relaxed/simple;
	bh=Wtgy6da4925JfoX9oIjmFDm1ZF05hpuazOLW5+rWCT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0AMSnie5dlWYbewQs0MckGuLGKt6cldOq0qH85G9TdF2PougqfJdPzrwL67AJVVewEJm8+oskVTdezECMOgImBb10X0QxV2gqXKyvruJCztWatKyhoznZyCYqit1NtnkWY6IR+Pl3d+qvSAYSuc+Y/hD/e7vck5RCmtB0nwQ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLRAZW2f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EB2C4CEE7;
	Mon, 28 Jul 2025 05:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753682385;
	bh=Wtgy6da4925JfoX9oIjmFDm1ZF05hpuazOLW5+rWCT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QLRAZW2fgp89hAS8KMPpxnR/+KMonssA4uwm0o++r6oL35ZuOKz1M5amcNcvSLZjA
	 fxwBXNsRWruxEp8eaZQi7z/GMzheH2dFGj9EliyTASMiBEHBYwSRbz6bhIcxQGdJei
	 rdNA6eX5E7Uqs6Gs5KCECoYNodzuiO421E9AyseEVG9BJZkqbfVHcDkHteP2KUa2kF
	 yGfypdJ2IAONs3m3GUhfdBhWgxI/XIhcUXYnpIs8iI1B5qK9GB7IDEKSz17yk8bI7c
	 ws/shviwI23Wt80DGcEjaeCq6P40OjItkj16mLxdDjPOJcxPcN2AywDQas7KkUhUCd
	 pz3Ci5jvVhwvw==
Date: Mon, 28 Jul 2025 01:59:42 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <aIcRzndNUdh-9R18@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <202507271937.EC44B39@keescook>
 <aIcD9f_52tlLgE-e@lappy>
 <202507272203.BECE244@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507272203.BECE244@keescook>

On Sun, Jul 27, 2025 at 10:10:02PM -0700, Kees Cook wrote:
>On Mon, Jul 28, 2025 at 01:00:37AM -0400, Sasha Levin wrote:
>> > If an Agent needs the above list, then so does a human. Everything above
>> > should already be discoverable by the Agent. If it's not, then we need a
>> > better summary document _for humans_ that reads like the above.
>>
>> Why would an agent read those docs unless we tell it to?
>
>When I typed "/init" in claude, it found the references in the Makefile
>and other files to stuff in Documentation/ and read it. Hence my
>suggestion to add this in a place that is human (and agent)
>discoverable, like Makefile, which any sane agent is going to read to
>look for a "help" target, etc. Any agent that doesn't understand how to
>figure out what _kind_ of codebase it's working on isn't an agent that
>is going to deal well with the Linux tree.
>
>> Similarily, why would a human read those docs unless we tell it to? :)
>
>We do, though. But this is my point: if we _lack_ a good entry point for
>humans, then we need to solve _that_ problem.

Thing is, agents won't read the README on their own: they need to be
prompted to do it.

Claude will generate passable commits without a CLAUDE.md for simple
prompts.

I'm assuming we both agree that we need to give the agent some entry
point which they will automatically process without any user prompts,
even if it's just saying "Please read the README file!"?

>> Just like with humans, the better context and background you give them
>> the better of a result you'll get out of it.
>
>Both the top of Makefile and the bottom of "make help" refer to reading
>the README file. I think *that* is where all these kinds of changes
>should go, and it should be suitable for human consumption. Honestly,
>README is extremely vague right now:
>
>$ cat README
>Linux kernel
>============
>
>There are several guides for kernel developers and users. These guides can
>be rendered in a number of formats, like HTML and PDF. Please read
>Documentation/admin-guide/README.rst first.
>
>In order to build the documentation, use ``make htmldocs`` or
>``make pdfdocs``.  The formatted documentation can also be read online at:
>
>    https://www.kernel.org/doc/html/latest/
>
>There are various text files in the Documentation/ subdirectory,
>several of them using the reStructuredText markup notation.
>
>Please read the Documentation/process/changes.rst file, as it contains the
>requirements for building and running the kernel, and information about
>the problems which may result by upgrading your kernel.
>
>
>
>
>"There are several guides..." and "There are various text files in
>..." is hardly the right language for a human either. And why is doc
>building in the README? That's, frankly, esoteric for anyone who needs
>to read the README.
>
>Let's fix up the README into something nice for everyone, and any decent
>agent should already be reading it anyway.

I think it'll be hard to find a common path that works here. README is
pretty generic because there are different humans that might read it:

  - A university researcher who should be pointed to researcher-guidelines.rst
  - A security researcher who should be pointed to security-bugs.rst or embargoed-hardware-issues.rst
  - A newbie trying to set up his mail client and needs to be pointed to email-clients.rst
  - A coding agent that doesn't care about none of the above.

So we can clean up README and try to make it an entry point that will
fit most of it's potential readers, but I worry that at the end it will
end fitting none of them.

Without crafting something more specific for agents, I also worry that
we'll be stuffing the limited context they already have with information
that will only hurt their performance (just like humans: there's only so
much we can remember at a time).

-- 
Thanks,
Sasha

