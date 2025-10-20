Return-Path: <linux-kernel+bounces-860715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B43BF0C30
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:13:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2C3A9371
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98562FF147;
	Mon, 20 Oct 2025 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMZmj06c"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05AA2FBE05
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958709; cv=none; b=VMDLOqkByPFO8sbjWqC6fjavpyQzFxsiqCX+CJN4osm87UAazfpj4QLCHDeTO6hPtMCWX451FAJyQguRLt3hJpYxhuNCXiMQ/DC1YoHXmkQLog7Xz28Jck/ARCubMjzdRZgIeU28QnZqZdTnwGnU+ZPsDdJhxkqETFQJ+IAYC7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958709; c=relaxed/simple;
	bh=u3O5/Vnm1zd6rOBSlXUrvnWCu5VwPjHgeRbcIJf/UzQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UuYaT7/WIPA0xg5/jAdynBJmTPQwbLnHu50oTdtOaG2YXxkfqAfgvPofrgbCcTL9+T5tFg2qGv9Wdu9vum865xaiOzQbvb7M/ZsLo2uQOmG+ZbetHE0sLm5pLCL9NzTOZ/8BruE+zNZ6xcM/3ow6cyafYQyxvqlAypGn49oks0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cMZmj06c; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471191ac79dso34130855e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760958704; x=1761563504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mh4C9N1Ju5JAAtnjcdgue8CazsWnd2rnlhBAUlc6beo=;
        b=cMZmj06cksMOVk/z5IiLs7k6X6gUa1PwL82OjpUT4xRT9f7hXVUhyQb+KUdjiUCBLM
         PfyaSbR3sDBf8tyZSE2/4q6ETeG3acjfG7Luc+ETjZ+fNVSRrWTIxiv33zNzRzZJl0v3
         pX2o+YBEfb5QHUFImR98O56uNIzYWnCZxZc9DEgpW+C/ecrzOVn2W87Xx41+fk3Di5Fy
         2wJSp7SX8VePaTQBkTU4IARiMgBIG5VO4aUpw1QbVCt7tg3DXolG6cYMyJXIdx8rVD4M
         FBJXBjBE8od+hFEOA+c48qN/MklgtUxqP8lA2hR+98PYG2b/ESewvObGTh/WKKGtoNWe
         +3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958704; x=1761563504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mh4C9N1Ju5JAAtnjcdgue8CazsWnd2rnlhBAUlc6beo=;
        b=UhK18/enyAyfhdpxp50pbmWetue5Ga1QrWoRmloMh4d+TgcG1dFC2XW/h+KOAetQ8J
         rPJfjxXbZtDMyEY7sdVEiyQznvGmXxOGKW1FS/AiHb+YYSIklKt743vOzUGSqnuw/5ba
         BrwF6gANKf9rIaQTpFSpeOU1cOPyvg9rYsPDmrbK/F83l+2BZH4nvYa8cZEODvHstsWz
         PCQhQWbqyn6dCaascbeAZ35SO2shbaZTR48or8YXwn4hIxIghViOeVCwMPugZGOaGp+R
         yjOckveRm75bKZEsxajNngr5YuyuDdTKFpAE0kXp+lbmXDAbpntl59J1bAv423te20Dv
         160Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQDnZWSNv8ZuyYIISBPh9UHoAlh3LPdcrrbrXVHRoMpGWV2XosKxgezMm03Oj6q8KAvtE9knxcf/GO4WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZDUerwcnbnpqPRGxeBqMH1l9nHzPeZu4vRDco1WcvXxvUnXm5
	LkUj6SxOcJ2vbUR7I7dUyyBBU26UD9Yrzxfoy8TLQgUuh0a8flbcYBYG
X-Gm-Gg: ASbGnctceXYhIrxi+g9FuQKK1ogcJUUtMW4UDV1VkiMoO9b+DiTZjsbVbGtcZyv2Awi
	ODS3slaV08ncwpYInloFA9QneV6SpipX2ZoFj0HsAPTILtnejEP30orDaB7VWHCdenw5ONP2PV9
	Lk+gCBmCwhhXViobqX5KIEkDluDMf77oe2d6cB3odJ4z2hfqxK5hGqfB/QQvCO+jKo82Aw5wMDs
	QZngNTHN+gB7JM9ZOUdNZPIYWFnWgfhU5adlNZkLMHnKrJtDrR0MPiR3CMS1Frk6wdn0KvGzcIw
	WL+lk9ZzWIG+4rA9zMxv/wHvM31XSDkclC+bnNReAxcWTVIePhnC6+8iyxCmCa3+g7N6I7nv04X
	AVOjEo0N6/lggXF2S20Ggk8BbSvsOuBSubjkY9jtlFaRKJeGScbVcB+50BTgw038V1+MFaSun26
	yBfRxGnDypY2ZNu3UPrySmnEjog7c97TkBpqNdk45pXcg=
X-Google-Smtp-Source: AGHT+IEC/EgoEzWLSutjjbvP1mXzMKOilW3J4zLO71+sEvQNi3rD9SLIUZ1bssHJ/V0ea3felgXDhA==
X-Received: by 2002:a05:600c:1e06:b0:46f:b43a:aeee with SMTP id 5b1f17b1804b1-4711792089emr93643585e9.39.1760958704255;
        Mon, 20 Oct 2025 04:11:44 -0700 (PDT)
Received: from Ansuel-XPS24 (93-34-92-177.ip49.fastwebnet.it. [93.34.92.177])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4283e7804f4sm12692219f8f.10.2025.10.20.04.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:11:43 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	upstream@airoha.com
Subject: [PATCH v6 4/5] PCI: mediatek: Use generic MACRO for TPVPERL delay
Date: Mon, 20 Oct 2025 13:11:08 +0200
Message-ID: <20251020111121.31779-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020111121.31779-1-ansuelsmth@gmail.com>
References: <20251020111121.31779-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the generic PCIe MACRO for TPVPERL delay to wait for clock and power
stabilization after PERST# Signal instead of the raw value of 100 ms.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pci/controller/pcie-mediatek.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index cbffa3156da1..313da61a0b8a 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -697,12 +697,7 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 	 */
 	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
 
-	/*
-	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
-	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
-	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
-	 */
-	msleep(100);
+	msleep(PCIE_T_PVPERL_MS);
 
 	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
 	val = readl(port->base + PCIE_RST_CTRL);
-- 
2.51.0


