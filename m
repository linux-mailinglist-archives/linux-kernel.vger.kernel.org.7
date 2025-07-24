Return-Path: <linux-kernel+bounces-744900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411AAB1124C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 22:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21075AC3C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 20:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BD62727FF;
	Thu, 24 Jul 2025 20:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="e6qNgGpk"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96626F47D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 20:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753388733; cv=none; b=RhyfK4N0FVrcihv4uQQqhMr/cYcxChTW4Gl4iwzCx1T8J7EiNfpSZ8dmCIbvmoEZKq1LLYk4hOih2jVAVyY/ari5uX5AarcL6VL+4zkeTPEoKGdCzEcD437hsogvG/+J0nwdWJ3DA31TgG/XheEmU6H1fmBLAJ8ci2cvfpB1DhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753388733; c=relaxed/simple;
	bh=gQgnEu46nXffeDK/T2EsMnfRsMV5amrAJvwckiMVDxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bNjfCu3JKcLv7EpKHRnK+XiLnVCR6bMpkQ8w9Lf6kpdvhZ1nAc70B/WJVu7YwC88Y7hwt8/XyQNolI7EuI1eWtPalsQKbWUXOsUqkPVySXJw65qLyCFmZtenwL1zIR2uH/KLzTJRSNzCoPqRRrWXTWTCSXFa0uM3hZNqJGzqIo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=e6qNgGpk; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-86a052d7897so42735739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 13:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1753388731; x=1753993531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEiPn0cbVvyWonyoHzSQ1laMwOj6/PCdxE3K2rEb90M=;
        b=e6qNgGpk/Zvo72makg5Wbl7ZUFGc6Ee4S2kr8+Y/9brDu/BZaE5rGekaJDZ800mz33
         BXTI/vuQdDnsA7KZ76Xm7KPH0rh/DyjIs3E4Xy2cJlPohAFU30e+GmRjmbO+XdL9biZy
         2LKmLedSx+fvSU05sX3jYIjlckztJW95WeAMrBxFxBh9UbJ7Gwbirf1zEQR1dz2ENlWf
         L/3bWhizGGq8fcgG49ytVFKrUzhWphcbO/Lhtr8Bm+DWBF0BHEPb4km3iGLluo5FdD6Q
         eyNMv7JUi2TtHwyy3m1eOsgZH7Gz5+cuzDkhDWlRV8GAv/7HRZyc/OKgntJJSdoabkoW
         ++zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753388731; x=1753993531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEiPn0cbVvyWonyoHzSQ1laMwOj6/PCdxE3K2rEb90M=;
        b=vNwy3TmcQ/xCsYSQTpiDFSQQR/hTCigL5V+3OGuwkzAetP1Rvdyvvy2vJh4AUIUa71
         vXjJiN3HOokLircTid/0QfykupLw2TxfFQc7qttpJUoyhvmnW5yVAPIyj2UqVbHC1Mcy
         NnL/018MZMRQrQ62mzQUQ0IYp9h+03bhtCfxCizBmOl3ZC1uJlgzRuvks3YXKopv3yLL
         jumYNJxcBLuTwEq7+LkgrjuVh1xDltyVaI/dZ1IojnFQb1mMajLhUxNigMB6UBgK5CvB
         gARjC1FHtb3ANiNS+MpQMKSFPdI4dpWZ+S2H5bLW8YvzR3NRDmNsEh3f7M7OgB8UaWRg
         fSzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzCd4yUsYRsPPFVVC4Eueh+jsGWMZI5Vq6GoYOJwS8/vmX73fov1dJgPJRRaj3b7LUo1IT8CbPeLYJ9KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFD7pyMCKsq0lO7Bv1l/M0KFGniwPsjv11kWL5Yht4EVbkfW9B
	K8mfPGsIwxgaGq72thX+dc+8T4FdQovILVVB4FfLILl9+7EmgWcZQ4dSgLbgCD31b5A=
X-Gm-Gg: ASbGncu3u9TtXIrCOvunae7YOV796uiMOfjN61tNLxsBy3XYcyH8XkLi9y0Eo68vZpq
	zjla2EgyjccQKdqKUhyHhd2P2DKeCOw3WrTItKYtJ1aNeJwPKbR3Ej+nIX0A4fsw9yFkP4ZoASg
	9wX4ikSzYRGTkj//sy6JZhBs960dCeNbO+bkQ+oRjpnvkV/DnM8j4VeKTfOHFBEmJUYMys48TWv
	D842910VpmOhmKDWJ4eC9fRnt/BXrAY04JRSfJVGeRVnNqsWJ0Fv5EXipS+E9y0qiQOsixa/+Y0
	6c5dBzsoPLjJVJHpW2necC7ITvusCbjTEAF8tMw/VxSvEDd3Sz1ZaUNfzi8/45N4YX4AwNuOl7E
	Svk9Bcd/cdWwoH8Cg8dl/rH8w2xP3VPl5J8Cj+83m
X-Google-Smtp-Source: AGHT+IEOCPJEmS++a59jxbnEfzm6BGBxv4jrcgvVSaZ5cgZIE4C2TYD/gzvOZX8xyz7qYVEph48/fQ==
X-Received: by 2002:a05:6602:3421:b0:87c:4496:329d with SMTP id ca18e2360f4ac-87c64f64aafmr1508845939f.5.1753388730846;
        Thu, 24 Jul 2025 13:25:30 -0700 (PDT)
Received: from zoltan.localdomain ([199.59.116.160])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-87c74316a3bsm63080239f.23.2025.07.24.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 13:25:30 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: lee@kernel.org,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	alexandre.belloni@bootlin.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: mat.jonczyk@o2.pl,
	dlan@gentoo.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux.amoon@gmail.com,
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v9 8/8] riscv: dts: spacemit: define regulator constraints
Date: Thu, 24 Jul 2025 15:25:09 -0500
Message-ID: <20250724202511.499288-9-elder@riscstar.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250724202511.499288-1-elder@riscstar.com>
References: <20250724202511.499288-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define basic constraints for the regulators in the SpacemiT P1 PMIC,
as implemented in the Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 104 ++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index a1c184b814262..83907cc1d5ccf 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -70,7 +70,111 @@ pmic@41 {
 		compatible = "spacemit,p1";
 		reg = <0x41>;
 		interrupts = <64>;
+		vin-supply = <&reg_vcc_4v>;
 		status = "okay";
+
+		regulators {
+			buck1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1800000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			buck6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3450000>;
+				regulator-ramp-delay = <5000>;
+				regulator-always-on;
+			};
+
+			aldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			aldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			aldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo1 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+			};
+
+			dldo2 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo3 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo4 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo5 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+
+			dldo6 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-always-on;
+			};
+
+			dldo7 {
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <3400000>;
+			};
+		};
 	};
 };
 
-- 
2.43.0


