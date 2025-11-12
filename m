Return-Path: <linux-kernel+bounces-897951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CD68AC53FA0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 928C54FAD77
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 18:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF133546E6;
	Wed, 12 Nov 2025 18:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot7iuL0r"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86023337113
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762972503; cv=none; b=SZbXbKJhVvc9YgeM0+aBnO+oGfL7HcFVDk3Eg+wzK2VbYS/Zdc3s2w+GGS78POmv7o1qAXstdw7yPfMTz3rn5vB5z1xPGc5qfAkIEM+N6oeK9j9gqzi/B6Vmv6jtRsBoA3LrPF6kWLCZxVTL97avE8iGCLB2I53g/sCf6xlkG2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762972503; c=relaxed/simple;
	bh=CiCb/WxR5IiY4zTCVf9V+wc+I2yi8BeC/aaOHbPg3pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mgsYU7uV9gVwqJ33DzOD0z4p5hFyUlrw4wJ+brb82QLCcL0tK5PRzlBbFjY6zZ9upQZ2FJY6F1KdYyWD/O3VrZ86YDXVomg7vfu8dsYUs4iDhd1dk2aOgQ87DnrIy/sX6gk6kH6F19Fc75t02Tlm4kM74qLZPVI663jo5TFQj3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot7iuL0r; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso11035111fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762972499; x=1763577299; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jjohzFTrNt1dds0Ak9mhbsBPxnWVffo9MAGuUzPAPSI=;
        b=Ot7iuL0rV+cT6a5+BClr1i1wVP1eWjkgNfoJJe7z12v/HaqO2yXAB2+W2tHYoHqfKw
         z0LhZV1Ja//0VTJcOS6ibwT1Kbz6piy/uDIXW7GaLg2uNvKJFSL4ABT4lQlhkJX352pO
         P3jK49WaCLIlRTGEkqFxgyp4Ty0gGgAafofXtRA52nwiBJfjjfeRLn1ly2YPsIodg12d
         M5cG+dbWEl/YCGdaiOuif+5tAii/PndS1G20TBIyao+gJHjUJgbeWUSatZAqjZsLYAWs
         WklmqbYR4nP5TW7fw6IRNABPHrkULSw/rOWoVagqn2n/6f8Q4t3qhMjPbx1CSr4GLMzW
         hHQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762972499; x=1763577299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jjohzFTrNt1dds0Ak9mhbsBPxnWVffo9MAGuUzPAPSI=;
        b=EUNwd8i8xrHOl/MTzl9zXnYwIH4nBEGzxy6Qa0Nrh0e+8MLVi3KFk5iTKm9QeoFkht
         FizFR5a82c8PcDG7l46Hg3oXPNj9My3Q/ydUprSG7mEHFjWr5xv9XM3ZzAnCSoD8GiGA
         xA6W5EPT3GeHr5u+aFLD/v7sP1O5iSyF+3feM59sHQARDkWOU6shwvrhzYBUD8bow/Cj
         TaBAJN9VO5FwaWOlZ22H+ZTIWLu9lUJP35zwRkSkZy25cWxcGleO1lVMO2yhTmDnxePd
         tRYxKwzrnowekbCqt/cLUQAUDc0hVu3pL7KBHTgbAzxIke6k26E5BCybgkdN4/mS6Lkt
         wlVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+ZWGfpWj6nPwfLx/BWlXuI338TRlAsu/VlMtmf1iPD1RQIVAhL0FercMOIC2NQgVX51iKAyGEMwrKjlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgU4cTQY2Kh8wxjFaM66uqqxsD59anzM4DHLaszpdkvOSv60j
	Z/X2TkiqYcZ4CNgc2VRHM+CatQ4ubqwDpGRgAmiPYehNkoB9pEIr5+yyG6Behz8Zb7mjwOjysDW
	T9URZ0Kh5DTHsmcLyX+Ze0OFtGDw9vFk=
X-Gm-Gg: ASbGncvYy7BSRJcNoh9JgHVcM8M39lm91PUAXywvwsGoN22YtijA7lhhQMkETJqfWkE
	I3XQv+RAJRdQwJQZ+Pe0a4ZXpYQv2M4vHW2n2XBa299x8NAm8GdTFgM5zUUivaylH+LHsUy3dmB
	qktpBgji6nwf6Et/Z/UUsKVLGkvFEtY6QwWTSs4csOVir/BxN1+9jCYJL8xeNlGsQ7YnbOwVtht
	jMHSRsa8ossJ+0rp853oKSsGQvPhRnRnbMil0sWy4YoIg0p1ETK6SGPNB1u
X-Google-Smtp-Source: AGHT+IEa3xVTKMLat1Wb0V6k6SNt6JXXRV4if7NrYfYOs9e0hkHkyyXtZb+lc0TmiRtVlY0vx8iH0c8Q2gESBvg9vVA=
X-Received: by 2002:a2e:98d2:0:b0:37a:9558:5bf8 with SMTP id
 38308e7fff4ca-37b8c3dca00mr9373041fa.32.1762972499219; Wed, 12 Nov 2025
 10:34:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111012348.571643096@linuxfoundation.org>
In-Reply-To: <20251111012348.571643096@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Thu, 13 Nov 2025 00:04:47 +0530
X-Gm-Features: AWmQ_bkg2w5p36Lweybo9KaHemnwRDH-EtITn2wPi38Rv8gnjjgkxCZ4pHNcSPE
Message-ID: <CAC-m1rqHCCMwVu4WVVV4w0SXuZNuv+e+Q1qZUzVrxH+=EeGJNw@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/562] 6.12.58-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HIII greg,

On Tue, Nov 11, 2025 at 7:07=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.58 release.
> There are 562 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 13 Nov 2025 01:22:51 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.58-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Build and Boot Report for 6.12.58-rc2

The kernel version 6.12.58-rc2 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.12.58-rc2
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit :

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

