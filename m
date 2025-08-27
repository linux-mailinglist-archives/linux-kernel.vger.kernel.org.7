Return-Path: <linux-kernel+bounces-788363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 174BAB3835C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D5EF1BA467A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC43128A2;
	Wed, 27 Aug 2025 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y7AZwNR0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DoYkPznx";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lL2qGwys";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7HGcCvNk"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF78235082B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 13:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300066; cv=none; b=SbQAqupAsuHn7zPVaxTJaf/AenlKitcJIZNOrgn63eIZAnQS0bmha/in/ompCTMEynGExv4RR9CK56cXqP/2YlDueTdrfsVTZ7kwqKcqlKqekR81RYvdIXqH+C+LMOd3Di/MtHhp8DdcV2c1w+ZqfSkHl8lVcFRsOil0kDkfjD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300066; c=relaxed/simple;
	bh=eI+Nz2KY3Oicb6ucDRp/ea+Tefai8e7GEELnp3WqITk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HhRKyEgSYTqb2zWw0AQBwGxB5IsSBzu53knlS7QAmA0Oqj+pCeE7fZHqQPzcJpN2Y6W0yGRcBuPCFMbRitr30K4UMcIDZKnQgCAkM86c5sAUWOApCtogrpA5l0XHy2QmdRbY7ElFbP5VnUaSH2kL2L3UoYnMVmpzhl+pCEyADlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y7AZwNR0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DoYkPznx; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lL2qGwys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7HGcCvNk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5F7522641;
	Wed, 27 Aug 2025 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756300061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSMcRXhDYhxLein4Kd5+NaB9/kTemgomKAqbBV9fU+k=;
	b=y7AZwNR0Bo5F5yIxEJisv65vHgAlJhXIXgkkw1jbXtODRWW1O+hRwmBAow6yPHKzsMjsqI
	2M2DRdO7y7h6Ylo/k/WhlTgEefziQ4VhTYnx2fkdpCSjfdLGDYfLirn+fIlVTi9OkbguQH
	odZP7K9uHZlriM5iOhAfqCXeDfW+4gU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756300061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSMcRXhDYhxLein4Kd5+NaB9/kTemgomKAqbBV9fU+k=;
	b=DoYkPznxpHy4dPdPuQ/MPFbY2703qrFTS5b8uDQttGHvTq+1JoRth5CjPkgh8SUVzNCJ6n
	Bp8StDOgouwoPKCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756300060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSMcRXhDYhxLein4Kd5+NaB9/kTemgomKAqbBV9fU+k=;
	b=lL2qGwysmEO7KroHVP0qOdWbYO0DyV5AW++RQgIsFcW7uUlVsNp9lm0wFggXeHQJufZXX2
	sCum/I/C4jqy1mwQ6dDqcrFo8PLRiax3lMrwH4VGBSAk+TaVo8lzzLVQc3Dse4YmVl0zM/
	LSRjWJIJ08Kkwc0IKWx/XL8cjeG3IIc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756300060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zSMcRXhDYhxLein4Kd5+NaB9/kTemgomKAqbBV9fU+k=;
	b=7HGcCvNk8Uun0+7RUWtvqCB+KItnMNwsp5OBaAQJQslKc4+tYSeg2hN5W1rxB+ecVmeFTw
	BqswCJ0DnwA9SjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9204013867;
	Wed, 27 Aug 2025 13:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id H98PIxwDr2iUXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 27 Aug 2025 13:07:40 +0000
Date: Wed, 27 Aug 2025 15:07:40 +0200
Message-ID: <878qj4hq03.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v3] ALSA: hda/tas2781: Fix EFI name for calibration beginning with 1 instead of 0
In-Reply-To: <20250827043404.644-1-shenghao-ding@ti.com>
References: <20250827043404.644-1-shenghao-ding@ti.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Wed, 27 Aug 2025 06:34:03 +0200,
Shenghao Ding wrote:
> 
> A bug reported by one of my customers that EFI name beginning with 0
> instead of 1.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Applied now.  Thanks.


Takashi

