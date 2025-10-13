Return-Path: <linux-kernel+bounces-850562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 20548BD32E8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 15:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D43684F3B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 13:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3552FE58C;
	Mon, 13 Oct 2025 13:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gcX5/t0H"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775DE2FB62A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760361656; cv=none; b=ZYmr0yDRzfhYrXSKfMOIbZunvTrpu2jdbrum6Ef3ACrdZ/wb5ePth398ihYXxitQJSPFaGrIGvaf58WYLc3AbGOgUDvy/YPOWpsKJ5ZSP+hui1HvReasXLdyqplVD+PoHZKh3xht8EmexygvvRamMv6qfTpgdTycSO/+V4OBsI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760361656; c=relaxed/simple;
	bh=wBV+1aZnEOkyIM0jJ14iKfrdBgNi5hFTOoCrxqQghPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UeS/hVGR/z+K8Nsjbolk2RAwqE0Kiva/dTi/L85lPyHJRaGvZldP3Sve//U/Sld7XNsFI397nqB9bddyb4Oqk5ouGgjvu3rqYETVW20X85Bx8O/8aVDECX2uk7Ds+QWt2SPL8xGaCL8O68lZ4Meg0SA7QJ5bQx50/vL/4v8RCb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gcX5/t0H; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760361642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B4FedS6ZPBrFJ1RksF5rENktGQfjCc8C/sdHc03ViEQ=;
	b=gcX5/t0H15SwwR/UtEHIJ+3WQg5ow0yzmPRycjb8uC6aZwIFdstYxyFNEOE8nSSY5jKLhH
	ju0ui6O1KpCdRN5UoeU5/10ZtPh6TlAiQ/WjYTnJkRiWrta6X0wn/va77b7iJ8keCktSLP
	wlTC6xPta2ATdVoU7cwFwE3ABz0MmkI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Dmitry Osipenko <digetx@gmail.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] PM / devfreq: tegra30: use min to simplify actmon_cpu_to_emc_rate
Date: Mon, 13 Oct 2025 15:18:26 +0200
Message-ID: <20251013131825.31400-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use min() to improve the readability of actmon_cpu_to_emc_rate() and
remove any unnecessary curly braces.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/devfreq/tegra30-devfreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 4a4f0106ab9d..2c9813bd697e 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -326,14 +327,9 @@ static unsigned long actmon_cpu_to_emc_rate(struct tegra_devfreq *tegra,
 	unsigned int i;
 	const struct tegra_actmon_emc_ratio *ratio = actmon_emc_ratios;
 
-	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++) {
-		if (cpu_freq >= ratio->cpu_freq) {
-			if (ratio->emc_freq >= tegra->max_freq)
-				return tegra->max_freq;
-			else
-				return ratio->emc_freq;
-		}
-	}
+	for (i = 0; i < ARRAY_SIZE(actmon_emc_ratios); i++, ratio++)
+		if (cpu_freq >= ratio->cpu_freq)
+			return min(ratio->emc_freq, tegra->max_freq);
 
 	return 0;
 }
-- 
2.51.0


