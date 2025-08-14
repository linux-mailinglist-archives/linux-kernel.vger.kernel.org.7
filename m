Return-Path: <linux-kernel+bounces-768008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B8BB25BCC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 732C53B2F8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F9824BBFD;
	Thu, 14 Aug 2025 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L63H6Aof";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1tnHSWb1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="L63H6Aof";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1tnHSWb1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763AB1F5827
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153144; cv=none; b=sAmtQnfvWMoralc4PaEdReQFwObK8ECSufDhCMrr6Ygp7hrDvro/5tug2phn1pIl+bc1TjYiMJwQpdomQAbBRNXGzYTHDDENs3uCz6XJrVIQRL+JSmN0LUkwhHFNtwsSOq5FPCvElA340gWOyJtCcYDE0SUaB88Dln6kr9sHO3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153144; c=relaxed/simple;
	bh=+DYOQY+uj3RU1MSHwNncwHTuKO2M7KAOhucF4nWc1PI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Px7qcmcAyBgAfmvawSzbf1nBH405nD2UCtAx+l8vyqeT4vL7qVkYhl08TSDI9u5fKyjhrEt/Fh0q5xyUiN/Y75Y9TexLzWEiTMpzU4/y0hgTdkg/mz9w2b7RXkn+f4jd2Onuambm3LFl+mWsIw7kBu8Cygu3zk9GjKPwfxZ2aq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L63H6Aof; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1tnHSWb1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=L63H6Aof; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1tnHSWb1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7782221AAE;
	Thu, 14 Aug 2025 06:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755153139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xu1qadWxTr+MAFIsiwJyhQ9AGjmxViERwRno/GWs84I=;
	b=L63H6AofurlzUFOb40yQoY3BvDHVDIZWuMbpXpui3p2PcXL1W+b4efTodOwYr2QDYEOcDK
	XzabqqwtIvAGF027+9uy/2O4d+SQ7kqMCQV1Sj80dl/DqgcXU6mPnj4uD4kRlDJxipyYnw
	MMCKZ79zgkrhb+EPlQSEx88WiCp4v98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755153139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xu1qadWxTr+MAFIsiwJyhQ9AGjmxViERwRno/GWs84I=;
	b=1tnHSWb1P0LkSBsunlgjf0dLxz6IrXOT8TWVIjPdN6i06myyxKiGj/I7TBWxJfk/j4JnG0
	T4ROxIScLysISTAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=L63H6Aof;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1tnHSWb1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755153139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xu1qadWxTr+MAFIsiwJyhQ9AGjmxViERwRno/GWs84I=;
	b=L63H6AofurlzUFOb40yQoY3BvDHVDIZWuMbpXpui3p2PcXL1W+b4efTodOwYr2QDYEOcDK
	XzabqqwtIvAGF027+9uy/2O4d+SQ7kqMCQV1Sj80dl/DqgcXU6mPnj4uD4kRlDJxipyYnw
	MMCKZ79zgkrhb+EPlQSEx88WiCp4v98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755153139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xu1qadWxTr+MAFIsiwJyhQ9AGjmxViERwRno/GWs84I=;
	b=1tnHSWb1P0LkSBsunlgjf0dLxz6IrXOT8TWVIjPdN6i06myyxKiGj/I7TBWxJfk/j4JnG0
	T4ROxIScLysISTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D97B1368C;
	Thu, 14 Aug 2025 06:32:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Il8YDfOCnWivbAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 14 Aug 2025 06:32:19 +0000
Date: Thu, 14 Aug 2025 08:32:18 +0200
Message-ID: <871ppewgzx.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Xu, Baojun" <baojun.xu@ti.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao"
	<shenghao-ding@ti.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Normalize the volume kcontrol name
In-Reply-To: <417f8e1c8a314ae4a77070f313d8af2c@ti.com>
References: <20250813100842.12224-1-baojun.xu@ti.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,alsa-project.org,ti.com,139.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7782221AAE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Thu, 14 Aug 2025 04:29:10 +0200,
Xu, Baojun wrote:
> 
> Hi,
> 
> Answer in line.
> 
> > ________________________________________
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: 13 August 2025 23:44
> > To: Xu, Baojun
> > Cc: broonie@kernel.org; andriy.shevchenko@linux.intel.com; alsa-devel@alsa-project.org; Ding, Shenghao; 13916275206@139.com; linux-sound@vger.kernel.org; linux-kernel@vger.kernel.org
> > Subject: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Normalize the volume kcontrol name
> > 
> > On Wed, 13 Aug 2025 12:08:42 +0200,
> > Baojun Xu wrote:
> > >
> > > Change the name of the kcontrol from "Gain" to "Volume".
> > 
> > Could you describe "why this change is needed"?
> > 
> This name is in kcontrol, which is open to users.
> Volume is more normalized and common.
> Gain is a more professional term in smart amplifiers.

But did you realize that changing the control name may change the
user-space behavior completely?
e.g. alsa-lib implementation tries to group control elements per
prefix and suffix, and "Volume" is one of the standard suffix.
That is, with this change, it'll appear as "Speaker Analog" as a mixer
element name where the former name is "Speaker Analog Gain".

I'm not against the proposed rename.  But please remember that control
names aren't something you can change easily because you don't feel
good; it's a thing to be more or less "fixed" once after defined in
the release products.


thanks,

Takashi

> 
> > 
> > thanks,
> > 
> > Takashi
> > 
> > >
> > > Signed-off-by: Baojun Xu <baojun.xu@ti.com>
> > > ---
> >>  sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> > > index 92aae19cfc8f..e4bc3bc756b0 100644
> > > --- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> > > +++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
> > > @@ -256,7 +256,7 @@ static const struct snd_kcontrol_new tas2770_snd_controls[] = {
> > >  };
> > >
> > >  static const struct snd_kcontrol_new tas2781_snd_controls[] = {
> > > -     ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Gain", TAS2781_AMP_LEVEL,
> > > +     ACARD_SINGLE_RANGE_EXT_TLV("Speaker Analog Volume", TAS2781_AMP_LEVEL,
> > >               1, 0, 20, 0, tas2781_amp_getvol,
> >>               tas2781_amp_putvol, amp_vol_tlv),
> > >       ACARD_SINGLE_BOOL_EXT("Speaker Force Firmware Load", 0,
> > > --
> > > 2.43.0
> > >
> > 
> > 
> 
> Best Regards
> Jim

