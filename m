Return-Path: <linux-kernel+bounces-807119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59711B4A059
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 05:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08561899DDA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04D628F935;
	Tue,  9 Sep 2025 03:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RIqv9BFT"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50751264636
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757389831; cv=none; b=Ri7+h5ASrn52sUBz652kY6vQy55a5WJwB0pjFgN67P2aBez7uz08KYI8KOAaUXrExQSj5hhCSvbhEuCH8YZ/zA2wt5n/zH6zTJQ0OZ1b8FkRhmPtx8keB5YcCNqqRnxI9eYgGJb+pBTuWkrC36ccl1JzLyfIHhDHwvO2YkZeAP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757389831; c=relaxed/simple;
	bh=1xFzen0cPNxM5zXyiLBipVzRarGcyUizNL8zdN6+qmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Olp1OFaJIegwOSoc99GSCQo3rsTBVis3aOtWXgDtQcTVVMIM38X8L2bAEZHliEH7QvawUJwy0F4n8aMGFlHopI5OaSTfNK1vOjETGHjm7ojO8xrfEQsNrYNMD6VFcEy/mhZdg5kqkFPg2TrLpZuMcm5ZvCRm6+Zem/VrFF/fOzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RIqv9BFT; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f78e3cdf9so6298894e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 20:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757389827; x=1757994627; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eua2YAPyWNoI872YUJ3VdyRPkVf1aMyuVYL342nj/u8=;
        b=RIqv9BFTB2A79EhdhA5Bj3DFOtVU8it4eVNNks3TAwDU0u3lyKNhjXxhfdbPq9H8xy
         ES7E9qS/9oOfJky0N+dBZR/3erD81LLKxqSQbCLUkJhGwvJHNpd0LGd906JmFgeUCUl3
         mGG8+VM4ogasakxtNDQleLyopDqBmw6+ldr9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757389827; x=1757994627;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eua2YAPyWNoI872YUJ3VdyRPkVf1aMyuVYL342nj/u8=;
        b=L+VXX10Rt+BTw85JCErdhaYQwYR+tCz70s2un1g7hipcw0NWcwR4SIsxY0BIeVBaEE
         2P0/CG95NbpD7LtnFDhkVMFvsA0bATEVpS8y2pAOUkn2uHhuT0UbxOJgwgOuSjRwtor8
         nihVefDWAgriAjw7yPbrVGyslCfBxmdX/FqO5OyU+DQ7L0l0SULNBw2TzbRUqyOsAf1V
         H3joYdTZpbedL5yaSSJfWg/EUEyUDR313xdT+mWtgJA7jtZujaWrGXh3ilBrY0buYWfb
         eJPorIVW3yZncT4Xrql6pyiumXwR+OeFIUZJQyKx1u+enSKRR4d5Dpb/npJ5p3wj6sCc
         bINw==
X-Forwarded-Encrypted: i=1; AJvYcCUpUF4RqFAFMZaiNHwU9Z+dWTo0sl0A7Yw2aH4NExNLfG1ki2EmPsBk3h1AgRzoFv1ov0be1idIqBfb5pw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKKEYisIghy+t/ar6hj3NfKTVx2Hy3ZSfwnz9ATy+5wj5925zv
	um/BlYTDVFUWgEolPSROSBrxOslH1E/4bRYbRTWClJfwJehcg9FoG6HpNxijdaomw6SP4LVTKwT
	u7JtdGqcmb+glJtOjypGWU0czfWx96beJnrTDrRdm
X-Gm-Gg: ASbGncvReBteHyz6CmI+4fZBb0UT1itpZmX8RzE+acgg9z9ycrjLrNtIjwAdUdHZGj6
	8I/tr0c6GN1AYnSAYTQAbwwJVMQX3MmsGsILgLVTKeL2uxKMoOFlpRGWWsBT2c6i8nlvnGU1+sf
	IkX4HpuL3CgJYrgPhPLQSHTyMQ589bic9yRwZ68eCEistD7BRNOob3yTgG5aVjk3AkrETUF32zW
	DQNiTHZyKvzeEXIdQXHal5lMgpELM0LP3M18iaUXfsZKbEd
X-Google-Smtp-Source: AGHT+IGj8MbtzCVC3eleE1z+3A7HLn2+wwQE3Dbn34sAVj1F0T1xg3I1Y5OtFtL3Vq/iIqiBfRs27XObu4ME5Ad0K9g=
X-Received: by 2002:a05:651c:e10:b0:335:2d39:efe8 with SMTP id
 38308e7fff4ca-33b5840d79bmr17650591fa.44.1757389827313; Mon, 08 Sep 2025
 20:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250906082652.16864-1-leilk.liu@mediatek.com> <zddsit53dwqo27buoxaolgpzvvvd6uvwcyzughv7qfvwg64ces@yrlrur5dkf45>
In-Reply-To: <zddsit53dwqo27buoxaolgpzvvvd6uvwcyzughv7qfvwg64ces@yrlrur5dkf45>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 9 Sep 2025 11:50:15 +0800
X-Gm-Features: Ac12FXwAUz9S8d-8r_TaFcUSUGZ-l28LM65axRib-fNazk4pPZoYccYUgggaCpc
Message-ID: <CAGXv+5HZcZ8uVZQbT83QnWd1M6p7fXvKU-0gOfc794BxqOmw1g@mail.gmail.com>
Subject: Re: [PATCH v2] i2c: mediatek: fix potential incorrect use of I2C_MASTER_WRRD
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Leilk Liu <leilk.liu@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Qii Wang <qii.wang@mediatek.com>, 
	Wolfram Sang <wsa@kernel.org>, Liguo Zhang <liguo.zhang@mediatek.com>, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 9, 2025 at 6:17=E2=80=AFAM Andi Shyti <andi.shyti@kernel.org> w=
rote:
>
> Hi Leilk,
>
> > diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-m=
t65xx.c
> > index ab456c3717db..dee40704825c 100644
> > --- a/drivers/i2c/busses/i2c-mt65xx.c
> > +++ b/drivers/i2c/busses/i2c-mt65xx.c
> > @@ -1243,6 +1243,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *a=
dap,
> >  {
> >       int ret;
> >       int left_num =3D num;
> > +     bool write_then_read_en =3D false;
> >       struct mtk_i2c *i2c =3D i2c_get_adapdata(adap);
> >
> >       ret =3D clk_bulk_enable(I2C_MT65XX_CLK_MAX, i2c->clocks);
> > @@ -1256,6 +1257,7 @@ static int mtk_i2c_transfer(struct i2c_adapter *a=
dap,
> >               if (!(msgs[0].flags & I2C_M_RD) && (msgs[1].flags & I2C_M=
_RD) &&
> >                   msgs[0].addr =3D=3D msgs[1].addr) {
> >                       i2c->auto_restart =3D 0;
> > +                     write_then_read_en =3D true;
> >               }
> >       }
> >
> > @@ -1280,12 +1282,10 @@ static int mtk_i2c_transfer(struct i2c_adapter =
*adap,
> >               else
> >                       i2c->op =3D I2C_MASTER_WR;
> >
> > -             if (!i2c->auto_restart) {
> > -                     if (num > 1) {
> > -                             /* combined two messages into one transac=
tion */
> > -                             i2c->op =3D I2C_MASTER_WRRD;
> > -                             left_num--;
> > -                     }
> > +             if (write_then_read_en) {
> > +                     /* combined two messages into one transaction */
> > +                     i2c->op =3D I2C_MASTER_WRRD;
>
> i2c doesn't change for the whole loop so that it can be set only
> once outside the loop instead of setting it everytime.
>
> Something like this:
>
>         if (i2c->op =3D=3D I2C_MASTER_WRRD)
>                 left_num--;
>         else if (msgs->flags & I2C_M_RD)
>                 ...
>         else
>
> looks cleaner to me and we save the extra flag. Am I missing
> anything?

It looks correct to me, though I think it requires a comment explaining
that "in the WRRD case there are only two messages that get processed
together, and the while loop doesn't actually iterate", and reference
the block where the WRRD op is set.

Otherwise someone is going to look at this snippet and think there's
some corner case where all messages (# of messages > 2) get handled
using the WRRD op.

So maybe it looks cleaner, but it requires more context to understand.
Whereas in the original patch, the extra variable sort of gives that
context. In this case I prefer the context being more visible, since
the original corner case this issue fixes is also from missing context
and assumptions.


ChenYu

> Andi
>
> > +                     left_num--;
> >               }
> >
> >               /* always use DMA mode. */
> > @@ -1293,7 +1293,10 @@ static int mtk_i2c_transfer(struct i2c_adapter *=
adap,
> >               if (ret < 0)
> >                       goto err_exit;
> >
> > -             msgs++;
> > +             if (i2c->op =3D=3D I2C_MASTER_WRRD)
> > +                     msgs +=3D 2;
> > +             else
> > +                     msgs++;
> >       }
> >       /* the return value is number of executed messages */
> >       ret =3D num;
> > --
> > 2.46.0
> >

