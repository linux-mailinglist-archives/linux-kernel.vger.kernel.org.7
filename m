Return-Path: <linux-kernel+bounces-873427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CDFC13E99
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E0474F9380
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BD328467C;
	Tue, 28 Oct 2025 09:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH++043s"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9AB202F70
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761644828; cv=none; b=Yz80jUrKz5JwPvG4a1QCl5p0HFlFTs04pJ2BI0dz1SbKOjIr0xhTGo3MaEpxiLYsvC5wnOf/7oF0L1XniToKITJxJJ9J6Mgi13BIPQk1PbG0RK24D5snIXrpSpf6GRbG0fN7B+okALWZ94Hc8DLs+m1HaKbHx5VVu/lrPmulehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761644828; c=relaxed/simple;
	bh=hSWOe53S2QH3pVgKVB9TrVijS+TcXb/7kNtx/H2jVds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/lvZxNaPa/kB8A2x3+S0dq9pepdtHmr2Xn5nk1Ls1kaXURlQUyqeTzyPoWuiZc/W8PEDTyiFAXMk8IMYOk0OuGdzplrfnt8FdWbSyShEOLApVfZzLi3IsI+TgZJp9vc/wjc2OSc+yxE6fAAUOyz3Ott2AcvKZ+Wg5ijjyfehT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gH++043s; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-650409430f6so2781205eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761644826; x=1762249626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRcEviLpCpzNbLcGaqosnVGor2ewNPnssN8Q7KbkRtE=;
        b=gH++043stkwOBSwbobKc79hFO2W3CPytqSSxp8/WBT/76s2CyWMiPq6n0LdlW54xQ7
         P7pgXMCcbLNyPjFAy9Cxk5ozWkujCN/U/H8yiPFV1Q96UFpFky5Y5Xd6U9RJXMERTLau
         NFSH1WHp6+wJ53hcqjsjci23GigykdSIwRqahcQkltJK+qoZEgH8WEOye/TIFZumDvei
         Yfo/okhTq8koEQKNW+8/dfa2Yu3NhmpnECGKc0pLBjp3VMQIn9Hjzv0iTyt3sgXjW3VU
         0P4NRq1Dk0PxDt7tZcurw5cURtJozQ6GUHMl2KkDkRxO6NGoqJPUMK2UA2DS5d1i7zG0
         Cwuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761644826; x=1762249626;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRcEviLpCpzNbLcGaqosnVGor2ewNPnssN8Q7KbkRtE=;
        b=l8QC2kiSevfInslJA8O72p9T3aqZ/lDzLMHRY6cixW2yMhELAeH6y2ZeWVVQmhfvxy
         ogtmm/13i5tBibw+rzNzwcX6/aJvEIVJYii5DZXE/v28YtTGdOJ3tgusEgMrPeFAVvGq
         FCL0q5R22rWOl5mryTIIZv/oWPt+h8GNc2C2vZNSvSgfAIbL4lPQSNv4G4Gvsf2+vxlc
         ovbfofWWQiBZU6zzBX1jFspHnyezT01yEY6lBmfSAsznu7Es1RcfjmmmSoWXzvVyRtSL
         kAKtoSgeWCBUNws7lO2wE3uy82jT8daJf0ug/Lku3eQ21U2H2jVVOvLkU7M9JLz0BP0K
         OMIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWNd+PxLidfL+5z0+pvpERwX1rRUN26J3ona3JDgec0ptQlg0s6TFVObGr7LSs6gkY66pR2IvNsILEk0NQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdZBlmNyP/bjrVaO72jhBmsuUkb7RW0wKXYGWaIf/wB0G4N8Rv
	W1CzOl08v7Y5u/q1BO97EyBkRIk2pITEUZ2Ski2SgoOypuE2BRJhcoevJ78MJwii51dUwg/vThB
	qAIjoj3Kgr2p+j7e+zRE89apSiQ4JZDg=
X-Gm-Gg: ASbGncukAkDuHwnbTwIVEEUlwHpWIjDWgVPwQTuUlZzXDObB1qZl/q3Cpy3mVXW9H1H
	ciUqw/tFmJjXcEqrF0sHSsrMhrnICNFNV4EKiEu1rl4bFZnTFeTD5MtwDvJ7gdyPqbwKuaat+Q4
	e5UylmXPKSL5fT+rYLtGz9Ao2J9yankll5WeacFSApJKly9UIg/DBAY45bC7EWEvGrCiso+weyf
	iG5eiJE2qiiVBLkW324qMX1UkbQKxapJuX+91DULkllQUvrgsaoCGzpE1Aq
X-Google-Smtp-Source: AGHT+IFw8a2DTtRPDokUw0E0HICi9syLpcF47ySoZkOb+tzllRPpMha+vYjNZRtSyWsUbq0R+JTaLVdCjMUDXP0/UC0=
X-Received: by 2002:a05:6820:2188:b0:654:18f9:cfdc with SMTP id
 006d021491bc7-6566f2a0dc4mr1298750eaf.4.1761644825696; Tue, 28 Oct 2025
 02:47:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027150713.59067-1-linmq006@gmail.com> <aQB8PRlaBY_9-L8d@smile.fi.intel.com>
 <aQB8j7Hc3b9vAT5_@smile.fi.intel.com> <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
In-Reply-To: <aQCHt9JL0Bc4Pduv@smile.fi.intel.com>
From: =?UTF-8?B?5p6X5aaZ5YCp?= <linmq006@gmail.com>
Date: Tue, 28 Oct 2025 17:46:53 +0800
X-Gm-Features: AWmQ_bkMzCWltp8_0lWU6LTq8diCXGtcBzjewll59CoFnsgQA3j4_8Ni5MdIpMM
Message-ID: <CAH-r-ZEG5qN5QNCJTnX_oK2uyheNjvzoAEgzuyTYyUWF4kf+wQ@mail.gmail.com>
Subject: Re: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Markus Burri <markus.burri@mt.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Andy

Thanks for you review.

Andy Shevchenko <andriy.shevchenko@intel.com> =E4=BA=8E2025=E5=B9=B410=E6=
=9C=8828=E6=97=A5=E5=91=A8=E4=BA=8C 17:07=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Oct 28, 2025 at 10:19:27AM +0200, Andy Shevchenko wrote:
> > On Tue, Oct 28, 2025 at 10:18:05AM +0200, Andy Shevchenko wrote:
> > > On Mon, Oct 27, 2025 at 11:07:13PM +0800, Miaoqian Lin wrote:
>
> +Cc: Markus Burri for the da9374819eb3
>
> ...
>
> > > > + if (count >=3D sizeof(buf))
> > > > +         return -ENOSPC;
> > >
> > > But this makes the validation too strict now.
> > >
> > > >   ret =3D simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbu=
f,
> > > >                                count);
> > >
> > > You definitely failed to read the code that implements the above.
> > >

I previously read the simple_write_to_buffer(), but add the check and
think it can help to catch error eariler. My mistake.

> > > >   if (ret < 0)
> > > >           return ret;
> >
> > > > - buf[count] =3D '\0';
> > > > + buf[ret] =3D '\0';
> >
> > Maybe this line is what we might need, but I haven't checked deeper if =
it's a
> > problem.
>
> So, copy_to_user() and copy_from_user() are always inlined macros.
> The simple_write_to_buffer() is not. The question here is how
> the __builit_object_size() will behave on the address given as a paramete=
r to
> copy_from_user() in simple_write_to_buffer().
>
> If it may detect reliably that the buffer is the size it has. I believe i=
t's
> easy for the byte arrays on stack.
>
> That said, without proof that compiler is unable to determine the destina=
tion
> buffer size, this patch and the one by Markus are simple noise which actu=
ally
> changes an error code on the overflow condition.
>
> The only line that assigns NUL character might be useful in some cases
> (definitely when buffer comes through indirect calls from a heap, etc).
>

I believe it is still necessray to use buf[ret] =3D '\0'; intead of
buf[count] =3D '\0';
If you argee with this, I send a v2 with just this fix. Thanks.

> > > NAK.
> > >
> > > This patch is an unneeded churn.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

