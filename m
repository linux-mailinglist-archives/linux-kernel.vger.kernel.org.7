Return-Path: <linux-kernel+bounces-768402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07539B260B0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:23:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8376916CD63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0252EB5AC;
	Thu, 14 Aug 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+Lig8zD"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F80E2E9EB3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755163102; cv=none; b=OPi7P/re/IVJkHGr8fmXOiBPZ7gSyCcqCzGAK+i1w8zsAhngZqMU+p6dyswLiQfRRrF/ga8zj6wmcELIOM97UBej17w1WhTzQl6kS95VQ0mVZbr6siBCCSzXYZr5d4rkBOMEh8My+mBnHphy4/dbGQGdxSMXuUkeJyC2y9hoVTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755163102; c=relaxed/simple;
	bh=rHzxROU5ryoJgm5jbG0atVnTjdbnBgsujevNDGx2vtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k8d+Vpx7ePucmnfHte0+3KYVjui+6G1hyesQk4PrDajwAsaXrIOb+4oKZJxTUB1Zh3LHMJl1HlkHWkmalq0XH/PSDIBaE/wH89ywX5eE9j2rLSQnlemPsPEVzPEMoFKMlECAZ/k9i5G1ukSI/PGZ+icYIoz2b5Shh/m6xHU6TFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i+Lig8zD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45a1ac7c066so4619875e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755163099; x=1755767899; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZAaDT/OUbXmcuIyI0UD5MRIk/4NCc8MDaMt6MhGlz8c=;
        b=i+Lig8zDYzYzs8M153W9h7U4UoAccDfTerkDB4LC4hHj+TBjJ4V/Zn+JZL2xU4hxFU
         m7P5ghzGg3qeDD9zuAU2NLZZIqac7F2IKYscBbE4BeN/xosGs94HxBIhkjf2mfz5ERgn
         b808wUFpWaFwfaCbupBWnzamNzO4dKbffb3RvfrCDCCHE6m0DKfYadfoGix7rB6CBeSV
         SDK2qE2TjEuJVWKnjfrDyBrHnKsEtlU9Txj/NAcBlgkJKJwCp3hXoSglxEqNpD9qGI0N
         0VN6yLIvwtfVRUZPD5KeezQ73h+mTMLYEPKlY5DdpXbxEmWFOW2aMhcUMBvWbdSUFTlZ
         6m3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755163099; x=1755767899;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZAaDT/OUbXmcuIyI0UD5MRIk/4NCc8MDaMt6MhGlz8c=;
        b=rsekR0xol2w12/stdQBsitUvq/XDjNlgA/tAON0twqQlYL/92CFqiHbZtFXT7NhhZp
         AswLgTyr1Xz/KEk96OiF7ScoHUQ1EYXopRn1x8AbXLdfBPl/a4lNs2OlYjALw5ZG9yZk
         ntQFqVUl8Yjoyy7Xfe6/DWUK3oCg61ZaFNoO4IYkXLDK+hb4FFFPbGAbovply155+KrT
         szTiQHypMN/V30C019kB21xU7WvS7WvZyBeEcAvKeM//iyejk6sPDkVZrollXsXdUjpG
         ALbCCmsVBcLf/0nVyQgZyIRQ7gvtrh6dYgD6diRLIY6+clCNWP/Dz00/bf/T+C2IW3EE
         YXdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD7oF+B/qZuOjW4kcQG8D4PNg5juC0B0P9+cGrczEfvrbxVMQjAMEzbdOcXEMzL7rf7oxcySScQKcI7lI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqfbhAcuMDB0i157r/rwO3Y+C0J/lzK4RNYVY4xEf5ELgwHNV
	/Obic99dTdTaK07mMM64FcZ4VyWl8RSGS3EQSoZkPPJ8u9KRA71KFfg4StwyUAY/O+w=
X-Gm-Gg: ASbGncvHAdXLT7d832idngN+M9YtT2OV14xVjveEzrEvXAPHjSGCj/J1DA7jf/G/qsD
	bGf51ZePIQai52v13i3O8fAWs6KtERlhBeK2p7ju5pYpy1ZhdPxpCif4zrE9m2fH5vq+3ytJG/X
	SKc0PSAzCpSaA6w3mXugH1ofoeuHwO9oDGXfZJ1Bjs2nPTTDiaMqDQbbYO7Uz4d4aUHup70gKGR
	CjHiI6o1fbm0xDObvk6axR1THgkIXdEuGu+TODqsYYv6PNNLSQ/WRo0QYFn1C6bYSco4zj84oBQ
	+zkY3VCzhpglkzp4guONqPyNuqkKtpE9ixdF/zHlBbudBqJfGWHpkQcynOHpnsjRuvtF/dbFgVx
	hKyVeGibbptptXSsmD/0a4RJh8fqq7VGHzrGu
X-Google-Smtp-Source: AGHT+IEja8CLfTSNlKR5f4WfpXSN4rOwyS5Xo1KeZ5Yr/TOyUiNzdSQo50qDF7mxVImYpzfwRhB+ZA==
X-Received: by 2002:a05:600c:3503:b0:456:ed3:a488 with SMTP id 5b1f17b1804b1-45a1b78645emr16883635e9.1.1755163098783;
        Thu, 14 Aug 2025 02:18:18 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef41:ea13:2485:4711:708])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c74876csm13861925e9.14.2025.08.14.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 02:18:18 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Date: Thu, 14 Aug 2025 11:18:06 +0200
Subject: [PATCH 1/2] driver core: platform: Add option to skip/delay
 applying clock defaults
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-platform-delay-clk-defaults-v1-1-4aae5b33512f@linaro.org>
References: <20250814-platform-delay-clk-defaults-v1-0-4aae5b33512f@linaro.org>
In-Reply-To: <20250814-platform-delay-clk-defaults-v1-0-4aae5b33512f@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jessica.zhang@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Abel Vesa <abel.vesa@linaro.org>, Michael Walle <mwalle@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2

Currently, the platform driver core always calls of_clk_set_defaults()
before calling the driver probe() function. This will apply any
"assigned-clock-parents" and "assigned-clock-rates" specified in the device
tree. However, in some situations, these defaults cannot be safely applied
before the driver has performed some early initialization. Otherwise, the
clock operations might fail or the device could malfunction.

Add a "driver_managed_clk_defaults" option to the platform_driver struct,
similar to the existing "driver_managed_dma" option. If this option is set,
applying the clock defaults is skipped in the platform driver core and the
driver must do this itself when ready.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
 drivers/base/platform.c         | 8 +++++---
 include/linux/platform_device.h | 6 ++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 09450349cf32364bcb3c8dd94023406442ec204d..c7278ace71d3f6d473fdea35bf79bcf80a56ee21 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1392,9 +1392,11 @@ static int platform_probe(struct device *_dev)
 	if (unlikely(drv->probe == platform_probe_fail))
 		return -ENXIO;
 
-	ret = of_clk_set_defaults(_dev->of_node, false);
-	if (ret < 0)
-		return ret;
+	if (!drv->driver_managed_clk_defaults) {
+		ret = of_clk_set_defaults(_dev->of_node, false);
+		if (ret < 0)
+			return ret;
+	}
 
 	ret = dev_pm_domain_attach(_dev, PD_FLAG_ATTACH_POWER_ON |
 					 PD_FLAG_DETACH_POWER_OFF);
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 074754c23d330c9a099e20eecfeb6cbd5025e04f..fa561dae2f106b61d868a870e10d9656542b1c7e 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -250,6 +250,12 @@ struct platform_driver {
 	 * to setup and manage their own I/O address space.
 	 */
 	bool driver_managed_dma;
+	/*
+	 * Skip calling of_clk_set_defaults() before calling the probe function.
+	 * Use this if the driver needs to perform some initialization before
+	 * clock defaults (parent, rates) are applied.
+	 */
+	bool driver_managed_clk_defaults;
 };
 
 #define to_platform_driver(drv)	(container_of((drv), struct platform_driver, \

-- 
2.50.1


