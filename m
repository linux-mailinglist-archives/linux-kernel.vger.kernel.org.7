Return-Path: <linux-kernel+bounces-813075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBAE9B54076
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91850A0527D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E45E1F8BD6;
	Fri, 12 Sep 2025 02:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXWnuwqD"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3394D1E3DDB
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644622; cv=none; b=f0NueqA1ROopmC5WJ4DOe3jZTvdfXBrCASDJXLVkKwRup9qgdvrYuaHtTNPlOoBcUMq7Wwj94rfoajPFd9ZHfDGW07ZvrlNZx5yfLtBpRLq50YvJ5HscZfepgfmk6Py3T7Sf4gMg8bs3gD6OkxA2beVQb+J3ckq4AtykS9ZTj0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644622; c=relaxed/simple;
	bh=7smwJj7dQIrNWzLpxsZgOxIEd7UE823bj8z0yhG3OBw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BENV/W5VRGnjaZvt2O0n3hwioFIFaiP9FbnN//hL+Mw2HecKjFiEgLXgeQchD0ENhZUUA07qoa9sUK2gbNdnegsO0D6RI+n/I0Fdw1wQUWRPglIaZa7q6bpsNW7ObV8LIiVqovBZPTFz2TtuqXPblUEYULRcui1YAl3u60/H+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXWnuwqD; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74c7d98935eso661255a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644620; x=1758249420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gvwjuScXFIOkNO4l0NAjh5hmUBFBDILktbVX+sGXQiQ=;
        b=VXWnuwqDJN1x/FOS6HQyuxSPVdC6w3EBPWPd4JnozuYmzRJiEEj4zS68rS0/isQoin
         xb/4yVXAym60NWIZorM7vqgxKZU/tBkcsZR4oDDMs3okNZMzfwn5jgR4RXoytqKgK7Gp
         4tLoR8VT72xLralFun0wQO3MU00KMP38XOZgW/OHPbX2rKOohyyYCEOHiBHiEW8I4gPp
         gFGQV62voPVo6X+46oalGmu+i5ngi2NGzv5jNCPgcWTsgw4hiSNkn3lQzQ1qq2Uj2ji4
         EaXk5PE5cE0AsfOOheJEon2nro3BX0zU9Wc2Gvd0YG10rll0oiJXk2tMetPBxcuerYoR
         jVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644620; x=1758249420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gvwjuScXFIOkNO4l0NAjh5hmUBFBDILktbVX+sGXQiQ=;
        b=O+wwXJPDyuJXsR7xmJ7bUEQJ2C0c98Tdk5thDCeii4OyfjUyXoXwWO1HsekQWkLyIW
         K13mvBBkBm542X098i6BwrsPVoz4fzcdHWILmC0chcstTdZ6M3UqTnXT5aFko2Dk08Nz
         UHFXaG68SRVqLiSH6jjY8vJ/G7F7dKYvvxG6Iy2bwFyBleAaHYm+J8M07w77vboeseSi
         aStUrxICXUWbEgyUkxRUptb49ZWmzfojSdfC4bBOAqI60Pu5ra6w0N0Y+VrNwB+ngBVk
         8egwmK5KQ1CHnBhzzLELQxrxBh5YVv6tEpVHo5sclNohVOU0qsc5RoJHTDfJLOEaCsC9
         tI2A==
X-Forwarded-Encrypted: i=1; AJvYcCXWito7GNkGHoezOLgNSR7E/v0QmvGrwcFqASrPV4MmZl7ITFsbhgINcRj7ydi0ckDcYk/S2OhXMbNMIi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHffrT6f4DGNo+4CPRlm7pgRVZBavK3ZbHplNyfTiS2rqRhEjN
	1FOcVMuLIIt3M1GOUMoNZv6rjgsDAyALbhFshGRDKJECQXzkDWWj9JGp
X-Gm-Gg: ASbGncviNXa66iP6bVBlj6wwG9U9STJC4WgnYaKa3Qeux4Rk1mhdipDAFyTAHrKJgS+
	oq7MUGG1C+G37hDNITlLcdLUMAFAfQ8LLmqL9rKlK7dgOkwD2bzczJuadHfLZ1zwMr3JCvd2P8q
	eF9M2KR7ka01bqU5dySdhzQlVnfaaHzBlg9GtTjyAU+u1qcGm2nDckpVuV1Ixj0p84bXhTFA4Aw
	+E6hxQdIKMOAl/vJsFkrnx+dE5LM826zF1/qdUx1ZzvK1/G4mTe0kbZ5SvvWD3anSACjpJsMlX6
	zKXx3DddDdWUF1lilRtFjAk9VRLo0nPd4anfeYM9GlJAZpL7CuQnV1hB07vuqq6V75XGKKromNe
	OpDe5L+6LZ6XHuS1EmHSj9eUO6mzMwsU3
X-Google-Smtp-Source: AGHT+IGyuP3/R9DH/EcaxhL/iQY5WFNGJfVttr0Thdfkkw6lmjBCk6VyxF13AjSvDr/I+XJlRFCejA==
X-Received: by 2002:a05:6830:82f7:b0:745:9a08:c9b2 with SMTP id 46e09a7af769-75352d903f5mr897685a34.5.1757644620197;
        Thu, 11 Sep 2025 19:37:00 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-621b7bf520esm343900eaf.7.2025.09.11.19.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:36:59 -0700 (PDT)
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
Subject: [PATCH v3 4/7] riscv: sophgo: dts: add PCIe controllers for SG2042
Date: Fri, 12 Sep 2025 10:36:50 +0800
Message-Id: <828860951ec4973285fe92fceb4b6f0ecb365a2f.1757643388.git.unicorn_wang@outlook.com>
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

Add PCIe controller nodes in DTS for Sophgo SG2042.
Default they are disabled.

Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index b3e4d3c18fdc..b521f674283e 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -220,6 +220,94 @@ clkgen: clock-controller@7030012000 {
 			#clock-cells = <1>;
 		};
 
+		pcie_rc0: pcie@7060000000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x60000000  0x0 0x00800000>,
+			      <0x40 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0000000  0x40 0xc0000000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xd0000000  0x40 0xd0000000  0x0 0x10000000>,
+				 <0x02000000 0x0  0xe0000000  0x40 0xe0000000  0x0 0x20000000>,
+				 <0x43000000 0x42 0x00000000  0x42 0x00000000  0x2 0x00000000>,
+				 <0x03000000 0x41 0x00000000  0x41 0x00000000  0x1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		pcie_rc1: pcie@7060800000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x60800000  0x0 0x00800000>,
+			      <0x44 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0400000  0x44 0xc0400000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xd0000000  0x44 0xd0000000  0x0 0x10000000>,
+				 <0x02000000 0x0  0xe0000000  0x44 0xe0000000  0x0 0x20000000>,
+				 <0x43000000 0x46 0x00000000  0x46 0x00000000  0x2 0x00000000>,
+				 <0x03000000 0x45 0x00000000  0x45 0x00000000  0x1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		pcie_rc2: pcie@7062000000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x62000000  0x0 0x00800000>,
+			      <0x48 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <2>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0800000  0x48 0xc0800000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xd0000000  0x48 0xd0000000  0x0 0x10000000>,
+				 <0x02000000 0x0  0xe0000000  0x48 0xe0000000  0x0 0x20000000>,
+				 <0x03000000 0x49 0x00000000  0x49 0x00000000  0x1 0x00000000>,
+				 <0x43000000 0x4a 0x00000000  0x4a 0x00000000  0x2 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
+		pcie_rc3: pcie@7062800000 {
+			compatible = "sophgo,sg2042-pcie-host";
+			device_type = "pci";
+			reg = <0x70 0x62800000  0x0 0x00800000>,
+			      <0x4c 0x00000000  0x0 0x00001000>;
+			reg-names = "reg", "cfg";
+			linux,pci-domain = <3>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			ranges = <0x01000000 0x0  0xc0c00000  0x4c 0xc0c00000  0x0 0x00400000>,
+				 <0x42000000 0x0  0xf8000000  0x4c 0xf8000000  0x0 0x04000000>,
+				 <0x02000000 0x0  0xfc000000  0x4c 0xfc000000  0x0 0x04000000>,
+				 <0x43000000 0x4e 0x00000000  0x4e 0x00000000  0x2 0x00000000>,
+				 <0x03000000 0x4d 0x00000000  0x4d 0x00000000  0x1 0x00000000>;
+			bus-range = <0x0 0xff>;
+			vendor-id = <0x1f1c>;
+			device-id = <0x2042>;
+			cdns,no-bar-match-nbits = <48>;
+			msi-parent = <&msi>;
+			status = "disabled";
+		};
+
 		clint_mswi: interrupt-controller@7094000000 {
 			compatible = "sophgo,sg2042-aclint-mswi", "thead,c900-aclint-mswi";
 			reg = <0x00000070 0x94000000 0x00000000 0x00004000>;
-- 
2.34.1


