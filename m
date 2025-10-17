Return-Path: <linux-kernel+bounces-857261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFFDBE6595
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 06:59:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE72F4EAE9A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B521430C635;
	Fri, 17 Oct 2025 04:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rP4RCeeo"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FE930B525
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 04:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760677166; cv=none; b=Qs/o7wjqshj5d6m1tXh2TXBp92O9NqpqVNFvhDZUO+bbLhLu3cUuVGoUJ8CE3tnl0laGGwnWWoXfKkPB/q8yQlv7G7VWQ97p8G9KpqUQYaJ6856VkYKOx1YITPsd2u90XcerIF47o+WsFF2dODydVfoYermFvk47XFIMJabtUCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760677166; c=relaxed/simple;
	bh=zIxLGjbus2Nm+UNtns2PpMFy6y32gwr6ft1KacyPH6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPGXLcFRUqHeLIYLyi+D4ohS5YQCdwuImDv8sGQkzVFJW3phws5Oj38jogCWskW4hiG951ROp0YmnpkcpEFS7gNig7QYp4iBeG+f62eWUHn/7/Wy6VLI6NUPxBGeC41zChbvbZlMf5fnSScfWXZG2Jk+m7peo3L4nvucLlshhdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rP4RCeeo; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b3f5a6e114dso24234366b.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760677163; x=1761281963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUnCnObHtvExaoAwWKhjWqhVzitq0j5khgwEsaU6beU=;
        b=rP4RCeeom2ius2iULpO90/E5ogtzTW1BJ8jE0yXoFGeY2KuILwHq+OlhOzNxZBOEkr
         24Gz16uTxnCkWqV5WZpNk3ZY4rJQXMlNid4OlYpmCerYy1rDdHOwO66pDgarKu1QU5Ss
         loI1WscHCA4iZF5hEGkd/PieBcwPEN8rH9T2PCn8n3qMqazlOlHiVjWlbDQY8tYJdSe3
         GrTb8MtpLoOWSrOuIWwXAgzlIA05TAByftes2Lpji9rS+71WJNpR3wOdQOhdnrTmq0Z2
         MHwoJ8LxF85EffyEg65gnHcqaGdRzml1yLBuKvj5CCI4MYdD/2z8PXg3Dhat9dMBtIEu
         RnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760677163; x=1761281963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FUnCnObHtvExaoAwWKhjWqhVzitq0j5khgwEsaU6beU=;
        b=MA4p0PLo2QzilZ41GvGtVGISjp1l15CV946cTbIESOqiWNts5p75DjVjeOc3YFuWtb
         iU8Y+R7JGFIwO1N+ryXQzXWdEodP3iNAHDlSYQIpou4v9cN6Z5TAw2BCgRyG4Ia1WuEC
         Co7/9iiLSlDFtkBNr/XMNyNT7EHPnsGYXdaboWhdq5JnFBL9TAPTmYZj10KowOfd62B3
         g5Ah3VdaiOxqbNc7rlZvNAyw3JR30fkPEDdnIOPzkqjCEX5a/9PXM2ZE/sPY188LQa+4
         AfvcgQ42Al46/Azsjdf+7VNN+itn7X35xRs+eUWvV+GrhkHquoS8HoP3jCrgmZF3ODa6
         qRlg==
X-Forwarded-Encrypted: i=1; AJvYcCUbfEvO6QAkFTj6ryOF1ny+p+dvojFVk/yD1AXvi+FoI3+XLKiyXlnRI3Z2ZbLOGRH2aL0eHdoCil25zjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQIWFqM4aI1nUZZBQZibK4qE+mcGkTd95pGwxPOZPI72nBX5H
	hn4UEejdHUYqR4eJzmvabl7cXds3QbuYfonkj46xgMvb1i/VOtG7CK7WoC7udZPoaAs=
X-Gm-Gg: ASbGncudE+OV91GV1pOCAEgC/SQj7wuzxYvBJzn3WLUJJ6HwMfIIyIeflWK8wU9rcjy
	KBfQZrQ6jiOZsnHpFMcDBIbjghFzJqlkZho/gebXmIeiMYwfwRvkdBJvv2odxH3X1+8UDVgZqZb
	h1EDFahx9f4NNW5ica8PUDCfBIDChMNJzMVYb3fPD8doO0IyFartU6cyZWCFS90PMXYbuBVpthw
	+S3tGdCnIndTuKYVj6CH6eXfSSGuNT63A2nXeewxTDNEsFfupqhs3dN//d7uOR1dBjCgnGqV+eg
	fKdzOVKXgwfsqMoDuJ9+Lx3DoUd4Q75Q6Tgc+/k4RDu1J4UhgNyA5uGLXtBdJ1lnQ9kOPilbSp8
	0lsOti+R5KeNLZ1YHqOLNNvDxyr0cgPDT7UhqEFFZxSzoYHf+qaYYlYfIESd7JGSe1rtl1FNoIw
	pAKpIYQHW36nc=
X-Google-Smtp-Source: AGHT+IFYxqz0Ttcz8UykimpyIaiCfE30akXHB7FNTj96qec06NuAlaW4UjbM/IwFrLs2OKOR1FkUpw==
X-Received: by 2002:a17:907:7f21:b0:b42:1324:797b with SMTP id a640c23a62f3a-b6474834edemr124163266b.9.1760677162690;
        Thu, 16 Oct 2025 21:59:22 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965c599sm718858666b.11.2025.10.16.21.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 21:59:21 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Restrict resets per each device
Date: Fri, 17 Oct 2025 06:59:20 +0200
Message-ID: <20251017045919.34599-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bindings should be complete, thus complete the constraints for the
resets by adding missing compatibles for devices with two resets and
"else:" clause narrowing them for all other devices.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
index 119b4ff36dbd..9f5f9af6f6cd 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml
@@ -215,15 +215,23 @@ allOf:
             enum:
               - qcom,sm8550-qmp-gen4x2-pcie-phy
               - qcom,sm8650-qmp-gen4x2-pcie-phy
+              - qcom,x1e80100-qmp-gen3x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x2-pcie-phy
               - qcom,x1e80100-qmp-gen4x4-pcie-phy
               - qcom,x1e80100-qmp-gen4x8-pcie-phy
+              - qcom,x1p42100-qmp-gen4x4-pcie-phy
     then:
       properties:
         resets:
           minItems: 2
         reset-names:
           minItems: 2
+    else:
+      properties:
+        resets:
+          maxItems: 1
+        reset-names:
+          maxItems: 1
 
   - if:
       properties:
-- 
2.48.1


