Return-Path: <linux-kernel+bounces-847696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD2DBCB6D6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 04:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82953A46AE
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 02:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C66F2517B9;
	Fri, 10 Oct 2025 02:29:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052924A047;
	Fri, 10 Oct 2025 02:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760063350; cv=none; b=PjIFpXyokxXvf70/uMlVIYmLNioF409dH6h7V/jmUo4Mmz84BC8Rc8OVaChUgv2H1hmcZMamDu3r6DQsxOh0uK4epHgKK4vHAAZ1fw638NBWQhh1fEx/lkCXv5KxbRlkH7iTvq7rIheIda1xXuO5AAolE1wdckwpNDXdGhDo3e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760063350; c=relaxed/simple;
	bh=bHwkYH/zaO4ohrvY74ltRru3hW8ph/UMjhR3E3/0RIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koYVR+fL7eTx7Idp3wNj98fIvLYBSh65qBLdXrzpKSf+XnZkVL+Gp6dbB2mLMK9Z4esJQP/SCuVN9XEoOSBUj4JOguNR7VlxLDNqwQdAJjEOLX61P3hRmIqBvUrmeMQsnqRmFhFr6CqFFT0BkgUdt/Jp+HHokNtOm3CRuxkc9Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.57.136])
	by gateway (Coremail) with SMTP id _____8BxG9Jtb+hoWIYUAA--.42626S3;
	Fri, 10 Oct 2025 10:29:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.57.136])
	by front1 (Coremail) with SMTP id qMiowJDxQ+Rfb+hoHsHXAA--.20307S2;
	Fri, 10 Oct 2025 10:28:47 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	corbet@lwn.net,
	alexs@kernel.org,
	si.yanteng@linux.dev,
	tglx@linutronix.de,
	jiaxun.yang@flygoat.com,
	peterz@infradead.org,
	wangliupu@loongson.cn,
	lvjianmin@loongson.cn,
	maobibo@loongson.cn,
	siyanteng@cqsoftware.com.cn,
	gaosong@loongson.cn,
	yangtiezhu@loongson.cn
Cc: loongarch@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH v5 0/2]  Loongarch irq-redirect support
Date: Fri, 10 Oct 2025 10:28:39 +0800
Message-ID: <20251010022845.140234-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxQ+Rfb+hoHsHXAA--.20307S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4UKr1DZry5Cr1UJF1rXwc_yoWrJr18pF
	W7uasYyrs0kr4xCFn7Wa18uFy3GrykG3y2q3Wak347uwn8uryqqF10kF98ZFy8Gw4rK3WI
	qr4Yq34DW3WDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUUD529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r126r1DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q
	6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU4YLvDUUUU

This series of patches introduces support for interrupt-redirect
controllers, and this hardware feature will be supported on 3C6000
for the first time

change log:
        v0->v1:
        1.Rename the model names in the document.
        2.Adjust the code format.
        3.Remove architecture - specific prefixes.
        4.Refactor the initialization logic, and IR driver no longer set 
	  AVEC_ENABLE.
        5.Enhance compatibility under certain configurations.

        v1->v2:
        1.Fixed an erroneous enabling issue.

        v2->v3
        1.Replace smp_call with address mapping to access registers
        2.Fix some code style issues

        v3->v4
        1.Provide reasonable comments on the modifications made to
	  IRQ_SET_MASK_OK_DONE
        2.Replace meaningless empty functions with parent_mask/unmask/ack
        3.Added and indeed released resources
        4.Added judgment for data structure initialization completion to 
          avoid duplicate creation during cpuhotplug
        5.Fixed the code style and some unnecessary troubles

        v4->v5
	1.when it is detected in avecintc_set_affinity that the current affinity
	remains valid, the return value is modified to IRQ_SET_MASK_OK_DONE.
	  After the introduction of redirect-domain, for each interrupt source, 
	avecintc-domain only provides the CPU/interrupt vector, while redirect-domain 
	provides other operations to synchronize interrupt affinity information 
	among multiple cores. 	  The original intention is to notify the cascaded
	redirect_set_affinity that multi-core synchronization is not required. 
	  However, this introduces some compatibility issues, such as the new return
	value causing msi_domain_set_affinity to no longer perform irq_chip_write_msi_msg.
	  1) When redirect exist in the system, the msi msg_address and msg_data no 
	longer changes after the allocation phase, so it does not actually require updating
	the MSI message info.
	  2) When only avecintc exists in the system, the irq_domain_activate_irq
	interface will be responsible for the initial configuration of the MSI message,
	which is unconditional. After that, if unnecessary, no modification to the MSI
	message is alse correctly.

	2.Restructured the macro definitions to make them appear more logical.

	3.Adjusted the layout of members struct redirect_queue\struct redirect_table and 
	struct redirect_item, making redirect_item the primary interface for accessing
	other members.

	4.The method of accessing registers has been standardized to MMIO.

	5.Initialize variables at declaration whenever possible.

	6.Replaced the the "struct page" in redirect_table and redirect_queue with "struct folio".

	7.Adjusted the initialization process so that all irq_desc configurations are completed
	during driver initialization, no longer relying on specific CPUs being online.

	8.Refactored portions of the code to make them more concise and logical.

Tianyang Zhang (2):
  Docs/LoongArch: Add Advanced Extended-Redirect IRQ model description
  irqchip/irq-loongarch-ir:Add Redirect irqchip support

 .../arch/loongarch/irq-chip-model.rst         |  38 ++
 .../zh_CN/arch/loongarch/irq-chip-model.rst   |  37 ++
 arch/loongarch/include/asm/cpu-features.h     |   1 +
 arch/loongarch/include/asm/cpu.h              |   2 +
 arch/loongarch/include/asm/loongarch.h        |   6 +
 arch/loongarch/kernel/cpu-probe.c             |   2 +
 drivers/irqchip/Makefile                      |   2 +-
 drivers/irqchip/irq-loongarch-avec.c          |  20 +-
 drivers/irqchip/irq-loongarch-ir.c            | 527 ++++++++++++++++++
 drivers/irqchip/irq-loongson.h                |  19 +
 10 files changed, 640 insertions(+), 14 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-ir.c

-- 
2.41.0


