Return-Path: <linux-kernel+bounces-730145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41593B040B3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FE9E4A2E94
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B391EEE0;
	Mon, 14 Jul 2025 13:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x7y/v6K/"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF1A255F4C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501326; cv=none; b=X7PjvZw2QsCc6lZO8X9ZfZnWQqDXFCM1VYarVi/Xq9a3X4YBXWENSr0xyBlaoHLpNz25GMtVqvWTFcuLSvckCMjux/DNfN2hRhHg5HoZFtkKZTYNPGx7B8rRj8cKxG+ZbQQWFDGe7hEt5+7/RjNGEJO15dwejat/EQQ+bJ8oPjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501326; c=relaxed/simple;
	bh=iNegukadm2V/oL15ljlmE1NK4FnQWvdihlwr9UrogKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IJ52DHJqXk4y9S3JLxShhO33pM0uBqkuOCjDVrWgddkyMA7N3A0hQyEaxK4589y5rJOtOg1Jmm2+JcPWfCXG9dDPw6LP0r8FUZOViptkDX5auDSlNdA0Tw8uMLlgp9DBt+JUKh90VSqcoBNvoWJ82em5sQEKE9UCW2zbv7HTF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x7y/v6K/; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-455d297be1bso864075e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752501323; x=1753106123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Beg+DF2YmVQjOrhC4X2EoLMEeo1VHCG9nawUB7v8jVw=;
        b=x7y/v6K/elJcggL4TAc7bllFQCbXZKv7/84FpKOc2WYWSFbQ/JvUZrbQ1rBrqMMoz3
         Nu1is7/zKaNGanm3DV6IVWY/xWhwV6xS5/DY+zt1peqPjUHydpKY3k5H/tT7MjEjb/0w
         PLu5kTPB7XZbO07kts2pb0REYTtJTCsLhvucmTIkVaZqB+3bNFnHlB4e/aMNo+Tpd8tq
         bgdr8AGDUrcufgB7oAWy6uA4E0TtV1wdonWqmP+xESTPJqQank53/H8To2IfleDNFM9K
         DaTdB2sFZvc8pkbhkfWirvA0PmeZLvrpTRNjKThKJIZ8x0VR3l82Qrpnd2CJzmMo0ZhB
         pOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501323; x=1753106123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Beg+DF2YmVQjOrhC4X2EoLMEeo1VHCG9nawUB7v8jVw=;
        b=jUbCnbjKu2k5Mrkhmo1vdTFAv8dr1rXq2tunFXGXyY+jHLIgR72qrONfOJu/3FiffG
         Xx9zej5/j+wGcybubqqTdEtp2ADxuCxN/JkMQURSWcBh3p9UhIuz85s64VjqlnUbJSPZ
         UZgcc/C0ZwZk8ggHEA2ns0LKq/ABf0pD3XWwe+uMsF6fTJVTOG8B74xE8EFAYElXhOyi
         msSXSMmyIy2z/kifq8+gw2Z5py5YfkkG53HaTI8qIqbOk2SjfGLCskpmt5G8UybwItXW
         4qp3jSNPu7ZW7HRuKdJbxKjHb7xmTtiBzu4j+mb9Rm4bKIhn0pJc7ko4qZUzkNqByDZJ
         oxlA==
X-Forwarded-Encrypted: i=1; AJvYcCVHu1WsXnnrHY3L2IkZrbPzvgncQ7GQ614Ukm0F6g+/vWa4kbZyizMfr1dkQZXtqcDN6dfPqSFO5BQ+DCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH5h2CUtvyUnxYJ51GWUz9LvpV60Tgd/WGES/+cEyU9lYmCuhc
	nhK1hW8MlbA+dy6wUxwWYZuSNUjby9QCkQdcOqi7UfH5J1fRbM4pW2dQgiX1Fn7emIw=
X-Gm-Gg: ASbGnct4bDFbspFAp9UtQndGXh+LqnBxSBKRKg6tcILJpCoUn1rMq1vKCDhVN7HdS3v
	APV32CYVoIwrhROOeGd7QgWu+6Pa9AgGHMC+WM+leInVcvuqXR3u56t0nSkX30vGzjef1c4QV+3
	HK6RAr69m+jUqnTcD/2hefJHWJiAk2Or3uv8HZ/Io0Ns6XWFUOXFBrgpNRtoyihdeBkyeHr6gN2
	t6hrjlcQKXLJ1NP0iQKuVOgYqT3LSMBWMwyPl/7hchvgGNiE+P6nldSMYX48G96U1mn99O/u5Mv
	N5hSY3i6hoLdRg/f2lGyhyXWsRwlObVHYLd815e1uzzUGmA3z8nt2NkNY4xvHeWIqarB1aDddEe
	UxjrRagioPIZer3+jpuD01tQNS0FPKTwfzHmQ
X-Google-Smtp-Source: AGHT+IFiQEBflEOZcKjk/ceATAsOHRn84t5qge6iYycptbGCNNwKBLw79Xaj2LSCBJVGB0ftHHOuMA==
X-Received: by 2002:a05:600c:1f94:b0:43d:fa5e:50e6 with SMTP id 5b1f17b1804b1-454f4278d1dmr49832315e9.9.1752501322594;
        Mon, 14 Jul 2025 06:55:22 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5037fa0sm172291575e9.7.2025.07.14.06.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:55:22 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 14 Jul 2025 15:55:15 +0200
Subject: [PATCH DO NOT MERGE RFC 2/3] arm64: dts: qcom: sm8750-mtp: Enable
 Iris codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-b4-sm8750-iris-dts-v1-2-93629b246d2e@linaro.org>
References: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
In-Reply-To: <20250714-b4-sm8750-iris-dts-v1-0-93629b246d2e@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1129;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=iNegukadm2V/oL15ljlmE1NK4FnQWvdihlwr9UrogKw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBodQxFi01pLo6NwbIbJmkTCjs3sR4XSmBVG2bLF
 HV0GzJahIqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHUMRQAKCRDBN2bmhouD
 1x/1EACRWvjiVD2PmUPQeW9M97dsDpnPILX6/3SYbQ22agTLpgmspeVhxxzteh+7ZtfBWvyzoln
 JZo5xuI+MOU4BFta29hYNR7LO+zhHn3onIGVu1tyo3u8O4hS8X2ek8+Szr0JU6Ip7OQ5+iTgeLH
 X0Zoe+QOW+hsDXUqken1u6NdjVx/jVM6UWVEOigpCdNJvzdE2aML6lNofhQeAPKnxOVKYZ4BIjM
 MhDnrvbnyoWHZY+5VL3/XMyXaF7t4sSJPvLoZWWuqpspah4O8A7MkMAbMUYSqaUAo0c1dOWpcAE
 2G8yXQLKXw4oZRkk0veE8kZMucuMmgtq2aCYc9X0nF8hOlnCpZt0gHVY6cD6bSf436CBc5QRCPn
 Q7raGi15K3yRGqfpCXKhaLQHwjtJ0HPh3pgRdGy1RwC9v0MjWHSN9ok7EWf7I+9wXlqgbHKhVtz
 MOB0sUvrvAN0ZPimaFLtvae71JV3/OioEAT8L1+4o8Yra53fovd9ImRfnzX4jkXRiGJBMCKug5s
 v+DLWy1mM+riHc8hX1m10pCRGMBrrcKCrnk6UwE35+QYAz3T4xIDDyaawoRSp2dv6plE+JwNRyf
 Ob/iLdisTkH3laVBExEhlkVeXzIK1ACz+pNfkyMR9UIboLJ5mHXtky7ovvOAGA6cHHy2lkRWTiR
 2m7/t3eqmz8zXtg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable on SM8750 MTP the Iris video codec for accelerated video
encoding/decoding.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Do not merge because firmware (hard-coded in the driver) is not released.

For Rob's bot reports:

qcom,sm8750-videocc bindings and clock headers dependency (will fail
build):
https://lore.kernel.org/all/20241206-sm8750_videocc-v1-0-5da6e7eea2bd@quicinc.com/

qcom,sm8750-iris bindings:
https://lore.kernel.org/r/20250714-sm8750-iris-v1-0-3006293a5bc7@linaro.org
---
 arch/arm64/boot/dts/qcom/sm8750-mtp.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
index 75cfbb510be57a1ab8cb3d870b5c34d3baa53c70..4c155b731a68138154f66fdb0d0e6db5e47adf3c 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-mtp.dts
@@ -812,6 +812,10 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&iris {
+	status = "okay";
+};
+
 &lpass_vamacro {
 	pinctrl-0 = <&dmic01_default>, <&dmic23_default>;
 	pinctrl-names = "default";

-- 
2.43.0


