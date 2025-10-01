Return-Path: <linux-kernel+bounces-839409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A13CDBB1925
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CEE03C6BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 19:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F92D7DD7;
	Wed,  1 Oct 2025 19:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOsMzrdD"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5019523D7DB
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 19:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759346077; cv=none; b=hbADd8n/A+ilIYHFSCCZVB3F/oxEhI1yjKKUrOq/Zm/sfypL1+4zZYPIEHGZl9N2lq5FA+lj5FHdB1DPOU/ajAKBnWikkdLB7KZ4sDkk7uJmsgWrKpz5zH1iGHWv+9Yr1JoXMAZfu/Waruo4j24Ngj16hnc87NNtkLVga67DJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759346077; c=relaxed/simple;
	bh=vU2bRCzOPz9cqFE+fRPp0KSU/JqJXG1CNpMF2SQ0dXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R7dEf3ttgcmQYaXDJbdgy0ZAoxgri7rStLvDKMX06DDYcqUYggrefO87+A2nEJS4LhepraNVrms7S6cH8RChLFL2774spGa45ck4u5w96g2EkuSqpy1dYuxTr9sq/e5HRC8qSKMSvDjR5ZLbzHqtJyzuQnkJSq2c8b7AVLWwmm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wOsMzrdD; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so234536e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759346073; x=1759950873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpYWttYdrlKxMJNuC4/+/3P23bCufP7vQF7gyhcuZQE=;
        b=wOsMzrdD+S7fxIiMmQqhBtvdGNvn1N2/qXS7odyyMMbfGlZLJ1wQrhqKFVbNi60ivC
         x4HCHhlkxxr+M6iTn1TOlMClUAdhXH/xf/VoMRkP7AhxPPFBGFrUXsMUyXmnCcLomvs/
         71b644mm+Llh9frR60YplYtJxthbcdTeDMZhn+Fqy1rl39I6KtJSNhAh0v2Ls7ufJDsl
         NwNzLSPrIUWWakX/h43L/GDHv2Eyrl2FOh61jwwxyYPBv7zBBfGSXDceHsyrVFtprhzf
         mUxTEgYiZzGLclr7bNsTUNr9z1j0Jsw+Y+WRKtkvALs2JRFXo+Sh/1jTSbtO1HBP1NNC
         ytzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759346073; x=1759950873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpYWttYdrlKxMJNuC4/+/3P23bCufP7vQF7gyhcuZQE=;
        b=keOmUiJG+vIRboYxraHm9GnzWZybSGdjRKfu40addXsquSdC8jy0U1AW0B5Xf9Oi3k
         AqiU+8MpcQU+wesS0geEVqRn5BIdUIGQc7yYV5dqlIffBHbGY6Yqd2Yf+IwpgZaxnUM9
         5fBoDRqmtzjJ36wfYKLG33Eq53QZyA0L6iyLBqk0gGel5OaHegnL5wVeZY2TMDRBTTNv
         fCVPk8ZfB2Wko7Gb3f9qRqv1srnEH9a6U9JRYp7szysjpnwAKYyLepiyIlajcd0U6tQb
         fbX4XqZYQmcMqfpToxraUy937UOe9nPC3Xp0BUJGnEpgKlwcxpgS8Kix+M0zogNfxLGk
         2Hcw==
X-Forwarded-Encrypted: i=1; AJvYcCUzw+B2u8O63TC/HstV/F4ZOShioqlZnf/8VNzouIKzAtJUktpFckzTj+I1tW+jQkeXCtgKsQEC3Gu3SMQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk44i2oVQfeua0NgfI+rq7VxqduyQ7K57OJIFFjQJjO/U3Z5sG
	Xz3/LVD5ArtgkZLZD/brwEx1F1LYlzePmf03K8AsZut6Y7sdJVXgl0QCa4DaxMSJ1ePzCcbuxLj
	LMvu6Zv0hj7qKNqzxZCiY5EwuESWEtlBIjf2M3mU62w==
X-Gm-Gg: ASbGncuy0En6TmqK0Z9A9lEzr6lQgfsiAm6GFpMllvczCYX6EPyVFDze9eCYDIsPYV8
	Lh5yZN46I7kiWXNSO7Go0vLeEUs31Kqg2CW3UIDTqE0yvb+5JTvTalGlOEbhcNuFu1nZY/q6Z8B
	N4bKJ5mB2r7/GZLZHnnHgYKVepG0yfCOmeVzwVIHW5FKHp7cmb7F8WvmPxRf4TGjRtaNy6FYtJJ
	jqMbDVUqxNt7qFMT6GaI/3aD5PE+eM=
X-Google-Smtp-Source: AGHT+IGMkX2miJlksEsdM7PXcVzHNnO384Za6SpV35+lEVYqmGUHyp9bwhwrzCQ3loRfE0DrPQkJgxZVFLD3fAKGmIc=
X-Received: by 2002:a05:6512:3b8d:b0:57d:ffa4:56eb with SMTP id
 2adb3069b0e04-58af9f6ad77mr1525367e87.31.1759346073280; Wed, 01 Oct 2025
 12:14:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VI0P195MB2739D000BD1BF18B3B718F93ED1FA@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
 <CACRpkdZbwuf2Fgtq+jyqzqspb37-P6X4O9xqkG-mSb+afSjh3g@mail.gmail.com> <VI0P195MB273993B2928F985EAC763375EDE6A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
In-Reply-To: <VI0P195MB273993B2928F985EAC763375EDE6A@VI0P195MB2739.EURP195.PROD.OUTLOOK.COM>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 1 Oct 2025 21:14:22 +0200
X-Gm-Features: AS18NWBTQ0S6ldFMcXWF5q6y_CGyKZtR3CUF--U4-z61ZpL9iuM7LkWUlYqHj60
Message-ID: <CACRpkdYLbFTnDn-X=TRb-P_SmwZkxiEFk5PG_y-12_shQrpO6Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: Make sure CPU_ARM940T kernel can be built.
To: Franz-Josef Haider <fj.haider@outlook.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux@armlinux.org.uk, ardb@kernel.org, rmk+kernel@armlinux.org.uk, 
	ebiggers@kernel.org, nathan@kernel.org, rostedt@goodmis.org, kees@kernel.org, 
	dave@vasilevsky.ca, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:04=E2=80=AFPM Franz-Josef Haider <fj.haider@outloo=
k.com> wrote:

> Hello, I have done this change because when trying to "select CPU_ARM940T=
" from a Kconfig for a device with arm940t cpu, the build ends up failing w=
ith errors like
>             arch/arm/lib/ashldi3.S: Assembler messages:
>             arch/arm/lib/ashldi3.S:44: Error: cannot honor width suffix -=
- `rsb ip,r2,#32'
>             arch/arm/lib/ashldi3.S:45: Error: thumb conditional instructi=
on should be in IT block -- `movmi r1,r1,lsl r2'
>             arch/arm/lib/ashldi3.S:46: Error: thumb conditional instructi=
on should be in IT block -- `movpl r1,r0,lsl r3'
>             arch/arm/lib/ashldi3.S:48: Error: thumb conditional instructi=
on should be in IT block -- `lsrmi r3,r0,ip'
>             arch/arm/lib/ashldi3.S:49: Error: thumb conditional instructi=
on should be in IT block -- `orrmi r1,r1,r3'
>             arch/arm/lib/ashldi3.S:50: Error: cannot honor width suffix -=
- `mov r0,r0,lsl r2'
>             arch/arm/lib/ashldi3.S:43: Error: immediate value out of rang=
e
>             make[3]: *** [scripts/Makefile.build:430: arch/arm/lib/ashldi=
3.o] Error 1
>             make[2]: *** [scripts/Makefile.build:556: arch/arm/lib] Error=
 2
>             make[2]: *** Waiting for unfinished jobs....
> With the change I am able to build a kernel which runs on a device with a=
rm940t cpu (with the patch "ARM: Add missing mmu flags entry to arm940 proc=
 info." which I've submitted as well. And with the necessary mach files etc=
).
>
> I can elaborate on this in the commit message and also adjust the conditi=
on to include the other CPU types you mentioned.

Yes please, thanks a lot Franz-Josef!

Also add:
Cc: stable@vger.kernel.org

in the bottom of the patch so this goes into stable.

Then eventually submit the patch to Russell's patch tracker when
we have reviewed it.

We (ARM SoC maintainers) are interested on what kind of system this is.
We really need to know if there are actively maintained ARM940t boards,
and with you posting this it seems the answer is yes, so please tell us
a bit about this device and what you're using it for.

Yours,
Linus Walleij

