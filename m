Return-Path: <linux-kernel+bounces-830212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEFDB9913A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E9C3B0CBD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2901C2D6E69;
	Wed, 24 Sep 2025 09:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wtxX12zZ"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DA71990D9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758705713; cv=none; b=AGNdZDrOxfv7gfxLaOccZp6Bydz2AZeUwnz6+lacoug/YUMBJ27vHj3umjVfozaTjl6HJ4owK2wSlgaxuicS8DSADL5JV5ryVmxXQiGXbOZpQ9N5nJTcXMwBR2Oz2gcpG13ZM3iU8zHaLnH0dS5FQRdhI9MqMzurp8idxsUvOlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758705713; c=relaxed/simple;
	bh=7NNM8R5NxUh4SLUZIUUbqIsW2iUc5a409TK77C1tuyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g2xzUiyMDn5AV5MVMJ64B8iMSIYsM0OqCtynI49buRM/+yrOd7MdH0UZArF+9AyA26dNCO32ezEfjf/UXgRM2yCCqVGJbhfh0uHOQ+/bBrN67WW9ELlfOUIbQcdEUy9s6La+EqJ0cApYbe9eKmzQWb3znQXCZRIro+CJpQ4shYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wtxX12zZ; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-6327423f190so869926eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758705706; x=1759310506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxVruqv640FOouJsJqQA7LKvaemFmmPlp5hTqabzSp4=;
        b=wtxX12zZMCbYJ4SaQu86TeoIgpI+rduA9BSMMNzhgxyyxY46tnLzIAV/grdzH1EAek
         62fWfgsE1BpTdS8vkMF5puLRWog3J/LKyd37ZeMw00HxKpe0XO4GxZGvhm3wOZ238nbj
         Wy2iVu9FgG6a17jdYZEnDIaKXpbL6d64cpEFq1vuHhzlBNBfh9HV3xcrayFjJOOm6L7M
         vWQ71SOMcQoTl/B/BKk0VJtszwbzV5oQsHFLjbWKCsk5/AEFlqUt8yBTjhl5lR1gFbc0
         US1oSH9oXdFJulRd/0dW2Hj/+vunUQB6OYdQRRxT8MGFgVLkHsQqSTqQuNi5cQIY+N5X
         S+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758705706; x=1759310506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxVruqv640FOouJsJqQA7LKvaemFmmPlp5hTqabzSp4=;
        b=FD2N9bTaiqgBoCdH9r3LMSjh7Az62I2IFwBqZpMgU8ZOViLRH4USHWc5vs0NypbQSI
         rfAYrI5lp/7t/SmZfstviMuTNQei9kfLIuVji01oHoO5sCxFS6NZ92mb8ZiI3tBMuCiX
         P7XZCdlA7z0AXVr6tHl2hdxWD7QHMkaxTme+7VU0pvZJS+UMaKnrbVyr5WAA1nBlIGQN
         bo6iwle/8hIZuQv/haa4NJ0EgvaTqhqQRVQvRRpGGWKk0Qb1aKH3yVd4s2SwhjUFtgAI
         4bpBBDTKpfzQZK5rYvtEWhcLnBnSicbbz+jC9uQu1tGDD338pQnbVzPQBqiHCVyxYxvm
         eDeA==
X-Forwarded-Encrypted: i=1; AJvYcCXlwCK+JLdH8cv0QB9NHEgt2j0o2iYIVmAbQ3Zt/So+gY7vh5adm7Q6Y48QDkz0l788fURj8brMgLwdJX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeLpb34LP4WtncBYaaMD3Cedds1v1PUrCjKCpPE7/81UYY59Ky
	VpfCy18hb2Mg9Rn5rhYIDoGgofWeD91SZ03kSq7FRBde/F4y4s2DsKuFZMeI85U02obvRH80PYH
	3VH4StDfNRAWpmnoNBNifC2tYaMi81Okv7nfiI4t6JA==
X-Gm-Gg: ASbGncvGSEObBPjgRGETkj/D+2WRid+FBCpKZe87n9atoJUYEJ2SBpFqYLovOHZwG6T
	HLsG7YoJKVyVGr23QypUyRGcc7yONFLHMA1wlO3yX1EIII8jOXO6Bc3PmkNhxEdXw1PdSO5tNyl
	77kUwPnibdBekMXRKg7j012Z//btbFJbrJ7NnOe7wimqTle3VNzLY9FcKKyeHcwEL25nyoyiMWJ
	UCAtClR
X-Google-Smtp-Source: AGHT+IF9MUcsTpqeMRCCkmOByiXncoZ6aC5AAkRn9kos4HYZSgn1UCyuiasgjldg/eI9Gic3np9EBS9bfwc5jv78a7A=
X-Received: by 2002:a05:6808:17a0:b0:43b:516a:6a3a with SMTP id
 5614622812f47-43f2d4a0853mr2953120b6e.46.1758705706106; Wed, 24 Sep 2025
 02:21:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMvV4kK386Sni10i@stanley.mountain> <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com> <aNOfXlG21HIBR18E@stanley.mountain>
In-Reply-To: <aNOfXlG21HIBR18E@stanley.mountain>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Wed, 24 Sep 2025 11:21:34 +0200
X-Gm-Features: AS18NWBAFawQ8-QtJaveVkFxCVFVwvIAoDOcJ1zhiDc0CJ08YKpktCHoZXO_RhA
Message-ID: <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, 
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 9:36=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Wed, Sep 24, 2025 at 08:58:45AM +1000, Amirreza Zarrabi wrote:
> >
> >
> > On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
> > > On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> > >> Re-order these checks to check if "i" is a valid array index before =
using
> > >> it.  This prevents a potential off by one read access.
> > >>
> > >> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> > >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > >> ---
> > >>  drivers/tee/qcomtee/call.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > >> index cc17a48d0ab7..ac134452cc9c 100644
> > >> --- a/drivers/tee/qcomtee/call.c
> > >> +++ b/drivers/tee/qcomtee/call.c
> > >> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_p=
aram *params,
> > >>    }
> > >>
> > >>    /* Release any IO and OO objects not processed. */
> > >> -  for (; u[i].type && i < num_params; i++) {
> > >> +  for (; i < num_params && u[i].type; i++) {
> > >>            if (u[i].type =3D=3D QCOMTEE_ARG_TYPE_OO ||
> > >>                u[i].type =3D=3D QCOMTEE_ARG_TYPE_IO)
> > >>                    qcomtee_object_put(u[i].o);
> > >
> > > This is not required, considering the sequence of clean up, this
> > > would never happen. `i` at least have been accessed once in the
> > > switch above.
> > >
> > > Regards,
> > > Amir
> > >
> > >
> >
> > Also, size of u is always num_params + 1 for the ending 0.
> > (basically means `i < num_params` can be removed).
> >
>
> Yes.  This is true.

So this patch isn't needed. I'll drop it if no one objects.

Cheers,
Jens

