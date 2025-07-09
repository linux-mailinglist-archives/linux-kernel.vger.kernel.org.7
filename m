Return-Path: <linux-kernel+bounces-724420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D347AFF299
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 22:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674DF3A0731
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 20:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EF242D72;
	Wed,  9 Jul 2025 20:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gKrOCWUk"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7277C242D76
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091482; cv=none; b=FjWnXhcdZ4LMXoOUwKKuQnZ0rgc8cILF/ryKPcjAQxlabo5c+d20J9NsVF6NRtan4khNZPNF7mPycyqifHpBosAH1uKvsmSkWghMEKc8WQrmjRD8q39FBu41xYV1Z+TE3v6OO7LY2hSIIH0OhFWB7f72754r62xX0l0AQQJX4ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091482; c=relaxed/simple;
	bh=6oyYM6Bzq6DIFEVKD4PZ0b1pUz22xCymj9g6kLJahpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZtaM2zo4mNYbPTI7+zXsaldTOMzPIRhzgK9TfbJC1hrH2ea6Y0Ky21sq/uOMeV6OSBJiZpRBCJ81NXNHAJDknFhczCP1zecjTid1YIu4Fv4G7gRr9r/ItN4yjo/9lIFFqIoC70jJoQqO9iEk6EprGXAmGyg7jk5CpEef3VNVUfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gKrOCWUk; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3138e64b3fcso354957a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752091480; x=1752696280; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Suysl+uy0WOM5aXjtyyo3S8JCmjXJX0wRi5U/ew7K4k=;
        b=gKrOCWUkmighhmSL9kPNlHEL1YLWmey5LBro3hqVrzvFwpKVljZBiQKWVIkKOv4VUi
         s3tneXCpUOAJtmpAn48ZB2Ny0JNVtMHi8Ou0FqPOjJU93A4F/HX9tfZ95fGay6JPt9rR
         qTBuO6/1vlwiRBbJYS3qY35EsnwP/vtmlmcfVIRXT3bnBHjvX7kZ93xAF1YvYXV74vFi
         nTM/NEERQDwFb2p8S2ovvbVtos7tPFDW7iqxKTlaADIYECdhs4xEIDbfdRQmaJh7xheP
         v/eLo5BAjrgZVs/tNS3aTszZv4afc76hRfrTuh9FSMaiW9HqVE8/hXdE/C5sose+wQel
         JWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752091480; x=1752696280;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Suysl+uy0WOM5aXjtyyo3S8JCmjXJX0wRi5U/ew7K4k=;
        b=P+P9FJAzq4AOUnypdNDZqACW23qmMjinSfH8DN9JHjGH6pqlYaJU7iTS9+XTU2JarF
         449+isAmGpZBUxUjy7GAs5poBMSV0gEEByJu17Jpl7zbZng+V7nozRn7hegknZ1N8NEx
         tQJgeMh84ElIFxhv+st2nPEEQ/sKVyoQtZUCugNwKI1EFxFdaakxO/brTjt2GCE3g40s
         hYElfJ9T/Vdcr3K8uNtS0BM8QM3UriGzsgm++i4n7TCD8RBoyjbX4F9ysHHLO6Rampg2
         z+i3Pdv3ReUjWbKD6pTBQbY4rVmqSzf7K5JzbdvngE7IRjorKmZ/UsmrazYGOV4zLT2M
         sIuA==
X-Forwarded-Encrypted: i=1; AJvYcCWTsjJd1NSW7BDJiVf9nbiV200YkdNtrFLyIR+0maU/ktUdY32n7eU7NO0S8zdvd0hrkyd832tyr76PgX0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXQGQB97YNLzRCFqHnsqLh6N3Czmou/8OhFVLX9HxIPZNlDuR
	Jl8+qTBXU2QL4xWhFEz70N9BIbMtyM71rgzKwv3VmitJ5rIUE+KPNgoxy+/QQo0FBZWDGQJ3gxX
	0+EgR6ZsiCmhPzPF0pUIskDDzeiKtUUjUywn7ZMBzqw==
X-Gm-Gg: ASbGncvyFJHCEDUth3ZDQ16D44lwVUruW96YJJpF+6oxj/kpI5KGu/+WGVZk4XX18Df
	+IJoPdeiv/HaLVRS3rRkpiHkHa0vfc+XXy+q0iwP36mhNpQcNrbwAQGIfVoU+aP9NvkOBMJ65Ar
	csFmzdqna2In327kRzTneE1xXkQpvOsKVf7Heo/1tjKMhttIBCdef7XCQfgXll0cl2LeEDt1S+G
	WA=
X-Google-Smtp-Source: AGHT+IHyb7AodBmFQk72shSQkiCXZlrFkQoW4uGqYTIWPeAZ+h2iGsmtVGE4J9dRdDa0kWaEz27u2ChQkJDWDPr3dqU=
X-Received: by 2002:a17:90b:55d0:b0:31c:3c45:87c with SMTP id
 98e67ed59e1d1-31c3c45088cmr1530172a91.13.1752091479654; Wed, 09 Jul 2025
 13:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708180901.558453595@linuxfoundation.org>
In-Reply-To: <20250708180901.558453595@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 10 Jul 2025 01:34:28 +0530
X-Gm-Features: Ac12FXwQoTBN3H_JtJVT5-ethl5wWUwGHDE-rzunC_bB-mbB4lZM0MGm0RgxXb8
Message-ID: <CA+G9fYtkGSe0MP7+vXEcLxg80VC4-yHtme_xjnK-Dg8LkN1VAQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/81] 6.1.144-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Niklas Schnelle <schnelle@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>, alifm@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 8 Jul 2025 at 23:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.1.144 release.
> There are 81 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 10 Jul 2025 18:08:50 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.144-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


Regression on the stable-rc 6.1.144-rc2 s390 builds failed with clang-20
and gcc-13 toolchains with following build warnings / errors.

* s390, build
  - clang-20-allmodconfig
  - clang-20-defconfig
  - clang-nightly-defconfig
  - gcc-13-allmodconfig
  - gcc-13-defconfig
  - gcc-8-defconfig-fe40093d

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: stable-rc 6.1.144-rc2 s390 pci_event.c:269:21:
error: no member named 'state_lock' in 'struct zpci_dev'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log

arch/s390/pci/pci_event.c:269:21: error: no member named 'state_lock'
in 'struct zpci_dev'
  269 |                 mutex_lock(&zdev->state_lock);
      |                             ~~~~  ^
arch/s390/pci/pci_event.c:272:24: error: no member named 'state_lock'
in 'struct zpci_dev'
  272 |                         mutex_unlock(&zdev->state_lock);
      |                                       ~~~~  ^
arch/s390/pci/pci_event.c:279:24: error: no member named 'state_lock'
in 'struct zpci_dev'
  279 |                         mutex_unlock(&zdev->state_lock);
      |                                       ~~~~  ^
arch/s390/pci/pci_event.c:285:23: error: no member named 'state_lock'
in 'struct zpci_dev'
  285 |                 mutex_unlock(&zdev->state_lock);
      |                               ~~~~  ^
4 errors generated.

## Source
* Kernel version: 6.1.144-rc2
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 10392f5749b37d327ec5529958e9d5d27cf07b6e
* Git describe: v6.1.143-82-g10392f5749b3
* Project: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.1.y/build/v6.1.143-82-g10392f5749b3
* Architectures: s390
* Toolchains: gcc-13, clang-20
* Kconfigs: defconfig

## Build
* Build log: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.1.y/v6.1.143-82-g10392f5749b3/testruns/1565938/
* Build plan:  https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/2zbVlOqL24w4NUJUSg3nXcHGVZ2
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/2zbVlOqL24w4NUJUSg3nXcHGVZ2/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2zbVlOqL24w4NUJUSg3nXcHGVZ2/config

## Steps to reproduce
* tuxmake --runtime podman --target-arch s390 --toolchain gcc-13
--kconfig defconfig


--
Linaro LKFT
https://lkft.linaro.org

