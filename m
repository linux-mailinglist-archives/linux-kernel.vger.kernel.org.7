Return-Path: <linux-kernel+bounces-785286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD80BB34891
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7971B20BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA59302779;
	Mon, 25 Aug 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="EHkqQjkm"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F3307AE8
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 17:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756142478; cv=none; b=Mu7hwQ4IOEgEw9tEwjq6+AVKvF+KP1qJzIVY9Ko2oSPM/FPlZdb7JMaYKqn0gEeFfIjR/yYdYdSv303xScUqvzCia7tOh33sPu68uj8XbO34HXt6hDnLOJlv9mUmzm+FMWhnchdY2ozoP5ujcRBJL0/STms3RndHpmfNssMD9bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756142478; c=relaxed/simple;
	bh=D00Agu9o5lMwHglRF8JEmN9Mz2SwGM8gIpQ2brQAJHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvr2FoMSQKV8XRuCKXtwU2Ll42EB0nFUNZRQt5eUZkFYFjJv9lpdNjuPm9e+yy0f4NequFhE6C2hZySZRZGhT6R1SCP9IrGd4BsHg5iXTMiNOT1v5+3X1uXy2NzvTcG1OGeuTYD0HXF1R+323hcQDYnVwXCepN/Yb6yauMkw3/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=EHkqQjkm; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-88432d932d6so55264439f.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1756142475; x=1756747275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmHcfUIrXFFWAxyqlPf+YQqXo4C+Q0QbA66Hg5xFlzs=;
        b=EHkqQjkmXHu8VAQtdYG8cdjzazIyFYR6KVsULolaId2YSJb8tec/DZ6WAMe5Yv9hmj
         B3oEm1VKK/Tfk4ZS1ycwWT4jJutHBsgHPkusAFl7oDkJ5jAh4fCAAtNl8U3wAq/qAGiZ
         bR4tohcCEaC7zBiCd0p+HGeVmmpgOobMmVN7XnB7ANGMhrS0lJ69c7Ep7dl72G0yvfwc
         QPjkpeedfzoObWjwUewS15eGBPtFFWWUTcBTZnXsxdflFBswU/Ddm1E2uAZumVpY9fMC
         e290i9mzQjWOh6rbPBwkgyjXTjqbtj/Fw+3p77BW87k/BxX/ofv4Mi3XmKlmA3OesvF5
         BNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756142475; x=1756747275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmHcfUIrXFFWAxyqlPf+YQqXo4C+Q0QbA66Hg5xFlzs=;
        b=worhshlH/YJmaRAbTBhGRlpydf7UgDOYbH2jXW7k0n7npNuIrYMSMaIn3J/QTgiC+7
         hsW8/k6SzfBfkpEAqZilgkhxTyRRj/V1NEhDYFZZlbLyEa+ek7uij6ayH4f9/5oGP5uG
         cQRXuZ5YLzyYR/ZnfHaKrMjsqHmUw4yQflB26Z7O/PcXdbyBdpi6REeMKX8YRphgrx+q
         IvP8h1RoEUKtDPt76RzAKpOH4hVGAo1Cnyt6pacoYKQpac/zMYYJTYAagPy0BrHhfkZm
         D0+hDazuSHMY750rp6pxsFozuv8cTeAvnXBJPv/TKKKqFvWYgspbGhhiL6CWk6RBuuLc
         +uHA==
X-Forwarded-Encrypted: i=1; AJvYcCV0Xgmcj2m0N483Du/2cqYIJxuv8+VX6wk0AP4Ay+47Xe3ETAKqq0QSedF6qfnb67+7W++RE1ihMKgvVos=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU90qyTnteJvOSkBDXoN4jYNxVS2tx2Jbs6CA2hj9cm0b3Ow/o
	HoXrU0U2DWT15CzePMcwgJEABAOCHRX1Bvg8v6wryQPmPYnpNgQK3MiGnI1XhpTWjlw=
X-Gm-Gg: ASbGncsm+DHYclgu2pmzgE0MxvSutdMt2ccg/HwRNlb6dhB37pZwE5HVhzPD9FRricV
	zO/RUEEUrzBsbhH1PAgGNfnm0ot9MYbLFAFcJ5NrkrjaAtkq0k+i+auD2K+0MGcCrTEuzjf8en4
	jDUrVxiEGpfXm7eUYMQ9lmXodlYbyMlRRAgkt3paF7qylaQGyUbgX8Ylv+dCK10QSq7+Oa7fgjb
	Fj0j3xQxdpdLFUCD7JvyQvzpbRN3w3LOfooqDWeHM1VHKf2i2OAL4TOpRIWp/XQjWCWbrLQ5jtz
	n6VcL9/7ipx8DMwXJFql02URjIU/xhf0HwFqvjOqYs0LvBz2nmD+B/C0GSCVo/a5zxmC62eSVWl
	vNJKZ05Sr4Qib3n0c3bDW0cYFy/TICHS03TXXaCEyd5BRp6X+5IHWlTnSSMbmpDbSHA==
X-Google-Smtp-Source: AGHT+IFaVPmcRIepO8mSzmP9PzGXjZwSc4TayWxRM79v7g/HByE5zJt50D0eHv9Uu2pV8a3THcTTMA==
X-Received: by 2002:a05:6602:3a84:b0:881:6cf9:b8df with SMTP id ca18e2360f4ac-886bd1baf78mr1747744339f.10.1756142475231;
        Mon, 25 Aug 2025 10:21:15 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-886e60c4737sm76275439f.26.2025.08.25.10.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 10:21:15 -0700 (PDT)
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
Subject: [PATCH v13 7/7] riscv: dts: spacemit: define regulator constraints
Date: Mon, 25 Aug 2025 12:20:56 -0500
Message-ID: <20250825172057.163883-8-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250825172057.163883-1-elder@riscstar.com>
References: <20250825172057.163883-1-elder@riscstar.com>
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
index a11a60b9f369b..a9a2596a94e89 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -68,6 +68,110 @@ pmic@41 {
 		compatible = "spacemit,p1";
 		reg = <0x41>;
 		interrupts = <64>;
+		vin-supply = <&reg_vcc_4v>;
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
2.48.1


