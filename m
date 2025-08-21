Return-Path: <linux-kernel+bounces-779730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5FB2F7E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8E693B1C25
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B89F30DD36;
	Thu, 21 Aug 2025 12:26:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE3D8248B
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 12:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755779170; cv=none; b=uFN2Gq5WtHQQYAl1GMQ2WTWE3BZyOrxNixBxINbyuFEHlJBPAHzGVlOFgp2WEFdPEFtoBb4IkJHaDGzh7O0lBrKEr3GutJms/PVOq7m0tNym5zanq7dAt0pk6Et7y8O69ngVb74LU/I8JkP7OCYsVIbn3hxP+7tpJ3z72xQXdak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755779170; c=relaxed/simple;
	bh=YqoTewEht3AiwH7FFwLmhvsXBjLcxSAa1J+T9pF5rb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=URYj2rvK2e8jUk2N2psXCN9svCTjXBIW8PEclypM1WouVzrn03Q4DxPzj9eo9ZhV74HLFDeXqUlipWjTcWefgxB03/0syiEBCFYT189rPpIT0683rmYMAIW+1lUM6VGJRlogvQIRNcnR09IGY1k5iDHnUKfxK5t2+WEtTsUV7i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8Dxvr8AEKdoO24BAA--.1678S3;
	Thu, 21 Aug 2025 20:24:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJCxrsP5D6do3ZldAA--.48716S2;
	Thu, 21 Aug 2025 20:24:31 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch fixes for v6.17-rc3
Date: Thu, 21 Aug 2025 20:24:10 +0800
Message-ID: <20250821122410.1144154-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxrsP5D6do3ZldAA--.48716S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Wry3Xw45Gry7CFy8tryDtwc_yoW5JF4kpF
	13urnxGF4rGrZ3Xwnxt34UWr15Jr1xGr1jqF47K348Cr1UZr1UJr18XrZ7JFyUJ3yrJr10
	qF1rJr1YgFyUJacCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17
	McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_
	JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17
	CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0
	I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I
	8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU
	0xZFpf9x07jepB-UUUUU=

The following changes since commit c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9:

  Linux 6.17-rc2 (2025-08-17 15:22:10 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-fixes-6.17-1

for you to fetch changes up to 538c06e3964a8e94b645686cc58ccc4a06fa6330:

  LoongArch: KVM: Add address alignment check in pch_pic register access (2025-08-20 22:51:15 +0800)

----------------------------------------------------------------
LoongArch fixes for v6.17-rc3

Fix a lot of build warnings for LTO-enabled objtool check, increase
COMMAND_LINE_SIZE up to 4096, rename a missing GCC_PLUGIN_STACKLEAK
to KSTACK_ERASE, and fix some bugs about arch timer, module loading,
LBT and KVM.
----------------------------------------------------------------
Bibo Mao (3):
      LoongArch: KVM: Make function kvm_own_lbt() robust
      LoongArch: KVM: Fix stack protector issue in send_ipi_data()
      LoongArch: KVM: Add address alignment check in pch_pic register access

Huacai Chen (2):
      LoongArch: Save LBT before FPU in setup_sigcontext()
      LoongArch: Rename GCC_PLUGIN_STACKLEAK to KSTACK_ERASE

Kanglong Wang (1):
      LoongArch: Optimize module load time by optimizing PLT/GOT counting

Ming Wang (1):
      LoongArch: Increase COMMAND_LINE_SIZE up to 4096

Song Gao (1):
      LoongArch: KVM: Use kvm_get_vcpu_by_id() instead of kvm_get_vcpu()

Tiezhu Yang (2):
      objtool/LoongArch: Get table size correctly if LTO is enabled
      LoongArch: Pass annotate-tablejump option if LTO is enabled

Xianglai Li (1):
      LoongArch: Add cpuhotplug hooks to fix high cpu usage of vCPU threads

 arch/loongarch/Makefile                 |  6 ++++++
 arch/loongarch/include/asm/stackframe.h |  2 +-
 arch/loongarch/include/uapi/asm/setup.h |  8 ++++++++
 arch/loongarch/kernel/module-sections.c | 36 ++++++++++++++++-----------------
 arch/loongarch/kernel/signal.c          | 10 ++++-----
 arch/loongarch/kernel/time.c            | 22 ++++++++++++++++++++
 arch/loongarch/kvm/intc/eiointc.c       |  7 ++++++-
 arch/loongarch/kvm/intc/ipi.c           |  8 ++++----
 arch/loongarch/kvm/intc/pch_pic.c       | 10 +++++++++
 arch/loongarch/kvm/vcpu.c               |  8 +++++---
 include/linux/cpuhotplug.h              |  1 +
 tools/objtool/arch/loongarch/special.c  | 23 +++++++++++++++++++++
 12 files changed, 109 insertions(+), 32 deletions(-)
 create mode 100644 arch/loongarch/include/uapi/asm/setup.h


