Return-Path: <linux-kernel+bounces-768901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 924D3B267B4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4301CE0B80
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C25302CD7;
	Thu, 14 Aug 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjX+Tz5J"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A3E3D3B3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178244; cv=none; b=Sl1q+1V+FPzcaUlEzeotxMOT8HkcPwuuQ8begg8Tjvku6xp5t6Q5E4VOIoBvxIF05Q53lnyG4qKITjaG87D18+mxBuhPBTFgb/qCyNaRAeV2fJz7w28ILE5sdvn2r06kqc1qro2h2bnD1OnSIbav573tUqSoHOoE30fPio60heU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178244; c=relaxed/simple;
	bh=RyODLr4tfYQgpZQoVN1JjO56CVtyANQBLY/NQuvqZRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVltVtJ8b48Xnq3VkfnO3ocTNUvSAhWgmyjC95bTWcI5HmdsaKp4eDaCwXynguH0eZgXZKY9xXPSN7c+5v/3foAqReBmbxrDtJsupOfB194wy4klid8S3WVmaLwO7TkErIzAY3JPAHddqIiRG0R6jx5Tg/AvkNo6eKfjvbGPBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zjX+Tz5J; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so5972395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755178241; x=1755783041; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VUP8YT3BizT/F6pRuI1p9cYQKQzwKLKvSp0CT6xtpHA=;
        b=zjX+Tz5J/c+jQlE8JzAZy+ZFJhsS7w3GEC1LHthwxw1KS1dEjozyK09zyNkaEsrE2t
         lLyx1x4zS9pjxgC96Ni1ZT9043qIyT+WAgbU/LlPKnA+5c5yP1g1yV6HV4lt9d8ynQWq
         hsmc1olsV56d8SwJCHVdPEKeq0ns4nTm3q42FVZrOz9s+SMpmqSqcRr0UKquN9Kb8bsS
         zhDI2aMt3OEgC0r+v0OrmDAsNK2S+F788iK7Ne8h+wQYZa3Sf32Ob6O2UdpBnne4TlxD
         w5Zav5Bc1y6Mutcdd+OBl+SUyKFbPBdToS0Q+LtPj7T4FVgEEaqmph0EGa83HA8Eoou0
         nPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178241; x=1755783041;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUP8YT3BizT/F6pRuI1p9cYQKQzwKLKvSp0CT6xtpHA=;
        b=hs9NjiAuySGD2HvVDbPWNoCgt+jwcvGLEMSXv8XmtWNQZFeCEH16AvD+IQh3zZh9hW
         aJb84bTgaaVd9S7WMR0TTb68tA5edloWKfNmVCTWNSLQaPlQxUKHBGguLJQyu6rZop5X
         j9lfEXt+Rseo/V35V9vlKnL284Yuu+ygsoeF5AE1FpDdn3K2iYSkgKtlVa8KATi/21wS
         P1EWIDdpMd7jtI5QbabvSaRjEK/ye0SPo7vErECQ2Gw+WcjkFZdNEZvcqmVcWI5R+FtV
         qUPA4hG0tiz8M1nFXBrMpm2YbZ5qM2kKIeczFWIYVVg0AR0y5njZmOcLiOECFHX4fsdG
         J+MQ==
X-Forwarded-Encrypted: i=1; AJvYcCX54vdU+n7uAj/Z4MP/+trmbkl870oqZm9tEGJ+Xpq99elTCQMtHbGK4ca+8GMYxAZqW/VObi/39N1M79Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlJXIWWZfxWCCYZFbaAdzhnsKRLrp8var4gpPFnFnxwrpVhgn
	VdPgKnP+HQQVLcxexc7DWQ57WCWn80CMmbbfKUmigCajEHF/CuH0ifHFHj3U+3TeFoY=
X-Gm-Gg: ASbGncuRMQvf06s91sWkHApcNb1DY0W725GdcO2YFkfbfsUJmkMIPGYKqxhsagU7lts
	69hYewginQe2Oj0C4R/Q5hKa076AHN+y+yud2oHOcfbU5f8NjJcL639bXDuQb+OVzfIfTI41vlm
	DU6TrrPhrVjhVvU0KPZBp8+8w7FK+XZrnxgij+8j7gqlldRKh7acVKfpNTs34C+DW2Hfcp6hobT
	4I4A8n0976UQlXiO/DYDrAWImOQ/e+NqWMOEkyPCPsMhAlY1p8RCw4QkZDvsjONNzPzQRs+mMb5
	tjAm+fCp0TWTROE5G9Zeto2wET1GQpQ3DhzrHvoHRO6ydVg/MaKbOxnzFGJnUSGA1nkhAwMGxy4
	2oawCMyyxBJLsExG5xb9beUbvxWVLpEksXCiK
X-Google-Smtp-Source: AGHT+IF7LAjZCyCvOBTYMG4GUOkSm13ztgYqT1wBAfwRLo47Hx07Kcdhq9rvFE1i3I5vmK8VyDXcpA==
X-Received: by 2002:a05:600c:458a:b0:459:e39e:e5a5 with SMTP id 5b1f17b1804b1-45a1b791232mr25209425e9.5.1755178241116;
        Thu, 14 Aug 2025 06:30:41 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:9c1:e029:fc81:a800])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm21468385e9.5.2025.08.14.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:30:40 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 15:30:28 +0200
Subject: [PATCH 1/9] arm64: dts: qcom: x1-asus-zenbook-a14: Add missing
 pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-x1e80100-add-edp-hpd-v1-1-a52804db53f6@linaro.org>
References: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
In-Reply-To: <20250814-x1e80100-add-edp-hpd-v1-0-a52804db53f6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, 
 Christopher Obbard <christopher.obbard@linaro.org>
X-Mailer: b4 0.14.2

At the moment, we indirectly rely on the boot firmware to set up the
pinctrl for the eDP HPD line coming from the internal display. If the boot
firmware does not configure the display (e.g. because a different display
is selected for output in the UEFI settings), then the display fails to
come up and there are several errors in the kernel log:

 [drm:dpu_encoder_phys_vid_wait_for_commit_done:544] [dpu error]vblank timeout: 80020041
 [drm:dpu_kms_wait_for_commit_done:524] [dpu error]wait for commit done returned -110
 [drm:dpu_encoder_frame_done_timeout:2715] [dpu error]enc40 frame done timeout
 ...

Fix this by adding the missing pinctrl for gpio119 (func1/edp0_hot and
bias-disable according to the ACPI DSDT).

Fixes: 6516961352a1 ("arm64: dts: qcom: Add support for X1-based Asus Zenbook A14")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
index 16d045cf64c08c02c420787e000f4f45cfc2c6ff..613c675aac296f931293a1ba3d8506c6663bad21 100644
--- a/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-asus-zenbook-a14.dtsi
@@ -1001,6 +1001,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {
@@ -1236,6 +1239,12 @@ cam_indicator_en: cam-indicator-en-state {
 		bias-disable;
 	};
 
+	edp_hpd_default: edp-hpd-default-state {
+		pins = "gpio119";
+		function = "edp0_hot";
+		bias-disable;
+	};
+
 	edp_reg_en: edp-reg-en-state {
 		pins = "gpio70";
 		function = "gpio";

-- 
2.50.1


