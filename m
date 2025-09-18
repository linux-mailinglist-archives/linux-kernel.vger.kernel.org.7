Return-Path: <linux-kernel+bounces-822643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C90FBB84620
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C70B623D31
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 11:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DDB303A1E;
	Thu, 18 Sep 2025 11:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2kZpdxN"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E5F2582
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195597; cv=none; b=sBkGPmv92YkoH7pdsGyWo7LxoJAyh3dUERIkH1ZR0rTyp3wHBukbNyhBNGDO+zZ5zsNnnP7NGdVIUihx6koNfRsygomSqACLCF1jhioxk761A3DtNBlHgyIDbRHi9tORh7IqhuwevcKnOyxYjwESON3cnDisVIUe/wRbTXK0LLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195597; c=relaxed/simple;
	bh=uFxlB2R+ZAYSRcEYlTPVQyhSU7uzPWXjKHbWDaZJTTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqBFRJCA+pjq0TL1F2vjVISmJfATd5lzHb7gK5QhAlT2ufbCAQXynr2P2omkHr9osF6poy1XfJjT63OMFVGOtiaiEjZCWObANqN8lwbDQT0VcgJIuUYsx1+kzAMn3e5ne/J4IRh0KcT3MP9U3aaa3TKcRxiG5dSWzFFhM5zReGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2kZpdxN; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-726fbc53376so100206d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 04:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758195594; x=1758800394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5vUxrIL/IBc7jEhkf1uGzLd2PnG5mi3zNkUmu0ufRfg=;
        b=T2kZpdxNfMQtbgeexpIY8UHjBFOlky/mRWMBcXEClIVPPib/QsZMJbshRo0loinT/V
         ysYeZjU86GCAHspAityKO0hZN3HFWxWmbHnV205AhZC/G/cgjWzLl7LPw+uuv2swS6Ax
         uIEjTxhqxI959GMj62FXeBoDeFVaMWR20xCRt7h9TRS32+NFJZwWQp2gAtwtDD9Hlstw
         NVq/tkBYddVoZVDKmIhUcZShk7HXeJDqs+6AvYFx+0WPRcffwo27n8JJaRCUa9MzoHMt
         QVsNIT5l+N/IdZiF9esHZqfRfKLnYCg/SVASAYqs6YIoe2t22V7zamGR5Z5wZYcLEmqK
         83hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758195594; x=1758800394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vUxrIL/IBc7jEhkf1uGzLd2PnG5mi3zNkUmu0ufRfg=;
        b=Ls2p3vFZ8SkxW2WDoHklCGT6lB9J/iKlsAtyQFGrIO/6u93774+PvoxtX8aTY6gBx5
         NDHm/3h3i5JFloXBxLdDxGS6TM42yRyd1pU9mi0RACJKZkIaWdy7FLVQaCRwHgzE9cXd
         7cENZCdCrWWcCnnhwJPMo1zc7fYjOtD7e/Dgs8h1ZjJzwQzXDC9JMGhxBCrSeQAuqWIF
         P+QJ6i2PBsWi3zpKpYiHW5LDwQq8WAJjpX3dQdYUsdSGW6sG8Vhz+/vlWK7gk1Jy5bcg
         bDeVDEaK+M/9RnGY98qnkQpu+J6guAvhSn54+k6Le2MATNdKme5Frq7TmRx4fsMRr0Vr
         xVPw==
X-Forwarded-Encrypted: i=1; AJvYcCV3psGhIhY+G2xWL3Rbd2idYoeqBfmbY9xem8IWHahp3IuPKrng7hAqKj6VQoFR+4dzG2AJtkbjrnaoby8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqEQMtVP22rDkY+UTKUtIsqCxazDeN7Mv9++LumUvrd/mqiTT
	Uk4nFaxQVjwc+9Xv3LptUChKLDkA4dSqetUPqE4Wae/nUkNfY3/qO9dCwNHZkBrgPZ6yRQIjxzH
	Z4JMeKdWA1UcCJlh/plJMk1f7wAKwvHLEK/vu+daPySVTjuuB4cLZ2eum8g==
X-Gm-Gg: ASbGncuj/LGpEp4iwlUD8EjVCpiHeP5bNSPz3Io3u7YnWrKZ4AXHllTJCjgbB0GC1Fl
	aTANrXohTICr5/iFnjwfOzIWpWJFUwTdEzmIaVYqgSM2lNdWaHyfBH9kbmVi7RKEJWDWEV2F8zp
	ZXmKZsL4I5RItBeaTALiyeSJKYuuCVouFto1pCsLvt2dETnmVjwBvjgQ8/1WryyO4wI2JqJVo0s
	cAukDK7ey7vV+i5aV5BgHiS
X-Google-Smtp-Source: AGHT+IH48ivQXtWG6C+0ln0hXjbS+q797BMP5NkKk70x0e10WLGtjHZ+0cOJrQylQsmByXrESmf6BwG/gWAUyqH0+oU=
X-Received: by 2002:a05:6214:519b:b0:795:c55c:87de with SMTP id
 6a1803df08f44-795c55c8cffmr5136256d6.5.1758195594483; Thu, 18 Sep 2025
 04:39:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250917123344.315037637@linuxfoundation.org>
In-Reply-To: <20250917123344.315037637@linuxfoundation.org>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 18 Sep 2025 13:39:43 +0200
X-Gm-Features: AS18NWBNNFTT46ohA_9aWzCCmFKj0hhU1Nz5FCTOq6VyCT2bqNOYD0vIURq0WvA
Message-ID: <CADYN=9+vrKOAkyqp69eG785TXoqbw2QdORoFOJWz=fXeEmGz1g@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/140] 6.12.48-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 17 Sept 2025 at 14:48, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.48 release.
> There are 140 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.48-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

While building Linux stable-rc 6.12.48-rc1 the powerpc allmodconfig and x86_64
allyesconfig build fails.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: powerpc clang-20-allmodconfig

Powerpc allmodconfig build error  :
/builds/linux/drivers/net/ethernet/ibm/ibmvnic.c:6134:13: error: stack
frame size (2080) exceeds limit (2048) in 'ibmvnic_tasklet'
[-Werror,-Wframe-larger-than]
 6134 | static void ibmvnic_tasklet(struct tasklet_struct *t)
       |             ^

Build log: https://qa-reports.linaro.org/api/testruns/29918282/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.46-149-g6281f90c1450/log-parser-build-clang/clang-compiler-drivers_net_ethernet_ibm_ibmvnic_c-error-stack-frame-size-exceeds-limit-in-ibmvnic_tasklet/

Bisection in progress.


Build regression: x86_64 gcc-13-allyesconfig

2025/09/17 13:43:43 socat-external[1252] W waitpid(-1, {}, WNOHANG):
no child has exited
x86_64-linux-gnu-ld: kernel image bigger than KERNEL_IMAGE_SIZE

Build log: https://qa-reports.linaro.org/api/testruns/29919415/log_file/
Build details: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.46-149-g6281f90c1450/build/gcc-13-allyesconfig/

Bisection in progress.


Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build
* kernel: 6.12.48-rc1
* git: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git commit: 6281f90c1450c5ee21a0f42e3dff4654f395d963
* git describe: v6.12.46-149-g6281f90c1450
* test details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.12.y/build/v6.12.46-149-g6281f90c1450

--
Linaro LKFT
https://lkft.linaro.org

