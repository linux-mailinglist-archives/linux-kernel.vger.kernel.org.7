Return-Path: <linux-kernel+bounces-768908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F62B267DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5DA4189C794
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59283074B6;
	Thu, 14 Aug 2025 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kVsCbUDH"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873013074B4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178252; cv=none; b=Cx1xReh0vwzo4fxOdd/Fi1y3XQL/Afjl/FwSDgc3VBSzItrEBNqhqZGpzFbx1SKIai7q+OWl2pfHsZ6Wg0DC6qIV3uIlN+SMBGsu/CabAS2j7ZujjMCxzx7Yk+8gcVy/UbQGTZUvjsdXkva9VVsaNoB0aePlhJPDJ9gVzg7oVb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178252; c=relaxed/simple;
	bh=tscxYaT5sQKtzcTlzSXCHSFfEbjIy4+squBwe4MgATE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NELS2bvLCzv5K/5hhti2SFt9esFcntu3Abx7oTV4gVK3NoIahJb7kvMPyx9knOeGxwWETSqEhSkBxBy5wKU35OiiDVJ0s5m0o9L/zi1PzyVTVvZhTUq+cZUU6M/sCc13ACw8cu22ZkOeCqZTSTZp0C82qrCLXBu6YOHzpz1xIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kVsCbUDH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so4933165e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755178249; x=1755783049; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MzNjOlUyysYS3PhHwof1q4yQf+nXA8uaGo+GPuNkhNQ=;
        b=kVsCbUDHD9241vQe3ReAqxtBsn4iV2pfnvEEWECDT5VcEnFXSzUIbvz+2Es7P+XMRp
         YdLsdAeiL+6BhF4MlP4phqhfSMzkkAFZL+FLhYGyzvBDQ8yjFdiL73/1ICIilxB81lQL
         ZyHy8vv8ULFV8tr0SXeJ77mB86z/ol6DgLucFIbKwbxP1Z5JePQp/tGsPcoMA5Q6e6e8
         ahnsaSi8C45D33+qBK8lDs1UgVRvOmcN5YoqW4cm66LNNPjCfxOLKihTF6GzXoH053q2
         EWUbakpdd2TOgsa8P45YVYgxwYD/x5SIZ1g5MYgpRDCYd0S2g5jnsokczUgbPiKKTPKr
         JxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178249; x=1755783049;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MzNjOlUyysYS3PhHwof1q4yQf+nXA8uaGo+GPuNkhNQ=;
        b=i8aD8K6csWsgHLrW+eNWWqVmj0NbzOLGEv2MOzGwZpJYkBycxzdIT/PXf0mv/njJOU
         nxKnfyheALGfIJhd3xTasZTgQJ+70CWSrLCQ6QmuMzlZ5lqpSHDd/HQgrFVYhGFPIVrm
         dg/GI9jyJVl4hhfo5rpp0tGdNuBmO+GXvdBNPCWDAeHTguf12D2dS01lcgDasGOKY91n
         IST4Lu7YdebpVSsMd6hAiaHOGDZMFVi37fft1K8f/5TPdb8GqoDWTbkSofwRvBZqYBvr
         CKljRP+dm3AzYiK5j/ZBqNVZhLpLMmC5hzOXkXYbov46moF+3xTtckBCUxS1xyUqeIcN
         mR/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUoKirIJQeUJH+rMNAl8B9pssBEpswnVouY03rada1YCbIutjwX2HEc5Qt2kOTaayV0wPnezdMy+oFkk3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNua/bPPe4LT82PYiCZYj8Si2eaQy2sM1d6b973oOfVGeUz+MF
	sergARGKnISZEsdxDZQ1lVuZyEuXE2Ktf+TNaogMwSzLQf5Dz0t6Marb2maHK38gcbA=
X-Gm-Gg: ASbGncuN4VtyFYSpI+BnqhE4RNM/snOZ3MJEVsTbauPIKeTyP4yTvWMedpbN/1tsRyx
	UezYElafOPeNFd22ErNOSEz99EQU8kBc23jvmrDmujFC7svaAq9ihPDCBNfSiYqAtjX1iLJl6DG
	/YZVAPuzTq9KOA1vX2LOGmx9WgQxt8VKMRlGT5AIhXeRwG0vPrAhQpYJ9nTLCfaz2uB/EvPtjFO
	PfBbIHxZee6MDrE7lR1QjjYoVUv0yNefXGOyxwAyc125jaxbBYQZ6012ilHdDFOzhgmp+1hQtoQ
	uf5NAlfIRJSRxGZvsmq1LLl7jw/B5hM3AF2RMOYey0cRTnCPs8XeHs2Y9tFKV4eZgekw/KOet3r
	qAsO6KiqHz916Aaw2X620SEXFNqU/DjVnxRQk
X-Google-Smtp-Source: AGHT+IEIcfJCRbuIKrMKbYAGTbkrNvpfBWo/E/Vya9pNleHIQWRDX1hsaRNlAs/0t1QyLv3P6Cp9TA==
X-Received: by 2002:a05:600c:548f:b0:459:e398:ed80 with SMTP id 5b1f17b1804b1-45a1b66adbdmr22545165e9.32.1755178248798;
        Thu, 14 Aug 2025 06:30:48 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:9c1:e029:fc81:a800])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm21468385e9.5.2025.08.14.06.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:30:48 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 15:30:35 +0200
Subject: [PATCH 8/9] arm64: dts: qcom: x1e80100-microsoft-romulus: Add
 missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-x1e80100-add-edp-hpd-v1-8-a52804db53f6@linaro.org>
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

Fixes: 09d77be56093 ("arm64: dts: qcom: Add support for X1-based Surface Laptop 7 devices")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 27dd5e4e9939124360544ee9c59900ebb01f3f49..688db57a472844fccb143c45ecf66155477286bf 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -965,6 +965,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {
@@ -1207,6 +1210,12 @@ &tlmm {
 	gpio-reserved-ranges = <44 4>, /* SPI (TPM) */
 			       <238 1>; /* UFS Reset */
 
+	edp_hpd_default: edp-hpd-default-state {
+		pins = "gpio119";
+		function = "edp0_hot";
+		bias-disable;
+	};
+
 	hall_int_n_default: hall-int-n-state {
 		pins = "gpio2";
 		function = "gpio";

-- 
2.50.1


