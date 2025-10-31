Return-Path: <linux-kernel+bounces-880188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB73C2515B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 13:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C37FC188C1E8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6CA344028;
	Fri, 31 Oct 2025 12:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a4Ffj/nJ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 125E8329E6F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914735; cv=none; b=pEaVjQ6D/WwrINbW/taOyfz8RY0EBNBpnEWTTlVcxLvWVJAXEZo18XHw65InLfCSus3KwYHeJP9r5yR5r41psyYhYFBoEdNNUhBAcfklZZqguDJ27o5zAwuML8Y0/wORbh0WQya4dG7R9qFsOLWpWGR1SCEQ77jH6Sa0/3ZmIYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914735; c=relaxed/simple;
	bh=jbtOQh+KZGaronPKGSCjW9AW/6hcLTFo8o99haI6DgE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDwik/SIFHQ9PL2acgKSxGH2ipyaKvm5v6klCsrnvBN2GPz9MhKDOgBvSXVdNH58llRNrkwzJGbqnYPaORnrAY4EdUXZdxp4AJA6oKCWDelLPVbWmrdLKquq5nv2Q8hAQeB3SL6eV39OgfAYdteQMc/grRTqFkzVoh1GLmKmakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=a4Ffj/nJ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dbb524e4so13307855e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761914721; x=1762519521; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LI8bIiPiGdrKa8u7FU/JStfXK2j48QfKQas4QVWIkY=;
        b=a4Ffj/nJRpGs3i+ujW7Qpz8i2DnyHbJL4wgiFhyxqDwpIEGeU9vL9kelwr8cnT291a
         44fa/xNTNSof/X+oWEyJ2WuIsfRlkjfbnl4cTyNOfPTtY/7VVjBacjjy+IyScSzpz1kt
         lGweZWqzwQWIAspHqUNogJZWPOfGyNzTRmmu7wxx7igUU2OipAzN6JG2KHOcW8eoelwx
         HO1H00Ptl+RnioxNyiiiyv2zQH3AVHlTj3V318e/mjENYmRjMj/S12+VbZhwF1qktqjH
         4G6tMvhWqLH5CTZl3Br7jEYq708AQoEn2wZV21lGW3lQzpb2uPwRjAJME82dxDdcs7mN
         xpaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761914721; x=1762519521;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LI8bIiPiGdrKa8u7FU/JStfXK2j48QfKQas4QVWIkY=;
        b=RCtIv+TUlPOpV+czmvy7osDar4vGoM2g9cuaRRnKPBgSLX31FcdnmZiq2ZcVic1VXV
         x7naJY9GP2HygnuIEMNJ9Jj2fxyvTPxBQLLKx8KEN83di+C3FJ2kIqfZTxzEQEL7oOTP
         0L/J+effKzPo+wknbHhAZSJPIfNnPluWU6PqcGg36dF0DJMEMtyzGNVigxuCHrEkmv1M
         9v5g3f8gBtXfbwlKt5PTUakJkCcFFwRn3V+vz+aKaoGHKRGbqDVUE+zNBvr/93VwkGdP
         Ph/LNt7NTH3SKxJh+5qnPUAYX6ziuBxaacXKluhN9H5D+Mp/NzIAKZwMOrwKr9z8FmJ4
         d5hg==
X-Forwarded-Encrypted: i=1; AJvYcCWwAu/EP1WuhmN1/pGMS1uTxufGdw7r+B9gsvIb3mpi/9618fDwMd97O2d/judv2q1UOtBxH4R+PGvd6a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAaQRYXYLxjmSK491PngpWS8JfsGB3Khf5/1C9NJ/5yuPcg+P
	bR69Q20gN/vOn+xiN8Pw38QkSS7Vj+jcWpu5bRVwwRdUQIlXXhEL9qMdv0l4XZft/Ts=
X-Gm-Gg: ASbGncvKslcV2b0mqmPoRtKZCfcwyNP9cXRshS/Y5L+VP8dPRYh5xN0xRr31uSUVC7H
	UKv0OcB4g/zToOYCS75ijLXv1C7Rn5J2Ifzg7AjlsYHMb42tSE2HgFbhUAA4DaFm16NP6ja2J30
	tw3OMNR4ezZAB66yW9J3Aq/lqULO5V73BvWZ0oioaH4NM/SoECAKCynOh9YdnewQKvTEmKsWBWi
	bZVw9N8NMDoWGFtZygrMhML5RSV3Dtv/RWD9KwJ+gNfOO7nS1RYS94oQhUN2joW6TqJdkC2syqv
	PtBTSXNY5H+LUHtKeP1fldjHds1fuXOpdrovrHyFVMLLXaH9I8PdKsUA4RYe7EMIJxKkFnokQSE
	/epO4uyowUWHvzJsIt7VKbv28BMWtJyeyRkRn9xAQSWaCvKLFMd1jk4cU23AZ30eQ1idFTm+C6a
	YM9frjEtSvaocEN7V/379fGRODIsLmPnjdb4yk7puADOc3fsYQiWj0
X-Google-Smtp-Source: AGHT+IHOR9o3pN2qjHmH3aj2ibwtFk8fBD1ANgqBkHALk2NU/zxtz1qYd7JTDoI7nz6jygMlz28LcA==
X-Received: by 2002:a05:600c:314d:b0:471:1d8e:3c4f with SMTP id 5b1f17b1804b1-477308aa77emr31810825e9.24.1761914721275;
        Fri, 31 Oct 2025 05:45:21 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732ff7fdbsm31077535e9.16.2025.10.31.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:45:20 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:45:12 +0000
Subject: [PATCH 4/5] arm64: defconfig: enable Samsung Exynos OTP controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-otp-v1-4-2a54f6c4e7b6@linaro.org>
References: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
In-Reply-To: <20251031-gs101-otp-v1-0-2a54f6c4e7b6@linaro.org>
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com, linux-kernel@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761914716; l=915;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=jbtOQh+KZGaronPKGSCjW9AW/6hcLTFo8o99haI6DgE=;
 b=anPmmraBvSuRYrza8lT7XXPyLkgmlAH/yyD7w1SjaBtSE3hCPJZEkgDHb0kPl8CtR+4Ta8bjR
 mEUElj9TnrgDeBa4TOQQUClCBg6x6jMhPpnKkx/DI+wT0L+NvF59rcO
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Enable the exynos-otp nvmem driver for fuse access on the Samsung Exynos
SoCs. The fuse block stores various system information (Product ID,
Chip ID, TMU, ASV, etc.) which will be accessed by client drivers.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 646097e94efe7f1a18fb59d5b6dfc6268be91383..6433e3c0f88b892ce6f2ee190f866a6ab4889771 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1682,6 +1682,7 @@ CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_NVIDIA_CORESIGHT_PMU_ARCH_SYSTEM_PMU=m
 CONFIG_MESON_DDR_PMU=m
 CONFIG_NVMEM_LAYOUT_SL28_VPD=m
+CONFIG_NVMEM_EXYNOS_OTP=m
 CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_IMX_OCOTP_ELE=m
 CONFIG_NVMEM_IMX_OCOTP_SCU=y

-- 
2.51.1.930.gacf6e81ea2-goog


