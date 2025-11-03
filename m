Return-Path: <linux-kernel+bounces-882815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1D8AC2B92F
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:08:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3706F188D4EE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 12:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC9F2FFFB4;
	Mon,  3 Nov 2025 12:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k+Hkk9+Q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2EKIkJ2O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EvK1R8RW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u87g95Y2"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E22BE7CB
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171691; cv=none; b=CzAzoSjWe5z1QaAJbvkduJFue8u+g+KTAOxSCx2iyCAYLuCAzxe+tK+NW/QARgbGJk6L+ijdyM6Z/Hn4XMUFwts9lqhsnzDWI3mU1848QyJvm2zHO0vL2V+t7n4TaAz+MfV2gT97Fmmn9HZOztrZ/rp5zddByJwb30wcS0HWtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171691; c=relaxed/simple;
	bh=6eJh3mWaIhBAttbCES5iUcMpOUiWNzq3LIPEU/ix7uA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBjltBSzNyjHic621Na7q9sZv9z3UovTkwSXMTjnyDIa7NqdVH7tPisutMsbUp36Ld7t61rUUlF6u7YKP95Obp5XvzphpBVIOFsWsbeMHVZY/0TZpruGu//XhVewV3NCDY9jGoZVx+1PUzwNCCe0RFwQZKHfhiByM1pNSR3Qb5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k+Hkk9+Q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2EKIkJ2O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EvK1R8RW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u87g95Y2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED96621D41;
	Mon,  3 Nov 2025 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762171687; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=k+Hkk9+QuXoj0SVM/8hOdxL5ahn+9sHbpz9pwFUj65b2efhKWckHBo/ntn0yajauxYMaMO
	jEjLOhxmKl30UtWWOMH0CNno7fxpDqBr7+hqneRahzwLHen8LVYjQDTa8Ee1jjq+2juAcx
	Etlh2MmdGixDAtwLp9qWiPqz8DwRqI8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762171687;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=2EKIkJ2OyNRrlBHMoHS4D4twPXH2IQ3ahQQwgHfueKUSHadV2rzdZovxMm/Llrqmtet+4G
	DMS4NjbjZbNVc5Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EvK1R8RW;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u87g95Y2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762171686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=EvK1R8RWkxtpHIw8czuikVHznxK2j5wNnbMt4H+yofphflzVc+mVGK/+YZ48LY+T1qj+wT
	iEiQzUyG3WdxWUGwuObwsI9qtD02llCrcCYv1+Di5hhA0w2CfNh/VVKfdkccTACAmUjH6K
	vBUgLQ7pEvOaG6DucOC8JRmGhKzOwhU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762171686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gwhxop0V2LwmKtNZnJaT/hPJi0Xa+bOXCiCZt4X1ic0=;
	b=u87g95Y2yxySrZZpr4WFzSbPEcKn9lQ0LnOHvuZoOSMu+byIUbonQDUgvHk7Cyqmza27g4
	+NoAjVRWiENbUAAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D44261364F;
	Mon,  3 Nov 2025 12:08:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xVhQMyabCGmASQAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 03 Nov 2025 12:08:06 +0000
Message-ID: <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de>
Date: Mon, 3 Nov 2025 13:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251030035114.16840-1-alistair.francis@wdc.com>
 <20251030035114.16840-4-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251030035114.16840-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ED96621D41
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:mid,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 10/30/25 04:51, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing the queue ID to te sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> 
> Note that only QID 0 (admin queue) is supported.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>   drivers/nvme/host/sysfs.c | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
Please, don't. Currently we are using the same key for all queues,
and we really should keep it that way as we don't have a way of
specifying the key based on the queue ID (the TLS identification
is identical for all queues).
So we really need to trigger a replacepsk operation for all queues.

I would suggest just allow writes to the 'tls_key' attribute; any
writes to that would trigger a replacepsk operation.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

