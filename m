Return-Path: <linux-kernel+bounces-714027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D5AF620B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 20:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5402523E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jul 2025 18:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 303292727F7;
	Wed,  2 Jul 2025 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dS4AbLBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA702F7CE2;
	Wed,  2 Jul 2025 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751482641; cv=none; b=MIaGoEsJXBIu/p+lDVWrRpp6giQq/s27/Sox8Qz75wUeSA+rjHuq8VNIwZboVMxEsZt4NY0r7ogsnju28KI3X2fQdEbKv4tohPkD7boP224tDAK7RU3Y3gfrFfYL0kk3JvGVOqCFEw9a7kp5abZM/2HGgAhSpTOmCJi7lN8+dJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751482641; c=relaxed/simple;
	bh=oAuYWwMlcoUOMp7fNhysK7uclvqFv4Y+nGaAFChmaZk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgPA+bLcy7REWSZIVsEEUjiS6Lt4TqWjlGRQ5l0P+2dxxV/VgFplh5reDAGnc+yfnnWN3Ygsyuputrk1xqYonH8f7aVOoIVQrCYu1BBE/HcGAuoYHivk4EM8/iPY/GP4xuQUp8lLIKXCF40SEGrPnGmkwGMzL+u4Z1QqpXBd1WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dS4AbLBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58111C4CEEE;
	Wed,  2 Jul 2025 18:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751482641;
	bh=oAuYWwMlcoUOMp7fNhysK7uclvqFv4Y+nGaAFChmaZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dS4AbLBdF5J/y7IDK4f9Xr4xeCHicSFDNyYvpT/kfowNEsMQYG9HevkEMhjtbP8CD
	 ZSTJfI2qQXiyaoYCYIBdWi78PJ2MGzkPxmRBMlc2M3qi1jaF9jzUbKjIGLtxdKaOxA
	 PUY8mi6d2nB40J6eTIeyJBgqin8gnrSaWsX+DOcfVhr2c3hvpTsrZrFH5V3gjNn7C1
	 qjyA+7WobDqTLoFAmDWM4MZwSBwvkQhOUp0NTPalXCge9fored9PsEtBz2YC2YtTSk
	 hF61su1kvAN9mQf/JfOHgoilu1doiJDp4IPgj9Jh8BQfk2TBUo33abe2CEuRhZHa8R
	 4FEcPfGPqZP2g==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-60be827f2b7so141884eaf.0;
        Wed, 02 Jul 2025 11:57:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVfAkIChIkeSy6ikL6o+a+GmLLPIPSGwy0Ik4uBjtM45HJHfqx4/JugaOGU6QxKVzB07ryXKVdLO2DpySk=@vger.kernel.org, AJvYcCWj1458pAGOEaBfwXpx3r4KXTKlsY3UZReuJhQ9hKnqE61OMpvv+p2RGCiwO7Lg78Ksj0+JLG1Tuew=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW+MN/YI8PZlurSSQFUwz2gwxuZR0SefeofWlXNzCn5BB6jcJj
	cG1yrxPFMSqAw4kRLEPZPGUsEg0tNGor/B0RQ1xHRuuq+Yh32I2pBkxLrYH6JjZS58SyMiAIZgD
	ZyB9vR4ivBftQytaa9/jDhvKqSMJc440=
X-Google-Smtp-Source: AGHT+IFP1YS20zKCA03/uE1QUW5rL9pMJhvUrlaZQJ5bihmEEMLvJ/fS/OBD5RwvXkhn2ZjCno+yFWcWUj3+oDHl+QU=
X-Received: by 2002:a4a:ec4c:0:b0:611:3e54:8d0a with SMTP id
 006d021491bc7-6137e862d21mr549827eaf.1.1751482640540; Wed, 02 Jul 2025
 11:57:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250619035355.33402-1-zhangzihuan@kylinos.cn> <20250619035355.33402-5-zhangzihuan@kylinos.cn>
In-Reply-To: <20250619035355.33402-5-zhangzihuan@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 2 Jul 2025 20:57:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hR37in6uikFGgtM+PjXuSCQSc7mk0uLwwniNUKZvnZng@mail.gmail.com>
X-Gm-Features: Ac12FXz1Jq7KszMG7oyR4xMkecASU-xjA2tkI-uMdUtmxNDCJjvElllZ4S2qQSM
Message-ID: <CAJZ5v0hR37in6uikFGgtM+PjXuSCQSc7mk0uLwwniNUKZvnZng@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] PM: suspend: Simplify state check using sleep_state_supported()
To: Zihuan Zhang <zhangzihuan@kylinos.cn>
Cc: rafael@kernel.org, pavel@kernel.org, len.brown@intel.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 5:54=E2=80=AFAM Zihuan Zhang <zhangzihuan@kylinos.c=
n> wrote:
>
> Currently enter_state() open-codes state validation using
> `if (state =3D=3D PM_SUSPEND_TO_IDLE) ... else if (!valid_state(state)) .=
..`.
>
> This can be simplified by calling sleep_state_supported(), which already
> encodes this logic. This improves clarity and reduces duplication.
>
> Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
> ---
>  kernel/power/suspend.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
> index 16172ca22f21..b95c7a80ef20 100644
> --- a/kernel/power/suspend.c
> +++ b/kernel/power/suspend.c
> @@ -571,16 +571,10 @@ static int enter_state(suspend_state_t state)
>         int error;
>
>         trace_suspend_resume(TPS("suspend_enter"), state, true);
> -       if (state =3D=3D PM_SUSPEND_TO_IDLE) {
> -#ifdef CONFIG_PM_DEBUG
> -               if (pm_test_level !=3D TEST_NONE && pm_test_level <=3D TE=
ST_CPUS) {
> -                       pr_warn("Unsupported test mode for suspend to idl=
e, please choose none/freezer/devices/platform.\n");
> -                       return -EAGAIN;
> -               }
> -#endif
> -       } else if (!valid_state(state)) {
> -               return -EINVAL;
> -       }
> +
> +       if (!sleep_state_supported(state))
> +               return -ENOSYS;
> +

The code before and after is obviously not the same, so no.

If you do a cleanup, don't change the behavior.

If you want to change the behavior, there needs to be a good enough
reason.  A cleanup is not it.

>         if (!mutex_trylock(&system_transition_mutex))
>                 return -EBUSY;
>
> --

