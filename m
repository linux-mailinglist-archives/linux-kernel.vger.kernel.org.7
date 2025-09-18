Return-Path: <linux-kernel+bounces-822080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F78B82FA7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 539A04E1C47
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 05:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A102C234A;
	Thu, 18 Sep 2025 05:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpZWyN3L"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5302C08C4
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758172617; cv=none; b=TGyVvxB4Aj0+Nypt7PWKSzNFoih0xEZXN9t1+TQHGqD3y7DTmos7+sWzhHegP3av45HS4JdzxcZ5nDdbD+Awl0lmUysyxlfTJ4JngcLC7tJxiVe6AmbDsH5zp2MfymLwBVTsN9olUnAwJwQ9I5SpiTliob307dYoV9so/8r5d0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758172617; c=relaxed/simple;
	bh=YthZjy/Hv5hqKNtjIRhLrTfxuO/N5yUqpo/LnhhO6o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJx3aOuKeyQ8F3AW0qYuZ6m+/GWfVFzD9Y68O4jv9OAtJtLUHqymEF37v0OV4GU0mwgCd7iPsIJa4K1PrkpTRTSdH1UpFr7oBi1RYfh+yoqDYYG356EaoecvgSIBlZ1aYuIQU0yxWoyJR0Va9pXKHFx/p5m1piaMeymQCFAaXc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpZWyN3L; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77da29413acso11243b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 22:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758172615; x=1758777415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=BpZWyN3L3yY3x1NiUqyvfpYjDp5ycOEUaWMuNRzM/fbQoFtjkTsvRtLRmS9Y5VuptN
         H4L9W2sb4SzIrtqpQyYk9aIFke0czyxpf1/dn9TwFaZT0TNSziPaF8ln5qNOLgPPuReY
         I9ZBaf0T+vq41Nap/IG61SfRxkuB5QpPbLIZdZ/KYvuBo4jVhcHebMTknQLn7VE+amZA
         cDYXFRmHR1ydrcHHfuiE6XPo9fUzUi4KHN+vdvM2J0hMBTjpRbd4Z1CWj+07dpJLabwv
         SsQI7JyvMAoBXiGiuMsA8R5LERquvPsnQ4tQfwfUT69mnFTFgeXuu1pPQ+E9xZjguV6k
         UUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758172615; x=1758777415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=r0wlu5EFR+3YfnB1zMAuS0/2w5e6/JVMXnFcVuNQUbIlWhnDDjN3FGKzKS1EQ3Sniz
         bQxF2hvCVw2qenpozVT3kjcpd/6IozUvgFdxhvJeqwVWiBmHHINFKoUhyKSMsShtnKZQ
         4/SlUqmzcCztJeRsizLk18U15RwJ/O6dtuD0qPZb9isV0cd3pFrhiM29PDoK7j8qbDko
         0FXtdw6GjBWDfwzEHHqQAMa6NPHWZV45/jt9vGyZwAjWUcGFhlbYO2r9qnWthzmfQAMV
         7CBfzx8WQvewG7sAwoW4VVpXSIPGKEJRetVycDF0KHuIZX23BLfNDB4YfVcdvGgX3rzU
         n16A==
X-Forwarded-Encrypted: i=1; AJvYcCXlev/7SB5cKPRfIA55pReQ+lypfa8sJX+LiHuQLqLj1QmG9OaNyWR/l1jLnjy6+j6MAJHzTtB5GQSJ+aM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDhpQ2djTFCBUs9NXJxMH2x1YouneiHkZJY1cM8VIw+cyAsst
	NAqmw0qFym0ZSGhCf69qQ18swl+8ex2ZY5ZSJVs+b+ERNyUhzURBcBu1
X-Gm-Gg: ASbGncuyjaj04cYMZklC+XspN4n/DlGyzMjNKrIHWZzDQK58X4/xpKZypny+w780Jh9
	RtYZ1Quh/NymrtL0ATExTXKfkJpyZJwXfC2XmSfwvB+/IP63iJPJtbHsuG0H9YqbzUI9EwLYuO/
	Z/FIymg6M9KW69PRoznIdiPiA8FjGHBhy+65IRkbvva/RFJOZ1WH7fuDtZbE29lbI7Z4Bwwo+dT
	jNsiM06EEHEy7l6HXB0M7w/iASMuZaUDPMT8AWi2ukR5tFboiloI+5Xv/BQ0HEwBjqA/V0XBzXx
	wbSKBBww//n6ynqVuag54bUeJXpuYwJQpzBPTBE03T+mEyUxvxzoUuKxK/Of6n8dUSpROYNbPaI
	ROHclCdf22e2ujTw9OGEOzvJ7seYM6/O0235lU44AAEloEQEwvgXl5jWLn9+reApMq7JJTyYKVn
	8eClboJJQO9aE=
X-Google-Smtp-Source: AGHT+IEE5bhAXGPg0At7G00mXMtBGsn7rVxTHuZFoiN+K+q3D4zlIFK5OGVWVsR6FWUseoB/IlYZgw==
X-Received: by 2002:a05:6a00:189d:b0:776:9d99:e3f1 with SMTP id d2e1a72fcca58-77bf9856e7cmr5252403b3a.26.1758172614565;
        Wed, 17 Sep 2025 22:16:54 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfc2490dcsm1109998b3a.36.2025.09.17.22.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 22:16:53 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 378A01061EFB; Thu, 18 Sep 2025 14:16:52 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v11 13/14] um: nommu: add documentation of nommu UML
Date: Thu, 18 Sep 2025 14:16:06 +0900
Message-ID: <16a6c1233ec249e1bd32ad1aca36b0e1e396e1b0.1758171893.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758171893.git.thehajime@gmail.com>
References: <cover.1758171893.git.thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds an initial documentation for !MMU mode of UML.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 Documentation/virt/uml/nommu-uml.rst | 180 +++++++++++++++++++++++++++
 MAINTAINERS                          |   1 +
 2 files changed, 181 insertions(+)
 create mode 100644 Documentation/virt/uml/nommu-uml.rst

diff --git a/Documentation/virt/uml/nommu-uml.rst b/Documentation/virt/uml/nommu-uml.rst
new file mode 100644
index 000000000000..f049bbc697d1
--- /dev/null
+++ b/Documentation/virt/uml/nommu-uml.rst
@@ -0,0 +1,180 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+UML has been built with CONFIG_MMU since day 0.  The patchset
+introduces the nommu mode on UML in a different angle from what Linux
+Kernel Library tried.
+
+.. contents:: :local:
+
+What is it for ?
+================
+
+- Alleviate syscall hook overhead implemented with ptrace(2)
+- To exercises nommu code over UML (and over KUnit)
+- Less dependency to host facilities
+
+
+How it works ?
+==============
+
+To illustrate how this feature works, the below shows how syscalls are
+called under nommu/UML environment.
+
+- boot kernel, install seccomp filter if ``syscall`` instructions are
+  called from userspace memory based on the address of instruction
+  pointer
+- (userspace starts)
+- calls ``vfork``/``execve`` syscalls
+- ``SIGSYS`` signal raised, handler calls syscall entry point ``__kernel_vsyscall``
+- call handler function in ``sys_call_table[]`` and follow how UML syscall
+  works.
+- return to userspace
+
+
+What are the differences from MMU-full UML ?
+============================================
+
+The current nommu implementation adds 3 different functions which
+MMU-full UML doesn't have:
+
+- kernel address space can directly be accessible from userspace
+  - so, ``uaccess()`` always returns 1
+  - generic implementation of memcpy/strcpy/futex is also used
+- alternate syscall entrypoint without ptrace
+- alternate syscall hook
+  - hook syscall by seccomp filter
+
+With those modifications, it allows us to use unmodified userspace
+binaries with nommu UML.
+
+
+History
+=======
+
+This feature was originally introduced by Ricardo Koller at Open
+Source Summit NA 2020, then integrated with the syscall translation
+functionality with the clean up to the original code.
+
+Building and run
+================
+
+::
+
+   make ARCH=um x86_64_nommu_defconfig
+   make ARCH=um
+
+will build UML with ``CONFIG_MMU=n`` applied.
+
+Kunit tests can run with the following command::
+
+   ./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_MMU=n
+
+To run a typical Linux distribution, we need nommu-aware userspace.
+We can use a stock version of Alpine Linux with nommu-built version of
+busybox and musl-libc.
+
+
+Preparing root filesystem
+=========================
+
+nommu UML requires to use a specific standard library which is aware
+of nommu kernel.  We have tested custom-build musl-libc and busybox,
+both of which have built-in support for nommu kernels.
+
+There are no available Linux distributions for nommu under x86_64
+architecture, so we need to prepare our own image for the root
+filesystem.  We use Alpine Linux as a base distribution and replace
+busybox and musl-libc on top of that.  The following are the step to
+prepare the filesystem for the quick start::
+
+     container_id=$(docker create ghcr.io/thehajime/alpine:3.20.3-um-nommu)
+     docker start $container_id
+     docker wait $container_id
+     docker export $container_id > alpine.tar
+     docker rm $container_id
+
+     mnt=$(mktemp -d)
+     dd if=/dev/zero of=alpine.ext4 bs=1 count=0 seek=1G
+     sudo chmod og+wr "alpine.ext4"
+     yes 2>/dev/null | mkfs.ext4 "alpine.ext4" || true
+     sudo mount "alpine.ext4" $mnt
+     sudo tar -xf alpine.tar -C $mnt
+     sudo umount $mnt
+
+This will create a file image, ``alpine.ext4``, which contains busybox
+and musl with nommu build on the Alpine Linux root filesystem.  The
+file can be specified to the argument ``ubd0=`` to the UML command line::
+
+  ./vmlinux ubd0=./alpine.ext4 rw mem=1024m loglevel=8 init=/sbin/init
+
+We plan to upstream apk packages for busybox and musl so that we can
+follow the proper procedure to set up the root filesystem.
+
+
+Quick start with docker
+=======================
+
+There is a docker image that you can quickly start with a simple step::
+
+  docker run -it -v /dev/shm:/dev/shm --rm ghcr.io/thehajime/alpine:3.20.3-um-nommu
+
+This will launch a UML instance with an pre-configured root filesystem.
+
+Benchmark
+=========
+
+The below shows an example of performance measurement conducted with
+lmbench and (self-crafted) getpid benchmark (with v6.17-rc5 uml/next
+tree).
+
+.. csv-table:: lmbench (usec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  select-10    ,0.5319,36.1214,24.2795,2.9174
+  select-100   ,1.6019,34.6049,28.8865,3.8080
+  select-1000  ,12.2588,43.6838,48.7438,12.7872
+  syscall      ,0.1644,35.0321,53.2119,2.5981
+  read         ,0.3055,31.5509,45.8538,2.7068
+  write        ,0.2512,31.3609,29.2636,2.6948
+  stat         ,1.8894,43.8477,49.6121,3.1908
+  open/close   ,3.2973,77.5123,68.9431,6.2575
+  fork+sh      ,1110.3000,7359.5000,4618.6667,439.4615
+  fork+execve  ,510.8182,2834.0000,2461.1667,139.7848
+
+.. csv-table:: do_getpid bench (nsec)
+  :header: ,native,um,um-mmu(s),um-nommu(s)
+
+  getpid , 161 , 34477 , 26242 , 2599
+
+(um-nommu(s) is with seccomp syscall hook, um-mmu(s) is SECCOMP mode,
+respectively)
+
+Limitations
+===========
+
+generic nommu limitations
+-------------------------
+Since this port is a kernel of nommu architecture so, the
+implementation inherits the characteristics of other nommu kernels
+(riscv, arm, etc), described below.
+
+- vfork(2) should be used instead of fork(2)
+- ELF loader only loads PIE (position independent executable) binaries
+- processes share the address space among others
+- mmap(2) offers a subset of functionalities (e.g., unsupported
+  MMAP_FIXED)
+
+Thus, we have limited options to userspace programs.  We have tested
+Alpine Linux with musl-libc, which has a support nommu kernel.
+
+supported architecture
+----------------------
+The current implementation of nommu UML only works on x86_64 SUBARCH.
+We have not tested with 32-bit environment.
+
+
+Further readings about NOMMU UML
+================================
+
+- NOMMU UML (original code by Ricardo Koller)
+ - https://static.sched.com/hosted_files/ossna2020/ec/kollerr_linux_um_nommu.pdf
diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d32..2bc267220b07 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26300,6 +26300,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


