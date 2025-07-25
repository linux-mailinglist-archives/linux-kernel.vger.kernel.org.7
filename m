Return-Path: <linux-kernel+bounces-746441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 608D6B126B0
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D39D1CE5758
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148B3256C91;
	Fri, 25 Jul 2025 22:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rh+CLp4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3F1D5AD4;
	Fri, 25 Jul 2025 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481461; cv=none; b=Q+J2rkobh7qdQF6wI0STUMaDb9U/FfVLCo0vBlbUHqxzCG7s4mOttJ540XhUiynqlbojWtdoEKugifksOh6+dCrpS+C07GPCcidWskg/aN/tNPT3mNcAB7HZeZfxcZl7clmC0zjarcfg85s7cqYtKjnsNA5JNZDrnSani5FtLZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481461; c=relaxed/simple;
	bh=RN/PgXTtaWojAnY/YuC0PekfWd7MAvOKqy5R1YpmgwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCEQ2K2Pd1HZH0I/Ukzms4VZZgwBwUQThBu2aj69FAzAVWQjqHs+BGIKq5BQITlkM4R0RSdh/TXwBw01ruWSn9RBdJrKND7oNEK7J4mt+L0ECSuq3YEClQbPw6ZHrCaPL88fsdjbWJ+hszoGd+C8nHo17NExJ6dlO8+xIumVOoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rh+CLp4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9575BC4CEE7;
	Fri, 25 Jul 2025 22:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481460;
	bh=RN/PgXTtaWojAnY/YuC0PekfWd7MAvOKqy5R1YpmgwI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rh+CLp4jt2HMq7ozEUbOHhGFH4LPfgzkMkwK9oT9LEPMYgY7+6mejvsOaCif3au7Q
	 dysrL/f51pK3DG+6yLw22q+yccXmu8wjpV5nA8BuXfWZOoiF3pcslEbGdEiwyNml32
	 msuDAK11CRGH9uj4+wG2TFQ5MCa3EcCC+NS8i6jNaXDSzTeeLqs5UP3djNdsENPySc
	 /TlD+sSUrn4BPv/g3TLkkgymo1rMCxR8nRGjUCCYpTv/pE7VeZSIOv7ABCZ6zV6Lmr
	 h6ppKglHFzvphxgn5YocMIgMSsvASsLmwsakdAcOPznJPyFooeNG3QFusp7ms5wVKV
	 jbeIsMTyTF5Ag==
Date: Fri, 25 Jul 2025 18:10:58 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 2/2] AI: Add initial set of rules and docs
Message-ID: <aIQA8oizbtK4zSTL@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725175358.1989323-3-sashal@kernel.org>
 <202507251341.C933489@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507251341.C933489@keescook>

On Fri, Jul 25, 2025 at 01:53:57PM -0700, Kees Cook wrote:
>On Fri, Jul 25, 2025 at 01:53:58PM -0400, Sasha Levin wrote:
>> Add rules based on our existing documentation.
>
>I'd still like this not in Documentation/, but I obviously defer to Jon.
>
>> Require AI to identify itself in the commit message.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  Documentation/AI/main.md | 70 ++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 68 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/AI/main.md b/Documentation/AI/main.md
>> index 959ba50568f57..ca59e52f54445 100644
>> --- a/Documentation/AI/main.md
>> +++ b/Documentation/AI/main.md
>> @@ -1,5 +1,71 @@
>>  # Linux Kernel Development AI Instructions
>>
>> -This is the Linux kernel repository. When working with this codebase, you must follow the following rules:
>> +This is the Linux kernel repository. When working with this codebase, you must follow the Linux kernel development processes and coding standards.
>>
>> -- [ TODO ]
>> +## Essential Documentation References
>> +
>> +### Core Development Process
>> +- **Documentation/process/howto.rst** - Start here! The comprehensive guide on how to become a Linux kernel developer
>> +- **Documentation/process/development-process.rst** - Detailed information on how the kernel development process works
>> +- **Documentation/process/submitting-patches.rst** - Essential guide for getting your code into the kernel
>> +- **Documentation/process/submit-checklist.rst** - Checklist to review before submitting code
>
>Instead of hard-coded paths, I would recommend just discuss the topic
>areas it is expected to find and ingest. :) (e.g. redo the "Key
>principles" list you have later to be more specific about the topic
>areas and adjust the prompting to induce the requirement to find and
>read each topic.)

I'm very open to changing these parts. Ideally we can rewrite it in a
way that's easier for the agent to process rather than something that is
more readable to humans.

>> +
>> +### Coding Standards and Style
>> +- **Documentation/process/coding-style.rst** - Linux kernel coding style (MUST READ)
>> +  - Use tabs (8 characters) for indentation
>> +  - 80-character line limit preferred
>> +  - Specific formatting rules for switch statements, functions, etc.
>> +- **Documentation/process/programming-language.rst** - Language requirements and standards
>> +
>> +### What NOT to Do
>> +- **Documentation/process/deprecated.rst** - Deprecated interfaces and features to avoid
>> +  - Do not use BUG() or BUG_ON() - use WARN() instead
>> +  - Avoid deprecated APIs listed in this document
>> +- **Documentation/process/volatile-considered-harmful.rst** - Why volatile is usually wrong
>
>And the reason I want to avoid such specifics is that even as an example
>above, this ends up being hyperspecific. Why summarize the
>deprecated.rst? Just say "Find and read the notes on deprecated APIs and
>language features"

When we're being explicit with rules, the agent is more likely to not
ignore it (and go "whoops I messed up!" later).

It's a balance we need to find, but I suspect we can fine tune as when
we see how various agents respond to the rules.

>> +### Patch Submission Process
>> +- **Documentation/process/5.Posting.rst** - How to post patches properly
>> +- **Documentation/process/email-clients.rst** - Email client configuration for patches
>> +- **Documentation/process/applying-patches.rst** - How patches are applied
>> +
>> +### Legal and Licensing
>> +- **Documentation/process/license-rules.rst** - Linux kernel licensing rules
>> +  - Kernel is GPL-2.0 only with syscall exception
>> +  - All files must have proper SPDX license identifiers
>
>The only stuff I think should be in this kind of area is a commentary
>about how an Agent differs from a human. "You are not a legal entity;
>you cannot sign the DCO", which you get into below.

I was thinking that if we explicitly call out the GPL requirement, an
agent will avoid searching online resources and potentially embedding
code that is not licensed under GPL.

>> +### Specialized Topics
>> +- **Documentation/process/adding-syscalls.rst** - How to add new system calls
>> +- **Documentation/process/stable-kernel-rules.rst** - Rules for stable kernel patches
>> +- **Documentation/process/security-bugs.rst** - Handling security issues
>> +- **Documentation/process/handling-regressions.rst** - Dealing with regressions
>> +
>> +### Maintainer Guidelines
>> +- **Documentation/process/maintainers.rst** - Working with subsystem maintainers
>> +- **Documentation/process/maintainer-handbooks.rst** - Subsystem-specific guidelines
>> +
>> +## Key Principles
>> +1. Read and follow the documentation before making changes
>> +2. Respect the existing code style and conventions
>> +3. Test thoroughly before submitting
>> +4. Write clear, descriptive commit messages
>> +5. Never break userspace (the #1 rule)
>> +6. Identify yourself as AI in commits (see below)
>
>Everything except #6 is already expected of human devs, so I think just
>the last item.
>
>> +
>> +## AI Attribution Requirement
>> +When creating commits, you MUST identify yourself as an AI assistant by including the following tag in the commit message:
>> +
>> +```
>> +Co-developed-by: $AI_NAME $AI_MODEL $AI_VERSION
>
>If we're going to go with Co-developed-by: here, then I think we need to
>explicitly say "do not include an email", and we must update
>checkpatch.pl to not yell about the missing S-o-b when it finds a C-d-b.
>(Perhaps it can skip the check with there is no email address in the
>C-b-d line?)
>
>> +```
>> +
>> +For example:
>> +- `Co-developed-by: Claude claude-3-opus-20240229`
>> +- `Co-developed-by: GitHub-Copilot GPT-4 v1.0.0`
>> +- `Co-developed-by: Cursor gpt-4-turbo-2024-04-09`
>> +
>> +This transparency helps maintainers and reviewers understand that AI was involved in the development process.
>> +
>> +### Signed-off-by Restrictions
>> +AI assistants MUST NOT add a Signed-off-by tag pointing to themselves. The Signed-off-by tag represents a legal certification by a human developer that they have the right to submit the code under the open source license.
>
>Hello trailing whitespace my old friend.
>
>"Unless explicitly told otherwise, Agents must never have trailing
>whitespace on any line and all files must have a final newline
>character." :)
>
>> +
>> +Only the human user running the AI assistant should add their Signed-off-by tag to commits. The AI's contribution is acknowledged through the Co-developed-by tag as described above.
>
>And can we please not use the term "AI"? I think "Agent" is the better
>generic term as it could include other things?

Ack

-- 
Thanks,
Sasha

