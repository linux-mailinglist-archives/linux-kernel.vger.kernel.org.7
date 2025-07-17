Return-Path: <linux-kernel+bounces-734736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B85B0858D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9315D3B2515
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C4021C19A;
	Thu, 17 Jul 2025 06:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="CSbDskh3"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7299121A928
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752735306; cv=none; b=Aw8xoYDkgXrwKYWxGl8Z7VUSnrk8LW86ZCcHr1K9X/ZQTbpL41ESI8XmGyWIHftn3JkP5WMU6C4Ol/9P8HciwQxG0jq2VavkyFj+HXuqM+/YeroGZLG1wwTOK2bJTks6HYt9GCTQlIhAHpg044kO6FGi/ZGRwfNLNTxoHjTO1zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752735306; c=relaxed/simple;
	bh=N4PEPS5UV8E5Y8cK3eBI2k1UD3y4Gy1ShHAsxsUM/Qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cITt2Xippzp2AeLybGRfiDOhMD79l3EZNyt7/Rx/Csp8iEFR8y0wtBUzBrTtA4o4M+pI6/oxqy9Kxl3KIVYZVI6Ju2UalfFE3Niu5R4yU8GJhW454LNhq0ik4NJGJy67qswRVTJ3CLYpX/uL1qb6GfIDNMdFNT5SmaghVcllvTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=CSbDskh3; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-60bf5a08729so1202111a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752735303; x=1753340103; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB1OZtfGop0B4+NTVehCQkuCByfNf/kvNDqqQX1Bxo4=;
        b=CSbDskh3cip4PsCOP5ZkUYc0jF+1xJizVGT5o1iqmdiny516pGQTYzG4eB5bti/KXb
         8RhveVAQeKEO5y/BzRmQvP9r0oJjnYb2SBPvvh9cOJyZfFncAIC16ahu5D6kOz6MbjX0
         sf0H1egbBeYLlQBc7CTvms7jhHcQO0RguxF8be/dRAxK4Qf8AXtcEHi6u8/Lngovb1Bp
         Hph3f4qVadVFaY7ye+7bdPo1MfgUFw95ppn36dnWa8y7kZ1rtmX/wAN9iXsizENuVu+7
         pFQ8H+wnCkfpkTR06QCvLtq+kfOziC7j1TQjYuXNUwNQVWV38/ew7MSDpOdhwpP+trf9
         KFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752735303; x=1753340103;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MB1OZtfGop0B4+NTVehCQkuCByfNf/kvNDqqQX1Bxo4=;
        b=SAh7e5t15jgN9czXB2KDhFLCQUqClze6yCw+mqyskvQO4rDtSGMEcnyya59EW0/nT3
         8jtqo2fXbPjVQSR/L98hC8hhBmTH0JukTaQfPY1akG3TOqkQ3IGomj+AvFJwC8MtgUY8
         MpgLlCzXQKaQitK2g88j2Y9/PoZzg8cBTWLV3eZ+7RukGgg9iUeyWBCTYpE4ak13aAiA
         NV4luqpeI7ea0mHjalZi6VyWy2OuqSuqnT0XjxYAERYkGjLcnAbMNwtQXY1LIkQHdm9A
         p8MIZ7CnKwGtwZL+Os3sDbhdmel2C0c4NwOrTeGB97BgC04+igfbLepEUMRVepeZ4Zb2
         jykg==
X-Forwarded-Encrypted: i=1; AJvYcCVIt0+aKu+5rLgLqOA/H27TNJ5/tWVSDfc2rwKPKHWz/4kglsmtAPWTO0FlFLDFtitE3RtqV8R9Taq6tfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTNRJqgvu6X4Zkow40Z8iUdlCxTWS2mylouRWaQn47w7Pq59jE
	6Y6g+AGlD8VquD4dowPbMqVW9GTsEccqA19eAzYWLaYCr3eW6OqZb+9K2/dnxnvO2k4=
X-Gm-Gg: ASbGnctOUXE/2PayIWyvCL+eDZBl7TJXZB0M9eHjtKH0z06IAGDPveKFFWV8LObws+b
	a1hOK5qhv/8MhaI6GqpLssV5d/Mb9AqzZAR7dFf07t6RoKUue/x856RdmkjJNaIsMPu+6R9VECu
	K2EnlrWG2Dkf+dmyhLKSlQcMuI/mPKBY1xJt/mEjhcIk4ePmsEJZOxkCX+/nXfROfQeIa8mrnpL
	xR1+X0MWdi+hIPAnAa4hltz0gCHIOi3a6CwNazNM0Q5TVELM60xpmkHQT9BITmdUGxcMEI59hi9
	kq9c4x9/NYk6hi2GDr/U3l5Xm5rSDHLuP7CgNF/kxYvuyEw1pzdIOP/1mJgj9BTpnAJJY/WTEoc
	KVU8kNAeGwA//xvr1fZmA2VLszdCrBX71PXqc+QmHx0u6n9HzfVng1te0Vg==
X-Google-Smtp-Source: AGHT+IFgudfT73jE+tHkRBTab/R2HTLvDU42kys3saWRSJACMm7Yq4B7sYeqMxn/ESUAlHeq0K0laQ==
X-Received: by 2002:a05:6402:524e:b0:607:425c:3c23 with SMTP id 4fb4d7f45d1cf-6128590ba42mr4742628a12.5.1752735301278;
        Wed, 16 Jul 2025 23:55:01 -0700 (PDT)
Received: from otso.local (212095005146.public.telering.at. [212.95.5.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612477e1d2bsm4688882a12.34.2025.07.16.23.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 23:55:00 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 17 Jul 2025 08:54:45 +0200
Subject: [PATCH 2/3] dt-bindings: interconnect: qcom: Remove double colon
 from description
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-bindings-double-colon-v1-2-c04abc180fcd@fairphone.com>
References: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
In-Reply-To: <20250717-bindings-double-colon-v1-0-c04abc180fcd@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Marek <jonathan@marek.ca>, 
 Martin Botka <martin.botka@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Taniya Das <quic_tdas@quicinc.com>, 
 Robert Marko <robert.markoo@sartura.hr>, Shawn Guo <shawn.guo@linaro.org>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 krishna Lanka <quic_vamslank@quicinc.com>, Iskren Chernev <me@iskren.info>, 
 Loic Poulain <loic.poulain@oss.qualcomm.com>, 
 Imran Shaik <quic_imrashai@quicinc.com>, 
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
 Ajit Pandey <quic_ajipan@quicinc.com>, Danila Tikhonov <danila@jiaxyga.com>, 
 David Wronek <david@mainlining.org>, Jens Reidel <adrian@travitia.xyz>, 
 Priya Kakitapalli <quic_skakitap@quicinc.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Georgi Djakov <djakov@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752735293; l=8576;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=N4PEPS5UV8E5Y8cK3eBI2k1UD3y4Gy1ShHAsxsUM/Qg=;
 b=yeEzSpHjIpxpKmVkyd7AV4yj2hOTh0q2MSyZViu8cCy4pDypLBY3Wy4o7vzX6IDVzjzCCW2nE
 x9V4mNIY5jED/NWZLP+stsYuepVI2N+ardIwMakdaEIZ6JPPLybHBPw
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

No double colon is necessary in the description. Fix it for all bindings
so future bindings won't have the same copy-paste mistake.

Reported-by: Rob Herring <robh@kernel.org>
Closes: https://lore.kernel.org/lkml/20250625150458.GA1182597-robh@kernel.org/
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml  | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml   | 2 +-
 Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml | 2 +-
 10 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
index 2e0c0bc7a37659621f25a2a6c6487a7185ad83a3..db19fd5c570865535fabbe54a39183e2f493bb9f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sa8775p-rpmh.yaml
@@ -13,7 +13,7 @@ description: |
   RPMh interconnect providers support system bandwidth requirements through
   RPMh hardware accelerators known as Bus Clock Manager (BCM).
 
-  See also:: include/dt-bindings/interconnect/qcom,sa8775p.h
+  See also: include/dt-bindings/interconnect/qcom,sa8775p.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml
index 4647dac740e9b8bf308470255ba92066fb2903c0..f5d3d0c5df7335911c4fbc92d5c97bc50f019e2e 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sar2130p-rpmh.yaml
@@ -18,7 +18,7 @@ description: |
   least one RPMh device child node pertaining to their RSC and each provider
   can map to multiple RPMh resources.
 
-  See also:: include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h
+  See also: include/dt-bindings/interconnect/qcom,sar2130p-rpmh.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
index 78210791496f84c49989d6cb99a328ad997025b1..81c3dff539926eead123f86c12426931de1f7463 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc7280-rpmh.yaml
@@ -14,7 +14,7 @@ description: |
   RPMh interconnect providers support system bandwidth requirements through
   RPMh hardware accelerators known as Bus Clock Manager (BCM).
 
-  See also:: include/dt-bindings/interconnect/qcom,sc7280.h
+  See also: include/dt-bindings/interconnect/qcom,sc7280.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
index 100c686369092687e78f7c039135d63b5a02343b..2a5a7594bafdc36c8a26eaca5a4b0548d3f23dc1 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sc8280xp-rpmh.yaml
@@ -14,7 +14,7 @@ description: |
   RPMh interconnect providers support system bandwidth requirements through
   RPMh hardware accelerators known as Bus Clock Manager (BCM).
 
-  See also:: include/dt-bindings/interconnect/qcom,sc8280xp.h
+  See also: include/dt-bindings/interconnect/qcom,sc8280xp.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
index b565d1a382f65f7fee5c071f0a46f79e7d03fbbb..978930324bbf05adf1f1f7932b695cc418efe7f9 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm7150-rpmh.yaml
@@ -13,7 +13,7 @@ description: |
   RPMh interconnect providers support system bandwidth requirements through
   RPMh hardware accelerators known as Bus Clock Manager (BCM).
 
-  See also:: include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
+  See also: include/dt-bindings/interconnect/qcom,sm7150-rpmh.h
 
 allOf:
   - $ref: qcom,rpmh-common.yaml#
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
index 300640a533dd67e59aa9d16f06500c152b1510ef..6a46dc7d473ec39f95990fd30f39fe2bc6ed4c3f 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8450-rpmh.yaml
@@ -14,7 +14,7 @@ description: |
   RPMh interconnect providers support system bandwidth requirements through
   RPMh hardware accelerators known as Bus Clock Manager (BCM).
 
-  See also:: include/dt-bindings/interconnect/qcom,sm8450.h
+  See also: include/dt-bindings/interconnect/qcom,sm8450.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
index 716bd21f6041404522d17c232c301cfa49eca042..5325ebe23c771d571ef7f80326632d4511c641b4 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8550-rpmh.yaml
@@ -18,7 +18,7 @@ description: |
   least one RPMh device child node pertaining to their RSC and each provider
   can map to multiple RPMh resources.
 
-  See also:: include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
+  See also: include/dt-bindings/interconnect/qcom,sm8550-rpmh.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
index f9322de7cd61e677545f20ec913e21d541ff02f2..199fe7b232af39b96f9e0c97137cc9902f5062f0 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8650-rpmh.yaml
@@ -18,7 +18,7 @@ description: |
   least one RPMh device child node pertaining to their RSC and each provider
   can map to multiple RPMh resources.
 
-  See also:: include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
+  See also: include/dt-bindings/interconnect/qcom,sm8650-rpmh.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
index a816acc301e1fe5dce9316ef7c44b62b7fbd6758..366f40d980c2af9918cd6f9436a1c8ba6c771beb 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,sm8750-rpmh.yaml
@@ -18,7 +18,7 @@ description: |
   least one RPMh device child node pertaining to their RSC and each provider
   can map to multiple RPMh resources.
 
-  See also:: include/dt-bindings/interconnect/qcom,sm8750-rpmh.h
+  See also: include/dt-bindings/interconnect/qcom,sm8750-rpmh.h
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
index 08b0210e0e5960221c95177fe7e383d355096cb7..0840b0ec6e27619d87506f98c7e5c2dd17314cfd 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,x1e80100-rpmh.yaml
@@ -18,7 +18,7 @@ description: |
   least one RPMh device child node pertaining to their RSC and each provider
   can map to multiple RPMh resources.
 
-  See also:: include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
+  See also: include/dt-bindings/interconnect/qcom,x1e80100-rpmh.h
 
 properties:
   compatible:

-- 
2.50.1


