Return-Path: <linux-kernel+bounces-820465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E55B7E85E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 391D9188CB82
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 10:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BF88369340;
	Wed, 17 Sep 2025 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RClB7qvA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F84336933D
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758104322; cv=none; b=m5fN7KgSp+qc99sot9nZV8HLVZtADQizbq//bScSAOY1huhRIaP+0aYiJrVagPiqHKe+efk2tWtbUkJDEYyO8d6we8EEm1qOd3hjZYLsxLfa8SA8kT400XQg2o9gD+L3QUGDgH6wGDJOiD0vPz7wxD7w7EIAsmkXnr01xwN7FIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758104322; c=relaxed/simple;
	bh=Y2b2qy3Nyf3GyD7Iwe5SpDRWOQK+1d0IaIkWEZxaouM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G8jBZo6P6GxfVze0klcn95n83mlr+u9YyUaSoaFpbvUsUBSP9RAochlXy/EFGZhUmeDonHfL2hUiF69sBMbe5ZAHo6gfVFHFrVkYAwlcRC7U4botBeKU1XzBGPgmvKSFS1sj3sNc4SDJOrwGeEuF+bOmfUi+OB26UC8Pv27TuY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RClB7qvA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-25669596955so66807545ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758104320; x=1758709120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3lwBMTCg1xkGzoFZzilNGQBuvChETr/ISTszxUGZzo=;
        b=RClB7qvAhmyZVQo+9RgLBkPqUatYuLHTWtQQ7jLwNLfizQ+Q6ZZ1UBKOYveMZHwNL4
         pfsNKvf4LFYcual9xZxTxVni3hZ+CKZKFW+34TJfl8Ki7HAnGkCnBE1Mnu8mlej+oB/7
         PjxnjJCxR9fxcTcq6GVsQAh5fZR1uK+qBm624NnAjR9JgRhZ3w4tvv+SNQhCuueWoSIM
         CipNZEW9K0T3Vqj+uth/ikqL/rRXx3t/KloTxiaR/CEjMa1mLgkc8OLqj+6RJjAE/BBV
         Fa+GbMsk9ShmjrlwPtIEOLRqSWB2exGGFTssOIQNJGND8jEeObSVvHZcxDLWSK6kTe4n
         FXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758104320; x=1758709120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3lwBMTCg1xkGzoFZzilNGQBuvChETr/ISTszxUGZzo=;
        b=aqG8M0JLR10JgYNAM1ZSbaA23sc8n0G1mky8lUpE8CgB5fF/iuo3oX7PyPYnC9golm
         nUFP/f7jXMVbHib6JDC+xSglzP1IsG+yvhH3Q8S7IRhOExPrAnJEXWmuyIcxwSWfm+su
         w/ar7MT0pYn6MtT4Xhq0s9opbUb+LZBVT3gSQkgPfgDc3a4gGLa8gGfAe9MhXK7rv4H4
         O3TC3AlpDutAukCkMs9v/h0QSf4fqRcOwpfgcWN0CuF2NBEErtNIMXTkbuaAitpC0uow
         t86fp3b+QXIGBDG80zZQbY86k3OaNT8UIxXazqwDminlGawT4HkIvluO3fSQkBFLYjeO
         XfHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzkEf2AGt2SOVEbhByqSXW2cub1sgTIHuLmuVjlGyZo2WfaJG+vx8O5gphE7WmXNz9nn8o474KWMiGiNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqG6FncYNSl5l4n+YrIOtmoNiseO0Q+rl4Edt6mHa9NSF2X5LW
	Ot0YOoClb8gC/25nhNwkVT9WHzCPeX2vUlT88dbXB8LZVYgQP6AO2pUD
X-Gm-Gg: ASbGncuH6tMKe3VckNRcbcpRbIpk+pkucNrUJJ2IWEMRuGrmnmzne4TRW2SFm8DvRA9
	9LE7dNI/p/3ySHBZ1ZS0PvzSeSaHxg+822mn0ZZq4k2kxPZqbKd27MsNlLE0s7fWliP7y7+eFM9
	mZfRcLYg1MbnBjgZiwzG5efX0yuE/ymqJGTJiXarZqYvNCRbC4iFjiPMZ0uaxdna4xVX8twKTr2
	5IUbMl8Jm92Zysg5abKQMgG4QfpNbRTMMJI6CIeNh2t+QBzQwvH6jtdGKS2K8ZNfUwDRpEedrUS
	5pDBOjLH2vibn0m/enVvFcuTjMkoTEkz8r+/mNK88XTGBj6qvvn/HG7CeeLOg6TOzYVatQSgYq6
	JGPGcFqoigDENenmnv0xlyWNhNw3lkF5e9tVvgoG98385/14xyAL2dAG6jsr8tNH00Em7xoJN5C
	HQMfLHbaKzMz4++rEAObCfQqlioY/mcZF4IVa/
X-Google-Smtp-Source: AGHT+IFpwu5XMkJV8ZMehKfE4Wk0PNKKgC3/i2DNW5XrT0jCQFnppvNab6Czf66Re5ST81k11mqhQg==
X-Received: by 2002:a17:903:11cf:b0:24d:f9f:de8f with SMTP id d9443c01a7336-2681216b692mr25942835ad.17.1758104320167;
        Wed, 17 Sep 2025 03:18:40 -0700 (PDT)
Received: from eric-eric0420.dhcpserver.bu9bmc.local (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-267f4d286aesm28588755ad.63.2025.09.17.03.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 03:18:39 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: peteryin.openbmc@gmail.com
Subject: [PATCH v1 3/4] ARM: dts: aspeed: harma: add sq52206 power monitor device
Date: Wed, 17 Sep 2025 18:18:24 +0800
Message-ID: <20250917101828.2589069-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the SQ52206 power monitor device and reorder the sequence.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-harma.dts  | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index bcef91e6eb54..fe72d47a7632 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -353,14 +353,15 @@ eeprom@52 {
 		reg = <0x52>;
 	};
 
-	power-monitor@69 {
-		compatible = "pmbus";
-		reg = <0x69>;
+	power-monitor@40 {
+		compatible = "infineon,xdp710";
+		reg = <0x40>;
 	};
 
-	temperature-sensor@49 {
-		compatible = "ti,tmp75";
-		reg = <0x49>;
+	power-monitor@41 {
+		compatible = "silergy,sq52206";
+		reg = <0x41>;
+		shunt-resistor = <500>;
 	};
 
 	power-monitor@44 {
@@ -369,16 +370,21 @@ power-monitor@44 {
 		shunt-resistor-micro-ohms = <250>;
 	};
 
-	power-monitor@40 {
-		compatible = "infineon,xdp710";
-		reg = <0x40>;
-	};
-
 	power-monitor@45 {
 		compatible = "ti,ina238";
 		reg = <0x45>;
 		shunt-resistor = <500>;
 	};
+
+	power-monitor@69 {
+		compatible = "pmbus";
+		reg = <0x69>;
+	};
+
+	temperature-sensor@49 {
+		compatible = "ti,tmp75";
+		reg = <0x49>;
+	};
 };
 
 &i2c5 {
-- 
2.43.0


