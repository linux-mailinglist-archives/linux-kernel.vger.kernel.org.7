Return-Path: <linux-kernel+bounces-880223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E375C25276
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 14:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2AA964F583E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3425E34C9B1;
	Fri, 31 Oct 2025 12:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkP7DDkJ"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9D534BA47
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761915375; cv=none; b=qp/cDL6bDDsRL0SxueooT/5ufly8w0R9hmwp2n+B93asPDM1Hk098ol+yR7GIob94/FDkXEvmIlE83tUt1rHYCkd6lfE3PgUS/katqOg1QpPUtdUQCo6XXqOQaK/H0QtByFtUlMBNOD76BuqNTBgTYB+2zeV1Q7GPxBMAcXpvwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761915375; c=relaxed/simple;
	bh=FIHoekKrBczbbS2fXtyE+7Irx4O0EiIRwRvzO55FnY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PX1/SfCLgZ0jbv7At0ixG+MDi152/yrrBtUKfCYSfWYz0Ca+MW6bvD/ZjpG5K+RkCrSZ6Q8LdvzEWpe84Mz1Yn5v/tx9zxvwciXEkXjdO1QPVxkPkI+m1daMAyCHD0HBadsVX6i9cX2LOcdgn7a4D6MDvtg9MgvMsA4hDqK39Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkP7DDkJ; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-475dae5d473so17864875e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761915371; x=1762520171; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RV56NpH1lI5ED8FEKTPa6jAqZswvvDhZwVi486+R9e4=;
        b=NkP7DDkJqIfPwc30HpGIC9tTwvVmgvvX1iZq6OzQRMHEDLphKfqE31dFP6rHkWoRke
         IT6fGqav5r/lIgw0x8le9UkgTojnDyr9IjKYB6gH1D6XtAj8BNxnWoPU6cHj5ADN8piN
         1dI4lFWSixfuf2McCjGYAlSJAYJaZcsqukSyQ0tmRbHu97fK4VGHpuIt3cX5SAEABfXx
         ho5mQYj7uTylXD0ZW54JVIY7wjuIQbGOG3YL3usrkoU0x8XAIrdBuC3YrsVBPZn8doIB
         ZreiG92vzS6YWSc1ePsVHXF9SSAH9CxUhq3/mvby6jGmXkk3YqdgMH8eYt9a1khEChhe
         qRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761915371; x=1762520171;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RV56NpH1lI5ED8FEKTPa6jAqZswvvDhZwVi486+R9e4=;
        b=u32cDj/v6MOml5RktoIMP7f+LqyY+Prt5X7JqAAqHV6cm+C8YPeSneTkxolDUNh9yT
         PghvQbgMY1Yy0sQT1PeSQKVHt3Gwn9KRSyC45WmOZWNllsgHotZ7dha6pLWkbbNm2BfF
         5chYBB1Iz4ItJjuihURUAKcH/cjHn9u7LBuDzsCj1sdBBl4gbWDKhwFpH9afSlvqJv9Y
         E4bKoUZQuuPAy1ZAh2rGs+jB0wAz6+ijkf49b5q0qBfx4UiPv3bU6qn59/EBTTrY834V
         C0lbknt3cWq+oNnJGlG6a5aes/+FjMHJxNSplDNmaa8Z1qCH0+jecn+wJH1/ir1oNXAu
         i3fA==
X-Forwarded-Encrypted: i=1; AJvYcCWGsUgLw/VTAD2B15aOL9hRMltrT3Ve4tRZummmF0ln9i+2P1+rmrSb3ZgQgqZfMxxxv2fUNro1FMf0dGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+SqwdJpfE/eDgg/iCMBEUQCN8DQL/yNN37SkaMYAtUrGM8cBG
	2aKjM3mQOPuSY+ZmcXHO0Rhvv1EylPi5VGBBGepQFVa3maxQVg7ofBtZi5eb7/IFye0=
X-Gm-Gg: ASbGncs/g+Il1AeZsnt2+5rtz9YipnQm5+dtVbXaQ2172cdsOhtlMQYidJv73dBZMQC
	ZLUJ9tFAw4+eZBC5TQ/GlVMqudc3j4KYeXF+Veb5V3X77l/5eTVFK+L4v83NdU1xn7xaZPhaLgR
	iaoTgxXvrr8K2Zkkb/vE0Vb0++6KL8Ds84SDbeP2JIFc+Dbc5bH6TMW+g1S3wlfGZNOnVB1lBzK
	Tc0LTdp4MqJaVGzNdV/imvkqLTzTqZeE+Lf/kwCfFFmJVrf8MgHeL+0zSTnc1+he/ok3KSdFvSY
	XgGCqMKmUm2CjHyiiGTq6w7ozItoFHXRvrlG1IefTEhOe1vcniGq87t7wwmtyDolrRHDG9xaXDd
	iG/SzU6x4WUUYPcr7rY8KsJ+PVRvWdevqV3sgsRzLbMEj9q8PgSZfd3MvyypE9YALNhIo+FPxZD
	+LNBidjpN8jQg61oIYwZidfh1kCMJW0pGI4eoUI8bYzhU1+aln3xrT
X-Google-Smtp-Source: AGHT+IFeggZ5me4AtsVkM9uFz8xqiFgrnYQxbJrRB9xgQZPpOldZCFch7kDit8HV51sz6CbJralSnA==
X-Received: by 2002:a05:600c:4591:b0:477:c37:2ea7 with SMTP id 5b1f17b1804b1-4773089c4acmr34565735e9.21.1761915370805;
        Fri, 31 Oct 2025 05:56:10 -0700 (PDT)
Received: from ta2.c.googlers.com (213.53.77.34.bc.googleusercontent.com. [34.77.53.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47732fe1075sm31814585e9.11.2025.10.31.05.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 05:56:10 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 31 Oct 2025 12:56:08 +0000
Subject: [PATCH 09/11] soc: samsung: exynos-chipid: downgrade dev_info to
 dev_dbg for soc info
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-gs101-chipid-v1-9-d78d1076b210@linaro.org>
References: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
In-Reply-To: <20251031-gs101-chipid-v1-0-d78d1076b210@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761915362; l=1062;
 i=tudor.ambarus@linaro.org; s=20241212; h=from:subject:message-id;
 bh=FIHoekKrBczbbS2fXtyE+7Irx4O0EiIRwRvzO55FnY8=;
 b=3OjTcS0UxbHqkoISucKjpZEuvX9vXYQp9nnD2kJ4+sGz7IPnIXZMCM6+YJE0WSVoEpcWN6fhL
 AHJDtb+21OcA7QBhRkXf2VyPH00dSPqRQdyZZ3BygbNy9FOa1XSl/mr
X-Developer-Key: i=tudor.ambarus@linaro.org; a=ed25519;
 pk=uQzE0NXo3dIjeowMTOPCpIiPHEz12IA/MbyzrZVh9WI=

The SoC information is exposed to userspace using the standard soc
interface. Downgrade to dev_dbg to stop polluting the console log.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/soc/samsung/exynos-chipid.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soc/samsung/exynos-chipid.c b/drivers/soc/samsung/exynos-chipid.c
index 92cd5dfc0a9b641428d0d047cfefd4256a893ac0..70e09ac656e4b95d5d252272bbe02bcf0f6fb2ab 100644
--- a/drivers/soc/samsung/exynos-chipid.c
+++ b/drivers/soc/samsung/exynos-chipid.c
@@ -241,9 +241,9 @@ static int exynos_chipid_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, soc_dev);
 
-	dev_info(dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
-		 soc_dev_attr->soc_id, exynos_chipid->product_id,
-		 exynos_chipid->revision);
+	dev_dbg(dev, "Exynos: CPU[%s] PRO_ID[0x%x] REV[0x%x] Detected\n",
+		soc_dev_attr->soc_id, exynos_chipid->product_id,
+		exynos_chipid->revision);
 
 	return 0;
 

-- 
2.51.1.930.gacf6e81ea2-goog


