Return-Path: <linux-kernel+bounces-875516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A972C19450
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8D715648F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A7F0325487;
	Wed, 29 Oct 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8iKZL/c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A371C314B77;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727038; cv=none; b=g2Ea0b9edgA0QIabov09oZ15A5BXobsUTAUlgKCHihl8Io8DpzKzwzaJxfEfZQxKL5/HDXfgJvLUg/OlwSa4nidO68vbZ4oZtTAhyh/WelH2YxBBR5JyE48odCCFVDLMZ8GxKeuWY+5ua8ZMHZ26ttzs6a/xbh4qNVaFIOnOb3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727038; c=relaxed/simple;
	bh=6qW85vJpsbRJXw1O0YT5oAnSuUBGMKsjU9actwwSC/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQJAtfnlpkjAY6pG7Br281sXoJGC23pMhZaHByWA2CLYR41JUWlKBx99Y55qjXans5XhPMurMpRxpjfQQCqGqVlEJkOd8vbMk74II/LsaU7o2OwGiomQEbSCttLcQRyFtgck0RiyYEVjySl0O0uYW0apiuH7DiWDdt/lSQZJcec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8iKZL/c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 400F6C19421;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761727038;
	bh=6qW85vJpsbRJXw1O0YT5oAnSuUBGMKsjU9actwwSC/Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=P8iKZL/cIwO0RM51lYB3A481gBJcA8zzScDjJZUCI7ptVD4V4iikdRzXdgDJF+NQv
	 LALPyM3SHe6qFxZUwyP7Ib8RbadQliIim8OAcEDxS/lm7Sq0PkbC/eyxNbWtuY3WVE
	 /Jjr34RDMpHv9X0jdpRKQDF8AbdOMllm/Lq2bdthIgdCB5lAwh2dCZcLul0Jm3hQRE
	 ZKaWung2va2PbE9QnrNXOB7Ii74k9dtX7T2OWksuGQvzWcN40wLsOmA+YROOW4wy3C
	 g7sLUx5MDEjvOr6xJM2pO4GGniurhckcxVEHeUMS/XFqmLYlxdWN4nG9f0QAUUkYPB
	 +/NackzOlaVMQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361BFCCF9F5;
	Wed, 29 Oct 2025 08:37:18 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 12:37:02 +0400
Subject: [PATCH v18 6/6] arm64: dts: qcom: ipq9574: add pwm node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ipq-pwm-v18-6-edbef8efbb8e@outlook.com>
References: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
In-Reply-To: <20251029-ipq-pwm-v18-0-edbef8efbb8e@outlook.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pwm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761727035; l=1234;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=YRF2XaROzhwVt/Pu0p6PQImVfL/oaIfrTBMqULFpuLg=;
 b=b+tdYlgh5p3xWcAR2IF0eHikC5VbtzjET/JgkRJKq/yVMg2MiwEi/UwFwyz4feZ3iaT4/fvhh
 4XHBb5sIWsPDvnUTOArWicqId7AhW4OtI/xRD2MsfGsEDIKahPiBXnJ
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

Describe the PWM block on IPQ9574.

Although PWM is in the TCSR area, make pwm its own node as simple-mfd
has been removed from the bindings and as such hardware components
should have its own node.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 arch/arm64/boot/dts/qcom/ipq9574.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq9574.dtsi b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
index 86c9cb9fffc98fdd1b0b08e81428ce5e7bb87e17..8dba80d76d609a317a66f514c64ab8f5612e6938 100644
--- a/arch/arm64/boot/dts/qcom/ipq9574.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq9574.dtsi
@@ -449,6 +449,16 @@ tcsr: syscon@1937000 {
 			reg = <0x01937000 0x21000>;
 		};
 
+		pwm: pwm@1941010 {
+			compatible = "qcom,ipq9574-pwm", "qcom,ipq6018-pwm";
+			reg = <0x01941010 0x20>;
+			clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clocks = <&gcc GCC_ADSS_PWM_CLK>;
+			assigned-clock-rates = <100000000>;
+			#pwm-cells = <2>;
+			status = "disabled";
+		};
+
 		sdhc_1: mmc@7804000 {
 			compatible = "qcom,ipq9574-sdhci", "qcom,sdhci-msm-v5";
 			reg = <0x07804000 0x1000>,

-- 
2.51.1



