Return-Path: <linux-kernel+bounces-860046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB83BEF32E
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0805E4E055B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66852BDC1B;
	Mon, 20 Oct 2025 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L26fsBei"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59DF1C8606
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931575; cv=none; b=cJ23PQFD0E9sMJ9M1iyOWjlZEAHaEgjDoXcGGEsCTX82hwwdQ+23S/6JupWyhBnXS88JjLnmigAljCE89RoKk1ENMhjQRfMamPBRDPd2GyhNfCc5DLeys+JAWu9bkxiwwPxrjcb8cGspd2K67oSyqek1Uc1aJPMr+tdEiNkd/Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931575; c=relaxed/simple;
	bh=7ZMKBRn7WTwBL6qsn+lHI9SZa+lKRdoNg2FdbjpyDqE=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=shstnDJnAlU7tDKy7kXaQT6sJhjHItpbMwh7kcXZ/Px452upjg/noZJd1j+2u0cK5eGntR73+mgFzNbScrOvGJvK44pL8jUYSlX5O8LeKiijd+YlERDT//VDRxV1CzMS+XV/xPdqCCrJ9o1U4lzbfouxhA7iLfD8slzcQuAll/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L26fsBei; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7c2948b774cso589789a34.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760931572; x=1761536372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=L26fsBeiNIWfpU6mC8TwXsdHWKXYuq5u+Vj9jPR3EfP0dcNoxJ9EHeRRLzFSS9gz87
         Fq4fyq1qEsvnVBlPWXBHDmfSP2EsdYTFmVecl1UWJsc5ms8bZ8pS63gM0WDSCW7s54Kg
         XLSVc0Qxa/nKwIqDg58L1h/3SApG+ggWKurLpXEmrQlTDNMK35esm7n2JlOSzOJV344p
         /BpZ4Z1y0m6WY8DGo7r1ABRSqdc/jipWE7IuQTXGxjH0g9cSDhyaokRGHUcWgWY459LA
         RrejtR826S9LojuiqtWf+VicjFk4n2gUhyd9baZWX2+cozXqTh470fmPygtKFyFghX+c
         KPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760931572; x=1761536372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a0NX4YDlfnF2moHa0Gi9m7awPoXSV0rkM143rN50kIc=;
        b=cmTElQJU4BIZLjjfFql9cEMYwYRlXMPfoXx9Ua5TYlG7TFG/E1MyIJ9w6F374AcE9V
         5qhab7f2jkweVHsNnGoTGMDwNkIHvc3UngJ267s61V7bX2IGNIDm28p6KEil6jcstMQq
         To25vup1jUg1piX6IsuYGDqhCb7PkWi6nIuiU/jO+SKsCgG/IAYdEv14fA4sj8dMKs9a
         UHmXYVehw+1IRFVSmZO6+nozOOCctdb0m161AkHIZ32JmAJyMrNEve/02sjDgh8cLS71
         5XpnEGwEhmio/8DWpkPyVj7FI8JxAm1hAMRr8Fk5m2fRAnKAlwBTLhNmXAsFJGQzrpRA
         CbVw==
X-Forwarded-Encrypted: i=1; AJvYcCVo5g141i2EPTU32I0l3NijHxrrQrYa4snDTe1WUbcQyyY0E2YLFrh4VgCQWlszU0z3rB5WuPPhG96s25w=@vger.kernel.org
X-Gm-Message-State: AOJu0YweQUjS3s7NR5HKvsKCJUUsssGBFl6uljcz0nWSPvSupf1+MFM7
	PDsJQzIZGhn9snfSNwNMlZNtCFwshTnodWgKUFaaHDa7wOGvZm2E4BYU
X-Gm-Gg: ASbGncsIn15RuITQf9/OEqV+3JDEWY2xJv0OOGADFyef/NAcW1YvvTftX86z4c0tv80
	BKLeaXUDkaiWkdKb0kBVSqBN8uH1cW+2JdnTGn8KgnI823U0Uco1nOBioeh4GoSIPGaEDbomhps
	is9Td7Q7S4GxD9X6DLVK6oaQG9Y7Bql0qj495XJ/NLCgmx42CxUyV/wmtOek3fLNC/Ur/w7pgTY
	rbKpynV+hgYAE7v65ywDtWoiG+my9an1ZfLjWv/ElxHwB6VXnskFli/GLmaV46SAyNjOiazgOOl
	4r8o+gY6aDvsp9dzqfOVhe2fruAyq8nWP4GnJ0ZkCI9BtvE7aSg08OBivXpRY4AsRkyKtKDiV00
	8MZjPvMIBbvaKVzAub2gHt22+tQ4j2iDh9aquzc8OorD+E0gTlIyNUZkCFrX6BmOyCQidr1Vvwo
	z8lgWyUxib5A==
X-Google-Smtp-Source: AGHT+IHOs0K/WHwSdDIh+Y1Yr2b9rRO8V71RUx/TA5imJO1TgmZR2tfJC9CXblqfxCEeOeM8R6VM+w==
X-Received: by 2002:a05:6830:4985:b0:745:a30c:b088 with SMTP id 46e09a7af769-7c27c912669mr6299929a34.5.1760931572053;
        Sun, 19 Oct 2025 20:39:32 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7c28890f2a6sm2259202a34.24.2025.10.19.20.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 20:39:30 -0700 (PDT)
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
Subject: [PATCH 3/4] riscv: sophgo: dts: enable PCIe for SG2042_EVB_V1.X
Date: Mon, 20 Oct 2025 11:39:22 +0800
Message-Id: <1ad96631cc9d9d7403a2bed5585d856fa101a2ef.1760929111.git.unicorn_wang@outlook.com>
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


