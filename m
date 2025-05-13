Return-Path: <linux-kernel+bounces-645511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D6BAB4EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 10:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DAD51B43211
	for <lists+linux-kernel@lfdr.de>; Tue, 13 May 2025 08:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 602AA21146A;
	Tue, 13 May 2025 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0/tJdYJy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vn1SCTmb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0/tJdYJy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Vn1SCTmb"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F50210F45
	for <linux-kernel@vger.kernel.org>; Tue, 13 May 2025 08:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747126749; cv=none; b=TBEJBTihscudyC40h0x3/lEPCmRcJSk2vPKYZBk0PvoWJ2xewZXJpfldymmYA/IqTt2Amd37+t79sPtusi3iab9kHSh1PnaShXdn7D+HNabgw8EsYVdtWr1gRefewaEJAN3JqJdwRfCS4dIyOSrlSBCLg68TzzJeP2H5PkXyFaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747126749; c=relaxed/simple;
	bh=qa4kqiTpeGYxQUkjn4Vg46+3YyeGMeZ8BvAbLPgq0Kk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bd9GHoM1u+JKO1PK2oiKc+snn4n+8CCbeQUWpXyPOOGrBhQYatWCoODGTc+qecCKYY0MHTcT700u/C0hiyUSjjIMNZzbWXMrH4lTMLpnvIf+DJlJhKszIfyB7y8nzkU5UyrqaGIe5fVOZVmdJ/tfOOLYPOd1xngNsnUZjIPcwMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0/tJdYJy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vn1SCTmb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0/tJdYJy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Vn1SCTmb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 294C51F6E6;
	Tue, 13 May 2025 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747126746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7ge7H23NNrp0HwGiU2YsFV0gkeI6XlM3YTCbOsRiCo=;
	b=0/tJdYJyr0V7aMfS3jSx5OEJaA7duHtDSkEN8IMbkqubQZ+vfbPlrDf9QLHUbZ89PLiuAd
	+oijCgsrY1ptlnwlpapQ/99MLswmdicwvYneTHj1qyj396rxhvL53zwoDrliSBENGCzBSI
	HFsaqyuN0gGtDCIQywMmaOMRX/6ORDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747126746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7ge7H23NNrp0HwGiU2YsFV0gkeI6XlM3YTCbOsRiCo=;
	b=Vn1SCTmbNAkDv5UT7JRLTXHCUOgABGvVulXvcK0zicra/Lo0BmIUgOexO6rcd9H380WoOt
	Yu1zvFrqNmQXNWBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747126746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7ge7H23NNrp0HwGiU2YsFV0gkeI6XlM3YTCbOsRiCo=;
	b=0/tJdYJyr0V7aMfS3jSx5OEJaA7duHtDSkEN8IMbkqubQZ+vfbPlrDf9QLHUbZ89PLiuAd
	+oijCgsrY1ptlnwlpapQ/99MLswmdicwvYneTHj1qyj396rxhvL53zwoDrliSBENGCzBSI
	HFsaqyuN0gGtDCIQywMmaOMRX/6ORDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747126746;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+7ge7H23NNrp0HwGiU2YsFV0gkeI6XlM3YTCbOsRiCo=;
	b=Vn1SCTmbNAkDv5UT7JRLTXHCUOgABGvVulXvcK0zicra/Lo0BmIUgOexO6rcd9H380WoOt
	Yu1zvFrqNmQXNWBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11B57137E8;
	Tue, 13 May 2025 08:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ka/BA9oJI2gKfQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 13 May 2025 08:59:06 +0000
Date: Tue, 13 May 2025 10:59:01 +0200
Message-ID: <874ixoubsa.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Christian Heusel <christian@heusel.eu>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Add sample rate quirk for Audioengine D1
In-Reply-To: <20250512-audioengine-quirk-addition-v1-1-4c370af6eff7@heusel.eu>
References: <20250512-audioengine-quirk-addition-v1-1-4c370af6eff7@heusel.eu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]

On Mon, 12 May 2025 22:23:37 +0200,
Christian Heusel wrote:
> 
> A user reported on the Arch Linux Forums that their device is emitting
> the following message in the kernel journal, which is fixed by adding
> the quirk as submitted in this patch:
> 
>     > kernel: usb 1-2: current rate 8436480 is different from the runtime rate 48000
> 
> There also is an entry for this product line added long time ago.
> Their specific device has the following ID:
> 
>     $ lsusb | grep Audio
>     Bus 001 Device 002: ID 1101:0003 EasyPass Industrial Co., Ltd Audioengine D1
> 
> Link: https://bbs.archlinux.org/viewtopic.php?id=305494
> Fixes: 93f9d1a4ac593 ("ALSA: usb-audio: Apply sample rate quirk for Audioengine D1")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Heusel <christian@heusel.eu>

Thanks, applied now.


Takashi

