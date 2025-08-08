Return-Path: <linux-kernel+bounces-759766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4506BB1E227
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D32C581329
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 06:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA31F30CC;
	Fri,  8 Aug 2025 06:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="V5yDFkHB"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7558D2288E3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 06:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754633915; cv=none; b=tjCmrA1/ks0W9fEWGffo57DkrSh/+vbCfBJ//O8WQRllRNNL84EazVtmA3umF88GlOTNh8VBUJQ27zd0744JdDoD2LFH4uN0S1KLgKRbGxU1pIeGD7gS8UovlPxghJ/wKtQbvvU2XcY4OwlfGfCFoyaoxq3gSV4/p3v+bT5PqlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754633915; c=relaxed/simple;
	bh=d51qXhMFqngZ+nXqw82toVbILYHcU/fluB+NBuKSs8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e5RhmjhtqRcNgbxvBfMUnucbPhc+Gs6pUJZGGgGem0MS0ztEvZ4wgenGR9OUzUx1L7evyLV/n/Vw9JUEPJhIS74vwhC9YcF1mNO+FqTj2bXZGVoCvqJfct1X0GnqVM3r2AOEbzdKPsKvizKRYd08G0UzU+wpilRX70lR1p3lImA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=V5yDFkHB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af95ecfbd5bso320546766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Aug 2025 23:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1754633912; x=1755238712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgaBZoG1YrnEA6bfqCkXkFoVQXkJH/A3swaWngLeOHQ=;
        b=V5yDFkHBNQdwb8OUYVeapmH6EbojB22hATBJpCabSihJ4VpRb+7Cag04mmAH0LIaSP
         J7DbJfv9NraRgjCeHkXGKC9NM1KTMKpb+aXj9Zwt0FZorAKN9BneunXqxV3pXTLabKNG
         U1WnPNXOB+wPJojuhH+DxlG9Qn+7dgX1pjl+G+Cc+B5yWotRn0D1Aedth6I9AG68H5Ww
         WZda5+9RCTiBvgRv0QRLByKv8s2opd+uzjvAJVddtOv21PxRHb+Kvb56YcxqyG7xyxic
         M+OvaM8B9GI4+zWVKOU0BVwcxHRW3rpWtwFyzZZovqV5yC1COxQI7lf+Qd20UR5CRu0c
         m0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754633912; x=1755238712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgaBZoG1YrnEA6bfqCkXkFoVQXkJH/A3swaWngLeOHQ=;
        b=TEX03mkVSnVOtnKjkj2IzUfMZBMpJvBCQMGeorBpnu/aB1gxnfdymfU/eYMLiVPFQ+
         KnP7sERdaBYw9rNtk6faA2enVHYQ2BhcEZKdlNVEzpcjDEpzM/MoSaGf2+OPsbm4JJsj
         mwwLS0vDK6SRQyjnNoThkADSIW0DmG0MMuFO/eLsiBfnwKftUqKOrHsIsZ9X4rYHFcT2
         8EndVu0eYPQ7/2dYzY5UuHYUBU++7890AdjaUMfdfxFNL/kJe/aq8mkYmm6xu7b55k//
         hC5xaQZoYXq32KqafzeuWbRnhKifoeMtS7bzKK9hCGIMsWWwdPQ84MYp0o6wc1cKaI/Y
         uwmA==
X-Forwarded-Encrypted: i=1; AJvYcCWmuo1TAJUh768B1YaWbE46MKpeRqLr2LhCKc7JwdtzUoiL52KVONOLN+bXV8ohZhocZcX5cNkj0YGTMkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXYktR3v5Zpb68jGmZ4j1JxJf5AJ0ER9qdpMKoWgTXY/Sds0Ba
	K4mo6frMtpDVLlOr4KNEoWnCTRkkOdmRdMX9t7adqENT2wMUfPMBEDh23bowvKq/0Rk=
X-Gm-Gg: ASbGnctNsRKMD/MWyy/8uzokjJ6444ZoERqpLYvyjoWr55xxj/uAT9jb4khxHA6aMv0
	MJmD3Fh5nUjprw9GJ0wbcRqZyIjJdf7ZOHz1AV+ZBSu90n4H1e+J1YlWb0EGM2dzi5MLm1/FDCl
	7VwfevxJnXC4tLGwtUx4JM3313WGos4rgOyMLkBjaJeW6llE46+NyTWJw35IxhDoC0MIq3Dv7Sn
	DOnHKTsnBkJnhVKycEcPR6ChXmV35uLxyIdLhP/XsVR/g3nZaT8GOwYhxo7q7yH1WEqPSnb+q+b
	Ba7+5sc540x9HJmWAhazcdrNQErm7SKpDOAdJbfWfuWj77Hjq/Nli5ISTfucBw6Sa2jMZLWP8NT
	7XTmMzFg02M+e6Ay5t+LV61ECSPRovhvS+bBDlV/Eds6GUsCmJ1cuHLY1YnpALFE=
X-Google-Smtp-Source: AGHT+IHttm5+ImjErw0mMRHoLiZ9CbwBXmRFtvaluIHBtf8iEFaAC3msQWdYIGs1nItjsBv9XcEAOQ==
X-Received: by 2002:a17:907:72c9:b0:ae0:d08b:e85 with SMTP id a640c23a62f3a-af9c6613dd3mr145882366b.61.1754633911879;
        Thu, 07 Aug 2025 23:18:31 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.188])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a218ab4sm1440488566b.92.2025.08.07.23.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 23:18:31 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v4 6/8] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
Date: Fri,  8 Aug 2025 09:18:04 +0300
Message-ID: <20250808061806.2729274-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250808061806.2729274-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The Renesas RZ/G3S SoC USB PHY HW block receives as input the USB PWRRDY
signal from the system controller. Add support for the Renesas RZ/G3S SoC.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- none

Changes in v3:
- none; this patch is new

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index fc14c41f5572..8aa2a5833c2e 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -108,6 +108,10 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
 
 static const struct of_device_id rzg2l_usbphy_ctrl_match_table[] = {
 	{ .compatible = "renesas,rzg2l-usbphy-ctrl" },
+	{
+		.compatible = "renesas,r9a08g045-usbphy-ctrl",
+		.data = (void *)RZG2L_USBPHY_CTRL_PWRRDY
+	},
 	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rzg2l_usbphy_ctrl_match_table);
-- 
2.43.0


