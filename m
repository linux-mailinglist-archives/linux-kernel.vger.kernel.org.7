Return-Path: <linux-kernel+bounces-881126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E36C2785A
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 06:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B3EFD34C5C6
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 05:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550982550D4;
	Sat,  1 Nov 2025 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iMEdI9FR"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8F24338F
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 05:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973849; cv=none; b=VPqmxmtCeu7OuCNerYXTkiZRI7J+G/LUw3alLU12ghsPuUpw1CB73Do32X2uIKJd3d0SOuAktPpJ9aq5mtfYZptz6UXZpd/sNKBGL7wPIB3dhEnmZjxgxhGSXsEd3hIsK/iqr5gSjThUVVS5N4ttp5mLIvooAgXRtBSrUG3X6dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973849; c=relaxed/simple;
	bh=eOlM1uFeuGo4OskzqCGnrLnEeqaOGDwuYrRt8MXSqLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ew0fdO8aYeeOvEHr5GRnlNEEPUzRvs9zW6qHa/6H+sKDTX9vIMRq+HfuPba8Nj46Vve7+f2xn6Bh5T3M0jwdwbNe/3aINfbSQe/LEw7Sy7CLwSSr9qYlebsp2vQxIFL3rCKa+IVGCK3XYQjpFK1Fy+CTmYfb+dkqwkC1E5vzXn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iMEdI9FR; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-37a1267c45dso24572731fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 22:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761973845; x=1762578645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDBf0EPKFSh2QRdvgUh08qctzAfCvCuzR3NbXNNUNTg=;
        b=iMEdI9FRmOCKFSJDM5JHp1I8ENxi/wN4KiN0O7101WgZCIqjWQO1V3mZjc991Sdfg+
         xophtcs1ENxjmtluIGZo/0uqdsu61PRh7f7ep8OqFVDDj/UXK0yPchVfBNoH2W+MB1sD
         o+ibQO7SYZybvTMduEz5Jla5jw1HsQHyotq6LwOMawQJ/pcw3400uovKSFNoOvBS6nLv
         94bscpKVQoGdlGAj6avqDbvIEvbtqo820oGU2nPvcz9Zg+TdehJ1Cr4TfX/rYxgzazyu
         Tybg3eITahSfMt3CCBFhJ5ociJ2XZeuTlVW2ks2ojm3vlSJompwmx1PLmF85Gw2Qcnu9
         gtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761973845; x=1762578645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDBf0EPKFSh2QRdvgUh08qctzAfCvCuzR3NbXNNUNTg=;
        b=ECSjIZhF/U3QMx1KdtUKtW0CcTSInGqa6jXd9tI3VsapZ7ITyGvpaG7gYzRLDKAJKW
         e72Kdqxf6nJwcLvaxw0cGRX6ZarbjX53n+C2EbcBBZzIcrYoJCyilladdPiAuJyHXg0O
         wCmRKRRcfgc+j6PU49vNBPLyS5cq2IeDetOzjAR1Z3kmf1Vb+E/6eT64sf1udNeJtHp2
         s90YWc18PZuKydbdGPGtBSMofVr3vCsByVwDARVGOgBop5+ooVIdQQMRe7rVMIMXZeEN
         WI8kTfBbnS4DpN/+MCIUl8iqw0tGvmQysBXI4VZoFKuuziYxD6bnHYMdEe99jG304bcF
         3Ygg==
X-Forwarded-Encrypted: i=1; AJvYcCUNuRz+KTJSPMa8PLEowJyfZm5FbCNcYsE19oiROprB3i6LhHSky2J0ZNXJKln3gNj1xow8BnP2PlgDZWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZQjUdHDH0a8JFbXPGZC+dPpvy0qmMQ+R8SC/N0G2vFku23ufO
	mgiu6NvZkvlSOfD+FUrREMEPjmEc6/UHI7FElnF3LB1bt74HBd0QSsiMGdG9iqLUWBLegDtVLwV
	cZoo4qNgTMMeGy6IrKPeXfbsEeSbU5D4=
X-Gm-Gg: ASbGncsIreCq5buA5MxIP75ikYzgud2tTbxJ9O1VeYlB0BkwSAPcCtY6aGhy0ARR7da
	AginotcOLbkWD28oC9Zjpme2/oxmYdqJlVCvJp5iYF4/iVBIo3+Z6z9o5jNxkbRJfYcFHdgLIEe
	aQplWDEA/jRCNGTddijT9wWaNnNSMmG9tklKGEEcb0lIjm/x1WQQaPSINoLPY29/THhAD7tykdk
	gd8HUKXVu+fWTZOr1WRNBHqP3joq9TsddxLZcVz0x4LdnjJFaDwCnfPjuwpeKML4VVypwuQngr+
	k0u+HeeAxrB2WCohwA==
X-Google-Smtp-Source: AGHT+IEgcVh16NBSlAcq0VebB5Gm+0g5P4XcZHFf7Hd8YhrkSByvbyzY03uBh9X6qmIXljQ+9mmdAKbfTpWuA4Lurqw=
X-Received: by 2002:a05:651c:2049:b0:376:4320:e33b with SMTP id
 38308e7fff4ca-37a18dee5f8mr15061341fa.47.1761973844866; Fri, 31 Oct 2025
 22:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.939381518@linuxfoundation.org> <19689e2c-5dd1-4c3f-a243-84b69a552f91@googlemail.com>
In-Reply-To: <19689e2c-5dd1-4c3f-a243-84b69a552f91@googlemail.com>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Sat, 1 Nov 2025 10:40:32 +0530
X-Gm-Features: AWmQ_bl-6-f_3Ztgk64RenjMy1dM7NuNxp6tpcUL91fjp2wWmf8Gqa3cmQnHIAQ
Message-ID: <CAC-m1rqVAbQ4HUQibgheOZ6HJf57wmC-MAApAyuuQ63oeDGRHw@mail.gmail.com>
Subject: Re: [PATCH 6.12 00/40] 6.12.57-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@denx.de, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 10:04=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.57 release.
> There are 40 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.57-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Build and Boot Report for 6.12.57-rc1

The kernel version 6.12.57-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.12.57-rc1
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : c3010c2f692bb27dc44fd2318888446944f5846e

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

