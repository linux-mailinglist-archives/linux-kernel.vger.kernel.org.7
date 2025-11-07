Return-Path: <linux-kernel+bounces-890935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 08857C416A4
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 20:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 863BC4F49AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 19:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07BD3043C9;
	Fri,  7 Nov 2025 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="odI8zLLB"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630B303A11
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762542976; cv=none; b=bmNLL7MeTQ2QM+ZSRwPYEsd0BelB0KKY9ohBIo6Menxrt1Pw1+yjnawFSLFGgU5+Z1E+KQPXNzZR/mtDOm0/3iPE73tl10mxVJTUaVsOerPVfhaN5ownzSQBAOQD3umwJ74NN0dBzx3QKH7H1Iiggo5JhyCGDdICo7ttp7Z/kS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762542976; c=relaxed/simple;
	bh=QBekHRPzqKsUbKsby283fcZkrUPlP9R23yy3sAWgrIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHrff/N7vcBiGMOovCTJEF8AsXPs2/A2ausJdfdTy2eMdRUsTrUB3Enz+O0N0456QJ66Q9hZyrSXDZmnL7Pkw70W64dKUAlleQkLMYxYjorSfbz8PeVnkD3QVXf1mRGqYt8rFQaOUjMwEBuQOYpOWQxggXNhtD+ncFwdW1Dgmfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=odI8zLLB; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-4330dfb6ea3so4129225ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 11:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1762542972; x=1763147772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UIkVe+mugmsixDMdOtfVXmcZx3cul0N4BhQxpoGzDAo=;
        b=odI8zLLBuDqw6Su63pKfdOspSOoYdgHfACPdP1g5I4WkhVypCzWhURcH96Dwul4sVY
         BJ785D0Md8ZkdVwKsMPoFXyMIxmhXB0U/zMhGxPsq4gojcwExZEmmBPelPZCHAKgQpSN
         iXDkzwDlbSq1GX0JA3GU+g4UyDMeVSBM5XGhGVuBcBnqhwPBL7wQRDVKrcVI0a7d1xwW
         CSLAPVmxQmBSpCb8aNZSxFB/b9/duZ5QakW6vMlewFHOSHRUWYte4oqbQeKxfcIVK7Zm
         V3JArmqckJ6eEduhFVsr7hxabG9kyDZv4xd7X5n39z8gOoR/LJVANsFXh3edRSvShcbz
         qjJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762542972; x=1763147772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UIkVe+mugmsixDMdOtfVXmcZx3cul0N4BhQxpoGzDAo=;
        b=NWsiDdho1zW+OhJUP+tr0PKEhLs6dm2PnXIYG7TbYA9ofZ7uvntn5vFcl7aZCuF4uC
         xmYzcmdVx94Df6x4SufijgptxLvM40r5lnmMG+CEexCZM4iBFT1mUlC+4e9I2oM3vMZp
         KQ+Fu+CyB52M/WdI68Kl+cpUDd8ECd2aA2X8VBkUKgTT5UGOndqvaOzBdkT/a76DFKoW
         ct58k9vHkN1LMmCJXd90amZnDf3iteIPb9HoGo+JpOL3ZIy4GWgV0kitsQVO7hg3OGwD
         XvUSeG0CZXB6ACrQQ3nBgK/sCBjds9vIRFiuD1zDGi+CO4b5JB3nRBCzJLoSEEcREgAW
         4JGA==
X-Forwarded-Encrypted: i=1; AJvYcCUpvdTWzc4pFdod/vQ2vZ0BzEg/g1Qcc5HKCcsoe6mP5E0ydKp3Yryl9u6ENv2RnbXPNbtCNv4x87sCtog=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhYUvp/qcVhAb9iSVipplIgr7u3cJe9NYXecvPJSAJFv6N2Mf
	pDnSy6kQdAtHvxAjbvV5DjYQmtLNcL6nId+LNZ0o8y3n9WorsHm9FRI3MV/rg9mwpH0=
X-Gm-Gg: ASbGncsJYDDVkCvwlo4mOvS7bzcshBeKz+gMG77kJkvQB79QQSuTQq/ex3JOEe8Y+CZ
	8VPLAkvW8WG1Iy9egDq0UK9gH9t1mzIOG1ApLSCq9RkampGt14Op86+QYf3kCdkoK18YPaaHgsU
	IBFQVBGQKLyvfc/ZyPi1FdGmggC6SHL2FZvlvXSVflXd0+69KKdJmYyEVOGOF61WRd2HV7972rV
	4xHQntSKVaBiF4zL9InC9BjBLr+iUT3Q7FMIoK0b6nK6Kc26x1ollCS76w2jYj9xlHre5HD3s0q
	OszWZHMedqJ7HY1jHGYiSO3C2KgYszPmMHkVe2kDLRYAw2AkGDR/Yn36W5OxxEJXkc34Oaj6CYg
	oBE9JcY9e/ZKuYfl6RWpacsTUcNyH2CaU1ue0EBCDLwMGFVhoV+jpS1+wFEof8SU4yIUx2tH5mY
	Lv2dapELzF9G/UTE0cuY9chAPrQh0s4oJK29jLc5CjyvzvMO8F2bTHZQ==
X-Google-Smtp-Source: AGHT+IFlqajTRrH6GkEYkSY6pfJF5GBL4YJImuL4SDohElEvyYDysB5Vc0X5vM04WS5bSAaQD5USYA==
X-Received: by 2002:a05:6e02:3e91:b0:431:d8ce:fa15 with SMTP id e9e14a558f8ab-43367dfa481mr8936525ab.5.1762542972541;
        Fri, 07 Nov 2025 11:16:12 -0800 (PST)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94888c34c6asm118772939f.10.2025.11.07.11.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:16:12 -0800 (PST)
From: Alex Elder <elder@riscstar.com>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 6/7] riscv: dts: spacemit: Add a PCIe regulator
Date: Fri,  7 Nov 2025 13:15:55 -0600
Message-ID: <20251107191557.1827677-7-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251107191557.1827677-1-elder@riscstar.com>
References: <20251107191557.1827677-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a 3.3v fixed voltage regulator to be used by PCIe on the
Banana Pi BPI-F3.  On this platform, this regulator is always on.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 33ca816bfd4b3..a269c2cca3ac9 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -33,6 +33,14 @@ led1 {
 		};
 	};
 
+	pcie_vcc_3v3: pcie-vcc3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "PCIE_VCC3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-always-on;
+	};
+
 	reg_dc_in: dc-in-12v {
 		compatible = "regulator-fixed";
 		regulator-name = "dc_in_12v";
-- 
2.48.1


