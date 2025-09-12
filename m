Return-Path: <linux-kernel+bounces-813077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E5B5407C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 04:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBF00164EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039792AE66;
	Fri, 12 Sep 2025 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdXvyRrH"
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC11D54E2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 02:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757644668; cv=none; b=B3ppNffzKKtE8/fVSXFV8tOJUgULpF3MBqVBwnDZ0srkBfAGzb9t4KHGG9zC4Dw1rUmhqH+Z9lhFWVFhFJBquKQSZr+WQqC8D1px4nMFpANv9aMaPtvlsZk63uYrb21d7lk638a240DEf4B82sGIl/j6lWeogjCC62CjAj9NGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757644668; c=relaxed/simple;
	bh=7ZMKBRn7WTwBL6qsn+lHI9SZa+lKRdoNg2FdbjpyDqE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioVHXj/yzNrfP8mU07oWTm+Jum1VXBjptkiYili7KCrppEiSyGI33D2j/wKIk6PEcpAvXJXL7OvyzI803ksZHdRk/8PLRinv1iWCJMjiT2AGDrOl04GTbQQUozFuLuPTccevlYhxrKeJvpQYCEJee/t5ImpH8c6SRxwop43IKVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdXvyRrH; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-74526ca7d64so1409957a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 19:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757644666; x=1758249466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=hdXvyRrHc5YVCn7WlVNjOl4HsPgAykdmV0jOS1WpZfcsUsn1dRd9/DESpg3TY9nPJN
         DhvPoLOzCAIR+J0VWUY0LXkeSZ7IKrwGt2uhLE87rjrZq2l+HwRsKLyQGJabzPL0GAW4
         CEkQAMNwK++4Rrf4uiYJcncS5Hjc03C2JI2vNPJy/Imu+tAvQnmfdulMuDSZOnKB/mif
         1wecv/UtYrCbiu7FqUb6Nf6Bz8AD1XzfAEMANOW2kgLuEy1eiNUIEjl4hbFh/w6yMvhO
         U1yJZQq7AliAzhNfKJ2rIbpievQRuePcZkOuPRVUobHkthoOri8joTl4GyduhaiK3Tg4
         Nz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757644666; x=1758249466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=DwfNEQ1kPRoHuKLkmqZQUO9yOXi0jD09vJ+ostZoQal5BTB1dSFvlVezWukaD8z2qz
         Yrol4XMb5vXB5BsN0+kOKK+pmmvf+NITyNMjWvZ19eQm/6bYGvtGMI6Lh0sUay0q1ebq
         BSh639Kzxkurn4mO0CrSY6+V/o5YK6bx1c+asuj9pn+FVAbXqTplSGOlQXL/o2ttqeur
         UUP1cs/DUZoPCfieIfRLs8VJjUslB1bq8pxHxGPGOAKr3uM4LXn+Pt+hyOFLiWEHbYbn
         CIPVH8VlS1tHwSOnoGMrlCkZg0CGccZqMOlB8wMNpWrLHNIPHdYRX/jDgq+gKqiwjvz7
         HTCQ==
X-Forwarded-Encrypted: i=1; AJvYcCX081IEk8A8OhhUN/P5MwQ6K7tyW/HCEKMA+T9seOmqzpxFAyb75hlGIYuu1bG7vN+VgcWSHH/1+S1MGLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcZ8p3lLCmT9m5DgBtkVuZYTW3l/fChtAT8rGxshX799s8VTPO
	pAV39StIG56ZBoLsP1aExYtsWn/VCzpBULUnNUL0HiyoP+mE9zgAv89P
X-Gm-Gg: ASbGncsR2uOQNvpmBTcNlvrjuabdrBXqB/LPia1Fw3xiolCU/D8rkTJalo1/lsTwnLP
	0xpF6Pc0ELGUjx+ZHzYthh6zm/beLcXXdFgwfzzqIZDSW7ZOMW0xy384d1R0rJnbQ28GchduewU
	uxUylBUfmxNY0rK7qb4d8Tne+bsUWRWNf4dzcD3e2jb8AvNKYB9g8kPSQxdMQCNlXWWEA6x48WB
	pvcm13qvginYs3DePwQuKGC1MPD4VBeoWfmCO5jcEpR7CiTPJ77H1Z5XEqV0OFQlUSK12YFevkV
	fr3yEG4v3QAS60dMAQckY9qt6mrZBux+w587Z4kKQ7xNYwV3HE/PhMU3xibsbM+1eqXIXGqn/Xq
	GgGCfcb5w6RG92SaiRIQn/MBwcbrG+0Fbpr+BmgrBSNY=
X-Google-Smtp-Source: AGHT+IG0TQa2WVbWUOjIbbfIZ5nePfOY9XArUERpTrkKtked//q7vNW0k55MNp1jMcZH67KflOuh+Q==
X-Received: by 2002:a05:6808:4f24:b0:439:b198:23ab with SMTP id 5614622812f47-43b8d8cff2cmr506892b6e.18.1757644666012;
        Thu, 11 Sep 2025 19:37:46 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b82a7264asm586173b6e.21.2025.09.11.19.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 19:37:44 -0700 (PDT)
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
Subject: [PATCH v3 6/7] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
Date: Fri, 12 Sep 2025 10:37:35 +0800
Message-Id: <76d4012e515dc3c3d4e406a237eadc55203f77b6.1757643388.git.unicorn_wang@outlook.com>
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

Enable PCIe controllers for Sophgo SG2042_EVB_V1.X board,
which uses SG2042 SoC.

Signed-off-by: Han Gao <rabenda.cn@gmail.com>
Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
index 3320bc1dd2c6..a186d036cf36 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-evb-v1.dts
@@ -164,6 +164,18 @@ phy0: phy@0 {
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


