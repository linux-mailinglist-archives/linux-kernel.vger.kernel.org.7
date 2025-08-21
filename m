Return-Path: <linux-kernel+bounces-779116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 172B1B2EF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC211CC36BE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81E12E92B3;
	Thu, 21 Aug 2025 07:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="f79nxg5a"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0E2E8B69
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760607; cv=none; b=QKkjckNim5xvHkFO/KY3ecV1uwLigiEGAlZkQh/f2PtIsuD/KPIO5nG4QDMYOulINtBhMzmr4BczJI9CzROcmG08LvMH0bQy9AwQYZMR02MqwzC8/kALkPlTHBYuxaMBv1mc9qixRPsOP8tY7E6KuWNxvB30pJzHacPa76ScUCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760607; c=relaxed/simple;
	bh=MFYFkMSrWP5pY4nqJFiDqJWkSa4uwcnjvsxZoozTN9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n1ZWbDC/k/qbPtTLTzYT//40vWh69GrAOz+UD2z4HkJTYzEwP4a89KKe9rGw0xYfVBc4kwQHufuEDyv5JQF1fKXNsW7YxjuG1YiwPUtFSofkWScFkk/zxw3QC3rwNTuWn1FNJkRVD21ucHJ4zAyNqVGIJCmDFMbpUAGuZbuB1V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=f79nxg5a; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso443641f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755760603; x=1756365403; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IiOSxWsMfZ22+52FKy1745xSVf+zWfH8pzVT2pR3hgY=;
        b=f79nxg5a3oQ4a0iSIjBJD9V8hrh4ogTx4t/o/+qG0MVMD+bnaq6q54bQUESF3J0irD
         AE0/leUTB6gHD1BCx6F2MLSumTojdiitMcwTSqHsaSn5+Lra1FnyDJVI47u5UWvqEydJ
         m4gKTXYawz/JERCi7FKTpbuNpHUuYx9AYWLMX2EvFCoGFBIoc2/WXq5XLx3gu9+ewxdT
         yheeM4e9LmHllGIl+E8hy8fpQ4coHsXw4jzcU2XVlRTfa+viWns2wlfY8K7Ixqe2DygA
         SOGk3ye9pkbFoJWUj6mmhzjzRLC8LfqYntF00Akd9/vvCO9ZoBsVwi864GFxUI2RvUCf
         pcfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755760603; x=1756365403;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IiOSxWsMfZ22+52FKy1745xSVf+zWfH8pzVT2pR3hgY=;
        b=e8pOGHdQ2AQbeekzBwO3YekHlF32XvHMnROS8FZ0rBZBuSMLrOrH6WP5TN0O83tnTE
         U5+6bUoZyzs/CN1VktkrpqiDRmfKPnqjJetIrHxPSWYhawY/rTZPuIXnlExyNXCErqdH
         ihSSIg6KbUBn4odBk0qGcPWT8qDwxKYnvj/u6e6WAcADIy4LYVo4fP4vnT9ZO3i/MdDC
         sCH2n8hxAWm364UdLD1A5t8BIg/TLzaV6f5aF8KOuj7mGcrwdE4z3B9FwMfB4rmMOR+Y
         3q1jOuIQmdcpONhkA1JGfXZNyDhil6wCtoSDqWbwdGJ6WKcJ+/DVs5gPZFIAd11H+BQf
         QLPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDEIRLlPGIZdrqs+7mJGmX2ISX2QOF50Zu1OBvZdNhFQg+a3WYtfzAqvEDjkT0oY64DTn2m+B8NZQVxdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsnoeOfxhY9D31dKOYNiNfJpK52lWgTVR/YjuAAfp+eWS/nSN
	7yoTNTMO7Exqz2yJY1YExYaSjwL6Zs6hQW8GA7hA42Y4lP78hfYqsYcMuLiRcKZrF0Q=
X-Gm-Gg: ASbGncuK9vYkhWaeHUzzutrYpA9k0qyew1ASpkl2FpIQ/S/Vx8u7AfihxTnsLnxj29b
	7Qoj//y5pomch7Tx9J+Hwd3WIYfNbGscFtbQBZjzpwrlEGQLJVHXI4SqCVuAhux9Bk+kgi2FiGn
	Us54fPzjV5CXWvwNllXBTcv+TAgUGn84PaSTj1S+S+TYXPV8aJatnBguJUPxYuAmUYBQO0khbRB
	0YA7/nTUAaMvsgTSxfcNNeI3lbhKvnYMWiZA6A1aRfR4t9AMk57CuKh0LKBNXThD5bHWd52wcoz
	3RXdzvt8QW/840WuGxxdYvTEi3iSaZ+1w2267SBTEr5i7sFj6QKFGp1t/OLv6Tiezk0HxZtoXAu
	DSRLK+QzQ3AarLPLH8OVO1+XBsaWusLwo4CdsmL1KwHo=
X-Google-Smtp-Source: AGHT+IE2duDyD+EqTrmYcapA1riRnaHwJhVPv+AeTwRpPsHbP5BgHn99AKrVHXuZLDRidZJpXNnK3A==
X-Received: by 2002:a05:6000:2dc1:b0:3b6:162a:8e08 with SMTP id ffacd0b85a97d-3c4af1eaf2fmr1128390f8f.12.1755760603419;
        Thu, 21 Aug 2025 00:16:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4de5b52esm14411455e9.20.2025.08.21.00.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 00:16:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 09:16:36 +0200
Subject: [PATCH 3/6] arm64: dts: qcom: sm8650: Additionally manage MXC
 power domain in videocc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-3-a510c72da096@linaro.org>
References: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-0-a510c72da096@linaro.org>
In-Reply-To: <20250821-topic-sm8x50-upstream-pll-multi-pd-voting-dt-v1-0-a510c72da096@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1214;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=jbtLIQpfABjo4yu0j1qEsUQ4afK624swlDN103gi/yE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopsfWx7SrQf4C4mJft/Jh5SQc5skYviHq7qGJzMnZ
 bfxkrXyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKbH1gAKCRB33NvayMhJ0RlkEA
 DMq2XsrsaAYfDF8EOA18LpMmfSgeV9APNMBpps9HwozvJrJdTX2voMUkINnBaA/Pw/rZCCFZHs2dml
 aDnV2rpDMRAVVEtXURHfjijAJI0Nf1tJhiUc5DBrGchllr+P//M03p8xfg9TOwqEeMyMC4dPRgEY4T
 UfnAuAU5xuh42vqtO8LY10lPLmIWt8NuCaws5eUPW8WeBCfGAKhMVrdKsdeVg4eA4lBg8VAIZxvQCj
 LXCUAL2kCOTPrknY/I+tYPS4xugbxnH3Mn5KvWE5y2Z6zg4zY3JacfiQj3kb+0I4rxFfaujPad+s4x
 0r0gWgN058T7IbVU9D/CpNgIuizfjnBA9vakH/TMUahbs2EfjHFLEJWlZm7s6CGFdhA9tZdvPfIUr5
 4jzmgLD4UlHUMaYpzj6P3MTog2UUB3K5CoUh5eH8T2PbxPfJs2qYDUlOCdoHY/MCb9Ib6eQZKVPyuR
 IF9a3pSsmokWwagj6t+eQW1yMZWdVlTTszfKad7dogvxbhXZsa0jm7o3JU7OBTaNsP/nzZqM9j2u/W
 LR8YCKHyHL6Bkc9LC7dQThzBoJO6+4Sd22hkQRPLDwMBDk87N3nNI+Ws/1dxa/b/w73xLEGJ0AzrwJ
 GBG0mqQkEIUR4E09fpfQtsmTCvVkZ/3GkWdXnyBJBADEWSmongwPDF0+MlNQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

From: Jagadeesh Kona <quic_jkona@quicinc.com>

Videocc requires both MMCX and MXC rails to be powered ON to configure
the video PLLs on SM8650 platform. Hence add MXC power domain to videocc
node on SM8650.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8650.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8650.dtsi b/arch/arm64/boot/dts/qcom/sm8650.dtsi
index d6794901f06b50e8629afd081cb7d229ea342f84..99b7c6603f284df54b0a4e0ed554817fa8ce6f35 100644
--- a/arch/arm64/boot/dts/qcom/sm8650.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8650.dtsi
@@ -5236,7 +5236,8 @@ videocc: clock-controller@aaf0000 {
 			reg = <0 0x0aaf0000 0 0x10000>;
 			clocks = <&bi_tcxo_div2>,
 				 <&gcc GCC_VIDEO_AHB_CLK>;
-			power-domains = <&rpmhpd RPMHPD_MMCX>;
+			power-domains = <&rpmhpd RPMHPD_MMCX>,
+					<&rpmhpd RPMHPD_MXC>;
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;

-- 
2.34.1


