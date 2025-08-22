Return-Path: <linux-kernel+bounces-782008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C7E3B319CB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:39:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA1718830C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449A930748B;
	Fri, 22 Aug 2025 13:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="snnjKL2h"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D73009D1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869618; cv=none; b=XER5i4m4BnehjfXmuUYlNyHco7TZxwAl2/qQ4+TLTIPWUhFAuCAp9Ont9lx6bT6axBQm1C/1Em9qcC5NOkjE+c8+wnYFsv+yu0ZxcdK/sYXUnBp/cOAs5oqYnPXWygmq0MNYObLulUT1oR1NZg3tz3XTDDP3p0Vs9UjMeRUkDl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869618; c=relaxed/simple;
	bh=dtID5g8DJtSmQ3vJl5ZBxIlLQ2hkiY+HtiOqkvEqEts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kk6pYpgCcxzsrPtFVpap0QZyz0BLzYbk5YmPjwtVHdPEEhm7VYc0sxxHctZWD6wuU4CMzt9vHHCcEO8jJtwL10xMlu1bNqNS7OtDpdGR6PcW0m9oSWErJOjdNe7YP1/5HlCLo6qFv4YDVdbiOmWKJyv/zYtp+XuIyowy+/VgkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=snnjKL2h; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61a54560c1fso294610a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869615; x=1756474415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYJ3Waol90DxIJJuBJ0Cdr1sRkDiR+1RilwvhBCpH8A=;
        b=snnjKL2h7ABhvkPkG8ztW3oyFVJOq5sguAwmwuOQlwjpzgAChoMdSED5azmj8XAcT1
         nHkFrFyW930DbXmfYce9Qwo71umnZGPzoIW+e2YJP2279ry/Y4Cex0AS4ohC2mnHy/nx
         eTcv+bQxliaOkDjV1tA7KNMzXCug0c3m2wiTOzP84L16u2OM4Khxvfu8rJgJpRqWsEiN
         g52DL5Aa1uLooo1Q3b4e0fssnjRqTwWssFiVP5m0m/9rYTLLY6a6St4Xb+07aIWZeJCi
         QGgN1UuGDbUF9P81u0oqIKCvjSegpVBJ9FGyVE5WKfUiqrHwYKciCyoiGJvziJWodgNz
         R5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869615; x=1756474415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IYJ3Waol90DxIJJuBJ0Cdr1sRkDiR+1RilwvhBCpH8A=;
        b=hHfmyb24zc63NNJuNgUZYvjftbEc6qa/g0221Gkpg76/rxB/ANOJp2hAc2IbYV7mHr
         oGRjcMx62kxRf6QC1Bg3kSElFjlK8QaPm5b04W8RSSkOlukKkhKRWTHiYzfCqrM+t5du
         agRKb2hc8kyPSm8XERgo7ln9kLhXXNULOUSUh92sqIAd3xH2lQ8B7Y1G2PKpV8odHPu2
         e7w5KVtk9fL6Ou4Nx5x4vOBsz1veGmZftxhJZS9P40zXatHRE6jgN8UVhRi0t6LQLj2f
         sIvwj9J23hqsBRFNlA5bhGSQOzs9kFx7WvJ6EcmJITQ3Ec1Ay5FP2QiH60acQjZMNHqf
         OKqA==
X-Forwarded-Encrypted: i=1; AJvYcCXQVDnr77BKT3Kq4wCSuJU0zz/y8UlGD0giz0Svt5IMa1DWjkHf9SqmobSdxt3NSaiJRq32LX/yQA9mmkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxICrQQ1YgRE9EnbuC7hdEes/prVMqL6rGIirkxSL6ZORtXFVXc
	8Wn+xoGavhusZDCsPP9s0SNYPqnFUK0c5TE7qNC04gDoZ+FGVyc3ZS+XZ6aJkEeXqlI=
X-Gm-Gg: ASbGncs9M7D54y7lHvfOPE2YxuY7X9C83uzhA/VXY0pyV4MJ1VnCcOLhTnB0KkGXrqg
	lDaHCO7M1vgl4E7mTvGErXvTnftJQPLze732s/GnOoUrD/1fmNipQyCTnBLE7pfzePNRO5+rYWo
	jiqAa8CMPCt4YDmqeqNAfXCEGvrxT7a0OL+9aXL5sdU0Xrpv79dKaG4j5uvbB0FuLBHALVtNP9e
	uKSFScZnU/DnVyBQyuJAa1AilLE43KW4+Ln6iSmjFFwzCoIkPBAzcY5N/PlUv8GUS/lx+ZZFF/9
	qQRGeIOK+tQyu3XEIbWL0MEb8FLesibwqZ4VhFsov616kre3XlHtgrugehrnsdwTcQfhPhru808
	vyXvrAlt8ofhnQg9wje62BZdIep5kebJ6zUpvBApaGfL+
X-Google-Smtp-Source: AGHT+IEDljXQJso1O+dt/12kndTs/eRYZO+jTymQLY2/8T5kyJtnHBEBf/E3oIyet20GFVSY0iZuHw==
X-Received: by 2002:a05:6402:234b:b0:618:1835:faa4 with SMTP id 4fb4d7f45d1cf-61c1b4d0198mr1621928a12.3.1755869615455;
        Fri, 22 Aug 2025 06:33:35 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bc305sm599477566b.18.2025.08.22.06.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/2] arm64: dts: marvell: armada-cp11x: Add default ICU address cells
Date: Fri, 22 Aug 2025 15:33:31 +0200
Message-ID: <20250822133329.312326-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250822133329.312326-3-krzysztof.kozlowski@linaro.org>
References: <20250822133329.312326-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1388; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=dtID5g8DJtSmQ3vJl5ZBxIlLQ2hkiY+HtiOqkvEqEts=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHGqLJ9+bOCak+ZL88H6M5j8mYmsduALpOpAp
 pZT4h2zS2KJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxqgAKCRDBN2bmhouD
 1wqSD/9JH9wq5MUh1vmWps3nd7umQISUTcAEpBTG5mGLu5zCK0ee3/brMUx/K1Gh1twJg5d1GGr
 i6MBwSn7u9U9fmeX41RXZm7QufPAISvPMcObjlZxtaH9GYlImGchPgCRpRCcuNAL0N6sigVvpAe
 UbEqLCBlJ0gymCMI/DnsrCr1pf2Cnp1Ib45ZTQiNKByrEmlOVu+bYQBOf6jdXqAArrTbMwePAN7
 TBMz6u/HTTKmEEHi4YNlNipYXDND/ebgzIX4IOWM/L8skFZtn68mngdgKoJwSwbfhlSbsVNG7zm
 7RX43L2Wd6J9coVVeOZALrhErv3/cxMkPkmIg5f5xCRh7nwAD149gCbj8J8uhMOvl+W0/zrgsuM
 +LHkAeZBharDSCqbDN7DXWrt/wGDLWJLRQ9vk9QgyrMiI8uVLj/rPq8QSJ9uEC6g9soEMOAL9zJ
 PAy9BHLuKTERj7B4vfeLwW72igV+0GBTTMpDEAGxipMejOuBfFBCNJV87yPjrSZD1RKunofBvkq
 PqfiBV8lNPT5mQH3BfYQ4KIP0CoXWUeoP6fiSa72x8swEws+naUMAj5mr8vURXqblMMmpbhv+yP
 V+09dmphvNC/ZpJVejg63DSjnnvjV3jM1SakqT2m5N2HARhhaYpgO1lJ7ue39v/77KE3kBdbr8K iC7rdJrkptN/aPw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to the ICU interrupt node to silence W=1
warning:

  armada-cp11x.dtsi:547.3-47: Warning (interrupt_map): /cp0-bus/pcie@f2600000:interrupt-map:
    Missing property '#address-cells' in node /cp0-bus/bus@f2000000/interrupt-controller@1e0000/interrupt-controller@10, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index a057e119492f..d9d409eac259 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -202,6 +202,7 @@ CP11X_LABEL(icu): interrupt-controller@1e0000 {
 			CP11X_LABEL(icu_nsr): interrupt-controller@10 {
 				compatible = "marvell,cp110-icu-nsr";
 				reg = <0x10 0x20>;
+				#address-cells = <0>;
 				#interrupt-cells = <2>;
 				interrupt-controller;
 				msi-parent = <&gicp>;
-- 
2.48.1


