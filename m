Return-Path: <linux-kernel+bounces-747338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E8EB132B7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 03:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1181745C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 01:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105312E1CD;
	Mon, 28 Jul 2025 01:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fqic5nl5"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56902184E
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 01:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753664723; cv=none; b=gCow/Yzdjebq23yT1H58ryy3qGpM4L0k8eUBjic/xvgmbZrVfOiKI/60pE2oNifO3B+PRQNDm/QxoikC9rKI8Py7h8xKPncsN/U6RHvuCRrBVbuHxDQasxVOwuEdkn2+r7l48p+qMZnSFvZXnGhshYOHXMFlPHBH74rGrYqIM/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753664723; c=relaxed/simple;
	bh=49bTQJhbu7XxTS20QcKrCCoQXPAXu6H88A0u1bB2hDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZhCJA64LMhbRrc6zq0UtKX9XSqpLRTrC1dVv8F77ZeZjIIeUn2PSN4gEKZ49UzRC2GjDDco2mvKt1sCC12TE6Irq/orDhOzUU1Hl3PY4MNW/Vc8Ot61yf3vs578qx7uUoeEUUJX5dgSh7D3/lctS5eAF41/QxPSPnBjKQNTgO4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fqic5nl5; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b7889ea74cso45063f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 18:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753664718; x=1754269518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0yAlgRTz5Zd4GgIGI64fD+hC9AH6yPyVqGHu8QQlgU=;
        b=Fqic5nl5G9QdvGpZCg2lHJBmbi5SfdyMskoRYcuLEKAPfSJhpW0MFU4RVDek59mC4T
         tpRIwKvNc7lFebBbw6Hi9e1Upd7SgMSLt9sAqMwqUfwRKmJOsprf+ZLkC+soNy4XmD5t
         AGNj1PEmkelZ66wtbo21bcwP1r82Ju3XUdBPoREre7SO1wPncVz8aneTrL6Y/jyGM1jr
         7XH2yKVBW4ai8e3rlsmhyQMCn2ETBiFCMbiETAUWs5zCjNVB+xAZIcJAXMReOjy/hP4B
         MnyxPt3Wn6///RPpOzMrZ4OxxnTY6qg2xUIe/46yx9QiGr4hCcLa2DXrnjUeBkOiOlTk
         FkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753664718; x=1754269518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0yAlgRTz5Zd4GgIGI64fD+hC9AH6yPyVqGHu8QQlgU=;
        b=Y5vM4JuQy6lkNCz08NzZtekxkoEXaLIu6wQKaYwOqNVazFgginYQn8QD26ja1EqIm8
         zD+O7KbYBhDo0sMXVuJsanDh/NdwS058xgvgxap/bGWkYD/9UM8j9bFYmKB7TSDLDYYo
         Kk1yWk+hXKgLtM0B1UsKrssXycn9WPdBeH6k5P1diUCRi+ORAWimF9K7UhgdEzjEeXZA
         px3+KV+7b8GOvwRK3MN2rw6JHXNP9vVOhCSCK8VipuB8XjIvYk5TuWKIJSyZPIF3ZAOX
         nL3h+1qqkwtYgZDPRBX+KG0FtO1MJOaFX1DErwD/8gAtlQEygDjmNh2sB+uHSgcV9rCw
         36Kg==
X-Forwarded-Encrypted: i=1; AJvYcCUSlY2c02SKkO/n37qX1hw8PSyUzeVblgzsSlczuU2abMY9f8LmnklUsUR46yMQx3p07d+UM95CI8bU8bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKD7MOao8YjaH3c0h/W78UpLPXf9VkTDbBbHJoEPJpxqquQd2g
	Vowiy9cQZkQN2xqxaz0gXt2z0taROTZlziPs8WxRrJKrgTzbWCrFPh7E6rl+Lv2wj5EwI6G56e8
	B8opzch8wlcmuyKabIw7PNROf2dL2tMc=
X-Gm-Gg: ASbGnctz9meF1cHdyEx7FOdJDNTneozRJi4OtsURbAUKvrSKq3k2k8RrwYPohKaIYsa
	GnJuVZXj+X1o/ED0J2WiZBg+xGhfjTRdKPda64q0H7VKMK3imM6BXm5+U/FShJ07JDA5eg93hL4
	GgTdmM2zyvWayfo6di6QWzJ7LqbK+ddSHtKyDdQ1MKY2Y11l3fHF9GFSK8Fg0oxevhoTy6A90Pu
	iVFzJzE
X-Google-Smtp-Source: AGHT+IHHPvKIQsAP7dKGmzcWQefQFtVx4hPoMsQ+HsUVNN2PtYMWl1O2eUcAaOYoGpDyCWUsu1OYi155hpT0nzDF2WE=
X-Received: by 2002:a5d:5f92:0:b0:3a5:3369:391c with SMTP id
 ffacd0b85a97d-3b7766d2d43mr2200021f8f.1.1753664718266; Sun, 27 Jul 2025
 18:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250725054922.3972265-1-chao@kernel.org>
In-Reply-To: <20250725054922.3972265-1-chao@kernel.org>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Mon, 28 Jul 2025 09:05:07 +0800
X-Gm-Features: Ac12FXwqkE8fSsJO0UoEegMdGTPOgVJV_tO03QHQWvLDuYYVwkDYM45AqoWUDuQ
Message-ID: <CAHJ8P3LBH7oxV8nOiwU3yfQSr+LmK58EvFtyF8YLPQ=usZpqFA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] mkfs.f2fs: support -C [no]hashonly to
 control linear lookup fallback
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chao

Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
=E4=BA=8E2025=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E4=BA=94 13:51=E5=86=
=99=E9=81=93=EF=BC=9A
>
> It provides a way to disable linear lookup fallback during mkfs.
>
> Behavior summary:
>                         Android         Distro
> By default              disabled        enabled
>
> Android case:
>
> 1.1) Disable linear lookup:
> - mkfs.f2fs -f -g android -O casefold -C utf8:hashonly /dev/vdb
> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       2 : 2]
>
> 1.2) Enable linear lookup:
> - mkfs.f2fs -f -g android -O casefold -C utf8:nohashonly /dev/vdb
> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       0 : 0]
>
> 1.3) By default:
> - mkfs.f2fs -f -g android -O casefold -C utf8 /dev/vdb
> Info: set default linear_lookup option: disable
> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       2 : 2]
>
> Distro case:
>
> 2.1) Disable linear lookup:
> - mkfs.f2fs -f -O casefold -C utf8:hashonly /dev/vdb
> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       2 : 2]
>
> 2.2) Enable linear lookup:
> - mkfs.f2fs -f -O casefold -C utf8:nohashonly /dev/vdb
> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       0 : 0]
>
> 2.3) By default:
> - mkfs.f2fs -f -O casefold -C utf8 /dev/vdb
> - dump.f2fs -d3 /dev/vdb |grep s_encoding_flags
> s_encoding_flags                        [0x       0 : 0]
>
It is very clear and easy to understand.
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - honor [no]hashonly flag for Android case
> - update testcase and output
>  include/f2fs_fs.h       |  3 ++-
>  lib/libf2fs.c           |  6 ++++++
>  man/mkfs.f2fs.8         |  9 ++++++++-
>  mkfs/f2fs_format.c      | 11 +++++++++++
>  mkfs/f2fs_format_main.c |  3 ++-
>  5 files changed, 29 insertions(+), 3 deletions(-)
>
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index f7268d1..a8da8fa 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -1478,7 +1478,8 @@ enum {
>
>  /* feature list in Android */
>  enum {
> -       F2FS_FEATURE_NAT_BITS =3D 0x0001,
> +       F2FS_FEATURE_NAT_BITS           =3D 0x0001,
> +       F2FS_FEATURE_LINEAR_LOOKUP      =3D 0x0002,
>  };
>
>  /* nolinear lookup tune */
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index 2f012c8..1a496b7 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -1424,6 +1424,7 @@ static const struct enc_flags {
>         char *param;
>  } encoding_flags[] =3D {
>         { F2FS_ENC_STRICT_MODE_FL, "strict" },
> +       { F2FS_ENC_NO_COMPAT_FALLBACK_FL, "hashonly"}
>  };
>
>  /* Return a positive number < 0xff indicating the encoding magic number
> @@ -1485,6 +1486,11 @@ int f2fs_str2encoding_flags(char **param, __u16 *f=
lags)
>                                         *flags |=3D fl->flag;
>                                 }
>
> +                               if (fl->flag =3D=3D F2FS_ENC_NO_COMPAT_FA=
LLBACK_FL)
> +                                       c.nolinear_lookup =3D neg ?
> +                                               LINEAR_LOOKUP_ENABLE :
> +                                               LINEAR_LOOKUP_DISABLE;
> +
>                                 goto next_flag;
>                         }
>                 }
> diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
> index 8b3b0cc..fcb227c 100644
> --- a/man/mkfs.f2fs.8
> +++ b/man/mkfs.f2fs.8
> @@ -232,10 +232,17 @@ Use UTF-8 for casefolding.
>  .I flags:
>  .RS 1.2i
>  .TP 1.2i
> -.B strict
> +.B [no]strict
>  This flag specifies that invalid strings should be rejected by the files=
ystem.
>  Default is disabled.
>  .RE
> +.RS 1.2i
> +.TP 1.2i
> +.B [no]hashonly
> +This flag specifies that linear lookup fallback is off during lookup, to=
 turn
> +off linear lookup fallback, use nohashonly flag.
here should "to turn off linear lookup fallback, use hashonly flag"?
or "to turn on linear lookup fallback, use nohashonly flag"
1.1) Disable linear lookup:
- mkfs.f2fs -f -g android -O casefold -C utf8:hashonly /dev/vdb

> +For android case, it will disable linear lookup by default.
> +.RE
>  .RE
>  .TP
>  .BI \-q
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 2680bd3..04dfc20 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -671,6 +671,17 @@ static int f2fs_prepare_super_block(void)
>         memcpy(sb->init_version, c.version, VERSION_LEN);
>
>         if (c.feature & F2FS_FEATURE_CASEFOLD) {
> +               /*
> +                * if [no]hashonly option is not assigned, let's disable
> +                * linear lookup fallback by default for Android case.
> +                */
> +               if ((c.nolinear_lookup =3D=3D LINEAR_LOOKUP_DEFAULT) &&
> +                       (c.disabled_feature & F2FS_FEATURE_LINEAR_LOOKUP)=
) {
> +                       c.s_encoding_flags |=3D F2FS_ENC_NO_COMPAT_FALLBA=
CK_FL;
> +                       MSG(0, "Info: set default linear_lookup option: %=
s\n",
> +                               c.s_encoding_flags & F2FS_ENC_NO_COMPAT_F=
ALLBACK_FL ?
> +                               "disable" : "enable");
> +               }
>                 set_sb(s_encoding, c.s_encoding);
>                 set_sb(s_encoding_flags, c.s_encoding_flags);
>         }
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index f0bec4f..8f8e975 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -143,7 +143,8 @@ static void add_default_options(void)
>                 force_overwrite =3D 1;
>                 c.wanted_sector_size =3D F2FS_BLKSIZE;
>                 c.root_uid =3D c.root_gid =3D 0;
> -               c.disabled_feature |=3D F2FS_FEATURE_NAT_BITS;
> +               c.disabled_feature |=3D F2FS_FEATURE_NAT_BITS |
> +                                       F2FS_FEATURE_LINEAR_LOOKUP;
>
>                 /* RO doesn't need any other features */
>                 if (c.feature & F2FS_FEATURE_RO)
others look OK to me,so
Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> --
> 2.49.0
>
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

