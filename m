Return-Path: <linux-kernel+bounces-830394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF92B998B1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBF019C1174
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD21D2E6CBD;
	Wed, 24 Sep 2025 11:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C+IkBcFv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174A92E3B0D;
	Wed, 24 Sep 2025 11:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758712269; cv=none; b=YinnGAwIJ4WZRzUKbVbPGFySm9R5yTfbkaCXwLxiVoU0CmZhGFmDzQvrFhrHFdumPwpC0hhp4wO9weKcYihEiDc7s4D4peIyu8TnA7kimXpG+CZ8sL0KqBTzsNJgoTmn0yevxfWL2wmLwy7NzXaUyWdnk4//Mkmx9IFoMl4toGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758712269; c=relaxed/simple;
	bh=doBgBoI1eDAhaG6OMnM5npExQ5Xq3oY1DJugrOTICDs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KuCiVQR+c94JiVfMNSyaft2AsR3VP9rnI5eqXHYRJEsOnBuzknUD4QU76o03XPHoK07pC2zn4WGC8n7c4Z3Wd263v+1VfPio8n/hZ80LSugtMLkwepjteYh8jTVy92S/7i9inOkWAozDgFup2yweWs1C+Kj+vEvP5l1jyPsPgG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C+IkBcFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9094FC4CEF0;
	Wed, 24 Sep 2025 11:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758712268;
	bh=doBgBoI1eDAhaG6OMnM5npExQ5Xq3oY1DJugrOTICDs=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=C+IkBcFvRHMhMqSTAi7QQvT426ov1Xu2lUdeVYhwFMZ/ySB+bA9+EkAeUtMjEoDzq
	 hdgcIDbRhBuRXaITeBuyUwDm0WKiprteqxn4OwZ9WJgd+OW7yWorlsg9iC+29qhvG1
	 x3luhyhCR4ln1Pgdt9UOW28fPZw8+otc+Zi69pMbQzZQpXIV7vjgV0TDrAmiSBPumf
	 JBs+eh3+7HMARx8f6ph1+OMtreW/srOdiCHC9Klc4zI3JYPSM/3mBqlrBI8pZYpSal
	 3K0kZora+PXHeg9JXNfEbKEjp/iQhE335xgQ5IHVeAmAjB+n/1ejXtKnyytdm4/FDV
	 4T6bsdP7YnF6g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8525ACAC5A7;
	Wed, 24 Sep 2025 11:11:08 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Subject: [PATCH RESEND v6 0/2] riscv: Use GCR.U timer device as clocksource
Date: Wed, 24 Sep 2025 13:10:36 +0200
Message-Id: <20250924-riscv-time-mmio-v6-0-9c6158a14b37@htecgroup.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758712265; l=2047;
 i=aleksa.paunovic@htecgroup.com; s=20250806; h=from:subject:message-id;
 bh=doBgBoI1eDAhaG6OMnM5npExQ5Xq3oY1DJugrOTICDs=;
 b=cGoKWPef+x/OJkYs0CfESXFWfVLvr4WX+Yo6owR4wQKjP0iD42TLYxf1tYO05HzoeQYXSwtF0
 DXSxwdt/bd2Df9BY7kAWrV0PLXuzNvKx6zZxEiTuuxwiSE2do/xWQXQ
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



