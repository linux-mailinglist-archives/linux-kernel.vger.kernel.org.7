Return-Path: <linux-kernel+bounces-754634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 182EBB19A4B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 04:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C020318959D1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 02:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3A3218ACA;
	Mon,  4 Aug 2025 02:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="dxmg5WkD"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35764EC2
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 02:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754275901; cv=none; b=eyLttss4BlA7kUFh/hOmMnGFax5KUPHikeb8R38Yj8BEN/zpZyK03bWMxJIZSkL+nwxeCh5cayqMJRVvyn36GTCCpKbg3ufhQIY6JcvYAo0y3kZy3R1qyqQ4FKy3F0tqsL0Iq7Uvw7HD5tyrWE+F8Vj1qAgH/fSZ9QuWd97pSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754275901; c=relaxed/simple;
	bh=EhGd6gIenyb/JLJh5qNleIbNoKz8jaEu4G9DhpC1VTE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXNG5liUZfEiCwyh2tsf8vqskEKXEAoyGpsww9JnkjnK86zh4cnmC6KTGP54AZ63cWWQBpWKRiK757vR0QiO1urZz+3QpmNS921VGDaBgF9/qJzvmvITwHPlnhav6wlecJ1e8n25gPIf0TgT3lIsLe0qivY5p+JA6jm+cbjOfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=dxmg5WkD; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7426c44e014so3507420b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 19:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1754275898; x=1754880698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kppyljle9MoC1RO3HWHQlYBE2gQj+CD/61kPvhIKZUU=;
        b=dxmg5WkD1sdsnaR1J5zK5oXIQoSeZ4+a6UYlvECyUGEsUE+s1nTtnzjtiLk/gG8VKN
         ueq3nA6Z/xUa50Ro/XRgGaq3te166LDcYv+HE2jiPH8i4v3R1f6tljp5H84RvbkXAkda
         D87d82nfqj/OPhknz1TIhxpEAdbSlzYTo0ETqddKZ/tTYBokNXlpaQwqYN7p1oOwqzTq
         yDhQ3hKCUXQ040pMgGa6ioiqrKDt9i2CUR/j/57aIjuInTKrOrHKWsmVpcb6m19EDcPP
         Qp7UcB2cR2j1sUOSIE13daIMgd9/DXaVJJYLuinbonvJtuiNFDluNsUFad2QJJG2o8As
         /ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754275898; x=1754880698;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kppyljle9MoC1RO3HWHQlYBE2gQj+CD/61kPvhIKZUU=;
        b=giDj1ryUy2Ica1HsR2C1QQks4kJwruVdij9jhSiVp70POZ5XEAt3T/juk4b/dbV7yi
         avDdf6lVAF7Kr78ZYCUeMHmChQpBSr2izeqDS2s674CzTQsJMmJHGBJrGpLFgC0NIpll
         z+uqvLNlfuJfI07IgbjDUC21ibOqGQN2ih1dIKDicN1tS0vQ+AkPiTdutu8sYH+sOEoX
         9BDW1wUAVIwNvfOTXC+WacH6Eoxi1NcyHzKJSz7fMxZUg/WV3EB81Zb7JQ0RYJoQLJf2
         rS4z6P8cUb50Wz6xOPqi/fqucodDTooQZbee9kiu53cfG6lrpVI5jlViOP1v/luav9sY
         V4KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8f4lAchzJMmm+CG6C86dKBDetLCCrMqaq3ej+m0MdysTGNPjpNs/Euhrr9c8Wjr9mSzkLf2pBCqeaTKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr9xvctCdKJ9RR/RikUWbYkTQGr4p9j6pdfjM2TvIhI56sk/NV
	1+VHXjHesLwo7x4IQt4Gl0g17dfJ7lPOZQ6xQaAdsANTGsI9lP5SXegGBrFhXhsdJa5nNPe3QrJ
	No9NNqq0=
X-Gm-Gg: ASbGncvj/kjYznXmosjfJDI1b28VuEmcVbyIxveMw675StAMwjSrEnmW0K6rVqT0N98
	BwdvWFurTWtkLylaxXAM/zWC6YcvjX7fODQC1GY3S/5JaWm+Syp2Brk6JtthpxIXcQjpZinsjuB
	wm/nFMgwV/HUOadTQ5mBnFeLO3M2qR+Xj7Q+i0Ls2kUi7F+Q9wCBCyHucl1Ej8yTugJ3/a5tJzw
	llY2GZk+JrufXHSgXOibO9fEap5iJzcq0gx+9/QDLRdn+mWbuKkkDPhBZ2nSNqqd8qJ1CVHP2a0
	7DIdVVGeMr/f/k4HJ/scHjXKzaX4xKmJQ51aUmogjrDsRIkOZeDZmc3ptPUIbEpsCOQgnzA82ZZ
	F+4fKF7NOUIQtFMq+Y7bYU1cd/N+3QYvtJfRhTG2pWPHgyvSvElb2WF+FEjRLHw==
X-Google-Smtp-Source: AGHT+IGnAJTT+IrbnsWZCRCk+YCd+3FYDN3fJPd3vuAU12BnpRFJPFCkmur1SehfCljyn2rk7N6/hA==
X-Received: by 2002:a05:6a00:9a5:b0:76b:c882:e0a with SMTP id d2e1a72fcca58-76bec30d23dmr8835977b3a.5.1754275898337;
        Sun, 03 Aug 2025 19:51:38 -0700 (PDT)
Received: from L6YN4KR4K9.bytedance.net ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76be9143983sm5181960b3a.1.2025.08.03.19.51.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 03 Aug 2025 19:51:37 -0700 (PDT)
From: Yunhui Cui <cuiyunhui@bytedance.com>
To: atish.patra@linux.dev,
	anup@brainfault.org,
	will@kernel.org,
	mark.rutland@arm.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yunhui Cui <cuiyunhui@bytedance.com>
Subject: [PATCH] perf: riscv: skip empty batches in counter start
Date: Mon,  4 Aug 2025 10:51:10 +0800
Message-Id: <20250804025110.11088-1-cuiyunhui@bytedance.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid unnecessary SBI calls when starting non-overflowed counters
in pmu_sbi_start_ovf_ctrs_sbi() by checking ctr_start_mask.

Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
---
 drivers/perf/riscv_pmu_sbi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 698de8ddf895b..3977f7488e4ef 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -877,8 +877,10 @@ static inline void pmu_sbi_start_ovf_ctrs_sbi(struct cpu_hw_events *cpu_hw_evt,
 	for (i = 0; i < BITS_TO_LONGS(RISCV_MAX_COUNTERS); i++) {
 		ctr_start_mask = cpu_hw_evt->used_hw_ctrs[i] & ~ctr_ovf_mask;
 		/* Start all the counters that did not overflow in a single shot */
-		sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG, ctr_start_mask,
-			0, 0, 0, 0);
+		if (ctr_start_mask) {
+			sbi_ecall(SBI_EXT_PMU, SBI_EXT_PMU_COUNTER_START, i * BITS_PER_LONG,
+				  ctr_start_mask, 0, 0, 0, 0);
+		}
 	}
 
 	/* Reinitialize and start all the counter that overflowed */
-- 
2.39.5


