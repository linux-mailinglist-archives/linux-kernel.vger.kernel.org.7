Return-Path: <linux-kernel+bounces-768905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C978B267D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:44:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99649E1761
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4BE3074B3;
	Thu, 14 Aug 2025 13:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i4i8TAcT"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8998306D20
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178249; cv=none; b=NFDfCb42XY0UDKQDO78u8jPoeR7Bhkc71ioti78JkbNHz2MJZUBZmAiZgygBqRdZ5t4/PUP0qKSN8W9EQEo3lwg54cBp9vJCz8cDBtals8YVDK5xVuhC4q3Ci+7RiZ3LfQ1RIA32/uvr4/RibLDZrrwxfcemRXZLAMQ1M68ycPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178249; c=relaxed/simple;
	bh=znQ7gVSuwvaFmfXTJN2s7CZyHtnz0WIQh+xOOE8QsFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OQS5So8A1hFyDl79Mt1IMXwiJM7L4YqSAg/BqBAf5fVPrmDSRH9k3fZwre6LPI/KfYfXkWTGpFm9TzQ6TQ3LYp/Dp9eWHUCJivvpKIfo+DvzJoapd/YiVpBSOp2tOiE1DC5NgFPsB8qD4V0Fh9I9hhkmlwYgPM9XTXaSj6CJHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i4i8TAcT; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0bde14so4710905e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755178246; x=1755783046; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0cwBy6Ky9emn6674S7HsQ1ClNw2fn2tkOaPVrQns16Y=;
        b=i4i8TAcTm/yBBu9WfQAjttHHt225kn0EhEmpXTds34xcG2FrUeSKtXi0yfjvbn6Qwv
         4hH4gCEm4L84OeI4D735R9XYg8Q6PfQr9LltAQxieCi7dVrmPKKkPvt91Z0/ToW1e6xY
         ZBX5yd/Yh4FFQ7ZAQ3X+oSbobwqV+MDQq+yNLQOKNj03J0aaSqcjQjNYvNirRwtoH0Vc
         DfXX7vpqb3K8Jly5/UZDGIKMUUJ3Qp5N9dKaD4BbIsbsvH+4gbft7hbT5FC5+O5a5U2O
         0S4w/JhxGcnpfJElZlJiyWfQD2aEFTXZKilSoostuhZHbq3rir+Ac2CJpUWN3EQzRxCF
         T8WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178246; x=1755783046;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0cwBy6Ky9emn6674S7HsQ1ClNw2fn2tkOaPVrQns16Y=;
        b=gTH9gJG9hiDviBAD931M5TwKa1rWrtoazKuUcfK2oDDMaIQUcKZJ+wxMQzdI3F+gw8
         8EI1yPZZZ7bq1B2PbUT1m22n0B6ySt7ZGL5NDjI0VtVkvNT0pIQpF46+cFXGvR5tR5Qy
         OHnPaoW+g/glVfT+jqJruQKekHzWXI4Akhy8qyNilRiI3z6F/9oILH/AP4AVv483PeKc
         BYtyJwK8EO1UKaH46vdtOr3syclyoCCHu+mXw8F9HQAA7iwE8i0Op31aIxrJAj5uHmTQ
         2/B3NIaLPa3mFKEWaeMYjTyCMRl0E8Lq7Y1bacfe/9Au5zON38YAPA0h0rK0qF20vq4h
         trpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6PFgx2tnlM5yTAgMFTiKR0oW0kcbaXr3aShzj8aJm9cB3ejzp1jIWsXmoJdmVkvNB3rZin1sMtyUfwiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRnBUC7oIqNDLlGvMNSXDTiCR9S6+Z583nwKcCV4x6h7vNqFd
	EwDZGhHtu5dQD5VT7Rv9MbrnXsjGK3JIJM+EKUa+OEflLrg59NT5kjeW2NeGvRwvIT4=
X-Gm-Gg: ASbGncsF+F8SyQw3sAr6QRjxaZ9lNYwtuqBL14Nhjz5uaaFBGOQY+xvoriHYsudZ8nB
	qUut9MR2fxWseu8uUEu2q+pFv2RWJWqmNYr5Ce2J9YsuCYxDAXkfXN6bQg4MR8Oc+PDbUm8frRQ
	exisBVsq1dVShBO9FMW2c/8L2o1c0T9NrPK+BlI/ejJAoHcti3v8Yp+s9VaYDqhAl6HrvB1pgCd
	9CsJpX9Dy2bYx0jzqPwac5rr9NAJtUctVhhYgfAvZ9hMlhtiAER9uAlSqhV7Do5DjDwFMAXs5L9
	uBTnQtgVRTiC+4qO4sh80o/MFH4mzVYWhDO5Kp6tvE2gGZJMMb2j7DykbqPwTrmFzKLFTD1M/Kf
	RjbcvGoZztG2nseFhMZVhmFZMRZGVgoUYj2vu
X-Google-Smtp-Source: AGHT+IETd818n3b8dsIfDRA2rMYZ4tfdJVXGsvoq1dwVvSh2Aexkw7PjMywYOPDX61Ol3IkavJaK2w==
X-Received: by 2002:a05:600c:5309:b0:459:db69:56bd with SMTP id 5b1f17b1804b1-45a1b74882cmr24060075e9.20.1755178245701;
        Thu, 14 Aug 2025 06:30:45 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:9c1:e029:fc81:a800])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm21468385e9.5.2025.08.14.06.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:30:45 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 15:30:32 +0200
Subject: [PATCH 5/9] arm64: dts: qcom: x1e80100-dell-xps13-9345: Add
 missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-x1e80100-add-edp-hpd-v1-5-a52804db53f6@linaro.org>
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

Fixes: f5b788d0e8cd ("arm64: dts: qcom: Add support for X1-based Dell XPS 13 9345")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
index 6b27067f0be66b5c41fa681ff3b4f535100bdf59..6cb98197eb9c0d6e171741aa83e7f4ff77e911c9 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-dell-xps13-9345.dts
@@ -900,6 +900,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {
@@ -1080,6 +1083,12 @@ edp_bl_en: edp-bl-en-state {
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


