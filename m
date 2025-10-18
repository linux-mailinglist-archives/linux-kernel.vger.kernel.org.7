Return-Path: <linux-kernel+bounces-859114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C752EBECCF8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 11:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF8A04E5B1C
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 09:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5614D24EA81;
	Sat, 18 Oct 2025 09:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPwNjKyl"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F17D944F
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 09:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760781380; cv=none; b=ZRqtC671zhPhCNcCEtKcNV6c6hE2/QDLtPGxfdjBhkj6go2QBKGAXUyjolnBwcebhQzj4+Gl72XGiPAweGEWRwczQ+NxCiJniBvNMBhnXUS8zPbRiX28EFpEd56ZU/dN9D0m8rP5pXdntP1ibmbt1qhX+WAirDgRIerfMG7ggxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760781380; c=relaxed/simple;
	bh=scF0EL4ZrQ8MG0dfR6wkjGh51GNi7IaZ4FTFjOLlLJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfImwSsVaknT0OT9pM61R+YTKDezkaX6Z0IP1l7IWZzp2iCgnY7BbRmxtZO/vctfPNHd6HYMYv2DXMhhB2BthPkcF4oefN0MeA0hlFntqY568wsh3ycb1L7Giw/5Z1GQwg34zBBUbYMMWqoSDKRgdac/JrFd6A8gYy87JETfbeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPwNjKyl; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36295d53a10so22757941fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760781377; x=1761386177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FG8h4x80hiheaVlFkmBnjfZS/77H5VFbiYTB4d4lcjA=;
        b=iPwNjKylLLTCAjv+dqXkOb5aTi93lSKMguT4wrFZIZxqe8q9dTOp9A/8ainmLtKNUI
         +jBZ/qU2sRMyUgeYRAI+r3cEQlpvk1wH1i1Gh+2fcHam/83KNXamKr/yQhvHFThvE4vZ
         iMr8nfPwIcS8+E7fU8nbI/J1SLn6sIZjRghigLwpZjVBAtUL/oV+cfjwwh3+R0Dwhhij
         MMa5ghdDsSMKr66U+IlzMIrgb2NkQv37WOarFqPmgo0OL/DIqcjgD5Zwq8b8WrJo2CQA
         YZjFOg6hEDi0ozi51zgLEms3/w+Q30dJMu+7Z8REn7WeuFyKBxRymxOF3IUydkamlhXp
         c5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760781377; x=1761386177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FG8h4x80hiheaVlFkmBnjfZS/77H5VFbiYTB4d4lcjA=;
        b=ARTJ0otBHnhM3UFAp2AWcD0sNnYaWAzvW9ODmyK4d6+sSw9KaSoQBMHEmPEpA2MsD0
         PxtR6L7iqOdxwKxtJZczCVU/HPog84Wyr93bVqCEX+r8ir1XZC7wDnYv5DX1L5VUBFdM
         EHFH9cf+RiniF29Xat0jKJ0qtEQIvG3KfYYlioXt+98ZRFemcN3CVOfoVaUO2Z8cdwpG
         FrInO/SBH7E+3yIs2Di1iaWTCrKtIZTMtWGo3ON7bPsYE/wq6olVQLEt0vf+k4YoD17Q
         0PWPRmkZa2c+Dt45xTR66j1K+dutt4Pw/sGUhFY4tN1rRnj8t+v2OI4ax6usUlYZmbei
         NegA==
X-Forwarded-Encrypted: i=1; AJvYcCVoZhZbr5WnpbfsIASGF0JxCGVU/FBdtmyW8cRu5XwLa7uEIMU105qQQc4sOJYk67SDRV6VM+PdjValh2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuFINqvRWNXs2O+4BwKn5BVO93IZcZAJAoaO1+jVRpRlucCcr
	59dS17fYmjJlvP4ir3iQ2gYgUU5LMH2D5iLUOkx8GkZZIv2HHP7sjsFpSpmtQPiTCvS/JPEDc30
	1bT40hiKdEdqxHE1UhrjjKNE7QHBbdbI=
X-Gm-Gg: ASbGncuT/HXa+8zwukBoA+EEwKMSqJbC4dWjeeTBaO5b8nHQ/oSkSFUrjC+8XTmYfZA
	mWERO0ZHRQ/3IiLm/qZDIatoBFI9q/rMo7bjPN8TyhPvutfVXHR5+XIWbC2RtA+p4CwSIDSe3C8
	LvTY8ROefRhQCnm0grj0HvI1ehETG5wAZ27PyxC3QwNE58KX623UZ7yWbbYJIIRg9494SOBZA4I
	ZGiWMl8mPCDZDgTV9KLbou5dTfjlD75QJV6777k4zWX9BQux2GdzL5bER445iKJGcj1wkvP39x4
	8XXhtZN02VLitnLt
X-Google-Smtp-Source: AGHT+IEKJ5y6YF95e/034EqGxft4V8xi6FgMAhGq8nqr/x73Z61EUK919R7mXNOGbOwgly5qAy/ORYIiCfLVfCja/8Y=
X-Received: by 2002:a05:651c:1989:b0:36d:6d71:4ec5 with SMTP id
 38308e7fff4ca-377978ab84emr21143131fa.17.1760781376848; Sat, 18 Oct 2025
 02:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251017145147.138822285@linuxfoundation.org>
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sat, 18 Oct 2025 15:26:05 +0530
X-Gm-Features: AS18NWDmZ6tjsEYEhc3Qxf_b1eBqwCHw2ql60itDmA3aRy_0TfbbrlLraB7y8cM
Message-ID: <CAC-m1rrkfLXrBtvvpZf=dBnx8B2bb7O8zZQ8xx_1mA5LAM88Sg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/277] 6.12.54-rc1 review
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

Hii Greg.

On Fri, Oct 17, 2025 at 8:46=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.54 release.
> There are 277 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 19 Oct 2025 14:50:59 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.54-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h
>
> -------------


Build and boot tested 6.12.54-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.12.54-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: 6122296b30b695962026ca4d1b434cae639373e0

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

