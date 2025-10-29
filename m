Return-Path: <linux-kernel+bounces-876553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B988C1BEBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEEB65C17FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D389A34575A;
	Wed, 29 Oct 2025 15:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ra/9fSiG"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF341338F54
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761752467; cv=none; b=lJh9y0BZP0PSxTaDhVT8HWTKwyFAf4tK+Bk12tx4VXF3EQ99O/tPl6JjF1ssUOPu0V4D0iZRHG07VQgiZt+KmSHIYA7Uncn/UsOBVMM3XLzcvCvPcyY9zjMHxgWUuh+QWWWquDneflnfrm5agFsrwvqUz2AFzb86NERKQiQw5dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761752467; c=relaxed/simple;
	bh=jmZDND6HgYX8EZDdUAJP/IquD3beTYD9OCZKg3gtY5U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G3Vys7PKivF1ziDFX+6NxXPIXIqxqqyWpBxqpXcWgk5DL0Ud/FLmrOeDsC2WKUk0UVnpYb6C2mJfP10TTLUDwg5aV+H4U/xz+3Rigux2UPijzi8E4r9YKC5M98wQ/KlFcQ/3ZlGFuy1GHAcdJpX6GOdP3khzheLNPy7/6SxCM8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ra/9fSiG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3fffd2bbcbdso519911f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761752462; x=1762357262; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VxI90H/RvA6j+47WbvbjLy4lY2bQBr0L5l614wF2bwQ=;
        b=Ra/9fSiGcI7N2vrUAw+2qeKQ3MweoeRYW3rjZys/43icnJJfxWqeKQP0WSgZqQnLXc
         KGGHl0C8uDKEJ70aaztiAMkpsaHjl5wly7oLcVc8a5XMbHpqy8rXgPKuMIi6xqWXs4Uf
         UPKXNILrzwdHAwg/C/F34AFa6Rwqu7veTeaP3LdvEYb6nhuV1ztUT/Kn85nqK65JVpvg
         6dpt93NBjUVAoxYDEyhkxRkCZ6uUP+YQ+WiTPLQXE0srmkHCcmslTruCN4RFWNqGypdo
         +RQHCxRmupXylhYZ+lLIMBBkeUrxb78qe2NyCv0WVoaBeEgrAe9hhMMrFclrHb6n3p5V
         +fnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761752462; x=1762357262;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VxI90H/RvA6j+47WbvbjLy4lY2bQBr0L5l614wF2bwQ=;
        b=iCD/cV4m2RMxm2JwHwyGvCwTuD+tsib1fgaZXl9NCUhPvMah3pGyBR+pCxgoFnuA6Z
         ep9csbPRnGpqoJWJ84FPMjYh8DSF9T0peOtKgyd1V4Xrl/2+yLW+x+3Yj/gRxvNBym84
         YsGsYYZcBpu/Q/wYg/6j1uGmAdIP/oK/CEnXHH2eHviRIwUfIibU/zZcKzwFJTie2Mqb
         ZejpSmokeaK1weIKEoOciQPhZz8H5zfEgWxFgJxNmwn4K4CYuUBkEKu2wYNqsr+CWiGX
         nS48vj/DMlwxELXRpukGwYwl4BRNQ0TEITbmhrDA4cvpHzDZ8S66AdEJa5bcScfVIFne
         hu2A==
X-Forwarded-Encrypted: i=1; AJvYcCWUOJsxs5fxpE4ck5L1p+6/q8+XZFmaZzTzl/iyWfestjIloxJQymu3I6q98vHmXW4JWdE1jbBWqqJeSDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKOXRAVCV5IFz6tpjBeJU9NYuhVHfA0fJ11HfY8IBxiODS/Yq
	OdF7W8B5yRLNurRorT2OSRupd7xSoLwSpEew1HEBg39SWqBwG1JO5EG2W68bqZMODuo=
X-Gm-Gg: ASbGncsu/LJkCPdJczqf2CJERzq8JFLuL1V29GHLYWUD5UKrRm79VQZoEmCwFlpk9FE
	FBcAvisRwKV7BPd9PiK14OyacxZkmMHFIvwXJ1caY3DNIdGY/g0nBvqEenpmYCJahKFzCYGddj5
	1hrXJxYQVXNKHMPuIQbKc87EUBJfUQeC+n57pnCVKSEumTzvFlUW+hs41c+l2sd2CVm9ms+Pa5r
	u1ChdXcnCpAk0e6nczGzpKIOzMesMEqVUp2ud0Tjrum7SsM6lyTvyeldaTYpQ4nOfwN61wIz5Wj
	aRrx7LVZLwhG4fldFQb5WBxVBmiXgmmwQmDvCWzqZ2wki08sxJt0JImmvI3oWrHlrRzolqdLNjv
	5vvgOlkFuoSXkwTDhO+mq0a8HojWueXzQOxQd8f0pdO3K/6JzQRe0wVAnHAKMUAo3mFOeWD5XwY
	ARcSdHC3IZ3fyvEpqa
X-Google-Smtp-Source: AGHT+IH0MTxj4KideKlmnNCTWGRH1FJc2DdwXawsfzS+YbdnXfbjerZ4hGirRpqlsBnBP95NVvOT1w==
X-Received: by 2002:a05:6000:2088:b0:3ee:1125:fb68 with SMTP id ffacd0b85a97d-429aef70b89mr1611585f8f.2.1761752462598;
        Wed, 29 Oct 2025 08:41:02 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df5c9sm27006875f8f.41.2025.10.29.08.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:41:02 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 29 Oct 2025 16:40:41 +0100
Subject: [PATCH 4/9] dt-bindings: PCI: qcom,pcie-sm8150: Add missing
 required power-domains
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-4-da7ac2c477f4@linaro.org>
References: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
In-Reply-To: <20251029-dt-bindings-pci-qcom-fixes-power-domains-v1-0-da7ac2c477f4@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Abel Vesa <abel.vesa@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1043;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=jmZDND6HgYX8EZDdUAJP/IquD3beTYD9OCZKg3gtY5U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpAjWBmcy4XgYDlp4xPS0l52FU7QL68VmVi3wFH
 JptIegewAGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQI1gQAKCRDBN2bmhouD
 198pD/9wZok/UWTRqJu0zO4NrX3NW/CSMcltjXyHSXz9f1CNq4CDhov3GAq2fPqNYAwFbGZg4eg
 RmW4EAElTFoutWfp5ht3GhccOCMM5nsiQE44AhZaDeLujUn8kcnNS48fpVjnkFgnYumkvmcBeQN
 51PHrVGSPgTW26Sex0ZDJTwPt//BZ9o74QJ3Ief+fJQtN6ACsJTEIM7sewm4dJw3Y5dsNeijb92
 yjYNeQNfFD6NIb7PZFUgi1yVT0r3IBWtKYFp755iK3Agjfm/XrrHwqI3DidgoHYEs4HsHk13Xxp
 rIvGsG3SMJ5LYSavdm37X5/ENlkLpj5NjC+dmBArbBkLbjQjs7/1C9kqM6fCG/5Tc24aqb5hILX
 Av6B9bUNOaeUuR8YdSfhVtWQZy4i1venuSxvdFskZavcp//gfwW9TzODZOSu76kC7ZYRgcwaxHQ
 cnNu1+HoLlP8JvKl4i/o/U108JORS4vsPO4uXxasvgGhumQaA2c22t3KltmJ//0Sod88rwonAe/
 wd3soqsovOfNnLqFv4oTgT9TBdr2NTbuVxybhlnHRAh89YuK18KHuv4kP/UJNDOMyxvF/ZerH63
 QZpA98YSVZSkCk9mrQvkpKlXcEYhTxEaB7RhJW5TbUB5mj2Gc0zHAgO1nzBk+xy7haa7Tg0TkaT
 WXCe62oV/PbTsTg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Commit 51bc04d5b49d ("dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to
dedicated schema") move the device schema to separate file, but it
missed a "if:not:...then:" clause in the original binding which was
requiring power-domains for this particular chip.

Cc: <stable@vger.kernel.org>
Fixes: 51bc04d5b49d ("dt-bindings: PCI: qcom,pcie-sm8150: Move SM8150 to dedicated schema")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
index 26b247a41785..ceec5baedcd8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -74,6 +74,9 @@ properties:
     items:
       - const: pci
 
+required:
+  - power-domains
+
 allOf:
   - $ref: qcom,pcie-common.yaml#
 

-- 
2.48.1


