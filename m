Return-Path: <linux-kernel+bounces-735041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1E3B089F5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86FAE1A6698E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0FB293C47;
	Thu, 17 Jul 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aX4dKohA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/RVYFRGM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aX4dKohA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/RVYFRGM"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C87293B73
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752746010; cv=none; b=XSnKMzbp55abogLy6jkFt1p9YJVTF4ayx3byTHw9quESJqCdHLoYCFu2ArK/BZnfM/JiEexoeVAL1qVkRKZ300k2dqWn/U9dUJF+wG0UVzPr6t/lizcqKGeUX9znmMSlO6GEMlT+Fjpo3GIKoX5wTxH+Fn5hs0tfSdGSqunETVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752746010; c=relaxed/simple;
	bh=kystHuLsKjmpTUJzMJzJKncP2PljJ3kUCgfQBCHSP0w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jkVYlUvqpU8XrXpMaGMd+dYg2CCG9m8qew6u/vh4ndlJrgdOvUSF/e55MhR/a8fYu1yw5V6XJ8/H3fkRnIwRBVyz2OL/R6chiYPOLqEawzVRZP2x8UvTXLGNi+B5RfIC0FylfWMYGmEwry2PRbM9vUArb2rDzL0YkOz2AzPWaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aX4dKohA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/RVYFRGM; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aX4dKohA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/RVYFRGM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9187D216EC;
	Thu, 17 Jul 2025 09:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752746006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wu/llPazrUceIkAbknof/ch+BMbjxtDAhyZ2pdmEywc=;
	b=aX4dKohACPouNOmbvndi3LzHn9id9mFSPDr3jRLRi42OX04F8atPH8Fj0tpp8ZbA7llg1h
	v6NlyurZs76rC6GA0XuFlwrQ+UVS3NqDt6E2qd9rr0wJuBkt7LjsdYIXQKqBlu+VwxGLfu
	gqIRCwAgH7S44daO1ttpAaPEarVVpJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752746006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wu/llPazrUceIkAbknof/ch+BMbjxtDAhyZ2pdmEywc=;
	b=/RVYFRGMJn9YsDHU5PBerrM51gUv15RLXgg8mcsMZCJtIjzIVuoY+MVTNLGsIWiBhCoumJ
	xoyDGfzfOOlRV0AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=aX4dKohA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/RVYFRGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752746006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wu/llPazrUceIkAbknof/ch+BMbjxtDAhyZ2pdmEywc=;
	b=aX4dKohACPouNOmbvndi3LzHn9id9mFSPDr3jRLRi42OX04F8atPH8Fj0tpp8ZbA7llg1h
	v6NlyurZs76rC6GA0XuFlwrQ+UVS3NqDt6E2qd9rr0wJuBkt7LjsdYIXQKqBlu+VwxGLfu
	gqIRCwAgH7S44daO1ttpAaPEarVVpJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752746006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wu/llPazrUceIkAbknof/ch+BMbjxtDAhyZ2pdmEywc=;
	b=/RVYFRGMJn9YsDHU5PBerrM51gUv15RLXgg8mcsMZCJtIjzIVuoY+MVTNLGsIWiBhCoumJ
	xoyDGfzfOOlRV0AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AEB013A6C;
	Thu, 17 Jul 2025 09:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OfvmFBbIeGggXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 17 Jul 2025 09:53:26 +0000
Date: Thu, 17 Jul 2025 11:53:25 +0200
Message-ID: <87jz479m96.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Sharan Kumar Muthu Saravanan <sharweshraajan@gmail.com>
Cc: tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP OMEN 16 Laptop xd000xx
In-Reply-To: <CAGo=CcK+aHAYVv=tS4frM07D8MCar1CHBy3r3eg1An16YCqk6g@mail.gmail.com>
References: <CAGo=CcK+aHAYVv=tS4frM07D8MCar1CHBy3r3eg1An16YCqk6g@mail.gmail.com>
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
X-Rspamd-Queue-Id: 9187D216EC
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.51

On Thu, 17 Jul 2025 05:02:19 +0200,
Sharan Kumar Muthu Saravanan wrote:
> 
> this patch is to fix my previous Commit e518230 i have fixed mute led
> but for by This patch corrects the coefficient mask value introduced
> in commit e518230, which was intended to enable the mute LED
> functionality. During testing, multiple values were evaluated, and an
> incorrect value was mistakenly included in the final commit. This
> update fixes that error by applying the correct mask value for proper
> mute LED behavior.
> 
> Tested on 6.15.5-arch1-1
> 
> Signed-off-by: M SHARAN KUMAR <sharweshraajan@gmail.com>

The patch is still not applicable cleanly.
Please try to fix the mailer setup and resubmit.  At best, test to
send a patch to yourself, and try to apply the patch by yourself,
before resubmitting.

Also, don't forget to add the proper Fixes tag pointing to the
commit.  It must be with 12 chars SHA1 ID followed by the commit
summary.  See Documentation/process/submitting-patches.rst for
details.


thanks,

Takashi

> 
> ---
>  sound/pci/hda/patch_realtek.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> index 060db37eab83..062d439e753d 100644
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ -4753,7 +4753,7 @@ static void
> alc245_fixup_hp_mute_led_v1_coefbit(struct hda_codec *codec,
>   if (action == HDA_FIXUP_ACT_PRE_PROBE) {
>   spec->mute_led_polarity = 0;
>   spec->mute_led_coef.idx = 0x0b;
> - spec->mute_led_coef.mask = 1 << 3;
> + spec->mute_led_coef.mask = 3 << 2;
>   spec->mute_led_coef.on = 1 << 3;
>   spec->mute_led_coef.off = 0;
>   snd_hda_gen_add_mute_led_cdev(codec, coef_mute_led_set);
> -- 
> 2.50.1

