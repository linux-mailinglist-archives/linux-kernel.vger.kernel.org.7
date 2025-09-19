Return-Path: <linux-kernel+bounces-824186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4760AB884EA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 09:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99565224CD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 07:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A13012EAB94;
	Fri, 19 Sep 2025 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8sgX+OM"
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367DA2FE057
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758268740; cv=none; b=JIk3tWxtfOTr/5qBO1o3QewscQty0DdgpTQMe7ILzpIZ4EksM2ZJtZDec6ul0WPHHDachxEU/AuD1qyyRysK4fAnWBZVh7vqC6IZNhTljiwzpXZxdgG0L7huknQ+nhnPq8EJVU6v7JCs0xSIFtj+OB0SDVqHI9nvrQPd+c7eAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758268740; c=relaxed/simple;
	bh=O+hzsSvVnJz7MunYFuB149YvUwD55qvPOuK7bklmxF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdK+8l16B3K6vIWoT1uqsxYS99FPsvekcWj5/kRqMh7pZ+8ldSvTEiVnxtd3ZcVFhLCRtZ72oCX+1q9QbkbESpvs+E36QXt/8AWAEfD+QyJQYMMds7bACCoGpFSXt+Pvf+/41ZiBulCWhLYjoF/ULwAcng64YSknsQEtIatmdrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=U8sgX+OM; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-621b965a114so948275eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758268737; x=1758873537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHJ3UbPpS3D5IfXMLoQP0sFO1NEt5wlea5HnZpiaQh0=;
        b=U8sgX+OMvuAMhWAlTzti44Vh98HqEFnUG2ujSwiS4fo7cGSZmErv3+k68VHbPMegHO
         PHFMKM4nYYFJ3D+JwXM+7gaRNA5fCkfCSL3yES2TQ/pBnUy3z0saX/GzcQQAb6taAwlD
         QOQiyhBhPaT4CRkHFTJWIqkoJpqIjMFHknaca3MqRAN7tDvleJLK7Lupl2Zbeh1ilakS
         Ge9eY9UlcjI/abZ8h8i6Z7Oop9r7c6FD87tIZKg3IQdWCB8q4iXzv8UP2qGT9xyCUFWy
         nuCoFuqvGCRyC5OYjvZIsrvWKYRhJysn7KbsoX4QStZumnJunHE6lw+SDaOG7hAmNDiu
         jR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758268737; x=1758873537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHJ3UbPpS3D5IfXMLoQP0sFO1NEt5wlea5HnZpiaQh0=;
        b=sjZt7CpTzQ76HQrQ8/JgI6nYUBiQeBhUmJ64iGROAtPrjb/NHDx8JumJQjr14cg6NU
         +vKt5x3TqRkajgIxr+w3O0noY4+EMDf5TYTNHu+THfU2V0aW+NSExxUcoZU+Y7X4bwsS
         eu7U6we8h1/l4MKMiP+DrZPqJAJ1e/8VU7CMBrJ3rag5RT+XVpEpJ42e1dpzSLvcKzj5
         3VyfAPaU5QlqXitYLMI+Jbsqt+EdxUKzGThzFLpuShYz78ojf51Y0OUlcm1qyQ3/GwNr
         kHxYeZ92ZHsUjNd6kkHs2qlJb5pcRuwa3Te7Mtz42mp5JaEg/ooFEsQ4soN6AFH3NRE9
         kvmg==
X-Forwarded-Encrypted: i=1; AJvYcCVKqESMmX6kJQbL3+hlLldsn6ZJdXhN2jX/koMMmvAxSYdUd53NEBaOvavZDZCgrHprqjCZKVVLhPLWoQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr/dZf0+6+VXtdOMbuHZllqnt8nsatwVtm2v8J8j3DQxQM/Ye7
	9obsxDMWa4l8vyFmCSxWFZxk8RNbYebcSweerpnNfXbq1Vi0kXOk3Udyu8k3CDqrG5m/htk4dDf
	UocwTynq7tro4UV2nmgV4VFNiheUaA7doFsT5QqT7aw==
X-Gm-Gg: ASbGncsGXJv8ZeXupGQ6qvumsvDbVASYAJpFeAu29DKALOcYdMux6nJtfnDycSXpjCG
	xLk67G8hz5VTEa5fw2w74ZEZg+rAtRb9WQZg3OaCfjXjBA5eRgo/RG278lHVbRMDdF2efRHX1KA
	59JKCMVfu9zoYkmsrIWuq/f1thrvEDVqS6mukreyZFnSFhhrnkZ/N8kUr4YAYTSoXmRxLVoCSZc
	Ap8ruZc
X-Google-Smtp-Source: AGHT+IFkd+gNrjrot18Zo5hmp077YMeppKIoRCZvWMh3/mqyMghiA3DIyH1IQhZkyQF86NUjQQnEf00dsGPBqTCeBfU=
X-Received: by 2002:a05:6808:6f85:b0:43d:6b7b:2469 with SMTP id
 5614622812f47-43d6c129f19mr966534b6e.4.1758268737218; Fri, 19 Sep 2025
 00:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aMvV8WIKnqLN3w6R@stanley.mountain> <aMzodGIvL88HNi0d@sumit-X1>
In-Reply-To: <aMzodGIvL88HNi0d@sumit-X1>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Fri, 19 Sep 2025 09:58:46 +0200
X-Gm-Features: AS18NWD_RyD3kl7DRtBl_0VNsyLANW3lHRdWn6UrulYuNqtupf3pr3qBMXZkBaU
Message-ID: <CAHUa44HLULAZ3XXimqDzCfG8rc8OzU-ACmv2Gaee7Xbi=w3VEg@mail.gmail.com>
Subject: Re: [PATCH] tee: qcom: return -EFAULT instead of -EINVAL if
 copy_from_user() fails
To: Sumit Garg <sumit.garg@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
	Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org, 
	kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 7:22=E2=80=AFAM Sumit Garg <sumit.garg@kernel.org> =
wrote:
>
> On Thu, Sep 18, 2025 at 12:50:41PM +0300, Dan Carpenter wrote:
> > If copy_from_user() fails, the correct error code is -EFAULT, not
> > -EINVAL.
> >
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> >  drivers/tee/qcomtee/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

Applied.

/Jens

>
> -Sumit
>
> >
> > diff --git a/drivers/tee/qcomtee/core.c b/drivers/tee/qcomtee/core.c
> > index 783acc59cfa9..b6715ada7700 100644
> > --- a/drivers/tee/qcomtee/core.c
> > +++ b/drivers/tee/qcomtee/core.c
> > @@ -424,7 +424,7 @@ static int qcomtee_prepare_msg(struct qcomtee_objec=
t_invoke_ctx *oic,
> >               if (!(u[i].flags & QCOMTEE_ARG_FLAGS_UADDR))
> >                       memcpy(msgptr, u[i].b.addr, u[i].b.size);
> >               else if (copy_from_user(msgptr, u[i].b.uaddr, u[i].b.size=
))
> > -                     return -EINVAL;
> > +                     return -EFAULT;
> >
> >               offset +=3D qcomtee_msg_offset_align(u[i].b.size);
> >               ib++;
> > --
> > 2.51.0
> >

