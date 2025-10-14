Return-Path: <linux-kernel+bounces-852693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 34266BD9A2E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 242C6501EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4713161A0;
	Tue, 14 Oct 2025 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="MzaNRXIn"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A56315783;
	Tue, 14 Oct 2025 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447458; cv=none; b=KG95t2Ayp9YzcqQq7J60N62vTvrGOPH80pvx2pENOw4ZdHkEgs0FMjBXF9MwUOoIe0I2XWZaoytZpLBQiuE9+HJzupk3TpTARc0WH0CMA48zlRYgeiastHPntZCfFznW3RzloROPKgMpwTZXLOnEy37YDQVicE80SPFJ87LA2qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447458; c=relaxed/simple;
	bh=SnHE+KYEHYlkFQ1P6HZQnLB2xV8QwDDqPT4rwxwlJ6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtqG+MKE1/18+ajc6v8doyQbjs9Hp98QagOgup5dkCaQwvbEuTvzh6hmvccjBWBW+Nu1mLNsJRz1BvtswbHGJ1XYa5a6IWcG831DuWXwUezKFu+tX0PkhDWZAyHTXHE6Uv4SF1H+9ecTXE+s4RlAaU9W+w/l7oTWZCovLz262N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=MzaNRXIn; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6AE6522BF5;
	Tue, 14 Oct 2025 15:10:54 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JnGNg-KN5pZ; Tue, 14 Oct 2025 15:10:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1760447453; bh=SnHE+KYEHYlkFQ1P6HZQnLB2xV8QwDDqPT4rwxwlJ6I=;
	h=From:To:Cc:Subject:Date;
	b=MzaNRXInIU7n2CLfs0Q63SN1pA0bzrgbHPLGdxUwBtuQE50Unl5MFqC1beR0aBI97
	 7zN9/3SRr6cLvYDN9fb9l3VrercwRqWpFJJ2M01BfQdzBAV3JhJP0BoooPnBXu66RH
	 V9feFn5KKkZTMaFl01skCvUFYmkTOie6f5hlZHMQfFtE8jr3JfqOdcgY1jWgwFRDAv
	 vtwgau6IOjbWhbKB2X9+I99g1FR6uEN4DixGMDUlteF6R241nWaqagNc0WQVaZTwO/
	 G6GJOyPaLVjcLKH4Npo/K5z0AnbVasQ+4bjwNYi7d5oBWY1a7NBliAaNYc1DeZXHQG
	 XOrLTvg73lQvw==
From: Yao Zi <ziyao@disroot.org>
To: Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Michal Wilczynski <m.wilczynski@samsung.com>
Cc: linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Icenowy Zheng <uwu@icenowy.me>,
	Han Gao <rabenda.cn@gmail.com>,
	Han Gao <gaohan@iscas.ac.cn>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH v3 0/5] Add reset controllers for other TH1520 subsystems
Date: Tue, 14 Oct 2025 13:10:27 +0000
Message-ID: <20251014131032.49616-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TH1520 SoC is split into several subsystems, and each of them comes with
distinct reset controllers. We've already had the one for VO subsystem
documented as "thead,th1520-reset" and supported, and this series adds
support for others, including AO, VI, MISC, AP, DSP and VO.

For TH1520_RESET_ID_{NPU,WDT0,WDT1}, these're reset signals that have
been introduced along with support for the VO reset controller. However,
registers in control of these resets don't stay in the VO reset region,
instead they're AP-subsystem resets, thus the original ABI is
problematic. I remove them in PATCH 1 and reintroduce them in PATCH 2.

Note the reset controller for AO subsystem is marked as "reserved" in
devicetree since AON firmware may make use of it and access in Linux
side may cause races.

This series is based on next-20251013, thanks for your time and review.

Changed from v2
- Collect review tags
- Fix duplicated dt-binding IDs for DSP-subsystem resets
- Link to v2: https://lore.kernel.org/all/20250915095331.53350-1-ziyao@disroot.org/

Changed from v1
- Make a separate patch for the ABI-breaking change of
  TH1520_RESET_ID_{NPU,WDT0,WDT1}
- Fix the duplicated dt-binding IDs
- Sort compatibles/reset-signal definitions in alphabetical order in
  the driver
- Sort dt-binding IDs in alphabetical order by subsystem names
- Link to v1: https://lore.kernel.org/all/20250901042320.22865-1-ziyao@disroot.org/

Yao Zi (5):
  dt-bindings: reset: thead,th1520-reset: Remove non-VO-subsystem resets
  dt-bindings: reset: thead,th1520-reset: Add controllers for more
    subsys
  reset: th1520: Prepare for supporting multiple controllers
  reset: th1520: Support reset controllers in more subsystems
  riscv: dts: thead: Add reset controllers of more subsystems for TH1520

 .../bindings/reset/thead,th1520-reset.yaml    |   8 +-
 arch/riscv/boot/dts/thead/th1520.dtsi         |  37 +
 drivers/reset/reset-th1520.c                  | 835 +++++++++++++++++-
 .../dt-bindings/reset/thead,th1520-reset.h    | 219 ++++-
 4 files changed, 1083 insertions(+), 16 deletions(-)

-- 
2.50.1


