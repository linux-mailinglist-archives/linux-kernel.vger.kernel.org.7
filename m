Return-Path: <linux-kernel+bounces-892625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA010C4578C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 09:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70A273B4948
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A952FCBF7;
	Mon, 10 Nov 2025 08:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/j7MBQo"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120C12FD1DB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762765072; cv=none; b=nVAhFUi5unEAgfebB4C7drbRkpkfum/SIUEFfFNZ16vQuaEgC2zOz8R/E43ZtYKF0j9dO8ljmnru0eLxAFe7wn4u3IGWOJXS6Cy+tkIBO5y6H/wD4Uef24EziyXHyx9h74MMtp+kIIa1tjPdb6F+Klwv6m/9DqTHsKu2/dK7b8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762765072; c=relaxed/simple;
	bh=5GHxvDWQcxyWdVLkU5N2dv4/sQx2GEcWltELKfBhSMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E+OFxLTnj7AK5C6CBP34FrIjl7M5MZpoQwtrTd3wKUpaPALbkYfQC89elJOpk6OjGAvz9+Sd39KdJpddC10wKfFtIHtAPPAL+SLlFNCOzQaNJxFL9j+OfJVBbFUNrO2hfAzGhKumostm6rKCuOy/EMnYAGY4tHcFSpbxAAfy+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e/j7MBQo; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-3c96de7fe7eso1947970fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 00:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762765070; x=1763369870; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+DU4bC9oY8isR66wkaZVD1cgl7C2T/3TuAVsgHOOjs=;
        b=e/j7MBQorKMv3qhfZeOQYJho6w+nD4h2hGcT7LJ64J8+9Vg+Q51G6QBqasYV2cCoLq
         8FDDenKGD4F9Swc9Z6VrZ+NrTg3nlf8DC3pLMEJGle3g1sSF6INESYbuI3z/ivk0K6Zq
         VO1X3xfLKRM11XLURzU86C6NeH9/FvwwF94qgC1KO0swnuJzeQXDE/Y34ALETmvD5hGm
         s7t2j8VZmwpr03U0qvfkw3NH7kOWhT+x4bNhhMuBxdrGeHup6S2YmXlYOllpjEi9JGV+
         xql8kq7nIEQdOxUaZ1q9Yl8er0/OxZtxzf4TJmZ3zMpHahpKAe7KvrXu9YpRz20nNdju
         XG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762765070; x=1763369870;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+DU4bC9oY8isR66wkaZVD1cgl7C2T/3TuAVsgHOOjs=;
        b=EhAgUhMWsaSOoBdMgf3l/Sd4JxCzNt4S4UVr/T0AnpcAvZzPMO1g8QuSxskQVKO/7i
         wJT2luz0i9pn4Ou2fea6dBvlM2K99bXOC35AE/3IRTkPBdo2aU9GyveZ/5flg2Lw0pso
         bjFGe7zn24SxAcaWGC38fg2N6uVO/AuMXXMUMVWCt26csAMigG7XEmAxUrGERCL4BWFA
         HEXAnuP58pSAQYYifKnZzdYqDHah6NsYkuiNEYawuXIGCWGzo7JrUPjqGdMJzoudh0Me
         +51SAufACclXfF2R17znzNmQcs7oeqCJp+b/FEynaFEzmB1jsYzHlv2rXkV+EsV9NnHX
         AyKA==
X-Forwarded-Encrypted: i=1; AJvYcCVknMJlEpTyfhZiy3UR9gtM47y5EdxfrtsTqGSyA6kv1fkGtCujxkCXnddc/COiZ0zfVbQWYosP2NPSeSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtX02mTSsHCIb75tUyYDWTJ0CuwgQEJ/5gSxY5MeiwMWUJemG0
	cIX3zLZYHkN91YkIDESgqhBZvq4nyx1YQguOxq3bdkmsKnopbe2oMxZ+hJwrek9LlR2cak65MkV
	9bi8RtbXa+KiMNUxmH+HShqbLw51FMWlAGmQ3xG1Zyi/8l1TYJqgfFuQ=
X-Gm-Gg: ASbGncsRijloCQb8QSTHLqtUGJNRAeD4XzQ3l5zt54xejJM0GOeue/lM+Jv2NLmesqk
	atK12i6Ue5Vqh0CyqReiZhqHL4YAPuyrBIEbCBfq2fH9biSgmLCKwKGBTqKXRK2kK2GLpa7l9+r
	85/py8Rqf8TUMMyZtNbD66dGRdOmtP2T2Hp7w5F0HYGLEsW0Rqewaagnwp7gawStpfKsreLS07X
	5jz7BRmEqcM6dmBqeZOwqjAqgF0h9fz3c8XMxOa+ZsyLd0Rk3TQnMNndjhnsc0+Hg8dP/E6eqWk
	6ENs
X-Google-Smtp-Source: AGHT+IEvNSWQF8V50WXZvHvTh5vdg6c1kYKSH5fDM/Ta6RUD/FEZDy3lz08IzLZFRWp24NzfBrjEWgoxjvYDKgubZn0=
X-Received: by 2002:a05:6870:899a:b0:3d4:760f:544b with SMTP id
 586e51a60fabf-3e7c294ab31mr5259236fac.46.1762765070045; Mon, 10 Nov 2025
 00:57:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com>
In-Reply-To: <20251105-aheev-uninitialized-free-attr-tee-v1-1-2e1ee8483bc5@gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Mon, 10 Nov 2025 09:57:38 +0100
X-Gm-Features: AWmQ_bmbfwlbuD27u393tcu35e2C0scPDS3Uy66i-DK7aOy74DFrH1rStFwJq9A
Message-ID: <CAHUa44GYnZFaZQBNbV0=RSR7r61+ErYdQtEsRObNALz2CwT_Gg@mail.gmail.com>
Subject: Re: [PATCH] tee: fix uninitialized pointers with free attr
To: Ally Heev <allyheev@gmail.com>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>, Sumit Garg <sumit.garg@kernel.org>, 
	linux-arm-msm@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	linux-kernel@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 5, 2025 at 3:20=E2=80=AFPM Ally Heev <allyheev@gmail.com> wrote=
:
>
> Uninitialized pointers with `__free` attribute can cause undefined
> behaviour as the memory assigned(randomly) to the pointer is freed
> automatically when the pointer goes out of scope
>
> tee doesn't have any bugs related to this as of now, but
> it is better to initialize and assign pointers with `__free` attr
> in one statement to ensure proper scope-based cleanup
>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---
>  drivers/tee/qcomtee/call.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> index ac134452cc9cfd384c28d41547545f2c5748d86c..8b7b4decddd8d1811dc0a7cc4=
6a4a4fbada45526 100644
> --- a/drivers/tee/qcomtee/call.c
> +++ b/drivers/tee/qcomtee/call.c
> @@ -645,12 +645,13 @@ static void qcomtee_get_version(struct tee_device *=
teedev,
>  static void qcomtee_get_qtee_feature_list(struct tee_context *ctx, u32 i=
d,
>                                           u32 *version)
>  {
> -       struct qcomtee_object_invoke_ctx *oic __free(kfree);
>         struct qcomtee_object *client_env, *service;
>         struct qcomtee_arg u[3] =3D { 0 };
>         int result;
>
> -       oic =3D qcomtee_object_invoke_ctx_alloc(ctx);
> +       struct qcomtee_object_invoke_ctx *oic __free(kfree) =3D
> +               qcomtee_object_invoke_ctx_alloc(ctx);

Can we zero-initialize oic at its original location instead? Doing it
here looks messy.

Thanks,
Jens

> +
>         if (!oic)
>                 return;
>
>
> ---
> base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
> change-id: 20251105-aheev-uninitialized-free-attr-tee-0221e45ec5a2
>
> Best regards,
> --
> Ally Heev <allyheev@gmail.com>
>

