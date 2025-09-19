Return-Path: <linux-kernel+bounces-824188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D550B884F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AADF564430
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF72FF179;
	Fri, 19 Sep 2025 07:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YR7fQ92I"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4F2FE051
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268768; cv=none; b=HS/xEWXDYEdn6EgLlo4kibbJNS/Ln2wp6thVcJ33NidMn1qB516Z/QXTk6WRpkjlEsffNZmPhCky5HuLxVlTHpzDc9mhx9dPiMChc8JT042bwcx3BBYtVkRpzxnM1goZZ3esSOWWwC0E3836DUcfvJLavwjcItt/7KA1rnRUaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268768; c=relaxed/simple;
	bh=FwMus99U8OAhl7KhXnsvGESrZFJWyVna+f36n8I5bZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krYvtL0nO9/mbc0fZGMs8QBN+CXibTvw0n2GQY8MplUNg5QjhN943PNA+mPI2Xa6dQohEiXEe4KKQYHekip1zrFp8EogHnIX5NDrSUe72YzxII/wkWatG/uS0JQfd4BrNxmTzNj9uX1tRXYd5Uno/wUgRBWUiH6PrZd4qsO1YqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YR7fQ92I; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-751415c488cso1772719a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758268764; x=1758873564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ASDqAkH4cmxDPZSFWYENHrs1T7W+4jRPHJP2+bsh1GM=;
        b=YR7fQ92Ia2V7geu1PHmvzbLL9QMop1gN73J1L2hxicnLCpQxFtU5C0a5xPX9YXpkmD
         E+6ZVepeYfpFwxM+4NFBLwfToq82fs2O9z+xLYzycg2b5XUfVhOco39Nm1/q5Tq1Sv6A
         d2SeyfKkE6Lu6tC8Xk9SlObyC/T1QOmz4IlD8mPAK9V4//xUGL95jjSyAiFSJq4EW+8S
         7r3aDKjg0z8I/6SCHEEV0LccVroN+98TvDBaZnMv0zBlVfKGgcLjzUZ+irgmd2JDZCRj
         sfVwwjmcGLK0kS8dij6ndG7Eu+9zbU8TZUz8yfcsF4xIHgThy9IElnuZtVUWgYrI0Ag3
         H+MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268764; x=1758873564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ASDqAkH4cmxDPZSFWYENHrs1T7W+4jRPHJP2+bsh1GM=;
        b=OR+0+8G5bUDQcBNGNUpiiFyfegMJV9RFoFi2VOltvrlL3/KMkL6PAsjwhQxohSBs4H
         M9LjcELFrimk5/Scx2XKO+VezNbu2JYKfycMU61cxXfarUAZ3wcBZUJB1O/pm4IrXCxT
         ndwfMdEhhH8WT8Lz1RFQ9pAVmwJzwNNJRGku8ILoYMLsv/Gt9MPZQzvdzq5BbaFD9g1o
         +X1NVfVIw7PRN58AbG0NroOdAVkvepuYXHaSLzyHtHDlS7H+lfC2Boyzm16tSmWrYGgp
         vPE/pp/KQV2UIP3ZMRxzklgf6HpZCimuYXpoe8JE3FNsFtzPgqTkG2uFJtWl9qCow3vp
         W3WQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0C3SYYxZLMcwOQrG5//mFgqZuHGdVzNXjXpa/JYhg58pRL46mMg41s0tpaGRrOJ+U7kvJDwXGrD94SWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIjE7Z3Y5zhxnaR8u8Dsx3xOvw+f6QjWdJ/WHulB7Q4Oz/ILP
	Erpx9Th0zmr5wGhM2FubUcNdxYdoSrMShYiNO1rBl9f6nKPW/u2xqPz3Iu8G4+32+jITNrN04Zg
	lvEcmjS3gntaWN/mrh1nxNyolujYm23SeGNsw5Q3+Mg==
X-Gm-Gg: ASbGncv/R1m+DHqFpWJ3vMTngKgVkQbcyAKt1ODKva0/FSk/g9AB4btG7CGHxZ21J6c
	L0Bgw8yKo5tnTnrZBBUhpwuXFxylXvl2K3DTZcLRmb+dmx/f0fwkqOjOBNKuc5keW+luCnAFzWi
	q1m/83jbFSINWwFCduNL18DzVjJZ7+AfZm364t3Ige8oYictDPftE5i3sPEUKnjfndRIVcf6OwP
	J73zvrX
X-Google-Smtp-Source: AGHT+IEekOH9/D2Na5uJOAYH+Gd3gYDqTSm7RjBTFazB5QY2j1Nx/k/QnGRih+TMOqi+VBgoo9dEC9T1EDeBavQpFxI=
X-Received: by 2002:a05:6808:5094:b0:439:b674:d9a3 with SMTP id
 5614622812f47-43d6c26736fmr1011006b6e.35.1758268764408; Fri, 19 Sep 2025
 00:59:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMvV4kK386Sni10i@stanley.mountain> <aMzoPc67ws5NMpKS@sumit-X1>
In-Reply-To: <aMzoPc67ws5NMpKS@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 19 Sep 2025 09:59:11 +0200
X-Gm-Features: AS18NWA3C9LQrIakhvqgeKImPW9n-BTnckAYGagXPywalztGB_Wmp1fHsBSux6w
Message-ID: <CAHUa44G96pdFL+08Rn8yr_5fp2MpUCjLAUsUcgprnrZCcSyLxg@mail.gmail.com>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 7:21=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Sep 18, 2025 at 12:50:26PM +0300, Dan Carpenter wrote:
> > Re-order these checks to check if "i" is a valid array index before usi=
ng
> > it.  This prevents a potential off by one read access.
> >
> > Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/tee/qcomtee/call.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Applied.

/Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > index cc17a48d0ab7..ac134452cc9c 100644
> > --- a/drivers/tee/qcomtee/call.c
> > +++ b/drivers/tee/qcomtee/call.c
> > @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_para=
m *params,
> >       }
> >
> >       /* Release any IO and OO objects not processed. */
> > -     for (; u[i].type && i < num_params; i++) {
> > +     for (; i < num_params && u[i].type; i++) {
> >               if (u[i].type =3D=3D QCOMTEE_ARG_TYPE_OO ||
> >                   u[i].type =3D=3D QCOMTEE_ARG_TYPE_IO)
> >                       qcomtee_object_put(u[i].o);
> > --
> > 2.51.0
> >
> >

