Return-Path: <linux-kernel+bounces-781809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E598B31700
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:07:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3403D6235D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CAE2FFDEB;
	Fri, 22 Aug 2025 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JzfS1zWD"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B652FF14B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864289; cv=none; b=tMAMMCJBered/ixWB/U6+rWHlGuxOa39NaEYFoXrUdQEmgkB7FVdbKViG/mJxpB4HjAZ++/O6rxxa8/hA8mTwXNFj6gKjin5eGEd9PcUPVDp/RUpFdYFZGDThuti9clnlMxhoMGOUsowEYUEFWRqOX/CcMfr5wcKOfhjDGdN7tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864289; c=relaxed/simple;
	bh=s2tVleEZ/E1WmJ7NVGTUwd69ez2PiMC0RZCWhGpEGO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhswW3/J6EPiFnBkZOgmKQ23IwlM6A3wFtSWom+FrJGDG0ImwDSmOubE7o2EuYNKNDbB1UuCQZ/4Cq/Z9pdZ8fmfYIt7X8BVD+7tS/WzEIUUl6mnghysnPssGFBSoUZ6pkMx11o5uWRChYZs3mhIXP/JEjHWIG/NAGHzofUy7x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JzfS1zWD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c297e8306so21935a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864285; x=1756469085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAf0RPftUd6Zez8unzMkY/OCN5Vx0DLo9mAKZiY/u+U=;
        b=JzfS1zWDY3VV2DQxf4PvIO7k+NJXFUugKE+DCS1cZlEB941Heq7p0NUrn2JLr/tvLh
         E2GUCZnoYEwTOGWXqCsFvt/PY2+3UypA8nG7sK0XqrIldHa2E0OlqbRxqMrB9TGIYnXg
         S1Ko2cIOATxV4Y2wEDgEC3/29XXHKFl6leyfSygCZKnqlIiM+fDduoNMuiOQb18S5bjW
         /TdXgyeaChXU0Hr19CRVAr+ErUu/vExV4FzqrzR9mb5OOJcrH3CnWtzjKHr5xn8ereud
         LY9D6A0HJY6x99wVU1GCMiQSCH748v6OkIed9grI+SjzCjgf4o5C/C2/P6yGzMbFnSXm
         zwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864285; x=1756469085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EAf0RPftUd6Zez8unzMkY/OCN5Vx0DLo9mAKZiY/u+U=;
        b=UAlX0WDWMF4viEchZkOWbVSarUQaQdqz3aSEX3jtJdruZGMXM98MwvxlNafegBAD/v
         kR3qMa4Mfj3T0whdj/zksE4BsYkYJ6A1QMMrcoicWKtkJQJbe6M8FTJgiE12xlYjG21+
         3nC68cDXGJM7rHOkeTaObg8+sBX1RIpvvf6KctIls7rHIBuka/eDj9urpyyfgNjYeY0e
         L+MePkNl0Fug5REg5fbe/zCuvGD0/CKXF0KjzhFG1coQrq3r+KzalztSG3vE5jE2Wl/c
         F4XNpU6eGpGiT7khPRm8XnVggN7C+yvZFNOD7l2vfAyDQDeVeJNZK+2fc3v79h0/f9J7
         kORg==
X-Forwarded-Encrypted: i=1; AJvYcCW4TpRzcp9HE8JIS2/Gej8WAKkDd0B99ZNKx/cjdd70UbrsYBDMUBz0V1geepadqs0FsuOtbMXXT40Q06U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHMp166CJIrOSd4+KiEVHuybLfktSkhhsq99js0VvVrxbrZmkB
	06tcnNT26P2Xs6oz8nvbDMlWJGpXQI3X9hqyf4mBXASzWilWn4Fp30rhrKd0MO2rK+Y=
X-Gm-Gg: ASbGncvK9UD8LxIID+E6uTA6cTXHjAa5mYFwfLVgThlxX6V7jcfLsaLXofrdJM5ijiz
	gaqYH4pqykCQ1n+e6hqYaLLXcYVY4pp5GuezYAxqEl+oHt++70E0oJKCxji1IA/DmQCoR/4VnVu
	1AeZruxc2Xq9I1pCLOv9xY32SL/IM/OE75Len/Hurpil1PNYaZp2C47oGdd24lQD/RrrRW3SrJn
	UuHuXJy2j0gjlhjT4Y7Nn32GR8vqsGzUSa098e/z+cF9JpbWYRtdUDcA2YLtJmiS8OcX0Ked6/0
	xkivViVcTBU70UQW8s9ZTmKCwVSL4DJmwDdSaIlHgav1NHrb/l0/9tEcLi+DymFH1AySOp/aj6/
	CwX8tz+wRqXPLJxDuImAaaehJ7wPTeAjVut0l+Lg=
X-Google-Smtp-Source: AGHT+IHdsJS79v8zrjBlgGdzLQ6NJygyFmcdoRf2vnDlpGPl4UQ9EArkX3+jfdK92F8IRbukVk3ZtQ==
X-Received: by 2002:a05:6402:348e:b0:61c:22bc:b207 with SMTP id 4fb4d7f45d1cf-61c22bcb3c6mr658272a12.0.1755864285219;
        Fri, 22 Aug 2025 05:04:45 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:14 +0200
Subject: [PATCH 14/15] ARM: dts: qcom: sdx55: Add default GIC address cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-14-d54d44b74460@linaro.org>
References: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
In-Reply-To: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1336;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=s2tVleEZ/E1WmJ7NVGTUwd69ez2PiMC0RZCWhGpEGO0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFzGqDF8MccHrPjNSooM79Qht/bUjB32fUFpo
 sMnI0jjUwaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcxgAKCRDBN2bmhouD
 1zlFD/oDf41QxQaYCUdHkj7ENeUMvZj9DOj16opWYmUPSo+6ViT1+8BsDkguEwNuqvDmVAEK1xt
 tDyR6BtDyw5+sTEAtIdgOSJQ1c2nl7W5soNyuiuOvbcktxJ/tFi5R4EYeSdhtABdOe7hxAJ1uDH
 +SodK01Ua1Xpt3ExZOZZL054usw2ji43kqyTp0IUYPwWwrQh924Cr4ZxHL+aV4PboI8flsz1Y6O
 sXV8jYSuYT3HD7rdqCt7tvCWiGi6c++n9u+eJ23GuqQlRqtA2rZ19OEG/v4SPBDl1MfZw2zVTPA
 e8bV1d58QaBU64WUyVQtp16QEJmnQLfdJ9ln7UmHVBHBGJoh5sxnnNtGdLxqZ4mxo80252xjR5P
 4EOp7KfwAnX6xlzKgzA1WlnBgrH26pV9mpIGqDLxjXcdw5zIWjvfn78RTLNlz3aHQdKuEIT/JwK
 ihBsshuMhLS+2IyxYlUldXGXGQdvX/f3OZ82QziPfwifIe3zKfpM06uJtrwV3SGc+gah+OASeAC
 LWmVBKhYwOi2XCmpu6dmw4VQo/p4LRI1ToWjJNtV4sw/hgn5vxzcc3YZstCoaNbnGk1eu5bgfHR
 B0Zeitc17EOIG4olWFyl7sJlMAShbFgF4Wd8ro+G+umFVhVt/3ZHcbSRKmeaUN7XIyN4wADZ6La
 kFJJKoTo/KDZ0XA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  qcom-sdx55.dtsi:343.4-346.30: Warning (interrupt_map): /soc/pcie@1c00000:interrupt-map:
    Missing property '#address-cells' in node /soc/interrupt-controller@17800000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-sdx55.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
index 20fdae9825e0c709596b88c1cf710fcd8d339341..8d0aabfa1ee06f5bcebdbfd8ff620f500de7fb78 100644
--- a/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-sdx55.dtsi
@@ -707,6 +707,7 @@ intc: interrupt-controller@17800000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
 			interrupt-parent = <&intc>;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x17800000 0x1000>,
 			      <0x17802000 0x1000>;

-- 
2.48.1


