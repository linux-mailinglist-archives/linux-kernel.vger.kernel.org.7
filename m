Return-Path: <linux-kernel+bounces-829113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B971B96513
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EA9A4A7DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E303246778;
	Tue, 23 Sep 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+7Dwcij"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ED2231856
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637945; cv=none; b=S8lG/HClPRGzGgp4px7I/hDXnqIF0NB0kh+47i6sgFPW3/MYANYrrlTz6nhhZMHL3/4KJmoSDUQvRp1TAW9nW5N7teFPhNqrWZ+Tue42bFufX4I6HNzfg/Q+RZ2IJXY2pKCldFwtN+SpuPvkP3XKi2DuIkbO372T37nAsw/pE94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637945; c=relaxed/simple;
	bh=SyF2JYjmgNSd1raMXbXoz7cNPV1N8IiH9rEfanxfDAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N6VWvtxQUDBWhQoHTAPnwQZGeFj6wOSOYU3wyOa750Glpr7msSS7cJOldKe7+3SYIekn4JlPYIKgdsOpVLKxLc7522eqv2ZcOJBROYBdvCipRNwHy3yUjuz/BE4Nm2/VBeEd8GBXuX3JJEKlD5rIiB3BOpC9PunkHHtTYB+ImsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+7Dwcij; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D5EC113D0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637944;
	bh=SyF2JYjmgNSd1raMXbXoz7cNPV1N8IiH9rEfanxfDAk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H+7DwcijAcU0RCz4y0A3Rwsi4riw0jYG3FB+zPbiY+9HPPSawYn5BajbHqSIYqmHS
	 QZK4Z1GrzYLhPG4RMe4g7q/uIcyy0vsl15TFM187icZCFd+u2ZlEwTqoMheYPl1XU9
	 DLCZ5MdorU+yO9JNs7xqoHn6RGUqM0ZSMBPSe7WQWwDUpbJGOSrbgZO5pAT3Gj+hlN
	 i48BXuMAj8hXudLzA5Lm9LRKUWXd/i1EePdRuIUZblfUxak20t3vTL9fcivBtTR0NH
	 Clwgwn6gPKlTO9x27GYHx/TYY3oyFdIQhHaofY94L35rT+rg0JlS0Xv8j70Z8nhIS2
	 WlZOTQwOgGdtw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b0b6bf0097aso1026264866b.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:32:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXgpgelBJsrUU6x5tlVYjPHo53+eqQ0Orp+lcwBCfCuhS/tnm2NjzEfRQjUey9b/+Cjyt6E3pAksenif/4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+m9yloqDwNGRNAtx4MnQsJ/4SGaM70T90vUFQHDnBi813vOQ7
	H90vo8WYDtaEvFpPjDTSf0cikXRmSomKYVxIy2PiLy5zufHkS0kc58fP3zr5ggRTLTwz/DkdulG
	FUg1q2numLPOvYucHjkQpUfmDjKrzyV4=
X-Google-Smtp-Source: AGHT+IGIkFwYjOX3usyebxtGb1H50QClcMAW03NWwNMggd+PADyfcgxohGn87l5jtQfOMRTJbk9MQ7GEJkgAdYLLOQE=
X-Received: by 2002:a17:907:787:b0:b04:6546:347e with SMTP id
 a640c23a62f3a-b302b50c092mr266770566b.51.1758637943170; Tue, 23 Sep 2025
 07:32:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923061722.24457-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250923061722.24457-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 23 Sep 2025 22:32:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4e0xeHoEJ4Vzs8pQT+sbjaAL8N=Vc=TrU8fd3iU=97nQ@mail.gmail.com>
X-Gm-Features: AS18NWAjA60oBdRDZ55y-2Nhs7beo3GYqq44uA2jysjtFj67BTWZM1yP8m2PJwo
Message-ID: <CAAhV-H4e0xeHoEJ4Vzs8pQT+sbjaAL8N=Vc=TrU8fd3iU=97nQ@mail.gmail.com>
Subject: Re: [PATCH v1] LoongArch: Add -fno-isolate-erroneous-paths-dereference
 in Makefile
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: WANG Rui <wangrui@loongson.cn>, loongarch@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Tue, Sep 23, 2025 at 2:17=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Currently, when compiling with GCC, there is no "break 0x7" instruction
> for zero division due to using the option -mno-check-zero-division, but
> the compiler still generates "break 0x0" instruction for zero division.
>
> Here is a simple example:
>
>   $ cat test.c
>   int div(int a)
>   {
>           return a / 0;
>   }
>   $ gcc -O2 -S test.c -o test.s
>
> GCC generates "break 0" On LoongArch and "ud2" on x86, objtool decodes
> "ud2" as INSN_BUG for x86, so decode "break 0" as INSN_BUG can fix the
> objtool warnings for LoongArch, but this is not the intention.
>
> When decoding "break 0" as INSN_TRAP in the previous commit, the aim is
> to handle "break 0" as a trap. The generated "break 0" for zero division
> by GCC is not proper, it should generate a break instruction with proper
> bug type, so add the GCC option -fno-isolate-erroneous-paths-dereference
> to avoid generating the unexpected "break 0" instruction for now.
You said that this patch make performance increase a little. But this
is strange, because -isolate-erroneous-paths-dereference rather than
-no-isolate-erroneous-paths-dereference is considered as an
optimization.

Huacai

>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/r/202509200413.7uihAxJ5-lkp@intel.com/
> Fixes: baad7830ee9a ("objtool/LoongArch: Mark types based on break immedi=
ate code")
> Suggested-by: WANG Rui <wangrui@loongson.cn>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index ae419e32f22e..f2a585b4a937 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -129,7 +129,7 @@ KBUILD_RUSTFLAGS_KERNEL             +=3D -Crelocation=
-model=3Dpie
>  LDFLAGS_vmlinux                        +=3D -static -pie --no-dynamic-li=
nker -z notext $(call ld-option, --apply-dynamic-relocs)
>  endif
>
> -cflags-y +=3D $(call cc-option, -mno-check-zero-division)
> +cflags-y +=3D $(call cc-option, -mno-check-zero-division -fno-isolate-er=
roneous-paths-dereference)
>
>  ifndef CONFIG_KASAN
>  cflags-y +=3D -fno-builtin-memcpy -fno-builtin-memmove -fno-builtin-mems=
et
> --
> 2.42.0
>

