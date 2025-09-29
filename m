Return-Path: <linux-kernel+bounces-835926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F635BA85C0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 10:08:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EC5917DD87
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71A3260568;
	Mon, 29 Sep 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LHYIaSyf"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EF81EF36B
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759133315; cv=none; b=jYczbLlB5DltyQ33DY3QdKZm8aI3sbTG3+tG/7AZELtR+1ioHn6uuwb/Oqu6M7gVFcJnq2KBH2gCEdgqXybskNPFvq9SoYP4lg6n6Y4lBvaPLkgd23yYJijeemQxFdw4zR2PguN2r67B1pvkBRhQS8bQhLy9QR0tQuM0kk3h2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759133315; c=relaxed/simple;
	bh=0obBXfVQzTDi0JqwlzzvHtJw9SU1QUHp6uTOdmkKnAE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=tbV+fN2fvr1O8jaKJlPxN06cf0UEo5gfAePD7QeNDjnF1ND0sYFptESXemWeVwTLNNdh8yGZoelDmd+4O1tECBwBVSXkF8esiUYZ4tlN82jzINFGsDkwWEE7GmUfjuBlIbXCnrhUGkw0F1qQz4nYxxzdxbEutteJtZRRIAyWtrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LHYIaSyf; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-46b303f7469so28997335e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 01:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759133311; x=1759738111; darn=vger.kernel.org;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HAMfSDJSbJ4xjYZMH8vH7FynSdefu5J6b+jcnMr69Vg=;
        b=LHYIaSyfoCUd4bAK+JVq54njUjBRKm+m8ogSjNV70H1OzUawi1v0dE/cOOJC0EBTFh
         NC4SXc0+xhx6DCAg23gxIDjVSfpT7xJGLesDCCpw1HREEh7uCKX6c1t18acYqodcZdGF
         O7AraBnawCysywnGGM8Em6an/mqPe2kEKIBWUQVdkd0mNWIlH1sFxrv2Vt4gin8WBGRc
         uyKqBEhgTbO4II+5T0F9dJcU9+CMIKTk7KdSilC+bkN56iwdSAJOeqru4Va52twP+zhU
         DVU3KSHdXdRjLGpBNUwZy20x/HzcSi1lJrohXhAtyKlon7RyQNiyqIuKKULHJ/+3ZJPo
         bARQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759133311; x=1759738111;
        h=mime-version:date:user-agent:references:in-reply-to:subject:cc:to
         :from:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAMfSDJSbJ4xjYZMH8vH7FynSdefu5J6b+jcnMr69Vg=;
        b=f2eHTCuEJPEuKO9OGmLSnbmkaYSONNWsX/5mZhGYJc1qwHcYPogzYMpZZNoC7WBEaf
         adADfsY9V6+HzoRnLwNWsKsHEoFePSeW0kiPiqYhqWKMRb9NgQ/cuwEgD+1kBgcy+IRc
         YXb4xIw7iUqWdsoi8GG0k4IAqi4qFw6hoyfWaOzyjP/h42QNhMUMOziz8Rg+bx6S1Vbh
         sTWJG2b37iMpcRoIS5009pAq5PgBlczxiCBEAJXxUvN6Pi9BdSRNzK0Wq9IBV2UYk9Qu
         6CM46h6RtAUfNFplJT6aGUd5fUU3ksQ7TUVbo/dRSAsMM5uy7WIl8sdVsq1ckznDb5FE
         cTzQ==
X-Gm-Message-State: AOJu0Yw7AI3Ye7Y1xFrOj/I2Aoe32mE3fFP7o/DzY1s8R8Fvi8xCY74k
	kXCUMmrGLrAUDjRkX5UBnIktwIWciLExiZx0J43DTKyiwGO67Vg14zDg8XWhuGJD
X-Gm-Gg: ASbGncuR4Qjwj3y6TvpwrE+tyfoXe5kQlGchWPrffTSgKhpIWz/P8JD81kjmC7XnXeo
	Yc2q6cOTjhn5agTLRiz6u/MmpJ28X71zHg6gqjtepK6MBVd9CYl65MCFv+CFX1TCLSI2LLEiycC
	TAxNlbv35JiCFM4MrWXiIaDtu+ap9MqbWoo5P0G9z0i3ODj1tBVvpwGTjcPTx3sOrDhCEQ1wtOZ
	+PK5NN+9pyn3/y7nHd8u5oL1TzfdO50R/dyqQqO81Ax02WYHEA8sDiGnny47bEDgPwWmOxOwive
	opkWXkwvTOiccXywPiaRVvUyy2HWeeG0J1JA2gBxiXYs++1PaFJQ9PauNFJY1DpCjSMcAluKGXe
	7PMQ+8czrrq8t/fOMvMZ4slZcZPY0zBl+7P3OppeG4cPcAsR4vUgg51ZoM64=
X-Google-Smtp-Source: AGHT+IHV+5/OPoidJc+VFRpQ3RDVstQeCOgbJbduyd+YoxhpucCmsRW+mCqJOOcvZ2DftJsEqzKuyQ==
X-Received: by 2002:a05:600c:1c8e:b0:46e:1f86:aeba with SMTP id 5b1f17b1804b1-46e329f819dmr157710745e9.17.1759133311480;
        Mon, 29 Sep 2025 01:08:31 -0700 (PDT)
Received: from localhost ([37.72.3.43])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab31ea3sm213196785e9.12.2025.09.29.01.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 01:08:30 -0700 (PDT)
Message-ID: <68da3e7e.050a0220.8efdc.f1ab@mx.google.com>
X-Google-Original-Message-ID: <877bxhy936.fsf@>
From: =?utf-8?Q?Miquel_Sabat=C3=A9_Sol=C3=A0?= <mikisabate@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org,  maddy@linux.ibm.com,  mpe@ellerman.id.au,
  npiggin@gmail.com,  christophe.leroy@csgroup.eu
Subject: Re: [PATCH] powerpc: kgdb: Remove OUTBUFMAX constant
In-Reply-To: <20250915141808.146695-1-mikisabate@gmail.com> ("Miquel
 =?utf-8?Q?Sabat=C3=A9=09Sol=C3=A0=22's?= message of "Mon, 15 Sep 2025
 16:18:08 +0200")
References: <20250915141808.146695-1-mikisabate@gmail.com>
User-Agent: mu4e 1.12.13; emacs 30.2
Date: Mon, 29 Sep 2025 10:08:29 +0200
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

Miquel Sabat=C3=A9 Sol=C3=A0 @ 2025-09-15 16:18 +02:

> This constant was introduced in commit 17ce452f7ea3 ("kgdb, powerpc:
> arch specific powerpc kgdb support"), but it is no longer used anywhere
> in the source tree.
>
> Signed-off-by: Miquel Sabat=C3=A9 Sol=C3=A0 <mikisabate@gmail.com>
> ---
>  arch/powerpc/include/asm/kgdb.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kgdb.h b/arch/powerpc/include/asm/k=
gdb.h
> index 715c18b75334..4c0afde87e97 100644
> --- a/arch/powerpc/include/asm/kgdb.h
> +++ b/arch/powerpc/include/asm/kgdb.h
> @@ -25,7 +25,6 @@
>
>  #define BREAK_INSTR_SIZE	4
>  #define BUFMAX			((NUMREGBYTES * 2) + 512)
> -#define OUTBUFMAX		((NUMREGBYTES * 2) + 512)
>
>  #define BREAK_INSTR		0x7d821008	/* twge r2, r2 */

Gently ping :)

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJlBAEBCgBPFiEEG6U8esk9yirP39qXlr6Mb9idZWUFAmjaPn0bFIAAAAAABAAO
bWFudTIsMi41KzEuMTEsMiwyFRxtaWtpc2FiYXRlQGdtYWlsLmNvbQAKCRCWvoxv
2J1lZZWeEACfvXT5BDoAcVnNuPxZ36G0knwhRxUX3kxQSfzbX0bs1vH5FK4FCBGe
TIes6jqBY9w2jOXTZSZK+A4rnTy8kV7vYEKb4iYJOYVq0Rz1xwrI39A2JcX2s9w8
DZ8foErf6AiqUiXg7LgQaPH0KJTknqV+sQmAIhgx0QWEA2jcnLrwis0droGZlGFY
UWFIMXVcPalNz1gWe2Kpt98z459sYvPDDYqRd622yQkCmsm2skkfT2lWdliuZREz
NJF32bVhG9KiD1t/l6P7x1y6CrXYtZBzcm/D1lqmvSSWsY3X8ImA2CvsNPqc3jKX
cfQOcMfBtdXav18oxV29Pbin/LrIMWf5fPrBBn1t/v1LNVN/AwofYhVAVRCuHbpJ
WUOGXrvs/ovpROPyLtGzxCKuGbRTXIM/uZIbMYb4Xk+AT+U7zPdIUgOHnETRG09o
lRodAa541k+13M4CVzf9ymtGLAFDNpealz35oet8e50z9VbMZTk9vfqjUkTskP54
eqHf87a3i0s4Lra/mqLiTDCpR8rpV7SWvNpumPH1skaDmbtN4pg9yE5qSuOb0fS5
h58fngqridD2SQ5Kze1GN3IetgJyLPAkkUNdVVoSZr5x+s1/poYivgCxtWuAkilJ
ZbaNMXeRezTPNl4vKkoesdRHaSCmN9u754MccG+dOetvpA4lom1aRw==
=/0e1
-----END PGP SIGNATURE-----
--=-=-=--

