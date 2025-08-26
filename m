Return-Path: <linux-kernel+bounces-786914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5D4B36DBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DD0F1B68392
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 15:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113912C08CA;
	Tue, 26 Aug 2025 15:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KjCsAshE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W2KbPuEs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kt7ZCUFi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HtcJEKdK"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BCD2BE638
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222255; cv=none; b=n3eBXoh01M3atpue00xFnfhURxFZyguvWy8teMrmSXduRFIyTeGuaC3D7lDV2okoJBZrbwTphukSdLqwlsSqkt5ezcJwmOXIx6jd+CmwCNIynbjRyhci0Y2AD8JbrVJmEdM6mCOfKj0DNEmpPLd/NwtbIoQ87jwzj0cRh8HhwSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222255; c=relaxed/simple;
	bh=tyUsBjItZQMaTIBmWCJs4LMl0/k68Qr2JOPz6EVpzvM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXAc6o+8bxat3Fzqd0iFxeHCrvjGLqoH62LmZbau97e9MqjPYENYgMOHsYBEvTfGw1rKn8H3cGMpuQvQCei2LwJLdGMZdNxKdqM6qmMjOSjaCa7YY4s3rN0JK0CHTp3kIxQqqijVxfsFv1uGvXRbMIwj03FO1bObaYM1GOl1FVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KjCsAshE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W2KbPuEs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kt7ZCUFi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=HtcJEKdK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E0B012119C;
	Tue, 26 Aug 2025 15:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756222252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2ulA5rFhGxVZgPAbguwQbAYjHqkpl/zPVZhIWuo/qw=;
	b=KjCsAshE1Wnw6YjR8OaiLqSfDrrvoXHr2N6HN9DqBuEHrH2wKkGkYRYbJGgfhBe3L3zzZy
	VS6CsfjnRbi8/ByVkAAiGQTn3z7/7xAt6tIawW8RyGaH1+hndngdd1wqlgc6TNuT3yzpnY
	zH6gdZiPJeAjZfZV72+PuicE35HIZQ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756222252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2ulA5rFhGxVZgPAbguwQbAYjHqkpl/zPVZhIWuo/qw=;
	b=W2KbPuEsST5DbQDcA9kFlVZlKRsWOimqsR8fFNTpyq1geDiW6Tr6Ykvmrz+HSGVM/NVJTq
	a1D5qOnNiRM92wDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756222251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2ulA5rFhGxVZgPAbguwQbAYjHqkpl/zPVZhIWuo/qw=;
	b=Kt7ZCUFikh7ptdKMFML3d/xTzJCPGRQ5pLjjyxVTV5KaSyQI9rDsWF/mpUU5f5uGDd4eus
	5M1gxxG2xfqPt4aevnhZ1dmItEwQS618+56I5lS96iAKLawOk2uUBep8LArSApTUPBAI4R
	VjHjRHVIuYw1JMGIlHNN+HVKqzglDZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756222251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D2ulA5rFhGxVZgPAbguwQbAYjHqkpl/zPVZhIWuo/qw=;
	b=HtcJEKdKp3f3keEsvumqhLgwUyhNp68Okli6IyxZQqCUuFdQI53UgG8w0a3Gr55lo2f3HY
	cAeE3iZPsoPPJ6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FCE913A31;
	Tue, 26 Aug 2025 15:30:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id llkbISvTrWivWwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Aug 2025 15:30:51 +0000
Date: Tue, 26 Aug 2025 17:30:51 +0200
Message-ID: <878qj6gkwk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<jesse-ji@ti.com>
Subject: Re: [PATCH v2] ALSA: hda/tas2781: Fix EFI name for calibration beginning with 1 instead of 0
In-Reply-To: <20250826094105.1325-1-shenghao-ding@ti.com>
References: <20250826094105.1325-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 26 Aug 2025 11:41:05 +0200,
Shenghao Ding wrote:
> 
> A bug reported by one of my customers that EFI name beginning with 0
> instead of 1.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> v2:
>  - remove unrelated change
> v1:
>  - Fix EFI name beginning with 1 instead of 0
>  - Add extra comments on EFI name for calibration
>  - Remove an extra space
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> index ed7771ab9475..635cbd8820ac 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> @@ -340,7 +340,8 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
>  		data[offset] = i;
>  		offset++;
>  		for (j = 0; j < TASDEV_CALIB_N; ++j) {
> -			ret = snprintf(var8, sizeof(var8), vars[j], i);
> +			/* EFI name for calibration started with 1, not 0 */
> +			ret = snprintf(var8, sizeof(var8), vars[j], i + 1);
>  
>  			if (ret < 0 || ret >= sizeof(var8) - 1) {
>  				dev_err(p->dev, "%s: Read %s failed\n",
> @@ -349,7 +350,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
>  			}
>  			/*
>  			 * Our variable names are ASCII by construction, but
> -			 * EFI names are wide chars.  Convert and zero-pad.
> +			 * EFI names are wide chars. Convert and zero-pad.
>  			 */
>  			memset(efi_name, 0, sizeof(efi_name));
>  			for (k = 0; k < sizeof(var8) && var8[k]; k++)

Please drop unrelated change and concentrate on the real issue.


thanks,

Takashi

