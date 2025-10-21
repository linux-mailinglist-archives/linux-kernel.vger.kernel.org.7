Return-Path: <linux-kernel+bounces-863062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333D0BF6E4B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9354119A0BE8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 13:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A684333A032;
	Tue, 21 Oct 2025 13:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vJhlH2k/"
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F78A33A02B
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054737; cv=none; b=bu5Ow8g27EiDBCKUrFchEC9ye+QJ/mqONfRTpMB3AH7fE2lWtniuTvf/aZa9DHc31wtQ5HwQqQVYTQ96HGj8aBNTXnyQLyFl3JzQdcTbPSrgWyRww7PqyLRJ9zyQ6gNl3gQdeMqo8mo9YLFiyzEOSkBRwv3ytI7ehqf8Iiuzhrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054737; c=relaxed/simple;
	bh=KcoZRlMIRQYTtUsbeUmLMcynfUy20gbDZvC2+z6HaGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvD9NcAbIpCPF3YsBWh3PSiFzoq/7HNvQ/0ZaLkRIz4Flw+O8+BxYKXaiGoSl/dmPKfE3gvgZ+hUzGP7AmjylVncOPUApmkL1/CULxhqjkoftRU0YEQf9mjBtBZI5zJlnXuBg9jJjcqlR1HWZaiALPq4I6WGv8QOSt7XEFvNu7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vJhlH2k/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761054732;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QuqX+DVA3hI2/d+SyUtCBAKfn2WnwnI/ZTaEyd57HEk=;
	b=vJhlH2k/IXH0+K+ZOmlfs3G9ac+QbvdJbaeQt5QuSjnbmpLZfrJLBx6f+l7HcIYK46qRFG
	SJnlxx+rL+2dSwjo/e3M+s/vpghs599PE65LqJC+G7wSMB3oih3gySCbZaRUgo4pK7CgiJ
	1t3WGX7Eq06L7sG/5CTCo2QxhPhSO3w=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Anup Patel <anup@brainfault.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpuidle: riscv-sbi: Replace deprecated strcpy in sbi_cpuidle_init_cpu
Date: Tue, 21 Oct 2025 15:51:54 +0200
Message-ID: <20251021135155.1409-2-thorsten.blum@linux.dev>
In-Reply-To: <20251021135155.1409-1-thorsten.blum@linux.dev>
References: <20251021135155.1409-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/cpuidle/cpuidle-riscv-sbi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-riscv-sbi.c b/drivers/cpuidle/cpuidle-riscv-sbi.c
index a360bc4d20b7..19be6475d356 100644
--- a/drivers/cpuidle/cpuidle-riscv-sbi.c
+++ b/drivers/cpuidle/cpuidle-riscv-sbi.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -303,8 +304,8 @@ static int sbi_cpuidle_init_cpu(struct device *dev, int cpu)
 	drv->states[0].exit_latency = 1;
 	drv->states[0].target_residency = 1;
 	drv->states[0].power_usage = UINT_MAX;
-	strcpy(drv->states[0].name, "WFI");
-	strcpy(drv->states[0].desc, "RISC-V WFI");
+	strscpy(drv->states[0].name, "WFI");
+	strscpy(drv->states[0].desc, "RISC-V WFI");
 
 	/*
 	 * If no DT idle states are detected (ret == 0) let the driver
-- 
2.51.0


