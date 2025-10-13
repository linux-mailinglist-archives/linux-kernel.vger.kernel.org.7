Return-Path: <linux-kernel+bounces-850100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C7568BD1D86
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 38DEB4ECCA9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 07:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7905F2E9722;
	Mon, 13 Oct 2025 07:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aYD0lMFu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/8wYMcE0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="E7lwRxVA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="98uzvVEj"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CAD2E8DFE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 07:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341223; cv=none; b=ikeE7UEV+pT2Uy2gniZS/0qU9IK7zi6A6t2bANubMWK6Otkg91ZGZggLy1iDsOGgGQFSIIr1cb+HGAQ5nLdcjI7XQSAaOSQoyPwXL2MTz3ZIKHK46QhhLpNmUF2aH6YAxhBrQ2hWgmGhB08pQGh8vdEDIIXi7Jyuh8Oifpt3djE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341223; c=relaxed/simple;
	bh=bj8qi9VLqCnFi/6W8tBWdfOyRLW6sgcAT3YyjZyaYRc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K/Pg//EUY0RL283y75AUGqSm+Y/d1RDVb2k4nLa1uQfjvoH7s6tHciN2e2sYAyTxup4hWCeMXDAqOMG9WsCf+fS0sHpVPYMJ7wXsoVgIlk+mfalWED0P7hQov43ENbC1ojyrbz1q6Quq1hg+8PVpfY4iLSrhPaZ5wFTHRj6vI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aYD0lMFu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/8wYMcE0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=E7lwRxVA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=98uzvVEj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4C1FD1F745;
	Mon, 13 Oct 2025 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760341219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zo8sbB8b5rFYvKMDDRbGc7juWeTWjPesh3A73LZg9hA=;
	b=aYD0lMFuihh8fuY+M8/0mSatp01aBst1r37addDE0qWtHYF3TVR9C7+JkwMBm9nH8Xnjf0
	4q5G2rU305LUlsO3cVIfegvTA5Hn7J+vCZb3vXMyvWzzrOBOMi7eZzMfqFQXwRzly+K66C
	leqsVi08gsot5/EbMDojR87SYi+Bcqo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760341219;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zo8sbB8b5rFYvKMDDRbGc7juWeTWjPesh3A73LZg9hA=;
	b=/8wYMcE0bBeCWIF44bIj3M+LTajbNGwn2fbnumo9QJaL4xl8GczNLruewUgfX5rB2U9WLa
	Jw6Xu+gSd+DkwvCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=E7lwRxVA;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=98uzvVEj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1760341218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zo8sbB8b5rFYvKMDDRbGc7juWeTWjPesh3A73LZg9hA=;
	b=E7lwRxVA7n60sagCg2gXcTvLYAgeW2zp6ASe1dNTdsU3N8vilS53dwxo5B/zxwnc9YjCVe
	jSB8oTkZMoBDB20130VGwhxerYPwGG+mBx3lK5gmyzuuTp2i3D22pKedVJtqJJ6KfcKVeW
	RPr1yXyV7i8K2t6RsZXnWsc5QoCx5iM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1760341218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zo8sbB8b5rFYvKMDDRbGc7juWeTWjPesh3A73LZg9hA=;
	b=98uzvVEjgAPMYS4ingO7g9DKTUKe5Ae7fyACkKOZrLDFBXDsKHCYvPtYhvClgsJ5K0eE+G
	yEbbIvTkUJXP74DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 041481374A;
	Mon, 13 Oct 2025 07:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJuQOuGs7GjbewAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 13 Oct 2025 07:40:17 +0000
Date: Mon, 13 Oct 2025 09:40:17 +0200
Message-ID: <87zf9v8d26.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>,
	<13564923607@139.com>,
	<13916275206@139.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Set tas2781_hda::tasdevice_priv::chip_id as TAS5825 in case of tas5825
In-Reply-To: <20251013043555.1871-1-shenghao-ding@ti.com>
References: <20251013043555.1871-1-shenghao-ding@ti.com>
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
X-Rspamd-Queue-Id: 4C1FD1F745
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com,139.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid]
X-Spam-Score: -3.51

On Mon, 13 Oct 2025 06:35:55 +0200,
Shenghao Ding wrote:
> 
> The software reset for TAS5825 is different form other chips, as it will
> set as 0x11 instead of 0x1 during reset in the tasdevice_reset(). So set
> tas2781_hda::tasdevice_priv::chip_id as TAS5825, tasdevice_reset() can
> work correctly.
> 
> Fixes: 7ceb69ca82b1 ("ASoC: tas2781: Add tas2118, tas2x20, tas5825 support")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Applied now.  Thanks.


Takashi

