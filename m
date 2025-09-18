Return-Path: <linux-kernel+bounces-781918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9053EB318B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 647A062786C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD74C3054DD;
	Fri, 22 Aug 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wo2D11wj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fzUQ4KRi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Wo2D11wj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fzUQ4KRi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84F83054D6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755867328; cv=none; b=D3XEFgbNRzKajL8IKTezFB9/G+5RHdKvviPxgnFdMDPlxqfzB0kAQp6z5aUOZGoghwjVi47NqMmXZ/tAL8yYRUzEQVIwgMC1cWhIFpCrs2e5WkA9acIGGprfmUMsxV/YmZQBpCAHQuQzsjqKOAc6nPpTKHTG+mfb4JTxOYKrUKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755867328; c=relaxed/simple;
	bh=JuYJN8X92/vpqRoyDWfbvhI7T1wHV6RuPWjG9uGuaVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRuLtogw9hGUpKxxPxhBQlstsGwdiPiZ85IdHCxGOkSta/R5qpi8QoGEUR4SZDe6JePXnYKgZC1w5InQONzYV49cYcyayLrlljexQvL8yBebgL3Ce0JowhDVogshXLLC+4xDeapMFfn3G+iZYkG3IHTRWRnDikv2JyDXBxXrxuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wo2D11wj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fzUQ4KRi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Wo2D11wj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fzUQ4KRi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F04C1F38E;
	Fri, 22 Aug 2025 12:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755867324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=Wo2D11wjQJ5jK+7tkectyOtW5XK4Ng+0iA0XpKAA9eoiOFXyIabkMKYa9dlWDO7Xg1MpMg
	XKBkIkXjUpZoS/xxhnpcN9ExugYqm1/UwrDETa+DeNSt/jk/DRmRMKMvUTpxmRvfyuGx3H
	ki6PPgfRfmWaxIgnt6STWaRI28BFlkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755867324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=fzUQ4KRihzwadLuz06J2zef7GLhmVRp7Va9lLCFgrESN7IeASqWeywlDPMW7phUhy/VDJV
	tkvgyMDh02pjFNDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755867324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=Wo2D11wjQJ5jK+7tkectyOtW5XK4Ng+0iA0XpKAA9eoiOFXyIabkMKYa9dlWDO7Xg1MpMg
	XKBkIkXjUpZoS/xxhnpcN9ExugYqm1/UwrDETa+DeNSt/jk/DRmRMKMvUTpxmRvfyuGx3H
	ki6PPgfRfmWaxIgnt6STWaRI28BFlkY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755867324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iAGJNZt/SVuXm/6gXKf7y/cvf3/WZOP+sAK7SE94s34=;
	b=fzUQ4KRihzwadLuz06J2zef7GLhmVRp7Va9lLCFgrESN7IeASqWeywlDPMW7phUhy/VDJV
	tkvgyMDh02pjFNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1338813931;
	Fri, 22 Aug 2025 12:55:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LkxKBLxoqGhYbQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 22 Aug 2025 12:55:24 +0000
Message-ID: <5cf81b43-b173-4b36-a1df-f40cf395acfa@suse.de>
Date: Fri, 22 Aug 2025 14:55:23 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
 Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250821-fix-nvmet-fc-v1-1-3349da4f416e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -4.30

On 8/21/25 14:48, Daniel Wagner wrote:
> It’s possible for more than one async command to be in flight from
> __nvmet_fc_send_ls_req. For each command, a tgtport reference is taken.
> 
> In the current code, only one put work item is queued at a time, which
> results in a leaked reference.
> 
> To fix this, move the work item to the nvmet_fc_ls_req_op struct, which
> already tracks all resources related to the command.
> 
> Fixes: 710c69dbaccd ("nvmet-fc: avoid deadlock on delete association path")
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fc.c | 19 +++++++++----------
>   1 file changed, 9 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

