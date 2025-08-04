Return-Path: <linux-kernel+bounces-755479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A252B1A6C4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EFC41883F8A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97722271471;
	Mon,  4 Aug 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myURbJ25"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D7726FA58;
	Mon,  4 Aug 2025 15:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322918; cv=none; b=FC/P7x280MuaeOuWi0gOK8jiPGXieN0kaxy7L0ydmlET3iUG8F+I8SP6GsOsEfs8A2Kp+F+cZFFN9pdiMJwme4QSAVPf1AGdLq7+NOZ3pIU1gZX4veW7Wa5gk8iF32y6mpnwLmm0UZd/Wpsmm99BB7qmUHadkSIkko20wrhHBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322918; c=relaxed/simple;
	bh=TPV/gANFLQmr2bfUQV8zW1ahfpoF0zZmztpolXyucCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hx5LYtQkgoW2Nv5WIs3+5UBpijDpgRwXkhe64AiergEd3vrvRBWicNTmcJ7Jl3w78H8Oty0BDOzEjlQoB2UKP/kHnRWrwyXTkrW2gXaVAy5I7GduGl84C4b1O9o//qsDDz8dnDRdj4sqRWi9YjZGWx5FovPc9dwzjFaVfpKQL+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=myURbJ25; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-af9611d8ff7so274825666b.1;
        Mon, 04 Aug 2025 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754322914; x=1754927714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2SQBN2LqLgnFTTK1bF/iTPkYmGpLMu0WNvqsbmaEDQ=;
        b=myURbJ25+6NYkVk5bi9Jmg/8zfqadCjTEZIODD2T0HxSSFDa9PaQD6dUje02TGAzc7
         AsAwjLmyGZTuUrfU6MOWe1LUgF+F0MPASIoTqg3HKQ0ZrxocI3Qp1VKOA+Xav9ATlncx
         geI64G4x8kVhYFHGJePtx6OjxDfzy0nqU5AJETn7+Z06DxUWk4H1Fi7MG1zBNiyjLWrS
         GWp5q2M6Fr6woZjR4fdv3qMh9KPnW37toS3BBwKpcjrjQGqsmvobLcdkZIZUMF8B8zU+
         46OhH2yClDgefEUTAoUc7tt4gR3a3vaMpQpxtWVUC7AbAECO7iOL2MlkRcyTtuP9qik4
         ABHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754322914; x=1754927714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2SQBN2LqLgnFTTK1bF/iTPkYmGpLMu0WNvqsbmaEDQ=;
        b=Y017Y5Y4XXqqQ8oSdRNhkX0A2/bUnby0TgBkbrxhYYG7VfiWlo2uWJORlFrOZyJA9/
         OoSPEy6DtTfasO09Y02Mih3TiO0gud62Q+jm59rJk4vvJ+JXg6R6Ub+QRfH6iQKxKDrx
         ru7wtFtaGdyHIi9B24PieoiRB4fhO/uAMIBPPU8E4jNYkM7PBuZvRFWc1mTYDFALBCqS
         0H5hKPpYfy5yYUpiqqccKBOZUG/39d5G6286q9CNwoFYUnO6Y78GOc6qy7obEvm6LgZB
         D0ufeyOsstjYlnVmozI6FvnfnDAIWJrgjWqX4aSwU8QKYneyTeiU1GZfvGWdrFlamcYA
         pb4w==
X-Forwarded-Encrypted: i=1; AJvYcCVLLnvXz1kPSrspmr3OPC1BO9DdEmCEhG7H1O7vWkG2xLcTsZVe6fBwSgaMarAu0IQ7JnhxECV5+YYJ99jD@vger.kernel.org, AJvYcCWlKquIgl7X9erBHzm3j49gJIIeQb7xyC0aM1+Q6wJgKyf9WBVXLE5pjTIXH4vRgJ2RfFdhiN76DML9@vger.kernel.org
X-Gm-Message-State: AOJu0YwvZZYMO17l9XL1/xMzVqGS2wyE63KLP0LaAJrCKFWQ/pifuAR0
	QVeKY2lCoVPi7tNMGuESF1DSoRodEOWTB/uJTJek2KycG1PGzZFdtUfO
X-Gm-Gg: ASbGncvSzo8pQbUVOjQAMcdL58+akDvSOsEbWIIqHxKouUNGs6isNdpkydnPIpLdSTc
	Qqmeq/LYbEJmz7ZcCqBSmK5PkRCqKoLJjpwImO/UKM/mIeqk/c30Jrl3KQorIVG8Z7DXDGzSnP4
	lRKOwnIJx+LqrRkQ/FDEwMob21mKV1f4JQl2Z1jiOMVsyhDfuYDzpTtDF4snk+np/IjlCNRuH+L
	XncmjMPZT5u0DRDHDTU8o3jhFSIoPJ0/iVdyFBFzJq5nzwNTRcQl+gHD53hoXnuDA3ra9mYwMfP
	9KjwozG0PeRW/dZxpcsdJoDvf/OWxuLCsU29qbMgokTaKBAFbE1cd0Y/3Z57WHoD7aeWA/mwQh7
	ScRVGfUFdWvRxHm0i7CBbiYgHdSastJy80iXT0B7nsAh8SUElRoY5zN/EBnE=
X-Google-Smtp-Source: AGHT+IEWkAzWDKPbEqjRuqq3sF8A9XVVyaZnj3ChlC5hZyh9wED/CGb0dzmMEblht1brVSC3lOJCEQ==
X-Received: by 2002:a17:907:9722:b0:ae6:c334:af3a with SMTP id a640c23a62f3a-af97d21fc73mr11381866b.6.1754322913598;
        Mon, 04 Aug 2025 08:55:13 -0700 (PDT)
Received: from playground.localdomain ([82.79.237.20])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a075a74sm761114266b.17.2025.08.04.08.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:55:13 -0700 (PDT)
From: Laurentiu Mihalcea <laurentiumihalcea111@gmail.com>
To: Abel Vesa <abelvesa@kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-clk@vger.kernel.org,
	imx@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: [PATCH 2/7] dt-bindings: clock: imx8ulp: add SIM LPAV clock gate ID definitions
Date: Mon,  4 Aug 2025 11:54:02 -0400
Message-Id: <20250804155407.285353-3-laurentiumihalcea111@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
References: <20250804155407.285353-1-laurentiumihalcea111@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>

Add ID definitions for the clock gates managed by the SIM LPAV module.

Signed-off-by: Laurentiu Mihalcea <laurentiu.mihalcea@nxp.com>
---
 include/dt-bindings/clock/imx8ulp-clock.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/dt-bindings/clock/imx8ulp-clock.h b/include/dt-bindings/clock/imx8ulp-clock.h
index 827404fadf5c..ebebb4831761 100644
--- a/include/dt-bindings/clock/imx8ulp-clock.h
+++ b/include/dt-bindings/clock/imx8ulp-clock.h
@@ -255,4 +255,11 @@
 
 #define IMX8ULP_CLK_PCC5_END		56
 
+/* LPAV SIM */
+#define IMX8ULP_CLK_SIM_LPAV_HIFI_CORE		0
+#define IMX8ULP_CLK_SIM_LPAV_HIFI_PBCLK		1
+#define IMX8ULP_CLK_SIM_LPAV_HIFI_PLAT		2
+
+#define IMX8ULP_CLK_SIM_LPAV_END		3
+
 #endif
-- 
2.34.1


