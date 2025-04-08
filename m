Return-Path: <linux-kernel+bounces-594343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AD7A81055
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 17:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18FF0462832
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 15:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A51F4199;
	Tue,  8 Apr 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARw/tYPZ"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A64A1D63C4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Apr 2025 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744126554; cv=none; b=XopA9m3z3PRlWhM2aAhukm5W3XbOLLXtjUsR0KHnLqE4GV/WItjwPYH+Y8F01/zD+TP11cmXEDHcAtKJhxZ2QwyZ8Hz8DTFeywcTYzwZGPlEirHwVRQH/o+Y+2WTOih3By1rhWCHzaAhridU1FfKq6FVUPYl5lR4lXChEvR2/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744126554; c=relaxed/simple;
	bh=S6DOC2X2/GtSJdHKZrfV8WYIYmEEczMsgL+5jkuX3do=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WLsCj5WK2zDKUBAXo/UuXqxvz0btyDxHWqUnfFwDTjCeqLJt6HEuSb1Zn+/TZ0VfQBNHxGnc0Uv4QRLeKzSeBFmbv4BJIHmQ0FXYcwV1rzhN8q96YQ+Buiu4nQ0JL1NU0vhsQtERfsb5bagQnNI2pcyucYMS0eeVBjyYWT+oFzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ARw/tYPZ; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-51eb1a714bfso5817071e0c.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Apr 2025 08:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744126552; x=1744731352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqY9nqo/bT1yXEsldnMuBK8EFrTJ4cUK70Tv0YCH5v4=;
        b=ARw/tYPZFwyQMm2/A4dagX/ODf0rTCUwRIauDnzuGe4nR74ZbUpdi5cFstnKYSVAWE
         9Gj+URjmyLUB3V6rBs/jqgN6S4RG8bE33UlrgAcfqlWKON8dw/uwVZ1KPHIHMX5Dr/JP
         6XcbboWuVii0qVBNQCSXM5Inv35xG3Gtwpg18DMVSk4G67wpEImTIj3WOoWmKAaGJrah
         CXc+HmXQhU+7JhnRqBCvNN6+np6DQa0F6wBz0R6P82YRI4a7MT1vGvfIt9i4hVoyEbA6
         7VrDt3htYOTS7jCre1/7MaKL3ddZzK03RKQIWt70njU0Y2S60yRTl/N1PviwyyPlngty
         19Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744126552; x=1744731352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqY9nqo/bT1yXEsldnMuBK8EFrTJ4cUK70Tv0YCH5v4=;
        b=taAy686W6QkmCLosi5U+xyCU4AQrulYinlaPvWiRrvjWay62rjKm7oVco6ClJjfeTw
         zOn3sryCb0D/pB72AlU8g7n9/F1y6Q+pmHtGoiOicbSxqL6DzoVUIIhj9s97QpUB1LMI
         eTYbIlqGJkKCpCL5bA7deEy7jBwHWN83bFo8GOras8e97HQDayEVoLfsBRruLLXJflzK
         b/XIWhpA2/J2nK3uc5jB4ShnU0IfuZ8dztSg2ksi3e2Iz8w736ENHGeyjMwE2hEfRNK2
         h5Q0TpYsWRLW5yYIL4UXZmkdqguKrhqxw7iLhz601ckLiDfJB7bd/bHQ/3Ipkm1LHMjn
         S1wg==
X-Forwarded-Encrypted: i=1; AJvYcCXlk6erJs5vxX2G7v5drpseJNZBTc02Bss+UAunodRAWp8/g9hi+AfEeF/IHhw1paqoeKGmzwxpcLoVLgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2GFOrcM/tZSLuHwg3h/WqE4bTEeYIRvDsO1djupXgn1gIDqik
	pKRsNDRGmvHF5T9wWgy2T1sLRMONPBYhk+rUcUal38j7RoTPcLfx8ggbup7XyDwGVVeqTr16TCC
	jtb8zwKXEdplMqHs81hCY0ygjX0s8j6xKgkDeAA==
X-Gm-Gg: ASbGncv5YBOtQ+j3ynKk5QtWoMSuUnuUk5sLaSPWJmX5UG+T8Qdn2MfowCweC8ZR+QG
	W0N946V9SprMz8yWrSPw+3WpuRpRFNM//aip2Caak+cwWqWCXDaS+mKvDIdblBx8u/J60QNWUFd
	0BfO8Hw1RsPPtaIeb2twklYUX4Vm7EaadxerJWH0/znYY/YEtOtnwbSJ/D
X-Google-Smtp-Source: AGHT+IFQzExTa65nA0/f4X0nyU/wBDWz+iIbK1IkF+A0MydItYVQcLhe+aX9axgA7v4CkLL4+J/Ad8oezLldyzb9hYg=
X-Received: by 2002:a05:6122:20ac:b0:525:9dd5:d55a with SMTP id
 71dfb90a1353d-527730a9b14mr8923640e0c.8.1744126551943; Tue, 08 Apr 2025
 08:35:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250408104851.256868745@linuxfoundation.org>
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 8 Apr 2025 21:05:39 +0530
X-Gm-Features: ATxdqUE5K9Dlr_XtGSCpzfXdBhhJtN7jxVeLpGfJQfW41WarrWU_eZhxEWZq6W4
Message-ID: <CA+G9fYuzqN6BjRx3XTAC87qviZWMLzOX70KfJvXEX772ZHDZzQ@mail.gmail.com>
Subject: Re: [PATCH 6.13 000/499] 6.13.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Apr 2025 at 17:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.13.11 release.
> There are 499 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Apr 2025 10:47:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.13.11-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions on arm multi_v5_defconfig and tinyconfig builds with clang-20
and gcc-13 on the stable-rc 6.13.

First seen on the 6.13.11-rc1
Bad: 6.13.11-rc1
Good: v6.13.10

* arm, build
 - build/gcc-13-tinyconfig
 - build/clang-20-tinyconfig
 - build/clang-20-multi_v5_defconfig

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: arm ld.lld vmlinux.lds section pattern is expected

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>


## Build log
with clang-20
ld.lld: error: ./arch/arm/kernel/vmlinux.lds:33: section pattern is expecte=
d
>>>  __vectors_lma =3D .; OVERLAY 0xffff0000 : AT(__vectors_lma) { .vectors=
 { OVERLAY_KEEP(*(.vectors)) } .vectors.bhb.loop8 { OVERLAY_KEEP(*(.vectors=
.bhb.loop8)) } .vectors.bhb.bpiall { OVERLAY_KEEP(*(.vectors.bhb.bpiall)) }=
 } __vectors_start =3D LOADADDR(.vectors); __vectors_end =3D LOADADDR(.vect=
ors) + SIZEOF(.vectors); __vectors_bhb_loop8_start =3D LOADADDR(.vectors.bh=
b.loop8); __vectors_bhb_loop8_end =3D LOADADDR(.vectors.bhb.loop8) + SIZEOF=
(.vectors.bhb.loop8); __vectors_bhb_bpiall_start =3D LOADADDR(.vectors.bhb.=
bpiall); __vectors_bhb_bpiall_end =3D LOADADDR(.vectors.bhb.bpiall) + SIZEO=
F(.vectors.bhb.bpiall); . =3D __vectors_lma + SIZEOF(.vectors) + SIZEOF(.ve=
ctors.bhb.loop8) + SIZEOF(.vectors.bhb.bpiall); __stubs_lma =3D .; .stubs A=
DDR(.vectors) + 0x1000 : AT(__stubs_lma) { *(.stubs) } __stubs_start =3D LO=
ADADDR(.stubs); __stubs_end =3D LOADADDR(.stubs) + SIZEOF(.stubs); . =3D __=
stubs_lma + SIZEOF(.stubs); PROVIDE(vector_fiq_offset =3D vector_fiq - ADDR=
(.vectors));
>>>                                                                        =
               ^
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:77: vmlinux] Error 1

and
With gcc-13
arm-linux-gnueabihf-ld:./arch/arm/kernel/vmlinux.lds:30: syntax error
make[3]: *** [/builds/linux/scripts/Makefile.vmlinux:77: vmlinux] Error 1

## Source
* Kernel version: 6.13.11-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-st=
able-rc.git
* Git sha: f1209ffbc87a3003d66f47bd6f986d1a0d154a2f
* Git describe: v6.13.10-500-gf1209ffbc87a
* Project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.10-500-gf1209ffbc87a/

## Build
* Build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.=
y/build/v6.13.10-500-gf1209ffbc87a/testrun/27947363/suite/build/test/clang-=
20-tinyconfig/log
* Build details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.10-500-gf1209ffbc87a/testrun/27947363/suite/build/test/clang-20-tinyconfig=
/details/
* Build history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.13.y/build/v6.13=
.10-500-gf1209ffbc87a/testrun/27947363/suite/build/test/clang-20-tinyconfig=
/history/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2vRlYe=
E7ChBo7YMjumm63mifyB9/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2vRlYeE7ChBo7YMjumm6=
3mifyB9/config

## Steps to reproduce
 - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
--kconfig tinyconfig

--
Linaro LKFT
https://lkft.linaro.org

