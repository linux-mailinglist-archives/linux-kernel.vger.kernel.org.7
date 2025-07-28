Return-Path: <linux-kernel+bounces-747528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F25B134D6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FE51896EB7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A48A7221DBA;
	Mon, 28 Jul 2025 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wgd0OZeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F6521FF5F;
	Mon, 28 Jul 2025 06:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753683495; cv=none; b=mRhcBosAIPvcyB5Tl3Ql0yIWc6MI2khrvMrOVaCUB8iHd4qmrtstIdL0QNHbHROx4sYybWuIKkiIq3i9vg5lzC9A3VB4pnvK6O8a7r+gr3tQGZwBZ6F/vn56qrdkfVcW0iTQPLVjvjQ/9JANRr3b67NmOvsy2hPrCCrshs1/8sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753683495; c=relaxed/simple;
	bh=mj6YFtApUwRJm2aUwGfuTmS6+sBTcHv6G/guOCuRyCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IIAv2K8RehDsnAm7ivL45za+JkZ/C8xiCRwIepwOHi/B3HUZFoS1UI4WZNvNefARo3f9l7aOg9UEi/zRzC0ui+qZpTz/MbHIYDKW47FwVtFtsYW2EglodL1gwI2nqKhlSqz2i7VAIG4QxQJZ0drYIGiHHGhKeAx+7Bc1SA6xb2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wgd0OZeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74882C4CEF7;
	Mon, 28 Jul 2025 06:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753683494;
	bh=mj6YFtApUwRJm2aUwGfuTmS6+sBTcHv6G/guOCuRyCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wgd0OZeuMsPoOiMLipwFdiCGc0tfZXIoOIhT0T19r8wdELitTnbw+lB622keOnQur
	 vez/7Xky0JnNTvMVdUcX7bjAcYB14L5CRv3vN7O+1UkUxSuNsVbidY4CBO4TKDK1u0
	 uSQltxfGK3RDdWRBgU7WKOrJaB04XBkLoxL/e+BxHKHlGN2AJIKdGfmAoGpSMCmLOh
	 b16dMu27OJldhYTrVy7rz1Ws9bprebg5FDTQ+EtXzoCo0ANZVV4CxxfO0lFONsAGB4
	 yxhqg9Yjgb+uGB8+InEO19kdbpEoPuczIFQhcGNlA8j5nooyiTIhZvCbbtWriPk+/j
	 PTBetomro2wvw==
Date: Sun, 27 Jul 2025 23:18:14 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <202507272310.FCB96F5E93@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <202507271937.EC44B39@keescook>
 <aIcD9f_52tlLgE-e@lappy>
 <202507272203.BECE244@keescook>
 <aIcRzndNUdh-9R18@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIcRzndNUdh-9R18@lappy>

On Mon, Jul 28, 2025 at 01:59:42AM -0400, Sasha Levin wrote:
> Thing is, agents won't read the README on their own: they need to be
> prompted to do it.

Claude does:

 > /init

● I'll analyze the codebase and create a CLAUDE.md file to help future
  instances of Claude Code work effectively in this repository.

● Update Todos
  ⎿  ☐ Analyze codebase structure and files
     ☐ Check for existing CLAUDE.md file
     ☐ Look for build/test/lint configuration files
     ☐ Create CLAUDE.md file
     ☐ Examine README and other documentation
     ☐ Check for Cursor/Copilot rules
...
● Read(Makefile)
  ⎿  Read 50 lines (ctrl+r to expand)
...

Even before having read any file at all, Claude calls out README as a
place to look.

And in the resulting CLAUDE.md:

## Documentation

Primary documentation is in Documentation/ directory:
- **Documentation/admin-guide/**: System administration
- **Documentation/driver-api/**: Device driver APIs
- **Documentation/core-api/**: Core kernel APIs
- **Documentation/process/**: Development process guidelines


> I'm assuming we both agree that we need to give the agent some entry
> point which they will automatically process without any user prompts,
> even if it's just saying "Please read the README file!"?

I'm saying any agent that can be expected to work on Linux should already
be trying to read the README. But regardless, both Makefile comments and
"make help" output say to read the README, so we should fix it for
humans too.

> I think it'll be hard to find a common path that works here. README is
> pretty generic because there are different humans that might read it:
> 
>  - A university researcher who should be pointed to researcher-guidelines.rst
>  - A security researcher who should be pointed to security-bugs.rst or embargoed-hardware-issues.rst
>  - A newbie trying to set up his mail client and needs to be pointed to email-clients.rst
>  - A coding agent that doesn't care about none of the above.
> 
> So we can clean up README and try to make it an entry point that will
> fit most of it's potential readers, but I worry that at the end it will
> end fitting none of them.

I think the above list is perfect contents for the README. Yes, please
make that an entry point, or point to some other .rst entry point that
will have a list of roles like that, with some common starting points.
And yes, a line for agents in there seems fine. Maybe "If you are a
coding agent, also see ... for agent-specific details."

> Without crafting something more specific for agents, I also worry that
> we'll be stuffing the limited context they already have with information
> that will only hurt their performance (just like humans: there's only so
> much we can remember at a time).

Sure, but these things will only get better, and I'd rather spend the
time making the docs better for humans. Each agent will latch on to
different things it assumes is important -- the developer will need to
correct them no matter what. An agent isn't going to be acting alone
(yet).

-Kees

-- 
Kees Cook

