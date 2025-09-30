Return-Path: <linux-kernel+bounces-837148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC7DBAB8B4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5B73C63ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 05:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9FA127E077;
	Tue, 30 Sep 2025 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMCnFo1v"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E3127B35D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 05:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759211433; cv=none; b=RN43oRM5wBai7rnl17fl6OsXaVlvMUQVR3JfZlVlzLCRU7oGB3jX2sUA3T2KpM4vAmLVmmHf3N6ZHbv93qcsLF4O8iINepFTrkkDCgm4o6+bCN0zSkWf/z8xE7E9mUVyT/16ZP81Pd4UuwmceOymBOziM0DWue8o0arHHb/5NP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759211433; c=relaxed/simple;
	bh=4WqaVu4ojyQzVM8QrCUI7LikzMb4bhIq2dq3ZVmQLGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KJMPDHrzjFxSK4ngfcVskCfOYK7slrBp9WlhrmK8NtIlYz/zm/5FvvkPCniGV+n1f9R/ILtq64xnFmHppuZHFmhf3p2G/nYP9jdGSX/tdoVhnKIrKmxmJgFD1XLUPuyq99YNTihw2xV/3YfRCzSX2IBMoz5bBbxpC4a4NZxg8/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMCnFo1v; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-862cbf9e0c0so345750385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759211430; x=1759816230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDWN4g6ghBuiYarXPc9Grf4Kf/+CFy/Pefagl1DF5KE=;
        b=EMCnFo1va318dR9SATkkgKmqJNtL+Yo9rOA9cW0WNNbwsLTZlx2cX4Tu4v90gHw+rP
         U+Iz1JftH7cTWMXaL8e1zIXEzBsXjA49awry1f+f9DG5KG4O4Hzd0vAtzjqcZElsJlCn
         dZGpY0ZWAL7jkykKNHAJ66ljDQXej0PE3N7EDbRkwcHn2iarF6irsosRiixiu4HadZym
         uYA+d01IoPwGMCCJFJI0WVlKjZiu6U7W/njby3eto+Y4LFrWoR1DDh8YgaBafYQPKk++
         z3I2cgfRsaQjWCxdMXTvZA9LDpy3piLBLN4ZIL4dsSxMlXM9YAJys3zPK+GSKe+FOJvu
         oKnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759211430; x=1759816230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDWN4g6ghBuiYarXPc9Grf4Kf/+CFy/Pefagl1DF5KE=;
        b=PFywkjkkUkmhxfCQ/c5WWDFFx9KpqysTqy3BWwk4rreMpwG+9NjnUY4zE5ubTv3zEt
         OSXs3AU2hn6jhrerUY23/wNoCrtJwAE1gnK5FdMLfSITlTlQKFAj+Zi5x9+l5Jhz5Lld
         Fyhzs5bzRwlSxBGB3M4k9QGgjb5SVF57cXZHmhW405qBxmyYJaorgN1mSk94W460MJgh
         AZ5Ouu15NByQPFoWl+AckXCjoG+bCQTSm9dkD2nHngx148YBEKEzRMjJXVKLoGSkuFuS
         SZygQybBkDKIolsIfFTjwBcNhiRorQRq108q6PMGM6QSTQKQRK+na8fV7pEZXNiHtutX
         c4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeT0NwOH4q6HjcaJsINf+GPxSERThSHSj6EHZO1rc+M0rZ7MWM7Fmj2RsCMJ9rrfjZAJZVnVGNt4t5vuY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw54orl+VUKHsCJO2xFVxMZ2udDrPAP8NDSKZQXIujL2aluU1EE
	JtorRJH8NcVF6I8pyyDiP2YdX7AsNsaiYoGiY6xMF4oR03jm81Y4ySml
X-Gm-Gg: ASbGncuxZ37cBD9BgwGBbAyI1am0jOf78WmjXNtK8oMCSc1VY93pqMHgCFiEd1xR6Nj
	1EtVO1/GMrKeEpr1xBaWkrpYonJf/ttdt1t2/C8tKyVC1Gu2T0R3hK5TX2Nb6oyVwo7IpKoMF+g
	Q8mVNE25tfuXZn3wbFQ1lP9GQGCJ2HfDfP4dHqunjahBCI9tbbzrqOhxsV3ZuWDHq99lBZLx3tr
	XVuueE9/OQ5jMpEVhxL7jqd5fD795Xy2Hg+b5BBgJGcH8w+kXPhfKQmgepdqtxpdYuXA15EpBEz
	XOQQeGqCNRhhgfnNpEo7DtW6i5/of9elOoNrkBklW4Bfm05Lv+cgBhbeIUD+tb+1izJ2a1USUuk
	eCd+I+5wNCJWdMh/5VIHyDNG55HZRUBI7CHzriUljjcaJ
X-Google-Smtp-Source: AGHT+IG9qqjmdiQSDLHuO7EpbaYz9j/RzszkZqlPiHzP5xEh40KEmQHqMDJaw66yqCAcH/AUHfDcug==
X-Received: by 2002:a05:620a:198b:b0:863:a3da:6407 with SMTP id af79cd13be357-863a3da6711mr1776483085a.31.1759211430006;
        Mon, 29 Sep 2025 22:50:30 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:3981:263c::3cf:53])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c306b5f64sm971990985a.32.2025.09.29.22.50.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 29 Sep 2025 22:50:29 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	kever.yang@rock-chips.com,
	naoki@radxa.com,
	honyuenkwun@gmail.com,
	inindev@gmail.com,
	ivan8215145640@gmail.com,
	neil.armstrong@linaro.org,
	mani@kernel.org,
	dsimic@manjaro.org,
	pbrobinson@gmail.com,
	alchark@gmail.com,
	didi.debian@cknow.org,
	jjm2473@gmail.com,
	jbx6244@gmail.com
Cc: devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/3] arm64: dts: rockchip: introduce LinkEase EasePi R1
Date: Tue, 30 Sep 2025 13:50:14 +0800
Message-ID: <20250930055017.67610-1-jjm2473@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---

Changes in v2:
- Change deprecated "rockchip,system-power-controller" to "system-power-controller"
- Link to v1: https://lore.kernel.org/r/20250925055906.83375-1-jjm2473@gmail.com/

Changes in v3:
- Fix typo ('status = "disable"' -> 'status = "disabled"') found by kernel test robot https://lore.kernel.org/all/202509261328.Grjhp029-lkp@intel.com/
- Link to v2: https://lore.kernel.org/r/20250925092037.13582-1-jjm2473@gmail.com/

Changes in v4:
- Fix missing "Acked-by" message in patch 1/3 and 2/3
- Link to v3: https://lore.kernel.org/r/20250929065714.27741-1-jjm2473@gmail.com/

---

Liangbin Lian (3):
  dt-bindings: vendor-prefixes: Document LinkEase
  dt-bindings: arm: rockchip: Add LinkEase EasePi R1
  arm64: dts: rockchip: add LinkEase EasePi R1

 .../devicetree/bindings/arm/rockchip.yaml     |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3568-easepi-r1.dts    | 692 ++++++++++++++++++
 4 files changed, 700 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3568-easepi-r1.dts


base-commit: 30d4efb2f5a515a60fe6b0ca85362cbebea21e2f
-- 
2.51.0


