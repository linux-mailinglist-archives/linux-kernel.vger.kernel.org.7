Return-Path: <linux-kernel+bounces-818871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57D7B59777
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78150173993
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC523191B3;
	Tue, 16 Sep 2025 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrZzFxZ1"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7393C3191AF
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028987; cv=none; b=Sb1BMz95phtVuzbbtZOIZGk3qsufRrTGiATt4S66vA3iE94e3HulXso5/VBZeoSUKjnmSISoQPjYPoTCTgpeN3svBmMXldVzjkJ6NbosqljiKXen77FttW5ljIw6cTry3XaAEFPwbosS1awmOGSoHp4rYsOef9hsdgYYhAjteZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028987; c=relaxed/simple;
	bh=LW8gKY2G7VDUyUL5o7Bf03DIXlO30RMJvYfW4F5X8pE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MOvaP7SwrMRnsju8bUcMG4jkY7+k+kRh9OgHxD4AgrlBTicHj7k+g/zN4r/RKRk0wcYNMPCbub20bS5zeEidbzuvUS6ij+pw2MNCvPhGs8ShKJsQ8jPsU4OgZluYNXmod+xXYgl7JVSz+cuU7XKgljOyl0umv8tsndhbIS2Dd4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VrZzFxZ1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7726c7ff7e5so4310981b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758028986; x=1758633786; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kyl0BpQ16/PyZbIlinkdVOcrBnbxP1cm62TtUJjokW4=;
        b=VrZzFxZ1M5ZOOQ7MA+IxTHBg37yz0sAPOBQLvw6KDynYEmx7mwusQnxPCWKN/Ff1ZB
         +d7nZK0aaANJdfJptQ3GAjCv/AaR8UaJFCXxkjiDgkidn/NGab2sBp1P+QCLzKaHra92
         CktwmUd0+KhhRmQCxSrs2OsJtBE4Jy6XEUqAc5TrXf+4K8GjUC+6wxoEakKCF8a6X8/5
         tZl0irHxgAvQuJaq88tKteKCyZ8GNqlss1pXD75Jf/VqOZV0ZQvXDAkvzn9DbkXVx6sP
         iyZr8b93sL6aDWr10C00bsXNgBnsJY9xsYh7bJe/UtIcptgxX94AoF5BwP7wnqsRwwzm
         jT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028986; x=1758633786;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kyl0BpQ16/PyZbIlinkdVOcrBnbxP1cm62TtUJjokW4=;
        b=Zr2LyehcEdZgnfDo5s0j8BUlgs2DiD2ddP+fI/ooCr2APxPzWYFWs1HI2xDWNU3pBy
         SifrS582MnL+HrQ+CwNqrczHxLr+J2QrdorVNjlIVfNdlG1eNru/1m6jbhJ51UOSiONk
         xrUKGoY+hju21oyNkC1qYXTmKJP5h15pWINr06kIXx3p/PA5N/Dey63bG0sccfMSIfg5
         aORReZib3Ln2guzgRL0IVOWgKq0LdOu/JoC2D2gfcML5WQ22HRgCsKhwQkoUZEWCGkLu
         l5NFOkQjhVA/bNg1DC4vbtILpiXeYSxJuZUvtWapX1IKBAG0vCZV8CWmIHDksvIup7tN
         omUg==
X-Forwarded-Encrypted: i=1; AJvYcCVa3Le8D9+qNDtL9z7fmSMbA80/z39Oz+O2dmaDzjO/VIxal+9q+30g13RYry484muXC/AVh8QBlDiW7Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZLkhANHQKFOhpp+cqwMU+X9Ec0qANh/R25oD2ymLGB4H3BVC1
	UDB6k2cO8q6+fN7+G/vlNFUEXjqF4SSaDLv74E+0sQ2PSSuL24Ovr1Fj
X-Gm-Gg: ASbGnctABvsk7topbh3w+1SZUFL/B6Au76T9boRgW6Y9+j0IXr1kz20sZ4qyE+2dAsv
	Lu0HNmQrh2X5qbnCLunznEf7LrgCpC1qE1zhuO97CkTbOloFiEviuiUOVjtJszguE9MfZPu3p42
	55/3JxTY4XhNSzCBspoNQ3E2NthpnGT5++whwgpfFwO+qVkB3a+FGZNzWxr/S0EV2OuR8p/D6dC
	OP5VXRCVEMZ+/xIUCFBh8naZ1RXtrU3z9qQVHhi7mPFei6frlPnTut0XmHP0g5B4i+ZuQTvfXfW
	DU7vm08O/9ZeXbb7Lh/S7KQuNsPAi3kTbYJZUuo/rAHAlKcxdwllD6SNDb4gM7g29Cn7VlAZfR3
	jPKJOpOJD4aWdpeKxBKvxdZvNSMzzTA==
X-Google-Smtp-Source: AGHT+IGSbUcFgUuRvZhaEbQGDXU6wqj1uhsdBmleOb5RXYY5OoqndPwdDpqY08h9eGK8Pj5YxrReZA==
X-Received: by 2002:a05:6a20:1594:b0:243:78a:8291 with SMTP id adf61e73a8af0-2602cf10c79mr22060394637.56.1758028985340;
        Tue, 16 Sep 2025 06:23:05 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761562f25dsm13277310b3a.74.2025.09.16.06.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:23:04 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 16 Sep 2025 21:22:51 +0800
Subject: [PATCH v2 2/4] riscv: dts: sophgo: Enable SPI NOR node for
 PioneerBox
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-sfg-spidts-v2-2-b5d9024fe1c8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758028972; l=1355;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=LW8gKY2G7VDUyUL5o7Bf03DIXlO30RMJvYfW4F5X8pE=;
 b=LmgXboPjMuiz3VPvrfkLEdDdVW0rUIoVOP3joiPKFCvu9SUeNA/yoJgD6nm7b0aJ96eV9Rtb0
 +QkVfFRRv0kCq67IYvjTluKfTWicee+PH4Ibp9rjh8E8H/WzMTholA4
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Enable SPI NOR node for PioneerBox device tree

According to PioneerBox schematic, SPI-NOR Flash cannot support QSPI
due to hardware design. Thus spi-(tx|rx)-bus-width must be set to 1.

Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Tested-by: Chen Wang <unicorn_wang@outlook.com>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 .../riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ef3a602172b1e5bf3dcf54a8cacdad5172b7f50e..93fb493995522a88d61de67fa570631c01807718 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -138,6 +138,30 @@ &sd {
 	status = "okay";
 };
 
+&spifmc0 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
+
+&spifmc1 {
+	status = "okay";
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>;
+		spi-rx-bus-width = <1>;
+	};
+};
+
 &uart0 {
 	pinctrl-0 = <&uart0_cfg>;
 	pinctrl-names = "default";

-- 
2.51.0


