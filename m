Return-Path: <linux-kernel+bounces-850324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FC4BD283A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 12:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE3D53B2458
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1122A1990A7;
	Mon, 13 Oct 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3qX2/5i"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CE314A8B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 10:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760350667; cv=none; b=jdWosAehae0CkHKVIq8K9c9HroJWMbg6cfEEneV/SMr4KOLfntpn0Ic8D4dqE4vtKwkWUOQ1sCF9ieJ3Q8VzAAXzDMkYfwRn3Y6c23px1pCpHzOlHaYiILyrqHt50XUZGru28trQFo89EXqxWMknag1Cl7mo9l/OROqLRl059VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760350667; c=relaxed/simple;
	bh=fLqhCB9ZHaE35jEAvUwL/XlQACvFsJNj7NN+aAdIw+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UOuh+tP2pmc8qm/v35n6jMWTX6JSbCEPFxxPUqdbTeQ3YFVX94FizyojALMPuDMo2Ds7vwk4otZ2/O8dcN6YqkF2t+qDPn+WW0Xr7+HHWsJlRjRCNOvVeog83NL84DpGnfszfWygNwl27ob9DSWzWucpgSgF5o5N2nBUBbchi9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3qX2/5i; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3304a57d842so3327308a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760350665; x=1760955465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rL8Zvity0qBrpOIGKiLq2gATcEJ0bdlrudF1QRk85so=;
        b=e3qX2/5iepCXH6WkrSyxJe7ORCQ8SRV46El9RZmkR9AV4HwElRyK5OFc4nLFWqN1tR
         gnoeHcNW+nIS8o9uiAV/SE1Q7wl3F/qE9E+mee3jeFpwZk0rH2a3+8OAaUiapa5W9yfd
         x2zFo6OEod/Fz/y2Q76TpjFZqPfhGw8ntS9SXeTAoD4jwQySMmTGK0eUUbI3pHLI6YVH
         EQeXTy9Rf2qdt4Uj/zPNtaD5CEJN7UK1yXFM+T2gdrMiUykhhDWw4eN+Sr6J51Ep4aAB
         DarIacU/aSAQE2TRaE39UJXVQ4L+HKfRfv5p7XX2mMicXKJ53h9IQOHM6kP2NtygFNKb
         X4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760350665; x=1760955465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL8Zvity0qBrpOIGKiLq2gATcEJ0bdlrudF1QRk85so=;
        b=uuSQv5x4/KIJNhjoV/SMIYW1p25nRSnvTfSrfa+7bsiDTFnPvbNt40P/JgRTa1D37D
         X5/dJsDU0r6Vf2sEzHV9n8EcY3kSzzLUWS1kHRD27DBpqp7vP0Wby/gIzjNoLohDaptd
         4Y4Ezpm+UZECtbodmzr9Dkx/aqfGOPBq+hOI2jG9Ut3vE2qPSDZCVYve5wjV+CFjHbVE
         1X7MfM53OGlm2xgBzU68Y8yi845nn3ieiOkZWj5W2zaUGDo+8JRhFoR+s/hDJTyTIMtz
         FRZj0xmHtxAB56egUeTH41TaQhRO+v0xK+XOs40/kLt5UYx9ldGrYFCs3BZyjBPpXSv8
         RPpw==
X-Forwarded-Encrypted: i=1; AJvYcCXQckCcUpx40hrMEsSnT9auZWAAxjbS7U+Alal18a/6eKTkEG6bdMck5zUS+3RavV5qEoGzFsZ/MTDPAi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxK3X6mT1uakD8PhxFeWj487j6469vnLWgeUEOCy6WVwlFTPf3
	6hPjy+ZZYQodYoqpmoDm+yd3GUvr7bcykMfq/toaoJUUa6xNX4nO6WMR
X-Gm-Gg: ASbGncvm5uCp/tbMq6h7mLcRmxH4ImJaXwYoskqB9cPn/t1tQ34w4YSxoQgmPh0PpRB
	T7gjSHlUHLB3/U5kPviNshhPsYvikjcE7+5fPTlA0pLC3qj7jQbj08OO6ucyjcc9QmAYNUZTMcJ
	Th1c+xmOJNkOEuvGgPp5iEpIEw4a/IjhSNprtLVx1sNCHA7OilR3ZmJd0Jlmlg0VS5Dso8Ss4gN
	13oE7X7gOTSU12Gc+4KWcfMXepFhqjSLZnXPg6Xm2/gfmeHr9EcifVflUM8m17x8VS8BMArKrc8
	bmEqCVvSz5YqCgYPFtYoaw7K/7kDqzREiCd4xXucxNU4oGKJAyV6lidpNe0kf9JUXtPyuPZN/tH
	NZUa3ERI2V1jXWjki3y75At3kxitqMuaN4aakmh7gw5tDOOomcQ==
X-Google-Smtp-Source: AGHT+IHcngJ21CdNAU4iF9jGL+GrQ8wIh2V4zG56kXYLEpN2UR66JICC8m/eBuKADrldWfXWqWJEAw==
X-Received: by 2002:a17:90b:3846:b0:339:a323:30fe with SMTP id 98e67ed59e1d1-33b51168e73mr29465661a91.14.1760350665091;
        Mon, 13 Oct 2025 03:17:45 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b52a5656dsm7422864a91.11.2025.10.13.03.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 03:17:44 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [RFC v1 1/2] PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
Date: Mon, 13 Oct 2025 15:47:23 +0530
Message-ID: <20251013101727.129260-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013101727.129260-1-linux.amoon@gmail.com>
References: <20251013101727.129260-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use devm_clk_get_optional_enabled() helper instead of calling
devm_clk_get_optional() and then clk_prepare_enable(). It simplifies
the error handling and makes the code more compact. This changes removes
the unnecessary clk variable and assigns the result of the
devm_clk_get_optional_enabled() call directly to pcie->refclk.
This makes the code more concise and readable without changing the
behavior.

Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/cadence/pci-j721e.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 5bc5ab20aa6d..d6bbd04c615b 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -479,7 +479,6 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 	struct cdns_pcie_ep *ep = NULL;
 	struct gpio_desc *gpiod;
 	void __iomem *base;
-	struct clk *clk;
 	u32 num_lanes;
 	u32 mode;
 	int ret;
@@ -603,18 +602,11 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 		}
 
-		clk = devm_clk_get_optional(dev, "pcie_refclk");
-		if (IS_ERR(clk)) {
-			ret = dev_err_probe(dev, PTR_ERR(clk), "failed to get pcie_refclk\n");
-			goto err_pcie_setup;
-		}
-
-		ret = clk_prepare_enable(clk);
-		if (ret) {
+		pcie->refclk = devm_clk_get_optional_enabled(dev, "pcie_refclk");
+		if (IS_ERR(pcie->refclk)) {
 			dev_err_probe(dev, ret, "failed to enable pcie_refclk\n");
 			goto err_pcie_setup;
 		}
-		pcie->refclk = clk;
 
 		/*
 		 * Section 2.2 of the PCI Express Card Electromechanical
-- 
2.50.1


