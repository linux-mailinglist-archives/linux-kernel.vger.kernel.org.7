Return-Path: <linux-kernel+bounces-846806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FA2BC9168
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 14:42:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E791A60FDA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54F42E2EF9;
	Thu,  9 Oct 2025 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRNQO7ZS"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23F51DE8B3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 12:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760013737; cv=none; b=V+0hMMRESGnrCvJyHpD4K6EkoDqIQwxadOSIJygDO2CYRwm/5NcRxLeLYE37eGtOc1FQQxsMObCZArxofl1vPaXNfDu255dIa7GwHi05AspS76dS/9a0B9oZr1/Gha5VequPbEi0MvmiBAmfjkaiPYB8c/B1vz3KoY0v2Q+LUUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760013737; c=relaxed/simple;
	bh=bYIFaq1Mo5ck6eZSr/P9RWtuoRuQQYxYdIqM9OZP/BA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4q+rAEM0eLcGNukynVRpc5YtishH1gGE93quUoaeXYP9miBzqlJFWJ80n6/vRWADMKgMMe0q8V5nz5BtCvs+4oT17q3GKbQBhOAMO29De+rLJ67LmF6OSa3Gw+x/S/ou41o/p4CzR14Tm+HbAKIRPK1acDCv444mgF1gJ2krlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRNQO7ZS; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-273a0aeed57so25038975ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760013735; x=1760618535; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DOe3oVDqR85nR2fwu3ohGJtPxHxOCysNyoebRoZ3K5o=;
        b=fRNQO7ZSOovyLAjJWT+hp3xgGVk6HxqW7+6i0R7Fg949cEf85VguWKAaQPJSfuE4qI
         8s7vVVqPXaPR3U4JAXN0zMRmXUW6wGj4dDBMeuWmAbuzZ9SlzTsfWKYKg2wtquteeRVU
         bf4KNpp5KP+08MD/kyB9kMP5OJY1WToZFmwUtOD+/dR9mjVe/vnVrC965Y5NZpLCxz7r
         edeSMMhgUoJwQUIJtsk9bkszIggMuESyJ7qcVQP5opLUWg50O3Intt65Dmk3DEjafQQb
         pT4XWp4o5ZufosE32AyCzsKI7zctlrFGZTL5FvxGJp4ftFtbeUYUhCurx5HQccwjncqU
         XrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760013735; x=1760618535;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DOe3oVDqR85nR2fwu3ohGJtPxHxOCysNyoebRoZ3K5o=;
        b=grneHE0DepvacUkfIATFPkYjuOm6YkQbVu/h9Ji8zn+WfroGbcC7mPbho0btMI2eXv
         tq4mUMmrGR/CcDaKb64ojmcZxXCxXdxceIwDLjDFW8whd4myMG2N3vRbdAHjrVctTCxh
         z7Zk40748pPfemWSlASHHO17zGYnZrx2vRaYSJu6D+Lhe0mxYFvx0yV1t8yTX9l2XLq8
         n3GOceYShOMBlex7jso+mTKmeorstHQmTYFEZedMtzSPYx4koVp53MZMX8gClOhqZuY0
         pwNappZaooZ8UeVyI3S0lkdSDYfJLaTKM0809M3WeWfT4j8XIUZdqY5x7HV7xMnzoKvj
         LGXg==
X-Forwarded-Encrypted: i=1; AJvYcCUiPyJxl54+gHvzI/RZuhFmM6BbMIDULENPDh0f50eWq1ubEZhIVulDTKoQ6Nxm2Yj9UvYKuoomoY8/72g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmj1zBBHgZVGlW6j5jc8AHoTFXFopTA1ZHeJ+0jxGZ8jX9pb3s
	+Txkdzg5oHJ4v42QREMQ6+U6mPmSwGloiHH0DUalkZeon1Tk18Hy37DpuR7b05kuFGQCo15FPU+
	EawDCvVQaft2A2sXVYOpmsANTlJkPwok=
X-Gm-Gg: ASbGnct6ycfyWP1YQx+ftDWwoY+0pOjL9Sx56vfdjQrCuZJdv3jly3rErnQfyBce1uP
	ycumKVOY0Q8tnCtctR8eS6laH4X9MrMXxJa8jW4IshsaZm1rzssXTjsDGPLEzF3NftSfmzXe9sC
	7X5aURhHhvo0QKlabAPjsXnYftjL4BbpH2nxFn8xo38yFvS1mVJR8Ad3B8rpURlKftfj1oLL6rC
	3tGQMWGqC48hByiV7UqvnPRno5D8QXTtg==
X-Google-Smtp-Source: AGHT+IGNyj/nlQwe8P7jt8p/6nIFzaQojjpzpHA2u3gzIiLTo+jcmOhifOgoQWIQZU+ee5SP9iX/eeXegA+8sYDkv0s=
X-Received: by 2002:a17:903:2c03:b0:279:b2cf:26b0 with SMTP id
 d9443c01a7336-28ec9c97450mr139697695ad.14.1760013734835; Thu, 09 Oct 2025
 05:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007155808.438441-1-aha310510@gmail.com> <2025100824-frolic-spout-d400@gregkh>
 <CAO9qdTEo46hCZ0UXKjjBQ4W2sLT2+5zw9DugQF98sqpHLyNzPg@mail.gmail.com> <2025100940-unrevised-passcode-6682@gregkh>
In-Reply-To: <2025100940-unrevised-passcode-6682@gregkh>
From: Jeongjun Park <aha310510@gmail.com>
Date: Thu, 9 Oct 2025 21:42:04 +0900
X-Gm-Features: AS18NWChPXtq3xJ5rkA9wSMgPxns56d8dKAkezJPDg5Kxa6WRZEDQu4yF8VynC4
Message-ID: <CAO9qdTGktp71We9BAhsd3bewb9yKWyOjbnq2TQh0CaV7CqD6UA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y 5.4.y] ALSA: usb-audio:
 Kill timer properly at removal
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, 
	syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com, 
	Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, 
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 09, 2025 at 08:23:42PM +0900, Jeongjun Park wrote:
> > Hi Greg,
> >
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Oct 08, 2025 at 12:58:08AM +0900, Jeongjun Park wrote:
> > > > From: Takashi Iwai <tiwai@suse.de>
> > > >
> > > > [ Upstream commit 0718a78f6a9f04b88d0dc9616cc216b31c5f3cf1 ]
> > > >
> > > > The USB-audio MIDI code initializes the timer, but in a rare case, the
> > > > driver might be freed without the disconnect call.  This leaves the
> > > > timer in an active state while the assigned object is released via
> > > > snd_usbmidi_free(), which ends up with a kernel warning when the debug
> > > > configuration is enabled, as spotted by fuzzer.
> > > >
> > > > For avoiding the problem, put timer_shutdown_sync() at
> > > > snd_usbmidi_free(), so that the timer can be killed properly.
> > > > While we're at it, replace the existing timer_delete_sync() at the
> > > > disconnect callback with timer_shutdown_sync(), too.
> > > >
> > > > Reported-by: syzbot+d8f72178ab6783a7daea@syzkaller.appspotmail.com
> > > > Closes: https://lore.kernel.org/681c70d7.050a0220.a19a9.00c6.GAE@google.com
> > > > Cc: <stable@vger.kernel.org>
> > > > Link: https://patch.msgid.link/20250519212031.14436-1-tiwai@suse.de
> > > > Signed-off-by: Takashi Iwai <tiwai@suse.de>
> > > > [ del_timer vs timer_delete differences ]
> > > > Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > > ---
> > > >  sound/usb/midi.c | 3 ++-
> > > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/sound/usb/midi.c b/sound/usb/midi.c
> > > > index a792ada18863..c3de2b137435 100644
> > > > --- a/sound/usb/midi.c
> > > > +++ b/sound/usb/midi.c
> > > > @@ -1530,6 +1530,7 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
> > > >                       snd_usbmidi_in_endpoint_delete(ep->in);
> > > >       }
> > > >       mutex_destroy(&umidi->mutex);
> > > > +     timer_shutdown_sync(&umidi->error_timer);
> > >
> > > This function is not in older kernel versions, you did not test this
> > > build :(
> > >
> > > I've applied this to 6.6.y and newer, but for 6.1.y and older, please
> > > use the proper function.
> >
> > Sorry, I didn't realize that the timer_shutdown_sync() implementation
> > commit wasn't backported to versions prior to 6.2.
> >
> > But why wasn't this feature backported to previous versions? I understand
> > that most drivers write separate patches for pre-6.2 versions that don't
> > implement timer_shutdown_sync() to address this type of bug.
>
> Features are not backported to older kernels.  If you want this fix in
> an older kernel, then you need to either backport that feature, or fix
> up the driver to use whatever was used before that function existed.

I could write a separate patch to fix this bug, but I'm not happy that
great features like timer_shutdown_sync() haven't been backported.

So, I'll try to backport the "timers: Provide timer_shutdown[_sync]()"
patch series sometime soon.

>
> thanks,
>
> greg k-h

Regards,
Jeongjun Park

