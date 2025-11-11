Return-Path: <linux-kernel+bounces-894804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BB8C4C20D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE6BD4F2636
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 07:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9D4314B8B;
	Tue, 11 Nov 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Nsk5NZQM"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C826332ECC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762846541; cv=none; b=P+6HOzpfE26MapOUOiFGGdL18TSTiNN7Lwj3TJ5MOTPSDj7+XdCvAdxhz2szNPzEppLoR4XwpdIbwx64eR0ccA5xtx6TTKpaUlhWGHW1XWSAaXid31yrPAKbBRL8VxmpBqTsVP6IsZFNZmPMO9jz5+aGDTIxyzenDtUTD8d4YJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762846541; c=relaxed/simple;
	bh=TXw2u5rDDypAuPP/PEkhaT2sUClVbxjCMBkI2ULXV/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hOyKPm2Sy7Dckbof+1Xb8N55psbTZzS+M9CXT3Pt+DhvAUzrkoU4N64OpunlKbvGt7AQgq0TSABIFJo6E1suqa9n6B9/EK6KQgWeejnerR8q81i8oq7Fs4CsnSk4Me7+f/MmDI+kfsClbDoMHTc9UrLrvJJm5rMBIxzJAU9AYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Nsk5NZQM; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3434700be69so5218724a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 23:35:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1762846539; x=1763451339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOOlaVy/20CIon+tjXLAyji+6ZbQKD+NsElw/LVQ6M4=;
        b=Nsk5NZQMIAtTqaGJT8qrDL3svqUHfaFKEvwVZudVvrqD4K80BApHQIh5EKsi7W5fvp
         4DwJ5Szs4NEBylUTAWZ94ibBwQmtcKj7TeCU1dvQqcJkBf+GQjWQ3XZ9LRsmY1YiLT7h
         CftIzSr4fIqj1BVA+SRFWLSZN58aSu/geI65Oaz3+qCYMOWtjZOaBZu11nxBN6yXGcXp
         AKxrunIW/U1gDj/nwb9JHU0swb8XANRxn/ZK076YVwUDcL57l0eCMuGojlxjXdW/zabh
         /1jAB4rXiTU+bjogG7ZwyzET4+dK3fpDhO20RaKiw7jam9RxnwcJk3dnvZg2YrXAzGDX
         QkBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762846539; x=1763451339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dOOlaVy/20CIon+tjXLAyji+6ZbQKD+NsElw/LVQ6M4=;
        b=UxvsM3bRrzGyHDuD/aLg79kK41IArT77eqP+yDRti3yvZ910OfgvY5Z02UbVZplHUc
         rMshcfwv4Knw+yEP2wP2GCW9dSSS+sbjTDzJwoJJmCAZKt0OhlJIb/G8wEd8LNwRShYB
         4oGK3MhuzjJMLKzzI2jEsovGoC65u/TYAb8wWaR78Qk60G9+ammEl6qoHiXs4knvHjUS
         o26X0Yj6UXaE8L/zJHoFBLBFeI0DC+VXl4k3T+ukWCfBWXdYFJPyfHXH4UblvanN6IXr
         ImUs6PZOd5gvrMYaREqjMIKrp27rc8SjlgWnB7Q4TuKAmw9LSsJ67Plnw0eoVbls2QZt
         KpgA==
X-Forwarded-Encrypted: i=1; AJvYcCWWnQQFqeDxe2wPlZe6KGrpCB0EDcBbkp2LUD1YqS7fFVsB3YbTbNm1r5fly6I8iGa7aNqCbLPcBAsSgfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YybVaIrgQQYUr4UEOVN44Hwrp171uTOJ6TqkZv2ki5NUDwukwiP
	KO24W3tpBZjlkZCVtawcALqyuCruZUYG2YPWDI2hDneVb72PI3kBM+QO4FSVBWt6DKg=
X-Gm-Gg: ASbGnctbQmcbNKO9RVqAPCDVP4Bv/+H12x6Il9TxIPyA+Pun8NiqbYHUVtkdgpHX5ub
	IZxaQToI6FTIDqXy/DDsHWqlEgk7fzFkf8//tDQ08fGUXBJOkB4f1zxczhIaPdu3feoMaYCkph5
	Zo4KK1FF3zN1W0a3BJlE+cekrtS2coH4GfkbVnTM7Bt1j54Nkphtgeg4wJhXDJMkRV9ny1w6bFf
	1Mn5nkNn1HwnfQT1N842BguI8VcM1AhBSZrFezIKR0VfeIRznbc1yVFih+t9BzQlkrJVgV4qZsR
	vRZEuZGs50PnUN22cWcR0rLdmXx7hbRD+AeJIdRMqtXm/O+4vr1R95A45pP0nL2bNFal43mucz3
	o8G8tWd9REBakQ9TmlG0OoikHaGJTuyDkostFvy/Gt12kyifk5LcGB8VkgXbFWJv3/3Ayiiu3WY
	S4niiuHPaSta+2GA3fTB5oeH4m1fU5E0tHT+7i5pW55w==
X-Google-Smtp-Source: AGHT+IEUw+72YJMnHDr6LbdwL+uWXqhzBDVKr1Hy8+90WDm/+ZatB8gHaR6Ah1I0Nw0KhXzjZnlq6Q==
X-Received: by 2002:a17:902:e545:b0:26a:8171:dafa with SMTP id d9443c01a7336-297e564cef9mr165530405ad.21.1762846539211;
        Mon, 10 Nov 2025 23:35:39 -0800 (PST)
Received: from L6YN4KR4K9.bytedance.net ([61.213.176.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c94abasm172928885ad.82.2025.11.10.23.35.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Nov 2025 23:35:38 -0800 (PST)
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
Subject: [PATCH v5 2/2] riscv: add HARDLOCKUP_DETECTOR_PERF support
Date: Tue, 11 Nov 2025 15:34:59 +0800
Message-Id: <20251111073459.44030-3-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20251111073459.44030-1-cuiyunhui@bytedance.com>
References: <20251111073459.44030-1-cuiyunhui@bytedance.com>
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
index fadec20b87a8e..74835cdc89ddf 100644
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


