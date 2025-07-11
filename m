Return-Path: <linux-kernel+bounces-727597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B778B01CB7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E0FC1CA7100
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B652E7F08;
	Fri, 11 Jul 2025 12:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ds023dpA"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBFC2E5432
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752238698; cv=none; b=q01T7wciHWNaCPtQWRM4cQGBKcnhDLT9N27qBFgILu3iopVelYBj+FFU8X0hX4NVFvdCfGzhUcIUK3PNvkk03Q3zbdoZGIQ2oTgUzh3RyO/LlJAqC4rQOsFGS/OLW2iWiAH57c5dz9sMGDFGkEGSGxRxhL7GY4OjNb6VofYXEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752238698; c=relaxed/simple;
	bh=uSDaDaav64zb5yYxypWWibFdUxaoPe5jKMH1pUZLk94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=keuBEJVWsHFJnBwXJNlqiJwimHyfNSINIE5/j2PT8dLkkdGkDt8z9kK3K6rX5DBU7mktiFZStz3G7Qx+V5R0+6had96PXA84QmQG/CJR4OnypCR0dnphRNlyntMnlAbrMhMcDcxIyjF6wxX4BJ8Uf9h8UlwIaBn7c1+yZaFXbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ds023dpA; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a53359dea5so1246718f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752238694; x=1752843494; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dCX8cXoRpgVx4P5Io0U7mbR/WruUP4Knm+tOtVt+Hmc=;
        b=Ds023dpAjFm/8I06Fklf696c9WE0RAVjIBUQ89HTFkasW+08G8FoeyDTAVghoEk+NU
         iofxdTu7cIgp0zOiTVQJY481r93Nhhd9jUeFN4/vtN9+MRQ7bV7RJng5SLXiEKSBxaGF
         qHbgxTWf1juZZnYmiT+BrHk4nJgDJIEkmxTUkWvTuZKCQGhp2kxo8BVaPsX9vVqLOBee
         6CTHyeUinLiMm1Ub/s1mXAeNwC4Hx/+nIxZGdpI8gvI8qdSi/BDDirJWyBaFcusQjHuC
         Ckm8JarB8u8j+pxroTijwOa4GfVhK8uwXBeuBMRXWJq32VK7g+UmQHP1yN7iyigqpYFI
         XhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752238694; x=1752843494;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dCX8cXoRpgVx4P5Io0U7mbR/WruUP4Knm+tOtVt+Hmc=;
        b=L4P5QNc2btcd3Ia3yGvTT0ad5JLzBPghlsR3DMOth05l3PK6ZvJ+8yxh05sdQF3NNH
         OVZCgsKvRdTIWbbSEZyUT0pOcYVIy3VxPg67c5A2DDBK9G2OXQYNDOHVoIiVVODe1i8I
         sL2Qk8tu1+1Ae5FWNKI2/QcKPoAl0Xi4Kr1TTjDfwjNokR9N11yGLAq/Wi2FnBbAOWOM
         vrNyJGDvGguPUvpWIAZ7ly7ZKuz9zWR9L4LJxQDGOXMGrFjetXd2BV5EbKtyDrIE2zSy
         6rQCQ/lLBP+ZjdY6Wz6Xs/UNHpfPXF8fV29O+bHCeIXBPTZ8VHwQG+MVDBFX4WYz0FDz
         F7QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI4HEtMcMhrF4aIBRvobIWq2bLH9U2I+bPG28O9/NnHSoUhB8flWZ7suCfEkmWSVA39nUjNnGSF2I1z8g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw34ACBdCfxwMtoY8HAs5lFfQ+jovhCfa2bZGYdh8NUcVjxU+WP
	JZAc2ZCHomXutcZESN7j2fCQ9VPDlojBLWjxbq2VfMSJsCNHE3TVEumIE6hThEAXonI=
X-Gm-Gg: ASbGnctj3Lz7mq2S6rJuHbdXQGWn9f+Ok8qHKvWH6BzMl0S1PlkC1y6/eG+wnHN2XK2
	C7e9CLwd0//gynj4LG7PovFqGbF8RaAVXmuFdRKGZJkIta1XcKl39dJMYa5ddMTZDT4YmdjKjXA
	P8uWgklY/kDzFd/cxCw2sOyGYxEVahjVbwawzm+CTKUCrRDcnyOw8Yww0f9VoQbDTrlfDLKcTL1
	Tdff64nkQ2IUJVxGlopSkwNDsDQwZ/QfK+vpc13KRmfB/2gmWLtnNpIJVik5kHWvkpbn8NGsHdY
	zjtEyHfgm+kK+isfM5uYobgFnjAdBNZE0Kfo6vYsm9RGba6u0yt4r+O5oTgPehw12iliHFyq6v3
	YHD++yJY//ynl8R1WViRm4Zj6BUU4f5z2wL0VgzXbzwAsKRKJp/SNFPnp6cZqZS50
X-Google-Smtp-Source: AGHT+IHRdrwIdEYn1uWxB8RWx/mQy9xRQiWitmMhrYOydAjTq4r03EUNHWVCdeBVi97TcQejktiaCw==
X-Received: by 2002:a05:6000:2913:b0:3a4:f744:e00c with SMTP id ffacd0b85a97d-3b5f2dfd84cmr2243331f8f.29.1752238694191;
        Fri, 11 Jul 2025 05:58:14 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1f70sm4373648f8f.27.2025.07.11.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 05:58:13 -0700 (PDT)
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Date: Fri, 11 Jul 2025 13:58:04 +0100
Subject: [PATCH v7 12/15] arm64: dts: qcom: x1e80100-t14s: Add pm8010
 camera PMIC with voltage levels for IR and RGB camera
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-12-0bc5da82f526@linaro.org>
References: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
In-Reply-To: <20250711-b4-linux-next-25-03-13-dtsi-x1e80100-camss-v7-0-0bc5da82f526@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Foss <rfoss@kernel.org>, 
 Todor Tomov <todor.too@gmail.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2864;
 i=bryan.odonoghue@linaro.org; h=from:subject:message-id;
 bh=uSDaDaav64zb5yYxypWWibFdUxaoPe5jKMH1pUZLk94=;
 b=owEBbQKS/ZANAwAIASJxO7Ohjcg6AcsmYgBocQpUR6ijDo6ewwpWh7R+yqfwdvx080SbYU0ga
 UnLG43hu8GJAjMEAAEIAB0WIQTmk/sqq6Nt4Rerb7QicTuzoY3IOgUCaHEKVAAKCRAicTuzoY3I
 OqGnD/9To2DAf4tBf4dnVNpVdMKjTwLe+wGnSXZp9TNedJD46rnySjgr4T0z5++Pq+VGRUi2e2q
 G02DcGPZ7JjafRmei0ewJJzDvdtGKiCPMSmo/9zFxU4KRWAHFffydGvXtWByGpfec13af96dSfg
 +tGcyt1E/H34cpcHHIXYmb4KMFVaLlGaldAsminlYZawgFMQFNiq6cbHy4TGvNGz6Abm119gJUL
 yPcyAshaKZUY8QGuOnisJvrekp6apsAlAFDT0jJUy7JDPFaN5k0CXjph3Ns7K0dLsX3KgEu2pDr
 5QBnY0TfmsseKIOtt4eU9h87WsH/XRgshexll06g+tt+sQeJbMVOfUAbRAjyaPlZgagIuMMWguy
 OqcTaQ20/tgoMDwklaHhUsANgmgj2n3IQCYeDxbSbzqhdRgZ9rzYfK/Y6XOXMH2XbN8s7z/cKP2
 Y2pWiK8pQThF10KEqVFYLpXL33GWTDoQwdDTScze9dbc5QpLOMEX3BUEfENw2XzUBKA/dbkR6Gn
 +AiiThdh53EiPaeQqat7QdyzuFHfOuKJc8lOsRVw8TJWhQXt24kHv8NASvaHHz1rMhQdxQZu01S
 ZAJTFDCRrDdgE/cfYOm36j+j6fEwUYRCKAp7xiGp1zKztjDSnf5kYbp9In40suEOG/KmlubqEBK
 X/zVkaDMgaRI5DA==
X-Developer-Key: i=bryan.odonoghue@linaro.org; a=openpgp;
 fpr=E693FB2AABA36DE117AB6FB422713BB3A18DC83A

Add the PM8010 PMIC providing the following voltage rails:

vreg_l1m_r @ 1v2 IR sensor
vreg_l2m_r @ 1v2 RGB sensor
vreg_l3m_r @ 1v8 IR sensor
vreg_l4m_r @ 1v8 RGB sensor
vreg_l5m_r @ 2v8 IR sensor
vreg_l7m_r @ 2v8 RGB sensor

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 .../dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi    | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index e19daf0f41f1f081e4b0c04be71e37f6ef492b6d..c9215c1a37cf4e7bad1512f52afdfc18ea616127 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -580,6 +580,13 @@ vreg_l6b_1p8: ldo6 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
+		vreg_l7b_2p8: ldo7 {
+			regulator-name = "vreg_l7b_2p8";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <2800000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
 		vreg_l8b_3p0: ldo8 {
 			regulator-name = "vreg_l8b_3p0";
 			regulator-min-microvolt = <3072000>;
@@ -823,6 +830,58 @@ vreg_l3j_0p8: ldo3 {
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 	};
+
+	regulators-8 {
+		compatible = "qcom,pm8010-rpmh-regulators";
+		qcom,pmic-id = "m";
+
+		vdd-l1-l2-supply = <&vreg_s5j_1p2>;
+		vdd-l3-l4-supply = <&vreg_s4c_1p8>;
+		vdd-l7-supply = <&vreg_bob1>;
+
+		vreg_l1m_1p2: ldo1 {
+			regulator-name = "vreg_l1m_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l2m_1p2: ldo2 {
+			regulator-name = "vreg_l2m_1p2";
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1260000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l3m_1p8: ldo3 {
+			regulator-name = "vreg_l3m_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l4m_1p8: ldo4 {
+			regulator-name = "vreg_l4m_1p8";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1900000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l5m_2p8: ldo5 {
+			regulator-name = "vreg_l5m_2p9";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+
+		vreg_l7m_2p8: ldo7 {
+			regulator-name = "vreg_l7m_2p9";
+			regulator-min-microvolt = <2800000>;
+			regulator-max-microvolt = <3072000>;
+			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
+		};
+	};
+
 };
 
 &gpu {

-- 
2.49.0


