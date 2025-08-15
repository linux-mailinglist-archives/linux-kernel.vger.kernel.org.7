Return-Path: <linux-kernel+bounces-770399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C757BB27A53
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFD7AC672E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156E723AB88;
	Fri, 15 Aug 2025 07:46:36 +0000 (UTC)
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045051DD0EF;
	Fri, 15 Aug 2025 07:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755243995; cv=none; b=n6PUo/YfO0y9eWdLlC7QokJJ3mNwKYm3LVLlh9bcZOMF6CuIoCvyrvP5BtVU4/vCND35IrXEwNO+FSsZy64QDd1d4eqt5dQGsttYbEII/HVfVcboyUH7uWl8+QTUJFqZg2KCEOAw9AuZCz2yoqf2BSF6fvJhE4MW7tZ5IjpSoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755243995; c=relaxed/simple;
	bh=M5wxVbseO6auJIkzODJGZ86Vw9gaeEM4NLpeJyR9ozs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcPPY5NVyr25SkSLTzWd7gbUsp8wnZLqqUVqTFCsVaXbfb3nzHQA6a1Wj+L2GhM/eBbXMiAr/7KqVmkQKKyB4RQmp0oLBq0ZtIbwj8zd61+wFGe1jgdKSr7WYX91+n15m1vsNdMeaKlh0vztegKtWzvPrtgbK6jox8+l3ZVrJDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Received: from hay.lan (unknown [IPv6:2605:59c0:2078:cf00:6ecf:39ff:fe00:8375])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 700BEB4E004D;
	Fri, 15 Aug 2025 09:39:56 +0200 (CEST)
From: E Shattow <e@freeshell.de>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hal Feng <hal.feng@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	E Shattow <e@freeshell.de>,
	linux-riscv@lists.infradead.org
Subject: [PATCH v2 0/3] riscv: dts: starfive: jh7110: More U-Boot downstream changes for JH7110
Date: Fri, 15 Aug 2025 00:37:20 -0700
Message-ID: <20250815073739.79241-1-e@freeshell.de>
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

Changes since v1:

- patch 1/3 "add StarFive JH7110 SoC DMC": Rephrase commit message and
  description, drop min/max items and list with description instead, drop
  legacy clock-frequency property.

- patch 2/3 "add memory controller node": Rephrase commit message and
  drop clock-frequency property.

E Shattow (3):
  dt-bindings: memory-controllers: add StarFive JH7110 SoC DMC
  riscv: dts: starfive: jh7110: add DMC memory controller
  riscv: dts: starfive: jh7110: bootph-pre-ram hinting needed by boot
    loader

 .../starfive,jh7110-dmc.yaml                  | 73 +++++++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 21 ++++++
 2 files changed, 94 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/starfive,jh7110-dmc.yaml


base-commit: cb69daf085b5974fef2df9789f8c1b35e78e7913
-- 
2.50.0


