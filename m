Return-Path: <linux-kernel+bounces-781486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C909FB3130D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192A91CC0DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77FB2EE5FF;
	Fri, 22 Aug 2025 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nO/HTrwQ"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7232E3B00
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854804; cv=none; b=I8BRDFol1IfxUpxgdJAggwMa3KG1uDbNSl5+FDMlani5CeeeTaFbYtvQRp/IsuiXXE6eJPxhVnSsibL9qr5Wcu3mKfzHnyLVkej3P9a6ziSQSkYOezyPqX/sluU2IviNxnDQskXgCoFW1JCgmnjl4Ml9aYYcfVs70Hcy9hpI9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854804; c=relaxed/simple;
	bh=C4TnU2YDn79d1hZKPF33rnSJzJUcjFicRADIi/s+iJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYWyCz0dmxMHY6HeMNuFtN84r3Mq9ZU9hvhT2OaApju+I5FJBZsOb/Tq5hZ8ApaIb4U5ob+kRIfQGI336MEx69X8HjzfPVGuObzHB1YizXNZu7wi9tLsaKohVWqKAwVrZE/nUkXjzp+gqa+WztkGmCuL2BG3Cu/RZ9HYBaFLf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nO/HTrwQ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c6743a10e3so163706f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854800; x=1756459600; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zuj+iAOhtgXhlr4DasU1PClq4DgoiYTAxV9eMIo4W6U=;
        b=nO/HTrwQAGrs56YntvQnX9WInslLWfyiXY1GKvaIoiSOhotNICSeCQP126qHCw+oZy
         hN/h33UkerSl9BUVxWTFR64gaXEpXcVaBFGazhqa7SJ9forMvohVrP5xI/PEVk7A6d6B
         YAKAiUB2CBkhg9RQhOVHh/0/Tl1E0Y+lizytTbgwWsmoAo/whrnfezEFO10RnHOptahG
         t2XiUGWa7HV0QdcgrkEuS/GYlmJjl7t1YxPzm6ZlhfuulL0EQL53YhCc/PisbqS4QNAg
         kO1DKGrECaauOyTZYGXb8vFMjdFdUkU5qorPyrooGrVXNqgRNAAOezKJa1/eKQTFAOka
         /p7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854800; x=1756459600;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zuj+iAOhtgXhlr4DasU1PClq4DgoiYTAxV9eMIo4W6U=;
        b=sA7mSyHTppHuVviEQINfKk/sdORSs6tUyVyek+HtVwmEpWoaVfZwhDyCzdC+QzA13y
         mNlEDPw7W8yMvSA9pxa/LbbeJtvwo27gqrj9tpUbVwfPQ/10rv9FNv7YxfGNQ8/zCJuP
         MAsmJsEx4Nf+5RNw3nNaLDqysORiFoo6DeJQDluhPGxY2ell/6dQx12wN+TqIo0ebGar
         48RfPUzk9OY/PDwA5cDjexb7m7MB/JcigjjJpjxsBi5UugKvuV7Q+9J495To/c85YYxc
         Bdo+Qc5wXDqTOLfYGBYkSmqgnkD3246WAjqi3JOXwlO/vqWHICT2RjuHNgpDHl7Kunfl
         Xzzg==
X-Forwarded-Encrypted: i=1; AJvYcCVF/rqw5j/RdfiXucQ1Da8quCsM/z+TdZtYYt6u5a6cX00pA8ItFUPFABzRHFzsV6gMU7wzoLp+y91AeyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsfqqdrsxT69J1vvL/BSLGrSv+L8P/Gemtb1KU4nPzp2SaRO1
	m41lYnKS03aVlH2dihEvFbGnYbFetCdQWSv7iCBqnMBQDN8pSa3MadnMTdiNyw9ojmQ=
X-Gm-Gg: ASbGncv2yiOHTiskejC7t5ovftvlA/lE3ICp2If/21nODhS+smc53ADLNgFWVySZ97M
	+fBzvUVzrdvYI+RJdaWHVDfIG93l23thX1GJQypwNuhyVCOLGW9pZqx+GCJOPTDgfZtBGn9XMwg
	GJgu8ycJoBOfAN+m6Ba1OymsThjwK8d4bhenwX8I0B9q7ExBMPFCpEWHUm4Cr8pI9C+sOCeuJZ8
	JLTwseufXhzjY75KCB++zkJKQ66vBEfp8WiatU6F2oel8sDOQHvqXauTVleJMMNauxMdMt3KIZq
	qujEx7SPjb165PZUVNJsJNVMhh6hB53ycJZHXeyDe9z9FemOgyonwldfftK8qka/JEP0vJmx1ZF
	ajEei21E14M85oCrS343eywGC1gmnqORrKous1xLs1ZE=
X-Google-Smtp-Source: AGHT+IH3SCVoDUXzpVQKZUne86yIuRvYTzTQ9SllmeMy+IlSalvEzfIiZoJ4B1+D9DEPGFwISwhoqg==
X-Received: by 2002:a05:6000:2c09:b0:3c4:39cc:362 with SMTP id ffacd0b85a97d-3c5dcff39damr1827701f8f.58.1755854800301;
        Fri, 22 Aug 2025 02:26:40 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c5826751d5sm3297007f8f.14.2025.08.22.02.26.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:26:40 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:26:33 +0200
Subject: [PATCH v2 1/6] arm64: dts: qcom: sm8450: Additionally manage MXC
 power domain in videocc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-1-28f35728a146@linaro.org>
References: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
In-Reply-To: <20250822-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v2-0-28f35728a146@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jagadeesh Kona <quic_jkona@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1344;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=C1mW1P5f/eV3xTX9/EGe13scB+qV+ElK9sPewtfbTHI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDfMfhIPjtACjZgd0bI50dxn2aaDFeJJEfr64mpu
 INzDkeSJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg3zAAKCRB33NvayMhJ0XMQEA
 DG0tz589Sl25rBka2R/i99dzIpRPqcEYcTv0ET+k1iemoOysfu5KvrVTh8Ml4qSjyHv35zOsj10TTs
 JhErTCmS4xCnb9Fp9FDvEx99JqlvxwHe4NEKA8k2OhWHrlK4RgOfIBqlXG5s7oQ7jQZIZqeImH1jPQ
 TRFrebXTgmO9Pp+7uKutenUh6LyyFrGrlzoV+kEYwV2asH0S8uOAQEIsZILsLqJLUPE5Ijy1/K+Isr
 1pQtiZaNktJZbo+7J4g/zXvX8J9q9b/JQdjDO5y2lEwOz7ZLFKHviCKLNX8se1F0lHXNUyDJPSa8/9
 fiL/Shl13dw6nwhmp8fP/2wug2zmkoE2Pvedm+QeAuzrRdqc+A0+jPCeturasb6gQQxKsC3NgRL4NG
 3HuUhC0El41aCNpK+Nxf5XN5gCrO6EWjwoZVV5AwKXyS/01hXtOpmjmoGjoTOD3ZWbFOBsu4p51gIH
 3k1Bs/BFKhkDaJTEjj6Lh/S+oNE1FcspKRsA9UfTPR3gGu/b7+ehks118LajKfFK59GIaEKF6W2d+W
 fLNrd20cYhIQrMdg9ItljzDaZZKlB/uOZJlVCPcg1AdUlrfBaRf/qfXfx8fUtvkbLhwOMYC26F2DwF
 tDZ8vKxt657Aq1PDDLPjNhvuBAiugHb/1zouFhtELTY1YiRWyFacEe/XxGWA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Videocc requires both MMCX and MXC rails to be powered ON to configure
the video PLLs on SM8450 platform. Hence add MXC power domain to videocc
node on SM8450.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 2baef6869ed7c17efb239e86013c15ef6ef5f48f..8f6db0d78f738b14c776735d6b3ae9233b165026 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -3199,8 +3199,10 @@ videocc: clock-controller@aaf0000 {
 			reg = <0 0x0aaf0000 0 0x10000>;
 			clocks = <&rpmhcc RPMH_CXO_CLK>,
 				 <&gcc GCC_VIDEO_AHB_CLK>;
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


