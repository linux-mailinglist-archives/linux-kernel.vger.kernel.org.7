Return-Path: <linux-kernel+bounces-857497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B2BE6F60
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B14B1562028
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8168D23A98E;
	Fri, 17 Oct 2025 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBrnVN+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44B5239E65
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760686647; cv=none; b=EWcj5hSRFH8TN0FxcD9XR7ibCFN9QyQ1Ge9ev9cWq7jWT1FM2zVC9JdXL5UcincYE2h+FiQ29VC3rIJSSP9mgduoIAe05wWYIx6qGnSn2lph/1VXqjbhd+IlvSG5BFYuBl/9z8ova5MOuJXT07gmdb/Z/GPeijnCoUfvqvu0dIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760686647; c=relaxed/simple;
	bh=dBK7cPC9iAHNs3jlccSM11qLIpnf+7WOuhUQ8BMgHQs=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=f5MIzXuRa0B/AIR8DByq4QvDKQT71mJ6hNW8ssPaUMcUd/YwBsykhIuMSv+IlZRVa5HC3OwK87jqmjJwDV+D5XLlNiyxEdgF+BPaPZ7IRxRdFuJs1Pz1GsThTEJsxWLUW43HD/4gi3+gY1S0edVx+92LY38BU4qtQZ+VkJps8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBrnVN+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AF2C4CEFE;
	Fri, 17 Oct 2025 07:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760686647;
	bh=dBK7cPC9iAHNs3jlccSM11qLIpnf+7WOuhUQ8BMgHQs=;
	h=Date:From:To:cc:Subject:From;
	b=LBrnVN+Gd6VvuVc6t6TIPDtQ4Sp0ej1culVBROwY7WjRDE9wsJoYKHzEo6PoUrcry
	 pQKR1IvYWJWSle5t10+itRAKZ3C0Z25YJzQmplbh2ERno/She+H87eQCgZWux0BEst
	 Q2XtNO3K8HxNm48vLcyIUVhqrjN0ya3WRbZMVK00a3W02NCh5+FTQgm68ra7StjTAE
	 5eViJzh3/xHw+xOcu8lhnVFP0dVtcdUTZNVZyGqW/LYeJoB7oJvBaZJL3BRzzKpt9k
	 u5+73XmXDZ563R689OZ8P26ToB8591LoS3cmolkyEWGKllTiF0RJ4EkYWv5wVDwps9
	 EzhFf4n4VKiMA==
Date: Fri, 17 Oct 2025 01:37:24 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: torvalds@linux-foundation.org
cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RISC-V updates for v6.18-rc2
Message-ID: <f21ca0d7-dd9f-3dc9-34ca-c1444702370a@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1986118873-1760686615=:2568925"
Content-ID: <780db4b4-8477-116f-ab35-9f9db1c1abcd@kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1986118873-1760686615=:2568925
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ba9789f0-4c79-f1c3-ad3a-3b198d8dd505@kernel.org>

Linus,

The following changes since commit 5472d60c129f75282d94ae5ad072ee6dfb7c7246:

  Merge tag 'trace-v6.18-2' of git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace (2025-10-09 12:18:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux tags/riscv-for-linux-6.18-rc2

for you to fetch changes up to 852947be66b826c3d0ba328e19a3559fdf7ac726:

  riscv: kprobes: convert one final __ASSEMBLY__ to __ASSEMBLER__ (2025-10-10 16:04:25 -0600)

----------------------------------------------------------------
RISC-V updates for v6.18-rc2

Some RISC-V fixes for v6.18-rc2, including changes to:

- Disable CFI with Rust for any platform other than x86 and ARM64

- Keep task mm_cpumasks up-to-date to avoid triggering M-mode firmware
  warnings if the kernel tries to send an IPI to an offline CPU

- Improve kprobe address validation performance and avoid desyncs
  (following x86)

- Avoid duplicate device probes by avoiding DT hardware probing when
  ACPI is enabled in early boot

- Use the correct set of dependencies for CONFIG_ARCH_HAS_ELF_CORE_EFLAGS,
  avoiding an allnoconfig warning

- Fix a few other minor issues

----------------------------------------------------------------
Conor Dooley (1):
      rust: cfi: only 64-bit arm and x86 support CFI_CLANG

Danil Skrebenkov (1):
      RISC-V: clear hot-unplugged cores from all task mm_cpumasks to avoid rfence errors

Fabian Vogt (1):
      riscv: kprobes: Fix probe address validation

Florian Schmaus (1):
      riscv: entry: fix typo in comment 'instruciton' -> 'instruction'

Han Gao (1):
      riscv: acpi: avoid errors caused by probing DT devices when ACPI is used

Miquel SabatÈ Sol‡ (1):
      riscv: kgdb: Ensure that BUFMAX > NUMREGBYTES

Paul Walmsley (1):
      riscv: kprobes: convert one final __ASSEMBLY__ to __ASSEMBLER__

Thomas Weiﬂschuh (1):
      riscv: Respect dependencies of ARCH_HAS_ELF_CORE_EFLAGS

 arch/Kconfig                                   |  1 +
 arch/riscv/Kconfig                             |  2 +-
 arch/riscv/include/asm/kgdb.h                  |  9 +++++++--
 arch/riscv/kernel/cpu-hotplug.c                |  1 +
 arch/riscv/kernel/entry.S                      |  2 +-
 arch/riscv/kernel/probes/kprobes.c             | 13 +++++++++----
 arch/riscv/kernel/setup.c                      |  7 +++++--
 arch/riscv/kernel/tests/kprobes/test-kprobes.h |  4 ++--
 8 files changed, 27 insertions(+), 12 deletions(-)

text data bss dec hex filename           
  +8    .   .  +8  +8 vmlinux.rv64       
  +4    .   .  +4  +4 vmlinux.rv64_nosmp 
   .    .   .   .   . vmlinux.rv32       
   .    .   .   .   . vmlinux.rv32_nosmp 
   .    .   .   .   . vmlinux.nommu_virt 
   .    .   .   .   . vmlinux.allnoconfig
   x    x   x   x   x vmlinux.allmodconfig
--8323329-1986118873-1760686615=:2568925--

