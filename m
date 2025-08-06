Return-Path: <linux-kernel+bounces-757283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B563BB1C045
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:08:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B4418A36DB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 06:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476AF2147E6;
	Wed,  6 Aug 2025 06:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LgLVtzaP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x5llDXoB";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HxBGyS05";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="biHsbHpv"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF15212B2B
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 06:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754460445; cv=none; b=Xu7ACinM/wRzcgqJ8ijWXhWLzhIy0kNhZILwkpuxM067/aQayF+gF2FeMyo7nEXq5VhU42DWfnYo2VOQUj5b+iR/EIoxOtPCYAmeVvplJb3a2NIGT+7qjCz1NoAnWR9q0ff6FP0z+UMh9LdKVOb4GGE0VhW1XMIIqP5xoTGNmXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754460445; c=relaxed/simple;
	bh=Uy3EGkN+yEao1BDIEWmakFyqpZgqt3NXDN9LMoE0mOY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPwHTIG7tpGg7nbkZIqUDyYHBCfBaxpNP14ZqLSZjIqZaV7Nfk1f5krrRjV1EBzbqoozl1fqig3e7nC7jcCxP9NdVgoNl6Lnl2zw0zL46BvwNsgNQ9pa/Z1eSAm9Y6rTCI42wDhCF7XEmitDs9p+6cvyoqnxs2tmKOljLSPe+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LgLVtzaP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x5llDXoB; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HxBGyS05; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=biHsbHpv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0547B211F8;
	Wed,  6 Aug 2025 06:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDfyXIz/VJptEYZ0UR6/796YxobUugzCV7SvGmQWBc4=;
	b=LgLVtzaPtf44Srix8w6BFqTVQlvtCT9JvVZxPAbJrJxusu7ExOizdCqFfBhRG4Ozk6Kco5
	CarBBn2jD1lvIVlc9R4bPBOd+j7UedAQooedTzfL6DNDVJQLRoGuICX/JHeuaA0GHGoC9o
	L08nWe2PVeuuU9p2KzmGBq4o9Ycdi7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDfyXIz/VJptEYZ0UR6/796YxobUugzCV7SvGmQWBc4=;
	b=x5llDXoBfnSjm8BxyO+GhyOOaqQvab8OajNItBij20nYlUmq3xvOhp4gZATV9dCTtkPaBC
	kyEz/yn9bQzpPkBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HxBGyS05;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=biHsbHpv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754460440; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDfyXIz/VJptEYZ0UR6/796YxobUugzCV7SvGmQWBc4=;
	b=HxBGyS05O+hF78GZtxy60yPCMiaXhRAiplZgixjajT0S38hr8NDd1jDRPqh9RjEXcYHorp
	LtvFMPKAePCMSQzRP8CS3gglaN6Daq+QbNvLNAlVqqPO7i4r0eltVTJFWyqyWu1TsNS0Gq
	EzhKhWUrzPgziXVZQtc6jolzxCryLEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754460440;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rDfyXIz/VJptEYZ0UR6/796YxobUugzCV7SvGmQWBc4=;
	b=biHsbHpvpj3qrIkcglH4Ne7evp9M5juykBYeWNnRRh5ZsUlYWNrBv6HT2G2rjZwVZDGK5v
	yq/JYcPROXpeybBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B771013AB5;
	Wed,  6 Aug 2025 06:07:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yi6oKxfxkmhoXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 06 Aug 2025 06:07:19 +0000
Date: Wed, 06 Aug 2025 08:07:19 +0200
Message-ID: <87ikj1rnjc.wl-tiwai@suse.de>
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
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Support L"SmartAmpCalibrationData" to save calibrated data
In-Reply-To: <20250805070945.524-1-shenghao-ding@ti.com>
References: <20250805070945.524-1-shenghao-ding@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 0547B211F8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Tue, 05 Aug 2025 09:09:45 +0200,
Shenghao Ding wrote:
> 
> Some devices save the calibrated data into L"CALI_DATA", and others into
> L"SmartAmpCalibrationData". Driver code will support both.
> 
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Thanks, applied.


Takashi

