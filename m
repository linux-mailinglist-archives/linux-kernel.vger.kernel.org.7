Return-Path: <linux-kernel+bounces-847356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F87BBCA9AE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0551A63EC4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87FB1FFC48;
	Thu,  9 Oct 2025 18:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EcDZcqqi"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0BA2367B3
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035777; cv=none; b=gcBSCY3NvK1rAN+jWY0b/KGnwsxW4KLHJyphx4gIBbOfaxCQYTClxkPzwvGHUPQxu68rNXQWCgdfnU/v3Jm7KtRL86voX/J8xL1ywRCkZdUQCNoHJpqdKcyFX8HdnCA8qI6gBqddWWNc4KM95NmtEXkrzz3nFGjTHASHuw1CMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035777; c=relaxed/simple;
	bh=UShdFoBuAwfbyO6hqQqzp5FMsu6U9c0iB6HC4U7g1ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ErNc64FczS5EKr1No9W8cOn/8nHSaDnnjs+5Uf2PCq/OOIp5xl/Lg91U0c/NvEGroEuvjkG8reg7rzku18pSZZx2hJHN82QJUGDu8B8ysqusDtNxstafB14SHDqJsMbnOUAsjA39l+EhwwiyHSLsgGVJlTo259HO0IHxa+bgGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EcDZcqqi; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32ec291a325so994834a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035775; x=1760640575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDSmbrF8JzunGw/f0Rpkl5VvvKxlJtr9tXEz0PlojHg=;
        b=EcDZcqqiBtsbi61N8h7wS7XhQuCtkwIhRqwcUwfWdoCTZSXVqpqcEOowupGf3JbCet
         fqpbyQBNNWZ/4Qf1FS4WJ4MXuo1j7Bw0Fed06oddlPUnIsj52NDJrQG/CCP8IiASX5cW
         /wGVdHTRjheuPf8R4ErLbagj5vQnrNNTNbg1B8jFRrsBQnE8+/LzqhvUVXoGTxCjet3h
         TpvJrfF8OC8+w0GcqJiI2vtlegfiuYEoxcKavBZnbTeVucGLSJM4m7aqEIC5McZgM/G/
         mc+ZmklaBiuQ8urvf1pr1SXPDECyfP34AFlz9P1yPsxaJEjg6unOa+Cb+aRpA5b7cZct
         jHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035775; x=1760640575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hDSmbrF8JzunGw/f0Rpkl5VvvKxlJtr9tXEz0PlojHg=;
        b=ILpJsT0IsGpAbZ1IlfHwv3Nv5RTm0NIccgsAR2noJXScEg9rMAPvdY/yhtEAqrOohY
         FOyllCU0dpF/yBx0MoEK37OXEE3yk1tZtnodhB8HKmWnexuHvfDj1I1vYrVIQux9hIni
         CUZxMXZSUmC3jYpNaRmjvclTcZ6GefAusm10AbQe6F54NU6c/H5uWJOA74jRpCAaomEL
         Jg0TAi64xUED4xuS5LwO8nejZ1vNYBp5fMT/jeswAbACNxovap9YSSWfnp0Gun158812
         Wz2BIIlAyMCrNudHmAlWM6RpZBIQlyOtMtlpKxjAOWiqRVROcj7rLAw3ZGHdGMbgs1K5
         mRRg==
X-Forwarded-Encrypted: i=1; AJvYcCUA+ZCVo5dkw4i/0nPLsuxxXhHXPWxb2bsDtf2C4b0JMvX9oPuFoTyDEy70Q45BIn1dBYsUKjOBHUTKymA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7PVMfAtWsVVlbTatAr6cERHdEGVpE5sKUB55/Pawt9PfgGM6
	w+EinK0KogvGEm80ZnsvqrQr7QzCCeWpXPX4Sur6S/3+gYt6L2oT8ndq+cP55cdkdiUedjkgbV9
	TDn1D8evQHBHRDgqR/Sg3Cxt42/bC0zrrGg==
X-Gm-Gg: ASbGnct0Uwxqi3gGFKDYQw+ofMmhtDFktrou6NGTKttuWbQkV1bJpvI91rG0+ubsv3k
	q0QYsrDDcVl/uN9l5x782Dl6W2EClWEFi6IK2/NY2uDlmb/ZpzZNnd5o0Fi1oWiIOPQZZeJgSS3
	HrsEcXvHA8cBwetMCn6s/D3ceLRTMUkDlsmcBfs2m5JreHVcpbx6w+VWb0NQii4ZLXCu9W4tYUx
	IOstH1pqZHVJ9r4yh33SqRv5VQeWJINzjSk72baDg==
X-Google-Smtp-Source: AGHT+IFuJsC04j2tmVoA6UgpF4mz4gEVXtC5ekRaUxk+SFE0MHfOmJZkmq0YlRac/ZOBjT6dSC2Ll9q/RZoioR72pRA=
X-Received: by 2002:a17:90b:1e11:b0:330:6d2f:1b5d with SMTP id
 98e67ed59e1d1-33b513840bamr12506871a91.26.1760035774918; Thu, 09 Oct 2025
 11:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001215643.31465-1-casey@schaufler-ca.com> <20251001215643.31465-2-casey@schaufler-ca.com>
In-Reply-To: <20251001215643.31465-2-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 14:49:23 -0400
X-Gm-Features: AS18NWDBurz4VRzNl04xbd9NuEilFgbv9pRjpgx67-Z7i2XTMbO9mkM42Ls_urM
Message-ID: <CAEjxPJ7M4qySg+ZMujTqMQFSncWNbG21W+kpLzji6c4F+hyprA@mail.gmail.com>
Subject: Re: [PATCH 1/2] LSM: Exclusive secmark usage
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
> The network secmark can only be used by one security module
> at a time. Establish mechanism to identify to security modules

a mechanism to inform security modules?

> whether they have access to the secmark. SELinux already
> incorparates mechanism, but it has to be added to Smack and

incorporates

> AppArmor.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/lsm_hooks.h        |  1 +
>  security/apparmor/include/net.h  |  5 +++++
>  security/apparmor/lsm.c          |  7 ++++---
>  security/security.c              |  6 ++++++
>  security/selinux/hooks.c         |  4 +++-
>  security/smack/smack.h           |  5 +++++
>  security/smack/smack_lsm.c       |  3 ++-
>  security/smack/smack_netfilter.c | 10 ++++++++--
>  8 files changed, 34 insertions(+), 7 deletions(-)
>

> diff --git a/security/security.c b/security/security.c
> index ad163f06bf7a..e59e3d403de6 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -283,6 +283,12 @@ static void __init lsm_set_blob_sizes(struct lsm_blo=
b_sizes *needed)
>         lsm_set_blob_size(&needed->lbs_xattr_count,
>                           &blob_sizes.lbs_xattr_count);
>         lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> +       if (needed->lbs_secmark) {
> +               if (blob_sizes.lbs_secmark)
> +                       needed->lbs_secmark =3D false;
> +               else
> +                       blob_sizes.lbs_secmark =3D true;
> +       }

So if I understand correctly, the first LSM to register with
lbs_secmark set wins.
Not sure that's a great idea - seemingly some LSMs may want to insist
that they get to use secmark regardless of registration order?

