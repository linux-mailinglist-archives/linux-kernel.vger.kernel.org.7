Return-Path: <linux-kernel+bounces-781488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8672B31319
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98D9D5880FC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C22E2EE285;
	Fri, 22 Aug 2025 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ctbhC3Bt"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3E72D3218
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854806; cv=none; b=frdw4mif8XsVBsHMlG6ozQIzUaieOv1HpuiPPIgfa/PnQ+4VRMyJ7/usdovZa/U3ETPuRdLTVnUHUX4AiUwmvdJYrjx10ck1x/BjhFFK6rtfdHWp5DXjhn0QN026vE3tI+/NRHvmDEbDW30ph9r3zMQybickAKqAW51ol+ZNlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854806; c=relaxed/simple;
	bh=PyUQi8YMEtw07ZLmRCK8btCo2t5iTXXchMaxMmTMsLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IC1jRSFv9dN/rlsuW4QgR4sjVUFdE7VZ6/MwUljSA3nG7/Qy9diS+GmzDhDCGVHX7p5XfFQnVfIp/xVwplU/Vo6/HmtqwKNZAdoihzON0sDvU/9yDRNkTdVIMjL4So184OrKb5VGEcfJgre8YiiwECdQ67KNpgBUW+IooZV4/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ctbhC3Bt; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9dc5c8ee7so1705949f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854803; x=1756459603; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPn06geqbCWQqNy693X8sDc8Y17mZtLy3S+a8W9CJcY=;
        b=ctbhC3BtKa87tzjADDDknPAJl1+MEQ50sFuUQPktkiKg5a4kvNfkgMYSUxjAM81AsX
         5is8ykrBb/h5NwHOxKiqKMv1Pq/6dYp5rBu5kp6Y5lIknkDJrL42dSm9QH/mkF+ekjoN
         v/nXU4V/MsXqQ1vGnhe0C+NslErRCXuB4H/1anqOORoDiuumG33Sdyohitq1lwrDhRj1
         WvGr710ud9uV+W4OiyjrG82xRTqx+xhZR36RywyY0aXNeli1tEZ7nDKGxxC/iya4kHlb
         3JXXPAzToMwqA/INt1e3PMZu2VEXuk6EcW+L8pH8Z6oa5J8opE+NjIAcQU1zz4O7Tfs1
         OpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854803; x=1756459603;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uPn06geqbCWQqNy693X8sDc8Y17mZtLy3S+a8W9CJcY=;
        b=mHNbFncz3pQ9JejOuUCNH+xuVwn1kdxTR1N0OJ2Cvim9uAbajoT5PKupAjKJRifvYA
         BQzIYpL32WuvTDXq0IzH9njdvr8v4BnSGxZO44+cFzT2LHAXb3LfpoJAm0aHb0cU2Gv4
         ed7FAMD45INGW+MVWoVoYyMY2SijxKYgcE8AxwoB46nwr+PC3NBvfjrvLvRQZ5O7GND8
         RDEmIXEXHudCANbUudINhzPdhn/danaApmnndwyQVRdjh5uju5jyz1fG52rLpf5Jql9y
         fqL7XB+A2ZEla+lzxoVh5vmm6X6l9eVPuRSkmorQHM3hj40YKs4/OH/xByMGO2W1kxvX
         k3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgNONxy42Q0H5RKsfcIFjUDkSedH6VbKBytFv+o7PpgPnF787jY+vKKFKRjdid2zdJirc77CuQWmldO3c=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb4fzz6Z5vGb1ctO8NBvTc51K991QGvna1LImefGRsToTXIY7W
	7EwbyCL+Kn1ybMTi0I1dEPC59tUvVpX24hXSlVnfPmHMyMFZmIqhrMN9kMzB9hIJZCU=
X-Gm-Gg: ASbGncv8fLLSYcsouIv8BbduMwf0fawHAA4cLN++D15a9Y0MA6evQlmAwYhGDuGnJGz
	7YO7blZ9hgiJjuo2arBBqILWRIssyZjShR29kqTjwloo4x0y4OOSczzHn6MKy5KaqXkT74sCdv1
	J5bv+242PYyYM6foNiSObykqAKPUQ23iAmLZsd3RVbNG9jpRRAAFF3zkvjtAvqSCqyEiRrqMirM
	ij51mx8dyuNggGXyGOMdRn7Bh2hK2xqU4z3QiGXDISLcvTWHUJlM/tzHVX61EDZ6uvrhMSIWEWi
	E78x21vit0ECVB/gfHu+7qfSBofxD2xlLGMkd8pXol2JiHDb8eoRzTYvuOiLiCg1EDFIYvEueLX
	aCOVRcoEGfd9S9D8U0nXRYYQlX+GgZcSa7IopM4gycuI=
X-Google-Smtp-Source: AGHT+IFedQ3busDYbK6lGgDbe0C41mZBZUValE2EqFh1nWTdYGSWt7lG+G2Kt5lkPDyb/JEuUkpbPA==
X-Received: by 2002:a05:6000:471c:b0:3c6:2ac9:d9a5 with SMTP id ffacd0b85a97d-3c62ac9dc6bmr868954f8f.0.1755854802892;
        Fri, 22 Aug 2025 02:26:42 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5826751d5sm3297007f8f.14.2025.08.22.02.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:26:42 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:26:36 +0200
Subject: [PATCH v2 4/6] arm64: dts: qcom: sm8450: Additionally manage MXC
 power domain in camcc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-4-28f35728a146@linaro.org>
References: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
In-Reply-To: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1322;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8OWok+mQJ6cMYBBRb+TGH/dRfH3HUvGf9YkBq8GS3GY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDfNK8rgyDQFwM0isX9gmL9sAkrITeK6U3Ig/NXy
 HHJNjt+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg3zQAKCRB33NvayMhJ0brED/
 0ZkBt1fkMr6ZJrfQE5HH6+6+lgkS3aaA/0EOEC697Crl3nGyQc144U+ki/TRUaTTcLpEHMDdCs04SB
 7gRHX86RdqCH54wb+IrFw6gkNPtpOw9+gKSuCNJJMBBPYIbVB/c5c4+gG/oXttfj7BcbdoE2pXLncz
 MohmGaN1q3bvtZl5Y5xMTSoLSsvmMHYOexj28EWSOHrpctMOXfJ0vZ36TVQk+5+c82wZI7J+vIzh3P
 7D3FmBYdF9QVr+8CjAN4E9ieI1GKFLQp9eLMrESFe/6jzL3FpcWEI7VLnC5YGRV3r5cXFM72Rs+Dap
 PCueCHXm+x3O0KFUBwRft97Qjpe3CvKt/zxZ3rVNvmIoTNu8ScZmaNqRltFiH6JoB1qJOJ7khX7BBX
 RuU+r//9lJaLhdLeoIEgMaALww/cpccRZFm9qiSxUpbDcp8zreXaYGeo3K63s1YkFO0aFpIWucIbYa
 e20I6hlgjqN+dsb+UMQccrq3y9Dipnmd/gTxfVE9uTDtT3QhS+h7he27hfkY7VesfNkQ6A5DqjyBpl
 sPRLV+ruIX4D2pZT0S5dMYzx0i8FwgW548GNkd4FqgEWYAK5sRANZDl7g9h52ivsUM5HAed6zL0BQZ
 uyysN0s3Mvx00ztbqzWpVzQQg19AR4UqIjg5LXdfFtN/uZ0SHmsXEOtFi19Q==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Camcc requires both MMCX and MXC rails to be powered ON to configure
the camera PLLs on SM8450 platform. Hence add MXC power domain to
camcc node on SM8450.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 8f6db0d78f738b14c776735d6b3ae9233b165026..dad1395c8c6712d233e5acd558e67f1e53d678ee 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3293,8 +3293,10 @@ camcc: clock-controller@ade0000 {
 				 <&rpmhcc RPMH_CXO_CLK>,
 				 <&rpmhcc RPMH_CXO_CLK_A>,
 				 <&sleep_clk>;
-			power-domains = <&rpmhpd RPMHPD_MMCX>;
-			required-opps = <&rpmhpd_opp_low_svs>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
+			required-opps = <&rpmhpd_opp_low_svs>,
+					<&rpmhpd_opp_low_svs>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.34.1


