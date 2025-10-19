Return-Path: <linux-kernel+bounces-859539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7EFBEDEDF
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5A1E734A4FE
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B86218AA0;
	Sun, 19 Oct 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf0RFGYB"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A98DA1A9FAF
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 06:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760854612; cv=none; b=S8z56/cjxTsG3O46N2mHpFC4aksGEkofD1aCdwHADvUhwPUHSAV6TcmpfJEhR3dRvJpc3VfZDMfUCSvz5zphqNO+liW6Wf5eXSFE5JKTbyWmUun21Unj1ZOBdsbu1Ltj66/XTISplvngndgU1r3fiD7Yw83Q7S3gsXKs0VjUUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760854612; c=relaxed/simple;
	bh=8tPUwbgp84z06Ha3YgOJe3L7npMTaAqF03hIvrPZnSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ng2pWtFJK8mhHCXXKj58W7ach0DOrnwwSzbd1ChhX4h+KeK+6yE13hqQ8CirbX93mUJnEmzUjfBA/apf+/aTf81FPXJFqgZY4NUe38zIe4de+qQVyNwXTRl9Mg08qUVan+OtKwCe+eoayIvrP1KkJBmHxp/D1pJa/afjDbQKvuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf0RFGYB; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7811a02316bso2281463b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 23:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760854608; x=1761459408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZRMP2OfxaTGj9Ba3u31wGuIf4ugyC10QC83Sd0wi7Ek=;
        b=Tf0RFGYBhSVgvAvj/Qm+D98C5HKmfFu4fni4tKQjKxi3wjuKbsh5gDDgSACJfS74u8
         Uu9KKfSdZ4R7KHWVzqxdhUDqpqI44scMcBVM/SY0g7akIMYKl+b4+xbXLI4deKhfZ3uT
         mAYRIHoO1dKDqpQL6pljUlCtOf8/LlAF35M91h0UiPC+vQWDPNX7horDH9Bv8ARsR/gN
         HYBWOt4bMEg9gXURLl4EytfGGA893US6IRhIABfyzJdfa+sTjxt6oeA47xWQrwi0Vajc
         UsQq209dhsPNewzkn8TLwTwYVF02WMS8Ky7tx1y1yAvczR5qSgWVrW+OgMx1VLRepZli
         g3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760854608; x=1761459408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRMP2OfxaTGj9Ba3u31wGuIf4ugyC10QC83Sd0wi7Ek=;
        b=RsgVkqvGptzcvRCozYrlldPf5GLLJmZ3aZJDASgqsTwAuUa2CjqGWD/U1QTPrt9e5E
         1YCcZSzUG09UFARxajohliFh2gWpaklvgWgmBLnkNc/+ZLYjqj7FwMrmArDlH6hjLZs+
         n21ssevf7j5wrHvNJ4S6fhVfsz4e0VV4fS9R/TgCYtRW1cLU/SSWhsdemrmSnGEyN4nJ
         ecdRm079H+BWDU53FbIRlKzh2xFlTE0trPmHXHKaI5Mn1L0dgYxRx9lbu7cVZHTvysQl
         bp5KYwIQ++03GVzUYoQTNZxwStZWdn/9K3RfXb4jFKgWhJlsXkm556cbMfS0XlvR48wT
         NqTw==
X-Gm-Message-State: AOJu0YzWZUqN+XHQIL8TgUH6hIh8Fghqpu7JQnX/ylIKaOE/TIXG3ng9
	SSTqWA4nYZSOnaSUvBDh5MkUfWqQ7Wk3jm2FOTDjxJVNQxFgnWWNN5SonlSa9Q==
X-Gm-Gg: ASbGncvRBVZcTGdoV5y19xM2V5+QR+qZ3mU8Dk2NHOTE/1SXhi1X7325WKbuYfVFLA/
	aj/2qF7rVxhihZkM/24hsfUdWq5x+oQwJYZKZcdaRHIxl66m1xaETPAZjYzBv7wXYVAsRu64Y+/
	nflB1631+YpRoGyA+nxEOdfiz0EW5H/USH4rDZwb0ebF+XoliJbsmfncvIIRhbgj/BxSfr4wNFA
	VD1cJ8WbdwKUBjqtQEYfCRiC7eRmfSIyScImbMZxc2TjlFJ2ErVYcHJPs77hBho0UppIAWaT9Jb
	G41J1v1dGdhgcjcyz+LlKjdXVIuMChkAlIfePzu7cQ9rzgvuS1tcShVLYzEpbUkxGpDRJv+MdfO
	qZFlzawUl+2h3i7scNYzdQF0BT41nZ/WY0ZvS2V/YsSNZmrZpkxUyh47PZ1TxwZpg+u/8aKFZKc
	ZnB80u
X-Google-Smtp-Source: AGHT+IGp4+Ph5e3LiXV7d0GmlI+i90WYkt6QaEte4wvTDN2FV/GISN5U6pAGNJ2hvtEGZmBPXg14lg==
X-Received: by 2002:a05:6a20:6a1e:b0:334:9b5d:3873 with SMTP id adf61e73a8af0-334a85d9eedmr11700112637.31.1760854608328;
        Sat, 18 Oct 2025 23:16:48 -0700 (PDT)
Received: from pop-os.. ([2601:647:6881:9060:bc87:d8fe:3e55:7ffb])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b6f302sm4332032a12.38.2025.10.18.23.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 23:16:47 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: jiri@resnulli.us,
	stefanha@redhat.com,
	multikernel@lists.linux.dev,
	pasha.tatashin@soleen.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Mike Rapoport <rppt@kernel.org>,
	Changyuan Lyu <changyuanl@google.com>,
	kexec@lists.infradead.org,
	linux-mm@kvack.org
Subject: [RFC Patch v2 00/16] kernel: Introduce multikernel architecture support
Date: Sat, 18 Oct 2025 23:16:14 -0700
Message-Id: <20251019061631.2235405-1-xiyou.wangcong@gmail.com>
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
- Better resource utilization than traditional VM (KVM, Xen etc.)
- Better performance than containers without noisy neighbor issues
- Improved fault isolation between different kernels
- Potential zero-down kernel update with KHO (Kernel HandOver)

Architecture Overview:
The implementation leverages kexec infrastructure to load and manage
multiple kernel images, with each kernel instance assigned to specific
CPU cores. Inter-kernel communication is facilitated through a dedicated
IPI framework that allows kernels to coordinate and share information
when necessary.

Key Components:
1. Enhanced kexec subsystem with dynamic kimage tracking
2. Generic physical memory allocation for multikernel and kernel
   instances
3. Multikernel-specific kernfs for managing kernel instances
4. Device-tree based mechanism for static resource allocation
5. Device-tree overlay based mechanism for dynamic resource allation
6. KHO based mechanism for device-tree sharing between kernels
7. Generic IPI communication framework for inter-kernel messaging
8. Proc interface (/proc/kimage) for monitoring loaded kernel images

The implementation maintains full backward compatibility with existing
kexec functionality while adding the new multikernel capabilities.

For the complete roadmap, please see:
https://docs.google.com/document/d/1yneO6O6C_z0Lh3A2QyT8XsH7ZrQ7-naGQT-rpdjWa_g/

For the Proof-of-Concept demo (prior to device-tree), please see:
https://www.youtube.com/watch?v=bmC4JRTSDKE

For user-space components, especially device-tree specification, please check
kerf project: https://github.com/multikernel/kerf


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

Signed-off-by: Cong Wang <cwang@multikernel.io>

Changes since RFC V1:
- Switched from kexec_load() to kexec_file_load()
- Introduced generic multikernel physical memory allocation and per-instance
  virtual memory allocation
- Introduced kernfs interface for managing kernel instances
- Introduced device-tree and KHO framework for resource management and
  sharing
- Introduced messaging over IPI framework, preparing for dynamic
  resource allocation and zero-downtime upgrade
- Grouped multikernel code in the kernel/multikernel/ directory
- Reorganized and rebased all the patches

---

Cong Wang (16):
  kexec: Introduce multikernel support via kexec
  x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
  multikernel: Introduce basic multikernel subsystem infrastructure
  x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
  x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
  multikernel: Introduce physical memory reservation and allocation
  kexec: Implement dynamic kimage tracking
  multikernel: Introduce device-tree based kernfs interface
  kexec: Integrate multikernel instance management with kexec subsystem
  Documentation: Add multikernel usage
  kexec: Add /proc/kimage interface for kimage tracking
  multikernel: Introduce per-instance memory allocation interface
  kernel: Introduce generic multikernel IPI communication framework
  multikernel: Add messaging layer for inter-kernel communication
  kexec: Integrate multikernel support with kexec_file_load()
  multikernel: Integrate Kexec HandOver framework for DTB preservation

 Documentation/multikernel/usage.rst | 215 ++++++++
 arch/powerpc/kexec/crash.c          |   8 +-
 arch/x86/include/asm/idtentry.h     |   3 +
 arch/x86/include/asm/irq_vectors.h  |   1 +
 arch/x86/include/asm/smp.h          |   7 +
 arch/x86/kernel/Makefile            |   1 +
 arch/x86/kernel/crash.c             |   4 +-
 arch/x86/kernel/head64.c            |   5 +
 arch/x86/kernel/idt.c               |   3 +
 arch/x86/kernel/kexec-bzimage64.c   |  16 +-
 arch/x86/kernel/setup.c             |  11 +-
 arch/x86/kernel/smp.c               |  17 +
 arch/x86/kernel/smpboot.c           | 159 ++++++
 arch/x86/kernel/trampoline_64_bsp.S | 288 +++++++++++
 arch/x86/kernel/vmlinux.lds.S       |   6 +
 drivers/of/kexec.c                  |  20 +-
 include/linux/kexec.h               |  30 +-
 include/linux/kexec_handover.h      |  40 ++
 include/linux/multikernel.h         | 659 ++++++++++++++++++++++++
 include/uapi/linux/kexec.h          |   5 +
 include/uapi/linux/reboot.h         |   2 +-
 kernel/Kconfig.kexec                |   2 +
 kernel/Makefile                     |   1 +
 kernel/kexec.c                      |  60 ++-
 kernel/kexec_core.c                 | 384 ++++++++++++++
 kernel/kexec_file.c                 | 158 +++++-
 kernel/kexec_handover.c             | 197 ++++++-
 kernel/multikernel/Kconfig          |  26 +
 kernel/multikernel/Makefile         |   9 +
 kernel/multikernel/core.c           | 532 +++++++++++++++++++
 kernel/multikernel/dts.c            | 466 +++++++++++++++++
 kernel/multikernel/internal.h       |   4 +
 kernel/multikernel/ipi.c            | 471 +++++++++++++++++
 kernel/multikernel/kernfs.c         | 772 ++++++++++++++++++++++++++++
 kernel/multikernel/kho.c            | 356 +++++++++++++
 kernel/multikernel/mem.c            | 376 ++++++++++++++
 kernel/multikernel/messaging.c      | 278 ++++++++++
 kernel/reboot.c                     |  10 +
 38 files changed, 5572 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/multikernel/usage.rst
 create mode 100644 arch/x86/kernel/trampoline_64_bsp.S
 create mode 100644 include/linux/multikernel.h
 create mode 100644 kernel/multikernel/Kconfig
 create mode 100644 kernel/multikernel/Makefile
 create mode 100644 kernel/multikernel/core.c
 create mode 100644 kernel/multikernel/dts.c
 create mode 100644 kernel/multikernel/internal.h
 create mode 100644 kernel/multikernel/ipi.c
 create mode 100644 kernel/multikernel/kernfs.c
 create mode 100644 kernel/multikernel/kho.c
 create mode 100644 kernel/multikernel/mem.c
 create mode 100644 kernel/multikernel/messaging.c

-- 
2.34.1


