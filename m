Return-Path: <linux-kernel+bounces-851960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30145BD7CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 267734F9569
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C962D5C9E;
	Tue, 14 Oct 2025 07:02:46 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04F763043C0
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760425365; cv=none; b=k5UkzWLP0u/BW+iR3c6pdtlykkXscPla0WOPsklSsroUsRZF3PgeD9ahtFoNKIXQpTFDskMNNh1lN3TRZ17ekEwrmcKW3svhPeviuo+BgjpPX46cZ95TRzBNk6rb7DpWsJmoEggkeArCTz3NQKprUeGX90RZg4UphIwXUkSACrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760425365; c=relaxed/simple;
	bh=y9Y6O8hfCDzT76c4seGWeaubHai+VPjb8cx8iSnw+6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qH05dNw2xwWzQO/tCdpx02aH+U04LeYY+IxkIoBVAxQzw0RAbxQu0ycjd85BPTt0YdzQuYRK7RBCvK06Qx0SiPTkhKgTOPxqIBVOL3WofFp4ywECk85W8NLIgXtkf0QShRBud8nEz+We1Fwlk2mMuvLo4o/HcvZki0gkgvRO77M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cx5tCG9e1oQOgVAA--.46962S3;
	Tue, 14 Oct 2025 15:02:30 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJAxfcGD9e1odRLhAA--.49445S2;
	Tue, 14 Oct 2025 15:02:28 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] LoongArch: Refine init_hw_perf_events()
Date: Tue, 14 Oct 2025 15:02:27 +0800
Message-ID: <20251014070227.22396-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxfcGD9e1odRLhAA--.49445S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr4xtF15Zr13Ar48Gw1xZwc_yoW5Wr18pr
	ZFvrsYgr40grn2yw1Dt345WryUJrn7uFWagFnxt3yxCFs8XrW5X3WkG3s8XF1rKw48CFyI
	qan5Wa43Xa47ZabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=

(1) Use the existing CPUCFG6_PMNUM_SHIFT macro definition instead of
the magic value 4 to get the PMU number.

(2) Detect the value of PMU bits via CPUCFG instruction according to
the ISA manual instead of hard-coded as 64, because the value may be
different for various microarchitectures.

(3) Rename the PMU name without the postfix 64 due to it is redundant
and may be inaccurate.

Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_cpucfg
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 1 +
 arch/loongarch/kernel/perf_event.c     | 8 +++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/loongarch/include/asm/loongarch.h b/arch/loongarch/include/asm/loongarch.h
index 09dfd7eb406e..89343b1a526f 100644
--- a/arch/loongarch/include/asm/loongarch.h
+++ b/arch/loongarch/include/asm/loongarch.h
@@ -128,6 +128,7 @@
 #define  CPUCFG6_PMNUM			GENMASK(7, 4)
 #define  CPUCFG6_PMNUM_SHIFT		4
 #define  CPUCFG6_PMBITS			GENMASK(13, 8)
+#define  CPUCFG6_PMBITS_SHIFT		8
 #define  CPUCFG6_UPM			BIT(14)
 
 #define LOONGARCH_CPUCFG16		0x10
diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 8ad098703488..ee5404d28423 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -846,18 +846,20 @@ static const struct loongarch_perf_event *loongarch_pmu_map_raw_event(u64 config
 static int __init init_hw_perf_events(void)
 {
 	int counters;
+	int bits;
 
 	if (!cpu_has_pmp)
 		return -ENODEV;
 
 	pr_info("Performance counters: ");
-	counters = ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMNUM) >> 4) + 1;
+	counters = ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT) + 1;
+	bits = ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMBITS) >> CPUCFG6_PMBITS_SHIFT) + 1;
 
 	loongarch_pmu.num_counters = counters;
 	loongarch_pmu.max_period = (1ULL << 63) - 1;
 	loongarch_pmu.valid_count = (1ULL << 63) - 1;
 	loongarch_pmu.overflow = 1ULL << 63;
-	loongarch_pmu.name = "loongarch/loongson64";
+	loongarch_pmu.name = "loongarch/loongson";
 	loongarch_pmu.read_counter = loongarch_pmu_read_counter;
 	loongarch_pmu.write_counter = loongarch_pmu_write_counter;
 	loongarch_pmu.map_raw_event = loongarch_pmu_map_raw_event;
@@ -867,7 +869,7 @@ static int __init init_hw_perf_events(void)
 	on_each_cpu(reset_counters, NULL, 1);
 
 	pr_cont("%s PMU enabled, %d %d-bit counters available to each CPU.\n",
-			loongarch_pmu.name, counters, 64);
+			loongarch_pmu.name, counters, bits);
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 
-- 
2.42.0


