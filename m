Return-Path: <linux-kernel+bounces-781564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C728B313D7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 214864E6395
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:45:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDE02FE578;
	Fri, 22 Aug 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mfvhruHw"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A532F3C0A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855576; cv=none; b=r4b2/syTdpTuv39SDUoTjW5n0P2PU2Tvprf+egV94APxfnUyI91EgOw+q0IQLKIm/IP+4EOpZGQVUnwh1xxbWXnWUHH4CwdIlf6P2xYe41hPAcumNubIOh/8xurAp/hMjPx9A4n81+9AO7fxz23QAW+yfFs4mVNRhnSf3YT8gxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855576; c=relaxed/simple;
	bh=LBXaPRYmChgNlaxLd1aqKcJ//ltc453vN2DqhuB6DAw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IslfYIQCGumhwcQP5hcJMBLTTipvOeB8zdSxgQNiL+8BwSPEYB2sVRaPBst1P6MSIcvh8UBSq8TlKmCYwBsrj+9gaGoSlTqxZByCCzvuwbJhPuR/u9rPRSDbmqJZJwVWNgmSQkLNGbh9MA07DJF4BywRIWgGZNTf1c4EFoZ9K9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mfvhruHw; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b55ed86b9so792055e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855570; x=1756460370; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5l1/E3apL0wGXJRh3OODxJwb4Or93GWoBw71KuYToUQ=;
        b=mfvhruHwTIcVlil4fRKX3L/jW9uw6MVQwzgdxcal2KGRjOl7bggdhrlP1XBV+R12r/
         cnt2nrArqhSoAks1wczzcRiDdsnh4KFHsAaYy/adwVNYF22UStyZ2zPDYhTNO6pEJhcy
         y4qgAHwbn7V9Vb8dgYYhKNIl6LXsoIX8egbURT5TjUvZxoR7V4Ut3poPcAwCMeHuVRke
         dhreRbSr7gs1tXcnb1U0UhWAqAc9ZZyZyLQdBjwpjXLa9mLefbOmFSTcdDx2xLkE9roc
         8bbe2QNdE2qXKnORWvmlUSKB9u+Xg2G2QDJmZzp/berD0ETyHRXlxhDzYEmzIsd90RI3
         FvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855570; x=1756460370;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5l1/E3apL0wGXJRh3OODxJwb4Or93GWoBw71KuYToUQ=;
        b=C2t8ac/JNov4oslWu0EbQvbNJC13uNJMEoazCD8aFuw8yEXZaaDQhmmJ8Qm7MeZpzc
         CpeX0/ztRumnpW8/Oinbf/hulVWaGNezBCuiz45Mo0+5HePV8E74FWrrjVCuK1f8kSE+
         hB6Oa/aotoLGGcXqjuhTjHjJbTghU+xV+Sb9BPfgddLmlCpFpqqDwLxlzSZImASfA5q4
         Jgtg42MsrXXPQa+DfaXA7G/667ITiFvAdEg3Hr9rvp0H68goYMC64bbmwhSleNqny+/K
         uAYSKF2rF667oZg30s41W1fd6dlwxqgzNFgG3HRofh+EihMTZeeZ3mHF9IpHANlBuWKi
         D7FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs5cUYfAT7srsBEUDYPHyJsj7JnLkWm4rz7MomCY0auqcHEPvkZBC+77Kir/3iUHZ1luAolUVP6cok/lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIKWfk9e3y8Yd8BMSUw5cb5g/vhTHrxqin2qa/a2eEN63OXQ7e
	9bEGFSfTb6uxNIDKPTbCMX0lOeOHJl5Rj27KI2jrWv/41HLzch0uCspdG/2yldK1OXU=
X-Gm-Gg: ASbGncvJNXgQe6pN87/pUJ5TucceoGY9wzvdhXCCChmLWqOFkuhOLd5zzdNxvnFY2nK
	AuVS1/LRpkqaXO5uHN/n6I/q+GjYNGTYdJ5p+QDtsUQBVVx+aTjA3Odadbx7ayKqa2xWQqWPrCz
	BL5zMd3lhV7TYGcW3Ak1cfEE3aDCcE3SD8Idgi813qnZfUFrG+2JGCvoY165ze8IxeT5oxDoV8K
	Mq0s71xPjmQbjkGExx2SXkWBhuZ1h5qO0+znNmvDlJB4wlnU9+ePtDvh+5M4VrYqt23JpjCdtTE
	6YwwU/OyiDe3LAOC0iG5WiYkocBHyD5PqG0xYYQgseuo6iwYFseB+FNJYA8HxoDnR4dhdY2YQP7
	ySJVkzmZpU2ybEzkT6lNIB1tmmhCRxjnux0R1EMSUnJ8=
X-Google-Smtp-Source: AGHT+IEMS1TtSWGZlaaAKlkn25Sn2eINiSBk5eS48rfOcx/OpiefMoBeBPtLHjsBLgoTF3FWBGM0Gg==
X-Received: by 2002:a05:600c:34d2:b0:45b:47e1:ef6c with SMTP id 5b1f17b1804b1-45b517e011amr15445715e9.35.1755855570312;
        Fri, 22 Aug 2025 02:39:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:30 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:25 +0200
Subject: [PATCH v2 13/16] arm64: dts: qcom: x1e80100-microsoft-romulus: Set
 up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-13-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1085;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=LBXaPRYmChgNlaxLd1aqKcJ//ltc453vN2DqhuB6DAw=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrHnUwZVKO3MUFLBAWjYd5MSZIR8zZlvnxdh5Qf
 XMFSjdWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6xwAKCRB33NvayMhJ0d+RD/
 9QE62hn4n7bLaW+l2Cxs7ku3uF4CJ9Eb7LLG2m9bCXq4nwgXXjT08lzpCFDR3k2GhwFWZh0hxTjJsl
 8unNMTxeGISwmeWV0X38VEtT78M2QsRu3dkzoX+2tEJ9zSv+vQzNeYImuT6ov5boNtfpEKXaYhbGUF
 OaUDeqiudWwqQAcsQiNTywZFktYf1AknztNLk+5H4etQCzcw+LsOXU1wCHWqwwwUr5V045+g747Sna
 E1ptyHMJUfme4ZU2Gpfemk/PanbDzA21T64vCU/tbaGh1JIIW/07sh4bCXFeI6m2iuQzU8BqFq0uUV
 5hPdxGVxCZIlgWJoChN3nfv5+FSHdJElTFpwEcysO7pXjxxWntzy67jJlojeWsYSeW9ib9kIpJDGWQ
 YdXHr43ateAyaL5DKNZ6s1KMO9bwmgC/CCgZIs/JLBxpOygGT9llTZnt9hHlZpHMc+8k4ghnJX+eX9
 cCsvxOVD2Cr8xE6d60KcMOmC1F3kwgY6tCfTQPxUZtswsNrTFaMuuvavz1s8r/l5wtaKT8mexFTjCC
 9qBwd01J+J+OYZhLVNN0zDJnmOl8wH94jNPiQOyEUoDFnH37UzDNmrv8RoJC8Y1Vr2rH3dAtpra/aK
 EMVUS8LSRWfSBuHxXkpCQRGL8lf2ChENyy3HV4c1pijoUy/oHoGr+cV6eC0g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
index 27dd5e4e9939124360544ee9c59900ebb01f3f49..559ebd9547ec4c3324576d58976c0bf2a8fc2217 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e80100-microsoft-romulus.dtsi
@@ -949,7 +949,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -958,7 +958,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


