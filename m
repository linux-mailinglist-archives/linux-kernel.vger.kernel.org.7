Return-Path: <linux-kernel+bounces-730146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA870B040B4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:56:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19A98174276
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA860258CD4;
	Mon, 14 Jul 2025 13:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SBGh9rXO"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E62561B6
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501327; cv=none; b=dCkL5pi7bgd8vD6Z+Ok7icUTQCnJ2P+AbdfePL9NBZ3dbiGVbmDa0Ye2d3NFTi0v76N5LdxCgJZcKzNTKC3BnCHphM0RDfLPeG/uitskrrLKX3g97oJQOeofq7LgBuRrJDmoVhTI0OBwJ2ZNTJVO8oS+TLOg2ObThyMpeKrwFvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501327; c=relaxed/simple;
	bh=U6vdEfe7eEqqK6fH9n+kZgrS8otaRD5ZuF4/mbw7luQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mLigNeZGko8taTr+i3GCyK3vNNqJDB11NeAudwZzYiml2f39alVgIQYD+wAdmWqz+vhYIEYqWlhx96IBp8CYFoSflLx6IFs1o8ycw9widtw9gXGxpJP10AlMkR7oLppMT5ak/kZYhAWoceA9ht4p/5xsmYLMiJ2vFjiXdwiO6p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SBGh9rXO; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a528e301b0so252713f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 06:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752501324; x=1753106124; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+exwkn5+6FAjeomS833hx9Nw5MjZVYQZmpGmTX5gKo=;
        b=SBGh9rXOP90CU41ouXO8LYNqxvxziYHUlIphXb3ZJc/gXGIKBiQo/Q2RiqMbTZRfOu
         0tFDmH1qbeqlPomXi0p4g5O+j69xk729+IFFSb/tcK7+/0wxsi5pA4KoSaIiq1f+KVc5
         nRF/g0jkH+6eMxvUByiDDAcvc9uWiA7iLIe5+9GyYRJNaajYaQmXWaP8iufRu9rYxKaV
         d5C2RrqxrLcfxk9pmD+ifwKJANwsdLIeQfgXwXXjDLOB5zsrwtIIKfY5ghcysldGTMWf
         lphDBFoOb94tl7YzcwJRgUtXbhq7Su3RK6pxAXY2f7P+snvPNGYwiIvjlpZJMKZKInX4
         4kpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752501324; x=1753106124;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+exwkn5+6FAjeomS833hx9Nw5MjZVYQZmpGmTX5gKo=;
        b=YGrSD5oskMTwDX0xHHDGg3uoMw+EYF3dt0YchUL635shSyfEDu7xIVT26m3Wf1wW2V
         taMQhJbN/z7L3Xxf65BvnNzZOjADA/+dIwFBQJeI+V4DB/7IEjAVwS6L3r5LnoOd0ZQl
         uu93fDykv+RchtS6+PJk8vGcC/rYSDnL0uQN4R41uAhIs4COidd+AkuQHMMTVNjFk+d2
         AHXzbYvaHjc8kEgW5xl59AagZRXLPjBsUtf9hm0AQORg7IU7PKIn28Mgd0GkalS890xz
         IWY2Z3T7epd8oUtpyIcfc1UcxByWGzhiWKcHMe3mcpwSfnb+UfgZ+PCc7QxWNjFQIl4v
         Z/Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV4ax/B+4WZLawcVG5kWNSem+Ji8IiVOv3rUGSNHGRJMbmbQEplgeDL5+bXCLH+tp9zadlreO84oXpnU2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjKHq+okYS6UmOYdRAuN9ZuSDVe78dW5l65kTiJw5A/c/cdzkA
	iJY+LhxjnFUVoNbuIAFTTmDjDNbwTit3AIfixBPOjtKF1Dmwf53Nv8o3C5cifeSBmtU=
X-Gm-Gg: ASbGncvYTz/aK/9LYL9G4Jn2smKnc2uja0Vsx5a3rO30USHRH34itpWcMtHnu9FBYgk
	iHTG5Wm6QnASUymb4T/Wohsqx5eGvNA+N83M35DHWxwKahsHT288cmn2Gq5KIHUNbVoQB1Insdk
	Gomr7YrsfcMnc62RlyrV+jhbNnmC4uKLl6Rc2L+kE3wPuM0OxTK2OX/rFnkAIjkt/Hwp94+6XyF
	CqNSpZVNNbwAurrgS3L3ZuHLFcb+Y2NeyCiF9DWI/d0yzHYcZxUddost1lzadgYn7QvlbWW0UJH
	0lTl6BFaXtJOGZ7qBX5UoBwaKlslSl3T1S1okmRoyNRRpII4FHXeRLv6JyCCKiF8OZQO1efr6ho
	8m3fyDQiKMI0lcrNvSvVoE3PRRxuCy0Ga+EHG
X-Google-Smtp-Source: AGHT+IGN5F9lGSNHk8ElMvikHLrdDkpF4jgTQ1Islu28FbyWWuuZDHETIrYK9F7PtGhmec77qA9Pug==
X-Received: by 2002:a05:6000:26c8:b0:3a5:324a:89b5 with SMTP id ffacd0b85a97d-3b5f2e39d5cmr3318899f8f.8.1752501323841;
        Mon, 14 Jul 2025 06:55:23 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5037fa0sm172291575e9.7.2025.07.14.06.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 06:55:23 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 14 Jul 2025 15:55:16 +0200
Subject: [PATCH DO NOT MERGE RFC 3/3] arm64: dts: qcom: sm8750-qrd: Enable
 Iris codec
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-b4-sm8750-iris-dts-v1-3-93629b246d2e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=U6vdEfe7eEqqK6fH9n+kZgrS8otaRD5ZuF4/mbw7luQ=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBodQxGbTWyaBxv/bqgY3HAsANB+pukY8Z3ub2VP
 4vdlxGG4DiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHUMRgAKCRDBN2bmhouD
 1yV0D/9gB7OmVyXChYn29CO2NYuNH5pe0JjHhmEkdRJ3iD1A3A0++uh0PZhDN+ZfWM5KpzruI4Q
 r1qEvS6v8hlopbc3b4wL4lYUBN3za0+gSiu9SZwJ0TL4uwPE3hnAaal1AZBuAAdXZcGxC8FPFVI
 Euxygw8myqhoqgJaMWz1ZjPT0qIPthIeYh6TgBnARiaQP2wcm4pmbDycupyIBYFoCAw+zj2SKpJ
 j9GK29ylES2ahY9DXJ+aZufjvUH4NU+KCatbpjNmJVvKNJrJugw5y7JJZFwhgola5XQValMCZqF
 dHBT3vQ2vx/2lR/zR1JuNgpxz9cIQlGRDKiqHB30v1FeDdEYLutIm3nTlxYpw3b0SK/4IQo0epx
 mStP009nY9h0q5AUxfVtTwFG6rixOXBDm4o1rGkFI1Xee+UEkF6jYbcxX1CxuV0A6HlSgPEuLwr
 Gce+Dv3EJL+NYWONsNxg2bm2RWG0gPy/gQIndX9lWno44+sGCgB0RKTkggLDUtLznCqvsv29WVy
 HPsofWkUOIWIwjykuz63MwUj1rS56q7ti2221j5MM0q0wOhY5r7wpsDBRVi79ecK70zTdGwelRK
 i6CAfNIErAumfSkM01HUyR67QJW+r2vFEhVFce4/FQeXQJx0gJrq8yV5eMlR6kV6gKEVb3zatIB
 j93F+A2KrfoSaVw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Enable on SM8750 QRD the Iris video codec for accelerated video
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
 arch/arm64/boot/dts/qcom/sm8750-qrd.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
index 13c7b9664c89cffb68a1f941c16b30074816af8b..369623f8e4c921e99532d5e22fe9f0049746ebaf 100644
--- a/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/sm8750-qrd.dts
@@ -813,6 +813,10 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&iris {
+	status = "okay";
+};
+
 &pm8550_flash {
 	status = "okay";
 

-- 
2.43.0


