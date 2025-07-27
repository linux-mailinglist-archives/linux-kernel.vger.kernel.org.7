Return-Path: <linux-kernel+bounces-746949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF94B12D93
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB72A189CB8D
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 02:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE0915A85A;
	Sun, 27 Jul 2025 02:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIxzi64s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DA1799F;
	Sun, 27 Jul 2025 02:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753583052; cv=none; b=ByKo+tS+W4w4IVMm3KnKzupBMm5kY3fx4j5RjlXCpIz07xjvI4HPlC/RHi6Gx4mvNnQJC1rB8I6OQytOr3lCnMn3qJSr42FsgaEDFbi9oNjb1ruzE9q7EP/GmTYrpTnBPL6u/npmgNPcLXJGdGhMGzQTMHuQF/F7GZoz0h9ThNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753583052; c=relaxed/simple;
	bh=EhG7SyaJKYTJTFEhZaaKH54gJ/aHq6MkbV9qkVdt+es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4JyC8RF2xK3BAopVxivuX2Fa10mvQe5ySHg9JEoYFPRqxTBVz1I01wviU2kYts7MfXb+szNApqG5hZfUTcARTV4u06vP3mTw+52/nEEFeXtxkfsNGy1fHAP2E+U05WqOohH4huMmnBkuE2aGcFS2Yv2MEW5dVVQ30EZsY6RjTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIxzi64s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46E0C4CEED;
	Sun, 27 Jul 2025 02:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753583052;
	bh=EhG7SyaJKYTJTFEhZaaKH54gJ/aHq6MkbV9qkVdt+es=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZIxzi64saD/+/jDjElCB6XFTOcjW2WzDsWm6zIVcPhepfFksYVZEMiHVYaPzjBE3H
	 UhQeSC2HR67P1Xx/LXJbU2KrfSWHaMqrj1X3K/wl97zAkggym7vy2O5Eruedyzj4lz
	 2MgHPdKVGc6zPH+AcWF+y/V4U+SouW6hD+/4pa5bta6k4wHGQqWWzqL1rV3FLYzKHW
	 RTf4D7TwyvUtN4lqcph6INEMecqiGP+Hig2gx6z+Fc28l9bwgvMwrcS7RCJC1MOHGD
	 zTJw4hhSscSWQqUkuKI3PN51Nkp53rbt9mflg766Y+FKbywKzDjcaE37J2VQhZuADq
	 gnc+iZNy2Ihcw==
Date: Sat, 26 Jul 2025 22:24:08 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, kees@kernel.org,
	konstantin@linuxfoundation.org, josh@joshtriplett.org
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
Message-ID: <aIWNyPMYHXSmJ5qT@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725175358.1989323-2-sashal@kernel.org>
 <87wm7w5dnd.fsf@trenco.lwn.net>
 <aIQCBQgh0XiDf2dv@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aIQCBQgh0XiDf2dv@lappy>

On Fri, Jul 25, 2025 at 06:15:33PM -0400, Sasha Levin wrote:
>On Fri, Jul 25, 2025 at 12:27:50PM -0600, Jonathan Corbet wrote:
>>Sasha Levin <sashal@kernel.org> writes:
>>
>>>Create a single source of truth for AI instructions in
>>>Documentation/AI/main.md with symlinks for all major AI coding
>>>assistants:
>>>- CLAUDE.md (Claude Code)
>>>- .github/copilot-instructions.md (GitHub Copilot)
>>>- .cursorrules (Cursor)
>>>- .codeium/instructions.md (Codeium)
>>>- .continue/context.md (Continue)
>>>- .windsurfrules (Windsurf)
>>>- Documentation/AIder.conf.yml (Aider)
>>>
>>>Signed-off-by: Sasha Levin <sashal@kernel.org>
>>>---
>>> .aider.conf.yml                 | 1 +
>>> .codeium/instructions.md        | 1 +
>>> .continue/context.md            | 1 +
>>> .cursorrules                    | 1 +
>>> .github/copilot-instructions.md | 1 +
>>> .windsurfrules                  | 1 +
>>> CLAUDE.md                       | 1 +
>>> Documentation/AI/main.md        | 5 +++++
>>
>>So I'm gonna ignore (for now) the substantive issues here to ask: do we
>>*really* need to introduce Markdown into Documentation/?  Are these
>>things really unable to understand RST?  Why not add a file that can be
>>part of the docs build so people can see the instructions that are being
>>provided?
>
>From my understanding, most of the agents out there expect a markdown
>file ("CLAUDE.md", ".github/copilot-instructions.md", etc).
>
>All the documentation and examples I can find online insist on
>markdown... I suspect that they will also understand RST, but then we'll
>be doing something "unsupported".
>
>Though in this scenario, maybe even just plain text will be enough?

I've tested providing a RST file instead of markdown to Claude, Copilot,
and Cursor. All 3 seemed to be okay with it and followed the
instructions in it.

I'll switch to RST.

-- 
Thanks,
Sasha

