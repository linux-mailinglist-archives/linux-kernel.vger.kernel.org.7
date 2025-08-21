Return-Path: <linux-kernel+bounces-780182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9735B2FEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:41:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF83643C8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 339103218B1;
	Thu, 21 Aug 2025 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b="gnoBmmDW"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2CD31DDA2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790027; cv=none; b=U7747UhJIcHvZP3aF2eFTag484PPjGNNZgtk8osyY5SCxl9J3zR4xrGrkgpwVDS1UekuVb9wRPFMZ9L7Q5+DWsatUi22mGX+sra+Sdli6GrLu05mEuP6XZaxQrtMI3ZuANuPbnkU7hR6x57teDc/5lTrF3kMVLAxYCn5k8jdhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790027; c=relaxed/simple;
	bh=pTn8q9gyy4U3k5WPUfs8ClUunMArOq9kWVVYSQNm6jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sZM/9+/M7rdqwf6iYjTywH2GpqTUPZi5OjPdItQflWAGYd1CLOrDtALud1qQZyPSsxqt/AAyt1fcI4Ll6bfQvOwKwEK/o5z9aD/1gFcEeLbraP8TwYSIm25nrFy0Ie62YSfAHSIMCp7lkq9x4MLC9zGyQ19npQI9PVC6NfPacgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be; spf=fail smtp.mailfrom=hammernet.be; dkim=pass (2048-bit key) header.d=hammernet-be.20230601.gappssmtp.com header.i=@hammernet-be.20230601.gappssmtp.com header.b=gnoBmmDW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hammernet.be
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hammernet.be
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-45a1b05a59fso8529195e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammernet-be.20230601.gappssmtp.com; s=20230601; t=1755790022; x=1756394822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2sjxBGydTfjruOh7OE8E/RbRzU+dSv4jaJNJXDHUfdU=;
        b=gnoBmmDWQOf7vNbixaZb+sQS5JjFEtmhwwO727V9nzEmjlapGR91d+H+ibEr03d9cV
         r2KVJodElLav1BSrB8gxAgpDQo7nTKxLx3pkgmJ7pipp7Ye79i6pC5B2wxosafyFjghz
         hljLwo6jFiUY7lEGiIaMU0w3MXcksDtS+ctA+wog/f5rRn8USoQWvW+g0kfn9PxCSsWm
         qeu4Ck72KFfyMPFTUBceU66HDjdgTWKxS7XE7OU2W0HvHVdbyRZDmlbIk4VU/K77Ncti
         DfV9XuveGEfXmeOw3u7pcOGNXd1DMK9Hz33rw0uPnXhzecA3cjSq+3TYVYGW4m6Ozlj+
         WL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755790022; x=1756394822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sjxBGydTfjruOh7OE8E/RbRzU+dSv4jaJNJXDHUfdU=;
        b=NwNqvAlUve7GsBVkYrPL3FrHGX8VTIrQF4u//yVt/hCZ6k6Kh1Ad3qO+a1sf3Prazf
         /KJeGpMx7HNoU7ZCbeqqpZ3dzk95SLGtmfqiJ4JGN6yORci8penNXQwa8QpQ+lveervf
         XuY8oPwak863mQHVij1nm79uXSrlJaatXCs03asSDaz8j8UnmhZhUG3TW+3tgNbXbD3U
         UZwZNoP0m4rpk2VFE3IaE6Z0TCQhqRhlqVA3keHuChP4+gVQ61WgB990iMkqMdFCFSr/
         uXoobhV0eyfG5CtrijF7mbCgtnZmxspmKeyrcLS6lJxaYbyWn2idYvMtx0cZJHdgJKne
         hebg==
X-Forwarded-Encrypted: i=1; AJvYcCXHhx95giXwcgZ8Nz1PkI1QgY148Y6MhOq6EHe+75bRb7njlPoo1KEbPR6uVCvkRyxqIe15w6OFxYr54TE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx27btaneFoPB6UXmm3iTeq4VYc2LI9GdqNwggVLGXZhRcZ/wHG
	FJfztRtBaM4GOAyAIx0KTCrOMZlDnawLUeeI445WYUTdk7jCYYK2ysXd6Dh3u0VfP1I=
X-Gm-Gg: ASbGncsyA/gDGt/6G05/KOp5lOjoiSQLk6h5vmBIfXWVcuCpsS5kI+6khDbwecW+xjS
	jsqT6tc4pSHdfnPiBUlSalo0BGBCysxqlMoyZuFjF3BS63zEz9KnbJwYdzDs/NHBKx2q1WhYMsw
	A6ElGvmb5AKj6eP3T7WKLbD8nwQfqErDFDG390mOY3txfrbiRKeczsTFM/vqIe8YjkfRn1sKlu+
	gwgNVVGrV3iHOwIucSiPyCSwhw/EjynWAUy/GwdYfbkWDKNPrp5BY4M6NRq3DBuxicPP9CXdRT3
	e1V70jtmQSaAbUTbxbZQejKLesiO1vR973d7v/VExJJSSmf0gnPlzGMei6067Ds+HcbVVlsc1dn
	5Ue2WDvcdJKc/PbLtYmjSFHxFUqW13thvnJCI8lB4pyzApD7liw==
X-Google-Smtp-Source: AGHT+IE+4ute/Nv5CZt5NNaDUwvVYtWu4YiNVI45PLItPoW2P50dq71Gb9k2LF4AVVqf2Lr512IxQQ==
X-Received: by 2002:a05:600c:1c90:b0:45b:4282:7b60 with SMTP id 5b1f17b1804b1-45b4fcc3244mr15901095e9.34.1755790022155;
        Thu, 21 Aug 2025 08:27:02 -0700 (PDT)
Received: from pop-os.telenet.be ([2a02:1807:2a00:3400:f5e3:b428:f4bc:eb5f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b50dc00b6sm1538345e9.2.2025.08.21.08.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:27:01 -0700 (PDT)
From: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
To: dlan@gentoo.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
Subject: [PATCH v2] riscv: dts: spacemit: add UART resets for Soc K1
Date: Thu, 21 Aug 2025 17:26:19 +0200
Message-ID: <20250821152619.597051-1-hendrik.hamerlinck@hammernet.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UARTs in the SpacemiT K1 device tree are probed by the 8250_of driver,
but without reset lines they remain non-functional.

Add reset control entries so that the UARTs can operate when mapped to
devices. UART0 is already de-asserted by the bootloader, but include its
reset as well to avoid relying on bootloader state.

Tested on Orange Pi RV2 and Banana Pi BPI-F3 boards, with UART9 enabled
and verified functional.

Signed-off-by: Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>
---
Changes in v2:
- Improved changelog
- Omitted current-speed property for UART0
---
 arch/riscv/boot/dts/spacemit/k1.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/riscv/boot/dts/spacemit/k1.dtsi b/arch/riscv/boot/dts/spacemit/k1.dtsi
index abde8bb07c95..6c68b2e54675 100644
--- a/arch/riscv/boot/dts/spacemit/k1.dtsi
+++ b/arch/riscv/boot/dts/spacemit/k1.dtsi
@@ -667,6 +667,7 @@ uart0: serial@d4017000 {
 				clocks = <&syscon_apbc CLK_UART0>,
 					 <&syscon_apbc CLK_UART0_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART0>;
 				interrupts = <42>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -680,6 +681,7 @@ uart2: serial@d4017100 {
 				clocks = <&syscon_apbc CLK_UART2>,
 					 <&syscon_apbc CLK_UART2_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART2>;
 				interrupts = <44>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -693,6 +695,7 @@ uart3: serial@d4017200 {
 				clocks = <&syscon_apbc CLK_UART3>,
 					 <&syscon_apbc CLK_UART3_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART3>;
 				interrupts = <45>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -706,6 +709,7 @@ uart4: serial@d4017300 {
 				clocks = <&syscon_apbc CLK_UART4>,
 					 <&syscon_apbc CLK_UART4_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART4>;
 				interrupts = <46>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -719,6 +723,7 @@ uart5: serial@d4017400 {
 				clocks = <&syscon_apbc CLK_UART5>,
 					 <&syscon_apbc CLK_UART5_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART5>;
 				interrupts = <47>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -732,6 +737,7 @@ uart6: serial@d4017500 {
 				clocks = <&syscon_apbc CLK_UART6>,
 					 <&syscon_apbc CLK_UART6_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART6>;
 				interrupts = <48>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -745,6 +751,7 @@ uart7: serial@d4017600 {
 				clocks = <&syscon_apbc CLK_UART7>,
 					 <&syscon_apbc CLK_UART7_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART7>;
 				interrupts = <49>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -758,6 +765,7 @@ uart8: serial@d4017700 {
 				clocks = <&syscon_apbc CLK_UART8>,
 					 <&syscon_apbc CLK_UART8_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART8>;
 				interrupts = <50>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
@@ -771,6 +779,7 @@ uart9: serial@d4017800 {
 				clocks = <&syscon_apbc CLK_UART9>,
 					 <&syscon_apbc CLK_UART9_BUS>;
 				clock-names = "core", "bus";
+				resets = <&syscon_apbc RESET_UART9>;
 				interrupts = <51>;
 				reg-shift = <2>;
 				reg-io-width = <4>;
-- 
2.43.0


