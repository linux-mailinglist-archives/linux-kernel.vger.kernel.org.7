Return-Path: <linux-kernel+bounces-794985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247A1B3EB6B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B681746DB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A02D5927;
	Mon,  1 Sep 2025 15:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UeWZDLx/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xvhN9kqq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UeWZDLx/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xvhN9kqq"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD3023D7C5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741561; cv=none; b=rk8KRY9L7MEwfmc+Z16OpYpSwxS8sSMKXVp5s0yVKEWtFNke25Kz9xkYujW6/eNpoRTYw9KYYghBV6TH7/TPuqyDiGch3mcauu3hcRRj8XDIViMF2JXZ/BhN7KbqkH0EMniA4IHOZXyl3Jfd2gLm7flraawnsVssMXFaIhb17wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741561; c=relaxed/simple;
	bh=yIIBpx1WiLYWLBRyT3VoexsH+O30nR5EJg4j5RtIhkE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEFVhM2vD9hfonztS9BQ/bmrzhwqz68C+8JIDB9bAAK1y9VbKHdJUddtmwuyKzCcfnnajmtKR2f6MHKavsSYZ/SouOAA8vUoYmnRUyCiVef8C4wX9vxqcAEcqeadX9uk6QFlJTNdUmg4z0n3Lp1kgV2J3kPnvMI1y9mUVYkj6B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UeWZDLx/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xvhN9kqq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UeWZDLx/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xvhN9kqq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8B4A61F388;
	Mon,  1 Sep 2025 15:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756741557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8E5oFHeOOl9JH2Nl796U5+RxzjChoh6gygsoYjlDhs=;
	b=UeWZDLx/aZwUy4sRs6VZ1BFp7F8r0oHwH8T0U5OTBoOxKIjHhwK4r1QmNtbuEFDn7Ho2VN
	f9mm4G0hrxdMqEuoUZMqHSOi/ZzQNQDwJCgCduMskRA/DDWcRJLEcqe7asF1sJB+P3vt6V
	bcs44kkkSQ7A83wJF1UWAUUj7xIpD7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756741557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8E5oFHeOOl9JH2Nl796U5+RxzjChoh6gygsoYjlDhs=;
	b=xvhN9kqqVb0THbvD9XWAZfFEYhaeIkSC6oJvQjHjp6fQmbDNgocSj9tMArOgiKUC1SgFXp
	i1L9W3LrwEimSFDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="UeWZDLx/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xvhN9kqq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1756741557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8E5oFHeOOl9JH2Nl796U5+RxzjChoh6gygsoYjlDhs=;
	b=UeWZDLx/aZwUy4sRs6VZ1BFp7F8r0oHwH8T0U5OTBoOxKIjHhwK4r1QmNtbuEFDn7Ho2VN
	f9mm4G0hrxdMqEuoUZMqHSOi/ZzQNQDwJCgCduMskRA/DDWcRJLEcqe7asF1sJB+P3vt6V
	bcs44kkkSQ7A83wJF1UWAUUj7xIpD7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1756741557;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8E5oFHeOOl9JH2Nl796U5+RxzjChoh6gygsoYjlDhs=;
	b=xvhN9kqqVb0THbvD9XWAZfFEYhaeIkSC6oJvQjHjp6fQmbDNgocSj9tMArOgiKUC1SgFXp
	i1L9W3LrwEimSFDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B5BB1378C;
	Mon,  1 Sep 2025 15:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X6VCDbW/tWhRaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 01 Sep 2025 15:45:57 +0000
Date: Mon, 01 Sep 2025 17:45:56 +0200
Message-ID: <87h5xm5g7f.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Cryolitia PukNgae <cryolitia@uniontech.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Nie Cheng <niecheng1@uniontech.com>,
	Zhan Jun <zhanjun@uniontech.com>,
	Feng Yuan <fengyuan@uniontech.com>,
	qaqland <anguoli@uniontech.com>
Subject: Re: [RFC] sound: usb: design for quirk 'mixer_min_mute'
In-Reply-To: <C22C1A172EBB9BD9+eccc2e4a-d21e-4a7d-848c-bbf3982feb94@uniontech.com>
References: <C22C1A172EBB9BD9+eccc2e4a-d21e-4a7d-848c-bbf3982feb94@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 8B4A61F388
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.51

On Fri, 29 Aug 2025 11:29:22 +0200,
Cryolitia PukNgae wrote:
> 
> We are discussig about the problem that, on some devices the lowest
> playback value represents muted state instead of minimum audible volume.
> In the previous discussion, we have shown that this problem is widespread
> across a wide range of hardware[1][2]. And we have already added a bit for
> it[1].
> 
> Firstly, we need to discuss about how to design a module param for it. As
> it is needed to debug the device for end users instead of ignoring
> hardware mixer and using soft mixer only in pipewire, which has already
> written in Arch Linux wiki[3], as an imperfect workaround.
> 
> Inspired by Takashi Iwai[4], I would like to design a module param named
> `quirk_names`, to be passed like
> `1234:abcd:mixer_min_mute,4567:efef:ignore_ctl_error`, so that we can
> apply one or more quirk on a specific USB device.

I suppose this will turn on each quirk bit?  We may want to turn *off*
the quirk bit, too, e.g. extend the syntax with '!' marker
`1234:abcd:!mixer_min_mute`.

Also, allowing multiple quirk bits by numbers would be also handy,
e.g. `1234:abcd:003f`.  So, if the last part represents a hex number,
it's treated as the quirk bits.

One more thing would be to allow a wildcard to the device matching,
e.g. `*:*:mixer_min_mute`.

An open question is whether we may want yet a new module option or
rather extend the existing quirk option to accept the strings
instead.  Basically, when the given argument has a colon, it's a new
syntax.  If it's only a number, it's an old syntax, and parse like
before.  But, I'm open for either way (a new option or extend the
existing one).

> And the already existed
> param `ignore_ctl_error` could be deleted, because of included in the
> one.

Dropping an existing option isn't so easy.  It can break users who
already applied it for long time.  So, unless it's really conflicting
and does harmful, I'd rather keep the old option as is.

> >    /* lowest playback value is muted on some devices */
> >    if (mixer->chip->quirk_flags & QUIRK_FLAG_MIXER_MIN_MUTE)
> >        if (strstr(kctl->id.name, "Playback"))
> >            cval->min_mute = 1;
> 
> Secondly, all efforts so far is only for the Playback. But we have found
> some devices have the same problem on the Capture. So for the problem
> that the lowest playback value represents muted state instead of minimum 
> udible volume:
> 
>   1. On some devices we already tested, only happens on their Playback,
>      but their Capture works perfectly. Or they are just a simple
>      earphone without audio input.
>   2. On some devices we already tested, have the problem both on Playback
>      and Capture.
>   3. Maybe on some devices we havn't found yet, have the problem only on
>      Capture but not Playback.
> 
> How could we deal with them? Would two quirk bit seems a little waste?

It's a good question.  My gut feeling so far is to make another quirk
bit for the capture, but we may find some compromised solution, too.
> 
> Thirdly, the most complex situation. We found a device: `3302:12db
> MOONDROP Quark2` , that its volume control has a range 0-120, but acts to
> mute when less than 8. I have no idea about how to deal with it simplly.
> We are actively contacting the manufacturer and informing them of this
> matter.

If that kind of behavior becomes common, we can add a common quirk bit.
Until then, it's handled as an own fix.


thanks,

Takashi

