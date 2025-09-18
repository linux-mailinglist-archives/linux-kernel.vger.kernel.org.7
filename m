Return-Path: <linux-kernel+bounces-823699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3EABB87392
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8717B7E08A1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790192FB62F;
	Thu, 18 Sep 2025 22:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dCe0vWIF"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765C2288D5
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758234383; cv=none; b=PJxVWzZ8Uvk188Qu2hy8W8VMSl//l8jWcf0oB+Dv4pK0gB0LJwPmIPALp6mrT2RQ4TUexyYsfZYs75Vgwr/YHRVPdZ79o4GrEsdijAIgbKn2F65T9wA99qkLxGVR7ISxJMDnTA7U/aQxipvO/eM+ljElsvzvwvu4Dh2d4cDLChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758234383; c=relaxed/simple;
	bh=CrDDzKJgIhpKNCJQHnN/NwhER/rUFlHEqMizJicBMv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JN29++d8mvaB57yrSx8PkoeUuIKjgqlyDQIm2BXcSD9Dr/kqdJtAQ+ILlnIE5fiQJQ1oh/khLn49LkJV/Vf7MIco9w0brjgehkqTS3AhK8I2sqBpftnXN+sXA+atsdMDRQlPsj2skSSZ6QDPHsG67ApoUAMF7V1JFHBOEux3LOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dCe0vWIF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1528910b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 15:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758234380; x=1758839180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DbEPHi/FBJoBntQoKxRmObfSjuVxaXboS80M9e4IQLM=;
        b=dCe0vWIFh4fJodsvno2eLxzT7M51S1bsyGzy0cJsZ/QxctDmggNBPXThELh9MIjZAz
         95f2OhZck/FTajOZky15Yf/wX5OdH1UC6p025OSVX7gaMj/9sR52xp63Jj5cVZDUC3DB
         qbelBCT+/Pws+YR9edOtzfdacmAoMlGSE2wJEF3sOdck5g1+qe+UZ7qUCd2m7vky1rFK
         fbDcjoNPc5TjAesd1uKdupd4b3P3zEqv3G4hgNz0ceNKP06VltB1/5cUp3Cl1YxqO0dN
         SWUU658JQWO8IghF/sJB3+1RX9y4EtzWP9KifCwHfLA5e67avW3hBpbkXge7/8cv5Z/8
         bmoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758234380; x=1758839180;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DbEPHi/FBJoBntQoKxRmObfSjuVxaXboS80M9e4IQLM=;
        b=uRydA3j/nOWhNdWpwn8f7+qzNrDS7Knxw99Jy52ZsXyEgirq9cShYYmElTjSUj0RzL
         mHwZ/MhiNfb/0c+GdEhmRa+2F5Mh1MhTZE0D/SLDC2K5F09GLLg2pwYq8r4GsOFC+k5U
         4QEQoad9gF+FJJpgYrMDw27b7/qVETu6BCPNGpJ//XBB19kneZCR9IjvoCVGKbSZRiTh
         pdkJ9d243D2W6rrLwL+5HZumOSM7DbH2tbQQ4pyiX/FoQEGo2XVuhdXUPlb3CyBuyod8
         BFDD3b3fPahrxDGu5I65UhRML4B6tidB1x6eevLMisEBSrMbfiSl3rLzvppK+vsDK5vu
         mFoQ==
X-Gm-Message-State: AOJu0Yx53jaf7P/FrNqMIQ+vca8Vb2bzlQ+3DCBEJ/QEG+N3/3syMezA
	WX9upGiWYQYoccwi+9VFTQVYd0ztNmk2smvYiAW55FpQlDMRmxa7nvTcYBzYpA==
X-Gm-Gg: ASbGncsVKx0Zkn8V4AsKal6jcvzHDc4vO6Ls/OB60jl6wy76ydtqxLKFHdECcNzM1ib
	0JWhzrwFBmC11QXkFkRmNt5AW5tK1OXOcCXxKvKf9tvdINdH9u7dNUXQcoOwSaPmJd8XGhWS2BF
	FrSSkq3JvA8kb/nQjAzO5mmMHUlolUeteL6QdiW0ZdsjqZo2Q+F3qb4i+WnuLvi0pJAxjhGu0kV
	ihcn6n59GhxJEO8RNrFTXdy64U2sy7BxksHpKszxCX8v/O0tES9HjCOQAfmB6zFeMLDnob+iY0U
	+hwHSUTi+DmOxgNqlzIAYLZxZ/YMSWCIhxolRtbIS+2J2nwAaVhoGc24D2Ad7bd2Lq3Ejhgoi8O
	AHoKzqVeThquF+b78AMrHJw2Kj3gbYXz9kqQc4TP3tt61OUk=
X-Google-Smtp-Source: AGHT+IG6nLv83h+1eeTVl7MZ7TPHJ+9naz9tMMEQEalz0Qo1qnLahXUNQcADDPcryvTTLERYOekvXA==
X-Received: by 2002:a05:6a00:190a:b0:76b:ec81:bcc9 with SMTP id d2e1a72fcca58-77e4eaad25amr1209704b3a.21.1758234379999;
        Thu, 18 Sep 2025 15:26:19 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:c5c1:2e33:6cf2:beed])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77e5fe6de75sm407542b3a.19.2025.09.18.15.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 15:26:19 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: pasha.tatashin@soleen.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
Date: Thu, 18 Sep 2025 15:25:59 -0700
Message-Id: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces multikernel architecture support, enabling
multiple independent kernel instances to coexist and communicate on a
single physical machine. Each kernel instance can run on dedicated CPU
cores while sharing the underlying hardware resources.

The multikernel architecture provides several key benefits:
- Improved fault isolation between different workloads
- Enhanced security through kernel-level separation
- Better resource utilization than traditional VM (KVM, Xen etc.)
- Potential zero-down kernel update with KHO (Kernel Hand Over)

Architecture Overview:
The implementation leverages kexec infrastructure to load and manage
multiple kernel images, with each kernel instance assigned to specific
CPU cores. Inter-kernel communication is facilitated through a dedicated
IPI framework that allows kernels to coordinate and share information
when necessary.

Key Components:
1. Enhanced kexec subsystem with dynamic kimage tracking
2. Generic IPI communication framework for inter-kernel messaging
3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
4. Proc interface for monitoring loaded kernel instances

Patch Summary:

Patch 1/7: Introduces basic multikernel support via kexec, allowing
           multiple kernel images to be loaded simultaneously.

Patch 2/7: Adds x86-specific SMP INIT trampoline for bootstrapping
           CPUs with different kernel instances.

Patch 3/7: Introduces dedicated MULTIKERNEL_VECTOR for x86 inter-kernel
           communication.

Patch 4/7: Implements generic multikernel IPI communication framework
           for cross-kernel messaging and coordination.

Patch 5/7: Adds arch_cpu_physical_id() function to obtain physical CPU
           identifiers for proper CPU management.

Patch 6/7: Replaces static kimage globals with dynamic linked list
           infrastructure to support multiple kernel images.

Patch 7/7: Adds /proc/multikernel interface for monitoring and debugging
           loaded kernel instances.

The implementation maintains full backward compatibility with existing
kexec functionality while adding the new multikernel capabilities.

IMPORTANT NOTES:

1) This is a Request for Comments (RFC) submission. While the core
   architecture is functional, there are numerous implementation details
   that need improvement. The primary goal is to gather feedback on the
   high-level design and overall approach rather than focus on specific
   coding details at this stage.

2) This patch series represents only the foundational framework for
   multikernel support. It establishes the basic infrastructure and
   communication mechanisms. We welcome the community to build upon
   this foundation and develop their own solutions based on this
   framework.

3) Testing has been limited to the author's development machine using
   hard-coded boot parameters and specific hardware configurations.
   Community testing across different hardware platforms, configurations,
   and use cases would be greatly appreciated to identify potential
   issues and improve robustness. Obviously, don't use this code beyond
   testing.

This work enables new use cases such as running real-time kernels
alongside general-purpose kernels, isolating security-critical
applications, and providing dedicated kernel instances for specific
workloads etc..

Signed-off-by: Cong Wang <cwang@multikernel.io>

---

Cong Wang (7):
  kexec: Introduce multikernel support via kexec
  x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
  x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
  kernel: Introduce generic multikernel IPI communication framework
  x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
  kexec: Implement dynamic kimage tracking
  kexec: Add /proc/multikernel interface for kimage tracking

 arch/powerpc/kexec/crash.c          |   8 +-
 arch/x86/include/asm/idtentry.h     |   1 +
 arch/x86/include/asm/irq_vectors.h  |   1 +
 arch/x86/include/asm/smp.h          |   7 +
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/crash.c             |   4 +-
 arch/x86/kernel/head64.c            |   5 +
 arch/x86/kernel/idt.c               |   1 +
 arch/x86/kernel/setup.c             |   3 +
 arch/x86/kernel/smp.c               |  15 ++
 arch/x86/kernel/smpboot.c           | 161 +++++++++++++
 arch/x86/kernel/trampoline_64_bsp.S | 288 ++++++++++++++++++++++
 arch/x86/kernel/vmlinux.lds.S       |   6 +
 include/linux/kexec.h               |  22 +-
 include/linux/multikernel.h         |  81 +++++++
 include/uapi/linux/kexec.h          |   1 +
 include/uapi/linux/reboot.h         |   2 +-
 init/main.c                         |   2 +
 kernel/Makefile                     |   2 +-
 kernel/kexec.c                      | 103 +++++++-
 kernel/kexec_core.c                 | 359 ++++++++++++++++++++++++++++
 kernel/kexec_file.c                 |  33 ++-
 kernel/multikernel.c                | 314 ++++++++++++++++++++++++
 kernel/reboot.c                     |  10 +
 24 files changed, 1411 insertions(+), 19 deletions(-)
 create mode 100644 arch/x86/kernel/trampoline_64_bsp.S
 create mode 100644 include/linux/multikernel.h
 create mode 100644 kernel/multikernel.c

-- 
2.34.1


