Return-Path: <linux-kernel+bounces-818779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96EFB5965F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C6832165A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C58D30DEC5;
	Tue, 16 Sep 2025 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwtK7vZK"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1B73101A8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026380; cv=none; b=UalmxDU/M6ostrlqqWPY6NCAUuXMKWVzAlXjbOcVuYhnHaOxlgDC50an/w5ElH+1T2gxdvU357y63Ecr60zlG6qQbpRKqIzdliIReAVwGUpxz6HizcHesLDYjf6ssukEEYaw3vzIprIhTG8oNabimcFJ80O6+mz/nl/1nBL0Wcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026380; c=relaxed/simple;
	bh=/nr/RV4+6Ya3JsPeMQRmLlubUZrACV5W6+rHLSzZCV8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=tCGZqmVhA/7u5Iv1GaPPx0rHheTZ5FoF/U0GvRjIGuw0/diFEj47ZvKokqXMBQl+TkQWZQT6Bc23qrFR8rzk90KYayfsxeN7DmsDLBfRwsziaIW1mzPq7f+bjYmpVoHGDE1jw02+wCw7OdbM3APnowrT3yaiK5tS6wMe+PyDdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwtK7vZK; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45df0cde41bso39891925e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758026377; x=1758631177; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gt0ZwE2fkLuC8Rptt0cI2XAd8Dj/MEqvhQxNXmrCN3E=;
        b=HwtK7vZK5JQUIm+DmpT0jG1imbGumUNMGDdyr19qr2wmr0Tb4QoA6gpaT6exRpa9DB
         cbWkk0bMq+mmye7kSB5yzIjRyBY4zT+Dzh5kF/EOww6bzbplFvrQnDGUxfdzxFb1qB1u
         +SdgCF5oIshNHgYue2t8f3M6SAXqPvl63uo3ZG9n2Qhwpx5+9Z0WSXbOnvKlX98HGfUr
         JZs55yj7L8egsKiCa8o0en+QOSB0Ismu+al78yBjfA8Pr4gQtJNp8RSNEBwzzwHeso2q
         SvJbIaT+ZTMQakpotW+PeyOGR2+RTPcQc88pBekCBoAsOsi0Aog/VwUjD5KpGbNbp81P
         votQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758026377; x=1758631177;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gt0ZwE2fkLuC8Rptt0cI2XAd8Dj/MEqvhQxNXmrCN3E=;
        b=FXeOx7eOIjNmJxAr++XZJr9baPsZR7auC75/h1H0NLyw1bH7FA0C263c4Uabkrti1j
         c0gWNULRbJ7vM+Jlb2QKzRYEvEFssew5Ucr5sLxRhZi4CMr46K6KnBa+b8ccC5B0mI7f
         v46/TKyMUyGJhcaUykvU9RRS66liIlFfWveDdfoPl2+ojtwUdTkZfosDouYsstLW2AnG
         zje9g9QAURX6m7G5+vNesRvPLMTZPx/gWkWRgFopauWSjiwIS6ydqdVml0zvEH1TUJ+8
         9pZj1/bV/kpnefHaTGwrCH05j7+ncyB+xzQZvWBj4q6or4DfDc5uv/oKcMbIcD16Y6Gv
         GTgg==
X-Forwarded-Encrypted: i=1; AJvYcCXxpgFPOK0ANQmNK4yW93mQWk+80GArQqtj0FvSuPLbLsgwhwI13escF6H3DIccXmBKb6bPYdj3biPsFxY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrA53J6Z/4enk1MNU6PWGpbTJbBbsMgGYYVpLmQe/5vqxJwzzX
	HsmCawWPldUoeKuktpKROgcjcurHrkSPoBqfssU3jO23SAOM2WLc4USg
X-Gm-Gg: ASbGncvQDWLD0gub8QqaiqyiiOQvN7TNxK2CqdfMbJCvethfp75jZQQrobznpT/+I62
	gQrTFhwGEbgPKJDfJBnpKOqO/ktdDXADMN453h/b8OvgJ3kzp9A08vk8g1io5dCg4d54PdeZ8R9
	ASq2vpDI/pRm/prik6LGgb40e6FKpP4s/D8Kh4PwtetROwrT5CGjvcmU3zefAHLVOZy/FhtGKMu
	F+45T+26Hko1DjP39ZEl6bqVmM5kf3A7sIrq3MwGNSmFO5HYz/sz6Ksw41/7tLInt4J0Gaq8NC5
	/hAqxexR45SmKG2C5a2t80JfD9V9XK8Wu3xwmBiJtWrtrREKNElGISkFT7EDu/0Khl7fAL5jGpf
	Kc1Rl9u8l1ieGG3uMXV0meOqcf1I=
X-Google-Smtp-Source: AGHT+IEDyzCIO/ZrWzZXXRqUqdpxBC3NkftkP3PMQ8QxO7unshVAe8c94K1S3RCZ/wnrdlM3sihzmg==
X-Received: by 2002:a05:600c:a4b:b0:45c:b5eb:b0c6 with SMTP id 5b1f17b1804b1-45f211c856dmr165318615e9.5.1758026376551;
        Tue, 16 Sep 2025 05:39:36 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3e81dbf9acdsm14817927f8f.55.2025.09.16.05.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:39:35 -0700 (PDT)
Message-ID: <68c95a87.050a0220.362e95.5aa5@mx.google.com>
X-Google-Original-Message-ID: <877bxylgft.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: kernel test robot <lkp@intel.com>
Cc: linux-riscv@lists.infradead.org,  oe-kbuild-all@lists.linux.dev,
  linux-kernel@vger.kernel.org,  pjw@kernel.org,  palmer@dabbelt.com,
  alex@ghiti.fr,  wangyuli@uniontech.com,  chenhuacai@kernel.org
Subject: Re: [PATCH] riscv: kgdb: Prefer strscpy instead of strcpy
In-Reply-To: <202509161619.eJeLbfU0-lkp@intel.com> (kernel test robot's
	message of "Tue, 16 Sep 2025 17:10:50 +0800")
References: <20250915200644.200498-1-mikisabate@gmail.com>
	<202509161619.eJeLbfU0-lkp@intel.com>
User-Agent: mu4e 1.12.12; emacs 30.2
Date: Tue, 16 Sep 2025 14:39:34 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Hello,

kernel test robot @ 2025-09-16 17:10 +08:

> Hi Miquel,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v6.17-rc6 next-20250915]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Miquel-Sabat-Sol/riscv-kgdb-Prefer-strscpy-instead-of-strcpy/20250916-040750
> base:   linus/master
> patch link:    https://lore.kernel.org/r/20250915200644.200498-1-mikisabate%40gmail.com
> patch subject: [PATCH] riscv: kgdb: Prefer strscpy instead of strcpy
> config: riscv-randconfig-002-20250916 (https://download.01.org/0day-ci/archive/20250916/202509161619.eJeLbfU0-lkp@intel.com/config)
> compiler: riscv32-linux-gcc (GCC) 10.5.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161619.eJeLbfU0-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202509161619.eJeLbfU0-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    In file included from include/linux/ptrace.h:5,
>                     from arch/riscv/kernel/kgdb.c:6:
>    arch/riscv/kernel/kgdb.c: In function 'kgdb_arch_handle_qxfer_pkt':
>>> include/linux/compiler.h:197:67: error: static assertion failed: "must be array"
>      197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>          |                                                                   ^~~~~~~~~~~~~~
>    include/linux/compiler.h:202:28: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>      202 | #define __must_be_array(a) __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
>          |                            ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/string.h:80:40: note: in expansion of macro '__must_be_array'
>       80 |  sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) + \
>          |                                        ^~~~~~~~~~~~~~~
>    include/linux/args.h:25:24: note: in expansion of macro '__strscpy0'
>       25 | #define __CONCAT(a, b) a ## b
>          |                        ^
>    include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
>       26 | #define CONCATENATE(a, b) __CONCAT(a, b)
>          |                           ^~~~~~~~
>    include/linux/string.h:114:2: note: in expansion of macro 'CONCATENATE'
>      114 |  CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>          |  ^~~~~~~~~~~
>    arch/riscv/kernel/kgdb.c:268:3: note: in expansion of macro 'strscpy'
>      268 |   strscpy(remcom_out_buffer, riscv_gdb_stub_target_desc);
>          |   ^~~~~~~
>>> include/linux/compiler.h:197:67: error: static assertion failed: "must be array"
>      197 | #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
>          |                                                                   ^~~~~~~~~~~~~~
>    include/linux/compiler.h:202:28: note: in expansion of macro '__BUILD_BUG_ON_ZERO_MSG'
>      202 | #define __must_be_array(a) __BUILD_BUG_ON_ZERO_MSG(!__is_array(a), \
>          |                            ^~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/string.h:80:40: note: in expansion of macro '__must_be_array'
>       80 |  sized_strscpy(dst, src, sizeof(dst) + __must_be_array(dst) + \
>          |                                        ^~~~~~~~~~~~~~~
>    include/linux/args.h:25:24: note: in expansion of macro '__strscpy0'
>       25 | #define __CONCAT(a, b) a ## b
>          |                        ^
>    include/linux/args.h:26:27: note: in expansion of macro '__CONCAT'
>       26 | #define CONCATENATE(a, b) __CONCAT(a, b)
>          |                           ^~~~~~~~
>    include/linux/string.h:114:2: note: in expansion of macro 'CONCATENATE'
>      114 |  CONCATENATE(__strscpy, COUNT_ARGS(__VA_ARGS__))(dst, src, __VA_ARGS__)
>          |  ^~~~~~~~~~~
>    arch/riscv/kernel/kgdb.c:271:3: note: in expansion of macro 'strscpy'
>      271 |   strscpy(remcom_out_buffer, riscv_gdb_stub_cpuxml);
>          |   ^~~~~~~
>
>
> vim +197 include/linux/compiler.h
>
> 230fa253df6352 Christian Borntraeger 2014-11-25  193
> cb7380de9e4cbc Kees Cook             2025-02-05  194  #ifdef __CHECKER__
> 243c90e917f5cf Vincent Mailhol       2025-03-29  195  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) (0)
> cb7380de9e4cbc Kees Cook             2025-02-05  196  #else /* __CHECKER__ */
> 243c90e917f5cf Vincent Mailhol       2025-03-29 @197  #define __BUILD_BUG_ON_ZERO_MSG(e, msg, ...) ((int)sizeof(struct {_Static_assert(!(e), msg);}))
> cb7380de9e4cbc Kees Cook             2025-02-05  198  #endif /* __CHECKER__ */
> cb7380de9e4cbc Kees Cook             2025-02-05  199

I was testing on the RISC-V tree, but I should've definitely tested this
on 'next' instead to catch this compiler error.

Since this is not too important, feel free to drop this patch.

Sorry for the noise,
Miquel

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJlBAEBCgBPFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjJWoYbFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyFRxtaWtpc2FiYXRlQGdtYWlsLmNvbQAKCRCWvoxv
2J1lZeTYD/9XO7FVYKCzIaCQhLxyHR3kNYkwsvWUl/OCr1dbInnW87CuFXOKZGY1
Skj7F1e8SQXoDWit5UvL7+C8MSH9KOxAmA4H5GFtQ2N/Y4cQlTgi5IjrxeWG42iy
NTG5FMkVxgVNh1QUJzwiz1RcC9HwVzsKPy0IcyaEoMcJ15bIjItWi4Q7ntyU+U+L
4yY+GWc5E/8li+RPDGW32eVvfejgwhJfdhrimINRHxfqcJdwVbmsj1hDgqecQP7+
w5xzHvcj8m/WP/tlJhGw0ed8NE3SQyIrTj23dr4aOD7XI2pOTyDHp2zRJgIDu5mA
zNzZ3PbesW7PwRKWmjCDnrYVgZolnZnjMvYTnfxfLQMLNaa7bCYPmf4j2BYrO2sV
XpYvqDM6vkL6fyrfnIpSnfeu603H90/jJPGRFgLUIpSJYumzu40XRlNVyvDGolSq
btqPneJ7XFKqHFDd3TsUqk//XQseTxGUFWh+ol27SYaGLxP/Y2iAMM5AaFCry7Rs
nVLtOAjPKfu0Nwopjn7FmLcwGG3QDEym4Pr9pxVSdThPLVxPlbGWZNk6reyiL8o5
JcgyiMFHI/u1PCgEsqJbur1uSzoQOEj4nYPBuVAZq0hYG92B7wpUUcFuxKlAtGmD
X3ys2ZjYEENYy/rcU/mU+6XeUjhVDCZ0Fkrn+NUBzuiMnmcwzvthwQ==
=KjrK
-----END PGP SIGNATURE-----
--=-=-=--

