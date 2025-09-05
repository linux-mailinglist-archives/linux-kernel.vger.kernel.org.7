Return-Path: <linux-kernel+bounces-803862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19D8B46684
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 00:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271373BBFF1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 22:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC89C27511A;
	Fri,  5 Sep 2025 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gl0twtyf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234841EB9E1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 22:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757110592; cv=none; b=idcyLdpU15e4NrhF7Cg3Ja4ac8W8KZKuh5VmlWjoZTT65CCVeR5u02rEUNG3pNwTuf6sGhZ554C+d03DKbjPpvPU8TeqesFxG0+UbXpPw/1y/fTfSHR1d25cVoRQKkTAZjyomblrz4GhJaDqXZ9etApDKAabDSLOdFj88eIvFnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757110592; c=relaxed/simple;
	bh=hiM3beF3fv5uGn3U41IG6n+nmzc1UenQ5CJyz/l9OE4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=jZCSGAprij57mH59TiggOWhpMUSt4+/ay1XqpdGIZTJaiIzk1Hyamd2AQoiKOB5EnuUIQbt24WAvtro8PUfvXASSE/CZXX4ec4DmOjSJzHK+9SDaMt61x+NySin0B3bo/XggWDmzT2vj4YH/HP7TquzqF9pBu+j1SuXotDENZMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gl0twtyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D1C4CEF1;
	Fri,  5 Sep 2025 22:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757110591;
	bh=hiM3beF3fv5uGn3U41IG6n+nmzc1UenQ5CJyz/l9OE4=;
	h=Date:From:To:cc:Subject:From;
	b=Gl0twtyfvuDZHWL7ztRp01L1BmA/zS0azuZ5pyhFedqa8CfRYFFOXH3FSw+oeb2WX
	 LJUAtkFpjRpwRm/q8P0eeRIrVjizvx3EwuYU1t/e1ViMM6QRevTivmdAC+UaGwujaJ
	 eyj8bHCE4rZZ6xj5TReHLwp6Jq8rkOMy8vvw+N3XEC5OAjXShUfs754SJBxItsjiMb
	 lWkEKwCRlrwkjsduucdFq/xf2x0acvdcfWaQljtzpRQc5pqtKAXSMNxfhaCgwLUycW
	 LvZTrdAatXv64covL8M4b+5GW+jeluAU1G2jr1OhGtkbGCf15qcSXHkOljWI+WpF8o
	 iWNsqB2LMsvkw==
Date: Fri, 5 Sep 2025 16:16:30 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v6.17-rc5
Message-ID: <053b276c-b22b-f3e7-6c11-abe61b8ee36b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1855849172-1757110411=:9369"
Content-ID: <bda0ad22-1471-ad2a-586f-25bbb3716178@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1855849172-1757110411=:9369
Content-Type: text/plain; CHARSET=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Content-ID: <a503a4c4-6dc8-b783-034c-98483ca7fdfa@kernel.org>

Linus,

The following changes since commit 8f5ae30d69d7543eee0d70083daf4de8fe15d585:

  Linux 6.17-rc1 (2025-08-10 19:41:16 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linus-6.17-rc5

for you to fetch changes up to a03ee11b8f850bd008226c6d392da24163dfb56e:

  riscv: Fix sparse warning about different address spaces (2025-09-05 15:33:52 -0600)

----------------------------------------------------------------
Several RISC-V fixes for v6.17-rc5:

- An LTO fix for clang when building with CONFIG_CMODEL_MEDLOW

- A fix for ACPI CPPC CSR read/write return values

- Several fixes for incorrect access widths in thread_info.cpu reads

- A fix for an issue in __put_user_nocheck() that was causing the glibc
  tst-socket-timestamp test to fail

- A fix to initialize struct kexec_buf records in several kexec-related
  functions, which were generating UBSAN warnings

- Two fixes for sparse warnings

----------------------------------------------------------------
Alexandre Ghiti (2):
      riscv: Fix sparse warning in __get_user_error()
      riscv: Fix sparse warning about different address spaces

Anup Patel (1):
      ACPI: RISC-V: Fix FFH_CPPC_CSR error handling

Aurelien Jarno (1):
      riscv: uaccess: fix __put_user_nocheck for unaligned accesses

Breno Leitao (1):
      riscv: kexec: Initialize kexec_buf struct

Nathan Chancellor (1):
      riscv: Only allow LTO with CMODEL_MEDANY

Radim Krèmáø (4):
      riscv: use lw when reading int cpu in new_vmalloc_check
      riscv, bpf: use lw when reading int cpu in BPF_MOV64_PERCPU_REG
      riscv, bpf: use lw when reading int cpu in bpf_get_smp_processor_id
      riscv: use lw when reading int cpu in asm_per_cpu

 arch/riscv/Kconfig                     | 2 +-
 arch/riscv/include/asm/asm.h           | 2 +-
 arch/riscv/include/asm/uaccess.h       | 8 ++++----
 arch/riscv/kernel/entry.S              | 2 +-
 arch/riscv/kernel/kexec_elf.c          | 4 ++--
 arch/riscv/kernel/kexec_image.c        | 2 +-
 arch/riscv/kernel/machine_kexec_file.c | 2 +-
 arch/riscv/net/bpf_jit_comp64.c        | 4 ++--
 drivers/acpi/riscv/cppc.c              | 4 ++--
 9 files changed, 15 insertions(+), 15 deletions(-)
--8323329-1855849172-1757110411=:9369--

