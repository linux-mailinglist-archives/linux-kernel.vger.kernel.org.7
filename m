Return-Path: <linux-kernel+bounces-853826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 77564BDCAEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2494235363A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B55306D40;
	Wed, 15 Oct 2025 06:19:20 +0000 (UTC)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708B305E1D
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509157; cv=none; b=gG6ENnnBn4AYdp/sDDJJ+SUjRAvbQ77NF0Si9JpZujwTPwR2fcNrEwwTspYViireVQerz7VbhqEIeWYscvZlJjSWEgHm0/SQ+2gaJM14ilMemUI2qyzvd5V1r9PG4XNO4r/kYc+SB0x7DMQ7MldcOZY0NtOSqGWDZPqOG3RRZU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509157; c=relaxed/simple;
	bh=yg0cl6aq1zz78rp7BFHJOnp8Z3Ql5vpAFF/hmAMMfPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQJoqxlLth/gXLdUyeOauObh5rzEJfaZ+2uCobXkQOZ45loUWCLebfGjQPxRTDS3TGYGkrd4OX21KIlOSVuMiYpstj+sGQltx8QXW9r+ZSutLNgPgfFYNCRvEcai0D5j3Wyx/WyuYvLq8om+4HaDzzLjg4uoft4nfjTN0n/qY6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpgz10t1760509149tb52a1c72
X-QQ-Originating-IP: CKHnewHYWDo1Yrf4J42jLvNSa3NYNzjq2GE7A4/LC2k=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:19:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4224186876999705222
EX-QQ-RecipientCnt: 14
From: Yuan Tan <tanyuan@tinylab.org>
To: arnd@arndb.de,
	masahiroy@kernel.org,
	nathan@kernel.org,
	palmer@dabbelt.com,
	linux-kbuild@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	i@maskray.me,
	tanyuan@tinylab.org,
	falcon@tinylab.org,
	ronbogo@outlook.com,
	z1652074432@gmail.com,
	lx24@stu.ynu.edu.cn
Subject: [PATCH v2 5/8] kconfig: add CONFIG_PUSHSECTION_WITH_RELOC for relocation support
Date: Wed, 15 Oct 2025 14:18:58 +0800
Message-ID: <31FE3D0D64425B42+b7172d7ef4e6fa3ee3ed543a44dbc5e467df4da4.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: My3NiEDg63N+0TZcnoWClepoomexH/04H+Xzuw7QuwAXiCX9EiQiM62X
	wgMqw3SYJBYyS3DZVbenSGP0KK/39Z+ma7HbrWablwRGg4guuBPwjGzyLH9BFlqvGZUExDA
	FnlB7/MFOrgRFCr0F2KH2beWATa+phfJReOEhgCvIto40etskOAwtkfqA+eD24F900uk6x0
	qWC9zfNCGONRfzs0IIqznw2zOyC3Z9WsXyiDqCYeLCZfSOsDV9Ru3SAf1MOVX/tr6vFXIDx
	DUydIaqd5+BMbZJ9bc5dMXHIN2nO2WkyRzyYaPU17kIL6spJipR8efBMUqDYc5HG+4EO2Zx
	Ay9nM+U7vJ8JYxoJuvpXUxIc6qAR2gnFt5qc2t+0OJ+le6w8/OhczzAHbREosjAOKy477ax
	Pf2BDS4hDw5yxlkBqgZN5jOyv9nBX16v750cpI5SZu8EDRgVmHoVtUpmkdqrXUuDDVidd+j
	sNX7r3eMvjKKbXmi9Vlp5/xfoZcvdxZ0agXElEXuICU3wjAT9lKaQj3yNszBJADOzhm7wt1
	YxAWRd2GWKnkHxCG5jn0+h8Zw+XVLJwWEEd4EjwyY63d248umUG6qaXAs3rvGSUSAMhgVBc
	JUcPIuGK8LVQsZCHWNb3YPaDtYp2sXAg2gOS+Ycuzfn2Vt9cBzZ9qpexx6wrl5rJk3Spn9L
	40CxTzgvTySbVRdM8vxVEt0VzH9bVfcu82HGwq3m1pJo/odEy7uD+7XXQqLqFB6K41PR5OQ
	dW5rEm091YwwtdaqEzSRJo1CBQlRSgoJQna674bukf5JhD7sHiggAgNpcSMepk7eKFTnZ28
	kev5A82CT+JTmeeyUZ01l0huuh6fwtMV+N/6b/MaLxm/i2XxhimfPmX1+NgmOgZNWz4OUOC
	AWYdUaJXXDfJ2Grg0bpYvg/fX5z5CXMcL1R97awUxf/LAsVICnc2oYsUwZi9HEEun1lyrx2
	nL2DkcX2kwG2CNPxdoeplbgHEL2ewpBctcc8=
X-QQ-XMRINFO: NmyfvsrRkCkJS5MlOxeZYe4=
X-QQ-RECHKSPAM: 0

If the assembler supports the '.reloc' directive with 'BFD_RELOC_NONE', we
can establish a reference between a section created by '.pushsection' and
its caller function by emitting a relocation in the caller.

Known toolchain minimums:
- GNU binutils (gas) >= 2.26
- LLVM integrated assembler (IAS) >= 13.0.0

All assemblers meeting the kernel's minimum toolchain requirements already
support it.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Peihan Liu <ronbogo@outlook.com>
---
 init/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 2c6f86c44d96..3d1cf32d5407 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1631,6 +1631,10 @@ config HAVE_PCSPKR_PLATFORM
 config HAVE_TRIM_UNUSED_SYSCALLS
 	bool
 
+config AS_HAS_BFD_RELOC_NONE
+	bool
+	def_bool $(as-instr,.reloc .$(comma) BFD_RELOC_NONE$(comma))
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
@@ -1965,6 +1969,18 @@ config USED_SYSCALLS
 
 	  If unsure, please disable TRIM_UNUSED_SYSCALLS.
 
+config PUSHSECTION_WITH_RELOC
+	bool "Trim more syscalls"
+	depends on TRIM_UNUSED_SYSCALLS && AS_HAS_BFD_RELOC_NONE
+	default y
+	help
+	  Enable building relocation-based references between sections created
+	  by '.pushsection' and their caller functions when the assembler
+	  supports the '.reloc' directive.
+
+	  This allows the linker to establish proper dependencies, remove the
+	  need for KEEP().
+
 config KALLSYMS
 	bool "Load all symbols for debugging/ksymoops" if EXPERT
 	default y
-- 
2.43.0


