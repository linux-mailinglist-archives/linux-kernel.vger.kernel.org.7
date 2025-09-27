Return-Path: <linux-kernel+bounces-834865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16222BA5AB4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA60B4A81AB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13318239594;
	Sat, 27 Sep 2025 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jfj1U+7K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9AD6723D";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L6GJEH3J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aXCu1yJf"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4B19C546
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758961058; cv=none; b=X+bzq0+RmEw+lCIsLbZY1rnt3mbcrSePu55IhVOSZ8UnuL+LIX7RjuEq2r2RrSPvezKBy31OpqVlmo35jhv7lsrWMLKee5Nnhh1IHE8dR6zZZBBcKFy5NkhbG5Vmy497RF+eivmtLDfIBBT6NKEyrT9w/oH+bTIWAHJJdL42vE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758961058; c=relaxed/simple;
	bh=lhC06RHBJJAP+FWXcGWw6ChxvJFxng8JUPPE2KMKaeM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xm8yMdVnprM6bkJaKMNNLFHh620JmKZFMcTTjWwZKpJYsrJNeDiuSHSlR0zyLSX5HFrwvRBrjffLe7O/1eBV14H75777jeUPO7ygJAj+D0TcjSIqmugz393ahkM6w1yejW2ZR6AuqXmkmCED0SyWSxkSVFU6hUjSIi/WbYT3Thw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jfj1U+7K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9AD6723D; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L6GJEH3J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aXCu1yJf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E8F622652F;
	Sat, 27 Sep 2025 08:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758961055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeLQ6kvFK2IWzBmjXBx+ddWDD3biix2eT1sBgsW/3ZQ=;
	b=jfj1U+7KZR6oTFljxOLBR/K+FPO9ecnlEp+T7E6fZOi7NiNKFLeKp/YyeIPYMRsikDRZcn
	bcRp5W2SV194LT1CG2sKVimanpGljSdBfaIb/sFfCtdS68Ob6U0kMuO0Slw9VBx0v6sfpV
	qiLsNFny1elNghtcYYG2NdQw8KxtdLs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758961055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeLQ6kvFK2IWzBmjXBx+ddWDD3biix2eT1sBgsW/3ZQ=;
	b=9AD6723DT0ZAXiXxfG0CsQJfxzYri0VzLf3dDnqHLBkO9Fs0da4zf62GJbIAXr4cK4vsrR
	ePrvj0yiU5YVLtAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L6GJEH3J;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aXCu1yJf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758961054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeLQ6kvFK2IWzBmjXBx+ddWDD3biix2eT1sBgsW/3ZQ=;
	b=L6GJEH3Jslpv1ofTuIhzCmvNPcLk4NYlxNKVKNWMNuZX9T20K8sWziH34WXLc933zkHsHa
	jXEoJEioO3q3yBWtDlR48q8oUApKgpO0mJLNU4uGbuPL+TDbAtNRQlXlvqfcBIYlC784Ld
	I3oy0+xoK/F7kW5ui/7xX2XbNUnZaAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758961054;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DeLQ6kvFK2IWzBmjXBx+ddWDD3biix2eT1sBgsW/3ZQ=;
	b=aXCu1yJfdQQqa+JtsegK+EJDzjKto9G1926ZPHdyLWx6fcMiMsPapZZkwn7ly1SP3XrTJT
	ANoWpihnTZxF+vBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA24013782;
	Sat, 27 Sep 2025 08:17:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OfneJ56d12hhNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 08:17:34 +0000
Date: Sat, 27 Sep 2025 10:17:34 +0200
Message-ID: <878qi0b97l.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kriish Sharma <kriish.sharma2006@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexey Klimov <alexey.klimov@linaro.org>
Subject: Re: [PATCH] docs: sound: describe 'chan_map' member in snd_dec_opus
In-Reply-To: <20250926162658.989479-1-kriish.sharma2006@gmail.com>
References: <20250926162658.989479-1-kriish.sharma2006@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: E8F622652F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.01

On Fri, 26 Sep 2025 18:26:58 +0200,
Kriish Sharma wrote:
> 
> When building kernel docs, the following warning appeared:
> 
>   WARNING: ./include/uapi/sound/compress_params.h:364 struct member 'chan_map' not described in 'snd_dec_opus'
> 
> The inline struct 'snd_dec_opus_ch_map' inside 'snd_dec_opus' was not properly documented.
> This patch documents the 'chan_map' member and its fields (stream_count, coupled_count, channel_map), resolving the warning.
> 
> Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

Adding Alexey to Cc, as it was added by his patch.

If any, please resubmit with a proper subject line (e.g. "ALSA:
compress: ....") as well as the Fixes tag pointing to the affecting
commit.


thanks,

Takashi

> ---
>  include/uapi/sound/compress_params.h | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
> index faf4fa911f7f..e90e2f40732a 100644
> --- a/include/uapi/sound/compress_params.h
> +++ b/include/uapi/sound/compress_params.h
> @@ -336,16 +336,14 @@ struct snd_dec_ape {
>   * @mapping_family: Order and meaning of output channels. Only values 0 and 1
>   * are expected; values 2..255 are not recommended for playback.
>   *
> - * Optional channel mapping table. Describes mapping of opus streams to decoded
> - * channels.
> - * @struct snd_dec_opus_ch_map
> - *	@stream_count: Number of streams encoded in each Ogg packet.
> - *	@coupled_count: Number of streams whose decoders are used for two
> - *		channels.
> - *	@channel_map: describes which decoded channel to be used for each one.
> - *		See RFC doc for details.
> - *		This supports only mapping families 0 and 1, therefore max
> - *		number of channels is 8.
> + * @chan_map: Optional channel mapping table. Describes mapping of opus streams
> + *            to decoded channels. Fields:
> + *              - @stream_count: Number of streams encoded in each Ogg packet.
> + *              - @coupled_count: Number of streams whose decoders are used
> + *                                for two channels.
> + *              - @channel_map: Which decoded channel to be used for each one.
> + *                              Supports only mapping families 0 and 1,
> + *                              max number of channels is 8.
>   *
>   * These options were extracted from RFC7845 Section 5.
>   */
> -- 
> 2.34.1
> 

