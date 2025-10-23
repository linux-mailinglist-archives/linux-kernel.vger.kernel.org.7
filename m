Return-Path: <linux-kernel+bounces-867122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E9C01AC6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0393D3B47A4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5925C31BC82;
	Thu, 23 Oct 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="SEUJpxC0"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010B7328B75
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761227919; cv=none; b=a11wZoZYyEcH5Cha2h6ppE5PyotYZput0dL/v90KixWoagUpJWu8NVoTy9/VN9hBOgdNt/VUWThkgrXa2WE3PLfpIIrNEpYSmooDXkaCHIaaDc8/+WdjcoA62rhgqtfT0p90oVrZN8ZfW90cCiW0Zlev39A91SkG17Vw+yCBT/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761227919; c=relaxed/simple;
	bh=gVMp9OKX1E6FMgxJQra5Aw6qeOKI1S5qh1QZpcnn0XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XvUqQvVaIELXS3783uWTazEhjqcO4FCGVDNc8UOsTX8JGls+IStM7OqAVec7wS+HjFwa6qIg6axIyHpEU30UocrtceOhUTCRonmtJvGYm7mKvvXRe6AS9RvndZ6Yh/Nltv8YEki85P9J+TTpby+QZxk5Rw4oWpArLScluRC0KRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=SEUJpxC0; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb7ae6ed0so197291166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1761227915; x=1761832715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5v6y+GjI1vQGPmK5PBayMgAyAsV46MUdg+BfNU35YfE=;
        b=SEUJpxC0r/cPOhFuwwpx3ViQU5kUen49/A9U/sBcUlS7VfOUUcOCxSq0lCBnfY3jH5
         RLg/f51wS2Z5yY+1q5KdS8+WdetyiElV5VyFcXdeNRZKDOaVG61Z1mFzzxyFxqsQvJ3r
         Axus2iLrSjaPPedHHNKajwQ5ARTL+usYv3Gkb4oRlaS34WroSM6F4lS+ZvA1gYJQzxcm
         aBDtq6+UKquCRzNO42/3AinDwgvXL5qMJDWezrWzs8MbulLEU3Amnnapd7WLE3iJ80Dg
         zAzzyDrpFJsdFb5b7SNiL2cwLJX4mymJKg1d2wRHxvVsvcwE/caPSwXGpL5N4tx0172F
         J7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761227915; x=1761832715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5v6y+GjI1vQGPmK5PBayMgAyAsV46MUdg+BfNU35YfE=;
        b=FAzH/mPGNDBbE1veg3gYTXLgFpxplZLK6+WViFVa7HSbAWYNiQYyZO6w//GA2YQP1y
         9YmqlNs/JNoqIprJyNk/EC7DndsCwHfYvKk+rPmT7qZGADF0g+wkhN2AOPyeq6E67hzU
         XGdH2+FOPM+lqnjpWzTW8Cxz7ijA03u9MJad4MpLgRbS9cFQF5KP7VoG1LcAUet0KDz8
         rr28dw5seGOahqOvcHw+wSc3/AJPOW9kik+wTdusff09AJdoaGIzR1pVUUhgnUzut2Ut
         zFxPUO/dW0GGfzduNJmk9nvOZY9pV06F6MQO5bVjn4XTQfFR2k1P/iWwDanBxg6+CYmM
         NwUw==
X-Forwarded-Encrypted: i=1; AJvYcCWUpeUy4F/MFWyW4Xe185q9bglpO6U2oaF05Krz4OtH3IdBcDQMlxrnE+CDxsBtvMJwzuBHdbO1iVuXYSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfKdew1fWzeD+jwsmzrBZ54nBx1VooEraHRdN8TeFKncwVzVL
	+8JlM51ROwNmIJGBWUyefnwMq7JpPjnlYt/vYdfFhKbgf/L1a9eX1Y2xBWsfWrGtJtA=
X-Gm-Gg: ASbGnctDr5lm6eQDyf35mPg9l/w7ArZHtlzl/7XTT7Ei8Q7TkC74I+GZi2Tj18QJ8IB
	gepkRcvz/Y5J1i81L88O5DupMUPuQHgSMx/2O+l0uE1W6hfY5ycp8mPGLackZq74/IcY1X/4MhT
	Y0lO/fgwon4BqF5voBUS6mJJbHLRuUNb8xd/2SK3tYf5s237S+qfjRo0UFbVMw5QWTPpFPzFPbY
	XILd6FVVM1r1ZETktm9YEfXK+AxUOjmakJbzQRhLFLf8pgHLT0tKdgxU+Aci1GMmqUmYKN/TwMY
	m5HGn0JAAxRri5mKKjJC7Wb5SKMkLjW1/zHgMKZ7Od6c7nnVL7pdibMc4OLRsmuwUUn2taO7Qop
	bYzMUn2TK1qTYeY47zsDA+GsHH/Y5IthPiDOYwYH2BrdaXSozR5a401nZACrZHtRAUDJujGw/YB
	/CUcrpWJbt95wCQZNfIgP9rU5152pxig==
X-Google-Smtp-Source: AGHT+IEC+rYJG36/rC4PJVSPAIdX4Lo/ftVglMxpEkizTmYDSbvRujYXusVRK/4v8s9FHkKuEzGgrA==
X-Received: by 2002:a17:907:74b:b0:b3e:5f20:88ad with SMTP id a640c23a62f3a-b6476ccc0c0mr2866186366b.28.1761227915106;
        Thu, 23 Oct 2025 06:58:35 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.151])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm226114066b.29.2025.10.23.06.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:58:34 -0700 (PDT)
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
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v8 5/7] reset: rzg2l-usbphy-ctrl: Add support for RZ/G3S SoC
Date: Thu, 23 Oct 2025 16:58:08 +0300
Message-ID: <20251023135810.1688415-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251023135810.1688415-1-claudiu.beznea.uj@bp.renesas.com>
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

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- collected tags

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none; this patch is new


 drivers/reset/reset-rzg2l-usbphy-ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
index 57350764be25..1c0424639e66 100644
--- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
+++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
@@ -96,6 +96,10 @@ static int rzg2l_usbphy_ctrl_status(struct reset_controller_dev *rcdev,
 
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


