Return-Path: <linux-kernel+bounces-746453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C89F1B126D5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFCAA548828
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC7B2561AE;
	Fri, 25 Jul 2025 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIcSZPUW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B4D27470;
	Fri, 25 Jul 2025 22:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753482345; cv=none; b=HaKEs92R0FSDp+WomhiOkwLblvs11V81MscyNCMrVqimdyHDvjdkWhoRGWEoG17W/ZCYdGeFhDOPwrbKhKACTomwRxngWwLixHqdPH1AuXJ+q3G/34sOP3hdSSYWevBZOnNljtscdyjZfU9c7juk9TfSO6PB0+MgWy2r+FlAZaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753482345; c=relaxed/simple;
	bh=txMmhidIg4RcfLmmLjqcinY3uiBf4XL6CIzT0pxHrI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kGdGPF3rvKYo3Em9BwKhS5Tc/AQvbf1rpA+cEbO5p2dn22LBc84RVZUfbAp+qqjKnqj+Y0DGwvBLB7z3ZwObc2/5O+TDuplNOiOaEspTzEXsw/ZO258CdcWIetv0ZJMnr0COudMt0NUv/kPrzr7WiL0fDImxmtv++IAEjppyrXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIcSZPUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAC3C4CEE7;
	Fri, 25 Jul 2025 22:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753482343;
	bh=txMmhidIg4RcfLmmLjqcinY3uiBf4XL6CIzT0pxHrI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eIcSZPUWMNKklNEBu7YWbKqYDmyE/9RGj7Hpu92xAd+GUAYtYih0w5R08aLr/8Rr4
	 CVzGis2p+hTjlDnQ9iWEZ7FJKR8N5g//sLqRlJhmnzpVwf4d6oUnwqgaRnqDBqEfwx
	 P7ef15d0V5iBO9zux0Syr+uveY2MId3XZVSH96YWq5Fa82nK6c75a8JdfrRwOEp5Ff
	 AUMHhwhdJKySzkjqfxDVmoDeyHzKrhXqn5wSxr8GDc6MVRgTQYEpYthlqqVrruS1Ss
	 g/zMKUOGPVQtFbkSIeasscXV1Ap3R6cq2+F/hAraFuNGqnxXPs5YoxXF72zXVAtl/O
	 Se8t3492rpQaQ==
Date: Fri, 25 Jul 2025 18:25:41 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
Message-ID: <aIQEZZt7rlzeMDSe@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725175358.1989323-2-sashal@kernel.org>
 <202507251329.8DC1ED1@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202507251329.8DC1ED1@keescook>

On Fri, Jul 25, 2025 at 01:40:55PM -0700, Kees Cook wrote:
>On Fri, Jul 25, 2025 at 01:53:57PM -0400, Sasha Levin wrote:
>> Create a single source of truth for AI instructions in
>> Documentation/AI/main.md with symlinks for all major AI coding
>> assistants:
>> - CLAUDE.md (Claude Code)
>> - .github/copilot-instructions.md (GitHub Copilot)
>> - .cursorrules (Cursor)
>> - .codeium/instructions.md (Codeium)
>> - .continue/context.md (Continue)
>> - .windsurfrules (Windsurf)
>> - Documentation/AIder.conf.yml (Aider)
>
>I do like the idea of having a standard baseline for agentic
>development, but:
>
>- This clobbers per-project information storage for the agents, which
>  the dev may want to be adjusting locally. I would strongly prefer
>  adding all of those files to .gitignore instead.

It will, but:

1. We don't have a different place to write this down (more below).
2. Users have other places they can add their specific instructions, or
they can even carry patches on top.

>- Documentation/ should not start getting filled with stuff to be
>  exclusively consumed by agents. Instead, I recommend a top-level
>  .md file that agents can discover that contains very simple
>  non-specific prompts about what they can find in Documentation/,
>  and drop a reference to the file in, say, Makefile to be discovered
>  during the agent's scrape of the project.
>
>I'd recommend something very simple like:
>
>diff --git a/Makefile b/Makefile
>index e05bd43f93bd..998b037e6d4d 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -7,6 +7,7 @@ NAME = Baby Opossum Posse
>
> # *DOCUMENTATION*
> # To see a list of typical targets execute "make help"
>+# AI agents and LLMs should read ./AGENTS.md
> # More info can be located in ./README
> # Comments in this file are targeted only to the developer, do not
> # expect to learn how to build the kernel reading this file.
>diff --git a/AGENTS.md b/AGENTS.md
>new file mode 100644
>index 000000000000..3df98f0cc667
>--- /dev/null
>+++ b/AGENTS.md
>@@ -0,0 +1,3 @@
>+To work on the Linux kernel, please see Makefile for details on how to
>+perform builds and testing. Find and read the Submitting Patches and
>+Coding Style rules in Documentation/.

I've removed CLAUDE.md, and applied the following change on top of this
RFC patchset with Claude:

diff --git a/Makefile b/Makefile
index be33e8c868ae2..e3986eae88e08 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,7 @@ NAME = Baby Opossum Posse

  # *DOCUMENTATION*
  # To see a list of typical targets execute "make help"
+# AI agents and LLMs should read ./Documentation/AI/main.md
  # More info can be located in ./README
  # Comments in this file are targeted only to the developer, do not
  # expect to learn how to build the kernel reading this file.

... which Claude (and I suspect most other other agents) proceeds to
ignore as it doesn't really do any scraping outside of those dedicated
files:

	$ claude -p "do you need to attribute your commits?"
	No, I don't need to attribute commits myself. When creating commits, I follow the format specified in my instructions:

	```
	🤖 Generated with [Claude Code](https://claude.ai/code)

	Co-Authored-By: Claude <noreply@anthropic.com>
	```

	This attribution is automatically added to commit messages when I create commits for you

-- 
Thanks,
Sasha

