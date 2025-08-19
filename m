Return-Path: <linux-kernel+bounces-775805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB08B2C53C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C161891BB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448D733EAED;
	Tue, 19 Aug 2025 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CHQz2dP5"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D4B305050
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609377; cv=none; b=InTOy23A1TODDOmwmWKvuIDZMFRYlzs0l8VWrJM2CBwxM4yiKIfmH4JCiPyNOAW/UbgD9zCD9WRcXFnPpdTZKUqKfpBrsZG1ce/3+G0YuUCOmMDaYewrNsdCChk3U7LGFefuiyOCmExetORgTupvY2z/RrLegvGxvVUDGfG2NfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609377; c=relaxed/simple;
	bh=zzJHbwP59FIAJRbh/laHlAqr7S4UlzgO8wkJUgyct7M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YLtnbVslxwF1scC3hydNVOREmDOF1K/MkBBcYnAfWysPosQ95/BfB2Cee9CNKtW5yw1O8gZz7F0lr72Ji5eXGV1jXLZJsEMAicbIXYFFwpGjrI3CrsjDX7r7O5v6AfQR+MkysaehsYek18kLFty4r45nCaGR0QtqsRTxluUZVY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CHQz2dP5; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-afcb731ca55so71890966b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609374; x=1756214174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xi518gsMPwf+xO6KMftj9HzM9h9TUyQOOtDZl1JTxQw=;
        b=CHQz2dP5P24gCrR0rh8AvtJv8SkxyI7jO0gyVfWcLBLwy7mTJouUyCcgDRn6YOQkjk
         JZra4odMORxc+TPvq69vj+imm3kfKTxZ62R7+wt0s096wjk3vfZ5wmkFEzsHF9aBumxT
         4eU61TzaWbV4kMZNrIqgMJeBmD3D+HD3vSec0aF39YGIqltn0rKETrxSl7fx5XAaxsb6
         LChe2a0Imf55S5+piU9b5c/5fQFXInKTvzDCA3jkEYqRpYyIfvmxuVhB3i7bhyvdiIpK
         SOuD9gvA0o4kYbegFaE/8san2nkyP5UwXIqQdMS1/1Le7AsGyBLyVUHScLVw2FQgoxAk
         qW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609374; x=1756214174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xi518gsMPwf+xO6KMftj9HzM9h9TUyQOOtDZl1JTxQw=;
        b=kJzl3DJiHbZtvvusG1O8uMSsBeKxv3nbCqqJ0hR9dtmoZwFFGulIuNbQzN2EatKy6X
         Fv3fZH9TZkb1Ixqka2ajSDn0xGhch/IrVih7+it6HLL8HP7gjfA0uZ9E+1oahtJ7y+9C
         /2BKlF0whc3pt/EWK1hqjPnMzOFcyCBo92t5NwI9DfJim2DMtI6No43njjqwM5NoNhvS
         l191Pm78syaGGTSJqaG6Vpnvod1W7x3J2EA2wXjVk3O74L4UrtAsCPCsbVoR1nwdvniG
         gcTxNB65URG/dSkDqj72fLN8E19peRs65yL8dScqwu5bVdRLRStwma9WosPfDvHzYjfL
         rl1g==
X-Forwarded-Encrypted: i=1; AJvYcCXmS5U/EAFMmTFj8zcTuPnsHFq4DrJniwGcaC223IOIem4p/Cd71MVfEZs15BXvpDzG7UoBYLimBwWhSVM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNa9wjlCwx40GAxktcOILTco2GTys95zux1rfwi2ds1jl870W/
	wJCJo/yz3mT5INjwC+m5r7UBm34BMXjnFRHpF1qv1rJcr64QLh9nVn8i94ggDDWHEww=
X-Gm-Gg: ASbGnctWpuyrsrCOUK/ANL19Y8rMZE6FiI3o9RPJ0E+80nvPMTDy9Rch+zkYFjPBEy3
	6LnZRQnDJanMmowG3DLQ6yhAqHlfokbvjY8c4Zy7KwzsCf27ewPDDpKAfORq04oCOSelQM8DeEY
	ApADGX5igjgm1LYw2bA1MYZEPhq7SiN3bRmE+ED6OseS+OQ2zJWxB4cnGKm4WThfvGNLFMM7etV
	R0/xURdkqb4bAFUKIRQCxnR/Aa+A0TQ499luBg2wpkzmYPSjCsa/ZJNi5H3Gug4UwK9xv675+fr
	kZJNhQmQciN7o1avI8gkoPzEsWzXO0Ne1VH4hmYJTBhuelD+klA3VQq1pNceqoPVLXhVVpSmKZu
	Q9qXv2tlFHxVsLI8qE3nSRZQ4Sd0980YyG0oCRDkzTOBh
X-Google-Smtp-Source: AGHT+IHNAQts7Tkq0in4K3BOL40AEJDywoXmLp4e38sGlmKMwBIojenupdYVLaUyK7UVgv2eYoj8jg==
X-Received: by 2002:a17:906:c112:b0:af9:5903:3696 with SMTP id a640c23a62f3a-afddcb4df7cmr81510466b.2.1755609374036;
        Tue, 19 Aug 2025 06:16:14 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdce53d60sm998744666b.20.2025.08.19.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:16:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: rockchip: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:16:08 +0200
Message-ID: <20250819131607.86338-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1479; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=zzJHbwP59FIAJRbh/laHlAqr7S4UlzgO8wkJUgyct7M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHkX1WKSqJhvQcELKxO426h67ZTlpdrZBKf1M
 5oH0eMggemJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5FwAKCRDBN2bmhouD
 1/bFD/4pTRoaumxN4qomkIs6yFeXrcTZBRmPV7OywqqKgE0NJ3WJviWn/dX3kiNForLEobrQSMA
 7i1yOWVOmKASx/uWgJIMy/Dfo6UbTYSCDfOlIHpIdW6TF7TyEIGbQRF88NP0ZHx6P3EqGh056/V
 x4m3PTjiseJ1hWbmgE4fdcHlFyrRxo6QTnnOzhx82sdoQhpeRCM+zYe0iK7pkpo+Rn/+V2m8Y1V
 bjV3p+u4+VT+lVfJhQZFpMvlZuyBD5ealdsJoFj9JE3/iB3DG+4eDqpywmkPWecdtsQcxC27K+O
 x9T/J//KGtMnTguaOKQtB+rMAVPiq5H2lOGizXIhbikXopn+Woo5x+qW0Y59Q4PdzZW/IG5mDX9
 Ej4CCCPSSbEsM0W6ch4fTN6ofGGWIkx3bw3SMI0WBEEHehrtPFRMCdR/o07DivyguWeJKcmkIws
 0NJcIH3Jn1JxBpHArx5tyAJ+nvB6c8Za5BX+IWOf1o/MQ7PzWgKRbtVUHouBAjwxfBABnNOvQxG
 BeRbFi5dJSpKuph/cnHwj/9MxK9y+H4uK4/waTuAH8NkDRlZ37Zd/tA3sQlEcw7cKhMMDxgGwyV
 f+VYKL+GDd5XIH2ft52QowEGKHBOhV/v+aBL+a0wWbuxlkoYAGyMcGi7E1lhu71rAHGAswuBucU BNVRX5amtmp0mqA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts    | 2 +-
 arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
index 21f824b09191..decbf2726ec4 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-xpi-3128.dts
@@ -272,7 +272,7 @@ &gmac {
 	phy-mode = "rmii";
 	phy-handle = <&phy0>;
 	assigned-clocks = <&cru SCLK_MAC_SRC>;
-	assigned-clock-rates= <50000000>;
+	assigned-clock-rates = <50000000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&rmii_pins>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts b/arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts
index c13829d32c32..8a92700349b4 100644
--- a/arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts
+++ b/arch/arm/boot/dts/rockchip/rv1109-relfor-saib.dts
@@ -250,9 +250,9 @@ rtc0: rtc@52 {
 &i2s0 {
 	/delete-property/ pinctrl-0;
 	rockchip,trcm-sync-rx-only;
-	pinctrl-0 =  <&i2s0m0_sclk_rx>,
-		     <&i2s0m0_lrck_rx>,
-		     <&i2s0m0_sdi0>;
+	pinctrl-0 = <&i2s0m0_sclk_rx>,
+		    <&i2s0m0_lrck_rx>,
+		    <&i2s0m0_sdi0>;
 	pinctrl-names = "default";
 	status = "okay";
 };
-- 
2.48.1


