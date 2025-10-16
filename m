Return-Path: <linux-kernel+bounces-855680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90268BE1F57
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E69E534F0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D502FE05F;
	Thu, 16 Oct 2025 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L53WD5cq"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5D62FABE1
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760600546; cv=none; b=lvN0K9MPMVHkJPXiFF9dAUDMXCIVB0VLZHyHMB7373sjsy5kySow9RhPplI3cTSzQs/UKBEF8q31Lk0ftmJNo6D0x22rdnFP6h1tUBoT6Ww9inOngPt8NIGUHeDzsPRS4oBn/FUpiJnVvyeKhWjILYSGXeQHHnG0e97HEiZPbsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760600546; c=relaxed/simple;
	bh=1GMIgj9fa8qcijUI+RA/PiInAoio4qFaHVwg665u70Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ETtKi/aBXh7MUd+H4ktGrToEiUVTf6oVI3nvI4jo1UNCpUbteonMBh0qN9dlRwvqhL04rBsYl5T+EgIn82dafQGVGzrVsObc1tvPKn7BBRWLXkCnypDno/TuE8RwNOvYMJOBye/DM5vdUPC0B1+EGQWwgMqZSTHpaFiexAxmUoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L53WD5cq; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-363cb0cd8a1so4085741fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760600543; x=1761205343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia5UihKP5vENKa1ZWsO4hQ9tEZ1zR6aQObC7qlN+yRs=;
        b=L53WD5cqZkf3Grf5Ny5ixH06yJZ6Zd6xcrPvucaISKp5w0no7oRZ1ndgWpoOBYsPje
         gR3LzzUvrHoDRJIj57OePmoYD7xYa0gQrZ0Zt70+ibX7DcrwLJDZ6mFAa0JqFWcwHnIZ
         5JswRRevK4L0LmiNuRzP3Wi6V8Tpqo2L69lQXsPJ808X3L33UzhD3FcNf3S2TgrrMp8C
         sDTi6eaTDRvU7EtzCu1hMK62RjquJ2HS1hrUMCAbzNCiHVWyVrolJE4wadKHkYuntqyk
         QguClvj3mRo1UpCodhYwsIWRx3J7SP8VtNQ+bjfIVsxd5RKJ4vajycvMsnW+aFpD0pA3
         qT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760600543; x=1761205343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia5UihKP5vENKa1ZWsO4hQ9tEZ1zR6aQObC7qlN+yRs=;
        b=mLWkeIPlw0jYEn+TdC0n9vXbw6dKGgaCk/iOoM5b0UWqKMGYzc+zCjA4v6nnYT4Pvz
         1a1Quu8JgElJtW0Vfj3a9f9OZhmdb28XqiO8OeT1QhbFUz2OkI0+V3saQi96AGkRzRX6
         Eri+MvywgOkyRLsMzE//fK43tzAGBRN0II3hdB1N2gZTg58E+l69Vu3ZbbyuRbMhjKjs
         H8j8Zi1JKkZRsH0g7e4s+A91RkDRX99RBoztbfCxcU8muDN+0RpLgeMzsDY3Xci+LjvO
         ofIn6gCyZiYQDDLCDGMCn6hNw66pt2wkf99TwAeTl+UnEhniP7pWqbhId0ZFqn19W6ub
         EvQw==
X-Forwarded-Encrypted: i=1; AJvYcCUuaQtjGc5peCm82maHbgOONX0CWWPU5hTTfDlUJN+giQ7000ZBG0aM6cMUKQzZXjBtt+adkjm02AxwAPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2jj3nviRvPWa8m4EaSX+lKJcjFWhtSP65e4iy1F/ohxw2ZGZ2
	vp/9Uo84BhspwEU3qheibQOdw4TYKxT9oY8OFQiU/4mxclwGhTU/UHH/
X-Gm-Gg: ASbGnct9XWfUk/8hUlEto3Fo0laEmfpeXvPiqICSMZdIm+Gz3CaeRUP1scIpX+Y2Jrs
	t+78DmFZ5RgFuRnWapMoPXSEvbA/AgNGT5O1hST2JANQxWduUmMWdAz/Gm1oQlYmijXoTAfYEsK
	3mXVtS5oTCPeK+HlR8DtSSY16InM2vopDbFw7vuVper6pEBmmvCnl4tVj8fsCG6GtLSREK6KHsj
	XJpXzUFbi1dl9KtnZvIxSxSszfmRB5WBssiPMX28iQB2HFFyRoA42lgdWjL42x+Qk7Twj9GpK0a
	E5+eJ2P+rOZIIzObaPd83EIQGIxkK36tF0plleHiK+a9Ks5KxTlQLB8Pb1SJYhGQsRFFkEPLLC8
	KJUD2Ywh6V34PF2qJ2fl42yP2yCkl4N5eRxpW5XrFafj3NtBUg5Mj6uDGqESXRFKfLQw=
X-Google-Smtp-Source: AGHT+IH30WPk5mTWKUGkgpDqPD9jcWCWyb5Rjdc/LS292IWzNiQQP2senhWiVMmYVrWHo213ylX7tA==
X-Received: by 2002:a2e:bd14:0:b0:372:9d94:8697 with SMTP id 38308e7fff4ca-37609f05411mr92467611fa.44.1760600542660;
        Thu, 16 Oct 2025 00:42:22 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3762ea14d46sm53226121fa.34.2025.10.16.00.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 00:42:22 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4 RESEND] ARM: tegra114: add missing HOST1X device nodes
Date: Thu, 16 Oct 2025 10:41:50 +0300
Message-ID: <20251016074152.8759-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251016074152.8759-1-clamor95@gmail.com>
References: <20251016074152.8759-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nodes for devices on the HOST1X bus: VI, EPP, ISP, MSENC and TSEC.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm/boot/dts/nvidia/tegra114.dtsi | 64 ++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/nvidia/tegra114.dtsi b/arch/arm/boot/dts/nvidia/tegra114.dtsi
index 4caf2073c556..8600a5c52be9 100644
--- a/arch/arm/boot/dts/nvidia/tegra114.dtsi
+++ b/arch/arm/boot/dts/nvidia/tegra114.dtsi
@@ -47,6 +47,45 @@ host1x@50000000 {
 
 		ranges = <0x54000000 0x54000000 0x01000000>;
 
+		vi@54080000 {
+			compatible = "nvidia,tegra114-vi";
+			reg = <0x54080000 0x00040000>;
+			interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_VI>;
+			resets = <&tegra_car 20>;
+			reset-names = "vi";
+
+			iommus = <&mc TEGRA_SWGROUP_VI>;
+
+			status = "disabled";
+		};
+
+		epp@540c0000 {
+			compatible = "nvidia,tegra114-epp";
+			reg = <0x540c0000 0x00040000>;
+			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_EPP>;
+			resets = <&tegra_car TEGRA114_CLK_EPP>;
+			reset-names = "epp";
+
+			iommus = <&mc TEGRA_SWGROUP_EPP>;
+
+			status = "disabled";
+		};
+
+		isp@54100000 {
+			compatible = "nvidia,tegra114-isp";
+			reg = <0x54100000 0x00040000>;
+			interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_ISP>;
+			resets = <&tegra_car TEGRA114_CLK_ISP>;
+			reset-names = "isp";
+
+			iommus = <&mc TEGRA_SWGROUP_ISP>;
+
+			status = "disabled";
+		};
+
 		gr2d@54140000 {
 			compatible = "nvidia,tegra114-gr2d";
 			reg = <0x54140000 0x00040000>;
@@ -149,6 +188,31 @@ dsib: dsi@54400000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 		};
+
+		msenc@544c0000 {
+			compatible = "nvidia,tegra114-msenc";
+			reg = <0x544c0000 0x00040000>;
+			interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_MSENC>;
+			resets = <&tegra_car TEGRA114_CLK_MSENC>;
+			reset-names = "mpe";
+
+			iommus = <&mc TEGRA_SWGROUP_MSENC>;
+
+			status = "disabled";
+		};
+
+		tsec@54500000 {
+			compatible = "nvidia,tegra114-tsec";
+			reg = <0x54500000 0x00040000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&tegra_car TEGRA114_CLK_TSEC>;
+			resets = <&tegra_car TEGRA114_CLK_TSEC>;
+
+			iommus = <&mc TEGRA_SWGROUP_TSEC>;
+
+			status = "disabled";
+		};
 	};
 
 	gic: interrupt-controller@50041000 {
-- 
2.48.1


