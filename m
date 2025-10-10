Return-Path: <linux-kernel+bounces-848236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E175ABCCFBD
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 14:47:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75E55422B5D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AD42F5306;
	Fri, 10 Oct 2025 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+Q6AJqY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97D52F2619
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 12:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100413; cv=none; b=izFAUzaOhLRH77gNkoWtwyazMFuxBi4rH49yVoO5XeINlvqMR65YIB1+C+lA4shRakR4cpCg8C6fNaspRBp5uR6kb0idIcI/1p1oXX3ejKwl0jnVotgoh51IZvsng5oFWzSBKbc7I6HNg6t6FuYwk0U8Dn8K7UP7l/1Sl+JBGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100413; c=relaxed/simple;
	bh=hUk7p7wXwxuWON/P6SaBYN67C9x3HyQcVroLLSWoXfk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F2JpMvIQG1UFQZpc+UTEdMCgyaaIuMAGOPCXNozjcVq26+xR2/uxvBCD6JalHW8g+oRYGXekQkNgHTci5fAyDbGhsdaCvUBf4NopqThRkR5BMRAjEEBXfT4+pyRjkHwWdgJahQzyKoxC//EQr69Mu9stcv61PTbl6FrcTBmHkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+Q6AJqY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e3cdc1a6aso15687755e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 05:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760100409; x=1760705209; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euDBh1JPBik0jtg2IFON/RfdHFmTQnkqEMlQtD5Hj7I=;
        b=i+Q6AJqYmm8LBYnWZA8kmyEyGoHVTegHASQDDbaz4rGaIbsc/whJJvcu6vrzHNgRVB
         c9/g5dJlEG2S25+17M1PUWImRVua9g2HNFhsKv94T2aMxZJL1YL2PV6xJZmL86tgQEoc
         updU1xJHMb+MXNq5INGRue1lYsqWQ+ycmXUxkuN1Ma84PyrujDF8DP5UwjiX+y5yeu8V
         3D0QKAShx9+Nsgpo5fFl26AFnmCeuQ0QtAVXOLYN/qZ0WdEASFS8ca4onoPWMl1fu0eU
         xT7/omWnVlv5KT8YSoDi6AnpTSGwkzODlGfx5GTiwtrl+IaoXO+f3Fxv9wPmVtRrxzGN
         BPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760100409; x=1760705209;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euDBh1JPBik0jtg2IFON/RfdHFmTQnkqEMlQtD5Hj7I=;
        b=f9fzrLkZyK7I/roGO/VKZ85tGVHoxDJ84puLgiPCJ97wfOMpF8XTa92jcM0Ht73PfB
         2Aux37jXSSgbQoift3WJruviAa0ZZDjTSIXeo1fbPoH/GtuRw1USO8kXTfxMFKFGeUXu
         ELNmN20OomiAi27hxJ5ZSypcaXWkR5LIo5srTtITDIdYvXUCeWqynGqPKERUCSzGO7bB
         4FNMWpt3ttbJVu1qli6GEXe/H7MPCOhKRrNGLZblfK5hvqlVNhup/ifpagCkDNOP1BHL
         r+uKBf2BEOCvT7+Q8cWyFgdJH7z/+Y4YMi/JjMhbPH9wcTkTOMdpOyFi4GOVU20EcSCO
         1NuQ==
X-Gm-Message-State: AOJu0YwNfOfuBzbz14H0U880FJsD6QN0+/NyKufCYAyzU0qveSqWuTrh
	zsd6VGR5EaSSPutyU0a0csQreehNPEELJ6mUpAiZk24XCqzV0Xo8na0DQVldYf77cNA=
X-Gm-Gg: ASbGncsi4iHJOIWiGeJQVferLBkHVeyMdekb/VWNPhk0W/4Dy2K6e5D8pmKIwFIJAZz
	CDdP+iVB7R3gjTCqPxKa1K/SUeZRlDeFJcJ97cCmnhXVmRJBwYAYmUEht+ADnBoajjO7zDHJKXO
	W2Mq8fJ3Gr4kb/XcKE3JiTDYuiwb4HM+cl0zWeZ+eMRVd79SRr6ZczoEUIRKXrL0vNvzGxjC9bK
	n/W0rIbpPPNTGCbyKET9VgmrSZ7vzgRm7tGN2b2s0SOjAr+gaBeZLpV69sAiWt8Ol+7YBosPkao
	fOAdXZVvzDZi1GJtkg0XzxMqSMaIh2bsam+8APA/vixx0rhl9QxPuHmnV6rXWmPe7RyEYmydTJZ
	0QJdM4dvvcoIJtDkUfefc2CSEQsbOFwQEce01Sis8CQ+BcVBL0RkWZr6M5G0SfEvTmBC8Zp6I6W
	XigwnlgfxK1dgqrxpPLwbi/A==
X-Google-Smtp-Source: AGHT+IH8x0QfTr6wJYCjDE3d42CDoKbarW30rvQ/Cc2ORyEX4B7UUOdkskMSSnIc4XAyGE82hs4N5Q==
X-Received: by 2002:a05:600c:6592:b0:46f:a2ba:581f with SMTP id 5b1f17b1804b1-46fa9ec796bmr84534875e9.16.1760100408792;
        Fri, 10 Oct 2025 05:46:48 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb484d056sm46376895e9.9.2025.10.10.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Oct 2025 05:46:48 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 10 Oct 2025 12:46:36 +0000
Subject: [PATCH v6 6/6] MAINTAINERS: add ACPM clock bindings and driver
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251010-acpm-clk-v6-6-321ee8826fd4@linaro.org>
References: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
In-Reply-To: <20251010-acpm-clk-v6-0-321ee8826fd4@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-clk@vger.kernel.org, willmcvicker@google.com, kernel-team@android.com, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760100402; l=1202;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=hUk7p7wXwxuWON/P6SaBYN67C9x3HyQcVroLLSWoXfk=;
 b=Enoypv5lWz1jLL8VOiF8wE4cWDFIyo47tyJbQitxtWSbq+eKO6jjL0y+BmtW8IkT/uywAVSZb
 namtqWy2kaMATnFmk94Ffxc0XmxkNambqyqvWPYoai4R6uOhoewf3BJ
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

Extend the Google Tensor SoC support list of files to include the
GS101 ACPM clock bindings. Add the ACPM clock driver under the
Samsung Exynos ACPM Protocol entry.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a27901781c2b2589a0f95678cf3df06401cac3c..6a6727ceeef67622e96441165aec542a2cb696c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10599,7 +10599,7 @@ F:	Documentation/devicetree/bindings/soc/google/google,gs101-pmu-intr-gen.yaml
 F:	arch/arm64/boot/dts/exynos/google/
 F:	drivers/clk/samsung/clk-gs101.c
 F:	drivers/phy/samsung/phy-gs101-ufs.c
-F:	include/dt-bindings/clock/google,gs101.h
+F:	include/dt-bindings/clock/google,gs101*
 K:	[gG]oogle.?[tT]ensor
 
 GPD FAN DRIVER
@@ -22756,6 +22756,7 @@ L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/firmware/google,gs101-acpm-ipc.yaml
+F:	drivers/clk/samsung/clk-acpm.c
 F:	drivers/firmware/samsung/exynos-acpm*
 F:	include/linux/firmware/samsung/exynos-acpm-protocol.h
 

-- 
2.51.0.740.g6adb054d12-goog


