Return-Path: <linux-kernel+bounces-806544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50EDDB4983D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA422075AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF0D31B100;
	Mon,  8 Sep 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ThMjfN9z"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E305312826
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355910; cv=none; b=MuAv4BtNPo2njcVJmeSQrJeeqm1wD4h45gHfpgQRuTZZPEeBjv6vTJzQzcxcgFhdrBAxrTGUoo7Cr7waCXB6l3HYtehrxdlYkgb5UIfDB7lqJ7rxnRYPyVEffd8Pl5DYQftAC92STE1uxP+aUi5GhdNDk2nj1PhmBTZmOf6NVm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355910; c=relaxed/simple;
	bh=GU4hHeFvwVnk7kq2RXY5Xg8cjjx6Qu6aF+dHzVCs+uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cwd5qMwh+T54OyKn0NkI09ROLuO9R0PLdmW8RNIm5RvL6G3GgSK17es0mDqxv3VEnlrOI65SYu4/+T2JklP4GlwNzvJXRUy4QBoXbQP8dlQT7Mw2gEGKBx6NTgBmHCyTTRPpyeTsCpT3Ehu3VMsMDQwQY/1ACGvMJ5RdYDy/B9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ThMjfN9z; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-32d3e17d927so2547953a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757355909; x=1757960709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9IWBcug01b4npQiJZok8CrAZHtpv3BYuhLyiOQ73LoE=;
        b=ThMjfN9zoX0Vkn7kU3tVUh50MMpJUJjxEiERgd0or9MYJZ5AM9qmgeQ/agKT1rFS7I
         jXMzoyq1mUBr7J5nb9DpDYfl+vQ0YeN5bR5hzpk0pS1cY3DTfio9hhP+TkpHPa4eVy2o
         /8UJ4uCP84BoM/ZGAcRfuB1rUuwNU+DQXefr4V13Clk4hKkRZHFymJL+hvlUkXVatgIn
         zZDWQbbhcGeyJSiwIBuva1+Pqp9YtvnotGVIV2boMfhh8MfopszIRGuVh6DriIKZSSeT
         7ssqltF1AIG0dOzYYY2KYCT3Pf6dUFJUAQnQK3/bHZBckQ7ybADgl2vrCcCKVJusxTva
         Vc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355909; x=1757960709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9IWBcug01b4npQiJZok8CrAZHtpv3BYuhLyiOQ73LoE=;
        b=GW8MGTtkaICeK1T32RnmG5zHAvCD8ii+ANi+MoTk94ySseHnifgEQwgDn4daGvFlBT
         R8z1/mz0S2LU3j2zR6v2comuUR6U2yjSyRT7CCx/tGerKacLh/m1DmFRZhxzFGtl6Ia2
         Zo6qiT7dSck4PEP4sHwGTMexaK0Ba0weM8oWzM/bKjFFfbizLISR3NYXB2y+SVBoXXtE
         CX9wfRWE3wyT23lekGSJF8R0/Dq1X7liaWDMt18Yz68vsykkjr+PGI43OP/znKB3Na3o
         XvUtNXRY5rT6zZXKfPRHTozKMccKxH1RacMW1VCMan4D0hv6EPIkseUlQIu/KQ+kly/t
         OiVg==
X-Forwarded-Encrypted: i=1; AJvYcCXUA/voG3EL6DiEFMtBvcic41i4hnCUaseolGetPMKYk/p97Joayi2tc/EqJvrgKBGuuKSmGC98UgT3EGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ZGqTJ57pLgi1EVEl2mgKOTFZFUVMG+uPpL3H23UEhpDMTwwV
	dCu/4kS8m6hhmamm4F+gjaribNsWqxEsIdhM5l9CToafVCn4f/gfkVR4m5+CvNN0nHWx7mz776r
	6jQ+23ZgO2J8vxMByz2P4zSYn1KKuOE/yHUb/fM5B8w==
X-Gm-Gg: ASbGncsm5X73yeI44iGBIJihlBMNHc5T+6XZybVVoi0X11oZxs7dPB4qu3R7JkI7RUP
	AGOXXWqVURzIqBSqx8IEzDzMQzPNSfKvYkOehfyQOBBymB0YChx58159H8ll/MJReRbzdbHxrsA
	8Yf1oCU1ToI4jS1jd1FlGcZb41D/EZEC+xmEpeswQbBizy1QVNn2zNUZb5ODwRydnpqNrBZWEUQ
	h+sHkb+GrMFqJR4rw6WR+SZT/T0TxmSw94I65f7pb6kkKR+YpOIHnqknh6IQbF0/lcbK60sB5cq
	sP5+88xzRAYjHQ56eA==
X-Google-Smtp-Source: AGHT+IHj9/tnJHkNQasTrRWqFjaqKqLyMbw17kMKkgYlBrWWXZgHdvHNrG+sKdBSH0wLKK9FFJY53g7/1x/HEEkUnRM=
X-Received: by 2002:a17:90b:3806:b0:327:dc81:b39e with SMTP id
 98e67ed59e1d1-32d43f1891amr10097489a91.13.1757355908088; Mon, 08 Sep 2025
 11:25:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250907195603.394640159@linuxfoundation.org>
In-Reply-To: <20250907195603.394640159@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 8 Sep 2025 23:54:56 +0530
X-Gm-Features: AS18NWD9pYZXIPgJSNXVjAumK8DAoDrS_GW9AD1G0s-Kl9qADSuGItB5Vl0yLJY
Message-ID: <CA+G9fYvQw_pdKz73GRytQas+ysZzRRu7u3dRHMcOhutvcE4rHA@mail.gmail.com>
Subject: Re: [PATCH 5.15 00/64] 5.15.192-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 8 Sept 2025 at 01:43, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 5.15.192 release.
> There are 64 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-=
5.15.192-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-5.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While building Linux stable-rc 5.15.192-rc1 the arm64 allyesconfig
builds failed.

* arm64, build
  - gcc-12-allyesconfig

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: stable-rc 5.15.192-rc1 arm64 allyesconfig
qede_main.c:199:35: error: initialization of void from incompatible
pointer

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

### build log
drivers/net/ethernet/qlogic/qede/qede_main.c:199:35: error:
initialization of 'void (*)(void *, u16,  u16)' {aka 'void (*)(void *,
short unsigned int,  short unsigned int)'} from incompatible pointer
type 'void (*)(void *, void *, u8)' {aka 'void (*)(void *, void *,
unsigned char)'} [-Werror=3Dincompatible-pointer-types]
  199 |                 .arfs_filter_op =3D qede_arfs_filter_op,
      |                                   ^~~~~~~~~~~~~~~~~~~

This was reported on the Linux next-20250428 tag,
https://lore.kernel.org/all/CA+G9fYs+7-Jut2PM1Z8fXOkBaBuGt0WwTUvU=3D4cu2O8i=
QdwUYw@mail.gmail.com/

## Build
* kernel: 5.15.192-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-=
rc.git
* git commit: ccdfe77d4229628515f4f822400fe6414b9861f8
* git describe: v5.15.190-99-gccdfe77d4229
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-5.15.y/build/v5.15=
.190-99-gccdfe77d4229

## Test Regressions (compared to v5.15.190-34-g29918c0c5b35)
* arm64, build
  - gcc-12-allyesconfig

Build log: https://qa-reports.linaro.org/api/testruns/29791503/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-5.=
15.y/v5.15.190-99-gccdfe77d4229/log-parser-build-gcc/gcc-compiler-drivers_n=
et_ethernet_qlogic_qede_qede_main_c-error-initialization-of-void-void-u-u-f=
rom-incompatible-pointer-type-void-void-void-u/
Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/32O3I8js=
bRRLOu0azhrfBwOPAjC/
Build config: https://storage.tuxsuite.com/public/linaro/lkft/builds/32O3I8=
jsbRRLOu0azhrfBwOPAjC/config

--
Linaro LKFT
https://lkft.linaro.org

