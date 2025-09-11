Return-Path: <linux-kernel+bounces-812488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D83B538CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2C2C7BDF35
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0BA3570B4;
	Thu, 11 Sep 2025 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1ZbPeP9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bp+O9nsz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="o1ZbPeP9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bp+O9nsz"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF894353366
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757607110; cv=none; b=S/P09acBI99HuSRPlxw6/cEZGgreSXw0IfPscqkfkN3aCYH6UE33lLgBOBHn219yKm82dZdmsZaOg/4lJDL4TuRzRMBAXAw9uESgvHKOJ8RjtGWU0+Z+V3GEB0RWYk8cBCyEwoy+TEOpJy96Z7UcCISwrSXkvHPoVFG/9FpgXmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757607110; c=relaxed/simple;
	bh=J0568fuHDPQs5XgBA87Fya7l6DWdCy/Y/1a5dGyC6cA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3T1/0UzOG+kAhSM5WTYYfSyEMvbSL+HmJNDXM6hMAEmRW/RDmk5Qii+NIYcLlhjl2KfHAUhwJHYNT6u6m6FkqyOrQIKDDS3kk4CnOJvrfR/w/bmXXcgUwonkrKUPqN1TL/qk3zMehcngToTvhi9GN5EffogjPB46y0CQ6RyRd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1ZbPeP9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bp+O9nsz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=o1ZbPeP9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bp+O9nsz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 927C640420;
	Thu, 11 Sep 2025 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757607105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMhm+cdLuSxLHqNMT9K0iB0b3U0RJDOdoZ55n3U8Gmg=;
	b=o1ZbPeP90sIbG72AgHgDNwGox7kAd4ML3rzANTxIbXdeBQVeEiSgE2D3BjmD+pNfAkZ8P/
	T8Qf0iYBPPQHsOHrSLrBzl+shKZv4RUQYGFwCRtumFEcHrAwEPkfQd4L3a56J1ddNv9/b2
	MNJxMWUk09OkgiVnQ6L4G+E5+aRHP4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757607105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMhm+cdLuSxLHqNMT9K0iB0b3U0RJDOdoZ55n3U8Gmg=;
	b=Bp+O9nszTgoQ7UcGBrRfnGGmNKkvgVkHR0Ga4gVmmVb89ZVTBMEeHKVzuQIgN1PfhS6pUA
	OogKSUGQR8ZXGtCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=o1ZbPeP9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Bp+O9nsz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757607105; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMhm+cdLuSxLHqNMT9K0iB0b3U0RJDOdoZ55n3U8Gmg=;
	b=o1ZbPeP90sIbG72AgHgDNwGox7kAd4ML3rzANTxIbXdeBQVeEiSgE2D3BjmD+pNfAkZ8P/
	T8Qf0iYBPPQHsOHrSLrBzl+shKZv4RUQYGFwCRtumFEcHrAwEPkfQd4L3a56J1ddNv9/b2
	MNJxMWUk09OkgiVnQ6L4G+E5+aRHP4c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757607105;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FMhm+cdLuSxLHqNMT9K0iB0b3U0RJDOdoZ55n3U8Gmg=;
	b=Bp+O9nszTgoQ7UcGBrRfnGGmNKkvgVkHR0Ga4gVmmVb89ZVTBMEeHKVzuQIgN1PfhS6pUA
	OogKSUGQR8ZXGtCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5544513A56;
	Thu, 11 Sep 2025 16:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7qVmE8H0wmj+EwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 11 Sep 2025 16:11:45 +0000
Date: Thu, 11 Sep 2025 18:11:44 +0200
Message-ID: <87h5x9rmtb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Shenghao Ding <shenghao-ding@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<13564923607@139.com>,
	<13916275206@139.com>,
	<alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>,
	<baojun.xu@ti.com>,
	<Baojun.Xu@fpt.com>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Fix a potential race condition that causes a NULL pointer in case no efi.get_variable exsits
In-Reply-To: <20250911071131.1886-1-shenghao-ding@ti.com>
References: <20250911071131.1886-1-shenghao-ding@ti.com>
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
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 927C640420
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 11 Sep 2025 09:11:31 +0200,
Shenghao Ding wrote:
> 
> A a potential race condition reported by one of my customers that leads to
> a NULL pointer dereference, where the call to efi.get_variable should be
> guarded with efi_rt_services_supported() to ensure that function exists.
> 
> Fixes: 4fe238513407 ("ALSA: hda/tas2781: Move and unified the calibrated-data getting function for SPI and I2C into the tas2781_hda lib")
> Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

Thanks, applied now.


Takashi

