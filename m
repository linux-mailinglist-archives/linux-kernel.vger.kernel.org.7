Return-Path: <linux-kernel+bounces-747472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EBDB1343B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777401893917
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41F122126D;
	Mon, 28 Jul 2025 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJauNBDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DB5188006;
	Mon, 28 Jul 2025 05:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753681168; cv=none; b=AIBVEHfJsATZzyoAqBZCCWJplYVKg6qGAQkNJBsDsXD4hHvrWdB9IZhKD/0hRRUR1x24fd0YgjhBvwq6fAiXfrfAlOTdEFvYwK9rJQH7IJQazGZiQBVoMS5lShyMu/waQCQ7W8SCkWBxGxSZZrdhR/DrFGTshU34sHTzOntGZc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753681168; c=relaxed/simple;
	bh=0u1rjO8eUJ+PYv0hu5JG2i4UwhATWMGvHmuhmMwdKm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joGUhLYNLYWeqZUzCN4QFYTmr91TrWZ2TlJBvoJlE3PCv5j8oF8DuVTJiw5XjnOPMwjH69KI6nxgpHlukXyAFlSBJuoXaFTF4u+ygeGb+cWCUb56+t+efuRF6Cfkc6wAN+naB2Zg9al0fDhMCjgnDkhso8LwTitOC4cHFJIodZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJauNBDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D4EC4CEE7;
	Mon, 28 Jul 2025 05:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753681168;
	bh=0u1rjO8eUJ+PYv0hu5JG2i4UwhATWMGvHmuhmMwdKm4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dJauNBDRymwiH/fpIPhVv9a9q9fU/GmXrJQBruhegP6jJFBXeKqX3IYvIocEIYqeH
	 +eJGDCGWCBtE8Vs1cLJmF+J2Atks4ypNW4FIIMp/cnNffGUtT0l0NZR5b4ivyuYsR7
	 iOho6K3uO5GLHRFhsXo/L+5I/FLDpKBLvsJdgozSKm8yS3YDvOxAN9MBLmhvKxmUeK
	 f/SOJ8MHFeji8tvN8jScNolOubAtg+l4gPvJAB4uU8n/TC8BC8uPk8HwjNRplc2CU/
	 cai8J8TddNBga1HLT/UJs6hrHW50WYUfXuNeBZXHgDIhDMiiBwmPQKg30ip3Ojea8r
	 M9MtUsYHMoWvw==
Date: Mon, 28 Jul 2025 01:39:25 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant
 configuration
Message-ID: <aIcNDZna65qZIiY1@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-2-sashal@kernel.org>
 <202507271934.68E1F0C728@keescook>
 <aIcACJhaU-NElyHC@lappy>
 <202507272210.E8E64F6C@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507272210.E8E64F6C@keescook>

On Sun, Jul 27, 2025 at 10:16:32PM -0700, Kees Cook wrote:
>On Mon, Jul 28, 2025 at 12:43:52AM -0400, Sasha Levin wrote:
>> On Sun, Jul 27, 2025 at 07:37:31PM -0700, Kees Cook wrote:
>> > On Sun, Jul 27, 2025 at 03:57:59PM -0400, Sasha Levin wrote:
>> > > Create a single source of truth for agent instructions in
>> > > Documentation/AI/main.md with symlinks for all major coding
>> > > agents:
>> > > - CLAUDE.md (Claude Code)
>> > > - .github/copilot-instructions.md (GitHub Copilot)
>> > > - .cursorrules (Cursor)
>> > > - .codeium/instructions.md (Codeium)
>> > > - .continue/context.md (Continue)
>> > > - .windsurfrules (Windsurf)
>> > > - .aider.conf.yml (Aider)
>> >
>> > I *really* don't like this. I use the CLAUDE.md file as my instructions
>> > for my agent. I think all of these should be .gitignore entries.
>>
>> Sorry, I might have misunderstood you: how does it play out if we add
>> these to .gitignore?
>
>Then what claude learns about my workflows and preference can be
>correctly stored in CLAUDE.me (which is how claude is designed to work).
>I would think of it like why we don't ship a debian/ package build tree:
>it's going to be different for everyone. And if you look in .gitignore
>you can already see that /debian/ is there. :) These agent files are for
>developer-specific use, and adding them to .gitignore is the right
>approach (at least for Claude and Gemini). Which reminds me, please
>also include GEMINI.md in your list. :)
>
>> The tool will just end replacing whatever we put in there with something
>> customized that doesn't necessarily correspond to what the community
>> will consider a "standard" set of rules for agents?
>
>Right, and then it will always be a git diff delta and cause pain. For
>the agents that are designed to _write_ to their files, then it needs
>to be in .gitignore.

Okay, I'll update it for v2.

-- 
Thanks,
Sasha

