Return-Path: <linux-kernel+bounces-889927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B77C3EDC7
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:02:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 554B33AFF53
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252B42E54AA;
	Fri,  7 Nov 2025 08:01:24 +0000 (UTC)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E33289374
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502483; cv=none; b=CtAtzbiwUCgGejwyTVX3egpxSPZXhRlC37S8pX2fbQ6KUkQ0xKw4I9J+6FBOO4QvcP+r/DDOAOS21TxLYDLGrBjVG9VQfgo2IGR6ijmaqItG4VvKGNczz62h3VTC2kck4f7R4ALV+q0yiB9ZMLivnaUe5ClJg1gmNcQ0r98he50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502483; c=relaxed/simple;
	bh=mVmxhRVa3QLX+9Tw5ztS33zfhofD3+aNGlWySPb0alc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqiCBN/6vAOycZrpAhvUqutK/O4urhCJQ+Px7Ns8p2ycqt4w4SJSk4k1GvBvceuRyp3eGu6Rvidv/PPMrnWqOgGMOAve2K6tlppJdz6zsHAebmyF7VtUpluiXcILTxwKDLg7qlja+fpXFl/HMU6b6BAAYBa6xCeu9huFSxxZ9Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-935241a7a0eso277939241.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:01:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502480; x=1763107280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uh6Brj9oYK8r8+vmC0dHdhpZdYfAyUsVdZvtypnYmmE=;
        b=JRyWKBqyIvKmjfRbfL/pXSijcRXNmCIWehHo1XDctjWza0FglR/D4cqr+V7rPjXHIy
         YQzw7prfkdmvz3qcqdOJQOeVjSKB3WGAJU+wBJO2saSrAwHAoy2MERYFV69WMOXCzvR/
         C7gIABnco00jDuWO4zxS7hk4yKrdsqksj7bpuL2CT3QRp6kSWgXVWCVc+kroT0cPn5tQ
         9ljtrmo+bwg6+QTSlHXo0EeuxzmgAGdrg8WMEEZ1TYlm7yp7D48NLZDmvXLiWxXO6XdX
         3jHcoePBy15EmG7TH7mFhyWUGus62P8zGiW3sgp0l298H+CMkjk8cmDxCTaa5Mm5eVWZ
         SUWg==
X-Forwarded-Encrypted: i=1; AJvYcCWUpt9rSqDvMzCRZtj4piLaCEYVc+PSCTj5rGSjRhuCXxXaN2IHToXtA1Cf5ddYfQuj+m1J1STCtsr0Pl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyaz9Iwx4Tlu4RDg12bv+zAERwIy4ZJw47HQ6Pzn8Zq59GzbGEa
	OkJArwiDkComP+M0CXJJGw8m0rHU5eXREKDw9awdTehJ4NHPBl/OeXk/3EH6k/8nLo4=
X-Gm-Gg: ASbGnctzdMLP6KbGcxQ0RylNSikpNBvql/9Ddq9vrk12n+a1lafZDd7/CNT/Ei+P3Jm
	GmQBq90UHEQBXCq5XM/rRvUnR9/rEI9T3/RpohxbED/+ys1yVU1MW0Alzfu5BWRHBiWqOh4TQ7w
	feqzlciXUE7rw0ApzF+P5i9HL2RlDgL+6g5OVVM5XqcXwBlsYnFf5eTNVxX2RJVr6F9kdDxwafU
	x02FLuS1ThHdRpttbSRGJTpyU0vWJOxt3Ld6gqLUE4yT1ngnQh0QbzyOSkec0DhWoRte3HQaDII
	J3aFxsgPMZYnwOYj87KAVLerLbmzJ9HtpkkehnSL+akvLPHQlIYBI90Zli53q1iuizPgSv8QYbx
	nHhQ2eCQ9p3foGiIvnMqDWiF6LYKD7+V9DEO+z5d5QxE9az5ABEKD9oOaogwIaNaKTbPiWsPOOI
	ffgQx2W3xwUpSNp/jSOhPLrE5C29bVMgtuHBWL1w==
X-Google-Smtp-Source: AGHT+IGCsIoUpa52Es00zQUqQOO60vH146EqfEjenmvf2jRQHi4AQrgbA3vCd4B/yzDx00sYBpa19Q==
X-Received: by 2002:a05:6102:1620:b0:5db:d60a:6b13 with SMTP id ada2fe7eead31-5ddb2259828mr869284137.21.1762502480295;
        Fri, 07 Nov 2025 00:01:20 -0800 (PST)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-93708522abcsm2137872241.0.2025.11.07.00.01.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 00:01:19 -0800 (PST)
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-932f654eaaeso285850241.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:01:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVwv4JJLZdgvX7Ifx1xTs0yoQ8w3L9spQ8vQB5PO0urvgrU3NUdMzvckewN6y9HRJU2cIm7416sc2kAcx8=@vger.kernel.org
X-Received: by 2002:a67:eacf:0:b0:5dd:b2a0:ac6a with SMTP id
 ada2fe7eead31-5ddb2a0af71mr544559137.9.1762502479423; Fri, 07 Nov 2025
 00:01:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106143625.3050119-1-claudiu.beznea.uj@bp.renesas.com>
 <20251106143625.3050119-3-claudiu.beznea.uj@bp.renesas.com>
 <CAMuHMdWDGpqdhCsA0MJqoL1JAiyVR-TA2YqDe+-S9Xf6c5O-gA@mail.gmail.com> <64c74f86-7438-49da-b164-a8a113e47c32@tuxon.dev>
In-Reply-To: <64c74f86-7438-49da-b164-a8a113e47c32@tuxon.dev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 7 Nov 2025 09:01:08 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXG8w9jR9gr4av15VT69XNouqys5z4Rxx-nidnvnbN3dA@mail.gmail.com>
X-Gm-Features: AWmQ_bnEZ6hIZCEeCwpb7yJfB13pZwILannIATGSzms1g-ARrV5rVjhvQqGb8yk
Message-ID: <CAMuHMdXG8w9jR9gr4av15VT69XNouqys5z4Rxx-nidnvnbN3dA@mail.gmail.com>
Subject: Re: [PATCH 2/4] usb: host: ehci-platform: Call reset assert/deassert
 on suspend/resume
To: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Cc: stern@rowland.harvard.edu, gregkh@linuxfoundation.org, 
	p.zabel@pengutronix.de, yoshihiro.shimoda.uh@renesas.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, kuninori.morimoto.gx@renesas.com, 
	geert+renesas@glider.be, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"

Hi Claudiu,

On Thu, 6 Nov 2025 at 19:56, Claudiu Beznea <claudiu.beznea@tuxon.dev> wrote:
> On 11/6/25 16:52, Geert Uytterhoeven wrote:
> > On Thu, 6 Nov 2025 at 15:36, Claudiu <claudiu.beznea@tuxon.dev> wrote:
> >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >>
> >> The Renesas RZ/G3S SoC supports a power-saving mode in which power to most
> >> of the SoC components is turned off, including the USB blocks. On the
> >> resume path, the reset signal must be de-asserted before applying any
> >> settings to the USB registers. To handle this properly, call
> >> reset_control_assert() and reset_control_deassert() during suspend and
> >> resume, respectively.
> >>
> >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> >> --- a/drivers/usb/host/ehci-platform.c
> >> +++ b/drivers/usb/host/ehci-platform.c
> >> @@ -454,6 +454,17 @@ static int __maybe_unused ehci_platform_suspend(struct device *dev)
> >>         if (pdata->power_suspend)
> >>                 pdata->power_suspend(pdev);
> >>
> >> +       ret = reset_control_assert(priv->rsts);
> >> +       if (ret) {
> >> +               if (pdata->power_on)
> >> +                       pdata->power_on(pdev);
> >> +
> >> +               ehci_resume(hcd, false);
> >> +
> >> +               if (priv->quirk_poll)
> >> +                       quirk_poll_init(priv);
> >
> > I have my doubts about the effectiveness of this "reverse error
> > handling".  If the reset_control_assert() failed, what are the chances
> > that the device will actually work after trying to bring it up again?
> >
> > Same comment for next patch.
>
> I wasn't sure if I should do this revert or not. In my mind, if the reset
> assert fails, the reset signal is still de-asserted.

Possibly.  Most reset implementations either cannot fail, or can
fail due to a timeout.  What state the device is in in case of the latter is
hard to guess...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

