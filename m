Return-Path: <linux-kernel+bounces-807769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDA1B4A8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D28B3A8A8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6562D2495;
	Tue,  9 Sep 2025 09:53:38 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0F72D2497
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757411618; cv=none; b=bIzAG3MvocieWWJziXGTiR4aVXrtwCKhyM9XhndXGEAhNW5GWBWT6H3FDB/fSkBTsAsEG77RUFFRE/dw2t1LvotTqUql4sZrbl2rbK/6fDSNsjyWbsC2huUgkZWESVXKnt15mxWiv24N1h3NtLYmzqdR6rhWj9limoHhQ1AT74c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757411618; c=relaxed/simple;
	bh=ksQPdOeqO/0Gc3J/7druQzRD0/2egKekET/Bt/pJQwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Kfrj0Ivl6509CIkN5fuemh28JK1MbR2KuIynGkeAVi2Yi+uMi/3+vNVeQ/JSmJRO3WtETmv1QuW9c4jXRoKjyW25AguQsKFY+7q4RoBIT6pmMq6Xe1j767YpQsy2jRcoT2RZi805vamsYsC4e6t+WpEpjoZCwm/Ff+nNIhH0CgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.89])
	by gateway (Coremail) with SMTP id _____8DxLvAe+b9ollIIAA--.17705S3;
	Tue, 09 Sep 2025 17:53:34 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.89])
	by front1 (Coremail) with SMTP id qMiowJAxleQZ+b9oHPGJAA--.50983S2;
	Tue, 09 Sep 2025 17:53:33 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH] LoongArch: Align ACPI structures if ARCH_STRICT_ALIGN enabled
Date: Tue,  9 Sep 2025 17:53:20 +0800
Message-ID: <20250909095320.4083749-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxleQZ+b9oHPGJAA--.50983S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cr18CF1rJryxXry7Jr43Arc_yoW8Xr1fpa
	na9w4DG3yDGr1vkFs2y397XFs8tFZ8GrW3uF40ga45AF18Z347XrWxtr1DGasxWwn7uryx
	Wrn3tF9rAa45A3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j1YL9UUUUU=

ARCH_STRICT_ALIGN is used for hardware without UAL, now it only control
the -mstrict-align flag. However, ACPI structures are packed by default
so will cause unaligned accesses.

To avoid this, define ACPI_MISALIGNMENT_NOT_SUPPORTED in Makefile to
align ACPI structures if ARCH_STRICT_ALIGN enabled.

Reported-by: Binbin Zhou <zhoubinbin@loongson.cn>
Suggested-by: Xi Ruoyao <xry111@xry111.site>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a3a9759414f4..a86de4f26264 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -147,10 +147,10 @@ ifdef CONFIG_ARCH_STRICT_ALIGN
 # Don't emit unaligned accesses.
 # Not all LoongArch cores support unaligned access, and as kernel we can't
 # rely on others to provide emulation for these accesses.
-KBUILD_CFLAGS += $(call cc-option,-mstrict-align)
+KBUILD_CFLAGS += $(call cc-option,-mstrict-align) -DACPI_MISALIGNMENT_NOT_SUPPORTED
 else
 # Optimise for performance on hardware supports unaligned access.
-KBUILD_CFLAGS += $(call cc-option,-mno-strict-align)
+KBUILD_CFLAGS += $(call cc-option,-mno-strict-align) -UACPI_MISALIGNMENT_NOT_SUPPORTED
 endif
 
 KBUILD_CFLAGS += -isystem $(shell $(CC) -print-file-name=include)
-- 
2.47.3


