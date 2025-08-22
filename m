Return-Path: <linux-kernel+bounces-781829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD3BB31754
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F831CE79F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD642FC025;
	Fri, 22 Aug 2025 12:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zf7BKyPz"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09572FB962
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864874; cv=none; b=G3pyuVRvGPG1AfnoeezAN2FwoSNlvO9l8j1ZooS+X1FdFOCyw1zK97cjR30tITYivu1UhirTIFwNGurhbf20kRPcbkEZ0eogXTB+/DYgpFhasJjB68v9Xe2TYBmXC0sXP6Qa2JH4rjkpo5iDjb0nR98q/KbTuATyORRJ2xO/Mqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864874; c=relaxed/simple;
	bh=5IK7visueTFPJvwe8aBx75t2Dc2ShuOFkE1pHPlyTJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bZnPNs0LX/Rx1a2G6i2sSoUdfQjUSx3UVeHXz2gfuI0EsMUtG3BU1QVDVtLNQU0dWmyKMJVwhoE1hV8U10wQLya7f98cowItKGhNahn7cNx6aPxWDHRdtE3W2g71w3Yvy7Ilgj84g2r9ubXGWjLLMMs1TOR1Neq9ZVNWbBpof98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zf7BKyPz; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-61c297e8306so23627a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864871; x=1756469671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DkBAAsfyV6LHd7/MmlCwhNuJJcA3WELhZpHBrkWxRP0=;
        b=Zf7BKyPz89RXdVHjILYb+pOlS/J8wENaSzkiPxrRkADJfVOau2LRPpHPrphJfUG+hu
         YUwXtVqzpeOFSVhDr4ZHRDnc6Z07WpeGHLJkGy198l128gx5NuBjK8fq4hrRG3R/+XW+
         zPGPJFVKWi9xUgnL+vYLHPwhHDUf8XpEXvzIFyEQcRtMwONGEOPaB5CEQEAABXQP0C34
         r+mU1n9LQh727zJLipoT8ybUDUHHnDH7L4g3Lof6ko7d3FvawSCBGiebIzJaa3xWBMVC
         7MvHg0OZk89zBcfCwVdIhPKTqZIh/ZyNdhN2B4hV5K514MDVejKZzZmnFqVfLrJs9fCz
         Pcsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864871; x=1756469671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DkBAAsfyV6LHd7/MmlCwhNuJJcA3WELhZpHBrkWxRP0=;
        b=LWR3fiXYb8Djsfand1+AvI15bT++wbITBj1AuW66lHWKG9Ds6+D8uPw9ADWJnfKYTB
         dujMRkq7ei0iuRRWxNpTa9rlryMP8RdM7t5icF89nTKrqhpeX4/DmnLwl7FB1JzPfyjc
         W/f/0H8e4H5vkfaDaqxP1NZXIu3fGvdZLHCHkKDcP3dYXJ2zdAT0XuQGK5zYZFOPw1t6
         xVYz/hRT9VRAmdosfdUR24LBpauG7bW0mPxVaW7Set44KQtyOqwib8otBS1LX8EMLmNB
         Vu+5uJDGafD4Ekc5EIL4zrzT7jOOtJ/xvvk4/LCvJn3GFW94vHCiOc5PDtfciadyoJNn
         O17Q==
X-Forwarded-Encrypted: i=1; AJvYcCUP/toQBuOltwHIfpZT/4yQXRJ5kSKggXyK2IOKAiEfpTHfjwHcmpHZfsers85+jnP6YvVcBv2iXRZoZfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfo8/0kvEIbSfRLWnMavFwY+S+XSvadAm01gyaW6eHmpKcHvSD
	LmnLW3qTi8NBFfENHEwYWBfH0Mrr9xgrHOPQeNGfKpliNGW9jgAS6Se1RvBK+Gm1lUg=
X-Gm-Gg: ASbGncvcPchs5fNVzauEystxYYyxveE+2qlGovxX7xqiSFmN5i5XN4yJ4Nygzson7Fi
	92gFJwbe6hkvJ+otPssVFiGMXDp+oRnz3WhfK4Q9sCoqnl+6pmssyWul2rBcwWG01r8J/B1EJOi
	neDTdS4vR0vD5sEwrLZaq+0AhLCklORF29RdSvmLmKDErdHYObHQVG27ABqn0yF0WiMNKgsrsUM
	lPPjNctzx5hyuN6nSXFB/SjCi3I1mf1puStN4+NE2RqusnSzEdwA05e0XHzoLs07ZBzgYIrVjBb
	R0/xs3NAjKEEH2Mb1g9yDwqlBEYbmG3fB8kbDcYMeYOOMPxPKpIgv1JHnJsNOeKH5CBjvox08Qp
	ii8jMg877FvTgJZ/xfGYTdO7IFDu72eaITg==
X-Google-Smtp-Source: AGHT+IFs4WBH1bJhJTxlQHx++FWWCdHXe96mTCh87JmHiQTRMMJIfTGjozNDivKIUBJBc92gTGlIvg==
X-Received: by 2002:a05:6402:5251:b0:615:c741:ec18 with SMTP id 4fb4d7f45d1cf-61c1b45ca84mr1190009a12.2.1755864870953;
        Fri, 22 Aug 2025 05:14:30 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75778c5dsm6842065a12.31.2025.08.22.05.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:14:30 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	linux-fsd@tesla.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] arm64: dts: exynos5433: Add default GIC address cells
Date: Fri, 22 Aug 2025 14:14:24 +0200
Message-ID: <20250822121423.228500-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=5IK7visueTFPJvwe8aBx75t2Dc2ShuOFkE1pHPlyTJ8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqF8fG4TdtYM0cmBodGvFcfp4CgidVvnzzwGRR
 hF5QnIYt1GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhfHwAKCRDBN2bmhouD
 1xCJD/wOs1s2c6cZkJlscMJv54fg1CFIqLecvrsXnlikIuOSInwpa8sCW4lL/PckSmRAX/wJGIf
 /RFOn0k/+skDBPFigKH3lwK1HCTnSQTTNtsYThsHBcZHKlXDVnFFycRsNK3U4rfldltdnl+ItXG
 zhi50Yh2vnjg61l/51jX1LqvIcpPyyJ+1AW8TADnOKG4SVZIL94sGd+iP6BSRQHVpos6jxYCY7S
 NiZ9szmd1Nf92KtIOIadb48c3W6lWpLNrHwY5zfeGdzzmv+pzqXSRKRWYVT2N+kSfCCM8Y4AIWz
 44rMBbe3uV8TrnQ+NxtOCuY7MQIMazBWtGZ2EiOt+CKBugQ2i1n4lxEAl+i/EIZC6SadTVwXN2g
 JhgFGG3Ifzuq/Q3lSpER35OX87hA0PnlOR82yzRrSMqLvW2biSmWy8+nrg2dMMUErBYrGF6/IDi
 NtPn/B4MfrPYu7c1u7eJmdjzyiOyFtsCLw4Ug4DuAZcwi+i5oQbq/4PKYDHebaNwBwKMKX4VV6F
 tKbHslXeDzJcvbZuE7Eh5Lnp586PhTQWynD2R70Wco6g4tvewvMhGJ8PVWd3p2oOpkH+7nas0+n
 LkFxeMQdnVtsqKTVXVhfRcKKOTRpd2L/TAZnM02eQBrk2F+3zhz0h18KYzmGEsYYd1pi4M5Pw16 ZKH/3SJXFYLGrYg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  exynos5433-tm2-common.dtsi:1000.2-41: Warning (interrupt_map): /soc@0/pcie@15700000:interrupt-map:
    Missing property '#address-cells' in node /soc@0/interrupt-controller@11001000, using 0 as fallbac

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 0b9053b9b2b5..fa2029e280a5 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -937,6 +937,7 @@ reboot: syscon-reboot {
 
 		gic: interrupt-controller@11001000 {
 			compatible = "arm,gic-400";
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			reg = <0x11001000 0x1000>,
-- 
2.48.1


