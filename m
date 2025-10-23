Return-Path: <linux-kernel+bounces-867767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C926C03734
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D821AA0B84
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 20:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF5D29D270;
	Thu, 23 Oct 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RWlsbH7+"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2112C026E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252794; cv=none; b=D/f4zXbZwj8lpX1BFwnPS0dIYbYk0LuoXbvI28d/r7GVl4ZGCNfW9R4sCQT08X/HsIv6XZnSBCz0Yftvr6iE819ATLXAljaTXab2GPpgKnKeIjVY+YwtVElVw3tbjQjAO+m15HSw9o9P9gZAnPv7jcJN28WJvLeIWqs3CrAnMMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252794; c=relaxed/simple;
	bh=C/1zX22wjI4qtmE/Rs+0jxW/rC4laO75J74Tq/ISSYo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pa8X9a9JhIxsrLoT8PAziEa9TtT+SFCp982H6KujngeUiCoYj90jP2XcBrqCKBaOICKJ+pcYzWfdgUmET/ecyGdTm3g03PX0RO5JF2k4I69451T6i8lSHoqp6Mw23KsfwzXhipoF1iWjB6eH+MlsJ/n8uAOzS47sbR+mq2TvnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RWlsbH7+; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--willmcvicker.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bc5d7c289so2624944a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761252792; x=1761857592; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n3ErCVLsFFmYy6ztYolejF5Ple6tVW26MCiEzz3ldVw=;
        b=RWlsbH7+tPtS85Su5B18H9/OwJc6o3vcyDCLKocUUY28Npa3zdngH9vdW57/bFojTM
         oV+3M2sVGEXiph6I2AdTtZwc4TGt4ARACKttwo2iRAVeC2FyvWrbbabH3bnwfxiyC/ft
         NGe7GPpA4WhWNgZX4pM7XQBMtbA14o0jtmzsDvrfexX8qMwI283zimtakGTz1zSNieQE
         hX/r17qUyFXpbAaTUSpNX8vMEgZhSpnggTG3WNvuJXWwc8Ev1WLeg9P1wdUvHkJmNddv
         3xuQTKAfCRdM9tMUPMw7Ef+rD4xoyr2ZztY7AsdZu1ExUDuhCNA0yR1QaMdysLByB1kS
         jc5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761252792; x=1761857592;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n3ErCVLsFFmYy6ztYolejF5Ple6tVW26MCiEzz3ldVw=;
        b=lIoskc/ffcTVlY3lLLYBRwaQCz4Wvrnc4QR1dpf0JcJ0338ZIBrzZ0MBpM2PTeh1bb
         za61vL0O5ZtDLZMiZIddMJXSnq2sAkR07XEjPi/umsvU0Z79QOf7pGx38MWShQ4jyGVN
         XadGu+oUFus+2U6klQo+6dVD25l3bMt7WiCtMWfVaDfzEPRFlFXRJBXAfaUNoh7ZLeQA
         UPc58rx4QaikwjulGT1EZYF2vHac57/3xBWuz17DOm+IYucAnaKNU9PSI5ZThEcxzx1V
         uIFGADRlryBT+e0zDd+aWySxIqD+QzKoOuxmYA8Zs20rE3kxqrLpp1xqEyKkKCNd6ewn
         sD/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXwaQJclj4NrCn6alY+v3HQ5jASs3RXBqLX8pdAhw3ICsjhlMca/gh5ROathLPndTsqMXCEPel3bLvaYj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb5Ttj1Fs5kwSsXSPfp/44SxhyXPBOpLi5Hi4PFN6AXgcJTUb9
	dSVv3w3NDtWzG+L+HNQwtpNVIASM3gZq68YFL/T2O+p6vPAaPZjrzCNvXmoUmldLu4n82oda8AG
	dbFbajuKBacodvb69+DnrKoL6uXY1LQ==
X-Google-Smtp-Source: AGHT+IFW1kad+/CsnnzJKL1H1lX75kDUCzIPITXCJ5Bo7w07f+DaO2z/DzasuC8nJRHc1pc75xqQpvcM/Ch6dWDL4aY=
X-Received: from pjni12.prod.google.com ([2002:a17:90a:838c:b0:33e:3082:9b48])
 (user=willmcvicker job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4ac4:b0:33e:30b2:d20 with SMTP id 98e67ed59e1d1-33e30b20e23mr9036228a91.33.1761252791696;
 Thu, 23 Oct 2025 13:53:11 -0700 (PDT)
Date: Thu, 23 Oct 2025 20:52:47 +0000
In-Reply-To: <20251023205257.2029526-1-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251023205257.2029526-1-willmcvicker@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251023205257.2029526-6-willmcvicker@google.com>
Subject: [PATCH v5 5/7] clocksource/drivers/exynos_mct: Fix uninitialized irq
 name warning
From: Will McVicker <willmcvicker@google.com>
To: Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, Hosung Kim <hosung0.kim@samsung.com>, 
	Will McVicker <willmcvicker@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Peter Griffin <peter.griffin@linaro.org>, Youngmin Nam <youngmin.nam@samsung.com>
Cc: Donghoon Yu <hoony.yu@samsung.com>, Rob Herring <robh@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, John Stultz <jstultz@google.com>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, 
	"=?UTF-8?q?Andr=C3=A9=20Draszik?=" <andre.draszik@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, 
	kernel-team@android.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The Exynos MCT driver doesn't set the clocksource name until the CPU
hotplug state is setup which happens after the IRQs are requested. This
results in an empty IRQ name which leads to the below warning at
proc_create() time. When this happens, the userdata partition fails to
mount and the device gets stuck in an endless loop printing the error:

  root '/dev/disk/by-partlabel/userdata' doesn't exist or does not contain a /dev.

To fix this, we just need to initialize the name before requesting the
IRQs.

Warning from Pixel 6 kernel log:

[  T430] name len 0
[  T430] WARNING: CPU: 6 PID: 430 at fs/proc/generic.c:407 __proc_create+0x258/0x2b4
[  T430] Modules linked in: dwc3_exynos(E+)
[  T430]  ufs_exynos(E+) phy_exynos_ufs(E)
[  T430]  phy_exynos5_usbdrd(E) exynos_usi(E+) exynos_mct(E+) s3c2410_wdt(E)
[  T430]  arm_dsu_pmu(E) simplefb(E)
[  T430] CPU: 6 UID: 0 PID: 430 Comm: (udev-worker) Tainted:
         ... 6.14.0-next-20250331-4k-00008-g59adf909e40e #1 ...
[  T430] Tainted: [W]=WARN, [E]=UNSIGNED_MODULE
[  T430] Hardware name: Raven (DT)
[...]
[  T430] Call trace:
[  T430]  __proc_create+0x258/0x2b4 (P)
[  T430]  proc_mkdir+0x40/0xa0
[  T430]  register_handler_proc+0x118/0x140
[  T430]  __setup_irq+0x460/0x6d0
[  T430]  request_threaded_irq+0xcc/0x1b0
[  T430]  mct_init_dt+0x244/0x604 [exynos_mct ...]
[  T430]  mct_init_spi+0x18/0x34 [exynos_mct ...]
[  T430]  exynos4_mct_probe+0x30/0x4c [exynos_mct ...]
[  T430]  platform_probe+0x6c/0xe4
[  T430]  really_probe+0xf4/0x38c
[...]
[  T430]  driver_register+0x6c/0x140
[  T430]  __platform_driver_register+0x28/0x38
[  T430]  exynos4_mct_driver_init+0x24/0xfe8 [exynos_mct ...]
[  T430]  do_one_initcall+0x84/0x3c0
[  T430]  do_init_module+0x58/0x208
[  T430]  load_module+0x1de0/0x2500
[  T430]  init_module_from_file+0x8c/0xdc

Signed-off-by: Will McVicker <willmcvicker@google.com>
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 1429b9d03a58..fece6bbc190e 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -465,8 +465,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt = &mevt->evt;
 
-	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
-
 	evt->name = mevt->name;
 	evt->cpumask = cpumask_of(cpu);
 	evt->set_next_event = exynos4_tick_set_next_event;
@@ -567,6 +565,14 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	for (i = MCT_L0_IRQ; i < nr_irqs; i++)
 		mct_irqs[i] = irq_of_parse_and_map(np, i);
 
+	for_each_possible_cpu(cpu) {
+		struct mct_clock_event_device *mevt =
+		    per_cpu_ptr(&percpu_mct_tick, cpu);
+
+		snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d",
+			 cpu);
+	}
+
 	if (mct_int_type == MCT_INT_PPI) {
 
 		err = request_percpu_irq(mct_irqs[MCT_L0_IRQ],
-- 
2.51.1.821.gb6fe4d2222-goog


