Return-Path: <linux-kernel+bounces-848620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4058BCE2F8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 20:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC04F19A6E75
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 18:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB29D2701B6;
	Fri, 10 Oct 2025 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4lM307M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D0B1FFC7B
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760119609; cv=none; b=A37TauU+TuxmGzU6DNv/8ItrwiAcK/NPu/iBrJ6DPAcUCRci0lgGsqghU0zR8xfobzr7YS1DTjyMfIDLbhw2O/clXM2cG9IQUbF6vEJZQoJg/m/oqWxIIMcRPXf/EqcgMMY4kW7rhHvdqxbzHXSzJK1uhZl2RwSFywADg8ZX0kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760119609; c=relaxed/simple;
	bh=g6rAGjV2Nc5xVFKhlt4vH4nfZspBAllGy6FhsdVHNPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/6ytymN5L113lZR2hmpRixr/j+ah5DJH3fWny5sNoPOtQXgxFd790/FqzEaZjU1SIYvRan5nvf2MoBJCBrdzUvOw8RswiVjN2uDnbCM2fwGxMoAPKJuDMv2OJ1hqo3Mf70X+F2TDVkQcPoCkONHAQQ6/WsywXRQYJ8pF5Pbffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4lM307M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0064C4CEF5
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760119608;
	bh=g6rAGjV2Nc5xVFKhlt4vH4nfZspBAllGy6FhsdVHNPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V4lM307MSiWsXHYPcglVnIstcNM3MYEFeN09VDzpAFUwu5g9onJb9UTupLGindfZ1
	 YLwc55+Ey/2dsyy33y3UAzTXpAMcmbOOYnJI6KzWMl/tqhTm7e2acLQHx6vCxBm8DB
	 9TzlzrSJIJPOmgy+VYfVatgaoP7awsyvxesx0dMh5pC3+bY6jj+isEwIG9W4AOs4mM
	 7V79+e+j5HybAHjsDUy7sjnzHayrT5t91iC68B3ITJi9CaKPy7DyLI2zJlfg4riDJa
	 Ny1701IDkB4sGdEbqXUEGH6V5D0qZn5ov85rNEYBj5YMBxkZBvGVaAuRkkQcpvmtzT
	 +73PFNJdG11JA==
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-79599d65f75so22956706d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 11:06:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVI4XKNn+rSSy4KMXjtkuEZI1YaLANOQgOiS+8MSVnL+f49AH5+ldMkyNtHeCpUs4zh6xoCORsp6r3Jp4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb3+cSFfSMmj5s1Xr7aX2ZZikVr7MhQoC37DZJrv2lf+y+uPrR
	WAsBtrNA5blw7wrzJnyVpOuvqa/9LfoOqbBziASzPkFF+WLfgOn0Sn8+v5B9VOJ4jADJFj1oxfG
	1vp//8iH9BoTazWmiREXKKbXOzEyeDYY=
X-Google-Smtp-Source: AGHT+IHRUJUAeJ5Je+YkDxQC/r6OXXbCSgJvVm1kGkEkaJIEhWHQvapqgQY+O5ZOx/oTWMHOfXFhHohJ7guwKL4YvOI=
X-Received: by 2002:a05:6214:19cc:b0:795:67ac:ca5d with SMTP id
 6a1803df08f44-87b2109283cmr190852096d6.30.1760119607787; Fri, 10 Oct 2025
 11:06:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251010132610.12001-1-maxime.belair@canonical.com> <20251010132610.12001-2-maxime.belair@canonical.com>
In-Reply-To: <20251010132610.12001-2-maxime.belair@canonical.com>
From: Song Liu <song@kernel.org>
Date: Fri, 10 Oct 2025 11:06:36 -0700
X-Gmail-Original-Message-ID: <CAHzjS_uBq8xGCSmHC_kBWi0j8DCdwsy4XtfkH2iH6NygCcChNw@mail.gmail.com>
X-Gm-Features: AS18NWD0sroF_9UF1VNMCiu_x8h4vyhFWvp2MLYPnP6wYTvtieiio2L0R61pPKg
Message-ID: <CAHzjS_uBq8xGCSmHC_kBWi0j8DCdwsy4XtfkH2iH6NygCcChNw@mail.gmail.com>
Subject: Re: [PATCH v6 1/5] Wire up lsm_config_self_policy and
 lsm_config_system_policy syscalls
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, mic@digikod.net, 
	kees@kernel.org, stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, penguin-kernel@i-love.sakura.ne.jp, song@kernel.org, 
	rdunlap@infradead.org, linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 10, 2025 at 6:27=E2=80=AFAM Maxime B=C3=A9lair
<maxime.belair@canonical.com> wrote:
[...]
> --- a/security/lsm_syscalls.c
> +++ b/security/lsm_syscalls.c
> @@ -118,3 +118,15 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, ids,=
 u32 __user *, size,
>
>         return lsm_active_cnt;
>  }
> +
> +SYSCALL_DEFINE6(lsm_config_self_policy, u32, lsm_id, u32, op, void __use=
r *,
> +               buf, u32 __user, size, u32, common_flags, u32, flags)
> +{
> +       return 0;
> +}
> +
> +SYSCALL_DEFINE6(lsm_config_system_policy, u32, lsm_id, u32, op, void __u=
ser *,
> +               buf, u32 __user, size, u32, common_flags, u32, flags)
> +{
> +       return 0;
> +}

These two APIs look the same. Why not just keep one API and use
one bit in the flag to differentiate "self" vs. "system"?

Thanks,
Song

