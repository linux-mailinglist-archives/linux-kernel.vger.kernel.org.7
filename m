Return-Path: <linux-kernel+bounces-774892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97259B2B8DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECFA4196894D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508DB31159C;
	Tue, 19 Aug 2025 05:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aqwlLrji"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE5F3101A8
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755582150; cv=none; b=MARcy0qqc243WT8eGdJBUPqXCGYSD1KafN2nyBJjbkKQ85WMu6lJHxd+cSp2hpfbPLh10AWRllMNQQrQznsjxN1oFva2NkRblxn8IgnCvfR2IzBJRMS7euPF3kChpHcF/VeayccI+E0HzvYAWzo91gMgl+vTEz74OWKnFGWiizE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755582150; c=relaxed/simple;
	bh=I2pIHduqkXRd0dLvTIouEU/KSG35hJ2SXBnZux9yRG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FzjQvKeDDorO0ZxK8CStVPub8lVMvlHaOADF9TSS6Eva1+zRVUddwSxQfqEXEalA8i4bCBao+6PJQHy0DATjfPXo3KxaywIWGSQQvbJLYzbPm1L9Klb1JT470WXucMZpZOyY72+E052zHu5MqNaaCCzwe+dmq+UI8zcMOqOZulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aqwlLrji; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so27581885e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1755582147; x=1756186947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRX0/ILbGcYC/ZOQ37kJqtpxqFwl5Y5CWHl3KvwJH70=;
        b=aqwlLrjiQ6l2Pt/S5Erw9BdgoaYUKGklnFlaO9M9oS6u/1XrXYGm1g04etCef7wz8V
         GnAvyBcZFKUCRvAIj5l/yZoY9kdsmQ3J1wdxgJConHkfjnXgRoq5QGNop0P9swTGJQKw
         usRAZDWWrHyQC0I2b0/1qOl+7OHaD78jqOLUEtMrZ4ZLU1r8kiZyGxc5pNKsfrhzpu3j
         KHX1LJLILWOyrEpjrgpWJlv0Jqax2kUGIYYCEZxgKlxIz9fdNeQ26rMcOibWMphjoSZk
         bAwpyLQvYR7FPff7pRwxF1rumMbXeqMJ3/nqMZnEDA/RdovNBu69sYslGPEO6L8A/qEF
         4D+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755582147; x=1756186947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRX0/ILbGcYC/ZOQ37kJqtpxqFwl5Y5CWHl3KvwJH70=;
        b=O/R+vwqJmBxaDLjzXnypAiRBHsO4GGMsXKtVaPpLPJbP3rvmJdQ+g1LrqATKa7yAf4
         TjZkY940BEOi94P34oubLJ77UvX+UhGI3iyTLbHBQGwNTmDSIzRjKR5jU9pZShYpp2Ai
         vyWcy6LF9RaAEbWifernx/6zff5vBNRk+E+DC8KOmiHX6oGJj8/MD0NAPhhe9dToBbOg
         7NyV+M8u6D4F9F+zx5ShY+P/DcQ6oMOMpZHBnS4CfEdV012AQq+bcGVjwm0RgMtTXxc9
         7uYtaBcHHAgV3APcIVx/ukWvpB81Jf5By4LzahVi/i3D672cKdNLbHBPBt5xeDGQkx6H
         qgSg==
X-Forwarded-Encrypted: i=1; AJvYcCVMpRSnyk9aBDjBBPARFiuwzILRu0ryhhvBDi0uKqepHLxrnTVOkzXBC1WWbXQdXXvFRjUIrs3uMXwr02U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1D9GGFdhdLbcva6/WIvpZsq56lGt7sryQwQyAqtadhdp4QRME
	lp2i/kG3RiQ11IkzSsxEHaPD9NNLAG08yTkcJcs0lzsZX7cchAsiDkG4FYASPb/7BNk=
X-Gm-Gg: ASbGnctSGSxohdPx1dki34nOIDaHlYXbhFgg2TjVvYDAzLTNRJ4mMErjY4I5yeGY9Yw
	YZEgvbxUfKRSqQktuLXTNmp7ejcx+14vO1pXJEhJD/lMNHDruO0sLgAdoHr+9cas6BUStzwchw0
	UrvZJDjrxvEu8BKwtrPAJk0Sk9q6xHKsgPysByZeVRStYBOWsUts5cukAwyIKR5yD8zVpFkg4Ag
	SCWUJXVQlludM5Ij4lBZfskcly6yzMNX4Z1eM7hNVGUcH9/JFUh8avt9xVTIsaVFPTa54aKixPd
	b4i0gv4Dl3QU52EbsrrKKwSPrjyMl/6/HZ8I/m/ruJopuB/BYbNRd5alnCOBcaeYEX8T1jJRNuY
	uelaQvfKNaqpu+VbhLjq1X2s/YMV//zv+SwAR2ge8ZWI+py/xM5SXuuC0Ks1NTLtMmuCLsCOtaz
	4dOeOmR19DstLQne8oBQ==
X-Google-Smtp-Source: AGHT+IE82eFUk/hVv5JzkA8bqsXhoqq+l404vddic1GqJDoG4Xu5ff4Uf0NgyqJJ6Jq6LFzRsve22Q==
X-Received: by 2002:a05:600c:3f16:b0:456:1146:5c01 with SMTP id 5b1f17b1804b1-45b43e972abmr8107215e9.12.1755582147370;
        Mon, 18 Aug 2025 22:42:27 -0700 (PDT)
Received: from claudiu-TUXEDO-InfinityBook-Pro-AMD-Gen9.. ([2a02:2f04:620a:8b00:4343:2ee6:dba1:7917])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b42a9847fsm25097345e9.26.2025.08.18.22.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:42:26 -0700 (PDT)
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
Cc: linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v5 5/7] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
Date: Tue, 19 Aug 2025 08:42:10 +0300
Message-ID: <20250819054212.486426-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250819054212.486426-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none; this patch is new

 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 3856072b23a3..924c614f84cd 100644
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


