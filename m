Return-Path: <linux-kernel+bounces-852261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA54BD88CB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B45264FCF1C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2098930FF1D;
	Tue, 14 Oct 2025 09:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ob4eJLwL"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E783308F25
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435202; cv=none; b=KfCg4BLQjQmIppttbIKD/2JAhkYz6OUxN8bOW8MZ0/4/kndbrRGbByi1IqCIET7HuUZ7FU47BNMEn8PIM7ZcenlHvMzdMtnLVRMwe1xcxZWjzElcJNlYO1p+DQZsJ0pcNQmcG66XNhtZJ+1lp9m6qWDPxBAxWQG4NKVYj3e9k8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435202; c=relaxed/simple;
	bh=lMgoKm6fFriFGTk58UsXdD/s6UE1JLiRxIhK+/XA3EQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Nl9ffI13DtYv6Ln/8Jc65CUYJNoP1Vk5DBg1tAIRF1Sw1Y4LF/UHe7yS8pYLKJXXysUMRf9Qx7YYQPyM9GaIavxYoA15a5zOKjQwsfji+pnjMwHLl71306k0KMTQqEHinOgp5K5YMKnDj5ey3R4YE39fvj2lN86U2M58RhifquI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ob4eJLwL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e2e363118so43447655e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760435198; x=1761039998; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xUaeped6AYTKx4zcDVin/2JtzA4/FqNOiGDU51UI8HM=;
        b=Ob4eJLwL1jy5pdRhSy987E5TWW35fjW5cctory4ljaIm6T/OVyYBzqaEBwf65aIFon
         tnFru3b/yIYBGGNisorW8FtjK/q1mmXAlmOHPPI5El/x6o8JPqiXOPzGttdHX2UC5pVB
         SRgeHMu3PFfLg6ubDEEKzlKkuC9OzOGZZ4DO2aAIoTkneiLzkj7fmXqE36P//IWzR1DQ
         n3inH0D6W4LBTDgLYQOJxod1DJSYnIsnK+QUjPVjDwOAywSvBM2hZpS69GDTaer1osZQ
         HKizZA8wEJuVgHFo/R/YHGMjPdO5r8P/cEIaoGMvPZKDDpMfCK34v2fMcQc7KXcWOH7j
         24rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760435198; x=1761039998;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUaeped6AYTKx4zcDVin/2JtzA4/FqNOiGDU51UI8HM=;
        b=g5o/6+lEUI0IF9MYh3wRusO/BiA/IOxUDLjLcyK8arJo+PBQCdxBx1D0U22ct65b+p
         QyqbIadBsPo0eZUbrO+/ksiJDIzyqIzqHEQtBi1n2xwGnffGyjDKkrb7Uh0aHxOQw2Zj
         kwW64wVYvYUt//nG7Sa1KqdacYUZqLfap6LzjcAmpi2DbZ3i0zJgPZNmLTeaEumy80Bv
         RNiP8ApUOdVBLjs7sNulLyrovydbkCSExg9qKC5byceNlBYN+tDBoaTK5RKFmWnRwuxQ
         ZXv4Foj7BSbKlt8PdRSqX3OQ109Gp7zDX5Ymqh/QZfFGEGbxq797ldjewfB9GUQpO3RN
         ro1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVW4MQ3Uk0a1L23kDfetLp124THYaClhof8eavUqYD3YzaqggmyKFKAUxMGzKOIR/ycZlZo4yj6dUQARmA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1j9dzSW8ETZvBXD62sqSB4SqtY1jZqkG9sFjyRLlWpgr0aKex
	1iqtvInqUb85bSMvxn9blSAYQSjgaEbwQkpw0PEvf0x4KpsdbDwJAPTaemPOfKbdUIg=
X-Gm-Gg: ASbGncvs5MIdTPZL6DJNfftYV2P4l9VE0JVq+NTBBEL0AeNLE64n9Pfl2O4qre97fUK
	3+4jmAVBkXtlyhQ3cn0hE49uhXJo2gNZC9dmxrOGreliHRUyay0GVxdriGkZ+zC85cc13Y5yTRe
	//joDvw+jDBdxdTsTVVFmnIOpsFqvNGj/VpOxhGblN3t6etAwR7wp337mAqm85uY75hsZK0XqV2
	IMCs9yKSWRhVMBdi/I6d0o2k35J2LciBsaUV8T3h7ALJEJ3akBeY1WoNKjv49DElJf8QxG/NZB7
	TndFbeFNvrMZlJN3o/UqIYiCmri70WoVaV9DkGN1am9zXxilUT/4W9j3+uCqGjtXJoauPhD9JvP
	stwNd0vsEq/9gGHmgW3AtbfgVsgUe8Bk9jokkKptwBNQECUH/dD5mjJyvRIjXTPYe
X-Google-Smtp-Source: AGHT+IHF94BpDjyQHISB3YpTos3ClDnO2QEk9OvNMWaiACfwfHscIkvvEEFe8GflJANQQTK/kZpUVA==
X-Received: by 2002:a05:600c:c096:b0:46e:2cfe:971c with SMTP id 5b1f17b1804b1-46fa9b937e1mr113989105e9.0.1760435198283;
        Tue, 14 Oct 2025 02:46:38 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e8b31sm22866442f8f.54.2025.10.14.02.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 02:46:36 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 12:46:05 +0300
Subject: [PATCH RESEND v3 3/3] arm64: dts: qcom: Add missing TCSR ref clock
 to the DP PHYs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-phy-qcom-edp-add-missing-refclk-v3-3-078be041d06f@linaro.org>
References: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
In-Reply-To: <20251014-phy-qcom-edp-add-missing-refclk-v3-0-078be041d06f@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=lMgoKm6fFriFGTk58UsXdD/s6UE1JLiRxIhK+/XA3EQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7hvpvtZYMOOjNeP/WxoC05ERCeQIn31ePA6ou
 KHQQL1n7NiJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4b6QAKCRAbX0TJAJUV
 VjkFEACACdNyGShHB0VCbqgl3wmaUbLAiFR1/ZnEk/ntbJYOWJBHthyNxhu6Kwq2S+xgChEcJ3C
 QZEC4bm0PJK353jPGQV+PvNWHLv5P4m2njVLdNctNau9asqqoyyjwwhOlGn4xS6Oi/p33yl87II
 +8CtFUZ7Lx4XirqFhNykxJ7QjgbsgZnMJmrRC906I9ps+TaOe1DtxTXP3sozR+NA6Q6nbz1YT1R
 4mhAmHzCiMGo+89DwZsUhkKIoVSrq9kV4D4p8Gi4tRwhTuGIpBl7bT5HLNOzWzaJwEc6B8HikTX
 rkpx2ZneYmmtu+UkRp6ZhJ5B0M7zuZC4TPxm5UGJUGtWYwv1MklakNYZLq5nfo/mi4Xa/zYwXbd
 nqM2eynJEMLpctZoXnC37DG4V8GMhsWIapXT4aXBRoY0gAZQbSGfS7nJYez4GewE531xVEB8ZpN
 B194MntxyQ2ezz9uk76VlkMua8dQkKf1IerZX1NIn/0COX0MfC0oxpQhWO8V5cjrg1lANTgKWP4
 h0zCHgiS76+ux8b/syakZ6yz609Ka34j1+l0QNMZHtTwOCoBecT8/AtUpzSi9w/9slJ1/q/Vx8e
 Mc6fUI0oevA6qCEEiUnZmqkabLH7VpJT17idYRfFGCazycy+HrDbGL7lQ/GHo1miGw1dPT9BU24
 j0PBwMhOV6uhIMA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The DP PHYs on X1E80100 need the ref clock which is provided by the
TCSR CC.

The current X Elite devices supported upstream work fine without this
clock, because the boot firmware leaves this clock enabled. But we should
not rely on that. Also, even though this change breaks the ABI, it is
needed in order to make the driver disables this clock along with the
other ones, for a proper bring-down of the entire PHY.

So lets attach it to each of the DP PHYs in order to do that.

Cc: stable@vger.kernel.org # v6.9
Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100.dtsi | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
index 51576d9c935decbc61a8e4200de83e739f7da814..0db5183cb4c4ea984d6a47987a1a165cacb3c4e7 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
@@ -5817,9 +5817,11 @@ mdss_dp2_phy: phy@aec2a00 {
 			      <0 0x0aec2000 0 0x1c8>;
 
 			clocks = <&dispcc DISP_CC_MDSS_DPTX2_AUX_CLK>,
-				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&tcsr TCSR_EDP_CLKREF_EN>;
 			clock-names = "aux",
-				      "cfg_ahb";
+				      "cfg_ahb",
+				      "ref";
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 
@@ -5837,9 +5839,11 @@ mdss_dp3_phy: phy@aec5a00 {
 			      <0 0x0aec5000 0 0x1c8>;
 
 			clocks = <&dispcc DISP_CC_MDSS_DPTX3_AUX_CLK>,
-				 <&dispcc DISP_CC_MDSS_AHB_CLK>;
+				 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+				 <&tcsr TCSR_EDP_CLKREF_EN>;
 			clock-names = "aux",
-				      "cfg_ahb";
+				      "cfg_ahb",
+				      "ref";
 
 			power-domains = <&rpmhpd RPMHPD_MX>;
 

-- 
2.48.1


