Return-Path: <linux-kernel+bounces-743664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73057B10187
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609663A655E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD5B4502A;
	Thu, 24 Jul 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JZs40pCN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8OR+eMRO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p2NOfqvJ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UVp70E40"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333B01FDA
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753341581; cv=none; b=DXQHyfhlvtho+pgQh6zz2OlCMIf9pYXgvxgLospgx4Pr3m9LsXKuJXZsZP7lrEx7dwHixCIafGJPTNHfLggfHVJVc8mSeDfCJi/cblqTuDbD8BqCw5ubK8r07T9MyjMlsbXA0RgJrz4LYoR4w59ByZ6sP5j+KdK57HdUEsYVnhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753341581; c=relaxed/simple;
	bh=moMz6gVD6lESF5/NGfsFYLi7+ud2E3489DsENPjNeu4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rge5c5eBOVbjNdJNjJYIxt8Yk0n+G9PbFM87fDl3vCPo9W3x4sAJxI22sixo0+cRJyPpYEVJoiKK53/9mof0n8Dr2EyeNp5oWcH+er4K5nfv6WsginR2+EWHTLgulwZnZ9nbE86XU5p9mmihdPf8VEtfqb0ymBd7AEzM6M0g3H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JZs40pCN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8OR+eMRO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p2NOfqvJ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UVp70E40; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2308C2197F;
	Thu, 24 Jul 2025 07:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753341578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJnrfTmm5leSmYtMynaaQ963YEhekdUy+5UPBjqK+dg=;
	b=JZs40pCNWKonlTJiaO7m/V2hrWMJt6nZutEGqpLHi86Xaug+LKL2Omh3icBPd2GLwvillc
	S42j3VzxKpdv6pX6Dq0ZleKn2LOFRhNZSe8TefVdUr+vM/B+tXCtBjchMaVgU25hw/k0M9
	K2elO7L7Wu2KYfe0Vile08qKF/4Dtss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753341578;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJnrfTmm5leSmYtMynaaQ963YEhekdUy+5UPBjqK+dg=;
	b=8OR+eMROzwGUb/JY/NpSz29lAZYhqdTU9Rp+MGZ/7uThHiR8WW+ym8ZeU2Ej8YR8a08BWc
	kjVPGhtgLcDjwYCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p2NOfqvJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UVp70E40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753341577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJnrfTmm5leSmYtMynaaQ963YEhekdUy+5UPBjqK+dg=;
	b=p2NOfqvJRjjAVqrDpi0I+ho7mqXY6vAqx/0SlFLilIYTDBSPjM4smGKDzyg7aFUOJXAVZR
	ae2q8Rsp2pn7hDDGFABMPFDqAjs3lvzXlqUHTto+JNHpPQzehvtMIRLGP3SK79hBM45Ppn
	ls6Bfxxe6ljYSH2xV+D5m27lcy00ScA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753341577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CJnrfTmm5leSmYtMynaaQ963YEhekdUy+5UPBjqK+dg=;
	b=UVp70E40y4B59NJlmR+0A2a7nz1T56GjNyUdU/L04nr6AOxwUnCkFbapECsH0M15Uvs8d/
	7//ls9G+ZXbO7uAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 684F213302;
	Thu, 24 Jul 2025 07:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iocYGIjegWgoLQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 24 Jul 2025 07:19:36 +0000
Date: Thu, 24 Jul 2025 09:19:36 +0200
Message-ID: <87o6takqd3.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sergio Perez Gonzalez <sperezglz@gmail.com>
Cc: vkoul@kernel.org,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: sysfs_emit() expects a buffer of size PAGE_SIZE
In-Reply-To: <20250723230927.109534-1-sperezglz@gmail.com>
References: <20250723230927.109534-1-sperezglz@gmail.com>
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
X-Rspamd-Queue-Id: 2308C2197F
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,coverity.com:url,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Thu, 24 Jul 2025 01:09:25 +0200,
Sergio Perez Gonzalez wrote:
> 
> In read_buffer_show(), allocate sufficient memory to pass on to
> sysfs_emit(), which expects a buffer of size PAGE_SIZE.
> 
> Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1648019
> Fixes: 35323d8ab811 ("soundwire: replace scnprintf() with sysfs_emit() for sysfs consistency")
> Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> ---
>  drivers/soundwire/debugfs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> index 825f7abbad32..08fb1e29026e 100644
> --- a/drivers/soundwire/debugfs.c
> +++ b/drivers/soundwire/debugfs.c
> @@ -306,12 +306,12 @@ static int cmd_go(void *data, u64 value)
>  DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
>  			 cmd_go, "%llu\n");
>  
> -#define MAX_LINE_LEN 128
> -
>  static int read_buffer_show(struct seq_file *s_file, void *data)
>  {
> -	char buf[MAX_LINE_LEN];
>  	int i;
> +	char *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;

IMO, it's better to scratch the whole previous change.
It makes little sense to allocate a large buffer here just for the
temporary formatting.

Moreover, *_show() functions there take seq_file pointer, and you can
just use seq_printf() directly.  The sysfs/kobject show callback is
with the a fixed PAGE_SIZE buffer, hence sysfs_emit() is useful, but
in this case, it's a completely different story.


thanks,

Takashi

