Return-Path: <linux-kernel+bounces-770193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5439FB27847
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56E1588A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAE129B796;
	Fri, 15 Aug 2025 05:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="i2VTaa0H"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAF1299AAE
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235106; cv=none; b=gXaUU+3wN04cVq4Sg9TlRkpERHRLV5dRtGEcRni7CGPL28ofsO0ct/EzHzWnhtav3lSppi4jO/+Ogn2ybFMC+5/+3zGfaiSjaQYRvUj1evEnVvq8sCH8OwkBG2G4lMeu2FXHiXq1EiqrkS/gc3VyUQNZ13eZSahA0UrHX5KAeXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235106; c=relaxed/simple;
	bh=wAbS4Hm5Ej3gB5y17PgS7507wIkyUc+hhTmlBTFT2ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c2Z6hYA76pbMq9bi+TToK4a8EPqIU2Cn8sTGrmZ60w8pKlwZOlHQw8nE5rUIKOiFaKcvW4+I+dnEd27vsN3DfzGCcHWRVVzpBqFKmEVhAgMN0QoSjfRYQaSCuMOXrJMz5zGP7KYqDdmuunCmxfOAC1AXX0MyNwztSuANNTl3kb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=i2VTaa0H; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-321cfa7ad29so2087974a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755235102; x=1755839902; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+tu3VbVvBVdJX8NKXRo9aN8ru1kGERA/t9NfAcjD1b4=;
        b=i2VTaa0HOYYEFjOlc1pUbrQ4CacopiQIdqOko7GMSfF2UFgNyeKoRq5BwxJD0J+w+j
         Sl8ybWB6K6BEznR3cLTCilgi2wlwfQYXz18pH/0ltEQ24fbOv4xIlrDzpWkLO2DvhwNu
         w6UXfnYUVyeI6F2Btg7Clt79vLmOjaqrfFfIGnv5fvKH2g7K2xgd4UnjUEuRozIn+A04
         SPxDQA7XJuqrQSWks40O0j/EtSvItnMfW3W05x4B2IhIfJHgCCS3dtZAyVEOKgT7hWeM
         eZ2I3xsr/3WA6d7a81Ce1E+jOhgBcQCN13RzuTyRlkCB5oDoVYH1p0mtc40d7muOyEq3
         2KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235102; x=1755839902;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tu3VbVvBVdJX8NKXRo9aN8ru1kGERA/t9NfAcjD1b4=;
        b=Yu0+836oJ6x2kIgLBEGjx7kbdYnWbFyh2Iou69IluvQAv4Ob9M+LFysedf7SPV5+SZ
         c/P94plzXwGIU3XZO4rh3R8N+krC39Vhk5RCrGcHrySHbHJlTRelI+10PZrMatNaJ4Tr
         d/hTjs052k25SkDDwFPQi4AiKKCHX6jbk14bhhHCuVAEi//dsI6V8G4R0VroAMh9BJ2M
         ylhO2/ilcM3GZEliYs4RkAdzkDhVF5+eyc6RbQSBBAuNAd5R8cjV6NBAC3itWXOSQbY0
         njjN/+sZjy/ZMGCzdFNiZOk8On5i65gq7yBvW2+NofBFWySpYfwe3EbhYdIXyN0Yo1m4
         XD3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUgchorSQddlidCoV44y7QfVWA1c8w1y+0RJJjUAGdiLcZqIp3ghX2Fwp8TlkVpGc1iVJnrBG87q0BfSPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHyRb+fwJvJrDbtmZJ10yPO0p86tWxEvf5b7lPs6yL/6I74Y4T
	ne7LsNaYPhYNiifJcUfO7n6H1FmtTuyfG5ec71j7FIBDOEoIaurtD0QHtpR5X53HkbU=
X-Gm-Gg: ASbGncvKvAUAUxe9Yl7QPwzOyj3Geblc8Hqqcbchkf4caMxa/jY6E4P3y/UJmZGiEU7
	8Eq8BPZKTMTlXXyPT4QZoSE0exM8BPCjZLb+JZDIOKgZTQnIWudWbsIaSf6GYhf/75viDcPotnU
	IDZp+rdLs+1jLcebgu3uYsquFu9s7oZtsGXIsoqZRpwMpP8zmUikigOyeX+mFxD/9suirP3QS95
	hr6n2hM25JUxZw28exfOFkxhqEcHg0k25D6Ap9YgLaAGAdOXjLeERK8zL7vaR4kxF0ew7mzT6AP
	EYFV6MQjzGbrZGkN/qKDJVFOBFNRfMZRLc63pK16nsQTp6OrVpuDdZ89opQcM3zAS36DexKWo+O
	Z/mkJpq5qF6LOyyP6N3s6JA==
X-Google-Smtp-Source: AGHT+IFDtHgfFvQxxm6fxEwWXi9awBBZD5Ua19+tFUlmmEm3vFbmRHegYSTVwFsXKmUcUeczaz7/jA==
X-Received: by 2002:a17:90a:c10e:b0:321:2b89:958b with SMTP id 98e67ed59e1d1-3233f0c1a4bmr1740600a91.0.1755235102576;
        Thu, 14 Aug 2025 22:18:22 -0700 (PDT)
Received: from [127.0.1.1] ([103.88.46.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-323439978a4sm373212a91.10.2025.08.14.22.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 22:18:22 -0700 (PDT)
From: Guodong Xu <guodong@riscstar.com>
Date: Fri, 15 Aug 2025 13:16:29 +0800
Subject: [PATCH v4 7/8] riscv: dts: spacemit: Enable PDMA on Banana Pi F3
 and Milkv Jupiter
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-working_dma_0701_v2-v4-7-62145ab6ea30@riscstar.com>
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

Enable the PDMA on the SpacemiT K1-based Banana Pi F3 and Milkv Jupiter
boards by setting its status to "okay".

Signed-off-by: Guodong Xu <guodong@riscstar.com>
---
v4: rename the node from pdma0 to pdma
v3: adjust pdma0 position, ordering by name alphabetic
v2: added pdma0 enablement on Milkv Jupiter
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts   | 4 ++++
 arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index fe22c747c5012fe56d42ac8a7efdbbdb694f31b6..6013be25854283a95e630098c1fde55e33e08018 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -40,6 +40,10 @@ &emmc {
 	status = "okay";
 };
 
+&pdma {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;
diff --git a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
index 4483192141049caa201c093fb206b6134a064f42..c615fcadbd333adc749b758f7f814126783f87fb 100644
--- a/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-milkv-jupiter.dts
@@ -20,6 +20,10 @@ chosen {
 	};
 };
 
+&pdma {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_2_cfg>;

-- 
2.43.0


