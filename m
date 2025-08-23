Return-Path: <linux-kernel+bounces-782991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9852FB32812
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 12:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378643B05D8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0AF23AE9B;
	Sat, 23 Aug 2025 10:03:14 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BEC1F2C45;
	Sat, 23 Aug 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755943393; cv=none; b=hsWHBlqVtJoG4DyuTJyF1NUZjgAIVddNQG+aLXf4gnkJa+ZAomEkqgxpfYhF2jZ4TVblZAfSpWnQbsLaPMoZDWR8sKaSr5owJO3U3tvOjWNkEsM9xfA6L4v4nHcwzn/FfQjuOGVa0ZRcDH/u5SHsTcPt4fFzpY/+wFD52/KAHoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755943393; c=relaxed/simple;
	bh=N5SPA0uLhiPgJjNJrXRDXCKhs9Tuc9R2/R866kkDGDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vAwYXceKP4l6yNcM+95kpRmtkPaaKrA/gyy4rTokMGyKwNO0b4a5wshRO/NXg9cc29l8wHOW7erERwWWvoxBUweY//YmvE6S+tf8sZhtwJgVSaHw5GL4rCcWiJjr/Ukt3fAz6M3wCObrVgLOmJE7GUuQxpzHPI2FFaKwvNbE/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 48AE0B4E1E32;
	Sat, 23 Aug 2025 12:03:05 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	E Shattow <e@freeshell.de>
Subject: [PATCH v3 RESEND 0/3] riscv: dts: starfive: jh7110: More U-Boot downstream changes for JH7110
Date: Sat, 23 Aug 2025 03:01:40 -0700
Message-ID: <20250823100159.203925-1-e@freeshell.de>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bring in additional downstream U-Boot boot loader changes for StarFive
VisionFive2 board target (and related JH7110 common boards). Create a
basic dt-binding (and not any Linux driver) in support of the
memory-controller dts node used in mainline U-Boot. Also add
bootph-pre-ram hinting to jh7110.dtsi needed at SPL boot phase.

Changes since v2:

- patch 1/3 "add StarFive JH7110 SoC DMC": wrap at 80 col, clock-names
  const is 'pll'.

- patch 2/3 "add memory controller node": memory-controller node follows
  sorting style by reg address, between watchdog and crypto nodes. Update
  clock-names to 'pll'.

- patch 3/3 "bootph-pre-ram hinting needed by boot loader": add missing
  hints for syscrg dependencies 'gmac1_rgmii_rxin', 'gmac1_rmii_refin',
  and 'pllclk'.

E Shattow (3):
  dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
  riscv: dts: starfive: jh7110: add DMC memory controller
  riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot
    loader

 .../starfive,jh7110-dmc.yaml                  | 74 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 24 ++++++
 2 files changed, 98 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml


base-commit: 481ee0fcbb9a0f0706d6d29de9570d1048aff631
-- 
2.50.0


