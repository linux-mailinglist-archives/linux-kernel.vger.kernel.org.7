Return-Path: <linux-kernel+bounces-618045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B4AA9A985
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 12:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F075A4410
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 10:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75DB22170B;
	Thu, 24 Apr 2025 10:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5b2y0se";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SwVf5t5z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sYA88nYe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FaUjLC4p"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D1021FF3E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745489317; cv=none; b=u2wTUDlrCh/F/z6X2Jnttv8X5RT6l7AhWIIIKE7OkHwrYcTcXaICk/8QhV46duM5A1Tm4A07A8n9Mb24fxDzhq7H6McF3kHe9XZOLsg1IZEQEIPaX23pGK2QsEyZAzrG2xpS2AZARIJAMaGXPzGqFqU+5FcOjOLJpaVa0c6wbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745489317; c=relaxed/simple;
	bh=8EiwbNyQb22atUJRMYCiU5899rnbSiVPpcKpV/du55Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rr9ylnNfeZm+Sr8Aa/U7W6ZqIwn85aT7FFL7+pvvdommnR6eh1e4rDPBXrcse4GneJg5Yjlat14pQ7XSQDskQp7wuhfPjPKOq6NY/QuCWnL9pYbWk7kgn2pHFraFYAGZ9PSmWr+UoBIrF5RbzL8p2sgrX/oxFz+CE1nUYa85Rz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5b2y0se; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SwVf5t5z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sYA88nYe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FaUjLC4p; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id ED0211F399;
	Thu, 24 Apr 2025 10:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82I/BRNzKzsNwtHvWAerd41AS1jV/jwLqQuF5hjo/ng=;
	b=T5b2y0se5ygLY2+Ig1nTkEhgfxfH74MB7F0hChVGGNyy2tOzmDEbS4UH75c5nhGlvzE9ZA
	WI4zGdNvcvY9cUlxEssauSDcURH6F7SjPLAdmcfVypnI8wposT7zOZbmF80u/eIEqkTwjh
	KlgbdAUiKb4lYc/MuXK4GHe3lXJiKaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82I/BRNzKzsNwtHvWAerd41AS1jV/jwLqQuF5hjo/ng=;
	b=SwVf5t5zSeoLo64GZMWeepMhip30k2kvKkk+WjN6XycOwWSCvebD8ua7Ik2CBlNclrKIUB
	Y+gWOgrAwC+2B8Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1745489313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82I/BRNzKzsNwtHvWAerd41AS1jV/jwLqQuF5hjo/ng=;
	b=sYA88nYeeNRLa1rlK7jBzHoTWBXleP+hZRMv9D1ZX8LG4zlY+xf+DK2W6ZFssHae6Knigc
	WPH6zO2sKq0x5eGMd8dlXVcfYZBOO/7Ri7r0H411ZTlroArlEw0urKNnedum5FeKyaE9RZ
	GiePRBlM/6NHLZTrAadTzZHuZk7xx4M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1745489313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82I/BRNzKzsNwtHvWAerd41AS1jV/jwLqQuF5hjo/ng=;
	b=FaUjLC4pyeAopY8y4gHp6XK8XFDFDpyKyRCaQbyB3wzNvvgT2ZsSNUQob73OSkL03eJABH
	DGLrtjT5QlO1kxCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D59481393C;
	Thu, 24 Apr 2025 10:08:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WGI+M6ENCmggJQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 24 Apr 2025 10:08:33 +0000
Message-ID: <002aee76-9114-4029-85b3-aa04e8ef76ed@suse.de>
Date: Thu, 24 Apr 2025 12:08:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 01/14] nvmet-fcloop: track ref counts for nports
To: Daniel Wagner <wagi@kernel.org>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20250423-nvmet-fcloop-v5-0-3d7f968728a5@kernel.org>
 <20250423-nvmet-fcloop-v5-1-3d7f968728a5@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250423-nvmet-fcloop-v5-1-3d7f968728a5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 4/23/25 15:21, Daniel Wagner wrote:
> A nport object is always used in association with targerport,
> remoteport, tport and rport objects. Add explicit references for any of
> the associated object. This ensures that nport is not removed too early
> on shutdown sequences.
> 
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
>   drivers/nvme/target/fcloop.c | 133 +++++++++++++++++++++++++++++--------------
>   1 file changed, 90 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
> index 641201e62c1bafa13986642c6c4067b35f784edd..2b23e43ef4403fa4d70c66263f7750165d2ddc72 100644
> --- a/drivers/nvme/target/fcloop.c
> +++ b/drivers/nvme/target/fcloop.c
> @@ -1047,8 +1047,14 @@ static void
>   fcloop_remoteport_delete(struct nvme_fc_remote_port *remoteport)
>   {
>   	struct fcloop_rport *rport = remoteport->private;
> +	unsigned long flags;
>   
>   	flush_work(&rport->ls_work);
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	rport->nport->rport = NULL;
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
>   	fcloop_nport_put(rport->nport);
>   }
>   
> @@ -1056,8 +1062,14 @@ static void
>   fcloop_targetport_delete(struct nvmet_fc_target_port *targetport)
>   {
>   	struct fcloop_tport *tport = targetport->private;
> +	unsigned long flags;
>   
>   	flush_work(&tport->ls_work);
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	tport->nport->tport = NULL;
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
>   	fcloop_nport_put(tport->nport);
>   }
>   
> @@ -1184,6 +1196,37 @@ __wait_localport_unreg(struct fcloop_lport *lport)
>   	return ret;
>   }
>   
> +static struct fcloop_nport *
> +__fcloop_nport_lookup(u64 node_name, u64 port_name)
> +{
> +	struct fcloop_nport *nport;
> +
> +	list_for_each_entry(nport, &fcloop_nports, nport_list) {
> +		if (nport->node_name != node_name ||
> +		    nport->port_name != port_name)
> +			continue;
> +
> +		if (fcloop_nport_get(nport))
> +			return nport;
> +
> +		break;
> +	}
> +
> +	return NULL;
> +}
> +
> +static struct fcloop_nport *
> +fcloop_nport_lookup(u64 node_name, u64 port_name)
> +{
> +	struct fcloop_nport *nport;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	nport = __fcloop_nport_lookup(node_name, port_name);
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	return nport;
> +}
>   
>   static ssize_t
>   fcloop_delete_local_port(struct device *dev, struct device_attribute *attr,
> @@ -1365,6 +1408,8 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   {
>   	struct fcloop_rport *rport = nport->rport;
>   
> +	lockdep_assert_held(&fcloop_lock);
> +
>   	if (rport && nport->tport)
>   		nport->tport->remoteport = NULL;
>   	nport->rport = NULL;
> @@ -1377,9 +1422,6 @@ __unlink_remote_port(struct fcloop_nport *nport)
>   static int
>   __remoteport_unreg(struct fcloop_nport *nport, struct fcloop_rport *rport)
>   {
> -	if (!rport)
> -		return -EALREADY;
> -
>   	return nvme_fc_unregister_remoteport(rport->remoteport);
>   }
>   
> @@ -1387,8 +1429,8 @@ static ssize_t
>   fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   		const char *buf, size_t count)
>   {
> -	struct fcloop_nport *nport = NULL, *tmpport;
> -	static struct fcloop_rport *rport;
> +	struct fcloop_nport *nport;
> +	struct fcloop_rport *rport;
>   	u64 nodename, portname;
>   	unsigned long flags;
>   	int ret;
> @@ -1397,24 +1439,24 @@ fcloop_delete_remote_port(struct device *dev, struct device_attribute *attr,
>   	if (ret)
>   		return ret;
>   
> -	spin_lock_irqsave(&fcloop_lock, flags);
> -
> -	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
> -		if (tmpport->node_name == nodename &&
> -		    tmpport->port_name == portname && tmpport->rport) {
> -			nport = tmpport;
> -			rport = __unlink_remote_port(nport);
> -			break;
> -		}
> -	}
> +	nport = fcloop_nport_lookup(nodename, portname);
> +	if (!nport)
> +		return -ENOENT;
>   
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	rport = __unlink_remote_port(nport);
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> -	if (!nport)
> -		return -ENOENT;
> +	if (!rport) {
> +		ret = -ENOENT;
> +		goto out_nport_put;
> +	}
>   
>   	ret = __remoteport_unreg(nport, rport);
>   
> +out_nport_put:
> +	fcloop_nport_put(nport);
> +
>   	return ret ? ret : count;
>   }
>   
> @@ -1465,6 +1507,8 @@ __unlink_target_port(struct fcloop_nport *nport)
>   {
>   	struct fcloop_tport *tport = nport->tport;
>   
> +	lockdep_assert_held(&fcloop_lock);
> +
>   	if (tport && nport->rport)
>   		nport->rport->targetport = NULL;
>   	nport->tport = NULL;
> @@ -1475,9 +1519,6 @@ __unlink_target_port(struct fcloop_nport *nport)
>   static int
>   __targetport_unreg(struct fcloop_nport *nport, struct fcloop_tport *tport)
>   {
> -	if (!tport)
> -		return -EALREADY;
> -
>   	return nvmet_fc_unregister_targetport(tport->targetport);
>   }
>   
> @@ -1485,8 +1526,8 @@ static ssize_t
>   fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
>   		const char *buf, size_t count)
>   {
> -	struct fcloop_nport *nport = NULL, *tmpport;
> -	struct fcloop_tport *tport = NULL;
> +	struct fcloop_nport *nport;
> +	struct fcloop_tport *tport;
>   	u64 nodename, portname;
>   	unsigned long flags;
>   	int ret;
> @@ -1495,24 +1536,24 @@ fcloop_delete_target_port(struct device *dev, struct device_attribute *attr,
>   	if (ret)
>   		return ret;
>   
> -	spin_lock_irqsave(&fcloop_lock, flags);
> -
> -	list_for_each_entry(tmpport, &fcloop_nports, nport_list) {
> -		if (tmpport->node_name == nodename &&
> -		    tmpport->port_name == portname && tmpport->tport) {
> -			nport = tmpport;
> -			tport = __unlink_target_port(nport);
> -			break;
> -		}
> -	}
> +	nport = fcloop_nport_lookup(nodename, portname);
> +	if (!nport)
> +		return -ENOENT;
>   
> +	spin_lock_irqsave(&fcloop_lock, flags);
> +	tport = __unlink_target_port(nport);
>   	spin_unlock_irqrestore(&fcloop_lock, flags);
>   
Hmm. This now has a race condition; we're taking the lock
during lokup, drop the lock, take the lock again, and unlink
the port.
Please do a __fcloop_nport_lookup() function which doesn't
take a lock and avoid this race.

> -	if (!nport)
> -		return -ENOENT;
> +	if (!tport) {
> +		ret = -ENOENT;
> +		goto out_nport_put;
> +	}
>   
>   	ret = __targetport_unreg(nport, tport);
>   
> +out_nport_put:
> +	fcloop_nport_put(nport);
> +
>   	return ret ? ret : count;
>   }
>   
> @@ -1609,8 +1650,8 @@ static int __init fcloop_init(void)
>   
>   static void __exit fcloop_exit(void)
>   {
> -	struct fcloop_lport *lport = NULL;
> -	struct fcloop_nport *nport = NULL;
> +	struct fcloop_lport *lport;
> +	struct fcloop_nport *nport;
>   	struct fcloop_tport *tport;
>   	struct fcloop_rport *rport;
>   	unsigned long flags;
> @@ -1621,7 +1662,7 @@ static void __exit fcloop_exit(void)
>   	for (;;) {
>   		nport = list_first_entry_or_null(&fcloop_nports,
>   						typeof(*nport), nport_list);
> -		if (!nport)
> +		if (!nport || !fcloop_nport_get(nport))
>   			break;
>   
>   		tport = __unlink_target_port(nport);
> @@ -1629,13 +1670,19 @@ static void __exit fcloop_exit(void)
>   
>   		spin_unlock_irqrestore(&fcloop_lock, flags);
>   
> -		ret = __targetport_unreg(nport, tport);
> -		if (ret)
> -			pr_warn("%s: Failed deleting target port\n", __func__);
> +		if (tport) {
> +			ret = __targetport_unreg(nport, tport);
> +			if (ret)
> +				pr_warn("%s: Failed deleting target port\n", __func__);
> +		}
>   
And same here; don't drop the lock after lookup.

> -		ret = __remoteport_unreg(nport, rport);
> -		if (ret)
> -			pr_warn("%s: Failed deleting remote port\n", __func__);
> +		if (rport) {
> +			ret = __remoteport_unreg(nport, rport);
> +			if (ret)
> +				pr_warn("%s: Failed deleting remote port\n", __func__);
> +		}
> +
> +		fcloop_nport_put(nport);
>   
>   		spin_lock_irqsave(&fcloop_lock, flags);
>   	}
> 

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

