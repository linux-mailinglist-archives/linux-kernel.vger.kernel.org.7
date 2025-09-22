Return-Path: <linux-kernel+bounces-827720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85106B9287B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 20:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64776188604F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 18:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7074331815E;
	Mon, 22 Sep 2025 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ejNO6fyM"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC7D1448E0
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758564009; cv=none; b=dukWj61OrVH4LBf/1xVwr12B3Dhk7+1MYF8gmlG+zDJYvnlmx7fQMJMkjj5uOzorB5SFoA3wKsXt2hkMYj/C8eYmmfsDR04PyvTM27X64OBkcFI05G2K8guP0U/1bmmpNvRsQeyQGuJmnahtpp+nybNrurs56/3tPgedX29SkL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758564009; c=relaxed/simple;
	bh=LyFQcvfyyUbzuum2T68G+X8Y3wIlSo94RVd3tQx/fGM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ljscv89xT/7pGlpCV0BGgRVHf1TKU7omDDFHtXCzEGrVNkwuxueRqEOR0+25vlp2aQ/JFyBl1PLhQK6A836/nzPNK6ztCaz+rN1NJfvj3LZmikpx+AmFeZUNGcBIx3EyC7uGAQ4DoYJKOklrvFt00+wLhXpDe/XktA2Js7vQER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ejNO6fyM; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24456ce0b96so52376595ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 11:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758564007; x=1759168807; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3tEHA5BGFi0qZLtSrmyzVuEmtCHCJP0b4IMQl2NugYg=;
        b=ejNO6fyMG1TefMeW+Yk1y+DvbznEVcCymeueZji9FlK//DthB9ujzXgA+iPi1G4zdg
         prasP8NzIOUOuLryCki+rKXTfGP9rnPYSM9pDsDM8qunf+6pgj2+QW83unbHsXapYzO1
         CqV68znemYb75p5ZOzSlZgM/L/4BL0IR9AC54zD3i82fCN/OOOHIQy2amNLgsp7N4ipZ
         WLPoDVgBXTt3fP0PB+aENNdpCoADQa9GIjl3yrl1w2sj3jwHWRoMU94jYRu3yZ0DXa1D
         brARYu2ZumvGb7WG42R8VF1UufuaUxnaz7UGJl49fFR/Na/pgXHCpP6Y7qmvASz49Eb5
         mt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758564007; x=1759168807;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3tEHA5BGFi0qZLtSrmyzVuEmtCHCJP0b4IMQl2NugYg=;
        b=M79/G2k2/qUsarrNBZdJJ1VN25pz4g0XTi7ko0DA9YDSdREkN9E1oXpOM+pK9xONy2
         tBrgm2GpwZLVECgAQuJmWHUzHJSRjRfd3eobQKVbiKT9ZLc4TjzMwGQkGHoysFItpJmT
         Oz8cYdxAOUQ0/FddES8jmiIgX9c+/+xegRsQxCTYekmM6xl1lq3j4g9dL8FurNp9K3Lo
         C3WZPAocohOnrT9hZFBPAYSaCeEGwqUMkc+HkbOhaxRAZdoY4HHk4bc0hBdktpdhpW1M
         sl74u73ULX/ce5u33K9uEacBroYBf8yU1NCnG8InLq1N/1hmRwr8d3K8kVqcZyu9iW+m
         XExA==
X-Forwarded-Encrypted: i=1; AJvYcCXChnUw0uhPiNetZ96KfuuVF1BeAgJJBDMTMFvODI49pzG+M+UpKu/A6DunzvktQne+BOeLAqaQmsfreQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCVpBh/5P6TyYKrLZlchWiKeOyK2Im0jDfMnZnBQmTQiMzvVTm
	IQFiZEUoSXZNb7Rf8zBr0alM1eU/eEhmLaROWOMLEv/Jel21WdDtQI9yAc3ND527CtDw7cgMOAW
	OcIfDbn/huH9OQkMXTelOQvWG4ID6lj2KX4hzzWBvnA==
X-Gm-Gg: ASbGnctzbW3xOddZavuPJyTdZGuCJA+KhN/C2tl56tkD6Yn0wgtuxg+gec+N/aagCwE
	T6IXQxl0/e1++OBc+ENholiTQmix5Fk9pZOP8NjpMRQEIpMzDkRhShoiO34TtlZ+ahpO/3Ogj9L
	fe7kJPF/GcpEFMn6iUnSPRNkQegjHNSgQ02lynGBo3Jl2h/W+FRJY3VRoRoFeq9FYy4g4/OJ2JB
	4EzeZdhjQnKu5rf1eJcmSbpTE+SrathMdAuWPsm
X-Google-Smtp-Source: AGHT+IHnq0rLb8m5TMIAGXGLN0gHFwtTPEoJOMo0Qxa07UPXisa8PfZthBdHiar633sbMLp+TiDunSqrb9HsyhZzMag=
X-Received: by 2002:a17:903:98d:b0:272:a227:245b with SMTP id
 d9443c01a7336-272a2274fc9mr102985765ad.17.1758564006785; Mon, 22 Sep 2025
 11:00:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Mon, 22 Sep 2025 23:29:53 +0530
X-Gm-Features: AS18NWDZwi1AO6kqN91ksL9x8G8Q2hcf5hfKdURyXPsi-NfZZp3RQHelXSAMyc8
Message-ID: <CA+G9fYvq732po6A=X=1Bm_zLZMAK50y+8sEToWVm38uQfOke1Q@mail.gmail.com>
Subject: next-20250922: arm riscv32 flexfilelayout.c:685:2: error:
 incompatible pointer types passing 'u32 *'
To: linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, clang-built-linux <llvm@lists.linux.dev>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
	Anna Schumaker <anna.schumaker@oracle.com>, Jonathan Curley <jcurley@purestorage.com>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

The arm and riscv32 builds failed on the Linux next-20250922 tag build due
to following build warnings / errors with clang toolchain.

First seen on next-20250922
Good: next-20250919
Bad: next-20250922

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Test regression: next-20250922: arm riscv32 flexfilelayout.c:685:2:
error: incompatible pointer types passing 'u32 *'

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Build error

fs/nfs/flexfilelayout/flexfilelayout.c:685:2: error: incompatible
pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of
type 'uint64_t *' (aka 'unsigned long long *')
[-Wincompatible-pointer-types]
  685 |         do_div(mirror_idx, flseg->mirror_array[0]->dss_count);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
include/asm-generic/div64.h:199:22: note: expanded from macro 'do_div'
  199 |                 __rem = __div64_32(&(n), __base);       \
      |                                    ^~~~
arch/arm/include/asm/div64.h:24:45: note: passing argument to parameter 'n' here
   24 | static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
      |                                             ^


## Source
* Kernel version: 6.17.0-rc7
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: 6.17.0-rc6-next-20250922
* Git commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
* Architectures: arm riscv32
* Toolchains: Debian clang version 20.1.8
* Kconfigs: lkftconfigs

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29967175/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250922/log-parser-build-clang/clang-compiler-fs_nfs_flexfilelayout_flexfilelayout_c-error-incompatible-pointer-types-passing-u-aka-unsigned-int-to-parameter-of-type-uint_t-aka-unsigned-long-long/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/333IdxAGk8S0TDZQ0YbgzNOtKgs
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/333IdxAGk8S0TDZQ0YbgzNOtKgs/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/333IdxAGk8S0TDZQ0YbgzNOtKgs/config

--
Linaro LKFT

