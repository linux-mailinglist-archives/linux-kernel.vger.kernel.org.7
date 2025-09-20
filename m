Return-Path: <linux-kernel+bounces-825589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAAB8C476
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A58C3173A8E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 09:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DB22C236C;
	Sat, 20 Sep 2025 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hZioOIh4"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9790726C3B6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758360389; cv=none; b=n32K/0kWwK3eBD31Jd7LhIy3V68SqMaqJ6c1dGK7PPDMyAUnkGrSKX+L+SxlCrRB/W3Y46tjJQoLRgBkDj6rdfzWZswJazwpE5UOc0nMxmbkkZq+zvRNgSBE5w6GOOPO1pcFGUFIWmnri3KhsSNcQS0Xl/h5ums6ZgmuWcQCIZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758360389; c=relaxed/simple;
	bh=o5EN6c1YWCxp4RRj5b0KuE59KXin0qqHFu3hvf1nM5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=beyWuXQxaWaMHhD9QKuu0l5J5dxspExAdHaGvqAyRBvuCNQ6PZXGcePA3Jx7qcyUAiusYXy0/y4wXrs+2D5TBTWMvWN+olaApiFBk0aFGViIRKIWADl48/Nv5YjjSX6n5/iXibdaxK1/WpNgx1Bww3uC4GaXg7+osVd3LA/9v5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hZioOIh4; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45f29dd8490so27634715e9.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758360386; x=1758965186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pb3oQ4OLLQ4LwjywIbmgSN/BEASRwYQS+6IVWtGhrH0=;
        b=hZioOIh4XAxl6Cb/jPs7/sefRY1N0maSmi7161+3c/70JsFpuyRA2dHQ/bQLFLA8TO
         I+1gS8U2WdC4HYuFQ/XrgxQuIXBRGoX64yyNZjqRaVxOAFVrvxjiVfCSPIEY+FIq26GV
         rzFoSk8xFtinYzMTkPjz/ZKXmwsaEdFIURR3MVDnedpXnHo9JyhZQMZhYxJZY/HpQNK4
         yeIG9zLWauOh5cy6tTZ3CmTFHzxBcZfn17BolZ1vyyVETM4Bm/C0nJ/9w6CSZODrw3tu
         ZOHzam8D2CG6tAj4q4vN5Tafo3oWUouZ/6n27GpkACKsMcr3zQ1lK2m3mx4y1ufAKi82
         oekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758360386; x=1758965186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pb3oQ4OLLQ4LwjywIbmgSN/BEASRwYQS+6IVWtGhrH0=;
        b=HWoXo+IlrNDrfU30etn/217ExWjS7siivWM/9X3Mmspaq95bk1gmqXu0cgk/Y5t75A
         N0UwBtlAT2ZZ0EAi6g67A0GsUpHBTTMBA88S30NytqKHGIVjdbu2Dvkkxun2yBhogILs
         OUzNM7TQBvvWE8MwYrBzkcOYf5bEmz8jBsoy5davABzHsXKuWSb2U7GosCsLwOP8l9GR
         j8ULm2pe84U2aHgK8KLw3DDHILPSnBvevHXi6Pt+4QIOSTetSHJ7q7TsDiP0NIocGySR
         Os9w8xEK9e6d8Dd3qgJjrgeaiNXUTIrQfkYuHlJvTWEm74GF8TPRK7JIkx5Ga14Ptasl
         kZnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVidMRB4a+RVWbsvUq5dJtFgTWuYMC9+gln2uB2c2Ozy5kIYwJRkmpdGszkogOcohwd68T+f6DaRbMnHUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYReljouNOU+bLcLkihS6gCYT6Ga4AtlQyAM1+9ArDQNfHc7nb
	a61jCDs3lJ6FrWbDYOYhbIdj/HsgeFLdxAcQFIf4mIBzeo3hQy5yMwmk
X-Gm-Gg: ASbGncuVrCzH3KHvvTzhrntHX+f1R9DImMx1fVxCHP2R6AEP9MZZW5Ih3QbUN277f8p
	BUL46N9gM+qLu7gFXFc+oTFx8bQHkMzja7ri4uHZceaj6eYnJ3g5QfkNByfzLPj5OeCFc5uREbA
	f8YOCBiaUyongm+yOU5EPvKZPgmG+W5fk0VFmvhEvkaOTyBtn0FGkL9MTKtHjvO18aVMqjLB9pR
	yZtRUNOuwkBPIfBDXGv0l02Uq20ROjg2mK7OzJnjGkJ6YtQOzectkhtixS1gwAXClzDh2W5Tn1R
	Lo1e9gmgUPUjdHr5HCy9pKz7bSv3NWNMS27aD6+uiW1ZNFCDvhsMa08kEjQQPVzz90Uz7hGoarh
	pMfjf0zMEcIAJ5lIQYW1aNqJV4KfgJGUstf2yq2f3DwiVFdNuIeSSFZeGHbRUPLkpl9y1eek=
X-Google-Smtp-Source: AGHT+IGt8P3rEmePLNMaAwjTE9SxZVmwgeAbuDHf0WXIvJ1mTKDwPrysE7A1gCCOMrssz2H1L7Vmmg==
X-Received: by 2002:a05:600c:3555:b0:45f:2f0f:6649 with SMTP id 5b1f17b1804b1-467ec36a2camr71215025e9.8.1758360385528;
        Sat, 20 Sep 2025 02:26:25 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-467fc818e00sm73648535e9.0.2025.09.20.02.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 02:26:25 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	upstream@airoha.com
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 2/2] PCI: mediatek-gen3: add support for Airoha AN7583 SoC
Date: Sat, 20 Sep 2025 11:25:35 +0200
Message-ID: <20250920092612.21464-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920092612.21464-1-ansuelsmth@gmail.com>
References: <20250920092612.21464-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Airoha AN7583 SoC that implement the same logic of
Airoha EN7581 with the only difference that only 1 PCIe line is
supported (for GEN3).

A dedicated compatible is defined with the pdata struct with the 1 reset
line.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek-gen3.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
index 75ddb8bee168..db9985375be9 100644
--- a/drivers/pci/controller/pcie-mediatek-gen3.c
+++ b/drivers/pci/controller/pcie-mediatek-gen3.c
@@ -1360,8 +1360,18 @@ static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_en7581 = {
 	.flags = SKIP_PCIE_RSTB,
 };
 
+static const struct mtk_gen3_pcie_pdata mtk_pcie_soc_an7583 = {
+	.power_up = mtk_pcie_en7581_power_up,
+	.phy_resets = {
+		.id[0] = "phy-lane0",
+		.num_resets = 1,
+	},
+	.flags = SKIP_PCIE_RSTB,
+};
+
 static const struct of_device_id mtk_pcie_of_match[] = {
 	{ .compatible = "airoha,en7581-pcie", .data = &mtk_pcie_soc_en7581 },
+	{ .compatible = "airoha,an7583-pcie-gen3", .data = &mtk_pcie_soc_an7583 },
 	{ .compatible = "mediatek,mt8192-pcie", .data = &mtk_pcie_soc_mt8192 },
 	{ .compatible = "mediatek,mt8196-pcie", .data = &mtk_pcie_soc_mt8196 },
 	{},
-- 
2.51.0


