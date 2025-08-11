Return-Path: <linux-kernel+bounces-761936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164BAB20024
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1620D189620C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98D92D979A;
	Mon, 11 Aug 2025 07:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OJ9ARzN5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gXsbqF36";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OJ9ARzN5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gXsbqF36"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250A2D94BF
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754896513; cv=none; b=MxZLDNVl4njA2DgQqJYXoNwOnFKKbgs+pbvQgMylkl575gKcQflF53DOLV7zxrHb3H4sM86vZaBquhHRGwck5PjvjvVg0s/b3xKFjIFGtPtx+t6tPYDHk6BWYhBXPu9KUNFws6MLofAYke3siHELQ/R/Q0YHf2isrXvK8Yw+cN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754896513; c=relaxed/simple;
	bh=paVdHkhEZiXG/x+PfgVd5hBnBOxO8AFEfCn94iQWttw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jazZrtOHUglU4pMqXYffjL1SDuEuPbTVRVjBxHFQh9RB24AQep8+QJYTtH/lcGMj7Eux2Cu2TRPxp9nhAboB+vV5G7AFeDgpSJepJYqeHqn2OonHSgvsuJXGrMxyukq50SnL3PbSZpjFa+IXTjLuqSC37Eva2epd76GvHT+evno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OJ9ARzN5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gXsbqF36; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OJ9ARzN5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gXsbqF36; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C2B55BDE7;
	Mon, 11 Aug 2025 07:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754896510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzuoF+Ilnpy3qIMtiaKwMmpaF18qvTSzWw5szQeeK60=;
	b=OJ9ARzN5vfY2G9Hn3ApFG2e9urLGEs+RWPx/kUyvwepgM01PIsGX/mItZfddzFjBxUgCKl
	1k4sTudldQcNOlQ0JTl7e5ZsWqdofxB28fUiT6jJifM9afDTImeXapNDYBaXtYJJAxXrxV
	NmUK0+O/K6e4QLbqwVuiwweJKE2e0uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754896510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzuoF+Ilnpy3qIMtiaKwMmpaF18qvTSzWw5szQeeK60=;
	b=gXsbqF36da12hz426MvEBjhabKQ21Vg850nfYMCabYLh23uuPhlNjoI1uUqCGyrl1RYnh/
	WaUr0IoCc/bRMHBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OJ9ARzN5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gXsbqF36
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754896510; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzuoF+Ilnpy3qIMtiaKwMmpaF18qvTSzWw5szQeeK60=;
	b=OJ9ARzN5vfY2G9Hn3ApFG2e9urLGEs+RWPx/kUyvwepgM01PIsGX/mItZfddzFjBxUgCKl
	1k4sTudldQcNOlQ0JTl7e5ZsWqdofxB28fUiT6jJifM9afDTImeXapNDYBaXtYJJAxXrxV
	NmUK0+O/K6e4QLbqwVuiwweJKE2e0uI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754896510;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hzuoF+Ilnpy3qIMtiaKwMmpaF18qvTSzWw5szQeeK60=;
	b=gXsbqF36da12hz426MvEBjhabKQ21Vg850nfYMCabYLh23uuPhlNjoI1uUqCGyrl1RYnh/
	WaUr0IoCc/bRMHBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17F8C13A55;
	Mon, 11 Aug 2025 07:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /DarBH6YmWjGUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 11 Aug 2025 07:15:10 +0000
Date: Mon, 11 Aug 2025 09:15:09 +0200
Message-ID: <87zfc6wcqq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<alsa-devel@alsa-project.org>,
	<shenghao-ding@ti.com>,
	<13916275206@139.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ALSA: hda: Add TAS5825 support
In-Reply-To: <20250810122358.1575-1-baojun.xu@ti.com>
References: <20250810122358.1575-1-baojun.xu@ti.com>
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
X-Rspamd-Queue-Id: 4C2B55BDE7
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Sun, 10 Aug 2025 14:23:58 +0200,
Baojun Xu wrote:
> 
> Add TAS5825 support in TI's HDA driver.
> TAS5825 is an on-chip DSP, but no calibration is required,
> and no global address support smart amplifier devices.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>

Applied now.  Thanks.


Takashi

