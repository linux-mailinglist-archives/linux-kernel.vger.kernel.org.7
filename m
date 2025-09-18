Return-Path: <linux-kernel+bounces-779920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C30B2FB51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E025CAE72B5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C4334F470;
	Thu, 21 Aug 2025 13:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jgGEhigJ"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727C34574C
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783464; cv=none; b=DyZSUvJLO899FfYhsqZXB6FWloJg+jZKvnc4Do+vcfBuzKSzfNLrMD+wD315ec0t86QCUiuAQtgYgXgDWOYddAV7lipq5uOFKXBvni6eirYY+D+Qhlbb0X+QfAzt8dEau7fdqPjlm8GifT9BjnjDCfWtsTkLHtwmL48mqiowVeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783464; c=relaxed/simple;
	bh=IVLr7G5CNd1mqLrgQvVKCpA6gBxqxPNhBzSeQuBgqi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PJW7wET7TYlcLmbfwLFpFsqt9V00VboVW8vP2rYo4HUVbCRfCCQUv8WEP/dYZWw67fYaUJLewwZ5TRZHEj52dp/lQDBDaabR58qqqgACUePjLhoB71W1kltwMu+ukTf3MC3khoFtPteTNPiewV4WCCTDFNZvA3D9I1RG9Pra0JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jgGEhigJ; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9a342e8ffso764562f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755783459; x=1756388259; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sHIXsS+Alr8U93l1XOYaFtoBwmCHuYPMxDTFbbYlAd8=;
        b=jgGEhigJGUtucu1dyKQGkMzbSgGhQsgDfTdNRQC0yKtz0wO1qngRna9R5JF2x4S2zs
         6v93uiutkRjsIuZRHA+yKaJpLNS9/12GOgaVAX4SruPWM4CnVJ/JvjOxuYxDD5u1l2aH
         dWvMxLGciq3c+nGAClvudQwR0DrsU1URHCyqOh1lYlCFFd6sphEFmG7KgEJDJ7T6+q74
         iZZ5tX6Odm5ZaUISrK4EdW2n9vKPN6LQjLe16phpRW9sv7015XzNxh2fuwcNxyrMXJgD
         JlmPf2M3YeVL3oZvsfM9I3n8b2KF8onkvN2dAdBswCx7x1Gb96VRQyCrbLXxO+sAxOqr
         Q8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783459; x=1756388259;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sHIXsS+Alr8U93l1XOYaFtoBwmCHuYPMxDTFbbYlAd8=;
        b=tzRTHQRaVuFsEScy1EKEow8KwYr57ZppvqeTNrXUDlVUDR2G3o3PJxgnjM5NF2XKux
         JIum6DWYPBY9qleQwJxP0msfEpl9b7O6qu1AGmEOzIc+mGRCGQvaMwDQU3nhJ4iSqeN5
         ZkcD/p0d7cqZMLeIIlpnbTJPazboQXRRfpSlpzGLNy2k1FXTof/Tc8EbJBPUqIBcXHSI
         4DGsNxCg5JGIOXphTuSHeaZzK/iFgntR5TP22uU+q4xEGEkmRrpHKyWIdekcZkuCELrZ
         0NwSkVjTuIuqgINvxNHQObQyzq3W/J+cU79WC3vC5IYKI5bA087wwVFsI+LENilbMRsG
         R65w==
X-Forwarded-Encrypted: i=1; AJvYcCUAsSaturI9eiMq32wnaAx6wci6/6CsFjFU0fVQO/8F6oxyZvXOiib4XxQU/ccrzAAfFBnw3nwF+wBL7vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvH3q6TqMuFY1jyjeXC9lwkvdKLe2ne6zOrn/Tynhi2TviQ9W7
	vwku1wjGcR4k5h6nQgtKD4MHspShYyIgdyUFyxBpuGtF6B8lTjpSpcscEE8abqrhAyg=
X-Gm-Gg: ASbGncub7VQtr19+ff96JB0Ch0f5Fl7yw8USNu7OsofTBCjV60iiYJIt3+Vm6QcTMw5
	1eN3dypnC7rwXwRk4AfFzk6EbQuFauuda08fCB65xqoR0oGry/hCktCaZbdiPLvb8kot3hxO5Fl
	0nfgd5NRpEfR9JA3U8QHnqt5TJEcy4EwTRKdlBLTSyyZ+Ox3nFFkRR+pU7QcAQhjXihegpq12Yq
	LNu5jeWLOZCuMQc4+WmdWHAWfhpiQ+ert3dlMbbzxjEzowNIrNGw2dwtQzpvTN1YN51e4SGbXp1
	zIl5FxAylJ+GPPFlkGK7UD1usbIVrCv+xH56PzubYAilazEz3nRSb/HM+PHKsQwvbDnjpQxcQkv
	I0Ce6PRMDoIBJo7YjBQgd26+Vpi752K1eWtftnz8Gw58=
X-Google-Smtp-Source: AGHT+IF/YPxEte3Lo7XXf5e1YDPhSWC2MNjPopH/SlqS1TeDbmfnqzD8d/1W5W4aEa+WWCW+GhJHxQ==
X-Received: by 2002:a05:6000:2512:b0:3b7:931d:37a0 with SMTP id ffacd0b85a97d-3c4aee0f93fmr2247836f8f.9.1755783458902;
        Thu, 21 Aug 2025 06:37:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b4db2ab4asm28937605e9.8.2025.08.21.06.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 06:37:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 Aug 2025 15:37:28 +0200
Subject: [PATCH 09/14] arm64: dts: qcom: x1e78100-lenovo-thinkpad-t14s: Set
 up 4-lane DP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-topic-x1e80100-4lanes-v1-9-0b1a0d093cd5@linaro.org>
References: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
In-Reply-To: <20250821-topic-x1e80100-4lanes-v1-0-0b1a0d093cd5@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1102;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=IVLr7G5CNd1mqLrgQvVKCpA6gBxqxPNhBzSeQuBgqi4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBopyEZWbxz7gF51YfOX3r+EXsl1CjXtZUrpUCQqLj+
 JU3kihWJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaKchGQAKCRB33NvayMhJ0Y9LD/
 9oyiSsfhYvg4GyemSNVR3MMyNeJEzbsrs5smFFIbeh0ph3BECqDUAj6P8uZBnoN4+GqfXN/zpoWAX9
 Xi/9VXEtF9b1FD0MV/VDUCA/F7LGkOZ82RysRXZue3H1G10bQ/2MxkmJ16elhaacXZ763aRrXXQqjp
 XmfWj920y3r3kCAmRFZ0nw3hHAY1RMahs2S5QN43++fCASa4lmGZGJZ3fotVsRuOtW5rLqmXjquqQg
 wLFd2WRMtNxE5wEo6WKpx+oqAHKZZN5mHvr67x8D7/uN/1GzNAw5Q6yf/xqU3BC8cxf7Ux/Ef8jEia
 mJ4GXABl5CLoZHHSfE+eWxKl78yR+FqtEHpIFcN7G8xGACtjNlA7zEpXzrcT3ViylsH6xZjgfa2jxm
 KAr5tf/dA1YiS6gaFrFdGeY5Zu5cV6BBu3iRCSOI/RE0Mdpr7shsyoPlOTG95DXpsVc19xyCmCl46T
 fp4/M1xVq187ud15YVrsttXdje8/6DsWB54FlTOgvRQpFNjLlZX/24NjdeWiFclQTr/EWMaOjKEY/v
 /7SM26YXKwDZHruBqaTFtVND09ODlXgvP1HkDXZNCotDcmQaTSwlLWjsk2Jb+DNeN1YJu9PEy25IoT
 JiD8RXOAZ8YPZvtyjWqaGg4D4VxClpUAGFt079ggkm+nUOBiz9v7ui+MQ4/g==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Allow up to 4 lanes for the DisplayPort link from the PHYs to the
controllers now the mode-switch events can reach the QMP Combo PHYs.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
index 4cf61c2a34e31233b1adc93332bcabef22de3f86..9f965a5faaa9b687ad0aa609fe42e4841c7f7d63 100644
--- a/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
+++ b/arch/arm64/boot/dts/qcom/x1e78100-lenovo-thinkpad-t14s.dtsi
@@ -994,7 +994,7 @@ &mdss_dp0 {
 };
 
 &mdss_dp0_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 
@@ -1003,7 +1003,7 @@ &mdss_dp1 {
 };
 
 &mdss_dp1_out {
-	data-lanes = <0 1>;
+	data-lanes = <0 1 2 3>;
 	link-frequencies = /bits/ 64 <1620000000 2700000000 5400000000 8100000000>;
 };
 

-- 
2.34.1


