Return-Path: <linux-kernel+bounces-746444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CD4B126B8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 00:15:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1404017D03A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EE6256C9E;
	Fri, 25 Jul 2025 22:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lz9pZVKV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B57238C19;
	Fri, 25 Jul 2025 22:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753481738; cv=none; b=CFYbO0yx5nV1oNNB8jhZbK9nquAqZbx1E/6EEdzAGVRvsRGob8fy546Xsd8wtr+L0D3gx/c59visXeVtcyW72c1Fpn5GgOGCQHxbkbSOsWaNCScigGh4MS2i1Ze/VlrWi0Po+1atp7UCbBLUJrmDX8BEuQbpy9o2NNsJI1AMJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753481738; c=relaxed/simple;
	bh=SShFy+0ge2bOm8xGZbOSlKyiH/NmSdmpZlQRNeevq6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j4/HleVq5mgx916jogXkHPe71zQJ3ZyE36wx/Etd1n4G6g7Lt1ZyPDPQI6FoDclGTXKbgSSjOrUs/iSZ3XGKJQWTzdakZ7WyFIizTj120MNni9vXjpaQYy1hleXH/bq2j/hSFGGo6OE9RH1RrfKAHi9+8neMN3AkEJ1ZEhIOdes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lz9pZVKV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F413AC4CEE7;
	Fri, 25 Jul 2025 22:15:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753481736;
	bh=SShFy+0ge2bOm8xGZbOSlKyiH/NmSdmpZlQRNeevq6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lz9pZVKVU2jyDJLXmnv8VptOgV035u3KHingWBuTMCueZKXIUYHzv9xLvvW2D7ECV
	 Hwl3JpJj+NpsPQfac1oUu9MzIcYA1A6D5kc+H9S62+VQdBF3Fvv6fzElMV0sjBSDvM
	 xN7I5TPF2snlBFqxVijHBbr9ZubnmzO63EdkEhjzU4evfVxOlzZuSPGqqUVRP7Hnk4
	 avQlDoZBNR1BeM750ExzBjAKtUxbxP9k6hpPw8ecTPzLz9Ws7oUljP1x96Pa/Oc2ei
	 hYB1A+yzqBlDMl1tzIv5vnRW+qyEwa5j/nEi955k7MXRKmo2TXYbZ4e/cVVjA8WjDT
	 2k4nhfBvVlqxg==
Date: Fri, 25 Jul 2025 18:15:33 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org, kees@kernel.org,
	konstantin@linuxfoundation.org, josh@joshtriplett.org
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
Message-ID: <aIQCBQgh0XiDf2dv@lappy>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725175358.1989323-2-sashal@kernel.org>
 <87wm7w5dnd.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87wm7w5dnd.fsf@trenco.lwn.net>

On Fri, Jul 25, 2025 at 12:27:50PM -0600, Jonathan Corbet wrote:
>Sasha Levin <sashal@kernel.org> writes:
>
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
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  .aider.conf.yml                 | 1 +
>>  .codeium/instructions.md        | 1 +
>>  .continue/context.md            | 1 +
>>  .cursorrules                    | 1 +
>>  .github/copilot-instructions.md | 1 +
>>  .windsurfrules                  | 1 +
>>  CLAUDE.md                       | 1 +
>>  Documentation/AI/main.md        | 5 +++++
>
>So I'm gonna ignore (for now) the substantive issues here to ask: do we
>*really* need to introduce Markdown into Documentation/?  Are these
>things really unable to understand RST?  Why not add a file that can be
>part of the docs build so people can see the instructions that are being
>provided?

 From my understanding, most of the agents out there expect a markdown
file ("CLAUDE.md", ".github/copilot-instructions.md", etc).

All the documentation and examples I can find online insist on
markdown... I suspect that they will also understand RST, but then we'll
be doing something "unsupported".

Though in this scenario, maybe even just plain text will be enough?

-- 
Thanks,
Sasha

