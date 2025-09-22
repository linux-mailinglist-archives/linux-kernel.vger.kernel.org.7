Return-Path: <linux-kernel+bounces-827379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCA7B9195B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18700424887
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D419AD5C;
	Mon, 22 Sep 2025 14:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5GskFl7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y3Ervkkc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="T5GskFl7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y3Ervkkc"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5879D1AF0A7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550072; cv=none; b=iKUbhyaAw2DuU1QkO7zTvqBZmlLW42NUtX65JcbndhODXX2gEINC7RjMMgjCh/9Yu/FbIDWMUIH3+AX/8YEo4D0ZLUYwGpKL/v3HGxCufYm8UrY7IwRZlG6MljMRxiFy6bMy4wt+bjFqjsr7eO7dZsJGmApKaMCNq6q6SqXVe9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550072; c=relaxed/simple;
	bh=WqYi7C7rPVPMchWD3Tm/mWLYvFm7Ms2J7l9sot1F8V4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jpKIP7QqFUB10+3buvFJZRkr8xaFOXAgRh3m7jbK0AbK0LU8/kZHsviliewIcm/XAd0+WfQNmOxpXZoxIJlY9Fz5GEmimK6QD4iyjgqoSHKZ0FN/pkEF1mkKWWiDkUd8l1+9zVwZkOdF1ALyN8LjXTD7SZJLeFebOvCraK+Vxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5GskFl7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y3Ervkkc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=T5GskFl7; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y3Ervkkc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 680DC21E89;
	Mon, 22 Sep 2025 14:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758550068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGHYx5pOu3PjDgbMOcAjQn1OWUKG2IfHDuHiMX4Epn0=;
	b=T5GskFl792iJc+ydo0xeGMBXRXGfst8/vFHPYscSYhHlez9L6VIXv4u5ksxRo7NCINOPS6
	O9hwvd2neeDeHkQL0Mm22lxRxo8LNKkHJFN6tHizuVRYCGRDgGHhUeL3Pnk6hEddK2N/vv
	8oSsO75GD7Vbc6CLC2OAdg+k8wtA7mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758550068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGHYx5pOu3PjDgbMOcAjQn1OWUKG2IfHDuHiMX4Epn0=;
	b=Y3Ervkkc+c9IT/VS6vwPm5mlkV2ozDDrvGYH/D6b8hVfg7X5tbWNBshBrUr3WhSWnn/XfJ
	Iv0KCW+WAC45UzCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=T5GskFl7;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Y3Ervkkc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758550068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGHYx5pOu3PjDgbMOcAjQn1OWUKG2IfHDuHiMX4Epn0=;
	b=T5GskFl792iJc+ydo0xeGMBXRXGfst8/vFHPYscSYhHlez9L6VIXv4u5ksxRo7NCINOPS6
	O9hwvd2neeDeHkQL0Mm22lxRxo8LNKkHJFN6tHizuVRYCGRDgGHhUeL3Pnk6hEddK2N/vv
	8oSsO75GD7Vbc6CLC2OAdg+k8wtA7mM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758550068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGHYx5pOu3PjDgbMOcAjQn1OWUKG2IfHDuHiMX4Epn0=;
	b=Y3Ervkkc+c9IT/VS6vwPm5mlkV2ozDDrvGYH/D6b8hVfg7X5tbWNBshBrUr3WhSWnn/XfJ
	Iv0KCW+WAC45UzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 200F713A78;
	Mon, 22 Sep 2025 14:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8KZ8BjRY0WhCCQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 22 Sep 2025 14:07:48 +0000
Date: Mon, 22 Sep 2025 16:07:47 +0200
Message-ID: <87zfammvgs.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
	Linux PM <linux-pm@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Zhang Qilong <zhangqilong3@huawei.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/3] PM: runtime: Add auto-cleanup macros for "resume and get" operations
In-Reply-To: <CAJZ5v0iwNuFxiu3x3-fWO9dkLUq_=c3H=G2OgFmPfVguw0U4Sw@mail.gmail.com>
References: <6204724.lOV4Wx5bFT@rafael.j.wysocki>
	<3388279.44csPzL39Z@rafael.j.wysocki>
	<875xdaevab.wl-tiwai@suse.de>
	<CAJZ5v0hSBDg4fD7Gy6yEX31xO-3USJG_jFps71BRJJ2f0Oh90A@mail.gmail.com>
	<87348eobnv.wl-tiwai@suse.de>
	<CAJZ5v0iwNuFxiu3x3-fWO9dkLUq_=c3H=G2OgFmPfVguw0U4Sw@mail.gmail.com>
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
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 680DC21E89
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	TO_DN_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51

On Mon, 22 Sep 2025 15:44:51 +0200,
Rafael J. Wysocki wrote:
> 
> On Mon, Sep 22, 2025 at 3:32 PM Takashi Iwai <tiwai@suse.de> wrote:
> >
> > On Mon, 22 Sep 2025 14:50:32 +0200,
> > Rafael J. Wysocki wrote:
> > >
> > > On Mon, Sep 22, 2025 at 10:38 AM Takashi Iwai <tiwai@suse.de> wrote:
> > > >
> > > > On Sat, 20 Sep 2025 12:54:58 +0200,
> > > > Rafael J. Wysocki wrote:
> > > > >
> > > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > >
> > > > > It is generally useful to be able to automatically drop a device's
> > > > > runtime PM usage counter incremented by runtime PM operations that
> > > > > resume a device and bump up its usage counter [1].
> > > > >
> > > > > To that end, add DEFINE_CLASS() macros allowing pm_runtime_put()
> > > > > and pm_runtime_put_autosuspend() to be used for the auto-cleanup in
> > > > > those cases.
> > > > >
> > > > > Simply put, a piece of code like below:
> > > > >
> > > > >       pm_runtime_get_sync(dev);
> > > > >       .....
> > > > >       pm_runtime_put(dev);
> > > > >       return 0;
> > > > >
> > > > > can be transformed with CLASS() like:
> > > > >
> > > > >       CLASS(pm_runtime_get_active, pm)(dev);
> > > > >       if (IS_ERR(pm))
> > > > >               return PTR_ERR(pm);
> > > > >       .....
> > > > >       return 0;
> > > > >
> > > > > (note the new resume error handling).
> > > >
> > > > Do we still allow the code without the error check even using CLASS()?
> > > > Although the error check should be handled, it's not mandatory for
> > > > now.  That said, the above example could be still in a form like:
> > > >
> > > >         CLASS(pm_runtime_get_active, pm)(dev);
> > > >         .....
> > > >         return 0;
> > > >
> > > > while adding the proper error check is recommended?
> > >
> > > I'd rather not encourage doing this.
> > >
> > > While it may still produce working code in some cases, one needs to
> > > remember that in case of a runtime resume error it will be running
> > > without a runtime PM reference it has attempted to acquire.
> >
> > Fair enough.  Then it'd be also good to mention that in the
> > description, too.
> 
> I can also add classes for the cases in which resume errors can be
> neglected, like these:
> 
> DEFINE_CLASS(pm_runtime_get_sync, struct device *,
>          if (_T) pm_runtime_put(_T),
>          ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> 
> DEFINE_CLASS(pm_runtime_get_sync_auto, struct device *,
>          if (_T) pm_runtime_put_autosuspend(_T),
>          ({ pm_runtime_get_sync(dev); dev; }), struct device *dev)
> 
> with a comment explaining what they are for.

It might be helpful, indeed, since the error handling isn't always
straightforward, and this still allows us to convert to the
auto-cleanup safely.  It's still worth to mention that those aren't
recommended options, though.


thanks,

Takashi

