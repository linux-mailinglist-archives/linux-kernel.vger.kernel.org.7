Return-Path: <linux-kernel+bounces-852306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13118BD8A8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 12:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60D0E544CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 10:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B72ECE8A;
	Tue, 14 Oct 2025 10:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rg+Vx0Oy"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D572F5A13
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760436179; cv=none; b=hH053QAJPh2ddur2dcwDUpiL0lBvgE6cLixjJOvvHs4n0NQV3n82jgQ7/mP/ECY81NAYWEVn4RAz+GWdNtSPummFw3g0b99JlGNj9mmKCOKXz8nD6gFi+TZAATYOkIdnGxB2HGspTuIIsLGU2Cuem5vJbMqgUvrt+OAM6W1Qrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760436179; c=relaxed/simple;
	bh=SjQNMcKFiFxf1UzqcFbV5V5FIrz1nf5P1xbHJ87t43c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XFC476muCmzwVyKL00MJfpkWfm7KqDYhzTroiQZVnD131Us3WSBa1vQrTHeHwvEbnZNW8OGHXF5U8nHUKD67ZhJV1ygCLu7Qntg/SFcVR+MJf5aX4CxlxHT/axIM14l87NO0dNtCQCq5RF0grpR8q/DhpWIIr6sBR8YW5e4XmgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rg+Vx0Oy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e6a6a5e42so22427965e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 03:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760436175; x=1761040975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cVJfqn+CURZR5kgzfDjtV++23e8mA5V4+ieWpLbcMzI=;
        b=rg+Vx0OyC0tKcb+PkXiZfGOl3Wxsg+Ht/I4kztmIH7KvASEMHNz7KHbBTf76rS4r5U
         b+3sgrQta9u/XoKTRefaOncJ1aLQ+I4l6Hctxf1w1NQB8ZNpygG1hOlzzNFJQs0iCbK8
         KR/7ce3g7xI9c7PhUMs8SXVWyccNRtNvKVtyfiks5F9ahCzxr5H6p3aUhFHzWllWkdCK
         RyZho6Wui23kftLL7Jp9cn8V7uPtQYUFt+ID3r8fZ66wsUG+t3slaibv735VkD/A//kN
         xgFe7e6dLO5z1SCoobg554dOHN9MXVWr5U4AwZ48hsfogNg+tTdaDCBd+Fnh674jEAVt
         DHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760436175; x=1761040975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cVJfqn+CURZR5kgzfDjtV++23e8mA5V4+ieWpLbcMzI=;
        b=N36m7nNUsBsTXE7rlZesSKydBD0dHDijco7fnlMrAzpd088l/AOlPvS4hRQ3JPNHwT
         ydBu4vjTGqSPJFfefGCzanqaCOLOXHcPRgKG+AgxMw8r/CmJjrWvNlLUrbXnUcXipQeF
         52elJkmcxxb6YBlY/KbGoLSyT4PEWzH2MS1P0hLRDPDxZkeB3b63F3Q5gnjOnpCs6wW8
         60CwoppSP8QETMt3cV5i5KSRKaMYgc1gVjvgYvFumotabU/ZAN/TdQhl4azO8Ukb0Vae
         MMW78Au0lyGJ0ew+cWovakSNsi0HJDw4cuDiy22NfZ0pRdEoyWW3dLMGaHxCOZuhCjVd
         xP3g==
X-Forwarded-Encrypted: i=1; AJvYcCXNfKV0XrGnkhsmlijt5kWLZWPpc5rOPz3zDm2Bgd/FMIrVcD41OPI5MDauMPKm8VI5oXonCd5Dzd6dIqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXLtMskKdkR3GNdbt54u5KnXOfabSzJ2V+GM5ryiwgqrq48wH0
	BG4LzLJLmwmOK+FsjbqWAN0SpQ48NqnwWuzmg/q0fvtOl3dN1+CZDh3fPuljsI+zF2g=
X-Gm-Gg: ASbGncuOoxh2A3LJMz/nOSazo48G+tRGt2v9zbhhRbvnV3F0j9aRbjS5H2yfj+qmnbl
	92z7xl65cMUYdtw15bai+nES7DXL/lyGInDcqCTyyLVyUNtj0rfgUJSaENCX5NerLfL9ZB1mc9J
	SNcDXl+VIMc8AGgSUR1+fnKTka56/r0XHJHA9RmO0KLOikC58jk4VzaMsB/DdUD5g1tPfNAb5Bc
	rfwedQ3eV9s6GWFxvC6edgN2BHwM9Ygg/neN/zOzUoF7+rH5L/VMUdkAfdQ0sYPUugYZQ7xRCKh
	oxHHL6rZGhc8Yjng8THDYxe2rPktHwNDDoAiedES21YkUhwfNVsSSQWMn0ZRg+0NsJNCL9k9toP
	2sSQHNVKjYisZ4d/jCYxVDb7Uad353VUfCgVkP+uibDw=
X-Google-Smtp-Source: AGHT+IHn1J3P6w0TT3kflXZRWIHbxv02CVqgaJ7Zj1UOEcse11mXhprORjqLY8jjisVskI0JowAdcg==
X-Received: by 2002:a05:600c:1e86:b0:46e:4581:6634 with SMTP id 5b1f17b1804b1-46fa9b018e1mr176937295e9.29.1760436175311;
        Tue, 14 Oct 2025 03:02:55 -0700 (PDT)
Received: from hackbox.lan ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb489197dsm239615305e9.10.2025.10.14.03.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 03:02:53 -0700 (PDT)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Tue, 14 Oct 2025 13:02:27 +0300
Subject: [PATCH v3 1/4] dt-bindings: phy: Add DP PHY compatible for Glymur
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-phy-qcom-edp-add-glymur-support-v3-1-2772837032ef@linaro.org>
References: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>
In-Reply-To: <20251014-phy-qcom-edp-add-glymur-support-v3-0-2772837032ef@linaro.org>
To: Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Dmitry Baryshkov <lumag@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, 
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=SjQNMcKFiFxf1UzqcFbV5V5FIrz1nf5P1xbHJ87t43c=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBo7h+/P9kfefQL9Xhu238N4OW/+ki3a8ZQcLA+5
 /LnZTJxNsaJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCaO4fvwAKCRAbX0TJAJUV
 Vg0BD/0TH9WNgHrWjeqkeEuXihRVj7jKEy9+iMDKrSQ8/rwR7ChvS6cRGpe+u/O4DAzGomvgO8Q
 lx7b2fwpoWlEowETy6PImWEB2TmpNXUBdD4zo/BDHLaoISEcdcHToJpihgWYI5rMnQ9zhRIKshe
 q9ufkvxu3L/+/u+FG9LCc7sES2xB8WjJFaoPQpROLNfaNB+9455YfeteCb3SvePUAzbtO3qJavG
 P4igEdfz7GaknEHv9wlIiYb08v5jJJKCc+PROmlHQfojvQvbED6Rn9+YuymS57MnV0bhTRt8Mb9
 QVXW6+6YpfLU3eTjLBgPlrGF4wjF0kuAl766P+FjYwDscU0MUaTXk3FVehoO2uLB3KXmXJpvpQT
 zTlh2jLKjy/lJk9aHxChoS/hVQk3Ac+U6LPqYcfEplRrKF9nXeBWYoRbQ4+olOltcY01+QnIeKx
 1Pp/9Wx2UxS4HDM3pFw8g3MvCkA8FRpo5kcQXqDBFVt1+kFy0vUhmlD3SIzpzohIgWX4m1+tx3X
 WsPCgPkRq9UoKN9VSpzP1urz1ueT52u2OrGpa1X0AbIvOCaE+eBdacV669Tgx/F1mk6nR5OynX7
 lar0vq/2GI9bGPxHKSu0ZAvctRDk2YWF6csnxydqF1krfDNbM0Gh7dxwEVGM05IFMnpuhpkrJLX
 dxT0tKQyUxjylrQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

The Glymur platform is the first one to use the eDP PHY version 8.
This makes it incompatible with any of the earlier platforms and therefore
requires a dedicated compatible. So document it.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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
2.48.1


