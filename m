Return-Path: <linux-kernel+bounces-746782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D254DB12B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 666783AFF36
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6A82E36E1;
	Sat, 26 Jul 2025 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="fkifObck"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6513D1DE892;
	Sat, 26 Jul 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753541670; cv=none; b=KHE9dvvs15cdBtBqFdQUjfumsOzwR/FuPXiU5YOBCgo557QsnCjwvdkhMgAwqlgPx/k5G8sb6UqN3kg+7B2JnvAE6JCGC3tNPOS+gU4i6qWy35OenYOpXFwwAIgVGtCyHtNhposKq1I9U3C43wqZ7s+1CedJpap6IxG1jJknUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753541670; c=relaxed/simple;
	bh=3bHnZA8m1tqBMoYoIdlxpAcQmT7aS6sqXwX7iqsYTxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jo31tVP3MRIlft7tYx5XqKtqQhBquh9tljUKBQQkn2qnPUBZNYUOeo2/nVhpjHjLwe2yNJevGaxxQG8PPVCUEJLnxBrVniE2sHkwYsz3U8qAkalr3qHCTS1/zmPOx8GBoZdvEWUQI6bhYYAixndjD56US1daJVv56rXKrUVT86E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=fkifObck; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-234c5b57557so26155395ad.3;
        Sat, 26 Jul 2025 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1753541669; x=1754146469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bHnZA8m1tqBMoYoIdlxpAcQmT7aS6sqXwX7iqsYTxA=;
        b=fkifObck90YpH/snTIsTJHfNTiTXJB5U4zxxl06Z4zU69jKDOg6OwZrdV51Bqc+33s
         SWlK3U+2KfkTT8Nr6tP/POXbu2OZlHLmLJlySA2sbAUbZ2KIkhzGOgU+pMkc6c5UqKXq
         3DTquELHovkswLBPoLadU3OUgzAd5mu+iYs2cXhVql1h8xCpsGUcqJnSnan7oS5NuHIi
         Su0TatWTkX5xvAFnmv5fsUQ4Lba5DLNYWGiZ8ZkoJW2f562vVXxsLtmkDxCuHc0L+KOs
         fqvddxcLQxWhArg1RN7Xlobz69Vd230JV41cP3s2VYkFzN9978cZxtagsBGGqqUstwwt
         ScaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753541669; x=1754146469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bHnZA8m1tqBMoYoIdlxpAcQmT7aS6sqXwX7iqsYTxA=;
        b=Z4ywQYvm5ij6uXM3+KQ2ylxUungX3gwH9k0BXhK7XH8RPT+5XRFjkPW1wHmA+t/6FO
         uTQSyavY9hB1jaWgAwyLEufvx4XqK7VG7yxYPN/X23VdXXVhlP+4vY5Q5EAMMKtJJkPD
         CyMcE/9iIH3H45mOqTQeS7/obaLPOtHUuxKPs9sOyJjMbMJzRvw3vbuBIcb1i8QIMWA0
         Ni2lBWz2or4bkBdu3HePqBnQujGrpjb73enfKae+wQ+GjL53zTtPIFTv6EB2w/xyyH1x
         G+iwoxxIqKjFtUfchVy1NJVTPz60/0V9M1gUrQ9xi3g+Y2qHFQMFht5qqHyJNiS76zoB
         0j7A==
X-Forwarded-Encrypted: i=1; AJvYcCU5y/VJc864OKh3rtUmhpd/QzJD7MWASNgTnjmUJGFpq3on0ce5HCQ7tA7/PX5sqGu/msQoxi00AJQgKGQ=@vger.kernel.org, AJvYcCWirFiF0NOBR3acWR9cOeljMa+KfnO/KZCXIQ1lDPJADFnNPfFhgun309a0eLh6XKZ8eYLoJOuOx3wy@vger.kernel.org
X-Gm-Message-State: AOJu0YzCfpgg3y7vbVdA/rznqvhCszz/LFbAk6vck2G0tCNuKnWksccR
	p25JUzVzd4+OroelrOOBAsCJj3Zlmfysshl3GGFEKOhzD5hifWsstcivIP67N4/KEgx1hpyMdk4
	SlvOlycr/O6ROxiieOmPJByaIvOfPp3M=
X-Gm-Gg: ASbGncv++2o1uWQrBv2EaGlithS/+3uj2LwiUR7t/RE5CJ7XFBHjpKkc08B9xGnoqBI
	hsT6c7FvEAMPgVouHKFd5hlFH+bdDpQ3aPQx+WxlXatM9t6IY9n8n0bBvI3BQICIqFtA8HgWbRq
	CWd/+gJVFFCAFotXRm+4hRXdXhJ5zDbNBjaJ9AQps3ghEGqSZVoYH9s90uVNhTxll/wgsYgNfCo
	CeT8+1klHJAZaXoYxF33bmbe0dSHPIEzgJijI4t
X-Google-Smtp-Source: AGHT+IH48189c7fSvo4Rra30U14aRDZDu0fOQbJ0LdUinC1a9SuaFher9z2GM01faWEF1qWm7EppDpjH0gxkV+fO+7k=
X-Received: by 2002:a17:902:f211:b0:23f:d1f8:72aa with SMTP id
 d9443c01a7336-23fd1f87e3dmr21200685ad.48.1753541668593; Sat, 26 Jul 2025
 07:54:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204135842.3703751-1-clabbe@baylibre.com> <20250204135842.3703751-2-clabbe@baylibre.com>
 <aCHHfY2FkVW2j0ML@hovoldconsulting.com> <CAFBinCAUNNfOp4qvn2p8AETossePv2aL7jBkFxVZV_XzzULgVg@mail.gmail.com>
 <aINXS813fmWNJh3A@hovoldconsulting.com>
In-Reply-To: <aINXS813fmWNJh3A@hovoldconsulting.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sat, 26 Jul 2025 16:54:17 +0200
X-Gm-Features: Ac12FXzcvotFyw8g_x45Czy5Sou_bnfiuDxwp3FFXKkJTi9lE_FJig1Ihyh4vGQ
Message-ID: <CAFBinCBMTOM-FMgENS-mrnV17HbKzhtPUd44_dDiwnD=+HVMWQ@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] usb: serial: add support for CH348
To: Johan Hovold <johan@kernel.org>
Cc: Corentin Labbe <clabbe@baylibre.com>, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, david@ixit.cz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:07=E2=80=AFPM Johan Hovold <johan@kernel.org> wr=
ote:
>
> On Tue, Jul 15, 2025 at 11:20:33PM +0200, Martin Blumenstingl wrote:
>
> > On Mon, May 12, 2025 at 12:03=E2=80=AFPM Johan Hovold <johan@kernel.org=
> wrote:
>
> > > The read urbs should be submitted at first open and stopped at last
> > > close to avoid wasting resources when no one is using the device.
> > >
> > > I know we have a few drivers that do not do this currently, but it
> > > shouldn't be that hard to get this right from the start.
>
> > If you're aware of an easy approach or you can recommend an existing
> > driver that implements the desired behavior then please let me know.
> >
> > The speciality about ch348 is that all ports share the RX/TX URBs.
> > My current idea is to implement this using a ref count (for the number
> > of open ports) and mutex for locking.
>
> Just use a mutex and integer (not refcount) to count the number of open
> ports. Submit the urbs on first open and stop them on last close.
>
> Not doing so, and instead submitting at attach(), means that the host
> controller will be wasting power by polling the endpoints continuously
> as long as the device is plugged in.
Thanks, my code wasn't miles off of f81534.c but I'm following that
more closely now.

[...]
> > I'm trying as you suggest:
> > - submit the URB synchronously for port N
> > - submit the URB synchronously for port N + 1
> > - ...
> >
> > This seems to work (using usb_bulk_msg). What doesn't work is
> > submitting URBs in parallel (this is what the vendor driver prevents
> > as well).
>
> No, the vendor driver tracks THRE per port
> (ttyport[portnum].write_empty) and allows writing to more than one port
> in parallel (e.g. releases the device write_lock while waiting for the
> transfer to complete).
>
> I thought the problem was that you could not submit another urb for the
> *same* port until the device buffer for that port had been emptied?
>
> This seems to be what the vendor driver is preventing.
I managed to get it to work now without any unnecessary waiting.
When I switched to just waiting for per-port THRE I accidentally
re-used the same URB (along with its buffer) for all ports. This of
course "corrupts" data, but it's my fault instead of the chip/firmware
causing it.
That's why I was referring to data corruption earlier.
Thanks for your persistence and for making me look at my code again
with a fresh mind.

> > > You should implement dtr_rts() as well.
>
> > This will be the first time we need the "package type" information as
> > CH348Q only supports CTS/RTS on the first four ports, for the last
> > four the signals aren't routed outside the package.
> > I need to see if I have other hardware with CTS/RTS pins to test this.
>
> Just connect a multimeter to the DTR and RTS pins and verify that they
> are asserted on open and deasserted on close after issuing those control
> requests (see ch9344_port_dtr_rts()).
Do I need to set anything special in termios for this to work?
The datasheet has a special note about DTR/TNOW (on page 8 for the CFG pin)=
:
> Unified configuration: During power-on, if the CFG pin is
> at a high level or not connected, all DTRx/ TNOWx pins
> are configured to function as TNOW. CFG pin is low, all
> DTRx/ TNOWx pins are configured for DTR function.

On my test board the CFG pin is HIGH. From how I understand you, RTS
should at least change (even if DTR is in TNOW mode).
No matter what I do: both pins are always LOW (right after modprobe,
after opening the console, closing the console again, ...).
I even set up the vendor driver to test this: it's the same situation there=
.

If we need to make the DTR and RTS output something then the only way
I know of right now is to switch them to GPIO mode (I have code for
this but it's another ~300 lines patch on top of this).
So I'd like to not implement .dtr_rts and drop all CRTSCTS related code for=
 now.


Best regards,
Martin

