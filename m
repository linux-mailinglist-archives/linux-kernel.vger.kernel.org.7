Return-Path: <linux-kernel+bounces-879821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFBDC24184
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBBC41897064
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56ECA32F77C;
	Fri, 31 Oct 2025 09:15:59 +0000 (UTC)
Received: from wxsgout04.xfusion.com (wxsgout03.xfusion.com [36.139.52.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D50330B14
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 09:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=36.139.52.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761902159; cv=none; b=g7JiO7s8TtxEFCpf5hjLFFs2Pi0+eQtwfru0fh4XwHYhou3Zs0uyitHC+ZP5aHf+a7WnikVI2FwUMQukVfNENDP+4Rtes46yktF1zFDQB5W6wzJeKuF3NnUPZhYMYP6/TycYJUXwPW0t2fHTdmofHaf6NsIbS1zD3yVBySaNS+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761902159; c=relaxed/simple;
	bh=335LFdAs1ozkW9woaDAxz+YErnTtx/QohsYwEw8Eo8M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HA6Q9ngBjYccRjVk9M3Ell3sE2AvWiL6A6sy6pv1w8gSKAu4LsJw3dxVmqQMRtXzEw1+BYIiFCjAmbZAU8b/S+aeQzXdfKTWB/Kl9orq/5qCN/hIitypMx26094vDz4wKubfiAm/KIoAL5MB6OHJAQuyLRN67MlDilfAfj6IVNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com; spf=pass smtp.mailfrom=xfusion.com; arc=none smtp.client-ip=36.139.52.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xfusion.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xfusion.com
Received: from wuxpheds03048.xfusion.com (unknown [10.32.143.30])
	by wxsgout04.xfusion.com (SkyGuard) with ESMTPS id 4cyb0t30h5zB9Xpf;
	Fri, 31 Oct 2025 17:15:10 +0800 (CST)
Received: from DESKTOP-Q8I2N5U.xfusion.com (10.82.130.100) by
 wuxpheds03048.xfusion.com (10.32.143.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20;
 Fri, 31 Oct 2025 17:15:47 +0800
From: shechenglong <shechenglong@xfusion.com>
To: <mark.rutland@arm.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stone.xulei@xfusion.com>, <chenjialong@xfusion.com>,
	<yuxiating@xfusion.com>, shechenglong <shechenglong@xfusion.com>
Subject: [PATCH v3 1/2] cpu:Remove the print when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY Kconfig option is disabled.
Date: Fri, 31 Oct 2025 17:15:05 +0800
Message-ID: <20251031091507.1896-2-shechenglong@xfusion.com>
X-Mailer: git-send-email 2.37.1.windows.1
In-Reply-To: <20251031091507.1896-1-shechenglong@xfusion.com>
References: <20250918064907.1832-1-shechenglong@xfusion.com>
 <20251031091507.1896-1-shechenglong@xfusion.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: wuxpheds03047.xfusion.com (10.32.141.63) To
 wuxpheds03048.xfusion.com (10.32.143.30)

Following the pattern established with other Spectre mitigations,
do not prints a message when the CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY
Kconfig option is disabled.

Link: https://patchwork.kernel.org/project/linux-arm-kernel/patch/20250918064907.1832-1-shechenglong@xfusion.com/
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: shechenglong <shechenglong@xfusion.com>
---
 arch/arm64/kernel/proton-pack.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index f9a32dfde006..d833b7c1bba8 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -1042,8 +1042,6 @@ void spectre_bhb_enable_mitigation(const struct arm64_cpu_capabilities *entry)
 
 	if (arm64_get_spectre_v2_state() == SPECTRE_VULNERABLE) {
 		/* No point mitigating Spectre-BHB alone. */
-	} else if (!IS_ENABLED(CONFIG_MITIGATE_SPECTRE_BRANCH_HISTORY)) {
-		pr_info_once("spectre-bhb mitigation disabled by compile time option\n");
 	} else if (cpu_mitigations_off() || __nospectre_bhb) {
 		pr_info_once("spectre-bhb mitigation disabled by command line option\n");
 	} else if (supports_ecbhb(SCOPE_LOCAL_CPU)) {
-- 
2.33.0


