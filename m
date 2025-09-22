Return-Path: <linux-kernel+bounces-826717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B56AB8F2DC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8D7017E2E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6DF285C92;
	Mon, 22 Sep 2025 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SyG9g19M"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3146534BA39
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523163; cv=none; b=MfClOQiC97vqhtyZHfenz/jobPo0G9s4bmmwVRYrKi5LIXa+Ow5IYkQUo9MOi4w2Wum+9iC0oddVMV+dmJzxyQeR/Uwj4ZoKXbouatWtRaG+PjMgWkWoOzscAGtWPLVGfGHFZ5mPsbyxThI2L6u2S44FNaGv8FvfFuvAaCglCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523163; c=relaxed/simple;
	bh=aAm2tLu9Lcd/rEeyh90A2+r4aVuP6V5aTrIvHxF3RDM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgcNwuVZJeMiOvzbc2BCAh5pUV4qC8iJeVFxiJYvbR6jd4KtTt6jrZ5so52SwhA021unRSNc9V0MHhSnyK29U8EYGdBtdJrTJJhpOKLUcjawcW4fkC3zLMevmZIMFTfGv4PCAtRHnzokziGfu8Cwf0XIF8Nw7SNxh8T28dsE1Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SyG9g19M; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-751415c488cso3991223a34.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758523161; x=1759127961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3BWzW2J9Z3ytb9T+PalkAt1wTD7VsNe5O2iBqLv+TE=;
        b=SyG9g19MDe30mqXfKc2DtFMag8r2gSi0aKin5HTnJfCsHmTXEXhyqhdAYT+XBe6MWK
         XhOlSkB6ONYzGFjNZWsSKQAE7u2dYlgMceAMvN9JXKgcMw5i5Mz7El+QQMWR/vJ6wOjm
         g9YaHBzbsqyqkKt8GfK+9yqgifLUNWBoNEVyMYcDBHe3GgE2X8J/6p7DfU9gunJDRdsa
         g66zJERgcN3k4FG/65OiSQUwCqN/TECqy9KjH/bEm4mxtM/W8WNxATkxNSJnAua2Is+N
         lp+H9UiMK1Uul0CvaAycewK5NiSr3h+OReIZGnPgz3fTOIyZuuSjSOBBgGcnwZ9NFLZW
         Yihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758523161; x=1759127961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g3BWzW2J9Z3ytb9T+PalkAt1wTD7VsNe5O2iBqLv+TE=;
        b=VKkd9oLw4nLXslzvFOFU2gOoy2lyC8Jnlm1BEGRh0/AyjnUxzU6/rjZjAbCFJ23ZgM
         +xok1uqP8v+md5yVGF+t9jLT+8e16E9Xjbk54EgsnC8vhpIhWa2dCXPA25oc8VYRO85R
         070CBSWi0sZ8gD6MriUq6DukdglSYvaz0K1/GTP0AfJbGm9i2qvp+e8BfHFgjZ4SnqcQ
         DworL1AEvu0AUIhsGCr/+vB95RVlxxOCTZIktlgLsdND+pVbjlQNQQt8iGethYe9ROEr
         AEQTefG7U4KxMeXon7aXepqikVaUEJyuX/EIb69hx7eEhD9rNLERCBZLr6T7L6seDLpB
         nGfg==
X-Gm-Message-State: AOJu0YxsiWnw74Uv+aqG4KEQljyJ4Xwud4ojTP6H9BbDzRRz/4xBeqXg
	EQZebV6zY5RLWhKv5F2skEibl9cKRfDFSQv5tab/ribjX6yi41i95WfwTyNm+OkwGBeEIOD5Ys0
	bjCNlI1Q0UUyl0Ktr8tY3P81+XIuvpQVs8/ByE2mbNBgA0ldHYyYcehw=
X-Gm-Gg: ASbGncuXZeyDC4bITwGvSz5yWp7Op6t2+OmfHlptQs3SueFz9noaX7OncABCXlNtCln
	ZUNGKW4uv2D9N3cK9MrSElNbsUgoFKWlo/0pU23Zoi/4n0/B9Rve569Nb/saaeOEB3tPiMgqYhc
	wPFr8F5iJ5iVpRlFUm8sh3cF/wf03LfxpcsUm5X2rr590dybUnRqHqWlruzQ3bp4MZ5ksFFXCHy
	AlA7qX1
X-Google-Smtp-Source: AGHT+IFx764zTbdEA6SqVfFUP9+ys/yQKFZFbRR5D83kmZZwWIFqppMGgBDBb4BDrHixxUD9Shg72y/IVcEl/e7S/GI=
X-Received: by 2002:a05:6830:6988:b0:749:77df:c38a with SMTP id
 46e09a7af769-76f6eb4df7dmr6465952a34.2.1758523161170; Sun, 21 Sep 2025
 23:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919124217.2934718-1-jens.wiklander@linaro.org> <aNDMXvTriEiSLwPb@sumit-X1>
In-Reply-To: <aNDMXvTriEiSLwPb@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 22 Sep 2025 08:39:09 +0200
X-Gm-Features: AS18NWBbLb0VegGkHDcTRrbkfOYIr2ePDSBP0JcyijOcWJqS4-t8BSaLIlBpDKw
Message-ID: <CAHUa44FKBXjteyU=PsVfwdhNXb0msw03WD=5itxx2EKcEDwNTg@mail.gmail.com>
Subject: Re: [PATCH] tee: fix register_shm_helper()
To: Sumit Garg <sumit.garg@kernel.org>
Cc: linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Jerome Forissier <jerome.forissier@linaro.org>, stable@vger.kernel.org, 
	Masami Ichikawa <masami256@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 6:11=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Fri, Sep 19, 2025 at 02:40:16PM +0200, Jens Wiklander wrote:
> > In register_shm_helper(), fix incorrect error handling for a call to
> > iov_iter_extract_pages(). A case is missing for when
> > iov_iter_extract_pages() only got some pages and return a number larger
> > than 0, but not the requested amount.
> >
> > This fixes a possible NULL pointer dereference following a bad input fr=
om
> > ioctl(TEE_IOC_SHM_REGISTER) where parts of the buffer isn't mapped.
> >
> > Cc: stable@vger.kernel.org
> > Reported-by: Masami Ichikawa <masami256@gmail.com>
> > Closes: https://lore.kernel.org/op-tee/CACOXgS-Bo2W72Nj1_44c7bntyNYOavn=
TjJAvUbEiQfq=3Du9W+-g@mail.gmail.com/
> > Fixes: 7bdee4157591 ("tee: Use iov_iter to better support shared buffer=
 registration")
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index daf6e5cfd59a..6ed7d030f4ed 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -316,7 +316,16 @@ register_shm_helper(struct tee_context *ctx, struc=
t iov_iter *iter, u32 flags,
> >
> >       len =3D iov_iter_extract_pages(iter, &shm->pages, LONG_MAX, num_p=
ages, 0,
> >                                    &off);
> > -     if (unlikely(len <=3D 0)) {
> > +     if (DIV_ROUND_UP(len + off, PAGE_SIZE) !=3D num_pages) {
> > +             if (len > 0) {
> > +                     /*
> > +                      * If we only got a few pages, update to release
> > +                      * the correct amount below.
> > +                      */
> > +                     shm->num_pages =3D len / PAGE_SIZE;
> > +                     ret =3D ERR_PTR(-ENOMEM);
> > +                     goto err_put_shm_pages;
> > +             }
> >               ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
> >               goto err_free_shm_pages;
> >       }
>
> Rather than operating directly on "len" without checking for error code
> first doesn't seems appropriate to me. How about following diff instead?

Sure, works for me.

>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index daf6e5cfd59a..cb52bc51943e 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -319,6 +319,14 @@ register_shm_helper(struct tee_context *ctx, struct =
iov_iter *iter, u32 flags,
>         if (unlikely(len <=3D 0)) {
>                 ret =3D len ? ERR_PTR(len) : ERR_PTR(-ENOMEM);
>                 goto err_free_shm_pages;
> +       } else if (DIV_ROUND_UP(len + off, PAGE_SIZE) !=3D num_pages) {
> +               /*
> +                * If we only got a few pages, update to release the corr=
ect
> +                * amount below.
> +                */
> +               shm->num_pages =3D len / PAGE_SIZE;
> +               ret =3D ERR_PTR(-ENOMEM);
> +               goto err_put_shm_pages;
>         }
>
>         /*

Thanks,
Jens

>
> -Sumit
>
> > --
> > 2.43.0
> >

