Return-Path: <linux-kernel+bounces-891390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE9BC42930
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 09:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E1D3834B8D1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477AB2E1EEE;
	Sat,  8 Nov 2025 08:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv4IQfGQ"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A6B2EA731
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762589186; cv=none; b=bXzc5K6H8VMBHK/D4OBYozGstCyvLSvw53yS+5yE3eDKxG12Sp6na5GONwN9GmI4sN+PKlMz2QtT9DBWShaTS00eIA1eN6Tk1gNUD+Ldz3LIv6GOAJ9dW652opJ89bmADjJ/0bUZXaRht+BmZjTT6CxaD/PR0A2e2FsxRicSCWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762589186; c=relaxed/simple;
	bh=zibfGPnHjDDfR56CnEZcgy7KJBvoyjyLYqaq7S1mZJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJCf5KVrLQ9q2EjWaFQPf+Cy2gDPcwyO3zrdbmEewKt1gZnSKY4EEDNGQZ6VFKCjwsFlczrOlWGWb81PxjaNcQnWo6F9Ij6mEBeKWyKkkScvbEzx0V/RHwH+iNZXHTcnhOftQ2snZqQd3laruJqaJIkN+P2KgGi4+ITqPwzxmGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv4IQfGQ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1225617b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 00:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762589183; x=1763193983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dqdH+bbha0oqzf1JSsYMP+tOcPwBytuRd4+x0yMEJ4=;
        b=Hv4IQfGQM3uF8887B+vgAqRIGEQB/DzQGGjm6kb11+Zz3ePtJXaZwoOmzvTUpyycfP
         3sOFC+m63csV6aHJkaoCGn1lCCDWXH4JDlZJQ5nsM2ep6Byz94CqU65Ivbxc2xmPnR8K
         QbJ1z5V4VKS+DjwLcrVlQHBO4LwTFq99kx8skQUc9EpuJ4oXzj1EVesE7gnLKYxGIOsv
         6K45PK+bTMyGLxmBjH0YZQcyKYB3WVwzEPNH0/wO3dQ3t1fS//+ezSVILtcrG6N20646
         6n6MwoSLME07p3nuAtwhIE27QUOUIWyMTVoojLemO/nH1YMvKsycxUODoI0PTXWJzPmI
         x+Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762589183; x=1763193983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dqdH+bbha0oqzf1JSsYMP+tOcPwBytuRd4+x0yMEJ4=;
        b=iEvndzPupeIBw/RYdnseDDBCRU1p1rQ6p1EkE2/xVwQv2SK+feZhlP3DW9AzZjyZVn
         CzT4mIuGmPziTyvb6awwfUF6mDKb6fHQIc7qRYNdGcDLChOf25HAw6MlawJLw4/K1CVM
         O68EUA5FOkqdn24oji4S53C5iAqphmQ+EapSE6l7uEHYnlMGk/LTTH4hAEHSF/bExi8p
         xs3DD193BPJEdRXJk0cf+PSPRfhsRSrvC5sOJ7w0r4udF+dW6nV5/GhTLcoJI7IdezXB
         IaFT8kKKXiq1YyOoXAED5HlC/f4kNO6gBN//AOC16540tldNo3RSpLGXv6ui6/BkJrFB
         A/gA==
X-Forwarded-Encrypted: i=1; AJvYcCVM9i1+JDmMkLrcCpEvM8Ba5aBPE/CWdV5sr+O6O/gNq+cYAHbSvk22PPM+lDArj3VzEccLuj9uly4zol0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdK4ZgzEGLOaK/qWYh/xlxRAtOH/nuOe62OtFbPrSbQa9ll1Tn
	NMATXlKJOopA+iwlRE0lr+enjjw0gB8IJP23LKFsR8Pa96dgLCR81+6y
X-Gm-Gg: ASbGnctcKj70F7sEUG0lAGCheRIuxKoPHvnLxLyObqex6UP9JkUyY2xYBW7fwdNB6kx
	2gCJJRSvoVHC9HYn4VxBXsFipfr/n5h8AOFQMGacFF2Cub5H1hJ0YaLysoodKG01HM7TodcjG2v
	9AieY0vDRgFv9iWmrbM9fjvOxvOYFCmNilLQq2Wd0q/tKdE0zoNUcJAcU/JxY1RJbbN4tyONzgl
	dszeYn/zPYB1pQXWqpLxYk31dig8GapVRMiDRyJwjWOw5CYo1CHm6P4iA4Ql9gRnvQRlMw0S5sp
	UkOELZw4uAXmLHN4Fl6yN2fwCFw9ASy1fTuQsyyPEWDqugtqpf3Kj+wVOnDmhut2FC42b4pW7h/
	b1vCAo+12fQQ5NvBWtuJninSMNWwsqcfl3hhJ15wYatdPjBHPjV5alGd27Cn51yJRWg7F7BvbKp
	vwtTXM4KFIb7MyGM00RkXb581A0Yj79+jPNSPyjM4fr/8cnFewYAWnLbkq
X-Google-Smtp-Source: AGHT+IHPdEthRdTRwy4DjlAb9ugJodv/2lyawe799MFKgVDlI5BF9aTI1fKrT19wzsFKSQnRdicvzA==
X-Received: by 2002:a05:6a00:2d8b:b0:7ab:2fd6:5d42 with SMTP id d2e1a72fcca58-7b22668fd88mr2351669b3a.16.1762589183437;
        Sat, 08 Nov 2025 00:06:23 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0c9ff74bfsm5237995b3a.27.2025.11.08.00.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 00:06:22 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 2C76011388DD; Sat,  8 Nov 2025 17:06:21 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v13 12/13] um: nommu: add documentation of nommu UML
Date: Sat,  8 Nov 2025 17:05:47 +0900
Message-ID: <16940d31af89a3127acf29d23e10dcb9b7b9f4e3.1762588860.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762588860.git.thehajime@gmail.com>
References: <cover.1762588860.git.thehajime@gmail.com>
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
index 3da2c26a796b..2f227f56d04e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26764,6 +26764,7 @@ USER-MODE LINUX (UML)
 M:	Richard Weinberger <richard@nod.at>
 M:	Anton Ivanov <anton.ivanov@cambridgegreys.com>
 M:	Johannes Berg <johannes@sipsolutions.net>
+M:	Hajime Tazaki <thehajime@gmail.com>
 L:	linux-um@lists.infradead.org
 S:	Maintained
 W:	http://user-mode-linux.sourceforge.net
-- 
2.43.0


