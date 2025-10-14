Return-Path: <linux-kernel+bounces-851584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF936BD6D50
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E74F5BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EADB224FA;
	Tue, 14 Oct 2025 00:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvKRBlXO"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367A61A26B
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760400447; cv=none; b=UBModwaZMoR4HTbXy7Zdk8HNxKxmuxU9b7latBE8B2Wz5MytqTGZo7UI/0d/grL73NC5h8nV1hQijnlEMrXg0cW6j40e7s6Z0oo46kJxkL0z0umgBZaXGmBaMdF7IDMkoO+hscF1Ejy3atOHUSHB54il4KdDXiPtpk0bLzq4LsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760400447; c=relaxed/simple;
	bh=sddReqsaz8eLzv5j+uCqjuSBZlVdS1F7COeMoD+e74U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCxOUYo2U1dBbCQ0ZvydDTKRW0lb6wAcn+XfYLjQepbwp66oqZp4hq3b44x+tKzwt0+G0Kl4XB55ox8dOy8RCS/z2VfNPEhtyi7ibpgoG5zbrIkrDuUG1IMTEB+5g+FnNv49N/bfsDmXQy1nwD7zPC0iaKNdNT8NYki+F7kj/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HvKRBlXO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-46e3bcf272aso150685e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 17:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760400444; x=1761005244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMm+3DwYc57Ap+tGlaHsprQ869OBpYwPHVEmSgDdMcs=;
        b=HvKRBlXOzv3CtAnwhi3XfzLUYZdpvcn0gulLNgjrPnUBAUhffZUEd+72G8GLXelWID
         7B09lESuTvNl3tci+v4Mc9xHcCSgddqYNhTNwovYilJt9hEZZthEMMyc4tCwUklCbEis
         8EBARVJgA8QlKbPql+gSdYsawmMnrgHvdnnE+IvuagO6qXZXwVeftT7Zr1Yu69VG/KEM
         S8kXyJv8HG5J+hRLqkgsykaHqsDaWN57m1/eQnx3CCxhG37tpTJWFGPZsOB2pWVoATOb
         m/yJsKCpa5GwU4HpYySFociwZj3MwURnADVhc4kVzkLNLP21FFgTl2hfvqM3A05YAAbW
         xgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760400444; x=1761005244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMm+3DwYc57Ap+tGlaHsprQ869OBpYwPHVEmSgDdMcs=;
        b=akIaaXlE6sf5JI/f4vVAV6anY7T3AEYcxpm+pFSisaOyab8fgSrc3bK+bLgYFi5+SD
         IRCHtbqqiDCH8nVR+m75wz0zvI6FLzi0g0ybdFwFwl0p6xa8sjw0KJcgbyG3dtB4PNXG
         XYO4/7ny4YNixcaxfvbPAB/X49Hi2praDd3GL3m5w6Gu7bwatkCfuiETL5Vmm5I0V1TC
         gDD1lot+qUlARD3GT0Yvuh/ItRvfTOW4lfXRXZC4ynIk8wMK0dvmRytNytwCPC9ehBsN
         SzGCnvFtX4V/fu49fl03GNWcwaMXfmikJVN/uYHvu5QcG5cnyW/1wi6xOlP8bESwC7PG
         gUyw==
X-Forwarded-Encrypted: i=1; AJvYcCWYJ2rG0lZXqUFMnAK1BvqJcF/mcpi+rquWQMcJ00KNrjAk+wb0o3OUZ5PfnT7Kx4RH+37Xci2jbWWr1rY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Fd3mEJ3VZZ1jXOqqD05MCNo1Ua8DkI30KhxwQPAa+E/Mj9qn
	4jYFnCHDfh8F5IebG0RZXmqbyu0MRqw5sZO921RylZjgCVhAlAjG7BgIHTvQPlrICdMKETBOOZs
	DA5XhwBTvpJfcelC0i1aTHmEcVYMVPu2LfOqHiWyLUsiXB8MYf0ZH+2FIpOs=
X-Gm-Gg: ASbGncsxkoDCcNdJaRUa6TEhUbNNoCvkiRh+k+MSwsMq/wMb1KGX/Akr6JTx8zZ9TUb
	9Mg5Y4Itsme1PzmKMtBjFXZhCBHYk2wxNz6wdrklIudP06Xe/KoAZlQpQgF6mUUuyY5WEg3rrdW
	fgSpfMaqztO2Ma8IlWbjXHgk7cpSk/w3j03muAVQRsOB0d/VUZzTkl4b4Z9eUVNMVJJU7N1wOtY
	bv/eRRWg3jUVZa3tj6UeuqaowfUvk0BU3woPX0MI6S1ky6JU80oE1zCfGyve0dJplln9xMmdbG8
X-Google-Smtp-Source: AGHT+IEfUpm7jUZSRfnU0C0FFysE4UdCaRG1nCop1BnDe0FupZuPsPJRbm12NwMwO0cQ4O9JYCiPLSfXNWeTUgmSYMc=
X-Received: by 2002:a05:600c:258:b0:45f:2e6d:ca01 with SMTP id
 5b1f17b1804b1-46fa9b27c4dmr9968455e9.4.1760400444288; Mon, 13 Oct 2025
 17:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013-usbcore-tracing-v1-0-b885a3121b09@google.com>
 <20251013-usbcore-tracing-v1-1-b885a3121b09@google.com> <24db7c90-16d6-4122-8bda-aee2a2c930bf@rowland.harvard.edu>
In-Reply-To: <24db7c90-16d6-4122-8bda-aee2a2c930bf@rowland.harvard.edu>
From: Kuen-Han Tsai <khtsai@google.com>
Date: Tue, 14 Oct 2025 08:06:57 +0800
X-Gm-Features: AS18NWB0Kxa7h3QNdNpyTtcwVGiNqLivxymxe8yrp9JvNSNy-LBpInicvco97IM
Message-ID: <CAKzKK0o5vTe-nxE7nBOUqb=Y3dnT_F-KUtOThSe0vXs9-z6gdg@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb: core: Centralize device state update logic
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Mathias Nyman <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Alan,

On Mon, Oct 13, 2025 at 9:16=E2=80=AFPM Alan Stern <stern@rowland.harvard.e=
du> wrote:
>
> On Mon, Oct 13, 2025 at 10:01:22AM +0800, Kuen-Han Tsai wrote:
> > Introduce a new static inline function, update_usb_device_state(), to
> > centralize the process of changing a device's state, including the
> > management of active_duration during suspend/resume transitions.
> >
> > This change prepares for adding tracepoints, allowing tracing logic to
> > be added in a single, central location within the new helper function.
> >
> > Signed-off-by: Kuen-Han Tsai <khtsai@google.com>
> > ---
> >  drivers/usb/core/hub.c | 28 ++++++++++++++++------------
> >  1 file changed, 16 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> > index 256fe8c86828d51c33442345acdb7f3fe80a98ce..ce3d94c960470e9be7979b1=
021551eab5fd03517 100644
> > --- a/drivers/usb/core/hub.c
> > +++ b/drivers/usb/core/hub.c
> > @@ -2147,6 +2147,20 @@ static void update_port_device_state(struct usb_=
device *udev)
> >       }
> >  }
> >
> > +static inline void update_usb_device_state(struct usb_device *udev,
> > +                                        enum usb_device_state new_stat=
e)
> > +{
> > +     if (udev->state =3D=3D USB_STATE_SUSPENDED &&
> > +         new_state !=3D USB_STATE_SUSPENDED)
> > +             udev->active_duration -=3D jiffies;
> > +     else if (new_state =3D=3D USB_STATE_SUSPENDED &&
> > +              udev->state !=3D USB_STATE_SUSPENDED)
> > +             udev->active_duration +=3D jiffies;
> > +
> > +     udev->state =3D new_state;
> > +     update_port_device_state(udev);
> > +}
>
> This seems complicated enough to be a standalone function, not inline.
>

Thanks for the suggestion. I will change it into a static void function.

Regards,
Kuen-Han

