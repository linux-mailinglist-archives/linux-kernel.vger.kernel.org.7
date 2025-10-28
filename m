Return-Path: <linux-kernel+bounces-874341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 092B2C1611A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DFA94E31A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1AB34889F;
	Tue, 28 Oct 2025 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2pDM5Aq"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A12BB17
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671527; cv=none; b=Q4kf16jcWyzvqBNiudnCVaItN9RhT0ON7sZue/jFcbqTmWwaBliJCY/Ui/2hnHIE67pG0w2DCk6yE7XC4xe/0oUHLqqfh9sb85BNBahhBnxF3eHkVXyCFbOW7mxS/TSMeHcspEikq9YYdNUTgGxhJWnfeK5AwRiK/Zh1JHNJIRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671527; c=relaxed/simple;
	bh=uRk8EwEwcOWT3u2NM1bPYXtYi7WeFHtlYV5DrUELKj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7qr3/Ec/3MuTtcslORearFK5ENZU0viNTj2704c3apHROhJ4XxBjzFjBCkiQvIsX3wcCOMVfcN3ZKfnkxdaKuvaegZndhy8p4tTBFP1rAPETHpgfmV73VzFXsVAmdmt4L+rGzUf1lZVAacvB4UqpmgPk+MC/yfy6IPS90X0T2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2pDM5Aq; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso132137e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671523; x=1762276323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3Pj3kvcN6aBQ6j/0SMZsas3fPFyjC2TU5uVuC6Co/U=;
        b=c2pDM5AqZHFsKfkYmLLw5UuryD3LRgp7av7ErMnEYUk2Ct6b2uxR0nhomol9QHFsDJ
         avThxUfWEzlz29LWRE2eQRwKFL58N5hPFdKvODpu8WxlqKL6YRK7LchLyr8+ewWL5JnK
         NXrpgYRnHHXlwoJo7voZh9LDjgpnY5okgFQCH5guJ5gqrykdIFEjezPMYvcuzGOtryBC
         3AdfrMnWKu+1v/CJhfeb4yUJ8ovT9j/9t0fIoiQF7qOkbxfq6+q184f/h6XB7bMjg78o
         ps+q+uVPTnT92ewFAi1qQBelbns3bbnJkMF2i2PJxTQY9VEEYCl6gqLa5H+Y2ax8UMRt
         taIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671523; x=1762276323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y3Pj3kvcN6aBQ6j/0SMZsas3fPFyjC2TU5uVuC6Co/U=;
        b=s8SUx7vSLgpTeoxc0Xt8ElxsghAO1Mmn0nyXByMJKy5dOpYehztD4RTAywJEahnJVr
         Xxn+yzP963+UuDuQogaoONuGc/5ZFUDcKvPLAqsvjp4ws+Bne0zqQX7xkkHTLFYpzZdb
         2zlsi/hoRrDZYTKTuOKUqVDEfGvStGde8HT8GKOyFYtK/r/IRD+VlfD1wq30xWj0O4d2
         L6BhfGa7zHRIeLIeEO/jIqhNAdluKQHKnrTZmc2cyPWQ3BUa/L/qVv6bg2FsENwTWYg/
         IeMBoQpGYrIWc4FG/dzPtE+pMi4xqI/pHD3om1BEbgbMm70YNVQZOGHjo+DKyqhRITqW
         yUOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUEL98a2snXem3v6+Vbswh1aR5v8K/L5FqlDsBthMQ5mmzET5Qd5W+736eNLXxltgTQztc5UiE/HyFNCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YynGTDlG6n6IqV8DCpStgwol8oK5q5UeLIpr2q6rC0U701B3+dl
	Oqxnv6aoR4Cb9Kvhwbmw7lGzP54uYdQTb5J0aevO8RtzhsJAoVYTEyngHkeXpf7UFzzvo2n2FuX
	DFD0y6OB4Xt9iGNcINx96MzijOvxPf1Q=
X-Gm-Gg: ASbGnct0H+34Txbzw6qiBYK2FkRpg3dfoV0fB4TGMRR1LsZCoTLkNRctsuvptWfha+F
	7mftmqsB82igiE4xITMPkKUpG4Zx66Neoau9NEB80BpsWCFGQk3mXZCZ7t/YadbmLYS/IudTAy2
	5ZEcw9YdmeB7bLXN+SlSwQ8QrLu0ytUYmpky5ClwFPlo/h78LI7UoG5BsUXw2NpUWLuPXbaLQ3X
	khLfxogh8DYyjVGGHFq22XnKyEdbhrvfjHjB1ZhaOP18y78rVwSygNPvdHFmqopmvHJLA8qD7as
	o/1PgIFWBnA97/ipqA==
X-Google-Smtp-Source: AGHT+IFiHrUMwVmkTCLb9w5Mom04LhEQB7TPo2rlpYqTBqyrPAneD8NpZPc6wf+wC2DY8YSbv1v4z9OiFrCUDrWhegI=
X-Received: by 2002:a05:6512:2312:b0:55f:3f57:a64 with SMTP id
 2adb3069b0e04-5930edf7cf6mr1431299e87.18.1761671521998; Tue, 28 Oct 2025
 10:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183453.919157109@linuxfoundation.org>
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 28 Oct 2025 22:41:49 +0530
X-Gm-Features: AWmQ_blC5Fm1cvehLp8Fe4c8zA-3g-SfayVM4q9tWXtt4kuTKi3hE7u8Q4HxCIM
Message-ID: <CAC-m1ro02LHYLz4-J_9_+XUOBs9YXRO9sAr+Otd4ddj6gxndog@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/117] 6.12.56-rc1 review
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

Hii Greg..

On Tue, Oct 28, 2025 at 1:21=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.56 release.
> There are 117 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.12.56-rc1.gz
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

Build and Boot Report for 6.12.56-rc1

The kernel version 6.12.56-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Kernel Version: 6.12.56-rc1
Source: linux-stable-rc.git
Commit: 426f7f601ca06d40c899834021f62b7cf90894ca

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

