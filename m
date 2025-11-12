Return-Path: <linux-kernel+bounces-896650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 183C8C50E20
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6998C4F17AA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E76C212F98;
	Wed, 12 Nov 2025 07:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GOa1syeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="igApBArw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GOa1syeY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="igApBArw"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB851514DC
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762931541; cv=none; b=rGwctKWdPWRRGv7wWcBVa8ev/Lpdhv2q3NDMyeNtAtGFcskIQlEJ1lOdhUMFoVO5ODGl3bw761Vz9oJfilaHQ2MuzmSwg5tNR30Xi7S6PMcFvmxVMo73Uxjg7ncPlqlbFUdOPPcBibJqGyuScq8/6FmnXBsKCVIiEANJpuijldc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762931541; c=relaxed/simple;
	bh=IgJWAKaFXJYsTfhhTqaVwrs1C+8TzHVMfFGN72V5GXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbZT+C24y3+ozlv5sU+qVaa2OqzFI9bZaBXHBdL5yTkMrGIKEiWRPGehiJEn6+nfGvyFyaD0j2gC0WLVw54Ax6A28/i+41z/T3eeKpzfv7WnxYMgZhGM1OxwKVQi0dEPknpJRxGc2XByes7LZ3cq2i5QRwyU1DpYc8fRKXqYXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GOa1syeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=igApBArw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GOa1syeY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=igApBArw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26F7E21841;
	Wed, 12 Nov 2025 07:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=GOa1syeYZ/mNrYeNR7C+fnj5dD9BHhJ3ajLOlIj0VAcUOYnpmRwC7lxf8RXqwO+r8/dXze
	uBvQ+ZOOjkQOBoLO0bedoEM0aI6HxPKlvDc/p/sau8uRIBr3QUYFpFhZMWexChReWgsvYY
	0SUOOG5HPnArJEIJN/y2dKyENoQnzVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=igApBArwZss0PLdWU6EicDKB1VGfz7ZA4q0tb8W1BswjhQxcmc0lnDy+rGWueWRkY+cF0J
	2e0jZ1nmhi2K4TAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GOa1syeY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=igApBArw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762931538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=GOa1syeYZ/mNrYeNR7C+fnj5dD9BHhJ3ajLOlIj0VAcUOYnpmRwC7lxf8RXqwO+r8/dXze
	uBvQ+ZOOjkQOBoLO0bedoEM0aI6HxPKlvDc/p/sau8uRIBr3QUYFpFhZMWexChReWgsvYY
	0SUOOG5HPnArJEIJN/y2dKyENoQnzVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762931538;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sr+6U7iD29KWE6me6qmFhjAX6dUIjh3/FKSQYhO4ZC8=;
	b=igApBArwZss0PLdWU6EicDKB1VGfz7ZA4q0tb8W1BswjhQxcmc0lnDy+rGWueWRkY+cF0J
	2e0jZ1nmhi2K4TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BF88A14DC8;
	Wed, 12 Nov 2025 07:12:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zqofLFEzFGkbeAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Nov 2025 07:12:17 +0000
Message-ID: <ce51e08a-d7a7-4a92-b9c1-0fe13d814721@suse.de>
Date: Wed, 12 Nov 2025 08:12:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] nvme: Allow reauth from sysfs
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-5-alistair.francis@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251111234519.3467440-5-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 26F7E21841
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,wdc.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.51

On 11/12/25 00:45, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> This can be done by writing to the sysfs file.
> 
> echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/tls_configured_key
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
>   - Trigger on any value written to `tls_configured_key`
> 
>   drivers/nvme/host/sysfs.c | 23 ++++++++++++++++++++++-
>   1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 6d10e12136d0..db1c53e00501 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -806,7 +806,28 @@ static ssize_t tls_configured_key_show(struct device *dev,
>   
>   	return sysfs_emit(buf, "%08x\n", key_serial(key));
>   }
> -static DEVICE_ATTR_RO(tls_configured_key);
> +
> +static ssize_t tls_configured_key_store(struct device *dev,
> +					struct device_attribute *attr,
> +					const char *buf, size_t count)
> +{
> +	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
> +	int error;
> +
> +	if (!ctrl->opts || !ctrl->opts->concat)
> +		return -EOPNOTSUPP;
> +
> +	error = nvme_auth_negotiate(ctrl, 0);
> +	if (error < 0)
> +		return error;
> +
> +	error = nvme_auth_wait(ctrl, 0);
> +	if (error < 0)
> +		return error;
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(tls_configured_key);
>   
>   static ssize_t tls_keyring_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)

Errm. Why 'configured_key'?

The configured_key sysfs attribute is a representation of the --tls-key
attribute when calling 'nvme connect', which in itself should be used
for debugging purposes only. And as such it really cannot be modified.

Please use the 'tls_key' attribute (which holds the negotiated key,
and is available always).

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

