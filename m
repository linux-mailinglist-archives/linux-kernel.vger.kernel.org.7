Return-Path: <linux-kernel+bounces-769260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58CDB26BF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 18:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D9AF1CC6674
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 16:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FED12472AB;
	Thu, 14 Aug 2025 16:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZGBNhqX"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921825BEF3
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187633; cv=none; b=ZEhN+OS70/mwlDciTZp5QAGMz6lfvGAKsVuuJbySzoCQJm5cVggW4iJGe01gZx0mzy9XODbvKKMW1VuyaAErFf6o93rj9JOlnu5LT5TZgE1AmLdOLV1y+J6U92UXCg5qPK6b5OvxWI7lr2D6PjtMWGEd1P9Sq5KTC4mPR3Awq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187633; c=relaxed/simple;
	bh=TEu3fUN3erzyt+FPBw44SIOHKGNM0QzRYPzn7NfE4so=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cMMWsB6P9kXyBArZhBPeTfCVBTcDN8uP4o+tqr8EUnUiPtGtaeVt3W9l9WKvjtmb8Q1c8/IuCPIWPjV9iNClVhMTm/wwywU4uXyOSZsJm1BGmO5dnMLjKcl8e91W8uK0uQ1qY2ps2I4DBzY88YWh7Vyu4BEPS3kh4m5jzIo9e3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZGBNhqX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b0d224dso5970205e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755187626; x=1755792426; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMBgPb4Xq82JDov80ni4i5qWbWTDW7t8a9VlWvi+IP8=;
        b=LZGBNhqXCSFBfTMsfTypjAypvClYCc8UBt4qo1N2xtQNu2e4fPC4R+4QC7lqMFOIvt
         Hfr1Xw+ozcfCIinHAuYrx7/KxiRbalCELZ4C+DOIUeIcZqpVu53KnwbTl+8ZzrVe9eHu
         3IynDUhlbbt2R9bN7qIVFOMxmpgiManmwiiN2Pd401Im2xTQb9MGNuMLImlbR4iYbjGj
         STlCbAEwaFR6GJcAnl2PIh3NTakGqfC0fWigJZLDovYgzvM44T2/LD8B2tJI9YofAqgz
         SwKIEGIuamQv1nBA8uPMeiCmUaC4whNBdrt9yD/m3Y0Qihl78tF5J2GrOCTFdTzvUI9X
         SAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755187626; x=1755792426;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DMBgPb4Xq82JDov80ni4i5qWbWTDW7t8a9VlWvi+IP8=;
        b=r3jX2bPHMf9COJVqvc9D9jDiQXLUr0mQZe8fg77Lq41S0+lb5WmyNRGKBK5ZkZubB3
         PUx7o9N508rEnLo5VPEcQDsCQW3Xl4keAKKb8VQJyipG/L6HKc9EYHkP5+s9Qd2CoVrF
         fWEAY7NkwXBh/Aa5R9siW9Tb5YzHdOs0UOsgLbJdYROoWPKcWKZbfl1tVVGsxXGjHNeX
         ubPm19GN5Nnjfrx2OR1DrxJl3X7QBca5NZzXKLe2Co7PFV5Qm3OP1HFJyj1igwGrniBI
         jCJnHdNV2/5SsWlNg8+rFuSfUuER+Hw/4gb8H5HzOZ2+D17IwElw4nsNZQuDwn+CFEK0
         j+Fw==
X-Forwarded-Encrypted: i=1; AJvYcCV1aS+jNfdUXxtWjRE7Hy8tItrQl99dECtzUhSHjmhk0XFRBT+bK2KLQDVIMyejaJRUgjJ1KkS0RWeAMsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/NCQuno/0jIehJVRQshfKYEqaE/V8XCsqqBpYRUbJ+Bepwd9
	9fqcbB6GlQmt0UL4UaWW6Rg6e2b7yQLge+gZE1neCK8Jw6uhdDc0U9X13cR02dtSTls=
X-Gm-Gg: ASbGnctuzlKodUVtvwNFHbQTLjDm0YrlsmYIvJHy1cgQFMv6AwScN3nneTuBfN5pUu2
	CqA9sG7oKxP4l34dTWZVhUZisoM1QXa3Bq5KdztdV0IGdPZML6449Zk9qXkU0VC3hnuKIV/6UPi
	BVfCEy4QSp7XY1S9DdQGuiMuuS7F0LOF/1Mb+nxcxi133SYdAcEeRY5HyIW7AAKZuwrwVriGP90
	IRh077Clq5r6VkJ32R+C+vpzaYBcoj7wMav3Kg5KslJLxFamT5h0yBQd5UNJbOAGbam20EHITgA
	bMwPPm2OiLFbCymelKKZ/a9Q7E/0XhqotFowD7UHnFP9RphaDha18gHhOt7htuRlPA3f9UeiDPT
	QN2HqiHGtgvgTvW7iCuHw5uVM680iruQ=
X-Google-Smtp-Source: AGHT+IEOT2wwsPyctFrgMr5ByDkZdw4HXDUlDk99xnD5BV/nP3sUkqvIgtuH6uOuro0r9fJd4VPXLQ==
X-Received: by 2002:a05:600c:870f:b0:456:285b:db3c with SMTP id 5b1f17b1804b1-45a1b88d5fdmr33513625e9.3.1755187626069;
        Thu, 14 Aug 2025 09:07:06 -0700 (PDT)
Received: from ho-tower-lan.lan ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6bd172sm28363495e9.6.2025.08.14.09.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 09:07:05 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
Date: Thu, 14 Aug 2025 17:06:44 +0100
Subject: [PATCH 04/13] spi: spi-fsl-lpspi: Clear status register after
 disabling the module
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-james-nxp-lpspi-v1-4-9586d7815d14@linaro.org>
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

Clear the error flags after disabling the module to avoid the case when
a flag is set between when the flags were just cleared, and when the
module is disabled.

Although fsl_lpspi_reset() was only introduced in commit a15dc3d657fa
("spi: lpspi: Fix CLK pin becomes low before one transfer"), the
original driver only reset SR in the interrupt handler, making it
vulnerable to the same issue. Therefore the fixes commit is set at the
introduction of the driver.

Fixes: 5314987de5e5 ("spi: imx: add lpspi bus driver")
Signed-off-by: Larisa Grigore <larisa.grigore@nxp.com>
Signed-off-by: Ciprian Marian Costea <ciprianmarian.costea@nxp.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 drivers/spi/spi-fsl-lpspi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index aab92ee7eb94..79b170426bee 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -82,6 +82,8 @@
 #define TCR_RXMSK	BIT(19)
 #define TCR_TXMSK	BIT(18)
 
+#define SR_CLEAR_MASK	GENMASK(13, 8)
+
 struct fsl_lpspi_devtype_data {
 	u8 prescale_max;
 };
@@ -536,14 +538,13 @@ static int fsl_lpspi_reset(struct fsl_lpspi_data *fsl_lpspi)
 		fsl_lpspi_intctrl(fsl_lpspi, 0);
 	}
 
-	/* W1C for all flags in SR */
-	temp = 0x3F << 8;
-	writel(temp, fsl_lpspi->base + IMX7ULP_SR);
-
 	/* Clear FIFO and disable module */
 	temp = CR_RRF | CR_RTF;
 	writel(temp, fsl_lpspi->base + IMX7ULP_CR);
 
+	/* W1C for all flags in SR */
+	writel(SR_CLEAR_MASK, fsl_lpspi->base + IMX7ULP_SR);
+
 	return 0;
 }
 

-- 
2.34.1


