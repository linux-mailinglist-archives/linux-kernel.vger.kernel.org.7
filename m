Return-Path: <linux-kernel+bounces-896646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FB3DC50E1D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A2BC3ADA82
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56529284894;
	Wed, 12 Nov 2025 07:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WkrY8boz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SVyGP6PH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cFJDvsaa";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="J9qTJF0A"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05522157B
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931337; cv=none; b=J00sYunMikUYjefeGFG8yWhC+o3tYfA1S2Nxfon1OhAXq740zJ42lGdMnKvZTgFw5y/6AQGaqTb6gUXaVNGaCpxylhWD4igUTqWMuJVAcz2W0FGElFe92026ZBbg56MyaW4biVgPiZSdbB0dyloCkWa1AB3WT9geNjdfVLkVX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931337; c=relaxed/simple;
	bh=6kEW9Uk6Qc+e9CoMZs9tx0awk/G6MucfDKhh8+7X9ts=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zk3cWZV4GryEdNrcQqmdRyFmhfhDXXFhHWoUV2scc/bwKqk0uVkaO3WaJMnsiHIMThHvwdQwv5DYh3RqOb91JKPUlBC/egvQNQf5MF4N2V6DwlOzV1JVE1F9xKv2KAX10kwEn+MvDyoljZKEMFnJkDZsZFgZZyGXhBZrayp91aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WkrY8boz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SVyGP6PH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cFJDvsaa; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=J9qTJF0A; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EB37621CB8;
	Wed, 12 Nov 2025 07:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931334; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/z0wdshMTTAUY3KPOo5vy5OooG9EA7XvjAnJH2Mq0eg=;
	b=WkrY8bozibhpSHACBBt4FhkDbdf6ZcTRH2qYPAfoW/khoW8MbsIz3ENSxjIvlGwv8xjDvn
	VdOYMswEnsighqcYTzYsC1K3rhxwgsPOvos4d2Z15MnJ9IWFK1wkrbs6g4+H9DPOkC/UaE
	Cl5Pz7P0rkg6FvEphJ1N985eEutamYY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931334;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/z0wdshMTTAUY3KPOo5vy5OooG9EA7XvjAnJH2Mq0eg=;
	b=SVyGP6PHahfTkO3MHjZp4N39zXmXmJQ1A/7Y2fhY8qtx66TZsyfjjkdrWjzdNjK1jaVsBJ
	rteeTKGwr7iB7cAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cFJDvsaa;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=J9qTJF0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/z0wdshMTTAUY3KPOo5vy5OooG9EA7XvjAnJH2Mq0eg=;
	b=cFJDvsaa72I5FOByG1+JL06CZqe3f04WvOQGWAy9pWmKWwETfkWrYJ2t0gNHorQ9fHDzJx
	l4AgxjEQLsPIDIzY3M8BnFQ+56f6wY7AXwP0brCN5M1g3LSg1hEqDHqJ+9nxzwtGjWs8Te
	spkYNqfhvqnZfVWkrQ2y2siji5u4I/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/z0wdshMTTAUY3KPOo5vy5OooG9EA7XvjAnJH2Mq0eg=;
	b=J9qTJF0Av1oYFKmbhsuIn3yd1n1CmpPPZIUTbrbqY4UTEgU2yJom6jNWYSfXbgKOF/U1af
	zNryfW+ztR5jbgBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65AAA14DC5;
	Wed, 12 Nov 2025 07:08:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lTbKFIQyFGkWdQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Nov 2025 07:08:52 +0000
Message-ID: <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
Date: Wed, 12 Nov 2025 08:08:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-4-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251111234519.3467440-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EB37621CB8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,kernel.dk,lst.de,grimberg.me,nvidia.com,lists.infradead.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email]
X-Spam-Score: -4.51

On 11/12/25 00:45, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - New patch
> 
>   drivers/nvme/host/sysfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 29430949ce2f..6d10e12136d0 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
>   	    !ctrl->opts->tls && !ctrl->opts->concat)
>   		return 0;
>   	if (a == &dev_attr_tls_configured_key.attr &&
> -	    (!ctrl->opts->tls_key || ctrl->opts->concat))
> +	    !ctrl->opts->concat)
>   		return 0;
>   	if (a == &dev_attr_tls_keyring.attr &&
>   	    !ctrl->opts->keyring)

??

How can you have a configured TLS Key for secure concatenation?
We generate the keys from the DH-CHAP key material, don't we?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

