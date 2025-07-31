Return-Path: <linux-kernel+bounces-751697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7E2B16C66
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8AF3B6C25
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D8828D8E2;
	Thu, 31 Jul 2025 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KNBxcR72";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BnrtRR9A";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f5gWOCfV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LI1AM2Ir"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038D23E25B
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945656; cv=none; b=EGFHEYvb8G6cBlSFpZYEoGeT2tQkTBLILSTcJ0TsR6vwq/arZLn1SwGIUeIdcHzR6JFhgj27GXnvNoQ2kHew1NQgUozz9BQw7pGZdhLAXeVMYqBZy9aiefBKvP8e0l3VzhkBi3s64rZ4HmgBN3ul7iq20yh0e37AaabgXOejlRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945656; c=relaxed/simple;
	bh=uNq5YgNWC0JduXOh89NmVinXt2YvLYn3fmm+cayt4Wo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b721hVnkujGB1/z8bsifoJ5bv25d2HmD6FKZRgMAHEhfc45Xdd62bTMvCnRv+Xbtg7fsOmzM9mQe8xXGVTozDukDIJdlpJ/gb8FfBTq2GwtnG8hFBdwH3Q9iUYyYbkSHTh/vH0L+CJ8/QKqKOcsdg6aMOTo0GPsHFzBQI010Y1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KNBxcR72; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BnrtRR9A; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f5gWOCfV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LI1AM2Ir; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0CAE91F7B6;
	Thu, 31 Jul 2025 07:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753945653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR8gPKVMmGmjKuJD//CRj8pwhfAE0au4XA9ioUJkw9A=;
	b=KNBxcR72/9N/pl313LwY5ykJukeyL3vxyvzQxpUW+o2dvqlRNCYd9E0V9HofK5FO4Zvrb0
	wFyLPvonR2loGBUjpUJ82Miu1mEwwsyv3LU/O9opiHr7L8oev8QRImwI4Ne07UmKGXt98J
	OkJm8lVpaRTs4b+95wpaFYdkKkSrpgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753945653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR8gPKVMmGmjKuJD//CRj8pwhfAE0au4XA9ioUJkw9A=;
	b=BnrtRR9AdbvIit/B0EtI7fE04/V8k3n5tQefmlcNK21S2XCSvc3w901FPiLjBxH/BBxa03
	YY9HASI3lvu1QDAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1753945652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR8gPKVMmGmjKuJD//CRj8pwhfAE0au4XA9ioUJkw9A=;
	b=f5gWOCfV8yLrwTeAPNCzg1grb9Qc6pPQwmCXomDgB/o08BYrjBY7EN/1ALmh5wg3PktoMN
	Czk3niNqNxYvnpy8ypbnYN7pQ3BT/AxeY7ZksxnY0meP0AChOZuiU4SKQG2mZ86hZySqpu
	3mwpk8HJsZTh0sjQwYn9MqKpL1AFgwM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1753945652;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WR8gPKVMmGmjKuJD//CRj8pwhfAE0au4XA9ioUJkw9A=;
	b=LI1AM2IrSCagHvMVIVsbMdWAMdvdQ23SwbaZYCIj5xVQ4ocVAlLtnlLJM+g4j7FvL7roe/
	qxeuc7uIfoHIayDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5E9A13876;
	Thu, 31 Jul 2025 07:07:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GG2iMjMWi2hLagAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 31 Jul 2025 07:07:31 +0000
Date: Thu, 31 Jul 2025 09:07:31 +0200
Message-ID: <87wm7osurw.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: Re: [PATCH 2/3] LoongArch: Update HD-audio codec configs
In-Reply-To: <CAAhV-H5p6-oHtbbo_9P8oZJogZTxgeY2cmc0usuefZBmE-4buA@mail.gmail.com>
References: <20250731064813.1622-1-tiwai@suse.de>
	<20250731064813.1622-3-tiwai@suse.de>
	<CAAhV-H5p6-oHtbbo_9P8oZJogZTxgeY2cmc0usuefZBmE-4buA@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 31 Jul 2025 09:05:04 +0200,
Huacai Chen wrote:
> 
> Hi, Takashi,
> 
> On Thu, Jul 31, 2025 at 2:49 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > The HD-audio codec driver configs have been updated again the drivers
> > got split with different kconfigs.  Add the missing items.
> >
> > Fixes: 1d8dd982c409 ("ALSA: hda/realtek: Enable drivers as default")
> > Fixes: 81231ad173d8 ("ALSA: hda/hdmi: Enable drivers as default")
> > Cc: loongarch@lists.linux.dev
> > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> I prefer to select all Realtek/HDMI codecs (except
> CONFIG_SND_HDA_CODEC_HDMI_NVIDIA_MCP and
> CONFIG_SND_HDA_CODEC_HDMI_TEGRA).

OK, I'll refresh later.


thanks,

Takashi

