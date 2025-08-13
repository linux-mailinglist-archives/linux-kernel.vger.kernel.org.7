Return-Path: <linux-kernel+bounces-767081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA05B24F27
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD495C500A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F150429DB77;
	Wed, 13 Aug 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a2oX0zyN"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DD299924
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100792; cv=none; b=HfLl0PJLl4Jp4TJQZGIrvHVx359FdzQgrYnYo1XTVQM6YsNcOE4ZfdCpL0ojFSVtxsvilGWLasfO5inzwGVospIdX27aEaUmW4PEXHE50F8Xw+HzaivIzErYiAnCyZucudU4f2nJD4mHEVaXJxsamoEeGklFhaTP7f4ANB74DQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100792; c=relaxed/simple;
	bh=TxT3XP0xgV/7aiaCGEZotGL6QqLvbEiYjqpdnjAJF9U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a4WD7+FBxZxNTjHgh8PdGGC8Cg5abuQ0FG4igIzlSb/paf2SmO9cThUjOxv78nvBw3HpJc8l//lqpsBe+OJB5R53vJDhjuzc+2UUVSMOstq7wi4MXk0Jts3CKtHkBes7M8MUmvabwXPKvc7I1ocQq0XRSTAHl8+Et36+5ov0QQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a2oX0zyN; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b790dbb112so4144378f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100789; x=1755705589; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gmDU7DO+okib6EqaOv8JzKdmguaiibmXWYxBVNPq+Vw=;
        b=a2oX0zyNWUwMKpQPXC2C9x61u+CovCN8Suthzpj36Y6vXWJjzQSJMSheJB7JEetOYs
         cTQSuWIpMQdRht0zYDOAQfvusBFp+U8T80OAjKV8ZHF+wug8RY8ogCYK3nde6yJII+Nx
         F41EAO4/gvFFbLmycFiJuI2Ysu7TJyEoRdfYYuBBXb2kK91T3yp31HW47Iap8jfIla0f
         D3576sAAvywp0wFzmcJVsWBfBwT61lwH8cGoouc1+WXPQEvdZ5teNZgPyTB+95bden9Z
         FoHI+ei6NFxDO2CU8mJ93dYaX0Dar9uT9GbrQo8Klg69Mi3d0cGAH8B9SmHItakeJJlA
         JJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100789; x=1755705589;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmDU7DO+okib6EqaOv8JzKdmguaiibmXWYxBVNPq+Vw=;
        b=MhCaMSxC6V8NAn+AE0kxTDgCSgiXE2xiJNXeJ5VuQr8HXZIHUaC4IoQkxpBiAva3vr
         L4qiw/ybQtXmgmybdNhTkqNQi7q8/COT1f2qb+Fhbp43QuK9BlyU00o60+1RtB3Hphgm
         IgesSRMg8ji3wm4dSIWpaNvFv9VNFkXLdddvP8PClQwv2NAIiujIz7Zjz/LMBpFLZnwK
         uYorjmUd1NNOWg/h24L5jW+mUXC72+GxMlC2qkk/Wi7M4/oLnSbV1N6MQUVYQ5aC8lZo
         rwpkXB+lw/XO88JNBVklG3cl/KQNTOd9d8ddkQLjwK+/wpuGHKQpfDnPY4OYxiAND2mn
         S+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCXQ4/eX0fwLkfQntUx92JM48bW3++G8MLMD7NQDdO/B0LACY16ZqBt1B2x3KJ+Udw2rlYCs+UmG9Qk6kms=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7ljGOdQUVTqwxUO5xKGG4kDO8q39D1KJd+gxyo9Yvnoj0zbPY
	KyZbYh7F1qmodN5XXw62FnrYOMvMu3NxVKm/0TXern8OTP8yG4jtWRu0ccMotcn69bs=
X-Gm-Gg: ASbGncvphL3klnl1CDptEQTboiplhH9oL/z0N8EJ2jlyHIb50loM7EhNuitwlhnye3P
	4ry63FBFIoXqN7HI6wECxohXgIesrFmJpCje5kizezxJZcq8ptJt6/5XKZmoNJns8kEXYDtx9yZ
	YnU9c58baNmcqflIEMxUafHXDa5MtWhUjF8ppS0g0luzjWn8iIkSrjHeJMjteHloBiwsDh9+5Go
	HtLek/MzulroKAnlUnc1JD+mob5nNC/V28EEyVSfyqkzhFLWC2KiUgDuMZqoqNHEIvPec/RDkyw
	lICuzs2AkrUxv8Kd3dstN5o/LASc/DM3JB5EO5we+EK0bjcLOeffz0lRhfhKJSvwZGpQgP983rw
	n35peTe/jsZl79Ny9NsekZQ029h+5h+wE+4UpUw==
X-Google-Smtp-Source: AGHT+IGhrwunR/U37K7KdPqHpQqbqeIaJFvnnvKHfM8rmssepuAqgduQ9Nj4OZ/qYOCx1rDOdHejmQ==
X-Received: by 2002:a5d:5f8d:0:b0:3a6:d349:1b52 with SMTP id ffacd0b85a97d-3b917e3918fmr2952191f8f.21.1755100788652;
        Wed, 13 Aug 2025 08:59:48 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:4537:5d58:c08d:204b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a517c26sm7087755e9.7.2025.08.13.08.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:48 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 13 Aug 2025 17:58:59 +0200
Subject: [PATCH 2/9] arm64: dts: qcom: x1-crd: Explicitly enable used audio
 codecs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-x1e80100-disable-audio-codecs-v1-2-af82d9576f80@linaro.org>
References: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
In-Reply-To: <20250813-x1e80100-disable-audio-codecs-v1-0-af82d9576f80@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>, 
 Johan Hovold <johan@kernel.org>
X-Mailer: b4 0.14.2

Currently, the macro audio codecs are enabled by default in x1e80100.dtsi.
However, they do not probe without the ADSP remoteproc, which is disabled
by default. Also, not all boards make use of all the audio codecs, e.g.
there are several boards with just two speakers. In this case, the
&lpass_wsa2macro is not used.

In preparation of disabling the audio codecs by default in x1e80100.dtsi,
add the missing status lines to explicitly enable the used audio codecs.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1-crd.dtsi | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1-crd.dtsi b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
index e3d2fc342bd184473b37882f3bc4f9c4d23135bd..21eaeeff3ec3a668477859c466176ff1d1e0d82c 100644
--- a/arch/arm64/boot/dts/qcom/x1-crd.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1-crd.dtsi
@@ -1114,7 +1114,13 @@ touchscreen@10 {
 	};
 };
 
+&lpass_rxmacro {
+	status = "okay";
+};
+
 &lpass_tlmm {
+	status = "okay";
+
 	spkr_01_sd_n_active: spkr-01-sd-n-active-state {
 		pins = "gpio12";
 		function = "gpio";
@@ -1132,12 +1138,26 @@ spkr_23_sd_n_active: spkr-23-sd-n-active-state {
 	};
 };
 
+&lpass_txmacro {
+	status = "okay";
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";
 
 	vdd-micb-supply = <&vreg_l1b_1p8>;
 	qcom,dmic-sample-rate = <4800000>;
+
+	status = "okay";
+};
+
+&lpass_wsamacro {
+	status = "okay";
+};
+
+&lpass_wsa2macro {
+	status = "okay";
 };
 
 &mdss {

-- 
2.50.1


