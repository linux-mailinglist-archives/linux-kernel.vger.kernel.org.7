Return-Path: <linux-kernel+bounces-741308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD7B0E2A8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5400C56408C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFEE27FB1B;
	Tue, 22 Jul 2025 17:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MDj970wM"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3406627E7DD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205801; cv=none; b=Fht72eJuslrosQvvhEEwt4mpF5Oai6i74zIGimtS5GC6tELlAT4LsESPuEptIC4LJg2MgMXgmLNX6+h0VFEkEZsZNaAAYqgTGDbdrp4do/c7g4/JGj04ZFuXbleZk0F023U9v7m9KSJkUsUoUpf+pSQVzufFbOIkgpJ2lIQIWSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205801; c=relaxed/simple;
	bh=2axkp3f5ddX04ujyqEGdONBW5Q8IRjQZN01M0cDJ1hI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MXpC95UZaODp2p2N3kaLQVGWhDnI+M7s4wzO4UlcDUtJ3/v3UcjuxHumR4CGuks0QJVrFN5xVN+9niewK6zFvRlf5DlGtSHKlTxY4bGdRzRzft4a/+GOeRUSBlYZXidC4EKW1FzEQ9VyGgruPPFQ6QMAOqNzgcMgS4OiqVnjtLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MDj970wM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234c5b57557so51719805ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753205798; x=1753810598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WWXPzZR17yVeEQvaLavPxiayGN5aPr+0vFgreyi823Q=;
        b=MDj970wMt92S+lL+Uqtf8CdMpZ32x14ursvtzqlfrCsSC+9GUmS9xQXDWpxyA1IdyZ
         4qYTTQPSwht7MpmolxXjpUIZ+YUH6NVgxBslZ3KGVDCQR9YNGNHaoHJvpgDw39/i4Tze
         35Jbaird7Lsu8bYi12pcq9BRmGbycsR6Eex6rZC0NZr0O1uiNpovMMj5zxSKvSmU1scC
         VKwc8TVW+RpsXpIx3lVmlQyZiLJFYxh24LcwE+x2hy1j5O6hlRd0xrYrv7lihIgkxPCK
         rXKGUYL84NOVDDBhrHwBXtoTXS94fSiZr5PqnIQGXVbPs98zRvQ2yHtHme/eilPYgQtp
         kdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205798; x=1753810598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWXPzZR17yVeEQvaLavPxiayGN5aPr+0vFgreyi823Q=;
        b=GrhE3fTOECq37hZLD+yI0aI6tFUHHX5xC9cCfyVS95jBDglBy/RWolKUFPajppIQWX
         LC1Q/ZcGR+byCPPCjqFZl2XKJ3VLqYEwui0TGwiopPENzbluptmClestBnxbDHP1It6u
         XM9yBMDL3kMqrreePQGHKiWfTYGyKEAz4hsIMEv8U3e6fixuSsjJ/qRqORZGoZAd4k6d
         eSliyFBFSyY0E8Hsr09tsUtkDYqfbX2rYMglZA+FvMpXa8+REzoY9DkAsmr/b3/LZ1o2
         FxcRzOXEsFBIzvqukQyrTQXjXXKE3m/a27UUtGxvXU/L4NsCEe5D9Tfn7V6ah1QXugcZ
         rUqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCkQ3RzsuNoH5XBEimuxVGkhqrU9Mp6+TeixWRdd/ubX/uyI+eS6HZWB0PCTj8tzalpK9z9pmZi2S8esc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKRCmpT1Ivvv/gfrk0ZDeZ+ZM02NMdHkrnp9274TP+EE6nM5X
	IfdTjCzl64KNTZdwjaKpxiVUeNt8xjBdIRFU9Go5ezyhfWI8Lndpd6xdElNeiLBOtZMKces1/CZ
	Qx8AK0+pa/cTb2Wo5E/t1opJpt6ecWZRvKSmnkMnTEQ==
X-Gm-Gg: ASbGncv92I30/AfoheQc+3Y2cWXAlNqIlvQrYa4i+HvV3pD8fTDLwnojFEvuuF93cSi
	dBZTcLhhnqPnc29G16TysQ/gexAuj58QI0/BMkopSB0KNmKB9/LZmNJ/S2jQyviT+p0usn+/ihH
	AyS+OOP96gvhmzVgGMitwF/K1bnLokbDIeNtsOUbrBmDoLNmV8BbiQMeMYjz0X9ORaGu/V468NY
	by3V7d9w1XpNvR8sh7tdVqmo9G5d+unQT14+IsvJPDeBYCf
X-Google-Smtp-Source: AGHT+IEy1xm2TqQlOmdtPxzMMBfyqW6NBLNLnRvTRydQhFeyBv42+TUFYyc4kk26QAuv/J3OEh9WLD0WjO4Y+jfMmNk=
X-Received: by 2002:a17:903:166e:b0:235:c9a7:d5f5 with SMTP id
 d9443c01a7336-23e256adfcfmr297545055ad.13.1753205798348; Tue, 22 Jul 2025
 10:36:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722134345.761035548@linuxfoundation.org>
In-Reply-To: <20250722134345.761035548@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 22 Jul 2025 23:06:26 +0530
X-Gm-Features: Ac12FXyiK9qISUvF_HIZvmbjmo4biYOCInngZ1yVyGInVK5qVkduAH0VIdLJwh8
Message-ID: <CA+G9fYs_6KYHSF6eyeFmewDxYGqqD70kO1DuB0_1qwCPV2LjOg@mail.gmail.com>
Subject: Re: [PATCH 6.15 000/187] 6.15.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, clang-built-linux <llvm@lists.linux.dev>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 22 Jul 2025 at 19:37, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.15.8 release.
> There are 187 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 24 Jul 2025 13:43:10 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.8-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Regressions while building allyesconfig build for arm64 and x86 with the
toolchain clang-nightly version 22.0.0.

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Build regression: arm64 x86 mm ksm.c error variable 'output' is used
uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
Build regression: arm64 x86 samsung s5p_mfc_cmd_v6.c error variable
'h2r_args' is uninitialized when passed as a const pointer argument
here
Build regression: arm64 x86 mediatek mcu.c error variable 'hdr' is
uninitialized when passed as a const pointer argument here
Build regression: arm64 x86 broadcom phy_lcn.c error variable
'diq_start' is uninitialized when passed as a const pointer argument
here
Build regression: arm64 x86 usb cxacru.c error variable 'bp' is used
uninitialized whenever 'if' condition is false
Build regression: arm64 x86 drm dpu_plane.c error variable
'crtc_state' is used uninitialized whenever 'if' condition is false
Build regression: arm64 x86 drm amdgpu imu_v12_0.c error variable
'data' is uninitialized when used here

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build log
mm/ksm.c:3674:11: error: variable 'output' is used uninitialized
whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
 3674 |         else if (ksm_advisor == KSM_ADVISOR_SCAN_TIME)
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c:45:7: error:
variable 'h2r_args' is uninitialized when passed as a const pointer
argument here [-Werror,-Wuninitialized-const-pointer]
   45 |                                         &h2r_args);
      |                                          ^~~~~~~~

drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c:133:7: error:
variable 'h2r_args' is uninitialized when passed as a const pointer
argument here [-Werror,-Wuninitialized-const-pointer]
  133 |                                         &h2r_args);
      |                                          ^~~~~~~~

drivers/media/platform/samsung/s5p-mfc/s5p_mfc_cmd_v6.c:148:7: error:
variable 'h2r_args' is uninitialized when passed as a const pointer
argument here [-Werror,-Wuninitialized-const-pointer]
  148 |                                         &h2r_args);
      |                                          ^~~~~~~~

drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:3365:21: error:
variable 'hdr' is uninitialized when passed as a const pointer
argument here [-Werror,-Wuninitialized-const-pointer]
 3365 |         skb_put_data(skb, &hdr, sizeof(hdr));
      |                            ^~~

drivers/net/wireless/mediatek/mt76/mt7996/mcu.c:1875:21: error:
variable 'hdr' is uninitialized when passed as a const pointer
argument here [-Werror,-Wuninitialized-const-pointer]
 1875 |         skb_put_data(skb, &hdr, sizeof(hdr));
      |                            ^~~

drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c:2728:13:
error: variable 'diq_start' is uninitialized when passed as a const
pointer argument here [-Werror,-Wuninitialized-const-pointer]
 2728 |
&diq_start, 1, 16, 69);
      |                                                       ^~~~~~~~~

drivers/usb/atm/cxacru.c:1104:6: error: variable 'bp' is used
uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
 1104 |         if (instance->modem_type->boot_rom_patch) {
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c:1066:6: error: variable
'crtc_state' is used uninitialized whenever 'if' condition is false
[-Werror,-Wsometimes-uninitialized]
 1066 |         if (plane_state->crtc)
      |             ^~~~~~~~~~~~~~~~~

drivers/gpu/drm/amd/amdgpu/imu_v12_0.c:374:30: error: variable 'data'
is uninitialized when used here [-Werror,-Wuninitialized]
  374 |                         program_imu_rlc_ram(adev, data, (const
u32)size);
      |                                                   ^~~~


## Source
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git sha: 81bcc8b99854ba689a8c85fb1d39d5acdce0385a
* Git describe: v6.15.7-188-g81bcc8b99854
* Architectures: arm64 x86
* Toolchains: Debian clang version 22.0.0
(++20250721112855+43a829a7e894-1~exp1~20250721112913.1588)
* Kconfigs: allyesconfig

## Build
* Build log: https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.7-188-g81bcc8b99854/build/clang-nightly-allyesconfig/
* Build run:  https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.15.y/v6.15.7-188-g81bcc8b99854/testruns/1699830/
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30EaSfe4S6Pi4zE2kv1TGQcGByr/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30EaSfe4S6Pi4zE2kv1TGQcGByr/config

## Steps to reproduce
* tuxmake --runtime podman --target-arch arm64 --toolchain
clang-nightly --kconfig allyesconfig LLVM=1 LLVM_IAS=1


--
Linaro LKFT
https://lkft.linaro.org

