Return-Path: <linux-kernel+bounces-782400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C2EB32001
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 18:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3BF58600B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791FF25B2FE;
	Fri, 22 Aug 2025 15:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d+FSL41Z"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E791239E7D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755878223; cv=none; b=dbUribZR8j3elO1ZZItKQPHMZCIcoV60/J17aPkGULPo2v6bLIr/t302JrHksrOUfkZNQ06bEiI66RyRrm+xF4loRUuOdtQowBSJj+iXSH10Q1Y9xalr1PjT9DzcZTY801CjzQsC4Tx3asF/mErfxydjwzikdNg6DC+43FtOFYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755878223; c=relaxed/simple;
	bh=vz0Pb/W66QBQ9wQPylYtekNJpoGxq9q5ENvtBgP8PRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K+6C9AiczfXRk4zq1YXrT+qi/QPxkMnafVnIVcTH+TOpTV2j7xoOH3awBL9ocfmV3+hJRLrqON2G4PmzsH+9q7TCB88Cf6L8sUsRkaVleLce/BSFkQ/l1LUSQuiqSfjwvjRm5VTp8g3LcdpVGil7VZb7NrKTehsa0NaZRblvqlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d+FSL41Z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c4e9efb88aso1193215f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755878219; x=1756483019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsA/CLw9FJUPvXsg3qlFrQnURFnDrWqBqbRAFJut4KQ=;
        b=d+FSL41Z7v5DtowmoFEHRhveYLigbLXYA/LMsnix7XFOFf9L13fW40qrDLeow/+KGU
         efQL1nqElbvRPDMBS9H5j2MLiK+apfMwE3hHX84RGTqniQMwgLN7/knIERwXJIUxstY7
         psWhn7AWglFCIJhIx7mP67p/XAd0pbAHDpO8i6gkFd1ybMRD5k5lVTDZidrgFcV8mA+f
         VJUTB1FlPNOLsmsviWOLwr0IkfcGmbYXexmpAN3mKdvEyKlTuOrMHODvtDZpvLg4557T
         768Xx2pI0XMfHpMDTnfoZb6zlX5s7/ewECaOQI2uaw72oLIoTD+gbIt0Uediq3SzVtVl
         pC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755878219; x=1756483019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MsA/CLw9FJUPvXsg3qlFrQnURFnDrWqBqbRAFJut4KQ=;
        b=wb5O3uz7vcY3i2GwPGiFgs/oSgfsubf1byB72J+FnObiqu5N0Nvxskg6Ol5eg1DA4O
         K/O0XPBJWJc6/bq8RuX2W63UM5Nx8hxN/jHlaGFoc2H9KvkgB1lKg3IivgMHHrJkVRyb
         rPNKysV+QoOBTqFbr/uAcJ4FqSkQqLD4qmR96OVqs939Y6TUHg9hCwIEHrx3KZyZSoRU
         XPD7/Kgo8lRLk6WlDCEtDUdE0jhDOyx+nhzUiv6g2QRU/IbT9NAKUfT9YDbd3dfYUEQZ
         z+EzChzGnHTQ6lTc0MmVkN2H/dIjjf50ozhIRwXCCETd5PDFcHR3pvbX6ruWS8ABwpic
         Gn/A==
X-Forwarded-Encrypted: i=1; AJvYcCU7AY+U2oZv+0yTvqEdnTf5N2QljRjM3lIrBdd3K306fT7l8DmLe/pHLkN0yVuya1CIb8oChgTKbACIjrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQJ+tkt8P3fjQJV0nsza94e7xTC56DGtkDn/B4LQQ5OsP4hdGk
	hhBHvo+yKYMiY+8DK4Kv9/zZrG4GSSsPrQJnk8gFILhJcnJHegjPsSQJcjtQpE5pkDQ=
X-Gm-Gg: ASbGncsmv04Z1vxcO/QXH6k1vnXm6s6KDnKnkL5nHzoH7q3X0ZQp4/m6BubaEEcjMnK
	32o8npn5tCjoeh8LP20h9GdErGIDEtckYGIq+Jswky6CjAO4WFHcHWWYCRiJCYlSw2v5oZt9Uon
	TOQG0aOGVfqeGoF4vxAy+GJlUYae5xgmhBoEoZlVeHOqP6jJyUkDQbfN/AexImZbF54qUJXc+py
	8KVlEjJTn27Wa8Ojg0dOUcMqG3w1QortDA5MfE86mzAlghCR45cacWPGa5/eLakxCCZgZUFmdmy
	TILjSQgFPoYs3cbvcJfAGh+X5rOpdXd/puO0BWV20UgXCvU1gxp1ZoD1BdMAZwM/7vX8cOp3+2d
	NbwoxUefRoyAM1tsbCwZksbGi9eWKgpNmTwAfL+uz98E=
X-Google-Smtp-Source: AGHT+IFFXQApdDohQovqIFy5k4yyR7bD4zpqAkWXJXBgMe174Jsd0tbuCvhc5tXYnt9g2cz/zi0sKQ==
X-Received: by 2002:a05:6000:22c6:b0:3c4:c15e:d055 with SMTP id ffacd0b85a97d-3c5dbf688d4mr2674398f8f.23.1755878218325;
        Fri, 22 Aug 2025 08:56:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c3c89cd4d4sm10095765f8f.42.2025.08.22.08.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 08:56:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 17:56:50 +0200
Subject: [PATCH v3 2/9] arm64: dts: qcom: sm8650: allow mode-switch events
 to reach the QMP Combo PHY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v3-2-5363acad9e32@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v3-0-5363acad9e32@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=724;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vz0Pb/W66QBQ9wQPylYtekNJpoGxq9q5ENvtBgP8PRw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqJNEoHwAOGPg7yXygilW+EpPf7tdoZAK7ZxlGd4W
 7fsIClKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKiTRAAKCRB33NvayMhJ0aRaD/
 9oMnwpRgOPqQy7DiR89B7mziUzSzYaRLmfVMshCQ4ftJVJJvxj62RPOoF4CG0Lshi/vXJcrzQXX2CW
 fqcHL00zImBgqO1psyc9HCVtPNDK2cRUeheiCM9+KCExnPXFuig1zlNMwVqaHIe8DWFqHAoeKpkzSY
 mMVl7XPnOrreQdV8xdwpffjv01m14VfruKKZ1SsUkYxk6JDP5mgYZv5FTBAr+3ORca4L7wFr/1XsNj
 I0Xs1LqgJjGjAgRIarT44qQJwLiREj91gT1JZSR3hC20IacG579gRlsVAyfYA71rymUuB/Hraw6Hem
 Qhns5LvhElsCqsD6NZK6oW7inl3GatYEZ8WxI9Oi9ZqO4Gp3EsinQCe6rYirke/SuN9a1aXMz5Klnl
 wXR4mAd8oTsu6X50lRHa0G0qAwqFkxAA2/vVk3cHtJVM24C+w4ASi08Kou98jR7ySVo3qxKhjxPQoj
 Erfc+WxDuc7AwAiDjrWUqPJjDtlZ2qzlt1Neb2RSsEiPODDiFRQBFLTzxVI/DegvwN55+nAurATXPy
 jQTEuDZuYCKWOdX3m2qtXS98YDkjvJWRluk9qLuHyrGy0nlCXyu+wi/bEjS4dgVvqrRcMTCWso7OjT
 X5GKEutL/j3ujwDdOF4R7eWnI60mtB9TeYwcf3PrZ/TFXwdADyPYzaU9n0eQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow mode-switch events to reach the QMP Combo PHY to support
setting the QMP Combo PHY in DP 4Lanes Altmode.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index d6794901f06b50e8629afd081cb7d229ea342f84..1a750ae39232419d3b496f5a009f16ac8de40fa0 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5012,6 +5012,7 @@ usb_dp_qmpphy: phy@88e8000 {
 			#clock-cells = <1>;
 			#phy-cells = <1>;
 
+			mode-switch;
 			orientation-switch;
 
 			status = "disabled";

-- 
2.34.1


