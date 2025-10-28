Return-Path: <linux-kernel+bounces-874634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD5C16BE4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83646403679
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 20:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDA5C8CE;
	Tue, 28 Oct 2025 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BMguPJNc"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824041CAA85
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 20:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761682563; cv=none; b=ewZBA5+ieel5uL2LL3+PSEHp/xW7ZXOT+DUKcjQCQqEqv8O0+CkC57MerjBs8CBUpwCpvkI9OHxH06Nc416INLYnxbwp8wdvwXL+4T1H5EK3dQaR7SCfSuoKJrWLdcw3pxReq/lz/JyaaaeYyUHspC73ydPmzo/4L805/o9FKRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761682563; c=relaxed/simple;
	bh=BM/drt1Kw/lCtndnSgTN6wHlOq9MSst/ff0sEWt9SEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4M7JvLXSapbWfnNxDTBSMLt+uvqFEyj2fbvdPTBrHx8cvYL+PWYXrPiMkmPIZTX0Ix8TkoXEKWxZeKINdU7xnbRBPrH+6ngZHyKPu6GQzhI/oLGDhFMsgt0+6gVi4tpidTpljYFmWp/FzQC0la0tqqsZcCvm28EQtgGoyvcAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BMguPJNc; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47114a40161so72246535e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761682560; x=1762287360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8sbXcQ5lD5cCxutqIUWwx12KWSx0PkZ6JH0o6eFGGg=;
        b=BMguPJNco5Valnt36LdTyeUfquwtP/Ebh2myPcgUuWsZCb7t27ZDQNp8dF/PjOO7+2
         wU+Yss9GRIauiOoMCCwEYkNICgxsWtGPI6GO1pGEx2ZrO7bN/G0RT4Xp5NsoCjrbDZk5
         fbhfrBpAMrAlXj1lhrQfGJ0yfIyljon+uVK3zYfnyByc2S53Fihtt5eqqDAgMTy1SuOH
         OQfBvtFLaEpGi5v4N49tiTyS0uijwVIPeOXcklK8sUEdiZIpk2yGaofgSpmKI1GrdqVd
         4V7z9x1MRRoUBIv2FJAhlot+YX6bIEIUY+2AFInXuqDYD+C7GklnNwYC/RhXKpg8OsgS
         mGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761682560; x=1762287360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C8sbXcQ5lD5cCxutqIUWwx12KWSx0PkZ6JH0o6eFGGg=;
        b=I8VY4jQmNzpVyJlaQ/7MXxzL+TIJFBYwu3D6OYMyzbjKJP7jY7hF5z7lHJqCVIItCH
         qPHkuHQmhlo+ird78pJP8YSVU6HKYF6JwGVR2PwntPtx2jdjFOfAPY6QWfKZmp+l1QjO
         IufKjYvUe79Vy44d8INYtzxDVkGuT6OlFL2AxLqbsBKtODJRNu5gnG3AMjM1SOF63Ntx
         kxWXdVsCSnZ+QwwF7Vy2gDk3XtJVTwfo1OkIr5tH/uBKlupGD7g9/o2v1lKw8VG6Xv9d
         3xVJjqVxh4cOW1p0XU4q0FSPXOB2npocY+ZjlPrYuJimR6DRgg+hWmw+Fv55J4oLewbu
         AWsg==
X-Forwarded-Encrypted: i=1; AJvYcCUwqlfAx7lVjn8ylE5lWh1xlH+8hhd0S0gPNcd+nOa3+vfQcSiOgsiZ2QVKlFDzUorQ4NWOvCcTCjzAZD0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdEOhjgi7lm633gM+QjRUZgJPbaFvqEUtFQaZrXtwtprYrwsIP
	fRFM+TpSbIuFlCykGnQzWmHdobyYO3LXzHpfdFVGtvQ3DJq8vNaHPzV9/pYZUxOVchvsSWTviK6
	jHZUV5O8+Pns1beWiso7+tviVACXhlqI=
X-Gm-Gg: ASbGncuM5kJxgnu8HMxieQgUM1eASjyu0MN5IB3a2Te6XgHH1KxBf70dYdo9FfQg92w
	L/e20F5bVyZ/vD0Qu7HVO7QoWzGHyR8okGjGLg9ekCF83wNmbjA3I/39t5bN9lymGyGGSHE7FHZ
	1Y2uYzUUIMv+z3n9m/hjcVPRhUB9BdkSZqxEtiXP/DBeaaU7pBHp6l8YZrI9eu80HIxM0EcP18Q
	3C9JTXnRT/+D3cASFq6f/KETF3fP/frgE6+i9A+J7WAe0FOJ4NkSBo7/yBz7aYWzx9nqdMsYssz
	bDVauiiujEJ9k4eIBA==
X-Google-Smtp-Source: AGHT+IH8GZm4jB2bptQiSIyNDsqdA47qbhPsbgo1JM5SGKK5xL+QrbeybCdL/wavQXil+cg+EkPuHY3/sqmCyLrg608=
X-Received: by 2002:a05:600c:5489:b0:475:dbb5:239e with SMTP id
 5b1f17b1804b1-4771e2248c2mr5265385e9.0.1761682559479; Tue, 28 Oct 2025
 13:15:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028165659.50962-1-krishnagopi487@gmail.com>
In-Reply-To: <20251028165659.50962-1-krishnagopi487@gmail.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Tue, 28 Oct 2025 21:15:47 +0100
X-Gm-Features: AWmQ_bm2C0BdXgXZU7UzFGNl63fc1nW7YzeP97hg5BdICc-hcGNcMMHXSO8p6_0
Message-ID: <CA+fCnZeZ+c15X8BXg59ppbEmEUvp64aMaTPjXARyO_0x6KL+eQ@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: cap raw_io transfer length to KMALLOC_MAX_SIZE
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
Cc: gregkh@linuxfoundation.org, snovitoll@gmail.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	david.hunter.linux@gmail.com, khalid@kernel.org, 
	linux-kernel-mentees@lists.linux.dev, 
	syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 5:57=E2=80=AFPM Gopi Krishna Menon
<krishnagopi487@gmail.com> wrote:
>
> The previous commit removed the PAGE_SIZE limit on transfer length of
> raw_io buffer in order to avoid any problems with emulating USB devices
> whose full configuration descriptor exceeds PAGE_SIZE in length. However
> this also removes the upperbound on user supplied length, allowing very
> large values to be passed to the allocator.
>
> syzbot on fuzzing the transfer length with very large value (1.81GB)
> results in kmalloc() to fall back to the page allocator, which triggers
> a kernel warning as the page allocator cannot handle allocations more
> than MAX_PAGE_ORDER/KMALLOC_MAX_SIZE.

Ah, right.

>
> Since there is no limit imposed on the size of buffer for both control
> and non control transfers, cap the raw_io transfer length to
> KMALLOC_MAX_SIZE and return -EINVAL for larger transfer length to
> prevent any warnings from the page allocator.
>
> Fixes: 37b9dd0d114a ("usb: raw-gadget: do not limit transfer length")
> Tested-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
> Reported-by: syzbot+d8fd35fa6177afa8c92b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/68fc07a0.a70a0220.3bf6c6.01ab.GAE@goo=
gle.com/
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
>  drivers/usb/gadget/legacy/raw_gadget.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> index b71680c58de6..46f343ba48b3 100644
> --- a/drivers/usb/gadget/legacy/raw_gadget.c
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -40,6 +40,7 @@ MODULE_LICENSE("GPL");
>
>  static DEFINE_IDA(driver_id_numbers);
>  #define DRIVER_DRIVER_NAME_LENGTH_MAX  32
> +#define USB_RAW_IO_LENGTH_MAX KMALLOC_MAX_SIZE
>
>  #define RAW_EVENT_QUEUE_SIZE   16
>
> @@ -667,6 +668,8 @@ static void *raw_alloc_io_data(struct usb_raw_ep_io *=
io, void __user *ptr,
>                 return ERR_PTR(-EINVAL);
>         if (!usb_raw_io_flags_valid(io->flags))
>                 return ERR_PTR(-EINVAL);
> +       if (io->length > USB_RAW_IO_LENGTH_MAX)
> +               return ERR_PTR(-EINVAL);
>         if (get_from_user)
>                 data =3D memdup_user(ptr + sizeof(*io), io->length);
>         else {
> --
> 2.43.0
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thank you!

