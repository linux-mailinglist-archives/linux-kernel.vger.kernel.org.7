Return-Path: <linux-kernel+bounces-821319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E31B80F70
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2C41C81264
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C747034BA36;
	Wed, 17 Sep 2025 16:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RY0bUt/s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dniolIEq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RY0bUt/s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="dniolIEq"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBD42FAC1C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758126038; cv=none; b=ORbrJeRXG23dMOlXtLbKbpMgN5KeTVPYJHvQeXYXkCA2zQl77zalDaAWDMMgHmVXREIdu7iqW1mkU/4aAHFk/dtmRzPmeh8FGI8/l5EQeAEWmnW56/RUNi1Ip8lL+cKsv7uUiPT5aGwszjLQ8dzgZOaAJB3Z5fQCzANbsg//60A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758126038; c=relaxed/simple;
	bh=LQuvKEHTVJZsvHGLtLW0Kg8WTPnzr/+0HihLj4fYHts=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aV1Rkq4gmza3O0f5FqfvKB4HKZyUxa0ifZA29NlQVGmkG7VMbBQU9DyI18Ix8KdNgPbzR481zRLqvdfyFjb8Rr7tvHAfrqzCh+MPI1vHn2snDeKxbKm5M0tVVmWZBJeQMOOolkxAkvB17/UH7mV5QhjBz71fnj/Yy93sqD3NGIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RY0bUt/s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dniolIEq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RY0bUt/s; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=dniolIEq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A55522785;
	Wed, 17 Sep 2025 16:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758126034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuIJwH4EkUh14GpweEDXfjpcwhTMBfMSb+0vHYyWZMc=;
	b=RY0bUt/sT+uGF3H/BcKE1d7DtBPhYGx79Ja9jD84qI15uaw7pXrQZz4em4HCMgkTTWQ0qc
	nIk7JS96Gi5JVzAYobbGZE7bu8V8CvMgqdlLCdYRDIY48JWAvU2DJ1HkJD6FDuDiV1Hvso
	UTAWIwFj4l1vnK55EGmSjYHn1Ag89zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758126034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuIJwH4EkUh14GpweEDXfjpcwhTMBfMSb+0vHYyWZMc=;
	b=dniolIEqy85hRTW3DEu/15DZhkznlh56Avr/hs6fnrf+RAaG1T16Vpj70+YT+68Q1rsjv2
	va17oXnocTnyOcCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RY0bUt/s";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dniolIEq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758126034; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuIJwH4EkUh14GpweEDXfjpcwhTMBfMSb+0vHYyWZMc=;
	b=RY0bUt/sT+uGF3H/BcKE1d7DtBPhYGx79Ja9jD84qI15uaw7pXrQZz4em4HCMgkTTWQ0qc
	nIk7JS96Gi5JVzAYobbGZE7bu8V8CvMgqdlLCdYRDIY48JWAvU2DJ1HkJD6FDuDiV1Hvso
	UTAWIwFj4l1vnK55EGmSjYHn1Ag89zE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758126034;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XuIJwH4EkUh14GpweEDXfjpcwhTMBfMSb+0vHYyWZMc=;
	b=dniolIEqy85hRTW3DEu/15DZhkznlh56Avr/hs6fnrf+RAaG1T16Vpj70+YT+68Q1rsjv2
	va17oXnocTnyOcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDA111368D;
	Wed, 17 Sep 2025 16:20:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vRpiNNHfymiMLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Sep 2025 16:20:33 +0000
Date: Wed, 17 Sep 2025 18:20:33 +0200
Message-ID: <87wm5xaw4u.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: tiwai@suse.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@opensource.cirrus.com
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Prevent SEGFAULT if ACPI_HANDLE() is NULL
In-Reply-To: <20250917160609.461718-1-rf@opensource.cirrus.com>
References: <20250917160609.461718-1-rf@opensource.cirrus.com>
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
X-Rspamd-Queue-Id: 2A55522785
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Wed, 17 Sep 2025 18:06:09 +0200,
Richard Fitzgerald wrote:
> 
> Check in snd_intel_dsp_check_soundwire() that the pointer returned by
> ACPI_HANDLE() is not NULL, before passing it on to other functions.
> 
> The original code assumed a non-NULL return, but if it was unexpectedly
> NULL it would end up passed to acpi_walk_namespace() as the start
> point, and would result in
> 
> [    3.219028] BUG: kernel NULL pointer dereference, address:
> 0000000000000018
> [    3.219029] #PF: supervisor read access in kernel mode
> [    3.219030] #PF: error_code(0x0000) - not-present page
> [    3.219031] PGD 0 P4D 0
> [    3.219032] Oops: Oops: 0000 [#1] SMP NOPTI
> [    3.219035] CPU: 2 UID: 0 PID: 476 Comm: (udev-worker) Tainted: G S
> AW   E       6.17.0-rc5-test #1 PREEMPT(voluntary)
> [    3.219038] Tainted: [S]=CPU_OUT_OF_SPEC, [A]=OVERRIDDEN_ACPI_TABLE,
> [W]=WARN, [E]=UNSIGNED_MODULE
> [    3.219040] RIP: 0010:acpi_ns_walk_namespace+0xb5/0x480
> 
> This problem was triggered by a bugged DSDT that the kernel couldn't parse.
> But it shouldn't be possible to SEGFAULT the kernel just because of some
> bugs in ACPI.
> 
> Fixes: 0650857570d1 ("ALSA: hda: add autodetection for SoundWire")
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Thanks, applied now.


Takashi

