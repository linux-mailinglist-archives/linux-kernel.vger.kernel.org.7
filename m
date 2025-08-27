Return-Path: <linux-kernel+bounces-788341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39092B38329
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 15:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4945E3B1BA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 13:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3265350D5C;
	Wed, 27 Aug 2025 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RA0TW2t5"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD171C8630
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756299592; cv=none; b=kn+/iTHxcx0+6UL2Jnu6nIQ0/p+WzG7sbnD3MQmquRIA/Wl3kZ2q5qfhuPIw/2xBSVyBioWrPddUUZcyuuxkKR/XxknQKox9ZgDky9RNlgLyKIYmIbFzpx/A7y7PMQ99vy8ikuYd496Np6aCUv6CMmEa4IrYnvghU/uwjXRqHZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756299592; c=relaxed/simple;
	bh=oYO2aZrhN1EN+TKF1UnZ/sK5wtemMH9P5gox8Ik8xhE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eSJJANqpuPHXtdiRFKtZ5Vj5H12lP/OsCPA7Gzm6w1VlooffyxtWq9lQNk4kmjXMcCtcN+izJ68h/Zz4To3MbZ5SObYnh45RnIzmNtTSTU21OBY9VlVTJuHjhbJFIvCgKjtC0/RiNJCLoWcFnk8OlR562wfTzBeEIDAENA5Edzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RA0TW2t5; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3c79f0a5fe0so2406905f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 05:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756299589; x=1756904389; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J2+GEmKa2OmE1NjrVANYz5XX9YGwV6aNe/Kh6e6q34E=;
        b=RA0TW2t5Dwx1Qx4ugD/7KOmylXqznXJnfP9TfpijFWhCyh+5OOZ6+em7WVFAFQ7KFk
         O8M08O1jcyjlzX4KFY+Rr9FzWzGiA+5iQmbP0oWwYhO7O6f2i15q3rNPwl7v0DzmaKYx
         zlejZhoLrVtwSwLX56knnYqW+cnIxmkJkor0rhXwDzvg1LGXXhKbrLPi8y1QKpBrbeTo
         KyHCOx9VPEleeXbVlRpSgvHlI0zmZzyiL4mmml5VcYgVuFb3tO925lkBXenGZa8Yl/Oe
         9pm1aqhYLSP6f7JYjBgakTACwRW7ySV00QZ1dVrgHAkOzWXf/AG2OeM6sJFURQu7qAvb
         3fUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756299589; x=1756904389;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J2+GEmKa2OmE1NjrVANYz5XX9YGwV6aNe/Kh6e6q34E=;
        b=OpJxycYTMLa3l4pAb2lYeE8sL/CaBhouC3cfhGec8p10l8cN6m+VUyz1txWfkRvtdG
         z6+O0fnCKEdW6Wma+YltO/X4iahmVP84wa3vbELo5k276gYWx66YTN0Rq3FxabQUYOXG
         g8gU9kB3Pr104/5+ZgqH8p9n6Xlu0hINqm1CHMjGnk7UrnDf4mXLb7dxKIJ77FO1c5NH
         73mF6/TmAHDAxRcwHaFAQOtf0aKO7oKj8LruzHulMTD5zBNf2M93IWtLJHKWfE6RBoEP
         oFqR4UKF23QyQiQNDi/moPPdr9VO5Hwo7m8UpcYD6kXU06wVQdmqYVCY/4Q30dWuD6jv
         1u+w==
X-Forwarded-Encrypted: i=1; AJvYcCVMsiXCZyo+kMCN0cGBAHhcWLidC/mJl4h8ajsCiwq6rMpPqiSojlyDyorS0HHseIakyK0Fd6QSpySIrPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrdgtAEH6nLeojtH5ASRJL4rADG4TvY4F9pvcrz4CTve6seK1O
	VZT7GJSYEEf+rMsGHdkR3dpwnQFF282+79WCs5+gBddPWnK25tmQ3mjSfuAvJCsKWhg=
X-Gm-Gg: ASbGncvEGaRvvWbO+2xBMdOmLOcfohhCgfxzFDY4O9M2aVuKeHDGiVNNXCNUzGnPJ5j
	uB9iKEyfV5U7Pr6fJfiGXauWINZLmnCvKBxTSkjNWf/0umdts0xqmBGJIOlJVv16G1wre/sRIve
	zmDHSSHcYJWVb6XQJV6MrnLhghPU6MD+97dKDgDNEVQO6OdnSTdmnMQOjzKvvs/3vkSCuHxAXf2
	8QZ/kIoDLwaYr1fmKYpAK73ysVbPFv9j35bx+ONNBEOJhgt2dHwJL+rN2BfhUQX09hNdqjkxRR/
	R5sQxQiYhOVtAOPOyPjLfI17la3szr2VsN68IP9ut5cnItQxV4iGG4MXKNYrUepBSmBIeyCgJx7
	osR1WAWYzGaOnQQSUkIfjubM/TfHaxgJ8KazvE8Du7DKxnfEEhRW3a2jLDSrJaCz3gYgz5XzTRO
	QHYw==
X-Google-Smtp-Source: AGHT+IFYbOQDkswd8yZg7ePHjCvgvWKEUD2miqxIlRTjqnawegRIfM+9sdtjHuSQ/AW/K7wL9nEJSQ==
X-Received: by 2002:a05:6000:43cc:20b0:3c6:aa87:d959 with SMTP id ffacd0b85a97d-3c6aa87dab1mr11788600f8f.26.1756299589300;
        Wed, 27 Aug 2025 05:59:49 -0700 (PDT)
Received: from ta2.c.googlers.com (219.43.233.35.bc.googleusercontent.com. [35.233.43.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cc890b178bsm3272069f8f.52.2025.08.27.05.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 05:59:48 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH v2 0/3] arm64: dts: exynos: gs101: add cpufreq support
Date: Wed, 27 Aug 2025 12:59:45 +0000
Message-Id: <20250827-acpm-dvfs-dt-v2-0-e1d2890d12b4@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEEBr2gC/3XMQQ6CMBCF4auQWTumxaItK+9hWEBbYBJtyZQ0G
 sLdrexd/i953wbJM/kEbbUB+0yJYihRnyqwcx8mj+RKQy3qRmhpsLfLC10eE7oVxXWwN6MGZ62
 DclnYj/Q+uEdXeqa0Rv4cepa/9Q+UJQpU/qIH0yihrbo/KfQcz5En6PZ9/wLSjGgKqQAAAA==
X-Change-ID: 20250819-acpm-dvfs-dt-06bc794bdccd
To: Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756299588; l=1160;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=oYO2aZrhN1EN+TKF1UnZ/sK5wtemMH9P5gox8Ik8xhE=;
 b=vFZY7juelyD4nVnYQ7mi3pFO0bqjlNOteUib11Jccm9ahWUZSQbBny11zaRftz6LXZp8Erea+
 mOSitc7kKe9B+IHnTcctE0okkkdCgc7IFUPuhRPIxgN0UeqElkV7R2t
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Define the CPU clocks and OPPs.

The patch set depends on the bindings sent at:
https://lore.kernel.org/linux-samsung-soc/20250827-acpm-clk-v2-1-de5c86b49b64@linaro.org/T/#u

The following error will be seen without the bindings patch:
arch/arm64/boot/dts/exynos/google/gs101.dtsi:75.24-25 syntax error
FATAL ERROR: Unable to parse input tree

Thanks,
ta

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
Changes in v2:
- acpm node becomes a clock provider.
- reword commit message, extend cover letter with info about dependency
  on a bindings patch.
- Link to v1: https://lore.kernel.org/r/20250819-acpm-dvfs-dt-v1-0-4e38b95408c4@linaro.org

---
Tudor Ambarus (3):
      arm64: dts: exynos: gs101: add #clock-cells to the ACPM protocol node
      arm64: dts: exynos: gs101: add CPU clocks
      arm64: dts: exynos: gs101: add OPPs

 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 284 +++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-acpm-dvfs-dt-06bc794bdccd

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@linaro.org>


