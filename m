Return-Path: <linux-kernel+bounces-789704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E22D7B39964
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 12:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BA41C26980
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 10:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743B430C602;
	Thu, 28 Aug 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FYxTGnJd"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F9430BBBB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376137; cv=none; b=iBOic8P3o06kw9vUgP02cBcaQXYQjuHkapZBm6zVG7TYQfiDFQ7kPqQMjGRdh8+I904c7DMsf1Y7OulYotw9s63XELqu3nWQ8x2U3Kt18SJKSIqHBmDNRKnzuAMV0j5E8hwRcJ5y1hhbEy6SKEixdynKO8eSQjemXexMSPiL+WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376137; c=relaxed/simple;
	bh=wV99yE6O3aUV6aiHyiCHUEH5emPMYemriCvZoRjSOR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0cUDWsT/CqyK8fczdlAKVoBHwslI7utJMaA8i+KANes/69S5pMdRVWoN+CBLNiyXCDj53tUjc1TGauLB/LUDuBphY2YeFPnHDhU+Lady4J6tLdknVfdNpQBH4m0vixaHFReoccSU+lu5tEMqEsa36W6s17H4PdZamJ0SmNynLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FYxTGnJd; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45a1b05fe23so4151715e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 03:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756376134; x=1756980934; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDhhY5HvG69Xs1o6vbgfFhudFKBTjzhr8voCZkOZ5X0=;
        b=FYxTGnJddW77i8/7E9Ca1hNJwnsidYn5dKsKuP2QOPdUzsZehKxIgemVczAYzHz051
         2svi+KDijkj0adXHGof7TK7GS5szw2c2vhKKRlOpkIGJVwr/bcKucT3Hu0wt5O1cnr6r
         Bx+i9vsmLR+KA2k+/FNAm4C90K8ckVXkigCKHrsjoSWc8vCgWGcDBWq6FEpX/VoDJHf9
         ruA5WAUR55M3SgIN6QoaD3B7s1SKdZYpwV2kU4y0E3/NsMS5LbsFPQwR0hNh3PO02LpH
         +I2+muukPGKdCd8LbQLBPzxLdxP6oKb5T6DbegV+B494WbCKZ9Yg7GS5wMhvXpXpVMw8
         CrdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376134; x=1756980934;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aDhhY5HvG69Xs1o6vbgfFhudFKBTjzhr8voCZkOZ5X0=;
        b=MSUOLvUq86GG8lxPPDy7XCAnZ4v4eTltyzbYRzUukkW+ZxLNllKiFSghayiF9SKzW4
         eJnwvdG6oqMcWYNu3aDeMqKZ1TILbCXudVbNjYYHmLa4Ta+GzofpCqQViinjhVdvWrrG
         12JC/iqTlR1fFJ7UmonyHnTaogX8e/yV2tIWYfPHVRT1bexS+4ZQId+DUZTWUcx0eXy2
         1+SB93YBzLfgSI4WCKPkcNwa0V/t8Nc+58paSYyGUagEmadTDNpd0sxtf/XMsJn7eAFy
         fsNAVaSkyt7H33do/LCBLbIDq5mhJ7u0dO2ZcRMqXcUwJh61sICk0jwQyvTmfe5Lb7hS
         /umg==
X-Forwarded-Encrypted: i=1; AJvYcCVqMr1hJs0Te2XIxhlDopfDmG1kpP62i0bMJUWBEnov9lAhvZnmrEOh7QJ+m795Z72Kh5w5NweI7mKzoZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkVI4BQ/0gJZpC9nSWhyID6UxriU4dCSGFMKbBH/uwHf11vrCM
	vakNWiRNUlqe0U1X7ahYtVJwduPosckSHj55XcgEU1c5n4aCWDQHMGTBbFP5hOB0aIw=
X-Gm-Gg: ASbGncuYOGC1PKkOgqUtfipRCi5Dqj2L1sO0gtczU/fqqq9+GjxbcrzZHhm6Rc48RXI
	B5pSnbED73F5EbDpS8zN2Baf3lKe4iZc8n2NW2609SCYMup8xPgu70X54Lf/1QfvBi/2bo7F4F9
	xBvp6ARCA0N0G9EzNgcLwsSwtaZNuMoqbWt9b1SC6u1hT/MstxycF9v8y9lfSdemUKUC4spXuc0
	kR5AxcpiLQdMQkJ923Kn5zEIrgEcFQDhDq0hi3sLTPt+cw4IZOH/xNhj8dGqsuyh49i0BfST2/Q
	EqYbXn4bxAoBwI0AKqeNHjXlNFHiqnDo229nE5/VdxoAhNSwoIrkvbIvCmGH71naoaFsofJZG2U
	rbfRVkSX5U6J2W+W8cszCLmklLTDoUPzQY4phsrrkYg==
X-Google-Smtp-Source: AGHT+IGrzpI1g4LHphInRHv2NogHJqDObuPLPd+CQOWu2AaDbp8EhCxG65HZRkwGpUMdtcy8AaZQJA==
X-Received: by 2002:a05:600c:19c9:b0:45b:6334:3526 with SMTP id 5b1f17b1804b1-45b633dcae5mr131802235e9.31.1756376134524;
        Thu, 28 Aug 2025 03:15:34 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b66f2041fsm49976305e9.5.2025.08.28.03.15.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 03:15:34 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 28 Aug 2025 11:14:45 +0100
Subject: [PATCH v2 6/9] spi: spi-fsl-lpspi: Constify devtype datas
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250828-james-nxp-lpspi-v2-6-6262b9aa9be4@linaro.org>
References: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
In-Reply-To: <20250828-james-nxp-lpspi-v2-0-6262b9aa9be4@linaro.org>
To: Frank Li <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, 
 Clark Wang <xiaoning.wang@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
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

Add const for all devtype_data.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index fc4d49f0717e..f16449cf42bb 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -135,11 +135,11 @@ struct fsl_lpspi_data {
  * ERR051608 fixed or not:
  * https://www.nxp.com/docs/en/errata/i.MX93_1P87f.pdf
  */
-static struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
+static const struct fsl_lpspi_devtype_data imx93_lpspi_devtype_data = {
 	.prescale_max = 1,
 };
 
-static struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
+static const struct fsl_lpspi_devtype_data imx7ulp_lpspi_devtype_data = {
 	.prescale_max = 7,
 };
 

-- 
2.34.1


