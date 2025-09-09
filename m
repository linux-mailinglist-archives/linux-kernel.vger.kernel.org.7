Return-Path: <linux-kernel+bounces-807285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C686AB4A287
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 830DD446DD6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC36D3043B2;
	Tue,  9 Sep 2025 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cfo+f3oe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fOu2OQhD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKJkMxhV";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="G9SrgBRr"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72289303A24
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757400233; cv=none; b=fOWLR/Y/0FiPVLlL7SDCBj9JL/oHxFBEuWv0Q2Vmp/xr1VqQxsRz3eSl8ylZirG65trrmS8LMaveUgCwLbzwnMTF6jkxiPxjhapordKq5WWJ+KIToGI38l4spCUpuo0s88MsA2K/MNT/OdVbrxF2IYvbbiwxNg1dftHke9OfXgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757400233; c=relaxed/simple;
	bh=RCW5GgCArVSwPic7glqYC7RlTKSqQK8WdmS+A/Xg6rk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sZxLURuAGhRzzT8UIRN7fj7qnBGCI5ryyaxpWuGYM1qpGBi7C7nibVpVFjpq0C7Bu5SWuyFwXibxlpxTq9NZZIOq/L01gV1hCmS1x2Q/WHZSTiuHud7qvaYpz0BsEiFK7zUMhXjAJNiF6Hw1Vo+Dhk6ytWXir+8zDRQ5YNHFCEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cfo+f3oe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=fOu2OQhD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKJkMxhV; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=G9SrgBRr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B636E20395;
	Tue,  9 Sep 2025 06:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757400222; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv9rmhdL0uNXK3cxzdO4tHRw+ROK7mOEB36x9Me9aq8=;
	b=cfo+f3oecUouQ0KpQpEYlBA+qvvM+4RXBYZWKAMcl5dVBnthBqad3LiltENna7TfHyAi9t
	23npTRN621x0COFSDVQYZ5d4Hvm2BFVgLtgXqHCJKBW8VNdcJn2SxpcNVAJXEiXlHRqr3I
	nglpNrhZqbQR8OPVCsZfs7fVQ4HjFTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757400222;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv9rmhdL0uNXK3cxzdO4tHRw+ROK7mOEB36x9Me9aq8=;
	b=fOu2OQhDBImqqKc3sWvwXYtWxuDYmQfFKBmwY1QQV+fKw9AwXatlCLMmC8c5iBl8+UUpYC
	stnfGGTjixrm21Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1757400221; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv9rmhdL0uNXK3cxzdO4tHRw+ROK7mOEB36x9Me9aq8=;
	b=zKJkMxhVPb/f5q4ETbALAoFXWY39YJkcaulAOOAGinGnNHonPCiGtr4+GGSAxiNvVNEZ9d
	PcbraGBKU56lthg1FnAk8kqd8pAvpeF6nz5zVwTmZs2XPvGsOE/4R+UwQ/FEt1ghopn+8U
	Mfg8Ut98YtGpmIl+tf19Wr0hldnS1Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1757400221;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mv9rmhdL0uNXK3cxzdO4tHRw+ROK7mOEB36x9Me9aq8=;
	b=G9SrgBRrpo48ggyq2wAOhnOLmwjJivBbHWSOnmmLOyEWMCfH/bDyeIWpvaoreRdSnHagZT
	wFk+g/rPpGUiqPBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 304431388C;
	Tue,  9 Sep 2025 06:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /nTWCZ3Mv2jjVQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 09 Sep 2025 06:43:41 +0000
Date: Tue, 09 Sep 2025 08:43:40 +0200
Message-ID: <87ecsgxh0j.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Cc: "Xu, Baojun" <baojun.xu@ti.com>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13916275206@139.com" <13916275206@139.com>,
	"alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
	"Ding, Shenghao" <shenghao-ding@ti.com>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"Yi, Ken" <k-yi@ti.com>,
	"Lo, Henry" <henry.lo@ti.com>,
	"Chen, Robin" <robinchen@ti.com>,
	"Ji, Jesse" <jesse-ji@ti.com>,
	"Wang, Will" <will-wang@ti.com>,
	"jim.shil@goertek.com" <jim.shil@goertek.com>,
	"toastcheng@google.com" <toastcheng@google.com>,
	"chinkaiting@google.com" <chinkaiting@google.com>
Subject: Re: [EXTERNAL] Re: [PATCH v4 1/2] ASoC: tas2781: Add tas2118, tas2x20, tas5825 support
In-Reply-To: <071e0e04-e2cb-480d-8207-f6ba87cb56b5@sirena.org.uk>
References: <20250830061459.24371-1-baojun.xu@ti.com>
	<993d7fe7-5206-45a9-acb6-0d610a3a2136@sirena.org.uk>
	<12aa63e694c94213aeb6b48959d02b45@ti.com>
	<b70314db-357f-4c39-a9b4-088d8ebed2b0@sirena.org.uk>
	<67fafc23d16d4790821321643a87385f@ti.com>
	<071e0e04-e2cb-480d-8207-f6ba87cb56b5@sirena.org.uk>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[139.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_RCPT(0.00)[dt];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[ti.com,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,gmail.com,kernel.org,goertek.com,google.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Mon, 08 Sep 2025 19:10:28 +0200,
Mark Brown wrote:
> 
> On Mon, Sep 08, 2025 at 06:22:51AM +0000, Xu, Baojun wrote:
> 
> > > > Or need to create patches on tree broonie/linux.git?
> 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-6.18
> 
> > This patch is also relative (shares the same include/sound/tas5825-tlv.h)
> > with another commit on next/linux-next.git:
> > https://patch.msgid.link/20250810122358.1575-1-baojun.xu@ti.com (ALSA: hda: Add TAS5825 support)
> > However, it was not merged into broonie/sound.git yet, should I wait for it?
> 
> OK, it's probably easiest to just apply these directly to Takashi's
> tree:
> 
> Acked-by: Mark Brown <broonie@kernel.org>

OK, applied both patches now to for-next branch.


thanks,

Takashi

