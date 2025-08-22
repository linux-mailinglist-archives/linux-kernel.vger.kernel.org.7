Return-Path: <linux-kernel+bounces-781565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C05B31424
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210851CC71EA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4825B2FE56D;
	Fri, 22 Aug 2025 09:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DjmI+GQk"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7CA2F28E6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755855576; cv=none; b=oZdUh2im8Q4L/kxr81s+t5GGlBDOZNwAN0eeqdQ/lOUAePlW7GNnKYciyKIN4VuV3qxi7l9rP2fjHyPlMXCwZT820UqWzxR9xtTZhtlvzaWy2lMBVy5nGFc2arDhtYuJaQmQTqqWtIgV1AcH4hc2ycirfSRKIwGxj/kXO3WHGLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755855576; c=relaxed/simple;
	bh=XnG8D8Z88eQIU49PG/7dMe7xnqvu5KLqqFXsnUqNrnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BD5wlnPnaeDfOGBWIar2Fv8XO+944hGrH0EL+cAdYNGNOlwuJ0vqU/DQsi+fPTcJJ4XxGzAyxsJWF4dd3V2yK1ssOW2NDvjOI2UzHUA5udBnKkE7bqowj2+h26yKmvDBWVGXF/nrK8sKllMJ+9+FDVAn2iU9RmSX7ErNAB2PQEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DjmI+GQk; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b0c8867so14429375e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755855569; x=1756460369; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0n5vgZCuc6Zp7e2AYbn/NQMbYtFdI2JHkj77/HaE12s=;
        b=DjmI+GQksMUBTt5G32hSbcPprMxhIIU2hmggtoB6699yQHTkpF9C6FsZt/gJ/mvO89
         rYG++RnE8SrPEaG+oFIlMjA/O34SipDPTp7ATFFDmUEd1c+VKb4OmLD4lA0StMVzJ596
         Jw1KuwWdnzc7fNa09ufhWGRGqrCpsycxmKwKOfnU7Th2UAqrzRbi/VbRg2B3xXXKkUdy
         s+0yCIj2oyrt3pkY4yBoGIZ6GqCTBfcS3Ji3GlwRPsY7KY3KKukwIgovPJOvpqVSvRh7
         l6eC6LPIxPhki40pvzcoa6n93ARRQgJgW7BkpLN1/dSS3Q9fGbN0bDPIXmxNYi4XRDD9
         kgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755855569; x=1756460369;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n5vgZCuc6Zp7e2AYbn/NQMbYtFdI2JHkj77/HaE12s=;
        b=QKwzQ+lIsdiyNlDhWopRj5HkJ9c9L3Qo2j7unOuOu6Urb6loOJhv40fVVrCkyJ/xeo
         9hg1lYQeD52cp/A4oOr09/3Ka5IJlpU7NDbJDoNrCtaptvGvE59NLmOodep81WPrRqHA
         UDneYmGR52tlWHAakym6xsfjkfjffaPEOy9fH52eKvX+Nh3+QmeoG2slyfOO0W4qh6PZ
         KKaoTPbq9XtdZScYYuhX0/VKiw1q7Z5PWWXxa1PL5vg/bFViO2bbExsDMjCAWiW1E4A6
         VKpsiHuMljwmyHNrzzk8EzCxRrqqNOeVkw3SlYLM2+1BQQaBE70sPpKcF+Mlv6VC9hmD
         xNIQ==
X-Forwarded-Encrypted: i=1; AJvYcCX3AHHUu0BaOaCLHO9jii2efTpge2boGqfbJ98FH5nmc/kiFWXXMmHIq8GxsIe59z6dkIhM+KoyCi+bynQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz63aJTXEI/tM6vKHMOgYFSD/HK2FO8b2bH/aBsl4gZIngPIqPY
	KN8jMHjMQ685xZnwSTRwvSW5E25zT/VOcuKTUqUxAO+wbn93EGpcHR9MkYklV/3i9Tk=
X-Gm-Gg: ASbGncvfYGELFd0tNDvSpd9fx68Mlb7IIIZWgelvngtdySkOH5LMCw/ZvB4+3kWqGPP
	n3YqP/qTiCmyX33P+SzYysM1OSE1AlfkhW9Wu6GXIGByl/948O00AhOw5Kv7yplf/yj4jjmq+AB
	ckQelRJqlhF3aDQNanBdbm+nxAqT+RcKX1cDkLU7teFfkgVxOr3YY102tRlpEAWm8perbomQ1Db
	IsVyETL+Wzt4Wm1XJt7JnN1XtOpsRpUm7DmiFmBP+ba2bo4Jdkrt5Fz1mnY06rr30abbc/oE0tN
	x101vzU/yjVqfIjRwhmRscDY4rZNbGI0+LWURJItKNqCjpMAt2HGBiNyuIRlm8K3+Oqb3acqndL
	nuBkRorRaKGVcf6Cyr+aBvIXdg7dt8YTzwZneo5XAk79LXfoK5WFYmA==
X-Google-Smtp-Source: AGHT+IFFI4X9EWBxoPg7BFosPeFvYDvTePo9F+y/SpSsSLAEdL/heq2F6uv9oN4lyxsuHthUVWKfTw==
X-Received: by 2002:a05:600c:1c1d:b0:459:dc92:b95f with SMTP id 5b1f17b1804b1-45b5179ce00mr20976265e9.5.1755855569025;
        Fri, 22 Aug 2025 02:39:29 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c684524163sm609890f8f.61.2025.08.22.02.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 02:39:28 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 Aug 2025 11:39:23 +0200
Subject: [PATCH v2 11/16] arm64: dts: qcom: x1e80100-hp-omnibook-x14: Set
 up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-topic-x1e80100-4lanes-v2-11-4b21372b1901@linaro.org>
References: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
In-Reply-To: <20250822-topic-x1e80100-4lanes-v2-0-4b21372b1901@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=XnG8D8Z88eQIU49PG/7dMe7xnqvu5KLqqFXsnUqNrnY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoqDrGcynERPnzxiUawAlpfRl2v42WqdFSLFaIWFEa
 Fe/IQNiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKg6xgAKCRB33NvayMhJ0YnfD/
 9ez1wRfb+Ld7EDVf3sVaKq/8y6770u9wJ5N/w4reOU0/BUryHLPGSM+j8xJWxQoytWzv1q9OIi3g8E
 fJ4SzcfctYROUWaT18KUxJxn+Kf6JWriuqaJ3RsOOqMyJFMOVyoTtnUGaOiFbefHaGK3swi0A12EMC
 X8JOle//wcO5df/FYtKeOPmnXIAZqLEGqaKmDUP1spYSp6M6qu720vcgdtMscrMa+D3YHGK+mVTY6K
 Lct1i8mjZv/7g9539r8CqeeBOAb0zG2u3s2Fkug/IoNl45/SQ0CLAj7CJiuWt0f3MBMQdVDbv/b70U
 fo3bj4fEES3p9lT0HRJXOS4vJX3mFZUzTBoC0+TqdORkGAz6WP2+xpdAksF80BGizAx1deVhpvRVEP
 yScP5ZvBpA+Y+0Lygj+aypFO9HYTyX8H87H3N54qpYyu3WfcoH1Eg+XwjeQDvSm9qxw19z0MEpYt8B
 vYy2jHXV+SXrI7QX5bQaC+40f+C7/v15ozwUTdrXugZQsQnkRV0UsGvTF32GvPBWqJWRNzbmJHiTw4
 T9qT4OxyVVjmk2Z99oxe2n+hubHU2xObFhiHxTgJq05yYy+PuC372nzXBayO46jUN4QzZnCgkzOpKr
 Fy3Stx+aQEadwUrI2KZOL/m3xZy/0Srmw2XfpSF4wbEs11c1DjHt/f7W3vRA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
index f9ce2a63767c151192b0618ee2154e8d97316c1b..e1116ca9c0ada2431d36805e20535e2edca62b31 100644
--- a/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
+++ b/arch/arm64/boot/dts/qcom/x1e80100-hp-omnibook-x14.dts
@@ -1028,7 +1028,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1037,7 +1037,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


