Return-Path: <linux-kernel+bounces-800318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A94B43634
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AD087C2135
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9A52D322C;
	Thu,  4 Sep 2025 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wk08+767"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFBB2D322E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756975528; cv=none; b=V+PIkqD+lG+VuQ2WKm08RWDti/Udjg9TVbf+EuOi8HiRAVMN5JdE/V8zIz9mx5oiodl41N2tcSUihbr9ZeO6cIRNTV45rsRudE5V18LhB/Kf1metygiXoJD5/O/bhGhnfytzLe6+nTRjsiUCqJbSmis5144433pi1a6S+frHbb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756975528; c=relaxed/simple;
	bh=sYR42U2MvkMmwi+/8JUkIwoIC/89jsdJ11j/3dLnOto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wl2pFX1JetYOi7e1O06l0uB7vc/XIf+WEBaWjjK/uxTRA1CPHsg2jHuKwHFn24eXN+SiNHcghCi/Wcj9JTVxHfQQp7uigVTlv1Gzlwls9hDmn2rPAzWjHGaqgqBwzX2Ksd/XZAnADIXyB2wPd9n/cCsAUe3VSYm4LiR2gekGCtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wk08+767; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cb4348ac4so135216a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 01:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756975524; x=1757580324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NdddFXq0N8wPePfrI92m/GcUNUBtrPIgFXTd/FN5078=;
        b=Wk08+767y9J6ipD+Stfd/GwmqxtuSUxOzzNOv12U4gH/SwSJBzVB+ug2+Xd9Iqb5rH
         HsB6AxvG/vck+M1KW8zVkhgve4qH96PvxpRqky3CTKbnUmElURi4SSXQLva4NlQ79CwK
         M6y2CGEblsDae+9HzYOVhJ40DwpXsifI732TMDS60l4lf8GWTXEItzqFgWOgAyR0Nh69
         0Bq0NyQBWgN+UlSP1ramSNewiIxIFxxiG6Vup1c+GqdYoxjFh1ezvVhq/FytV/5ckzsw
         oeFkfx7vjB7Tn+UrWDS/ePMzJ0CsXkP0Ae8WSg6E+Xi/3V+IUsrZkSuFftzuUHpVBlX6
         KRfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756975524; x=1757580324;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NdddFXq0N8wPePfrI92m/GcUNUBtrPIgFXTd/FN5078=;
        b=nW8d2aPUhMZ8xnIuBe6RXz0UCMg7Sb28DoFnYObe4uApv+7YvytShmLTwt+sRUvE5K
         ovjfdV/fRcs6PRcbPL3vc6nIu8d6+HTaWIqb5lkStBsJirGjSguJktFvjWENRG8M+ZBF
         w5mG5Tc+X/NgaiKgtXddCC8WG7aUDuhTSRcfN8xWar8WRRibvDq9WV41krupwyyNxjI1
         fEZWlzlhfxDfn+lusJydFedsENtMkVWVid3tdkt6gLX4V8bStNcNoZz7FUqnVBun+QTo
         AaqVDtD34uJxY7Bqk/0BYXph3A5+L2/xkXynviCVPPKvD2CZz0I3j/NJmMh9K8f1ApGX
         j2fw==
X-Forwarded-Encrypted: i=1; AJvYcCWwGru/psx2KYOWp168vu3kVIK6BIN2KXuAuzkMdFtSB6o9UBRNsSND+KVkWmngaA+eznf0WHK5tnV7RgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5yT3kvw95fVx5F6ezHy9kQuSsBp3NTEVMMklvxkZ2UlYu0TIq
	MRs5EUiqtLuBwcVzgPQgqFNxx1oP3ltu41u04pcva/q6pR/8L0lhRm+Pw8pQkOtfovg=
X-Gm-Gg: ASbGncuWp2UjX6JUnGlcKH+9fhGnR3tuj4T9mrrwRrrqi++f98ZTAy6cXsur0ZRN+HN
	1nvd1TLeHxMeRvJrtD0MKRc3bYSMwroBkH6gMvuXhVUWHEmoWJy2NUxKBewMgAPu1HYs90Yq2Rd
	snq/AqiRDvwgSX59hnti7Wkeyx0O2P6IOUjq5i9TtnnPfEwf1i9DvKRhwnNh6gDZGykhKm3QYc0
	3mlprSGvn3oLtWDR4ErXFijt16arxnb39TYlsIWJ4rZzoHi5KNpYFkPmdxedwjq1H/Iwk6C8QEk
	giPMjexD5KPr5KyHvENKqiOGPJCYYDkNDYkLVV+p0Zvft4/9DHIcOOml5qEZeVhJYSdKzA9qHQa
	CVxFa16l+R6ARjvUT2mrnDoILP3OaiAmQ5cL8HCdYsgD2
X-Google-Smtp-Source: AGHT+IGt2nAcZZZ6lfYakm5nTbxW+1p8DVBGyPnaTPvWzLNZS8BaOdU0Ax09zgrQ+zvjMOu0Nbd+Cw==
X-Received: by 2002:a05:6402:21c2:b0:61e:9c96:959a with SMTP id 4fb4d7f45d1cf-61e9c96a260mr6295895a12.4.1756975524518;
        Thu, 04 Sep 2025 01:45:24 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7ed1sm14209228a12.1.2025.09.04.01.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 01:45:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: qcom: apq8016-sbc: Correct HDMI bridge #sound-dai-cells
Date: Thu,  4 Sep 2025 10:44:22 +0200
Message-ID: <20250904084421.82985-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=sYR42U2MvkMmwi+/8JUkIwoIC/89jsdJ11j/3dLnOto=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBouVFlgiVkxPP4ZLrZg/ApMC/ISBcGCwft8LcOy
 gAOX3ij00CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLlRZQAKCRDBN2bmhouD
 1/9NEACWGXu1o5xQ8Zv/6OzO8zixBYLr+ufxlmIR/mVyc9jxTi4SSMoGORK13p1H8r/HZ/v2NlS
 aD5AhFgpyRzS19nY6/MzjJtZ5kDgiZuWtVI1nFJmlkjdDbdP9wMzWsiy4+h8R4ROqTkKEoIqy3y
 YRqLcj9RaFtNjY6qtm//qPQFSnhC7onmigSz/jyrLImOPDvBbdzV8MO2DJHDaTUolRa7tTkAxR9
 zq26ntZg9UfOfvo9hmbCVlDOJDBgJZ1eWH+neFdJDsrYKShidgRYztyCTOi5K6CsFQqIBnBSKC7
 rN7azjJsW0s+1yX9FHldFMcBiw3y0Q+NZmlzqSmZ2zP5y6gDtfyXlXlgsGQ16OxMNj5PoG1jGdm
 uXBv6kO9GnQ/UYyvmMfP1Qg5JWD2aFN7O1m6IDkfsMgav2jZFpjpgSTWC51lVnPtGPiTPJnHDuO
 b+XZN1S6IFrygKO20s1GbEEwDvcQTAxPmLF3PiEba57JXSvXpYJqo+ZDTXFkNqDWWVqs8WtfuM3
 3eBXvnKMhiCycuseF+v1jz9v3G9Hj6W5MK2lVWm2Kdy79/psLnCRNBgiE4ZgVneOurnjHPsWy29
 nYz+Dil/7ka9v2YbjKipYPWaMcKE+LEXLtcLNgeWMOzyeNRfDQcLBB21QgdZFrN2jWWinB28wPj IlR5KZ/GFvRpPRw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

HDMI bridge has only one sound DAI and bindings already expect that
(dtbs_check):

  apq8016-sbc.dtb: bridge@39 (adi,adv7533): #sound-dai-cells: 0 was expected

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index b0c594c5f236..9c71de589749 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -181,7 +181,7 @@ adv_bridge: bridge@39 {
 		pinctrl-names = "default","sleep";
 		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
 		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
-		#sound-dai-cells = <1>;
+		#sound-dai-cells = <0>;
 
 		ports {
 			#address-cells = <1>;
@@ -346,7 +346,7 @@ cpu {
 			sound-dai = <&lpass MI2S_QUATERNARY>;
 		};
 		codec {
-			sound-dai = <&adv_bridge 0>;
+			sound-dai = <&adv_bridge>;
 		};
 	};
 
-- 
2.48.1


