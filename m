Return-Path: <linux-kernel+bounces-794977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49CCB3EB6A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 17:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90EC0484F50
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD01C2DF124;
	Mon,  1 Sep 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b="iDd0F24x"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFED19CC37
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756741443; cv=none; b=aJAogQRKUO49ngk2fouYg3Pu3sliGw5S2Sk2j2KqVh0GdmbecRcQzNsjg5x1A2NUKLa7DyKsmcRvzgJGWUNnAj42+NkmviYka93qHLOKN5Ny69MD1wMnZS0Zkb2ufZbVr9nlYLjgxEmfnReTJmvMLJvXAecGcAGjFMRfgTGKJNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756741443; c=relaxed/simple;
	bh=DJG/mh0ShlyKGUT7wvRI8Ef5EkNRh4jbjJJD85H9Mk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQ6+g/ain0p+kkj5S7S7CK1QSURFvu4EK1QnwcOpJx3WJwzVQCRrOWu44qiYKM2qSd44K+FrQ68GXM7bpSp6Zd3NhtTFgkTIKG/bfpd1HhUmCtHhekHLJ3/ZUvu6r2WssrjPQZeoBH5zL2lVnu6zWJnclqzQVzrGCaRETabZLec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net; spf=pass smtp.mailfrom=tomeuvizoso.net; dkim=pass (2048-bit key) header.d=tomeuvizoso-net.20230601.gappssmtp.com header.i=@tomeuvizoso-net.20230601.gappssmtp.com header.b=iDd0F24x; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tomeuvizoso.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tomeuvizoso.net
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so3223015276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tomeuvizoso-net.20230601.gappssmtp.com; s=20230601; t=1756741440; x=1757346240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUiM499WAsgc6Ukc/D+bl/hCEszVrQlmtsEYo4ugE2U=;
        b=iDd0F24xF+wFeNpJjJ5hlBpORVTfp2H0iYJ/S46KnZOFeoMs7El/JgZEZ+HBLeKD+s
         pLy7pLqP5AGf1DXlwUplIhZXbBIu0cy+KX142+SHRwWcIGN/O/tNrP5cVTlrGALN+T7c
         X5vu+9ivn3nk/BySQ0FVGCHN1b5Rssfmyli4bQp51mLhb2eWBRlIbL5+t6jB7EfB84qk
         aVh/o9yIGl+mDV/poUg72pvWlF8iOzHdBHYRert8F38IKh8AZFsEcJEFLhqMaLHzrdu7
         t1Ynx1g4s6CkFUtSwP4o1200ThtKepDt+2f0FK516rsHyUpwTnIvHxW2FDTwozL8VCjI
         ILTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756741440; x=1757346240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUiM499WAsgc6Ukc/D+bl/hCEszVrQlmtsEYo4ugE2U=;
        b=Lxt7WIJqQhkVjImxzJWK4A9N6D4qDBT1dEoc6QNoh/qT2FDy6IszfluB8r2XV9R/8o
         iQ4+zqLvvZ40ctAnIrmHkyjFL0sXh4sw1/ZokAcIBXxhuCz8PI+E5T4v8iZmdt0/JYTv
         jDmJzC4HYNPvfy3d1Qk76WL7PHff7LBoG/xfuZXKqfBtT6tAIHiIZF5r/L1Rxl8XXRqc
         KySZyxbyfMynXrICriN0QcRMOk3bKhqSGLWICBjPz2WspXOsbW4fEl/secp0EPhryvOD
         NRQZU/6755Qd9eXBkqxRFJaapHOohze2r0NW8RJF1CNuUdMCseRecuBiw8YwZwcbJ9bQ
         WhKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf3UsSeTuBH41uiJdgzzFyG5SIcKsIKzkeFO1dbCjpCMf7X4nitTwyeGqUpVo9JJPKbOqNj81mPIcmCek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA7y7Ylk5N9IObvBc5zuhuSBeCtcrh2sptQkNnTDvXDnGDBomP
	LTAS7wsLl1YGIdbLRVqMFpG2bz/8QBQwZroEFVOKK+1N7URCTRoMATNXBmWHggNCTmRa5PTKUaR
	qBkTlxphL1Q==
X-Gm-Gg: ASbGncs+adciawRDUZyTCW+eXODZugTL+jFPqOEdd5OH6gkukiHOmKYooXTkS3QO8u8
	Cais18aRndfvho4+v+xWK8UXST+dFGB7TYHUFY+fLdng9JGI/fqGhakHd6+wW0vX51x3p8f9CjQ
	JGCKF0LsxI0yCXjZE8KikuHEEun2hLNysXfXrUhgW0PK2Qt0aQCwJn/0FMBTNMJ0lqXQQ4+Max2
	e1tqJJLE7QIPjexvm9Q9UkKEYLbKTXd5zOYsr5xyMylyGEWrv4n62rChEF7Nbay+AJSl/0ASN5r
	/3mJ0OT3XZagpPSvDHPLPc/zTzHXkapH4lIJ4bJeHYMTEDkIMKNGvoENw+oknQFJx78DqFt9vtW
	oqMOq+SWf8yE2u4UETZjUR6NULmvVWWDSOa4km3nfHRrhavaocSwP0ZC3zbeTAZGy/Q==
X-Google-Smtp-Source: AGHT+IFm+xQZvYT6gDPrfeUAKsU20ljCi5OiSKm21nxWgyrE2fN/9N6fl5ny7//3zoOoXHtMbK3zVw==
X-Received: by 2002:a05:690c:610e:b0:723:2012:53fc with SMTP id 00721157ae682-723263b527amr49458417b3.16.1756741440099;
        Mon, 01 Sep 2025 08:44:00 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7227d5d16f0sm15860667b3.2.2025.09.01.08.43.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 08:43:59 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e96e1c82b01so3223007276.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 08:43:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1asVVhRn3B18B2D37xSCw0s9DtkO6LKw1GThquVDGlLlEBEgHIiIDfbDxIYJmAQsUPV8oLBQYDeFbpvA=@vger.kernel.org
X-Received: by 2002:a05:690c:dcd:b0:720:378:bec1 with SMTP id
 00721157ae682-722763a6893mr103121127b3.19.1756741439428; Mon, 01 Sep 2025
 08:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813-rocket-free-fix-v1-1-51f00a7a1271@brighamcampbell.com>
In-Reply-To: <20250813-rocket-free-fix-v1-1-51f00a7a1271@brighamcampbell.com>
From: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Date: Mon, 1 Sep 2025 17:43:48 +0200
X-Gmail-Original-Message-ID: <CAAObsKCcpLheLP-qAW34CfG53vGnAceAOT19VUDLt4nKW1tDUA@mail.gmail.com>
X-Gm-Features: Ac12FXzUHl7q6vH9f1nyi7wu4CMwk0i7C4k_JNPH92MntSXDR3OrCP25AsHGPxY
Message-ID: <CAAObsKCcpLheLP-qAW34CfG53vGnAceAOT19VUDLt4nKW1tDUA@mail.gmail.com>
Subject: Re: [PATCH] accel/rocket: Fix usages of kfree() and sizeof()
To: Brigham Campbell <me@brighamcampbell.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	Julia Lawall <julia.lawall@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 6:02=E2=80=AFPM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Replace usages of kfree() with kvfree() for pointers which were
> allocated using kvmalloc(), as required by the kernel memory management
> API.
>
> Use sizeof() on the type that a pointer references instead of the
> pointer itself. In this case, scheds and *scheds both happen to be
> pointers, so sizeof() will expand to the same value in either case, but
> using *scheds is more technically correct since scheds is an array of
> drm_gpu_scheduler *.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202508120730.PLbjlKbI-lkp@intel.com/
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>

Thanks, Brigham, I just went ahead and applied it to drm-misc-next. I
also think two commits wouldn't have been worth it.

Regards,

Tomeu

> ---
>  drivers/accel/rocket/rocket_job.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/accel/rocket/rocket_job.c b/drivers/accel/rocket/roc=
ket_job.c
> index 5d4afd69230623215e3105da7153d2d010636d52..f6fe1a6d9264b7508a3adc032=
48e5a704c68c4f0 100644
> --- a/drivers/accel/rocket/rocket_job.c
> +++ b/drivers/accel/rocket/rocket_job.c
> @@ -222,7 +222,7 @@ static int rocket_job_push(struct rocket_job *job)
>  err_unlock:
>         drm_gem_unlock_reservations(bos, job->in_bo_count + job->out_bo_c=
ount, &acquire_ctx);
>  err:
> -       kfree(bos);
> +       kvfree(bos);
>
>         return ret;
>  }
> @@ -496,7 +496,8 @@ void rocket_job_fini(struct rocket_core *core)
>  int rocket_job_open(struct rocket_file_priv *rocket_priv)
>  {
>         struct rocket_device *rdev =3D rocket_priv->rdev;
> -       struct drm_gpu_scheduler **scheds =3D kmalloc_array(rdev->num_cor=
es, sizeof(scheds),
> +       struct drm_gpu_scheduler **scheds =3D kmalloc_array(rdev->num_cor=
es,
> +                                                         sizeof(*scheds)=
,
>                                                           GFP_KERNEL);
>         unsigned int core;
>         int ret;
> @@ -630,7 +631,7 @@ int rocket_ioctl_submit(struct drm_device *dev, void =
*data, struct drm_file *fil
>                 rocket_ioctl_submit_job(dev, file, &jobs[i]);
>
>  exit:
> -       kfree(jobs);
> +       kvfree(jobs);
>
>         return ret;
>  }
>
> ---
> base-commit: a3daf184bd85d7c08ce948a79bb0e4cac2203923
> change-id: 20250813-rocket-free-fix-3ca6a759a290
>
> Thanks!
> Brigham Campbell <me@brighamcampbell.com>
>

