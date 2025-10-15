Return-Path: <linux-kernel+bounces-853851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD3CBDCC34
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 08:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E509418978C1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18EE3126A6;
	Wed, 15 Oct 2025 06:39:10 +0000 (UTC)
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DE8302178
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760510350; cv=none; b=PcFdAM9Bc/05ywdhb97p5VUDRqhBb9q4IWOlkp+4eFKRD0id8XuK0mjbmKPOzuvDj7TXjEA8DDDbf6eA3kLs4gG/r2j7I4aiRUsXqfUcRb4FFD2sx9niCEkiWJMutPJodCQgUCPIZTby1e/+ST9II+zVa2Zp+zoXEwTBCYZeUB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760510350; c=relaxed/simple;
	bh=IYD1jN5WkZj4VgxNMFXq2HVKXVKvIXQ7z1epo6PKEZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqEK/GfggV8g1LtvJqGjBgXl4oFS8F8RH/dpwZVPYH5aaObvMlRdsFYPGDfk5finKEtsarKvfMgrFCMz7FzjBTwYuGF3DDBEWxnwgssD/2cRO+Wx/e0iqeNrrZraffiikBsA3oI81/506ZDc7Mwepwng+oQzT/hSALcaeP/n2ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org; spf=pass smtp.mailfrom=tinylab.org; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tinylab.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tinylab.org
X-QQ-mid: zesmtpgz1t1760510334tf939942d
X-QQ-Originating-IP: od4bNRLOLfQkHFiv6vxwr/aDip+WTs/jGF3/NVLsJ6I=
Received: from GPU-Server-A6000.. ( [202.201.1.132])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 15 Oct 2025 14:38:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7569591979002680664
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
Subject: [PATCH v2/resend 0/8] dce, riscv: Unused syscall trimming with PUSHSECTION and conditional KEEP()
Date: Wed, 15 Oct 2025 14:38:43 +0800
Message-ID: <30C972B6393DBAC5+cover.1760463245.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1760463245.git.tanyuan@tinylab.org>
References: <cover.1760463245.git.tanyuan@tinylab.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-QQ-XMAILINFO: M8Zk4Li7PoFiTw+NQSaUVPSNuBAlU1et83LHIW2ei/gwxZrxBYbsJIAJ
	tkRYF4XEhGwYukpv6nzAfQ6gVD3VUynrhZoLjFPhx05mDmJ/kI8gYhPqZSYt2cNkDOeBJjY
	CXdi3xeVmTnrD2KReso7+/Khs8TiEq1He3eaCEGD6geMvYDiWoMVbaAOi2Dgc0e1kmXteqI
	gjOX7mujNKCuuB9n32EBd8Z01JJk/oN6uVn6W2/IxRDqId1pOSDYZJXmjSfxLnI7bOMyAG2
	0GSEbzwWcXMqLtyY4+rxpeDVDoYuw+wkLefeVvvVglSATMXbMWVuQyhs8XbvtwUBlQGQmui
	CIdfRvOunG2F3qPdXi3lcgjmfSRNMrZWrz1KNalmJbw4WhB8YT0k3lWdck05mUWNXGB/QId
	wnZ/guLNW6GBUbOr9a37Pa56f4d+qe1H328rNG44z3IvywEWk45AyuJUKMg8Wc8ECR2R4nK
	mNiAL+68UU5fJ1C1p4lNYguHXGYskQyKfigDgctUiZDfX2KePfY7bjqOPkx1pTOMI9JvKXE
	bIZpAe2XefUR1wP8E0E8TR5+GpgPQAG3LK/+IXzvQlZAxRNahB4zNr3Jsdb5WV5HGA0yi7C
	H4enj8xULOEXBYIPmYoa9g9yjGJXIFhT2bi95XwotRsk78+zRtrbKk3h+dJTVt8rBd8WaTp
	obqiuBWt3deU4A3AoEzlwzgGiPXUEn8X/cPJFl2hKStwKIYaDqD/Nd6swAewq12RIxPTRwJ
	gu3F6UqIG5K++0yG4qMhfOcT+uT6WJJ8xxJtq6gybZs+a3HxIHKNWqkICFbObzQccdWMVIb
	UYUpJ1KNx210+dMcLUHjNoAvw8Nwggmi75fAI+GwBzrnRJdOqqH29qtpiJI33K2Ydp3IDbD
	pOhCoSN0b5sJow5MMaSOTb4T+H6Br8JbnRQtMP09pTTn6e0Xpct1Dh+b8XuQHOIpx0oC4lw
	LFBMasQyCHA4hR8EoR3386NSjaOOiVbxTNCyxuc0OVj5gLidLqVbvQHtdT6nT3rF3q2EM8c
	DQMF2qJaWCOSL6WhCoIf26sAlWZfA=
X-QQ-XMRINFO: OJlEh3abS6gXi5NWrXbD0WI=
X-QQ-RECHKSPAM: 0

Hi all,

Sorry for the noise — it looks like my mail provider rewrote the Message-ID
of the cover letter, which broke the thread. I'm resending the cover letter
to make the series appear correctly threaded on lore.

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


