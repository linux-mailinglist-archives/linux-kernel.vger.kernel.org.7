Return-Path: <linux-kernel+bounces-875577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E30C1956B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:17:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF4B11C26A99
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3CA2EBBB3;
	Wed, 29 Oct 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsTbBoAK"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB328E571
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761729339; cv=none; b=kcqH7WeAdDbOY0H6m0kzMQ42BGDRur50bXyT8XSjVKa/uLGYIL7eLZpGF0v/r05yvKN9jst6cL1YRYtiSROAPddW1Dr0MtCx3Ud5vBpVhkLZQz94pEAHdqxXpGSTYOdxbVBt975ElEpsG12FtmUSmocRrQxUY925U/Q0jPLwjRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761729339; c=relaxed/simple;
	bh=itjsDcySguGaFki53FVnzohhMjE5+9HRovLjl7e5KEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7e/QXlPKOO7k5W3GbNzXCkLR1j2PsZGOmBlcRVsdl96FL+mLE7EpQ/BxpLxG7VBoZXNNI1HuF/Av8SzLXcQXWFwDqJlBkCi80rfk22FuGBo4Vfk+bQ+pQUs1HQBs9MhryjMzX/SaH0Bv0bKi9XAut+y+/4/FrRtxdAdSlkxq8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsTbBoAK; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7815092cd22so91967747b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761729336; x=1762334136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UygssEPwtyV4QTrYeX1AiLSpA4gBFv6ObS7fU3X7V2U=;
        b=RsTbBoAKdChs3u8HeEImtn3XsdxcY/nT5avZ8hOVQGdIKxahhuxWZMWoIXPTbzOdAs
         wVjUSQBwHfj1vVvdNIJDUKxNXntGysUDVm0jdjFIwbARqbFwReho2jI3R2eY4p3ENNqK
         4KDccfNWLImRaXZ7QUYCst8M9sOv6MOlBo2AHEVoDsX9v6s9vsBstqQoO6SE2A/usQzI
         ApGUF8OeaSoB3tGuIv/iQT7BibIvX7zPzJbSviq1ENHVTYo066GI359S0QHFYOMkrtgT
         fcSi0QRBD60W6ckqaJIS7oqSozJXCUvce2midHR8CpUo4aBcruTTVqXkVwNAT+4veBg2
         82LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761729336; x=1762334136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UygssEPwtyV4QTrYeX1AiLSpA4gBFv6ObS7fU3X7V2U=;
        b=E/1m4sAC8wsfJAgpN7l9GtyGkylmXX7OwMFWlM+LFIcKK7tq7m9QPbZ1Ugl8qdlguV
         9UMefJmEzo7VWnl9XApsO81LisX5YLjdTk3dNbqdbsh12WNp++npRP/l4A8gc3YHiBP2
         F3M2r9zk6IQULPfdliGqH5Iqv1A9P10SIJeb3+GzQQy+TJPB7QEYfoAfb9AmuNjU5sJA
         nJTXjA1SSaKQvFIr+J24Okd9zTv7C+ysaG8/GXY17pE1c5skg0rV6Ap6AFTdfkieTaee
         kyCUJL/cIKY2YGJIoWq42KOvzsXrdDIIgJKDuS+5Fr1dvAQtuESR2DwiHigC4BwqXY+X
         YuZg==
X-Forwarded-Encrypted: i=1; AJvYcCXsaWM7Ox8YQedKpXBI+jLoe+tNyRd2A2HfI2yOQbW/577TkOQwlY/Ok2O4BlueFprHHz0YSwYAWHru3rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyws7f4eSV+K620pFyyV3l9qmnxVACMnNZN+Go+jqUtM/mzpHxI
	tZJ6ss0yWO5bqseZX3xkct3tIu+9XBH8kr9Ab9j7HdoJ/XsiMu6RXmR+bN8sEuQkbHYfpJ7mUz0
	yaA8Gma8NAHU00OfTnLsZ+fLUHbGUMDk=
X-Gm-Gg: ASbGnctuyzBzHJ2otdzdZBb7pUSAVrfcOgZMOgHlP/Vtm7h2g9luyZq/6TzTATOoXjv
	JM/+c8Igc/rCldHFGhztelYZznaWZgWLKoSee9Mqz3mz6JMuLIVjUxcuUA/XCtYCxExR+9FxU0V
	3k3y9f+OOffTUyf7qmFXk2mWXuxZIVRDaO1Gn3BVm4dZPBi3L1BvaBiyB2E8hppecbvTz4X1tdS
	oXoToAxf/0iwMo6PlJ3H3YJgFPkxi5daEJY0Jj93wt06H+3pzfXynYM0kE=
X-Google-Smtp-Source: AGHT+IEQDyFSthCYxiKEqlJv14a8jhCmiZaL70iGNaUt1WzUGm5AZRwZxAZ/eefAJU3mVt3LlAEv2c8FlDqRddjvGN8=
X-Received: by 2002:a05:690c:74c2:b0:781:1c9e:fc82 with SMTP id
 00721157ae682-7862903d263mr21137247b3.48.1761729336254; Wed, 29 Oct 2025
 02:15:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027171759.1484844-1-cjd@cjdns.fr> <CAOiHx=nSEP=4s2xZuPtLEO43YDbkNEYzw6V11JbXG0H2iPn7Ag@mail.gmail.com>
 <096509d1-4af8-4abc-8068-ca27d8ef601e@cjdns.fr>
In-Reply-To: <096509d1-4af8-4abc-8068-ca27d8ef601e@cjdns.fr>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 29 Oct 2025 10:15:24 +0100
X-Gm-Features: AWmQ_bmyo1Vk5GBvVeX6G5wl6wdQm6iXyIxD4JsyZ1GGxh0xGeFFX2edoLr2NHM
Message-ID: <CAOiHx=nqWEdHEMf5immXO0VwyzDakDV9AMsoDETcJ0F4FqUt=w@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: mmio_(read|write)_copy byte swap when on Big Endian
To: Caleb James DeLisle <cjd@cjdns.fr>
Cc: nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com, 
	shayne.chen@mediatek.com, sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 10:42=E2=80=AFPM Caleb James DeLisle <cjd@cjdns.fr>=
 wrote:
>
>
> On 28/10/2025 21:19, Jonas Gorski wrote:
> > Hi,
> >
> > On Mon, Oct 27, 2025 at 6:19=E2=80=AFPM Caleb James DeLisle <cjd@cjdns.=
fr> wrote:
> >> When on a Big Endian machine, PCI swaps words to/from LE when
> >> reading/writing them. This presents a problem when we're trying
> >> to copy an opaque byte array such as firmware or encryption key.
> >>
> >> Byte-swapping during copy results in two swaps, but solves the
> >> problem.
> >>
> >> Fixes:
> >> mt76x2e 0000:02:00.0: ROM patch build: 20141115060606a
> >> mt76x2e 0000:02:00.0: Firmware Version: 0.0.00
> >> mt76x2e 0000:02:00.0: Build: 1
> >> mt76x2e 0000:02:00.0: Build Time: 201607111443____
> >> mt76x2e 0000:02:00.0: Firmware failed to start
> >> mt76x2e 0000:02:00.0: probe with driver mt76x2e failed with error -145
> >>
> >> Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
> >> ---
> >>   drivers/net/wireless/mediatek/mt76/mmio.c | 34 +++++++++++++++++++++=
++
> >>   1 file changed, 34 insertions(+)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mmio.c b/drivers/net/w=
ireless/mediatek/mt76/mmio.c
> >> index cd2e9737c3bf..776dbaacc8a3 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mmio.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mmio.c
> >> @@ -30,15 +30,49 @@ static u32 mt76_mmio_rmw(struct mt76_dev *dev, u32=
 offset, u32 mask, u32 val)
> >>          return val;
> >>   }
> >>
> >> +static void mt76_mmio_write_copy_portable(void __iomem *dst,
> >> +                                         const u8 *src, int len)
> >> +{
> >> +       __le32 val;
> >> +       int i =3D 0;
> >> +
> >> +       for (i =3D 0; i < ALIGN(len, 4); i +=3D 4) {
> >> +               memcpy(&val, src + i, sizeof(val));
> >> +               writel(cpu_to_le32(val), dst + i);
> >> +       }
> >> +}
> >> +
> >>   static void mt76_mmio_write_copy(struct mt76_dev *dev, u32 offset,
> >>                                   const void *data, int len)
> >>   {
> >> +       if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN)) {
> >> +               mt76_mmio_write_copy_portable(dev->mmio.regs + offset,=
 data,
> >> +                                             len);
> >> +               return;
> >> +       }
> >>          __iowrite32_copy(dev->mmio.regs + offset, data, DIV_ROUND_UP(=
len, 4));
> > Maybe just replace this with memcpy_toio() which does no swapping at
> > all instead of double swapping on BE?
>
>
> I'm not that informed about how PCI works so I had to test to confirm
> my understanding, but I can confirm that memcpy_toio() does not solve
> the problem.

Ah, right, I misread _iowrite32_copy() to do conversion to LE, but it doesn=
't.

What architecture is this you have? PowerPC? ARM? MIPS? 32 bit? 64 bit?

So the differences I see are:

1. __iowrite32_copy() uses __raw_writel(), which has different memory
semantics than writel()
2. __iowrite32_copy() assumed src is aligned to 32 bit, while you
explicitly align it
3. memcpy_toio() will handle unaligned src properly, but does 64 bit
accesses on 64 bit systems (and uses __raw* again).

Is src aligned? If not, then the issue might be 2. And if your system
is 64 bit, it would explain why 3 didn't help.

As a first step you could try to replace the writel(cpu_to_le32(val)
with a iowrite32be(val, ...) which should do the same except avoiding
the doubled byte swapping. If that works, you can try to replace it
with __raw_writel(), which then would make this the same as
__iowrite32_copy, except making sure that src is aligned.

Also you could replace your memcpy() with get_unaligned((u32 *)(src +
i)); Should do the same but inline.

>
> The issue as I understand it is that rather than making every driver
> carefully call cpu_to_le*() every MMIO write, someone decided to make
> the PCI host bridge itself transparently byte-swap all MMIO on the
> wire. Since most MMIO is hitting registers and most buffers are
> transferred by DMA, for the most part everything works and nobody
> notices.
>
> But in the rare case that we need to write a blob to MMIO, it gets
> transparently swapped in hardware so you need to use cpu_to_le in that
> case. Doing a search of ./drivers for write.*cpu_to_le I can see this
> issue comes up a bit.

Every (PCI) driver does conversion to LE implicitly by using
writel/readl (or iowrite32/ioread32) etc do the conversion to/from LE.
So writel(foo, dst )is a __raw_writel(cpu_to_le32(foo), dst) etc. PCI
memory is assumed to be in LE. If you are on a little endian system,
then no byte swapping happens, and on BE it will do byte swapping
before writing the value.

Best regards,
Jonas

