Return-Path: <linux-kernel+bounces-786244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDCEB35715
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0188B1898D48
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F92FA0F5;
	Tue, 26 Aug 2025 08:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UyKjsFQd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CosuOZYD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UyKjsFQd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CosuOZYD"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44DC2F999A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756197243; cv=none; b=DnL3Spx8rxYcJnt7FjML29/BcNHyWeVUs3lMlowzO4dI64E2HHyPsCCmSY6OTNGWKyiVMZ/OlQ6J9b82Wxdk+jGi/RI1Sfyj48Usrs7qil8Tde//eXcm5/FbyMQuu9qRn0vvvdaAQ9vU5iYzVMjvAtnvF0dfl7cE32z+C0bWwII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756197243; c=relaxed/simple;
	bh=ZoIVSnj0WUlVcoaYbk/KZUKWhT/Vp1ezzJlsiqUnXNY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYQA1fJapZAPHIRBPXWO7WfY/B5JaiVCkJe377zs5xLaADBjWi102Qw+IjMwvIpEWjMRjnA4M5eF9x98OQGPBCieTgciAOEGqS8/e1NORxP1X+DBO237ns/4YSdFWc3ONSzRqVzPL5L5u+T2yrgF9k/WDmmG82EoqP8zziR4olo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UyKjsFQd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CosuOZYD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UyKjsFQd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CosuOZYD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 941E321193;
	Tue, 26 Aug 2025 08:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756197239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sloPabBLaK/g+vm2hRV4fJp6Txk+q5pY58hnKn9cJ2c=;
	b=UyKjsFQdv/eItSH5WPSCsGn9sjGahoBn4nOmbsbm20unrYaewTRhTI4efmEjSTJ6pdIZvg
	ppY1A9PytXPURamHP6DMuoc5Hm4HT1keeOPVpUbrOa1XNTpXC8jx7fuv44CcXKnng5ginx
	aFToI1R0UIg1PB3lS9fsHUxTtTglI8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756197239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sloPabBLaK/g+vm2hRV4fJp6Txk+q5pY58hnKn9cJ2c=;
	b=CosuOZYDOED02/vaqpARYjRbe4pPon8gJ5PXLo9v3Nf2CLlpPw0RqtcA1Z97mFzpeLjiBJ
	nZU2JaD3jJvv1bAg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UyKjsFQd;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CosuOZYD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756197239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sloPabBLaK/g+vm2hRV4fJp6Txk+q5pY58hnKn9cJ2c=;
	b=UyKjsFQdv/eItSH5WPSCsGn9sjGahoBn4nOmbsbm20unrYaewTRhTI4efmEjSTJ6pdIZvg
	ppY1A9PytXPURamHP6DMuoc5Hm4HT1keeOPVpUbrOa1XNTpXC8jx7fuv44CcXKnng5ginx
	aFToI1R0UIg1PB3lS9fsHUxTtTglI8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756197239;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sloPabBLaK/g+vm2hRV4fJp6Txk+q5pY58hnKn9cJ2c=;
	b=CosuOZYDOED02/vaqpARYjRbe4pPon8gJ5PXLo9v3Nf2CLlpPw0RqtcA1Z97mFzpeLjiBJ
	nZU2JaD3jJvv1bAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5092413A51;
	Tue, 26 Aug 2025 08:33:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Vp1zEndxrWi6TwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 26 Aug 2025 08:33:59 +0000
Date: Tue, 26 Aug 2025 10:33:58 +0200
Message-ID: <87tt1u32ix.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix EFI name for calibration beginning with 1 instead of 0
In-Reply-To: <20250822135043.517-1-shenghao-ding@ti.com>
References: <20250822135043.517-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,ti.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 941E321193
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Fri, 22 Aug 2025 15:50:42 +0200,
Shenghao Ding wrote:
> 
> A bug reported by one of my customers that EFI name beginning with 0
> instead of 1, and code clean for the string checking.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> ---
> v1:
>  - Fix EFI name beginning with 1 instead of 0
>  - Code clean for the string checking
>  - Add extra comments on EFI name for calibration
>  - Remove an extra space
> ---
>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> index ed7771ab9475..fecd5eac739b 100644
> --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> @@ -340,16 +340,17 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
>  		data[offset] = i;
>  		offset++;
>  		for (j = 0; j < TASDEV_CALIB_N; ++j) {
> -			ret = snprintf(var8, sizeof(var8), vars[j], i);
> +			/* EFI name for calibration started with 1, not 0 */
> +			ret = snprintf(var8, sizeof(var8), vars[j], i + 1);
>  
> -			if (ret < 0 || ret >= sizeof(var8) - 1) {
> +			if (ret != strlen(var8)) {

This doesn't look like a code "cleanup".  Calling strlen() is just an
unneeded (but significant) overhead.

Please concentrate only on the correction for now.


thanks,

Takashi

