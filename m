Return-Path: <linux-kernel+bounces-814348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C1B552BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 17:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00094582991
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAA43164C0;
	Fri, 12 Sep 2025 15:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PvctjGLf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T7cdSouk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PvctjGLf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T7cdSouk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EF031353D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 15:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757689803; cv=none; b=TaRYIhXkmynDZKM9gvXwqQxOuNG7EBRJqqjRIB4Jqs4mHTc0pNzoLN62n7IEp7xTjJtRWEvetVLXJ95gHqt+c6Cuwzjw4uk4VQlmVCZAXoiCQIb7QgnO/Fz0ibPUJenyfjILE/fhiS4zU1x3tqbAX8zC2WAzGTeAQJZyv+XhodU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757689803; c=relaxed/simple;
	bh=yBMtdHR8Z2DW6AnutSlIlWUYFnDNkrdCerjgdZMZ7KU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ss4mbloEMkbjHHmlnHjST3U0O72XiQOlQ/IZVNScdi+bY5A5v4AmVYOl5F8RQm3lTaf0tt4e/azvzpj/M4JC8zMejlMd2WCpYfga0RooCog/F5J3p4s5ry6ynuY78Y2XdhIBKDtKgABDhBMr1Db6uT2UsU6YyrPkWzHTuSY+7/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PvctjGLf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T7cdSouk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PvctjGLf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T7cdSouk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 36FC620F12;
	Fri, 12 Sep 2025 15:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757689798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/pM/9W1r75+CaDorOZpGk2LU+S6hOX+QgOMBroL+zs=;
	b=PvctjGLfSuDclCddVBNmBQSwY9/Flua3RqMf0XLlwJ0ZwrSrQzsQkvzOzIHqHbbMlrVVf3
	SMHveOmH9RTeuGx+A6NvQZpSaoe2A/1Yq+AoT8mgpM0pmfSy00GSzGb+n1YLaigb5xwA+n
	e7GxWfsk9Xmim5wGMqimqplINPibA+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757689798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/pM/9W1r75+CaDorOZpGk2LU+S6hOX+QgOMBroL+zs=;
	b=T7cdSouk/K4l81JJ/UOIziYPp4EFoWTjUIl9vPrTFC0u88tskt6+l+DR6pgfOdpfMy//q1
	ku1F5jIgoOkcWsCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PvctjGLf;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=T7cdSouk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757689798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/pM/9W1r75+CaDorOZpGk2LU+S6hOX+QgOMBroL+zs=;
	b=PvctjGLfSuDclCddVBNmBQSwY9/Flua3RqMf0XLlwJ0ZwrSrQzsQkvzOzIHqHbbMlrVVf3
	SMHveOmH9RTeuGx+A6NvQZpSaoe2A/1Yq+AoT8mgpM0pmfSy00GSzGb+n1YLaigb5xwA+n
	e7GxWfsk9Xmim5wGMqimqplINPibA+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757689798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F/pM/9W1r75+CaDorOZpGk2LU+S6hOX+QgOMBroL+zs=;
	b=T7cdSouk/K4l81JJ/UOIziYPp4EFoWTjUIl9vPrTFC0u88tskt6+l+DR6pgfOdpfMy//q1
	ku1F5jIgoOkcWsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C867113869;
	Fri, 12 Sep 2025 15:09:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id b1yDL8U3xGi0MQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Sep 2025 15:09:57 +0000
Date: Fri, 12 Sep 2025 17:09:57 +0200
Message-ID: <87a52zr9kq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-sound@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com
Subject: Re: [PATCH v2 0/3] ALSA: usb-audio: add module param device_quirk_flags
In-Reply-To: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
References: <20250912-sound-v2-0-01ea3d279f4b@uniontech.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 36FC620F12
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Fri, 12 Sep 2025 08:48:57 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> As an implementation of what has been discussed previously[1].
> 
> > An open question is whether we may want yet a new module option or
> > rather extend the existing quirk option to accept the strings
> > instead.  Basically, when the given argument has a colon, it's a new
> > syntax.  If it's only a number, it's an old syntax, and parse like
> > before.  But, I'm open for either way (a new option or extend the
> > existing one).
> 
> I would like to add a new param. The existed param
> `static unsigned int quirk_flags[SNDRV_CARDS]` seems to related to
> some sequence the card probed. To be honest, I havn't fully understood
> it. And it seems hard to improve it while keeping compatibility.
> 
> 1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
> Changes in v2:
> - Cleaned up some internal rebase confusion, sorry for that
> - Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com
> 
> ---
> Cryolitia PukNgae (3):
>       ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
>       ALSA: usb-audio: add module param device_quirk_flags
>       ALSA: doc: add docs about device_device_quirk_flags in snd-usb-audio

Well, what I had in mind is something like:

--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -73,7 +73,7 @@ static bool lowlatency = true;
 static char *quirk_alias[SNDRV_CARDS];
 static char *delayed_register[SNDRV_CARDS];
 static bool implicit_fb[SNDRV_CARDS];
-static unsigned int quirk_flags[SNDRV_CARDS];
+static char *quirk_flags[SNDRV_CARDS];
 
 bool snd_usb_use_vmalloc = true;
 bool snd_usb_skip_validation;
@@ -103,8 +103,8 @@ module_param_array(delayed_register, charp, NULL, 0444);
 MODULE_PARM_DESC(delayed_register, "Quirk for delayed registration, given by id:iface, e.g. 0123abcd:4.");
 module_param_array(implicit_fb, bool, NULL, 0444);
 MODULE_PARM_DESC(implicit_fb, "Apply generic implicit feedback sync mode.");
-module_param_array(quirk_flags, uint, NULL, 0444);
-MODULE_PARM_DESC(quirk_flags, "Driver quirk bit flags.");
+module_param_array(quirk_flags, charp, NULL, 0444);
+MODULE_PARM_DESC(quirk_flags, "Driver quirk overrides.");
 module_param_named(use_vmalloc, snd_usb_use_vmalloc, bool, 0444);
 MODULE_PARM_DESC(use_vmalloc, "Use vmalloc for PCM intermediate buffers (default: yes).");
 module_param_named(skip_validation, snd_usb_skip_validation, bool, 0444);
@@ -692,6 +692,22 @@ static void usb_audio_make_longname(struct usb_device *dev,
 	}
 }
 
+static void set_quirk_flags(struct snd_usb_audio *chip, int idx)
+{
+	int i;
+
+	/* old style option found: the position-based integer value */
+	if (quirk_flags[idx] &&
+	    !kstrtou32(quirk_flags[idx], 0, &chip->quirk_flags))
+		return;
+
+	/* take the default quirk from the quirk table */
+	snd_usb_init_quirk_flags(chip);
+	/* add or correct quirk bits from options */
+	for (i = 0; i < ARRAY_SIZE(quirk_flags); i++)
+		snd_usb_apply_quirk_option(chip, quirk_flags[i]);
+}
+
 /*
  * create a chip instance and set its names.
  */
@@ -750,10 +766,7 @@ static int snd_usb_audio_create(struct usb_interface *intf,
 	INIT_LIST_HEAD(&chip->midi_v2_list);
 	INIT_LIST_HEAD(&chip->mixer_list);
 
-	if (quirk_flags[idx])
-		chip->quirk_flags = quirk_flags[idx];
-	else
-		snd_usb_init_quirk_flags(chip);
+	set_quirk_flags(chip, idx);
 
 	card->private_free = snd_usb_audio_free;
 
.... and snd_usb_apply_quirk_option() adds or corrects the quirk bits
based on the string value if it matches with the probed device.
This function will be similar like your parser.

In that way, the old quirk_flags options work as-is, while you can use
a new style by passing values with "X:Y:Z" style.


Takashi

