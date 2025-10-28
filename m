Return-Path: <linux-kernel+bounces-874342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C0C16162
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 18:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8471B2614F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F55634A764;
	Tue, 28 Oct 2025 17:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pb9rEkPs"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4A434A3D2
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761671532; cv=none; b=e5jrhDfUewIbOK5BEZ48Sda6AvlpNuQtWMnp/EvVVRMOMrZikbTX5btCjValqW3nQ42Twjfqk/rWeRP7EdFLbAew85eE45OJF0jEEzjPFAMdgR95iI6WvWPHw2gpvh5oIJx/HkOqM1cjG72PKcHYNLhp3TFHOB2Om9am2u2KZSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761671532; c=relaxed/simple;
	bh=8aY+K6oJRK42GwUHaRODz04gZAOQSJRTEgx7aLu/TlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZCAyz18+AUxg/qENneorm6oh+eJSi5mRYTAUy5J5DBYkcSZO1VopleCj/jSYVe94V9nrAsTuJ9MYAgEiasEjHBcL4XpBW9Y3ec80g4h6l2l3bcNmmZCNB12jPvr0Dy8w+NLSLh91+bdzaDES8ijnkFrWNhfv/Bbbdsr6M2r9Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pb9rEkPs; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59310014b8eso1201067e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 10:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761671529; x=1762276329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhaEim7pp67uySZyfPHViLfH6/90BA9wjTtQgKcXy9Q=;
        b=Pb9rEkPsWeLLbybEvDyx3QxAY71+E5MKZwDyzdtndckz1WS4dfBNibLJMyW2YF8wq8
         HGMnrCxoIhCUwTTL08XS592oOGyaRrS/M8uJMAIL2aDQa+UbA/IPykotFI88YfqqQp3N
         z/UQjJW2zxKlhGLdjjBIlNO5auprjrzXXYGEs6S0JSgK7E12b1ZQRcybPcNi3tV/XK+K
         epJrqPflP6oGV7dQSoM99g9kFmqn7JOA5/PfMHpz9iZhjf605WacTOAEEuJUz3Px7L/y
         kypPFvU9et8Imy3tBs3zagYxQE6yVVCiPmZ0bKJbP76C+XroWnUMYoHRdjCQnYpLSzhN
         hTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761671529; x=1762276329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhaEim7pp67uySZyfPHViLfH6/90BA9wjTtQgKcXy9Q=;
        b=YfNDuVQ4sB4v6e03mVskSQxargDoMxuk3MaGVTtV4xJ8OjbDynhJD4GhvnDVb6etu3
         LrBgfeAQ+1e42Rdq+Ng21eVzLItDOUyRa8Y75+RWozbWBdnILLs1o0wR7ef6yDxnxLut
         Ipgzz+xl2My827+7qrBQ+nlNUpiQTX7/MG3+FshuPYazHH2Y5d45ygyrJ/hSWADCIk7F
         AwGHDi/Fhl8tJE27QbBf47nOEd5g4ZFm+DXbID7bpGwOpTcJPb8+um1g/s39JwfSFdCE
         gKlVu6J/Ix+hXAJaYIE2nge6nRIjO5eHX4AlvgA0JuOiQRg54uHqxBERVAexxPUBwQI7
         EznA==
X-Forwarded-Encrypted: i=1; AJvYcCU2p0lOfcqCfd7bQ9Mi2T5E68rgUeULGJz/PBi9EGhr1giJBgj1aPpdmBWfOgV+nZjVizG4PBjPPRQ34Gk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQEGq2A1D7LgrlC1luPHIWydtJCPkx42oN87xdAighF6vYbVDE
	6AyI32PqjRY82Xl+SCzVD1CAbHrJxVaCwXfwfVd1xW7KMUf+TtQFqcUXmIrKdGIpQZvkBpUi8ag
	fzJCEPbTucTGZWGt94oo928Cq/APvaJM=
X-Gm-Gg: ASbGncsp1pMcabaOJTnffiEXhClIu+T4y1xYfcBK+ZRQ/Hpbm93mCvlTiU5qkzOt/Ka
	DlyBnrFQjLsbIPgkCSGdgbYlh37mDx47cicy7o+Zpk22KzD0jcalk7yCxEZjgB/wQP0TirmbCGx
	HZb/XRjrAWyfxbouKtOp+ThWtecnCROMDjhjMxcjJa0lnkygR/WJslYOpRbqPRJJMMS6QleJL+A
	Ki49mbltCZaJxWYF/wNyRMKQAZHKp2ViohLMEZWlUA2x4PenEDacArKGOo0SuUJe12kDPc54qTH
	bWF5Vna5WQKL0eMUhw==
X-Google-Smtp-Source: AGHT+IGXVzMpnvwsNeD4NLKZTNTvU1+LcBI9oWgBlxyGBWCgiGyua0eoHig285ENZWhSAfa9iwDHF5qVrZu8Qf6uHOQ=
X-Received: by 2002:a05:6512:2312:b0:591:d903:4384 with SMTP id
 2adb3069b0e04-594128df108mr29896e87.51.1761671528566; Tue, 28 Oct 2025
 10:12:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027183514.934710872@linuxfoundation.org>
In-Reply-To: <20251027183514.934710872@linuxfoundation.org>
From: Dileep malepu <dileep.debian@gmail.com>
Date: Tue, 28 Oct 2025 22:41:56 +0530
X-Gm-Features: AWmQ_bliD54_NlxW6lHqh2heDhMGVKTWJMWeMi93yWM8vkjT7VQBefaXUu-Hg4I
Message-ID: <CAC-m1rq0XORNAq70r7SuRq3=4=QaAkKoPBWZ58uZz5fYH8pPqQ@mail.gmail.com>
Subject: Re: [PATCH 6.17 000/184] 6.17.6-rc1 review
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

Hi Greg

On Tue, Oct 28, 2025 at 3:23=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.17.6 release.
> There are 184 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.17.6-rc1.gz
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
Build and Boot Report for 6.17.6-rc1

The kernel version 6.17.6-rc1 was built and boot-tested using qemu-x86_64
and qemu-arm64 with the default configuration (defconfig). The build and bo=
ot
processes completed successfully, and the kernel operated as expected
in the virtualized environments without any issues.

Build Details :
Kernel Version: 6.17.6-rc1
Source: linux-stable-rc.git
Commit : 10e3f8e671f7771f981d181af9ed5a9382cb11f3

Tested-by: Dileep Malepu <dileep.debian@gmail.com>

Best regards,
Dileep Malepu

