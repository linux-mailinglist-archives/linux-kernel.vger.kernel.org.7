Return-Path: <linux-kernel+bounces-887708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72CC38EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 03:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A08D74F4F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 02:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930C24DCF7;
	Thu,  6 Nov 2025 02:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llymclVl"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D212253F2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 02:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762397619; cv=none; b=IYlOrojkm7dWil137lfKq+QXjRVo5Z982vI0DmvxfOH12CpjRwggs5WjcgyYMW82q5u/JxbHpzqayovJeRuIiKqF9mkFChAfvJRsYTo71uCqM2tTiULRww5ZPsHSMKKgLNxHbveE9TZonAXYVSn6+LxFtj0QpnnS1UpnDJxx6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762397619; c=relaxed/simple;
	bh=qmfm4nTYXj4d67e/ZFdu+FoHVdOEgEHWQ62Qb0rfoMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChF4Xhu4N/JYQNgg67whErJs7em670aSBbHpeji0LVvMDNinVq42laZ/G7D01o8VzdJaOD2pUXhE+iQSoQt7jehhWtRH/P9RUz57YHf9MxVt8UM2K5+bWzYCZ0RMzDYCj2Pxk3e+bkpwyh7/W27ee57bCVt8HJM/3elaEzZz88g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llymclVl; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-429c4c65485so408753f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 18:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762397615; x=1763002415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bcQMsNO0O8rvC7OlsNCiFi+ASZdXsyJZBbfNsI/gMNY=;
        b=llymclVl7fm/bsXzFmbKyOsGMBeHkOZJpK10Os23fNjfC7kLtvFM9tWARrgkeKb3GG
         4yu581xERMKR8xG61CvdBkK4jam/0CVFFrNXi/lkk0HSG+ttOugnDFEPTm/quU2T2RS5
         CAqpIAjTYFNSXeEmQi4i4Nh5y436lKmNPelwCvW5iPh8q7h4eQWPFJKl0Xozzyx6K6ts
         9f8CNiot6umhp2+q8g9HASs0wlH0AFdZKYQUbSuJnt63t2e15ruhFwvOPRtlWrO3HnJL
         ExL3xT3ovg/jH+poCfgbaLAewhpktYOMPwv1fKBcetcXDPQQeXlgI1dwUrQrJmd6KWrv
         qdDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762397615; x=1763002415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bcQMsNO0O8rvC7OlsNCiFi+ASZdXsyJZBbfNsI/gMNY=;
        b=dca/Qh6AF8YR08TeOeb2NHu0+W4HaYum+sc+HvuOx1ZB+i8D6ckUcwoyykFoKkt47D
         yCmCMe7X+NbHxk8OJ/HYL9js49dN550Y9aBYZIJfgW/DP+9roXhDXL12o5bIGkQinMoq
         gpfsZtPVMhj37n/wY/85KhObW5Qe5TAiUN9GaTYTWyNAhIoHYudKglWvNBuBYenU6Mxo
         uV7I9UUzSpOeI1J+OmYr+4KhQOtXN3twp6P+PRzvbAHIdHWyqfXmRUsIc4/uCuPbMNfS
         +Fsg5+fWxTC7p2+PAL+4wdMUu4xiOxgOYDNzV+CGE09kruHPMBGieHJcWVKB+7Zb/njg
         wV6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVHkWAGPzRRK0lmsTVjSgDnwlKWdoeJNRh7c/FxboYamw3x0Ntao4z0sKu88GmP4NNsqBedR3uiEkHPxZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFArlIxNi1eopjMxn839qKL10Ln81luPjT8pCU1Wo7GdSmQkz0
	rwbg9jzzxqTN55C44rOr81z1JtzVhFskZKK1aM/IasXP50LecDA77eqYqqNOlNa53rtntWgDif0
	YkNm75D0/mQa+62Sm2wtikTVtxzEp7nQ=
X-Gm-Gg: ASbGncu5vdkkD2pSUnxiS8+oFCCoKSWmfvQnGxS338zb593C8IN12ghoGdWpD1VgPTl
	YvxBRdZzmB3THiRr7IbncY82DBU6LHqJzIaLpuPdcHdw9sPCdIcQv6ThojR75h3p7ieeds1i2F3
	aCBO8D32mDhJPJmw/l2DhL53/fL1w5Ht2lD8L3wHoLCqGeitshEQ4i+XCvs2KPGU8xNEmv1S2XE
	ZjcHbn1EirYYSdZouGyycDszaXjXyvzcF2GX5fNRsZqJWHUtjwNry+LtpiUFXyO+7vilqVL75L7
	qGQ31J7UzcEDLC5O4IhvYh9bIAv5
X-Google-Smtp-Source: AGHT+IFgHo9WZJKTS4D4CZPHMvUuqKgcTvl9SJ9/dfT8HptvgBagea4p9NuA+sU2B75qOpkO7ninSQ0FH88nOttOqyg=
X-Received: by 2002:a05:6000:2287:b0:429:d6dc:ae3e with SMTP id
 ffacd0b85a97d-429e3313344mr4775045f8f.49.1762397614770; Wed, 05 Nov 2025
 18:53:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251105142319.1139183-1-pmladek@suse.com> <20251105142319.1139183-4-pmladek@suse.com>
In-Reply-To: <20251105142319.1139183-4-pmladek@suse.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 5 Nov 2025 18:53:23 -0800
X-Gm-Features: AWmQ_bmqzU40z-SC7k7ETvJcX5sVEBdPvjsWiXW7M4e2QXc-RoIMyuEO7uyuVL0
Message-ID: <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>
Subject: Re: [PATCH 3/6] kallsyms/bpf: Set module buildid in bpf_address_lookup()
To: Petr Mladek <pmladek@suse.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, linux-modules@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 5, 2025 at 6:24=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Make bpf_address_lookup() compatible with module_address_lookup()
> and clear the pointer to @modbuildid together with @modname.
>
> It is not strictly needed because __sprint_symbol() reads @modbuildid
> only when @modname is set. But better be on the safe side and make
> the API more safe.
>
> Fixes: 9294523e3768 ("module: add printk formats to add module build ID t=
o stacktraces")
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  include/linux/filter.h | 15 +++++++++++----
>  kernel/kallsyms.c      |  4 ++--
>  2 files changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index f5c859b8131a..b7b95840250a 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long=
 addr);
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname,
> +                  const unsigned char **modbuildid, char *sym)
>  {
>         int ret =3D __bpf_address_lookup(addr, size, off, sym);
>
> -       if (ret && modname)
> -               *modname =3D NULL;
> +       if (ret) {
> +               if (modname)
> +                       *modname =3D NULL;
> +               if (modbuildid)
> +                       *modbuildid =3D NULL;
> +       }
> +
>         return ret;
>  }
>
> @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_find(u=
nsigned long addr)
>
>  static inline int
>  bpf_address_lookup(unsigned long addr, unsigned long *size,
> -                  unsigned long *off, char **modname, char *sym)
> +                  unsigned long *off, char **modname,
> +                  const unsigned char **modbuildid, char *sym)
>  {
>         return 0;
>  }
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 9455e3bb07fc..efb12b077220 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long addr=
,
>         ret =3D module_address_lookup(addr, symbolsize, offset,
>                                     modname, modbuildid, namebuf);
>         if (!ret)
> -               ret =3D bpf_address_lookup(addr, symbolsize,
> -                                        offset, modname, namebuf);
> +               ret =3D bpf_address_lookup(addr, symbolsize, offset,
> +                                        modname, modbuildid, namebuf);

The initial bpf_address_lookup() 8 years ago was trying
to copy paste args and style of kallsyms_lookup().
It was odd back then. This change is doubling down on the wrong thing.
It's really odd to pass a pointer into bpf_address_lookup()
so it zero initializes it.
bpf ksyms are in the core kernel. They're never in modules.
Just call __bpf_address_lookup() here and remove the wrapper.

