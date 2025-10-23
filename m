Return-Path: <linux-kernel+bounces-867075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D80C01855
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1F783ADBAD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E75F30F934;
	Thu, 23 Oct 2025 13:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/PIu6Ez"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DB1C6FE5
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227202; cv=none; b=b3m+162VmkNmXw9kYblpd3JTi3t3TaShCuzrn4WeYpHkvplfHXF3wLBjkFLCKp+zmmeaYfkPeazsRS+0OxruXpMkiAqI7UhRDnbkccIIIZI4QBw6O1Frffza9NfU0nBFKZMyzlOCVdTDG9Of7ZjyYpmDjjwjKj6FkIKC5uZFmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227202; c=relaxed/simple;
	bh=/uOTs1q5SVrzj5CFd9wdgrKkBcR+k/U9EPm9zsJPeB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NFmqspC/usb9dNAayGNd4DZIxHT6+BjNY3tnRC+aKTMyfHy+cwT4E7IASdJTueb7KLy3OG6fj03YdrKIiAAG6TDYE+l5aAwJKZC+2fz1rMBX/0Z48Fwsoi8QPO3Sa0DBoxrGiChPlftBEqU1rG/WFvfx5oaFpnE8iVGMHMbGZh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/PIu6Ez; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-71d60157747so8056157b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761227200; x=1761832000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jy6lC3A57Ib1X/ldziMbYIxUXh2m/UTOp45qtZcaD8o=;
        b=K/PIu6EzjyWzQ8S1T71vCraPKEXaPNjiK0q4m0867x4gn8Rm85azacE17vnewdVrAD
         oPKss9xWoa/G04rgKjGtmmlVa1R7KRMlMu3DmZswIdKKo8DYmaN+kA9m2RcCE4e2Nn0q
         h85oSvqqwDE6KH4eF6aRT+M0ZUjvYvXTROswFVTQ48U9ZyCODXUIn5TWIEViqU08G2iL
         cOgS+MHrteqYemecSefgdCKVIDc5NG56Ylt9Lebwd1+N5qmBDqekExqfXFz3ua/ABuwk
         WXA4MopywCq8nXuccTVnb1HD0NsEQFGcovdldEV1PN8GMHtO1nUT67lArTeDIAV89gev
         X94A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227200; x=1761832000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jy6lC3A57Ib1X/ldziMbYIxUXh2m/UTOp45qtZcaD8o=;
        b=spvVXa6lNmkuL+mTaQ4tI+KvM08LqU+HVQAcoZeQ87x8/ZZ4gZaVED5eAdybD4iP7R
         xhhq3mX4eEZxBIdBCTvyA+9LhuisdSZE4lBXbQuM+HedfjPcP82GlOg2Zmh+WaGHf0Gs
         7dWSyRZE+DrloM/+UAb9OTSbvgO5bBIpwk7kBjuk9EfuugLyDz8Pfvwre5xNMhgYOzRB
         tr83T0VfjGmzcv3ARKlEt6XU/JNH6bpl/6bz3Hg7rPlZq3ULmKgn8yINnnJfA61pwL21
         fDVkndx0lgKrlzUSrDYaSUtq/PQQHbGIQsSNiDtwgMT58bEfTtuyGxb51hKTfOS6uM0Y
         cWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyW8rWffUL1UBiw80dQOi25VFIAjIG2WU3hijKFnDVBrvvm/yRq8IDCR5Dnz0T9WGfa2whSBULF6GePoE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2UT/xwfl59YpiRbw9TbJw0d9amECJVAN3PJUFNmxlL3niZ6g3
	qTOpfGX2Ib722YQKXE3ESaHlpVXDwnXeRjL7fUHZucpN0KdjMZsbqXFZ2HURe4xCqmOGWrlcCo6
	+vS52xN0OJvNV45OO88p02/bdbvb+qkk=
X-Gm-Gg: ASbGncvjRj7EkNP1WKHH6Zu/ocakotKFZow63/zqYgbTI8er7ubB+VKZ4xOT61tBT9k
	veSBBdO16Nb+c5mlSxJynDvoRIww/Tt8HMluA0HEQ1jfHc4OuG0YCwl/dOZiEM7i+WP9tBZ3rmC
	Zw3cUz2ZPSZKhVDaObqjLS6Ukf8XGP6+ipLafkVIdBrSEyiJ9xHacWVhQaNWmJQwTq0rzGaE95Z
	hv5niVuZUSLDd48EPnZfM2WlsGE4zRTYZcja+zy2z1ACDSkyOjs6MB86CK2ppuzceBthDXedQ==
X-Google-Smtp-Source: AGHT+IFeMvXPBItEkfBj+TsBWyt5VIqp6s/l7RNR/q2sdGig5DUtPk5kvMBJvF/jCsasvBcq9d/Rcm7+8sLfBHIWEqA=
X-Received: by 2002:a05:690e:1c1b:b0:63e:2640:1a7d with SMTP id
 956f58d0204a3-63e26401ab0mr14051030d50.68.1761227200274; Thu, 23 Oct 2025
 06:46:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014043255.176499-1-ghatto404@gmail.com> <20251023131732.GN475031@google.com>
In-Reply-To: <20251023131732.GN475031@google.com>
From: Ghatto <ghatto404@gmail.com>
Date: Thu, 23 Oct 2025 10:46:28 -0300
X-Gm-Features: AS18NWC9E3yt3s627ad9waG9TUDD9_NHQ9jvHp0WZHyVN1_6SchCRS75fSFhIPE
Message-ID: <CAMQHOhdzaak3c_jMuOXnukrE9LnCKvouOiAy8g0veRS2eQ3ikA@mail.gmail.com>
Subject: Re: [PATCH v1] mfd: max77705: support revision 0x2
To: Lee Jones <lee@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:17=E2=80=AFAM Lee Jones <lee@kernel.org> wrote:
>
> On Tue, 14 Oct 2025, Eric Gon=C3=A7alves wrote:
>
> > Revision 0x2 has been tested on the r0q (Galaxy S22) board.
> >
> > Signed-off-by: Eric Gon=C3=A7alves <ghatto404@gmail.com>
> > ---
> >  drivers/mfd/max77705.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mfd/max77705.c b/drivers/mfd/max77705.c
> > index e1a9bfd65856..5201a4c9c3f5 100644
> > --- a/drivers/mfd/max77705.c
> > +++ b/drivers/mfd/max77705.c
> > @@ -105,8 +105,8 @@ static int max77705_i2c_probe(struct i2c_client *i2=
c)
> >               return -ENODEV;
> >
> >       pmic_rev =3D pmic_rev_value & MAX77705_REVISION_MASK;
> > -     if (pmic_rev !=3D MAX77705_PASS3)
> > -             return dev_err_probe(dev, -ENODEV, "Rev.0x%x is not teste=
d\n", pmic_rev);
> > +     if (pmic_rev =3D=3D MAX77705_PASS1)
> > +             return dev_err_probe(dev, -ENODEV, "Rev.0x1 is not tested=
\n");
>
> What happens when PASS4 is released but not tested?
PASS4 doesn't exist from what I've seen on the max77705 header files.
>
> What about changing only the first line to:
>
>   if (pmic_rev < MAX77705_PASS2 || pmic_rev > MAX77705_PASS3)
>
> >       /* Active Discharge Enable */
> >       regmap_update_bits(max77705->regmap, MAX77705_PMIC_REG_MAINCTRL1,=
 1, 1);
> > --
> > 2.51.0
> >
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]

