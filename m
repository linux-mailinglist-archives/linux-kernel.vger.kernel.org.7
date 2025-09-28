Return-Path: <linux-kernel+bounces-835245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4555BA6921
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5293D17D4E1
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8261DF73C;
	Sun, 28 Sep 2025 06:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y9+k0VK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CNCFATm2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Y9+k0VK3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CNCFATm2"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A471C3314
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 06:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759041428; cv=none; b=qbnyFMIeDopcBuxMkudCCUaPrY84KMs0AAiZ/LKt3zNLlCfd4xDiNV8XDpKElIwhWWn6VOkn9+8VbyjpY/vu5GLfZ0upS9ttDw0sGSxPJUS7dWA5CvjUAUvoEpv77yMabm/S0sBVr4gl5FOIAjX612ZMnC+2bbaU+WxQ7vr3CP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759041428; c=relaxed/simple;
	bh=u3UkN2UIMLVqvd6wFyt6mK9hHNUfpSwCJiEhDxGdp4E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RKgu9SNy56GDwih45XNx+qiKlQu6U53WX8svTjkPobgy3HRyFZFjtT7jyt4TzMq8+x6SuBDyt9DJqAxFTg1c6QanIHsupFEyoB27svSLYcn45vmACp91wbAgH+FOt4EVZFDupqopMEC1M8u7VTlGXITfY+WGvnu8eLNf6q9pOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y9+k0VK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CNCFATm2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Y9+k0VK3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CNCFATm2; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BDB2A506F;
	Sun, 28 Sep 2025 06:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759041423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz+JsWzUlf9UhVcRJddbz99nd/mipsYFBQq3Gk4nz1E=;
	b=Y9+k0VK3d1oqbtqQEAltpFUoJEOE9phkVN8fQettXrT+QOybKdM12J7uL3M/c2FSaZJT7u
	OU+8nnWJ4jd9dXT6WymreJ0ugF101Aa/mailkja+MNXKAWJ/v6DZoeDlK9/rptTC2HIEYA
	qqOkFfvBCr4DvAIgLC92uv4cPJvLulc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759041423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz+JsWzUlf9UhVcRJddbz99nd/mipsYFBQq3Gk4nz1E=;
	b=CNCFATm2xzbBSxylRHDgr4tQaKPpHiJTLYUx9ragm7fQKoy1/J6zF37KU8lhSwIgEHcd+F
	AxUDvCC0A5kW71AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759041423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz+JsWzUlf9UhVcRJddbz99nd/mipsYFBQq3Gk4nz1E=;
	b=Y9+k0VK3d1oqbtqQEAltpFUoJEOE9phkVN8fQettXrT+QOybKdM12J7uL3M/c2FSaZJT7u
	OU+8nnWJ4jd9dXT6WymreJ0ugF101Aa/mailkja+MNXKAWJ/v6DZoeDlK9/rptTC2HIEYA
	qqOkFfvBCr4DvAIgLC92uv4cPJvLulc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759041423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lz+JsWzUlf9UhVcRJddbz99nd/mipsYFBQq3Gk4nz1E=;
	b=CNCFATm2xzbBSxylRHDgr4tQaKPpHiJTLYUx9ragm7fQKoy1/J6zF37KU8lhSwIgEHcd+F
	AxUDvCC0A5kW71AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CA1A13A3F;
	Sun, 28 Sep 2025 06:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Xz/4EI/X2Gj2GQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 28 Sep 2025 06:37:03 +0000
Date: Sun, 28 Sep 2025 08:37:02 +0200
Message-ID: <874isn9j75.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>,
	kernel@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v6 0/4] ALSA: usb-audio: improve module param quirk_flags
In-Reply-To: <20250928-sound-v6-0-7da6e5982432@uniontech.com>
References: <20250928-sound-v6-0-7da6e5982432@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sun, 28 Sep 2025 05:07:58 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> As an implementation of what has been discussed previously[1].
> 
> 1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/
> 
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
> ---
> Changes in v6:
> - Apply review commens, details corrected and wording revised
> - Link to v5: https://lore.kernel.org/r/20250925-sound-v5-0-2593586ff350@uniontech.com
> 
> Changes in v5:
> - Apply review comments. Thanks a lot, Takashi Iwai!
> - Link to v4: https://lore.kernel.org/r/20250918-sound-v4-0-82cf8123d61c@uniontech.com
> 
> Changes in v4:
> - Split basic parse and dynamic change
> - Drop usage of linked list
> - Link to v3: https://lore.kernel.org/r/20250917-sound-v3-0-92ebe9472a0a@uniontech.com
> 
> Changes in v3:
> - Instead of a new param, improve the existed one.
> - Link to v2: https://lore.kernel.org/r/20250912-sound-v2-0-01ea3d279f4b@uniontech.com
> 
> Changes in v2:
> - Cleaned up some internal rebase confusion, sorry for that
> - Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com
> 
> ---
> Cryolitia PukNgae (4):
>       ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
>       ALSA: usb-audio: improve module param quirk_flags
>       ALSA: usb-audio: make param quirk_flags change-able in runtime
>       ALSA: doc: improved docs about quirk_flags in snd-usb-audio

Now applied all four patches.  Thanks!


Takashi

