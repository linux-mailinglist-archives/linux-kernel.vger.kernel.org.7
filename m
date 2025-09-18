Return-Path: <linux-kernel+bounces-822242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17758B835EC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B10987A47C7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFDE2F5333;
	Thu, 18 Sep 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7j2d32Q"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E108F2F3C21
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181176; cv=none; b=EZWoIuaSr4yDQMbc/Fba9Ndtmyld8K1j8JZQiS3+xWI+oDe2AhXmE0n7y7k1hmlQvylcepzeYVFyPHfRWNnuvukuuW/6goaRpuxLhSL3+I0N/uaBISmoXC5LGD4pQOC1t+O7Z+wB9rpl+K5Zvjl8ZE5dZaWYh6OyhyPZj+Y02mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181176; c=relaxed/simple;
	bh=YthZjy/Hv5hqKNtjIRhLrTfxuO/N5yUqpo/LnhhO6o0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l49zpb+YYsmgZe/6+jzHNSqwz59/l77onKYW95VQ1whgwkP+VBR1/KyQBJi1TW+yOc6QRoDWyNkglogEJrjElsHMzuVhTjGncbSMhtyvPST/hGeE7oCatZH+rh9+tDTaNdXU78kI8qoHBzSLhRZ//UPI2HyL92A0kQDoiLQmFSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7j2d32Q; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32e1c40ecb0so489143a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 00:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758181174; x=1758785974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=M7j2d32Qc9ieYPVDRlT72LnprXONgQf7fnUD6zt8lZZfCPlA+9nju4d3Z34Ik4lcd2
         5GyKt98K7WQ8Nh8iyoHKXCYswcLuMT5hu5EMO/ShGxpYreDSki58pKfqIwppSGtkrD8d
         hrAkqijjEhHa2COYkuScggn8oUIe/6l63GUjZndxe6MlnAsyTkW6hQ7SqPW+St37dBlK
         VHL98Q/OiZ+sMN7yUoi7Y+ZLW/4D6zKDvVxfNO4/KBwZ8CmzAxJlzmPbJef9mSsqROgF
         zoXbtOYzR5DTs8qT8XympCBxDZloUefiRLORfjQNzkY5NmDp/e6rBCX/WYT2z1iVsOtS
         EyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758181174; x=1758785974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7W9A+e/F06Vc82vlngwh7iXI86jVV5QL2Xi32VbEg8Q=;
        b=Qtb6gUvePW08eWRBoxmDFjuBqJj6D0wE6x0Htp6nJRG+OaTqJ74/51DPv1qAryWotL
         QwcqBWs5+HK684jdfkn6TkNYgACihkM+Fyq4ZS7/9dsQ1rEoV0l57LVzDbVDfdiuLJKT
         Y7xo9XYHDtVsW8sgQ+vP6huiszILfH5N1R9YjZ7u1zXgYdm8enF+w8dMkEheUTP74Sh1
         YbItm3D+YgwuqZCiIyzu68z72zwiQWak18XE7qKNePfnGsop0aniKYKv6LMJNkOFtbuF
         Dw8agQyjbTfpliXC8PzriQeewX1ZmUE1p8r4Zua1gVYT1QuY1TsZODq5supVfOZaOZUE
         ecxw==
X-Forwarded-Encrypted: i=1; AJvYcCU4xZzs0jzXsstcb1adMbpRmhWeX2yZ11qDm5MiwTNWHeIwpuRxJgv/AEvud3iZFZpl9MA/riVxGTn4HAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnHYdzDt9RHNPzbFJYRih5MkAYLbwH6+zmldM+dGGToku+glM3
	phkQfzd2s8/DW7We2y3F/KyqjyLaqtaZbEOqku6SFf4z7UYKIVlFYiFi
X-Gm-Gg: ASbGnct/oNS0ywBV8IVp0I7MUzYLcz9bZ5AliEfNBx6ns70maagSwmtlvWfsFb68jv1
	Vznpc5Eo1gcUf6yvbPyf5mPhWGXmWhGvCoeuhs/Yr09c1hTMElpXPHa+MJiYGwMGnJiZns38sUu
	Eq4qGZmG9JZg/G85WeNXL/mv2dV8nGnZKr4tdJjwN+b2Zj/mYQy21NFjnSYzN6/PoaqP3ejQYel
	BqpzLPZ8P6McV8sRx6pqpgupJMOylxBJBLXVqnm68CFAL9LtYVoG56M1JP1qGpcUDhKJM65VCu6
	IlBzEXbdUhf1BrF4lcC10AmBm89Ef8FNDOVwrIMrRhbK656h0DPhR92Qz3/MUwCUiQ36jdS7lS+
	MlvgihIq8pt+VhUZbbY1krcjWzak3ZMG6g+aKVA3fZh5SvVcQyb6Lzi5416h1i540FgtONPzxBu
	eaWqVMozeCI4k=
X-Google-Smtp-Source: AGHT+IHxkUslwpxevE9bI62FFSn+jT5ev+hfJBOVMTNtFsfSx8g7hj3BL9W278Q7NiAXFoCSS/Poyg==
X-Received: by 2002:a17:90b:1dc7:b0:32b:aee1:18d5 with SMTP id 98e67ed59e1d1-32ee3f76419mr6422504a91.29.1758181174135;
        Thu, 18 Sep 2025 00:39:34 -0700 (PDT)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed273ec20sm4537412a91.16.2025.09.18.00.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 00:39:33 -0700 (PDT)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id AB4491062112; Thu, 18 Sep 2025 16:39:32 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v11 12/13] um: nommu: add documentation of nommu UML
Date: Thu, 18 Sep 2025 16:39:07 +0900
Message-ID: <375e45e659d289d5343d7852303e1c04d6077a4c.1758181109.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1758181109.git.thehajime@gmail.com>
References: <cover.1758181109.git.thehajime@gmail.com>
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


