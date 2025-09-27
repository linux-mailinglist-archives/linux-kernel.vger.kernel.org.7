Return-Path: <linux-kernel+bounces-834957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A23BA5E8F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791631B25F94
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 11:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26A22DF715;
	Sat, 27 Sep 2025 11:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzVOS7Vy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GXxnk8Ff";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OzVOS7Vy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GXxnk8Ff"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23C726F2BD
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 11:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758974023; cv=none; b=E/1YeD9bM8HQMSu8kNALso5TerV84irJ70kMmZqlstUqndwSwf46+DTQOeXh4Gxmz+Bpiahf9kQKsQnDe+23xarThby1YVvZz/FZL/mTSGPrQgGihaYd5A4+ozjWmo1wYx/1yPWR5H2iPQrI3gOSbDk4RyNT8y6Jd4IBxB1ZsGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758974023; c=relaxed/simple;
	bh=S3VwGeESsbU0786/XY4agdoEZgKCpJ+QyNWOw3juBJQ=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=py4RsWWrNgdlvN+x7I3kQoA3QcwInQPyhX70vmJF651H2h6UrB/Ym9ME49YJpW7Im0P+/NQqSvGTe5atcUM+4pUpi9fao/Toxj3fTeEvc0FJSHUEUkrjma9gLMnOucuzXniQGrWiji450gav5pJ1CuHt6EcwZNOk3wDIddB32yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzVOS7Vy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GXxnk8Ff; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OzVOS7Vy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GXxnk8Ff; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D551134467;
	Sat, 27 Sep 2025 11:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758974018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30ejNt9RdKAgdOITpIbk0cl0d+4zggGIYg7Mcb87jfk=;
	b=OzVOS7VyGWf4HQ6SlQXTRny09VCzDZoo0T9hJ13sN9oc4BmiHiFimdVFZ9yXtzSGaWYXsu
	XF1Rzap2YrIUZzK7yxwZmEGp7tPzj9Bo5mAJFRIB7QjkU0W7RZ19qc0EdL2wFP01035FTg
	Oii6pbquUqgT7cnT9928DoKHl6WaiOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758974018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30ejNt9RdKAgdOITpIbk0cl0d+4zggGIYg7Mcb87jfk=;
	b=GXxnk8FfvLRAfV4Wuaf9ZNgE0pKECdL1YPoXiZtQJJb2QVXXdK3trVkZI40lhp3EfFgoRc
	vMo2JkZSJ+Nnq6DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758974018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30ejNt9RdKAgdOITpIbk0cl0d+4zggGIYg7Mcb87jfk=;
	b=OzVOS7VyGWf4HQ6SlQXTRny09VCzDZoo0T9hJ13sN9oc4BmiHiFimdVFZ9yXtzSGaWYXsu
	XF1Rzap2YrIUZzK7yxwZmEGp7tPzj9Bo5mAJFRIB7QjkU0W7RZ19qc0EdL2wFP01035FTg
	Oii6pbquUqgT7cnT9928DoKHl6WaiOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758974018;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=30ejNt9RdKAgdOITpIbk0cl0d+4zggGIYg7Mcb87jfk=;
	b=GXxnk8FfvLRAfV4Wuaf9ZNgE0pKECdL1YPoXiZtQJJb2QVXXdK3trVkZI40lhp3EfFgoRc
	vMo2JkZSJ+Nnq6DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 950661373E;
	Sat, 27 Sep 2025 11:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6HgMI0LQ12hGcgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 27 Sep 2025 11:53:38 +0000
Date: Sat, 27 Sep 2025 13:53:38 +0200
Message-ID: <87ms6g9kn1.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>
Cc: aha310510@gmail.com,
	clemens@ladisch.de,
	hdanton@sina.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzkaller-bugs@googlegroups.com,
	tiwai@suse.de
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
In-Reply-To: <68d7c285.050a0220.25d7ab.030b.GAE@google.com>
References: <87tt0o9ojm.wl-tiwai@suse.de>
	<68d7c285.050a0220.25d7ab.030b.GAE@google.com>
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,sina.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,ladisch.de,sina.com,vger.kernel.org,perex.cz,googlegroups.com,suse.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid];
	TAGGED_RCPT(0.00)[f02665daa2abeef4a947];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -1.80

On Sat, 27 Sep 2025 12:55:01 +0200,
syzbot wrote:
> 
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> KASAN: slab-use-after-free Read in snd_usbmidi_in_urb_complete

Another try.

#syz test upstream master

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

