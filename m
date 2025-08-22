Return-Path: <linux-kernel+bounces-781807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E824AB31709
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:08:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8E481D20DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C332FE566;
	Fri, 22 Aug 2025 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkOUBPXO"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D2C2FAC0D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864286; cv=none; b=oTmk/wQ+7poVHXlhNaq/IZUK8BpOLNc9HDuWL0pOuRdzKYLEQpwOFOKnmQkPd06cF/61wwJ9B8OMot+AflHHZOgbtQlU1a4W/ekajSNi8XrU/ifziF2/YkqzHjNBXdiI4MIO0YoT7mgLbISfrLqhpbTVbIQ/M861Lc4WFw9Ds80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864286; c=relaxed/simple;
	bh=+m/VbJ8LuXiAvJGDr8ib87nIKbN+2PZQ69yZYJYr/6w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hIR/AESFmR976DhcTJmjica1u6HA3NCh+3OOTP4LbFv2ZoQuULOPim4cORi1Plh240TDlkXqu6hwnikB3gY5JXAq1cpbzJLqZ4+Aj5p8jRsdAtj4jZ/QqTLuHT44IKmCpBSe2GxNLEDrbowseXGE26E+XM5/2UVlLAk1DGq6qAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nkOUBPXO; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-61c1d397fffso81429a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864283; x=1756469083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oK3Q063m1xlWvbyZ8GthB7BdAbmwNNtZ50Wt0YimJNs=;
        b=nkOUBPXOAJr5Wf2qAM+Fr2U+36IWXYVR7ouIoDvgMdpeBqyKgwesVuNW6ipqTv4n9/
         J4ndOUTvPPwVOovOUtF6Q3lhYr9zGsefvdL5wpZEEq1YVMDC2bQRTuUyMJrnPygi4OHX
         iAceBcpumAHNjDEUKeUvZmlYZb1oGOLmGA4ux1wjaMzZStCetRESiWXolSbvglQHsvKC
         fyuttRzzAcNHYILoy6lyScTsBs9FWaU/i/BSH7yQQHgXTiT1PLkcywE6Jw0JmiquXMup
         Sxvo9AEC+FC7k48lAdfnY5Suy97Pd0NSd3FIXSUXFmRwoZH5Qyn3cjWSdYPY0lWwf7E7
         1C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864283; x=1756469083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oK3Q063m1xlWvbyZ8GthB7BdAbmwNNtZ50Wt0YimJNs=;
        b=R3nqzKBBWNwvy/Ds9qAhcKYs4Y1NuoF2Ry6ujtssOvLshk5idxEoJIo7wqwFvJ3/o5
         FzjvdBEQdNAJFSoV6MfymHYJ3dQFCBxA+eX6fxaTI3wfQwFmqrz+k89EuVKk4XylNuwm
         c26odt9d7llR+w6XLyzQNw/FKO4IzKcbTPvdpkJj1MUhgxvNlPyHjl7tGqb7iGv73EFa
         4yakCA1UMxTiQhPHOWRn2rwX4cPHuR/UL2XIvZ35yWfiiVt/oOTR/kHrqtsGsfyWd/3A
         F/sncBHo6gHbN1PUj8gW67Aw7Ej9rpGku7KW3S2Jk66Cld7ncf+JIpYJGQ5DoxCLJUCr
         yn3A==
X-Forwarded-Encrypted: i=1; AJvYcCX/7MiIdFeyivk3Jx2D1OIwmkiI0W/9X8N3basC1XqZ9f7v6fOX7GcrJENn7TIOL1ZnJ2Rki0cWJkdEyn8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8j5NU7jRzym4wUx2wtIItdrf7cq8UC0/LuUWRe5dmtxuqENN6
	kOzc43ecJfmdjz6xtWAhLzMTwcs7+i8UaR9ZrNGQEJjZWzFyziHYAMiOxdvcBZw2/Bo=
X-Gm-Gg: ASbGncuyHyB4hx3495R3oTo7i+CtuEv/7/9nVvOFSc2bGBD+uQTshjnN21ZxkqMWqir
	bW87yKJBpYmPUYGU4Sm+AB4A9bZ9KhAu8eU0NeCbLGg+IvRKeLuPAGijGwHNiPFIYwTRRqZbmvL
	Wr469nk8nlNhWKflhXtdT+PaHefO47KfPahN2FFrVpHFheEqTRyOnopJ3rwcgkYMDXFgCpjLwzO
	pxRS7C6k+ZMzyno61Glnrln73aipP2FMm0ob4CyEMHkliLDIlRfv3MXG67ERERX4mz39cfsf6R6
	2sduEGBjA+BbI2B8iBneiijIRK6XSGookYjAvPNKC5BBqkXoJdQQwjwvqJEj5aH0EYk/B6tLpZz
	koKkwipVt6ijn46zM7uW12j8u2EdIgdIssUauPac=
X-Google-Smtp-Source: AGHT+IHOn7Ywt2vJBoupkCqFb1G1kiiUtaTbQGeCMZcXvMgExy6cHVcB6KdGKY1IP8daStonceaLhQ==
X-Received: by 2002:a05:6402:358d:b0:615:7ba6:4876 with SMTP id 4fb4d7f45d1cf-61c1b91089cmr1189584a12.8.1755864282676;
        Fri, 22 Aug 2025 05:04:42 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:42 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:12 +0200
Subject: [PATCH 12/15] ARM: dts: qcom: apq8064: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-12-d54d44b74460@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=+m/VbJ8LuXiAvJGDr8ib87nIKbN+2PZQ69yZYJYr/6w=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFzFSEPLcWHEEIyGDj1vtyh070nNpkYopnCYm
 4AIARReRDCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcxQAKCRDBN2bmhouD
 1xczD/9JFCFLGMWHqU+utqJLMr7zQ3zCHcEsQ3nKHnHYA0/LpTnKmnfiv2B3zQ1HQwu4wlpKBra
 8BB5ip1gF0jCmTPdwz557fzvxWIZGz41OX8n2nhU6SNlvbVcJqVB5WG6BoemtJongNwBx2o9cWH
 mZ3oBEkteXLhrqoME0faO6UuuxX3RPW+/xRhQBbSU+6f8ZY/+x9qjvLi/AnjPHOs21ehA1YynDn
 SbHlug9VjXpAzPOA08bMpAdkBiWxJS+QxmVH0woeaba0tzsNRhpC9XQcvjmOcMF5RVFZw0rLucT
 uhBwoU7xEPSSs8gqZFYaZb0AbSyqLdID3W76Z6E9c8ohqwsvPlwdcs+nL2HsjzzTX7UjqaiuCgg
 i94j2+YCE/lL7WBBBAjx9IzTnFxEUZEnyslB0NOE7jX2bzyzxdDQvQl8FBxYw8kD9tIyuAg8DaK
 SA70OSyGYIGArB0v9luqh//yQFBqTJ1lPssCieT2LkJieDWt8e11YnpXrOi4JF7a4eqMploFTMw
 e3en6EOhQka7Nrfl1YMCiV7l4jtzafj2yiyPaS69zM387AUKaThzLg+LJeOOlgtIfYZJLiVkuW+
 P5zZSu/OBqDiDYF+yBRn7UXt3uCU8Gw8Iyf9GFnywBWB9/fFsDvsDRV4mRE6mVc/tGQtgaBOWZC
 mSxAcIVN5gsxyzQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  qcom-apq8064.dtsi:1353.4-1356.29: Warning (interrupt_map): /soc/pcie@1b500000:interrupt-map:
    Missing property '#address-cells' in node /soc/interrupt-controller@2000000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/qcom/qcom-apq8064.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
index 17e506ca2438b33675477b65584c2b15bc1ae11d..4c9743423ea880515a05148091ed97411f08e8a3 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-apq8064.dtsi
@@ -342,6 +342,7 @@ sfpb_mutex: hwmutex@1200600 {
 		intc: interrupt-controller@2000000 {
 			compatible = "qcom,msm-qgic2";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			reg = <0x02000000 0x1000>,
 			      <0x02002000 0x1000>;

-- 
2.48.1


