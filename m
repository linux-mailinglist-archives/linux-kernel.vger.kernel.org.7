Return-Path: <linux-kernel+bounces-864204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E1771BFA2B5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 872A74F5354
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDBF2EFDB5;
	Wed, 22 Oct 2025 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cevypGaq"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D478221F26
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761113232; cv=none; b=vBqobFufDpBZwfxLWI6t3Ysco9J7OYdIpAzJKez4u33PvrSqhxQBqG2wbw6s/aFeRzlq0d3+GSwhGIebme9luDt6hA9PXE4w7RFx3zF+oyiL0Nl7u+Z/yfnKsOnmvT3uV+xvKnoyq5lITAzpzbCVny5setHgy4/cvVH1nSKsztk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761113232; c=relaxed/simple;
	bh=PuhNIsXn9gttM7pCatxgdPRfxI8eKFytwCjci5lswhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ayqs2qToCYGBbsZhF9BVawrb/4jcR/KCTSWnw/Vek2PcPUkrG2TRGxW0vLYNBsu+DzeAy3uwOHr/f+ILOxCPe1XUShCPEzz4fZkGM33MSozHhZWdWeX581R64PV4wWFb2xogfR4xh8EDlwJfwARVmZnmgM5AwNIecAMiGZ1fsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cevypGaq; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47103b6058fso3776045e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761113228; x=1761718028; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=//34rvi82AnqDieMydgJVTZIokdiMPBeG7Fzj9fzlEE=;
        b=cevypGaqq4Yjb7c9GIucHbbdDlu7F7uQaBeZDemrIYBH6XVdDnQrKLqaFzaYLeigE8
         7mLjKDDCaq1RrAcnRTCnS1O6JeRC3efFAcnBjj4QpHGkcTDaVFSiUD8qpMKZJdF5F+eH
         ToEXXmtlvT23SImzLdVH9tcTRRaW6RfWAbxf/LyiztZ8FfBDFYdSYBp3mlGtlmomlTsQ
         G6ay55j1bXazqa//K8VBAJhYvhi6+vODYxD6nP4tjt/+KgfZ5tKOOHOoeGTbSfOStaTY
         0KLy2AEW0llKfsT1BmWdA/9DJkn9DxvYCR4EN3CJfvh8tc68rbORL54iF25b/3jlBj8Z
         2grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761113228; x=1761718028;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//34rvi82AnqDieMydgJVTZIokdiMPBeG7Fzj9fzlEE=;
        b=E+dWRcBqMVtgxSS7+goY55PTqPb7ToBSbKR0+xyXha4ESOpuLtcpV4B/rzYWuXpDdu
         CFmFN7Qa8e0f5ecUEHB90s45RbeGdMprTrwpj9s9GLlDwZsvVhvra8Isf+BfVcHuU8tA
         K23M7ZNBNj6JapkQUofHsAA1j8saEvlQ5mLEtfRonvkWjdXtWbTH/dR/HV39PcHnncfs
         X1y/4FstdnYf/hdhvfeP6BOkUS49U8EG7oycVUNoiNN32my0QKMNYKvGPU58PwEJssNK
         JZOebln5R09MD6ZIp6ejHdvwWg5JRxGF03cqzpEIana5BxyEGiLw/PPedqEm1WqzQ6Ce
         BrZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoPGye2Vie7WHZz0KtYKFyTG4r83IWrpzKnbAg0nD9yERrDfIZdDJ3+IMIcffhea8gMOU/FgV4xz5fslY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWJPhGBAFrScgiYu13rJV/s/sk49n/h5HRf0r/GEIb4sgr6tfM
	v9AEnauPfbrMqKygeydrjp65tj6XfnQa2sspMBGQJt+z43h/XXnVJp4VxsBoigKmIPA=
X-Gm-Gg: ASbGncta7OiEW9TF4oFjVu59D4dA6kRSl7PdonnBs2H36wNPdQARH85CXBRlM9GRqve
	E63EsXCVGkvVQcZaaQhZtJ2hVAYeaRgFlmvgODjtHxQAHdgaVm7F8kjP1vdsLhSUETxOOOGKUtu
	YGhFNGau6wolP4RkSj9skHWB48PlQueoKHy93pQMOtvwY6zxiNEOMAevATvADPKTG2dLv0CPKsm
	rJgIg9pBz+F2CMFpTBQBziiADJHQX6Zgyu6G7N6wlTqBMsCPNirxLPhhwa2skryiOPe20fw34+e
	JN0OlAOSzpNbNGqFDRb7vq7iXZriFZdm1gGjEyJ7L5CN1X/nC8CBjg7GKDO7ynPVE7S9w5RYzGy
	sFGWYKmJ6uCyoFmHHnlZcPc89GB4qSKSwLKW2P4t+52dsxsNXcY3RyUlQ2q6s5Xy6/6d1ULynBu
	HHB4SWPuCAsmZX0fby
X-Google-Smtp-Source: AGHT+IHpMXyFR/tPlDOICiK+dKxQNn4WouM9bvYwnhmK6iquazWF671SAXHrZLEjrQhXYCPWxy5KoA==
X-Received: by 2002:a05:600c:5d5:b0:471:331:8058 with SMTP id 5b1f17b1804b1-475c6f20089mr1241255e9.7.1761113227744;
        Tue, 21 Oct 2025 23:07:07 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:11f4:2b3f:7c5a:5c10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a75bsm23794067f8f.23.2025.10.21.23.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:07:07 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Wed, 22 Oct 2025 07:06:43 +0100
Subject: [PATCH v3 3/3] arm64: dts: qcom: qrb2210-rb1: add HDMI/I2S audio
 playback support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-rb1_hdmi_audio-v3-3-0d38f777a547@linaro.org>
References: <20251022-rb1_hdmi_audio-v3-0-0d38f777a547@linaro.org>
In-Reply-To: <20251022-rb1_hdmi_audio-v3-0-0d38f777a547@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Srinivas Kandagatla <srini@kernel.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org, 
 Alexey Klimov <alexey.klimov@linaro.org>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2

Add sound node and aDSP-related pieces to enable HDMI+I2S audio playback
support on Qualcomm QR2210 RB1 board. That is the only sound output
supported for now.

The audio playback is verified using the following commands:
amixer -c0 cset iface=MIXER,name='SEC_MI2S_RX Audio Mixer MultiMedia1' 1
aplay -D hw:0,0 /usr/share/sounds/alsa/Front_Center.wav

Cc: Srinivas Kandagatla <srini@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 55 ++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index 67ba508e92ba1f0ef3bcf8b248eae125de059869..43af25d17aa8314354b1ecb8617510cdd6c857a3 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -188,6 +188,53 @@ vph_pwr: regulator-vph-pwr {
 		regulator-always-on;
 		regulator-boot-on;
 	};
+
+	sound {
+		compatible = "qcom,qrb2210-sndcard";
+		pinctrl-0 = <&lpi_i2s2_active>;
+		pinctrl-names = "default";
+		model = "Qualcomm-RB1-WSA8815-Speaker-DMIC0";
+
+		mm1-dai-link {
+			link-name = "MultiMedia1";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+			};
+		};
+
+		mm2-dai-link {
+			link-name = "MultiMedia2";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+			};
+		};
+
+		mm3-dai-link {
+			link-name = "MultiMedia3";
+
+			cpu {
+				sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+			};
+		};
+
+		hdmi-i2s-dai-link {
+			link-name = "HDMI/I2S Playback";
+
+			codec {
+				sound-dai = <&lt9611_codec 0>;
+			};
+
+			cpu {
+				sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
+			};
+
+			platform {
+				sound-dai = <&q6routing>;
+			};
+		};
+	};
 };
 
 &cpu_pd0 {
@@ -323,6 +370,14 @@ &pm4125_vbus {
 	status = "okay";
 };
 
+/* SECONDARY I2S uses 1 I2S SD Line for audio on LT9611UXC HDMI Bridge */
+&q6afedai {
+	dai@18 {
+		reg = <SECONDARY_MI2S_RX>;
+		qcom,sd-lines = <0>;
+	};
+};
+
 &qupv3_id_0 {
 	status = "okay";
 };

-- 
2.47.3


