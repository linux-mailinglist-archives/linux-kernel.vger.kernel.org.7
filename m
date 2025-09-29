Return-Path: <linux-kernel+bounces-835925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDC5BA85BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7368317DBBD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C331EF36B;
	Mon, 29 Sep 2025 08:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVwppZA1"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12070625
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759133298; cv=none; b=Lro/W72OKa9RIJbkM5ghnCVb9VHiDQTZPKwWQFhIX7OUF9I4ybqiebafqUyn+6iCfYiHYFspjBLvikucJJ6z7IUl4tZx9Nlnkn2QEbShmNRyLDosOeYzI67h7K8whLjcFZZw7xa5Ubuq5ICuFHMBSuP3WgEtAI73QsRs+dJfjvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759133298; c=relaxed/simple;
	bh=Mg+OCZ9Ag5YfR2bHVjHUmTzPxjRJPNTx0QR4IPupU80=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=jAQu8zO+5A5IWtEXNLU6lwoagBrWNW9WvAW0vbWOh2p4XaSVQIxPNcScT4Udm5bcEYWr4xpDjICpNM+acYgk83wKAfPXP1NZFFA6PswDCFwctHHcaczbgTBeeAYXr2kz+2zH/fEHbXBzGfmGUt4cU8zEv+mk/xalaB4Ea/vN9tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVwppZA1; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e4ad36541so15118855e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759133294; x=1759738094; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GVUj56PTBElUdL5rbfLGdPrTXQDNa/dgDh2G4V1z2Tg=;
        b=SVwppZA1gV3xIdXMVBMxSR8kUP2HHQEteyFmRb+f73TgQisLNNvFicaGYCmCyfymwx
         HrODmILRphWGR3jULMe5DTkACurjOBPe8NbPKu0xnj217Dq/xkmikTxoNjfW/bQa/Q/0
         e2UJGbXzQx8LHKvbNeoVAqyKZC6CMPRwW3R1SGcHoFbEgE0LbyIc6X6JRubJ/j4lQTsV
         dpGNI/e2h7ZqT2YNHZClVGDaREMu1W3B44JsOu6w61dkkqA1e0/HiCAc+lImJ+B5PHuK
         8fZ1cKxahA38LIGVgIP5U0gKwm8JXbiT2BxETavSONFRMox/gHZ3Etjayu3m/5zFPzfX
         2c9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759133294; x=1759738094;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVUj56PTBElUdL5rbfLGdPrTXQDNa/dgDh2G4V1z2Tg=;
        b=LKm5MPpyjmWCMsTwkxFWNnBaJdOZNzJdhhpiIGJHmOui3J9WXczvGenIWYa0Hbm3UP
         YUixFs93dCkraB6tXJTdzLe8/Bk1Kdf0KK4KsiZSdwnvnzF4lwVT8y55hy8nxAqd58yb
         FTh8rMx48j57XJMjatH2ytZffRnOLXvTc1Zk/GADVSJIsr3KslyElQ9HcWmQX+VgySwo
         hjl0KsBuFKEp4Ib/Ud5pXJE1VRhtrrDV1I2hAq4nsHjlsitV70QET5w14XCOyqtdes8I
         Mav12uCjQuDJb7cdA6Oon+MqubbmNP8HTrFCg14qJE8YIdTtZrnJMdZY8sRoFl2OsktO
         A0Hw==
X-Gm-Message-State: AOJu0YwRxXaDxUn8jTZg2cH/0TpMB4ad9ne5yqLzHrmjcQCB5AwjYeB5
	y2OgoFpQEaYm8xepGVSrpx80TM2gaRN15tF1EeX2JIhugv1GxTLbjFIuYNdjEO3eBf8=
X-Gm-Gg: ASbGncvl6NzjGKpwx7wil6s4CApkN3exxjnEN0DfyhwSpbuN/bRtBCwmJdLyhO0+5Sq
	Dzm2aoA0det4+hv8WK5h5nSnDVqmc8PdgNOCweahjU8lOOtAbcyayXAsb1gAHbwOEe5vEGA/U8R
	nbV1/x24sPwmvN5n+9sHFLmn1Z4hntq1PlU82GpyPNeg69pv+w2X21u0khVsFPNVr0yruVVq0/4
	FUzYM8GX2YQPGd/am752TfoVgSAwHis9H0WmmnRrNCa0D62GFDhJLQpKH9+M+yAXqXgsbZxfmi1
	iAn70drFjA1AGcl8BixSMmBjc2TesoKZjiSiw8EXIIPaL7USdOA5zThNvepVkKU6TpoKlNJvlNz
	WPedFAr08DbcYT713kF7lXNvtBU4sCDKj2/pkHh2vDs/iitRfPBFhjkYgJiY=
X-Google-Smtp-Source: AGHT+IHI1PVHeNoXUhxNikFYnbqcWzMihaSMSG/MVn+wa3bjmjBsAoX15cYb0vlQ+YWd9XGgUfPh/g==
X-Received: by 2002:a05:600c:1394:b0:46e:1f92:49aa with SMTP id 5b1f17b1804b1-46e329c6355mr146802235e9.15.1759133294014;
        Mon, 29 Sep 2025 01:08:14 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab31f62sm215500625e9.15.2025.09.29.01.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:08:13 -0700 (PDT)
Message-ID: <68da3e6d.050a0220.c13dc.0f9a@mx.google.com>
X-Google-Original-Message-ID: <87cy79y93o.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,  pjw@kernel.org,  palmer@dabbelt.com,
  alex@ghiti.fr,  wangyuli@uniontech.com
Subject: Re: [PATCH] riscv: kgdb: Ensure that BUFMAX > NUMREGBYTES
In-Reply-To: <20250915143252.154955-1-mikisabate@gmail.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Mon, 15 Sep 2025
 16:32:52 +0200")
References: <20250915143252.154955-1-mikisabate@gmail.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Mon, 29 Sep 2025 10:08:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Miquel Sabat=C3=A9 Sol=C3=A0 @ 2025-09-15 16:32 +02:

> The current value of BUFMAX is similar as in other architectures, but as
> per documentation on KGDB (see
> 'Documentation/process/debugging/kgdb.rst'), BUFMAX has to be larger
> than NUMREGBYTES.
>
> Some NUMREGBYTES architectures (e.g. powerpc or hexagon) actually define
> BUFMAX in relation to NUMREGBYTES, and thus this condition is always
> guaranteed. Since 2048 is a value that is generally accepted on all
> architectures, and that is larger than the current value of NUMREGBYTES,
> we can keep this value in arch/riscv, but we can at least add an
> 'static_assert' as an extra measure just in case NUMREGBYTES changes in
> the future for some unforseen reason.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
>  arch/riscv/include/asm/kgdb.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kgdb.h b/arch/riscv/include/asm/kgdb.h
> index cc11c4544cff..66ff46e434fa 100644
> --- a/arch/riscv/include/asm/kgdb.h
> +++ b/arch/riscv/include/asm/kgdb.h
> @@ -3,14 +3,18 @@
>  #ifndef __ASM_KGDB_H_
>  #define __ASM_KGDB_H_
>
> +#include <linux/build_bug.h>
> +
>  #ifdef __KERNEL__
>
>  #define GDB_SIZEOF_REG sizeof(unsigned long)
>
> -#define DBG_MAX_REG_NUM (36)
> -#define NUMREGBYTES ((DBG_MAX_REG_NUM) * GDB_SIZEOF_REG)
> +#define DBG_MAX_REG_NUM 36
> +#define NUMREGBYTES (DBG_MAX_REG_NUM * GDB_SIZEOF_REG)
>  #define CACHE_FLUSH_IS_SAFE     1
>  #define BUFMAX                  2048
> +static_assert(BUFMAX > NUMREGBYTES,
> +	      "As per KGDB documentation, BUFMAX must be larger than NUMREGBYTE=
S");
>  #ifdef CONFIG_RISCV_ISA_C
>  #define BREAK_INSTR_SIZE	2
>  #else
> @@ -97,6 +101,7 @@ extern unsigned long kgdb_compiled_break;
>  #define DBG_REG_STATUS_OFF 33
>  #define DBG_REG_BADADDR_OFF 34
>  #define DBG_REG_CAUSE_OFF 35
> +/* NOTE: increase DBG_MAX_REG_NUM if you add more values here. */
>
>  extern const char riscv_gdb_stub_feature[64];

Gentle ping :)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJlBAEBCgBPFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjaPmsbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyFRxtaWtpc2FiYXRlQGdtYWlsLmNvbQAKCRCWvoxv
2J1lZa/kD/0SS0w13cbSDsDAHnIMSkwzhsxBOPIOH+FnsVfA5umjAhSchivjDOVh
l6tl7s9XJoUH91fNuySbMOxgZvPa/TBHqBdImhKOqS+x9HtIAk8F4KT+RuXN28VH
dOrOjXLin/qksjl0t7BEDvLZMrK9l8DkKN9RluE0902wvQOIt/2sEQsm1gF3tndD
W8j7enoHf0A3nDEk71RcgtG3TVc4I4ds+9t5bE5xcZAOsftaW724lCsQMuL7/VAE
pzPnmHC/t4ksx/Hp+7RSDu15l6HHeUXy3lsVFVD3VXkHcX0fjdvtk8WGGzj/s7nH
LbWAOrHYJWW4vmHemAGbMq59AJFN/sHd0K81hfifCkOvFWqM4yx5W7dxhmyShaHi
t2I1Wh4Tg5UNRbRA/gCunnXhUvBPSgcFNWij+eWZskGG3HsHTREvWeSXuOScY6uf
ayKt3cL5DqhB9uh+CFD9//uaTmleZfVPNC/19w02CUmgUCFbKMRr7FyNkvjmUy+D
jEWP89FctIhttKlfff6wwFlQm8AmagxkqHg9WhQu1PY3a/A8NPbUxhR0FDZMxbjp
l5Mfj/5huZ53FM9XjzRUtFnCcEO4jfvedJUX3/6LDm4Fsx25BduXjZtUOdv0XJ3E
1Y+ND6zCVD17mtrwict9mI3B8Hd+EE8QoW9v7TPq7k/j2RT1leltAA==
=GfxR
-----END PGP SIGNATURE-----
--=-=-=--

