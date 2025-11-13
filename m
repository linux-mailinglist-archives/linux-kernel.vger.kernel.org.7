Return-Path: <linux-kernel+bounces-899767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AED0BC58C1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B16354F457F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBFF35A93E;
	Thu, 13 Nov 2025 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWRVCEnu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A917328B57
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050234; cv=none; b=fZ/mmMshylOETQy/WKxH6XEk9bJuKmc5nLOn+Ernrw4uzJz2XSAAIyQdXgbW6dEz0VvCxciZj0SGvXDi1mHhCF8DMYChbnqyEtT1IdMqsCUbYHeoCEyUwkvjaH6tHQ0jKkOtIVxtQY6MtAUgx+I5H7sX55Q7vTKDjBjtRwiCvuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050234; c=relaxed/simple;
	bh=uoiSwBZ2fFI7bc6BNtYaJ1tZg2fIebS4JU9VTGUTOCA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kCLJ/ztaF6chrLu2E6QqNT0JQkSnybH1ziRuwxxEOovvIN8ogzNvdRManVXKsZCvAylDQYUm+ErQSQK6445PqbPiB8DJjhRW7cBc/7rb+VYMHXEq79m62LV2cU8w4fcG3CwwJC1A/xvK+bZLFXq0bggoy/kn1HiSCoSgHWhJFcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWRVCEnu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0A4A7C113D0;
	Thu, 13 Nov 2025 16:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763050234;
	bh=uoiSwBZ2fFI7bc6BNtYaJ1tZg2fIebS4JU9VTGUTOCA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=qWRVCEnuTbl9GxPtWoY8rpjnkc1n6jFEhG5XcIt0ZDjOOnLwpofn5Kee94FciU7hp
	 eZo0dlsADOk3+qed8NPJQx3Y41tHMbq1FEEIzgStc24Il7S0aT9Snl/qNZHvHMR2Dk
	 hUevieM5T1DEsWefRNGv+P4r/Dy4+nS83FoPHbTSWuDwOxhOL2LL9qtA6UU8L0p+Eg
	 fXxswU4D+0+KMd9QD6tIXS7WqowfQubRCy9Rb3ncbhaFYwn1NS8UoDS4VlTDkvNBdd
	 mMQc5UlIQMtdB09mZeyfFTCUQSueUIt+hPVrtLK2cZIvDWbaGVXOFoiCy/mh+uZ1yv
	 cm6o0OzEB8LqQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F378BCD8C99;
	Thu, 13 Nov 2025 16:10:33 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Thu, 13 Nov 2025 17:10:32 +0100
Subject: [PATCH v2] riscv: Update MIPS vendor id to 0x127.
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-mips-vendorid-v2-1-3279489b7f84@htecgroup.com>
X-B4-Tracking: v=1; b=H4sIAPcCFmkC/12MQQ7CIBBFr9LMWkyhJSauvIfposJQZlEgUImm4
 e6Odefq5/3kvR0KZsIC126HjJUKxcCgTh0YP4cFBVlmUL3Ssh+kWCkVUTHYmMkK6/ickUdegJ2
 U0dHr6N0nZk9li/l95Kv8vr8SW3+lKoUUozMP7UarB4c3v6FZcnyms4krTK21D4p8D3euAAAA
X-Change-ID: 20251031-mips-vendorid-df103aedf117
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Conor Dooley <conor.dooley@microchip.com>
Cc: Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Chao-ying Fu <cfu@wavecomp.com>, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763050233; l=1465;
 i=aleksa.paunovic@htecgroup.com; s=20250806; h=from:subject:message-id;
 bh=htvoMgY/r9ZZuZiS5oLQr0msScykVQRnyI0BkorgU5s=;
 b=DH0Z+mWY5DvQ1ZxYsIpMOn7gANn02HB+BPNMvkRg7eQ4UStyb1EgAQ25LZVGT9XGYIyk6D91j
 lGONnSsnfbdAof526t7owx6W4CImuzeLdyRHSBbcDvie3SEj0LzNJCv
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=Dn4KMnDdgyhlXJNspQQrlHJ04i7/irG29p2H27Avd+8=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250806
 with auth_id=476
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Chao-ying Fu <cfu@wavecomp.com>

[1] defines MIPS vendor id as 0x127. All previous MIPS RISC-V patches
were tested on QEMU, also modified to use 0x722 as MIPS_VENDOR_ID. This
new value should reflect real hardware.

[1] https://mips.com/wp-content/uploads/2025/06/P8700_Programmers_Reference_Manual_Rev1.84_5-31-2025.pdf

Fixes: a8fed1bc03ac ("riscv: Add xmipsexectl as a vendor extension")
Signed-off-by: Chao-ying Fu <cfu@wavecomp.com>
Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
---
Changes in v2:
- Fix "Fixes" formatting
- Move "MIPS_VENDOR_ID" to the correct place.
- Link to v1: https://lore.kernel.org/r/20251103-mips-vendorid-v1-1-4fcb5f4d53fe@htecgroup.com
---
 arch/riscv/include/asm/vendorid_list.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/vendorid_list.h b/arch/riscv/include/asm/vendorid_list.h
index 3b09874d7a6dfb8f8aa45b0be41c20711d539e78..7f5030ee1fcf830b17c6529e9c430fe19ac68b05 100644
--- a/arch/riscv/include/asm/vendorid_list.h
+++ b/arch/riscv/include/asm/vendorid_list.h
@@ -7,8 +7,8 @@
 
 #define ANDES_VENDOR_ID		0x31e
 #define MICROCHIP_VENDOR_ID	0x029
+#define MIPS_VENDOR_ID		0x127
 #define SIFIVE_VENDOR_ID	0x489
 #define THEAD_VENDOR_ID		0x5b7
-#define MIPS_VENDOR_ID		0x722
 
 #endif

---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251031-mips-vendorid-df103aedf117

Best regards,
-- 
Aleksa Paunovic <aleksa.paunovic@htecgroup.com>



