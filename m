Return-Path: <linux-kernel+bounces-777434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9C9B2D958
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6E63B0F87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91ED72DECA1;
	Wed, 20 Aug 2025 09:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vmtVp9kz"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEA82DA777
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 09:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755683370; cv=none; b=s8nYBZfyV7u2e7i9+U53YZfOWHXo0JtF74kNJhsQkDJHGVdbMtjgfeime5JAK2h2l+ZY3bWSI3fGJPvFS34/4W75REKSCFYXth3hxDxg7hA7w6uI2UZ2HCEyqffET0zBKzaMmfMwQhwds7JHtomsI+8PJ5Rmc9f1QxtVI/k0HU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755683370; c=relaxed/simple;
	bh=L1WblGj94ZaDL048pCEw1KwCIcqYN2hMDRmKDSs9uaA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LIteQMpBvzSW2oxyxYQeO5hSjKWfTz1GyVi8NNtIUSZvIf5SLrZjARluVF3nNpWSp1FH/j4GV8Pet8b09zAjt/GP/l8YAdF+g4CvJImZRX4gifHOftZNFfANAQe0ek0gfxYTnKlvDFNhY50JnJ+h5+pqts/3a4tGAqzPrf0etM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vmtVp9kz; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b916fda762so334116f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 02:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755683367; x=1756288167; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RTn5jI7F0FHyPpe98WRNj88qeA6Ryn7e0IBMDqMkQDs=;
        b=vmtVp9kz9XDtGzVMq7CVnCvoAWpV+XruOALc9KWvkrfcQWSuelpb90ib578kBXThRM
         R9+ooNf9tTRErusN07nRJfANUyj0BA3fEaqKTKV3cUToaWRPnRMTrTHOagLKxUFjrZCg
         vM+UPWThTvvzxFYNyNst3T+LFnOP/CRZvuIl0cIkVeGMDeNr3+KZKK0rX4hcSvUrXZxT
         K3/+Eah3M+rnyeneEobVV7/nqLJwGzH68q5E0XLrqFtdTYBHglkHQJaYfe2wtaxWslFo
         rshdBU4PWuU2bT2JW4w3F8Sj0jAUffETF4jQ4Q81jKX5jUMIn0sc8cC6837SWnKvJU8g
         DeDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755683367; x=1756288167;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RTn5jI7F0FHyPpe98WRNj88qeA6Ryn7e0IBMDqMkQDs=;
        b=Y+vtKvfzLi/TF2KSDhJaNviukL6i/Y55i1j1Ue1TkJhwRCvWioUKkDm4LRAjcht4kM
         6xLs1yxoEACz7O8yAaxPfVTevOb5qCa/5Wo4a/8KGcbwGrfJ/AReiDsddLb1G4lJE4rV
         QSbI4hUlQbWi0aiRIgbKPT0qFSgG7g3NIKnHbq4Xv+vcpr1IOTcsPCARrTWZiGaE3nDi
         OwuWnUVf1hwiksWMbrnpRMSi//Q7cMESzITba5rHW0VE3RTKHmVcNhS1ia2kDR6S++el
         FX3CBc3wJqiHIl1FJK3qw1cmFprYs/VrPhkni0Zxpk7L5VF2fnVGzWZQVNWMsoYlbS7X
         ZhHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVNSHXSNnGhfIHvzDkkrSfjiAzttLGvBhI6SSgSInZm16vUYQUzn75LDrF6Uxarufb2sUEjrQPtqAVwjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCZD0ujhA5sCMiA7idbjACG6BbkfBUt+cmRF4R82TmIp2npkqN
	ig18JV6z8ZCLtdKiteICF8swF7vy3RW5voFNLtguypPlsWBHAN4038yVEA72uqiqbhw=
X-Gm-Gg: ASbGncuzzegK1ySBfz0y6DG5ktcZ4sPAgrWVPhUVxymgvMm6d1HvHK7+pkT2iCeYKdy
	eZ737xTaxXgTASrzpqQK1aUGJMi5D87vQQ7iTAaJbBFwbRMHOjydlu6DLVxeAaoCa6tXrgbI8pI
	CawUsxcXbnWcYxLJObGj03MwpkpqNSL9/GLcrnTeAe0d40XRlv0XPhoRbZIU1hKJPRx/69Ze95x
	pSDCG1kIei/oHozKZ1AIQlJJqILro2Z0tEwTXCQc8e2aURB/6u2kfwVdGwXe8JtFUQVYp0sCVMt
	b4CMiHm5Lq4XKp85V3si5Hn1wp70dcybHCuzZaWYyc8cTgZk89D1ZYr839uM5+Bw/1oMSQqObRE
	YrABzo3pAzj5hJkW7ykFztOiNgvFv6knIqK+mA2VnOHs=
X-Google-Smtp-Source: AGHT+IFg5Ji4BYP9JKWjNupPFl93tYsMVzai0VfaG4aFr1zwAmtsu/Ny4WGlrKBByhP8RI6boi9rnQ==
X-Received: by 2002:a5d:5d0d:0:b0:3c2:9d64:125f with SMTP id ffacd0b85a97d-3c31553b888mr2106541f8f.28.1755683367034;
        Wed, 20 Aug 2025 02:49:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0754f3b7esm6721228f8f.30.2025.08.20.02.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 02:49:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 20 Aug 2025 11:49:23 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: sm8550: add PPI interrupt partitions
 for the ARM PMUs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-topic-sm8550-upstream-pmu-ppi-4-cells-v1-2-a8915672e996@linaro.org>
References: <20250820-topic-sm8550-upstream-pmu-ppi-4-cells-v1-0-a8915672e996@linaro.org>
In-Reply-To: <20250820-topic-sm8550-upstream-pmu-ppi-4-cells-v1-0-a8915672e996@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=L1WblGj94ZaDL048pCEw1KwCIcqYN2hMDRmKDSs9uaA=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopZokNOHPgcU0D7Yz5C5q4aRb7SJAE+S5eG8rUQcn
 yFsEMOGJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKWaJAAKCRB33NvayMhJ0Xn6D/
 91kZOwE5btJsTTYQ4qDmCrLyi1kNVTqNJplHa4kwdQ+0mme1jGwNhJ3tmlWOPETbitIjg7sfTBT0Mk
 FMnSVC6mAqrvQW7FYSFgCFOz0YOy+9yN12AvXSDQtlcMlVrRJX89k8NxsZyn7Wot2FWZKWUOwEq+eJ
 uy5SqMYua6gKu/52nahWBPteOZjUdElHblLlEkuvdmpE6lfGqdbpHf/ES3Ru+nODsw+KRPWTL3Dfp1
 3WMj7t4cxejrYPI+d3Ht8Oku9+WEYPMwnv6hO3Z+sVMn4GmuUjxW7ixujELz3wFN6P1j/JDQVuggqe
 vTaDslrVHlJ/igHWs5kBx5k3W2aAz7RenYKgrGfXm9581dHbz5lBrDkBja2DfPlIroxrGv1iVT015L
 Y174UF3gVub7K7dLWLDNHL1p6xO5viw7U5UYmIv3Zm3uYwaA0+IUYd2Mu/rE4YY7rCxT06LVaPskSo
 bC93YpMlw1vHh/jOFVO6WZQPuPLjJT49nW0/2iUeetPeRkfg1ILVzIyTwnPzxDBhAiiq6dUS92g4qp
 wNq83YoI5q9poFePIQpgGMv+I/VNtmQ3U5BkH9YoWF/QfMkxYDG0VOe/QNG7J5KX6Rvajujm+lmZz9
 1+zfsP/ZT9+SOzT942R7jhy6c1US7qWa3m+9dmIfPkth6nFFSZcK175wyhNw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

The PMUs shares the same per-cpu (PPI) interrupt, so declare the proper
interrupt partition maps and use the 4th interrupt cell to pass the
partition phandle for each ARM PMU node.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8550.dtsi | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8550.dtsi b/arch/arm64/boot/dts/qcom/sm8550.dtsi
index 2ebe02e2ca8c03ac9b987af720c7ebe1cd63afec..1b7fbbdba2df986e1efca5dbfa36c01eb1be0836 100644
--- a/arch/arm64/boot/dts/qcom/sm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8550.dtsi
@@ -399,22 +399,22 @@ memory@a0000000 {
 
 	pmu-a510 {
 		compatible = "arm,cortex-a510-pmu";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW 0>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster0>;
 	};
 
 	pmu-a710 {
 		compatible = "arm,cortex-a710-pmu";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW 0>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster1>;
 	};
 
 	pmu-a715 {
 		compatible = "arm,cortex-a715-pmu";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW 0>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster2>;
 	};
 
 	pmu-x3 {
 		compatible = "arm,cortex-x3-pmu";
-		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW 0>;
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW &ppi_cluster3>;
 	};
 
 	psci {
@@ -5066,6 +5066,24 @@ intc: interrupt-controller@17100000 {
 			#address-cells = <2>;
 			#size-cells = <2>;
 
+			ppi-partitions {
+				ppi_cluster0: interrupt-partition-0 {
+					affinity = <&cpu0 &cpu1 &cpu2>;
+				};
+
+				ppi_cluster1: interrupt-partition-1 {
+					affinity = <&cpu3 &cpu4>;
+				};
+
+				ppi_cluster2: interrupt-partition-2 {
+					affinity = <&cpu5 &cpu6>;
+				};
+
+				ppi_cluster3: interrupt-partition-3 {
+					affinity = <&cpu7>;
+				};
+			};
+
 			gic_its: msi-controller@17140000 {
 				compatible = "arm,gic-v3-its";
 				reg = <0 0x17140000 0 0x20000>;

-- 
2.34.1


