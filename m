Return-Path: <linux-kernel+bounces-857629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E53E0BE74C9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A493D502641
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B97629D279;
	Fri, 17 Oct 2025 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ds7lp1vJ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FC74409
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691131; cv=none; b=rQJQXyDjTkT1hJyb0EuFfIHhTOPxnMO7Wx+++qEmocKEZ0fYU1ZPx3lyJ5Rn2QnonGSzFt1sSWFkiZiViroTVm8kbiGe2i57TgLn5XGrwNtyyHc9n0/6VD26WXU/WM+d5tAdozV7U37254iJwJFYfLDwOXRQ33aQF2p4xs8jEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691131; c=relaxed/simple;
	bh=2oLMnCZ23LLTDdFKDD3O2sUs72MeFy/tN37/VGxtlsA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=L4X+R0UqfVSH9jp58MOokksurVF6cO7BmDJz+JMafK3RiZcsKeN9opTfXxStFOTwa8bl33rKTpqy2IRWMig0rqe0hVGAkzZljImmgxQ0WKxRzXmwDJMnPrXMpc2t4s/35/m7bkHANzU8UgegAsu/hoxwTyJlRP5aXdazZWszshI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ds7lp1vJ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-292322d10feso309245ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760691128; x=1761295928; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=J+y1vB4iqnryB//UhMXxu9OFiqC1kDkx0s8+5S3KEFo=;
        b=ds7lp1vJAhMfZEy3rXTjECwKGoxjvE2Wbdw6EdyDbPI9JQFiiaHIY1butP8qXAOnGj
         nDV0MoztSaExsAcpoS/qXcrqw0gFPGoHbu/GERV3s21uMQUUJ0sDyD69MxWPH72bR8Jc
         AGAfxM9TadlB0twAq3ZAxESDfL1rZBFnFoYVYGyEFpppHY8MLAVTtCcMW8d3paJ1+YAN
         QE9DxM6E5lv3pxwqgQUrwTVSdv7VQKJyWSVnY1buoiNhE6QJ+XfaEx41GF716y+2JVJl
         e7QcC8eU6I1QPGocTztgesmJ0jHEt2vwJWy5Qu3DPnrHrrFwYYiBRutifuTQ18sSDA/E
         4M3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691128; x=1761295928;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J+y1vB4iqnryB//UhMXxu9OFiqC1kDkx0s8+5S3KEFo=;
        b=WLvW0f+2RLFBCJGJkQ6BoJ79l1LihYSsITtUMjw+OFmv3KJcw6m9/pqYIlEhcVFmzK
         ysRefTsUfsfFSpvg7X+RhFOQCl/dE97MUt0y19U/qpv2otfa2KlPkHGHIR5e6sgO2g4G
         2P0o0yyxOYar2jqhQc99efZEvmgRcBT+aZdD4qek+Tgt3zhnaKgjNbaRxTCTAmTMgKkd
         ZN7qgT2miqFQkXO8MArTqChDvVnBpszOHgpYXg/xhnQL5+Z0t+XH2I6MA84/kD19fWNe
         bPNFxkq6sPMqAbS3LMHGUb36tN9xo/cajBWBgyFML3tqvMrbOBB9XvPF2G9kSJb3ssUA
         Ck8w==
X-Gm-Message-State: AOJu0Yzp8Dt2ddiQIAiRG/FUuO6xrlFmoyrX9nyTsnaS5WxFYs+jaTL3
	V8ZnL5vc3IhO4jzN2Q+un45T4R15AL2mw5dd8FV9CzdCQ7aDKbeL2IXTPBwFvLXHY2sV+0Y/1w9
	snmOLhlnHRSz54Jvf2FMNCql2zp4zn57yTX1Alp6U7pO1Go5LyYt5/VE=
X-Gm-Gg: ASbGncsQsRIbDK3pDLG4LHcODeI299ICawqu7gTqs15xAGAJbf/+fVnja5+k0Xf7pdM
	3M1dRVMICtOE0/WAUyilSfFVba81cYRyZAHmM61KYlhV1MJ7FeS7LEkEUvS83JpjlHjQ0TI6UdI
	1aimS405jGrPTCy4FaKrvJzEDkOGZj1eJc3qEVc9iJizihAsIvIoqM78WqiftNWYLpy3sCrVHYO
	cHin+jbq8EQ4s/EMNsoB5hK1NkUDbevGUsRek3nraV7Q0ws5CoRp3l+AtFDn0tZNyo6Ld/VZUfL
	2gwDX184CKnMo75LuqBfquZD6VGaBi9YbagX7j3JVUkZhEhvYxBQ0iles3A4
X-Google-Smtp-Source: AGHT+IHnzdCZiWkeq6B0nWCC7+Ta7WqnE/RTfJHl80GUdwDwM+iInU4JzJQ1fseC0j68aNlkWHaYLC2Le5AdhB426tw=
X-Received: by 2002:a17:903:2310:b0:290:ad7a:bb50 with SMTP id
 d9443c01a7336-290ad7abe3amr60139775ad.27.1760691127941; Fri, 17 Oct 2025
 01:52:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 Oct 2025 14:21:56 +0530
X-Gm-Features: AS18NWDmy4VY4bYGS9Uinoj_a_bgUwsPBK0TlYzxtMKYza6ex6eRnnUZiu6_1_8
Message-ID: <CA+G9fYuF44WkxhDj9ZQ1+PwdsU_rHGcYoVqMDr3AL=AvweiCxg@mail.gmail.com>
Subject: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL: ioctl(pidfd,
 PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL: ENOTTY (25)
To: open list <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Andrey Albershteyn <aalbersh@kernel.org>, Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The LTP syscalls ioctl_pidfd05 test failed due to following error on
the Linux mainline
kernel v6.18-rc1-104-g7ea30958b305 on the arm64, arm and x86_64.

The Test case is expecting to fail with EINVAL but found ENOTTY.

Please investigate this reported regression.

First seen on v6.18-rc1-104-g7ea30958b305
Good: 6.18.0-rc1
Bad: 7ea30958b3054f5e488fa0b33c352723f7ab3a2a

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regressions: 6.18.0-rc1: LTP syscalls ioctl_pidfd05: TFAIL:
ioctl(pidfd, PIDFD_GET_INFO_SHORT, info_invalid) expected EINVAL:
ENOTTY (25)

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test error log
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_test.c:2021: TINFO: LTP version: 20250930
tst_test.c:2024: TINFO: Tested kernel: 6.18.0-rc1 #1 SMP PREEMPT
@1760657272 aarch64
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected
which might slow the execution
tst_test.c:1842: TINFO: Overall timeout per run is 0h 21m 36s
ioctl_pidfd05.c:45: TPASS: ioctl(pidfd, PIDFD_GET_INFO, NULL) : EINVAL (22)
ioctl_pidfd05.c:46: TFAIL: ioctl(pidfd, PIDFD_GET_INFO_SHORT,
info_invalid) expected EINVAL: ENOTTY (25)
Summary:
passed   1
failed   1

## Source
* Kernel version: 6.18.0-rc1
* Git tree: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
* Git describe: v6.18-rc1-104-g98ac9cc4b445
* Git commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
* Architectures: arm64, x86_64
* Toolchains: gcc-13 clang
* Kconfigs: defconfig+lkftconfig

## Build
* Test log: https://lkft.validation.linaro.org/scheduler/job/8495154#L15590
* Test details:
https://regressions.linaro.org/lkft/linux-mainline-master/v6.18-rc1-104-g98ac9cc4b445/ltp-syscalls/ioctl_pidfd05/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/34AVGrBMrEy9qh7gqsguINdUFFt
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/34AVFcbKDpJQfCdAQupg3lZzwFY/config

--
Linaro LKFT

