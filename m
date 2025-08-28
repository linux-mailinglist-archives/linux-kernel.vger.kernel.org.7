Return-Path: <linux-kernel+bounces-789670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56091B398E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2927817C1A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF7B30146D;
	Thu, 28 Aug 2025 09:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+IvwnSK"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173203009FC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756374907; cv=none; b=o5SIJ1jEaEQXzcsUDltcST33faX22WWLOE7GvsetJM+OO5HRQ+SXPpr8SR3gmkSXTxMLs13JEWuZvf4etj1RxvNcTWxg40Tt5y81HxiZyKiCiPTYE2NJaWQxQgCVNZTQMDG5/rrCDmThfpSZgPvRkBkPA8sua5yBxty/5iyNLoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756374907; c=relaxed/simple;
	bh=ZVfqOwwixQhN1YsADMJ1GsK96L3zPIgJ19cSnfmn7Po=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tBualpb7biEhEsIuQTX0OeR6oPe4IESjh5pChrxAHSQs1lhyd3CsPwmjtf8UBHZgkRq1Dtp//4IVbOgharM7AGif2I8QRimfbV9JPWwy5uGp0F6WKPu0OGi4eeigWUIxZZvAT6suo0rHzAiBP0YfrvRBnolYky2oafuY3lPSP8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k+IvwnSK; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b49d46a8d05so708467a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756374905; x=1756979705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0jvuITZ/unJkIw6qmtKmEjkIbRFIhMwWVAIfVS1zjig=;
        b=k+IvwnSKqqG9Jm/JWgQrC6ozm4K8QyYUHhDDXKWrQ0N6L8nm/YH+5y11rChvQjke9o
         jayIuIbPMkdJVf2satZ93XwB6k0n4myKPoqqI8S3vUf/eVlMu87MPkTyGCOT9i7CByrV
         acZQw8bnAyztloJYRAVG3eH7zTctq95Lk/ScP666Ao0rSQvHB3CQ0hT0tFArBdbw4vct
         95FmyCpoBK0y/zdcRBblDtUIwRh19XkSgivrZlw0nbd+iWYA5W4Rb5NCp8IHZ9idygrz
         aohMj3T7Q26n90V8UMZQMgitubszCNHHh28oEo92UEfyA4olUWVCjckkP61srcmcpMUZ
         kI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756374905; x=1756979705;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0jvuITZ/unJkIw6qmtKmEjkIbRFIhMwWVAIfVS1zjig=;
        b=eFba5yLLcSGRu99e5EgeVUyaY2+khrdVU+9mLd11cx2QPJM1vTlrXcd/3PeRoBYeAe
         spTTgzP7Dhv1Om7NI/8NUuLWok/Oh2M4WmSfWxgAc9IPhVYbjs30zFhprPyBqFaLLzyp
         JcwGDAaV77MH/K6k162ZfO70ui15wAww9LYAR/lAC+ve6svCtfEsnSes5PNompnYRgP8
         oMzBeWale6B0MFn9iSbJHh0XpwP37a1jqYu4xlDC9AOqiW5bFDJdFjpYvRL8s0bZq1Xe
         HMQbQTRC9RrsVYry7Df3nMMMJmHrL+Pa3Di9fejae0OZ/jNn3cJwzlmm07cYGRi4NchS
         0BkA==
X-Gm-Message-State: AOJu0YxLjQq2yrzrA0OX3HZHmGwnRFsHw1LIr3aG+TqQ0wiRwp5uoiQS
	4U7TA89wEMmghn77WwgBGo5A9DWxzPacBXecrC7OgfV4JaSOle63fPcslJJ47EaouxkmdaCfKuV
	54tTzDCwpHxKeioJHvnMeqdkbczyu2oNZ7FdqyJY3qRhd0ABL+ZzQpJA=
X-Gm-Gg: ASbGnctiz6dfcWCUDLGDwO0wv5GC/+3rK/JQO2tbesGnZTGda1jDTnQrUVjoyXaN183
	UXLSDLzlBCuUy2InuVPzrKks3rKj8ABAK6EMdMODKXZDyO1ecVw+dO3avfzflo31c8Ae2WHF6Sz
	aYvOXawDrUaM5ZYgUsaN3F8Fby488a/L1M3VjqfVmH7L+m8TxG1u131S8wenFFHtqxjgruedhiW
	2qRVWxzy1CocPf47c1qXcXmujVoYP24hr+zseGa
X-Google-Smtp-Source: AGHT+IFguJ+Z2YRJ9oQ+HqMrtwdA6Gs0EPRzyWeqEUpa81kCuYGFXDbA1Lv8HrhL0LBAfCI3DqPu7qWgxYGM1sgbFHg=
X-Received: by 2002:a17:903:11c9:b0:243:47:f61b with SMTP id
 d9443c01a7336-2462eeecaaamr332793775ad.45.1756374905075; Thu, 28 Aug 2025
 02:55:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 28 Aug 2025 15:24:53 +0530
X-Gm-Features: Ac12FXyceiP5RR-C_nUh1L7LdZ5AX72S9AZ1y-5AioD-F1Rzld83iOQ0aG3Om6s
Message-ID: <CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com>
Subject: next-20250826 gcc-8 compiler_types.h:572:38: error: call to
 '__compiletime_assert_478' declared with attribute error: FIELD_PREP: value
 too large for the field
To: open list <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed on arm riscv mips with
gcc-8 toolchain but gcc-13 build pass for the following configs.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

First seen on next-20250826
Good: next-20250825
Bad: next-20250826 to next-20250828

Build regression: next-20250826 gcc-8 compiler_types.h:572:38: error:
call to '__compiletime_assert_478' declared with attribute error:
FIELD_PREP: value too large for the field

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arm:
  build:
    * gcc-8-integrator_defconfig
    * gcc-8-omap1_defconfig
    * gcc-8-footbridge_defconfig

riscv:
  build:
    * gcc-8-defconfig
    * gcc-8-lkftconfig-hardening

mips:
    * cavium_octeon_defconfig
    * malta_defconfig
    * defconfig

## Build log
drivers/pci/pci.c: In function 'pcie_set_readrq':
include/linux/compiler_types.h:572:38: error: call to
'__compiletime_assert_478' declared with attribute error: FIELD_PREP:
value too large for the field
  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
                                      ^

Anders bisected this and found,
# first bad commit:
  [cbc654d18d3743cff70b2dafb64c903b8cd01f2b]
  bitops: Add __attribute_const__ to generic ffs()-family implementations


## Source
* Kernel version: 6.17.0-rc3-next-20250828
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250828
* Architectures: arm riscv mips
* Toolchains: gcc-8
* Kconfigs: integrator_defconfig, omap1_defconfig, footbridge_defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29694807/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250828/build/gcc-8-footbridge_defconfig/
* Build error details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250828/log-parser-build-gcc/gcc-compiler-include_linux_compiler_types_h-error-call-to-__compiletime_assert_-declared-with-attribute-error-field_prep-value-too-large-for-the-field/history/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31u6OUKGnkxZYEIbLMDV9Fi1OgZ
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31u6OUKGnkxZYEIbLMDV9Fi1OgZ/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31u6OUKGnkxZYEIbLMDV9Fi1OgZ/config

--
Linaro LKFT
https://lkft.linaro.org

