Return-Path: <linux-kernel+bounces-888975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA99DC3C5D2
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44E23345BED
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8B734E767;
	Thu,  6 Nov 2025 16:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LRyBhmop"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E869C2BE7A0
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762445799; cv=none; b=qiT2AfgkcOBPZ+jqP1CtY25u1fRcZ7nzszAk81LvZHMwmKQDniQwrwMtborSgMhyL91CrRHINLyHU6Qo1TQeAoEGnZXQH6dGOVnXHf2aghABn3waEcajlwVlhR0AYlsWJvDk2Ih1UD4GyBiDYVx75aUl8zIWp4Jz2R88B17PQjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762445799; c=relaxed/simple;
	bh=m+62ZdK0Lq7jNUHc6LhXJD8r2Oz0NXj2Wf/sdNqZaZ4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Y5zlcPfWn+5SGZS2DShRYlxhMhSJbIAHg3Gdn17MBf+YIHhFA8N9bJ1LcOaoG9X3wpoWvWFYfoncSd7RsN8mPXqmMG4y0bWiyEb85/IppEaLBBeOSFc5JMk4pSyjuhpRyPjsucQYIhp3Z1OyyJHEWI0t6T7bsMuoBwiR6MRFf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LRyBhmop; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-640ed7f26b0so181638a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762445796; x=1763050596; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a/cWESJHLQuQfZBepHMhOg3dPVBwhTpABUd40+CP0cQ=;
        b=LRyBhmopWy4spnFYHZmVRlmUodonDK0TuQE99e3Qwa2sYiqq2yA8n/q7fyryrUzcXz
         1rEbYBgOtYrRZNd42GLdJL4IIEe8GZBpkXREWiVYeE4JeMmfCFIMkQqSKI5btjoBJ0Q4
         u7dsuuRfM5F1QOLvKHGpugDtrNEodcXeUpPiughq9IEsW/kmjbSmYVJGphM3FpvM+lBX
         WTI5VJsXdAm6lizwt4VVlzIhDghPL08ZkCEyaClOTK00arYedwqIsxGJkPT/l04I0zXx
         V+TkvqNlnsKUEqG7SIISPHDFcQNhSL0LSjOcITZPXE04VOUJ/JyI5ho6TwV08QdP3MYW
         6ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762445796; x=1763050596;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/cWESJHLQuQfZBepHMhOg3dPVBwhTpABUd40+CP0cQ=;
        b=jGPoykFUVUmhgKxcAFR6oKy7hMQBN7r07fTLMx5POcl1fwvo1wI5plh5tEgFdZHQ7X
         khqFDwvPkessJhlwQgryz8Q2VuP3Ovet0/WN+yRhM6guSEezUiFr0Nt7CISqMckWw3jw
         FPg52g0WJdjczANi9TJtSRz1Nw1NOfUZQ7JxU8Bhy5w1AuCU2naPEF2Yz9hQfhTA6g6o
         jgPlxVmCYGRls0eC2BIH4O1YAxAHTMFJTV6s0eRdKZmnKceIg9N6ZXeepQm+IpFNkKTb
         oGRfpIQCXXPX/PaXs2GZzAIE7PQeo8kMormdYZM+hcy8YBDrAShdv2ymzQrbp355imIj
         dLaA==
X-Forwarded-Encrypted: i=1; AJvYcCWAG1EXz43qCmwOangYWKELN8p4burCHtV/s13A3ITJ0F0Pid9l1YugPFXmEgJBiB5gtnppdWPwb2QdCCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziBhi7d9DMd8wJPSXPbI8Py38zp0/6E9G+Rnt02RuyyyQGR1Ag
	faol7c9yM27kF3uX/Eezs2s/PHi9ItGpyliZlCbNjnfmo3l+NA2r030GZvg5HPKSTrumAg845SE
	jmSgl
X-Gm-Gg: ASbGnctgxI8z1O9BxKXXxZMWT5fjQGraCEUcl20t9rYsQPNa2wfd+4djKmSVrISXsy+
	diT9mIuUHe7AVmeVdu2m6JC7vguMDXBVJNH5vDOxqKFrl5Noxf5VeX4kRFDZtJiL8CU/5xlDVU+
	Zq3DazTO9/MCEh9RnEpJZd52FL3q7rZn0Y9v87xg04bWbjysPzGEVq5xWWJlVF9robcFg6rExG+
	OBR4Df0J19TukSg5KlQDcZvD9kNY6hBWxQmqRc0pQtA1DrjijjfxCQ7PK0LlZOD6tn6ilUTSKpc
	a9b/2nR/CfiE4K39QQBJQXLlLbIyCp3OBWcNQgVZkbWAE3GBm5uNJ0A6iFw/nAJes6fNMX2nhLN
	GejbYpC0UYSRtlKYYRAysLw8WwsQx4gPmnfAT+p19A6K9+vod2yI+4M/xEgpvNQzuz49eVmBGjr
	AlkNFXtkcmscbCtVV6jiLTQuNPspQ=
X-Google-Smtp-Source: AGHT+IGZyiotRhhgwXYn5kLA9144yJt3CqLXWRIlBplyMOGLmU5g6JzMcGZwLmbbAR1KDnNe/CJBWA==
X-Received: by 2002:a05:6402:40d5:b0:63b:f26d:2eab with SMTP id 4fb4d7f45d1cf-6410588c64bmr4342221a12.2.1762445796238;
        Thu, 06 Nov 2025 08:16:36 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f813eabsm2113408a12.11.2025.11.06.08.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:16:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 0/4] gpio: Simplify with of_device_get_match_data()
Date: Thu, 06 Nov 2025 17:16:24 +0100
Message-Id: <20251106-gpio-of-match-v1-0-50c7115a045e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANjJDGkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwMz3fSCzHzd/DTd3MSS5AxdI+MkI5PklJQ0AzNjJaCegqLUtMwKsHn
 RsbW1AKFqXdpfAAAA
X-Change-ID: 20251106-gpio-of-match-23b24cddf063
To: Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, 
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, 
 Srinivas Neeli <srinivas.neeli@amd.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=m+62ZdK0Lq7jNUHc6LhXJD8r2Oz0NXj2Wf/sdNqZaZ4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpDMnawcy7CZrgSJdmsX8aGdzbZJXfoTmd5wcte
 EXUkZPJykiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQzJ2gAKCRDBN2bmhouD
 1/GKD/sGaVw4KqMnqsuf/Iq4t8i+hgL/3lnY0jK+9SSHdXboQ7EJfgk3Sm6wY52RTR+tUedRqHb
 KgFgHA/5ybPQRwhsYIiMvznFthIaKAJQOyqKUk0EoICVUmcd41lh1MD19gMi8bXpb3tdhoMD0k7
 c/ssi6l4uvZwgGAsZlS5xpcM45nHBvnKd52CJW6DphNkNEcv6mznj9RoO4xwAw2YNkPUXcVyTOG
 /Iz/TKqD3SC4b4ckdDh/LHlBACvBtj9Ouh4a5kchOc7TvE5K8NOCIstjaGA+VYGTt1gRiqOI/+l
 GQhTiL2jKs68Rxvm8cnU/28TKbJq/Bw9/SAaE3R2zYyzd/A1OyqrCHb7kIjtg1T3G4jVK/nX0vG
 UI037XTHkPBuQj9xet8T8YsCEgsT8xyeyDe8LnAmiXykzytmOzkEhUszveFit4ZBFp/JOdCMSpR
 4ar2NyVFBRiYVufNe3lzr2S4DZPoinPKdKdRJfZ7twvu1E5rN3Ptry9kUlKmFnc6rDTTJA0zGwJ
 wcvX7YTxJiaMdZgmLN0y8Wh9a8s37KEQWrJAWQqcPFFA3o9MwAsGR5QDYRHuagOmkCjj2MmP4QG
 9giy7q8+4GvJ7VWK3iCZ1y37exP4A7BdriM9cp5obCaixlPiHoWi32+FRChQSaI4HfZ0l4XcZga
 V+lfSKqaELeCsBw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Few simple cleanups, not tested on the hardware.

Care has to be taken when converting of_match_data() into
of_device_get_match_data(), because first can check arbitrary
device_node and the latter checks device's node.  Cases here should be
safe because of_match_data() uses 'pdev->dev.of_node'.

Best regards,
Krzysztof

---
Krzysztof Kozlowski (4):
      gpio: tb10x: Drop unused tb10x_set_bits() function
      gpio: aspeed: Simplify with of_device_get_match_data()
      gpio: creg-snps: Simplify with of_device_get_match_data()
      gpio: zynq: Simplify with of_device_get_match_data()

 drivers/gpio/gpio-aspeed.c    |  7 ++-----
 drivers/gpio/gpio-creg-snps.c |  4 +---
 drivers/gpio/gpio-tb10x.c     | 19 -------------------
 drivers/gpio/gpio-zynq.c      |  8 +++-----
 4 files changed, 6 insertions(+), 32 deletions(-)
---
base-commit: 5892a3d1e4764f041ce756d8f8b321d2c92f653a
change-id: 20251106-gpio-of-match-23b24cddf063

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


