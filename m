Return-Path: <linux-kernel+bounces-768903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE1B267B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 770A11CE1AE0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4E5306D25;
	Thu, 14 Aug 2025 13:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WM/5un6e"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484F5302CC0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755178247; cv=none; b=ZjqnOg1ZRP5R+1BD6ocFQaf90wVKbhToztn8nkqX4sqhLWRhQfVAVZr02z8eSrpazX5//O2SSV14bX3NNDqpJzyxMeFnU5EYQRDWa7V6dgwisj6p9GJskv5LRC5zySNN532iX6R21bXeYBdMVCy/kHN9zLAPU6T1NorCqF72TCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755178247; c=relaxed/simple;
	bh=DdmaG7ehVjESVEvapkg0MYfay+O+SC8wve45b9Wg3/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G5uXU2jvmVi8VSuhLpX1Nkq2xz3I5It4lC/ynpTIXzFtmlBQWFO+O3+1sqMAhvGyGMDUzVtLcldvrKC2RKwOW5AJ5q+67NcUrB7DXyNseDcRf/u7Tar2ah0bug7CU/iBC3gwjt+2LuSJQJCe9eMXBC4K90h98Az0ndf1aMgAG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WM/5un6e; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45a1b0cbbbaso6391705e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755178243; x=1755783043; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xO7OyOIjZ2UD4IHxiiLEPx4FR9p4ANXjYYZCIW4sH8Q=;
        b=WM/5un6e/YNZZ0QVIrPiVD7B/pmEf9nj/2nE5A/Tcxw3QJj38cjI8aPcHmXJhlYSCT
         Zoz3R+6WAQC2IDg5VDnv6HWGFTsI9cR5LSMpcwkTmmivs634DQkzzm1sPqcwMZHulKxM
         1ttcBFvYL0E8zTSAFjJQ+X1S/i1cGHXXtnAX9vmj7Hv1EdXcf2IwfmSMqBtjX8Rat1tj
         10ccHXJbw95hWJqwBKcT+uQpNKBHYq8bLJlzHjQ188ayNTpCm0M6h+qPfMItNUsvro4f
         0vr5wTQNB9O+lVRBMoUyoE/Re+ohOoW1LZLhYkf0KBymTKl8Q6nnFwO6pxvQxDxV3RD7
         yDMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755178243; x=1755783043;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xO7OyOIjZ2UD4IHxiiLEPx4FR9p4ANXjYYZCIW4sH8Q=;
        b=wLBPUlV/ff0e9SVlIgAqL1aw8//wBkARLxGn7KAqWEseidtR6ENPDIhhDKgYTey7vo
         6S6N3FyhVzVj7wI5HJ3mkS82M5ZKkQMmfNIFEV1ZOeZqvVGHOKtHncqTbEsB7opZYnpH
         qtAq5fZWnTrVnQ5/pmHzNKIYTATD5USOId0Bev3+SVuBV7RRwmcvsD+VWcZhw6SbROx8
         CzwOcqOROd0iwOGyw1qWXiG1x1zuhAzA1ct9/2cnwpaVfK5mt3yUMos9Kc3iTwDyvgPC
         ylBzWEWMO9fP9xJ+HB9+wXhbXoh+Jf3/Hn0+gMuHQ3dz0/JMUy3JPWefttkjWb5OToul
         rBtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTi1/gIR73CoFe2QOcKRAum/mU1pHqKScbNBZ0E+8/mrv2E3aOcWha4vNePGmWXhXZdJR8pnfykhFoYWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy201K/aMF8aQqkJZv6f2zMMPgKQhfGgRB4+bJAVnRpw93kSG58
	sibjG6nVcILPP8QX1LdUqYKEz3xCu2T6aTk3KVeh4zTYi/aPHb9en8MNj5MzErbbTXU=
X-Gm-Gg: ASbGnctEIkhFwQnTsQtoz7pRKdVfuCVrUD+yUDltdT9gwsaNyjla5u9fwoFiY6+SZW+
	LdIAWAMeSj/RU37d0X7n1fSrvKGTFCCF4c47DIf98YORWoI6vb7W5Q0vg3N9eCL0GC3mhHrjTSU
	noca7fHv02/zgT8zSzMH33XG//Py0OB46iNi4BRjgR+UJnvYnkuOd4H8Vu4CMsBDaIjAQPZGl5Y
	59JYFTEJwukSUMfBdd1/IS6INDIXSUsyVILa499PjrL701iyKdT4jHj8aMdP6CqauJBJ8Iwxlcl
	fM5FkntGg7NmI0ZnNQ4BcIprKADL/m9TTfuQUMW1X/16JOYzQx2ZIEjbeXWXJWA7zKUqXLu9Vhb
	2FL8gYHBn3sMr3JdTEnmXAQHPp+nKc/ocpFsb
X-Google-Smtp-Source: AGHT+IErG9lWZOvLzZHMGjaWUJqrantKmVyUgoNQhEzIXeLjDvvFkrGyYX3YexiBqjoDQV3W7HBtaw==
X-Received: by 2002:a05:600c:458a:b0:459:d3ce:2cbd with SMTP id 5b1f17b1804b1-45a1b61bdcamr27554675e9.13.1755178243488;
        Thu, 14 Aug 2025 06:30:43 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:9c1:e029:fc81:a800])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bc85csm21468385e9.5.2025.08.14.06.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:30:42 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 15:30:30 +0200
Subject: [PATCH 3/9] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Add
 missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-x1e80100-add-edp-hpd-v1-3-a52804db53f6@linaro.org>
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

Fixes: 7d1cbe2f4985 ("arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6")
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 4cf61c2a34e31233b1adc93332bcabef22de3f86..b775110bbcaff165cac259cacc7509a64746b987 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -1010,6 +1010,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {
@@ -1263,6 +1266,12 @@ &tlmm {
 			       <72 2>, /* Secure EC I2C connection (?) */
 			       <238 1>; /* UFS Reset */
 
+	edp_hpd_default: edp-hpd-default-state {
+		pins = "gpio119";
+		function = "edp0_hot";
+		bias-disable;
+	};
+
 	eusb3_reset_n: eusb3-reset-n-state {
 		pins = "gpio6";
 		function = "gpio";

-- 
2.50.1


