Return-Path: <linux-kernel+bounces-863761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 856D7BF90B8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 00:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 872784F0BEB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133F429E109;
	Tue, 21 Oct 2025 22:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYmwI9Hi"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC4296BBA
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 22:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761085607; cv=none; b=gVzviocIgpEOTQfi2c8DXzNKnvN+pwpNqIYhrUX0sHLejJI3n+F0qv6mEqvKK6tj4qVLLo8ioTl/X1UEWMbdttbf2ikzlO6pKf8iS3xpRie3RDHWeegDasv6XFdjaNKlgUL0sdmn7iVKx0Ijq4Tj+iZQ7sWWmgKhjZvREi6DmjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761085607; c=relaxed/simple;
	bh=mwRp7aXDMeuqw9lPShCQa7Qn0mcGgCkUVUwaPDlvSCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PABLkYww026pw3VrPznsg9NWCAMLMmCx3vsLsZugxwnTNOggDDAJNqN84yYMgELIQpiey4YnJSWdU0kt0xwZOL0I42jYHMzpI4ymbPlej9tivixhZmtKZvYuX+QgF3q8OZfHd5MHv05K0ZmmJv41k/QOps9tAuG/K3F0o/tVWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYmwI9Hi; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47114a40161so18835835e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 15:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761085604; x=1761690404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk5EdGXRJO7qKp/sEruSVRBX2qsBvNyyYKbMfRHxLXk=;
        b=VYmwI9HiVbeWpkMwpgji4Ov2hrnphV8zjiboWWKIi+7zT8p03h5EGbECtvBT73wgv4
         XJ+d+wC6SS2gMU6srf1pmk6JaVgU8FMbMsbleyJVKJzClwZs6lpqsmtX5fTLxEkvTaXP
         TqNzZPhEd05kMOpHdkFWX4ahksFgKSPJjcLQLT215j/XW5Ntcq0O4538HAheAtiX8y4g
         ju8Bjc88sZNHF74nrdB0SBv7ve31OfpIOEiT4PNEF1bOSP6HpwO4AGOKejJXMC/0Zs7w
         STgph5a6+x5dS255kIp6HNPt9l6tPtQ7SsizSpUd3hAEOLedJQOB3ivz07CTBOawhyiH
         tegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761085604; x=1761690404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yk5EdGXRJO7qKp/sEruSVRBX2qsBvNyyYKbMfRHxLXk=;
        b=kOe51xNXo6qVTyzQeiM1kFaLb0HTcpYkFRC7rUOEfbU9PGSw73wBJl1NQldl2RwsEA
         SNC87SGoxOudIme+dD4df3GLnPNavETe33MD98KFvg+rKBVL4a5bTDc7k4f+xxwqMAyI
         oT8qRIeTSCLF/NxdhJTljJXE/yaMy/1x9MTNIEBkbv9+zoqCDSPYXmW0r2abAOUTDf6s
         Rd0S1IGJNPAIR8TwiDbfYMUWqogOjUcYiV6kR8xkiY5ubFaO5nXYDwVVMiaobmhNQ2Vr
         Rv7/q+VyvwD3rS5uZ2/cUrzsG0KvUFVpscsyRTvaUuCTRWkluiHkvDl+hYgWF2wC/+UX
         jAdg==
X-Forwarded-Encrypted: i=1; AJvYcCVIThrdZm4TmfXBKIMQFX2f0+N6hY+pnIVXMI0HAov7iXZ0FCdUC8ld0l9+BXsjs3XEnsdZLbuta2D9TFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0NraVUPpD4Jj/fIgVqnq3sfIOAOUcq+W2Hn8MrL6LAKjTXVts
	08irOen8gCxZ8blbO3UGF8r6bjrfB+uuP51Lh7L0SPJU7CxESDPrA0sdClxNAszXRYxKiDKsCbI
	JipSOcNsdLVOlJwSSp9r93VkdKQBjFQo=
X-Gm-Gg: ASbGncuYOsfhvIiPW+lg/PDxhh4aB82AWS0XndRjw2mtEZ2f1CIbCXcbCtdqxY67/yC
	x44ncLYN50hiBQzWG3QxlFt2cFVBdJvI4ZF/HqDS8W8jiGinrgbpuJxPDw0XyVAqJPkWbjhsk41
	pRakhYwk0HJlU7+3E2lcGZVhhMobtxCkQY5vSg05d5GU6/CWuYs7O7ZfRlUsAy5WD09Kb6S28ls
	FOdCEmv5kiWBF0TV9sqTWGfkttmpi2JzB0VxlxXr/D+SGOFhephkC30Ly4KeeX5xUuGmVbtMq38
	ct8pJL/NyrNEsHpVKG4=
X-Google-Smtp-Source: AGHT+IGYoeRkbinjZq4rfb3IpCbKu1sZPsyNIP34D3eTPladuTEWTWB5CAhB0AiDCHZrF11k6gXwYJbfXqyVdDGYlGQ=
X-Received: by 2002:a05:600c:4fd4:b0:46e:37fe:f0e6 with SMTP id
 5b1f17b1804b1-4711791391emr159678545e9.30.1761085603795; Tue, 21 Oct 2025
 15:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a6024e8eab679043e9b8a5defdb41c4bda62f02b.1757016152.git.andreyknvl@gmail.com>
 <CA+fCnZdG+X48_W_bSKYpziKohjp1QVgDzUzfYK_KOk42j58_ZA@mail.gmail.com>
 <CA+fCnZdHJtHgZuD9tiDGD8svXTEdP=GK8HSo71y_UfKgZcaUxg@mail.gmail.com> <2025102151-footpath-entomb-76da@gregkh>
In-Reply-To: <2025102151-footpath-entomb-76da@gregkh>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Wed, 22 Oct 2025 00:26:33 +0200
X-Gm-Features: AS18NWCf_UXS44wj9g_pn-uEAnNcwzugyYPMuelk7EE5VgyExzuwoWDIV5U5S9g
Message-ID: <CA+fCnZea_CXGFD5cgwamM_0VtkjcPR=tcOUqzEN+eNY+EtR2+Q@mail.gmail.com>
Subject: Re: [PATCH] usb: raw-gadget: do not limit transfer length
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	andrey.konovalov@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 6:06=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 21, 2025 at 04:19:13PM +0200, Andrey Konovalov wrote:
> > On Tue, Oct 21, 2025 at 4:18=E2=80=AFPM Andrey Konovalov <andreyknvl@gm=
ail.com> wrote:
> > >
> > > On Thu, Sep 4, 2025 at 10:08=E2=80=AFPM <andrey.konovalov@linux.dev> =
wrote:
> > > >
> > > > From: Andrey Konovalov <andreyknvl@gmail.com>
> > > >
> > > > Drop the check on the maximum transfer length in Raw Gadget for bot=
h
> > > > control and non-control transfers.
> > > >
> > > > Limiting the transfer length causes a problem with emulating USB de=
vices
> > > > whose full configuration descriptor exceeds PAGE_SIZE in length.
> > > >
> > > > Overall, there does not appear to be any reason to enforce any kind=
 of
> > > > transfer length limit on the Raw Gadget side for either control or
> > > > non-control transfers, so let's just drop the related check.
> > > >
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > > > Signed-off-by: Andrey Konovalov <andreyknvl@gmail.com>
> > > > ---
> > > >  drivers/usb/gadget/legacy/raw_gadget.c | 2 --
> > > >  1 file changed, 2 deletions(-)
> > > >
> > > > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/g=
adget/legacy/raw_gadget.c
> > > > index 20165e1582d9..b71680c58de6 100644
> > > > --- a/drivers/usb/gadget/legacy/raw_gadget.c
> > > > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > > > @@ -667,8 +667,6 @@ static void *raw_alloc_io_data(struct usb_raw_e=
p_io *io, void __user *ptr,
> > > >                 return ERR_PTR(-EINVAL);
> > > >         if (!usb_raw_io_flags_valid(io->flags))
> > > >                 return ERR_PTR(-EINVAL);
> > > > -       if (io->length > PAGE_SIZE)
> > > > -               return ERR_PTR(-EINVAL);
> > > >         if (get_from_user)
> > > >                 data =3D memdup_user(ptr + sizeof(*io), io->length)=
;
> > > >         else {
> > > > --
> > > > 2.43.0
> > > >
> > >
> > > Hi Greg,
> > >
> > > Could you pick up this patch?
> > >
> > > Thank you!
> >
> > (Greg to To:)
>
> Can you send it to the proper list again?  I didn't see it on the
> linux-usb list as it was never sent there :(

Sure, done!

