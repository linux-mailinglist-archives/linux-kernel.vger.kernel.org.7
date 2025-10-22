Return-Path: <linux-kernel+bounces-865091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3189BFC348
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E119544AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 13:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC822348885;
	Wed, 22 Oct 2025 13:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UrqLx2jX"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D083347FF3
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140073; cv=none; b=YlNWUd+VoMbGckd12gkVyEIG9E7IBmGPfw7dFuDj3On34lyiXX+pYhI6MYtEgOunG5ex7wDzUDqXtW4rQmu173lVNSLdXyMVX8iaSBipFEHtVIGoZlLvfDQU0Cl8Agvj371Os5tO0K+tbcNItUUNtmF2tHXv095b5YAx9H03GSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140073; c=relaxed/simple;
	bh=T0KheH9SmHYRG9S90aXs4rewCJfStqdviPw1bBq61oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ik4ww7rjQd73uIVdUdFDUQ+46Q0F1rw6emWPXGKwzB4EcqVGTyHS53sQoRLGfqnn3t3V7vNFppDBgU5wvSjB8WE16KIvMMbIqMw/RrqgdWUYcKziT4CInIse4YfjUc7tqZu+rrsxN/JUCt3Gn/Uv+RnqRv3gf1NaE8r7n1Qw/bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UrqLx2jX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4270a072a0bso780005f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761140069; x=1761744869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X6bRIK7N0Lc6wOEz1pBT1Kkom/tSArzPgk5+y4nbPsU=;
        b=UrqLx2jXTyMJkQCoL6eYFx82cCydhZ2Q1yowuxxOpVg41IMr+b3AWk5Qzc0UOSptmH
         YLxG/0dZ46P76ApNmc9iuQraPntbthmKCmpcVSilrmE+bkVmkPhZr7p2Pd5jAsXrJVjW
         o01Thw29jYBLuYdhAiZ80H4qh8Htqr/Oa6UtjcPBsej7EHKJCZAVZHXK6ank9Y7gKzwx
         NfxMHZZg9OSdfBmvAZDTqTgCQkV9ty8fSE+UOqMbwBDnj8Z2yADlAYJdf5wEVkRJFxn5
         39GNn2Nk2Np80n3/4xnsbSV42CQQaibbirfFF2ajUD+VeElYu3ck4RlO6NywhD0zCSHN
         OoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761140069; x=1761744869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X6bRIK7N0Lc6wOEz1pBT1Kkom/tSArzPgk5+y4nbPsU=;
        b=jtRJpYqa9byCRsiFjBJcoPoAF1Oefr6BJdeJcyh2Nr0oOWYiquyQc475CJ6HX1lwTW
         3I+mweDtVb+Dnri9sO3BogoJTDonE+Ipq/YuReNiCwu0FWdluUiCqvUMOLlLnofcoqQO
         NTQ9BUmu8DUHO7HKnOBjlcmf54jiRiJfSd02NTkYLU15qSgCvJdYNJ4NUiBh6pVxhNnG
         4YqQg1iBwevzgJHlV2dyerg0o1tyU5RcDgBoIIfQD9w+zDcwMRuJ3vTA05zsH3j5qVrG
         /f6e85giTkw+ozLhqfDdLGJDeE5NtW7Mic8JBu+4YB6we/Euc1dY9Q2ykkqq0fvvF4EL
         Vf9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWpvJQAM+Woc9xnTlqDThvf4FDdB01kANhODvCV/XOaacUlYKsdo0sy/vkqqguhuf+C3EIDClA38bEjWlw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY9pUWtxk1w8Mpk5Rb6b2DfA7UQjt9DHwQyCR3auuj4430fJHK
	A1kw8ntpFejGhglBskczDEefJJNDEMvDblbvCyXVUCWg2xs4icDpriDbM/ymdVt12sw=
X-Gm-Gg: ASbGncvjRnoYezaDgfIyfzx28bM5uRAKw9lzwdzQI3I1OQl8pfdoG6mXr//kRl9UgUM
	eDUiPoTzpxLUZm1lCokPK4yPloYZ0goOQM9qShPV/8eJn6Z4W6BayyAt5myu2T6pUoigmVRbJAW
	HNnZ/Oi6rF3H88tflN2bEdTu3izj9axm8XOhkyZQWg70VxTCbkAVPavP2UT0emlJ36/aTCfKXTq
	XVo9kF17J/LO7pdkuGFxnPUDobiy8XteKipXoAEFWXfRKhHLMqcFUaLLzcHgl8grrxDVRhujIWs
	B2zaNqSXJiFgKJmEAaEKL6GSLZ8I1qPZ8KgVQl+/m9FzXriZQ40jzvogY6UCEUctyiCbDqPv1r9
	oIMeZJ9NsRxxzMKTaYwMNHKxtucdQdM6lZkmkNvMb4cCOa9hBHqRVBTywMRaWwZhvNLsbWwk6fX
	lsXs9fTZRLkxCLhUAeBwBzTg==
X-Google-Smtp-Source: AGHT+IH/eS0bO2rVpOyBa4Ba5RIcrattnMm2FYtHvflh6MkB0GWk0k3OOmlqwAxRAezHhj8eTykIgA==
X-Received: by 2002:a05:6000:184f:b0:425:86cf:43bb with SMTP id ffacd0b85a97d-4284e55735cmr2864362f8f.5.1761140069463;
        Wed, 22 Oct 2025 06:34:29 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42855c2fb92sm2981201f8f.46.2025.10.22.06.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 06:34:29 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
	linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] dt-bindings: pinctrl: toshiba,visconti: Drop redundant functions type
Date: Wed, 22 Oct 2025 15:34:27 +0200
Message-ID: <20251022133425.61988-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022133425.61988-3-krzysztof.kozlowski@linaro.org>
References: <20251022133425.61988-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Referenced pinmux-node.yaml schema already defines type for "functions"
so $ref is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml    | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
index ce04d2eadec9..0eff0a0ee9e9 100644
--- a/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/toshiba,visconti-pinctrl.yaml
@@ -42,7 +42,6 @@ patternProperties:
       function:
         description:
           Function to mux.
-        $ref: /schemas/types.yaml#/definitions/string
         enum: [i2c0, i2c1, i2c2, i2c3, i2c4, i2c5, i2c6, i2c7, i2c8,
                spi0, spi1, spi2, spi3, spi4, spi5, spi6,
                uart0, uart1, uart2, uart3, pwm, pcmif_out, pcmif_in]
-- 
2.48.1


