Return-Path: <linux-kernel+bounces-847349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8ABCA975
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 20:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DC214281ED
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 18:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B1624DD09;
	Thu,  9 Oct 2025 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YnODS5kw"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8921BFE00
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 18:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760035120; cv=none; b=dQ0VlDy8rRd/DQYV/uhig0FM8sUfqP4mqJM43O2dwo342Zq5hAxsDYE1605UtBlEZpf77gKrMoYRBIdfTcjT7VLxBuVZCbH+SmuoETMjUkMpSmVVHHxrzvVqZMrzk+awCktKQ1rybYysC2Exa8+QTrfilXR+Bl3BHeXH8FkSgFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760035120; c=relaxed/simple;
	bh=uc5fJQsGJgb8TKtrt4MNAJYGQ1zQS8XPkUbMORFhV5o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fq+1TM3V1UeQ2gHmLLWAUhdoW8r0d3HI3cn5mk17QVm2jOwkosy60zl0nnRMjnk+3HHQLOgPgNHFiX6oHN/g+WuI/eIddJ7NVR1R5VvGYvhcXR5wdIaFlLEBvdgToH72CsvXQF2Qo+dcxR7gyfwNU8ydBgAKK1ZkxZaSqRoGtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YnODS5kw; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33292adb180so1244504a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 11:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760035118; x=1760639918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uRnmBs3bu/Z5++L4FvOqDgypy6pd49YNgJGmGrhncu4=;
        b=YnODS5kwwLmd4p0NnVe1deAmz4p/3KcLFdgR9V3tS8+yU930EouiESo9BBNxy/ZgJH
         2ElpI/nkNwu1qjbED32ln4Uv7lt4iHIgHblLFeAHPOiibiJLRuR95C4gFoEXMrlycViU
         quMOma6QtbRoCjTU1Q2PEEZJQecIg+c5S772HsxczBV8guMLWJOLSmtwa6JIBR+nFVdy
         D7ZAvmqrQTOs2rWkJ6yQRtlE9a7nKKo4oyZ9nWdt7vTNAXdBxmnfblUCkTD1T0Tn9qFH
         cJziIgYurI31166/gGgserDkuhEqWG//JsN8PZCy8wuEkft37gOWffPHhSZjEYWK0D3x
         uh2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760035118; x=1760639918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uRnmBs3bu/Z5++L4FvOqDgypy6pd49YNgJGmGrhncu4=;
        b=Br29MVpRvLMJNmPRJCUZ0TxOM4U+oJuzM2AD3nIEeBQq6mXBlxk8ma48Vcuw+r2tMf
         FotwIlpmFf+WSwjMsDr6u7kUmAOK1QJwd26BK7HElWZxaAvuS/w8lE4LfVUg/rd/ucvZ
         GDwzKe5aFneDgOyEL0DUCSvKnc5yJB8V0wLex2Fo+zY4m9nYtg03S3VCalCQ0xEpkstL
         R1yJh3bKmrzk7F6NisGmyNN+vfDsuE0OMYbKesz1CI6gOfKTCOwCVcdgNCHBxUGSLsbu
         uimw/huoLgAA1D/blDvDJx4FsVaWvRnltRk9pcqbwc4W/h/mqntN1zDyWV0Loll/1bjV
         RuKg==
X-Forwarded-Encrypted: i=1; AJvYcCUksFE+ytuMfMyUXFhYSgdOWJj503j8uGW5nIlRdnTOq/HCNHtSHTbygzrEvpl7NwIDjHvFh/8MTUGPwmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzft42uoU8vf5NFwuM3z/SaHjRbThXafFhUIgKBZAf1iU9NwxNf
	HHfixJ9V1NzhBbL8FOt5a6VTQEp/TzCnRwvQgkCU0gPtcZKDbOYDrtyo4xaxkk3cdNgtGl6QTkn
	IjGn5LT7iIGNcRVh/1KbewaZIAXA4/Qc=
X-Gm-Gg: ASbGncuEdqP4RryWivNRX9n6336GKMJfTA6Yg9TaNkqvR7ZhF0E7WjtOH0jEmeH289i
	paglcbNU9PqckL991qIBYmsXJSY4kuTTCIvV+pAaBum6NbDvQg89Lm6xv/m2gujY5Ky/U/dHfgn
	Ity7UslQ4ww6U9QOBYpWlykFEvXRP5T94vm5QHHlGzJuRkZVtz+QRtvOn8po7CKg1vEbLIUcrOd
	Gzc8SMpT4EH1blsBEKXoxFOek8hwmw=
X-Google-Smtp-Source: AGHT+IF6+vHoSPAPu/kmoRZVAL5HBvulLN7D3Dg3aJqMJxirCFziVTM6riwQQRESpPcUE/EAAP5IslXI+D/JCY6pRQ0=
X-Received: by 2002:a17:90b:1b42:b0:330:a228:d32 with SMTP id
 98e67ed59e1d1-33b5111891emr11394539a91.10.1760035117884; Thu, 09 Oct 2025
 11:38:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925171208.5997-1-casey@schaufler-ca.com> <20250925171208.5997-3-casey@schaufler-ca.com>
In-Reply-To: <20250925171208.5997-3-casey@schaufler-ca.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 9 Oct 2025 14:38:26 -0400
X-Gm-Features: AS18NWAYJ3O7XILrGAYfzTb7IkJ81kAiTqesEPkSBBRxZgeNK-1-SB6vpngGrBI
Message-ID: <CAEjxPJ4D7A4KDF9BfmRa9VvzcAHBkkrdKCvmGazuZUto5=qDuw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] LSM: Infrastructure management of the mnt_opts
 security blob
To: Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>
Cc: paul@paul-moore.com, eparis@redhat.com, 
	linux-security-module@vger.kernel.org, jmorris@namei.org, serge@hallyn.com, 
	keescook@chromium.org, john.johansen@canonical.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:12=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> Move management of the mnt_opts->security blob out of the individual
> security modules and into the security infrastructure.  The modules
> tell the infrastructure how much space is required, and the space is
> allocated as required in the interfaces that use the blob.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 4bba9d119713..1ccf880e4894 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -656,19 +651,13 @@ static int selinux_set_mnt_opts(struct super_block =
*sb,
>         mutex_lock(&sbsec->lock);
>
>         if (!selinux_initialized()) {
> -               if (!opts) {
> -                       /* Defer initialization until selinux_complete_in=
it,
> -                          after the initial policy is loaded and the sec=
urity
> -                          server is ready to handle calls. */
> -                       if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> -                               sbsec->flags |=3D SE_SBNATIVE;
> -                               *set_kern_flags |=3D SECURITY_LSM_NATIVE_=
LABELS;
> -                       }
> -                       goto out;
> +               /* Defer initialization until selinux_complete_init,
> +                  after the initial policy is loaded and the security
> +                  server is ready to handle calls. */
> +               if (kern_flags & SECURITY_LSM_NATIVE_LABELS) {
> +                       sbsec->flags |=3D SE_SBNATIVE;
> +                       *set_kern_flags |=3D SECURITY_LSM_NATIVE_LABELS;

This seemingly would produce a change in behavior for SELinux.
Previously we would only do this if there were no SELinux mount
options specified.

>                 }
> -               rc =3D -EINVAL;
> -               pr_warn("SELinux: Unable to set superblock options "
> -                       "before the security server is initialized\n");

Ditto.

>                 goto out;
>         }
>
>

