Return-Path: <linux-kernel+bounces-782017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CEB319F9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C07816BDFF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04D430276B;
	Fri, 22 Aug 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb26JSu4"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994B02D7DE1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869671; cv=none; b=C/mxnsQRlO4tMvig3Mu5eiPjG52augqVhUMkFpH0Dpn61Z5IlNAzyvhCi7M/QuWq9dG93tB9hqYjuYN0CrEslebtc+sJD0TM85VLWAWg06FURjKPR5vxvWE69gp7l9aCN9Ptx0iTNKtnIuG+AC7DKpi3DfsLNipV3yjpydeYZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869671; c=relaxed/simple;
	bh=tyU5PFf0gSlmc6T4OX+FawiNzX4PdYFtA22/rM0+roc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o6eaK/Q7bsum3eVWR0juO6rQHMymQ4VfDzZ5op8Qx9+E49KqQtSq72gLo/tdb1V2IDV6vGipCB8ZJW8S8VK5y+7FaO1VGwJW01pZaD6ezqKKv7N2KiKqE0yo3xYkBGzKbTOVUNRitKXcqEjgXDZhFKouUaI7tXE/IRhUMzWsIIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pb26JSu4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb78d5e13so27279966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869668; x=1756474468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AtTpKVUrrZWtxsaE3XNcl8fBkP2fQZlgHoCoWUccQ8U=;
        b=Pb26JSu4UXmwPjF276TPWdezl9hAAVbEaq5hkGHarQA1eyQN4k2laK3sRWmKzEwdiI
         Eb7k+T844kVX9275kuQb8g4l+Hy2Tywh1gYtfPBi4tRRu61L+HBZiPr1J3SaoNb8IOj2
         FXUH2YEN2216/+tF7sfRfl6VD7uZCwgAckcgLlFU91muixOhxnT/fn0vUfKiYQG9U8+2
         dQOV8RYGRLUuRBURXomRuuMvbi5NKDi+4udN64oWbPg6jvCzBOTQ48rFrf3JTWVI062p
         D56c+OtX/l3tRh3iCmZidxPKOVCPnYLm9LuaW5WWeBhs251zXo6/GHrUtbkeFgZC0V8U
         1Vnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869668; x=1756474468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AtTpKVUrrZWtxsaE3XNcl8fBkP2fQZlgHoCoWUccQ8U=;
        b=ZLmm9s+JVEhn95feBKQddwqhzhZAO3rWdgT2nZa3bTeJiUC6CxfrjP0b2gYfAep7pG
         TZGetctHWHS9XLsnC8hRoBt1KI3zhQR241UGnAv5gWpGjjJ2TkMQnvZP6eOJGPxkau/2
         on94gUwnLr7sSmr8/Qy6dEIwQupAf/UvXUiHX8J1PqTL6WoVwx2jfm8rhyBWksPq59y7
         NekpwKVQQ5hF0i64keXl5H6FuNt+R7brDuExUgzkML9+b6DZhmAtvcqlz8wqtXzScT4l
         zMezs3420f5KZeXIfkpsqlPKYYLOM4s82KoOkax88oYjwEl6yJQbt1u4dzkN9q6bO1TJ
         07/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsuYFQ/QIvpWT7YGYNSYdOllMiawa2yHXNCHdIUc3HuKQMMcwoIw0b3yg3u92Mr+RAVEO2wQVEgWxE0dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMvy0iTSphMul24sFooecmS97RfX967nskLquFd5Vy1ZDl0ziy
	xmsp5tK57pvqlzEZ6H/42w6vME0BFZ1BwRgz+d+E5XLzAGlrEbNH3r5bNxgShKJhiMc=
X-Gm-Gg: ASbGncsgjR/N79uTwBtJCiRImJuPaqCdAwl3Sbx5IIoAwp46KquAI7TPBkTuApZxaTm
	kFGmc+gyTwcCZfRoSqOmG+y9GrZj3ir3VFR7SW+q7uRkAN3cUFTkrvkMUeq3wGLeERXcZfCh3io
	CnJyFTNJ4kMIleBo4dZV3abcRSzU/ASqrjVRCYiO1dXufFZeZGLXHRX9q1HiAmS9bAN3mQyINhm
	4xqY7QVnt9Co4KO7CMQRZBTn/gAW0f8FiKwwhcGr4lRdystvzUGf29PimZd9pVcDFJwBljHxSEN
	tG//nafSFDHAk9gqoy5dxCVsPiorV5rLjCcuMQuFe/K+9Ee6eh5QWhC+Hp39OiwTrTrux5YU8O4
	z7tfY7damh0xCJiTPqv5SC1g0Djg6vBlrqQ==
X-Google-Smtp-Source: AGHT+IHyPW5NgrCRagEyLACFGuB7+uhylut2VWju0IRcaH4EtwnYWwcFk/zuHnAseVuD7vXuzF2thg==
X-Received: by 2002:a17:907:94c9:b0:ad8:8c0c:bb3d with SMTP id a640c23a62f3a-afe28f08b6cmr138535066b.3.1755869668029;
        Fri, 22 Aug 2025 06:34:28 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded3020cbsm610986766b.31.2025.08.22.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:34:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: amazon: alpine-v2: Add default GIC address cells
Date: Fri, 22 Aug 2025 15:34:24 +0200
Message-ID: <20250822133423.312621-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1269; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=tyU5PFf0gSlmc6T4OX+FawiNzX4PdYFtA22/rM0+roc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHHfELWc05SkwOsVBGBcKQXp6Y93jBQ2qJ97g
 Q0o5Iy2rQiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhx3wAKCRDBN2bmhouD
 1xt/EACXLCSkFmZebqljwxXYnk2YlY9ntN9zgdTE2izATGlbDmWlBaPPVTHzdI/JiX3dkM2Bol4
 AfyDL/lYvqflqBto5GLqCGhTNbJ7eKk7b7bkXxp5S7kI8XShQFk7CVdOcQf2byUtHo0yr8sFYMb
 1iUCrT5lVZud7qF/WAVN3/g5m21HJ78wkfgi80jFISnB5CyLLUmzonnsfgER1lqBaDHYEUMjIxk
 vFlh0sMk/3pZdg0eegriBDktPyypCW7qDO9JmD7Pyc2TvoTNm9s+3r7jp3XyX3XX1EGBz1oynxo
 3SHZYGnSsX3uQKhSGhxECeASapKr88yTK7mOFQS9sORg2nMnH8bu0bntEBtKcN41T950EbD7gry
 eHkGl+/T2PEaFq144GyWp07tezX/l+GLSqLK+xD+JdfUUiyMAeaLsxcASGvdoVUzl6mBAm5l+7s
 kxtz+mAhAFReeFT1DpelH1SRMqSHZ6GXT3TBlnCh/MliW0Z0ovfIcI8mK3f6YkVxaIYwN7w2JBN
 jkLIchwiO4zGkNpkGa7xQsLV1230UNeK5wjZzkq8MPDoZ/UnqKelPjCWvzfYqFJ6BsXlwQcAqd4
 UhAAvgG1uWhrDMSqKf+09BG/zmT6omfmddRIEFpqLCrokU0IDEtVQuA13Kr07cYnAWmsYbuhP1E 8v9LSY0erntWa9A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  alpine-v2.dtsi:138.4-139.33: Warning (interrupt_map): /soc/pci@fbc00000:interrupt-map:
    Missing property '#address-cells' in node /soc/interrupt-controller@f0200000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/amazon/alpine-v2.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
index 5a72f0b64247..f49209fddbbb 100644
--- a/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
+++ b/arch/arm64/boot/dts/amazon/alpine-v2.dtsi
@@ -123,6 +123,7 @@ gic: interrupt-controller@f0200000 {
 			      <0x0 0xf0120000 0x0 0x2000>;	/* GICH */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 		};
 
-- 
2.48.1


