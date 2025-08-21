Return-Path: <linux-kernel+bounces-779566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F78B2F5BC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1213AA363F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55B930BF7D;
	Thu, 21 Aug 2025 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWMO7lfj"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343A30BF60;
	Thu, 21 Aug 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773813; cv=none; b=bFc1FzIUTXMLUA2rrxfoYho67Dy1S2kljsiXhGy0qTw+AlKOp5u1v0eGoR+YNDx/1lDMGMzBMlU7b2enQ+MP6nBucvyklBd/GXgPdpQISMoXVO2tTrrl7Mfsp3DdeROIK6D/hKncHVc4Vj/bp00EGxzQFxF7omcG0JbooLnxstg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773813; c=relaxed/simple;
	bh=o8NAXCaejWiw+zFwI0Jwj0x24KAK8eSxxcsJHf9XluM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6pBfdzGDG4LMqOH8QMyJ2iM1eIYmndmyuixcrghE4k7aaWGQIxdZmav36RytF0eftmlCCpPZ5xo3b4e8q+M+WEGM5yke+bmnEJqDg8W2S85qPq+7cv8o79WVwrbFiYetj4VY+hbB5usLL15Y0lUsodChlIQzth0z1vjwq58v+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWMO7lfj; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-afcb7aea37cso112465966b.3;
        Thu, 21 Aug 2025 03:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755773810; x=1756378610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6cqZj81I2CiiZ0Kzalw4lV9uG5vvjnDT/qAPEKbzCHA=;
        b=HWMO7lfjvxzaAH4F4zNa9DMGofrg3psbSpiE6b1i8DiHCxV3oRFudRt5ziE2GBTqOp
         0mi89+je+ccNP3YI5wC0lJBVekUDg/X08MbGOQaOePvwmN4dzvU5bcxYSM+0Xurc/Rri
         u1dB86m+2ow3pNSxOTAVnR1LnBVzEpR9nCPCRSKdSPYVzNj90TkUqRwzwcf9mJBZaQ3i
         EEz1H05K3/NM3oLFmF31eBmJb27v+TjTWziiVqamZu5ls3AkGChQOI7Z1BjzvwHZMkg2
         zjGURCMCWxpZ1vPnwZXdUhPe3g5n52j29FC6o3L507MY9FeDV4nv+mFPn/AqmK19DHdX
         x0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755773810; x=1756378610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6cqZj81I2CiiZ0Kzalw4lV9uG5vvjnDT/qAPEKbzCHA=;
        b=GkTzmC9m38792iGdMBGAFOR63Mbb1sCYb2fcWTB9RxV7TjRJ+4p3HhzC3zVxSTo+J7
         9kcorh1xGRApDZwvlHAPY8CddLabTmZGbvh+AT25/xiFe6O+4pc2qJU46C9reZistI0T
         uYzcIR5pW6h3Ik1z3xBQL3hncpvG5njzi5gIrt+j3EA2mwzouJEU0OHW2M6M4nnwiOfB
         F7NdnOWiN0d48VBIZe90E5FT/0zumqbH+5g9XYcYehuwq3SZkAHqAiIYVO/W/BXRj7E2
         eoWWErbp+9LoYf89fDcLvenHxuHuA+FkjHxQZgIPgCQ76nK4DHdSUenqBiQLQYNFxuNO
         w4VQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbilzzpmV4OuSlk8VbBNryu7WcWS5yufFNxqJUm35HD5jmzjWtBEGN7kL8eYc/UyNlgpEyeGHOFU+zSXbd@vger.kernel.org, AJvYcCWBig/AfrqHAwUCL7anrHvvQtAfG0bawWJegsurtGlU9CrGUb/Q5B+eOpvuDw9p9F530ADyfn5/LW7b@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtzjJEMJNlYoEKCfJDXfFgtlFv57v+rNfn3i5S50YEgvsRxaL
	Bxn6NNjmnjJOUfOzROfPxHgrvXe7hD6Mn2DitZXIfiGFE+tTeC400Y0A
X-Gm-Gg: ASbGncssj2B6OBAeGxextsQ0DsDjKjPTu32dPQdQRcRnsri1n4YzHMetbuoSkJLC1/R
	l6LkFA5/ai8pAuv86njkof6EIp5pk4G836g9IJ3SwuGN8udviXS+vmvOHyvCdENwAmr0iWGoyzl
	HTO2WHqCZ+JJLn3uWRmbl5dZmAGpYB1TAgBV9298mHqt+scOmzSqc5kwituuYh8iqbLErF2KnT2
	O1xNf3KxVskzL7Tc8poBd5qDsf90XYHZyFbqiuxvye39WuTr9wGe2gJXhM7mHmw/nLro9eKxwZP
	WOMSxDhOTKbQO9rotI3SbHhDkD/Z9uxN6TZTaKZ3kN0e4r/Ejal+2spcNBrYt/t/FmHWni9uxFk
	yOVA17vZPiq1YMLzFuDtpeOWbLV4kF9/kxbgnYP+X9rgZSaZl1e2u6+GXiJf8+Kw=
X-Google-Smtp-Source: AGHT+IGiQ6nnY2TbUKJoHVKQI8O3PuXhA0dGXV3weWAMnEObF/hJ5WdKCmczbq2+Q1oqR6D9+xs5aQ==
X-Received: by 2002:a17:907:3dac:b0:af9:84f4:6242 with SMTP id a640c23a62f3a-afe07c19686mr167470166b.47.1755773809529;
        Thu, 21 Aug 2025 03:56:49 -0700 (PDT)
Received: from DESKTOP-TTOGB9M.localdomain ([92.120.5.3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-afded4790bbsm373602866b.56.2025.08.21.03.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 03:56:49 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] arm64: dts: imx8mp: convert 'aips5' to 'aipstz5'
Date: Thu, 21 Aug 2025 13:56:32 +0300
Message-ID: <20250821105634.1893-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
References: <20250821105634.1893-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

AIPS5 is actually AIPSTZ5 as it offers some security-related
configurations. Since these configurations need to be applied before
accessing any of the peripherals on the bus, it's better to make AIPSTZ5
be their parent instead of keeping AIPS5 and adding a child node for
AIPSTZ5. Also, because of the security configurations, the address space
of the bus has to be changed to that of the configuration registers.

Finally, since AIPSTZ5 belongs to the AUDIOMIX power domain, add the
missing 'power-domains' property. The domain needs to be powered on before
attempting to configure the security-related registers.

The DT node name is not changed to avoid potential issues with DTs in
which this node is referenced.

Co-developed-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index bb24dba7338e..b62bb821cf61 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1396,12 +1396,14 @@ eqos: ethernet@30bf0000 {
 			};
 		};
 
-		aips5: bus@30c00000 {
-			compatible = "fsl,aips-bus", "simple-bus";
-			reg = <0x30c00000 0x400000>;
+		aips5: bus@30df0000 {
+			compatible = "fsl,imx8mp-aipstz";
+			reg = <0x30df0000 0x10000>;
+			power-domains = <&pgc_audio>;
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges;
+			#access-controller-cells = <3>;
+			ranges = <0x30c00000 0x30c00000 0x400000>;
 
 			spba-bus@30c00000 {
 				compatible = "fsl,spba-bus", "simple-bus";
-- 
2.34.1


