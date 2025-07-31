Return-Path: <linux-kernel+bounces-751669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D57BB16C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 08:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D1E55434D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2054C278E77;
	Thu, 31 Jul 2025 06:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jt7rfGtn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rAIS43ZX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jt7rfGtn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rAIS43ZX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F5A270EA5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 06:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943806; cv=none; b=cXe5On5obNMZOspRpqOLVlyYLueV4Mxi2jHzBx1kKkn5Y08tcXyiEbHD6K4OSojHZnlMrcg1ZolgMqE0RrUA38TZOIssguZOZRD8V5rhtdLiSjc/6nhVGhoFsFD4xVokzVyHIrD/4w4RL8EYpMMobmnf7EpTFxD3q/MT4YKZS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943806; c=relaxed/simple;
	bh=Mg1SZUDtpb5fukYlpDOVGZPlqb1vD1mfKltNiZVMAKk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVc4EpTqdqE0UrNkpHlvxPA22gY4KEysIfAO09DcUHwA6Vpf86n10iss0NDXDjTU13sCLAenLsiBUqqWAxuCAxfLcgFfN5o7tMd1JBJbNzLFbrCJ9yptKYjPqZM5S9enVq6cj4u818LN/Se66+6wX5SVsNt/yThZqQHSK6NvS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jt7rfGtn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rAIS43ZX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jt7rfGtn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rAIS43ZX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 242711FB52;
	Thu, 31 Jul 2025 06:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753943803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1B1uEdP31ZAwho/mN4CDJyBnyJcWEEaVOVcOgfkzOQI=;
	b=Jt7rfGtnZkzKrUzjWwjODMVB4zuaygIdrvrfmstiAHJGoIvLv5/89/n6Su6YLB+fyAKjQb
	HQA6yg/5Kn1dnXAOVvR2IIKmbRoTiDgO2vYjEXqo7Z1IXeUI6Xn3bpRv1hw315YftECxkk
	QpVuoyaT+N9yI58ImGwjG9iF1S8pou0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753943803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1B1uEdP31ZAwho/mN4CDJyBnyJcWEEaVOVcOgfkzOQI=;
	b=rAIS43ZXAoT3yN4hhkOw5BSNc3Y/cNRblEXLdYehFWa8veN1EGpuy4NUDdFrgwQjGO0H9S
	pnb70Ieq1XG1WHAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753943803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1B1uEdP31ZAwho/mN4CDJyBnyJcWEEaVOVcOgfkzOQI=;
	b=Jt7rfGtnZkzKrUzjWwjODMVB4zuaygIdrvrfmstiAHJGoIvLv5/89/n6Su6YLB+fyAKjQb
	HQA6yg/5Kn1dnXAOVvR2IIKmbRoTiDgO2vYjEXqo7Z1IXeUI6Xn3bpRv1hw315YftECxkk
	QpVuoyaT+N9yI58ImGwjG9iF1S8pou0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753943803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1B1uEdP31ZAwho/mN4CDJyBnyJcWEEaVOVcOgfkzOQI=;
	b=rAIS43ZXAoT3yN4hhkOw5BSNc3Y/cNRblEXLdYehFWa8veN1EGpuy4NUDdFrgwQjGO0H9S
	pnb70Ieq1XG1WHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1A7413876;
	Thu, 31 Jul 2025 06:36:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q2bBOfoOi2hmYAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 06:36:42 +0000
Date: Thu, 31 Jul 2025 08:36:42 +0200
Message-ID: <87zfcksw79.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Fix arch defconfigs
In-Reply-To: <d143e454-1994-4dbb-a7f2-bbb693405376@kernel.org>
References: <20250731053031.27121-1-tiwai@suse.de>
	<d143e454-1994-4dbb-a7f2-bbb693405376@kernel.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 31 Jul 2025 08:15:06 +0200,
Krzysztof Kozlowski wrote:
> 
> On 31/07/2025 07:30, Takashi Iwai wrote:
> > The Realtek and HDMI HD-audio codec configs have been slightly updated
> > again since the previous change.  Follow the new kconfig changes for
> > arch defconfigs that contain CONFIG_SND_HDA_* items.
> > 
> > Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
> > Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > ---
> >  arch/arm/configs/multi_v7_defconfig        | 3 ++-
> >  arch/arm/configs/tegra_defconfig           | 3 +++
> >  arch/loongarch/configs/loongson3_defconfig | 2 ++
> >  arch/mips/configs/loongson2k_defconfig     | 1 +
> >  arch/mips/configs/loongson3_defconfig      | 3 ++-
> 
> 
> This is not ALSA change at all. Please use correct subject prefixes
> after splitting the patch per subsystem.

OK, will do.


thanks,

Takashi

