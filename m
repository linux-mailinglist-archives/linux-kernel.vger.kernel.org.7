Return-Path: <linux-kernel+bounces-755473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D0B1A6AA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF0816DF5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E3B2737F8;
	Mon,  4 Aug 2025 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="djUEYN+r"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38703274FF1
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322583; cv=none; b=pji+R15dAvTSOje6k0Bz8if0uObvGrn8r+pSan/MpaczLQDcoUowGn1F+qfLtFrstkaxIR0msYweeTnDOsh8BRnDtO+0X7gi/51L28+Xqi9uIdaVWxwkKTHfAIvIyh/YpAbPVWsTLQW94C9+r6hh+BzYoi2+El3eFdUKWx3phPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322583; c=relaxed/simple;
	bh=qtND1ibzYk4UkWAwRjkYsZPKmIXRsWimj8IytYGcCJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dQD3THPMjX8S5EeJxiijp9fDQFuz+M1d7/JpgUmNhVA4wgILO7M+muz1oltQuwgjl65VpHobfmgGceW5wtPUaI11CHwtpieT3g7CDWwuCSnJ8d4+H3LCDdgbY0COPA0ya1zM2xYS3zlAUuyKcRFE4WkB7tB0JVoqYjfzVLb+9s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=djUEYN+r; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-6197e7d225bso1186772eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754322580; x=1754927380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwpsU/1XQKoqUW4t4lntajLzcj7nckiR82+0joEUMlw=;
        b=djUEYN+rnSHbNs21Nn3JM3WG6UPELRMiVsQjiGfNZqAsF1T4Oq4BAgKe6PRm//sSif
         lhP5lOD2ySUu7QRvBXSdKKkZLnNGkePf6kMn9WWnWygrnb6Ohuepv9X2Bu4/Snx2r3nA
         JdHOA9XOoumP1iFo/ou2I2xeQ8jvL/KqXEaAL6IkU0oXbptd6nhI86dT+/kDX13o3Ccw
         ZNdS42N76Kkjjd78GrXi1mLysCxGZB4qeC9sUFx8XYFk4pz6N4j/MOQZgaI3dHumEDLB
         44tDc0kdlU0Hv/giPlKKdyphRRjI+oqkso3HYz5xDSZBlVo1USjqVgljr24cYkK+u0Au
         +jFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322580; x=1754927380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwpsU/1XQKoqUW4t4lntajLzcj7nckiR82+0joEUMlw=;
        b=jarVIIDiLqVKy9Aljm2GqjSXVYZmc7uU4KCDxG4mKCrBF4lTJNs3/wUwx6Mis5ixD7
         9MddjtXfYg/tT99ahe36Cqd0lTNBdGY/ZU5wvSIj8iBTKBSlIJZcCeHmBjG82KAuWgwv
         LZ7ETXFL+9eY5Olm+xzKl5B9EcPpQXXzXFdZZ9wSGTiLclLCT1hXItUTrjFyaohFkK5w
         JPSZ74d1GI/F5HzLsWWCQjtB9tfP5ZDv1E/4+lms3m7vM9WWyft6h6FIzsVeppzpas9+
         de3u1RFYIPIldl1Qqr42zvezo6XOapi6dSjbh1IqRv8E3cMy4xgxmQqHNpVt1xwSJ7au
         pJzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwvEAIz21L3wdL/tlpc/TGDLyalfXuc5X1zEBw4h8E0mBPEyTWVq35ONwUeaReq68UuMY02Xs8ug4iL98=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwAtp4Ppe6ANQx4S547hHSRfRIXldEUZgWyBSV/bOojXwq18MF
	uRiNGi3DmPfNwyw53UJrbzST+3Mfam+E+rT97nvh628v6wuYsqr0TPDysB4RxhufXebJ4tqqCOU
	LiALPyouBDreh6cfORTfJI9RxHxj0LVGD55SRxjWYvLO1occI+grAKzM=
X-Gm-Gg: ASbGncsT4z91Mbco9UGeDcejocNynADeIA2lqaOs5xkBfL2z0+RJJrmxmE+Gw+fbEIW
	OtHEp/qoxQuPxh1cR9y6u141KmIS8JH0vSMuSD2sHd6fxE3DnB+/37JbbF+Jdp9gztOCzgpmiNy
	o0uNIMN3Rk3jX7rkDr1p0NCJk5PEkI+KgtlWU6poMs8lnb0YkXJ0v5/HvujWhmkDjqHPciSA8UT
	hinXpM/
X-Google-Smtp-Source: AGHT+IHgaQgk3f6H/3KX12vfUec7jykjb6GJaLe3Edl/bXtGP6RofdteZULNw3f7ts3w5DkzL66APzyZelnJi9ZiEQg=
X-Received: by 2002:a05:6820:1e88:b0:619:a040:a61b with SMTP id
 006d021491bc7-619a040a962mr3008362eaf.8.1754322579949; Mon, 04 Aug 2025
 08:49:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ae66122a86295f0ca5f2ff385ac2850360a805c1.1753251689.git.xiaopei01@kylinos.cn>
 <aIiUEGt2uVF9yi1W@sumit-X1>
In-Reply-To: <aIiUEGt2uVF9yi1W@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 4 Aug 2025 17:49:27 +0200
X-Gm-Features: Ac12FXxloQhDa4UWHLtUmaDy4W6OWJWZEYbGK0Nr6i7EzpGH5yulks4fivp9qnc
Message-ID: <CAHUa44ExoWcNXVDiwUA02qEhiCFF0obeXYJY4_NEVUTzEvkUng@mail.gmail.com>
Subject: Re: [PATCH] tee: fix memory leak in tee_dyn_shm_alloc_helper
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Pei Xiao <xiaopei01@kylinos.cn>, balint.dobszay@arm.com, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:27=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org>=
 wrote:
>
> On Wed, Jul 23, 2025 at 02:22:41PM +0800, Pei Xiao wrote:
> > When shm_register() fails in tee_dyn_shm_alloc_helper(), the pre-alloca=
ted
> > pages array is not freed, resulting in a memory leak.
> >
> > Fixes: cf4441503e20 ("tee: optee: Move pool_op helper functions")
> > Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
> > ---
> >  drivers/tee/tee_shm.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Looks good. I'm picking up this.

Thanks,
Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 915239b033f5..2a7d253d9c55 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -230,7 +230,7 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm, s=
ize_t size, size_t align,
> >       pages =3D kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
> >       if (!pages) {
> >               rc =3D -ENOMEM;
> > -             goto err;
> > +             goto err_pages;
> >       }
> >
> >       for (i =3D 0; i < nr_pages; i++)
> > @@ -243,11 +243,13 @@ int tee_dyn_shm_alloc_helper(struct tee_shm *shm,=
 size_t size, size_t align,
> >               rc =3D shm_register(shm->ctx, shm, pages, nr_pages,
> >                                 (unsigned long)shm->kaddr);
> >               if (rc)
> > -                     goto err;
> > +                     goto err_kfree;
> >       }
> >
> >       return 0;
> > -err:
> > +err_kfree:
> > +     kfree(pages);
> > +err_pages:
> >       free_pages_exact(shm->kaddr, shm->size);
> >       shm->kaddr =3D NULL;
> >       return rc;
> > --
> > 2.25.1
> >

