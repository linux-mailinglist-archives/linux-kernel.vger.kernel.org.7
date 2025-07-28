Return-Path: <linux-kernel+bounces-748409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3B2B140CE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D95D13A47D4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4544D275860;
	Mon, 28 Jul 2025 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeIKsv1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FEDB19AD70;
	Mon, 28 Jul 2025 16:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721813; cv=none; b=VabVDE7cGT5/yoAyFm8t0+GIJptksMTrTLmAlZ/p2vLDsnNjpomdVVZ4sxub32uBnATcVpxBAS+p93y7roy7HNImBlEXeGsse4hM3h7rX5DdOYBscUZwFIU6+f43+2gfRxnWDLJSWeQXrUxApzmauT52z+JB127GuYNmoJkeb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721813; c=relaxed/simple;
	bh=odlcYQW5Wn6AyKNjInxSo5JDWz7ZVfbs1sZAKYTg8ek=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YicE6ZkUsYXRFkZVRpQLWrp5Yka8PfGOKQNlEECnBQVNAL6WSg626MUWGdXjdztnJLKEg5OpZIc7PRquodnv2tD4FEOGIMc11UyVgoO98D2YvbAXxo6XMKs3bL7+Jdei7WXDpFy1WoLjVEgVyJLxx8lA8HANTxglDB+ZHw1vbM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeIKsv1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23120C4CEE7;
	Mon, 28 Jul 2025 16:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721813;
	bh=odlcYQW5Wn6AyKNjInxSo5JDWz7ZVfbs1sZAKYTg8ek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PeIKsv1S26oO8OiHqBNiQf69n3csMuh0hZOK88J1aZSDRwZN+3TACHdEPVajUfi29
	 X1pfEKSk7I0ABTGMvbU48RdG0vCK6Z3BtfgDqaozok58LoOLpaHZoFxXl/4r/662Lw
	 hYCR35TeEmURByY1B13YzKQEUbbFseCzYpN6Fz7izJzyj6qRD48MUOjxcHLmFsQBVP
	 025iTLTmUzjOArwoXigPS+Y1qHiW8KYNEWc8wTWgONxISRe3HI+ho8hWLE+XxfTP0q
	 3DEgGRi5KTDNU7i76Rbs+Fc7mHvv38DA80UMGkIxvsZjRhaVwZVjAmgNuMMpQMtYBg
	 1bw8bf1AH/KaQ==
Date: Mon, 28 Jul 2025 18:56:48 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, kees@kernel.org, konstantin@linuxfoundation.org,
 josh@joshtriplett.org
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
Message-ID: <20250728185611.36f5865b@foz.lan>
In-Reply-To: <aIWNyPMYHXSmJ5qT@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
	<20250725175358.1989323-2-sashal@kernel.org>
	<87wm7w5dnd.fsf@trenco.lwn.net>
	<aIQCBQgh0XiDf2dv@lappy>
	<aIWNyPMYHXSmJ5qT@lappy>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 26 Jul 2025 22:24:08 -0400
Sasha Levin <sashal@kernel.org> escreveu:

> On Fri, Jul 25, 2025 at 06:15:33PM -0400, Sasha Levin wrote:
> >On Fri, Jul 25, 2025 at 12:27:50PM -0600, Jonathan Corbet wrote:  
> >>Sasha Levin <sashal@kernel.org> writes:
> >>  
> >>>Create a single source of truth for AI instructions in
> >>>Documentation/AI/main.md with symlinks for all major AI coding
> >>>assistants:
> >>>- CLAUDE.md (Claude Code)
> >>>- .github/copilot-instructions.md (GitHub Copilot)
> >>>- .cursorrules (Cursor)
> >>>- .codeium/instructions.md (Codeium)
> >>>- .continue/context.md (Continue)
> >>>- .windsurfrules (Windsurf)
> >>>- Documentation/AIder.conf.yml (Aider)
> >>>
> >>>Signed-off-by: Sasha Levin <sashal@kernel.org>
> >>>---
> >>> .aider.conf.yml                 | 1 +
> >>> .codeium/instructions.md        | 1 +
> >>> .continue/context.md            | 1 +
> >>> .cursorrules                    | 1 +
> >>> .github/copilot-instructions.md | 1 +
> >>> .windsurfrules                  | 1 +
> >>> CLAUDE.md                       | 1 +
> >>> Documentation/AI/main.md        | 5 +++++  
> >>
> >>So I'm gonna ignore (for now) the substantive issues here to ask: do we
> >>*really* need to introduce Markdown into Documentation/?  Are these
> >>things really unable to understand RST?  Why not add a file that can be
> >>part of the docs build so people can see the instructions that are being
> >>provided?  
> >
> >From my understanding, most of the agents out there expect a markdown
> >file ("CLAUDE.md", ".github/copilot-instructions.md", etc).
> >
> >All the documentation and examples I can find online insist on
> >markdown... I suspect that they will also understand RST, but then we'll
> >be doing something "unsupported".
> >
> >Though in this scenario, maybe even just plain text will be enough?  
> 
> I've tested providing a RST file instead of markdown to Claude, Copilot,
> and Cursor. All 3 seemed to be okay with it and followed the
> instructions in it.
> 
> I'll switch to RST.

Maybe you can also check if aren't there one "unified" file where
others would read, or if are there any efforts to unify them.

I strongly suspect that, if not now, with time, they'll all end 
supporting "alien" files for the most popular tools, if they don't
find their own special file name.

Thanks,
Mauro

