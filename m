Return-Path: <linux-kernel+bounces-781006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8405B30C36
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 05:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CB531C28953
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 03:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9F9279781;
	Fri, 22 Aug 2025 03:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="B0tZ7czM"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A031126A0D0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755832012; cv=none; b=HPkf8LQtQBl5xfPDfTFcMo98wm5SHBOhOgF0p+LZG0upTGT7vzAhEnr5bgNzzPeoJvfXQxvX7aRBEpgnL/Y8Gd1kusaVSyc4NKjKhyIhM84MPkX6ObuZ7M7cSdDmYswQypQEdpJiiZSWMAJpFDgmiJJaq9qjqEm5+EsP1lpbWdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755832012; c=relaxed/simple;
	bh=ET9r67SBgRJAysqntixUlTo+ibcE6/lAnyl7Y1qAqb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nMPMg5xfpQ3jHyZ9suF3cd+xftScAS1WlvIa9/QT144YMtWMbHuloR8x1WktbK8LO+jft8nWJSqPgd82rinjp4XP0Payjpeat6gCE6YEd/rA95TH34NfDuMDeZf0vcCTTCy1BHOKzbe/pbcKIS8QmU2FgimKbFhotj88OUPqv2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=B0tZ7czM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b474a38b25cso1410311a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 20:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755832010; x=1756436810; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dC7kl9A7D2BWwkfx5jwlJiGlSj0s6ZSSxNG7ocAEL44=;
        b=B0tZ7czMfJU1/ngOrYt1uG4xgRL1v5wO7FI7uw8nMNDvz9w5K7y7KlD2C2wqtJ6ZNZ
         iAyhYZJhcMdCqKznP7r4Ze2vYL19/G85Ky0Xx5EF/qPJUPS7bdnSg+5umBIOOb5IbDTp
         V5xPIWuHMHj2Aru3zlGSyOo8U911/MyJOD4qM1koPkWsYxvxRJquqXrLKSuItfXH7wCw
         1+TxlMsq7P6gRaBrI2Lc4azw8PmijKbmbgBPwFNUNAE2KFecENYDT3cjPh9AogoBjjp1
         XkDxUCk3PHe6Qa0CrMLV+D/kDwFyOx0A2jH9L1qZE9M0ck5QVGn+lxzpdNLgEjEOcY9n
         s/QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755832010; x=1756436810;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dC7kl9A7D2BWwkfx5jwlJiGlSj0s6ZSSxNG7ocAEL44=;
        b=V6wfD7XIW046Ye5KUxnpUEbZuljvzhyLknnL3PVLpavhOWvt07g1JIutYKfg+/wVDv
         A+6pZ0qFu11PDT9uAHmT5w3kgOIqlwCxb4ogQ4NGzo9Sd48TJFgGrqypkGYYUQ6lU42I
         oex1hy3QBGTOVjs2HuAkmarw4pJyar+jS16/BlVo/JZJgedScwTCJF28+b+O7VyUyWCb
         8YSpkWIrq6E1uiWLk68ACVmHER3ciIORFOS/f/1wXucAXlwKRsoDk72gcl7amcc0uGpE
         lb894baQD4IcvbS4BygkBQqt2N2rf4JH7c3e7E0q39MUQ0s1OaK07ip4g8NJT28a8OLv
         3GYg==
X-Forwarded-Encrypted: i=1; AJvYcCXRhW6GIgzx4Qp27szlAMRYxdPdAsuyKkSxSbWrWp3O+eVU9zQAGjo1lZmZjHtXarg58E8Qidnfue2sc1g=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj2+YR3x9cIlfaCoaZQzsYUpE+TNGk0gtR6t+d51cwyDulfmLh
	dsKlQLDrfvLvWhyWgNLgbprYFX5hD3OTLYnq+Chbaf6NMiagV8x+7nVoRyQNgy75O2lt3mdAKpc
	OoZZu0F0bW8g3
X-Gm-Gg: ASbGnctEt0v7KqgffqkKYBkkAEpw4uHaNsSco0IhmD+hc1vUUjgz/mbmhlgUj2sizQt
	WN1OWv1kx+9Oqo/XQfn1ixRPGy7gCtbssiaQhb53Ur7pqeTYdEMVLSoG6Ja+E5T+If1LfckKX+8
	vkQCZOuoarkg4RLmjIGs8NGd0hPGjUmV8X5H4ZGiNGlD1B3UWyfp5+gQjRq3M5jGrUElE0qNgJS
	nY0Ti5j7ODMaCV6JRqifUe+pWhNsBSrkU8iMc7zVONQafscJwwRQqkKO4BOuEIvWl0ljBUuY1eq
	PUvZ5FRwtjCv1X6ynIOZ7EMbzZBk1ScdtntgSs5HhcQthjuq3tEuwvWnIovo1O9yr3IF3ZtM6Mb
	u73UfZnq8up8SjJojjjQEOu7cIOfqrFn+QA==
X-Google-Smtp-Source: AGHT+IEAIhdT3Tfgdb8iNC0j7z0iqiuqLPLYGzXSr+7++MUa1eCRn81F36zR4QAh/yOgPvq9YcRdkQ==
X-Received: by 2002:a05:6a21:339c:b0:220:aea6:2154 with SMTP id adf61e73a8af0-24340b016bamr2141981637.17.1755832009592;
        Thu, 21 Aug 2025 20:06:49 -0700 (PDT)
Received: from [127.0.1.1] ([222.71.237.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47769afc1bsm2756777a12.19.2025.08.21.20.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 20:06:49 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 22 Aug 2025 11:06:29 +0800
Subject: [PATCH v5 3/8] dmaengine: mmp_pdma: Add reset controller support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-working_dma_0701_v2-v5-3-f5c0eda734cc@riscstar.com>
References: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
In-Reply-To: <20250822-working_dma_0701_v2-v5-0-f5c0eda734cc@riscstar.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz
Cc: Alex Elder <elder@riscstar.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
 dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, Guodong Xu <guodong@riscstar.com>, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>
X-Mailer: b4 0.14.2

Add support to acquire and deassert an optional hardware reset controller
during mmp_pdma_probe(). It is optional because in Marvell devices
such as "marvell,pdma-1.0" the resets property is not a required
property. But in SpacemiT K1 PDMA, "spacemit,k1-pdma" as the dt
binding schema file stated, resets is required.

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v5: No change.
v4: Updated the commit message, no source code change.
v3: No change.
v2: No change.
---
 drivers/dma/mmp_pdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/mmp_pdma.c b/drivers/dma/mmp_pdma.c
index 4a6dbf55823722d26cc69379d22aaa88fbe19313..fe627efeaff07436647f86ab5ec5333144a3c92d 100644
--- a/drivers/dma/mmp_pdma.c
+++ b/drivers/dma/mmp_pdma.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/mmp_dma.h>
 #include <linux/dmapool.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 #include <linux/of_dma.h>
 #include <linux/of.h>
 
@@ -1021,6 +1022,7 @@ static int mmp_pdma_probe(struct platform_device *op)
 	struct mmp_pdma_device *pdev;
 	struct mmp_dma_platdata *pdata = dev_get_platdata(&op->dev);
 	struct clk *clk;
+	struct reset_control *rst;
 	int i, ret, irq = 0;
 	int dma_channels = 0, irq_num = 0;
 	const enum dma_slave_buswidth widths =
@@ -1043,6 +1045,11 @@ static int mmp_pdma_probe(struct platform_device *op)
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
+	rst = devm_reset_control_get_optional_exclusive_deasserted(pdev->dev,
+								   NULL);
+	if (IS_ERR(rst))
+		return PTR_ERR(rst);
+
 	if (pdev->dev->of_node) {
 		/* Parse new and deprecated dma-channels properties */
 		if (of_property_read_u32(pdev->dev->of_node, "dma-channels",

-- 
2.43.0


