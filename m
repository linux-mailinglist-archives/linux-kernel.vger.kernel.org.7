Return-Path: <linux-kernel+bounces-834964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64294BA5EB9
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98DCD189DBC7
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 12:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE6E29B8D9;
	Sat, 27 Sep 2025 12:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGtvTWJ/"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382D1F541E
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 12:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758975371; cv=none; b=R7jLoQ0Wfr10cFSK1jhConhduubxw2aWdfLWOy/2B/NBprNmW9CIQXJ96OZ//K8gw0dSijj/8xbU3xeleXTehcZIajpCisXopICymLv8jYjFWXBeeEgA7GUgk0qmSB92GNVRChSps33h/Lfs77aYJhjjYW9HVw3X+ETLrlNqV/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758975371; c=relaxed/simple;
	bh=osqMo4xYnsPBNWFZJF66fDdoXny0UKAShUKrp2Qwdh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/0HUlaHyHHnJeZ/zKIRJi3oEyYrs+aEqTrBBOJZT9T+wP+0LK4mBnZjJ4dHr94CY/9ZA28GCCMUnjOGJyJGsGLQuF7GqQbMdg8iJjAaL+LPcBBWD8XCNnoar9BR3ybNvmlBxyfWvz3bVtJ5nTPGuJVJBqzQjnPzhpuT6XcoXzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGtvTWJ/; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-330469eb750so3493069a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 05:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758975369; x=1759580169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8qv4Ga5QoIsrNSn68xSGIzks6N+Mwy6yKb05/24myBc=;
        b=FGtvTWJ/SQLCRQwVgs/0rifqaSPVGLpuqEdM+Mt6A8XMjVzykGQV05dzFp3nTfVSnU
         s7QDszQ3xny3WB6Rc8071ZwT5Sn/uGRtwo3bwF4lCHj59epAZK04AwSi/jvNZXYDg86C
         vf4sanBaWPCWiZYD2WN3GZLFwaN1CYOx0ydF1ioHQE43GOfKO+ShAwjgLlgC+zJfe9L+
         gxQ1kWtFFSt2vNM1iYljvWFdI5bGiY8FUfMl0fjXQLWNigmih5Cfbz2im61yu4e+b4Xf
         aDRmbvHqaoBft9mvzpQav+HjgJMYbojSXdzjrhBepIm95EqvNVD1hE+EaZSuZXSurAJM
         omAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758975369; x=1759580169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qv4Ga5QoIsrNSn68xSGIzks6N+Mwy6yKb05/24myBc=;
        b=pifuLmI7t3wLmKOJF735rPrFGK3kye5p0a0wahuh+Ks6z8ZVTKA6o747yFCkytx05D
         EMCNngpj8mIEj9yLlSdSzv8H493snZjNOX9OC/SgMoJ0946z9WzmfHT/lzp3yqYS+LpY
         xHlKnnvWyXcfxHM3N1LdG5T3bc0xF0nkB7STKViGampYIHHnmgYJhv5iXSQhNSGIcD2d
         kh3aOGhKQ9v9/9o9Qkq9889Y0ka9BOGxwDwVsqW6WHdZL4z/TqaPntANnZGz1ZjYWMM8
         ih5/rGg6BsYiYdi2oZaAkdctpBSHGyQO5iKLgwZm4liA+aIz9bwSrO+t86HfyySH4KiU
         b5UA==
X-Forwarded-Encrypted: i=1; AJvYcCWWbebIql17bZ1dWu8iMtuLY5eveNDQC08IoiUxef/HmPQub4zR9a/UJ/fG1jrYuYQAzhUFaMtUkdG1c4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ9xz1UYba3y4hyCvfnKXBVtBT0cfdXqjJpfP+V3lEusH+fmd7
	MBbAQodFxnT8s8P6qCsShtXg1EJyQLxEBNEYxF0JMAx8pXnJetgdARxt8LlcrPDU6sbBu2UuHM6
	cVJs1BWHQOL92tDqI10TfDFYbI2yKpUw=
X-Gm-Gg: ASbGncvOYC8M0t3NO3hf6c70LCwP4O/zaqgVtQ2v0NQw9JomgK5ahfzX+MWR4g95nHI
	2EawukPgbkbqmCZb7oxwTf5uNoPYLrdBvODI+O10f5z+rGdleyaTYW6HJfDmSCVY4M7STgJQnG0
	yXTQdHnIg3T/uo1KtFTGn9hNwkD9W0uP7MKPXbatrSIDhNSALHqzfWxa2TYIe0DAc1tOp3FLVSc
	CAAf/TgnY1Ec1LuBIx8gOGznvGM
X-Google-Smtp-Source: AGHT+IHsiI17VYHrQ3GH2ZPIOFDNXOLIe/yeeAd5WF1Qrebu5OoIx1VUVdYu6RrTjU7uSt9UNTZrJ8m09OWgillHOi8=
X-Received: by 2002:a17:90b:1b4f:b0:335:5e84:6d37 with SMTP id
 98e67ed59e1d1-3355e846e68mr4821211a91.6.1758975369333; Sat, 27 Sep 2025
 05:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927091931.7691-1-hdanton@sina.com> <68d7b657.a70a0220.10c4b.000e.GAE@google.com>
 <CAO9qdTGH5eMQTesCKVjLU7-kMg4uGC_6DGxP+YOP63yp=07HdQ@mail.gmail.com> <87o6qw9koa.wl-tiwai@suse.de>
In-Reply-To: <87o6qw9koa.wl-tiwai@suse.de>
From: Jeongjun Park <aha310510@gmail.com>
Date: Sat, 27 Sep 2025 21:15:58 +0900
X-Gm-Features: AS18NWAqKqXB45gFfRyKYznZA3-cmvgfUfXNm8gAy3YATj5FzCcOkOtwAhMN0I0
Message-ID: <CAO9qdTEbFHyxKToEF=7NRdxTNGi7dmgbQ6g4OcLNg_10yamdeg@mail.gmail.com>
Subject: Re: [syzbot] [sound?] [usb?] general protection fault in snd_usbmidi_do_output
To: Takashi Iwai <tiwai@suse.de>
Cc: syzbot <syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com>, 
	clemens@ladisch.de, hdanton@sina.com, linux-kernel@vger.kernel.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

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

I'm not an expert on the usbmidi driver, but based on my analysis so far,
I think this patch is the most appropriate.

And I tested it with the PoC I have, and no UAF occurred. If the syzbot
test doesn't produce any bugs, I think it would be a good idea to apply
this patch.

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

