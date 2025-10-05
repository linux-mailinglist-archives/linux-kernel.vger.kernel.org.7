Return-Path: <linux-kernel+bounces-842362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343D9BB9957
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 18:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8438F3B5E5A
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 16:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC89F277C87;
	Sun,  5 Oct 2025 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqp3vaJd"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC5E136988
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759681014; cv=none; b=BIyhk5Pz/fRyarMGkuhVOF/G7Bz2Gn8Bkrfa8dVns/yUEzgHS6dDmCTbkVsYVIpFTQ/mfson3OZqs/JPoZIf5/mf5qJAInZEu5eThq1iVKrRddMHssCv6nkaUnxU0lMz1Vp7yLzmxR+GAUnjlkHEtBpWCS1zv45oq4u2NMxXBL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759681014; c=relaxed/simple;
	bh=dty90F1rwneZJconV3QOpe/vTPtclXy/p4MVSEe8Yn4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zjxu3jy08QihEZeoazx/2c79W34jhwgVW9YFBYJrfXH3qBYfUa8hK6sDhphCDGiWmwMfYRQ9aOgbgCzescju0Had1z4oYm35kOBS8ea0QgPj6iT2hSF7ivKKluVNF/2Ok2fN++yNxKHFaviU6+CLVGCxZtf6b0qc6En9yttUj5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqp3vaJd; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5818de29d15so4946097e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 09:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759681010; x=1760285810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xZ/Xe3yLnVX9DMsOGPDjCo4xUIUON52FJicpdmr9Qi8=;
        b=gqp3vaJdGPtMfAnsFzAqGPHyg73XjRABwRbWKcZhuwCm4pWVCyjo3mdmCPFTlq/HMK
         a4jUVsS6+g2PBsGkWUGiT+TXD9erK2mU6sggHkSbt7jNpP9+6BhW1eCk2KLk9kSAKMwV
         BNojlNwW4R8YXD9rZ6JwAjxN1VJg/ERNjIRpgql+sHuVSn7mPAHYVEuJrYRehbuafpJM
         nEMXBpMYwYZyBFKX0adAEHPm7MIKWUv60RRDJmLkQYajreg1iLrduVtFgJu5kxrJ+U0O
         iIU2jmBY3yebVqXPpxPH6R3eT3Zvr1ssM21rBfOKx4Zt6dRN854O8dcyZ4+gWtTVxtHb
         m9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759681010; x=1760285810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZ/Xe3yLnVX9DMsOGPDjCo4xUIUON52FJicpdmr9Qi8=;
        b=Yzf/515EQuwvdC80WX1VW/vmB3GGiw2GAGv6f9voSWvtIWP9RzrQllShN/I5P1h3T9
         qJTyVY5xLBRDaRz8AC21CUCz7Kq6195Kd9UVEX7bguchijuPOhc5/+FYRHKE7ErqZ4bX
         WbVkt659V3vFvQ2ljOGft0PKU9/zcNwDxw/Tl4knII8kgnMOUXpv76L/FmngGcHcqbCG
         tcwBt1W8Vhse4causAT2fyCEnJlaBkiaoYWbnh/wFX1ZGHlp5HarJUy6JBSXe49EBV0V
         AB8Kz09VTOYFGzcI9p1Xw149QCY3oJmbgIolsb1lG85UXdKT17kGIA9+gUZX9tNZ4AfV
         oV2A==
X-Forwarded-Encrypted: i=1; AJvYcCVWlqdqmWIBV4JP1Q9SptcJL6WfI/DvGBXVOHC/e9uYjvwj4rQ+CnNfL2+kYY+xgEemTK8+zQFx2GX2yTs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9AGKW1wxichWShJ3S3OOhGAB7GMsA8Lsfvc75uxdxjudI9PJ
	61m7Mt9XTpSNTtPRgEaqrfxpyrg8c8dm8ZaD0I0VhIInamiSy0ifXxQ66ilF/AtoPp0S03J8QxT
	6FWTWaSe1bIjSnFYFDfw0TWt0wdoykBg=
X-Gm-Gg: ASbGnctmlhCDhYsZ1+g2iZiu85rFYD0JuVw0UmSX5MVzNFsF42sSsS1y7oC+lBwHaqe
	xyy3RumLX4SEBHtzpqRcH51hs+a+P+AAEz4X42uzKg6lKG5zm1rasFLGTX6/+eJmW53n94Qipvk
	APDYh3BxOo+2OHWUC9x4yjNEsIzIor/7UPFNqu/X7joF0/wCZwly5ijk+7RAjCEXnCaPCK3I+Dm
	ky7qrV/CuHuFZwP4DiaZ7IszWViUfFqw7+mAT5/URWPnfRc9V8naazJtsSCtfQ=
X-Google-Smtp-Source: AGHT+IE/dRLMfEuaRQqy5I4fZVpH7vF/19UAx7JrGRcujK2n+IGuU86xj7rH5QbW3nldnCI8sGQ+vovSwKvXg6cab/A=
X-Received: by 2002:a05:6512:2383:b0:587:b4f2:7f2 with SMTP id
 2adb3069b0e04-58cbc67fd14mr2692880e87.57.1759681009447; Sun, 05 Oct 2025
 09:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003160359.831046052@linuxfoundation.org>
In-Reply-To: <20251003160359.831046052@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sun, 5 Oct 2025 21:46:37 +0530
X-Gm-Features: AS18NWD3xFJTRgNFUfQnn3MOQsNtm_4XFNOYW88C6cthLJM2mf2PXFq2mY54q_Q
Message-ID: <CAC-m1rrzZ31hvy2r1b=UpCtb=n8dqOxb3CMRL-eFP6F1A-fExg@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/15] 6.17.1-rc1 review
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

On Fri, Oct 3, 2025 at 9:37=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.1 release.
> There are 15 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.1-rc1.gz
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
Build and boot tested 6.17.1-rc1 using qemu-x86_64. The kernel was
successfully built and booted in a virtualized environment without any
issues.

Build
kernel: 6.17.1-rc1
git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc=
.git
git commit: e7da5b86b53db5f0fb8e2a4e0936eab2e6491ec7

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards
Dileep Malepu.

