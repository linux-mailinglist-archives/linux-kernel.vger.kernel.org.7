Return-Path: <linux-kernel+bounces-755688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CD8B1AA66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 23:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D69C1881DAD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 21:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD2239E92;
	Mon,  4 Aug 2025 21:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="lUPoc7O6"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6905319C556;
	Mon,  4 Aug 2025 21:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754343349; cv=none; b=TdKcPCl75+f2YbNg6erL/0jN+ZNNG0IXVzyEtVxMpJU+uZCVXmbvomb46K6JJywHJTp38PZI+/jUpg0Vism/u12fauWmHahaFRrMTz14USXaWZ9APJAzCpRPJR1Xm/is7jpGLnOfKvPNQXUcp0sJ7UilPPQX1DjUct3l5xkEhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754343349; c=relaxed/simple;
	bh=RD7w/8aIHn1ifCKTKAphGnkshouTa3cUYHBlHD2G2Dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OXs14pDkP9jJFGsHMWNnthJwHUnOdycv4JFbkd63nBo2yyx7CNxxA6r7VCp9v9IgwuhhrHFF9EsbwALorbo94k14OP37yep0s3yP3lWajGKPjJ14zcl0yHwYpDa1Nlv/tfbsTc71vnmTo3S/fq1t5b2S9qpxVUPbbUvm8tBaBNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=lUPoc7O6; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2406fe901fcso36469295ad.3;
        Mon, 04 Aug 2025 14:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1754343346; x=1754948146; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cvo6vUqcyrnegdoTW6jNdQzV/1E/0vD/BmUkrhOfOMY=;
        b=lUPoc7O6t185UGMvwkkZ4KNmK6R+3uXh4rLrK/2D0bW5fD5F5UHfcBGA+oTrHOIsM5
         lhgXvupFYsyhMRqD1UruuirOOQW14vfqH3J8pfuWAQOLrtKTp1nMwEQ03E1BpDBTmH6/
         53tIo0bLwvMjHtCLaEDEnrG57QGZHapGHgY59V/keiJpHkk7Ov8L/SVVwWdCN+WvFzRq
         Hcmtp6xhomEj/JAowKu8UGSN+rtfGXmBryrT3xRdUsQ3cE1N8iLvvv03KNTQIRyF8mdE
         pRzzvayHulZukkFOXPSS2gBR07XvzRLrjHpKhm7oUTrdXiws24af4d9SIx03oz+7XPRZ
         4d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754343346; x=1754948146;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cvo6vUqcyrnegdoTW6jNdQzV/1E/0vD/BmUkrhOfOMY=;
        b=XnAraSP/bp6frsFrbMU/RM8ZFUM+SLd49KQ2Wc5DouZjDGVV0aSkdYQCRQdFCH3Z6T
         YCv4TDqVuFaDTh3rvau6ZKaKnQx4twS9vlIeTNI8/jW9Q9A0NeYVu4cb9d2/l1D/ZCrz
         yUg8kKyw0yw3yxdwS8mDkdcbMfp9Lt5/lAp9a59y74CJtG+mcLNLZbrf66BGpwA3NoWf
         rlBDSYhliZb/f0+cyFbKHlSDAvFwjvUNMGBeNUpaBfrlqaO/uBlFY3vtpSgspSX2+rwl
         INShElffJ6HgAZqju4l6AroWXmLhjAjQSgjacEcR2MrmMyLtJ1Vn0JGDvtFQOski3dII
         8cxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUiMIUWL2rOp5gG4g0cxTeramtA2bRuztXtKtsAa+p+jf5uVzo1Yixwi9dH9bHoNSWcgHAXTOPHfb/nXb0=@vger.kernel.org, AJvYcCVawe9V9ZtBAdgqCjV7jrQBGsCCaCXNASvHlbzyFXHtg1hbQhlHESbqzt9pAvKmF+oUxrq3espzf4n9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6odaE+NcWwPOa+eF4DsqirwEfdE5zIZovdNQGDbymAmcvC1UW
	Ro1hH0hbYnO9XxD43Bslky4c/FkKQCJmHLUj8HcDKTOsj6X9qx4Ds2xh2954QYzHivFVWFmUh9m
	Lh+pLG7YNVXjxplw4k3KBkxiquxUE1HM=
X-Gm-Gg: ASbGnct1kvzqekEOhjVbp+fHiqVQkEnH1XePcc4hF2cK1oAg7D22LxfNlaeJB0ciaiL
	v7Tb1/+U1ulqj4RfngTNoOF98oX5zbXVIARpchuw1v0z//h4UrhyELOoqvGcuC/hunRn2cJOJL5
	VkUdMSaanw+jxivF/JYkMZ7nJC2BCZ5EBnQVWSoPy+hKb9oR9AdSgYcca1tYeatHIqdZveXy5EW
	+bNOAo1AJnWEzh+pAULSCGCWZtEHbwfWQVXntJm
X-Google-Smtp-Source: AGHT+IGQ4h1PdEwAmwxxpRH/xuW+XGXcOYeRCGe5U8mroWOM6sMSqCmdibSpRsNPVa5PcWE9a6zJ66cC8PcfcArPagY=
X-Received: by 2002:a17:902:f549:b0:234:d431:ec6e with SMTP id
 d9443c01a7336-24246f595dfmr140662145ad.3.1754343346482; Mon, 04 Aug 2025
 14:35:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204135842.3703751-1-clabbe@baylibre.com> <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com> <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <aINXS813fmWNJh3A@hovoldconsulting.com> <CAFBinCBMTOM-FMgENS-mrnV17HbKzhtPUd44_dDiwnD=+HVMWQ@mail.gmail.com>
 <aIiXyEuPmWU00hFf@hovoldconsulting.com> <CAFBinCBZhjs7DGEgxhz54Dg8aW3NX9_LdnoZeUZpm5ohaT_-oQ@mail.gmail.com>
 <aJCoRFe-RFW1MuDk@hovoldconsulting.com>
In-Reply-To: <aJCoRFe-RFW1MuDk@hovoldconsulting.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Mon, 4 Aug 2025 23:35:35 +0200
X-Gm-Features: Ac12FXxZAqA4cyvbrNHPrOIPUfKS-JVCCQbLvWMVrBSQIg1CsBV-T5pBhrunwJ8
Message-ID: <CAFBinCCYsWHsNwi99kFqvLv+xOYtp9u3omhrPdV-hdH+5Cfyew@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Johan Hovold <johan@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 4, 2025 at 2:32=E2=80=AFPM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Tue, Jul 29, 2025 at 10:45:20PM +0200, Martin Blumenstingl wrote:
> > On Tue, Jul 29, 2025 at 11:43=E2=80=AFAM Johan Hovold <johan@kernel.org=
> wrote:
> > > On Sat, Jul 26, 2025 at 04:54:17PM +0200, Martin Blumenstingl wrote:
>
> > > > I managed to get it to work now without any unnecessary waiting.
> > > > When I switched to just waiting for per-port THRE I accidentally
> > > > re-used the same URB (along with its buffer) for all ports. This of
> > > > course "corrupts" data, but it's my fault instead of the chip/firmw=
are
> > > > causing it.
> > > > That's why I was referring to data corruption earlier.
> > > > Thanks for your persistence and for making me look at my code again
> > > > with a fresh mind.
> > >
> > > Glad to hear you got it working. Did you confirm that you really need=
 to
> > > wait for THRE before submitting the next URB too? I don't see why the
> > > vendor driver would be doing this otherwise, but perhaps it only affe=
cts
> > > older, broken firmware, or something.
>
> > I'm using Corentin's test script [0] for sending data and by
> > connecting RX6 to TX7 and TX6 to RX7.
>
> May be better to use a second different device (rather than loopback)
> for testing so that you can separate any tx issues from rx issues.
I'll double-check it using a second device. The RX path has largely
been unmodified since the original submission, so it's likely that the
issue is indeed with the TX path.

> > For a 1024 byte buffer:
> > [ 3029.068311] ch348 ttyUSB6: submitted 509 bytes for urb 0
> > [ 3029.068827] ch348 ttyUSB6: submitted 509 bytes for urb 1
> > [ 3029.069363] ch348 ttyUSB7: submitted 5 bytes for urb 0
> > [ 3029.069902] ch348 ttyUSB7: UART_IIR_THRI - unknown byte: 0x00
> > [ 3029.215272] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> > [ 3029.215908] ch348 ttyUSB6: submitted 6 bytes for urb 0
> > [ 3029.233628] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> > -> data is received without corruption
> >
> > With a 2048 byte buffer the general flow seems fine:
> > [ 3031.073101] ch348 ttyUSB6: submitted 509 bytes for urb 0
> > [ 3031.073777] ch348 ttyUSB6: submitted 509 bytes for urb 1
> > [ 3031.220068] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> > [ 3031.220697] ch348 ttyUSB6: submitted 509 bytes for urb 0
> > [ 3031.221342] ch348 ttyUSB6: submitted 509 bytes for urb 1
> > [ 3031.512113] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> > [ 3031.512795] ch348 ttyUSB6: submitted 12 bytes for urb 0
> > [ 3031.513359] ch348 ttyUSB7: submitted 5 bytes for urb 0
> > [ 3031.513859] ch348 ttyUSB7: UART_IIR_THRI - unknown byte: 0x00
> > [ 3031.530476] ch348 ttyUSB6: UART_IIR_THRI - unknown byte: 0x00
> > However, the receiving end sees different data (at around byte 513-518
> > in my tests) than we wanted to send.
> >
> > My general flow is:
> > - check if we have received THRE - if not: don't transmit more data on =
this port
> > - submit up to two URBs with up to 512 - 3 (CH348_TX_HDRSIZE) bytes to
> > not exceed the HW TX FIFO size of 1024 bytes (page 1 in the datasheet)
> > if the kfifo has enough data
>
> If you're going to wait for the device fifo to clear completely you can
> just use a single urb with larger (1k) buffer too.
I set .bulk_out_size =3D 1024 in struct usb_serial_driver. Writing a 1k
buffer immediately results in:
   ch348 1-1:1.0: device disconnected

I don't know if I need to set some kind of flag on the URB to have it
split or whether the kernel / USB controller does that automatically
(as you can tell: I'm not familiar with USB).
If not: 512 byte transfers at a time it is.

> > If you want me to test something else then please let me know and I'll =
try it.
> > Otherwise I'll not dig much deeper, given the fact that I don't know
> > how the firmware works (e.g. in which order they send the status to
> > the host and what kind of state they hold internally) and we can still
> > optimize this later.
>
> Yeah, as long as you are certain that the generic implementation does
> not work and that you indeed need to track THRE per port.
I'll give it one more round in the next few days. If I can't get the
generic implementation to work then I'll call the current approach
good.

[...]
> > > > On my test board the CFG pin is HIGH. From how I understand you, RT=
S
> > > > should at least change (even if DTR is in TNOW mode).
> > > > No matter what I do: both pins are always LOW (right after modprobe=
,
> > > > after opening the console, closing the console again, ...).
> > > > I even set up the vendor driver to test this: it's the same situati=
on there.
> > >
> > > I don't think the console code will assert DTR/RTS, you need to open =
the
> > > port as a regular tty.
>
> Yes, even if the device is configured in hardware for TNOW mode (instead
> of DTR function) you should still be able to control RTS (at least as
> long as the device is not configured for automatic hardware flow control)=
.
I think I made it work, sort of.
It's a bit annoying because of code I don't understand. It seems that
R_4 has the following settings:
0x00 DTR off
0x01 DTR on
0x10 RTS off
0x11 RTS on
0x08 activate (used during port initialization)
0x50 HW flow on
0x51 no RTS / HW flow off

That said, poking 0x00, 0x01, 0x10 and 0x11 by themselves didn't do much.
One also has to write 0x06 to the per-port VEN_R register.
The vendor driver only does that in .set_termios, which I call
questionable until someone calls me out on this and is willing to
share a good reason why that's a good idea ;-)

However, I'm unable to control the RTS line of port 1. It works for
port 0, port 2 and 3 but not for port 1.
Ports 4-7 don't have the TNOW/DTR and RTS lines routed outside the
package, so I can't test these.


Best regards,
Martin

