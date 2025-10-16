Return-Path: <linux-kernel+bounces-856208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE69BE3794
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95B81583941
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 12:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ADF2E7F3F;
	Thu, 16 Oct 2025 12:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W2BkK9OH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L/W9u2tZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W2BkK9OH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L/W9u2tZ"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9907419539F
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 12:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760618743; cv=none; b=AbEVOy+XfjsfsNElSLsHgcjxAUj/JRH7VkqCNFbbCWnH73JYqbIfU4wsPkMPJP5SKL1+aGzP3SqWGYfk6z2chnlgR4/vpUwIeFqsun8Pi3HSlr/h3w6U5qR8zeW4lO3nLZpchuPbnxdn9+pTyJrA4+rWfv9b2uOX7C2byD8awww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760618743; c=relaxed/simple;
	bh=fouECuZDpRSmPs9vuEjrJZOFF5N21MsK4xYtYC7uB8U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjiq7NlA1ctpdLWlXN7esa6eFbTYpLS6o+yRM5UXs2in7l7EKrcNiHM1H63jwcB4DWCWI321R0eUBpGAZ8QmWjf2GkhDtjMk058mhJG/WD6rl6p69NZ4uxRDBt7luVPfN9f0q1Imm3fbLA5wUf5dw41ir5wbU9DjWDHM8gwC6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W2BkK9OH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L/W9u2tZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W2BkK9OH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L/W9u2tZ; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CDF321F8A3;
	Thu, 16 Oct 2025 12:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760618739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVVVX5exTluqVOqEy6LB4KXffv3vyfiXscSCQO0cVBk=;
	b=W2BkK9OHYXlQO0XmYdRzdRAWdRDPT9r5oKpKwxFLrQ+/AgsERU8eMKV0un1GH3y0WKQJWz
	TVqmBZWuPJ5TNtvmWONlHM7LkLZD5X+gfea62sf83fgHbv8/jNeuG86rR/5ujhenxd3qIZ
	yONn4kA0DSojuOvTPwCX0lyADpzGmaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760618739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVVVX5exTluqVOqEy6LB4KXffv3vyfiXscSCQO0cVBk=;
	b=L/W9u2tZ8R+CGrprY7aMWANrpMA+8d3uL6Q9eHN+0M1B1KF36IOi9eYgoa9z7V/JOt5IeW
	twdojKOM5JARjpCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760618739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVVVX5exTluqVOqEy6LB4KXffv3vyfiXscSCQO0cVBk=;
	b=W2BkK9OHYXlQO0XmYdRzdRAWdRDPT9r5oKpKwxFLrQ+/AgsERU8eMKV0un1GH3y0WKQJWz
	TVqmBZWuPJ5TNtvmWONlHM7LkLZD5X+gfea62sf83fgHbv8/jNeuG86rR/5ujhenxd3qIZ
	yONn4kA0DSojuOvTPwCX0lyADpzGmaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760618739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XVVVX5exTluqVOqEy6LB4KXffv3vyfiXscSCQO0cVBk=;
	b=L/W9u2tZ8R+CGrprY7aMWANrpMA+8d3uL6Q9eHN+0M1B1KF36IOi9eYgoa9z7V/JOt5IeW
	twdojKOM5JARjpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9614A1376E;
	Thu, 16 Oct 2025 12:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZxNbI/Po8GjtGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Oct 2025 12:45:39 +0000
Date: Thu, 16 Oct 2025 14:45:39 +0200
Message-ID: <87tszz6mmk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: Richard Fitzgerald <rf@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH 05/11] ALSA: hda/cs35l56: Create sysfs files for factory calibration
In-Reply-To: <d4e94837-6e0b-4b47-896d-d0dd3a59a39b@sirena.org.uk>
References: <20251016104242.157325-1-rf@opensource.cirrus.com>
	<20251016104242.157325-6-rf@opensource.cirrus.com>
	<871pn3860a.wl-tiwai@suse.de>
	<37e0f08b-ce35-450b-9abf-d3be09d2863f@sirena.org.uk>
	<14617d69-7312-418f-abd9-3c65a84f8421@opensource.cirrus.com>
	<d4e94837-6e0b-4b47-896d-d0dd3a59a39b@sirena.org.uk>
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
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 16 Oct 2025 14:13:16 +0200,
Mark Brown wrote:
> 
> On Thu, Oct 16, 2025 at 12:58:15PM +0100, Richard Fitzgerald wrote:
> > On 16/10/2025 12:27 pm, Mark Brown wrote:
> 
> > > This feels like it might be a better fit for debugfs or possibly
> > > configfs?  It's not really within the sysfs rules, and especially
> > > debugfs is a lot more relaxed about everything.
> 
> > debugfs is an easy change in the driver but more complex for the
> > tooling. Unlike sysfs there's no standard layout or naming convention
> > for the ASoC debugfs tree, so it's more troublesome to locate the amp
> > entries.
> 
> > ASoC creates a debugfs root by default if DEBUGFS is enabled. But HDA
> > doesn't have its own debugfs. There is an ALSA debugfs enabled by
> > CONFIG_SND_DEBUG, which is normally disabled. But enabling
> > CONFIG_SND_DEBUG has other side-effects, it enables more than debugfs.
> 
> > Or we could create a new debugfs node specifically for Cirrus Logic
> > directly in /sys/kernel/debug.
> 
> Dunno about Takashi but for this application I'd be happy for you to
> just put something in the root of debugfs.

I'm fine with debugfs root.  The current approach with sysfs looks too
generic for the need of this access, so I find debugfs would be a
better fit, too.


thanks,

Takashi

