Return-Path: <linux-kernel+bounces-746712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11A2B12A4C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 13:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 169627A3455
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 11:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9B124113D;
	Sat, 26 Jul 2025 11:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TveVSDjN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E9F4685;
	Sat, 26 Jul 2025 11:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753530838; cv=none; b=skw6vv9GkaHhdEQUU1aUee4oKBqgl+irgISB5+NXMj2Y/k9R54ge4jQKe5Ght0Liloez0Ld/w7iraRXRcK9dvJ46DouaL7352UjUVn5lfEyW8IFaJzsKPyDGLOzMw4EORiRRg9RHKiU0FwQIsrKX1lYiCU+whwumuEUiZWB/YSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753530838; c=relaxed/simple;
	bh=RPbKDYis5DkvlyPdor/z+HmZWvr23l4AQ2Sr+Rikcg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqgjX1nFXDWw//+ohhywP0b4Cff6tEOPz99KezOzghsvEVoAla8jWA/5SkKMWzY6Lba08ugEBJiwQZXoRPRH0rBctofk4YntFGffoH9QsNtzvoNxUM6MKDMrQyku35IEtrPdCxJEoeoqYbmV6p0c3i8L2+VQ8P6VEX9T9maRcyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TveVSDjN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F68C4CEED;
	Sat, 26 Jul 2025 11:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753530837;
	bh=RPbKDYis5DkvlyPdor/z+HmZWvr23l4AQ2Sr+Rikcg4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TveVSDjNmVPETGaHZkDyj3OYbKnb5RsjGpCiNJEZFqTLOf0xJizoBQjvswXp98MMa
	 pVuh+kPcYHeXvjEdSnhIH5RaHgDUva6iqhmfhbGxRRfYP4h/AjBgnQDBFT5HggwyZ7
	 kA2VLuWB7BMCPifuT3NIJiWOB62vnw5SeIBTh7AC2WyQGo/cnDjLhiCSftjC5Q1Hgc
	 dobWlQbWaonZPpevfmzUkTO9CrZGvdSlzcF+gfO9HezaUAg+MpxM3nzEsNzfth0g9h
	 AhvwEXzkATxNkhCiMtBnq6t6cwpkGbEhmWe0jOxLkIcdCBH1SY9OOE4ZKFpK3wAMte
	 h3t0zvJj0B55Q==
Date: Sat, 26 Jul 2025 07:53:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, kees@kernel.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <aITB009h39D3-Otn@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <77782f57-6131-4968-95dc-088329cc50f7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <77782f57-6131-4968-95dc-088329cc50f7@kernel.org>

On Sat, Jul 26, 2025 at 04:07:40AM -0500, Mario Limonciello wrote:
>>Example patch creation with Claude Code:
>>
>>	$ claude -p "Fix the dont -> don't typo in @Documentation/power/opp.rst. Commit the result"
>>	Done! The typo has been fixed and committed.
>
>Is this actually how people use AI agents?  I've never thought of 
>asking an agent to write a whole patch and commit the result.

Yup, there are a bunch of usecases for this, and while this is an
oversimplified example (that's why I picked a simple spelling fix that
the agent could get right "the first time").

See Kees' post at https://hachyderm.io/@kees/114907228284590439 , in
particular the buffer overflow fix where he logged his prompts.

>The way that I've seen it is things like Github Copilot within VScode 
>where there are inline suggestions.  It's kinda like clangd except it 
>suggests corrections to your mistakes instead of just underlining them 
>with red squiggles.
>
>Like if you messed up the argument and passed a pointer when it was 
>supposed to be a pointer to a pointer it will give you a little 
>tooltip correction.  But this is long before you would be ready to 
>actually commit a patch, heck it's before even testing it (obviously).
>
>The actual committing action would be by running 'git commit'.  So I 
>don't see how these tags could end up in there.

Even vscode has a commit feature which can help write commit
messages and actually commit them for you:
https://code.visualstudio.com/docs/sourcecontrol/overview

But yes, if you choose to manually handle the committing aspect then you
should also be manually attributing the agent :)

-- 
Thanks,
Sasha

