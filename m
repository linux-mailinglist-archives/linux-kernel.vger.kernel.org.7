Return-Path: <linux-kernel+bounces-747029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E68B12EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 11:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A916D189AEA6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 09:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D021FECD4;
	Sun, 27 Jul 2025 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIU477FM"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5B33F3;
	Sun, 27 Jul 2025 09:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753609064; cv=none; b=YBDzHLtzZ6lRMAHAHKnmzCBW+X37pIHbfnGeNxxA/RPqrtH2l/qULo9hM6y6//HiObtSNKjl/FHWDIywjNBwxG37cTtmMTfaF2ypVAf7WIJ2qvKOE/hswahJlVgGTRDja7cv7eyGhcqcm731M6x5QDei0FhYCcEJYUivZW324+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753609064; c=relaxed/simple;
	bh=r1WUJTuYaXc6Gg3ue+6sjWGHwrgY6KnugGpFvW2bxBo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=A7N81jc0BCE3RMnEDElyPbii3biSNjMTkt4oU3ZTXc71HB0KwmwMdPpqqqD4woBnLuOouc9ZgnOH3o2Da4cDUefbgZ5WWC8Nz1gldJyraNFBSYQE982P50+NyDIlVeqW//pXR721yHMzG4zHjQuo5WP/1L3lx6hJ3IyPjyZAMbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TIU477FM; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-553d771435fso3611008e87.3;
        Sun, 27 Jul 2025 02:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753609060; x=1754213860; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vDEbh++iSuge5z5TnrZi30Y6NAK/TEXvCRb5ta8Z3dY=;
        b=TIU477FMxPhUadWT70p0G3Hoy+wjD+MDhGRKtLi+k/uUfvrteL5pw9vP9A/a587Lvb
         17DXR+OqcAlhc+IRzePnoKjq7bJdzrWZv+9/i5C8eyGKRaiH1sy9laH92nXP9EkYO+1p
         HZMLiU9281gii8JZ1onCpo52ZCXdxLi+Fo+DL4sRpFn8r+gNau5/3/kKXqAUVZNjKZVt
         6UNzzYi5HiW0sJjiaxMmLO45hCQjKNH7OLJzBjsPzPiWXCt7D24ky23VFoGFXR2ra2Pp
         PqxMY7Ff66eyOlfOK/I3cJOCpJ+x2uFwqHSqMiR9+9hu7TjEfn54KZFGtiusvrHugCBS
         ELlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753609060; x=1754213860;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vDEbh++iSuge5z5TnrZi30Y6NAK/TEXvCRb5ta8Z3dY=;
        b=Xugb6TiE7zf25d8NAw0MJQfjKn8atPbNLiLw5ZUlvY0W9FtgVDwI+RKeywvbh0tS5O
         qa3vh8NJTaVPd8ceuM75I5n6iAhbC4kx4G0w41JPiMMZ58Nypw1em6X67QjAFPfLP9BU
         r7baVVejSydIxV50oPZKi/6GoRjdgcXeL9uMIGUVyuwYGAY0ZBYJ48ROxCODjOdCE0H2
         21BiKMjDYi8TE/Q6oSgl6RP/ZzBItvpOyXcpdWlceEiFcSkOoUarHPcAM5XRtLYeBYzl
         WYN7mYiD4lFdh6YDQ0P6jL2cYPCOEJidHrt8YJKoFk4INfhLEh/pd7ohZ9GYq/FsByjG
         efIA==
X-Forwarded-Encrypted: i=1; AJvYcCVRh1XCJEm2w9SBtH+Avagjxyvdr7hrSWWXJoyR/cL0Xm5BegUdsI7NrZ8QHbqjrI32y0slfRhKfZef8vcI@vger.kernel.org, AJvYcCWf0rntBoas8qsqZOeyLF2W+H8luZg0FzHGwsLFV525FTEQsMb6WLI6s2dxJ9S1OsWEQDHSaklb1H4=@vger.kernel.org, AJvYcCXiuV6HHGznuHOkHHl6PFHWG4x6CGAfz7BDEeXM2GtZZZhMufS3yaEIci2YTVSXMMPTH+mKhwZTpm2W@vger.kernel.org
X-Gm-Message-State: AOJu0YwyyEkEu1LG9iyNxZz8dP0XHDEcFZeLHa3tFRymoP1i/DBFgrxE
	se8p7o5CPVpTDfkRg2qGkXo/1lMScCh8hSNxLNfSUrDvCnWdArjoRBz/EiemoSZYh7SQCBL+3Ng
	tY5cT751ywL8j1fzonPfsrXmnvFKf8/U=
X-Gm-Gg: ASbGnctn8mmIhZYnIsfIpaVwgFbH2PGwbqNaNEoYePx8XPBVGQr4X68gUspBIVyZmEt
	gidxiBi2XPvKNIRgbLtgsyCLv1GfF5kE5pGtEKTZjZN7LEO7rrR7tuWTNI3ap/f0Hx8+6mFenCV
	zxcjNRUqaBtPYY/3OZ0UoRrZl9kkcl1VDcKY7Vo+LBZ/iPiDy+eKVil5ano6VxsaNyUFxqXZy3x
	/SSPP0=
X-Google-Smtp-Source: AGHT+IFx2Zb6DNpjfWCZqV5auDlsQGPpd/qr44bZuQG/DVvNr59t+emtF+I+c9L1/PhAsrWppHXxHxZ43OuYMVqO2eI=
X-Received: by 2002:a05:6512:2207:b0:553:2480:2308 with SMTP id
 2adb3069b0e04-55b5f44c926mr1824136e87.21.1753609059868; Sun, 27 Jul 2025
 02:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Date: Sun, 27 Jul 2025 14:37:22 +0500
X-Gm-Features: Ac12FXwMFqDvpaVLlUMYgDZA8RrAeq-B-Vv1dI2Sz-pocvCE4yZpymVjKBZ8lNk
Message-ID: <CACzwLxg=vQeQKA1mPiYV9biu=swo7QDmjB3i=UhYmv+fGRBA4Q@mail.gmail.com>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
To: Sasha Levin <sashal@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: rostedt@goodmis.org, kees@kernel.org, konstantin@linuxfoundation.org, 
	corbet@lwn.net, josh@joshtriplett.org, 
	Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On 7/25/25 22:53, Sasha Levin wrote:
> This patch series adds unified configuration and documentation for AI
> coding assistants working with the Linux kernel codebase. As AI tools
> become increasingly common in software development, it's important to
> establish clear guidelines for their use in kernel development.
>

Hello,

Thanks for bringing up this topic.

I want to share my experience as I've recently made a primitive experiment
working on various Linux kernel development tasks along with LLM help.

Slides are available at my Telegram channel [1], which I presented at
the local 2600
conference in June, '25.
[1] https://t.me/novitoll_ch/366

My tasks were:
- Analyze syzkaller crash report (w/ and w/o human patch exists)
- De-obfuscate syzkaller C reproducer
- Generate syscall descriptions for syzkaller
- PATCH review (feeding entire PATCH series)
- Generate mm/kasan code snippets
- Generate git commit message for the given git diff, and also generate the
  cover letter

The "results" of experiment gave me following understandings of the current 2025
state of LLMs:

- Code generation

LLMs (Claude 4 Sonnet, OpenAI o3, Gemini 2.5 Pro) are trained to give code
samples for not-latest git tree. You can configure your own MCP client, e.g.
Claude Desktop, Trae.ai etc. with external MCP servers. I was advised to try
context7 MCP server [2] which should hint LLM to give code xrefs, documentations
within "the latest" kernel version. I've just checked that the latest version
on context7 MCP was 2 weeks ago, which means that at the current moment
the pace of PATCH submissions to various linux-* trees exceeds the
synchorization of context7 MCP server so LLM can give you "the actual code".

So without human/scripted assistance `git apply PATCH` is error prone.

[2] https://context7.com/torvalds/linux

- Generated code limits in the LLM context window

During my experiment with mm/kasan code generation, the context window of
LLM was the problem. OpenAI o3 does not limit you with the long dialogue,
however I guess, it might forget the code you mentioned in the beginning.

Claude 4 Sonnet (chat bot version, not API) has a limited context window -
you send it the PATCH series, it replies back, you correct the LLM with such and
such, LLM apologies, corrects back etc. This dialogue might end up with many
chat interactions, that eventually Claude 4 Sonnet tell you "Start a new chat,
the context window exceeded the limit". This was on my $20/month subscription.

I know that there's a memory bank for Cursor [3], but my point is that during
PATCH series and human interaction as the verifier, I've faced the issue with
it.

[3] https://github.com/vanzan01/cursor-memory-bank

- Code verification

LLM does not do any kind of verification of proposed code. So the human still
needs to compile, run, test it.

- LLM API tokens cost for MCP agents

At the end of my experiment, I've tried to have a MCP agent, where I've
explained to the agent its role. I've set the temperature coef (LLM creativity)
to 0.7:
- 0.0       = most deterministic
- 0.3 - 0.5 = summary, tech writing
- 0.7       = balanced, default in most LLMs
- 1.0+      = more creative, randomness

Max tokens per 1 chat = 10240, max iterations = 10 (MCP agent can produce up to
10 chats). Result is 100K tokens. Which in OpenAI o3 was less than $1 per my
billing.

== Summary

While LLMs are **really** good in composing git messages, cover letters (in
fact, LLM was initially designed to predict the next word, AFAIU), and composing
you error-free grammatically, with all Oxford English dictionary,
yet my current $20/month in Claude, $20/month in OpenAI subscriptions and
$20 for the API usage, does not allow me to "vibe coding" with the Linux kernel.

> The series consists of two patches:
>
> 1. The first patch adds unified configuration files for various AI
> coding assistants (Claude, GitHub Copilot, Cursor, Codeium, Continue,
> Windsurf, and Aider). These are all symlinked to a central documentation
> file to ensure consistency across tools.
>

I don't think that we want to have a separate instruction per vendor.
Like you missed trae.ai, for example. So perhaps, _if_ the Linux kernel has the
documentation for LLM setup, then I'll be happy to see following:

- MCP server setup. MCP JSON is applicable for all aforementioned vendors,
so we won't have to support vendor specific instructions. A custom MCP server
with tools like "@code_review", "@code_gen" etc. that does everything we accept
in the Linux kernel process.

- MCP agent(s) role instructions. Since LLMs are trained publicly, e.g. they are
  not specifically trained to understand the Linux kernel code, we need to
always explain LLM jobs. What we expect from it, what it should and should not
do. So some instruction templates (with CAPITAL letters, I've heard LLM
understands it better in such a form) will be canonical. Here was my LLM
instruction [4]:

https://github.com/novitoll/mcp-linux-kernel/blob/d763e85f5ba8ab21ea73ecdeaea35a6ffab6b4f2/demo/finder_agent.py#L17-L29

_AI_ agent per sub-system and driver can be even better. Like if PATCH is within
linux-mm subsystem, then the appropriate linux-mm MCP agent should be involved
as it has the role to assess the code from different perspectives: w/, w/o KASAN
compilation etc.

P.S.: Personally, I've decided to pause on the vibe coding, since I
spent too much time on
explaining to LLM the context and copy-pasting errors, and reading the notorious
answer from LLM **You're absolutely right! Let me change my code ...**.

> 2. The second patch adds the actual rules and documentation that guide
> AI assistants on Linux kernel development practices, including:
>     - Following kernel coding standards
>     - Respecting the development process
>     - Properly attributing AI-generated contributions
>     - Understanding licensing requirements
>
> The examples below demonstrate how these guidelines work in practice, showing
> proper AI attribution in commits and the assistant's understanding of kernel
> documentation requirements.
>
> All AI assistants are required to identify themselves in commits using
> Co-developed-by tags, ensuring full transparency about AI involvement in
> code development.
>
> "Hello world" test:
>
>       $ claude -p "do you need to attribute your commits?"
>       Yes, according to the CLAUDE.md file in this Linux kernel repository, I must identify myself as an AI assistant in commits by including:
>
>       ```
>       Co-developed-by: Claude claude-opus-4-20250514
>       ```
>
>       I should NOT add a Signed-off-by tag - only you (the human developer) should add that, as it represents a legal certification.
>
>
> Example patch creation with Claude Code:
>
>       $ claude -p "Fix the dont -> don't typo in @Documentation/power/opp.rst. Commit the result"
>       Done! The typo has been fixed and committed.
>
>
> And the resulting patch (no manual edits):
>
>       From 7613561f430920803d945b3cd53aa81440d4f6f0 Mon Sep 17 00:00:00 2001
>       From: Sasha Levin <sashal@kernel.org>
>       Date: Fri, 25 Jul 2025 13:38:43 -0400
>       Subject: [PATCH] Documentation: power: opp: Fix typo dont -> don't
>
>       Fix a typo in the OPP documentation where "dont" was missing an apostrophe.
>
>       Co-developed-by: Claude claude-opus-4-20250514
>       ---
>        Documentation/power/opp.rst | 2 +-
>        1 file changed, 1 insertion(+), 1 deletion(-)
>
>       diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
>       index 1b7f1d854f14a..3eae4b955a63b 100644
>       --- a/Documentation/power/opp.rst
>       +++ b/Documentation/power/opp.rst
>       @@ -149,7 +149,7 @@ dev_pm_opp_find_freq_exact
>
>                opp = dev_pm_opp_find_freq_exact(dev, 1000000000, false);
>                dev_pm_opp_put(opp);
>       -        /* dont operate on the pointer.. just do a sanity check.. */
>       +        /* don't operate on the pointer.. just do a sanity check.. */
>                if (IS_ERR(opp)) {
>                       pr_err("frequency not disabled!\n");
>                       /* trigger appropriate actions.. */
>
>
> Sasha Levin (2):
>    AI: Add unified AI coding assistant configuration
>    AI: Add initial set of rules and docs
>
>   .aider.conf.yml                 |  1 +
>   .codeium/instructions.md        |  1 +
>   .continue/context.md            |  1 +
>   .cursorrules                    |  1 +
>   .github/copilot-instructions.md |  1 +
>   .windsurfrules                  |  1 +
>   CLAUDE.md                       |  1 +
>   Documentation/AI/main.md        | 71 +++++++++++++++++++++++++++++++++
>   8 files changed, 78 insertions(+)
>   create mode 120000 .aider.conf.yml
>   create mode 120000 .codeium/instructions.md
>   create mode 120000 .continue/context.md
>   create mode 120000 .cursorrules
>   create mode 120000 .github/copilot-instructions.md
>   create mode 120000 .windsurfrules
>   create mode 120000 CLAUDE.md
>   create mode 100644 Documentation/AI/main.md
>

