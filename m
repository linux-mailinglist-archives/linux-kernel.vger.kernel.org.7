Return-Path: <linux-kernel+bounces-834871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD4ABA5ADA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 10:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78DAD189FC01
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 08:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B57277C81;
	Sat, 27 Sep 2025 08:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFbPhmcE"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA02D47F3
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758962888; cv=none; b=J4213DJeZbPO+3Sd0jeadddoJ4w929Z66DbwXx8DZQyeSsnO+YkkEb7GgtPtFvcDYOEEpk6jab/zzR9kssviySD+Ee1ODjiTcrcnaTW/bMGfZb74hzw90LQLteG30wM2JVNS7BaK05zboq2iTtk51b5OjViLWfT3TNxEwwB9Be8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758962888; c=relaxed/simple;
	bh=W3jFT2xCuMdLstdxWfEbBiE9g9ULW4SMf/2PYW8sF0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KruAe9M85PaREmbWH5vW6EbomyquKR8HfKHXfQvGzOOS8xKTwuEx0dE2wgROApQwltZwsgm9EwpguXQn6SFAlbZYXOImm18s1SQz7Gobul8B+QhrZNV7iYT2JIDOXRgwEuihoDUPQ0vBscmbbeB9YmCSomcK8O3Lj9HRBdf4vgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFbPhmcE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso2929167a91.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758962885; x=1759567685; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/GTUQPP8+/5EC2O1mZ2t0mC7oS0NY7urV0HxwSW70UI=;
        b=EFbPhmcErXPM8UQyW275k9D26+VWXbmSxKKVEaVdO+dHiJNibzbB4VrBZuctCTnwk4
         3wGoVXcYXndrozrGZ3NnqsKRUKV5plnNn1uR1vxJFTfde++dWX23+QPp0d3u12I9WHXI
         4FxkGdFkJK5u1d2tHJ7doEveJ0V2b9yVgbl86zrLwR06tqc2JSynRjk3RCFGVJTx/ZOA
         em+ItWhG0QHec+jAmUpPLTuAMNGzTSHfKtjjZWzCYJOnPG86k1I8TKBkeYUYMdQ+G3RU
         hj5x1nEbttLOFgcSxWWvJXKIqXeUpCjCOf74pPNrLJ9VdXZEpcuByEf0w0fxy+gjGxGC
         In2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758962885; x=1759567685;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/GTUQPP8+/5EC2O1mZ2t0mC7oS0NY7urV0HxwSW70UI=;
        b=VRLgNnJkJ37936+8nvgCISMUCqMxYevOJdvTrORNE5ISGkixTsTEQsJ4sSxVrhsQwn
         K1JL52pd/81jJkifczvgjNJjdSInfEb1DQeHQRlRbhNgC3NTXi4w7CuSbFk9ZMCWocEA
         qTlT6auNcZIWrQm3AuZ8ZbcSBV28zr59rLGjKA0WlUFK9N+KzgRuCemzpGTl//37sYzB
         Ae17KHPKp84kRdUWBqm1xKjfiVo4MP5IGwsl4Dp8hQmrRMCoj7mPz4ER6o3oCVBHRseq
         9lQV8Tg+XfzmV3TWYaETpdL/zyoMzsCxanKqDC0iMRpr93a+/bWKizVuNanfi5KlojQA
         SsqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv7GbIAxJm+ELXQY/Ck1BdY1Zj8n5ScD8Zz5tmron50SCuzWKkWfDHqPbpcUVP9ZGQY+1ukhMbOGPiv64=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy622XkWNCvC1EOjsaNjWbIuyMUL9kV0sbkr+aCfo4j3pNTLv6h
	b2GEH55hGvgJFHtaFKdqLOdWsOoASLFGzQPu/N3uWyv1sxjVFcSTmcR/wjX3QaXBVSgcxHT/DVO
	57ISSVZ2ymQ6QSVJlNfHzDASOLIt9r+U=
X-Gm-Gg: ASbGncuCBAms0guIYrq0ICl9kc84YPMwUxqRMfe/JuFH7Rcczdzy2eAZMOvjN/U6Chn
	GRb9GRhbPIvnpAJVNC7gA3WVjjmfdPPpEzldfeWWRrZic/KepsBzddvImv0sTEqKP33oeOG68b8
	YYKkScpSkqaEPKb6vHa/RX/DpMiPpLsm/zRvm7x7vD1T0rpVw84ak34li0o6dn3+rmBkBQKoOAe
	fr8fzLDIuXCryJUCjre
X-Google-Smtp-Source: AGHT+IE8/Ky1EmR+0LJIy4YhT01cjWKhOibqsHQ53cBmr/JkwwCwaBr7tP12GcnmDWyv0cmrxLHDEEw+q8nuhwMAZu0=
X-Received: by 2002:a17:90b:4d04:b0:32e:a60d:93e2 with SMTP id
 98e67ed59e1d1-3342a260e49mr10570366a91.11.1758962885154; Sat, 27 Sep 2025
 01:48:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927044106.849247-1-aha310510@gmail.com> <87bjmwb9y6.wl-tiwai@suse.de>
In-Reply-To: <87bjmwb9y6.wl-tiwai@suse.de>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 27 Sep 2025 17:48:02 +0900
X-Gm-Features: AS18NWAH5mQvcVsDREbrMd7yAaCa4-5UOBVCoSMH3cnV9nAbMNh2Maxiike7hRQ
Message-ID: <CAO9qdTHSu6QmUVMo0pZj_=foz9CDtwKEYwjBx5vjj8gHzzVFNQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
To: Takashi Iwai <tiwai@suse.de>
Cc: clemens@ladisch.de, perex@perex.cz, tiwai@suse.com, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

Takashi Iwai <tiwai@suse.de> wrote:
>
> On Sat, 27 Sep 2025 06:41:06 +0200,
> Jeongjun Park wrote:
> >
> > The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
> > removal") patched a UAF issue caused by the error timer.
> >
> > However, because the error timer kill added in this patch occurs after the
> > endpoint delete, a race condition to UAF still occurs, albeit rarely.
> >
> > Therefore, to prevent this, the error timer must be killed before freeing
> > the heap memory.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
> > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
>
> I suppose it's a fix for the recent syzbot reports?
>   https://lore.kernel.org/68d17f44.050a0220.13cd81.05b7.GAE@google.com
>   https://lore.kernel.org/68d38327.a70a0220.1b52b.02be.GAE@google.com
>

Oh, I didn't know it was already reported on syzbot.

> I had the very same fix in mind, as posted in
>   https://lore.kernel.org/87plbhn16a.wl-tiwai@suse.de
> so I'll happily apply if that's the case (and it was verified to
> work).  I'm just back from vacation and trying to catch up things.
>

Although it's difficult to disclose right now, I have already completed
writing a PoC that triggers a UAF due to the error timer in a slightly
different way than the backtrace reported to syzbot, and I have confirmed
that no bugs occur when testing this patch through this PoC.

>
> thanks,
>
> Takashi
>
> > ---
> >  sound/usb/midi.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > index acb3bf92857c..8d15f1caa92b 100644
> > --- a/sound/usb/midi.c
> > +++ b/sound/usb/midi.c
> > @@ -1522,6 +1522,8 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> >  {
> >       int i;
> >
> > +     timer_shutdown_sync(&umidi->error_timer);
> > +
> >       for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
> >               struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
> >               if (ep->out)
> > @@ -1530,7 +1532,6 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> >                       snd_usbmidi_in_endpoint_delete(ep->in);
> >       }
> >       mutex_destroy(&umidi->mutex);
> > -     timer_shutdown_sync(&umidi->error_timer);
> >       kfree(umidi);
> >  }
> >
> > --

Regards,
Jeongjun Park

