Return-Path: <linux-kernel+bounces-851744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE07BD72A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C0664F3D3A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 03:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62C030AD0D;
	Tue, 14 Oct 2025 03:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Xx0hOixa"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC7C309DDB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411715; cv=none; b=irdZ+hVP09ImCTUgwLYDAsKH405iM7FRbWCXgNEvmxNruff4ev5rLIKj2cT3k1ZBg3985rrcA6ZlN7RZ97mS0lI6YZTUWGYHif7sTMmb46My/+hPhiu9LDC63VCLr+PQEkJBE5+6pYNvJH8Jvxzc95X3VLxDFT6UF+Ymy5M8aUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411715; c=relaxed/simple;
	bh=OsVZTQ1MyiSKr3/7iUE60rxwcYFEmk0jXWEJNuaWHSU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mT5ChH5a38ZTIxLiXmK4GgsBs/tNUWVo5k458+hZuMlP6DAQF4NJwc6g2Gguz3LHVRcaFJDMrxl/oCs8RS8ggJEPOvdwIscjpABIuxNuiCQTrJjQiRFsC9S1oGtBzlYlphF6RcUuCNxNtrN3XBYIa1JCN1VqTz0LjIrzaY8GzxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Xx0hOixa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-27d4d6b7ab5so67156595ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1760411711; x=1761016511; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6P8xZEQeIO5H4AzeXprUKU3oEf9nN+exJfE8nbRaRqY=;
        b=Xx0hOixavcFeu6tPsgTydMQDUVjaGTL+jFou2oMet9/laxKUBHnzvZP/kKfzbK+OKX
         5z/B5S7TWtUnysMNccO2p1Y7TA+GbrfyOppkxdNhv2s/mHbH6RiR1aFDcIf9Gv3ZOq4Z
         GufDcxHH9e6Dna9WlgBHLM73h5uNLKqoVQtHS73q2LDqcXqsRspsvvfMXbTsVym6zEpT
         DXDECAHmsM+wv/CzIm4R1kEZYwGBfMySFqmMVjGdCM6ZK66Kh5VXy+xem78m+wKjG/Vo
         zvunj+ZEGI7vxq8cb3ll7luThcIdkTyArY3YGmcjpUcByVz69GycfkH5M9hilYAP6o6j
         +bzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760411711; x=1761016511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6P8xZEQeIO5H4AzeXprUKU3oEf9nN+exJfE8nbRaRqY=;
        b=nroog/cjsksNY2l8s8kHatIfKpsWt6W8kTgT3O3FTw6xFEYq308HBT/Hkex0T+T80A
         rasWHsdVjYaDSo4UB2bRLoQjsyHpCTlQutKSROe2XknDlIuEPe8xuwvncRCJsuTd93wE
         kFrYUDVmIu7VLrVojRd5JgJ98HIjACaNSl1s5kmeL3ea0YmWClYMInmmbK2+vxzp4fPc
         s41CfYBIMn0U4uegvEudVM08lvAxbyIm2C1G70NvhXDZcrJqDJSKvNSY6i7XH1r6OH+Y
         vci5Ox7p67D3uDdjkQtQJqZUyBJTLYsb2lwi0sqtmkvnAdevH1sTLblD6SUZHqwFkbbU
         thgA==
X-Forwarded-Encrypted: i=1; AJvYcCXNoswwY84fDXXFSceu4uOk9wNF71Up1cw1M4/b9XcSLu6SS6XCW/WQem5kvsfUlr7oEYSEzzwVxu82nt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJKNMoIxED5H01gYSVCQ/IKssq0CbEfa2Aln/dzgZIbDHjMt1P
	a2h4M8lK8+xu9afRn/do/5njjmzfFkxhcQdTgwIDY4/RB7ri+gj9CsRLx3udr+VviN4=
X-Gm-Gg: ASbGncv4R5NSwgJBexWRfnp3hK5KLaLHf1nMNhyM4W1GMugxc1DlLcfKbwGFWbtfaIX
	eEjeidh6Wd1pn94UVjU9zIZDMULVSXHGaMJ6v/43adMgn4sdMdo4luYeJoY2fE1WiOpp2i3jTKu
	7TGWPLw3CqtsbSosQlTA6ryrGc449lV+mUCDAIsz2MmlcRgMQb/IItQ8FPmNo23Hnjynl5cvEVr
	99USM6C1/CDe5EBvVi4VNlU/5NTbg1Omi91jnNTvBWInDNTyu7uq2/6pbR1rJb2t6Qh7v30ZAYn
	m4efNbASO1vKP+StbO+T6RzvJP0kiORUZ/cXexOYfpP8wS4ljxyO4iN35KvXpUidRiuXdmWIYO4
	PjpfxkBctojFhBEp6TE2NxPavXikmXPPNNxIap8yO5TR2/jYM9I1wddnFrmYjt2iv41jH7n92S8
	q68XpErf5NAoWxcMPs2LtrrwpIB2c=
X-Google-Smtp-Source: AGHT+IEnhbhgD5wvfXgKIYQpP+Lfyce302o3Owp60kynW6BbE9VY04c0yKjSZIvlB5ornO/n4cUtAg==
X-Received: by 2002:a17:902:ef07:b0:269:82a5:fa19 with SMTP id d9443c01a7336-290272e3adcmr281603745ad.45.1760411710696;
        Mon, 13 Oct 2025 20:15:10 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f3de4asm148315845ad.92.2025.10.13.20.15.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Oct 2025 20:15:10 -0700 (PDT)
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
Cc: Paul Walmsley <pjw@kernel.org>
Subject: [PATCH v4 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Tue, 14 Oct 2025 11:14:25 +0800
Message-Id: <20251014031425.93284-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251014031425.93284-1-cuiyunhui@bytedance.com>
References: <20251014031425.93284-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable the HARDLOCKUP_DETECTOR_PERF function based on RISC-V SSE.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Paul Walmsley <pjw@kernel.org>
---
 arch/riscv/Kconfig           |  3 +++
 drivers/perf/riscv_pmu_sbi.c | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index badbb2b366946..0ae3291b303f9 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -186,6 +186,9 @@ config RISCV
 	select HAVE_PAGE_SIZE_4KB
 	select HAVE_PCI
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_EVENTS_NMI if RISCV_PMU_SBI_SSE
+	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && HAVE_PERF_EVENTS_NMI
+	select WATCHDOG_PERF_ADJUST_PERIOD if HARDLOCKUP_DETECTOR_PERF && CPU_FREQ
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


