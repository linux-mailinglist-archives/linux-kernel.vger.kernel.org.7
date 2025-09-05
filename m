Return-Path: <linux-kernel+bounces-801964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53DFB44C21
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 05:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E1251685A3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 03:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C913F23FC4C;
	Fri,  5 Sep 2025 03:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b="XkMwQoCM"
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA224D599;
	Fri,  5 Sep 2025 03:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757041881; cv=pass; b=sPYdEfaeNLIrqhtykYKKZ5YEsdBBrhj2KMAhvSiaQ2AE5Lm4SMUY3KoaqtKTLWUg1Xu1v2AZon0DW+DUe45swnp1nW7JAquEEfBTmDW6mjRxLHX9yHrLI5uxE4wGCpuqk8NpeHLpd9anIyc8yTSKzXuGvggrudkIT1bq34qjXAA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757041881; c=relaxed/simple;
	bh=ZnxsnPR2qGPRWubPuRjnTr7DJ+AEdQqDJypwh1CpZjs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dQa1S+jXpZ6k3aKS6DJQWTye+zTk7WDNFBBqP06QA+RmGk9wCmBCSFgwnqY4HPmlybvY37P07ukndIkhiuSrwJM3yB2DEGdOuycccOTOMtuRRwFeCkEhRXkgiMUDGH44c9hs0ki1Au+on2R6helA+arMw9WTC9wve0QG7VzgRHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=kingxukai@zohomail.com header.b=XkMwQoCM; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
ARC-Seal: i=1; a=rsa-sha256; t=1757041850; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WFVmTex9qv0kj1rXyTVR/Bl0XZkb1nioWiK28RinGGyd26RIaW3CD8PwnNpa2iywrJIGwRrncp1ATfPBUiVRS4C+0Rxq7lDxwuhpruwqKdDlQ8D3vZ9+YGtJCNGwQPee07IbFwVuTSnvaPNLO2QEJPmA+93Kw1vIcnPkgn1CPWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757041850; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6THPioZ3D7kvh3Uhi2X3oA729ty8bXY0f3Z3hyWzCrM=; 
	b=ciLoD2JmFFwc/j1lJgInnqGUv9pJO0nceYQs4p9wkHyBOCFQFLRDAPwFEEyHaJY3UVkB2urILq3t1T2GjhhQoEGw7EBOsySz+06U5F408sHbsxPfP/CawdqmCiyedoJhcCjD53Nt+Vqt+Rwzu9s4Y5RMZ0M2S8h8RteTqxU6kX0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=kingxukai@zohomail.com;
	dmarc=pass header.from=<kingxukai@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757041850;
	s=zm2022; d=zohomail.com; i=kingxukai@zohomail.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=6THPioZ3D7kvh3Uhi2X3oA729ty8bXY0f3Z3hyWzCrM=;
	b=XkMwQoCMyv8MvSZbxh3LAw8LvO/X1W7WgG3HsEvVA0b1duEbTwDXmqxXtilhV7uK
	ZpEnFTStSXme5kvaFEtnu1oWjWAO0owknB59neg1vyy6A5E1iAk6iCcVLtT70DOUm2B
	h6gE13x0JWJ+6WzmvDdTJRFvQ2dCWYOGksGVwccw=
Received: by mx.zohomail.com with SMTPS id 1757041842818787.6325831712053;
	Thu, 4 Sep 2025 20:10:42 -0700 (PDT)
From: Xukai Wang <kingxukai@zohomail.com>
Subject: [PATCH v8 0/3] riscv: canaan: Add support for K230 clock
Date: Fri, 05 Sep 2025 11:10:21 +0800
Message-Id: <20250905-b4-k230-clk-v8-0-96caa02d5428@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ1UumgC/3XSwW7bMAwG4FcJfJ4LiZREKae9x9CDTFKL0abu7
 CzYWuTdKycdUieeT5bhj/xJ6L2ZdOx1arab92bUYz/1w0s9xG+bhnf55ae2vdRzAwacBRPazrV
 PgKbl56c2gS+IRSUwNFW8jlr6P+dqPx4v51F//a5FD5ePTZcnbXnY7/vDdmNUc4pkYswAQijRa
 gpRlNARC5P65ApdSucD72qW7UZUMrIjKKY+pYgzLCLEJQh2XmslySTczAl2/XQYxr/n8Y54jvA
 5CS0mOWJbXzpLydsYlej727Ab9rl/fqhp5wCVeWMB7llXCnmfOXHhdQYG7xkGYEoWnCdYsjn40
 X0Ja92Su8otm8Q5dOhi/k9XS/fM5+QzOh9Dsitd7ZeukJbcVg5gc7Kk0aiscPjH66pMXHKYOXV
 oMnD2sMb9lePtynzl5KLUbUBExfWZEcw9M5rExMTexbjSNVy7OuuXPMxdi8RUHFD9YYXTlRPed
 Kf5Vnmq97LzCeUm9OPpdPoAokxgQYEDAAA=
X-Change-ID: 20241206-b4-k230-clk-925f33fed6c2
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Xukai Wang <kingxukai@zohomail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Troy Mitchell <TroyMitchell988@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
Feedback-ID: rr08011227a46b04b3360ed4d7c06c3b2600001d6922f00b98d97d2c41562fc4ae8d6e8e52770fc5516bee96:zu08011227052fa289f5934febeb3679eb000047b5b9de0e89fced7f5f947c77c0c16b1344f52eb14cfcfd50:rf0801122dc40bacc37b2933ba4c65afab000005ce6d1b822013d01c4e9e880bf89bb885e1512cdc59b98bbbc7b213e19b6d:ZohoMail
X-ZohoMailClient: External

This patch series adds clock controller support for the Canaan Kendryte
K230 SoC. The K230 SoC includes an external 24MHz OSC, 4 internal
PLLs and an external pulse input, with the controller managing these
sources and their derived clocks.

The clock tree and hardware-specific definition can be found in the
vendor's DTS [1],
and this series is based on the K230 initial series [2].

Link: https://github.com/ruyisdk/linux-xuantie-kernel/blob/linux-6.6.36/arch/riscv/boot/dts/canaan/k230_clock_provider.dtsi [1]
Link: https://lore.kernel.org/linux-clk/tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com/ [2]

Co-developed-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Troy Mitchell <TroyMitchell988@gmail.com>
Signed-off-by: Xukai Wang <kingxukai@zohomail.com>

---
Changes in v8:
- Rename dts node name "timer_pulse_in" to "clock-50m"
- Drop redundant comment and 'minItems' of hardware in dt-binding.
- Link to v7: https://lore.kernel.org/r/20250730-b4-k230-clk-v7-0-c57d3bb593d3@zohomail.com

Changes in v7:
- Rename K230_PLL_STATUS_MASK to K230_PLL_LOCK_STATUS_MASK
- Add clkdev for PLLs to register lookup
- Add macros to generate repeat variables definition
- Refine the definitions of k230 clocks
- Split composite clks into rate, gate, mux, fixed_factor clk
- Replace k230_clk_hw_onecell_get with of_clk_hw_onecell_get for
  clock provider
- Drop k230_sysclk and use clk_mux, clk_gate and clk_fixed_factor
  as the data structures.
- Replace one loop registration with individual registration for
  each type.
- Link to v6: https://lore.kernel.org/r/20250415-b4-k230-clk-v6-0-7fd89f427250@zohomail.com

Changes in v6:
- Remove some redundant comments in struct declaration.
- Replace the Vendor's code source link with a new one.
- Link to v5: https://lore.kernel.org/r/20250320-b4-k230-clk-v5-0-0e9d089c5488@zohomail.com

Changes in v5:
- Fix incorrect base-commit and add prerequisite-patch-id.
- Replace dummy apb_clk with real ones for UARTs.
- Add IDs of UARTs clock and DMA clocks in the binding header.
- Replace k230_clk_cfgs[] array with corresponding named variables.
- Remove some redundant checks in clk_ops.
- Drop the unnecessary parenthesis and type casts.
- Modify return value handling in probe path to avoid redundant print.
- Link to v4: https://lore.kernel.org/r/20250217-b4-k230-clk-v4-0-5a95a3458691@zohomail.com

Changes in v4:
- Remove redundant onecell_get callback and add_provider function
for pll_divs.
- Modify the base-commit in cover letter.
- Link to v3: https://lore.kernel.org/r/20250203-b4-k230-clk-v3-0-362c79124572@zohomail.com

Changes in v3:
- Reorder the defination and declaration in drivers code.
- Reorder the properties in dts node.
- Replace global variable `k230_sysclk` with dynamic memory allocation.
- Rename the macro K230_NUM_CLKS to K230_CLK_NUM.
- Use dev_err_probe for error handling.
- Remove unused includes.
- Link to v2: https://lore.kernel.org/r/20250108-b4-k230-clk-v2-0-27b30a2ca52d@zohomail.com

Changes in v2:
- Add items and description.
- Rename k230-clk.h to canaan,k230-clk.h
- Link to v1: https://lore.kernel.org/r/20241229-b4-k230-clk-v1-0-221a917e80ed@zohomail.com

---
Xukai Wang (3):
      dt-bindings: clock: Add bindings for Canaan K230 clock controller
      clk: canaan: Add clock driver for Canaan K230
      riscv: dts: canaan: Add clock definition for K230

 .../devicetree/bindings/clock/canaan,k230-clk.yaml |   59 +
 arch/riscv/boot/dts/canaan/k230-canmv.dts          |   11 +
 arch/riscv/boot/dts/canaan/k230-evb.dts            |   11 +
 arch/riscv/boot/dts/canaan/k230.dtsi               |   26 +-
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-k230.c                             | 2456 ++++++++++++++++++++
 include/dt-bindings/clock/canaan,k230-clk.h        |  223 ++
 8 files changed, 2785 insertions(+), 8 deletions(-)
---
base-commit: 0eea987088a22d73d81e968de7347cdc7e594f72
change-id: 20241206-b4-k230-clk-925f33fed6c2
prerequisite-patch-id: deda3c472f0000ffd40cddd7cf6d3b5e2d7da7dc

Best regards,
-- 
Xukai Wang <kingxukai@zohomail.com>


