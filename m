Return-Path: <linux-kernel+bounces-828740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFDEB9552F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B50222E15DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 09:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3165320A30;
	Tue, 23 Sep 2025 09:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fC78dJTe"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B4F28850B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758621075; cv=none; b=kfL+6IPkdy9dfeVxYCb1ovYCEAr3lMls8iqJLZaKP6qRdokke/dJsQE626THJEMyIv22S51bmq8GkyoSbwcbZjSY4zgpv7Blccz1lgP5d/SZ4PzUegJ+vPlD5z4R6nfra1CoL13ueEM6oW10XoKxUJMzNyJmr5o0hpcJCZeX/B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758621075; c=relaxed/simple;
	bh=aXu4O1FN+YVhKDNpeEOiwXtioblobCHbcZCuvieGJ5U=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=lF8Zj9QeRBgR06EHfcA1oBUrRc3zjStswKZZDJAnJYWm+CyPTzKsRQitTaC1I3ewb0HT2e3QVKjiUOJLaE+L0VbluUKRgQKud/Jhku7Zh12IQiejsUcNZdhADEeeJzFezbWAFqRlSFfhEgJDcPKRNHd1xUZyzcDso4MfYAXGDg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fC78dJTe; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-26a0a694ea8so34616995ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758621072; x=1759225872; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ujUSntEdEB2Zj8RW3cXBNzPb5lb7mNEARj7gYfxpl6o=;
        b=fC78dJTefUEdGD/tRW+gR53IoqOKulkUJfNRCw93iifTtJTo8+l6G6ftaibTlRv2Jp
         aT/AcB2+BSZjuAlUulDzW/jubQxIOx31g2saGGpPRUV9IvfPAVA1D1sIBIDZUB9QM4s/
         B5AI+vqcbq5H3svdqCWwuFAKT22aqMH/RkdiNJhFVk5Sf43hMtc7hWjCBbIWAGtg5VCP
         ewOf0YgMb6RzeNd3XQIQklYHmZJ7BAM7l2dULyE13IoYg4WHl0mcf3MhSoeuds4ok04R
         AmkzH078lC4U5gUiiYxm9wDJG2mK0rdfx2p1HNOAHLUGYovvPrr7nv2mjteMsy8G3Ie8
         IV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758621072; x=1759225872;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ujUSntEdEB2Zj8RW3cXBNzPb5lb7mNEARj7gYfxpl6o=;
        b=srueqox5u3SK29XFnZZ8N818YT+auY6oXxmsui4MKniLorxCxyVOq5Ic7Y4GMBUFCl
         VAKiE+P8brWN8iXrpi67JLHBsH73hHHyzsOhP/e1Mc/FseiyqhzQU5r1Dw7JGY6NhtUi
         JIppt663NDSRXlNEqyg7sFJpXcW3m4/zpiicxtO/MamLwkz6hiPsLk9fZ9Wl/7t0Vien
         J7QVoEok7foenDfGM85cO6KxwFoO8LXrs/3BUz/HEge/7lv7oJJzrt6aunx/TwXXnxPn
         cmbYzN39/yPRjfSJ+WMj3qIVk7RiF/cNYX8dCo+WKxoqQo2IMdZ/SVttsN7vxO6mYa5R
         5C+A==
X-Forwarded-Encrypted: i=1; AJvYcCXHtsKTKYfT+W437XVxftupc7klAYL2J+5JdQLS2xyLKZnRK/v2sBBjVhK7BfPWxsik8qDb6EWaVS4eR/M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7EVExnTk37uVPYHQSdPCMZDDqketXqlSLNBPNgoquTi7SPGHY
	TfM4mLQ8UWKJgk7bkIoJxM9apPuJ6Gm1O7iqhRmt4g4TTnT2pS9jaOhqwVfNKjtsdFNIx95dAe1
	Htt2hNcXRWy0Jtg7FuxPyCw6CkkPXXwPo3RQh0xHZxQ==
X-Gm-Gg: ASbGncsqao43A+GjMBhSaMOZghCPYTr6fC5kdto8ghJY2+HQuxyvNe/um+R0EsNj5Aw
	57Y0Oz4Vkp/6ImhVrtzOJS8jUwRAA8Soac1hZPQvSpqr2KyNFfyl8AAQ/s6T9M4CUVaOLVI6O14
	QEYqH/CoSnLsbglxPlC2EdyRFv6XH26ZFj3cf5vq/z2Yyifuiwdbgd2IMHFtZgo65loq1xEpe21
	xtnwDldAmOen7tYDz5z2WKdwfe3Gd1YavZA3gOG14hvwOzPd14=
X-Google-Smtp-Source: AGHT+IFHus42Ak5ruWRhTAyg3xMfr+guDvkTkhHI6eHQ3GvPvUzkyf4uNtM2sp4MCW+8IQd4OjacMuEUwlCpUIFW7h0=
X-Received: by 2002:a17:902:ecc5:b0:264:c886:8188 with SMTP id
 d9443c01a7336-27cc2c98b42mr26887555ad.24.1758621071785; Tue, 23 Sep 2025
 02:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 23 Sep 2025 15:21:00 +0530
X-Gm-Features: AS18NWCTfgTcnoVtFJ38FtxMSy0NvoryOqAycB2FQR-fdtYRDlc0bdIbrsPkR5s
Message-ID: <CA+G9fYuZZUQq=7qPavXnHZtX9oQ=amfYVeYRZu3SHfD0ReD6nQ@mail.gmail.com>
Subject: next-20250922: xe_device_sysfs.c:300:25: error: label 'cleanup' used
 but not defined
To: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Lukasz Laguna <lukasz.laguna@intel.com>, Michal Wajdeczko <michal.wajdeczko@intel.com>, 
	Jonathan Cavitt <jonathan.cavitt@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm64 and x86_64 builds failed on the Linux next-20250922 tag build due
to following build warnings / errors with gcc and clang toolchain.

First seen on next-20250922
Good: next-20250919
Bad: next-20250922

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20250922: xe_device_sysfs.c:300:25: error: label
'cleanup' used but not defined

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error
drivers/gpu/drm/xe/xe_device_sysfs.c: In function 'xe_device_sysfs_init':
drivers/gpu/drm/xe/xe_device_sysfs.c:300:25: error: label 'cleanup'
used but not defined
  300 |                         goto cleanup;
      |                         ^~~~

## Source
* Kernel version: 6.17.0-rc7
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc6-next-20250922
* Git commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
* Architectures: arm64, x86_64
* Toolchains: gcc-13 and clang-20
* Kconfigs: allyesconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29968978/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250922/log-parser-build-gcc/gcc-compiler-drivers_gpu_drm_xe_xe_device_sysfs_c-error-label-cleanup-used-but-not-defined/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/333Idt9y0485dJThIiCgCMB7ehs
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/333Idt9y0485dJThIiCgCMB7ehs/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/333Idt9y0485dJThIiCgCMB7ehs/config

--
Linaro LKFT

