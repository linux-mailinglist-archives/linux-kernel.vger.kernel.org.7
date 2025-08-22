Return-Path: <linux-kernel+bounces-781512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B41EB31361
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0697A624043
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AF62F746F;
	Fri, 22 Aug 2025 09:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CRXox0Za"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86752F618B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854951; cv=none; b=fJGJYRLDQHb8nbLrLgf9j1c83vARE52iGuJcOB8v3TYzziMeOgqxRApXqgyMAWmo5uqvlCZUjc0udq6K5vUopYi9qYAAV//oBSbYma3SxFj4obNBRQhb64+3UaVreHHiHTThljpIx5nTjt962iyCuuE26MsJhV4WMXENbgL+580=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854951; c=relaxed/simple;
	bh=FvPs3wBirH9wf6cIhRfzmRxFdkB6syQv2ofYw7Gsrt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XVsnI3qySWBs8JMPJIxHpapFbyIVIRxXsEXjv5WKT0BWAFzO9qRsVtGU6vvDwRjwW5s3T+ECYZzJN0MEDe68nQHNwt2n4+GpgyfYsCyk9KS2wtf9jIzOU9Cn/wkTCGPW99OMpCM88ALDTsDALu/SyDt6TwFq9dTaCcf1oEonSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CRXox0Za; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45b49f7aaf5so11577535e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755854948; x=1756459748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZMxXQw8/LMF8pMRBn7r6Jgqr/TVT4ig4WiXL2+/Rbk=;
        b=CRXox0ZaTJ3b1+2NaCHIpkfyBg7O8Ke/lhPDcQQf9OtpYWrwwV/npFj77a8tt30vDQ
         vQiMzB5HyYvhtHSRE0aqC2XZd0ELSNoL8U8i1Nv9Ln9wiK1/23XQYDaNItQ4dH02XfRQ
         v5Pq3g32Pp7b+FivnNctHwCHe/vvE4CeVBa5UURGmFUUQGDZnY8hk/aOGH4WlIss/rLO
         GDbD7uzJZD3oQa3KVSicadfNhD27WIQccwsKB6BFzvwb3omzQRXD6Mr+FJofUCIDC304
         2/fAhnvzeFvltm4WwkJeBDygBkH93CPm+2BlJR2eBGL90iyOv5lfmmrxLOGCf6uZ8sKV
         RC4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755854948; x=1756459748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xZMxXQw8/LMF8pMRBn7r6Jgqr/TVT4ig4WiXL2+/Rbk=;
        b=H6aAbNdkQWTQ0LQc+QP4Lb3OT3r5cvezu5GG2r2jyEJXiR/bQM9IntnH3Yrabxo71B
         8XitstPzRJ2eDzrIiYQVc3D0HrL2Q/nOAbrQwoxgHTj+2HNqHQkplrjW641wd29JxLMz
         NQbr/OKCayYLcZOqVO6W3Grx6Q4vdnZrPsku+24nfxhmg7BN+TI+TflFMM5mj7Q/bbVI
         4jTYNPiWscECs6AnBKEuM9oE6uA1jV3Dpf5mBTlNP8UVWoTM5i3CYbiKJfyvEearlfKg
         O9JqHdJCzXLNpEcIumg5GxJ09BSlnEwzQGjhzhLF8tR2JmsKi7x0M1oLQbIji0FtkWvy
         Io0A==
X-Forwarded-Encrypted: i=1; AJvYcCUwEWLNIJqYbvQj/RtsneE1nDDmC8p8HUHfKAnYEaEjD0VnZRFZCgPZJnMZW0vY53cEwhiQGJFRQztZ/6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAfJ2tkwE6UXxOpd77287FUUpdgl5f1lfsOXSZBSrbUzQ8u93
	Norocn55XECFHdVMABQMZr4b2/4CPXaolLgSq0pRljKgrKavdRp4i49KqV+ova2h6rI=
X-Gm-Gg: ASbGncu6/U28nkSjqEvK8AeyyC/M/OBuqpZqlJLpS0RaeJ6WgiBJaNrM0Swa5iM6Wvw
	L3aCic4ns4EXmjYDSEmFx/Vk8OqSOeZTlKJcnb6GNb3spPHaOb3cZ61YyEjPiPJjbzg8Gq8dTe7
	owBNA3DvgckUtIFpeUr1jglRkfLmPoHn1Ce/9g3Y7SFa/CFl45wpYGxuku0oydE9ggktfnXjVy+
	83RNB2VsWnpAy72UbBGibeowXnhOt6TUxSCe2uzUmXEePxwUZfCGiwwFrRsrK1aDdvdY5GKEXLm
	rNCc8TtogmueFGW+WUA+PErZ1IJfVMSzELF3mm2yGXKNoFSCP/Tjj1d6xSR7nKK3NeLNMEYmIWQ
	vLKzC6j7QFLkNfxRAw+N8jmjwbWTeWBboKQrYEQ==
X-Google-Smtp-Source: AGHT+IFJ9FWfvS1AnYycVX7DAKqsbG4Q/IzzJ8xRcOcq/trFxgqfeNBZXVo51B4Eh2DsKIVTjFJTYg==
X-Received: by 2002:a05:6000:18a3:b0:3b8:f887:c870 with SMTP id ffacd0b85a97d-3c5daf01e82mr1443738f8f.19.1755854947871;
        Fri, 22 Aug 2025 02:29:07 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:c671:531c:f2ff:2a7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4e269d20sm33831805e9.2.2025.08.22.02.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:29:07 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Fri, 22 Aug 2025 11:28:55 +0200
Subject: [PATCH v2 04/10] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s:
 Add missing pinctrl for eDP HPD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-x1e80100-add-edp-hpd-v2-4-6310176239a6@linaro.org>
References: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
In-Reply-To: <20250822-x1e80100-add-edp-hpd-v2-0-6310176239a6@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Aleksandrs Vinarskis <alex.vinarskis@gmail.com>, 
 Abel Vesa <abel.vesa@linaro.org>, Xilin Wu <wuxilin123@gmail.com>, 
 Jens Glathe <jens.glathe@oldschoolsolutions.biz>, 
 Srinivas Kandagatla <srini@kernel.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Johan Hovold <johan@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
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
bias-disable according to the ACPI DSDT), which is defined as
&edp0_hpd_default template in x1e80100.dtsi.

Fixes: 7d1cbe2f4985 ("arm64: dts: qcom: Add X1E78100 ThinkPad T14s Gen 6")
Tested-by: Christopher Obbard <christopher.obbard@linaro.org>
Reviewed-by: Christopher Obbard <christopher.obbard@linaro.org>
Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 4cf61c2a34e31233b1adc93332bcabef22de3f86..76d491f085db2eb6ba8c8358063882611446ae72 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -1010,6 +1010,9 @@ &mdss_dp1_out {
 &mdss_dp3 {
 	/delete-property/ #sound-dai-cells;
 
+	pinctrl-0 = <&edp0_hpd_default>;
+	pinctrl-names = "default";
+
 	status = "okay";
 
 	aux-bus {

-- 
2.50.1


