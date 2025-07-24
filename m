Return-Path: <linux-kernel+bounces-744570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB34B10EA4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:26:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 793595C1595
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AB02ECD2C;
	Thu, 24 Jul 2025 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZePNR7yK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19B82E9EBA;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370614; cv=none; b=Qq+N60sb9IcGGVkm+DiPkoa/RFXZIj4k15k/ZYjSdkT1CLrHpXorQZw9cYA199jXZA+w33snhHvorYJJp+NQ/Fj24r9z8fWh/Rgdxcslbs4LNUV/EA1yT6czHeHDv/07jT5W1eatZa+qls4Do0Qm37kl0lA7NV9IGzlnL6fiCOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370614; c=relaxed/simple;
	bh=lAX1g5gop0MIerHUXBGrgL0yJFgFvnxoPSCMB7zGP24=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GMA8o0KdBesSoJF43t9IIDUZjGGZNyjCmXvQOXf6WUECxMPiEGqeTafaJF4XbB3WcLN26ksd7hSwDzYqZaevbPycED6V6KGcJRit3w2sSP9JE0mzCPLtvq6B3vbjpuBG6AcVt1wzvv7QtGuWk044pD83OH4M8Hl2JElDj1zGzlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZePNR7yK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5EB48C4CEF9;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370614;
	bh=lAX1g5gop0MIerHUXBGrgL0yJFgFvnxoPSCMB7zGP24=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=ZePNR7yK580sLeSuLGIkVx1swhrbANednGD3UdzZCfEqeXsQwclGioY4JIwuJJaoq
	 xxIAwYBF177nmMyYT5gMZv0Mha9qXzFX/32ji/uevoCRNb4Cc0Ki8uzRzPFwexR+On
	 oNzU/0XZhCcc5TzRMKkB7aHQLpry4ufP50qx3Jncbd3L63x/6jfnQn4Og4P4eqmU82
	 95eGlu0qpIBJp7ArXR1YofYLCF0NTlICMZrbTlH1hU1WH2oryLup1+GGrWlVuSq1P1
	 NkAPLKhDAwweYZsKygl0HdBxeSGgnVbZjELOD39mz7bt4QGyCUb5NV2lm87yEwxlLs
	 DZCy5UwLWE1Ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544C5C83F26;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Thu, 24 Jul 2025 17:23:27 +0200
Subject: [PATCH v5 3/7] riscv: Add xmipsexectl instructions
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250724-p8700-pause-v5-3-a6cbbe1c3412@htecgroup.com>
References: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
In-Reply-To: <20250724-p8700-pause-v5-0-a6cbbe1c3412@htecgroup.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Jonathan Corbet <corbet@lwn.net>
Cc: Palmer Dabbelt <palmer@sifive.com>, Conor Dooley <conor@kernel.org>, 
 Djordje Todorovic <djordje.todorovic@htecgroup.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Aleksa Paunovic <aleksa.paunovic@htecgroup.com>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370612; l=1601;
 i=aleksa.paunovic@htecgroup.com; s=20250514; h=from:subject:message-id;
 bh=UiyuNpcwz9mf/w7Z4EE+JWW7TpbY11AARRS/HoJAhyY=;
 b=kXnwDRLnXwjTZ4lr4Rsy/L+SAr13tjMAbNWyOnuvvm6e4zSvz3YLRNrh0IR7dMh+8xMX09US2
 Wwjwe0PaWVDBXThnyVKeFAMlGqY3bEoiyc6llpvBoqixkCM53+F0yMu
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=gFVSVYLKAgJiS5qCnDyUMGOFuczv8C6o0UmRs+fgisA=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250514
 with auth_id=403
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>

Add xmipsexectl instruction opcodes. This includes the MIPS.PAUSE,
MIPS.EHB, and MIPS.IHB instructions.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/vendor_extensions/mips.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/riscv/include/asm/vendor_extensions/mips.h b/arch/riscv/include/asm/vendor_extensions/mips.h
index 133e55985d827ce7d6057004b590bdcbbdb1ec8c..ea8ca747d691df2e9ee7e5360f800fbdccfe3945 100644
--- a/arch/riscv/include/asm/vendor_extensions/mips.h
+++ b/arch/riscv/include/asm/vendor_extensions/mips.h
@@ -15,4 +15,23 @@ struct riscv_isa_vendor_ext_data_list;
 extern struct riscv_isa_vendor_ext_data_list riscv_isa_vendor_ext_list_mips;
 #endif
 
+/* Extension specific instructions */
+
+/*
+ * All of the xmipsexectl extension instructions are
+ * ‘hint’ encodings of the SLLI instruction,
+ * with rd = 0, rs1 = 0 and imm = 1 for IHB, imm = 3 for EHB,
+ * and imm = 5 for PAUSE.
+ * MIPS.PAUSE is an alternative opcode which is implemented to have the
+ * same behavior as PAUSE on some MIPS RISCV cores.
+ * MIPS.EHB clears all execution hazards before allowing
+ * any subsequent instructions to execute.
+ * MIPS.IHB clears all instruction hazards before
+ * allowing any subsequent instructions to fetch.
+ */
+
+#define MIPS_PAUSE	".4byte 0x00501013\n\t"
+#define MIPS_EHB	".4byte 0x00301013\n\t"
+#define MIPS_IHB	".4byte 0x00101013\n\t"
+
 #endif // _ASM_RISCV_VENDOR_EXTENSIONS_MIPS_H

-- 
2.34.1



