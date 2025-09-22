Return-Path: <linux-kernel+bounces-827454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0551BB91CE9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:55:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D2E18905E3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074782D5416;
	Mon, 22 Sep 2025 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b="ExgRDbmF"
Received: from sender4-op-o16.zoho.com (sender4-op-o16.zoho.com [136.143.188.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BF5BE49;
	Mon, 22 Sep 2025 14:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758552891; cv=pass; b=m0f8Oexe5faqO1xLiDPe5TzpsxX91aj8Y6yjX7ckGyBJFKQo44k5mfu/22e8ngunK8ZQvh0vkpx8aT1Dc3iq59QJGZxNBiPrmFWG9aBG8O36g6M4fof1la4Ch6+4IYmeopviXYw2Ks10oxVtH/8OiGjNHx0H92wnsSmGOGOniTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758552891; c=relaxed/simple;
	bh=rH5irle+sczuJXmPXvRUIjTgU2ufYTgrstQsYtxCWv8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lj3DW3lArK+Kfad6rYmlFYmK1a28q0VALZr4uPD/5tyHnkyGwxzMzWB6cTknuv17fHBmUhizvObzNJxXwC6HVGp7JO0iOc+15mYDFpNm9UXENplwpjxRSd+IyUAIpb9V6vUDBuNMRNgztAvjed+PU25+CdPYfPRTD+72Pi3scO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech; spf=pass smtp.mailfrom=pigmoral.tech; dkim=pass (1024-bit key) header.d=pigmoral.tech header.i=junhui.liu@pigmoral.tech header.b=ExgRDbmF; arc=pass smtp.client-ip=136.143.188.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pigmoral.tech
ARC-Seal: i=1; a=rsa-sha256; t=1758552852; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AvFy33S2MxKc3ZPS3j6+bHixCWAGoLP0HPOIjC3ipTD8O2XDpd8CYjxJPS8ztW6XK887aIHtbSeeToNow37t4WNzyPbkE34VhdsbC1gBOygDnhlf6O5/MiyQ1LDa56quhJRLbBudYUtpae2q44XypZWDbUmJzQuMtpQuarNFe/g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758552852; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DeLdKeuo/Hnz9lfAB7fI5TVyX1F6rNHmAOCEIqgmbrM=; 
	b=LOEjRC7uiLdaloKcyvg/xoExpZxwJJXonaDlOzndInUF48K+hu7lQIaKtTButYgjtW4A5ZnC7oSNNkE/Ek62/4TH37DA4XjyRkQAYh13kDmy5jEZDMrx5uRn5gMW/Xr56n05PX8hQdRYBLiGr0wOfYreime4m/ZJr1fY2H73fz8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=pigmoral.tech;
	spf=pass  smtp.mailfrom=junhui.liu@pigmoral.tech;
	dmarc=pass header.from=<junhui.liu@pigmoral.tech>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758552852;
	s=zmail; d=pigmoral.tech; i=junhui.liu@pigmoral.tech;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=DeLdKeuo/Hnz9lfAB7fI5TVyX1F6rNHmAOCEIqgmbrM=;
	b=ExgRDbmFd2BzNygVWiI7AS9jqK8EBUKXFWDgHmV3akjB7KXJx8iljQ7eEABN9fWk
	bgCrqMcpuofxUdfjs2mIdZUeHUP9+iJtefjb4OHdPrwBqN01ac3oLwk9Sy2muI13fSv
	RDpZsPQSq/yG8xnWryrqJG2+s7yynpzCT1acDvUE=
Received: by mx.zohomail.com with SMTPS id 1758552849368531.5028464290766;
	Mon, 22 Sep 2025 07:54:09 -0700 (PDT)
From: Junhui Liu <junhui.liu@pigmoral.tech>
Subject: [PATCH 0/5] clk/reset: anlogic: add support for DR1V90 SoC
Date: Mon, 22 Sep 2025 22:51:46 +0800
Message-Id: <20250922-dr1v90-cru-v1-0-e393d758de4e@pigmoral.tech>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIJi0WgC/12Nyw6DIBREf8Ww7jWID6ppmv5H4wLhqiRFLSBpY
 vz3Ut11eSYzZzbi0Gp0pEk2YjFop+cpQnZJiBzFNCBoFZkwykpaMwbKZqGmIO0KvBBdQSXvGc9
 JHCwWe/05ZM/2ZIvvNTr9GRKDzonD2SS3f2UnnJagPAQGFKpCsWtJqexy/lj0YGYrXqlHOd5/X
 7GMIGdjtG+SUKUZBys5aff9C/cVHLDTAAAA
X-Change-ID: 20250922-dr1v90-cru-74ab40c7f273
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 "fushan.zeng" <fushan.zeng@anlogic.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758552834; l=3149;
 i=junhui.liu@pigmoral.tech; s=20250910; h=from:subject:message-id;
 bh=rH5irle+sczuJXmPXvRUIjTgU2ufYTgrstQsYtxCWv8=;
 b=p4wngGULu5N+7Qr7vJFQKlmCAGbDs9xK8EV/QnrSNlZzmoxlUw99FzHEC8D7MtrU2DSWdu0aP
 yUpaG2Wny2zB19xl2ilzwrilMlAiptHKKPHG630jBgkXWET72ri8Be8
X-Developer-Key: i=junhui.liu@pigmoral.tech; a=ed25519;
 pk=cgATWSU1KfGWmdwNmkPyHGnWgofhqqhE8Vts58wyxe4=
X-ZohoMailClient: External

This patch series adds Clock and Reset Unit (CRU) support for the
Anlogic DR1V90 SoC, as well as corresponding dts bindings and dts
integration.

The CRU driver framework is built around the clock controller as the
primary device, with the reset controller implemented as an auxiliary
device.

The Anlogic DR1 series includes not only the DR1V90 (based on the Nuclei
UX900 RISC-V core), but also the DR1M90 (based on the Cortex-A35 ARM64
core). Most of the clock tree and CRU design can be shared between them.
This series only adds CRU support for DR1V90. Nevertheless, the driver
is structured to make future extension to other DR1 variants like
DR1M90.

This depends on the basic dt series for DR1V90 SoC [1].

Link: https://lore.kernel.org/all/20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech/ [1]

---
Junhui Liu (5):
      clk: correct clk_div_mask() return value for width == 32
      dt-bindings: clock: add Anlogic DR1V90 CRU
      clk: anlogic: add cru support for Anlogic DR1V90 SoC
      reset: anlogic: add support for Anlogic DR1V90 resets
      riscv: dts: anlogic: add clocks and CRU for DR1V90

 .../bindings/clock/anlogic,dr1v90-cru.yaml         |  60 +++++
 arch/riscv/boot/dts/anlogic/dr1v90.dtsi            |  41 +++-
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/anlogic/Kconfig                        |   9 +
 drivers/clk/anlogic/Makefile                       |   5 +
 drivers/clk/anlogic/cru-dr1v90.c                   | 190 +++++++++++++++
 drivers/clk/anlogic/cru_dr1.c                      | 258 +++++++++++++++++++++
 drivers/clk/anlogic/cru_dr1.h                      | 117 ++++++++++
 drivers/reset/Kconfig                              |   9 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-dr1v90.c                       | 136 +++++++++++
 include/dt-bindings/clock/anlogic,dr1v90-cru.h     |  46 ++++
 include/dt-bindings/reset/anlogic,dr1v90-cru.h     |  42 ++++
 include/linux/clk-provider.h                       |   2 +-
 15 files changed, 915 insertions(+), 3 deletions(-)
---
base-commit: 02fc12d7c5a58a010fe2bfaedbc0a5b3cc1cc231
change-id: 20250922-dr1v90-cru-74ab40c7f273
prerequisite-message-id: <20250922-dr1v90-basic-dt-v2-0-64d28500cb37@pigmoral.tech>
prerequisite-patch-id: dc2c18c600b0efd0e3237c11b580cb011b3f5070
prerequisite-patch-id: d67ae8ee7c8f7dcb35dc7417d002b1d9cb4d928d
prerequisite-patch-id: ab3aa9ae32dee038edbee3fd0c809fe4bb724d1c
prerequisite-patch-id: 376f134b341ff8ad728dbb094808eec7f74f95f5
prerequisite-patch-id: 3ab69aeadf1aba02977276bc21488d7599bfe1d5
prerequisite-patch-id: 2c6db06e8d61a46fbd68f6ecc49e111ad0e5f145
prerequisite-patch-id: f19a96b19ab1cdd9f71843e46e7ded542aee1607
prerequisite-patch-id: fa4c88d32c053108b28c6f567b563ad29870a881
prerequisite-patch-id: f2d425237bac7c99e29a7e6c47a1e6362986b923
prerequisite-patch-id: 72df5f2d85ee2234887ad66d38be3dff51439346
prerequisite-patch-id: b8e5a06023a0d521946b6df41713f26d189d66b7

Best regards,
-- 
Junhui Liu <junhui.liu@pigmoral.tech>


