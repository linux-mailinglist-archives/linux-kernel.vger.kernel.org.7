Return-Path: <linux-kernel+bounces-860043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 508CEBEF316
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7A803E213B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC83D2BD590;
	Mon, 20 Oct 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJR2OPaU"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778A12868A9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931235; cv=none; b=X37s70lrfftYwsYy7vchf4+o8zfeCnLNJIkp/wiPmZzQOBauwHqWAFvyUrVs0k5sMHJP1Pqpu/JMnegFqFD4yBm50R2/1ofWXi9j/OS1/NHTaCPobhLam5kCtwlRHoEbRAeL7AeU0QeSNBI0qSBKOMGE0UQj11N80hgafpy42KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931235; c=relaxed/simple;
	bh=jIfey9ih8KXLTx/c1IvRSwzN7kMVHh/BDw+ykH6YUBs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BIF0e0R6FfNfNs3poiQta0/LaKxgrpfu0A8hF8mwW2f5fSS1tcUq4pRrHIL8hb6QtYaUpev1muBCRl4e1P2ocBzMcTH5yXyNleLgvcHOKswT8ttVZgOAPjg/O7IvnOKbjREhYjRPOLKrBbJngsZiGS/FJUHpDF0IIX7hT6qyxiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJR2OPaU; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7c284d4867eso788748a34.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760931232; x=1761536032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eE+2izhbixPNMGObc2mrhI1AAWPZUT7zIjDQJxZtTJQ=;
        b=aJR2OPaUvGeDsgzmJ3jLlfcgF+3NlTmpq7q6Q60DDxjW5kL7+I86291zA0yFOzHc/T
         uvxs9tHP7UawcSdV/jKDGpqGcfxq+HDB1EFR6NvCVnE0R0VHrgll4tQ2suVOVoWiTzTB
         Qi1X2S7523/8jPTLRzxrFvbf+VsuuC84AhNcgIxWBB7z5x+uJjdLnZLQOZ3QfalcvElQ
         pxdDwbJLne+kZOc7TVGKfC5Bx47TKdxZKNcIHntVxFhIsjD79euE10+60RTyZNpFBLm3
         OdzdMd+Jqz1xoOlErHkwoVCG+FKWtKM62qV+mGA5iJL2jfUPGxbMRkSdtJFGkgby1bdB
         dJQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760931232; x=1761536032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE+2izhbixPNMGObc2mrhI1AAWPZUT7zIjDQJxZtTJQ=;
        b=VR5UWwwbYm8c7xzIXyPJJJoBOWnOMYKFMFHaD8ecj9EVXlwOlSx5q9Z4zp3AlyTHoJ
         YMQ+53JkwlRcnutnPxzM8gkxQfMSO92YOyN3vpuhjpT6S7bEWATZe8aOqQv1qxAKr5m7
         G/oKvtbP0rZOomWYSvg5L9Ae6afniRYtEq+UAU4JFGChg3GtaiW7JaOWRvixUEa//DcO
         olx1D18ggx4q9pJmNnzow7uWNJo7KbUMErWkB6e8Vl+3BWjgz0KUZObQs0mS92A8e/w0
         q0GeEr6ST2V9HLgjqgmjZCrovTbR/xBn0cpv609r50na7asgx6V99e/U5hC8Irrh5Ckx
         eHBA==
X-Forwarded-Encrypted: i=1; AJvYcCWx5LynSQtIKqMN/NhkTALc76QHu/qkFas5Np7rUNKTeJsRCAmHE+gCMwYl/J/av3yok+E3hFFnhIL+aSk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoJYWvFNJ7/lTAr60ySk6FEqkfnwQuv9f1+KJ2thvzRh9zbjQo
	CGukEyLLJLWRcJIxRhg1IVFkHU5WnLQIay7Yrvk4had9tCmc4eCFk8D5WMZUEf0DI9c=
X-Gm-Gg: ASbGnct9EW64hrjSjLLfEv2scu+YOjnUEjgezknnCRpRWKv0GQSzY1keoy968Cy1mn1
	bYdOXqhp5dm91oCOcQWEaxS6ncwZpqje6bW6c+/6q6uU9nBG+bd7rmc5IxWL3Z6qtP2JDN82kFl
	XElmnTqjCTahyv+BD9mvxw3d5NY84bOSI2f3JNzJZUvtTA2OYo6VnrsbaQW6gvagcVZ57YTWG7s
	0hKbhYLs9iWVhOnj5QUKpdEkmbXFU2l7qifvbu5AcSlm5Pg2cxw1HiQzSPs8p5tnGrMg5uRPf9r
	E4wZZtYGpl8oqH1t8o5YytgxJ2Fi4lfUlZ9AKsfIM1qgvJOw7Mv+HUJdsCAhrWRGjv4NVBmu90s
	7gI+BrNDMCmnhBT9PhUL/1hGlYVEzCyk7RY3huIZkOIES7v02GOv+cljTZ+5GpywYHO4I2q0XDN
	ta6+ifxyQF9Ao8LimN5GYd
X-Google-Smtp-Source: AGHT+IH7yi/yFmj7siKHMPw+MkU92NW4tigcvPRgjiSI1spL5Vh8ashM0eVWC/cROlPfU+WidZl7yA==
X-Received: by 2002:a05:6808:1a23:b0:443:a224:8f98 with SMTP id 5614622812f47-443a3179d1amr4879888b6e.61.1760931232450;
        Sun, 19 Oct 2025 20:33:52 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-443df628a35sm1586544b6e.22.2025.10.19.20.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 20:33:51 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	rabenda.cn@gmail.com,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	mani@kernel.org,
	liujingqi@lanxincomputing.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 1/4] riscv: sophgo: dts: add PCIe controllers for SG2042
Date: Mon, 20 Oct 2025 11:33:43 +0800
Message-Id: <b34d819cd763482e0ecbc5c5ea721f0101d1f844.1760929111.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1760929111.git.unicorn_wang@outlook.com>
References: <cover.1760929111.git.unicorn_wang@outlook.com>
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

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 88 ++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index c5e49709b308..85d8b89cf9fc 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -240,6 +240,94 @@ clkgen: clock-controller@7030012000 {
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
+			ranges = <0x01000000 0x0  0x00000000  0x40 0xc0000000  0x0 0x00400000>,
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
+			ranges = <0x01000000 0x0  0x00000000  0x44 0xc0400000  0x0 0x00400000>,
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
+			ranges = <0x01000000 0x0  0x00000000  0x48 0xc0800000  0x0 0x00400000>,
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
+			ranges = <0x01000000 0x0  0x00000000  0x4c 0xc0c00000  0x0 0x00400000>,
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


