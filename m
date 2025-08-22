Return-Path: <linux-kernel+bounces-782004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F53B319C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA43A1648B8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B53054F7;
	Fri, 22 Aug 2025 13:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="joFIIhie"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AC13054C8
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869596; cv=none; b=U0cOXw1plZzMJi5PuH1CYQYrHf0IvHNhnHFzzt9JsWODdoIwJUT/cWUlR4UfAG5rrkd4isL2cN2ODAv+vEDou4N3IDQrKgfhiYaZXzp+noqJTuoZUbUsNYqkNGYY4ywg6aR075cReVPRJ1tvdmIRnRIScko1cN8I6x3Xm2mlKkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869596; c=relaxed/simple;
	bh=wBmo3kbfIxIyD5dwKOQGVZ3JiT7ZOos1M4ntpCsT3Gk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KL/dAHJ9XJdGGRLkg6giBwWtL2lnE3iRykGLx2/AwLomz28z30n2LQ3kbq1PVHrUwa8/4hzwpyUwZOa+WwmMcvrP2SMU/88NHPCQPWUhhH/IXw48BghJQUy102zLiw250NQlEtZs+C3UMeCjbxmKxJF2x+tGXTim8yOyvT6C1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=joFIIhie; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61c1d397fffso93035a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869593; x=1756474393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BFHOC0io9g0o+2fapfpOBebq2bCjMy1h8J+xiMNdOIU=;
        b=joFIIhiei+t0Py+rmIrKmKhOsEQ6GSkd1ZZUvw/V4fKHVEi6wOctUySw8Ewf5e0E6M
         TuJGYPIXXzAetumVpFvKi/afvj/0ZVgaBNikuvPcxeOsuqAdEt4HRYC5LzYHU+fhv639
         scwj3yGFfUqgXQRkFU0+U5zOm1M4XGX+nPVydtx7kxRwa+y1++U88nd/ySGrwEBVsmTq
         v8pJ/na1EszVpAB1wi9719mLPvzHAWzHLc1AbpSIO7toC2xtAeZ6C8tro6d553Yql/OR
         L7yRyAODTDQP3dXnouaRPLTkBiR2GwvTu4tsMAFxTH8zR/40w5VrPhymGvj347twihZe
         evbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869593; x=1756474393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BFHOC0io9g0o+2fapfpOBebq2bCjMy1h8J+xiMNdOIU=;
        b=vXl1194Gt4yCf/j/oFoep7Bm/S6VrruWHMYHZt1HwzPJRBPW4jlCh+0vXaBI+/uOm0
         T4EvWSePmu6/EWXLVS2/yoAribl5PhD83RVGbE3rDjoIyXAD926tp2aXhoLIDnP/TUQL
         7/a1qMms2Q+Y9j67RU5uygLaP6HaryoT7UEYUCrbC8Ttq529aUjuOlj15olZFsTOma9P
         k9SQi+0hP1KXE414H58xz4ReFOFthAjdBpX3Don5VrS3Dh3x/MYCVTTd3OUdGpFDPFsq
         5o0+4Zy8hWXl/FMX55JNRZDkPHcmX2dVyg57UuiDvQETqDQg+DNKv/+aBuGTBRvO9N3n
         jVyw==
X-Forwarded-Encrypted: i=1; AJvYcCUqo1ThN5Ba8uLdJnnZocXpVazULqvb9LkNTl7e+ZyVOezXdVN2w++OjXU8AiSDQNkOU3OFQlczooZf3To=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMONODT3f8VEXWaDbIYhQmFkY+sE4N4uZ7+0BIX00TVF7RuOO5
	NWMJbPHCKPoflOqBXGUwYfFabKuKuolygGlYbM+aOcMLaL6huvpK++bGormH7Pw5gno=
X-Gm-Gg: ASbGncuSDevcZYFAEVCxCd2oLmw+PQk+O+OWKnK0l8qD4OJsf5xNZDHQZGJQ4v3u9Fr
	P1O0Z5+FmtCyU0Z03qEvfiLqdQEtijy4nxfL41al6bomUq1hrWH0Z2nKPg6QpdkbuOxEB48YleA
	jmYHmfkIYcW6jnqYiTg3k3xRqTa2Bxn5eNMEBx5rtykphubOSrH5Ql2AyBVkVh0Oqk9vje12i3S
	okt34s4j9laqRKW/k0UkXjPI67jEDLNSxl9hUKZtEbfrKHJiQR5+Yx+zdtI9oJUPKgCXIuM7r7y
	WTre8s6Xo7oHOQXUcoYaa/kQCYEPecmNMSLbbaEVCZN0Nt8T98bUI0ZSEgwYzOWI16Qz29Nb8jL
	rbE1YvFMpRljbAAdNOG+TzkXaQRbwxj9DtA==
X-Google-Smtp-Source: AGHT+IF0Xwlv3Rrf/C03hmGVd0k/7kdYNfMsfW7Jcb6mh78D7QdfCpUt2d6qVO+BaDy74Ko7HCfWgg==
X-Received: by 2002:a05:6402:348e:b0:61c:22bc:b207 with SMTP id 4fb4d7f45d1cf-61c22bcb3c6mr799727a12.0.1755869593007;
        Fri, 22 Aug 2025 06:33:13 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a7577462esm6984160a12.36.2025.08.22.06.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:12 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: ti: k3-j721s2: Add default PCI interrup controller address cells
Date: Fri, 22 Aug 2025 15:33:10 +0200
Message-ID: <20250822133309.312189-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=wBmo3kbfIxIyD5dwKOQGVZ3JiT7ZOos1M4ntpCsT3Gk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHGVWUdwHDptTGA7iZdCDsmkuIdKy3wqepGPC
 pE/eGTH/JqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxlQAKCRDBN2bmhouD
 1/MsD/wMWffWNAolAGwnNwVa1nFOJuOBrzvBM7+J2lxF14EKnnzhoffbj1ynFHes38QTRNQt9Fg
 5CqG5wh5hsDzK55ejAqrYcUH8VL59ukHeNR7ocJk9cDJaHHVU2hDRIo+vs/Htf2q8/kyAqqEvn6
 A+y49RYhdtbUUmh24+79Chh5xgG4UDwv2uI1xQ46fMe8ivN3CssmIpkDjjdv716gie0UwSRMqX6
 Z2ZFha/fSk1hD+wzBjxvC3uPnIwbnriOu0UbirFDNQKXGOlLAc4Qp6hm/gxCQHdISimMkeP+u3w
 foHEPu6pz3GfOGyf+2X0ZLrkBKw0B5hlUQoMSKuLlvrm146PI/AtZ3+z27uN6Ov60UP2Dd3ALT1
 ILNAs1tcps4nejlvC5D44+2a+7RbWO2Ki2vzQX3rWJZ7dlxkQ9rW75Em9COPW8w2y+nQ9X3etQZ
 SBrwiW4LtsRyn1VOlt3gvY/teUb8t45zbaM0CXpzp+hXQBX7xwg9KEeiQJJ/R9fiMcwHp1GTZHW
 LtlDALgoFxqR8RLEiJfSeVUjsTpWgg7ZtZSxSLh1NsMDLqbUslj4BZbiUBT8IUxG4P7WLSNLFa7
 ociB55Pln/NEiDm6pbHMRUAViGnfW0KbmIJ+Gu6uhX7rtk2qd/J5iJZIBeJ3eDQ5r6x85eAgVur 8yKAxa/NzFEgsdg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to the PCI interrupt node to silence W=1
warning:

  k3-j721s2-main.dtsi:1431.3-1434.29: Warning (interrupt_map): /bus@100000/pcie@2910000:interrupt-map:
    Missing property '#address-cells' in node /bus@100000/pcie@2910000/interrupt-controller, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
index 726374dc8795..0ad752975acd 100644
--- a/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi
@@ -1437,6 +1437,7 @@ pcie1_rc: pcie@2910000 {
 
 		pcie1_intc: interrupt-controller {
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <1>;
 			interrupt-parent = <&gic500>;
 			interrupts = <GIC_SPI 324 IRQ_TYPE_EDGE_RISING>;
-- 
2.48.1


