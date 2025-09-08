Return-Path: <linux-kernel+bounces-805853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18542B48E5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1759A17D4E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 12:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18EBB306B26;
	Mon,  8 Sep 2025 12:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fDf8SQv2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lGIXWnNJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fDf8SQv2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lGIXWnNJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A45304976
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 12:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757336226; cv=none; b=ZEIPFv3dVa8b2QEizzjUHtP7YTKjmCU67MPS1vPyTceE12DT6pfHaSSYT0DTwZKpbVqPgAhPLhjHBrYBt1P2Mr/X4/kb5TsBF6YRCRe5Ytm3e2/rq3NCvXw/Y8QwyDzxAh2CjPRksWtzfiCglYbdEZKw/xgEutqmKzDjGc9AtwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757336226; c=relaxed/simple;
	bh=Mt2t3xe8hP3JdtxzhRjgIJwTcYsY1xHnAr18ccmkyBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LxVSTkTw6aLIW7ksaGjheIC3Oo7wdgulu4TGMnYSNHEfraA9OlFiXZduGamaYyVzOTw4Pwx/kO3zGHcEyWER+A1ckosph0R1aD6fb8X60jfJ1N4NtnI6fZ5NeLXOWvPdrZyqTsv9aUAtDc6jK2r1EGBQ2VGkR+DLcPvdj7ciCXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fDf8SQv2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lGIXWnNJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fDf8SQv2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lGIXWnNJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7963A16F50;
	Mon,  8 Sep 2025 12:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=fDf8SQv2sIP/e0Mj308/WD1UXkPPuF8mumJ/W1XjvO1iGwAjiNhguXnoUVychBPU/GTcC2
	IN3JSakmXY2KGmb7a9vkfqeD/7Fz6sEjkkh8JDFpvAircCvJXMdAQ1HKJwRo04iINs7o8+
	BfX/i7kMim4OYb6Q8KejJIjGO6gqtvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=lGIXWnNJqzzOXhrhU0fntbrspLYZYcxr3aAGbN7CD0dWppz0oEFTZadR6doGvaOXoVyRqO
	414km+42EBImSsCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fDf8SQv2;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=lGIXWnNJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757336221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=fDf8SQv2sIP/e0Mj308/WD1UXkPPuF8mumJ/W1XjvO1iGwAjiNhguXnoUVychBPU/GTcC2
	IN3JSakmXY2KGmb7a9vkfqeD/7Fz6sEjkkh8JDFpvAircCvJXMdAQ1HKJwRo04iINs7o8+
	BfX/i7kMim4OYb6Q8KejJIjGO6gqtvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757336221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vdPGiMJOfHCK+wdnKYTzBA4BaNmWPhjMcBBhnMYhGs=;
	b=lGIXWnNJqzzOXhrhU0fntbrspLYZYcxr3aAGbN7CD0dWppz0oEFTZadR6doGvaOXoVyRqO
	414km+42EBImSsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4916C13946;
	Mon,  8 Sep 2025 12:57:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id j+NEEZ3SvmhhLQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 08 Sep 2025 12:57:01 +0000
Message-ID: <1077309c-2e91-4f0d-b8a6-69d3f9d60cac@suse.de>
Date: Mon, 8 Sep 2025 14:57:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] nvme-core: do ioccsz/iorcsz validation only for
 I/O controllers
To: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org, dlemoal@kernel.org, kamaljit.singh1@wdc.com
References: <20250905232550.1950307-1-kamaljit.singh@opensource.wdc.com>
 <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250905232550.1950307-3-kamaljit.singh@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7963A16F50
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/6/25 01:25, Kamaljit Singh wrote:
> An administrative controller does not support I/O queues, hence it
> should ignore existing checks for IOCCSZ/IORCSZ. Currently, these checks
> only exclude a discovery controller but need to also exclude an
> administrative controller.
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh@opensource.wdc.com>
> ---
>   drivers/nvme/host/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

