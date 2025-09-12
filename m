Return-Path: <linux-kernel+bounces-813700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CBEB549A3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7F3AA6EF8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52A72E2DDD;
	Fri, 12 Sep 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="b2A/X3Je"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27B02E175F
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672621; cv=none; b=LGmUbFIPrppAwMMXPOrJv204heeDDuPYjJ4duGmgSznEyG5Fcr0czwjqC3qUjroMyYuzlo/iSsIihIlXzeDg0i+foNZcVtHfvnhqENKDu4BPcan7B9cjFEIjr5kYm31QYc4szuNfRqIP+ectZA9SykNINlARFRPOWh7+7eczWGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672621; c=relaxed/simple;
	bh=L8+Vfsd5NRO7vLKj/WDn0QKcl6cnx+8yrLmAU9BNATI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQPSJPFrgOsEp1aPqofiWlZ0CVyak2aKCDf5gBxpzr7bXB1X8vmN2re1Q99ziFERT4QAtsTKfUuAviT2WceeRCKRmfgjwBH/FQr/POP23uTLFbeygsrvNzZ1+gdS9dXnmaRDYF6oUy05iMINLC85E+fuCct3+f4jWJpjvJoT3TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=b2A/X3Je; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so1254665a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757672619; x=1758277419; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yxaMEqYA6uym+Ir6zcrN22UPH27k/nnjzDJpTYQxN6I=;
        b=b2A/X3JeeiNdU9a6TFOgWkW505F23XXTIo+yGa7or+lZ+5rLICZQmIcLDUU6s4PpsB
         ZA0+I+hhYXVeu5HLA5TYdRc2pAGq/Zdr4xdTuDjwSlF9JhxkUP8aS8hURAxNLHXFuXzn
         jfYhj73nTGIuE6Nen2evckS1aWix1ux42nPwjTPbDr4mPF3wBkEuQ7Yc4CwujcVE7wsR
         4e+zbIP7szNCUEJRZ7qfiXcS26scl5KusgHRWhb0pwfjhJPyI2zl30OaYAsmVYbyd8g7
         wruupgH3GsUzMId5XJS6PklTlJVydzUIXU8iIur36eOp9HuHrzJ9BsYiHX/gT0KiKKRN
         Gwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757672619; x=1758277419;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yxaMEqYA6uym+Ir6zcrN22UPH27k/nnjzDJpTYQxN6I=;
        b=UMTZtgQpVSd3PocmpBc7+++VsaBYKZgEzrOgJdScDtA9qU4sQrP/1Ad5yJgt6v0zmh
         ini7e1bP+gOiDI0rPjeWXZMk9i0Blnw+GId1N3VfYNOmuoN3g0lmsiEfIlME5G1fdr+J
         bc7AjTegX45JswzA6/pJISrWWztiGoATqSKashIiQvE4XykOpDjh4wIBm6L88stYIiDL
         a2u1yK4q+ZPay7sbE0rOjSjVcV7jk35L/QuGVgUtz2FVYph2dPDuGvsDbP7dXJQOjDUV
         GMKsI611Hr0wxb+4PQf4An4+hkqiYVlfgMfmrhmSW3U690/lEHT3bEGDuCtKLACLuuNy
         uRtA==
X-Gm-Message-State: AOJu0YxLUxOrG6UR9KR08hYfYAMdTwhgulGLopJgt9Fb7GoULRtCkK0E
	D9mOUYraQDOvlGOdbmxBWGZCCJ3IPftDfaVuRYYmGNYJ1Y1aOs2r3dCxd2vAxmPI11hwGmLnkQt
	oSGMNnLZDbgyVdniDU15GcQZbDpGuUnVC0lQyCYQxeA==
X-Gm-Gg: ASbGnct8ARDM1ffF5pTHlgial/0KCPhYLXvEQ4IOsvXC7phR3XMTAiLziOnzDdv+xQG
	ll+YGAU6j5G3FDktI1ON9KM59O3g8xbtbxF4x49teU1lJSOrR8eTB35l6TMX6I9eaS3KHIDb6Ze
	uNNQ7hN6nizywfeamjkeEf97+KJmCIrBpL/lZ73JTEZcd28tZabhS9yqYhFo5Ln/y3Y5U7Rn0Q5
	CfuXNcQ1sEaQZe9KxgOwK+66Bf2Ht1ZkR8ONjAeb6un7nP4P35yJO9tnilj3Xwog42AVmH5tOfF
	ghMyZf4=
X-Google-Smtp-Source: AGHT+IFnlh7Lcvev/z+g8geBZVyzuCDqftK69x/3dM4A4/rPwhVxriJu5LaQAhPmA/dUWQDP37JDEPq7LkU6t/uT414=
X-Received: by 2002:a17:903:2407:b0:240:3c51:1063 with SMTP id
 d9443c01a7336-25d2576f18bmr30549565ad.23.1757672618671; Fri, 12 Sep 2025
 03:23:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYv77X+kKz2YT6xw7=9UrrotTbQ6fgNac7oohOg8BgGvtw@mail.gmail.com>
 <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de>
In-Reply-To: <1e331ebb-3315-4cbe-b194-ccbeeaded4da@t-8ch.de>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 12 Sep 2025 15:53:26 +0530
X-Gm-Features: AS18NWBiNtyoZJdw5AR77Ehen6tmbxWoHZEhVULSIr8zN1kPljDdD8rhs__pSZI
Message-ID: <CA+G9fYvrcRNBbg15UEcaZuYgs1pHU2i7h=zvJ2yHNo5i4fZ_nA@mail.gmail.com>
Subject: Re: next-20250909: selftests/arm64/gcs/basic-gcs.c:390:30: error: use
 of undeclared identifier 'HWCAP_GCS'
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Mark Brown <broonie@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>, Shuah Khan <shuah@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

On Fri, 12 Sept 2025 at 12:00, Thomas Wei=C3=9Fschuh <linux@weissschuh.net>=
 wrote:
>
> Hi Naresh,
>
> On 2025-09-12 00:48:47+0530, Naresh Kamboju wrote:
> > The following build warnings / errors noticed on arm64 defconfig
> > with clang-20 and gcc-13 toolchains on the Linux next-20250909
> > till next-20250911 tag while building selftests/arm64.
> >
> > Regression Analysis:
> > - New regression? Yes
> > - Reproducibility? yes
> >
> > First seen on  next-20250909
> >  Good: next-20250908
> >  Bad: next-20250909 till next-20250911
> >
> > Test regression: next-20250909:
> > selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
> > identifier 'HWCAP_GCS'
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Build log
> > selftests/arm64/gcs/basic-gcs.c:390:30: error: use of undeclared
> > identifier 'HWCAP_GCS'
> >   390 |         if (!(getauxval(AT_HWCAP) & HWCAP_GCS))
> >       |                                     ^
> > 1 error generated.
> >
> > The suspected commit pointing to,
> >   kselftest/arm64/gcs: Use nolibc's getauxval()
> >   a985fe638344492727528e52416211dda1c391d5
>
> That suspicion looks correct. I am wondering a bit how this works for
> the other selftests which use this symbol.
>
> Can you give this one a try:
>

I have applied this patch and tested and reported build regressions
got fixed.

Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>

> diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing=
/selftests/arm64/gcs/gcs-util.h
> index c99a6b39ac14..816b497634d6 100644
> --- a/tools/testing/selftests/arm64/gcs/gcs-util.h
> +++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
> @@ -26,6 +26,10 @@ struct user_gcs {
>  };
>  #endif
>
> +#ifndef HWCAP_GCS
> +#define HWCAP_GCS (1UL << 32)
> +#endif
> +
>  /* Shadow Stack/Guarded Control Stack interface */
>  #define PR_GET_SHADOW_STACK_STATUS     74
>  #define PR_SET_SHADOW_STACK_STATUS      75

--
Linaro LKFT

