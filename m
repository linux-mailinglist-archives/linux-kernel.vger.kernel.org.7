Return-Path: <linux-kernel+bounces-751713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E437B16C91
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:17:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3601717DA76
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FC91DED66;
	Thu, 31 Jul 2025 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dx0ZP54W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1O9v+dI6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Dx0ZP54W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1O9v+dI6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E0414885D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753946265; cv=none; b=i73eW1/VX3rOzzVN+wB0GI7JZkrxHrg2rUeb7+xG1OxSIm9VMBYJgPhKzJYVKn1R249Pv4eS6eTpN/AutKcDmfOb87lvkP0kIegVZzAeKpVkvLCrkYgJ/qmjbigYRgqK5dTVcN9+aeNpsHg/Mw7wa0RuF1SpQYwOaBirmyGRX6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753946265; c=relaxed/simple;
	bh=XhYZ+9qu63rJGO0+QusQX5MALTCF4ivx1NDh8kfwvb4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+0YehiqGs3yogAXpZ1DU0ekUy2aSMhp+AdlRGyDKDq0+XV8omp78NMdB/RaZI69V8/aweiRmpVRU/zeo1u1IDra+E8g+eFqxZHdPetsYlbnfmAoCMJWKjp9F1JrXVtw2l9a0XYjG6vTrdiUWlBU+fFbvZk+cQS1gLZaQRs0FSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dx0ZP54W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1O9v+dI6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Dx0ZP54W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1O9v+dI6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1BEE521B51;
	Thu, 31 Jul 2025 07:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753946262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kmbLCMq1EwC5ZFQi619+FWDMNBXnYYxgR2C8x77E=;
	b=Dx0ZP54WXAoQsk0yPdZhSI6ofAUxfHLEYYT3/QrIUbgnLxfm6AI0u3LU+TvUfzoq3A2bxx
	2pJzUq7hftnD+pRgFw2eoMhIWWt1MIXUYhsBZaEQlYkdmYJG8fnNPGzFs2ZA2vP6CRVXPf
	rWnqN+FioPCb4ORR6rwdRxoUW7oZMIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753946262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kmbLCMq1EwC5ZFQi619+FWDMNBXnYYxgR2C8x77E=;
	b=1O9v+dI6PL7Viloy5J9UNuMVXl59E0712hf+cNIeW7ePEp+ZkTS653MGWopDOjNTxp0Uvt
	KG2Il/4eFMctRYAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753946262; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kmbLCMq1EwC5ZFQi619+FWDMNBXnYYxgR2C8x77E=;
	b=Dx0ZP54WXAoQsk0yPdZhSI6ofAUxfHLEYYT3/QrIUbgnLxfm6AI0u3LU+TvUfzoq3A2bxx
	2pJzUq7hftnD+pRgFw2eoMhIWWt1MIXUYhsBZaEQlYkdmYJG8fnNPGzFs2ZA2vP6CRVXPf
	rWnqN+FioPCb4ORR6rwdRxoUW7oZMIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753946262;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB0kmbLCMq1EwC5ZFQi619+FWDMNBXnYYxgR2C8x77E=;
	b=1O9v+dI6PL7Viloy5J9UNuMVXl59E0712hf+cNIeW7ePEp+ZkTS653MGWopDOjNTxp0Uvt
	KG2Il/4eFMctRYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E26C513A43;
	Thu, 31 Jul 2025 07:17:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EqppNZUYi2h7bQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 07:17:41 +0000
Date: Thu, 31 Jul 2025 09:17:41 +0200
Message-ID: <87seicsuay.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 2/3] LoongArch: Update HD-audio codec configs
In-Reply-To: <CAAhV-H5TC0jYbqu2M0CXEJ+80Svonrg8VHOF-ygb=ff7kWHX6g@mail.gmail.com>
References: <20250731064813.1622-1-tiwai@suse.de>
	<20250731064813.1622-3-tiwai@suse.de>
	<CAAhV-H5p6-oHtbbo_9P8oZJogZTxgeY2cmc0usuefZBmE-4buA@mail.gmail.com>
	<87wm7osurw.wl-tiwai@suse.de>
	<CAAhV-H5TC0jYbqu2M0CXEJ+80Svonrg8VHOF-ygb=ff7kWHX6g@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 31 Jul 2025 09:12:06 +0200,
Huacai Chen wrote:
> 
> On Thu, Jul 31, 2025 at 3:07 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Thu, 31 Jul 2025 09:05:04 +0200,
> > Huacai Chen wrote:
> > >
> > > Hi, Takashi,
> > >
> > > On Thu, Jul 31, 2025 at 2:49 PM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > The HD-audio codec driver configs have been updated again the drivers
> > > > got split with different kconfigs.  Add the missing items.
> > > >
> > > > Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
> > > > Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
> > > > Cc: loongarch@lists.linux.dev
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > I prefer to select all Realtek/HDMI codecs (except
> > > CONFIG_SND_HDA_CODEC_HDMI_NVIDIA_MCP and
> > > CONFIG_SND_HDA_CODEC_HDMI_TEGRA).
> >
> > OK, I'll refresh later.
> Also for the MIPS/loongson, thanks. :)

OK.

arch/mips/configs/loongson2k_defconfig has no selection of HDMI
codecs.  I don't need to select HDMI codec drivers there, right?


Takashi

