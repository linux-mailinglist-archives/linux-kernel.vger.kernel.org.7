Return-Path: <linux-kernel+bounces-782268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCFB8B31DF7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07D89AC4000
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559151B808;
	Fri, 22 Aug 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Extxltvb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lgrCvuj9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Extxltvb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lgrCvuj9"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F5F194A45
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875231; cv=none; b=UvrXeg/LzBUyjGaY4F6Qkz8TiuUTDtBHb2zEA6Ybq4liI5+iisACABERJmkrhUtZV3GtI9QUecyXg5XDnb6Em/tW3W38As+lgzOBIKe7sMUo8VpAUaD9IGcd6qCOQExLnZTEHeGeo06l+gXfycuPp3W5niPi/NO2VxH6CRplh4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875231; c=relaxed/simple;
	bh=/uncVOXZcMQbLNucxBabFCDRr2nx2IC+bgiq+wWdwX4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bicr+4Elt0UnQ9Ch0Fs1ieEsyf3T2jOU1SUDIpJnkrjqPIOpA4V9nkYZdDtp98+kLaqhNgAkrTD/qZRx90fr9L3ckQW/Ez8LndFDDIiqXy8JNA2bmojr+O4Ur+fhacUfGzwuDLJLMam1g0DNq/msZe/sdkFINTra8Uddpcprdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Extxltvb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lgrCvuj9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Extxltvb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lgrCvuj9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AC2B121C23;
	Fri, 22 Aug 2025 15:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755875227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YDhxIfASYAxDg8QUeAO/Y8aHQ+HwfhrLXM/TNGwAWo=;
	b=ExtxltvbN6kPiUzTBNeGOTVS3ul8R92rB1bmfkVnIyRhHk4lxWi/XC4XaP6dl63V6svQgy
	qkLKHPrAn6ZeE1qrAJ2B2g0mtQ+LARKRzPs9mfOhZ1hY5HDQPk10LVO6uyethGJUKNLULB
	pGPHEE08Oaod203xjgr4YQbK2ZavSvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755875227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YDhxIfASYAxDg8QUeAO/Y8aHQ+HwfhrLXM/TNGwAWo=;
	b=lgrCvuj9e/vLdKYffKP4SDL/mHUIpWb/gbeJN3GDG9hMITQkDjX3v3qr21zoQCjNBoorL1
	IHWS++d3H/YdLICA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755875227; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YDhxIfASYAxDg8QUeAO/Y8aHQ+HwfhrLXM/TNGwAWo=;
	b=ExtxltvbN6kPiUzTBNeGOTVS3ul8R92rB1bmfkVnIyRhHk4lxWi/XC4XaP6dl63V6svQgy
	qkLKHPrAn6ZeE1qrAJ2B2g0mtQ+LARKRzPs9mfOhZ1hY5HDQPk10LVO6uyethGJUKNLULB
	pGPHEE08Oaod203xjgr4YQbK2ZavSvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755875227;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1YDhxIfASYAxDg8QUeAO/Y8aHQ+HwfhrLXM/TNGwAWo=;
	b=lgrCvuj9e/vLdKYffKP4SDL/mHUIpWb/gbeJN3GDG9hMITQkDjX3v3qr21zoQCjNBoorL1
	IHWS++d3H/YdLICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 503A913931;
	Fri, 22 Aug 2025 15:07:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Sw4dEZuHqGgXFgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 22 Aug 2025 15:07:07 +0000
Date: Fri, 22 Aug 2025 17:07:06 +0200
Message-ID: <87ect34cpx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: cryolitia@uniontech.com,
	Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	guanwentao@uniontech.com,
	niecheng1@uniontech.com,
	zhanjun@uniontech.com,
	jeffbai@aosc.io,
	Guoli An <anguoli@uniontech.com>
Subject: Re: [PATCH] ALSA: usb-audio: Add mute TLV for playback volumes on some devices
In-Reply-To: <20250822-mixer-quirk-v1-1-b19252239c1c@uniontech.com>
References: <20250822-mixer-quirk-v1-1-b19252239c1c@uniontech.com>
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
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cryolitia.uniontech.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gitlab.freedesktop.org:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -1.80

On Fri, 22 Aug 2025 14:58:08 +0200,
Cryolitia PukNgae via B4 Relay wrote:
> 
> From: Cryolitia PukNgae <cryolitia@uniontech.com>
> 
> Applying the quirk of that, the lowest Playback mixer volume setting
> mutes the audio output, on more devices.
> 
> Link: https://gitlab.freedesktop.org/pipewire/pipewire/-/merge_requests/2514
> Tested-by: Guoli An <anguoli@uniontech.com>
> Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>

Thanks, applied now.


Takashi

