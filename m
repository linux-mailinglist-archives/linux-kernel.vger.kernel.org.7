Return-Path: <linux-kernel+bounces-743700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DEEB1020D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A11061C288A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F069C26560D;
	Thu, 24 Jul 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iSmpZvav";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z4rbEGUw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iSmpZvav";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z4rbEGUw"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B4125D1FC
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342634; cv=none; b=DA9V1G7Mhp4O6TesbqnojRYbNQ8Iq/43IdKINdIyN1F0iY54RvkWOjPdnp1+aYMoCziL6qiJQXbfO7ww24wdcjHxoA3/klfgvO7+ST5eLa7p797+v0Pv2NUMTEYN5iLBrILUy9IOXMhgh4DdWcXzCmmkSn1sJFZQNQSdJGPRWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342634; c=relaxed/simple;
	bh=oYliYTiynIz5BqhDzeFuwYRcIXemghySuaUubvcJXek=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8iAdFzy9DWXpR1EVswcY2zIWOqogpcmIGeFFKoCPpzCNFPobHHJU0oZzzyXsMHvIFg2XvNzm0Vc1hOKDWtEfXgPtFfYQxV67vTLneg9/6W9p1r3NOX4Id7TF6Fn3vGAp7eVPKrytwrKvX0uo3OgY/Nf1CCuyVWj1S/9kkWShjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iSmpZvav; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z4rbEGUw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iSmpZvav; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z4rbEGUw; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AB781F394;
	Thu, 24 Jul 2025 07:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753342630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LBu7qSBaLkXMmbSWG/aE/FgzcMzPqdoHLqQXT0G0B0=;
	b=iSmpZvav8lnYGFgYWT9RAL6mampmVxsQdOjORxZQmpl2iwQ5NuepLPirg2axvQMywNZgsg
	sM/0rzB57rZzEH02wqXjW5wz+pcC37QvGMCoeNz+fEKMCHQtyI/iIz9EuMlZaSg5Zjlh9u
	Cqykg5TDSqTxG//PZUt1z2wPWxaauJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753342630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LBu7qSBaLkXMmbSWG/aE/FgzcMzPqdoHLqQXT0G0B0=;
	b=z4rbEGUwD7bCn2kBeVEXY5/AYO2k2An2G2PY3o03wE+J5eEo0PlaGSqS80GqXeQKv6Rpds
	ExwDAG9wh3tpu4BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753342630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LBu7qSBaLkXMmbSWG/aE/FgzcMzPqdoHLqQXT0G0B0=;
	b=iSmpZvav8lnYGFgYWT9RAL6mampmVxsQdOjORxZQmpl2iwQ5NuepLPirg2axvQMywNZgsg
	sM/0rzB57rZzEH02wqXjW5wz+pcC37QvGMCoeNz+fEKMCHQtyI/iIz9EuMlZaSg5Zjlh9u
	Cqykg5TDSqTxG//PZUt1z2wPWxaauJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753342630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/LBu7qSBaLkXMmbSWG/aE/FgzcMzPqdoHLqQXT0G0B0=;
	b=z4rbEGUwD7bCn2kBeVEXY5/AYO2k2An2G2PY3o03wE+J5eEo0PlaGSqS80GqXeQKv6Rpds
	ExwDAG9wh3tpu4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A643D13302;
	Thu, 24 Jul 2025 07:37:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7gjAJqXigWjKMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 24 Jul 2025 07:37:09 +0000
Date: Thu, 24 Jul 2025 09:37:09 +0200
Message-ID: <87jz3ykpju.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Cc: andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se,
	jernej.skrabec@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	lumag@kernel.org,
	dianders@chromium.org,
	cristian.ciocaltea@collabora.com,
	luca.ceresoli@bootlin.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	victor.liu@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	devicetree@vger.kernel.org,
	l.stach@pengutronix.de,
	shengjiu.wang@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 2/6] ALSA: Add definitions for the bits in IEC958 subframe
In-Reply-To: <20250724072248.1517569-3-shengjiu.wang@nxp.com>
References: <20250724072248.1517569-1-shengjiu.wang@nxp.com>
	<20250724072248.1517569-3-shengjiu.wang@nxp.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,gmail.com,linux.intel.com,suse.de,ffwll.ch,chromium.org,collabora.com,bootlin.com,lists.freedesktop.org,vger.kernel.org,nxp.com,pengutronix.de,lists.linux.dev,lists.infradead.org,perex.cz,suse.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dt];
	R_RATELIMIT(0.00)[to_ip_from(RL8m7tqgwaqu97o1bbfnn6ewdz)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Thu, 24 Jul 2025 09:22:44 +0200,
Shengjiu Wang wrote:
> 
> The IEC958 subframe format SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE are used
> in HDMI and DisplayPort to describe the audio stream, but hardware device
> may need to reorder the IEC958 bits for internal transmission, so need
> these standard bits definitions for IEC958 subframe format.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  include/sound/asoundef.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
> index 09b2c3dffb30..7efd61568636 100644
> --- a/include/sound/asoundef.h
> +++ b/include/sound/asoundef.h
> @@ -12,6 +12,15 @@
>   *        Digital audio interface					    *
>   *                                                                          *
>   ****************************************************************************/
> +/* IEC958 subframe format */
> +#define IEC958_SUBFRAME_PREAMBLE_MASK	(0xf)
> +#define IEC958_SUBFRAME_AUXILIARY_MASK	(0xf<<4)
> +#define IEC958_SUBFRAME_SAMPLE_24_MASK	(0xffffff<<4)
> +#define IEC958_SUBFRAME_SAMPLE_20_MASK	(0xfffff<<8)
> +#define IEC958_SUBFRAME_VALIDITY	(0x1<<28)
> +#define IEC958_SUBFRAME_USER_DATA	(0x1<<29)
> +#define IEC958_SUBFRAME_CHANNEL_STATUS	(0x1<<30)
> +#define IEC958_SUBFRAME_PARITY		(0x1<<31)

I'd use "U" suffix as it can reach to the MSB.
Also, you can put spaces around the operators to align with the
standard format, too.  I guess you followed to the other code there,
but following to the standard coding style would be better.

With those addressed, feel free to take my ack for this patch:

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

