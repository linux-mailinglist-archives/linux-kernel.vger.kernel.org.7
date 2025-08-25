Return-Path: <linux-kernel+bounces-784113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FF6B336DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6A1179E10
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148D028B7CC;
	Mon, 25 Aug 2025 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b443QzjC"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00702286436;
	Mon, 25 Aug 2025 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756104809; cv=none; b=ti1sLGYQTXDyZl2Y9xf0lZQqluWDwB56fRzCiNBTTlHmtb9fP4bs99bazn1GwfRdCp2ksEzhKpZLVXAyflXAVQFSv6ESRD8HbOhz1XYwFPRzmTvFB5euDlfoS0H+fd+cKiUan8qEC2Sm/5TNQkDmJUXL4pt3HaBG8XdgaDcaKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756104809; c=relaxed/simple;
	bh=f52NCmaKJpTSvMq1cH5UtyGiBCLg/5dBzjjeQ3YQP6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndP2k7okwnx6OtrlwH9Dc+PN57N/lr8vS8NWhFKghXRLmdJvTWt51oJ7W2tMssFKCK+j+Czr3as7Z2Md3taWY9ZaAcot5fF0XbRO1/6AabRO1ULGEwE0q0b7UuEWzv5arpm7hpTWhp3VUjD1ExjF9cVwHfojDyoT862rguM4vY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b443QzjC; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77057266dacso896735b3a.2;
        Sun, 24 Aug 2025 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756104807; x=1756709607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xsp4A9QUDHrrntxTF4ehOQtpgTlQEXfE6cbGWIJiBdA=;
        b=b443QzjCOH2nZ3IZSkRFwjxX8RGJOziiQV7HDfDK6MhCuAbYn4Cfwn2mRnKbiXTQSH
         arqTk/EQ8FoNBaupPyJ+RYTBuBTQ8BI7kd9hga0sAGHFSqYX613c6w9IjnzyvnpxuF5x
         QFno2RYrmr4LUWRgq6095GwOvnvao9PaTofmR+AP5W5H8cxbFddRnuQjjX5B1TWZ9Wim
         xEnbup6oX1XciJO4X821DXLn4ZG0GDLdS+jH8GJjMFewYHPOpac6IsgLzddR83h+xsrw
         UpCA/mlBRSYuWchAALiXugpXlz85/cTJJUpgf/FmsfaLDxVQcLR4BmIdzOydS8GujDmP
         VNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756104807; x=1756709607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xsp4A9QUDHrrntxTF4ehOQtpgTlQEXfE6cbGWIJiBdA=;
        b=rypRm9TXh8TfOGt95+3KV7aPh0dZu0iznuOArspfbZYziaDufUt9yDcHN1PnoTWUnG
         ev75WYOne/5K/sq1cLeMNhtmjjYbtcC4PKNyPtW3xfhbn+xc5yyI7ZeiVemtgcB07E15
         uPaoxqEXGspCWjUChOK6fUmPp4HD6TQfTUe4Md/A5ATv60NZJhXsdJRkProQ00fUOOFf
         kukQhajnes4pq9eOuV6odx9rbo1mxFMTonkv7af1CFC3VBEWdV7HiBcXmNgj+UAQdxXw
         G17arKVWHzIeYyJ4HuKO9aAABd/a6PqBUBe3NtC8ZQ+TSpDT12mIEyGxO2lzWqN+ypdY
         rWqA==
X-Forwarded-Encrypted: i=1; AJvYcCV5/P31VhhUX9D3BEjpZsP1cDJHwlHIfMorN2G+Zmx71LJY5/2+xdAjkp66mr+TP83Nssc+KTuINNtEPgis@vger.kernel.org, AJvYcCVI1fHHEwcqGr3wC+zIC/yLEMF09MWBvChqyk5znHAp+eattUzYuQqDQ86Jq8LpyDvsUgoqhvOaPXYc@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNOyjg+MKbLrhNw4BVDu6ctb0ckA/wPIhjIO8MjcqFPyis6LC
	vCFnQdE6tUein7ydP8geTh41Km4/GMKKcTWZsKUW8CH25EC44tMmFXkcL4gnuA==
X-Gm-Gg: ASbGncvRfRjwUY1e3nMrVQWd/l4swuI3fX4K0s4VmwJNd2IltTGJymt+2tZhm6Q5bK2
	4nMv69TESRb5lkwAir3gUEF1VfTZez0cxj0IEYQxfTsdiFuSBOXi3/3Pv4jjMWMbcd+T6szXXAZ
	y6IIF8eQ4MUHqztcHsQUcumvY+BrWpFe9qS4r7yio5ir07a3ZXHOIKBy03MTj5CbN1uokp9s8jT
	98q9mQurSR0rl1B2jpJvr4hbaVzOncHTiyMbzsxHJg4AndBvPqQvdFFD/TfVXVifONnZda7t4A3
	KjjSTup972iJzN/cdOM5S68G6DYDZiOv9wAfue67jHED7r7MwVdQgR1y8MkVKVL6rjgRSE+wjSD
	Agh2iuGkM7H4m++SN2lJF
X-Google-Smtp-Source: AGHT+IFBMgVXT0rvRm5EwJGuNlbxSehRl6q7h630ldMnG+iKbmmnfCi3ZZ8Wk9ASWeGQSTen7EJPdA==
X-Received: by 2002:a05:6a00:2e95:b0:76b:d746:733a with SMTP id d2e1a72fcca58-7702fadbe8bmr13687132b3a.21.1756104807114;
        Sun, 24 Aug 2025 23:53:27 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.216])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ecc51sm6604072b3a.75.2025.08.24.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:53:26 -0700 (PDT)
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
Subject: [PATCH v2 05/11] arm64: dts: amlogic: Add cache information to the Amlogic GXM SoCS
Date: Mon, 25 Aug 2025 12:21:45 +0530
Message-ID: <20250825065240.22577-6-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825065240.22577-1-linux.amoon@gmail.com>
References: <20250825065240.22577-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per the GXM datasheet add missing cache information to the Amlogic GXM
SoC.

- Each Cortex-A53 core has 32KB of L1 instruction cache available and
	32KB of L1 data cache available.
- Along with 512KB Unified L2 cache.

Cache memory significantly reduces the time it takes for the CPU
to access data and instructions, leading to faster program execution
and overall system responsiveness.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi | 24 ++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
index 411cc312fc62..514c9bea6423 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm.dtsi
@@ -64,6 +64,12 @@ cpu4: cpu@100 {
 			reg = <0x0 0x100>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -75,6 +81,12 @@ cpu5: cpu@101 {
 			reg = <0x0 0x101>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -86,6 +98,12 @@ cpu6: cpu@102 {
 			reg = <0x0 0x102>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
@@ -97,6 +115,12 @@ cpu7: cpu@103 {
 			reg = <0x0 0x103>;
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
+			d-cache-line-size = <32>;
+			d-cache-size = <0x8000>;
+			d-cache-sets = <32>;
+			i-cache-line-size = <32>;
+			i-cache-size = <0x8000>;
+			i-cache-sets = <32>;
 			next-level-cache = <&l2>;
 			clocks = <&scpi_dvfs 1>;
 			#cooling-cells = <2>;
-- 
2.50.1


