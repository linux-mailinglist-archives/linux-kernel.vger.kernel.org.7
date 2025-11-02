Return-Path: <linux-kernel+bounces-881719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B28C28CD6
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 10:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F31E18820CB
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 09:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF28275AF0;
	Sun,  2 Nov 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UX2g4X27"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44AB2737F2
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 09:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762077007; cv=none; b=CySBvNTnoiY3bIDqEJtJuY9pLnRv+9fYa6kDo1IRcYOmtdEv1QWxY7hQzGh+JNgreIKzdigmVeRf+kknS58HVDt2lVRloYFOB7ImKQCO+JFXXu0cvbRSNftwBqaakC8NGWzTUyLVwKO3SgeSNG5Vw8OQKGOarxBEbZJOeeLJgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762077007; c=relaxed/simple;
	bh=zibfGPnHjDDfR56CnEZcgy7KJBvoyjyLYqaq7S1mZJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZTNSUtc0jqhBSzpAd3zNO71h0uSx+SEUINbYE6o3KiEnOVe3oXRR87lFY4JM3cTaBGq/JkSS17Sl9K0GMF5HfykXHZUbmTa4ZdpKFHV/bpNr07sfbNaZ3C1MnyKMTJaCn36wdEEuYqwnLjzb3NvIWkvpq8lA/ZEBxi1Jf95jbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UX2g4X27; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290aaff555eso32065425ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 01:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762077005; x=1762681805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dqdH+bbha0oqzf1JSsYMP+tOcPwBytuRd4+x0yMEJ4=;
        b=UX2g4X27uPUyRnPXQaYADAYy6ozRCiooL0IFQZ+vKzJbl96MCml1T45PrBlNYAmxHT
         omJDTyaAOEPwAX2F6Qn7lIRUo77y6QVmGHbfDOHvW3LXzehZeXXcF2kJXOdfTyQIRulh
         GhAv36N2YMo8sSABJkpIO20WSC0Q1KcaVzqs6ai5jDqHz7V4M2G9Ezq58MrlxgRfNHYn
         KyGgLiZXw+9Lq64IFx/qo1jIztSVZdXrHdfsJfgUzFmZqaLSOfQj2+O5IGBHvTpkdhXM
         wzYxFp9jW83B52cEjLNhZvHLJxHwsI5p7DM4MPjR/siIFLkWGuXSBdYRdRUHe1xqzjD6
         8MQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762077005; x=1762681805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dqdH+bbha0oqzf1JSsYMP+tOcPwBytuRd4+x0yMEJ4=;
        b=L+TP9iCm2+rfFCtz7o8FLBJD3wIZ8LEO4zIG7JkyXOxVW6qfvw+qYK1XE+0JI/b9GX
         1Juqu1e9I4bsfQeSBWhk+A6KxQr4huBuxhQ7XNxomiUrqkfRRZ+zVuYaidLtrM10qlzJ
         NrwLyReCJDXTLaLA2K3qHatH/fdytATV6Y+9cd1DRAING1kw7hJUaY0TityC72AEG3Jb
         ScMvgmB0S0+B6gqfjo71AUGATWZh+LYBpL2X/fJUx9e9B7Y/UsxMAwEZ9pvl2wLmXBh0
         PbOSAUkIQNMRfMjwO9SEYq/gvfDO+9T/qtb107jVFGCN07VpYUry/FMA7nwURP21AKLi
         LxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2NOJKqXktgnBiFFSBJ7YwlEWy950tgPPQHSMZqmuODfOn+ggeu8hGYDw42dcEpu+JBcQE0vzrUDk19GY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLC1tefLkty8Vgwrt/7TqtsVgWWJlOEQn2y72pm4RHZcA8lhPi
	0U0mdS7TMUIsSby5FtonfFeTtBrEf5lMhGZe5LQRwcF0f0tQotM8/iEj
X-Gm-Gg: ASbGncuqPem0jSvDMaJ5iPub36cq2E8mzn3TQ+AgNGOSaNNBTHC09c435ytq3exc5js
	sc7paFF/I+nSFVmDXJHdW6FKwiE7OCquVLizLNOaXTtpufM5nmscc/4Jp2JTfA5AdsPV8dJzxvZ
	cvHEQc0ZS8PT4r4T1K1qYmYcUwg7uIfIAZTm2yrVWghkE8e3BlL9YViHDvc6t5GOoZUo04VMoQ1
	O3ooO6eTn/Tg3CFH/Vxn2W0S5pqsNxku/yHSN+g9F2e96zuAqtsSt7DR9Ug8t4a6GIVb2VjLCAg
	ohzBNkovEE1w0LtlN9fZYa09FHA6fSZVuWllkU2n9sLVua3wqYobgnLGqNxowBf0vVSjqCPVUaq
	omRFL+dFlFJ0smNO12bJAmNjqBQQ1QhAFp7FISEGmNZHrk6jxN/TN4tvHY4a9iZ+86eMSoFyRZu
	Fjlt9pZHzwX1tbpULEfMr9JMS+V8hgXDK56wlES+hEZqwvsc693+DbHcU+
X-Google-Smtp-Source: AGHT+IFTT8mUkp6R0uskWG/57yRDg57gYJx+nISTWHd5GAVvqwpyvi2KaA37qjTacNm8b/KIx1pAaw==
X-Received: by 2002:a17:902:daca:b0:27d:6f37:7b66 with SMTP id d9443c01a7336-2951a486898mr125305485ad.47.1762077004804;
        Sun, 02 Nov 2025 01:50:04 -0800 (PST)
Received: from ikb-h07-29-noble.in.iijlab.net ([202.214.97.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871b31sm82851965ad.8.2025.11.02.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 01:50:01 -0800 (PST)
Received: by ikb-h07-29-noble.in.iijlab.net (Postfix, from userid 1010)
	id 5B4291123815; Sun,  2 Nov 2025 18:49:59 +0900 (JST)
From: Hajime Tazaki <thehajime@gmail.com>
To: linux-um@lists.infradead.org
Cc: thehajime@gmail.com,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v12 12/13] um: nommu: add documentation of nommu UML
Date: Sun,  2 Nov 2025 18:49:37 +0900
Message-ID: <5a831d893431c15a1bc2833cedc5a45cdfa44cb9.1762075876.git.thehajime@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1762075876.git.thehajime@gmail.com>
References: <cover.1762075876.git.thehajime@gmail.com>
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


