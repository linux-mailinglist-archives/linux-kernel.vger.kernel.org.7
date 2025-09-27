Return-Path: <linux-kernel+bounces-834956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC04ABA5E8C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665963AC081
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676F2E093B;
	Sat, 27 Sep 2025 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ikph7uHd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="B0Gd+6rQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mgKnZQBq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FI8Ea9qU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E0B2E041A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758973978; cv=none; b=cM1rKjSLyRXZXqQXiAzBPFiExhnGDwqAtI/z0ksl1x123fk2j73etUjQJGzka2nRaQ1zzejnH2lthMeO6apb3+DW+KaULIgGbxj37zcc/leZOBArSBwd0yY++vWG82DktatoWHw89MkP4McXlSira3/ccP1red8Vc6z5fdqFuhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758973978; c=relaxed/simple;
	bh=3Qh5rLSTawxJRSctDgGgAJWu6GbOYmKl1Kvx15urDEs=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=POM5ocRGnzHvmpJHXvmFL4MOcOWM/Qn5aqv0q3MmA24AxbPQP+0DM7bICTT2zlrdvQHGdWCLWAG06TvH0GebD5sbK9/noWmZI8gQuwT17F1zf+5bj3D2YyoobAvffORu8zhj+m4lAdMR16vAvjkawksuj3Z6NMlODDdsC8aQr90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ikph7uHd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=B0Gd+6rQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mgKnZQBq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FI8Ea9qU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EED9937223;
	Sat, 27 Sep 2025 11:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758973975; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIIe7BVxo3nW2jr+S7icNHFFH4p89eeOK8EoRY7eKmE=;
	b=Ikph7uHdCEhi1Jb8+n70qo6WQ/DrKs0Xgj3mQps9aiF7Yexb8XgTswaT35Lt8o/BSGghZq
	Gv+9oDTSsfG5/RoKpPMTt0/X61bxoknt/TyuoqlLdPlGCMOgRUghki35tMjgJh7IuU2Tb/
	KWzRRzMLylxMmYJ3MtOgZyRcS6PV79c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758973975;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIIe7BVxo3nW2jr+S7icNHFFH4p89eeOK8EoRY7eKmE=;
	b=B0Gd+6rQXjdJimQ7J7D7FDwKV0bfRORWG/0PnddfjMcTu/QtjT6xHJmgXPuGLeZL3vBxy+
	qRtxeT9rBDF9joBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mgKnZQBq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FI8Ea9qU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758973973; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIIe7BVxo3nW2jr+S7icNHFFH4p89eeOK8EoRY7eKmE=;
	b=mgKnZQBqqJj69doxHHE6UiJh5fYSjld4tnFhc28PuG9dELEsLs8w7PVQDLq5nfQM9ex0Sb
	gKipVWE30pZXmfGD99EAK+KZl2zD1bilY10RsTSF0CWt+wS7vtGQb91/fyBiiP2gTWhrSs
	K3bNleS9T28wgovh9/jp4ZmJR5ZqMXI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758973973;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VIIe7BVxo3nW2jr+S7icNHFFH4p89eeOK8EoRY7eKmE=;
	b=FI8Ea9qUeTJnwik8RVitAtUIsCIvSgiHl+EVsFuXO5fuwwZdjOniIqnJod+EFHdFTUAeMg
	d9F9D56Z9q40RdAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A84021373E;
	Sat, 27 Sep 2025 11:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RB9VJxXQ12gOcgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 11:52:53 +0000
Date: Sat, 27 Sep 2025 13:52:53 +0200
Message-ID: <87o6qw9koa.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jeongjun Park <aha310510@gmail.com>
Cc: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>,
	clemens@ladisch.de,
	hdanton@sina.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.de
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
In-Reply-To: <CAO9qdTGH5eMQTesCKVjLU7-kMg4uGC_6DGxP+YOP63yp=07HdQ@mail.gmail.com>
References: <20250927091931.7691-1-hdanton@sina.com>
	<68d7b657.a70a0220.10c4b.000e.GAE@google.com>
	<CAO9qdTGH5eMQTesCKVjLU7-kMg4uGC_6DGxP+YOP63yp=07HdQ@mail.gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: EED9937223
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[syzkaller.appspotmail.com,ladisch.de,sina.com,vger.kernel.org,perex.cz,googlegroups.com,suse.de];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[f02665daa2abeef4a947];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -2.01

On Sat, 27 Sep 2025 12:36:07 +0200,
Jeongjun Park wrote:
> 
> syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > KASAN: slab-use-after-free Write in snd_usbmidi_in_urb_complete
> >
> > ==================================================================
> > BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x389/0x3c0 sound/usb/midi.c:251
> > Write of size 1 at addr ffff888074717943 by task kworker/1:3/5866
> >
> 
> Wow, the UAF bug still occurs?
> 
> But... this UAF seems to be a problem with how midi handles urb rather
> than a problem with my patch.
> 
> Is there something wrong with the way snd_usbmidi_in_urb_complete() is
> implemented?

This can be rather a missing kill-and-cleanup in the code path.
So the patch like below.

Could you check whether this works for you instead of your fix, too?
timer_shutdown_sync() is already called in snd_usbmidi_disconnect(),
and the call in snd_usbmidi_free() should be superfluous after this
change.


thanks,

Takashi

--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,6 +1522,9 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	if (!umidi->disconnected)
+		snd_usbmidi_disconnect(&umidi->list);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)

