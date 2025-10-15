Return-Path: <linux-kernel+bounces-853819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 355F3BDCABA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AFA943532B4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD41F23ABA8;
	Wed, 15 Oct 2025 06:17:19 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B5A3054E8
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760509039; cv=none; b=SyMJhzV85/TB5dFw8G9JJtpDk+hQsc/0Dk4JX8wVq3ntZvFnm2chlhU7fWjQrfUzxPcgLNEzcpr/UMxJ+HubAiyY1Y4NQMRMbZm2ZF6uvJnnFrLR+PS6RC8U0x3s5dM4kfdIjfYiI5UEhJs6ScR9DT71EfgCOHENM++S0s+7VGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760509039; c=relaxed/simple;
	bh=WKHvqzjQjt2OzlVb1dHZO/h9kfa3q8fZOo3Xqch/Ni0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rvvj3+TJEkg+ur90KmDxepeXxkkr2546ST4qpsXe1dgExU/0FbDsguEHGLu9N8ufgCTOkQyVL/Gm9EGhbdYHTdYFXC2Xu4ESQu9dukUhJslrpQa3wTPn30BaBxYT9fm/K4xhvRCdE9npozhPFkCZD0oIpCBr9Q1GkL19zL6O/do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: esmtpgz14t1760509018t31c70c8a
X-QQ-Originating-IP: 5rtYHnf1uX5lbvBQHVP2jDB76L3yTJsTwI5l+8A9+B8=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:16:55 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16965900830134084454
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
Subject: [PATCH v2 0/8] dce, riscv: Unused syscall trimming with PUSHSECTION and conditional KEEP()
Date: Wed, 15 Oct 2025 14:16:20 +0800
Message-ID: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: Ni68Q0J6fxe2wp8DJ9X0pgH9DGhDUwHJCsQp6zWnh+Roe9nVysG/ySXy
	pIqcbx7fLuHLzeKtodxuzMjS+TJB+ZILL356dtTHUa/Brgxj6Pz/vXybLLPTJju8jxpxR/7
	K9553wGSUxsTMJbRcGavCNsDqlQeaiF2Dfy/PMPYHcGBL0bOTCoby7Fd1eb2UYCfA0MIJba
	iQ9surgy++Fh146R+P+uZvo8rbTI43O7YxxE9aXG+bQXavwTJdyLPxKM7lj1w7HRV3WgmkV
	GwCvkF/LC2fYOD4ubC/1IW22e5E8cs3/H3LlpZXxQvYYEV1otYHEztgkU/ErOGJ1VOmthsZ
	aITR6xTZezWluxXd4g7FKvhsowLa8mn9B4LJJyKkw7Y68yfPBr52+l7UgmbzghmhDD4W4aZ
	4Mlz5hDxM03SO75AwtXVLBTfDVNwjqFNuoGpzdSKS7yMMBGy0iYGeh3Qg1IRKSCbm1qxemv
	F0ZtQIf1JfkcBhTJbrELV/M/zkWbR42aZgnY2rO672VaFLvSyPEcRKkCssKxxGqxD9mtcyY
	ypWHVYhTOkzqD+UmSk6/RYquGsPB4sHOB8wyDx0uxMSRii/w5CKBiWYtggxtOI+GA6JFiR2
	NmfCOj/ChuqB7z52ntmy8gySWRnS+7CHQWLFOcxBQ5oarubN1iGRwE+dxA6CcBmo5WzwRFp
	KS9XQLhA5oFyaiYk5+kZz6biexhKOGwDPLUifanjKQPTL45Sc/ExtsIcavGCtsk1Xxh/IeR
	Mely+JVlMAZuQK6GHPSKBbDHCAtE2uMWguL7d8LCdv0W63JsoBZuM0dqXGySQRDR0yVDXXj
	ziXGY5n+xOBFpzFk3h+Q6mBFkCbvQxb37wtSmx7u9ZO1gc8VtytIWripCR55jlkKKtrrroi
	4SmYe96cUu6Etc0ZJ7ad+bN+VRRi0bYaqssR6jMeaVjj2tg6imWMmbWzI1QzRf/hwSmqXjK
	LfAiQWp78zu/xqrKqlm68phlVLiy5DQyCFp5WTpt3CYn6tB/Oz9lWRLhuXyEcJ1Bkf89dJH
	OyHEYiFQ==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi all,

This series aims to introduce syscall trimming support based on dead code
and data elimination (DCE). This can reduce the final image size, which is
particularly useful for embedded devices, while also reducing the attack
surface. It might further benefit specialized scenarios such as unikernels
or LTO builds, and could potentially help shrink the instruction cache
footprint.

Besides that, this series also introduces a new PUSHSECTION macro. This
wrapper allows sections created by .pushsection to have a proper reference
relationship with their callers, so that --gc-sections can safely work
without requiring unconditional KEEP() entries in linker scripts.

Since the new syscalltbl.sh infrastructure has been merged, I think it’s a
good time to push this patchsetTODO? forward.

Patch 1–3 introduce the infrastructure for TRIM_UNUSED_SYSCALLS, mainly
allowing syscalltbl.sh to decide which syscalls to keep according to
USED_SYSCALLS.
Patch 4 enables TRIM_UNUSED_SYSCALLS for the RISC-V architecture. With
syscalltbl.sh now available, this feature should be applicable to all
architectures that support LD_DEAD_CODE_DATA_ELIMINATION and use
syscalltbl.sh, but let’s focus on RISC-V first.
Patch 5–8 address the dependency inversion problem caused by sections
created with .pushsection that are forcibly retained by KEEP() in linker
scripts.

Here is an example to illustrate the problem:

void fun2(void);

void fun1(void) {
	asm volatile (
		".pushsection .text.pushed,\"ax\"\n\t" "call fun2\n\t"
		".popsection\n\t"
	);
}

If fun1() is used, .text.fun1 is kept alive, but .text.pushed has no
reference to .text.fun1, so --gc-sections may incorrectly discard
.text.pushed. To avoid this, the kernel traditionally wraps such sections
with KEEP() in the linker script. However, KEEP() introduces a dependency
inversion: if fun1() and fun2() are unused, .text.fun1, .text.fun2 and
.text.pushed should be removed, but KEEP() forces .text.pushed to stay,
which even keeps .text.fun2. As a result, sections that should be
eliminated are retained unnecessarily.

In Linux, sections such as ex_table, jump_table, bug_table, and alternative
are created by .pushsection and suffer from this issue. They prevent some
syscalls from being trimmed.

Ideally, .text.fun1 and .text.pushed should share the same fate: if fun1()
is not referenced, .text.pushed should be discarded as well. To achieve
this, we can establish a relocation with a directive between the caller and
the section created by .pushsection:

.section .text.fun1,"ax"
.reloc ., BFD_RELOC_NONE, pushedlabel
.pushsection .text.pushed,"ax" pushedlabel:
	call fun2
.popsection

Based on this idea, we introduce the PUSHSECTION macro. This macro emits a
relocation directive and a new label automatically, while remaining fully
compatible with all existing .pushsection parameters. With this macro, all
current uses of .pushsection (and even .section) in the kernel can be
replaced, significantly reducing the number of KEEP() in linker scripts and
enabling --gc-sections to work more effectively.

Without PUSHSECTION, there are 56 syscalls that cannot be trimmed in
defconfig and TRIM_UNUSED_SYSCALLS enabled. With PUSHSECTION, all syscalls
can now be properly trimmed.

We have tested enabling TRIM_UNUSED_SYSCALLS while keeping all syscalls
listed in USED_SYSCALLS and successfully booted Ubuntu on a configuration
based on v6.18-rc1 defconfig. The detailed configuration is provided in
[1]. This confirms that the trimming mechanism functions correctly under a
standard kernel setup.

The vmlinux size with tinyconfig is as follows:

|                                 | syscall remain | vmlinux size   | vmlinux after strip |
| ------------------------------- | -------------- | -------------- | ------------------- |
| enable DCE                      | 188            | 1437008        | 915160              |
| enable DCE and syscall trimming | 3              | 1263528 (-12%) | 800472 (-13%)       |


Changes in v2:
- Rebased on the unified syscalltbl.sh infrastructure for syscall trimming.
USED_SYSCALLS now accepts only syscall names to avoid confusion, whereas v1
also allowed entry point symbols.
- Uses the .reloc directive to establish dependencies.
Compared with previous proposals using SHF_LINK_ORDER or SHF_GROUP, this
approach provides a generic, parameter-compatible macro for all
.pushsection usages without side effects.


Previous versions:
- RFC: https://lore.kernel.org/lkml/cover.1676594211.git.falcon@tinylab.org/
- v1 part 1: https://lore.kernel.org/lkml/cover.1695679700.git.falcon@tinylab.org/
- v1 part 2: https://lore.kernel.org/lkml/cover.1699025537.git.tanyuan@tinylab.org/

Links:
[1] https://pastebin.com/St51bk2K


Yuan Tan (4):
  kconfig: add CONFIG_PUSHSECTION_WITH_RELOC for relocation support
  compiler.h: introduce PUSHSECTION macro to establish proper references
  vmlinux.lds.h: support conditional KEEP() in linker script
  riscv: use PUSHSECTION in ex_table, jump_table, bug_table and
    alternatives

Yuhang Zheng (4):
  init/Kconfig: add CONFIG_TRIM_UNUSED_SYSCALLS and related options
  scripts/syscalltbl.sh: add optional --used-syscalls argument for
    syscall trimming
  scripts/Makefile.asm-headers: pass USED_SYSCALLS to syscalltbl.sh
  riscv: enable HAVE_TRIM_UNUSED_SYSCALLS when toolchain supports DCE

 arch/riscv/Kconfig                          |  1 +
 arch/riscv/include/asm/alternative-macros.h |  8 ++--
 arch/riscv/include/asm/asm-extable.h        | 10 +++--
 arch/riscv/include/asm/bug.h                |  2 +-
 arch/riscv/include/asm/jump_label.h         |  3 +-
 arch/riscv/kernel/vmlinux.lds.S             |  9 +++-
 include/asm-generic/vmlinux.lds.h           | 12 ++++-
 include/linux/compiler.h                    | 43 +++++++++++++++++-
 include/linux/compiler_types.h              |  8 ++--
 init/Kconfig                                | 49 +++++++++++++++++++++
 scripts/Makefile.asm-headers                |  4 ++
 scripts/syscalltbl.sh                       | 19 +++++++-
 12 files changed, 150 insertions(+), 18 deletions(-)


base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
prerequisite-patch-id: 7af3175326df94637f04a050dee7356416eb1edd
-- 
2.43.0


