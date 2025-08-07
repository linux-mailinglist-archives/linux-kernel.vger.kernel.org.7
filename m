Return-Path: <linux-kernel+bounces-758828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A40B1D44A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 10:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64233A62C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 08:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFC5233133;
	Thu,  7 Aug 2025 08:31:44 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C218FC92
	for <linux-kernel@vger.kernel.org>; Thu,  7 Aug 2025 08:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754555504; cv=none; b=jq+Nh7U1hqkCdmL2Dm4gJAAj17x0mFtbjI7dwjMWOrr6zr4McHiy0CzGq48oqD/bbxz0WXn5NgKi4smwLq8R6R8B3bRUJrCZFOMMETm4A0fFOBapHOuaSXx0vSczxOZ3jBAMhWkx+6EkyPkbtFyXdUxTnNElRwU0R0C7q5NKnYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754555504; c=relaxed/simple;
	bh=4Jg5lc9nbFADaZwb+r0P3PukyvOtGwl2j3EmdsuGanU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=U2eH2bFhnWKqW1pZ3XULsj7hMFiCLMHkYkUVkPHOiuoh4vL46ZP5nZlH+9cOtRkO5+b2CuJwy7yn58veKbIZtJlUiXYReAg5HDHal+Ilcl1Y1Fm960laT5Wo1oL383nEQi/oBgXDlibqQ0JrxDjULqtrksps3ubk+SO7Xo9PxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.69.45])
	by gateway (Coremail) with SMTP id _____8AxLOJgZJRorG06AQ--.7878S3;
	Thu, 07 Aug 2025 16:31:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.69.45])
	by front1 (Coremail) with SMTP id qMiowJDxscJEZJRoeWk6AA--.31081S2;
	Thu, 07 Aug 2025 16:31:20 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.17
Date: Thu,  7 Aug 2025 16:30:50 +0800
Message-ID: <20250807083051.178877-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxscJEZJRoeWk6AA--.31081S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxJFWfWrWxuw1kCrW3JF1fGrX_yoW5Ar4UpF
	y3ursxGF4DGrs8Xw1Dt343WFn0yF1fGry3Xa1akry8CrW3Zr1UXr1xXF93JF98J3yrJry0
	qr1rGw13KF1UAacCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcpBTUUUUU

The following changes since commit 038d61fd642278bab63ee8ef722c50d10ab01e8f:

  Linux 6.16 (2025-07-27 14:26:38 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.17

for you to fetch changes up to d35ec48fa6c8fe0cfa4a03155109fec7677911d4:

  LoongArch: vDSO: Remove -nostdlib complier flag (2025-08-05 19:00:22 +0800)

----------------------------------------------------------------
LoongArch changes for v6.17

1, Complete KSave registers definition;
2, Support the mem=<size> kernel parameter;
3, Support BPF dynamic modification & trampoline;
4, Add MMC/SDIO controller nodes in dts;
5, Some bug fixes and other small changes.

----------------------------------------------------------------
Binbin Zhou (3):
      LoongArch: dts: Add SDIO controller support to Loongson-2K0500
      LoongArch: dts: Add SDIO controller support to Loongson-2K1000
      LoongArch: dts: Add eMMC/SDIO controller support to Loongson-2K2000

Chenghao Duan (4):
      LoongArch: Add larch_insn_gen_{beq,bne} helpers
      LoongArch: BPF: Rename and refactor validate_code()
      LoongArch: BPF: Add dynamic code modification support
      LoongArch: BPF: Add basic bpf trampoline support

Haoran Jiang (2):
      LoongArch: BPF: Fix jump offset calculation in tailcall
      LoongArch: BPF: Fix the tailcall hierarchy

Huacai Chen (2):
      Merge tag 'bpf-next-6.17' into loongarch-next
      LoongArch: Make relocate_new_kernel_size be a .quad value

Ming Wang (1):
      LoongArch: Support mem=<size> kernel parameter

Thomas Weißschuh (1):
      LoongArch: Don't use %pK through printk() in unwinder

Tiezhu Yang (2):
      LoongArch: BPF: Add struct ops support for trampoline
      LoongArch: BPF: Set bpf_jit_bypass_spec_v1/v4()

Wentao Guan (1):
      LoongArch: vDSO: Remove -nostdlib complier flag

Yanteng Si (1):
      LoongArch: Complete KSave registers definition

Yao Zi (1):
      LoongArch: Avoid in-place string operation on FDT content

 arch/loongarch/boot/dts/loongson-2k0500-ref.dts |   9 +
 arch/loongarch/boot/dts/loongson-2k0500.dtsi    |  28 +-
 arch/loongarch/boot/dts/loongson-2k1000-ref.dts |  13 +
 arch/loongarch/boot/dts/loongson-2k1000.dtsi    |  24 +-
 arch/loongarch/boot/dts/loongson-2k2000-ref.dts |  10 +
 arch/loongarch/boot/dts/loongson-2k2000.dtsi    |  18 +
 arch/loongarch/include/asm/inst.h               |   3 +
 arch/loongarch/include/asm/loongarch.h          |   7 +
 arch/loongarch/kernel/env.c                     |  13 +-
 arch/loongarch/kernel/inst.c                    |  74 +++
 arch/loongarch/kernel/relocate_kernel.S         |   2 +-
 arch/loongarch/kernel/setup.c                   |  18 +-
 arch/loongarch/kernel/unwind_orc.c              |   2 +-
 arch/loongarch/net/bpf_jit.c                    | 701 +++++++++++++++++++++---
 arch/loongarch/net/bpf_jit.h                    |   6 +
 arch/loongarch/vdso/Makefile                    |   2 +-
 16 files changed, 841 insertions(+), 89 deletions(-)


