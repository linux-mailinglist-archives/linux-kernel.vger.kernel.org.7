Return-Path: <linux-kernel+bounces-727250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39686B01714
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:01:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51E171C43FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCFB217666;
	Fri, 11 Jul 2025 09:01:49 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794E1B87F2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224509; cv=none; b=f43evCVtFDJwuZrKcE4spMZTrIId8whyPhV6yn8Yo126EQspeL5Q5YpIn1Wron5O0i1aFiFLCFtF6SWrA7yBgWnWjzQmMX3wrkuG+uDW7kraqTLPy1EqU/VjZg+Ur0bFWkwVDvSrasieObNPbbkTMxMJLwKkeO7Hga55aoc4HGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224509; c=relaxed/simple;
	bh=pOVYx6iTmc59fYpDyJvs9ThfrlbfhiSd9g60QwJ6Dnk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nlilVevJS4Gx00XVT3p6ZIh2bi2SvTpFJVOb6XpwbIRV8+cj8mt8JLiKk1bBXIsEkS2zmrFhR5WUkqRFUdYsnlCani2jVZRxooA188+MSnCFO9sJOV3bI8fOKlFzEvgZF+blsm4V1sJTMRvkT75hxamlTijg5dbfwDLbymumNg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bdm152JZTzKHMyh
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:01:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D3A2B1A01A6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 17:01:43 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgAniCX20nBoaA1uBQ--.5260S2;
	Fri, 11 Jul 2025 17:01:43 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Pu Lehui <pulehui@huawei.com>
Subject: [PATCH -next] riscv: Enable ARCH_HAVE_NMI_SAFE_CMPXCHG
Date: Fri, 11 Jul 2025 09:04:43 +0000
Message-Id: <20250711090443.1688404-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAniCX20nBoaA1uBQ--.5260S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GrWDuw13AF18GFy5ZFW5ZFb_yoWDtrc_C3
	ykKa48GFyfCa4v9FZ2gr4rKr45Gw48Wr95GF4jvry7uw1xWwn3WanrKFn8ZF13Aw4DXFWf
	Z39YvrnrKr1DXjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbzkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjVbkUUUUU=
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

The implement of cmpxchg() in riscv is based on atomic primitives and
has NMI-safe features, so it can be used safely in the in_nmi context.
ftrace's ringbuffer relies on NMI-safe cmpxchg() in the NMI context.
Currently, in_nmi() is true when riscv kprobe is in trap-based mode, so
this config needs to be selected, otherwise kprobetrace will not be
available.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/riscv/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 36061f4732b7..0e2dfa98338a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -23,6 +23,7 @@ config RISCV
 	select ARCH_ENABLE_MEMORY_HOTREMOVE if MEMORY_HOTPLUG
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
+	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CRC32 if RISCV_ISA_ZBC
 	select ARCH_HAS_CRC64 if 64BIT && RISCV_ISA_ZBC
-- 
2.34.1


