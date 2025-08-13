Return-Path: <linux-kernel+bounces-767084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81437B24F14
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 681829A2368
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DE3291C1E;
	Wed, 13 Aug 2025 15:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVDS2x/5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFF29CB31
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100795; cv=none; b=iVH29x1Rwhavu5IOytdigtjUZKb8W8fHQiV7iVxoPcVHe7ztenrE8ODRQXwfRLY0T5AvKLhiYA+91CHv8PQatAXyjN/0M2qdiUH3yKVMXi60xhT/EcezBC3rOGgI/r32IzU3yXY6zGH6ibJBXnve7WimdbIWMBrwYpdvnXiZn7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100795; c=relaxed/simple;
	bh=gNm8EhjslBU1GmgGWgLZonsQpYEnOk8DA9/VTuIgT6o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bWkfdC18mk14wgSKlisbN+gMoBrDVdy9rZvXZS2+RsFbVcTT0vbFOhhHDYGoi8C1LwBd1KuqdGK5TIpjQ66Y4fk+hek5WhQiYETw9NsEjuy5WGlY2kRLizqZqGoofdADbOOSvcNctAcKOq2Q63edWDaCfma47sMKJHxs4Cv1gIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVDS2x/5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b7920354f9so5552370f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100792; x=1755705592; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kO4AkXf1LQZgWN36q2s+ktOvNdi599+pfo3LY+xayTk=;
        b=hVDS2x/5cACOIL2pwphAFVDtVWZZLOiDmOf49SZlfnrP9yWZdJ47iNIrNkWjkvkLwp
         RXpZ+cW/IWl4GLB59q3tF2zXncQM5DcjzHCyKTrLm0M7xmg7NetcCt9Q2f2ICZi1oR/W
         gyGDkxFJbnxePlmOJ74TrUX0XppK4sMSdtbUaY7mRVizhyuAUI7Lw8ISl4YaTiBP7tqW
         OP4Kkin7havcv2l8/y3wPuVkCqE29C2dm2K17SvRb2l7pLgnBFPcH1Ece0FnN3XX/P02
         BQrnraygmeHRxNHUOUyy1l86Nkkd4gTDJhRvq83Syt7W2CDNG2kc9AVQ+gIBz+GEPZfC
         QFww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100792; x=1755705592;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kO4AkXf1LQZgWN36q2s+ktOvNdi599+pfo3LY+xayTk=;
        b=Yr8yhJS//kbfGrklHP6FgJj1S8IkFf6EAYjpBgEC+aKg59JK4ENEZgw90S7vYG7mhL
         1dRgNikOoY2Uu7HVjIncVBK9PDYMs7T+RMlNMprXDVeg6sOhfMBcvRIBhhyzaVcMQ1hH
         smauadk6pak2rufJPWA/6USutomSOs85UA7RZSqeGP/mHXF0UxvnEkoPz0T++/t+6SI8
         D+hXSedCLMo+Iq6P0xEj0Y/xALEi/3fDA9r37cbiavg+bFt3DVK7Q5OVq3IEmgdDAOHK
         4n1gAfRXov8aSVuqL7cNYGKg4L9auq3/jqTwkjPoNi/wPDFTHn8sz8MSjLLSX2iADUPS
         G1Vg==
X-Forwarded-Encrypted: i=1; AJvYcCXSt6Puc6LT5pmSPxZDJxVUBA5HdVH8yR3TSKG0iBSWyVrSKnHYOqFSfKmZNJCywAsbCqvzuwUwikuQJvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6iOjye0GQdI2/Cv4O9fqBdGwJB/Arm+UP6Wtn+t8rIFnFpaHr
	4acn7WMey8VBNhcQKHaVCVLeApDynxAc+DadlfFlAnLPWXvmyFxzHBYLVMRXLOP6GTg=
X-Gm-Gg: ASbGnctxS9L4XsUwgbBB5mTK3pIM000uL9oCz73flvupT7VZG7STvf9S9pgyXGeUoDY
	kiuZRGg7kBYWz9XP3Ja92Go+vISGECTgTCFKdJiRUBK7EAGPg77ZQqrVNaBtaUVcStOHHNYZ/oh
	epPMBff5m9Sw2C1nSA76naQci/6DILl7dP0cnpOMGiQsiY+omZcNPQDkOm9hJDvCWNzomt48Jle
	qPdAEFjpkuznN5qHTrY4iC0z/VielLjtVmAQsfqFlccBL6rJrQcL5sHcaFU96uFAWZ4QZg7Vzxr
	LJamPXGGDngVKw+z6RQtOaWn4nl8RPeoaJTf3jsMM0hxGpPu1cbd03H67YTcbO0oF9TGfoxBQ7w
	teLNNxksFwsRRisHN78LWpP47AxecgD2urFIO+w==
X-Google-Smtp-Source: AGHT+IE4FFojWD+k4qvDKu/weMnjxR+wvCx3OHrJVyfPy5P1CFKNsSq4PaxPaS7EO3TTgJn2lMYGjA==
X-Received: by 2002:a05:6000:4284:b0:3a3:65b5:51d7 with SMTP id ffacd0b85a97d-3b917e4f617mr3325967f8f.26.1755100791812;
        Wed, 13 Aug 2025 08:59:51 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:4537:5d58:c08d:204b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a517c26sm7087755e9.7.2025.08.13.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:59:51 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Wed, 13 Aug 2025 17:59:02 +0200
Subject: [PATCH 5/9] arm64: dts: qcom: x1e80100-hp-omnibook-x14: Explicitly
 enable used audio codecs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-x1e80100-disable-audio-codecs-v1-5-af82d9576f80@linaro.org>
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
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index f9ce2a63767c151192b0618ee2154e8d97316c1b..1c8735f39e498f044fe8ebfb915cf500bc4ee531 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -1001,7 +1001,13 @@ touchscreen@10 {
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
@@ -1011,12 +1017,22 @@ spkr_01_sd_n_active: spkr-01-sd-n-active-state {
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
 };
 
 &mdss {

-- 
2.50.1


