Return-Path: <linux-kernel+bounces-672924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8FBACD984
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 10:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B3B3189476A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 08:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C672B28C2D2;
	Wed,  4 Jun 2025 08:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qc+ILPPR"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D9528C2A3
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 08:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749025150; cv=none; b=Aq/ldSdMzRGLR0ygZVdwH30J5A5opkyOHkE6UnEYlY4pZ2M47K1sMyKmj6/3jhodtA4ereAqrTETB1sQuWzdUPUKIlZduMzaDT5AK8WqziNWPzhHTquZl8Mn+MOlSyhhUHHV82TkA+NVf3sI7ln+N0hLkPPZQcHWZSZdBMB6LBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749025150; c=relaxed/simple;
	bh=DRCW62SWNyHDxET2rFNq/PrtoM5W1wDR8OS8EcSqkBo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJ/CV/Z6sei/9KX1CdhxksQpjaYnd5l9wJS3SfqsTxandghk91LB76t4xHiSg1C3HFjBhQApmlLxpyEpkq+LesaIJqoLM5/PqWKRCqnFtEOULRjgf4f639b7DpSix2d4VqIOMl4tIU9vtDQtbweeA2Q8oMyJMQUtu0hdpyO7zlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qc+ILPPR; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-450cc429478so3741715e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jun 2025 01:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749025147; x=1749629947; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ktjNH4EI2pmLPKIOf3AQOMvDxxrVNBtl13gKtpvYvc=;
        b=Qc+ILPPRs4ChZECCDSkNvit5vJp0sqLRdNHWSsMOEO7MlqFiaHnEw20VAut756Nvp+
         B+gtRP+KElCykPfpumYt0i7TA8sp8/zFfUFQGQ4NTFWDR/gpS+ny6N7THK4Brciqjgoc
         GfFEQ0bZ1YIK7hqt764yV0Gq8FxsLizMk5RRy3DbsFlrULMSFpd0M1gsbatyHZdYgEG6
         Ijzd5ouGEWquF+LOX1MNDaDY8G1JprEhrp9witK5nXzoeW/n93X7LVsW8Ht0oEbiHs+H
         2Gdd/kZ35F3L5jLkK2ENFHrwThRUCFgTLFIREZBu3Hn4enVEdX/Jf+nbUMi/W18s9K64
         FwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749025147; x=1749629947;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ktjNH4EI2pmLPKIOf3AQOMvDxxrVNBtl13gKtpvYvc=;
        b=FrLUI9V8zSfSYMMDODKUfpV4piAKDzgJCjUcPt14gj6mB2g+p+PbsGD+nAvDHZg83y
         XKVbklPhDZheqS3lCBEInLOBv48bETwgromFrPV4B2TVdWHeLGKnjEH57rUtZtGExwsL
         XesjBhC3r/dBygwyWhcQlo+QMK3BQYq0A6yPnuXhALVucrw2oWo8dmlX6dJLeCNeZtFD
         ePdkrwXJ/mOXkdYhmGxhjvw8YWFxo20f6aKyo3DfPCXXLF1Saz7Wu09kiEPgWoU6XGRc
         CYePxcyNoNk3v3p6tOJ/mU2buEJZE8pRbG1xp9lhlQdTpaX7OOlZ1Moj+Qn/3RE2DAaO
         lYbg==
X-Forwarded-Encrypted: i=1; AJvYcCVVfGDldReayvwWx+HN3Tmm00PZ/gCtCCvzTh/fTA6SNwleRwIr/6P3Lh3YlWazjGG6c+lOIxVemJiV7T4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgReh6hNu9Yann8civ9zArvXl6i+/7K740WMG5xHzyd/fUrPZw
	/4gjMgMoNkBRi5oFQPZszePHYZPuDyeWRP1mjsKppjKMWeyG/L0L2pwvX1lmJMuCVCs=
X-Gm-Gg: ASbGncveTlKgO6XInpn8/vvxvMYW/fOxW/yRdyZ/vyTc7Hxo54Ok69sm4dpB4AjkZVm
	w7rEISVVyZUdKrxRtd606x4jwztRH1Mx7NI3fqg5xKkrVhx5RLfhLs+ZnhhHk2xqs5VJoCe6sR2
	bOrmN7BtWuM7sbOc2svaXQvnyb/Myx0Q5dbiHpwklg1VkkCNJdL5fTsm0PqsfrvV7PQCnBSGErP
	48nIbibsQZzkbG1jFFC7tuSYUkgieaIPxgME5fVfWwVv5rnurf1X0Gq+dHyJyWmBPORN/A5HeEm
	fnsfcA5H5aO6Sz2KWsrAI7rmmD5SVqxYeIvSNbkOw4W6bU7ysn7oDLIPHWW1OAdueA1oKbO9SuC
	4niYAaK8HidCC0+VzTBjRaEOPwXxHt/so
X-Google-Smtp-Source: AGHT+IHWm1t7JTduLCpEoovyXlPtAsvMlQvSAMC4g4tbCLcRWUMOIPSIrFdKmi3brpTFPumrCqI1UA==
X-Received: by 2002:a05:600c:4f95:b0:43b:bbb9:e25f with SMTP id 5b1f17b1804b1-451f0b2a98fmr5259025e9.6.1749025146624;
        Wed, 04 Jun 2025 01:19:06 -0700 (PDT)
Received: from [172.16.23.13] (adsl-84-227-104-5.adslplus.ch. [84.227.104.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d80065e0sm198301215e9.29.2025.06.04.01.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 01:19:05 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Wed, 04 Jun 2025 10:18:23 +0200
Subject: [PATCH 3/6] dt-bindings: power: supply: qcom,pmi8998: Add missing
 power-supply ref
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-dt-bindings-psy-monitored-battery-v1-3-7f755ff75218@linaro.org>
References: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
In-Reply-To: <20250604-dt-bindings-psy-monitored-battery-v1-0-7f755ff75218@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Jakob Hauser <jahau@rocketmail.com>, David Heidelberg <david@ixit.cz>, 
 Dmitry Osipenko <digetx@gmail.com>, Tobias Schrammm <t.schramm@manjaro.org>, 
 Linus Walleij <linus.walleij@linaro.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1274;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DRCW62SWNyHDxET2rFNq/PrtoM5W1wDR8OS8EcSqkBo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoQAFuPmVgnuMmnev9C1JSBsF8VSMqeNc7xtVnS
 fpipQ7xoU2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaEABbgAKCRDBN2bmhouD
 12azD/4iAT6oNIAIzb6/VKQxJCe6lad3LVoCw0neiAfXBAGTnPfN13L+Tfu3yLSVdB0SA4pfaQP
 2Vx8uWbRCAA1qK5WJapiYh5ThU1jTWqfy0CvHt7ouDaUU5OHOioIabiNhf9blOpSEjgzYcE7Kj/
 gBOa3P4B38K/c1D0v4beEm1aiD4OIn5YOHMvvUPZaR5XqNltd8WttUaBtXawS0Sk2uCm9OM895q
 IPfHWvepoVVB0o7qKyb6WVr2w7G2Et+cuoKIMlVjEIAXa4N6koEbbjOM6awFWvskkoEcrnjXX13
 6OsqjkOCz735ncp3PQtLKxa9ojG523pF0pDuZOgbkGafQwtfMv4re1Kphg/MWsLwaHkYnn/n9LK
 Gl4ek3iGTkOp95BnlNH5XKIMwGwH3dBQi3no+xHXbvf96TH9XoNklTGAcNqavw157ddD+jVqG9h
 gFuAENcmWgUH5WLivB0P/0tbL28bqDbRfaul5HgrqJC9SnKU9DvVtCyH/sxGL+bEDtE/x3cp/5z
 MNg0AEpe//PLiwPyX43Ne6/HlWLnrLPJ2wXn2phUBTzEV2eRw+owaxrM8F3QuIcX+/836H+7FA7
 kvZMBJYNmtwgGYscz4+AOOSp8OIWfh9y0mf3o//+RPogkAEFihUpTE1ZOzQ3/f1F0WEEtY059KP
 wU/htQ9+PLCGBnw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Reference the common power supply schema to bring the definition of
monitored-battery property.  Drop also the obvious description because
it is duplicating what is in power-supply.yaml.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml     | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
index 90c7dc7632c58dc5cbfb3abcde8e730882bfd936..70f5cd6eaeabe822babf567d92b1d7f9124f3680 100644
--- a/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+++ b/Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
@@ -38,9 +38,7 @@ properties:
       - const: usbin_i
       - const: usbin_v
 
-  monitored-battery:
-    description: phandle to the simple-battery node
-    $ref: /schemas/types.yaml#/definitions/phandle
+  monitored-battery: true
 
 required:
   - compatible
@@ -51,6 +49,9 @@ required:
   - io-channel-names
   - monitored-battery
 
+allOf:
+  - $ref: power-supply.yaml#
+
 additionalProperties: false
 
 examples:

-- 
2.45.2


