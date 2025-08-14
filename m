Return-Path: <linux-kernel+bounces-769255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EDABB26C01
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0CC170CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B16256C76;
	Thu, 14 Aug 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UC6ZixgO"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495B24A05D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187626; cv=none; b=kc2RLJTeG+jGF3LIqdvzS60pzBdnt+epHG2kDeFubjUawJazmOftN20iUh3jseJduzg9co/7FIOHJxoVBFbVdnqr++EfKC4OdXoqCifEnDeV3g/8Jz1eR8QhH+Je2qptdveQEcVsz7VxM65m1tPH5uYyKVuPCxFHlWMPmXXWowk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187626; c=relaxed/simple;
	bh=LIQFUNWTOqtolcuHkK+5pFdAZIsgYQVKYSFmavPARR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rAss/qHui9Gm04fAWW53MrJ8ld8TKyQRvWAybqnqYEyOp/QtdYhxc4CQ3caNZvLnBy+GjE659ZjQ0hyTYOEle9DhTQXEco1huQ5y2QrN2CS7TiwWj8WhCPkE0SS/gXnumpjZ/VLGD+t40rgH76s1KW1NRTn4As4og+eCizVcxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UC6ZixgO; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso788471f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187622; x=1755792422; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Uvtvrck5DhEfDGyTURDlx1K5TeMVtpeGZ6H7CuQmSw=;
        b=UC6ZixgOqGpndMbxWTWe6b6053rtwQSP6FVAtHMfZXA4J+8O4tAytCkXBAKJyeB0nA
         P+H7HQ2kNCC0ZktDELHXWmb231LzqTL5DJIY7OMviT/mR60khjNdlJEK4fXcL0Dfn3+A
         Dj3yfIp+v9/kV68xFFr1wuqAu1Le3CN5hvjJZLQ4U7SKZlm6g/sl69ExuwpQMa0eXONS
         HnKz+PikUFAsjMONjp0orJzTjrTGx4Mm9wTH6Ljpi8hFApOB/fTh5RfkV18FinZU+nML
         0yHeNDtv5F0u1uj35VcFMPmm+nTIVRO21h1klh/DLUsepif2KQIx5IxpOPlJ4B0jSq9C
         y4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187622; x=1755792422;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Uvtvrck5DhEfDGyTURDlx1K5TeMVtpeGZ6H7CuQmSw=;
        b=fSWspNCgo4VK/NT7eng5M1+zszZ/IvK4JtWapsVc3q9n6WSGfTf2LuTf/BL1zNie1b
         Utn8PAz7CDIVFzB/B0tNhAI3P/E0xYPEDgIHqcVs4r6NNAT2ZIuwHbbsi3KY9dRS7T6Y
         RsaczcLK+l87vEBtTkF4bDMtb0jyeTQo8Vd+9gasjNqYTQ7Xs1SRkEfC2IFyv89w/VOI
         TpIjy8LLKyw1E5/0Q5J5bSULjF9ur9l0GWRGDXOtIYwNGyWKLY5oS356Sov+YC1GFpj3
         c4GRN/h8Ye1Sxmsj4FlrFiGLzxV2T8CGR6SlUB681SPcI/U3D7V6/N2wf3UocpkJF1G8
         wTjw==
X-Forwarded-Encrypted: i=1; AJvYcCVjduSh/uyLEgyzASleqo4ZWiQto8w45UIDZ7Ii+iUq29OPnwp8AiTlp9Cy1A4c7oldUeOyzVYXmJJlBTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGD6DFJ9oF96Sl5J4vRBwkPIr+RKDHRyeWSSiizWuOFxO2OElN
	eWGa6kd3QogXpR31Ek8IhcFAvun9T6uz+ZTjw5t2Um/EhNxj1cW3jjbwh//6ldbBEHM=
X-Gm-Gg: ASbGncuDJ3hnqTC5ovVukwyfeol9upaJQiYSzziXFD5oWTpDhklHVVHmqh7gmHo4wNX
	mhvC8b4qUYAvVQcLZWq+UQsoMiIxNC5jUE1Vqqkv8q+MtPtknoGER3x2a25z+bvl8imCn9M0N/G
	fUDkTc/+oIoxjD9WnJlrvcI8uA7+AOH4kiGEgYNAeNI45cSTSnIZqFum47nELyhgHg7sji7ndx1
	B7ENmO9Creq0BvZtpMWBKook4VTz+S8FzKb04OLmSvf0su21/DOXkCcv9GhxkUpHmigE63D7/VG
	ClavN7G1FNhwP0D1lUWak8+04J6ep2nfv2lfwYAjuvAgXZFSKg1vlUeZrfzEt9mks6jtQtkzWRw
	QRuONJHLSPAx2bL8g+KBdh9jwE+2rCDylUzIbt0HGXQ==
X-Google-Smtp-Source: AGHT+IGGBjbFKFRqiepm/LRwXnuwS+AKKH1MPA2LgWH+5Eq1mmSqrnU9CryUHU5mJcv16mc4hIWejw==
X-Received: by 2002:a05:6000:2893:b0:3b9:1d32:cf34 with SMTP id ffacd0b85a97d-3b9e415856amr2916372f8f.12.1755187622548;
        Thu, 14 Aug 2025 09:07:02 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:02 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:41 +0100
Subject: [PATCH 01/13] spi: spi-fsl-lpspi: Fix transmissions when using
 CONT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-1-9586d7815d14@linaro.org>
References: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
In-Reply-To: <20250814-james-nxp-lpspi-v1-0-9586d7815d14@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Fugang Duan <B38611@freescale.com>, 
 Gao Pan <pandy.gao@nxp.com>, Fugang Duan <fugang.duan@nxp.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
 Larisa Grigore <larisa.grigore@oss.nxp.com>, 
 Larisa Grigore <larisa.grigore@nxp.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>, 
 Ciprianmarian Costea <ciprianmarian.costea@nxp.com>, s32@nxp.com
Cc: James Clark <james.clark@linaro.org>, linux-spi@vger.kernel.org, 
 imx@lists.linux.dev, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.0

From: Larisa Grigore <larisa.grigore@nxp.com>

Commit 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use
CONT") breaks transmissions when CONT is used. The TDIE interrupt should
not be disabled in all cases. If CONT is used and the TX transfer is not
yet completed yet, but the interrupt handler is called because there are
characters to be received, TDIE is replaced with FCIE. When the transfer
is finally completed, SR_TDF is set but the interrupt handler isn't
called again.

Fixes: 6a130448498c ("spi: lpspi: Fix wrong transmission when don't use CONT")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 67d4000c3cef..d44a23f7d6c1 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -3,7 +3,7 @@
 // Freescale i.MX7ULP LPSPI driver
 //
 // Copyright 2016 Freescale Semiconductor, Inc.
-// Copyright 2018 NXP Semiconductors
+// Copyright 2018, 2023, 2025 NXP
 
 #include <linux/clk.h>
 #include <linux/completion.h>
@@ -787,7 +787,7 @@ static irqreturn_t fsl_lpspi_isr(int irq, void *dev_id)
 	if (temp_SR & SR_MBF ||
 	    readl(fsl_lpspi->base + IMX7ULP_FSR) & FSR_TXCOUNT) {
 		writel(SR_FCF, fsl_lpspi->base + IMX7ULP_SR);
-		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE);
+		fsl_lpspi_intctrl(fsl_lpspi, IER_FCIE | (temp_IER & IER_TDIE));
 		return IRQ_HANDLED;
 	}
 

-- 
2.34.1


