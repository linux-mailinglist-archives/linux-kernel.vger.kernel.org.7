Return-Path: <linux-kernel+bounces-892140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B43C446D2
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 21:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509F03A87ED
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 20:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CCE026657B;
	Sun,  9 Nov 2025 20:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUi/+bH8"
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D496E223DFF
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 20:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762720345; cv=none; b=p+jsIilsR6PS8j3d/4LQAdZOZRXSN4Az2U50Adn22Pm/JjOs/12nV/WbrhYa99dfcWhBZmsxOQ2fB9gT9u3wp57Opf/y4MaB2fzJHDFy8ZDKmHm4Ixjwu2IGhIrlqjs0QloImUbdF0lB+pC+jZniLtiJf+V61CE3Rv0v+MFXNfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762720345; c=relaxed/simple;
	bh=ncnmoEiO4eSEK/OqYp7O/p4RCS6dsMi+/tBH8i+d8mo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBEHUTn81rf0Krs2ykHkahtQe6CbBnYeBrEDrfnl/Es/uOyChSkr/wwHkaKgjWpRoLqQWHKV6iiWc7SNpnehUY3wmIX34UG4/4fb4qAM2wL7wj7sjBgkK1+acQUnHWMc6DsiAKsOfAAmZyNQscw34DCNEW5J9to/oIB4xxSrUgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUi/+bH8; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-63fc6115d65so2235518d50.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 12:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762720343; x=1763325143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Be/c3YNg235FCmw7rjdApsq2sbm+SiCG0ZNx+ltZ8Y0=;
        b=nUi/+bH8OWP3eqmQbfvD5vXzQTGEFzXnm51O4s/ZfOkKedntzAZb3fcd9OuK5aRqcw
         VPtTmazi0nD2Upn3DWIlMrVIzGn+zlf4yFrv40yv2A2jkoDp9NGbcpw73wAvlkHzzCma
         qmwso2Nge7Rw9P1s89NsjwelgRJTa+gfk8Ojh66EXH3Hc2/DUik/8gxE9/66QEVLcGA8
         2HMm4hC1cyE7B5CtPSENcsMX/q7Zx00eXIQLuRza8ZzOrDVQqSdgu5wA+knSRQ8Rr4O1
         bQOp9KBT/BrNVGFHNRRSkwBp7SBKk23myxnF31e4hjmvHoCciCx7ho6EfbcHIb3zLklD
         FD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762720343; x=1763325143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Be/c3YNg235FCmw7rjdApsq2sbm+SiCG0ZNx+ltZ8Y0=;
        b=oAqOI6puP+I0tvJbcS2qSUBWnWRHUOakG9YcU87sGwY686lbVKOHI9LsGHfhHaJIZQ
         jALivdrICj6x10TrAgulFI8ghDiLpUUFUem+P6zAOVyveYkehaMxhLaoaam/f8w4W+Un
         CHInME+AmJFgVG7X85SXN6t/s6Htg/p9STCvDfqPwzxeEYmRHy2L4+McrxZYTFF9MW3y
         S394WbkB7m2eDqXLfVZyt6KtoS06bNf2PTYHP3egJsVSqYKGntiSebrHx1ld+CARzdg6
         As7A6mTa8fjIKdymCNQ8uIrgOiddOJueNtXu73xlqh62cJJribYu1aqW9wqi5qOtPLKI
         pVyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCgE2R5Z9nCFdUfiMA4XC+YdIzFSlC5ZFXkVE0BtMwB0olvBI7lbwFM2xq8CZLmmwIc6kFrx2ENL4A8m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy07WzyjmolwPixe1nNnYRgOBVqccv8BI22Vj461OSIyX0VZ5c
	i9HWOeIJQnut/AgpoMmusBo9JAYcuhZSsUrro1rLVKd8LIuwPrQnLEtqThv5zzM89SZgq0LqA+Q
	zu3wqBAr8y6mJ9mrT6f0UEzx95qJPYrA=
X-Gm-Gg: ASbGncsGbwMT5v//QJX2wy9KWVjAv0HbIFBPzCk+FA2e35qK/deYafDtRrztMgm+hH4
	hq+nd+/8VEt5P9bjBkBv57nABxqggLxsHWCmnB2Jl2X/qRX+P8yzzaQT9FSkgb9R+mtIRTzZWzv
	awiGH59hsArG1j5FKbiEVC2h5Y54Due70WLDxY5BSoS1mgGucXMkZiGHm01AO6NIbU6jU3Syj1r
	zs/RTszlCrTkuWjMNo2iiCcW5RBQyt+cVrkUMMlpUzZJclwM8eWsM37xl4=
X-Google-Smtp-Source: AGHT+IGFO+lynNkcrtWe+dcm0Bay4mLO/hNJVc/tVTFVqDu91IbdCk4wGmH46TTnv/kCinfOBuJILdrgdGagC9sC9Ro=
X-Received: by 2002:a05:690c:dc1:b0:787:cfde:6787 with SMTP id
 00721157ae682-787d543c441mr61525737b3.37.1762720342868; Sun, 09 Nov 2025
 12:32:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_AB89A8B8A4621BA42DE4AF179EF525F32C0A@qq.com>
In-Reply-To: <tencent_AB89A8B8A4621BA42DE4AF179EF525F32C0A@qq.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 9 Nov 2025 21:32:11 +0100
X-Gm-Features: AWmQ_bnWPE5IucMM6RwAqhHzvVT3oCu15UXxdwh_2sU5Fhi4K2e4bzPMgteYxmo
Message-ID: <CAOiHx=k7ULBgdq+B=5D7Zon5R8vwPuEc0t9H8QA66x0Zhvan8g@mail.gmail.com>
Subject: Re: [PATCH] spi: bcm63xx: fix premature CS deassertion
To: =?UTF-8?B?5Liy5LqW44Gu5YWt6Iqx?= <929513338@qq.com>
Cc: broonie <broonie@kernel.org>, linux-spi <linux-spi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Nov 9, 2025 at 2:02=E2=80=AFPM =E4=B8=B2=E4=BA=96=E3=81=AE=E5=85=AD=
=E8=8A=B1 <929513338@qq.com> wrote:
>
> The bcm63xx SPI controller is programmed to use full-duplex mode
> when a spi_message contains multiple TX and RX transfers and there is no
> prepend (i.e. do_rx && do_tx && prepend_len =3D=3D 0). In this case the
> hardware shifts out the contents of the TX FIFO while clocking in RX
> data.
>
> On a BCM6358 device, this causes the chip-select signal to drop too early
> before actually read anything.
>
> A concrete failing case is a 3-transfer message used to read the MAC
> address from SPI-NOR:
>   - TX 0x03 (read command)
>   - TX 3-byte address (any)
>   - RX 6 bytes (MAC)
>
> In contrast, a 2-transfer JEDEC-ID read (0x9F + 6-byte RX) works because =
the
> driver uses "prepend_len".
>
> To keep CS asserted and generate proper dummy clocks for RX transfers,
> fill the TX FIFO with 0xff bytes for RX segments.

Thank you for the patch! I could reproduce the behavior on master with
a BCM6368 with SPI flash (getting to netboot OpenWrt main on a 32 MiB
RAM device was an adventure lol).

I played around a bit, and it looks like there is a hidden accumulator
for how many bytes were written into the fifo buffer, and this
overrides the bytes count in the control message for duplex messages.

It does not matter where you write those extra bytes for the dummy tx
to do during rx - it doesn't even have to be within the message
length, I could just write them in a loop to the end of the fifo
buffer, and it still worked. It just matters that the amount of bytes
written to the fifo buffer match the total message length. It also
does not matter what you write for those read-only parts, I tried
0x00, 0xaa, both worked as well. Though 0xff is probably the safest.

That being said ...

>
> This patch resolves the issue on BCM6358 (tested with OpenWrt) and in
> the v6.12.57 kernel:

This patch should be against spi-next (?) from
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git. Won't
probably not matter much though, as the driver doesn't get many
changes anymore.

>

Here should be a Fixes: tag, e.g.:

Fixes: b17de076062a ("spi/bcm63xx: work around inability to keep CS up")


> Signed-off-by: Hang Zhou <929513338@qq.com>

Your name here does not match the From from this email.

> ---
>  drivers/spi/spi-bcm63xx.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
> index 000000000000..000000000000 100644
> --- a/drivers/spi/spi-bcm63xx.c
> +++ b/drivers/spi/spi-bcm63xx.c
> @@ -247,6 +247,7 @@ static int bcm63xx_txrx_bufs(struct spi_device *spi, =
struct spi_transfer *first,
>
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82if (t->rx_buf) {
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82do_rx =3D true;
> +=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82memset_io(bs->tx_io + len, 0xFF, t->len);

You need to check that there is no t->tx_buf, else you will overwrite
the already written tx_buf for actual duplex messages with 0xff. And
the fifo counter will be off.

>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82/* prepend is half-duplex write only */
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82if (t =3D=3D first)
>  =E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=
=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=
=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82=E2=80=82prepend_len =3D=
 0;
> --

Best regards,
Jonas

