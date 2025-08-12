Return-Path: <linux-kernel+bounces-764157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A408B21EAE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:01:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E76683EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 07:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29CF52D6E77;
	Tue, 12 Aug 2025 07:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CqQAKgoD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yMHreUYy";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CqQAKgoD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yMHreUYy"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E7B2D4808
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 07:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754982055; cv=none; b=jsPuEQDsnOvuBh1s+r5kIJhCwvoQA2POyVYVn/pHhrdx31cbhd6vYIouFr9nArtWXe51DTdqUDWO/98M+GZ5wXHEc6JB2Z6I/dPo5L2QUVjBuWanhxJCVA3al+n1aXH4jxxCuDoIWr9AYh3Cs5SEYoT0YlpR6gBhlSY7Z8OpRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754982055; c=relaxed/simple;
	bh=daYrsawkrfT9LZzKvjg7+6Hh5Sb9X1VSk1T9Z1PGdBc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eAeIx3mwRFZ37QV/FeSE/07qPjmpSSGfa2wUh+1HY84P7oczWgOf+wjYSPIqGuqx+DF4Tt6rsLL6casB4mu8AubSyiag5wti0D5JJ3GkPeVmisfWTDQ5YXHqR1t1WE1B9A+lLB8mHArbRKd3Tn/OGzrfAWwDibvMhHldZcAaxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CqQAKgoD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yMHreUYy; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CqQAKgoD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yMHreUYy; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A4761F395;
	Tue, 12 Aug 2025 07:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754982051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdlpa1D/TrwdigQGHz4E3Tezdrj9l/7Oi9C1r7dw1uM=;
	b=CqQAKgoDt7pCPYzc8XenQbYo3rP8vbDR4EBP91ZQkniO0W5TVJTOWbPxP6EMS1o171dg+F
	1y6nSgBNaw7H3TfTb8TKyH4rk633t6K6NKPgpD6xpt+kXfS8cdDMG9ubSEFFEfeLL2iagm
	bZvqH+BThrcQfATItBktTy1HL0v1XX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754982051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdlpa1D/TrwdigQGHz4E3Tezdrj9l/7Oi9C1r7dw1uM=;
	b=yMHreUYyRHiO86uA74ZyyKMq+okW75hLUVDrRVZhji+OKJ1O7C1XL5SmQZ+s+/z/sthJwE
	pflU0OMeZ8PS50AQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1754982051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdlpa1D/TrwdigQGHz4E3Tezdrj9l/7Oi9C1r7dw1uM=;
	b=CqQAKgoDt7pCPYzc8XenQbYo3rP8vbDR4EBP91ZQkniO0W5TVJTOWbPxP6EMS1o171dg+F
	1y6nSgBNaw7H3TfTb8TKyH4rk633t6K6NKPgpD6xpt+kXfS8cdDMG9ubSEFFEfeLL2iagm
	bZvqH+BThrcQfATItBktTy1HL0v1XX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1754982051;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xdlpa1D/TrwdigQGHz4E3Tezdrj9l/7Oi9C1r7dw1uM=;
	b=yMHreUYyRHiO86uA74ZyyKMq+okW75hLUVDrRVZhji+OKJ1O7C1XL5SmQZ+s+/z/sthJwE
	pflU0OMeZ8PS50AQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 424521351A;
	Tue, 12 Aug 2025 07:00:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ErPpDqPmmmgVTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 12 Aug 2025 07:00:51 +0000
Date: Tue, 12 Aug 2025 09:00:50 +0200
Message-ID: <87pld1yqfx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-2?Q?=A9erif?= Rami <ramiserifpersia@gmail.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/7] ALSA: usb-audio: us144mkii: Add deep sleep and code style alignments
In-Reply-To: <20250810124958.25309-7-ramiserifpersia@gmail.com>
References: <20250810124958.25309-1-ramiserifpersia@gmail.com>
	<20250810124958.25309-7-ramiserifpersia@gmail.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Sun, 10 Aug 2025 14:49:57 +0200,
©erif Rami wrote:
> 
> Add a deep sleep vendor command to be sent during suspend, allowing the
> device to enter a lower power state.
> 
> This commit also includes code style alignments and implements some
> leftover suggestions that were missed in previous commits.

Those coding style changes should be better folded into previous
patches.


thanks,

Takashi

