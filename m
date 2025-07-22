Return-Path: <linux-kernel+bounces-740289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC8FB0D250
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC811AA5B7E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58B5928A1DF;
	Tue, 22 Jul 2025 07:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQjPtLy1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NOeHUMFD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bQjPtLy1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NOeHUMFD"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18873293B48
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 07:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753167971; cv=none; b=iYFFRNIfoKvfGQQbBTUgX/55DrvLSFjP/KJPa6KgN7GDUZjz0HTLyaP/cDVeG9K4ESFsQYa59w0eu+B6F9R8rBlOL4bqy8xMJn1vRXFf9OjKvjUQTMPIgqsXftJQIS4pY9pA7T5oN7lbkVUrKiwe9VRnGdYoil2D68+wektbUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753167971; c=relaxed/simple;
	bh=ijjc7zrFqFpP8nMmAdVZDWpsHbjdczkDDl45EDHqaWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jD0BsyAzXvoI+B7Hq0lfboyvku27/tS/GcN//RDDaBMlLCWarWhkLR8yVj7TQchhcSdcp2l6kVpti/8Y5aUJMMNeTjPsUrLXwTIo4ywb0oFaPIxBWNR9y7YUw/u8RO4DVxqQ7IR3W10099TDUc8Gg6oKGZThV4V5d5dD/7S3SGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQjPtLy1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NOeHUMFD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=bQjPtLy1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NOeHUMFD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1F9D21F795;
	Tue, 22 Jul 2025 07:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753167968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VycAWQ4vqs7g+JNNL+5yvnXhkn20RnTyu4BVytpYdoc=;
	b=bQjPtLy1aMl/QJTxEWfYAN6vpbpUL7Thcwb8yfxpNSDPS443bbO/4yvEn2Jxi2xywR3rTc
	vbKBRmYaX+t0zRI5p2Gb8Z75aj+7LEfAMQ+Cgu23TmyhBWFrHGZJUdiAw/SetHsnbRtXHG
	4NkJn23EavVIEt++ORtkAqjo8dj0IRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753167968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VycAWQ4vqs7g+JNNL+5yvnXhkn20RnTyu4BVytpYdoc=;
	b=NOeHUMFDLw77I8m4POkJk/5oms5DkHzD2KGhYgx9pSUCQtcqidgdQgjw49Xwn44OFOBPBK
	A6GKpvVBDQ3lnMCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bQjPtLy1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NOeHUMFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753167968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VycAWQ4vqs7g+JNNL+5yvnXhkn20RnTyu4BVytpYdoc=;
	b=bQjPtLy1aMl/QJTxEWfYAN6vpbpUL7Thcwb8yfxpNSDPS443bbO/4yvEn2Jxi2xywR3rTc
	vbKBRmYaX+t0zRI5p2Gb8Z75aj+7LEfAMQ+Cgu23TmyhBWFrHGZJUdiAw/SetHsnbRtXHG
	4NkJn23EavVIEt++ORtkAqjo8dj0IRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753167968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VycAWQ4vqs7g+JNNL+5yvnXhkn20RnTyu4BVytpYdoc=;
	b=NOeHUMFDLw77I8m4POkJk/5oms5DkHzD2KGhYgx9pSUCQtcqidgdQgjw49Xwn44OFOBPBK
	A6GKpvVBDQ3lnMCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C316113A32;
	Tue, 22 Jul 2025 07:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w62GLV84f2jYcwAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Jul 2025 07:06:07 +0000
Message-ID: <845e9caa-093c-466b-9a9b-905359517568@suse.de>
Date: Tue, 22 Jul 2025 09:06:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] nvme: add capability to connect to an
 administrative controller
To: Kamaljit Singh <kamaljit.singh1@wdc.com>, kbusch@kernel.org,
 axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cassel@kernel.org, dlemoal@kernel.org
References: <20250718001415.3774178-1-kamaljit.singh1@wdc.com>
 <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250718001415.3774178-2-kamaljit.singh1@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 1F9D21F795
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
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -4.51

On 7/18/25 02:14, Kamaljit Singh wrote:
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> 
> Add capability to connect to an administrative controller by
> preventing ioq creation for admin-controllers.
> 
> * Add helper nvme_admin_ctrl() to check for an administrative controller
> * Add helper nvme_override_prohibited_io_queues() to override queue_count
> * Call nvme_override_prohibited_io_queues() from nvme_init_ctrl_finish()
>    so it applies to nvme/tcp and nvme/rdma
> 
> Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
> ---
>   drivers/nvme/host/core.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e533d791955d..105127638c31 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3149,6 +3149,21 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
>   	return ctrl->opts && ctrl->opts->discovery_nqn;
>   }
>   
> +static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->cntrltype == NVME_CTRL_ADMIN;
> +}
> +
> +/*
> + * An admin controller has one admin queue, but no I/O queues.
> + * Override queue_count so it only creates an admin queue.
> + */
> +static inline void nvme_override_prohibited_io_queues(struct nvme_ctrl *ctrl)
> +{
> +	if (nvme_admin_ctrl(ctrl))
> +		ctrl->queue_count = 1;
> +}
> +
>   static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
>   		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   {
> @@ -3670,6 +3685,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
>   	if (ret)
>   		return ret;
>   
> +	if (nvme_admin_ctrl(ctrl))
> +		dev_dbg(ctrl->device,
> +			"Subsystem %s is an administrative controller",
> +			ctrl->subsys->subnqn);
> +	nvme_override_prohibited_io_queues(ctrl);
> +
>   	ret = nvme_configure_apst(ctrl);
>   	if (ret < 0)
>   		return ret;

One wonders why this is done for admin controllers only; surely 
discovery controllers also don't support I/O queues, and should
therefore have the same setting?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

