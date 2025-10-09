Return-Path: <linux-kernel+bounces-847054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 14119BC9C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 17:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02FA44EC219
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 15:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78F3E1FE451;
	Thu,  9 Oct 2025 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEh42Sh4"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82C1E3DE8
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760023509; cv=none; b=BtOCb7QABU0BQcwS1d/61fQSYcBasv/dmrLA+qsxUnyuDKtuQhbdJs505rT8rtBO+8f/V7AFP5ozqIFa3acV4uEKtnJCP9HVPcSM6Nbb26WMRMgSeBB9jWLEp8QCjVqrcr1YSzCdEHtD6iHCxCursMYw9c8P8FGMJ9dIbRJk5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760023509; c=relaxed/simple;
	bh=81jybtZ3s587CJJH0yCGA5kZLJlEWI3joc5fyisw8bc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQNbyPN5Or+y+PDkSTy/R9u3dMNe8RsCVRYpGx/w2tzSsorHVgnbjbpLek9D0gQXicK9M0qjeyvYzPh9v36cGc2UTV7Owns2hFrHPr4Lf5HUA4CEkAF62VtKzXqeD2Unk2lLqMbF1CoIV2V7MHrdT3N1Kd/YrH9Xi0oDZOY+z0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fEh42Sh4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b4f323cf89bso194169866b.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760023505; x=1760628305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B84jNTg7Yo8n7BGFGvQ15A/U09IRq0iw+ObZ/DfjbTI=;
        b=fEh42Sh4ZTts64I9k2hI4wxmvYV/aV2JAlYlunGkCTwvM9L1hUhnv7+dYxSRe4YS53
         pj3QAapZrKEXQIPUuCZ7bvfbr8HT51lpgDtkdd1CHWkhq42Zf9WMzdoyfB6CLtUSZsiF
         6fuIHhLr8YETYNth6R6Cavjvxz8YKrQzoab2cxpXsHMucxSKzQpQTxcXzYbe5ZtyMtCO
         kZ/xcXEO6gwJQvsPKdR7MBbcT7oXMCELC5KXR/POQ/v6+wquLb0Mxe+yPQ4eRXXkIh+n
         +EgGyx4mL9FB3Gf6b/MZCemuqlIPSMSHcetaEhukHJcexbl4dH5KJDvNDZSbTPY+Yicx
         cFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760023505; x=1760628305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B84jNTg7Yo8n7BGFGvQ15A/U09IRq0iw+ObZ/DfjbTI=;
        b=HmfNaLC8QZQM3btpONN7E8U/EBa4Ne94+KnqRZ2LnFNdoFme6KDkaruzi/BAb6RXWJ
         cumy43HXYUZqDdl/2BlzwgahxgH/iSN6GCQTYJB9n9SQjMPL/n8AHO67kSA+yNrAoZ1s
         sWLfYHi/pSUrO0PKWBaSWgQ/a3usMGa2d3fAjAX/F/EkJccgnsb2aqXNzTqaM+1vPkCY
         OmoLzql3bEEkLF1+HX7jDtAF4QiCKMZHzUsLMSRcjbi7esbXMF4HTwU+mf7hAbuC+mY5
         +GFSB9cejodEv2cGsSpo8J4RgSJOgTlrY8dlnyhOBcab0ksvtZ0nQT6K44jyemdhFI6e
         8rfA==
X-Forwarded-Encrypted: i=1; AJvYcCWafvtMv4T5AacxWq1XgOE8Fa4nNvKe6Zgq6buKq83jXx1eX6+pKsg9FdQV4muYp0aNU/wd+Hcu9DcZ3so=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTRq2BTqLJiB+0pvhqDaB0Nl33fSPXR4s2te8tlqMzSPNDOPhk
	wkP7J/F+Ubj12VwSnw3unenkWgBbgAG2QlXbCROsVLBcg/eNhwYfuZWup4NuH/UE2Oo=
X-Gm-Gg: ASbGncvJbjZj4AuDicArlgLCS33ZYVQXPqKLtjZQPYmclzG1FclbE69j7BtDgcg4/p5
	5HNTNqkVYffZhxA4zL+ZV74Oy9dSk1mvb+Ria8F4X3FplglWbbnJ5YtJD+jxrwTRgL/71q/Uc8c
	uLz4iZoqAGIAD7JuirUUb9ratpCw3c2pv/OypmLglGCtKTtl8Ey+X+N7Rl3s6OKBxZ73NtXeuEv
	eJ5e6UsNvkNZ1GQPh8Yz9T99NmIcM+X059bGvQ6S9dtDnPmFLsEdWFQFK0j+H/nW/osvCah+Nv0
	t9/rW3pHz9Qz7yhQDmcpCjP4+lQ1lO5dN6GIp4GYKf5XHJhqnaRQlvlyzfnTzJz+Jnc3nkr9SOK
	2Fy5zforRLx2q6shL15MyRUnRS30BpTM5/7MSTxbIMx2yv/BBZ9VC1osqxjuy/mRM0JRGxy6XqR
	kWkcfoJDBwHqn+pMr0sBlpIaSQg7hsY6vNXonnyQcA
X-Google-Smtp-Source: AGHT+IG4E2/BkqY+k6KCaob1FvNFhboNdxx7lEaSwbr4nblUCdc4u24xC8dmKvD/tTwPIY9VM74oUA==
X-Received: by 2002:a17:907:6d19:b0:b45:60ad:daff with SMTP id a640c23a62f3a-b50aa99e0f1mr827465866b.28.1760023505329;
        Thu, 09 Oct 2025 08:25:05 -0700 (PDT)
Received: from puffmais2.c.googlers.com (224.138.204.35.bc.googleusercontent.com. [35.204.138.224])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b36fsm1908967566b.62.2025.10.09.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 08:25:04 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Date: Thu, 09 Oct 2025 16:25:03 +0100
Subject: [PATCH v2 01/10] dt-bindings: power: samsung: add google,gs101-pd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251009-gs101-pd-v2-1-3f4a6db2af39@linaro.org>
References: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
In-Reply-To: <20251009-gs101-pd-v2-0-3f4a6db2af39@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Ulf Hansson <ulf.hansson@linaro.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Peter Griffin <peter.griffin@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.14.2

Add support for the Google gs101 version of the Exynos power domains. A
new compatible is needed because register fields have changed.

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 Documentation/devicetree/bindings/power/pd-samsung.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/pd-samsung.yaml b/Documentation/devicetree/bindings/power/pd-samsung.yaml
index 9c2c51133457112ca0098c043e123f0a02fa1291..c35c9cb0115d79e5c36142da2c2a5dd30cd2ad47 100644
--- a/Documentation/devicetree/bindings/power/pd-samsung.yaml
+++ b/Documentation/devicetree/bindings/power/pd-samsung.yaml
@@ -19,6 +19,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - google,gs101-pd
       - samsung,exynos4210-pd
       - samsung,exynos5433-pd
 

-- 
2.51.0.710.ga91ca5db03-goog


