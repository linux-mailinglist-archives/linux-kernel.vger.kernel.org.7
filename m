Return-Path: <linux-kernel+bounces-813076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DB0B54079
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:37:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 448C53BA12A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657C41FBCA7;
	Fri, 12 Sep 2025 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3IKT1ye"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FD81D54E3
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644644; cv=none; b=i1ZAiEZ9QAe+tQACXTxKWcYkSeISGZ6NVsKjCXJcAdKkTBEQUZV2xttbaXybV/G9KQAp5tPNo9i3Ing3dEUJ3y6jKaL5clqKBKAJ3WiHm3Fh/MaCsbvwRqlE8lsTdFMswBhYpONxKEn9jRur/J3V5xgNcsACGAgrLggyEweAZ2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644644; c=relaxed/simple;
	bh=dgpNPFFxsdIAjczNzjU4PLG/4kOomJBC5GhTApKNwOw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HexigT/47tNaOR0W5Z9kKUbWbBB5Y6FcRHSvfdU4cjGTCNw9cVaXZXQoa//jHu2P7lboXlXTwYAthdG2DWoFYk/s7crR47C6Di41bxJxsDk40fx2S4WIMP3uqrqdiwxC/9x/cGDLSNyDUF4p/WympsILqtCWrID6GZHw4IcVgnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3IKT1ye; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-31d6e39817fso1893451fac.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644642; x=1758249442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=T3IKT1yeV7eN6n5TExZxfQfQakjM1wZeabZoi1rq+7P1jsBXhZo2TbPOTbZjXxyXmG
         Xxra69XqJvW7IgnWCWJd2GEYFvM5HkxOacE+8oPcbReRI/0kR2ljyWt81s7TXZOb4X1P
         MIvBvJOQSHV+338IdxjYh3Lr7FMHGZkpKGEzwbpVI4LjdbBVOtvqPiZIvf7VqfBt2OxF
         VVdA/BdsHkfjD/+tKsRPSNGnhRXETfJqKHGplxxEnkHufwFc9Gc0ZLQ5xl/dF24lM0RB
         M14dYanxriEiQDg+e1AP9IqH4wNtzDaVLweBnK8ozXOd700MoDXnhGmsiL2uIbJ9Cgud
         yrEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644642; x=1758249442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=trzNaL3uwi13ibNPecun3N66dfGmyXSArw7bys+WFBp6Pm+m1zGjBq80dxHM3u9Tx/
         8rY8FRr+1jIA/0Um7qmseZi/DqnuHn8zAu9S0sLsJI8J8itwQstfHuVE1GO1pQIFUHMV
         sHpQzW+T1oXZvCtcoDYIzsQcEiMreYcm10GNFMrS6OJLlPyRwFTg7BI5IwTln+BbhNRu
         Ph5TWIgoU8jLQmDxFLG8UYda1xmUqCPzB/E17QlNb2Pj1VvX4TQDVX0fUBlDZKVhn3Cr
         iHd/4BTlxd8SFVUJ0nzS+fA4BWD07XOB4/FO0tRqTOn0DB9LPurhDRsZSbRnARLIJ/Qy
         7NAw==
X-Forwarded-Encrypted: i=1; AJvYcCW3Duhhx7Fvuu2tbcf11Is2sLmaFDQqYd0FYrzcjZ4FG60shhQV/iiKBKOr3X0IrvJnvc126m0eTMTjJO4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNJDwhTdjjdA78xNJbtOAi+Wzrlf6mlOSCom/0zxZnXHS+ubKD
	4o+tyJEbho7/AROPKWBr6Qs+JXUN6AeSvVEdNbC7o6++0dmtNdOlsBo8
X-Gm-Gg: ASbGncsC54Zr01ypm2ZXOSxWGyrl0gXWQxQTW2mNXfmx60K+O9qbDY6yCoNB6ohHZNj
	IChBxYC4+Wt9kUdEWKpXmdZYJ7mqe4PUihUit4cUr/Lhn5CUkSG5eusXiVjK9k50rFNdcQ9SFcO
	1LCuNgc6ozefjAtjIdOaVey/VHDRe1WRAHdud2GSRwEwBhNiPDF41gC0J1c5U2XkKmsaUnW3mN+
	l8mzkt4Fxi1y2CbiwpipgQ3waI+MOBiS7D0qlHqndtBBqddmAJy07Sgp2pCCn6wm4782a8Xz3Yd
	M6Vhicw29ny+n4NRvYjqJRvJCPI9F4GdQ48BRxuC7pbNh/KUiR+yDL3LN/C1Q5LL8PqDxWape+4
	syfUKuWVZgX0qKXUtQYK7EOhYuxuH54zbuseLoZu/KDM=
X-Google-Smtp-Source: AGHT+IFJlDg83j9kDJr9JJPfps+eRdqlRn3OyrAApBvHJZ97334vhQbAuQiDLCanW42L2b91pkrT9A==
X-Received: by 2002:a05:6808:6552:20b0:43b:6639:7307 with SMTP id 5614622812f47-43b8da12395mr687917b6e.23.1757644642421;
        Thu, 11 Sep 2025 19:37:22 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b828d2ee3sm565466b6e.5.2025.09.11.19.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:37:21 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: kwilczynski@kernel.org,
	u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	arnd@arndb.de,
	bwawrzyn@cisco.com,
	bhelgaas@google.com,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	18255117159@163.com,
	inochiama@gmail.com,
	kishon@kernel.org,
	krzk+dt@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	s-vadapalli@ti.com,
	tglx@linutronix.de,
	thomas.richard@bootlin.com,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	rabenda.cn@gmail.com,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com,
	jeffbai@aosc.io
Subject: [PATCH v3 5/7] riscv: sophgo: dts: enable PCIe for PioneerBox
Date: Fri, 12 Sep 2025 10:37:13 +0800
Message-Id: <a499a1c17f317ea57de8769032ec65e1e18b4b36.1757643388.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1757643388.git.unicorn_wang@outlook.com>
References: <cover.1757643388.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Enable PCIe controllers for PioneerBox, which uses SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ef3a602172b1..c4d5f8d7d4ad 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -128,6 +128,18 @@ uart0-rx-pins {
 	};
 };
 
+&pcie_rc0 {
+	status = "okay";
+};
+
+&pcie_rc2 {
+	status = "okay";
+};
+
+&pcie_rc3 {
+	status = "okay";
+};
+
 &sd {
 	pinctrl-0 = <&sd_cfg>;
 	pinctrl-names = "default";
-- 
2.34.1


