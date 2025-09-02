Return-Path: <linux-kernel+bounces-795908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4507B3F940
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 10:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B6417965E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472102E8DE5;
	Tue,  2 Sep 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fSn0lV+v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="to4iaZIt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fSn0lV+v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="to4iaZIt"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C50923AB9C
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756803415; cv=none; b=fHblUfiO/AjcLGgujDbrSvcUez2YJj0xmQileo1WZwxJM6BjZmnA0skTtby4EmxFA92buc21qCNztNDKunU8l2qjOEU8xsYFqeMET07Z97h5jKqhNJZpoJx+0xaF7vd4MVGLHAYUElqs7YqWOA+HMBNtlgI2HKNCWDOHDId2UM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756803415; c=relaxed/simple;
	bh=6ku4duxWUTG+MXg+SqIV0p88CEbMnlYAU84xRMwvwHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bzdOmp4sFq1ybiTXUcNePVs1I6tHkJOjF4Zw7o6El1zFRLgMmfT3XQILKGl152dCTAfQ8i8ZG+AIi5nBHIK0aGoDwnImFAlKD1k6GUowSZDSosryHlfPxRcKdUFid6d4+GztnzoOfpCzdY8TxaB1gshzBooU2NsUQ/chfOUAJv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fSn0lV+v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=to4iaZIt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fSn0lV+v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=to4iaZIt; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3928E211D4;
	Tue,  2 Sep 2025 08:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=fSn0lV+vhTvXYKT+kD4ZyziJBVp7q+SehdYBkgq+7jrf2t39zlGRkFJTurVMypbNMraYKu
	dseZ6hlTMY43fMJzH1y3xTYO4xobbuHyh6MKavrY284XYs4JWik9zcyNlv9B/lAjyMb605
	Iw6qG8DxRmLkgLrYrUkDrDJ0Bzk4c1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=to4iaZItr7iDPbXlXgl2ChP1eeHKmKKsNAvNU96SNQRJ5W4lEemypFfemIFg2sQVCDPrbi
	FJ6ki7KeH0ST7TBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fSn0lV+v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=to4iaZIt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756803412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=fSn0lV+vhTvXYKT+kD4ZyziJBVp7q+SehdYBkgq+7jrf2t39zlGRkFJTurVMypbNMraYKu
	dseZ6hlTMY43fMJzH1y3xTYO4xobbuHyh6MKavrY284XYs4JWik9zcyNlv9B/lAjyMb605
	Iw6qG8DxRmLkgLrYrUkDrDJ0Bzk4c1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756803412;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zdMXL3DzKbrzQgK9ln4DLjJYTZxHYiLh+LFuN3jZqs4=;
	b=to4iaZItr7iDPbXlXgl2ChP1eeHKmKKsNAvNU96SNQRJ5W4lEemypFfemIFg2sQVCDPrbi
	FJ6ki7KeH0ST7TBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 222CC13888;
	Tue,  2 Sep 2025 08:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s66vBFSxtmjMAQAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 02 Sep 2025 08:56:52 +0000
Message-ID: <8bf6c91a-18c5-4236-8176-d03aab8286f4@suse.de>
Date: Tue, 2 Sep 2025 10:56:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Use non zero KATO for persistent discovery
 connections
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20250902035211.2953174-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250902035211.2953174-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,lists.infradead.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3928E211D4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51

On 9/2/25 05:52, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The NVMe Base Specification 2.1 states that:
> 
> """
> A host requests an explicit persistent connection ... by specifying a
> non-zero Keep Alive Timer value in the Connect command.
> """
> 
> As such if we are starting a persistent connection to a discovery
> controller and the KATO is currently 0 we need to update KATO to a non
> zero value to avoid continuous timeouts on the target.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/core.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

