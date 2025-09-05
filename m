Return-Path: <linux-kernel+bounces-802790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7605B45708
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DDAA5C2E66
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0348234A333;
	Fri,  5 Sep 2025 11:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FAasRk8C"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDF927AC3D;
	Fri,  5 Sep 2025 11:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073537; cv=none; b=l7NwHOmVX0ac0JGAKyKAvOuVcc23/dfiv0VLjaopp7XylmMz33/hYPyIQTEPaynrSxBlxgNU8IZ/2kOsH1BW3A7cH6JafjrCYKCikhcxQ540ESBH0rVra6v+MG3tD0Vcsoc0gY0p52RdNlSu14PWlvvQJgJBDkCg5H5kPESJ0kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073537; c=relaxed/simple;
	bh=fA59lbn3Wcf/Kz2Zc1km/aOMFJVeyiVAB1CRUs85XYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fk0BF2oVoq0YYkn+wVWcizpgZtfqyW6pxqvh4OO9tBF81gV0ZcDH9smIk22iJI7EVe7vMRLMIPPhM+oji6lu3kdqSbZSMC/0bbXt3PlQD0ElS3q+v7M4tERmU/3aiBuToSl148iKJ/9kGUHZ0bsbV9lgb50674GMfaaQw79fBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FAasRk8C; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-323267b98a4so1886528a91.1;
        Fri, 05 Sep 2025 04:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073535; x=1757678335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rgEmhMGkA/7C6rJUz3eu6sKsMgEBOX6IsF8XiLjkFes=;
        b=FAasRk8CegRotLbrmRiP+ALsRmEBD7tYTashT0eeRWTpX4Ix9tDRwrcg2brX9Z8f5/
         E5EnvWyiO6reIm5JC5L29LfNo1DMg/krYBjBnOM0Pelkf/k/8+8m4VHzG/FQx8abdjai
         LothDBH24UCbZySQY9SgGR5jS2tasXR9w88o4k7+j7VnHzM1ohCh+95hB6UtJmY5eWC/
         BQybJh5VQK9yMOfp5K4Hz4QJyxAWQZQLFY6LghB92AG+rDLe7ofL3JVToctzs5Hd72E9
         gozcjymfK9h9TcdASunktcB4FTLg1DtTsGGQrcaqB8GAJKufS2HoSO8BWpxw43pNe2KS
         jpIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073535; x=1757678335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rgEmhMGkA/7C6rJUz3eu6sKsMgEBOX6IsF8XiLjkFes=;
        b=eFGmgUsxV6g0tfiXn4gf6GotY48oB42o8HZqip3SGxic2qpGXIDErckiZSv0MDnsjK
         qze9DLlW2PUHdFv+Guh17dOGBWJX/Fx58nH7NcdbPwsqmHTVHXa8BUvGq45bh+7Bnyrf
         xRzuT23o1yHyDZalKZDOeYiWx6pPj6jihoV3B6cNJY9ghrCUpdx6ZI4UCkrETJHul8yw
         tOHNcjCsvsP58RCzvL5ZStl9qjcVh0Km478QywxTyYzOPoXxJmwe3P/g/RXATjRRws4J
         zDy378SfSq70WF0QuvB0AYnYnwYXFA5iAQSYUFsvMluDbF5d/iJnrX0ZHypa1fx1KK+i
         sDzw==
X-Forwarded-Encrypted: i=1; AJvYcCULEFGvkHL+yQwsLqQSXsM2dJS+fFeLTijSXoQufLHFBtqRezb0l1l0NzJtRrYQDcJV5HZ2VsFWWThe@vger.kernel.org, AJvYcCV42WGJVENycVB7Sli2xELU0Yh9e88F1lOvV3wSmVFxKoIJsaqyEkq8gzpUVKlZL5OuCML3mkHpQUU5Vdyd@vger.kernel.org
X-Gm-Message-State: AOJu0YyfbqmNOd93dkSImSuyn4Wvct0Kha/kPsWALv1gnK9SpJiXQ5y5
	LWgL3+Q+X0+Tj4wSj+qJlw7Z7RZMUxEt2ccQ/QXKkmr+PozlBZdyNamd
X-Gm-Gg: ASbGncsX7Ie8olap+ZBu/6rKvU8FBdOq07pt4O5gxr2Xn/7wX2SRTODqIO+HuvndiCm
	yzVj/4Mc3PIN3TRqWJh8wkAgZZv4DYgK8gnRLPWZy+YUyyqK/97thl3+jkC0YiX4X5cbz0uSMfF
	XdL+IjAQy5UlEGJmYWbeGciDUo7kxy2IXTHtxVBZG4Vu5ozFUMMSmtAi4MhKP3cl26yF+J329c3
	mIbq4ln8Y2vIROamaSx3tXGHQcwyduR2RQQrnZawCqkA6rM/kLINyG9DfzQmKL7ZSgP1dv7/GY2
	yXnWTbow+DienavqGYtSv+zUFP2ha5adCMJiPQ4iFvejENPqrxzFTvbyqmHr8aDv3LrORO6H8De
	ua20GDEg7Jb8hPvuZeSSdjiV4zXgg2dc=
X-Google-Smtp-Source: AGHT+IHvSCvKNcr+1RiDaOoEYTS3Fy1NmwNtqF7b9X0oKCKnUTrgEvbzTuDDOwMkAwbrhYYeFjqG/Q==
X-Received: by 2002:a17:90b:5305:b0:32b:a32b:a163 with SMTP id 98e67ed59e1d1-32ba32ba476mr5438345a91.36.1757073535045;
        Fri, 05 Sep 2025 04:58:55 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:58:54 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC support),
	linux-amlogic@lists.infradead.org (open list:ARM/Amlogic Meson SoC support),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v3 01/11] arm64: dts: amlogic: Add cache information to the Amlogic GXBB and GXL SoC
Date: Fri,  5 Sep 2025 17:27:32 +0530
Message-ID: <20250905115836.7549-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905115836.7549-1-linux.amoon@gmail.com>
References: <20250905115836.7549-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per S905 and S905X datasheet add missing cache information to
the Amlogic GXBB and GXL SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi | 27 +++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index 7d99ca44e660c..c1d8e81d95cb9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -95,6 +95,12 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -105,6 +111,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -115,6 +127,12 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -125,6 +143,12 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a53";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 0>;
 			#cooling-cells = <2>;
@@ -134,6 +158,9 @@ l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x80000>; /* L2. 512 KB */
+			cache-line-size = <64>;
+			cache-sets = <512>;
 		};
 	};
 
-- 
2.50.1


