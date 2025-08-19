Return-Path: <linux-kernel+bounces-775826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D92F0B2C576
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBB324066A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77193431F3;
	Tue, 19 Aug 2025 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KU5Luvsp"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFF5340DA9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 13:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609489; cv=none; b=WcJwxhydRerZbTDvnEtVronmugveIldgaDR+j/As1amyv9eiEXGJp74NStQltsRs/tQfDfGDjmVJiqUKlh9tqZWLK+/KuDp6+G1gJEUQbkQJgFm730ZQJS5sW3MtgTP8yYuhzEMB7mjqghRIPfG96BGJKlRFeFZG+b2yY7hyLyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609489; c=relaxed/simple;
	bh=xtnDCv4eFzy5ACNTqpXuFQnkdvi4l046jdxQ272mGQw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DstpJIGmV6GcyjJ8glu7T4CbSecSWeWGzNC6fhzlaFw9neC8UEBks3WafHV4R7qriczEFrAyVS/q3IltE8ov23pyrM2j0HpRlJNEQYGlmLZbuzolOMCW4GSjr3Qn5WU3FTPUopa3mxQaDYwAaSU/B9mkKjAhwYVS8QMmQr1Qdmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KU5Luvsp; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb79fb221so72431566b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755609486; x=1756214286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A2jIqckmzmL31HAyK5saMTVF8f6NQtPgJyovhg4/VOc=;
        b=KU5LuvspIbrM8968ErVH/Q51iTRyrS9tXBBILJxFhIMf4GnJ++8PzyCDG+yffX2X4A
         NlPt1nBG1uKmjEQGoIKiPjhgvh+LNGCuolOkSwa1OKTQtiV9GMpprNRWlYHn7yhaltJq
         hsckiX44FbAxzgC3j9iO00zIGuqGQCaHFj/HTJjScjIn0j9bZbXadoj8ZaZ5qXXw44qY
         5ne6FfxMlw4KTEhnQBVDLkjk5siVqHYN313HecFJ4i1Q7vcqKoKICvIaFjzdD1+jNME6
         ccNWZPw93u0nyzejGvksT3QekoINPqNBqWJq1GKU2kHKOayGUYid+gzq0H2tb/z3sBi0
         Lsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755609486; x=1756214286;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2jIqckmzmL31HAyK5saMTVF8f6NQtPgJyovhg4/VOc=;
        b=H09uI35271PpPlFCHe9JNOMFYCBhejV/CWA2V+Wy2NzVT6LsvfqYGp5OUaYkMfF3Py
         4A7om47M69f6YFJstKyuSEUiA9hBPLgRLQTWZf9sz309xSGY3LNb4Yxp7mhSBSbS4LKB
         hCZf5tZ2NRK4F/TWRp3ARpID3gI17FSm9nRiVkR0TxeE2D99n1nBv0+JDZ//HS9ttk/O
         Mt+NtIwkqWIwUyxNvyL6Wxko7nWiDm7J+8kRnsFay+OzXzoPiCrHAAjiH97rq3TdoFLG
         FPF7Wqj1Ibx6NxALoPId5Dp217A+rKznEogq2IqqWUfd9S+0Fx4CCYyNFLKmsVF2pFS4
         3L3A==
X-Forwarded-Encrypted: i=1; AJvYcCXPTK6cRSCaxnJ32xPB5W+n2S19AqNswB1D1/VmRZILHSqXX5TGjb32Pcy83DqYPB28fsVAyMSHFuPqQw8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIUjkOYDUbsbRG6kAW5Yfq6KmT6awHeqjMnz8AHP1T22e4pVnO
	6VBdSZEmi47tlSOL+yzYq79z93+VprNWgQZaNlwcogBKGhdHMdaPncQuh0PneNCqq/A=
X-Gm-Gg: ASbGncsbB5934Fh1x+JNg2jBcPkZZCe4Ql9xd1VkiRfDtsNncoL2iGhZcr0IX4TkLHg
	ibKgU8SaYVYs/ywa7KfUQ+a5z4wbp4m2VPD0GQhpSt7GDuYSRFkPkvbdynF7ywo03GBBXQilaUD
	LsSK+a6kvhuY3zGvzIz4+ZzncbwJxHSGUn7SEtykxWG0HLSIlbpzdNuhNAvFADmXQQgnIbxGvtS
	cKiLreShUnSUBTApEHrTQQwfN253BSouBcNQUD1UgvHqEg7Kq1DnGP0XVL6qy6d2JHLL+nhlTsz
	eeqlII4SlffUC3C3/AShsnmFopz/U2IO/fwgotevO6uSAwRmLU5PXJgZOFMo53tQcMMHSg6fhTa
	UfupknNLX90gWsjF/JR4Gmel8iS+pxlqfFg==
X-Google-Smtp-Source: AGHT+IGyvvSsYmBOqUpNPKJ0n3bvvP0DcDCulcG/syIt2wzsfbzAt0lyKnerC5YPY0kHA2qlG+r2Mw==
X-Received: by 2002:a17:907:7e9d:b0:ade:902e:7b4b with SMTP id a640c23a62f3a-afddd1f8b4bmr100763666b.7.1755609485345;
        Tue, 19 Aug 2025 06:18:05 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afcdd01ab3fsm1006508966b.102.2025.08.19.06.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 06:18:04 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] ARM: dts: nxp: imx6ull: Minor whitespace cleanup
Date: Tue, 19 Aug 2025 15:18:01 +0200
Message-ID: <20250819131800.86990-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=xtnDCv4eFzy5ACNTqpXuFQnkdvi4l046jdxQ272mGQw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBopHmIdIih5hgjFKYVXkgjYOmgK6x+Rs7p3ybX3
 j/4k1od8vWJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKR5iAAKCRDBN2bmhouD
 15GYEACDpblDVOMuoKN4y9jt8cF4hJgLK9fli2s9chrgNEGKFUVpYq6K4M+iWYmXrBBPvZ2Kw2t
 CCjeHxVNkOM2PcH9C/3h5Xz4Aft/0XIK+EdQugnDfaYQr46cwlJ8C75O9KMtes/hR8llTh3qLIZ
 M26wOApvdXKMkvl4GKfHB6tdyQmW0xhLW+VB6BuY0TKWnsWfAkYr/tslhGE7URwyDbhEo3T43Gz
 ifcSgZeURLeyjrgztlS/HGjOb+Uh5XDBkxi2IWrVe0U+05Gv0TTJEv/HXIMok0oGwInp3JPnAcT
 UweplIcOEfh4A34gX+ZwtQ5RgycMcv+fwFgFNPbV0idAEtIsbljzAid19ikRmgi5vb6W3Sm0xyu
 joCSm4o9dg5PL0aYjcBIfDh6u17YJKhcYqvOrKDcFvTRUAOjEx8P+wJLFoPMOrtsamyxxaJZnTe
 2bmECOATOzSM9afaIO6irt1G7C4ocQUoF+OvFTbunP4XihRxHq1xcYCqJ/z+j8lERvCh9INlttD
 vAcAOl0CnNNL9FTOCQ7UM8xu5ovV/ssTxNXhZOT8RItS0Ze4RJj1jI3mDtZratMYt4qv4rQI4WQ
 Ep+Ez9WVUXvf2YKA4/ivB4fhn0bCLghsu6zIrVmbe7gVPCqrUb5QFlyMIIjgQ4zYNn6Sr36Rosp Q6PdBrAfYq3+2Mg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space around '='
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
index 5d1cc8a1f555..107b00b9a939 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull-engicam-microgea-rmm.dts
@@ -129,7 +129,7 @@ &i2c1 {
 	status = "okay";
 
 	touchscreen: touchscreen@38 {
-		compatible ="edt,edt-ft5306";
+		compatible = "edt,edt-ft5306";
 		reg = <0x38>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_touchscreen>;
-- 
2.48.1


