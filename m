Return-Path: <linux-kernel+bounces-847359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCD5BCA9D2
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E54221A63F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0E2512C8;
	Thu,  9 Oct 2025 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdN63dL5"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B935624DFF3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760036017; cv=none; b=ZbBsaPB/yp1R+0euHsodkXqhrRnMbms1WzTeQyLjNy7X2O0l9ufOrlMD7Tg5LJWwUlXpRO83711RsqEa7HiSlgiNQphS527Q9JNZ7ftN66NQP793xuhnV89pAjbM850vqZ3YzyJq6AFKf/+6dXR5UEpHTnWWyKjuO/d9MZmjztA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760036017; c=relaxed/simple;
	bh=1ac/fLFPsYRuSpEkij40k5Zmt1ThI8YAweN99K6QAss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RCyV0x6VR9ECrWxMaRnL+EXBfhMjQDpjjgLzRQGvSJrPaUuCD3KkQ6OiZJq/m/7xNxKI5FxD7FbWOULJSXENvkoapJciaTd7hYGIB/Q1VHKPj1DnqsFUA/udpE9BBeYcFF9Na9M/qKPrqvxI2GWLDjmRz8GjRsT6PrZYhgGDhlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdN63dL5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32ed19ce5a3so1256600a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760036015; x=1760640815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B1Uzp5iLkP5Bv1fIK+1rV8CxjLbvYcFDDKRV4JvrlmM=;
        b=QdN63dL5wPR0n/taPwv6oeKB/ueChxEfKvcz40tSBsgCljMJM0rR+/jxWX7mN0Ygbp
         Y/FPUkFD0K1zBzk94PAG6RderRkAi7iQ3Tcb/11j4m6tP+hkzIBFEdibDKEmJy61C/Fm
         xdatRxXMp79ahOMDpc9syoqlFYRR3UHLXsSTl7DTbiYLUFWdAobkOj1zz7Qd8l68LZET
         4eoyqi9Zxz56lKVoHe9NLpYhtqjCcjfMGJ22buKmK/ZbIN5OsFhYjQmSrLzFzte4d02Y
         ibgRvuVhS9ZKOtJldFa6jICte/nE8EUk2EKCrjuiRExC5iC0rzaQxda5gkdfoMjQxkwa
         goZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760036015; x=1760640815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B1Uzp5iLkP5Bv1fIK+1rV8CxjLbvYcFDDKRV4JvrlmM=;
        b=ppG37FjqJBb/Nm2+gRsb7TCJsetVdgnsUhspCcYAW04jzO7kv7wO/NC3vI/3y0Z8Bu
         sy76iQMSzeCypXEybNVPpt7jgcdTij3Ad6JFV0Pu/wKNXfPrZpm/qlCigYYIF/79iJUL
         yVV32cdBQTS/GlVEQvz9ky5Ay/prACAgEfWh2C5JNJs+XQKYcgWDotAims+vEr+eWIWw
         0Ezd6ZlCmpMNyiULyN9lyaB0horUBdcxZa4iLbYYkDdYV6HPfO8Flmi144R0RvA0OWNV
         ShHleKUj1WGT9BsJsjmRyrN/uyzHtpuDQSM90HHwHf4wAAez+uacUGxCFszsGX4gd8xR
         oU0w==
X-Forwarded-Encrypted: i=1; AJvYcCVS+TMo8xgMYDc/qTUJM0znHnbCVSQuPqHsiebZiH6SgTRrCafT3+mgQIn/XK8ZNRl2YAnesBH2foIT5JQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRROVq7w0j6T+2uvNcGhUKt9uRiPdSopWv9Ysw4APwZPh+F/ug
	qur2HT1J7todoKkDjQyZMieE1XZgBGZoNol1JCauUr5tPAlAJNLaXqAWgersuwWX0+VzeMA7QCz
	vM9Nb0Kvzv7bhKWQD0WtLO3iBU9k5sTVfBw==
X-Gm-Gg: ASbGncu43lH2igEwWQQa0GcbmrpsUIN+eNW/FYCiCkVbeJBf0J3DXOlPxkQHpur3ePZ
	CmktXHIFU9AgM3g3VOHoWVgr7ucPwb1WS0HOVyK57HZydnAII9F1eeN4/8JtR07BFrtshuC237L
	noYvipI/w00/9Pp+Dxrz5d1pOpwihkLc2v/XPW1OenR4ncfIdBKAQlWMSLzJC+OTCfTggzH7z9y
	3o3B7qGxqowxssCSe7KfJh5hFoV+r0=
X-Google-Smtp-Source: AGHT+IEr6xYml/4oPWWPBOYMdsJawHFJTDIUl5AA78sk0QeeIlMy3jRJkuZ6KGVkF1uxh5CG/9S2tm6wzcvo7HYhJS4=
X-Received: by 2002:a17:90b:1648:b0:32d:f352:f764 with SMTP id
 98e67ed59e1d1-33b51105d58mr10655063a91.2.1760036015068; Thu, 09 Oct 2025
 11:53:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com> <20251001215643.31465-3-casey@schaufler-ca.com>
In-Reply-To: <20251001215643.31465-3-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 14:53:24 -0400
X-Gm-Features: AS18NWD9a_Fk68Lh5JrlS0gUk6gyIQxpz3GgsrNopdIM_qVpZUajo16zBkCmCyY
Message-ID: <CAEjxPJ48PiZ5ZOZbZjka5YeiBxaWFsCufoGcY_jEztM+wtEUCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] LSM: Allow reservation of netlabel
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: paul@paul-moore.com, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, keescook@chromium.org, 
	john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:56=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
>
> Allow LSMs to request exclusive access to the netlabel facility.
> Provide mechanism for LSMs to determine if they have access to
> netlabel. Update the current users of netlabel, SELinux and Smack,
> to use and respect the exclusive use of netlabel.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

> diff --git a/security/security.c b/security/security.c
> index e59e3d403de6..9eca10844b56 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -289,6 +289,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blo=
b_sizes *needed)
>                 else
>                         blob_sizes.lbs_secmark =3D true;
>         }
> +       if (needed->lbs_netlabel) {
> +               if (blob_sizes.lbs_netlabel)
> +                       needed->lbs_netlabel =3D false;
> +               else
> +                       blob_sizes.lbs_netlabel =3D true;
> +

Same principle here - if a LSM wants to use netlabel, it may want to
guarantee that it truly has exclusive access to it no matter what the
LSM order is.

