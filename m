Return-Path: <linux-kernel+bounces-852328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5F0BD8AF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92DA11923DE7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:13:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EB32ECD26;
	Tue, 14 Oct 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3EvzCqS2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3FtNIyC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="3EvzCqS2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g3FtNIyC"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA3C1E990E
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436808; cv=none; b=WcLPF2PDpWBfcdli1f/vjNzaad7Vezhngr85QbvxCFtfG1tNJGRtX6rF2oKQk3NDaBhuKbC4XvwqzXW/VpIctYQdvNH+ighZgu34ewbK3+e0/iRCK52ucE8KhrgSGWo2JabbXpGHPuC5OHFIjnw/e6esvKsjckdzka3wwrMJGFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436808; c=relaxed/simple;
	bh=UY2Vkjnbydzqw/zcYf9FkNGPwUf1nlwvl8Cs2RQ5S0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tkoy7bGQati/W+H5mTmsuxGo4mNIQ02asIYdambcAxiN1/ZTETyW+FEGbEJoXWBPPJPNvkPn7spuHyLeg6IVPORgwVpnVPqgPzWCn+dzVcfhsivCW4h9mzZfAHINLlB5J2UH4GOq04Zqz6X90VbBz+Xcn9dk2eNf4klwYfOs+dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3EvzCqS2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3FtNIyC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=3EvzCqS2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g3FtNIyC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 485C222110;
	Tue, 14 Oct 2025 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760436804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CbwkeHzFm3DtPTQ3D79qC5uh3vmriiMk9eW/DTm8kzM=;
	b=3EvzCqS2DqrrdOjZQdJufLb/9lzQ6DRRaelZeViRMCoE/Drn/n4pPmcjGlyu/sdDghW/DG
	mxWiDTSBuG01CMkwDZJYQD3bHcUqEBWZUihXzhwojZJaxg7q7FWag7voVFYNfGkJtxWx1m
	ftxUyE8XN8TDk19EdTObXZtWVBGIoUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760436804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CbwkeHzFm3DtPTQ3D79qC5uh3vmriiMk9eW/DTm8kzM=;
	b=g3FtNIyCrBDppkZTEO2OPuW3HHzJhnrdUNvdwKJHS0QKB+q4hs/hpgcbQzDwKbSBxX86pF
	zwsdOAyhq7aeHtBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=3EvzCqS2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g3FtNIyC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1760436804; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CbwkeHzFm3DtPTQ3D79qC5uh3vmriiMk9eW/DTm8kzM=;
	b=3EvzCqS2DqrrdOjZQdJufLb/9lzQ6DRRaelZeViRMCoE/Drn/n4pPmcjGlyu/sdDghW/DG
	mxWiDTSBuG01CMkwDZJYQD3bHcUqEBWZUihXzhwojZJaxg7q7FWag7voVFYNfGkJtxWx1m
	ftxUyE8XN8TDk19EdTObXZtWVBGIoUI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1760436804;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CbwkeHzFm3DtPTQ3D79qC5uh3vmriiMk9eW/DTm8kzM=;
	b=g3FtNIyCrBDppkZTEO2OPuW3HHzJhnrdUNvdwKJHS0QKB+q4hs/hpgcbQzDwKbSBxX86pF
	zwsdOAyhq7aeHtBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F10A13A44;
	Tue, 14 Oct 2025 10:13:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6jw0C0Qi7mh6egAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 14 Oct 2025 10:13:24 +0000
Message-ID: <67e75a68-7a03-46bb-ae40-b1a8f24c0b16@suse.cz>
Date: Tue, 14 Oct 2025 12:13:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sched: remove unused cpumask variable in mm_cid_get()
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>,
 Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org, Menglong Dong <menglong8.dong@gmail.com>
References: <20251009194818.1587650-1-kriish.sharma2006@gmail.com>
 <v3zyf7pp64yd4kakqniq4thjf2egb3kavkwzgoqt6ye5cuqkys@jmkcwst6lrn2>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <v3zyf7pp64yd4kakqniq4thjf2egb3kavkwzgoqt6ye5cuqkys@jmkcwst6lrn2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 485C222110
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[debian.org,gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,infradead.org,linaro.org,arm.com,goodmis.org,google.com,suse.de,vger.kernel.org,gmail.com,linuxfoundation.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 10/14/25 11:56, Breno Leitao wrote:
> On Thu, Oct 09, 2025 at 07:48:18PM +0000, Kriish Sharma wrote:
>> The variable 'cpumask' in mm_cid_get() was assigned but never used,
>> causing the following build error with -Werror:
>> 
>> kernel/sched/sched.h: In function ‘mm_cid_get’:
>> kernel/sched/sched.h:3743:25: error: variable ‘cpumask’ set but not used [-Werror=unused-but-set-variable]
>>  3743 |         struct cpumask *cpumask;
>>       |                         ^~~~~~~
> 
> Thanks for the fix. I am hitting the same issue in my builds.

Let me add why this years old small issue became much more problematic in
6.18-rc1. When I want to test my own files I'm developing on with e.g. "make
W=1 mm/slub.o", the W=1 hits earlier in:

  CC      kernel/sched/rq-offsets.s
In file included from kernel/sched/rq-offsets.c:5:
kernel/sched/sched.h:3718:18: error: variable 'cpumask' set but not used
[-Werror,-Wunused-but-set-variable]
 3718 |         struct cpumask *cpumask;
      |                         ^
1 error generated.
make[2]: *** [scripts/Makefile.build:182: kernel/sched/rq-offsets.s] Error 1

So I can't get to the part where I test-compile my own code with W=1. So
fixing this ASAP in 6.18 would be appreciated, thanks!

FWIW I've bisected this to commit
378b7708194f ("sched: Make migrate_{en,dis}able() inline")

>> Removing the unused variable allows the kernel to compile without errors.
>> 
>> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


