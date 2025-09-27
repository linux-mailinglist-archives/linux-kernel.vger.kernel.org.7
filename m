Return-Path: <linux-kernel+bounces-835023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55F0BA6109
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 17:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5712317C8A5
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D662E2DDD;
	Sat, 27 Sep 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZamBSF3M"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369E02DF6E9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758987676; cv=none; b=XL4Qm756q+laSnlINQBQun4FCa4q6u/gNUOsFqcwkDDYMKdsp7OZrDYmf64BolK2QhvK2DIDBYDcPDaQqZRb1zK9TKw4g9pKsoBYlWb+8OUJ2wQsewnh1xbiBxhyAwILDiXnUhIhcRnYIbHD38vCv16z+MfPmqWw1DHYkrRWG8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758987676; c=relaxed/simple;
	bh=FPmwv6sV7hm4RdMnP+owJF/j0SUOZOnBAU0EQjBJ4QM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QS3dty8zCDbOdklBJjT1GquOJVrEYII4cj9KTp09FDxxjHYYQkQ9uz/5aKDKNiTwikgB7Y4wZ/rLrN38qPFfT0BWr0FlkH+OpjUUGvgQSbVKz+4QzRxOOsuIjLb2fXBKdUaVRadurrKUkYPaPsBe2irUzJxuxzMRQpgq9whuiMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZamBSF3M; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-781206cce18so1339278b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758987674; x=1759592474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+guc24UFix+87mZw75ftkg3HVWAUb97VQeNgK+6EGk=;
        b=ZamBSF3M0YvdqbjPmmtb10pmoRkFeK15WxiSNjklDZs9Y9IZ7LqCvyAOHLRIwaUUNi
         Il5N83bPAw6cCIG/bcpoRery2U0dR/lnUPj84xEFvtRsv3fuWFza2VDiTeYkLbEk71ka
         KEHh7POM5Rl8ySC4XN9LeEil3USDNYage/b1vhBTqCZjQauJA70liT6PjO+uISdZ8J7M
         QXHMlXHSD5tFXsspJ6frZB/62sJET2tk56XPaI+pj7gGiszVlzyt2ru4VGXNE5izHQ7H
         tV+sgPm3I1ZviIFIc42/HMhzeQcEkifmYol2c5NPvD8iri9KHJaeBMhaAPp3annPhPQG
         jFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758987674; x=1759592474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+guc24UFix+87mZw75ftkg3HVWAUb97VQeNgK+6EGk=;
        b=ryoPUTvmiW0tvA/3MR2DJ/D05fjcU92zUNTshLpnYZOrLC/Bae0/ukUZGI6bIk8qQE
         ZUo8TctytfLXTrQsvFGZ5sAamzWsX1AhK1E1XKuhIVlY0U5Y5L3uW2KDHa+FYwtRbEgs
         Bkd1wu8czbiPWsstOu+xhQ93dKwZ5IJYZWiWMOpmaIN1xy0TRtPDOjkoNRlZFJ9eZOyO
         FV3lmCCLxFLJ5oBcoPb0hsRudJGn1/v/ZJH3LcRYjWdVdwrzqCbSBoKENU1B6FU2o3ml
         gkEgt0AMDLcz/qc9aPOa84feuvZaG0dVkQ8qlKOnSduaRjaV8sYe8cpdO37hBzDaJxQQ
         LhSw==
X-Forwarded-Encrypted: i=1; AJvYcCU1yOtl9XT2sEh3Kl7NmzUwiFcxagYWWGVUdxCrFdtz9gN0xehccoD0oIjdUOOlw8EC9YTdV54J/cD32q8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0qfrPMkxUw9KwTAsCyzd3k+3RuEh2Rgwj9fx+CWfn/DGicjw/
	R1H6xYt6Yt2ydvzRA2gRN28+p6V+BlShLJEV+20YhKPm4dd3oDTRaxrl
X-Gm-Gg: ASbGncuuCuk6vBYOWPYiNpXgArQW/rZiRMEL0Ds6eLvuoNG2QlwNGalXNPcn6+5qCCo
	BYd7cCI/O/JnOexrM5hYp0o7BMmYCKTDt9wTPjqFAk5abNaE45wpUYmTyDOy6q67oAYrZoWqEVD
	M3jzz3BFOsH+8PcqvQeSDJyuxDkc6gxjzBGjxnc+vzcv5xwTlagkbdSGa/OvGkn5EM4Z+0C8Dyh
	X/0MSHPkAUJE9yseBWzgsisYLDe1Ha1MtrdyJ2YwwhCmuo8gbeMvEm2y6myAky2R10aSjMgUlVD
	5uBFE3PYh0djheZbtxVxreFqyLbSG7SwTX+gMxbv1/ioK3Ebldg18k7ZhCXI291RFmRhflIc2DC
	bA8yTvqaj15Yyb/L3IDrzrz5R4a6G+TwBGE9reWNOHvsUlxsl2w==
X-Google-Smtp-Source: AGHT+IH1j8iZ+VWe12C+/tThYXtmTrtzLYXhJdXhg11A+ZuNwyCqmcZMV00qeYbftkoEsVvjpMu9fQ==
X-Received: by 2002:a05:6a00:1f05:b0:77f:43e6:ce65 with SMTP id d2e1a72fcca58-78125450167mr3043482b3a.0.1758987674330;
        Sat, 27 Sep 2025 08:41:14 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c0709csm6923531b3a.81.2025.09.27.08.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 08:41:14 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: tiwai@suse.de
Cc: aha310510@gmail.com,
	clemens@ladisch.de,
	hdanton@sina.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
Date: Sun, 28 Sep 2025 00:41:09 +0900
Message-Id: <20250927154109.879926-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87o6qw9koa.wl-tiwai@suse.de>
References: <87o6qw9koa.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 27 Sep 2025 12:36:07 +0200,
> Jeongjun Park wrote:
> >
> > syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com> wrote:
> > >
> > > Hello,
> > >
> > > syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> > > KASAN: slab-use-after-free Write in snd_usbmidi_in_urb_complete
> > >
> > > ==================================================================
> > > BUG: KASAN: slab-use-after-free in snd_usbmidi_in_urb_complete+0x389/0x3c0 sound/usb/midi.c:251
> > > Write of size 1 at addr ffff888074717943 by task kworker/1:3/5866
> > >
> >
> > Wow, the UAF bug still occurs?
> >
> > But... this UAF seems to be a problem with how midi handles urb rather
> > than a problem with my patch.
> >
> > Is there something wrong with the way snd_usbmidi_in_urb_complete() is
> > implemented?
>
> This can be rather a missing kill-and-cleanup in the code path.
> So the patch like below.
>
> Could you check whether this works for you instead of your fix, too?
> timer_shutdown_sync() is already called in snd_usbmidi_disconnect(),
> and the call in snd_usbmidi_free() should be superfluous after this
> change.
>

Since both my tests and syzbot tests did not cause any bugs when applying
this patch, I think the root cause of this vulnerability is the missing
kill error_timer + urb.

So, I think it would be okay to patch it this way, but in addition, since
most of the endpoint delete-related code that existed in
snd_usbmidi_free() is now done in snd_usbmidi_disconnect(),
I think it would be appropriate to modify it to only perform
kfree(ep->out) as in this patch below.

---
 sound/usb/midi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index acb3bf92857c..97e7e7662b12 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,15 +1522,14 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	if (!umidi->disconnected)
+		snd_usbmidi_disconnect(&umidi->list);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
-		if (ep->out)
-			snd_usbmidi_out_endpoint_delete(ep->out);
-		if (ep->in)
-			snd_usbmidi_in_endpoint_delete(ep->in);
+		kfree(ep->out);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

>
> thanks,
>
> Takashi
>
> --- a/sound/usb/midi.c
> +++ b/sound/usb/midi.c
> @@ -1522,6 +1522,9 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
>  {
>         int i;
>
> +       if (!umidi->disconnected)
> +               snd_usbmidi_disconnect(&umidi->list);
> +
>         for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
>                 struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
>                 if (ep->out)

Regards,
Jeongjun Park

