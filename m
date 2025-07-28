Return-Path: <linux-kernel+bounces-747456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79AC2B13410
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E12953AADE3
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB39219A89;
	Mon, 28 Jul 2025 05:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBHwKt8Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57572E3708;
	Mon, 28 Jul 2025 05:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753679793; cv=none; b=lTJXymIYRsCYmpBI2NoLj7ZHXemVF1vJB/KJf3qOFJ7ljo4DD3E8FBvPXHJsbrR8jR7yxLTmFYvJrcpYXXdqo2q3R/iVPtwwCH7odi6zusyYXiwfO55isfQq8ixcOrwLd+UEkewRh8FG5zTbNDWxo/JHyNCnBmizkh0LTZKm1ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753679793; c=relaxed/simple;
	bh=qDx1ZZBo1UzQGdbqP1eOsZx6AQniOsrKTheh7dQ0KWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvZaZ9YeylpvuhShQcE5T0h2zuvElTuqkZQIu1IrlZgMwSxaqydD5op9NFrFvT+Ie3bC1a02ZBpUkzocCJN8Xu+mhPaNPLRn+QtVM6yxKwvYx51CE/dUtdz3JaKFft4V8p64GwWNOuYOSxVS8GigvMPSnvj+LtzLCXc+TDaGrhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBHwKt8Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36ADFC4CEE7;
	Mon, 28 Jul 2025 05:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753679793;
	bh=qDx1ZZBo1UzQGdbqP1eOsZx6AQniOsrKTheh7dQ0KWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uBHwKt8YkXgqU5WcQS8B8y1kLGmpBI0IeapO8CHJ+Vi7y1LYoB59vJiY0f5dYne0F
	 8QS0iR1xht/8/hg3DbNcm8qBHWVVFGElIavUKQA8+yQWiEmXGvulcO8Mco14ICs6AC
	 bJ1RlCR68Fl4mBBv5xV1Fr1YmPCNBDy9aky1zG6EVNs3o3NV00eD8jC0IDdTOt6F1R
	 6v4mKuSe9i7pQ2D6GRMbcO8rH4yVOowBKkyuZi0nu0EqJ6gstj/6yk/0CZHJuuTSeI
	 dWAeAzDUEenrB65nABdW3tufjRYmpq7isyKy6d+Lt+TdvczzKMlXl3pHYf2xkwr0CX
	 8nezvnZVGndnw==
Date: Sun, 27 Jul 2025 22:16:32 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant
 configuration
Message-ID: <202507272210.E8E64F6C@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-2-sashal@kernel.org>
 <202507271934.68E1F0C728@keescook>
 <aIcACJhaU-NElyHC@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIcACJhaU-NElyHC@lappy>

On Mon, Jul 28, 2025 at 12:43:52AM -0400, Sasha Levin wrote:
> On Sun, Jul 27, 2025 at 07:37:31PM -0700, Kees Cook wrote:
> > On Sun, Jul 27, 2025 at 03:57:59PM -0400, Sasha Levin wrote:
> > > Create a single source of truth for agent instructions in
> > > Documentation/AI/main.md with symlinks for all major coding
> > > agents:
> > > - CLAUDE.md (Claude Code)
> > > - .github/copilot-instructions.md (GitHub Copilot)
> > > - .cursorrules (Cursor)
> > > - .codeium/instructions.md (Codeium)
> > > - .continue/context.md (Continue)
> > > - .windsurfrules (Windsurf)
> > > - .aider.conf.yml (Aider)
> > 
> > I *really* don't like this. I use the CLAUDE.md file as my instructions
> > for my agent. I think all of these should be .gitignore entries.
> 
> Sorry, I might have misunderstood you: how does it play out if we add
> these to .gitignore?

Then what claude learns about my workflows and preference can be
correctly stored in CLAUDE.me (which is how claude is designed to work).
I would think of it like why we don't ship a debian/ package build tree:
it's going to be different for everyone. And if you look in .gitignore
you can already see that /debian/ is there. :) These agent files are for
developer-specific use, and adding them to .gitignore is the right
approach (at least for Claude and Gemini). Which reminds me, please
also include GEMINI.md in your list. :)

> The tool will just end replacing whatever we put in there with something
> customized that doesn't necessarily correspond to what the community
> will consider a "standard" set of rules for agents?

Right, and then it will always be a git diff delta and cause pain. For
the agents that are designed to _write_ to their files, then it needs
to be in .gitignore.

-- 
Kees Cook

