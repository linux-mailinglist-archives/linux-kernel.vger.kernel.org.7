Return-Path: <linux-kernel+bounces-880666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD96C264B7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 18:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56A10425532
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 17:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5812F302741;
	Fri, 31 Oct 2025 17:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOkHBL7+"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7D528BA95
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 17:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761930393; cv=none; b=ltq5MN1dtkkq3ouRBZ2XpdMmdLoQXdLi4FeBsrH6rLVE9OTeTKUVoRkUPI8JPzZydAZXFSoEbvGmtFshmiv9c+xOeklPWCMcPu0A0TEgn9og2wxTX/s5T009r3kobytIHyh4xquROpeLjgwQw+zOYt/7eIk54yOq15azFylTRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761930393; c=relaxed/simple;
	bh=V4e11FPTB70217C5nj91+hem0/N3V+YGbQrtmxcFY/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NrEbE3UCltvTXvhEqk0+suFSrcr7e3DQRje6i79F9uHeT9ZzRAJN8Jj5dcdAQabODHq9VffN/lc7f5p6WGodyVkXYUssotz4eNfpboMH5vB33clkSxb/QWFU7GNJjaEfLKuaV2augoYP6ckiSFLJwZLEYMvCPNdLfR9cYk624sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOkHBL7+; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso5258752e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761930388; x=1762535188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMkJiBcxuds+akFzr16pnTLfygNUfqye+Q3+HnkrYH8=;
        b=UOkHBL7+ynDpGtXo3om4ksJjDsM5Ucnc3/gjUxh9YO8FTgEbxqE3+6+9q/zlTPp6t+
         VWIl1gTdDhqOA2xblvgRt6/xkEJ7fye0c6XEfJ9FycNMooO1lqfR9riz8HPO06otuHPR
         t9HZA0817kBZXqcGIHwiDiGzufY0PtbzIc7pZ3yHKmWYKA2IPObLwzcH+ZwM5OMs7RtD
         EDxuyN+aewnOIPC5rlGZUuCNi1K7bil1E2qZLsh+TJusQOTxV4VJ+ZeQ3/CoitJlMjr9
         WFKQfMIyi40psyTluqaPdAqFyEgqr98w0NfPFtO3BiY/XjK+8OlJcrUDUBaiVGX51bHC
         HsTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761930388; x=1762535188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sMkJiBcxuds+akFzr16pnTLfygNUfqye+Q3+HnkrYH8=;
        b=hJ0ClYb1cK0X84tO86lRr1oQYSDFBl27XHuh7ymN356wRERvgbL22cPxeE+0nVTdO3
         YUJtt/7eqiSVVUCbpS3EKCkGMlwy2lwBUfDB8gCdctCwhggL018qQ4OsMXJ9cHPxVx4e
         yfCg6IbyVgs2QdJNzhDP7QFWBuo1wmIYVy5EpRS3qC7/rCf2hVQn/rW5L/QFRWZKYjQ0
         ohrF+YHg1RkHhUsJCiIq/mgf0+wAqRgE1HLwylOlE18Jfyaj2yDZ1pIXxp+gJ5Qu9rS+
         ZZN31FI9+SCkyBWp8niFTVEgaKC9Tv2DAhL7CHrRf7hOmec0NKJnnx421PUtYIRQH4+E
         XzxA==
X-Forwarded-Encrypted: i=1; AJvYcCU3Vns52nfQqu8HKZrghmR6sfAklK+WhLDNac9CDttDuxS6W3vx7MOV7hIycFTAj7BwPItNCFVmSyc5vAI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV8Q8Fbfqb0PODLC8R08GlU/xInmqviC+yJKIXjCNa553GMDjK
	06iGhFTpPM4oVFlZaCOZMGJG1wSTXK/VEescQpQK6iwJINk7LFuF2HxviHh9HoyVknXQt53QK9Q
	8UV7i0EBUNBUERAPIsDkj7Z7MDbG4JZM=
X-Gm-Gg: ASbGncvGZzH6iyvj2u2EM+PH/p9MZIMUHpnkPVRyKFj3KdHCehVbGOTQkpmgRNovWY9
	fhAxp98E/Hs7bfhxDuNOYUsLWS5S39vxck1iiiH0Ku45IFlmrFR50cOmIScrulr/4+1dHEQNtZw
	eRFQP+UVfdK1syHrX+t5fHiwPgjDJFp/JONTtiN+TijWoXpCgINVMdmXUTaY9uVlgJAuzwiL4Gm
	rtOm2yKPA6cNlnAx4NK5pz1aAatTKX3idUOlNI3uiep/5bEx8g41QJQLuXvt8TFTW4ESpePT3wU
	0rJreIed7QUfpP3WZw==
X-Google-Smtp-Source: AGHT+IFnG8xxlm9juE2SEhrODTBOOrCE0rh37MNi8KlVkCf6aXpO0iApavTsldubjEQyHeOMvNj5YZ+IFGx8qPHgQyY=
X-Received: by 2002:a05:6512:220c:b0:585:2df4:7965 with SMTP id
 2adb3069b0e04-5941d39c3d0mr1492676e87.14.1761930387930; Fri, 31 Oct 2025
 10:06:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031140043.564670400@linuxfoundation.org>
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Fri, 31 Oct 2025 22:36:16 +0530
X-Gm-Features: AWmQ_bnNapyza39VXDxGKokse023cnqtK8m6TeE7upn_35b0lbcczdmC83kKVz8
Message-ID: <CAC-m1rod_Qsk917N9A5G4a9B1vwA=n+E0RTujMPBAk96ZR3J=A@mail.gmail.com>
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
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

Hyy Greg,

On Fri, Oct 31, 2025 at 7:45=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.7-rc1.gz
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

Build and Boot Report for 6.17.7-rc1

The kernel version 6.17.7-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Builds : arm64, x86_64
Kernel Version: 6.17.7-rc1
Configuration : defconfig
Source: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Commit : 7914a8bbc909547c8cb9b1af5fbc4f1741e9e680

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

