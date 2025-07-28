Return-Path: <linux-kernel+bounces-747621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C529CB135FC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 09:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8D33B57C5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F702222C0;
	Mon, 28 Jul 2025 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVE3K8/o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O6euPDO+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XVE3K8/o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="O6euPDO+"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54137346F
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753689528; cv=none; b=GhBf3w+csN0rG3Hi65iKAlLcdoaxTBWVQutb41XzNJzeAxI9Fy//YZktBEU8XL6zwmsxz88grHGcokEsWZY1TnoHAAgc42IJ8kKC98yzi7IMXquV8eS6cUBv9vA+0HxcDU8k6xGTzvJSUFiheuZCgiwdM2GObfoSlW2vVdqTyv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753689528; c=relaxed/simple;
	bh=ws+bYEBqFomzxBZsBG1EGxDjBlBofhKZa1C7tH4wVCw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbiTa2laBV3o4hMARYb2DJ8Rnv0s4guqbMN8B5VEiA1U2DIS9n6QhSJ9H1azxUkdaM2x6QZ8fx/Po8uLf1XnRwblgaCZDVLo/PS5R2ZlhPi2daS40M8UVfJJKcX2jZdMV/XXmgbBqrWy0q4XHb91dO6L4EWZQ/a5zEw0oO2TKCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVE3K8/o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O6euPDO+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XVE3K8/o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=O6euPDO+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B8EBE1F750;
	Mon, 28 Jul 2025 07:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753689524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hYVl1iUieJGKFPs6RQlxU/Ua8jETjXuiuvY41xjGhew=;
	b=XVE3K8/o/TLm7VTVfCjZMmGmnv27LvMCwbbgWSX0dZ0U4jJFa+1vn/qg5gHEBo/shUWtB0
	AoFiJRhxCTqD8IixqcZlfjgJFq0236M+Wo2r9I64FDr5JVrc3gYR63lclVIzoyt/VQIHmc
	jyn4UiokESUDtgh14EkhdS4d15WhnPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753689524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hYVl1iUieJGKFPs6RQlxU/Ua8jETjXuiuvY41xjGhew=;
	b=O6euPDO+m144UuFa2SsA/Egl9LAbx4oKRVCbtuNJVVBGRRrD3rAeVRrwzPwb2X2LPB3MgN
	AvOzb5XSYNa+qmAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="XVE3K8/o";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=O6euPDO+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1753689524; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hYVl1iUieJGKFPs6RQlxU/Ua8jETjXuiuvY41xjGhew=;
	b=XVE3K8/o/TLm7VTVfCjZMmGmnv27LvMCwbbgWSX0dZ0U4jJFa+1vn/qg5gHEBo/shUWtB0
	AoFiJRhxCTqD8IixqcZlfjgJFq0236M+Wo2r9I64FDr5JVrc3gYR63lclVIzoyt/VQIHmc
	jyn4UiokESUDtgh14EkhdS4d15WhnPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1753689524;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hYVl1iUieJGKFPs6RQlxU/Ua8jETjXuiuvY41xjGhew=;
	b=O6euPDO+m144UuFa2SsA/Egl9LAbx4oKRVCbtuNJVVBGRRrD3rAeVRrwzPwb2X2LPB3MgN
	AvOzb5XSYNa+qmAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A58CF1368A;
	Mon, 28 Jul 2025 07:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1mLPJ7Qth2jBEAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 28 Jul 2025 07:58:44 +0000
Message-ID: <75d86e96-cb18-4996-998c-da7ac0e97468@suse.cz>
Date: Mon, 28 Jul 2025 09:58:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, corbet@lwn.net,
 linux-doc@vger.kernel.org, workflows@vger.kernel.org
Cc: josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org
References: <20250727195802.2222764-1-sashal@kernel.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250727195802.2222764-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: B8EBE1F750
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.51

On 7/27/25 21:57, Sasha Levin wrote:
> This patch series adds unified configuration and documentation for coding
> agents working with the Linux kernel codebase. As coding agents
> become increasingly common in software development, it's important to
> establish clear guidelines for their use in kernel development.

Hi,

this series seems to me somewhat premature. I think we first need a clear
policy wrt LLM usage for the *humans* to follow. It seemed this thread [1]
was going into that direction wrt usage disclosure. BTW I was quite shocked
by Steven's reply there [2] that he learned from the LWN coverage of a
conference talk that he had received a patch fully written by LLM without
any such indication. Now I'm not naive to believe that it's not been
happening already from e.g. first-time contributors, but if that coverage
was accurate, the patch came from a very seasoned kernel contributor and I
really wouldn't expect that to happen.

Also I don't know e.g. the copyright and licensing implications of LLM usage
beyond, say, a smarter automplete are clear? (again, such as writing the
full patch?) The thread [1] touched on it somewhat but not completely. If
that's clear already (IANAL), I'd hope that to be also part of such policy.

I know that your series has patch 4, but that seems to be part of what the
LLM is supposed to include for its prompt (does it make sense to call it
"legal requirements" then?). If it fails to e.g. add the "Co-developed-by:"
there seems to be nothing saying the human should check these things in the
output.

So without such policy first, I fear just merging this alone would send the
message that the kernel is now officially accepting contributions done with
coding assistants, and those assistants will do the right things based on
these configuration files, and the developers using the assistants don't
need to concern themselves with anything more, as it's all covered by the
configuration.

Vlastimil

[1] https://lore.kernel.org/all/20250724175439.76962-1-linux@treblig.org/
[2] https://lore.kernel.org/all/20250724194556.105803db@gandalf.local.home/

> The series consists of four patches:
> 
> 1. The first patch adds unified configuration files for various coding
> agents (Claude, GitHub Copilot, Cursor, Codeium, Continue,
> Windsurf, and Aider). These are all symlinked to a central documentation
> file to ensure consistency across tools.
> 
> 2. The second patch adds core development references that guide
> agents to essential kernel development documentation including how
> to do kernel development, submitting patches, and the submission
> checklist.
> 
> 3. The third patch adds coding style documentation and explicit rules
> that agents must follow, including the 80 character line limit
> and no trailing whitespace requirements.
> 
> 4. The fourth patch adds legal requirements and agent attribution
> guidelines. All agents are required to identify themselves in
> commits using Co-developed-by tags, ensuring full transparency about
> agent involvement in code development.
> 
> Example agent attribution in commits:
> 
>     Co-developed-by: Claude claude-opus-4-20250514
> 
> 
> Changes since RFC:
> - Switch from markdown to RST
> - Break up into multiple files
> - Simplify instructions (we can always bikeshed those later)
> - AI => Agents
> 
> Sasha Levin (4):
>   agents: add unified agent coding assistant configuration
>   agents: add core development references
>   agents: add coding style documentation and rules
>   agents: add legal requirements and agent attribution guidelines
> 
>  .aider.conf.yml                       |  1 +
>  .codeium/instructions.md              |  1 +
>  .continue/context.md                  |  1 +
>  .cursorrules                          |  1 +
>  .github/copilot-instructions.md       |  1 +
>  .windsurfrules                        |  1 +
>  CLAUDE.md                             |  1 +
>  Documentation/agents/coding-style.rst | 35 ++++++++++++++++++++++
>  Documentation/agents/core.rst         | 28 ++++++++++++++++++
>  Documentation/agents/index.rst        | 13 +++++++++
>  Documentation/agents/legal.rst        | 42 +++++++++++++++++++++++++++
>  Documentation/agents/main.rst         | 22 ++++++++++++++
>  12 files changed, 147 insertions(+)
>  create mode 120000 .aider.conf.yml
>  create mode 120000 .codeium/instructions.md
>  create mode 120000 .continue/context.md
>  create mode 120000 .cursorrules
>  create mode 120000 .github/copilot-instructions.md
>  create mode 120000 .windsurfrules
>  create mode 120000 CLAUDE.md
>  create mode 100644 Documentation/agents/coding-style.rst
>  create mode 100644 Documentation/agents/core.rst
>  create mode 100644 Documentation/agents/index.rst
>  create mode 100644 Documentation/agents/legal.rst
>  create mode 100644 Documentation/agents/main.rst
> 


