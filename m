Return-Path: <linux-kernel+bounces-851361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1697BD645A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC23518A2DC4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35359309F0A;
	Mon, 13 Oct 2025 20:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QuslfJAi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481EA2FAC09
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760388717; cv=none; b=So8Zjfb8sj1xwQCCy5+/oHfqL+RUe/lBk5MlalsjbYJ8LGwcQwTs6k+yKX2R8/lMjox38u57Rslyvk7b/+pgBE03dqtvTnFrPdpPSXrke7iQLm0jAbSNJVTuNJfQl/qHntTSeRP3RHPwqTm5gCmBdx454DeBwVe2BM4shHOJDUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760388717; c=relaxed/simple;
	bh=bAE97azgYQAhmWtKU8+8+yqGEn7f2/ot1bZbtYrS+Pk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wp8U7fMp5XZvrIqus12zg0eg5otgK+DfGwDoE3uvZVIZhBtgKruOWo4v7a25sDoUUnN5UrruwaESZv2e4l/pghwckoYolvZsnudaZq9udvUb+bQHKy3iTVigc9JaCrBQHzBEgoSI8s+H+zmZku2+swuoR8+r9nLmhTLWro6DOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QuslfJAi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-46e4473d7f6so29775945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760388713; x=1760993513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HLZVAB4akpL6sbRD9sjMqso66AN9VFCmtPd/UP8H+kQ=;
        b=QuslfJAiTDiIflB7ozjJtPEJErVDBya/Bf4Bn1HBoaDM68DLBYhXlvN3S7lreb24gY
         ask0yngAJ7+Pn5CE2lsnIly8Wq+U8ne1LdOFJ01fAeGs6od18+k3iSzAt3SbmsE/ix62
         hadf7skNtofVfoQSyr3HQifbfMpaHK6/Xb7hfHmS9oyojYEZTt+9mF7GU9rLbNxGvWXI
         KaxQwdm55oB4uGs/wfmfoEzi3nNUzaJqPSkJspDvgDY+DoufhFzNK+Lu14P3DkE3WM/2
         wZqD58Bu8ofab545hV/C2m0asXDYJlvZg8AJdWDnW9pxxw/iWZQXBKKjEPcBEILaP6+K
         Iw3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760388713; x=1760993513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HLZVAB4akpL6sbRD9sjMqso66AN9VFCmtPd/UP8H+kQ=;
        b=cGtNreO9ZfKdBAlRbuISKFisRDXx4DKd2OfRJvhHs3PiZcDojMXWT4TfFXBKHLEGoL
         /hXOUpntNB+8foeDmXtJiRGxBh3lYO2/thsitcM4R4zyDgisb+wKqT81Xfe5ZHsLPsLq
         h2Hq0Rm9tU4YXbjtUCF8Z02wffVVrWJ5VR9a06CgLyfIQrMp8OozZj6+6HAEEoo3z0+Z
         SGRs56OlU3su8SjKuhXBXCGBuiYwJDzLS5FcsLTc3K8PSRaPntfwouuOCdcDgBgBYSSR
         r+RicEKsb1IFEs2d2uoYTFCpHN+O5/99TSPzq5spbDaRn2ULsRD5gWFLjRjHKbb7blh3
         1WLA==
X-Forwarded-Encrypted: i=1; AJvYcCUtXmDt3T1/K9oCLnuvqY9EzuzCazKA9QTOYCKmBFGxYvkQpIh207I+1AmxQwaSGI0wVX75rSITwTK/KA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkGbHZttEyYBJ+gVWk7TgSiRauXHUWV4Icb/Dw80dcjExFp4sY
	REsmp5uR85j41cYpiHHvJX+CmnqufwJGByDIq1HMcqORx/10z3YcoRszsFbHT/aNbjQ=
X-Gm-Gg: ASbGncuT83G64pc3Y+K8OXxveGk3PqSFFiATJ0+Q3T7PEjFM+4oHHjIgZr48bQYZyop
	RI3ABkN54TnkXUlTrh8abq0KZGI0ZbfTzBxLWQeO/NHS8LFFwnt8y2WHd6qGNfjWBm2yLuwQF7w
	IskzCYo6MrsIYeEHgckoqZH4cMW4d8uPY0/fKNIEc3xsv1zm3nBvOUaKPaMaVMeKWz4ck0cruAG
	rYKA2x/fzasH1AkDJtH1mQdC/TD8WLNFAMnKtTGyZHVL3bWLjHyrs775vS1aPcCTnqsD6MExNRk
	4sJwY87Sq296Bv5LtevtstKXqkav0q0aKmwH7DY+/LtsKwrodt7hQ2ewNkn5A09AeIHFzUmMlC5
	sLF+hkygA/PBaaMbwdmXoE9akHWfGIDGbK1CEEmLyjldJYrGzA5hk7QDNDFO8yNHont8PXkyY29
	s=
X-Google-Smtp-Source: AGHT+IGLquRNwbSBxeaKtRQn+InjdLBSfDT/oRT91BBW3oh43qrtNPuOuXBni/cQqnsMwhMF64WhSg==
X-Received: by 2002:a05:6000:18a9:b0:3e8:9e32:38f8 with SMTP id ffacd0b85a97d-4266726dceemr15446311f8f.14.1760388713482;
        Mon, 13 Oct 2025 13:51:53 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([145.224.67.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3e3206sm133512615e9.4.2025.10.13.13.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 13:51:53 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 13 Oct 2025 21:51:34 +0100
Subject: [PATCH 5/9] arm64: dts: exynos: gs101: fix sysreg_apm reg property
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-automatic-clocks-v1-5-72851ee00300@linaro.org>
References: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
In-Reply-To: <20251013-automatic-clocks-v1-0-72851ee00300@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1103;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=bAE97azgYQAhmWtKU8+8+yqGEn7f2/ot1bZbtYrS+Pk=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBo7WZYYmJZ8YONtySkBG/HUNTVydzl5bgMRMGRr
 qWszbbZnViJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaO1mWAAKCRDO6LjWAjRy
 umR9EACMEsA8OD7G3hLHFLspQRD/IOXCZ5eytSYfOI2ddJChBcnhWKTACe/Vbpqvez6XcyYt81X
 GmrTlyWhQbunFVspRlSPeILc4GYLllyGdXrUBXVbN58apbf7W3NZ1EBB7gmonHVrjSypCIONXLd
 b27BLp2UkuvwHcx7aD+ODzdbNbgvIN9HmlbDMtrpcF9ubfIK3HZmBwxLxe5/o7mcfZbIAAqKpBa
 i1dq9gfOe9INP/BYlYNjkEj6CJPuLFNWDxwc0NufLc2NfeqmeOIx873p0kqTZcZBePWy0KV6CoN
 TdccbhoutOiJKVYdYdev4D9m/u7vijeb5dXnh9LbXslbF3g88wEgfYu9DdMU+5OpBFRni1RC+Ji
 sv0AfCYhg3mheB4+0K29PBo/MogbPdBtzu85fITfiGOkDg4Xn1bEy15JGXFchaxbl4BtGyDzb4w
 1Qt0VWA8BDBrbpm+lW+WUJNpo3dYNFA3yJFyY5X31mHIqnAWQmhGMJqLf1ERzWLG6nZU81iOibw
 nuxAgb66x1aVneQVYA/3kILxbTkd9AOUICwK+fazWWP3V8rBKJuNeyzJHwzl2cPSqY0dMQNKJfh
 WRlShcCYi+UvirrOt1URjnBvTRDctgCGnmKk6FwCNmEc7G9vcFgn954ZQ6/ySUSs0LrrV3fLfOz
 JEA739XWyEP617w==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

Both the start address and size are incorrect for the apm_sysreg DT
node. Update to match the TRM (rather than how it was defined downstream).

Fixes: ea89fdf24fd9 ("arm64: dts: exynos: google: Add initial Google gs101 SoC support")
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index 1ae965e456665bf05aa1b08269b5dd66b46d200b..ab66c055e0ac157f89a0e034f15bbe84e20a7e82 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -1414,9 +1414,9 @@ cmu_apm: clock-controller@17400000 {
 			clock-names = "oscclk";
 		};
 
-		sysreg_apm: syscon@174204e0 {
+		sysreg_apm: syscon@17420000 {
 			compatible = "google,gs101-apm-sysreg", "syscon";
-			reg = <0x174204e0 0x1000>;
+			reg = <0x17420000 0x10000>;
 		};
 
 		pmu_system_controller: system-controller@17460000 {

-- 
2.51.0.760.g7b8bcc2412-goog


