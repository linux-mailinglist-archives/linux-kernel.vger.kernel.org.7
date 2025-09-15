Return-Path: <linux-kernel+bounces-817423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6804B581FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 18:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 635D24E06C8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4FD284686;
	Mon, 15 Sep 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nCEehg3p"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FD22641CA
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953678; cv=none; b=K4WrxaASsChya9rMrHeNCnOa3XhBOWzcH/r+nf5YalNGFS4oIv16eIN1k1AJZcJbFkMsBBgvDyIqUZeLXxSG3AZgIL/5n/95z+xWFCgVeoYJk1Klx3pv5Rrhkx+iMeHA3XU9MYcMvm5pzsdwll3LTMzh9f7UtRv8JKy7upSTzJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953678; c=relaxed/simple;
	bh=HZPCk3JqUA3vYxv2NPfDB+tVL6uTR2siqsxBukIGtE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e5W+hJI/2S4KroF+xChIA4e/SXci4hYHTlEgyIGOCCOs7IEo8Z/BclPc2EaMzvdZm1sOypPoweXRsDsPO5yn4fVDH1iaruhRWpxMFV23MiL6n+b28y57VMEWICoKAOM4l4QvAU3M4TWCMVAeP4HtrTgMOANO31uicTDnwTyPKDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nCEehg3p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-45f2c5ef00fso13219105e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757953674; x=1758558474; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c/K+Z0wL5+PZjzV0vqQ/YTMEX+mNIMBAJmD7MHAv9vo=;
        b=nCEehg3p7ZjrBkR1o9dVtCYqkviINENyRvvwZdwta8NPOj7aQsMKToUgUvj4rHxfif
         bFDuBgN39L7zO6bnMdQCLysDoECK52dSQc9kWDwMfOVy8b3t/VCw8DIeQxat+7oZW1TT
         rh3K1N0ht5112EkFDf6EH5G6J2UdGrGxG0OlFAOZrprKJLxyplQEfetLK4MX6hxDjG9b
         dyMAuKBOy8J/nWGHAY/eZOzwdBYFxXY72Lgw8bGxCn71QlutffRBhmWaSV5ZlpHY3oVJ
         O+vjf6CF8Sbwn+RhP0MFmPKn8o0I84sgB1r+8k9USu5D2NI5TgtKKW2Qw5L8nI+zpp0A
         dw3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757953674; x=1758558474;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/K+Z0wL5+PZjzV0vqQ/YTMEX+mNIMBAJmD7MHAv9vo=;
        b=BuexaS2Vi+mrdz+Gormg/RgobTo3KQP8bLFxClKfjfnUAvBBVBo0iIdFCz7D4LokTx
         jOjMLY6wqy6zvukKfx3ExyYyHHJ0nzvw/ItPJukGI8ZMzrk6H4MyIHF6S4pM0aUtkowf
         efiIlp/WbbP1ly9B+Iq+Zlcc4gpDMvcrJV2V+NndNi8yhf8wza+83GqcprUtf6YSD1mT
         p3pqZ2jia7JJJ2nxfcu6w95N0aECcCHhkNMNJkSdBIxq8t0he4Ht4zKjcXc3Qt1xKV2f
         /mAY6zlXeYTMBSkYvFGpWBUGCQn6WbMcG94ZVmnNDX29kE3EACZjL+/nO7RTwrEIgMOi
         Hgrg==
X-Forwarded-Encrypted: i=1; AJvYcCXoMu+haEER42PbPHPH2VrsSwgr7yBjNL/Zq3VF/+Slg6gppBlyjuI4ByZFmuybAadAqlM44Pq8oeI8pYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YztwWLjlpGg0sedy6likVWpJxVQsG2heDaIO33kxZxa/XFNVM1e
	TPx45cOGgM7Up5tb3T5iBW0XbFhj10pFUSaRQWRsaWtM11g3hKMsUHEmyMsOwGOXKcLDJaNq9Ph
	sq4N0
X-Gm-Gg: ASbGnctNmRYrlB1aNSq98BcezM9WEomNaSqKhdJ7xOrAuXFVN44Kg+NR2M1fydON3Fg
	2HXOOYCQHg4eI6gK9u5zHOkIy4V1ZA4IWQDbsk/t9XMPeDDOn11ZE/fvEAMzzKKcjL1vonQWEyb
	eAELH28+fnRJs2dOjOJxYeNF83Ar85jCDoOD2yROa/eSZOMFDLiu7kvC0aUknQMS18uGxkfL3e5
	MCVUuaFM3+cxAEOn/hbrZ1yhqqDwZUT8c29UPF/KXadXDGW3mm+FOTNX8RWfZBuVpxTjkVNjdNz
	GhYvsZ7/6eo+rHqGx6OKrvuF/XJrKw4IDUB21H6eaDDoJa8h0gpsn/crDts5DeROjY61g5DU3d2
	FEFCRIETwVxYC7Akdy4Ot5p7dPwTnBZfsg1YJOqE=
X-Google-Smtp-Source: AGHT+IEn0sbvsgmnzVv9y6r8pDxl2GODt+IaZynjI4BpZgrjw2lmcfqmUv1WBZqeRiA6ek+oG19YaA==
X-Received: by 2002:a05:600c:58d8:b0:45b:868e:7f7f with SMTP id 5b1f17b1804b1-45f211f856fmr108161745e9.17.1757953674396;
        Mon, 15 Sep 2025 09:27:54 -0700 (PDT)
Received: from orion.home ([2a02:c7c:7259:a00:e60f:4b6c:1734:808b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e9a066366fsm7857989f8f.44.2025.09.15.09.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 09:27:53 -0700 (PDT)
From: Alexey Klimov <alexey.klimov@linaro.org>
Date: Mon, 15 Sep 2025 17:27:49 +0100
Subject: [PATCH v4 2/4] dt-bindings: mfd: qcom,spmi-pmic: add
 qcom,pm4125-codec compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-pm4125_audio_codec_v1-v4-2-b247b64eec52@linaro.org>
References: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
In-Reply-To: <20250915-pm4125_audio_codec_v1-v4-0-b247b64eec52@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org, 
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 christophe.jaillet@wanadoo.fr, Alexey Klimov <alexey.klimov@linaro.org>
X-Mailer: b4 0.14.2

Add qcom,pm4125-codec compatible to pattern properties in mfd
qcom,spmi-pmic schema so the devicetree for this audio block of PMIC
can be validated properly.

Signed-off-by: Alexey Klimov <alexey.klimov@linaro.org>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 078a6886f8b1e9ceb2187e988ce7c9514ff6dc2c..776c51a66f6e7260b7e3e183d693e3508cbc531e 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -137,6 +137,12 @@ patternProperties:
 
   "^audio-codec@[0-9a-f]+$":
     type: object
+    oneOf:
+      - $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
+      - properties:
+          compatible:
+            const: qcom,pm4125-codec
+
     $ref: /schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
 
   "^battery@[0-9a-f]+$":

-- 
2.47.3


