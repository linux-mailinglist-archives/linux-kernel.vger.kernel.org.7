Return-Path: <linux-kernel+bounces-771841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EECB28C1B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 10:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09F515E10CC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4C4241674;
	Sat, 16 Aug 2025 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MT9iPRb4"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C2523BD1F;
	Sat, 16 Aug 2025 08:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755334112; cv=none; b=J49qPiH8GF7KmSBNpaIP6Rcp1lH/sTvB6LUhTMRzTmh7qZ9uRPNhDzC1zNZ385ULj3AnU6uDl3IlMew1jxPxQJHzcyTU3P+BIJErw+MWS4b7QRj4ZRmKEHqQ2TMmhwypoEuSV7SW2AocPxVL5BLJQZro4WNK6B1lBxciK7vAudU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755334112; c=relaxed/simple;
	bh=pzJn+y3ubulKFb+XrVV1kazkT/PrWOp3C67NiveIlbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbzXHyONCc/JMzxhtYJnmoVQAPj+EHrk8tGO0XgK5WzcS3yOfq73Om+mOFXp1QmqyWw4IuEezPYlWQ1zAmjk04AWuL/llNJ/X5fgCJ1fGvMCzrGCisiBks1zNG3bSi6ntwTOvlb0wwRjAGA4XjBbfvolnzWlZyGRLsDS/Um95XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MT9iPRb4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-24456ce0b96so27931945ad.0;
        Sat, 16 Aug 2025 01:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755334110; x=1755938910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EDWOGAR/V8qhS+DEW6fYz84GWwsYflwCKKabdx3FCTA=;
        b=MT9iPRb4MTVlilz8OBLQPWFETPRKHCX92LU74iWv0i9llQxIv/i9MFoTnzhv/hbm5S
         cbjFsGGMQLnilBLbTiVjFy+XSkB0ib18Yzp49xjl44TNJQKT5B7DnDf5aQ0biPXlV3MC
         qOLo36Su0eB5LLn/B1ithBxSBHCloBoYuIiLvHEgGZm6Tua6nUxjN7cMPUK+Sy5IBaeh
         t0GoCBbZSKaa2NseEVmk5F/CVt2BCjNsqxSpq+JVxJ7Lhbrl6PodLnYVOslnD6RqLsuw
         C61LoYQvHNCMGiKD+IioYqgVJE8VxbG20Av3GhIb7q6xwCaRwoUuvMRgHq6d6L49PkLw
         KwYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755334110; x=1755938910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDWOGAR/V8qhS+DEW6fYz84GWwsYflwCKKabdx3FCTA=;
        b=UczeaTa4x+zsG6MEa3HSf23JXKo/2b5SKA0T32cOoyk9h9/gjQrq09rI69Wek8IwQF
         wwxECYG/+zfVhmFhiuzMVpJlCLTKi4ZZE0W8xiSlCHWHHy/ccxVu69bryOOQqUNBPO9R
         KZn4jCUzLiMak5u9w2fLYhu5zzDBwn4/N7PEuSOhMU+ocEjFW6Z8qqMpOPvvXOAHYITy
         Dj8FabUm4RU0YqkXy/mtte+BoZTTNDmKGbfX1CTi0pr49TQS+X59jbpVTaDUjdD+39DJ
         iUUMGFy8y9FQJbHhEo3hb3E35KO3NQ7x0DSCTBgwM7bbkHC/ShA8S56f8/W8ffupRGdR
         fpiA==
X-Forwarded-Encrypted: i=1; AJvYcCX5wDFDhMvWb7gdfkRNfL5uRuQymiMdaq0wYFotd0yVlJ/9O9QqHq/991GrfBlTEEUK+i2ncVBH7oicVcDO@vger.kernel.org, AJvYcCXx7zBtxNbzNFQW92A4vhRe/HtVa3Umkb1qhVbiBTRSMCOfxdb70FFIDRMoYEj/YKnAIYIZ7acN0PA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+OW374aWBPkWaZ+xgDVXRqqJbMwmBd5uuoYIj+Q/S2DgKwx1s
	vatJXS/QTBKNp1EDq1QTBv4OWLFPxkZzeitNvdqHpywKCO1z5S9kjiH0
X-Gm-Gg: ASbGncvYzf4gZcAVqrTrQTICL6Y0kCujOQ5lR1Vbq6aghfAHbqwccLq4bM5Nsz1kkGj
	bQlynbvjhoUwxucjuf/D9RlUBNrw++emNUkpv6UPEjvlR/Q2GBa+jFWALr2Jsj2QFdvgeSK89fi
	VdthDHbyz0MSPt6RUprfZZ64yXcOoYfF5/RMmOIZbcRGuyUMJT9OaDHbUFNfOTIUfAiZQ11Z87b
	bjvnGbbt7pFUjufopdJzLhtCNQq7MK22IcRNX/rVfDSjYHwo3QVWqAzoH55D5S8tbp6+kvi+6lU
	zgTpCV+q7YMiVqLylmDhHQldGNRzwq+7Uu7vXIKmYpEk44pTNQQjamxmxWXEorJc2ZRWGdSx7bA
	G1+GFrru7aYs=
X-Google-Smtp-Source: AGHT+IGsQHajlRxkkJKhsBN5q8Xue9SzeHzYvWpvVEasktK/+7UqcjxhnXytQgxkbXL5divXvBb2fw==
X-Received: by 2002:a17:902:d50b:b0:242:b138:8110 with SMTP id d9443c01a7336-244598679d7mr146468085ad.24.1755334110487;
        Sat, 16 Aug 2025 01:48:30 -0700 (PDT)
Received: from junAIR ([212.192.12.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm31048215ad.157.2025.08.16.01.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 01:48:30 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Andre Przywara <andre.przywara@arm.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org,
	linux-sunxi@lists.linux.dev
Subject: [PATCH 7/7] arm64: dts: allwinner: a523: activate USB3 for all boards
Date: Sat, 16 Aug 2025 16:47:00 +0800
Message-ID: <20250816084700.569524-8-iuncuim@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250816084700.569524-1-iuncuim@gmail.com>
References: <20250816084700.569524-1-iuncuim@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

Currently, these devices have a USB 3.0 port. Therefore, we can activate
it.

Signed-off-by: Mikhail Kalashnikov <iuncuim@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts | 8 ++++++++
 arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts  | 8 ++++++++
 arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
index 553ad774e..6842f8e8d 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-a527-cubie-a5e.dts
@@ -47,6 +47,14 @@ reg_usb_vbus: vbus {
 	};
 };
 
+&combophy {
+	status = "okay";
+};
+
+&dwc3 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
index a96927fbd..19388bc11 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-h728-x96qpro+.dts
@@ -46,6 +46,14 @@ reg_vcc3v3: vcc3v3 {
 	};
 };
 
+&combophy {
+	status = "okay";
+};
+
+&dwc3 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
index b9eeb6753..6f05cd297 100644
--- a/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun55i-t527-avaota-a1.dts
@@ -57,6 +57,14 @@ reg_usb_vbus: vbus {
 	};
 };
 
+&combophy {
+	status = "okay";
+};
+
+&dwc3 {
+	status = "okay";
+};
+
 &ehci0 {
 	status = "okay";
 };
-- 
2.50.1


