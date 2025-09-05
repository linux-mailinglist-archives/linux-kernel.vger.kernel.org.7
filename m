Return-Path: <linux-kernel+bounces-802791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA686B4570A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62DEE1C85AD5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610D634AAEA;
	Fri,  5 Sep 2025 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyLnKIdS"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5796F34AAE1;
	Fri,  5 Sep 2025 11:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757073544; cv=none; b=Ej7AZRsWcAqoeDwjE1VAU5APLuQuX2t/NRamk8mUYOc+MQtobd0vRNujCr9sM9c4DDgLp+eJh/lorDP3xBX7PGA4mh2utfUXn3vLSLKz+YLjGANNdqM1rEl36RlPMca3CUORdQN7eDgOzWDh7KS+P5L0DnRedPhrIC9qEMTmgQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757073544; c=relaxed/simple;
	bh=NQ/hVS3sGAExc1klYdPwosGWoE0raJ69IgzikBZN8h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hu6ltMR8nY7pmDrarUNpewmIQoGAffVD4CBn88BntznK8Gf1yuO9cwQ9HBAS9b94/Kmtjx86yyHVuw8Uhuekm15JTnw0GNoOQaW9eGlZac2DPh1PXmuuwVIhFdFRsKE8QdmypA01b75vAap/5dVob3MehuzCDztrY6v5HKBfl04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyLnKIdS; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7722bcb989aso1538225b3a.1;
        Fri, 05 Sep 2025 04:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757073543; x=1757678343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRmno6/jb7y1yMs+Fv+Jcp+7fGHpf1owbaVkni4ePvo=;
        b=HyLnKIdSSB/5i1jht9qmFvD8DApxgPkhzUlSironjmNBwbysafFBMFT3UwQL/mAmEM
         B+8E1aPVfLpdf3IuLUyaEgd5xVyhcv/lYeBisQjV9ZKYpCdj1LJS/xZDdyVrR7MQzdzi
         eLpGvomejMTCUvGSvQt4N6WA8NM019VVaLr0EPPly3W42wh1bk9uBdFGZv+mYFVZ4m9V
         bXktIiSl7RPdUJUOtFWakIK9tFRD352ZdNPjeBQ6NHhr+A7LuRG2pyOdBIJ1lF/Bp0Lb
         ZuIQJu4n/KfMXKSSqKWtRm11NzWxkzwz0x6wlGbbIfeBz6qPQjzhfy01x2DdXTcT2YQ0
         aECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757073543; x=1757678343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRmno6/jb7y1yMs+Fv+Jcp+7fGHpf1owbaVkni4ePvo=;
        b=C4+5qFda69pkA6YaKXIJ5yIdXEbtszf/qR1mGDtp1cDm9s6OoE0PNc93ymeO5T5L0U
         Mzsl4cgy7t1dqsW6UWoBPIiEQ4ejgQBeWsYyYYWlwiz4xDk8Jq7icnR43511VCgfwY86
         4M7OGUpchwE6N3WuoGuUg7XwhpzKjnzHRzBV4yLUPK0xnA1LTPDtf4O9tLZjRZIwZSzC
         TH/SFV+otg5J0RLd129SXSm7T6Qz3IARhzaSoez82OM22OMF75MVIWHllk3ZoH20gVNi
         FuK1hJicU0N7oYhiP4IfrNjVf0ab/ydN6vz1Aow3qGg3lZ6VxpZ26pe2G+3C/1CEZMX0
         kKAA==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZOgzLcoILtkbQDQnvnLHZBmTon8/8N486IpbW/73vJnLquUaRLGSNvcTplFH7VCk4nhljkCwcx9+@vger.kernel.org, AJvYcCXWvBlcCSaTECkVWaVP4tx6NP/fqT3Z2f1F32datTDYt95okpR9HkOvsyLBhmOwxkLMEGejDvozMzxRyYip@vger.kernel.org
X-Gm-Message-State: AOJu0YzF78ycyTqLQ8iNdvsDicl2oLaD7BrAUKJThNWC17BWvWHo7fC1
	RZStRaUNIyjs7usMrRke4iC/7RKQ31YDGckThvuAluyCUARCjebHGY7D
X-Gm-Gg: ASbGncuXas5PEd5wAjIj5C/CIUxNwiArPXW/UoUZ1Ymf55VrA0IM8zBcfADkY5oguFZ
	WCUmMR+wZ0t39tEw+vm639L7S4/FDwohpAAi4QHyvJREUMzXB6CFF+SvRrOD60oOt61PPgDRtNr
	o2fnDpiC+nrTkdShS30UKczdNhyXEzIQUXrG5aMEB9sgTSvzcLKLY0Dl2zZ3dTj8KkSXV0j+u++
	neLYo4a/zJ2ftC9OzVvTIRJFumLw09+b60lZa5/NEZsKz8IClo+5tNWZkytRWDyn4FFilw5mSx2
	/JMIOAFndXEK1hnkFa7pfcy830vYYfD7iw55Sb9cY0SWsATXfAM7YnyIHS/LL3fLuGASR1r75v5
	PSYHZjXETL/tMtUyNIcE4
X-Google-Smtp-Source: AGHT+IEiohm+eHdVQaMGSyliuUO5OP29x4A4piOTh2C9lah+h3yWdGM9HdoexCNaigmM3tpKzwjQcQ==
X-Received: by 2002:a05:6a00:3e15:b0:76b:d869:43fd with SMTP id d2e1a72fcca58-7723e342f3bmr32270837b3a.18.1757073542600;
        Fri, 05 Sep 2025 04:59:02 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772396d2b97sm19633049b3a.67.2025.09.05.04.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 04:59:01 -0700 (PDT)
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
Subject: [PATCH v3 02/11] arm64: dts: amlogic: Add cache information to the Amlogic SM1 SoC
Date: Fri,  5 Sep 2025 17:27:33 +0530
Message-ID: <20250905115836.7549-3-linux.amoon@gmail.com>
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

As per S905X3 datasheet add missing cache information to the Amlogic
SM1 SoC. ARM Cortex-A55 CPU uses unified L3 cache instead of L2 cache.

- Each Cortex-A55 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 256KB Unified L2 cache.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-sm1.dtsi | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
index 966ebb19cc55f..e5db8ce940620 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1.dtsi
@@ -55,6 +55,12 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x0>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -64,6 +70,12 @@ cpu1: cpu@1 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x1>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -73,6 +85,12 @@ cpu2: cpu@2 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x2>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -82,6 +100,12 @@ cpu3: cpu@3 {
 			compatible = "arm,cortex-a55";
 			reg = <0x0 0x3>;
 			enable-method = "psci";
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			#cooling-cells = <2>;
 		};
@@ -90,6 +114,9 @@ l2: l2-cache0 {
 			compatible = "cache";
 			cache-level = <2>;
 			cache-unified;
+			cache-size = <0x40000>; /* L2. 256 KB */
+			cache-line-size = <64>;
+			cache-sets = <256>;
 		};
 	};
 
-- 
2.50.1


