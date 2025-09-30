Return-Path: <linux-kernel+bounces-837011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 969E0BAB16B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 04:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0971B1924A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 02:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831D713777E;
	Tue, 30 Sep 2025 02:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EAebmBUt"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4E7126C03
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759200577; cv=none; b=od5dedr/BCiDJWQ0uUcnbTvr4mLLq24zlaVQZwPrtsTXSonnoUA+la2PQFe25mS2weXS5hjRb4FaFpMovn86h5jr/bI274E4aaco9bS4/NqEPrnwe/nbdo59moJg9lSLW0AdkoHb8PwIYJitelRSFYG0gBjTQa53Z9fyBwfi3sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759200577; c=relaxed/simple;
	bh=klDRu2KGjM+0nX0HtilCbWli5VflcdgLmjY2aTzwD5E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hsfjS6R9DESPkbOIZxV00xLislvnXWBegzt9dSRRrr4+Ryb3Hz8z/Kmh3EHD30fF4WBmkolMgZaOSI79t6ApfyzYGASP5XcsRdPsjWt6FvhmptX4l1lfmIye3tbA/2Y7eS/X1W3zre++eWvtbqYtS1d4YuqLKFYfQ0u/KiXX21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EAebmBUt; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7811a02316bso2898832b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 19:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759200576; x=1759805376; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wq8AM5fpXK6eEk4la14RAF7oSZLrkv9gGWRw1LyBjWA=;
        b=EAebmBUtBHgaFRSSgeNXqpY0Fcsc+l1F/1xJPwF+3baKQQAd2TaL4e/ApuO3iAYYIM
         C0yb5PkOl/ao2InPhcmtWwYnfbWIQyR4TEx5iDgvkX3TullWEFELubYzmVpQNnGgkfFq
         HOh1DsRx7lZBvH3qngvC958HRym1SWtP65tTPBYUO1vEK7DOGbaFPMwaPDyZIVVANj51
         zW3RoR1UuKnvkhF69PS6+wuL4rqeEjbxoHKrvLts210qfxu02fzsaM3mSsHywLEIYfYy
         +d0z6Ro+GnB2bhxqZ5GSyluZpFRak/iB4MONh0kd2OsGFwJXB5hl0lfOj5qK8TfKKh1u
         Psmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759200576; x=1759805376;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wq8AM5fpXK6eEk4la14RAF7oSZLrkv9gGWRw1LyBjWA=;
        b=sQUxIKQF7c0GD6xQJ2uRGSVWlLGTshq5cYfnqlJTsdfBcTKFrPV1W8RoF4PJ2b7lj/
         NJB96LvSztkwb+QMd1tVBMXWmOLxeJbKYKWxGVxQzRJr6NAmLEGRH8K3VtcqVuHAEiTm
         VRGoyz3eN4ByWPWrjAYy9lxWC2Ayt1+0jp0GuQSs8N6Co77iHNMKeg2/T/KxSpiDMwAL
         yxlPHiv0YuHZ3MdL8x6LJYj2tC5xDitY46mme8XbkXthSCE78TRzaOk/9s8Ck0Pa41gY
         i+TPAqDgjX9AoJJQ+aiXJyBqZl7yNLKbWoBqWN2PN4vzBoLd/Qwf9qGpyNVbbNrYa3bB
         FMRg==
X-Forwarded-Encrypted: i=1; AJvYcCUbdnS9/rqmU0d88nTvB7VTyAiobOHm53xiyKrZmFflUfUmIKNnFJmrtnVyaFWnjkPCEkQ3IJipFUHpnE0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7m8v+pQIC5Bmw0KdyFEQ797FJ3jRtZKt4J98bugl3B6ZKk697
	BH83tyrcdlOiNpnJgLPnQtiKFHO2dLT/eod2+W913h5UA76dv8yQflag
X-Gm-Gg: ASbGnctQALxFiUBjhFG4RiIyocpm0fpE30LCmvDbyTcoAmcMvoqCf1xQI6Ng0sbV9zq
	Iff7spZoVSJWPHC6xhdFcQ86ZXBHg39EU4aLSBmvbmDCCBQRq0z9WNXB/XcwXDf55Z4pUPQKFw5
	JajaURYxKJBwRiZCXHc/NXcVdXDjpSkwKrSYFVg6QScLP/00+tbYqxa2QVfqFosdXsmZFLFP0tE
	oaYKwSCiEcHFOWlCbG5qD8C2jT8+kstk8HsGnZodWIymXPEMFnkaL64SGWQ7hpeojpR0kRbQaSp
	g2SVhl9zfHjDUChBxjTNbGD2Z13eS2Y7dv+K2PfOB0B+FT+cFGZn+zQ4qRzkRuAlJfeldyLX+up
	PpAgmcvWaHIr7ucMvzb9kKVt3j5/y/IWlzo8Y9NTfTevzNCOhibQ0jbXjHs8n3AEytg/Xp9Es5x
	yO7xQfDAQgv1wzU1rYEQ==
X-Google-Smtp-Source: AGHT+IFMe6D44grpGqaN30+IACiK1ag0L1YVwPsQdog/6V2aBU+Upngdj4V9R3NOTeGT0ryw35P7Jw==
X-Received: by 2002:a05:6a21:3293:b0:2df:b68d:f64 with SMTP id adf61e73a8af0-2e7d4dfb6b7mr24100790637.52.1759200575723;
        Mon, 29 Sep 2025 19:49:35 -0700 (PDT)
Received: from [172.17.0.3] (125-227-29-20.hinet-ip.hinet.net. [125.227.29.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53bb255sm12688305a12.5.2025.09.29.19.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 19:49:35 -0700 (PDT)
From: Leo Wang <leo.jt.wang@gmail.com>
Date: Tue, 30 Sep 2025 10:49:23 +0800
Subject: [PATCH v2] ARM: dts: aspeed: clemente: Add HDD LED GPIO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-leo-dts-add-shunt-resistor-v2-1-8712984f04c4@gmail.com>
X-B4-Tracking: v=1; b=H4sIADJF22gC/42NTQ6CMBBGr0Jm7Zi2yp8r72FYlHaASYCaDhIN4
 e5WTuDyvXx53wZCkUnglm0QaWXhMCcwpwzcYOeekH1iMMrkqjYFjhTQL4LWe5ThNS8YSViWEFG
 51l4vXZm3jiAFnpE6fh/xR5N4OGaf42vVP/tXdtWo0VWltkVV1qZT936yPJ5dmKDZ9/0LDIQHv
 sQAAAA=
X-Change-ID: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
 leo.jt.wang@fii-foxconn.com, Leo Wang <leo.jt.wang@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759200572; l=1492;
 i=leo.jt.wang@gmail.com; s=20250618; h=from:subject:message-id;
 bh=klDRu2KGjM+0nX0HtilCbWli5VflcdgLmjY2aTzwD5E=;
 b=ZPnwa3kHMLZcbssExhvWUM2QAqYAJS1I7iHpxlKd7keXV5gaKRp07f4D4Fa3UWcplSv0Hmsab
 TM+5DwS+2TIDCG9kMJDLaoT9z5ObGavmkF/TWkmp56UEMqOToPr0+XG
X-Developer-Key: i=leo.jt.wang@gmail.com; a=ed25519;
 pk=x+DKjAtU/ZbbMkkAVdwfZzKpvNUVgiV1sLJbidVIwSQ=

Define a GPIO expander pin for the HDD LED and expose it via the
LED subsystem. This allows the BMC to control the front panel
HDD activity LED.

Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
---
Changes in v2:
- Drop "Changes include" section from commit message
- Link to v1: https://lore.kernel.org/r/20250926-leo-dts-add-shunt-resistor-v1-1-c871a68792f0@gmail.com
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
index a614f947dafc9a6628c3f3d45b62ff3ca9d2b618..450446913e36b1418fab901cde44280468990c7a 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-clemente.dts
@@ -95,6 +95,11 @@ led-3 {
 			label = "bmc_ready_cpld_noled";
 			gpios = <&gpio0 ASPEED_GPIO(P, 5) (GPIO_ACTIVE_HIGH|GPIO_TRANSITORY)>;
 		};
+
+		led-hdd {
+			label = "hdd_led";
+			gpios = <&io_expander13 1 GPIO_ACTIVE_LOW>;
+		};
 	};
 
 	memory@80000000 {
@@ -1199,7 +1204,7 @@ io_expander13: gpio@14 {
 		#gpio-cells = <2>;
 		gpio-line-names =
 			"rmc_en_dc_pwr_on",
-			"",
+			"HDD_LED_N",
 			"",
 			"",
 			"",

---
base-commit: c65261717599d419e9c683d85f515d3ca2261549
change-id: 20250926-leo-dts-add-shunt-resistor-0cba43f75bce

Best regards,
-- 
Leo Wang <leo.jt.wang@gmail.com>


