Return-Path: <linux-kernel+bounces-818873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 496ABB5977C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66F0E7A53CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435C431B829;
	Tue, 16 Sep 2025 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF76/qVL"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF4731B820
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758028998; cv=none; b=HPCpIcRgg5b6ZBt4U82E5BIdp7VMm25iHViEcc7ngU/1xiwgcyLEsD7LMOLgvXserCO8efdhBsQyvmyeB/IIlR8hFkVV8L63mEpib+NdMCWQwDizU9N7p7od3g6okbkJCsDxuQ+07ZWE69/14HqFZgxstpKRUhk7tb5IOr/iLAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758028998; c=relaxed/simple;
	bh=SHdpc+7cha07M+f6R46l6uT5x3VEV6Ux3f9d/uogxOc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHIA0L8iKg7O7j1aKDO50RIJm/D257ALfdcd3kf2xhiGBO2c2YR9LKV8JlHdMFvsOaZH6xBYJAPSuhs76lsmMT764Jb3AKoshsZUyTTfkyfIkJ4KajKDWdfr6mLhUr0SWsndVzhzCWc6vytS9nB6aGA60PVsCuvyZ8j3zlslqIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF76/qVL; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-772301f8ae2so5060135b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 06:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758028994; x=1758633794; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yzzsgn9kvMTgwJtY45RJ/1wKDH1k7Bp8Dx6C1RuTuEE=;
        b=bF76/qVL0O6wRI753velKiG0EwVYPjqRtnrjjeXt414Tk7BjxCtgrFWvkb1y18scpn
         QYrF9JKtqpjOWBVV1LN8002wH1K/iE8KjFLhjpPVnBetREhBZP942+OqX3hqYNVYUMD0
         WS1Bj3XLpTMGWa9w/a2BwcggzvsWQOsxRN+u5xiMZJ+t1sQ1xxMk8yLjc9guUVs46nqw
         HFcVcv45Q6jmCsIYWMKOcQmgGRZ4l97b6a1si0SYoL0frEiVI4X92CfKO7h1cZXQYydr
         0h3odG9yyGfxejJtmNNOSoiNDSA+9vfb5J8v3puowJzq/lw+uEZpVpfouR8UZ1+DWA3U
         MsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758028994; x=1758633794;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yzzsgn9kvMTgwJtY45RJ/1wKDH1k7Bp8Dx6C1RuTuEE=;
        b=erLcFjVrbiYSxzHOcqZevoqcpjDTJpu3hHyTnst/uBqnQtCmemj/jUpORoOfUvEJbX
         EZq55ILJUkPuL9Rjsy1QXmgDIdFOuyWhyhW1p7GU2vOi/z2JqqeBq6AuMC36wS3N2u/L
         ICO6GtM6sxjp2vDR+pj2lsWwfM75klrAEOACoBr5xBSNdA/WS9BfVboJVxsmG6tqG1Xe
         TiRS10aCIXDemdnj7u+1FX4mK0n8mcA3JoFky1iA29jezckvzPwHBXXX0ti9ObvbWryg
         QNzKHGHfBDBbOhinOUS9JrkSjwECXaLAJtDVQhStk2f6oWhkTyaix7ln95px1/qn1zXD
         ydWA==
X-Forwarded-Encrypted: i=1; AJvYcCVNiz5l8zyNWXilZAvw0vNNAr/X9VZbtayKXrluV08d6F4WLEYvYCHsHaWzDfsVzTe9lwuZqriWLjw/KR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAFLx1XR5W2TKiahxHxHEYIV0mYfUa2FsHR+p+yVZOdfomxpEe
	vBspQzIXwlQ2GCQ3fzhCghz7pDVXxKvpt1iswLFLmkYMsVikSPNashu2
X-Gm-Gg: ASbGncvoe935LATNbGFPpJ3R8Hfq0gPXt+unMISX42Ux/UYtPy0yR0usUrsEB4BBq4t
	VwXGdRZ5RbLbUfxhvn3daH0wojwd5N1ha79q062IVOZz8SgQJ+Z4tuBeIrxVA/p2meDlZ1H9mBl
	WA1BPxsXrBZ/SO4uuJRYjTZ2a/X6A0lecgNJak+uU3+YrluuXipdOojUw+zUtmIaVBcL5X//Wzn
	pR170peU8EZ5FRG5HFKY81ZlC3wzzlHL3KBtPLVePiPYPhlZqY8iGtoU9/JWmQYKtvVILn6R8zh
	ItxIqDP0VMo3VNOHTSblVAfkhWa1+UREBkvpoLJXY6AbBBxeDSbWpQYhngrNUxdNFMP5p2cMv2c
	UYTHOQ1CUwih3nUtKJnHxNNcMOi4f/ldnDUOge2VN
X-Google-Smtp-Source: AGHT+IE5hq85yAnL8KXZBwRly+Am1wE9i4harM8JJoKLoRcHxNlPBFEDqO+gKM8kuuZ21uWb8lnKDQ==
X-Received: by 2002:a05:6a00:1256:b0:76e:885a:c332 with SMTP id d2e1a72fcca58-7761219ffc2mr20627026b3a.32.1758028993976;
        Tue, 16 Sep 2025 06:23:13 -0700 (PDT)
Received: from [127.0.0.1] ([101.76.241.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7761562f25dsm13277310b3a.74.2025.09.16.06.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 06:23:13 -0700 (PDT)
From: Zixian Zeng <sycamoremoon376@gmail.com>
Date: Tue, 16 Sep 2025 21:22:53 +0800
Subject: [PATCH v2 4/4] riscv: dts: sophgo: Enable SPI NOR node for
 SG2042_EVB_V2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-sfg-spidts-v2-4-b5d9024fe1c8@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758028972; l=1060;
 i=sycamoremoon376@gmail.com; s=20250113; h=from:subject:message-id;
 bh=SHdpc+7cha07M+f6R46l6uT5x3VEV6Ux3f9d/uogxOc=;
 b=qrayuAe2fZLnjYDzxOLnAw2az6O9llF8jgD6vCjLrtRLt6EDzsqs6MurTj5fqyOKNCoHEPBvE
 Pr3wyrlOZPfBNPeEyGepFgePvGPIMqcszpioEq6XQVSUSDGYOvRr9xR
X-Developer-Key: i=sycamoremoon376@gmail.com; a=ed25519;
 pk=OYfH6Z2Nx3aU1r0UZdvhskmddV6KC6V1nyFjsQQt4J8=

Enable SPI NOR node for SG2042_EVB_V2 device tree

According to SG2042_EVB_V2 schematic, SPI-NOR Flash cannot support QSPI
due to hardware design. Thus spi-(tx|rx)-bus-width must be set to 1.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Zixian Zeng <sycamoremoon376@gmail.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
index 46980e41b886ce17dacce791fa5f2cef14cfa214..78460b2851a231a3e06b28f9ac6bffd4700e7dab 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v2.dts
@@ -226,6 +226,18 @@ &sd {
 	status = "okay";
 };
 
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


