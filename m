Return-Path: <linux-kernel+bounces-728567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93FEBB02A16
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 10:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 283137B8BBD
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Jul 2025 08:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4599826B77F;
	Sat, 12 Jul 2025 08:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2UQI6HGo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sY3Nf1/k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HhzT0oVm";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g8dpR2tz"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BE26B776
	for <linux-kernel@vger.kernel.org>; Sat, 12 Jul 2025 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752308952; cv=none; b=Xg+yV3WBpA/OmALetJa1LRGv2PDgzstO0JW9/i9JcBhp9GA/E9+jq9WDYDB7qXn/S2meVvMrm8Lp1z56GCofmo+U10RlELQ/1PtvKQfnNA6Ku2PeO/ztB+dCwzP9lblSVnEnUWaHahRxCe8b7hUIbnSpUiUbbCVGQ/QUT8QsSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752308952; c=relaxed/simple;
	bh=o5OSowyX0g2NZm20gpmAfN8NRzD6c4FUxrFvjquJBdw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifZ2dHBW6OjJ4aaFsB6AJsJ3wcZwpRJqO1FhO/Oq9N9hUqZeDSvE6NMl/19iOpOZC9R3N5TCykENqB6gp6U53kEfAjvtS1CBiWWR1m7lKow2i+b2Skmw0Gbp6Lu5EANQryd53j9+hllFgGU/4XrHf/PBRJE2BRqVJxqmdQ687Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2UQI6HGo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sY3Nf1/k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HhzT0oVm; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g8dpR2tz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1DC51F388;
	Sat, 12 Jul 2025 08:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752308948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBVbV/Lie/jK+I+MUg0l6hv/MvUm9iT369FmLVySVqc=;
	b=2UQI6HGoRfa+2uWYxrcF77ASgzK4yIF8V/tOK/BvLpu1pZ/pci7AzVDUnDTTqFKuEPiiNd
	KTfXJAneuCHdoWJtQE9ETeehwam5kguzAHg4P2AXg2iGGnAHl8cSxPeRXaJny68/Rm6h1N
	ddvYivLf3UbDnDF8iGwsMkzHXyXFH+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752308948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBVbV/Lie/jK+I+MUg0l6hv/MvUm9iT369FmLVySVqc=;
	b=sY3Nf1/kR84u03nBJvFIYQNAUdvBTtSWv/yzHbAGmk3g6zUO3dGeXSXc+2Hfmd54Fy8TL1
	GG3edwuurp3LBABw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1752308946; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBVbV/Lie/jK+I+MUg0l6hv/MvUm9iT369FmLVySVqc=;
	b=HhzT0oVmj+AxKCW0yVg2W+QMtIIwokFrRQrx/ZfCNT3q/idp7lB/LvEuRsPVq2dMV2Pnvl
	pDveQ8EwOIQk+DeZHrmGq7tSRaIpk7MDE5YZXwMpzsweNpKUbP67Lh+jlF6xYwfBzN8KfK
	SDAGJhqQM0nvG0apfhlH8+9WiKbHi28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1752308946;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eBVbV/Lie/jK+I+MUg0l6hv/MvUm9iT369FmLVySVqc=;
	b=g8dpR2tzIkAyQGmyA9V8uTCyh7OnDxN+BncBzKLnDQVhuwtKfx8cp7hUaevvfqaG7+Obkk
	A4eSA3uHoT5J/HBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A20EA138A1;
	Sat, 12 Jul 2025 08:29:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T2KyJdIccmiWcQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 12 Jul 2025 08:29:06 +0000
Date: Sat, 12 Jul 2025 10:29:06 +0200
Message-ID: <87ple5olrh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baojun Xu <baojun.xu@ti.com>
Cc: <broonie@kernel.org>,
	<andriy.shevchenko@linux.intel.com>,
	<alsa-devel@alsa-project.org>,
	<shenghao-ding@ti.com>,
	<navada@ti.com>,
	<13916275206@139.com>,
	<v-hampiholi@ti.com>,
	<v-po@ti.com>,
	<linux-sound@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] ALSA: hda/tas2781: Add TAS2770 support
In-Reply-To: <20250712081733.12881-1-baojun.xu@ti.com>
References: <20250712081733.12881-1-baojun.xu@ti.com>
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
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,ti.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Sat, 12 Jul 2025 10:17:33 +0200,
Baojun Xu wrote:
> 
> Add TAS2770 support in HDA.
> Create a header file include/sound/tas2770-tlv.h,
> Set chip_id in i2c probe, check it while sound control is created,
> and the DSP firmware binary file parser.
> 
> Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> ---
>  include/sound/tas2770-tlv.h     | 20 ++++++++++++
>  include/sound/tas2781.h         |  4 +++
>  sound/pci/hda/tas2781_hda_i2c.c | 58 +++++++++++++++++++++++++--------

The whole HD-audio stuff has been moved under sound/hda recently.
Please create a patch based on for-next branch of sound git tree.


thanks,

Takashi

