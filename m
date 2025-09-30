Return-Path: <linux-kernel+bounces-837659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E761CBACD99
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76404189FA53
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 12:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3392D7805;
	Tue, 30 Sep 2025 12:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lh/1rbeM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gGon9Wlo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Lh/1rbeM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gGon9Wlo"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8380F262FF3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235639; cv=none; b=H0j8gW/Bi88M8LQ9H/6CYJJXoKHsPxHFJ23wOLg2VEJ4ExkiVWWV/Bl2Kj+3kB8e79aecvvWVtrIiFBpbmNggq4yBE0Ep60xh88L6x2gZ4U0yitZGoqB/U1KyL2Du+0MG+RJ61lSY0csBJQpOHa3noYN0tTRZdEjMXk03paJnxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235639; c=relaxed/simple;
	bh=5nL1028SAfOhOIFmgXyOWd4pgxr29ALHzz2k1lwk948=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hI/x5e/l1XT+z94IL9u2gG5bNdd+1Fpl2cgBjP86PuZ7RWXz56cMWh4vFQUOoCB/q7jhCyrCb7HnGnSjjU+Kwn13oPWm7ilePgXix+lqMvXYH7kt3UuhA775UzucUCdVIfPA6iuDGfzQcyTWZbfuuTqgw2hdZXmOX84FdVKfTJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lh/1rbeM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gGon9Wlo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Lh/1rbeM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gGon9Wlo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8AA301F7DE;
	Tue, 30 Sep 2025 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759235635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2znZdlMorDPELgJlQixTa7ClZzREQMnXYZcZV5K2D+Y=;
	b=Lh/1rbeMa2nT6dhLtKUiqQcq4i6tXYHHwc9Y8N/3wVfoFIJGu3X6ykI2xwv2+Fu4ZLTKlv
	GrCgyXH1qjD5+Dg/zgWOxKoJC4nhmY1Oz9gt7Dk+YVfr16xbxu0sKbu2sAkxTg+AAfDY9S
	kp6wlBL4+nCsjAvPY8D5gp6RK7zDiFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759235635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2znZdlMorDPELgJlQixTa7ClZzREQMnXYZcZV5K2D+Y=;
	b=gGon9WloFLG3kpbYxKaIFWfAPn+x1FAyg+eZme0Il1AZzh9OXq9ZgMBXYLG57xf/KmzoYI
	bLdohzxfVRB4OEAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759235635; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2znZdlMorDPELgJlQixTa7ClZzREQMnXYZcZV5K2D+Y=;
	b=Lh/1rbeMa2nT6dhLtKUiqQcq4i6tXYHHwc9Y8N/3wVfoFIJGu3X6ykI2xwv2+Fu4ZLTKlv
	GrCgyXH1qjD5+Dg/zgWOxKoJC4nhmY1Oz9gt7Dk+YVfr16xbxu0sKbu2sAkxTg+AAfDY9S
	kp6wlBL4+nCsjAvPY8D5gp6RK7zDiFU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759235635;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2znZdlMorDPELgJlQixTa7ClZzREQMnXYZcZV5K2D+Y=;
	b=gGon9WloFLG3kpbYxKaIFWfAPn+x1FAyg+eZme0Il1AZzh9OXq9ZgMBXYLG57xf/KmzoYI
	bLdohzxfVRB4OEAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 765C313A3F;
	Tue, 30 Sep 2025 12:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5exVHDPO22igMgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 30 Sep 2025 12:33:55 +0000
Date: Tue, 30 Sep 2025 14:33:55 +0200
Message-ID: <87y0pwjf0s.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Steven 'Steve' Kendall <skend@chromium.org>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/hdmi: Add pin fix for HP ProDesk model
In-Reply-To: <20250929-fix-hdmi-hpprodesk-v1-1-f4a7e714ef11@chromium.org>
References: <20250929-fix-hdmi-hpprodesk-v1-1-f4a7e714ef11@chromium.org>
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
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Mon, 29 Sep 2025 23:33:34 +0200,
Steven 'Steve' Kendall wrote:
> 
> The HP ProDesk 400 (SSID 103c:83f3) also needs a quirk for
> enabling HDMI outputs.  This patch adds the required quirk
> entry.
> 
> ---
> Signed-off-by: Steven 'Steve' Kendall <skend@chromium.org>

At the next time, please avoid '---' separator before Signed-off-by
line; otherwise git-am won't pick it up.

I applied now manually.


thanks,

Takashi

