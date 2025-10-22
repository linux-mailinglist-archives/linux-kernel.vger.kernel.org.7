Return-Path: <linux-kernel+bounces-865708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB012BFDCE9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32B818C7299
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8508E341660;
	Wed, 22 Oct 2025 18:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRFV/t5X"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4633FE30
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157406; cv=none; b=Z2vp3UMkPJrdUcHlYZXPo8nA4daW1QaU2NzRbvGpAU9G//RjoeF5bL1I9u96LHkExuKI6s/Sx7yHAZtWTLWlEvvVqSg4kBQb7+lFhVp7i3dXA9bg4yua2N6zWtmlecZ9I7PqW7tPBGAS4OexCBJWnAgu07vM5UZ7kJ/Ek7XZELI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157406; c=relaxed/simple;
	bh=D/N87KwxV+Z68IbXXzogjntbGGIivtw3E0aCgzNmrh4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kB6eveDYEWzkevIVlUXPFRB+E+kJR2CukV2bbvmDEW4jvp40RkuiqXDFTN1ce1Pn7VDgo3Yvt96U2QwxbH0l4WhP/FqhZ/XHCiKm/gc9VjrJa692jfatCy5LxkKpq0PsAMKiJB9NDfrlfQLx0Xn3DA2z9kU2WO+vra0UMr/L1E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRFV/t5X; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso6751588e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 11:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761157403; x=1761762203; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z3Ba3B15sVVtpDRMi97H+sxsvfjd9I6QEv7fyC8Xwxw=;
        b=WRFV/t5XY1cbsYpMW7W5bl1wTvVexIXwgITTuAL23odOJ9t8jW+l6J6O+fVlIy63lw
         YuKTfrW9+Xd/cDq27tPXsaWF4X8X/U+BHXcIz4cMUj1+OCNIKv3oFLEwS74Ndf22L1Un
         ce2K/Vr7epFPF5oMKdLKEmHqgrlqrtgCeEma2GW602W6QWi1VFkl+ZlJuHv8o6SD8viN
         kakbiOzj0IsnlrHAPfyQVQLTDvEkV0hhSnfRRXOeVmEAuHFa1n0wMG+lzxt/+s6XRL70
         EPHuEUaLkEfb/2DbBTjn9C2nQ3kljyMmAEvSXj/IoCZ87KvuG2rd/DbwjgdYzMjyJTkY
         Kvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761157403; x=1761762203;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3Ba3B15sVVtpDRMi97H+sxsvfjd9I6QEv7fyC8Xwxw=;
        b=sVk+2yQ8ljUBB2UfoPUKRuWBKAcE6o1ypdhnA+DIfm+K8BgnQYIF64HE0kq2xI+RmM
         BipZWg4mRP7BcD0uf2CGGHweCTFesyeO28QvTwxCu6r04enbaBlpGW4YyYZuX1//cjDH
         MD37LltRZ9lB6TVjLLBloAHEfYC1V6SIaWr6tqPN9CkBXJ4uCAYQcWebJ2Q4Mvj/a57N
         8rAaehXiMYdKSgt31B1xkWm8/Y2hCCAqwzStjbNUPrDPnXLA/x7gy1IfUZaHfIK95Q/W
         Y348MJ8BjkqGw2943hQDzhOC3JWMEaTDMMYz1WOxSOELy4dTa5sSt93G04HLO6ZdyYPO
         dJxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpID86usR6pg9pgV/mF5u7tcbFLSfHv/xKGZpPQgU8duiaPZkP63l+29bfUkkyWSJicD16EdflVbNrP3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqEFcphoCPSs4YHBWFoLoT5SU1I448dJ6NaA6PNyBL+sAGtlA
	vGRAa9UJQZ/HPzKoPqWdsTfMfESQ7OUgrjmWIEQp0RNAoLEXaDnyOD8haanGMB33lc+6RJR5Ke8
	scDaOfN4v3rP1glhvvJPzr/CenK16/rc=
X-Gm-Gg: ASbGncurGOAXZRANc7futC4ujxa0aVZyXgeD+BE/k/hA5jH204sXPwmMB0n1rzX7hke
	pXvGnmNHHKYVXltb/9wbEM21/9GBNl5MhW/30v2sDqZ9CHOIO99kx3Tfmj3A1T2Vea3DHHBDCkV
	eBocY6lem14iTqXqUhb2gDq9yRLA4HixO9tvjNBEhW5ayKjVvYlzkhb//Ci6zo8SZ8I9AHb8Xs4
	bmtwsg99A/uxA+Rx15jHmO3uVKYINCpBX4pHLZbb86QqaLK+ZPnrJ/nmW5J0h+Xoq2QJ017Yuds
	MT5Dd+8nGG59wRQuNA==
X-Google-Smtp-Source: AGHT+IFe5sIAVTfqOs2vfE2J8nxHXTDuWTZ/Gh2yprS/NSIsXhVORISS9EYSyEXk1cLCfTI14WyTvgWzGLNy9u/kyuE=
X-Received: by 2002:a05:6512:3ca9:b0:578:75b3:4326 with SMTP id
 2adb3069b0e04-591d85898camr6876561e87.29.1761157402448; Wed, 22 Oct 2025
 11:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022053328.623411246@linuxfoundation.org>
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Wed, 22 Oct 2025 23:53:09 +0530
X-Gm-Features: AWmQ_bkB1VnCzq_z3-s9Pg8J_-xBFqTPE9lCpcHmgjOViDGV_maAREzZjQVmEWU
Message-ID: <CAC-m1roB4_c_ThPxiEi9yzvFE2qZxuY_s2fQkUKqYvF72o+ODw@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hii Greg,

On Wed, Oct 22, 2025 at 11:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.5-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.17.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------

Build and boot tested 6.17.5-rc2 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.17.5-rc2
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: 3cc198d00990d2fccf1413a30fa9ecfa9a02d35d

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

