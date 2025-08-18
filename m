Return-Path: <linux-kernel+bounces-774401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E5B2B1BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A1423AD9E3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D149C25485F;
	Mon, 18 Aug 2025 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="p9LWsTLL"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2B43451B3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545699; cv=none; b=c1xejVxxvc1+wuX4yIu0NEV0uvhhK1mYtveEd6UUj2rVTWmRC+Z5ehCxm5scvVjCamKm1Q+dzKvMlPw/2kGHd8gdmP39/DBnALWWenb/tRV8s8bq5vyQKGgNtZb9YSSHmPfmbe8JTCJgeMTgCPLXUTsgq/b01C1QiLGSSQP77IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545699; c=relaxed/simple;
	bh=fJVgysxWJtebeZkRpkEKP+ZTzL2YFsbUmhTBeevlDH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uQUtdHzqrzkPwI5rKInw0e6rp8HfcGqBFA+LNGsC6ImkEZ15bhcezPfYz0nT8WT84O6aALbJSslsAnxdIiklP/t0/Gf/3TccJuDT1nMyVGrOE/pBAsOgIc2l+GZWKjpKmYXTwXvM8p0auCrAcEM6gPwUUyDmWbXLPicd+6v6SZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=p9LWsTLL; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-24457f581aeso34620105ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755545697; x=1756150497; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sk4g/V8NvBfNXQ3D3vbeKt4dIWO1NyjBCxlvh1AtG00=;
        b=p9LWsTLL3LXfzF5RMN15rGmjP20M1Sm93DshyydzuRtf/XoogwD+ZxS2IjSLW8t3Zk
         ViHvsCd6SHJ4rBIal+6RKaq0fiZXvmv0kV6D9E+BC0bk5SDAPvH9gbpcIyl9MaS4CWCs
         BOCw6QlkY4A7zDVzGrMRfEA3GyUaAX708cXCybpjIBnVlNtcuSubBucwJCsJSy2T9nLX
         3tkOdfWK3/unJ8iBAElkgqk+ebxtr/n9cCN0v9KVwT3zUiWM2IFsIm5KWMol33gJsSwY
         QQyYNLJXFuuWReW3v0v5KJM9gLRrsn6OTwkVCV1phozKwuDTl1/2MZz6xV0zJxIFK8T7
         g5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545697; x=1756150497;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sk4g/V8NvBfNXQ3D3vbeKt4dIWO1NyjBCxlvh1AtG00=;
        b=hbv7q9RJuA0D6+fxGA0JWhfjRHRqwIBNC2ouCp+Bvrm/+UzkKCom3fCr6h4amxUDpP
         m+WAYVG0jjxulmIMxqZSaFLrs7OZQrjf/Vh3yRSc5ZnHTYWunbDSNmwPGWBPCpwI5h8+
         E27XHrlC443SRFwOFsM2ky9sumuvhtGDcdMiGv4Y2rJd8SYMHAnOY4SwYHqemiHPXevY
         hI3YVWELF9j4QQrJoTD0BcknFDtcaResuSRXsOL4tEcpafz6afPa/Kbs2msTAvxFAYAH
         uwNGZwBswXLCoIPsbG+55b1A0Spvg9Usb5B85GIY+ojZEYD6p2Y/brcBfuiaFAZbF0aK
         9m0w==
X-Forwarded-Encrypted: i=1; AJvYcCVm2sDlcOZXPxqp8hBX3D4a2XpBfP16QHdPhaFDuzv6LKKT4npTKYRLm3Bne9cVJjL6oMOAmHIM83c62E8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuo6BPdd1JNC1xmhkaAmIKe47WlNqVKWyZ8ngBonoL0pY+weW3
	rHg44y7GXRs4/YHxtmzMyggZxUxmZXLkdmkXiTUkXRQCBlt3i/UBXManeQeo25KjsWfVGsIzFUC
	Nonfar+p47Qw3+P7Xky5Uq0/5uxJEzMR9PyDcvLGNAw==
X-Gm-Gg: ASbGncvmxK4XBZmZGXEfpDX/EkaYRvZCQ8ik1AJ2Mcp6XUuhGgC9XMuM+RK/+Wycp5u
	TtJrLRV3LXSzyMt9SWjs/NzatpcHYcWG1iPCAcW9Uin27IxELTnBvwKIWWDwgSgTmdc+nwv5KwY
	c40LIDXPkOpzYtWn0jWoHFEjAO3AzW1VLyeexz70lKVDXfZpjCQjc0b4CsvmZ7S4FgEXXH2RVhy
	7ULpfjzlFJ0/7jbRu5rG+cMDEDI/OBizdDJ85mP
X-Google-Smtp-Source: AGHT+IGD+22SoOjTZ/FihjINPgZbyDR9tilIU2io9YzP5E/2FmaTF0iTg1KKmWTZa6umDawDeEhyqZj2WXxqG1b0GLs=
X-Received: by 2002:a17:902:f707:b0:240:3b9e:dd65 with SMTP id
 d9443c01a7336-2447902c839mr167746595ad.38.1755545696560; Mon, 18 Aug 2025
 12:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818124448.879659024@linuxfoundation.org>
In-Reply-To: <20250818124448.879659024@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 19 Aug 2025 01:04:44 +0530
X-Gm-Features: Ac12FXyjNRdpUahtphWIIZFImuMzxQuvbQbDP7xtaevXbgmxzYAExeWGREkRos8
Message-ID: <CA+G9fYtuPjHbz_-sJtQHn+JjaVosBRcncZnqT+wgXEvRGc=cfg@mail.gmail.com>
Subject: Re: [PATCH 6.12 000/444] 6.12.43-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, achill@achill.org, 
	Ben Copeland <benjamin.copeland@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Bjorn Andersson <andersson@kernel.org>, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	srinivas.kandagatla@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 18 Aug 2025 at 18:20, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.12.43 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 20 Aug 2025 12:43:43 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.43-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Boot regression occurs on the Qualcomm DragonBoard 410c (arm64) with
stable-rc 6.12.43-rc1. The kernel crashes during early boot with a
NULL pointer dereference in the Qualcomm SCM/TZMEM subsystem.

The crash originates in qcom_scm_shm_bridge_enable()
(drivers/firmware/qcom/qcom_scm.c) and is invoked by
qcom_tzmem_enable() (drivers/firmware/qcom/qcom_tzmem.c).
This happens while probing SCM during platform initialization, preventing
the board from reaching userspace due to kernel panic.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Boot regression: stable-rc 6.12.43-rc1 arm64 Qualcomm Dragonboard 410c
kernel NULL pointer dereference qcom_scm_shm_bridge_enable
qcom_tzmem_enable

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
[    1.136454] scmi_core: SCMI protocol bus registered
[    1.138666] Unable to handle kernel NULL pointer dereference at
virtual address 0000000000000000
[    1.142955] Mem abort info:
[    1.151940]   ESR = 0x0000000096000004
[    1.154445]   EC = 0x25: DABT (current EL), IL = 32 bits
[    1.158283]   SET = 0, FnV = 0
[    1.163744]   EA = 0, S1PTW = 0
[    1.166596]   FSC = 0x04: level 0 translation fault
[    1.169654] Data abort info:
[    1.174508]   ISV = 0, ISS = 0x00000004, ISS2 = 0x00000000
[    1.177627]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    1.182937]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    1.188062] [0000000000000000] user address but active_mm is swapper
[    1.193447] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[    1.199761] Modules linked in:
[    1.205740] CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.43-rc1 #1
[    1.208875] Hardware name: Qualcomm Technologies, Inc. APQ 8016 SBC (DT)
[    1.215733] pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    1.222676] pc : qcom_scm_shm_bridge_enable
(drivers/firmware/qcom/qcom_scm.c:1378)
[    1.229356] lr : qcom_tzmem_enable
(drivers/firmware/qcom/qcom_tzmem.c:97
drivers/firmware/qcom/qcom_tzmem.c:474)
[    1.234561] sp : ffff80008002b720
[    1.238984] x29: ffff80008002b7b0 x28: 0000000000000000 x27: 0000000000000000
[    1.242294] x26: 0000000000000000 x25: 0000000000000000 x24: ffff00003fafaf18
[    1.249412] x23: ffff00003facfc98 x22: 0000000000000000 x21: ffff0000036b2410
[    1.256531] x20: ffff0000036b2400 x19: ffff800083031000 x18: ffff0000036e8000
[    1.263649] x17: 0000000000000100 x16: 0000000000000160 x15: fffffffffffffffe
[    1.270767] x14: ffffffffffffffff x13: ffff800080028000 x12: ffff80008002c000
[    1.277885] x11: 0000000000000000 x10: 0000000000000019 x9 : ffff80008136164c
[    1.285002] x8 : 0000000000000000 x7 : 7f7f7f7f7f7f7f7f x6 : fefefeff35302f37
[    1.292121] x5 : 8080808000000000 x4 : 0000000000000020 x3 : ffff80008002b710
[    1.299240] x2 : 000000000000001c x1 : 000000000000000c x0 : 0000000000000000
[    1.306359] Call trace:
[    1.313462] qcom_scm_shm_bridge_enable
(drivers/firmware/qcom/qcom_scm.c:1378)
[    1.315726] qcom_tzmem_enable
(drivers/firmware/qcom/qcom_tzmem.c:97
drivers/firmware/qcom/qcom_tzmem.c:474)
[    1.320584] qcom_scm_probe (drivers/firmware/qcom/qcom_scm.c:2009)
[    1.324663] platform_probe (drivers/base/platform.c:1405)
[    1.328309] really_probe (drivers/base/dd.c:581 drivers/base/dd.c:657)
[    1.332128] __driver_probe_device (drivers/base/dd.c:0)
[    1.335777] driver_probe_device (drivers/base/dd.c:829)
[    1.340116] __driver_attach (drivers/base/dd.c:1216)
[    1.344107] bus_for_each_dev (drivers/base/bus.c:369)
[    1.347928] driver_attach (drivers/base/dd.c:1233)
[    1.352094] bus_add_driver (drivers/base/bus.c:676)
[    1.355653] driver_register (drivers/base/driver.c:247)
[    1.359212] __platform_driver_register (drivers/base/platform.c:867)
[    1.363035] qcom_scm_init (drivers/firmware/qcom/qcom_scm.c:2115)
[    1.367891] do_one_initcall (init/main.c:1269)
[    1.371538] do_initcall_level (init/main.c:1330)
[    1.375097] do_initcalls (init/main.c:1344)
[    1.379262] do_basic_setup (init/main.c:1367)
[    1.382563] kernel_init_freeable (init/main.c:1584)
[    1.386384] kernel_init (init/main.c:1471)
[    1.390722] ret_from_fork (arch/arm64/kernel/entry.S:846)
[ 1.393940] Code: a905ffff a904ffff a903ffff f9001bff (f9400100)
All code
========

Code starting with the faulting instruction
===========================================
[    1.397767] ---[ end trace 0000000000000000 ]---
[    1.403793] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    1.408446] SMP: stopping secondary CPUs
[    1.415825] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b ]---

Please refer the full test log information in the below links.

## Source
* Kernel version: 6.12.43-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* Git describe: v6.12.41-814-gd65072433784
* Git commit: d6507243378459e7fbd4a142a0b195f4cd3f713b
* Architectures: arm64 Dragonboard 410c
* Toolchains: gcc-13, clang-20
* Kconfigs: defconfig+lkft

## Test
* Boot log: https://qa-reports.linaro.org/api/testruns/29585571/log_file/
* Boot lava log: https://lkft.validation.linaro.org/scheduler/job/8407180#L2638
* Boot details:
https://regressions.linaro.org/lkft/linux-stable-rc-linux-6.12.y/v6.12.41-814-gd65072433784/log-parser-boot/panic-multiline-kernel-panic-not-syncing-attempted-to-kill-init-exitcode/
* Boot plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/31SgOm3HeBT4mwsDOOESkOLRK93
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31SgLgEU5QMBwix6uJ2Xzs56tq3/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31SgLgEU5QMBwix6uJ2Xzs56tq3/config

--
Linaro LKFT
https://lkft.linaro.org

