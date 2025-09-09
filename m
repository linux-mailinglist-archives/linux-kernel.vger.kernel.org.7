Return-Path: <linux-kernel+bounces-807808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3992B4A996
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9405363E76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A653191DE;
	Tue,  9 Sep 2025 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyPKfPFR"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8732031AF30
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757412494; cv=none; b=HRiCWD3nAM/wLvvs+MvODe/fHTxKviFv6b5+dm3Dnof47qcm6tdx5LIuRgZ3Y5OBp1FeQL0xf2Z3hLaxP0kAx6G8ws9i0NBxB8aAdu1NNf3rh92R0ZYH4mlzM3NCgjdpiNiiGbYlCvb79iCvqTYGS8igk41d71UYJdRqxPvIwqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757412494; c=relaxed/simple;
	bh=ItF/HMZ6S5OBCHm6xKpPP46GBkD8+N8VkbEbVV8pWR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1IxVfvKJ6X/pqwzqujcMtc/P/RGmNtHRQsHy1HQZlDbEw+beF+yk0NrQwdmTeqYMK7LpqBFZ3BDCfjT4Jhmwc8Cec2FuYhmFApK14Mh7AMnQ4RqU3XazDHbsg54/P185b2a8BBmLceBkZlrVIHxpJx0Gg1M1Q8uOdWhSi6t7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DyPKfPFR; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6237202020bso4967967a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757412490; x=1758017290; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x8PKsA3hbcCLf8IUQFKdfKvwoyrjgr1CbYXvf90j8TE=;
        b=DyPKfPFR7CJHyoiKRVe1PMIb/sgVczCs2kWVDrCRrnIzszAVKCpNJPjyFPPHQtg1jC
         MWr19jrgKcIOXMl4HZrzfUtiN5/eISDK3oDoPf5XbbKQ8fwZyOs9vkN8PrKakWQ57cMt
         ytwGjf5cmeLgh2YvhBCAiofpKIYvqhKJKCB5wRCghJ5Sf8MWNOhUOITIMH6251RtJTNz
         I54J+Xy5wzg7wQ+74LOur9w6wqeGOLN58SObWE6+iLrGGVPqPmYESsjF29f9snz/wpmE
         mLcE6ON+jQshZphmpZWS436CcgGcgm2oYqmT0FBXj1Fba7BhIQ3oVhb1XmWPoNGGbCFo
         w6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757412490; x=1758017290;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x8PKsA3hbcCLf8IUQFKdfKvwoyrjgr1CbYXvf90j8TE=;
        b=iF2A99Ex1mMv9sASYv1BQ7zGpjoSdt4hr2kr5SQeHZxwv4Kp0lrZRGC/9aXcIuY4Q2
         f9Fg2mNQRWJyIbLStHmKsl7LWnmgpDTVZ5DoPujchlQ2MtOCWI2j3BXtvrXV8SC2aWBT
         MqHZun0IqQ/W+ft6QakPcqH+Jw04BT7nhA2tvuGdT/SaBmUWWAlVXWZU43KvW7OJ77eB
         6PbB0XnMiMvHoNliCG5ClIvJku6FH8UFEezYLBC/l1IrDuG/fLlEvah1vPSpZhaZsE7W
         Tog1rl3cUdnDOFQicof6u0x8GYFOiCz9/XNXBNfOv/T8whlI5ItOQHFFM2yIk41+0Gvz
         5nAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Rkm9rgwwzeJQPy6IN+AenzO4z3SHF7S5pEwQlrnXbY8vgFBzVNSfHR6NYOxHqq5n/VFcLTq0Vjz0hE8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYzkbLT+NH3TDCQQ++oV+4yHfVvEc6YGmDEMxLrnCG4R/Cfo2G
	fEXhVwKGkO8kHiMu2q7cF6F0p+Ii2h6MvgDNAkSgbz94bub9/3qTtgGPLkyNLlQ+ZWk=
X-Gm-Gg: ASbGnct5u9cn2OpLvk3wnoLI1fuDaFG4NTA/SC5CE4bJV4T8g5znMXjrxJrA7b3L4Ni
	EK3pDBz+j4eY0rcJhjKDzkQ+8CBmEmrZj0oLWa+tqpaWlGKyCRAHPcdB4xGX0bx3RRa3kQDiFMh
	OULGZPzRQKD/K2aIIAx05GiuhAh477DF5T3A0oY8N+Srpet1uaoTARTuD0e9d+ayzHQMdurmGvb
	gx5+YR2I3lbPuRk2we94hSqjHBAcafHM0pdM4hxhbbYrnJF5yvRC5c0+gJMr60/2nOUHmK6Nrsy
	zM1B7ionP2xPYUBjbWBRVKbxDfYqQs8dMiJwr+er5mCLOdcaFOsUj1TdjSIpUny2m+aPEwdmyIv
	opfna4jpZc4UtJNYyMBXvMg16cIk+Z2Pqeg==
X-Google-Smtp-Source: AGHT+IHWfA/NvJtv795An80ISNX/g4eyZP7imfZNeAj+7gmKXZ9qxdyvphhOFxdTr84Pm2VwUCUoaA==
X-Received: by 2002:a05:6402:2342:b0:61d:90d:1431 with SMTP id 4fb4d7f45d1cf-62373df67d8mr10477327a12.10.1757412489840;
        Tue, 09 Sep 2025 03:08:09 -0700 (PDT)
Received: from hackbox.lan ([86.121.170.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62c018f65afsm965379a12.41.2025.09.09.03.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 03:08:08 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 09 Sep 2025 13:07:26 +0300
Subject: [PATCH v2 1/3] dt-bindings: phy: Add DP PHY compatible for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-phy-qcom-edp-add-glymur-support-v2-1-02553381e47d@linaro.org>
References: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
In-Reply-To: <20250909-phy-qcom-edp-add-glymur-support-v2-0-02553381e47d@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <lumag@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Johan Hovold <johan@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=976; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=ItF/HMZ6S5OBCHm6xKpPP46GBkD8+N8VkbEbVV8pWR8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBov/yBnLAeC5QI5RadrWtDwrlJlInPJ8UyZpMNz
 G/9Tv00Q6GJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaL/8gQAKCRAbX0TJAJUV
 VoecEAC3pWIuV6FBpIuIUo6D1ojM+HtFHItx8awv4geaaiv2Zdp1AEJBVAujCULh0YMA8HFmx8l
 /eY6zzEEC7IdNQHeCf12zWHq7bmpaeoSvcYgvoH0wHiSXlWfGjtMKSvpOeZY8WpfBOqcVK8qxCm
 1jDmDE6PNx0Mh27L7Ilok9kAYhfOQgGJOAs1vjOdwbBGnJroyvcRUMc2jcVA5hKzJ88+8KDxMni
 UV9IIqmiepOMt2KqoBEwW9k/vXeuRbuhsQAE1Yh3Jdmxneg9l41zTmsQ+KibWFNQy8dWbdvgm9b
 0UC2TBx8MiZnP4LSJLHTR3QtycEoMNNjexv842gA3ZmTrgvo811T3kz9H9Hem49iN054a/XfGFg
 2nbd6SMtOtf25eMMbmOY1+zs1vYiDaRFtvgdk0nXD4DcNAlDfbfqZIloOJCsBuSJzw8GbPsN8LG
 s87m/FTHqFxqsZD+aFMw4nmpSM6mOSxbwKnPUEvDKqEfzEMUymD2Mg5Enc5Xarj1QtFlYl6IkVJ
 CvIsudaSY6iIEo1I/Hi/tXdFl6/IUu5wLbFn9VrN3bXbYlChToiG3FgInvX/tmf4J+SRANaOfEu
 WX9rHwC0C5QEOHj8L9b/gCEUaJOw9GGLHwDXwFk/tvN+lUKWWLWjJCsI0zDXByb/2swPqW7uKe/
 ammrGh7kjFoRxpA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Document the compatible for the Glymur platform.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
index bfc4d75f50ff9e31981fe602478f28320545e52b..4a1daae3d8d47ca5f08d97a1864cfd615dcf108d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,edp-phy.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - qcom,glymur-dp-phy
           - qcom,sa8775p-edp-phy
           - qcom,sc7280-edp-phy
           - qcom,sc8180x-edp-phy
@@ -72,6 +73,7 @@ allOf:
       properties:
         compatible:
           enum:
+            - qcom,glymur-dp-phy
             - qcom,x1e80100-dp-phy
     then:
       properties:

-- 
2.45.2


