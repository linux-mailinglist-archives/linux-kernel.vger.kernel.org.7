Return-Path: <linux-kernel+bounces-781833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AEEB31760
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A941D203B2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40C92FDC55;
	Fri, 22 Aug 2025 12:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FpZ586V4"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715442FD1BB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864879; cv=none; b=BeX6WoFJFwHttVcanAjY2VxN/0BPUhbi0lh38/eRjCavfgQlwQKaBe41w3c+lEsxXI69NRUIuIRvbTSHiHpaHeHvCiOToFF7WccQX78P/7KgVSLWaEAHOPv2d+C0dahbtsbahwJ76Kh5G6brtf6OA/ZGWRzp/yT8+GV6qshKxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864879; c=relaxed/simple;
	bh=Xg8fbeULkVAunNHSuMSzm27A8P/HmltLuUUNMaXdfUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVhTwvuynkb66tVe0d5c6qanyAhwwEJ+4qp6py5mOVdvFov8JXkKWR1hg521KT7woigszAMTqJxz8AvkHDltyD9z/ksdK8yn3jsP9Hvwz62CPwJvS7ENlnLKavzGaC8k3B0UZUP4eekwdC+7ho4e7zVsGH/vf1RyWMb3+d6LiZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FpZ586V4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6188b6f5f9aso277704a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864876; x=1756469676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bS3pk4A3vwWotpGEwKef8o97dm0WRz75Dj7bwTZ/WIk=;
        b=FpZ586V4jzS9Sag5EmwpsZGuE9eFD1gXm3TwlB9woUbDVQrgdAa3OfL8Itp2EPK11Q
         Hjb+YzeOSM6GfG0HDUDWfrM6/SRnfixuvS2/R49U63+NdrL201P4re6QPlB4kYCP7EQl
         fzf4TMp82/2aP+rerfygIyaenkG4AmA8xsuAFspyn9ydHg0lCP8/q1g4ohBHREDBvysa
         Zfq/vgsYrjHMCNmIOmBjrNdVHOuwVA1EplYiEsal3wpPt+F+7jhvphCR4xJzcDelsnv+
         bF3cTkj4SbIiVPr6Xu1ggM6tn1zgbyla2BktMKQ8juTANULfQQ0IZS+/LuLMzhotbBoA
         N2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864876; x=1756469676;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bS3pk4A3vwWotpGEwKef8o97dm0WRz75Dj7bwTZ/WIk=;
        b=NnkOID7X9rI7NbxIKscyCb/gu0bxL2M1Z2DHvJ+OF86p/+BRVFFIru5vTLhIL3rDRW
         GhNRpI7vnnicruQeWXH1kUt5krqq6Iam2TEjVaBrVH5ZNAQSSovG9/eVC8+6Dx4z0HJG
         xKzhpGhu+Iopvzkq9OidiXf1/pVwwlUWnRhtC9DM0rFoNwwKcm1QU9iqb78ua0gBnjFf
         aZdsWDTy0MnLGSq4uKDXG2u6EsCNFZfY4WxP3THe81xCUZmujAhMTLhizbSCv5XDf6KX
         PCqRJRE42g7gb/DRMsQvqqvTPnX75BB6bjYeOsPoGCmZbQXzxIyD6LEcXM0ll1fGj+8n
         DlZg==
X-Forwarded-Encrypted: i=1; AJvYcCWUXbCs6A2J632OClmFZcbpDLao/sHSln+FR5gcFkRTGjd+3EEZl5W1jkrvT7lbrNX6trHB9AdgL57fcN8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOFJf/sSTtZiOxG9MjYf6svrt02PunI/Xb1h7l/W9wjI5YWkb
	33A2/8cAluV5YILglmx9SHXfFA5wGdivMdFKT53u8r+n8rjHzN3iwGL8qDWtntXqkB4=
X-Gm-Gg: ASbGnctsrW56Gk7mWusEfck0jJ+G6fRBd8IGqEqVSWHKYKx1EXjdwVDzs8wC8wX65zj
	O7VrF46wL8rZuioqVvU7svwfSKaA408ienCIp7iR1wrDIxN5ke3YqienpebAZWHGfeUO9F/YIld
	ZuX0wxIRb5uaM/Rym6Vd7DvRv695ugktib5Va3/cHvTLrLhv1OiN6a727HZq90ILFz1iHS+19ns
	VEPvUiw465bgyiI0mou1PVSCiUnIyEy8udkuVQMN66GIn7a6nV4RlZsMNne5NAbqrudzpioex9s
	14nU+Ku8xB8v6F7LGblbfL2l0XyAR0pm++/9CJhOrO++yTr2R9+AtmqhXm4RWldvbfEzCZ+HYNZ
	xFtOONLvpxIjVyvg0BQpLU+H9/E85/J1nGAM+JBBVLQj5
X-Google-Smtp-Source: AGHT+IEs5KmocG/KlG2h0mSlEdpjChfOeNLb5C+4lvVluwFDeR16CG9SFzVcRYZbx4Bk+B/miczFYA==
X-Received: by 2002:a05:6402:34c3:b0:61b:cadd:d84 with SMTP id 4fb4d7f45d1cf-61c1b2193c5mr1231624a12.0.1755864875727;
        Fri, 22 Aug 2025 05:14:35 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a75778c5dsm6842065a12.31.2025.08.22.05.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:14:35 -0700 (PDT)
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
Subject: [PATCH 4/4] arm64: dts: exynos2200: Add default GIC address cells
Date: Fri, 22 Aug 2025 14:14:27 +0200
Message-ID: <20250822121423.228500-8-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822121423.228500-5-krzysztof.kozlowski@linaro.org>
References: <20250822121423.228500-5-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=Xg8fbeULkVAunNHSuMSzm27A8P/HmltLuUUNMaXdfUY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqF8iqytdsSKdAQp7OV0wh+MN7sQXLAODPAJWe
 RxyvnA72wKJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhfIgAKCRDBN2bmhouD
 1/FrD/9T8gtPfLYVVMoSMObYA+o3SUHEGhUwlrr6NN6OsRErI+9TnP2Q60WHSUBrmH1Vch3Us/B
 egXQwdy5DAy94htJnu9b1V/jPaM6OfVsOOPCW+2hJZR0bBo3a8DRn2Wsh/KJRLhswIO9cA3EOUX
 zhz1blWRGOpRavXkXC32Q2zE+73l/OVNrKzOdAlt2t2Pzwyc4pmkptaEm4UKR3CIqAdBK8lkPAw
 5WXFs1090LyabpZhqMwaLKxg+l97LUfrico+E/8eez/UP0dIzbgPF4wz3dj/LOWohZVCR4TDHvT
 77VPH/BA/3UsW3pUVSKsgl4/TRDQG6rZHfHOzGtmxMNfJYIfc0JwhYdJqig/nyNGOQiFtNdgF5N
 YO0A7jVXw/Ut721AguDqg3J4/7kZEprvgjXIna38iX6WCi82RupWRtIFu/IdrFGcfmPv4iCICDr
 ew0O3vZr3wdD311zj77Os6N+Gm5hHnr52YyKqm1QNo2uny5P4oq5QPRo0GYt1T2K3cweGPn+8Tx
 6mHu6xRaGKidjX98H5ACEwF11d4vZvRZQhaDPDJtG5R/YRheG1N7XNTZ8RVH8vss71G+TFpxr3D
 Nhedh15zAS1ym05PrHCcBiXqDhMyBXDF81XmMRaMomjHbmUyK3r5Sq6xPOKqBwL7tIkeIOqg9Mm Dl45IID/LarMebQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node.  Value '0' is correct
because GIC interrupt controller does not have children.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/exynos/exynos2200.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos2200.dtsi b/arch/arm64/boot/dts/exynos/exynos2200.dtsi
index 6b5ac02d010f..b1fe315b40fd 100644
--- a/arch/arm64/boot/dts/exynos/exynos2200.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos2200.dtsi
@@ -273,6 +273,7 @@ gic: interrupt-controller@10200000 {
 			reg = <0x0 0x10200000 0x0 0x10000>,     /* GICD */
 			      <0x0 0x10240000 0x0 0x200000>;    /* GICR * 8 */
 
+			#address-cells = <0>;
 			#interrupt-cells = <4>;
 			interrupt-controller;
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH 0>;
-- 
2.48.1


