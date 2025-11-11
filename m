Return-Path: <linux-kernel+bounces-895488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F70C4E158
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 14:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 689493A9AA2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAE1331219;
	Tue, 11 Nov 2025 13:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKojIl+T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ICkSzmn1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zKojIl+T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ICkSzmn1"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906FA261B77
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867169; cv=none; b=CmawvHbFo/xkEH759yxbgim8Bu7zL9lPPlMqMHKxrogkk2DQfOz8xXdoCJTTHpJJtH8NIh93CaChy8BFr5tP450XlugMRGC2ZqVzDArL5jbM4eHk3TUHCEt9akt1GsHa49CRXBhB8TnVKGYEbaDJXs+HFn1sbuk+iTGhu2GKv9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867169; c=relaxed/simple;
	bh=mGi0PC2PNoIxcZfPSUswR7NA3rE1obD2j1G5qextpL0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToYEqRyRTFA52KMtgr9KOklszPPhybWR0dh6FpofA96oljjHsSArgdFg87NBxTUkwyKywfybgGhpniuUZWMDvTkqmASRrU+P1zPGWq8POxTQgWMZeHB5Nn2FDDO2+St/Rb/BaFP5SxTcUVFzeLt8Q7RGimK6E51pKjMbqMymwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKojIl+T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ICkSzmn1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zKojIl+T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ICkSzmn1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF11221A66;
	Tue, 11 Nov 2025 13:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762867164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4awXBCrj8KghMI3gehkngMqc3HhVAjLucvmCKFgfatc=;
	b=zKojIl+TV9mYGetOA7A2df+TVUaiu/sZqggp/0Z9JOORSnf2H6Of3R2Vh6LEs/3O5Etopi
	mPSq1jMv62Yhl7Q7zf4hWg+4/MxlVPqPApAtlFL3A4zXgFkhQXJGZL12xkkA1esLHM4OsO
	BUqdNKUb8JYYWLOspZIn4uDnZju2UMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762867164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4awXBCrj8KghMI3gehkngMqc3HhVAjLucvmCKFgfatc=;
	b=ICkSzmn1KQIdFeQ7AYF247f55keqQajez3Ejp+ydbwp9Y+jklfk0niEeuWQQLMndS7COQJ
	OsnPI72/1hgvXhBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762867164; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4awXBCrj8KghMI3gehkngMqc3HhVAjLucvmCKFgfatc=;
	b=zKojIl+TV9mYGetOA7A2df+TVUaiu/sZqggp/0Z9JOORSnf2H6Of3R2Vh6LEs/3O5Etopi
	mPSq1jMv62Yhl7Q7zf4hWg+4/MxlVPqPApAtlFL3A4zXgFkhQXJGZL12xkkA1esLHM4OsO
	BUqdNKUb8JYYWLOspZIn4uDnZju2UMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762867164;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4awXBCrj8KghMI3gehkngMqc3HhVAjLucvmCKFgfatc=;
	b=ICkSzmn1KQIdFeQ7AYF247f55keqQajez3Ejp+ydbwp9Y+jklfk0niEeuWQQLMndS7COQJ
	OsnPI72/1hgvXhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FEC914992;
	Tue, 11 Nov 2025 13:19:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c1mfItw3E2luVwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 11 Nov 2025 13:19:24 +0000
Date: Tue, 11 Nov 2025 14:19:16 +0100
Message-ID: <87zf8s1zcb.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Haein Lee <lhi0729@kaist.ac.kr>
Cc: Takashi Iwai <tiwai@suse.de>,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd
In-Reply-To: <vwh7h2qfic1x.vwh7h2qc6b88.g5@dooray.com>
References: <vwh35su1p1d2.vwh35stxlm3p.g6@dooray.com>
	<874ir03fc6.wl-tiwai@suse.de>
	<vwh7h2qfic1x.vwh7h2qc6b88.g5@dooray.com>
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
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Tue, 11 Nov 2025 14:14:21 +0100,
Haein Lee wrote:
> 
> Thank you for your quick response.
> 
> The problem is that `assoc` in snd_usb_create_streams() is a local variable. Even though it’s assigned in the NuForce UDH-100 case, its scope is limited to the function. As a result, when snd_usb_mixer_controls_badd() later assumes that assoc is valid, it actually isn’t.
> 
> I was able to reproduce this bug using syzkaller on my machine. I’ll attach the related materials — it’s basically triggered by sending a malicious USB device descriptor.
> 
> Personally, I’m not entirely satisfied with the patch, since it still leaves the case where usb_ifnum_to_if(dev, ctrlif)->intf_assoc is NULL even though the BADD profile is valid (as seen in the NuForce UDH-100 case). However, I believe this is the only remaining code of the issue, and adding a dedicated function just for this case would make the code unnecessarily complex.

OK, there can be cases slipping there, indeed, and we need checks in
the mixer side, too.

> Please correct me if I’m wrong. If we wrap up this discussion, I’ll send the patch in the proper format.

Please resubmit the patch and mention your finding.


thanks,

Takashi

> 
> Thanks,
> Haein Lee
> 
> -----Original Message-----
> From:  "Takashi Iwai" <tiwai@suse.de>
> To:     "Haein Lee" <lhi0729@kaist.ac.kr>; 
> Cc:      <perex@perex.cz>;   <tiwai@suse.com>;   <linux-sound@vger.kernel.org>;   <linux-kernel@vger.kernel.org>; 
> Sent:  2025-11-11 (화) 21:48:30 (UTC+09:00)
> Subject: Re: [PATCH] ALSA: usb-audio: Fix NULL pointer dereference in snd_usb_mixer_controls_badd
> 
> On Tue, 11 Nov 2025 13:35:13 +0100,
> Haein Lee wrote:
> > 
> > 
> > In snd_usb_create_streams(), for UAC version 3 devices, the Interface
> > Association Descriptor (IAD) is retrieved via usb_ifnum_to_if(). If this
> > call fails, a fallback routine attempts to obtain the IAD from the next
> > interface and sets a BADD profile. However, snd_usb_mixer_controls_badd()
> > assumes the IAD retrieved from usb_ifnum_to_if() is always valid without
> > performing a NULL check. This can lead to a NULL pointer dereference when
> > usb_ifnum_to_if() fails to find the interface descriptor.
> > 
> > This patch adds a NULL pointer check after calling usb_ifnum_to_if() in
> > snd_usb_mixer_controls_badd() to prevent the dereference.
> 
> Practically seen, this won't happen because the NULL intf_assoc is
> already checked at snd_usb_create_streams() as a fatal error before
> reaching this point.  But it would be still safer to have a sanity
> check here, too.
> 
> In anyway, the patch seems to have a bad format that can't be
> applied.  Tabs and spaces seem corrupted by your mailer.
> 
> Could you resubmit with a proper format (and add the information I
> mentioned in the above)?
> 
> 
> thanks,
> 
> Takashi
> 
> > ---
> >  sound/usb/mixer.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
> > index 6f00e0d52382..72b900505d2c 100644
> > --- a/sound/usb/mixer.c
> > +++ b/sound/usb/mixer.c
> > @@ -3086,6 +3086,8 @@ static int snd_usb_mixer_controls_badd(struct
> > usb_mixer_interface *mixer,
> >      int i;
> >  
> >      assoc = usb_ifnum_to_if(dev, ctrlif)->intf_assoc;
> > +    if (!assoc)
> > +        return -EINVAL;
> >  
> >      /* Detect BADD capture/playback channels from AS EP descriptors */
> >      for (i = 0; i < assoc->bInterfaceCount; i++) {
> > -- 
> > 2.34.1
> > 
> > [mail-r]
> > 
> usb 7-1: 0:4 : does not exist
> usb 7-1: 0:5 : does not exist
> usb 7-1: 0:6 : does not exist
> usb 7-1: 0:7 : does not exist
> usb 7-1: 0:8 : does not exist
> Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> CPU: 1 UID: 0 PID: 8953 Comm: kworker/1:4 Not tainted 6.17.0-rc2-00013-g5003a65790ed #38 PREEMPT(voluntary) 
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:snd_usb_mixer_controls_badd sound/usb/mixer.c:3078 [inline]
> RIP: 0010:snd_usb_create_mixer+0xa4a/0x1ab0 sound/usb/mixer.c:3602
> Code: 48 c1 e9 03 80 3c 11 00 0f 85 2d 0f 00 00 48 8b 40 18 48 8d 78 03 49 89 c7 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 19 0f 00 00
> RSP: 0018:ffffc90005abee90 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11003d23a03
> RDX: 0000000000000000 RSI: ffffffff849d60d1 RDI: 0000000000000003
> RBP: ffff888021596600 R08: 0000000000000000 R09: ffff88806b196ab0
> R10: 0000000000000000 R11: 00000000000630aa R12: ffff88801a8eaa18
> R13: 0000000000000000 R14: ffff88801a8eaa18 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880df204000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd87d8fd750 CR3: 000000001bdf9000 CR4: 0000000000750ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  usb_audio_probe+0x78d/0x3b00 sound/usb/card.c:986
>  usb_probe_interface+0x30b/0xa60 drivers/usb/core/driver.c:396
>  call_driver_probe drivers/base/dd.c:581 [inline]
>  really_probe+0x252/0xa90 drivers/base/dd.c:659
>  __driver_probe_device+0x1df/0x450 drivers/base/dd.c:801
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:831
>  __device_attach_driver+0x1db/0x2f0 drivers/base/dd.c:959
>  bus_for_each_drv+0x148/0x1d0 drivers/base/bus.c:462
>  __device_attach+0x1ee/0x4c0 drivers/base/dd.c:1031
>  bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>  device_add+0x1109/0x1a60 drivers/base/core.c:3689
>  usb_set_configuration+0x1194/0x1c40 drivers/usb/core/message.c:2210
>  usb_generic_driver_probe+0xb7/0x110 drivers/usb/core/generic.c:250
>  usb_probe_device+0xea/0x3e0 drivers/usb/core/driver.c:291
>  call_driver_probe drivers/base/dd.c:581 [inline]
>  really_probe+0x252/0xa90 drivers/base/dd.c:659
>  __driver_probe_device+0x1df/0x450 drivers/base/dd.c:801
>  driver_probe_device+0x4c/0x1a0 drivers/base/dd.c:831
>  __device_attach_driver+0x1db/0x2f0 drivers/base/dd.c:959
>  bus_for_each_drv+0x148/0x1d0 drivers/base/bus.c:462
>  __device_attach+0x1ee/0x4c0 drivers/base/dd.c:1031
>  bus_probe_device+0x17f/0x1c0 drivers/base/bus.c:537
>  device_add+0x1109/0x1a60 drivers/base/core.c:3689
>  usb_new_device+0xd2c/0x1aa0 drivers/usb/core/hub.c:2694
>  hub_port_connect drivers/usb/core/hub.c:5566 [inline]
>  hub_port_connect_change drivers/usb/core/hub.c:5706 [inline]
>  port_event drivers/usb/core/hub.c:5870 [inline]
>  hub_event+0x2d99/0x4e60 drivers/usb/core/hub.c:5952
>  process_one_work+0x98f/0x1b60 kernel/workqueue.c:3236
>  process_scheduled_works kernel/workqueue.c:3319 [inline]
>  worker_thread+0x67e/0xe90 kernel/workqueue.c:3400
>  kthread+0x3cd/0x780 kernel/kthread.c:463
>  ret_from_fork+0x5b3/0x6c0 arch/x86/kernel/process.c:148
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:snd_usb_mixer_controls_badd sound/usb/mixer.c:3078 [inline]
> RIP: 0010:snd_usb_create_mixer+0xa4a/0x1ab0 sound/usb/mixer.c:3602
> Code: 48 c1 e9 03 80 3c 11 00 0f 85 2d 0f 00 00 48 8b 40 18 48 8d 78 03 49 89 c7 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 48 89 fa 83 e2 07 38 d0 7f 08 84 c0 0f 85 19 0f 00 00
> RSP: 0018:ffffc90005abee90 EFLAGS: 00010246
> RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11003d23a03
> RDX: 0000000000000000 RSI: ffffffff849d60d1 RDI: 0000000000000003
> RBP: ffff888021596600 R08: 0000000000000000 R09: ffff88806b196ab0
> R10: 0000000000000000 R11: 00000000000630aa R12: ffff88801a8eaa18
> R13: 0000000000000000 R14: ffff88801a8eaa18 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff8880df204000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd87d8fd750 CR3: 000000001bdf9000 CR4: 0000000000750ef0
> PKRU: 55555554
> ----------------
> Code disassembly (best guess):
>    0:	48 c1 e9 03          	shr    $0x3,%rcx
>    4:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
>    8:	0f 85 2d 0f 00 00    	jne    0xf3b
>    e:	48 8b 40 18          	mov    0x18(%rax),%rax
>   12:	48 8d 78 03          	lea    0x3(%rax),%rdi
>   16:	49 89 c7             	mov    %rax,%r15
>   19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>   20:	fc ff df
>   23:	48 89 fa             	mov    %rdi,%rdx
>   26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
>   2e:	48 89 fa             	mov    %rdi,%rdx
>   31:	83 e2 07             	and    $0x7,%edx
>   34:	38 d0                	cmp    %dl,%al
>   36:	7f 08                	jg     0x40
>   38:	84 c0                	test   %al,%al
>   3a:	0f 85 19 0f 00 00    	jne    0xf59
> 
> <<<<<<<<<<<<<<< tail report >>>>>>>>>>>>>>>
> 
> # {Threaded:false Repeat:true RepeatTimes:0 Procs:1 Slowdown:1 Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false Cgroups:false BinfmtMisc:false CloseFDs:false KCSAN:false DevlinkPCI:false NicVF:false USB:false VhciInjection:false Wifi:false IEEE802154:false Sysctl:false Swap:false UseTmpDir:false HandleSegv:false Trace:false CallComments:true LegacyOptions:{Collide:false Fault:false FaultCall:0 FaultNth:0}}
> syz_usb_connect$uac1(0x4, 0x91, &(0x7f0000000000)=ANY=[@ANYBLOB="12010000010000104100410003000000000000007f00020109a001090400000001013000092401f7ff0a09000708240b040308750708240b0108012320090401000101023000072410080703000000000624400611050900082501ff0003d0030904020001010230000724100d06030600000006244003060f09058109c00001000008250102777c080000000000000000"], 0x0)
> syz_usb_connect$uac1(0x3, 0x81, &(0x7f0000000000)=ANY=[@ANYBLOB="12010003010000080000000040000102030109026f00020104608f090400000001013000092401040009090003090401"], &(0x7f0000000580)={0x0, 0x0, 0x0, 0x0})
> // autogenerated by syzkaller (https://github.com/google/syzkaller)
> 
> #define _GNU_SOURCE
> 
> #include <dirent.h>
> #include <endian.h>
> #include <errno.h>
> #include <fcntl.h>
> #include <signal.h>
> #include <stdarg.h>
> #include <stdbool.h>
> #include <stddef.h>
> #include <stdint.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <string.h>
> #include <sys/mount.h>
> #include <sys/prctl.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <sys/types.h>
> #include <sys/wait.h>
> #include <time.h>
> #include <unistd.h>
> 
> #include <linux/usb/ch9.h>
> 
> static unsigned long long procid;
> 
> static void sleep_ms(uint64_t ms)
> {
>   usleep(ms * 1000);
> }
> 
> static uint64_t current_time_ms(void)
> {
>   struct timespec ts;
>   if (clock_gettime(CLOCK_MONOTONIC, &ts))
>     exit(1);
>   return (uint64_t)ts.tv_sec * 1000 + (uint64_t)ts.tv_nsec / 1000000;
> }
> 
> static bool write_file(const char* file, const char* what, ...)
> {
>   char buf[1024];
>   va_list args;
>   va_start(args, what);
>   vsnprintf(buf, sizeof(buf), what, args);
>   va_end(args);
>   buf[sizeof(buf) - 1] = 0;
>   int len = strlen(buf);
>   int fd = open(file, O_WRONLY | O_CLOEXEC);
>   if (fd == -1)
>     return false;
>   if (write(fd, buf, len) != len) {
>     int err = errno;
>     close(fd);
>     errno = err;
>     return false;
>   }
>   close(fd);
>   return true;
> }
> 
> #define MAX_FDS 30
> 
> #define USB_MAX_IFACE_NUM 4
> #define USB_MAX_EP_NUM 32
> #define USB_MAX_FDS 6
> 
> struct usb_endpoint_index {
>   struct usb_endpoint_descriptor desc;
>   int handle;
> };
> 
> struct usb_iface_index {
>   struct usb_interface_descriptor* iface;
>   uint8_t bInterfaceNumber;
>   uint8_t bAlternateSetting;
>   uint8_t bInterfaceClass;
>   struct usb_endpoint_index eps[USB_MAX_EP_NUM];
>   int eps_num;
> };
> 
> struct usb_device_index {
>   struct usb_device_descriptor* dev;
>   struct usb_config_descriptor* config;
>   uint8_t bDeviceClass;
>   uint8_t bMaxPower;
>   int config_length;
>   struct usb_iface_index ifaces[USB_MAX_IFACE_NUM];
>   int ifaces_num;
>   int iface_cur;
> };
> 
> struct usb_info {
>   int fd;
>   struct usb_device_index index;
> };
> 
> static struct usb_info usb_devices[USB_MAX_FDS];
> 
> static struct usb_device_index* lookup_usb_index(int fd)
> {
>   for (int i = 0; i < USB_MAX_FDS; i++) {
>     if (__atomic_load_n(&usb_devices[i].fd, __ATOMIC_ACQUIRE) == fd)
>       return &usb_devices[i].index;
>   }
>   return NULL;
> }
> 
> static int usb_devices_num;
> 
> static bool parse_usb_descriptor(const char* buffer, size_t length,
>                                  struct usb_device_index* index)
> {
>   if (length < sizeof(*index->dev) + sizeof(*index->config))
>     return false;
>   memset(index, 0, sizeof(*index));
>   index->dev = (struct usb_device_descriptor*)buffer;
>   index->config = (struct usb_config_descriptor*)(buffer + sizeof(*index->dev));
>   index->bDeviceClass = index->dev->bDeviceClass;
>   index->bMaxPower = index->config->bMaxPower;
>   index->config_length = length - sizeof(*index->dev);
>   index->iface_cur = -1;
>   size_t offset = 0;
>   while (true) {
>     if (offset + 1 >= length)
>       break;
>     uint8_t desc_length = buffer[offset];
>     uint8_t desc_type = buffer[offset + 1];
>     if (desc_length <= 2)
>       break;
>     if (offset + desc_length > length)
>       break;
>     if (desc_type == USB_DT_INTERFACE &&
>         index->ifaces_num < USB_MAX_IFACE_NUM) {
>       struct usb_interface_descriptor* iface =
>           (struct usb_interface_descriptor*)(buffer + offset);
>       index->ifaces[index->ifaces_num].iface = iface;
>       index->ifaces[index->ifaces_num].bInterfaceNumber =
>           iface->bInterfaceNumber;
>       index->ifaces[index->ifaces_num].bAlternateSetting =
>           iface->bAlternateSetting;
>       index->ifaces[index->ifaces_num].bInterfaceClass = iface->bInterfaceClass;
>       index->ifaces_num++;
>     }
>     if (desc_type == USB_DT_ENDPOINT && index->ifaces_num > 0) {
>       struct usb_iface_index* iface = &index->ifaces[index->ifaces_num - 1];
>       if (iface->eps_num < USB_MAX_EP_NUM) {
>         memcpy(&iface->eps[iface->eps_num].desc, buffer + offset,
>                sizeof(iface->eps[iface->eps_num].desc));
>         iface->eps_num++;
>       }
>     }
>     offset += desc_length;
>   }
>   return true;
> }
> 
> static struct usb_device_index* add_usb_index(int fd, const char* dev,
>                                               size_t dev_len)
> {
>   int i = __atomic_fetch_add(&usb_devices_num, 1, __ATOMIC_RELAXED);
>   if (i >= USB_MAX_FDS)
>     return NULL;
>   if (!parse_usb_descriptor(dev, dev_len, &usb_devices[i].index))
>     return NULL;
>   __atomic_store_n(&usb_devices[i].fd, fd, __ATOMIC_RELEASE);
>   return &usb_devices[i].index;
> }
> 
> struct vusb_connect_string_descriptor {
>   uint32_t len;
>   char* str;
> } __attribute__((packed));
> 
> struct vusb_connect_descriptors {
>   uint32_t qual_len;
>   char* qual;
>   uint32_t bos_len;
>   char* bos;
>   uint32_t strs_len;
>   struct vusb_connect_string_descriptor strs[0];
> } __attribute__((packed));
> 
> static const char default_string[] = {8, USB_DT_STRING, 's', 0, 'y', 0, 'z', 0};
> 
> static const char default_lang_id[] = {4, USB_DT_STRING, 0x09, 0x04};
> 
> static bool
> lookup_connect_response_in(int fd, const struct vusb_connect_descriptors* descs,
>                            const struct usb_ctrlrequest* ctrl,
>                            struct usb_qualifier_descriptor* qual,
>                            char** response_data, uint32_t* response_length)
> {
>   struct usb_device_index* index = lookup_usb_index(fd);
>   uint8_t str_idx;
>   if (!index)
>     return false;
>   switch (ctrl->bRequestType & USB_TYPE_MASK) {
>   case USB_TYPE_STANDARD:
>     switch (ctrl->bRequest) {
>     case USB_REQ_GET_DESCRIPTOR:
>       switch (ctrl->wValue >> 8) {
>       case USB_DT_DEVICE:
>         *response_data = (char*)index->dev;
>         *response_length = sizeof(*index->dev);
>         return true;
>       case USB_DT_CONFIG:
>         *response_data = (char*)index->config;
>         *response_length = index->config_length;
>         return true;
>       case USB_DT_STRING:
>         str_idx = (uint8_t)ctrl->wValue;
>         if (descs && str_idx < descs->strs_len) {
>           *response_data = descs->strs[str_idx].str;
>           *response_length = descs->strs[str_idx].len;
>           return true;
>         }
>         if (str_idx == 0) {
>           *response_data = (char*)&default_lang_id[0];
>           *response_length = default_lang_id[0];
>           return true;
>         }
>         *response_data = (char*)&default_string[0];
>         *response_length = default_string[0];
>         return true;
>       case USB_DT_BOS:
>         *response_data = descs->bos;
>         *response_length = descs->bos_len;
>         return true;
>       case USB_DT_DEVICE_QUALIFIER:
>         if (!descs->qual) {
>           qual->bLength = sizeof(*qual);
>           qual->bDescriptorType = USB_DT_DEVICE_QUALIFIER;
>           qual->bcdUSB = index->dev->bcdUSB;
>           qual->bDeviceClass = index->dev->bDeviceClass;
>           qual->bDeviceSubClass = index->dev->bDeviceSubClass;
>           qual->bDeviceProtocol = index->dev->bDeviceProtocol;
>           qual->bMaxPacketSize0 = index->dev->bMaxPacketSize0;
>           qual->bNumConfigurations = index->dev->bNumConfigurations;
>           qual->bRESERVED = 0;
>           *response_data = (char*)qual;
>           *response_length = sizeof(*qual);
>           return true;
>         }
>         *response_data = descs->qual;
>         *response_length = descs->qual_len;
>         return true;
>       default:
>         break;
>       }
>       break;
>     default:
>       break;
>     }
>     break;
>   default:
>     break;
>   }
>   return false;
> }
> 
> typedef bool (*lookup_connect_out_response_t)(
>     int fd, const struct vusb_connect_descriptors* descs,
>     const struct usb_ctrlrequest* ctrl, bool* done);
> 
> static bool lookup_connect_response_out_generic(
>     int fd, const struct vusb_connect_descriptors* descs,
>     const struct usb_ctrlrequest* ctrl, bool* done)
> {
>   switch (ctrl->bRequestType & USB_TYPE_MASK) {
>   case USB_TYPE_STANDARD:
>     switch (ctrl->bRequest) {
>     case USB_REQ_SET_CONFIGURATION:
>       *done = true;
>       return true;
>     default:
>       break;
>     }
>     break;
>   }
>   return false;
> }
> 
> #define UDC_NAME_LENGTH_MAX 128
> 
> struct usb_raw_init {
>   __u8 driver_name[UDC_NAME_LENGTH_MAX];
>   __u8 device_name[UDC_NAME_LENGTH_MAX];
>   __u8 speed;
> };
> 
> enum usb_raw_event_type {
>   USB_RAW_EVENT_INVALID = 0,
>   USB_RAW_EVENT_CONNECT = 1,
>   USB_RAW_EVENT_CONTROL = 2,
> };
> 
> struct usb_raw_event {
>   __u32 type;
>   __u32 length;
>   __u8 data[0];
> };
> 
> struct usb_raw_ep_io {
>   __u16 ep;
>   __u16 flags;
>   __u32 length;
>   __u8 data[0];
> };
> 
> #define USB_RAW_EPS_NUM_MAX 30
> #define USB_RAW_EP_NAME_MAX 16
> #define USB_RAW_EP_ADDR_ANY 0xff
> 
> struct usb_raw_ep_caps {
>   __u32 type_control : 1;
>   __u32 type_iso : 1;
>   __u32 type_bulk : 1;
>   __u32 type_int : 1;
>   __u32 dir_in : 1;
>   __u32 dir_out : 1;
> };
> 
> struct usb_raw_ep_limits {
>   __u16 maxpacket_limit;
>   __u16 max_streams;
>   __u32 reserved;
> };
> 
> struct usb_raw_ep_info {
>   __u8 name[USB_RAW_EP_NAME_MAX];
>   __u32 addr;
>   struct usb_raw_ep_caps caps;
>   struct usb_raw_ep_limits limits;
> };
> 
> struct usb_raw_eps_info {
>   struct usb_raw_ep_info eps[USB_RAW_EPS_NUM_MAX];
> };
> 
> #define USB_RAW_IOCTL_INIT _IOW('U', 0, struct usb_raw_init)
> #define USB_RAW_IOCTL_RUN _IO('U', 1)
> #define USB_RAW_IOCTL_EVENT_FETCH _IOR('U', 2, struct usb_raw_event)
> #define USB_RAW_IOCTL_EP0_WRITE _IOW('U', 3, struct usb_raw_ep_io)
> #define USB_RAW_IOCTL_EP0_READ _IOWR('U', 4, struct usb_raw_ep_io)
> #define USB_RAW_IOCTL_EP_ENABLE _IOW('U', 5, struct usb_endpoint_descriptor)
> #define USB_RAW_IOCTL_EP_DISABLE _IOW('U', 6, __u32)
> #define USB_RAW_IOCTL_EP_WRITE _IOW('U', 7, struct usb_raw_ep_io)
> #define USB_RAW_IOCTL_EP_READ _IOWR('U', 8, struct usb_raw_ep_io)
> #define USB_RAW_IOCTL_CONFIGURE _IO('U', 9)
> #define USB_RAW_IOCTL_VBUS_DRAW _IOW('U', 10, __u32)
> #define USB_RAW_IOCTL_EPS_INFO _IOR('U', 11, struct usb_raw_eps_info)
> #define USB_RAW_IOCTL_EP0_STALL _IO('U', 12)
> #define USB_RAW_IOCTL_EP_SET_HALT _IOW('U', 13, __u32)
> #define USB_RAW_IOCTL_EP_CLEAR_HALT _IOW('U', 14, __u32)
> #define USB_RAW_IOCTL_EP_SET_WEDGE _IOW('U', 15, __u32)
> 
> static int usb_raw_open()
> {
>   return open("/dev/raw-gadget", O_RDWR);
> }
> 
> static int usb_raw_init(int fd, uint32_t speed, const char* driver,
>                         const char* device)
> {
>   struct usb_raw_init arg;
>   strncpy((char*)&arg.driver_name[0], driver, sizeof(arg.driver_name));
>   strncpy((char*)&arg.device_name[0], device, sizeof(arg.device_name));
>   arg.speed = speed;
>   return ioctl(fd, USB_RAW_IOCTL_INIT, &arg);
> }
> 
> static int usb_raw_run(int fd)
> {
>   return ioctl(fd, USB_RAW_IOCTL_RUN, 0);
> }
> 
> static int usb_raw_configure(int fd)
> {
>   return ioctl(fd, USB_RAW_IOCTL_CONFIGURE, 0);
> }
> 
> static int usb_raw_vbus_draw(int fd, uint32_t power)
> {
>   return ioctl(fd, USB_RAW_IOCTL_VBUS_DRAW, power);
> }
> 
> static int usb_raw_ep0_write(int fd, struct usb_raw_ep_io* io)
> {
>   return ioctl(fd, USB_RAW_IOCTL_EP0_WRITE, io);
> }
> 
> static int usb_raw_ep0_read(int fd, struct usb_raw_ep_io* io)
> {
>   return ioctl(fd, USB_RAW_IOCTL_EP0_READ, io);
> }
> 
> static int usb_raw_event_fetch(int fd, struct usb_raw_event* event)
> {
>   return ioctl(fd, USB_RAW_IOCTL_EVENT_FETCH, event);
> }
> 
> static int usb_raw_ep_enable(int fd, struct usb_endpoint_descriptor* desc)
> {
>   return ioctl(fd, USB_RAW_IOCTL_EP_ENABLE, desc);
> }
> 
> static int usb_raw_ep_disable(int fd, int ep)
> {
>   return ioctl(fd, USB_RAW_IOCTL_EP_DISABLE, ep);
> }
> 
> static int usb_raw_ep0_stall(int fd)
> {
>   return ioctl(fd, USB_RAW_IOCTL_EP0_STALL, 0);
> }
> 
> #define USB_MAX_PACKET_SIZE 4096
> 
> struct usb_raw_control_event {
>   struct usb_raw_event inner;
>   struct usb_ctrlrequest ctrl;
>   char data[USB_MAX_PACKET_SIZE];
> };
> 
> struct usb_raw_ep_io_data {
>   struct usb_raw_ep_io inner;
>   char data[USB_MAX_PACKET_SIZE];
> };
> 
> static void set_interface(int fd, int n)
> {
>   struct usb_device_index* index = lookup_usb_index(fd);
>   if (!index)
>     return;
>   if (index->iface_cur >= 0 && index->iface_cur < index->ifaces_num) {
>     for (int ep = 0; ep < index->ifaces[index->iface_cur].eps_num; ep++) {
>       int rv = usb_raw_ep_disable(
>           fd, index->ifaces[index->iface_cur].eps[ep].handle);
>       if (rv < 0) {
>       } else {
>       }
>     }
>   }
>   if (n >= 0 && n < index->ifaces_num) {
>     for (int ep = 0; ep < index->ifaces[n].eps_num; ep++) {
>       int rv = usb_raw_ep_enable(fd, &index->ifaces[n].eps[ep].desc);
>       if (rv < 0) {
>       } else {
>         index->ifaces[n].eps[ep].handle = rv;
>       }
>     }
>     index->iface_cur = n;
>   }
> }
> 
> static int configure_device(int fd)
> {
>   struct usb_device_index* index = lookup_usb_index(fd);
>   if (!index)
>     return -1;
>   int rv = usb_raw_vbus_draw(fd, index->bMaxPower);
>   if (rv < 0) {
>     return rv;
>   }
>   rv = usb_raw_configure(fd);
>   if (rv < 0) {
>     return rv;
>   }
>   set_interface(fd, 0);
>   return 0;
> }
> 
> static volatile long
> syz_usb_connect_impl(uint64_t speed, uint64_t dev_len, const char* dev,
>                      const struct vusb_connect_descriptors* descs,
>                      lookup_connect_out_response_t lookup_connect_response_out)
> {
>   if (!dev) {
>     return -1;
>   }
>   int fd = usb_raw_open();
>   if (fd < 0) {
>     return fd;
>   }
>   if (fd >= MAX_FDS) {
>     close(fd);
>     return -1;
>   }
>   struct usb_device_index* index = add_usb_index(fd, dev, dev_len);
>   if (!index) {
>     return -1;
>   }
>   char device[32];
>   sprintf(&device[0], "dummy_udc.%llu", procid);
>   int rv = usb_raw_init(fd, speed, "dummy_udc", &device[0]);
>   if (rv < 0) {
>     return rv;
>   }
>   rv = usb_raw_run(fd);
>   if (rv < 0) {
>     return rv;
>   }
>   bool done = false;
>   while (!done) {
>     struct usb_raw_control_event event;
>     event.inner.type = 0;
>     event.inner.length = sizeof(event.ctrl);
>     rv = usb_raw_event_fetch(fd, (struct usb_raw_event*)&event);
>     if (rv < 0) {
>       return rv;
>     }
>     if (event.inner.type != USB_RAW_EVENT_CONTROL)
>       continue;
>     char* response_data = NULL;
>     uint32_t response_length = 0;
>     struct usb_qualifier_descriptor qual;
>     if (event.ctrl.bRequestType & USB_DIR_IN) {
>       if (!lookup_connect_response_in(fd, descs, &event.ctrl, &qual,
>                                       &response_data, &response_length)) {
>         usb_raw_ep0_stall(fd);
>         continue;
>       }
>     } else {
>       if (!lookup_connect_response_out(fd, descs, &event.ctrl, &done)) {
>         usb_raw_ep0_stall(fd);
>         continue;
>       }
>       response_data = NULL;
>       response_length = event.ctrl.wLength;
>     }
>     if ((event.ctrl.bRequestType & USB_TYPE_MASK) == USB_TYPE_STANDARD &&
>         event.ctrl.bRequest == USB_REQ_SET_CONFIGURATION) {
>       rv = configure_device(fd);
>       if (rv < 0) {
>         return rv;
>       }
>     }
>     struct usb_raw_ep_io_data response;
>     response.inner.ep = 0;
>     response.inner.flags = 0;
>     if (response_length > sizeof(response.data))
>       response_length = 0;
>     if (event.ctrl.wLength < response_length)
>       response_length = event.ctrl.wLength;
>     response.inner.length = response_length;
>     if (response_data)
>       memcpy(&response.data[0], response_data, response_length);
>     else
>       memset(&response.data[0], 0, response_length);
>     if (event.ctrl.bRequestType & USB_DIR_IN) {
>       rv = usb_raw_ep0_write(fd, (struct usb_raw_ep_io*)&response);
>     } else {
>       rv = usb_raw_ep0_read(fd, (struct usb_raw_ep_io*)&response);
>     }
>     if (rv < 0) {
>       return rv;
>     }
>   }
>   sleep_ms(200);
>   return fd;
> }
> 
> static volatile long syz_usb_connect(volatile long a0, volatile long a1,
>                                      volatile long a2, volatile long a3)
> {
>   uint64_t speed = a0;
>   uint64_t dev_len = a1;
>   const char* dev = (const char*)a2;
>   const struct vusb_connect_descriptors* descs =
>       (const struct vusb_connect_descriptors*)a3;
>   return syz_usb_connect_impl(speed, dev_len, dev, descs,
>                               &lookup_connect_response_out_generic);
> }
> 
> static void kill_and_wait(int pid, int* status)
> {
>   kill(-pid, SIGKILL);
>   kill(pid, SIGKILL);
>   for (int i = 0; i < 100; i++) {
>     if (waitpid(-1, status, WNOHANG | __WALL) == pid)
>       return;
>     usleep(1000);
>   }
>   DIR* dir = opendir("/sys/fs/fuse/connections");
>   if (dir) {
>     for (;;) {
>       struct dirent* ent = readdir(dir);
>       if (!ent)
>         break;
>       if (strcmp(ent->d_name, ".") == 0 || strcmp(ent->d_name, "..") == 0)
>         continue;
>       char abort[300];
>       snprintf(abort, sizeof(abort), "/sys/fs/fuse/connections/%s/abort",
>                ent->d_name);
>       int fd = open(abort, O_WRONLY);
>       if (fd == -1) {
>         continue;
>       }
>       if (write(fd, abort, 1) < 0) {
>       }
>       close(fd);
>     }
>     closedir(dir);
>   } else {
>   }
>   while (waitpid(-1, status, __WALL) != pid) {
>   }
> }
> 
> static void setup_test()
> {
>   prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0);
>   setpgrp();
>   write_file("/proc/self/oom_score_adj", "1000");
> }
> 
> static void execute_one(void);
> 
> #define WAIT_FLAGS __WALL
> 
> static void loop(void)
> {
>   int iter = 0;
>   for (;; iter++) {
>     int pid = fork();
>     if (pid < 0)
>       exit(1);
>     if (pid == 0) {
>       setup_test();
>       execute_one();
>       exit(0);
>     }
>     int status = 0;
>     uint64_t start = current_time_ms();
>     for (;;) {
>       sleep_ms(10);
>       if (waitpid(-1, &status, WNOHANG | WAIT_FLAGS) == pid)
>         break;
>       if (current_time_ms() - start < 5000)
>         continue;
>       kill_and_wait(pid, &status);
>       break;
>     }
>   }
> }
> 
> void execute_one(void)
> {
>   if (write(1, "executing program\n", sizeof("executing program\n") - 1)) {
>   }
>   //  syz_usb_connect$uac3 arguments: [
>   //    speed: usb_device_speed = 0x4 (8 bytes)
>   //    dev_len: len = 0x91 (8 bytes)
>   //    dev: ptr[inout, array[ANYUNION]] {
>   //      array[ANYUNION] {
>   //        union ANYUNION {
>   //          ANYBLOB: buffer: {12 01 00 00 01 00 00 10 41 00 41 00 03 00 00 00
>   //          00 00 00 00 7f 00 02 01 09 a0 01 09 04 00 00 00 01 01 30 00 09 24
>   //          01 f7 ff 0a 09 00 07 08 24 0b 04 03 08 75 07 08 24 0b 01 08 01 23
>   //          20 09 04 01 00 01 01 02 30 00 07 24 10 08 07 03 00 00 00 00 06 24
>   //          40 06 11 05 09 00 08 25 01 ff 00 03 d0 03 09 04 02 00 01 01 02 30
>   //          00 07 24 10 0d 06 03 06 00 00 00 06 24 40 03 06 0f 09 05 81 09 c0
>   //          00 01 00 00 08 25 01 02 77 7c 08 00 00 00 00 00 00 00 00} (length
>   //          0x91)
>   //        }
>   //      }
>   //    }
>   //    conn_descs: nil
>   //  ]
>   //  returns fd_usb_uac3
>   memcpy((void*)0x200000000000,
>          "\x12\x01\x00\x00\x01\x00\x00\x10\x41\x00\x41\x00\x03\x00\x00\x00\x00"
>          "\x00\x00\x00\x7f\x00\x02\x01\x09\xa0\x01\x09\x04\x00\x00\x00\x01\x01"
>          "\x30\x00\x09\x24\x01\xf7\xff\x0a\x09\x00\x07\x08\x24\x0b\x04\x03\x08"
>          "\x75\x07\x08\x24\x0b\x01\x08\x01\x23\x20\x09\x04\x01\x00\x01\x01\x02"
>          "\x30\x00\x07\x24\x10\x08\x07\x03\x00\x00\x00\x00\x06\x24\x40\x06\x11"
>          "\x05\x09\x00\x08\x25\x01\xff\x00\x03\xd0\x03\x09\x04\x02\x00\x01\x01"
>          "\x02\x30\x00\x07\x24\x10\x0d\x06\x03\x06\x00\x00\x00\x06\x24\x40\x03"
>          "\x06\x0f\x09\x05\x81\x09\xc0\x00\x01\x00\x00\x08\x25\x01\x02\x77\x7c"
>          "\x08\x00\x00\x00\x00\x00\x00\x00\x00",
>          145);
>   syz_usb_connect(/*speed=USB_SPEED_WIRELESS*/ 4, /*dev_len=*/0x91,
>                   /*dev=*/0x200000000000, /*conn_descs=*/0);
>   //  syz_usb_connect$uac3 arguments: [
>   //    speed: usb_device_speed = 0x3 (8 bytes)
>   //    dev_len: len = 0x81 (8 bytes)
>   //    dev: ptr[inout, array[ANYUNION]] {
>   //      array[ANYUNION] {
>   //        union ANYUNION {
>   //          ANYBLOB: buffer: {12 01 00 03 01 00 00 08 00 00 00 00 40 00 01 02
>   //          03 01 09 02 6f 00 02 01 04 60 8f 09 04 00 00 00 01 01 30 00 09 24
>   //          01 04 00 09 09 00 03 09 04 01} (length 0x30)
>   //        }
>   //      }
>   //    }
>   //    conn_descs: ptr[in, vusb_connect_descriptors] {
>   //      vusb_connect_descriptors {
>   //        qual_len: len = 0x0 (4 bytes)
>   //        qual: nil
>   //        bos_len: len = 0x0 (4 bytes)
>   //        bos: nil
>   //        strs_len: len = 0x0 (4 bytes)
>   //        strs: array[vusb_connect_string_descriptor] {
>   //        }
>   //      }
>   //    }
>   //  ]
>   //  returns fd_usb_uac3
>   memcpy((void*)0x200000000000,
>          "\x12\x01\x00\x03\x01\x00\x00\x08\x00\x00\x00\x00\x40\x00\x01\x02\x03"
>          "\x01\x09\x02\x6f\x00\x02\x01\x04\x60\x8f\x09\x04\x00\x00\x00\x01\x01"
>          "\x30\x00\x09\x24\x01\x04\x00\x09\x09\x00\x03\x09\x04\x01",
>          48);
>   *(uint32_t*)0x200000000580 = 0;
>   *(uint64_t*)0x200000000584 = 0;
>   *(uint32_t*)0x20000000058c = 0;
>   *(uint64_t*)0x200000000590 = 0;
>   *(uint32_t*)0x200000000598 = 0;
>   syz_usb_connect(/*speed=USB_SPEED_HIGH*/ 3, /*dev_len=*/0x81,
>                   /*dev=*/0x200000000000, /*conn_descs=*/0x200000000580);
> }
> int main(void)
> {
>   syscall(__NR_mmap, /*addr=*/0x1ffffffff000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
>           /*fd=*/(intptr_t)-1, /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x200000000000ul, /*len=*/0x1000000ul,
>           /*prot=PROT_WRITE|PROT_READ|PROT_EXEC*/ 7ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
>           /*fd=*/(intptr_t)-1, /*offset=*/0ul);
>   syscall(__NR_mmap, /*addr=*/0x200001000000ul, /*len=*/0x1000ul, /*prot=*/0ul,
>           /*flags=MAP_FIXED|MAP_ANONYMOUS|MAP_PRIVATE*/ 0x32ul,
>           /*fd=*/(intptr_t)-1, /*offset=*/0ul);
>   const char* reason;
>   (void)reason;
>   loop();
>   return 0;
> }
> 

