Return-Path: <linux-kernel+bounces-892471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF441C4528F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587401883459
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A35A21A92F;
	Mon, 10 Nov 2025 07:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OTmO7GHj"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2299713FEE
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762758215; cv=none; b=jdOpFN5q5ZSjXX0WtsBi609AqB5/39zVSlsk+T4IGSfryLXN/Q/OUpNREab+kdn7Ti0eLUWBB3E+dTtTbyBeNAEufLmINed2pDofwyyKJBQzIBp/aL39lRNiXSJYcXf01bhdbdbIVeLPhCG4jn3Xlo3BPAocDwRDzPvRlgESLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762758215; c=relaxed/simple;
	bh=JRZa9hfwsWOsaBxdRONGO80g6WxN8n6B8FTon2v5I2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ey3OcxbplsrqG9mXZ11qr93NEm7fQPtwiPjwfr4AOf9/h+t13acCpFSFVKoFPoVmWVtrLkHUVUMr+1aSdgrcNIHEQx3/8+KwKiiat7kL3wDyvdsF38aiZZacpuXvWM+flUiv+8NM6zc9BaJFeNdn53pD8vc9/GFrmWdgcfsQJRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OTmO7GHj; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-656ee8052bfso134744eaf.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 23:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762758213; x=1763363013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZH9HBphOAagtoFjePNpMdaPRYh83TbkuAlXlrLr400=;
        b=OTmO7GHjEUUqTZnBbAGqlrzjHvZpg4qycC232YpYWeVxTkC7RUhoZp06ZcDJ7jFb2s
         0r8/FDFfO3nD9obH+qzWNmUue3tOM5Bz4r5wB7f+N6zyJx4fr6q1vJuXZLbU/CIRBdV4
         0jt12H59Pwq1pCM7kqTIWGcxhNJPqWW0/OqodCPFtljjS/kOkyOfARhQ15DlzpzHnN3f
         rhID/Mr80/AyWRyQuxNwDXOXOf4BgJPvNaaZywN1QHhrNXmll2LLpjjPm/O8IpvOtB1s
         7tC3fHu9gMMttSuW7mtLFuWzgOEEDAuhhgHaYhDVRZIBXHvxPbQmOp6wsWhZ2ij3FUMb
         KWZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762758213; x=1763363013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kZH9HBphOAagtoFjePNpMdaPRYh83TbkuAlXlrLr400=;
        b=a8dL8i3SYTtVN2FHaaBiDmUvcOV+BBtTYKeRxNiO7dHh1ZQmvJqig92Saa5t7tsUKc
         meUuG755IoinjtxVqvCA5vG0iNK0bskuLcFQqUU5L9Oy2ny9p9/Ik/uDShrvakhsyuuy
         HPI2tsuawRewZwjEQXTDXt8gFeCbOgJ/WPugPqtMQcFQUHqMN4LndgAtyWqne4GW1evS
         7Lw4v0MmIwwbOxqceVKMXxrXP2YbnYYUiA5DI5vmmxr+2T66ENChmU18kXBA1nkMXmSL
         MFua2xODbd8434dX3sxITX+UQ0PTmRTV+Kosqn5YEZiQfs/Sceu2vTC93gXNgtK91R30
         /uKw==
X-Forwarded-Encrypted: i=1; AJvYcCWBCvYEcMSZMoZOk/Nx4TygMhXvb/mJFwhCEcBlYB3EAHqEcz50jh3TKA6/OOSHRsfGMUdhWggGetco4/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzah2L//OOS8YMUvy08oNsTcZKhS59nP0akbod4qddqB8mF75dl
	ByUEbJYaU0UkxInAajnIH43dE9f9s2+LEZZfxco/E1lxEjR8eYRowyE9CAojsH4fZdmx8USAPk7
	P1UQ4m+7qcmdE7TXzm/zgw4e+utiQK0+75th+Tzy77A==
X-Gm-Gg: ASbGncuTIZuX7vVtTF2pBi4vhYQIRufCm4luW7hIq3vQoO1Fe4SPz2a0ZEqj2hUIar5
	CLH/5Xz9SutPWbzLwaFctJFRPKFEdwBDqCHovLFkXzue3Q5//dQnOdMUTIRIW53b9bELnYCj3zk
	oJZcmQ78iLskCo4A1KEYClHw11I0dyHiU5uY6KQT1UOse/et8ZkumB5a5XJNYBqtNmqPvtiiyHr
	QoxoyCje4CPDAHd+Gv+Ues/FHIqQsQ0jPjcVzBscDLVDrE0s/2ydroq2EOn6hS3G6Gb8gQ1h+l1
	X0G7
X-Google-Smtp-Source: AGHT+IGfcMCh8A+6KX8WwI3t/ZpN/O6TB7L+kmvdmryqmExFqyiRM6QCUcw0qA75XS8PzWEIgZCQDItmCsRNchsPauU=
X-Received: by 2002:a05:6808:3006:b0:450:9f5:dcbb with SMTP id
 5614622812f47-4502a1ba355mr3085976b6e.22.1762758213078; Sun, 09 Nov 2025
 23:03:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106102008.1310234-1-yangzhao@kylinos.cn> <CAHUa44FAUyQNBKmzugu-_gv_Jy_AftZqq=RSbKUnK1QQbL8Z9A@mail.gmail.com>
 <900f69d4-6ef9-fe1e-d664-e248e41da752@kylinos.cn>
In-Reply-To: <900f69d4-6ef9-fe1e-d664-e248e41da752@kylinos.cn>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 08:03:21 +0100
X-Gm-Features: AWmQ_blYhauiyF-OMkjBxubo-x9ZLpIW-Wp0gXh6FaZH1ZHsThtizotDjFMWNFI
Message-ID: <CAHUa44EXPtdfPogjRirGB=aZ+ex-bD-iRf7m_=1OVk_KAY03_g@mail.gmail.com>
Subject: Re: [PATCH] tee: fix illegal pointer dereference in tee_shm_put()
To: yangzhao <yangzhao@kylinos.cn>
Cc: op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	Sumit Garg <sumit.garg@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 7, 2025 at 7:14=E2=80=AFAM yangzhao <yangzhao@kylinos.cn> wrote=
:
>
> Hi=EF=BC=8C
>
> This issue is indeed caused by the mismatch between the TEE version and
> the kernel version. Currently, this patch is only designed to address
> the problem of ensuring that the kernel does not panic when the TEE
> version is incorrect.
>
> The virt_addr_valid() is used to check the validity of the pointer
> address, because during the test, it did occur that the shm->ctx pointer
> address is the address between the user space and the kernel space. At
> this point, using IS_ERR_OR_NULL cannot detect the legitimacy of the
> pointer address.
>
> The problem can be viewed at the link:
> https://github.com/OP-TEE/optee_os/issues/7575

OK, let's sort out the secure world side of things in that issue.

Cheers,
Jens

>
> Thanks.
>
> On 2025/11/6 19:31, Jens Wiklander wrote:
> > Hi,
> >
> > On Thu, Nov 6, 2025 at 11:20=E2=80=AFAM yangzhao <yangzhao@kylinos.cn> =
wrote:
> >> In tee_shm_put(), there is not only the NULL pointer dereference,
> >> but also the illegal pointer dereference.
> >>
> >> shutdown() --->
> >>      __optee_disable_shm_cache -->
> >>          shm =3D reg_pair_to_ptr(...);
> >>          tee_shm_free(shm); -->
> >>              tee_shm_put(shm); //crash: shm->ctx maybe NULL pointer or=
 illegal pointer
> >>
> >> Check whether the pointer is NULL and whether the pointer address is v=
alid.
> >>
> >> This issue occurs when rich world uses the 6.x version of the kernel a=
nd
> >> optee secure world uses a lower version (such as version 3.2), and it =
is
> >> highly likely to trigger a kernel panic when conducting hibernate test=
s.
> > It sounds like the root of the problem is in the TEE rather than in
> > the kernel. How about fixing the TEE to avoid supplying garbage
> > pointers?
> >
> >> Fixes: e4a718a3a47e ("tee: fix NULL pointer dereference in tee_shm_put=
")
> >> Signed-off-by: yangzhao <yangzhao@kylinos.cn>
> >> ---
> >>   drivers/tee/tee_shm.c | 9 ++++++++-
> >>   1 file changed, 8 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> >> index 4a47de4bb2e5..de01d16409c1 100644
> >> --- a/drivers/tee/tee_shm.c
> >> +++ b/drivers/tee/tee_shm.c
> >> @@ -722,7 +722,14 @@ void tee_shm_put(struct tee_shm *shm)
> >>          struct tee_device *teedev;
> >>          bool do_release =3D false;
> >>
> >> -       if (!shm || !shm->ctx || !shm->ctx->teedev)
> >> +       /* checking pointer */
> >> +       if (IS_ERR_OR_NULL(shm) || !virt_addr_valid(shm))
> > The IS_ERR_OR_NULL() check might make sense, but the virt_addr_valid()
> > does not. virt_addr_valid() might catch a few garbage pointers, but
> > the real problem is that someone is supplying garbage pointers.
> >
> >> +               return;
> >> +
> >> +       if (IS_ERR_OR_NULL(shm->ctx) || !virt_addr_valid(shm->ctx))
> >> +               return;
> >> +
> >> +       if (IS_ERR_OR_NULL(shm->ctx->teedev) || !virt_addr_valid(shm->=
ctx->teedev))
> >>                  return;
> > shm->ctx or shm->ctx->teedev should never be an ERR pointer. The
> > virt_addr_valid() test doesn't make sense.
> >
> > Cheers,
> > Jens
> >
> >>          teedev =3D shm->ctx->teedev;
> >> --
> >> 2.25.1
> >>
>

