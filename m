Return-Path: <linux-kernel+bounces-866552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E00C00131
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50D38188FB13
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 09:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3CC27F005;
	Thu, 23 Oct 2025 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TbbCE/yT"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B252FB98F
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 09:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761210185; cv=none; b=G6v5m+40LS2GAGNEmRFl4xBdGkBYqJtQ5Y42f/kvE5KN0zgTEDb+Ym3V+Js29QBXtABra13+PG5Gt0HwcZE3oLUqzn3VHFuyKl9krF+DiUmPvlEs04bj+InKE+EMJW9/X+pUNkTl0ZOCItQuADs9knTazQ46RBjtMTe6LrNDkcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761210185; c=relaxed/simple;
	bh=RvB0QfII4NieHlSWxal5DHWC4pQUcZHC+PzTz/++OqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fnfQOMirUg08CDXAlWbneZK403zR3TcmzTtVeuLZcRp7HH9UpP86khT8lMrsgwsRhSdFrNj4KkBkKRKz8N1F/yG6wkj9fjKjUBOFMgYokZxJWwkjEB0t/PsJWMQ6q0ndO2G74RcI5TUpPNok8Yrpr/N6j7ghAJUnBf4xWrOaItc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TbbCE/yT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4271234b49cso81916f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761210182; x=1761814982; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B0lmo2gSK6dC5/iKwrS24Z1fB1vhkVWE57DPvqhuyE4=;
        b=TbbCE/yTNL1Fyu0hWMxzS+f5RoV8ls2DrB4pC0p2xW75nNF4HUfRVDJWSOYePU9Ysm
         6C5YqRso6lG6ZTJDZN51R6VnbJzPEe5Enthe9ZYK1v5fyD7dBLGPKDeUaZpVV0WTeB7Q
         dgzqzdhCCTCseNMaETuVxidt6pcCIM3uu+j6XxpG3hZep9yryhPjzAPFjfYHbODoXQQl
         S7gtIV1DQKDH3/e3iBjnifwFHI3A8t+2HXyuh+CXjPGScDuuWfRke1NU+x02OPtUN3Hg
         2lANTJizQmy2YEHOg2Nu/C2NxnDqtZSI+BEMJWq/W4pmKSml4uBdGUeLGBtcmOraeP3U
         P88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761210182; x=1761814982;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0lmo2gSK6dC5/iKwrS24Z1fB1vhkVWE57DPvqhuyE4=;
        b=cmFcQt7S5ZNv+6s0RkMR+N15OqwJHvPtdp36er8JePAQXeg/07kF0zAxjaMd/wrTIH
         dOet0q2dtPOs87ny/yXU+YLhLMUdfEIk1H72p+OH2wLsldUfD3YoHIqAU7R/nnY0erZO
         rxnBUKp2QSMWSsEfQBJ7Ua8SRFWFNsZYr77cMERwQ7RapzfEbA71nDN6uP8Dg2BtiKbV
         2RFTehy/atzacDi9MvpeP1smO/Q7JWVcvxfr8xNcA17KmB/GfWBShbLkPw8gCiiRsP06
         Aazu9bOAd//x7LS/xFWTObadc2b6NrsTiSg4cm1sOvhrFcgKr/0P3trGpuPlHdO2/zSe
         PK7A==
X-Forwarded-Encrypted: i=1; AJvYcCW6LHibXhoraES/DksHNcMfW+4FYAxF6Tbuvf+45zQqErraKJwf0igD7aU95BVfJ6/6JE77vPdVj4RqNxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEKoRbejMItqYdst6cbzhJd4W3w4ZRcxJhCvlL95zVj4ny+CgE
	5bQ/CKTx5c83e2VmOQgiHyTMar/iYi/ep2gBGNlGdcuSUoDP6mPlMx8pmcxjjifHxZ4=
X-Gm-Gg: ASbGncu7tVMCFRTr4mBrhVmETr/AKzGkXgWZdD5mytsbCGXg0Yyys3RZC9HGfw6roky
	ZNkKg+Z5gj8fzzXQ35gRkl7bAAsv7zPWDppHXsq36favWHdna5hhfr+Us0m8wSzXGufQktBjjMt
	ztlWpYDoeRyf6u1TIBHOMrWtNzJyz0lRyoVSdtHL56TDptRkHwFj+tZ8eK0Ne/fytYR1ndgQIhI
	65ulsu+5KAMoGAqnHg5/pFqEVs2DXf4Lm6YLFJr2/nRdzMIZ81Z1Huq6YjVIGwZJZpouq7ASkLA
	WQGsyJm2w1VfJ0IrorszV+Q2YDncrYC7nuTrfZZQArmsgDami5mp1f6WwEPigt231vLnEG/IMCN
	X8VidAkzV0YC+bE1sFZUs2W3xUqPosfT95YZwrCf8Vg/dInZMQvTHIl+1O7QCjjmkt5GFzX/XaI
	Z2eypKIpuP61gfMuyKUTHVQU9ahvk=
X-Google-Smtp-Source: AGHT+IED6vyXHphp1/qY9Tno4NQeRDekE0RdTtSCtP7Dt4LSJrXcGljAhWwqEXuSADOQSeczj7tsKg==
X-Received: by 2002:a05:600c:3b02:b0:471:161b:4244 with SMTP id 5b1f17b1804b1-4749439ec9cmr42438295e9.5.1761210181644;
        Thu, 23 Oct 2025 02:03:01 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-474949e0a3csm57557415e9.0.2025.10.23.02.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 02:03:01 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 23 Oct 2025 11:02:51 +0200
Subject: [PATCH RFC 2/2] ASoC: codecs: pm4125: Remove irq_chip on component
 unbind
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-asoc-regmap-irq-chip-v1-2-17ad32680913@linaro.org>
References: <20251023-asoc-regmap-irq-chip-v1-0-17ad32680913@linaro.org>
In-Reply-To: <20251023-asoc-regmap-irq-chip-v1-0-17ad32680913@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Alexey Klimov <alexey.klimov@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1144;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=RvB0QfII4NieHlSWxal5DHWC4pQUcZHC+PzTz/++OqI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBo+e8/GYFUijdJAKhixCgluMcrMSqaCUzWEFwMT
 hCKiKSlid6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaPnvPwAKCRDBN2bmhouD
 1zXxD/9SorjfLptnntRhhKS9ae8uP8iYdmgGaYBh++xUoDagGf60z/a0/ECNV7RHSNIp/ievlC8
 UH7q7SGN0HS9OkjQiD0atioUjpLpDfMIg2MoY4Q8BxDzG7MKFB2pC/vXDJW/tgL24rZmKjWevR2
 asW1KbgrTl2iuR56NbyDcfoT1cQ3HQUHk+gcgHtyi4MKElbcS2uyCbhe/4cevCpyeGPxOh8pKvz
 IkX3RwocFPza8PSe7egItdTLKsnKy5XBBFJaSox9kc0ErH0+ee13/vQHr7zLuAZnnymRJN/P3Dl
 WieCTZebuLgIHT6Plh6inXm7mk1j7WGhzdpSYoo5Etl9Tb+SWxBi5wYlGqTIY28TTm+tMCj1Vut
 n9M6aBnaodiyw5NHhY28HYmvBLonxHQMyu9aq1G7dIE3IotfR608K8hWGCsQa6ao0STrqzpOWUE
 ANsBjjBeSdNcShYtHxNl76GFqINCCDlfG9qjH5G7Kax4a4B7I2Q9bzmC5AuWurL9MwRbL/457OT
 4aP+fZp2oZbi9xpQt5tb2BJHxtqJLhdhQ+Sw0DzsKgEkcq0Kr/MfnCSyGMB3L268D4T1QZ4LYzP
 uA7mrxWuk+iPgtz/5Cb7pru2gYoCJ2QxhsMYAT4HvxhrjL13/LosFZ5eTFQcZWmN7LG1HvelzpP
 Z7zVyu6HaBmXmLw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Component bind uses devm_regmap_add_irq_chip() to add IRQ chip, so it
will be removed only during driver unbind, not component unbind.
A component unbind-bind cycle for the same Linux device lifetime would
result in two chips added.  Fix this by manually removing the IRQ chip
during component unbind.

Fixes: 8ad529484937 ("ASoC: codecs: add new pm4125 audio codec driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/pm4125.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/pm4125.c b/sound/soc/codecs/pm4125.c
index 410b2fa5246e..c5ac2e6bb44d 100644
--- a/sound/soc/codecs/pm4125.c
+++ b/sound/soc/codecs/pm4125.c
@@ -1658,6 +1658,8 @@ static void pm4125_unbind(struct device *dev)
 	struct pm4125_priv *pm4125 = dev_get_drvdata(dev);
 
 	snd_soc_unregister_component(dev);
+	devm_regmap_del_irq_chip(dev, irq_find_mapping(pm4125->virq, 0),
+				 pm4125->irq_chip);
 	device_link_remove(dev, pm4125->txdev);
 	device_link_remove(dev, pm4125->rxdev);
 	device_link_remove(pm4125->rxdev, pm4125->txdev);

-- 
2.48.1


