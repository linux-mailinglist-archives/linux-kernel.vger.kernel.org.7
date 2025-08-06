Return-Path: <linux-kernel+bounces-757711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5E6B1C5D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D5A824E23EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B167028B7F3;
	Wed,  6 Aug 2025 12:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C09woFrC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D228A3EC;
	Wed,  6 Aug 2025 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483241; cv=none; b=iNU3X6RzHwW5AYZamCpRabBiZnnnvW5EDAnhqyMvrJSI9TpEYxCSBexb2kJYi+MzHKfKgMfjETdi0vZF6DHlNsQ4wRz+WbRpTnxmO39IlBg23Lzvyu8g0B+THgOjQgNTufwZ7VxESszp/nAnsnqrz/mVAiDYPqw/rCxJCGiq0q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483241; c=relaxed/simple;
	bh=doBgBoI1eDAhaG6OMnM5npExQ5Xq3oY1DJugrOTICDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nMwOCL8CZ5JmDDMKTty86snbdIOaeCA8stEotPfHV7quHbmXC37AwLAJQO3t9RamMxHLaPevTyT4k4yVwZhJHNOGwaZ0o0xx5/QeNbM7aGUptjsoypLirM+9+09b0sPDRo9AGdH028AHY5mQRrbF1KqHpmvwVpaHL9BrpTQp8MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C09woFrC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9048AC4CEE7;
	Wed,  6 Aug 2025 12:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754483240;
	bh=doBgBoI1eDAhaG6OMnM5npExQ5Xq3oY1DJugrOTICDs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C09woFrCUEGZq0FbmDxDUaIgiO2R0r/q0+PB0meps7jh9RuSWjZgf73bA7Acnb/x8
	 t6J3ueNK/UKdvAW2bizxWXofnA/t2/TXiXXZxXPn4833o/HXQfmqEE1zwlExk0JUz2
	 a9l/010lMy7729O0uOPohIbpduebLBsI0RSAttveDOVLPFM/VPmpsIRmvvg3f6jr71
	 ymYtPGmNM3ShzoL84TRVtnRE9wituw8udPjlpKzJvrcYO2I5Fk62OCuswTt0gdLCzS
	 QLy5CgZ2KWMFU1/hJ1NFGnqkSAahuQwo66oz9PokBl5VG17oL6DeBuMXqflOFGyxv0
	 AV3Hs5oawPD4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6D9C87FCA;
	Wed,  6 Aug 2025 12:27:20 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Subject: [PATCH v6 0/2] riscv: Use GCR.U timer device as clocksource
Date: Wed, 06 Aug 2025 14:26:38 +0200
Message-Id: <20250806-riscv-time-mmio-v6-0-2df0e8219998@htecgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP5Jk2gC/2XNQQ7CIBCF4asY1mKAALauvIdxgTC0s6A0UImm6
 d2ldWFil/9L5puZZEgImVwOM0lQMGMcaujjgdjeDB1QdLWJYEIxKSRNmG2hEwagIWCkSosGmLe
 mMZ7UqzGBx9cm3u61e8xTTO/tQZHr+rUU31tFUkbtg1kvWiGc1td+Atul+BxPNgayekX9jDPne
 0NVowXHfSOUcQr+jWVZPgdTiCT2AAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754483238; l=2047;
 i=aleksa.paunovic@htecgroup.com; s=20250806; h=from:subject:message-id;
 bh=doBgBoI1eDAhaG6OMnM5npExQ5Xq3oY1DJugrOTICDs=;
 b=9DPdV5c9qizD7HjzGYQ8LKXMZ8Fn/tvCYTz34vZBapVKFt+CdKe2JKRgd4pIoZ8l/X4tZUFPb
 99CMc541WKPC/CYMLlzCWsSAC3wwKlWrsVhrmL2gAi6thDEqvJr/eKW
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=Dn4KMnDdgyhlXJNspQQrlHJ04i7/irG29p2H27Avd+8=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250806
 with auth_id=476
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

This series adds bindings for the GCR.U timer device and corresponding
driver support. Accessing the memory mapped mtime register in the GCR.U
region should be faster than trapping to M mode each time the timer
needs to be read.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
---
Changes in v6:
- Rename mti,gcru to mips,p8700-gcru
- Link to v5: https://lore.kernel.org/r/20250711-riscv-time-mmio-v5-0-9ed1f825ad5e@htecgroup.com

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
v5: https://lore.kernel.org/r/20250711-riscv-time-mmio-v5-0-9ed1f825ad5e@htecgroup.com

---
Aleksa Paunovic (2):
      dt-bindings: timer: mips,p8700-gcru
      riscv: Allow for riscv-clock to pick up mmio address.

 .../devicetree/bindings/timer/mips,p8700-gcru.yaml | 38 +++++++++++++
 arch/riscv/include/asm/clint.h                     | 26 ---------
 arch/riscv/include/asm/timex.h                     | 63 ++++++++++++----------
 drivers/clocksource/Kconfig                        | 12 +++++
 drivers/clocksource/timer-clint.c                  | 20 ++++---
 drivers/clocksource/timer-riscv.c                  | 34 ++++++++++++
 6 files changed, 128 insertions(+), 65 deletions(-)
---
base-commit: 038d61fd642278bab63ee8ef722c50d10ab01e8f
change-id: 20250424-riscv-time-mmio-5628e0fca8af

Best regards,
-- 
Aleksa Paunovic <aleksa.paunovic@htecgroup.com>



