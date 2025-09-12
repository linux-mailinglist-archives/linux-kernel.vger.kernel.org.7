Return-Path: <linux-kernel+bounces-813079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42935B54081
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30D01C88223
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2672219E8C;
	Fri, 12 Sep 2025 02:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5LXNfWN"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF92153E7
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644686; cv=none; b=ZIssrH8oGltJJ3Epk7HWU95ZdFYk7Mo/Se4encktbFsfdM5+l4CXOBOBP9+ILoaH+tp2qKFhb5SbSlk/eoUPdwv9p82NMTjWMZtW6A1fnqVb4Uhga2kUYSBvBMZ1eHkTXgp1BTsF7e2cR0kDif9YcuayYBmq5Bh98ezzH5XPZMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644686; c=relaxed/simple;
	bh=+sDUkA3o71u4xm0yCZaBibtMSUQ/NK+r5JUrUR+q7Ew=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cxXPy3A53cLnyuyUZHZbbD1MX3zQnbCFC5emkZHkP7uoaor1EqnzCQ+ehkh8WMvSKQ9DbItoaofSPS+HMTU4xfwFo7L6R2EJl0CaYlSY/qTJg8x0A11tDO7tv8fnv/0/QlOXh6UptNbPB8HaTg7yMUWIsPoLhcLoMsKEgTNfmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5LXNfWN; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-74382048b8cso1184186a34.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644683; x=1758249483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/8dXK+URwMz/QYwLwmlxkiqTgmS0zDdGrSZfnYxwO4o=;
        b=N5LXNfWNVvZQsNNIZwv7wSw/tSOTGsuSWYr6//MoBK0UrPmK5cyI2ncLXows/NRYOI
         L44DU0osBtpE4btUSAi5siolPhO9nu5JM/a/qRi0F1jn37nsbBFppROjNQVi9ymr8HRG
         0KPFgsS3n+mko9t0sQCbuRAXPvljBJg2zzFAiK6zhbqq7ORYs8gvSu/IXP+WrIbNJ2xR
         7JUNp5GLGkC1ddEkpywEDSW9jjA/xVWYkkkE6iajDf1SqLeYFW+RaD5sEMHyUY6cxHKC
         /Vt8gRHYcptjezIsZFkTtWQxDLlgfiXw4mZqK0jOyRqqbRdQRaVr7hYFeM53ByontYx+
         xa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644683; x=1758249483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8dXK+URwMz/QYwLwmlxkiqTgmS0zDdGrSZfnYxwO4o=;
        b=dwL7WD+adUu8XOhLBpIvzTvk/b7Ifr/I2XhoxoHfYvI4QEXCSxgx5n4XhPjn1h0mxW
         XfI5EvdKaCoMRPzuCBnKJeJguYKP3EJApweIFLvrjBdIofGTxtHCV0wHyPLQqTTIOQdN
         c6CqtgLpkQTpJo0y/pJny9fXx6/78+oTf0LNnYPLOr8D4gJcLCouZKrmAYQn0c9UKxDi
         yvigUObBOnAaBw/xyQX80KWmoEDjUGdaB0wu6eczJQiBvA4GE/aVeoZBhgQH/yjclDsx
         EhfZCKNgU7KzKEIL7M1aayYmSDdI+8lokIyjitPlQQDxgwzwwdkwNz1VHpCpYqTpTHdn
         xTkg==
X-Forwarded-Encrypted: i=1; AJvYcCWuoXx07TFE2duBESL0inES4DVdUhP+49fbBFFoe1oGIR6W7uvLKkBNrzvxkwr79bjy+T0oNLB0VXa0Vew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcuryBXpR9xhtlSU7OOdIthdtMfuptsmwh8t+VpIdyYUVGxjwm
	9+fGF9+b+xsI6cg685HZHUdw5P4yRDAuIBXJBVdrGTP2mG+Uj+xTyx3h
X-Gm-Gg: ASbGncuoRhfl/ovSrP4kY9e8XvUp41OnJS4MFpIXMqPb3FIDOM6aTwvrouiHvXcfMw0
	zpGYJSQfUNa+wAqCAHqHZpj7nrTpJaN6KCL11pet9vEaLswC+DOCQpryrNw69Lyatb7LYcu85H7
	EPNDIjdtn9/8FVZGnb7PoPBEFa02fxbx+Q/FxXAFINtBUuj+ZCYGt1T+A4GTtprN38BpSj5wlBo
	BR5NnUXokkT2CiNm02sxrO1B1zxyAsfZRFJfjq5jvMx6Cg3fO70KK+VyUQLPRUndyhpQffuEI0V
	tqbCIe78MPo3pLVT7QtPnOKYAJ6eZX1T/pz/cR8Q2pKihyI5U34tyRFVoM5l5RqY0/FcANTnWxX
	03V7P7oCsabBEE5UVvy4lKd6RNwVEoKKn
X-Google-Smtp-Source: AGHT+IETqLmXYZmyiMH+mKY1KPo6Sff/q9RyP4s68oN/ZgPUPkjihsjoo2nIbRNYpa7WwZvbeHu73A==
X-Received: by 2002:a05:6808:470a:b0:439:b198:23c7 with SMTP id 5614622812f47-43b8da0c548mr626312b6e.31.1757644683591;
        Thu, 11 Sep 2025 19:38:03 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8293163csm565701b6e.12.2025.09.11.19.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:38:02 -0700 (PDT)
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
Subject: [PATCH v3 7/7] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V2.0
Date: Fri, 12 Sep 2025 10:37:54 +0800
Message-Id: <16831a3277a6c8c19436a17ac199d2f9b80f9ce5.1757643388.git.unicorn_wang@outlook.com>
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

Enable PCIe controllers for Sophgo SG2042_EVB_V2.0 board,
which uses SG2042 SoC.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
index 46980e41b886..0cd0dc0f537c 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
@@ -152,6 +152,18 @@ phy0: phy@0 {
 	};
 };
 
+&pcie_rc0 {
+	status = "okay";
+};
+
+&pcie_rc1 {
+	status = "okay";
+};
+
+&pcie_rc2 {
+	status = "okay";
+};
+
 &pinctrl {
 	emmc_cfg: sdhci-emmc-cfg {
 		sdhci-emmc-wp-pins {
-- 
2.34.1


