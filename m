Return-Path: <linux-kernel+bounces-813972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFCDB54DAC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780FFA05765
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E8F30AD1D;
	Fri, 12 Sep 2025 12:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YxgZOWTO"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330F8309DD2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679900; cv=none; b=LsGurPrS280rlldk0xW5p2jVrHm8CCnvw20XS7q6U3NC7JQzap6W8Vg3MWYSrK2SwNKOmN53QoYaoYyhst4x7f8VJ2uoRTJUj4ava+/rrQEYEiACRQeGgfITRG/OL4cVQopyKvljhsYZmQd16OxBfxqOMcZQQKktRtREY6jRvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679900; c=relaxed/simple;
	bh=I+7Djs63l7GXJDTeAQ/27T7cio0NUXbO3zrKL/onyaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pthSL3lQ4wRiP9o2btdrlOFe+MseRzc7LfI3FrWLodfyMnpyL/u49XZI9vDsLA8LXea+BGT2sMNAe/9YrJUuYWpk6L+u+8wDq88ZE/iFm8EgTVNzQkSEJ8y7LbdOaskMOq7Q5noCIoe3+OM6nnEHhiGMmOScFNy9cy6qdTEZfoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YxgZOWTO; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45dd5e24d16so17581165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 05:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1757679896; x=1758284696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ARyi1JtLeVWE3myoQ0nLHpqTl+/cCe/5eCYR9rK2cSk=;
        b=YxgZOWTOGiTX9FNpsIwTl8DIZZdHCnLruyqXSBWtftUePKEvs27mvWRI2SFY5KBzel
         AYt8OZ99jg6gGRsVlYT1dpHHNvMCqkbEKLQrOs/gbfyvdDeBn91VrfVrdh9jc3HFDoSG
         PYee6HaUWkYMQ3PIGnMzovCw6S/OPkAd3qcF7LdRlbhENKcY1TnZ1wuDc5k0WsKW88m5
         agUqkGrpNAiD7Ti2fvqwsg3+YGA5vocXTC9Yyrd2CwSX6fo0wRm+4T5br2UuGUatIxG4
         ChqcnTD5/r38wAvErJtGtExCkSqqGTy5nyMzMPWlRawslC4OhY3tY7oD8/dJxp9Tr1PO
         5OJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757679896; x=1758284696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ARyi1JtLeVWE3myoQ0nLHpqTl+/cCe/5eCYR9rK2cSk=;
        b=aX2zMNy/jD8K9m6y8RnufUhCKe++HH+KjJ7YQklI/vsij6fpFNyK7jiEwYls89n3K5
         Zbfky5LjGhujLUtjG7LS9MZmTx6MwXEUWXCzKV0ZxFTeO8FxVx9SB7gMzHJvl2Sbwt3v
         Uc3njMqSNGRlth5erN8u9SIro2tsHFpmaptwm+ieIlUpaq0ZxLCrVNVKA5a/wGWAT/sv
         dGoK21pWA8ccxdoupzDoeUekNBdwNtMe3+csoSUv+X5iU/eZLN9thdbWRZ1L6foq6waw
         TYCuh0HU5R5jXNeTu5oP+1VxKhkLAu/oQ3yuBOi2zWVvdDFa9g/4BDLI3GQSWRx390ie
         Y3qg==
X-Forwarded-Encrypted: i=1; AJvYcCWhYsd8q8oktu+/3OqQNmJ2DwucR0p0dSTU36gl0jPoENAgkWahP0WgW1QTd3V3ofjabAUt3Zs967ORgrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9Gj3svAtsrjwb7/QzAswn6ek0QurXGhml5qETXGSnNUvo1sQ
	4FwvAcbtduFJE31sciAOG5Tl6nrVwb8A8rrNV15xGB9Dw/W+QUsZTvF4uG/T84t4/ig=
X-Gm-Gg: ASbGncv+xj4ijtHeT7mCw9vBGQvjHF/+ol90LPojmpqfXea4O9Tj2nmRxN6PfUXnA5O
	2B5heuvqMuqOyXhwvIcUlFdMQ2saXoO/AhQDt4YDCeAeKbeNi4PeL3t8jMYtXMX9yFZ0trPTz2o
	Oy+4FptAtPTH+cPETWnSRUc2Nea4YWPWRukcT7gr/26ESm1xBct3G+PML7JT8yzCMdM1yiRKx/f
	pzoaHHYdJOr9U32F1hSVKatgugLzjzGYzQrWLSzj8Tuo9pxkPrepkZErWbLJkKugmzDx1sCM5nO
	wPX0ZQ1JGXFP6NVG3ZiIHCfqY9yTWVk5WcEaOBJYE0VL+Wsw/u+tr+QyLaE4ltHHu82t/8PPbEj
	sd4DZQE/cOcP+Sizt3mMtY/EVo9hBju97a/AER0Vv1lsoaSVfjF3Z
X-Google-Smtp-Source: AGHT+IFY3fAYyW6+lOKtkEhb0t3Tc9Ke60QYZgP9ORr1yLOrzlw8YMbaAkUxbjz4913QtbpQKyVgyg==
X-Received: by 2002:a05:600c:898:b0:45d:7d88:edcd with SMTP id 5b1f17b1804b1-45f211f06d6mr22329985e9.30.1757679896340;
        Fri, 12 Sep 2025 05:24:56 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607770c2sm6320091f8f.8.2025.09.12.05.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 05:24:55 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH v4 4/6] arm64: dts: renesas: rzg3s-smarc-som: Update dma-ranges for PCIe
Date: Fri, 12 Sep 2025 15:24:42 +0300
Message-ID: <20250912122444.3870284-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250912122444.3870284-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The first 128MB of memory is reserved on this board for secure area.
Secure area is a RAM region used by firmware. The rzg3s-smarc-som.dtsi
memory node (memory@48000000) excludes the secure area.
Update the PCIe dma-ranges property to reflect this.

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v4:
- updated the patch description with secure area meaning
- added reference clock for pcie_port0

Changes in v3:
- collected tags

Changes in v2:
- none, this patch is new


 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..4c1bb97ac9ed 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -214,6 +214,16 @@ &sdhi2 {
 };
 #endif
 
+&pcie {
+	/* First 128MB is reserved for secure area. */
+	dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0x0 0x38000000>;
+};
+
+&pcie_port0 {
+	clocks = <&versa3 5>;
+	clock-names = "ref";
+};
+
 &pinctrl {
 #if SW_CONFIG3 == SW_ON
 	eth0-phy-irq-hog {
-- 
2.43.0


