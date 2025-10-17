Return-Path: <linux-kernel+bounces-858396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2544CBEAC14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 18:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B84D5A7720
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E4229B77E;
	Fri, 17 Oct 2025 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZ8X1O3x"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BBB27F724
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760717674; cv=none; b=fNlwfEvtVLc2tX7ZFJ9LDnpgw5SxWIKmcqeSTxx+9LtoFd+AUJ3RsYBgbzRU8J5qPkErvA3yIdJo9N/iQwO6BOguCLD4tlooroXF1knmm05Kbuk7FcEUuVQFqaCvwtKN5eNVKcxcEWrn/W6Y76pdt1pItmPHBC7k9fZwc7dvDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760717674; c=relaxed/simple;
	bh=Oij+wM97x99m1N0mzXYrzpOj9vtTLe4Ci0NQCxPAsn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tfb4KjbxeyiPvzoJ84niIZcWr+eHS1cTtkenEGiefQsNBs0t3oNhK9NLUlMqhuMZyUvTtveMpJKaSeKFxjOpjlbsI/bBW+nV3Oce4PXlDgrNitjnpkkRUk/NVGETa2vIhcjMXnpHPmFWNCCGic14EIBygcmw29TGL6Qw0eHyADo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZ8X1O3x; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b550a522a49so1693605a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 09:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760717672; x=1761322472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmzDzNS6h2nn3lBWOC9er6/2mXt0x/z2uT1ZIS+7GYc=;
        b=BZ8X1O3xLHo1hDB7ROMUbbhBeE56B5LIeYSoxAcBBq4yN5f3jdFXV/SVXRRySgJ35y
         cEriVlOcKCUy9pXLqiLrqqJJyADnZrseirNqcMYVj7YIfTbOpuJAv1W2GsT7w0NYHmYG
         H6WOGfjLBOFHnv/68eRlOwcTADEvBawXSwmTGXl9YjjE0z9bLx3bzTj6kwTJChtIzUHx
         RFeh+EZqzVVUat75YdxR3LlBC5GELnM+uCYtuQJbWEzcoEZkuE94pf9PDhNKUqxDkqmS
         nN6xqjzVkz0NcBaklvzKF2kK6WbVzTYomHceTnH0toiErczB6zNFeL1+UmS+oA13CNA5
         i7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760717672; x=1761322472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmzDzNS6h2nn3lBWOC9er6/2mXt0x/z2uT1ZIS+7GYc=;
        b=siBFvaPSZPS9Qt1TxndacqpN2f1AY6bstS7pqsugNZB/YY9InN+bm1qlOLbMUDg79L
         lL3wbJIoisQpYOGiPIWHPa2xsslHquI+nTLHpJE0eMQT6CnK/NsYQTvr4qrndTpqTthR
         tDmTGUdh/m1mO3pdT61F64GZJYVoavFMyyLT16HmS9GeKFjgXZmpiOd3a6udFN1m7tIn
         DbwbwAXvgaGbhEauX/0ROrs+VkRgZkOLrqVQs7ewX4W8TYSqMjyrGI6VkbYeRc4uJhHr
         EXaM/NCfNlSrzxhQz2ZO+woacznIoEKvzkOp7Jwc4nrY717h3Jhg2ZNB/e+O5LdvRZ19
         IfeA==
X-Forwarded-Encrypted: i=1; AJvYcCX79wXersRG93LchZkcDNCIc5BrfkDUu88XItH/duCaGRm0wLe+oAv/qIwJC+tpi/2Br+joFpdIiQ0KHOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKAwao+7Qpb+INaoe4MBbq47C01F7OsJpLnsgBA3tIw76Ys7NP
	uwVbe6D0jz9FNUpJXgdoquFbaIQuBrYI3qKgn3i3GmAFhXDWbx7XTuIbBKPV4A==
X-Gm-Gg: ASbGncsF1HCX7YJmPkyBHulISpEAKgACwsPGNQ4njq+X1i3Z0Gg+WmSLGFK9sE8szJG
	nLHBz72vj3+VBxbLJorqIQ8utxHfnpKa8WHtcBXYIK2IaiqBwOxKHazgPS8rtQj55uzX9ZZmMQ5
	dZSE9IGmvz72oYkllKqj4UQEBtFfWcAXMpnACEunLO+gBPjn46lBrYxmptmQkjjxLzoAusyFfmx
	/xyB8Cl/G8xw76skGCFyhGlEV6W16FwbHFgLDBZ1olZEwFhAobyIGok9tOjNY53Eyy94WQiFRkX
	5XwwXoGBgK/k/r8FApGkcxcVMWjDH+2Pur4M9abZN3WU5Go5aF273Xa5e4RGRVJ+1/mjJWS0X37
	ha7WcBHYMZ3mDsu5pGu1/X+u0oMjS+DqTjBEifi+xVKbRz7/WyeoU3ooUtbLD6mBiBonaeQ0L3w
	qtVk+WeoZNr272/F0FkYM=
X-Google-Smtp-Source: AGHT+IHPUYJEehZ0R4uTpkY4LREsjkCPbkAqM2QaS5Epmh67gEiNbiMT9ytygjRT4XX5SRJeF72CLg==
X-Received: by 2002:a17:903:1a4c:b0:27e:ed58:25e5 with SMTP id d9443c01a7336-290c9ce5b85mr44190495ad.24.1760717671973;
        Fri, 17 Oct 2025 09:14:31 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099ae78c6sm68109835ad.100.2025.10.17.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:14:31 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Kevin Xie <kevin.xie@starfivetech.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCIE DRIVER FOR STARFIVE JH71x0),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v1] PCI: starfive: Propagate dev_err_probe return value
Date: Fri, 17 Oct 2025 21:44:23 +0530
Message-ID: <20251017161425.7390-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ensure that the return value from dev_err_probe() is consistently assigned
back to return in all error paths within starfive_pcie_clk_rst_init() and
starfive_pcie_enable_phy() function. This ensures the original error code
are propagation for debugging.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/pci/controller/plda/pcie-starfive.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 3caf53c6c082..192d7a6a7c6c 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -180,7 +180,7 @@ static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
 	ret = reset_control_deassert(pcie->resets);
 	if (ret) {
 		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
-		dev_err_probe(dev, ret, "failed to deassert resets\n");
+		ret = dev_err_probe(dev, ret, "failed to deassert resets\n");
 	}
 
 	return ret;
@@ -241,13 +241,13 @@ static int starfive_pcie_enable_phy(struct device *dev,
 
 	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to set pcie mode\n");
+		ret = dev_err_probe(dev, ret, "failed to set pcie mode\n");
 		goto err_phy_on;
 	}
 
 	ret = phy_power_on(pcie->phy);
 	if (ret) {
-		dev_err_probe(dev, ret, "failed to power on pcie phy\n");
+		ret = dev_err_probe(dev, ret, "failed to power on pcie phy\n");
 		goto err_phy_on;
 	}
 

base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
-- 
2.50.1


