Return-Path: <linux-kernel+bounces-786073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60DECB354A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 08:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B5B93BE5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 06:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D5C274FFC;
	Tue, 26 Aug 2025 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pJQ4iuGp"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D9521D3D3
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 06:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756190163; cv=none; b=Iluo4AHHKavC3xBrRBnYja50er23DERFXisMvh+wg6xhieouYhTg4kVnIkMJlM9jq5ImCfEfweEeb1Wmch22N3FpMpfY6hsACPN/oL40L/iyS2BubRf0Sf4CDegn7+ONUoFtB/WGdb3IuGZ2fx8xBTVb5zRRS5lajxmXlyoM5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756190163; c=relaxed/simple;
	bh=2BqXMcZnoG8t6tVC4Nu0TiARTMl3Fi3Qmn7b0TTYb0s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=twDdpEhb1QTvRsfUFuLIwCkE6TDoHDHaIXSH0NM2rsqVH8bZ/VGRz+AQAcCRJMOScXmeEb/ROolethRG9eWJHkYXFoEycnwJr+MngDqeVnEtAtjB99FqYLAY7opPZnxuQAQtcb8z83YNNRzuKhtzHv8F3rvdVOsFShe3/YEslVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pJQ4iuGp; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b47174c3b3fso3116097a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 23:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756190161; x=1756794961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZCZJrCEqdKPb4Dv2x8k8eTvQ61vGgPIzxIHFjirYy9A=;
        b=pJQ4iuGpzl+/9WVGNqWob+MbEuWuxbMDHe05LXsFpAnKlkGkR7Y0nHNKU+SwnFWL+g
         kaljpOgOoVC6WtPsBEftB7NfRRcdyI6/ppLDiFATst28txGiwsY0MMqu+mdv3/hSAxoL
         JTgYDd/IqJ+GMJl+iZmneCDjzyoQBVG3nV2OErZfRQgBoBIAU2adTEJ5/xw7alqOUqwe
         8LxARAXGu3QsZZkPevYfpuzOx8rok84UbF2lmyFp/x3O6wO1j8TZTi5rrftW0r77IZJf
         16E+ZO33p944iWIaNGVt/HVcEWcwL3ORjKwYZ4xH4rD4Rn9Vl6nQt1Ot4HVzApoBkbp7
         ujFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756190161; x=1756794961;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCZJrCEqdKPb4Dv2x8k8eTvQ61vGgPIzxIHFjirYy9A=;
        b=vFFt3+FKZuIqmQvmqsFE9id7vmm5vvkVinb7PggOymZIo3WDrIbCjXrINCheQCBddL
         1QufHUHwRlxKRPPOnDN2zTJVC5Umie3ZVOPFRaNjGci4KpaNkOEHbVy61QW5bsa2/O1x
         dr75LMV6sieTgVpLykqcXE+kzL3997V3mGTFgCfmu54B7ThgSLmtAzs/KhefQ5pvaf8f
         4W/W7TlZ2PVCacQi9ZcBPd5lp0U+t8lxOeG/TN914E+bMCCBeuO6vt8lMhIS/bgfC7ha
         zceE5KxqBGc+SkUkcvmb9hntcMfg0bqzPsRmasdBeiQvcaS2j0o/4MDG+7eVwgy47CYv
         BTRA==
X-Forwarded-Encrypted: i=1; AJvYcCVG3cxCnhArFloy2hQ1NUnHVyosAzvGR21d/c593Xn0IeFwhKjbswC1fzMamh2cOm87MjSTq2eicLGCEzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySupem71huPFqkK43BVeLrF2INNk7E9c58Nlnv2E/pmNMzRsPw
	hpOjLFBYEeZwVdiqqqCgMKyikgmZjSlL3HCfhOMxSUuVGIaO1294AT2VvdwvlJE9lRaPUQmv8Gr
	uqOGwxQWHjtuL6c/RryChvubGHTAEivaG2KoglpdqDQ==
X-Gm-Gg: ASbGnctKvT1QUZg0Dg3nvJZUUXskDWAJ8+Mkzcgm67FLOwGsh4/8ZkY+SsQFOaXpYNO
	dUeib7DAyEj84nF57DEc5IyzQ+S4Uc8JCqBM7TikzOfeeeH1jMrEUYCusl1zWMAXKXqkr51MLWf
	BeIdc7nR83h2Ec+A2XPot/Z5I7Ju9zuHIqriGsPTS5+Q44AyKaymKkydRQ3RAQvirV4Ue97m1Op
	tS58e/vGiu3etXrAb9JbcAcf8LhKhUf3ljsL3o=
X-Google-Smtp-Source: AGHT+IEQn4WiuIgZyEMURTgqGtjunWBRbpXl5so57HtpTznUyYEK7Ey9gxQd0qtxzwA+AVUwTTM+dZG94+sYVO8I9HM=
X-Received: by 2002:a17:902:f64b:b0:246:7a43:3f82 with SMTP id
 d9443c01a7336-2467a4378cbmr141502145ad.45.1756190159816; Mon, 25 Aug 2025
 23:35:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 26 Aug 2025 12:05:48 +0530
X-Gm-Features: Ac12FXyuAWdifk3AbEFJtNbFPLOMAyfmI2knp7BoLYQE5klP6No3TL9rR5qjI0I
Message-ID: <CA+G9fYuR9auMS=hg9Ri+A2SeCQ0jHkW7mN3k9RDG66vE5cfJdQ@mail.gmail.com>
Subject: next-20250825: arc: seqlock.h:876:2: error: implicit declaration of
 function 'spin_lock' [-Werror=implicit-function-declaration]
To: Linux-Arch <linux-arch@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The following build warnings / errors noticed with arc defconfig with
gcc-9 toolchain.

Regression Analysis:
- New regression? yes
- Reproducibility? yes

Build regression: next-20250825 arc seqlock.h:876:2: error: implicit
declaration of function 'spin_lock'
[-Werror=implicit-function-declaration]

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

arc:
  build:
    * gcc-9-allnoconfig
    * gcc-9-tinyconfig
    * gcc-9-vdk_hs38_smp_defconfig
    * gcc-9-defconfig
    * gcc-9-axs103_defconfig

## Build log
In file included from include/linux/mmzone.h:17,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from arch/arc/include/asm/arcregs.h:149,
                 from arch/arc/include/asm/irqflags-arcv2.h:9,
                 from arch/arc/include/asm/irqflags.h:13,
                 from include/linux/irqflags.h:18,
                 from include/linux/spinlock.h:59,
                 from include/linux/sched.h:37,
                 from arch/arc/kernel/asm-offsets.c:6:
include/linux/seqlock.h: In function 'write_seqlock':
include/linux/seqlock.h:876:2: error: implicit declaration of function
'spin_lock' [-Werror=implicit-function-declaration]
  876 |  spin_lock(&sl->lock);
      |  ^~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock':
include/linux/seqlock.h:890:2: error: implicit declaration of function
'spin_unlock' [-Werror=implicit-function-declaration]
  890 |  spin_unlock(&sl->lock);
      |  ^~~~~~~~~~~
include/linux/seqlock.h: In function 'write_seqlock_bh':
include/linux/seqlock.h:902:2: error: implicit declaration of function
'spin_lock_bh' [-Werror=implicit-function-declaration]
  902 |  spin_lock_bh(&sl->lock);
      |  ^~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock_bh':
include/linux/seqlock.h:917:2: error: implicit declaration of function
'spin_unlock_bh' [-Werror=implicit-function-declaration]
  917 |  spin_unlock_bh(&sl->lock);
      |  ^~~~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_seqlock_irq':
include/linux/seqlock.h:929:2: error: implicit declaration of function
'spin_lock_irq' [-Werror=implicit-function-declaration]
  929 |  spin_lock_irq(&sl->lock);
      |  ^~~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock_irq':
include/linux/seqlock.h:943:2: error: implicit declaration of function
'spin_unlock_irq'; did you mean 'write_sequnlock_irq'?
[-Werror=implicit-function-declaration]
  943 |  spin_unlock_irq(&sl->lock);
      |  ^~~~~~~~~~~~~~~
      |  write_sequnlock_irq
include/linux/seqlock.h: In function '__write_seqlock_irqsave':
include/linux/seqlock.h:950:2: error: implicit declaration of function
'spin_lock_irqsave' [-Werror=implicit-function-declaration]
  950 |  spin_lock_irqsave(&sl->lock, flags);
      |  ^~~~~~~~~~~~~~~~~
include/linux/seqlock.h: In function 'write_sequnlock_irqrestore':
include/linux/seqlock.h:981:2: error: implicit declaration of function
'spin_unlock_irqrestore'; did you mean 'write_sequnlock_irqrestore'?
[-Werror=implicit-function-declaration]
  981 |  spin_unlock_irqrestore(&sl->lock, flags);
      |  ^~~~~~~~~~~~~~~~~~~~~~
      |  write_sequnlock_irqrestore
In file included from include/linux/sched.h:15,
                 from arch/arc/kernel/asm-offsets.c:6:
include/linux/rcupdate.h: In function 'rcu_read_lock_sched_held':
include/linux/preempt.h:227:49: error: implicit declaration of
function 'irqs_disabled' [-Werror=implicit-function-declaration]
  227 | #define preemptible() (preempt_count() == 0 && !irqs_disabled())
      |                                                 ^~~~~~~~~~~~~
                          ^
cc1: some warnings being treated as errors

## Source
* Kernel version: 6.17.0-rc3-next-20250825
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Git describe: next-20250825
* Git commit: 6c68f4c0a147c025ae0b25fab688c7c47964a02f
* Architectures: arc
* Toolchains: gcc-9
* Kconfigs: defconfig

## Build
* Build log: https://qa-reports.linaro.org/api/testruns/29652436/log_file/
* Build details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250825/build/gcc-9-defconfig/
* Build error details:
https://regressions.linaro.org/lkft/linux-next-master/next-20250825/log-parser-build-gcc/gcc-compiler-include_asm-generic_getorder_h-error-implicit-declaration-of-function-ilog/
* Build plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/31lrYki7MzYyqtJKnutAe2oawoq/config

--
Linaro LKFT
https://lkft.linaro.org

