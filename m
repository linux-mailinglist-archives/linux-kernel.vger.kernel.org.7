Return-Path: <linux-kernel+bounces-770189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42480B2784C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21DC2AA68DC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC0F29A32D;
	Fri, 15 Aug 2025 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="b6Rc4ltB"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E041DE3B5
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235076; cv=none; b=J/HSUmC33/WPEMDQtEKq6f5a70EoM3ZnmK0uUA+nb9VMBjvOxjRkgy0WFiXsYimVF7Nq6nOhDQ3PwLoueBl70BKlwqKmS2WIZy5BAB/DyaIffPYN3aRghjnDwNFVE5Gt4l1Ayh/oLIJ7gerW2WNpwAG8IwpAIQRnVfsNfIj7PXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235076; c=relaxed/simple;
	bh=hpNlMeUziKF1YQw/oeCyeHBB4A2F1o7M2fzwISWlPn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GGUinLkDDtxELVKuC1pLMDdJOxZqrcd8P8T3eB/uaKN0PUtPqTycS1vZWcd2MirIVOp2c5kU6FNevvmcl8DgCqJJ1FMzel3bR/DrhFQWq527SVX4mW8J8PId3RZ3t846N/85SNlhxyADGoa0/Y6ZnYYvLVrpcdcnNb+65jW5A74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=b6Rc4ltB; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-323266d74b0so1472515a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235074; x=1755839874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sAR7LvrtEvYXVvXsm/WrP4bERAT0LEz+OoLyN7irYo0=;
        b=b6Rc4ltB2zBivf99cDPkejo1uyhqgvGUbjfgH6mD3Lm8Ojedn9i99POeys1T170Asl
         sXs7KC3khuKgQtePM7J8MioVmiwzz9B74ugTlK+9tk1miZtpni2CgaoB77TEyin0iOh+
         6qzNt0tMJo545eXWFkKsrY+O74h+V6nkSiQVVJQtZxRLNqHw18atAFa+M8GSTg8N1Kw0
         dD8Z8iAvN9h+GX3cSF28XYOHzePQg8NwRZDP2cI+OhofhdIDZrcrtXRR2ftyqJpVqCUl
         N9aVEQGGEKdNgjR+a3b1x/uv5vvyaN0j0j15fv3g+J7aphdoBu8BUQW0LxV3AkluAlYf
         WVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235074; x=1755839874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAR7LvrtEvYXVvXsm/WrP4bERAT0LEz+OoLyN7irYo0=;
        b=oUTavetk/tVqKbdvb+Lis/z1eie2CRlTo4VZq8a6cuGaUjkZ2GOLyM7HN3owCQLT5J
         S4N4CuOo8J1dNaKM0utUPGrTU8rrvm9ewkVSH9/W/EL3rEuctGsaaPthe0tRzGuZAsIH
         LX4TPF4mQxtbz3DX6NLCKGJbIA9eIdZtp3Kn+LhDkXu9ySfho7nSbWX0sVetB0+LiI6A
         VS3Wk/Dh/mxOy4MPXGrgk9EBNRDCFwkcPX6571Q1nPFZ/OfiQ+YAWV2bbUBeYt1sL8Jf
         5kynbNbLdphE6tNpMvQrLtBgvrz2kl390o1sZ42TkyIHvTe/zziicNSEGuvd+VpTJMAS
         qd6w==
X-Forwarded-Encrypted: i=1; AJvYcCWIIZbgN+nPCOHMmzlOZgLWAgznI4zhkPp4jJo6d/6RlS4oJSPrf/ucNReXhrj+4oXpDTY/zr2tA+IoaNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+eRTBcXTwJSAxqorHrlwgt4zPJOXMaPL2GSoCMBMx7aT27M2w
	QXb+cO4OwoXkR1QC7fhSXCNRg2ctxjI7MSBQs4rZvsCzZNH0ha7bhnARxeUwHVJ0nBw=
X-Gm-Gg: ASbGncsJXNSL3SMvpJJZbAjHM/9WbvpccHKnD43vY+4AvIfyDlNpnDLEG2wdV9ijVw0
	oKqN2yCPr5H4ZGHnaf6VeJK96v5srAMYKi2GLvGIjtuV2r4A42A0rVfZlV+zOdKFLqz3kV/I80b
	GnvrEBUMVCqJQ1aWxDFlLbCqOy5/G1XqCjmdgDuFy8EjvyGTk73C9S8XVo7bhzlDiZe8wiEt1dq
	92ZSle2IZpuUCKOgwGIdhacoAw6of3oyj9D4dscgioM+ZeHsCiCv11o8kgMU0m6lqlSICBsTKQp
	6SWpdRniyRAS18ewicF1kbocd3sNBZ2vlb3Rb7tS6Dja8+/NsiSaB6iZ6S+1AEGwP+996hkZYR2
	uIpAabuclaKcFXNm92lncRQ==
X-Google-Smtp-Source: AGHT+IGPjF60DU2opRQQ2ZRiuLuntu3rKr9lba7AQVneRYMhgy2+Kz3SAcjcb/1v+om4sP4fBS+qiw==
X-Received: by 2002:a17:90b:1b41:b0:321:1df6:97d3 with SMTP id 98e67ed59e1d1-32341ea79f5mr1298891a91.4.1755235074382;
        Thu, 14 Aug 2025 22:17:54 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:17:54 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:25 +0800
Subject: [PATCH v4 3/8] dmaengine: mmp_pdma: Add reset controller support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-3-62145ab6ea30@riscstar.com>
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
In-Reply-To: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
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


