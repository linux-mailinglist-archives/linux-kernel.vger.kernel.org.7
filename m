Return-Path: <linux-kernel+bounces-744573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6554FB10EA6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A46DF5C21A6
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDCB2ED858;
	Thu, 24 Jul 2025 15:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McGJNl0P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073502EA75A;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370615; cv=none; b=hpjKskKFnDP+BTTdCMkiQz373zUbZSh0aMtjYcEZUReghjNOH/+DB3vjbEScuLcIV6+3i2xifgc5us5YgU4uyzsRoemHjIYHIejO9xt3sTMvl3YYrJ59vQhU8euwVjtzmkQn8W+/9a0KV6P996cJxnhZ9nKvj1ftfuJHqTqqUnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370615; c=relaxed/simple;
	bh=JIi4MqCnTBTpO0jvbIQfNOEuOh4NNnMUtSNnb8YegrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K3jWdhNqCQ7Bvn9xyWMUpWAdsa8/R4NpS2oEIZT0afUDWf7huIu/TWMIii5q+OUew3GiJ3hrw97FVZpWIqoG26VaE4oEDjqp9wVkTP4hqicBpK5SrO9yeSDRRZEp6UwhWIHKvXNZcLO9P8Ejki5uU5XZHRP2uJFkvcR8+i37lwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McGJNl0P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85750C116D0;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370614;
	bh=JIi4MqCnTBTpO0jvbIQfNOEuOh4NNnMUtSNnb8YegrY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=McGJNl0PvMGj9X5HL2FaCTjI2IQBUM2p8mFAN3BhinzjJv6+SYAbpIHgEh+PC9EYv
	 l15goHHubFCSXPH9jduEmPTENa7IksoXCeHe/driR2n0dIeZof1TLpGyuLkjLT+7iC
	 qtL97CwC+02BU72B3K+VqMI5hB1NJnzDMaEPt+1wSEG1qN3Ih+MIwv5Lb2ScMrAL9Q
	 AVJli42SkXXtJl8eDAXjRhFflm7Qk0PgApOAoESEFiCtP1GrD0vf6V/+8TSPB6FTW+
	 eMrMMif+/ZlueqgrCB2Fi3TtV0lYBDSKOmMkQcxr7kFsE3ModCe2ziQd1K52QTVtTM
	 9RxGm5IXc8dDA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D870C83F26;
	Thu, 24 Jul 2025 15:23:34 +0000 (UTC)
From: Aleksa Paunovic via B4 Relay <devnull+aleksa.paunovic.htecgroup.com@kernel.org>
Date: Thu, 24 Jul 2025 17:23:30 +0200
Subject: [PATCH v5 6/7] riscv: Add tools support for xmipsexectl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-p8700-pause-v5-6-a6cbbe1c3412@htecgroup.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753370612; l=1792;
 i=aleksa.paunovic@htecgroup.com; s=20250514; h=from:subject:message-id;
 bh=ptovTVTWzY5ypMsdB9qvG2p0IpF3HX1Qk6cCHZ2BJ7Y=;
 b=cvYEEQqQIscI391aoxjPcy38xGkvOs72Op5o37Fz5zGhuJJuNcrQhOxlfmlgERoDpENItBnq9
 kxhulaZVCwvDvIUoa6kfudy7fSW90tgqTJ6jiIKVIE6S+mTGgzMZ/pR
X-Developer-Key: i=aleksa.paunovic@htecgroup.com; a=ed25519;
 pk=gFVSVYLKAgJiS5qCnDyUMGOFuczv8C6o0UmRs+fgisA=
X-Endpoint-Received: by B4 Relay for aleksa.paunovic@htecgroup.com/20250514
 with auth_id=403
X-Original-From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reply-To: aleksa.paunovic@htecgroup.com

From: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>

Use the hwprobe syscall to decide which PAUSE instruction to execute in
userspace code.

Signed-off-by: Aleksa Paunovic <aleksa.paunovic@htecgroup.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 tools/arch/riscv/include/asm/vdso/processor.h | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/tools/arch/riscv/include/asm/vdso/processor.h b/tools/arch/riscv/include/asm/vdso/processor.h
index 0665b117f30f2766a23446fbd7c8ce82d1843a93..b089d4be998f4ab7bc43a96496a6c6f1bb38da4d 100644
--- a/tools/arch/riscv/include/asm/vdso/processor.h
+++ b/tools/arch/riscv/include/asm/vdso/processor.h
@@ -4,26 +4,33 @@
 
 #ifndef __ASSEMBLER__
 
+#include <asm/hwprobe.h>
+#include <sys/hwprobe.h>
+#include <asm/vendor/mips.h>
+#include <asm/vendor_extensions/mips.h>
 #include <asm-generic/barrier.h>
 
 static inline void cpu_relax(void)
 {
+	struct riscv_hwprobe pair;
+	bool has_mipspause;
 #ifdef __riscv_muldiv
 	int dummy;
 	/* In lieu of a halt instruction, induce a long-latency stall. */
 	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
 #endif
 
-#ifdef CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE
-	/*
-	 * Reduce instruction retirement.
-	 * This assumes the PC changes.
-	 */
-	__asm__ __volatile__ ("pause");
-#else
-	/* Encoding of the pause instruction */
-	__asm__ __volatile__ (".4byte 0x100000F");
-#endif
+	pair.key = RISCV_HWPROBE_KEY_VENDOR_EXT_MIPS_0;
+	__riscv_hwprobe(&pair, 1, 0, NULL, 0);
+	has_mipspause = pair.value & RISCV_HWPROBE_VENDOR_EXT_XMIPSEXECTL;
+
+	if (has_mipspause) {
+		__asm__ __volatile__(MIPS_PAUSE);
+	} else {
+		/* Encoding of the pause instruction */
+		__asm__ __volatile__(".4byte 0x100000F");
+	}
+
 	barrier();
 }
 

-- 
2.34.1



