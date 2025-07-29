Return-Path: <linux-kernel+bounces-749895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76471B15464
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 22:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73B8B18A53A7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C327816B;
	Tue, 29 Jul 2025 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="U0jFwEdX"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5FB277CA9;
	Tue, 29 Jul 2025 20:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753821935; cv=none; b=ZA/1a7XqZkml2FmISXPoNd/rCQdp0RhvqvBizijsMLlPD8p0f0JndpyipZ0c2VMw3G9xylRb00j/xUaARNaPHSIOT1rdrN1o9rzsZPoFp2NJxQbj03bp66UONna9mbHDIcDH1MDUnmIHrp8rSjyX9vzu0J+tJgE0d98SCj3gfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753821935; c=relaxed/simple;
	bh=1MZvJiloFFQ+CPWljU5EgKKLdOjnv6o7TaEMtS98VQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VphGaOFz9OgrXLtjt59WbcdcOJT0C/qXkSVLezACoz+/gxTTvL1xVy/LRvNXkP3OIISlaKH6YU/MlZAM/MVB9CJ7+U5nvdWM1fdOOcTi6ZXnDV2EVrGUnKhwKJkK3W/0Tjoh/eiQGpp6TyXIu/yWGMBpfqSzEDoJsAqiWhR+J40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=U0jFwEdX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2402bbb4bf3so32906775ad.2;
        Tue, 29 Jul 2025 13:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753821932; x=1754426732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MZvJiloFFQ+CPWljU5EgKKLdOjnv6o7TaEMtS98VQA=;
        b=U0jFwEdXiVGQfNsiiOW/4fdsqf6Uo0xExCLkzx886Fk0IpAKxWfqo0iOM739HLRjg9
         WHL8KIkm/mIUCO/NAN7eRAmvLNL//e853aSQsokbeHigyYt+Pkz5PSzVKxY0rvJmJgk4
         wNkAZkD9JygUCThHIDqMgZAPnm/5rmVLIcwmiA94dozqNQeCRo8/bdjJpzkf8jWj++ZA
         V/i0szuV6eYNixLyMFIh4O0lCgbB8I1BFXgiOfxXjo4HtjSjXhVHGmzgJeU5zuK+Zw0U
         U2h/MYeyHcz+wjse5baQHmmAuDyCulWclHwqETGNbKP2q62hII+TzDzN6bfsuTLiHhEh
         3yYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753821932; x=1754426732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MZvJiloFFQ+CPWljU5EgKKLdOjnv6o7TaEMtS98VQA=;
        b=wHZ1NXLJGxa9SpEI7PiUjV10B7RV0m21nzLXpT1GV84GUX5XVfSg4RdcpK9/LH1jdI
         xXSMD5Mrf8ocwnYfxQLx6pxIGhAoeK/J2DtNYx3cIR67UIkFuCpzL+GMT7kdO2gg6/zb
         0iEHOpWuB3ycSUKIUuAu5MtX4KYf8pSUtsNJejfWyDfuAyiiuqloodzhI0x6jiIIdRtg
         ynRJKLqB3BfStqiKMAxl63cgdtLsZTRVyrGvQRcenfupVHdzVhq+FhiidZI8JQgzXFuw
         xhOcxfsEEg+Fn9gN4mn382/3YFnsuqPH0+FPEsKW3oszxmnwDjQmftK79nRX0fDMU1ax
         NK2g==
X-Forwarded-Encrypted: i=1; AJvYcCX4HmGU9l456xBagyZDG2YsGwV4PfytWXFqa9Njlab4ZICGIvHLjSeMqw+svZL5jfnpVh7Y2sjH4iR+FBk=@vger.kernel.org, AJvYcCXvjqvC9Zkt7M7a5g58ff8c5Y4gqwtS+7/0kwget4JQnK21788pJGyODjIC+MQ3KEfEw/e2p57Tao8B@vger.kernel.org
X-Gm-Message-State: AOJu0YwdYnXKoHnCzkz9fvk6s6hrnbm1nWLAmlWq60P8sn7mkI40yyN4
	LhUY9LQNmWnoJwYXbCJhz8gzauWAE6VcayzJx7Md5sWzGfGtQvbLn7EdPf85w2yuFZydvFEVGpY
	i8TrRCdBwmsfsJf9jHl8O0eaU3MrrgPo=
X-Gm-Gg: ASbGncuJCiKQl2J0D/7CMJ3LBQ4MBcnlfUCs7Or6YgAOZRTzCMxA6YG5v3sRpTnyPuG
	Knwtcs/WG0alMggenzKq7BfW+PhJ4FQxImnGegTYD+xx+eyucVWja74GZ4ItwahuV2rj1datWvG
	OvypGtI8IFr/hI++yCu399Swdg2KT0aMsRggFAJNrDrH264wSDm/6NOfi4cSNasyzjLioW//F1M
	9FPBz5mBtee+jLejhxJMtnssse2q6UOwj04AUKI
X-Google-Smtp-Source: AGHT+IGjb6IRhO7HyqgTLquzXL94sa1b3YkGBfr0fC0Hd0gl3JvHRk+3WsfH7Ip+nenYzJ+DqEy8pWRVi0DtWd648iU=
X-Received: by 2002:a17:902:ea11:b0:240:b46:120b with SMTP id
 d9443c01a7336-24096b4c51amr9660505ad.24.1753821931860; Tue, 29 Jul 2025
 13:45:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204135842.3703751-1-clabbe@baylibre.com> <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com> <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <aINXS813fmWNJh3A@hovoldconsulting.com> <CAFBinCBMTOM-FMgENS-mrnV17HbKzhtPUd44_dDiwnD=+HVMWQ@mail.gmail.com>
 <aIiXyEuPmWU00hFf@hovoldconsulting.com>
In-Reply-To: <aIiXyEuPmWU00hFf@hovoldconsulting.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Tue, 29 Jul 2025 22:45:20 +0200
X-Gm-Features: Ac12FXzip049c0je0JQVgwsiqE18SpBlfnzTyFeJrW4-V_R6WGqnHM07_1OfeB0
Message-ID: <CAFBinCBZhjs7DGEgxhz54Dg8aW3NX9_LdnoZeUZpm5ohaT_-oQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Johan Hovold <johan@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johan,

On Tue, Jul 29, 2025 at 11:43=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Sat, Jul 26, 2025 at 04:54:17PM +0200, Martin Blumenstingl wrote:
> > On Fri, Jul 25, 2025 at 12:07=E2=80=AFPM Johan Hovold <johan@kernel.org=
> wrote:
>
> > > No, the vendor driver tracks THRE per port
> > > (ttyport[portnum].write_empty) and allows writing to more than one po=
rt
> > > in parallel (e.g. releases the device write_lock while waiting for th=
e
> > > transfer to complete).
> > >
> > > I thought the problem was that you could not submit another urb for t=
he
> > > *same* port until the device buffer for that port had been emptied?
> > >
> > > This seems to be what the vendor driver is preventing.
>
> > I managed to get it to work now without any unnecessary waiting.
> > When I switched to just waiting for per-port THRE I accidentally
> > re-used the same URB (along with its buffer) for all ports. This of
> > course "corrupts" data, but it's my fault instead of the chip/firmware
> > causing it.
> > That's why I was referring to data corruption earlier.
> > Thanks for your persistence and for making me look at my code again
> > with a fresh mind.
>
> Glad to hear you got it working. Did you confirm that you really need to
> wait for THRE before submitting the next URB too? I don't see why the
> vendor driver would be doing this otherwise, but perhaps it only affects
> older, broken firmware, or something.
I'm using Corentin's test script [0] for sending data and by
connecting RX6 to TX7 and TX6 to RX7.

For a 1024 byte buffer:
[ 3029.068311] ch348 ttyUSB6: submitted 509 bytes for urb 0
[ 3029.068827] ch348 ttyUSB6: submitted 509 bytes for urb 1
[ 3029.069363] ch348 ttyUSB7: submitted 5 bytes for urb 0
[ 3029.069902] ch348 ttyUSB7: UART_IIR_THRI - unknown byte: 0x00
[ 3029.215272] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
[ 3029.215908] ch348 ttyUSB6: submitted 6 bytes for urb 0
[ 3029.233628] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
-> data is received without corruption

With a 2048 byte buffer the general flow seems fine:
[ 3031.073101] ch348 ttyUSB6: submitted 509 bytes for urb 0
[ 3031.073777] ch348 ttyUSB6: submitted 509 bytes for urb 1
[ 3031.220068] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
[ 3031.220697] ch348 ttyUSB6: submitted 509 bytes for urb 0
[ 3031.221342] ch348 ttyUSB6: submitted 509 bytes for urb 1
[ 3031.512113] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
[ 3031.512795] ch348 ttyUSB6: submitted 12 bytes for urb 0
[ 3031.513359] ch348 ttyUSB7: submitted 5 bytes for urb 0
[ 3031.513859] ch348 ttyUSB7: UART_IIR_THRI - unknown byte: 0x00
[ 3031.530476] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
However, the receiving end sees different data (at around byte 513-518
in my tests) than we wanted to send.

My general flow is:
- check if we have received THRE - if not: don't transmit more data on this=
 port
- submit up to two URBs with up to 512 - 3 (CH348_TX_HDRSIZE) bytes to
not exceed the HW TX FIFO size of 1024 bytes (page 1 in the datasheet)
if the kfifo has enough data

If you want me to test something else then please let me know and I'll try =
it.
Otherwise I'll not dig much deeper, given the fact that I don't know
how the firmware works (e.g. in which order they send the status to
the host and what kind of state they hold internally) and we can still
optimize this later.

[...]
> > The datasheet has a special note about DTR/TNOW (on page 8 for the CFG =
pin):
> > > Unified configuration: During power-on, if the CFG pin is
> > > at a high level or not connected, all DTRx/ TNOWx pins
> > > are configured to function as TNOW. CFG pin is low, all
> > > DTRx/ TNOWx pins are configured for DTR function.
>
> Got a link to the datasheet? Not sure what they refer to as TNOW.
Sure, try the direct link [1] - and if it doesn't work try [2].
It doesn't document any registers, so it's a high-level datasheet -
nor a programmers handbook.

> > On my test board the CFG pin is HIGH. From how I understand you, RTS
> > should at least change (even if DTR is in TNOW mode).
> > No matter what I do: both pins are always LOW (right after modprobe,
> > after opening the console, closing the console again, ...).
> > I even set up the vendor driver to test this: it's the same situation t=
here.
>
> I don't think the console code will assert DTR/RTS, you need to open the
> port as a regular tty.
>
> > If we need to make the DTR and RTS output something then the only way
> > I know of right now is to switch them to GPIO mode (I have code for
> > this but it's another ~300 lines patch on top of this).
>
> That should not be needed. It looked like the vendor driver had some
> variant of the usual request to control the modem lines. That should be
> all that is needed.
>
> Look at the vendor driver implementation of ch9344_tty_tiocmset() and
> ch9344_port_dtr_rts().
Thank you for the pointers. For today I -ETIMEDOUT, I'll take a look
at these in the next few days.


Best regards,
Martin


[0] https://github.com/montjoie/lava-tests/blob/5d4d83f2f71c37432dcdcc55ce3=
e31e74d133737/test2a2.py
[1] https://www.wch-ic.com/download/file?id=3D300
[2] https://www.wch-ic.com/downloads/CH348DS1_PDF.html

