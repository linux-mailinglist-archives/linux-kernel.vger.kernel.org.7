Return-Path: <linux-kernel+bounces-889978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795D8C3EF92
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 09:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C693A6C96
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA0B30F819;
	Fri,  7 Nov 2025 08:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J8JVsxW3"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944662BFC70
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 08:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762504383; cv=none; b=L++2TdT2PQA7SZtozkIPrpy35k/I6n1e3kZT4pxK5BBMGq5h1ePEPRWhhq6qidmxnpsUdN0XoqAZ9G1ZSLmUGsuZW/ygGxWLRsR7pQoPlsp2quXvkUlHTISwQZ7MYelUciiYRSGz9ht691qUgd9FC97H6TafFuINAT6HxOz7Vx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762504383; c=relaxed/simple;
	bh=pbWr/TE0Q2z0x6R+IpA7S1OT9dnnBI9KE52yQjeEbGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UD6udwZ8TarEmDYk7v6h7iHvRXUKSCs52gLHcmj5DR3yoVTEUZ9PiXvG0CVZ4a039ilEVkssykto4lIJ0VXVN149t6p5fcm6rkyRZx9PxhCjiUhvyDsnk+TboiJA8U46OvOp3ik1jxZbC7RKiTjJvPZgi+DbtyveTj/GBG3FFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J8JVsxW3; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b994baabfcfso314188a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 00:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762504381; x=1763109181; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QiFFFZfbJYTgNgjkvynOKEvJ6sYmA2OtVtFdpgrjxyI=;
        b=J8JVsxW3KoaxiOD0DP16Wd5lr89f5QF9cW1Z34yrvsyq5g9lxWvFkOKiIQicBxXFAU
         VISYC7bLaCpzl+GQUPrZVrvwiTu7ogMIx1f7BGfKbv7IoTLj4SpwfpCLC4Kn7kRKk5lE
         O9B0CHOrKcefUQoFZZLUecMwYsrzUNwcOfdT0SZIRV0GBjCMFxO3NdnAV54uhkAGSzXq
         K0SMzPPZDNwQlVlCIlHQdVOpcee1badOligNUy/hgcHRPZvwTm3GXHfHLlHqp/N2G9Q+
         LCXQ++xvHBz8vTWq23QYq94fRFcFikKSjIDdj9CorEqkYyppcsVeR564X7Sh/Z7eiGvP
         QT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762504381; x=1763109181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QiFFFZfbJYTgNgjkvynOKEvJ6sYmA2OtVtFdpgrjxyI=;
        b=tfUDHPKArAHxwccl4hcIpH1K8i71cNpGWgOM8zysLPJ7fxJsVHYIYTzu65jifQIZhf
         mq1F+5MGthHOMAvkwNL/lSYs1hPzibJkH/5m7rA41ukMepywZIOokR6c6P5DeL2ssf9C
         slsgoKJFScnnhDdjWJxKkDJSVWLvwRkcHch5/J44PsfqkOdP5IWzR/tYibf7fyA+/+rP
         r3R95i0eOLWmONJ8KpVi7yoDCIBEVsFC1zxscnN1B8aN2CQ/Dgw7o6ohWSuIPWuFG6A+
         +ZZu5RsFboXGPT5YvzNI8kZOmmVbeOj1LdiZca4AVh66+RfWzuOGJJvvsUbIl0bfTcrh
         njYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1mNGh3hHkl+KU4cU+sE0LcpZVo0mqwPgwPs1zVeDrgI6PAb0zEg5fJtwVrqqMoK1xjRRouD9l4XwWpl4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Ofr7EXL8gXdTcgY34FU+zaVuRJRXv7n/l0uKkcz0VpOQHhXB
	TKJuzr7SwRdC785mxjDW3b+xUHKADFaYQ+2HnUJjGo2uIFDFl7sP53QZFIDBUAsT/DtwdkaUZjf
	Yg0/ERdT19YOykq98JGDBBLUV2/kcZGc=
X-Gm-Gg: ASbGncvRO8/CHcXC5u5ZowZ40HzxbQg5xz4QhAZYrWs/xPyOMUQaAo+6Pgr+1rvgLPD
	Yc6td6Po7s1ZelCiwn6rCNo5DO9uKKzne9ukZReksHfkRff24zyZp0lLEW9eq74RUyNE3Y3J8AQ
	N4LCitG3UAAAonc7IEfAgn7DzDCjDFKl6CQ7A5zSgYEBiIAo7MJk7HQZftjmzJx4NeMpj5nCevc
	9BU5h7c6bHlkjzmg8AGa5KxwYzp6yJGu3H/bC+Cn96cAvNYuAWlqBnsQHmYpNeBvu2BmhM=
X-Google-Smtp-Source: AGHT+IHyDIIizr0tEJrJgOxhiQ2tNOEOeDfT7xB1P+WgbdSo29IJ7VFkjIMhqlfphw/t91fN74y/sss2by5tkWnrRHk=
X-Received: by 2002:a17:902:f645:b0:295:5da6:5ff3 with SMTP id
 d9443c01a7336-297c0292ed9mr33017155ad.0.1762504380817; Fri, 07 Nov 2025
 00:33:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106054940.2728641-1-linchengming884@gmail.com>
 <20251106054940.2728641-2-linchengming884@gmail.com> <87o6pf8r24.fsf@bootlin.com>
 <CAAyq3Sb8-FRC+bZt_bEvOdBNVSN4xa5F_TpBbKF__HzhVPEpTw@mail.gmail.com> <874ir68d4u.fsf@bootlin.com>
In-Reply-To: <874ir68d4u.fsf@bootlin.com>
From: Cheng Ming Lin <linchengming884@gmail.com>
Date: Fri, 7 Nov 2025 16:28:23 +0800
X-Gm-Features: AWmQ_blyRFNdq6bG7DRRVA8-bAzYofiDnApOK9hfVftd1T4Sua3lGtTQ0JnqN7A
Message-ID: <CAAyq3SZ33K4Ot8OgZnv1-CR5mJt0wNaPC55CMXMzpjbhBgiYOg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mtd: ubi: skip programming unused bits in ubi headers
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: richard@nod.at, chengzhihao1@huawei.com, vigneshr@ti.com, 
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
	alvinzhou@mxic.com.tw, leoyu@mxic.com.tw, 
	Cheng Ming Lin <chengminglin@mxic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

Miquel Raynal <miquel.raynal@bootlin.com> =E6=96=BC 2025=E5=B9=B411=E6=9C=
=887=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=884:23=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Hello,
>
> >> > +     if (ubi->vid_hdr_shift)
> >> > +             memset((char *)p, 0xFF, ubi->vid_hdr_alsize - UBI_VID_=
HDR_SIZE);
> >> > +     else
> >> > +             memset((char *)p + UBI_VID_HDR_SIZE, 0xFF, ubi->vid_hd=
r_alsize - UBI_VID_HDR_SIZE);
> >>
> >> Here I am reaching the limits of my UBI knowledge, so I would prefer
> >> Richard to (in)validate what I am saying, but AFAIU, the VID header ca=
n
> >> be literally anywhere in the page, not just at the start or end of a
> >> subpage, so in the vid_hdr_shift I would expect some extra maths to
> >> happen, no?
> >
> > I understand your point now. If the VID header is not guaranteed to be
> > at the start or end of a subpage, then yes, my current logic needs to b=
e
> > reworked to cover that case.
>
> I don't know if this is easy to do, but maybe you can memset the whole
> buffer before filling it. That would avoid the need to know where the
> VID header will be.

At this point I have two possible directions.

The first approach is to keep doing it in two parts, like:

memset((char *)p, 0xFF, ubi->vid_hdr_shift);
memset((char *)p + ubi->vid_hdr_shift + UBI_VID_HDR_SIZE, 0xFF,
       ubi->vid_hdr_alsize - (ubi->vid_hdr_shift + UBI_VID_HDR_SIZE));

The second approach would be to modify ubi_init_vid_buf() in ubi/ubi.h,
so that its memset fills the buffer with 0xFF from the beginning.

The second one is cleaner, but ubi_init_vid_buf() is not always called
before ubi_io_write_vid_hdr(), so I am checking right now whether this
would affect other paths.

>
> Thanks,
> Miqu=C3=A8l

Thanks,
Cheng Ming Lin

