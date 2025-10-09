Return-Path: <linux-kernel+bounces-847249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0253DBCA59B
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 19:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27F4D1A6351E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C3E23CEF9;
	Thu,  9 Oct 2025 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4Myphls"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3036623B615
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 17:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760030078; cv=none; b=VsjZNmxVO1ReLH0jESUrzsNYXMP6YII1XJASQx8bxcIABLQiembKFw62sMFww8oGtTygKtVXIZAYiqyQQ6nptsLJoETiRglr48F0zJsBYFKSu3svPw00V1ASjP8whqwPH9wWjzbT1Ut0uW/8/rnfwRks3CUZ30E2jqK+NGQNr2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760030078; c=relaxed/simple;
	bh=0zKM0e9qYySfTrXtzCDz9SownDZKCby8rjpw1jZ0wrQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzEpdFou7wGBpgAaBcXjP4znYsXi/pgirPmBTqR1KQoAg0tFU9SISWRpldtwTKnkok5i86cF7XtkX0xb//O52Z44WMzgxQrEENFur12hzCa3UEL27IKDG34BGoRG30cQx2j+1Rvm/+WiHG/Wofu013glkhCpWX/Ks6SMjv8KK2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c4Myphls; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3761e5287c9so10129501fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 10:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760030075; x=1760634875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlAR+KbSW1gZp/5eKig0p2dpF+5Yx/IHk0IkMrWQi6k=;
        b=c4Myphlstp3+ZW9ClEEPHWXOPKw/1rZz2bW4x0ObsovTOVMqwkKwsJCcLZWXxO0z6F
         ZG9uxH2T2Ih0K4el9QMWJbrZ1fHOnFgmu6dtVxgRqBNTIcF5B9aRbsYvM/1vX7Klrv2A
         HYDN39oM+IXpxwORI3izb1GvMPKO3Tba13hefXpUVjXzBhHM5gTpQSEUpfoI+hwfo5Cx
         qonmPF2RGUWwsIt24zHheY+EB/xqg0v8BXhrzqAsqo0HBvjt7d4I/djmHCaXq8RdKMn6
         Bo95BfCV+sigU+2vQy58fqivIKKGNJRyO6XA1ZGsJTZK8dPt3Ti6uyqROdhO28M9iYpF
         uMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760030075; x=1760634875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlAR+KbSW1gZp/5eKig0p2dpF+5Yx/IHk0IkMrWQi6k=;
        b=ezMUNv81bSSYQj7gvCiajEdonL6efuO7/cqlL/DsAxzTUijo4rp/xhiokeL0+znZUn
         N6Pjjh68eVE7rtOFKi/hs/RAipDdAbFbXkFzq5/gAB1zXPoo1GeA+39orVeNNG9FEc1M
         CqQCRTo0swKEpf/70Iq8t4S13AcpVrkD9ZxFR9wFbalwxv/vnNw5jbwp4SGlumFFbg9V
         BcKXa6sv3kHOjsLncovrQbKXwW9gQRcGedf4HosbCDmtbX8chij+uEAT3/0mWx8tH+6O
         qBhS2XeSH8EzYbHAkea110jEViJzkaTNn209KYGhFMRnl7oIsPDJEJpgYOmoKWB3vCY5
         2kTw==
X-Forwarded-Encrypted: i=1; AJvYcCV3vPqRdpXtCgkCEupWS4yBkbRaYddPcIVZll8scRAD15XF4fUerURhgrz7fmjvRcM/u0vbKrpE9tdGrUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd1JW3IlaN2yxOx+RDMBsF7WtuLJJhaeavRqu73VjvGnk49kBr
	te1B3VdHwLa4OljuFf30VO8OZySYv7DIG5797WTcsSGVhCU2dn+k1lt29MS4JCjPH97RwJ0TRSI
	JCdbHBAMrFaWVFRNBpj/53rt0yiV+tq0=
X-Gm-Gg: ASbGncs69O5iCpwFLQgrp6agJIGcausJ8y/X4/djELsIOCHhHWxcMAA5uJXOyOglu0H
	jj7XyZB5v4xm6U+82zRGyPXcznMc4on/O0/I2DSaS1Gw3LEGjlhMqESYfXmz8g8eakruXF8OYE5
	pALo1J9zZVqxSclRleFvGmP+ekyQPhn1aAONqk27PmIMGGHjO6OGK8QgTRUw9i0VdIrLXvyqLGj
	NhqWvtPvl/h/5X4wmsPCnbOMNXtiXaGJ2z2wzCG
X-Google-Smtp-Source: AGHT+IHnwfCA9lfjikRPwo6No8kmoalLOPLiFuzt6u82TYqFRhD9hGN9B18vXulFc+ISMpBlJz07vb1KGmj8nU7mltQ=
X-Received: by 2002:a05:651c:3608:b0:36c:7a76:d17a with SMTP id
 38308e7fff4ca-37609c9ef93mr25115931fa.9.1760030074994; Thu, 09 Oct 2025
 10:14:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <572c2a33-18dd-4bf0-8c41-e051d75f481b@molgen.mpg.de> <20251009164817.3762787-2-eeodqql09@gmail.com>
In-Reply-To: <20251009164817.3762787-2-eeodqql09@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 9 Oct 2025 13:14:23 -0400
X-Gm-Features: AS18NWCMoU278nHtknLMHLGaJduuWlcP8XauUrHAdrQfETXUwzPW6eaASZ1p_bM
Message-ID: <CABBYNZLgOpam+34S-VA3pVYVfwYRxBSCLa8FU66rrB57ogUv=w@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: bfusb: Fix buffer over-read in rx
 processing loop
To: pip-izony <eeodqql09@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>, 
	linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pip-Izony,

On Thu, Oct 9, 2025 at 12:51=E2=80=AFPM pip-izony <eeodqql09@gmail.com> wro=
te:
>
> From: Seungjin Bae <eeodqql09@gmail.com>
>
> The bfusb_rx_complete() function parses incoming URB data in a while loop=
.
> The logic does not sufficiently validate the remaining buffer size(count)
> across loop iterations, which can lead to a buffer over-read.
>
> For example, with 4-bytes remaining buffer, if the first iteration takes
> the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
> only 2-bytes remain, but the else branch is trying to access the third
> byte(buf[2]). This causes an out-of-bounds read and a potential kernel
> panic.
>
> This patch fixes the vulnerability by adding checks to ensure enough
> data remains in the buffer before it is accessed.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>

This is sort of useless if you ask me, this driver is never used in
practice, and even in case someone still have the only model it
handles  USB_DEVICE(0x057c, 0x2200) I bet it would have been easier to
just add it to btusb since it appears to be using the standard class
as well.

> ---
>   v1 -> v2: Fixing the error function name
>   v2 -> v3: Addressing feedback from Paul Menzel
>   v3 -> v4: Improving the error message for the block header count
>
>  drivers/bluetooth/bfusb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 8df310983bf6..02ba16775004 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -360,6 +360,11 @@ static void bfusb_rx_complete(struct urb *urb)
>                         count -=3D 2;
>                         buf   +=3D 2;
>                 } else {
> +                       if (count < 3) {
> +                               bt_dev_err(data->hdev, "block header coun=
t %d < 3 (too short)",
> +                                          count);
> +                               break;
> +                       }
>                         len =3D (buf[2] =3D=3D 0) ? 256 : buf[2];
>                         count -=3D 3;
>                         buf   +=3D 3;
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz

