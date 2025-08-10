Return-Path: <linux-kernel+bounces-761461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8B2B1FA64
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 16:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9CBF1896C1C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 14:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51887265CD8;
	Sun, 10 Aug 2025 14:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvBvZqim"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343D433B3;
	Sun, 10 Aug 2025 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754835739; cv=none; b=CCbi4LmWF2nwdywUPr3Y1GsCXnn/8slYXdOPoDt55wNp7iIGRPW5bFtK8SQ1W63Q79TKZH2fpd57E+ONIoJDxD1bZ390jDoxpAji3alK1yQGY2+j8uMKreUx4Dk5sIAkJ111n8+yIOnBT6w+/WyUDwvpXCxSDRQD0Q+rqaZDiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754835739; c=relaxed/simple;
	bh=dkX86G8MD/danFRtAd952MGS32rq/hcIy5+NgwjfQmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXGlQ5Wku4CDB4kIt2yJOCvDlFCLlhpqb6uXAeuedvBqTkGdJ4bY0KB64xTIS62/MbyHAoZ3ur4CU08xCop/JjP7UwC7M7g30PZxTGC2x2DCa1BnO3H7nxhdUq9XQjNV0qppfc50Q/vdY0vzg0UhI1mDMTiB5bOxSnLbz3NE3n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvBvZqim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF0D3C4CEEB;
	Sun, 10 Aug 2025 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754835738;
	bh=dkX86G8MD/danFRtAd952MGS32rq/hcIy5+NgwjfQmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GvBvZqimrfI+f4YcgBtbBPm7qFR4ScYWDD+QkXHEi1PHgQJyeBJmwDwCe0dyJFsou
	 V5hPwrLU9b3v2QgP1/PgDuhn9DMZMVkYJU6JIiSXAo51gHo75XTmuNDujR9eN0eq09
	 NjIGjsSEAdyjizfKyEvd4WlIuDSs9r5Eqyw+ZHC1Z6gL3Y3Ntdv1kaWwq/ryR3z7QC
	 1FSnYuTcBPbCn2Nvg//UxwaaadhhGWKINkXVWQ8XS/l0k9rGcNowEz5I3nS1VlcA3w
	 6GY42I0vaLGcOW2OX/GeK7hfcBplwArAyOofX5v4jNA+6Nuwwnd5e/imeIZZe91nkJ
	 RglL73GgvQXlw==
Date: Sun, 10 Aug 2025 10:22:15 -0400
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	workflows@vger.kernel.org
Subject: Re: [PATCH v2 2/2] agents: add unified agent coding assistant
 configuration
Message-ID: <aJirFxwuzxyau1j-@lappy>
References: <20250809234008.1540324-1-sashal@kernel.org>
 <20250809234008.1540324-3-sashal@kernel.org>
 <2025081040-armchair-although-8bf1@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2025081040-armchair-although-8bf1@gregkh>

On Sun, Aug 10, 2025 at 09:01:00AM +0200, Greg KH wrote:
>On Sat, Aug 09, 2025 at 07:40:08PM -0400, Sasha Levin wrote:
>> Create a single source of truth for agent instructions with
>> symlinks for all major coding agents:
>> - CLAUDE.md (Claude Code)
>> - .github/copilot-instructions.md (GitHub Copilot)
>> - .cursorrules (Cursor)
>> - .codeium/instructions.md (Codeium)
>> - .continue/context.md (Continue)
>> - .windsurfrules (Windsurf)
>> - GEMINI.md (Gemini)
>
>Having these non-dot-files in the root directory for just specific
>closed source tools feels a bit wrong to me.  I thought all of these
>tools were standardizing on "use README" and didn't need these extra
>helpers?  The fact that most of them just contain README seems like
>that's the case, they just need to work it out somehow?
>
>Anyway, I'd not like this patch to be added (patch 1/2 is great), as it
>feels like these agents need to get their act together in ways to not
>need these, we shouldn't be forced to deal with their inefficiencies.

No, agents will not read the README unless we explicitly tell them to
"study" the codebase (either via something like "/init" in the CLI tools
or a "Scan the codebase" button on the VSCode clones).

This is why the agent files only have a reference to README: their only
purpose is to get the agents to read the goddamn README file by default.

We don't strictly need this patch. Here are the options I came up with:

1. Multiple agent files: agents automatically read our rules, higher
chance of comlpiance, doesn't require user to do anything manually.

2. No agents files at all: this means that the user will need to
explicitly trigger an action, otherwise all the tools I've tested it
with will happily ignore the README file even when prompted to do other
actions on the codebase (analyze code/write a patch/etc).

3. Only "AGENTS.md" which seems like a few of the tools are trying to
standardize on. We could also use it in the future to add prompt cues
that might not be relevant within the README.

We could also start with most of these files, along with a statement
that they will be removed within 12 months to give the various tools
time to standardize around something.

-- 
Thanks,
Sasha

