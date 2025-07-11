Return-Path: <linux-kernel+bounces-728320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BF1B02694
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 23:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD69C4A69CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2F9220F23;
	Fri, 11 Jul 2025 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0fzv1J/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6FC149DFF;
	Fri, 11 Jul 2025 21:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752271042; cv=none; b=EbC3Yn4DfFvpvrE4HcHhCo1u0lfnA5l0FYP9xprZ0VPr/PjphZPjCnd2lxJwJZrY++IqcksYO6J3MCGpjQlhn4rUGSDCeUGl+FqJkS8ZqgbKRsKni9K2cUD0bUrGc16aSt4qNjd2Ykp8XEIX2Ev/YZ+iL/pofL/BkJ3eaTEHvxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752271042; c=relaxed/simple;
	bh=rKK6/zAeDGlf2Rcw+XgRGzGg1wLNDrZiOXO05uwH78I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=r/MpoT5nrNiFT8NpR/cUYQGegX+yeMZlwSRb+whzQL8BjTayKJ/STQTuQFBksDyfGFUjZhcLFL4v19awMKmd1qf5VNLYRxamqFCiz6wMr9DPZKCW+rJ3YxVE8H9iGXt2V2uN5tyRmV3axl5/f94u/b26wZjpoo06/LryZQ+YawI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0fzv1J/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E708AC4CEED;
	Fri, 11 Jul 2025 21:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752271042;
	bh=rKK6/zAeDGlf2Rcw+XgRGzGg1wLNDrZiOXO05uwH78I=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C0fzv1J/J1OS2rZ8cREfFFwlyuwaUdPYY6YfQVJku7fQJMUe3hDMvrP6cdjytJmsb
	 T0F+d+derx/9PxhuUHck8ivlq5D+33XlUumgQWon/YKev1in7Mt0++If8KQpwC2Mq1
	 fLWx2DnOsZm7yK4y3K7BM5DUDdn2cYGJz7+OTBGPvKbUQlJ87Sx5OmJqtyImDFMLqa
	 76Uru8EIfuUSvgSeLbIDWvz8HI/C8pV2e3xtKJkx7/3SI4fFrzX+JVFfyT/uR6H0At
	 oE5h1o9a78cf4sXvwyW83mxviXOMqUiWRSH/1d/UQGYRf24URZt1cb910fs1DH0iqu
	 qx/RxqzcLyY2A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D643DC83F21;
	Fri, 11 Jul 2025 21:57:21 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Subject: [PATCH v5 0/2] riscv: Use GCR.U timer device as clocksource
Date: Fri, 11 Jul 2025 23:56:44 +0200
Message-Id: <20250711-riscv-time-mmio-v5-0-9ed1f825ad5e@htecgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJyIcWgC/2WNQQ6CMBBFr0K6dkydtARdeQ/CAocpzKKUtNhoC
 He34tLle8l/f1OJo3BSt2pTkbMkCXMBe6oUTf08MshQWKFGqw0aiJIowyqewXsJYGtsWDvqm96
 psloiO3kdxbYrPElaQ3wfB9l87a9lL/+tbEADPTQ5vCIOdX2fVqYxhudypuBVt+/7BzH0MY6yA
 AAA
X-Change-ID: 20250424-riscv-time-mmio-5628e0fca8af
To: Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-riscv@lists.infradead.org, 
 Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752271040; l=1798;
 i=aleksa.paunovic@htecgroup.com; s=20250514; h=from:subject:message-id;
 bh=rKK6/zAeDGlf2Rcw+XgRGzGg1wLNDrZiOXO05uwH78I=;
 b=KytOxScst8FlcaqhCNUXLNgl4U+YRyv7Yo59CwjWeu9RGKO7KU14DknmC2ThSZqyiN+EJWQ1u
 i925hQY2QoLCIseXEBHReLzdPoZyna1zQlpJcjdIQHTIeO/BV4wy6H7
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=gFVSVYLKAgJiS5qCnDyUMGOFuczv8C6o0UmRs+fgisA=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250514
 with auth_id=403
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

This series adds bindings for the GCR.U timer device and corresponding
driver support. Accessing the memory mapped mtime register in the GCR.U
region should be faster than trapping to M mode each time the timer
needs to be read.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
---
Changes in v5:
- Fixed build issues on 32-bit RISC-V and sparse warnings
- Remove clint_time_val and clint.h, replace with riscv_time_val
- Depend on RISCV_TIMER in Kconfig
Changes in v4:
- Remove "select" from mti,gcru.yaml.
- Refactor the driver to use function pointers instead of static keys.

Previous versions:
v1: https://lore.kernel.org/lkml/20241227150056.191794-1-arikalo@gmail.com/#t
v2: https://lore.kernel.org/linux-riscv/20250409143816.15802-1-aleksa.paunovic@htecgroup.com/
v3: https://lore.kernel.org/linux-riscv/DU0PR09MB61968695A2A3146EE83B7708F6BA2@DU0PR09MB6196.eurprd09.prod.outlook.com/
v4: https://lore.kernel.org/r/20250514-riscv-time-mmio-v4-0-cb0cf2922d66@htecgroup.com

---
Aleksa Paunovic (2):
      dt-bindings: timer: mti,gcru
      riscv: Allow for riscv-clock to pick up mmio address.

 .../devicetree/bindings/timer/mti,gcru.yaml        | 38 +++++++++++++
 arch/riscv/include/asm/clint.h                     | 26 ---------
 arch/riscv/include/asm/timex.h                     | 63 ++++++++++++----------
 drivers/clocksource/Kconfig                        | 12 +++++
 drivers/clocksource/timer-clint.c                  | 20 ++++---
 drivers/clocksource/timer-riscv.c                  | 34 ++++++++++++
 6 files changed, 128 insertions(+), 65 deletions(-)
---
base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
change-id: 20250424-riscv-time-mmio-5628e0fca8af

Best regards,
-- 
Aleksa Paunovic <aleksa.paunovic@htecgroup.com>



