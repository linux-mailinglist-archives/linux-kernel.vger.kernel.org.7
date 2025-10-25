Return-Path: <linux-kernel+bounces-869762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6208C08AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 06:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561213AC220
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 04:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1F525BEE5;
	Sat, 25 Oct 2025 04:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3EnSCCW"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3485A1494C2
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761366719; cv=none; b=LnkloUqqsWvFddEvNqib7PcRPZ28f4KhlaiahNch3BDJGBOaAyLw3jFtIonvnmuLC1erlv2aYr6KrfPvR+ZyorDyw7zteNKYCHzWchhNJmoJPGSFlQB0z88x7fYpWbkXrornEM7agnc9qTk3VVQ3v5e61G/pDnbWvXVxhDJijlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761366719; c=relaxed/simple;
	bh=TyC97LahORynCpDNYYasLXMe/KE5E24maIVQwa1LxhE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BsRwJGevXr3aFdMbHEfWowahHFs7axthqCNzZJme6ONirc45qO6emKTwzW8lFKbJ7ir+7hOaSjphHVVGQwnZ2rOh0tEynR3+ox+iKSgLjmarjL01gq5VQgKa7TpzZTDVYbBntJ3HNARw3eNeJIwVhqTVeBPXsklI66/8HRrdUqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3EnSCCW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-378d65d8184so37576321fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 21:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761366715; x=1761971515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEVFVM/l2psTi4+scJeyVhhgmazdGrNFi6gMHZXJLQg=;
        b=d3EnSCCWd3gHiqluJx1/VKamPZRSQXHgglAIrf4U/gQcEJi1OZuz73eQ92o3Vhbmxy
         bOcgr5ur8b+ze4S2AJOi2cwKDxunPzVMjvGmQyHohqwoBwqZV5sG+QXPQZ0eFu3d1O6s
         RPNMks8FOuklQBTCnH5My3d3rHwfKWIByxV9qW75BHzS7XlurTzwrPTblC/PkKwyC6UU
         zsmO7q4z/c3QUTgCe9EU2JJ3K/pbcEtSCYzH85aSessxOjyESD9+WIv+QJ2arfuKFcz/
         kye0kepU+mnQoO52qrcdjycodcdD0JVaZL1VEuUTmOYPpEZRmlZU7bXmuLH+KDKhgUpB
         /d8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761366715; x=1761971515;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEVFVM/l2psTi4+scJeyVhhgmazdGrNFi6gMHZXJLQg=;
        b=X/3Uyq+88hnqYV7nBDbR+E9mwRNJBAGOPXiAc94sOsDmU2o4oZ4+47BhVd++chXxqS
         h++xKvioN/fTu48YmGACewy2voB8k/wrOq5Sx3a1NWCBqTtS+lidDJ7Se/7TDdZ8nzq5
         3BsduIVAxFiCJiyjHlz0cVaFtJ9QIH4yBCxBhY7/AYO8uFOOJ35qLMjQJq9wsarffDy0
         OT5vZ74rtZpk6QZmOmt0P1a33uzwLsV5TI8cliDntlrOS1D37jy5i3/Blhn2z/zFLQFD
         5iRUdcZAIv+eqd2evHJWghxggwu35TzxvFWDkB85ONz/FzI2EatmwURt6zFCVRYBJj7v
         A2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHTOGxV9zVsJy6SVT3awlH5CWQBrjanGhJPLdkrSXhD3Y1HyBKh+VqEJ32JhDOdVrsPdYbmALE0H4UoZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+X1fYmJPk0ruCW9wxHl1o5V3ykLY4q4LB4PB2zExJ5M1id0ss
	CTX4OztHP6TWDdFEPCmZw8XQMPr77zYa0nmXvxnDOflLo3D1mMNiCvtc
X-Gm-Gg: ASbGncvfTV/QHN5z5mgnWgx2IDiYYg6tAJT4eoiILCmSL5w23gacf4prhWGt7QZ29bV
	EyvrsuIhZXKDvhTobctYQoJv6Mf3MShkCKx/YvV6o2poOyJKvTUH/jy4poKgIKEXzyzfoRtAza3
	uy7CoakmeNdsG2UsxkK5K/P0RXadKlYrBDQ4fm4y6/6GJPUGPfi/YxIcBqqT/A5I+AAi4KQNFRs
	jHY5Wy0lK3hAo013ZML96twqsfbQ3BDficHNTMPUHqXfM0vea3StjJxjkwt0ZRYpa8MVFJWIOTb
	5aM/Ay35iIdILuE7TEnS4GBSe9wiF3SHIzx85eCUl7EGv4YD5Y/RjhNA+pj6JP6kv4nUhJF0Wmr
	XrH9Z6G6OUxCT9wOD09tDEZu3/ykE3DenpK3bOYDxFuImSRqrK5lj5l2FMN1caarz6zUxD0V6+8
	Ge
X-Google-Smtp-Source: AGHT+IFXzz4JrbCccLfkZ2ZXGDknqpjtngSJ7wok4+tdSDfFKxhBjVek1aHX+t+1GLDollUvLiPj9g==
X-Received: by 2002:a2e:bc25:0:b0:378:dd60:38c9 with SMTP id 38308e7fff4ca-378dd60520emr22966101fa.38.1761366715050;
        Fri, 24 Oct 2025 21:31:55 -0700 (PDT)
Received: from junAIR ([176.106.241.81])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee0ca7a0sm3409241fa.33.2025.10.24.21.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 21:31:54 -0700 (PDT)
From: iuncuim <iuncuim@gmail.com>
To: Vasily Khoruzhick <anarsoul@gmail.com>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: Andre Przywara <andre.przywara@arm.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] Allwinner: A523: add support for A523 THS0/1 controllers
Date: Sat, 25 Oct 2025 12:31:23 +0800
Message-ID: <20251025043129.160454-1-iuncuim@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Kalashnikov <iuncuim@gmail.com>

This patch series adds temperature sensor support for the Allwinner A523
family of processors (same die with H728/A527/T527)

Based on 6.18-rc1.

Changes v3~v2:
x) dt-bindings: nvmem: SID: Add binding for A523 SID controller
 - previously accepted, therefore removed from this version

1) dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
 - added changes as requested by Rob

2) thermal/drivers/sun8i: add gpadc clock
 - removed undescribed changes spaces to tabs

3) thermal/drivers/sun8i: replace devm_reset_control_get to
 - changed the commit description to the version suggested by wens
 - added reviewed-by tag

4) thermal/drivers/sun8i: get calibration data from two nvmem cells
 - added spaces in the description block before "*"

5) thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
 - added alignment of functions in compliance with open parenthesis

x) arm64: dts: allwinner: A523: Add SID controller node
 - previously accepted, therefore removed from this version

6) arm64: dts: allwinner: A523: Add thermal sensors and zones
 - no functional changes

Changes v2~v1:
1) dt-bindings: nvmem: SID: Add binding for A523 SID controller
 - added new patch

2) dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
 - changed clock order
 - added additional nvmem cell with calibration data
 - added requirements for new controllers
 - added description

3) thermal/drivers/sun8i: add gpadc clock
 - removed unnecessary call to clk_prepare_enable() since
 devm_clk_get_enabled()includes this

4) thermal/drivers/sun8i: replace devm_reset_control_get to
 - original function replaced with devm_reset_control_get_shared_deasserted()
 - removed some of the repetitive code executed by 
 devm_reset_control_get_shared_deasserted()

5) thermal/drivers/sun8i: get calibration data from two nvmem cells
 - added possibility to get calibration data from two independent cells

6) thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
 - removed magic digits
 - changed description of calibration data procedure for A523
 - changed numbers of array elements with calibration data

7) arm64: dts: allwinner: A523: Add SID controller node
 - fix typo (sun50i->sun55i)

8) arm64: dts: allwinner: A523: Add thermal sensors and zones
 - cell with calibration data divided into two
 - added passive trips for gpu
 - added information that information obtained from BSP

v1: https://lore.kernel.org/linux-sunxi/20250411003827.782544-1-iuncuim@gmail.com

Mikhail Kalashnikov (6):
  dt-bindings: thermal: sun8i: Add A523 THS0/1 controllers
  thermal/drivers/sun8i: add gpadc clock
  thermal/drivers/sun8i: replace devm_reset_control_get  to
    devm_reset_control_get_shared_deasserted
  thermal/drivers/sun8i: get calibration data from two nvmem cells
  thermal/drivers/sun8i: Add support for A523 THS0/1 controllers
  Allwinner: A523: add support for A523 THS0/1 controllers

 .../thermal/allwinner,sun8i-a83t-ths.yaml     |  56 ++++-
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 154 ++++++++++++
 drivers/thermal/sun8i_thermal.c               | 234 +++++++++++++++---
 3 files changed, 401 insertions(+), 43 deletions(-)

-- 
2.51.0


