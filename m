Return-Path: <linux-kernel+bounces-816551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5D8B5754A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3E4D17D799
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52DD2F6183;
	Mon, 15 Sep 2025 09:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="PgZoum/h"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048392EA73C;
	Mon, 15 Sep 2025 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757930100; cv=none; b=WmdTf1wiM5bqN7q6xf/1il1RGKQvHqFUZJPxP6VyFlgh0wWWKXAyD0qYhJNkTAUplKwESXaDrfDmuyPvFZRWj00AUR3hHNQ8cQ2wGxJmjcf1eXciJ9OiaLcqKRliPjN0Lw/xszLI8XK7tfyDodKxgFOLwzkuYN6UQYnBnLpg/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757930100; c=relaxed/simple;
	bh=d0VqZbpQ0JGwY8ajzJh1U/vak+EkkwD4uK2aJndcr8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OM2LPva1FAfOqzRW5ZjBjNDQzSz9RLwkuQ2mQ+3seaB8OwFR3S0I9/6IEHpFdSNcpfkgXLV8TvuVQuSYRiIyWxwOQ/zG+Wqf5ClwBdUXVjvRlCKVd/lhjkWlpRDwd7fs5olnx9CT2nyAvGFgBWWgg0i5SZSewpsjfYC5TTErfQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=PgZoum/h; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 6928C25D81;
	Mon, 15 Sep 2025 11:54:50 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DKm59VjfPMPN; Mon, 15 Sep 2025 11:54:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1757930089; bh=d0VqZbpQ0JGwY8ajzJh1U/vak+EkkwD4uK2aJndcr8E=;
	h=From:To:Cc:Subject:Date;
	b=PgZoum/hHcKkQqtSl3UBtjW23RnWMDzKiJCFBXKH8tu5b33wGdm80vG4QlxujSoK3
	 CodbPTz8s60cg3td0TtnG9zlXD5vk+Ezq6O8Z1m7Ww1bc+ACnq6dUT386zCp5zHFhE
	 aOWX+RmNunbz9jsM8i0gUY9ysZHyGe1eOIC9B2amrIycL2T8UO6Keu+ZolGynxHdfR
	 smzfXbYsQdA0eEPrPRG4kJurSKk7KPGNl5f7jLKdLsOqiNiCGPkwUpR2wQB7j0J6oC
	 u5a0FwOWAuNygw76T8mfzP5zBg0anCJoxwLxn/tcjjtcHoogyC/uMqgkjig+vlgp96
	 wDzIyvbwzT0JA==
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
Subject: [PATCH v2 0/5] Add reset controllers for other TH1520 subsystems
Date: Mon, 15 Sep 2025 09:53:26 +0000
Message-ID: <20250915095331.53350-1-ziyao@disroot.org>
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

This series is based on next-20250912, thanks for your time and review.

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


