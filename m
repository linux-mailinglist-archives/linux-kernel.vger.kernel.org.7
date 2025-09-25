Return-Path: <linux-kernel+bounces-831999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B95B9E1DD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDAF1B27A40
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55CA279335;
	Thu, 25 Sep 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RpkcPUG6"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C388C278772
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790124; cv=none; b=K9KubKZsHZJOjAS+/G7D943BvvhnCiUSRMbZ4CbjUes1UfDJrZcLBHpNR/UWGoBKML9CJVhiNqDYJe39xpqNrXPh+kIKdnllOZf1Bw9+CGBS6cWUEvj70s4uLvscWpjjpEO/WpLKUP8ci8I5Mv7xTI4X0W1+/oomorTTenLeWHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790124; c=relaxed/simple;
	bh=rfT/UnolT2+BKHZylLOfQE/YMmzeQ4dYHqdSX/rrlS4=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vEd0Z03xqnVpPFWDz5v8Kisqu6w54H4yoos3SwFnExYiSoWKFcrVroYmGVUKkFkL0/CgfF9sIQqSmFbN0f10frgfb7gW44IBMkkkrEo0AtKpgZNuHPvIwbKpu8B33g2ewKubavwF4A7wpNqMK1qSzrUdXIv7RYH5uOLRUt6W4Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RpkcPUG6; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f343231fcso467949b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1758790122; x=1759394922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Ub+joKWJDAfsvLrnMb0mGFn8U6flakDwqgSsOBFKpo=;
        b=RpkcPUG6t0yNyFnUytqgxLmzHVC03pRmJ/vSNCJYoQET1G6g+d53uTN3kKT8WmFYIf
         ZBJC4E2SIfaTdNms3twzjbtBx5BTjxtZUlVlJkyScT0pPGri61rDlvzXSg6HqDZj+hB1
         HiIClQZXiZzYEW2hu+P91Ncqsbn1q3SpJMAYAWEc67bml/UXW1MBxWeKF/ReZ3JMywtD
         sP9oWVNFEahEEqA+/12mzuPUldym8AKYqvtWj7dgLJF1CufwzrtAJ13bu9KDqOv9M21h
         w683IAfMSGN/T99F2SIjjytqGSdAKJSBZ0mMG4WtQxIbsFoOSmDpiLRCZwuD3F4foFVe
         FMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758790122; x=1759394922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Ub+joKWJDAfsvLrnMb0mGFn8U6flakDwqgSsOBFKpo=;
        b=kBKjG4s/diVqfE3ubQAguXuKbto67pOPOR3cqfSXtCJFL0WB9BYzXkT7ZN3hN7kato
         0eiwWDypIkoxoI3woMzR1yEeHiJijAXk1tAYOW4Tu5iD+mSQCmGBXtU6CHyNl9zUEExN
         agjQvBWrWeRWNi89IyU8vplz5mJzTiAkddtvO24dZsNMVgmt0M3p3vFUPiLxZ0zczzYw
         AemCD6nfU0Hx/mgs9p5dbAJQW5D7S7A1jg9nvSC5KnRe6fF1v+jm3qTXnZgLLs2rSzlD
         SyFcuY9t832bxkSaaQ3jpGG/Ic0HX0DZdGgpQXJrzOoimOH8+F5doGy0HxPGBPi7lwzh
         Hp5g==
X-Forwarded-Encrypted: i=1; AJvYcCU7fxMYaAwjuRLqGKo0HWaVrgnI54n6gBd9YHN7bYrpQDQtn44xa5o4VTOffmfld8G8Mm/enQY4SCc/BFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrrV9GynxAmDcQKKNOi+vy5/itGFqg80xyxC30DmPNr9JANMji
	SE8cQGmjpdNA03duKwMXCGTBnulEtYsYC07EZP0/wANHMplsvjZZpBIFTV1No6t6JlA=
X-Gm-Gg: ASbGncu8/wRwC2AzOGltbFQRTG9asF6dx/Vrtpy1e0aSkg9xl/yOK7S6lxqBlqo/Wam
	4XHp/GbtosopxyNQgzJHIKoTuQmyDQE82MdE8L3C3kPo8udSuzuWn+7ueNlFyFwZp5uofmbNR6C
	naXB7FQpXsPcKeW8QZOz4/i2TcQYygtym38icv7IAjjR+jmZGwqlNktY9wt66am5kQJxKKaOjbt
	dD/X3kOWk/xvnz1YbLeLXOnfTYuAf91qqliM8nM8OS4+6rURzd9H6flRa7YISOtalXDkoiiqAXc
	BpzU2wCD0mTCPQDAONTWCQ6piaXXG10L1wLVBhDFrYc6iUcjalPSbxEqgZOXVGrXr4PlF6HXfFU
	H8xpWSjNsmpifBeTYMmmslvxUwaLhl3Jkg8nZi3sB8T8zOHuGcP1g4aSuh1dn
X-Google-Smtp-Source: AGHT+IEGSkHjuRa7OGjamv0g/2mmAckOVuB2U/CUDAe2j089bjTc0cZKoTa5Cf1LNp+M5twG0RcAdQ==
X-Received: by 2002:a05:6a20:a127:b0:220:10e5:825d with SMTP id adf61e73a8af0-2e7bfc1d570mr3624129637.8.1758790121907;
        Thu, 25 Sep 2025 01:48:41 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023ec6aasm1321867b3a.46.2025.09.25.01.48.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Sep 2025 01:48:41 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: akpm@linux-foundation.org,
	alex@ghiti.fr,
	anup@brainfault.org,
	aou@eecs.berkeley.edu,
	atish.patra@linux.dev,
	catalin.marinas@arm.com,
	cuiyunhui@bytedance.com,
	dianders@chromium.org,
	johannes@sipsolutions.net,
	lihuafei1@huawei.com,
	mark.rutland@arm.com,
	masahiroy@kernel.org,
	maz@kernel.org,
	mingo@kernel.org,
	nicolas.schier@linux.dev,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	suzuki.poulose@arm.com,
	thorsten.blum@linux.dev,
	wangjinchao600@gmail.com,
	will@kernel.org,
	yangyicong@hisilicon.com,
	zhanjie9@hisilicon.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Thu, 25 Sep 2025 16:48:06 +0800
Message-Id: <20250925084806.89715-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250925084806.89715-1-cuiyunhui@bytedance.com>
References: <20250925084806.89715-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 arch/riscv/Kconfig           |  3 +++
 drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index badbb2b366946..bb4e8c5a18717 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -186,6 +186,9 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
 	select HAVE_PERF_REGS
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index c852f64a50221..0c7c5924687c9 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -22,6 +22,7 @@
 #include <linux/sched/clock.h>
 #include <linux/soc/andes/irq.h>
 #include <linux/workqueue.h>
+#include <linux/nmi.h>
 
 #include <asm/errata_list.h>
 #include <asm/sbi.h>
@@ -1192,6 +1193,13 @@ static int pmu_sbi_setup_sse(struct riscv_pmu *pmu)
 }
 #endif
 
+#ifdef CONFIG_HARDLOCKUP_DETECTOR_PERF
+bool arch_perf_nmi_is_available(void)
+{
+	return IS_ENABLED(CONFIG_RISCV_PMU_SBI_SSE);
+}
+#endif
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
@@ -1618,6 +1626,8 @@ static int __init pmu_sbi_devinit(void)
 	/* Notify legacy implementation that SBI pmu is available*/
 	riscv_pmu_legacy_skip_init();
 
+	lockup_detector_retry_init();
+
 	return ret;
 }
 device_initcall(pmu_sbi_devinit)
-- 
2.39.5


