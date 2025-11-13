Return-Path: <linux-kernel+bounces-898614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFD4C55989
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC31A4E91FA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024232F7AAC;
	Thu, 13 Nov 2025 03:49:43 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DB8285CB8
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763005782; cv=none; b=E1uI1L4uvZlav/eTybRnP6fHDkUjoxKrFM0riF/w0TbYUR2DJkHum8pfVTo5iAcUKPUFJnTxTlz14OGZiNZqYFp8MAIn9abscSunNZTdVVRcK79dQEAo3rCo0njDvSYm/I5VitWyJwqtCDjte8HKP28cwH5rnU5wxAhjuKkJ20U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763005782; c=relaxed/simple;
	bh=x11Y37J0bS/5OqxW0bzdcQwtXAeG3/BWc48b1Cuzy88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HV3Vxbr5VX0LCfqfCza3pZ1ENcdFgpS4a21ivE1rnXJNsal8QqgjkrtzhoyUV7GA2xQoqAtvyf7onAuBXpknox52ctLSn/noH1JA3GJPBZ+orvKFbRgUczSVqL1KxfJoWklG8snh0VEg77UdKyUCoxE7XUr9FjmIchHznR04Ihc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.40.46.139])
	by gateway (Coremail) with SMTP id _____8BxVNBKVRVp8LciAA--.9811S3;
	Thu, 13 Nov 2025 11:49:30 +0800 (CST)
Received: from localhost.localdomain (unknown [10.40.46.139])
	by front1 (Coremail) with SMTP id qMiowJCxM+REVRVpyDkxAQ--.9432S2;
	Thu, 13 Nov 2025 11:49:24 +0800 (CST)
From: Tianyang Zhang <zhangtianyang@loongson.cn>
To: chenhuacai@kernel.org,
	kernel@xen0n.name,
	akpm@linux-foundation.org,
	willy@infradead.org,
	david@redhat.com,
	linmag7@gmail.com,
	thuth@redhat.com,
	maobibo@loongson.cn,
	apopple@nvidia.com
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tianyang Zhang <zhangtianyang@loongson.cn>
Subject: [PATCH v6 0/2]  Loongarch irq-redirect support
Date: Thu, 13 Nov 2025 11:49:18 +0800
Message-ID: <20251113034923.9699-1-zhangtianyang@loongson.cn>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxM+REVRVpyDkxAQ--.9432S2
X-CM-SenderInfo: x2kd0wxwld05hdqjqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxGF4UKr1DZry5Cr1UJF1rXwc_yoWrJF1kpF
	W7uas5Ars0kr4xCFn7Wa18ZFy3GrykG3y2q3W3C347uwn8Cr1qqF18KF98ZFy8Gw4rK3WI
	qr4qq34DW3WDAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU_529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUtVW8ZwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3
	AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1q6r43MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU5rUUUUUUUU==

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

	v5->v6
	Fix the warning messages reported by the test bot.

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


