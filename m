Return-Path: <linux-kernel+bounces-747953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE90BB13A94
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 375E73B5223
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813B826463A;
	Mon, 28 Jul 2025 12:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKNsmfXf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D548E6EB79;
	Mon, 28 Jul 2025 12:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753706144; cv=none; b=rU0SU5gkI4KBNdxDV3ONP2N64XauEQGJ4FO3sGR/erlv7yttCe4VXdsFMHgGh3IsFK0lZ+Stsoi7NlmexWZ/6IjgI3VyaHV3dzYkWbOI+m6gmDgVRQ50qV4qT8PIz/mlXcfqqawBc5Zk3pRPwyQPJ27hO9rADsoA5SRPM7iv4N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753706144; c=relaxed/simple;
	bh=o8eZs36uMwbLt2BUAEIAM068UV589WXxCIFQXsvIgxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgXs6vgtyFR9ZPSFbRATaeXxOejRUcMKZEuhlReJ4i4gqaZbud3O+AJhjAnXJKfp96szdGHRHXWPyxwoYHW0/UOBGrP+KPUSxl0+veiN6+uqvPC6BsSfBZAviuK5+NS3vlkDrAK/SZC/7fFsmzNZOgU2BdlTRDfYd43JwLRrylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKNsmfXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DE5C4CEE7;
	Mon, 28 Jul 2025 12:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753706142;
	bh=o8eZs36uMwbLt2BUAEIAM068UV589WXxCIFQXsvIgxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKNsmfXfJSpatoHENS6oF9FumDsyEvw49ea6rZNlrCqSP0f0OfuZcFLLGB1zsxDN6
	 vsaWG9Lk8DHlTJAPfF8H1HwcEE8wyCvy3oG1YwR08fMXZa++n8slKCdQaxjermbZsG
	 ONP/Mdx0sKMLFio8Mtx4RGGrtK9uVXzi7Oa8moc3d/87skOMYdHqVOANLr/p8Q+Rrh
	 HBqy2waiYMO+ZnDZYpjv6lipZHUpr3DnsKyYUyKOeQFobuhXivscTMRviwYp2KMmxY
	 5YpQvE+LDJNsLEqA4Hsc4qNytKOGhq9P/0+u517RLbvDidF4Pz2KcuDQcICVHP/mBo
	 slojZ160G9P6g==
Date: Mon, 28 Jul 2025 08:35:40 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 2/4] agents: add core development references
Message-ID: <aIdunK1e4I_jq_lI@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-3-sashal@kernel.org>
 <202507271937.EC44B39@keescook>
 <aIcD9f_52tlLgE-e@lappy>
 <202507272203.BECE244@keescook>
 <aIcRzndNUdh-9R18@lappy>
 <202507272310.FCB96F5E93@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202507272310.FCB96F5E93@keescook>

On Sun, Jul 27, 2025 at 11:18:14PM -0700, Kees Cook wrote:
>On Mon, Jul 28, 2025 at 01:59:42AM -0400, Sasha Levin wrote:
>> Thing is, agents won't read the README on their own: they need to be
>> prompted to do it.
>
>Claude does:
>
> > /init
>
>● I'll analyze the codebase and create a CLAUDE.md file to help future
>  instances of Claude Code work effectively in this repository.
>
>● Update Todos
>  ⎿  ☐ Analyze codebase structure and files
>     ☐ Check for existing CLAUDE.md file
>     ☐ Look for build/test/lint configuration files
>     ☐ Create CLAUDE.md file
>     ☐ Examine README and other documentation
>     ☐ Check for Cursor/Copilot rules
>...
>● Read(Makefile)
>  ⎿  Read 50 lines (ctrl+r to expand)
>...
>
>Even before having read any file at all, Claude calls out README as a
>place to look.
>
>And in the resulting CLAUDE.md:
>
>## Documentation
>
>Primary documentation is in Documentation/ directory:
>- **Documentation/admin-guide/**: System administration
>- **Documentation/driver-api/**: Device driver APIs
>- **Documentation/core-api/**: Core kernel APIs
>- **Documentation/process/**: Development process guidelines
>
>
>> I'm assuming we both agree that we need to give the agent some entry
>> point which they will automatically process without any user prompts,
>> even if it's just saying "Please read the README file!"?
>
>I'm saying any agent that can be expected to work on Linux should already
>be trying to read the README. But regardless, both Makefile comments and
>"make help" output say to read the README, so we should fix it for
>humans too.

But my point is that calling /init is a prompt (just one hidden behide
the scenes).

Without an explicit /init call and no CLAUDE.md (or the copilot/cursor
equivalents which I've tested), nothing reads README.

>> I think it'll be hard to find a common path that works here. README is
>> pretty generic because there are different humans that might read it:
>>
>>  - A university researcher who should be pointed to researcher-guidelines.rst
>>  - A security researcher who should be pointed to security-bugs.rst or embargoed-hardware-issues.rst
>>  - A newbie trying to set up his mail client and needs to be pointed to email-clients.rst
>>  - A coding agent that doesn't care about none of the above.
>>
>> So we can clean up README and try to make it an entry point that will
>> fit most of it's potential readers, but I worry that at the end it will
>> end fitting none of them.
>
>I think the above list is perfect contents for the README. Yes, please
>make that an entry point, or point to some other .rst entry point that
>will have a list of roles like that, with some common starting points.
>And yes, a line for agents in there seems fine. Maybe "If you are a
>coding agent, also see ... for agent-specific details."
>
>> Without crafting something more specific for agents, I also worry that
>> we'll be stuffing the limited context they already have with information
>> that will only hurt their performance (just like humans: there's only so
>> much we can remember at a time).
>
>Sure, but these things will only get better, and I'd rather spend the
>time making the docs better for humans. Each agent will latch on to
>different things it assumes is important -- the developer will need to
>correct them no matter what. An agent isn't going to be acting alone
>(yet).

Oh, this is interesting!

Do you see it being as something like "Common kernel usage usecases" and
then some sort of a tree of docs/blurb related to those uses?

Sort of like a meta-index that indexes the docs by purpose rather than
their location in the directory?

Do you see it as being just links to existing docs or should it have
some blurb in addition to the links?

-- 
Thanks,
Sasha

