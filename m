Return-Path: <linux-kernel+bounces-837669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E918BACE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F11AE3AE7FB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F69C2FB0A4;
	Tue, 30 Sep 2025 12:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d8pcbHFz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/AxaPuup";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="d8pcbHFz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/AxaPuup"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019CA2D3237
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235908; cv=none; b=Nl5tEncsX3m9RUdFQk/vaHA4B8NTF4XqiUzeQCmRdG10R+nNz2lKZcipCa8yDqf1GBWbiTmokJcfRH7ytBOHGEcyzoKlMxTexlDOqfGSVpBzEEcM7i4F6+YDwrROaemTejYV80fF6kctmjmdCArk7Dnr8wFYjD5KJz3SDbWodh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235908; c=relaxed/simple;
	bh=Aei3rdUjohoI0TXFDAwreXDlBZy0mwN0gsaIfpfbAR0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=twiFYgwZsXuFRQMjoXRMJN+Z9S1Jucz3qBnPss5tAvp4ahz6D0zyZjVAkeWKYM4UUJQPRgADG5RBuHy3wA0KkcxgPAb0Auba39aW5wMauB+63ODg2wdxUJuMHucnvhKPUyOXfTxkH6vlrwY+5thWZMiB6nOiPeL8NH7RVcWjQTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d8pcbHFz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/AxaPuup; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=d8pcbHFz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/AxaPuup; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 92B401F38F;
	Tue, 30 Sep 2025 12:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759235903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4pTIefMfA4LxwV+gd1YvcX6HyeQAVsGfGFw5D43zHQ=;
	b=d8pcbHFz0wAV7+DIudHOBbIQ15Epdk6akAOl+AIWfHbRrkSMMShTTQdKUWrvCyuFRTNj2i
	sEH7RlffhgERhS6kNjPN2khHoOZMSHbxk7zoLl40l4Iv6nmel+jypk4OzDWMdJRuZI3T1j
	RX5ellyGmDFgTerbXqnghBwAtrda0+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759235903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4pTIefMfA4LxwV+gd1YvcX6HyeQAVsGfGFw5D43zHQ=;
	b=/AxaPuupt5ZXwffZy3qFNGBCFkLLXHmp+0mIOd+iSBZ8POpOOOtWNk1erRkcj7bgQGyd0u
	hz8BIP7CLgNoNqAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759235903; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4pTIefMfA4LxwV+gd1YvcX6HyeQAVsGfGFw5D43zHQ=;
	b=d8pcbHFz0wAV7+DIudHOBbIQ15Epdk6akAOl+AIWfHbRrkSMMShTTQdKUWrvCyuFRTNj2i
	sEH7RlffhgERhS6kNjPN2khHoOZMSHbxk7zoLl40l4Iv6nmel+jypk4OzDWMdJRuZI3T1j
	RX5ellyGmDFgTerbXqnghBwAtrda0+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759235903;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r4pTIefMfA4LxwV+gd1YvcX6HyeQAVsGfGFw5D43zHQ=;
	b=/AxaPuupt5ZXwffZy3qFNGBCFkLLXHmp+0mIOd+iSBZ8POpOOOtWNk1erRkcj7bgQGyd0u
	hz8BIP7CLgNoNqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 770CC13A3F;
	Tue, 30 Sep 2025 12:38:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pUjxGz/P22j0MwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Sep 2025 12:38:23 +0000
Date: Tue, 30 Sep 2025 14:38:23 +0200
Message-ID: <87wm5gjetc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Adam Holliday <dochollidayxx@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kailang Yang <kailang@realtek.com>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Chris Chiu <chris.chiu@canonical.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for ASUS ROG Zephyrus Duo GX551QS
In-Reply-To: <20250930011507.12037-1-dochollidayxx@gmail.com>
References: <20250930011507.12037-1-dochollidayxx@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Tue, 30 Sep 2025 03:15:07 +0200,
Adam Holliday wrote:
> 
> The ASUS ROG Zephyrus Duo 15 SE (GX551QS) with ALC289 codec requires specific
> pin configuration for proper volume control. Without this quirk, volume
> adjustments produce a muffled sound effect as only certain channels attenuate,
> leaving bass frequency at full volume.
> 
> Testing via hdajackretask confirms these pin tweaks fix the issue:
> - Pin 0x17: Internal Speaker (LFE)
> - Pin 0x1e: Internal Speaker
> 
> Signed-off-by: Adam Holliday <dochollidayxx@gmail.com>

The code change looks OK, but the patch couldn't be applied cleanly --
some spaces seem malformed.  Could you resubmit properly?
At best, test to send to yourself and check whether it really works
before the actual submission.


thanks,

Takashi

