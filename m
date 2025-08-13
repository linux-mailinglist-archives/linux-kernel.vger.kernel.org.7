Return-Path: <linux-kernel+bounces-766260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C651FB24469
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65450169A5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7613723D7D3;
	Wed, 13 Aug 2025 08:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZOCMKZpP"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044A2EF671;
	Wed, 13 Aug 2025 08:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755074024; cv=none; b=pGFJemWB2i7r8GF6nO1r0c1/7Zs/GQl09uSpkK8k7B1E4Jv+DcQTUffqjL2OjS6CzFYcQlgmKtk46GvGwz+olmqStry6GkpXD2lSzkzJOlew1rtGxHZjJiAQpTbDl9JkdqvmdPF1l+Vw8CWd4Gw7J+XRfrS3quFJFJJ8TgebcaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755074024; c=relaxed/simple;
	bh=3Lv5bTYlKhpC0eWwB0IvqfV0hV7JqAASipFjDdwVTeM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZHQ6UGEXfQLFJJ1l7m2Lr0PtHoN68IoQ9t3zygObv/xUbNzltFuUL3oUbEcrAUAz8Lnbd2zbvgGRii1nrR4LCsy1Tnnl5qGeCwK5m04kO2CXMRd2MpLyYWB81ifGoS2aYrdnDWaVC+81dV9RvKfyZOSKRVPmDoB90/Omfpg0NBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZOCMKZpP; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bc5e68e26so5914177b3a.0;
        Wed, 13 Aug 2025 01:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755074022; x=1755678822; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FrVKbMMxUgucaMuE8fujtQNji+Pr9aFYe0T4La7C6k=;
        b=ZOCMKZpPWE443l11m0nNBaN48w5NI6y3nwxzHv7OFhfPN3spA+yziMcjyE+qkDiytl
         f6w9Kmhcxc5usLWAf5tpHihJ/ddJGlDJ2Fc6KVNldhHgcyuc6aIIAwW9ZXjd7Y3Fu4wD
         jkoTLIeGZmAqmtJI6dlKFsO12Ju34+k24kIUUxO4PWhvw/uAv9yFBA30htTb8A6EnCMJ
         kO+jN0AjoZmSXZzSDyyIUqMhcClFsQ1DE0Qr0ieOOQPGhl+k4ilG3w7JdtVrC9t5Rti6
         OmD+Flj90r5+JwNUhbiL1g1eXc1LC43maMbK1eRLl4Eaxt3LQvF0yNI/DZkUQmnnn+sU
         nxvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755074022; x=1755678822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9FrVKbMMxUgucaMuE8fujtQNji+Pr9aFYe0T4La7C6k=;
        b=Hyy4j8wkeu07Bc4p378vrzFv/EaJ8EhzV1xYxb/UJra9djde17/p8ZZrCac7FIww4Z
         +GCItlrahLfkW8M3yg7gJLCpXdSmFNoCeA4tLM2W1djIjbd/etklGXRIRtpqoJ/LQdbU
         WBt8/iS42KC+gVxyQhFur35XvlCovDd2AeM//SrJHXFfJy7I15qB6bfSve2NEYCoHttW
         VjTngmDMsbQ/RhNI4Bg0vX9QQMdmBGD+QrepWv8afcmq34jVFgSLovJMGK9v63wAHM8r
         T5cOCUabnr1QibtVXoDL8Zu2V8vzzkc+EKuOmWfLo0XNVOSB6g5UEhMx0S6GMuRAuLW3
         HjQA==
X-Forwarded-Encrypted: i=1; AJvYcCV9h8szckcPw/0hisyJFm+832vz0Kgs9ixgg+eBs5eXimASx3tafsiRLOSxsrqxRSuRvAPU5fQlU02fQT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiO6rGBUcdxpeX0CgV9p/x+LBsCsAeWv9XH31B5GKHI+yhFTUT
	NO0hUItBG6huFIX8HlBmkTFBrIZPisrDODgfw13wgVbvLeld7rJEr9ty
X-Gm-Gg: ASbGncvuRYoS3vNoFFDPnrl236qb4KrRgs3A1PaCXEuFxohPC7tVeYJBmRSFey7LYjY
	5RujaZiIfZpXwWlbmzq6HyGPi1GTBfon8UPYpujMun4/NeTxVCGLItJ9eNgzP/vNhLwmkyz5+vb
	cb6icDcJ1oBgQJF6KopoT+UdDLMPPDmRgd5GZTzcgLNw8LmbnbGzCBYZ9KnD7UZSvK6gBD0gX4j
	lBtE3Sm4WdDkDebIUlB+mXq1x2p/ujEppAC6cNGYiQyYQj3PWnw9QEHxbOUS77ULdONtRzidPRq
	mLfmKMa0HxMeaPmdZivUdVcA+ZVfX7BVU9g+pn0OLrDS3HE027a9U5AObFFKLkT2KerARKj5auo
	1POYuTqDmrJdvIrk+zX3pGg==
X-Google-Smtp-Source: AGHT+IF+s8cQXKEirEmIJJ5qRb8UyALTc33892JJyQWbd8Eu8uoFYzitLuwaOSKfnI5pphmxlLCAGw==
X-Received: by 2002:a05:6a00:3e2a:b0:742:3fb4:f992 with SMTP id d2e1a72fcca58-76e20d09aa0mr2982062b3a.10.1755074022038;
        Wed, 13 Aug 2025 01:33:42 -0700 (PDT)
Received: from [127.0.0.1] ([36.255.193.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfe50c8sm31307814b3a.120.2025.08.13.01.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 01:33:41 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Wed, 13 Aug 2025 16:33:17 +0800
Subject: [PATCH 1/4] riscv: dts: sophgo: Add SPI NOR node for SG2042
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250813-sfg-spidts-v1-1-99b7e2be89d9@gmail.com>
References: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
In-Reply-To: <20250813-sfg-spidts-v1-0-99b7e2be89d9@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755074006; l=1514;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=3Lv5bTYlKhpC0eWwB0IvqfV0hV7JqAASipFjDdwVTeM=;
 b=BJ8pWBbvIH0FzbHcdXVpTFAH5lT0rZrjui0Ve61V+wuFm642CvwU6DaqC/dcoIV8XCjY7DG54
 qI4V3t1jAbxAPR4ndQ0bSfWHDppgyK0MUgXDmPse4XVc4ZfdG6PbS68
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Add SPI NOR controller node for SG2042

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index b3e4d3c18fdcf94c2294a56ed6ad866fc59a6adb..0f7d8a3743c35046ceec902902af2b8d3ec8e6bd 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -48,6 +48,30 @@ soc: soc {
 		interrupt-parent = <&intc>;
 		ranges;
 
+		spifmc0: spi@7000180000 {
+			compatible = "sophgo,sg2042-spifmc-nor";
+			reg = <0x70 0x00180000 0x0 0x1000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clkgen GATE_CLK_AHB_SF>;
+			interrupt-parent = <&intc>;
+			interrupts = <108 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstgen RST_SF0>;
+			status = "disabled";
+		};
+
+		spifmc1: spi@7002180000 {
+			compatible = "sophgo,sg2042-spifmc-nor";
+			reg = <0x70 0x02180000 0x0 0x1000000>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clkgen GATE_CLK_AHB_SF>;
+			interrupt-parent = <&intc>;
+			interrupts = <109 IRQ_TYPE_LEVEL_HIGH>;
+			resets = <&rstgen RST_SF1>;
+			status = "disabled";
+		};
+
 		i2c0: i2c@7030005000 {
 			compatible = "snps,designware-i2c";
 			reg = <0x70 0x30005000 0x0 0x1000>;

-- 
2.50.1


