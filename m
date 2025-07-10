Return-Path: <linux-kernel+bounces-726272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22159B00AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 19:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE0F43A88B6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E82322F5C49;
	Thu, 10 Jul 2025 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="yowRgb65"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EC92F5487
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752169884; cv=none; b=M/Q8YQ5/YIwCUYH00gvqdOZ1eWGUv5hG4Tw6w4ho1VGf4s+im9kxPNEUN4ZYlRBLesv/hmlWHK5O4GR6YZ7WzsDwsEJgvnn6Ux0QD31ba/zQiaRvCC7O5de4nMUxWHgoYs7GCaO7jeDSBOc8AW++0+GvaYp2EabXQCjjnbcPR8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752169884; c=relaxed/simple;
	bh=E/I9W6fX+DhSmsmtI3yC9YfnKc4TowcG2XvObw3IonQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHpOq+N2B5CxLGlW8JOk/K8VXmiN20a+XTKZmOD3GFS5Rx9uZbs0/AabAYY+1c1rKs/h+hq+Ku9joJfSKZ4ne62Ztw9+1QZTfEedjgF6dhUJHg4UE4lVVuoWzh4Q+M4A9CfBkOO1zR/UK0hB3j4lOIiTIQFuM2f9LV/btsB5gyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=yowRgb65; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4a44b9b2af8so8711291cf.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 10:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1752169881; x=1752774681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpaBoGbv3UwS2ctJ5MNrLd4WnRBIdXYjgTh8qQmsLHk=;
        b=yowRgb65dlYl1UwLNtYu5kyk7CABjg+hzIqxKhirf90/AmCf0nUnWdEler/8E4QQfJ
         hlRbR93GHuILIsm49sGSiWTAKJ9KxMwwCzwiOzjED4xTbS2TCN2q221S7ZLOz+nUAvia
         9YNxSFYm9fCxIYy/Prpnj5Wm84vHI/cvsdMyV98iilEazXOfugHf4rg5uCrf1fCqBV96
         lg+fZZU0Ls1TZAtZ1amP7vP4t5XqtkqOKAa3I00ed1I29CbACFaot8XDyHokUxKeAUS/
         g8LkCorvKRLPtfTPMZgJODf5UgQORHjWgsAP/tWD/nmUQUNUlUtCXvRhtMM7n7x3pTli
         iQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752169881; x=1752774681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpaBoGbv3UwS2ctJ5MNrLd4WnRBIdXYjgTh8qQmsLHk=;
        b=qT7MNcgTfBAz5R1YevlexIvKWkjK6jvoqlIdCBuui/5vu1YHLnMoWE8w0usg9fevZM
         51h9dnl+QcSsxplrbgaQz6knuhOg8oKXx0xNrsME+B74S93+WsiTs2pfB3TJsp64jLwu
         ytqxAbtAXN9M6o7PfWrtmilCQIol65bLQ711z1SLG2EQhX56mqpE5luIpPQvp9L5+GAh
         F2ut7JIN3+7Omrw7zMGK836H6piZWeK/U6H3VMWJYEUPXpVH6rDHN0G0ftgxQ2kX4ZuV
         qQC6dr7fbkY1LuRVgSgzwKo0NHIcIXhR2LIcw8f9CydOSFIaQkusPnJ1H4L2Bdbsk5ac
         OACg==
X-Forwarded-Encrypted: i=1; AJvYcCXtashgFBrynJCioNIAR4bEF2FdATsK+a1e9i1c3AeKQUm+VY16k8suDsvh55e4+g2uYdMMMFN2vPJBstA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTiX/2dnz8NK64Ce/m0wPvExJXMg7zKIMoiXHyC5xBBNVUAr/S
	58DbjdhRjJYe+DYRaznuRzBGk6Tw4/ztZS1kbVWrQBM8omiED57SbiTldC+5Oz//aoc=
X-Gm-Gg: ASbGncspv+mgEqSGPZI90WJcaevhW9akfTH1hzFPLb1ALC6221qLMbSWxY37lhjuac8
	Co5I+V/DqxbF831zPFKLGxWhSq7iLoeQV0iXsJM3H2iaheL/gDgdWakJREpqE/Gd7MZIpGdLrwr
	HoPWbetTtoJkzN/AHa+viZokN8nvJEOwxBL3FCDHKZ8nqtBk3zWLEN66uJ9Wmrlz81xyVSzsLrJ
	usKhy8AlXMuyVPdtCjjGmsdUQ8xMHQWemilowpfrmUKwF0y+NsbxkZwK27XQGbErd7y5tNxDX60
	cgOFo9HLq+XN8rK5ZifkkT6DL58TDm1JHWHqi5zqcP0K0aBbztsBoUYVwaBdAN6oe1xrWA8phFT
	+ArEVCSoIev1QFnmdr3lw2pBj85IlMyWD1dI=
X-Google-Smtp-Source: AGHT+IHBaLoGy+mXI82bk9r9JVDCOAUDtCda2f1J3UcRVBL1tXN88/2gwPEvHSrFuX0VVuYTud0GuA==
X-Received: by 2002:ac8:4e07:0:b0:4a7:7b5c:90a5 with SMTP id d75a77b69052e-4a9fba23006mr2458881cf.7.1752169881236;
        Thu, 10 Jul 2025 10:51:21 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a9edeee300sm11165941cf.73.2025.07.10.10.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 10:51:20 -0700 (PDT)
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
	troymitchell988@gmail.com,
	guodong@riscstar.com,
	linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/8] riscv: dts: spacemit: define fixed regulators
Date: Thu, 10 Jul 2025 12:51:05 -0500
Message-ID: <20250710175107.1280221-8-elder@riscstar.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250710175107.1280221-1-elder@riscstar.com>
References: <20250710175107.1280221-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define the DC power input and the 4v power as fixed supplies in the
Banana Pi BPI-F3.

Signed-off-by: Alex Elder <elder@riscstar.com>
---
 .../boot/dts/spacemit/k1-bananapi-f3.dts      | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index 7c9f91c88e01a..a1c184b814262 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -28,6 +28,25 @@ led1 {
 			default-state = "on";
 		};
 	};
+
+	reg_dc_in: dc-in-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "dc_in_12v";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
+	reg_vcc_4v: vcc-4v {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_4v";
+		regulator-min-microvolt = <4000000>;
+		regulator-max-microvolt = <4000000>;
+		regulator-boot-on;
+		regulator-always-on;
+		vin-supply = <&reg_dc_in>;
+	};
 };
 
 &emmc {
-- 
2.45.2


