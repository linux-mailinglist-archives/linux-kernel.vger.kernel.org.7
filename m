Return-Path: <linux-kernel+bounces-881072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD0C27596
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 02:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC8364254E7
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 01:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D985E242D89;
	Sat,  1 Nov 2025 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxqVEBM1"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D677E246BDE
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 01:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961491; cv=none; b=EsInVBCFPJwalN19pUqbF8k6aTh760rriDMFxMBQ/o0RDqwtZZXlj38Eif0S3g+t8+A2gvWKsF9G6WWQeDwPAptE5CIcbgtYXDSa4o1lYl5QIlnvxI64ny/l/eLFwTvbn8sMdfKgrTOsWlkLt03z6DLaRs/wbvxbyCnaZCxCmpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961491; c=relaxed/simple;
	bh=gHKwX7PP5gGOlLXqIefFTY7ny3XOT8J2aK0JKv2/Ofk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D9ofCD/OZ+PBK34G0ctqa3MNCTRgsPxhH2XjMS/u04JJJpi9YR+MpS0WC67AJX7pUKgAGQWhAfRHBYn5ZDcltYU4CeCKqo81JxDNfl/ambSyGCqX1j0lXKinDayaxJqJt8ZG0j3jJJz8OLaAGt/ofH8TaKGZ9BBe6JECCh0NSCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxqVEBM1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33d463e79ddso3468067a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 18:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761961489; x=1762566289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDm1+WSNoDjU3S+YxmjJ+3pKYEs3Q0EpdQk5O1Ku0Ho=;
        b=QxqVEBM16WbQaP5L81QbHvmfkXKv2DxEjPkNcpbu+n4s/jZiYlcvpDWKuWU2U+W7cH
         ee1cdd9+GDW94kKDPsVyhAaDgFENFcjnwACArq7XhR35Q13hnFK/gamCZaUAKXmpCH4A
         rsRjgBda8Uizls7wUVdCHTR6ZDEA5DCOKnAdbyo0Vl5plRRGNlQ5ACXYiUOn6vMLkMuv
         8Ex8RdgD3O3gd71822o0CdcWCJJJdg4kfjmzUSWDcKs9G0SChIBFMU8M65NN8oTO+b4M
         A6Xn7KtH7IZ6BLVabHsELH+AUsKJ0Qs84+zj5UFtaOEwhqnqbAzMcUL6yPHPTKIiSA/2
         SjUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761961489; x=1762566289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDm1+WSNoDjU3S+YxmjJ+3pKYEs3Q0EpdQk5O1Ku0Ho=;
        b=kM9LSKpYxzajHefyyTUFb30lBEubxHHNoH5poxWjiWZnuCN1P6GNcUjEatHXedPslf
         1rIxr5WtD5T2LuelievyyPcie+MT85rw7pA4y3llsxXSHrt6HMOsa0XS9fod7F5WiIoa
         Pfm7YK2DfkAdgQ+nssOY5l8S5q6q0bdkmqop6/HeH1ZpkbC4iv35bfb3ETazI4OIRvSV
         1Zmc9kKHAhjpxd6KDPLuIKGkDmS3QDG9QrvJVvcJTbAuC/witMpeut3Bmn7jKi1yCnB7
         icDU2HvFUfSRuk3/f7Rz9N0gSmZqufp+vYHN0V2YXz/insSfIPJCwpUtXBfCDTPsZIT3
         y+SA==
X-Forwarded-Encrypted: i=1; AJvYcCV5aHUHfvL+gsMoBnDnlu9GPJPKKosRPk9l5ZDn5dmrxDLI4s/yGIAZ9PZKvDldQuYgm/HMZhCmUnaU+No=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFICiQG/AKO/WMG8QA+FrW8+xDtpv0Pdyx9X6JwTjbs4EDNl1Q
	POuGYOfuqZSJwa1lLa+IeyDaL4k8W6O0Oy+tCt7N0I5Hs7NGCVyWLuBM
X-Gm-Gg: ASbGncsddkV/KIf8R+vNa95kFCOAA51z1vcE/mREB4DPAJk3LsdTzjK7gARJdDEL+Ry
	UmxV9bTi7PRpdETciX8jcQ6FwuJYoZI0Odfk/Dpua6JHm8g/uSi6AaXsALeefgjc5I/39jPWBgN
	jy767vKUk2xR8JmBL68wvk8kfFqaoMUE8dHhk/re79D3rKSwHz7aD4qaIFwAlK6FpNdEXpRPFb3
	MfyIp4eXSph+NOi1cWH7UCUPr3WFjY5w/LD8Ps730KBWB7RWayYJWpily/8L3s9dE8W2HqNPWZV
	8ncFLScYdNWYKxOmkbLvt84l+CYj3tn3Ynv5rGyK7c3v3VuiSZSOg/K27FnxZAAhjcMPwzfh2r+
	StgTfFtEMpwKNniosB8BkU6mVPfJcf6QIJpQ/h+0KYO2gEEC3NvMsSQKzTlG080JWFnbAWzqJ3F
	c3Mlvxq2mQVkVWb4zI5ljtTGXRw3E=
X-Google-Smtp-Source: AGHT+IHCcU4e+DqHPOrwiHTkTGTSDdoO4ULRyleIswiaTH0OibjXfdAmKn0F8G4yAJ3McQ4Uax/qcA==
X-Received: by 2002:a17:90b:510d:b0:340:c02c:d2b1 with SMTP id 98e67ed59e1d1-340c02ce1a2mr476048a91.1.1761961489084;
        Fri, 31 Oct 2025 18:44:49 -0700 (PDT)
Received: from localhost.localdomain ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93bf078924sm3350585a12.32.2025.10.31.18.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 18:44:48 -0700 (PDT)
From: Longbin Li <looong.bin@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@gmail.com>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>
Cc: Longbin Li <looong.bin@gmail.com>,
	devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v5 2/3] riscv: dts: sophgo: Add syscon node for cv18xx
Date: Sat,  1 Nov 2025 09:43:22 +0800
Message-ID: <20251101014329.18439-3-looong.bin@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251101014329.18439-1-looong.bin@gmail.com>
References: <20251101014329.18439-1-looong.bin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add top syscon node and all subdevice nodes for cv18xx series SoC.

Co-developed-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Longbin Li <looong.bin@gmail.com>
Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv180x.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv180x.dtsi b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
index ccdb45498653..42303acb2b39 100644
--- a/arch/riscv/boot/dts/sophgo/cv180x.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv180x.dtsi
@@ -25,6 +25,32 @@ soc {
 		#size-cells = <1>;
 		ranges;

+		syscon: syscon@3000000 {
+			compatible = "sophgo,cv1800b-top-syscon",
+				     "syscon", "simple-mfd";
+			reg = <0x03000000 0x1000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			usbphy: phy@48 {
+				compatible = "sophgo,cv1800b-usb2-phy";
+				reg = <0x48 0x4>;
+				#phy-cells = <0>;
+				clocks = <&clk CLK_USB_125M>,
+					 <&clk CLK_USB_33K>,
+					 <&clk CLK_USB_12M>;
+				clock-names = "app", "stb", "lpm";
+				resets = <&rst RST_COMBO_PHY0>;
+			};
+
+			dmamux: dma-router@154 {
+				compatible = "sophgo,cv1800b-dmamux";
+				reg = <0x154 0x8>, <0x298 0x4>;
+				#dma-cells = <2>;
+				dma-masters = <&dmac>;
+			};
+		};
+
 		rst: reset-controller@3003000 {
 			compatible = "sophgo,cv1800b-reset";
 			reg = <0x3003000 0x1000>;
--
2.51.0

