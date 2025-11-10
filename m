Return-Path: <linux-kernel+bounces-892303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CCB8C44D00
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:59:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09D29188D113
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C01D2405E7;
	Mon, 10 Nov 2025 02:59:29 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0029823C506
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762743568; cv=none; b=HISJzvo+MDaRBKj1fDTasWaw/jPG16cBUsMgB4a0J069vS2Ct75S0+9PkePnSPXI8/pSBYgINCYrM8R7rHS+Oci+k1oxzfK9Pi18cDGSWVvoCbH0OIGqhQ8BXX+tissQ9rLZYuyjv8Oh6uq2zNvvcl9WMhB4MsOow/BA1K+3u6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762743568; c=relaxed/simple;
	bh=VpWqPM9spr1XgP8yOcguwsrXuP9/CaDRj/HqlbbJ4jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LYlOdpT1914zY2sqo+ECIFmP0bmD3hfB15pLyETP/T99mvTOu8artgIbsk874d5FAE7UFgO2DSNHw96x0gUYs7/IDeLO8nK69w9w2IdvcO89EEdnqfgVK4RNW1cTdf9QAtVYRx8PDXenlfOVMrwSYev+207X7z/NzJSRV838eYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8Cxf9MHVRFpxkEhAA--.5935S3;
	Mon, 10 Nov 2025 10:59:19 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCxXMH7VBFp6YktAQ--.14886S4;
	Mon, 10 Nov 2025 10:59:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] LoongArch: Detect PMU bits via CPUCFG instruction
Date: Mon, 10 Nov 2025 10:59:06 +0800
Message-ID: <20251110025906.17096-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20251110025906.17096-1-yangtiezhu@loongson.cn>
References: <20251110025906.17096-1-yangtiezhu@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxXMH7VBFp6YktAQ--.14886S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7CryUXrWrKF1kuw1DJFW7Jrc_yoW8ur4xpr
	WDZrn0gF48Krsayw1Dt345Wr1UJrZ7Gr4a9F12y3y8CF43XrWkXF18Gr9xXF1UKa18CFy0
	qan5W3W2qa47AabCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6x
	kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcsjjDUUUU

Detect the value of PMU bits via CPUCFG instruction according to
the ISA manual instead of hard-coded as 64, because the value may
be different for various micro-architectures.

Link: https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#_cpucfg
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/include/asm/loongarch.h | 1 +
 arch/loongarch/kernel/perf_event.c     | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index 2d0c14bdadda..9d257c8519c9 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -845,12 +845,13 @@ static const struct loongarch_perf_event *loongarch_pmu_map_raw_event(u64 config
 
 static int __init init_hw_perf_events(void)
 {
-	int counters;
+	int bits, counters;
 
 	if (!cpu_has_pmp)
 		return -ENODEV;
 
 	pr_info("Performance counters: ");
+	bits = ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMBITS) >> CPUCFG6_PMBITS_SHIFT) + 1;
 	counters = ((read_cpucfg(LOONGARCH_CPUCFG6) & CPUCFG6_PMNUM) >> CPUCFG6_PMNUM_SHIFT) + 1;
 
 	loongarch_pmu.num_counters = counters;
@@ -867,7 +868,7 @@ static int __init init_hw_perf_events(void)
 	on_each_cpu(reset_counters, NULL, 1);
 
 	pr_cont("%s PMU enabled, %d %d-bit counters available to each CPU.\n",
-			loongarch_pmu.name, counters, 64);
+			loongarch_pmu.name, counters, bits);
 
 	perf_pmu_register(&pmu, "cpu", PERF_TYPE_RAW);
 
-- 
2.42.0


