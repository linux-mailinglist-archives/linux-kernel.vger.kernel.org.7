Return-Path: <linux-kernel+bounces-779427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 258D4B2F3F1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:30:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F9917B5768
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4342B2D6E75;
	Thu, 21 Aug 2025 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0d9yE5Cq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="li2XxLbt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0d9yE5Cq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="li2XxLbt"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4711C69D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 09:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768645; cv=none; b=qbAlh2hGJ9kcQ4HZQgg+XrG8Wg012kstvdl6ulk8gNdkuipMx+sCJ83k8++3ZLociShrrh6tady4mJiO1bsHzsgY7HITeOgt1/AbKVc9iZoz2iVsHnP/8h9ZPrnL+E3RJM1XDhQcxEfmUAuEyA6erk2g5gWjjo3TInYS4TexZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768645; c=relaxed/simple;
	bh=SJ4YW3Ea2q45XCUNkHVpMntDMPBiHzmCLeelC1nqS54=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bv5AEfdZUkeZzCiGNemrEEQo6btTLVWRj423J1NGlVCfFJq2lgfPL/PwWX+J/W0VmPE6ojsbLzQcIRt0EtTkil7Rf3+EFmv10PPNLnaJStoqo6PlTzZ5lKtPRVVmEWCBfVQbgLU3a+BKv/DFcXpcqrh0pqUNmzqvzW6tQeQZ4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0d9yE5Cq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=li2XxLbt; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0d9yE5Cq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=li2XxLbt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7E3A21F38C;
	Thu, 21 Aug 2025 09:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755768639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hbyz8wtHEYy0Ae85OaDqxH7p8zTasJ948wOCcSpwgi8=;
	b=0d9yE5Cqv1hav8mNmuUknQe0tHr8L4hkHo06Zdkq7hdzLb+HZBZqQ67G+ibruiMuX00VxR
	hG0PYPjP9W5mgXMh+BUeL8gY5YW6Q2Aty1gLS9JK2ID9oHtKv/R0pM3g2shxY6jczibrLy
	M8kV3PRYq+MtH4heutHyK7AQuDU0YVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755768639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hbyz8wtHEYy0Ae85OaDqxH7p8zTasJ948wOCcSpwgi8=;
	b=li2XxLbtrxxODjBBd3auPfGlTAy0YpKkueYXtur2KaDQYq2Dn35iCmZKXjLua0oq27tdFG
	8lCkwSBB7V0Zw/AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1755768639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hbyz8wtHEYy0Ae85OaDqxH7p8zTasJ948wOCcSpwgi8=;
	b=0d9yE5Cqv1hav8mNmuUknQe0tHr8L4hkHo06Zdkq7hdzLb+HZBZqQ67G+ibruiMuX00VxR
	hG0PYPjP9W5mgXMh+BUeL8gY5YW6Q2Aty1gLS9JK2ID9oHtKv/R0pM3g2shxY6jczibrLy
	M8kV3PRYq+MtH4heutHyK7AQuDU0YVo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1755768639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hbyz8wtHEYy0Ae85OaDqxH7p8zTasJ948wOCcSpwgi8=;
	b=li2XxLbtrxxODjBBd3auPfGlTAy0YpKkueYXtur2KaDQYq2Dn35iCmZKXjLua0oq27tdFG
	8lCkwSBB7V0Zw/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 35AF9139A8;
	Thu, 21 Aug 2025 09:30:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sLTHCz/npmgyJwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 21 Aug 2025 09:30:39 +0000
Date: Thu, 21 Aug 2025 11:30:38 +0200
Message-ID: <87349l6myp.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Ding, Shenghao" <shenghao-ding@ti.com>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
	"andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
	"13564923607@139.com" <13564923607@139.com>,
	"13916275206@139.com"
	<13916275206@139.com>,
	"alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>,
	"linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
	"Xu, Baojun" <baojun.xu@ti.com>,
	"Baojun.Xu@fpt.com" <Baojun.Xu@fpt.com>,
	"Ji, Jesse" <jesse-ji@ti.com>
Subject: Re: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Enable init_profile_id for device initialization
In-Reply-To: <203d0937f1974417ac64b4ed6a6f2e69@ti.com>
References: <20250820082123.1125-1-shenghao-ding@ti.com>
	<87cy8p6t4t.wl-tiwai@suse.de>
	<203d0937f1974417ac64b4ed6a6f2e69@ti.com>
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
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	REDIRECTOR_URL(0.00)[proofpoint.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,139.com,alsa-project.org,vger.kernel.org,ti.com,fpt.com];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,intel.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -3.30

On Thu, 21 Aug 2025 11:01:45 +0200,
Ding, Shenghao wrote:
> 
> > -----Original Message-----
> > From: Takashi Iwai <tiwai@suse.de>
> > Sent: Thursday, August 21, 2025 3:17 PM
> > To: Ding, Shenghao <shenghao-ding@ti.com>
> > Cc: broonie@kernel.org; andriy.shevchenko@linux.intel.com;
> > 13564923607@139.com; 13916275206@139.com; alsa-devel@alsa-
> > project.org; linux-kernel@vger.kernel.org; Xu, Baojun <baojun.xu@ti.com>;
> > Baojun.Xu@fpt.com; Ji, Jesse <jesse-ji@ti.com>
> > Subject: [EXTERNAL] Re: [PATCH v1] ALSA: hda/tas2781: Enable
> > init_profile_id for device initialization
> > 
> > On Wed, 20 Aug 2025 10: 21: 23 +0200, Shenghao Ding wrote: > > Optimize
> > the time consumption of profile switching, init_profile saves > the common
> > settings of different profiles, such as the dsp coefficients, > etc, which can
> > greatly ZjQcmQRYFpfptBannerStart This message was sent from outside of
> > Texas Instruments.
> > Do not click links or open attachments unless you recognize the source of
> > this email and know the content is safe.
> > <https://us-phishalarm-
> > ewt.proofpoint.com/EWT/v1/G3vK!vxdrHf3mV2Ub4obsvxtoX4FTV-yYd_C-
> > 6ngQtFeUFpCRaEESj8_B-sZXmuX5JN2I2u4Qx-lD$>
> > Report Suspicious
> > 
> > ZjQcmQRYFpfptBannerEnd
> > On Wed, 20 Aug 2025 10:21:23 +0200,
> > Shenghao Ding wrote:
> > >
> > > Optimize the time consumption of profile switching, init_profile saves
> > > the common settings of different profiles, such as the dsp
> > > coefficients, etc, which can greatly reduce the profile switching time
> > > comsumption and remove the repetitive settings.
> > >
> ..............................
> > The patch causes build errors:
> > 
> > sound/hda/codecs/side-codecs/tas2781_hda_i2c.c: In function
> > ʽtasdevice_dspfw_initʼ:
> > sound/hda/codecs/side-codecs/tas2781_hda_i2c.c:468:29: error: ʽstruct
> > tasdevice_rcaʼ has no member named ʽinit_profile_idʼ
> >   468 |         if (tas_priv->rcabin.init_profile_id >= 0)
> >       |                             ^
> > ....
> > 
> > Something still not landed in my tree yet.
> I will resubmit it after your tree is ready.

So it's currently only in ASoC tree?
Then maybe it's easier to put Mark's tree instead.

In that case, feel free to take my ack:
Acked-by: Takashi Iwai <tiwai@suse.de>

But, the current situation of TAS driver support is messy, a part of
changes are found in my tree while another part in Mark's tree
individually...


thanks,

Takashi

