Return-Path: <linux-kernel+bounces-768209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545CB25E3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26EC51884519
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4692E2DC8;
	Thu, 14 Aug 2025 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0C69dW38";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h+48ulXe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0C69dW38";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h+48ulXe"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE7A2E2853
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755158369; cv=none; b=Wh4FskXJfmy7kY7yS0uEU4lvJQKPK4zXX4sNpaeh5J1RcXdkYa1zRVLq2632NPRACCuvYRo1I1sJiMx8oXWFtr1UwUP/5knAybCznR2EkCNed7kGJPBwaks99lcdjVNQlT1GFjhfgOQgSNafzqbVvs0PqHQsFMy61gY3LOSC+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755158369; c=relaxed/simple;
	bh=njlR5+dDpIu9lGmGFrzjmymDMYaSbyX07Jn/2hn+0XM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RwQsjcbJssebkkPDnvm61ZY620Nstepk82R/vKbNqc3fPbSg16ScytTllumOKFl+vFu+sfolMLfnvnW8oQ5tBUrxa49PZl0p3S6iZ9Jc7oiFIpmB1dnoZK7kBGi0qRDyoE/AMoZuU9tJRy2AeUP46q/uBj8+IZUZ3hu8l5rDJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0C69dW38; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h+48ulXe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0C69dW38; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h+48ulXe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A71231F7CE;
	Thu, 14 Aug 2025 07:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755158366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piRbzTwHpZ4JfuQf9NvdvsiYRSgiemRdeFZv62/Pu2I=;
	b=0C69dW38s2gOvuKnmJDakezU2GwwbkNupsY6IjMLadJQz0b7eIzz1j8frLwg4+OuYBT6Np
	WFYLW+lX/O66wZnKRzMVfcENenfWFzxDypSFfcRjozBfSxanqZz0JODOFS/RLHyEvvPKMh
	zpNa0fd5dN5+taaGpRsw/32h03yv83s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755158366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piRbzTwHpZ4JfuQf9NvdvsiYRSgiemRdeFZv62/Pu2I=;
	b=h+48ulXeOGsYgdaC9fP5Luuq13+vmMPeyddoEeVxL6AQfmaYvnEkDY5TroTKFqb6zdGlhN
	3WvfhkmzzZ6GRPAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755158366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piRbzTwHpZ4JfuQf9NvdvsiYRSgiemRdeFZv62/Pu2I=;
	b=0C69dW38s2gOvuKnmJDakezU2GwwbkNupsY6IjMLadJQz0b7eIzz1j8frLwg4+OuYBT6Np
	WFYLW+lX/O66wZnKRzMVfcENenfWFzxDypSFfcRjozBfSxanqZz0JODOFS/RLHyEvvPKMh
	zpNa0fd5dN5+taaGpRsw/32h03yv83s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755158366;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=piRbzTwHpZ4JfuQf9NvdvsiYRSgiemRdeFZv62/Pu2I=;
	b=h+48ulXeOGsYgdaC9fP5Luuq13+vmMPeyddoEeVxL6AQfmaYvnEkDY5TroTKFqb6zdGlhN
	3WvfhkmzzZ6GRPAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 71C53136AE;
	Thu, 14 Aug 2025 07:59:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2JROGl6XnWjTBwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 07:59:26 +0000
Date: Thu, 14 Aug 2025 09:59:26 +0200
Message-ID: <87ms82uye9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: Re: [PATCH v4 4/7] ALSA: usb-audio: us144mkii: Implement audio capture and decoding
In-Reply-To: <20250813131518.18985-5-ramiserifpersia@gmail.com>
References: <20250813131518.18985-1-ramiserifpersia@gmail.com>
	<20250813131518.18985-5-ramiserifpersia@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Wed, 13 Aug 2025 15:15:15 +0200,
©erif Rami wrote:
> 
> +void tascam_capture_work_handler(struct work_struct *work)
> +{
....
> +	while (atomic_read(&tascam->capture_active)) {
> +		size_t write_ptr, read_ptr, available_data;
> +		bool can_process;
> +
> +		{
> +			guard(spinlock_irqsave)(&tascam->lock);

Use scoped_guard().

> +		decode_tascam_capture_block(raw_block, decoded_block);
> +		process_capture_routing_us144mkii(tascam, decoded_block,
> +						  routed_block);
> +
> +		{
> +			guard(spinlock_irqsave)(&tascam->lock);

Ditto.


> +void capture_urb_complete(struct urb *urb)
> +{
....
> +	if (urb->actual_length > 0) {
> +		size_t write_ptr;
> +		size_t bytes_to_end;
> +
> +		{
> +			guard(spinlock_irqsave)(&tascam->lock);

Ditto.


thanks,

Takashi

