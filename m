Return-Path: <linux-kernel+bounces-884243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F551C2FBA4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 08:56:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D774A1896690
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2A93101C0;
	Tue,  4 Nov 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hENdKQ21"
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38E030AAB8
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762242951; cv=none; b=qxeuvffHUkWKLkvsd/6Gc64jPC53J4muI/7OHcC5xGlTqnUueM/vWd1XqPAcVW6U6w3vbRzoziRHLj93GuI0gjngRGN/49AoUze2rvNal2EBgRRc6VCbYxaF1B1mT8ltXFa4C1X8Nns1t62+rWTc5j1F52oUeBk33yMyMvAfsGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762242951; c=relaxed/simple;
	bh=LeOCGfywwihtrz0pnZKuzKShPA8snZlvMlYADmne93A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwI7b8begDwFmgcisOsBvYQesbOU2s8yOTiuWeTD/GVjmX9MmFvMNd49ceKsNoTDQ3+e6riYPg1dVBPlXXNgiKxiqPZ8addoJ8mO/57oqp5LSOtcX+0vnmwF4Tyb+EeJkcqDIkoBETma5D/qX1fAw4xs1ZGj/Wx0OKEcffgh7FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hENdKQ21; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=cidHgw/xNGXgeS5+lrmSBrk6DyPCnvca9eh+9hpl+R8=;
	b=hENdKQ21rju/zb8MhykSFu6NqS1dTitxvcgSSFh+6qRW46PkB6uVMoqpkV0UatHtAVtprwMXc
	M3X0r4upH4dyMSQVCI8u2AM5d/FtlpGDReGiB0SX/XXsy43t+xgaFwhnctwVSvTuMHKSVcliS0c
	dPI2sWcUC0K4VAysceTtyNg=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4d111b5RD9zmV8q;
	Tue,  4 Nov 2025 15:54:11 +0800 (CST)
Received: from kwepemk500012.china.huawei.com (unknown [7.202.194.97])
	by mail.maildlp.com (Postfix) with ESMTPS id 77B75140158;
	Tue,  4 Nov 2025 15:55:46 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500012.china.huawei.com (7.202.194.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 4 Nov 2025 15:55:45 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <beata.michalska@arm.com>,
	<ptsm@linux.microsoft.com>, <linuxarm@huawei.com>,
	<jonathan.cameron@huawei.com>
CC: <zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <zhenglifeng1@huawei.com>,
	<yubowen8@huawei.com>, <zhangpengjie2@huawei.com>
Subject: [PATCH 1/3] arm64: topology: Improve AMU-based frequency calculation
Date: Tue, 4 Nov 2025 15:55:42 +0800
Message-ID: <20251104075544.3243606-2-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20251104075544.3243606-1-yubowen8@huawei.com>
References: <20251104075544.3243606-1-yubowen8@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500012.china.huawei.com (7.202.194.97)

The current approach of reverse-calculating CPU frequency from capacity
values introduces quantization errors due to intermediate scaling of
arch_scale_freq_capacity, which results in the calculated frequency having
only 1/1024 resolution.

This patch:
1. Directly computes frequency using AMU counters in amu_scale_freq_tick():
freq = (core_cycles_delta * timer_freq) / (const_cycles_delta * 1000)
 - core_cycles_delta: Measured CPU cycles
 - timer_freq: Architectural timer frequency
 - const_cycles_delta: Reference cycles from fixed-frequency timer
2. Returns pre-computed avgfreq in arch_freq_get_on_cpu()

examples:
Before change
[root@localhost ~]# cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_avg_freq
2297851
2297851
2295312
2297851
2297851
2295312
2297851
2295312
2297851
2297851
2297851
2295312
2295312
2297851
2297851
2297851
2297851
2300390
2297851
2297851
2297851

After change
[root@localhost ~]# cat /sys/devices/system/cpu/cpufreq/policy*/cpuinfo_avg_freq
2299177
2298117
2299188
2297330
2296530
2298817
2298434
2298986
2298596
2299395
2299560
2298446
2299108
2299294
2298707
2298453
2298632
2299218
2297962

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 arch/arm64/kernel/topology.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 5d07ee85bdae..c0dbc27289ea 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -20,6 +20,7 @@
 #include <linux/percpu.h>
 #include <linux/sched/isolation.h>
 #include <linux/xarray.h>
+#include <linux/units.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -144,6 +145,8 @@ int __init parse_acpi_topology(void)
  */
 static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) =  1UL << (2 * SCHED_CAPACITY_SHIFT);
 static cpumask_var_t amu_fie_cpus;
+static DEFINE_PER_CPU(unsigned long, core_delta);
+static DEFINE_PER_CPU(unsigned long, const_delta);
 
 struct amu_cntr_sample {
 	u64		arch_const_cycles_prev;
@@ -246,6 +249,7 @@ static void amu_scale_freq_tick(void)
 	 * arch_max_freq_scale and the use of SCHED_CAPACITY_SHIFT.
 	 */
 	scale = core_cnt - prev_core_cnt;
+	this_cpu_write(core_delta, scale);
 	scale *= this_cpu_read(arch_max_freq_scale);
 	scale = div64_u64(scale >> SCHED_CAPACITY_SHIFT,
 			  const_cnt - prev_const_cnt);
@@ -253,6 +257,7 @@ static void amu_scale_freq_tick(void)
 	scale = min_t(unsigned long, scale, SCHED_CAPACITY_SCALE);
 	this_cpu_write(arch_freq_scale, (unsigned long)scale);
 
+	this_cpu_write(const_delta, const_cnt - prev_const_cnt);
 	amu_sample->last_scale_update = jiffies;
 }
 
@@ -288,7 +293,7 @@ int arch_freq_get_on_cpu(int cpu)
 	unsigned int start_cpu = cpu;
 	unsigned long last_update;
 	unsigned int freq = 0;
-	u64 scale;
+	u64 delta_core_kHz;
 
 	if (!amu_fie_cpu_supported(cpu) || !arch_scale_freq_ref(cpu))
 		return -EOPNOTSUPP;
@@ -340,14 +345,11 @@ int arch_freq_get_on_cpu(int cpu)
 			break;
 		}
 	}
-	/*
-	 * Reversed computation to the one used to determine
-	 * the arch_freq_scale value
-	 * (see amu_scale_freq_tick for details)
-	 */
-	scale = arch_scale_freq_capacity(cpu);
-	freq = scale * arch_scale_freq_ref(cpu);
-	freq >>= SCHED_CAPACITY_SHIFT;
+
+	if (check_mul_overflow(per_cpu(core_delta, cpu), arch_timer_get_cntfrq(), &delta_core_kHz))
+		return -EINVAL;
+
+	freq = div_u64(delta_core_kHz, per_cpu(const_delta, cpu) * HZ_PER_KHZ);
 	return freq;
 }
 
-- 
2.33.0


