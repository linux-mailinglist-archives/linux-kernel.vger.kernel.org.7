Return-Path: <linux-kernel+bounces-793039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E05B3CCD5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC2C7C4B8B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 16:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FCC25CC4D;
	Sat, 30 Aug 2025 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdQQz/k5"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE6B17A316
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756570747; cv=none; b=EbJAQk0a0mNmZ1GHRsrPrQXhU2kG9yxeUw5W8B/HqFNUGCKLRD7pU0GFdI79vo7HiFf9LYPToN2ZG7C0ZydbwrY/z7sdxN6fhbNmdC8EQ9rqVLJwKVfvpVgdP0R1+mrAxewZp8hO+nm9OQoIHoRQUXvCKKvSOhxOqico52PSPOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756570747; c=relaxed/simple;
	bh=kxMw/WIXfPBihRmGlFTttWDAAJ/Xm4Bt05BxcD1pFPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rz4mcsvnAoUV+lDB/Bxs246xLHkeKL8wDk8CrX3TAu7+O0uqIJBYV8a5/adiDQrfEQn4lUSc1vlAYn2o5sAa7ZjmA/YtVlLwGSenixBkHk6zW2E7b2BMnvNrTSrSA8/wpjINeYNJV+mfGA2BODIB3uwt4TedYFVSIgnziorVTe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdQQz/k5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so428785966b.3
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 09:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756570744; x=1757175544; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxMzt/GBIj0UW9I3M//LQeJ7sMlKGd3ps0QKVHkOyqQ=;
        b=HdQQz/k5t0prJHKK4Vd1/WzjJQMqD0Y2jle28w3bDwH+3LMaFrQlOCMlJneRHgd+7O
         5vn+tGIzkl42gz523tjJ5PrupPn3CzKXDNICXK29ZSI7CGTnAseKQWVJm1XoFF5aFF+a
         wR7L6vxeCARKHZYG3uzQF4AdV7Jb2s4yaBmnbO7ceh2k0JB+Hd0nPXospkJwNIJPi8nz
         o0AUZawZthNja8VpKzoHdiY0kfvkKzfqRsptJe4unaV64Rog3M6Mmk7Z7DYgeEbhYLM3
         L3bSc52sePcIwCNO0Hanbpyf377XOKlnCis8WigMWXwzHIWhR2EJgkCKGR01vKPYSGbl
         F7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756570744; x=1757175544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jxMzt/GBIj0UW9I3M//LQeJ7sMlKGd3ps0QKVHkOyqQ=;
        b=xLTnLF/UnNbv1xeRxSkROym+ZfxGhRE6wcUOA8oQu8h8/I+QjlShwECrao8NMbdBNx
         lOxyULNFGPoWWfijHcxVoeAQjV2VYKSIcDJUHmoWXb5JgelaTxnuFPwuFGZY5kMmSq1y
         p9tAWxszJuQ4BeoqZxtejE8xYeMF6AF5IdiPXYAzgDFx6F3lF3eeM8ynjJYgj8rrv85z
         Haj3V19aFZR++EVrwiYD6M5oSadxFzHc6oho6oWBQ/E9V5hRLex5qm5N3jhXu00lIeMz
         HZx3MXRGtxGBSXjmQmRaW0wFzCPkj+CvosIoJlbAUIBN5tN2fD3C992H/LXOG7S3Y5v8
         EZWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwSbOeKbDKzOZnK+b1y3HKPA6qYKP2jJ9c1CARZVuAyZxrdRc2CQsBGBbFdu86uSWbpcmdcA5PK9/BeGI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+PCrUGrQF48ABz2flPl3n86mltl035jy5MUfNbx3vIPkzokzb
	io1y/oq4WKVsR3Ry/qa8K0Th9d35yAtAN4Sl4swzjD7Hb6LaF+aA0MiCZLDcseIn2stTHQdSEYc
	ZFVbOMqn83GJ03i7rIrw441bkm3xsfBo=
X-Gm-Gg: ASbGncuQ9CRO3Drr0OUvTjcY6D24cxhGbLLPMOyfxOHTxl6zsFVTAN4Me6U5LNPcqmf
	B3Nio5MVtJueTEV+PD9CkfT5Z7jLLGVz27larf+0AqQrO0P22UvWbGjp5xTweHMEUcVEXfxt9yK
	nwd9GpgPULmC5126EksM02xZIowDBm+/OfrcEglk5HO/+rEpl3RFTsUB7ptaBfCN2wMB2htPu0/
	fpcfrQ4Ep2cI/HHEQ==
X-Google-Smtp-Source: AGHT+IHkRKxVU+reQMPK1zuncnBkqvqcBpNprsfqqAW3ZzU8ka+7OuD0N9oxMQC02pQVZTWF1WCQx+ZbR8CcCGe6wkA=
X-Received: by 2002:a17:907:7fac:b0:afe:b133:22f0 with SMTP id
 a640c23a62f3a-b01d8a2fce5mr251570966b.5.1756570743860; Sat, 30 Aug 2025
 09:19:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829010324.15595-1-jefflessard3@gmail.com>
 <CAHp75VdF=_LQbHJozUGExCmDd4UW4oJ0-deT=aEdnQjCOotsVA@mail.gmail.com>
 <67046EE4-FBE6-41FA-AB03-B0E01FA1C274@gmail.com> <CAHp75Vc3DHUJwA+S4PGfoZxGtdqVq3GTF6_BEnJFo+=sFMmfDA@mail.gmail.com>
 <587AE3BE-CD1F-4160-AA21-12B875E4EE81@gmail.com>
In-Reply-To: <587AE3BE-CD1F-4160-AA21-12B875E4EE81@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 30 Aug 2025 19:18:27 +0300
X-Gm-Features: Ac12FXzlcuYb650sDHFx-07awMBUqRh0mhRQ25JN_jcMBj-2bBzwdUf6HL8FUHw
Message-ID: <CAHp75VeetsQ0NgVEnhic3wdUs-w0q7nQoGX4rO3aNdq8feypRg@mail.gmail.com>
Subject: Re: [RFC PATCH] auxdisplay: line-display: support attribute
 attachment to existing device
To: =?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 30, 2025 at 6:21=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
<jefflessard3@gmail.com> wrote:
> Le 30 ao=C3=BBt 2025 10 h 39 min 20 s HAE, Andy Shevchenko <andy.shevchen=
ko@gmail.com> a =C3=A9crit :
> >On Sat, Aug 30, 2025 at 4:55=E2=80=AFPM Jean-Fran=C3=A7ois Lessard
> ><jefflessard3@gmail.com> wrote:
> >> Le 30 ao=C3=BBt 2025 05 h 15 min 23 s HAE, Andy Shevchenko <andy.shevc=
henko@gmail.com> a =C3=A9crit :
> >> >On Fri, Aug 29, 2025 at 4:03=E2=80=AFAM Jean-Fran=C3=A7ois Lessard
> >> ><jefflessard3@gmail.com> wrote:

...

> >> If needed to be split into multiple patches, it could be:
> >> 1. Add attach/detach capability
> >> 2. Add num_chars sysfs attribute + ABI doc
> >
> >Yeah, the commit message was a list of 5 things, hence 5 patches. I
> >haven't read closely to map each listed feature to the possible
> >change.  The description of to_linedisp() sounds like it can be split
> >to a separate patch. I really want to see the attachment/detachment
> >patch separate with the explanation "why?". I am not sure I see the
> >point.
>
> I will shorten commit message and clarify the "why":
>
> Enable linedisp library integration into existing kernel devices
> (like LED class) to provide uniform 7-segment userspace API without creat=
ing

a uniform

> separate child devices, meeting consistent interface while maintaining

the consistent

> coherent device hierarchies.
>
> This allows uniform 7-segment API across all drivers while solving device
> proliferation and fragmented userspace interfaces.

Yes, this is a good start.

> Note that there is no point in introducing to_linedisp() based on attachm=
ents
> without attach/detach capability. Current implementation is actually corr=
ect
> if only supporting registration of child devices.

This can be made in a series, so the order will suggest the
dependencies immediately.

...

> >> I am also thinking to add a 3rd one to pad the message when length is =
smaller
> >> than num_chars. Current behavior is to wrap around which seems weird t=
o me.
> >> E.g. for 4 chars:
> >>
> >> Current behavior:
> >> cat "123" > message
> >> results in "1231" being displayed
> >>
> >> Padded behavior:
> >> cat "123" > message
> >> would result in "123<blank>" being displayed
> >>
> >> Any thoughts on that?
> >
> >It's basically the question of circular vs. one time message exposure.
> >When it's one time, the padding makes sense, otherwise the current
> >(circular) behaviour seems normal to me.
>
> I get your point but I should have noted that current behavior is to wrap=
 but
> does NOT scroll. That's why it seems wrong to me. It should either wrap A=
ND
> scroll, or otherwise simply pad.

Ah, that's an interesting observation. I think we need to ask Geert
and others about their opinions on this. To me it seems like you have
a point.

...

> >> >> +       &dev_attr_num_chars.attr,
> >> >
> >> >This needs a Documentation update for a new ABI.
> >>
> >> Agreed. I think it's also worth documenting the other ABIs along the w=
ay since
> >> they are not documented yet. Then, what Contact should be documented?
> >> Is there an auxdisplay mailing list?
> >
> >Your or no-one's? Is it a mandatory field? In any case the ABI must be
> >documented, w.o. doing that any good patch is simply NAK
> >automatically.
>
> I thought contact was mandatory but after looking closer, there are multi=
ple
> existing precedents where there is no documented contact. I think it woul=
d be
> appropriate to add my contact to the added num_chars property documentati=
on,
> but to add documentation of the other existing properties with no contact=
.

Good for me.

--=20
With Best Regards,
Andy Shevchenko

