Return-Path: <linux-kernel+bounces-818870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB33B59775
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C4B3179AA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A34315D56;
	Tue, 16 Sep 2025 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ORt/5on5"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265F9311C1B
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028983; cv=none; b=t0Xm29KQx1UhxMAIqXSAw9yEkcrlM8PZMoC2atmY6VVzSMrY1EdkiONyJNcIP9DzZOEfydQR4D0uD8b2lVtm4JRg4sthTrpks0HU/8TEJLyE3VwbyBP88KuQOzHDJYAxRKp01B+uK8c1O99zQfdu3sl9fKtmmP6eB0V47godI6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028983; c=relaxed/simple;
	bh=QybYOscoNwdDfY/Wes+QSL8OfKyE3/6HFcIoUfyJOiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b0iSjmRFAPnjOu6FxLNGCnAt6ABb130+Vlr9/UCuifhYOVROYv7YbIC1dFU7m6e4rvp0t8kZlMm4WgPe4l04uf/PiaMFMN/N7zop9KIUnvEAwulqeW105N5fv/r/Hi87HHK/iGZ7jSIzoummAZuQQN9eIolq+AEr0FJuCBklSA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ORt/5on5; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-772301f8ae2so5059840b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758028981; x=1758633781; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaxG+kWIaesk2NKerDmk7jBSPRl4JInhM+mFO2hD1V8=;
        b=ORt/5on55AKxr3OY6sbRtLYnbKQ+CAqJG86CdQ3mnzd0YjPMW1uSlxV7aNJ0LUvaAp
         glaZSiaFAgYPl79dlMPsbYsG5og39Bid0Q2KTOkw4oO4cysp2x1c8MbQxeZcLc9gVO3h
         mL2Jt4xydDdR/del0gPXkt0O1BQ/loOV9wuThuavwVrYw5rCXSRQjNCxUc1wMzLqL+/b
         NYqaeEo8WOaSnM48oKGnn5AIZrU57f0h3OhoKbfQrdDvH9st2szDakJRZQQ4/oA+pVX7
         xFLbCgNx1sy+JEN2E3Xo5A+mOuV1dEpo58fT3zlx6ZyI1hJMF/Vybx2TaXOimwqGxkRT
         YZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028981; x=1758633781;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iaxG+kWIaesk2NKerDmk7jBSPRl4JInhM+mFO2hD1V8=;
        b=bqBYbBQIszyHAFuFo1riYHJrIUCX3UNQkgISBXao1JgJcs3MZIfcfgmXUJsOfjYE/c
         zeM/k3b1H8CfzZSQj0Trm5ZDtafbAlMfjfqIxX7ZvdLGDuW0XwoLn7EeNmbuOh/F5yt1
         n+uXpi4VRNXO+LioDbSSv9wk1t3edIEa0FmzZ2GMi48LcoOhm9yuyAGArMA0ei5mD1wR
         MCLkUNlS4XYR7H2rD9E2tKZJhUDjFiVNUXpjwVbSTOh0pl/VIToccVW4Y+2MnLCm0dWB
         JmAza3K4C6UzYoe76o1J1cDWUhrf0Ef9z2/IBunOIu7mQopYqhHDVg6fvAO3Nn/iGZw/
         OlDw==
X-Forwarded-Encrypted: i=1; AJvYcCWr1Ftp2mcevAZ6KQSGBG7qk15ncwrSEGF70hADpzh8FJ+M2tpMkFsrZ6LvZILZyoCiz3wRS4kGovWlsL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkQXn6dO3HjQ/VW8t8lO3qhmeyInvWZmmiWKQQxdt0mGLBmYIo
	ly30x6M7oaqUsK9n40ljdA1jkaFYw5fJS8tBT6mPPxrwRmIFwTq/E/3M
X-Gm-Gg: ASbGncs6dFOrjsk3I/aIXj16+JWIEWQsKjddJ5tZSp27TLDaZE5jNTOsgo0b7OcR1MZ
	ZkGwxGgnWrEzkKHptGZdg11QromjIAiB/nmQjQJgnere+xFaAjdWCH1JKGoJlGzUWUwUXnkZvip
	rbxPTY3Xr4aONyPwPNSWl6lZGN7YqGavhoxHNLWIWOpXqaomMRwXQfYPn/yFcNpZaGNbPGjansq
	p2xrg7M2mMwb9Jz5SFMK2Fmrw8oU0kzqijMcMLBlJTasK5/9Z94J0r/vasUaIBF6SKkIgRlL6kG
	NpUUzl3te/R3Neb/2wLt2EDWZseKKbUFa9Z4UUWAil6qMuN9sE90xgaCD7oslFAXVBsZA7WA6UK
	HcWgYQVEm7Dc07Hul5f92GBd52jx3Gw==
X-Google-Smtp-Source: AGHT+IEw/bghXBwSKJHoeHGCMNhxKW0ZFmnDf4/5yHXHLv5gzxmu71658fIQ+i33vla5FL014yEGZw==
X-Received: by 2002:a05:6a20:1590:b0:24d:38c:26bd with SMTP id adf61e73a8af0-2602c90c629mr22551051637.43.1758028981023;
        Tue, 16 Sep 2025 06:23:01 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761562f25dsm13277310b3a.74.2025.09.16.06.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:23:00 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 16 Sep 2025 21:22:50 +0800
Subject: [PATCH v2 1/4] riscv: dts: sophgo: Add SPI NOR node for SG2042
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-sfg-spidts-v2-1-b5d9024fe1c8@gmail.com>
References: <20250916-sfg-spidts-v2-0-b5d9024fe1c8@gmail.com>
In-Reply-To: <20250916-sfg-spidts-v2-0-b5d9024fe1c8@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, 
 Inochi Amaoto <inochiama@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org, sophgo@lists.linux.dev, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Han Gao <rabenda.cn@gmail.com>, Longbin Li <looong.bin@gmail.com>, 
 Zixian Zeng <sycamoremoon376@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758028972; l=1514;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=QybYOscoNwdDfY/Wes+QSL8OfKyE3/6HFcIoUfyJOiw=;
 b=IXC84u2TUyu2cXBaPXrIM5z07LJd32cnc4k6CDpgCHZCt5iMtHWKaI6Mk+GPruvXAfXbcJFiF
 midMpPuhWb2BBpYExx3tRvDl6IK8XaxHc0wkxLIk0qHUoA33y9iMqtw
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
2.51.0


