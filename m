Return-Path: <linux-kernel+bounces-897515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E6FC533D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A6814A05F7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1BF352957;
	Wed, 12 Nov 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC9G5MQS"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1CD3431EF
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762959783; cv=none; b=e0RAQiTWI4U9SnfsARBh4JQITF4r8dezrKNqo/JppY+B/efes1hjwpZ5WxW16WNZecvxpJVUk3nXnyu1cwZgMLafpRTyKNKJexH2ZoGkWh4vqy6w5EptW/A0+o0mBGhFOUulc54iMv56hWsgSiWtGolqJkUWVOROnm6jTaW/T58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762959783; c=relaxed/simple;
	bh=CEg/BR0cwvUubt7wKmvcZpBYJWSSViaS4k1tDGeLsnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jyxwuqq00fk1v7gFONiMmPrEoK7KkJLoAIj6Xmtgmkv+vL57hrEQvdIPNdMUMyRwmJ1Exy4eHLRQvKyZTfy+m70AT5c4XJ+PUfQhgVN3IKH2pUwQlMXbJAYo3NVXBAiupGy7SgTUpJsvOG09P9cmZtzkGroXv6pBtKu64Wo55+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HC9G5MQS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477782a42a8so396715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762959779; x=1763564579; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dt/UyglSFhPayVd5V58V0cdDUFPe2/XCsVkpQyASDuI=;
        b=HC9G5MQS97jbk8GJjNa5Wn9wGfz+T0WSwLorV7NghPu2jtKkyN3NhWSI5tIirH16Cy
         vTtx3GuFwgPW2tAvtdw89lJW55wP/SvXxgq6OjDUMGy7CIYfPoCAHMHYIAbj+kWvByz6
         gs66gub7azOQWXbM5PxDGpg+HG8n3Lo2z0KIC2HPcFqLN7xzSIV1y0knjYm3LNU376pd
         aNxGoGxx9WxcAvsDlmBe538yRTyQh6BqDeKr5gk4haGd+1lKxc3QZZyyFPNV3MFjCq1d
         4y0QzbrHb7Cw/xTFzCaUUXMQzw6QYJ0FNVBbkYyhv+sfl2CiJaQw4IhSwuF0I3s2zhC7
         Rd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762959779; x=1763564579;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dt/UyglSFhPayVd5V58V0cdDUFPe2/XCsVkpQyASDuI=;
        b=O1oMTjKqgkUyaSLJde2NLd7TelxTK41EBWX4igc0zh13oF8NSmiY1ZLvD/e1n8w5WX
         5MTKlnNf8yxnBVCv0pYObd6gSu85bSU4gtmV+yrjddX+Z8LlfXJ2hyN3bYXtomoylG2q
         dmPbst86XOHGkkV8XaW49b0QDNEJlKv24KLC+SMqErN6B+5OSerJU7qtEStnB7mzHmvF
         5ETBvkXclR9E9aGQ8Jvz20XbVkP1drCfEEUqxbbNrlDRL11hwQmt4G1vWLjYAoXrzEid
         jRVnvQ+TCX87JMnj5Pb0MPRw3xrlxL6mqJT/1mUaHcwF+ek3RGrIfgiYUU5p1w0KHtxy
         bQVA==
X-Forwarded-Encrypted: i=1; AJvYcCUmhWW0qTDewNtlNt7dOHhxJIIhFKa/B3b7m0zevPikpLAm5h2ifXHUYHw6vY/MPKjYKSD71cXHC67Q1DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6cE/ArqbPk0wCNVM3W14pIpZCkGwYM2E7xwyst9eQjR6DYDv4
	IRAlbYffBCCsUHxFGaFmL5XfOdLOvTCsKPK7mlKqMBRf1cnsuPc4JGA+kdDauAxRGlg=
X-Gm-Gg: ASbGncsUNKX7eWao0EWzqizYr15X5Vp1Q9NzQjMzQZLhfe3xwVWpfzoQhrEzuGpGR++
	4akfX2WFO5ztvmdI/9hRiFRy9BsdOwcoebpbjl2bI3KlNeqIeaTD65j5qKTvtpX0MfeNxHSKec2
	5kdzSTCFE/P1yvMPUW43xyykOd+uHDwgS5Q3fabtXbvPY0zUsfqUQfSmypCBtAU4fIphvN2zu/q
	fWeL6mb7gSS3FyN7Fetv0Y7/JYu/3bCCKxa7prh35Cd/OYffeJx918/hnG/CCDIaAEBxrX5MJ0Y
	3sYKV+Npoaaopaf/bFHn+x+XjhxcYT3LKH5PQUKa/YVuSmvIEo9HFPyVmPCusVDAbMOqk6at7R8
	b1n7LhoewEUO079qrtgqD/JlYr70oXEh9qsRueZ+K+MQKGvzHaxOPFeabCBu6OQaTJqEiYBSZH3
	TgibNQEyrbSb1KS44B
X-Google-Smtp-Source: AGHT+IENBm+sbHBZP8sKCFX53F0pXmzcEsrL3oVAqUeDgHS/EPxC04oGQPAKqUYSRNnCMVrGCIyjSg==
X-Received: by 2002:a05:600c:190d:b0:475:decc:2a0b with SMTP id 5b1f17b1804b1-477871e67edmr17544805e9.3.1762959779385;
        Wed, 12 Nov 2025 07:02:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477889be9a1sm15134355e9.6.2025.11.12.07.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:02:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 12 Nov 2025 16:02:41 +0100
Subject: [PATCH v2 4/4] arm64: dts: qcom: sm8750-mtp: Enable DisplayPort
 over USB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251112-sm8750-display-dts-v2-4-d1567c583821@linaro.org>
References: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
In-Reply-To: <20251112-sm8750-display-dts-v2-0-d1567c583821@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Jessica Zhang <jesszhan@quicinc.com>, 
 Abhinav Kumar <abhinavk@quicinc.com>, Abel Vesa <abel.vesa@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1286;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=CEg/BR0cwvUubt7wKmvcZpBYJWSSViaS4k1tDGeLsnM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpFKGZgloiB5z8Wsgzr1Yow0LPIkOoaluZ9a68n
 3x4mR/A6g2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaRShmQAKCRDBN2bmhouD
 1+51D/42Ubx4mQ5x+yvDt2GRYc5frR8p9FJ/0mrqW+lkuRup2kHaxcRxavznDik5eHfmZzqyxBG
 CwbbSp6+/FoQ9YGSThrLYWjBYtBVEeGQfuGvPi7icsTLbENAkbc1r+yY/698RC0qHpxrSMtM4jL
 cTU8k8gqY+6MAoU1W47GWeq3eh9N458CgkQAXvI2yORr2iM4Rhd2BQgfCX45BUzpuaNoMoQysX/
 IyF3YZyFt2stdXoiwD8ImA8pUd7KAlC3gNb97q6uq5lM9/dUC+r4J8rfboc8n8L2arsMFbz9x24
 3eaLwLmMUT2TuZpIEXshT34KfbgEw5OVRlZpIsnOThayAUapeHJ8sAkgDz1zCXO3Pbc2zpL5s8i
 gOhj4VeXNS07dkGUKMMnWdDaMMZqvMbAW6ziM9giqnQD1hFdhlXtQwImSSS+JZHJulKkSP/svT1
 OfbUp1gWTTzw/29YBg35QdPb/2vT/xAnMl58Jxwve5Zylx+4TJSS6xcxXYPTQrYduqJ323Uruav
 pWVcM3zsJuIPLkB4gx7FkZ5uU7ZpTQckEY44F75gvtIAcCF8wQW+5aqicSpmDFdnc9tYaZmqs+m
 ZEyGnRRmHxyiQD2/fGOoNc/HX27nfMwa5F/GLLKrjhu6K1zYtvmCSNhte2sRLzzAmTrITsCpioe
 5JRgAM2UdB8auNg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Hook up DisplayPort parts over Type-C USB on MTP8750.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 4 ++++
 arch/arm64/boot/dts/qcom/sm8750.dtsi    | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index a08bedd2987e..8d5a5d89a2ad 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -983,6 +983,10 @@ &mdss {
 	status = "okay";
 };
 
+&mdss_dp0 {
+	status = "okay";
+};
+
 &mdss_dsi0 {
 	vdda-supply = <&vreg_l3g_1p2>;
 
diff --git a/arch/arm64/boot/dts/qcom/sm8750.dtsi b/arch/arm64/boot/dts/qcom/sm8750.dtsi
index 11194b34e6dc..6584e324a163 100644
--- a/arch/arm64/boot/dts/qcom/sm8750.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8750.dtsi
@@ -2648,6 +2648,7 @@ port@2 {
 					reg = <2>;
 
 					usb_dp_qmpphy_dp_in: endpoint {
+						remote-endpoint = <&mdss_dp0_out>;
 					};
 				};
 			};
@@ -3142,6 +3143,7 @@ port@1 {
 
 						mdss_dp0_out: endpoint {
 							data-lanes = <0 1 2 3>;
+							remote-endpoint = <&usb_dp_qmpphy_dp_in>;
 						};
 					};
 				};

-- 
2.48.1


