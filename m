Return-Path: <linux-kernel+bounces-873326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFA6C13B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 10:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0835B4EB9BF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 09:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE4D2DD61E;
	Tue, 28 Oct 2025 09:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="gKlVBm8+"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4372D978C
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761642205; cv=none; b=G/fZ3EKtsbulASqHLMKPKs/koxjBbSdKhhoEziXaRkMGRZuRdJVQPRSGafXGFHyCknqYKuKy4HONO8hM0nD3fKWhZUKi/HBdwTH7x+21w2R2kNody1PVm3gxHqkBr998z61JaJHf5oZpQQEDhVPJtPtUnOppvxpBmgQn83mRF3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761642205; c=relaxed/simple;
	bh=oa18QKX0l9/zrNbFelaAjri3Nu2ogEOJV9SkekhMHUQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tU1kQ+ku6dqcOXziaUx5VF/cxb3uxNEFXOGQgx67rqFCxi6SxIy4NsX2qLX3rvuEqB3GVmFXDccDee7qJHDIu1pUMyG/ih2OB0OQcQ2Xy7xmTBtX6TWgtBKihEt4lbIE2Euov89FNEqzFTBJl/+nQHFCm0hw0nqzG2LKrQo7m7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=gKlVBm8+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1761642199;
	bh=oa18QKX0l9/zrNbFelaAjri3Nu2ogEOJV9SkekhMHUQ=;
	h=From:Date:Subject:To:Cc:From;
	b=gKlVBm8+5rI8Ix1xm8HYkLa0WTs+Xa9sbAw5SjORYeyAVZW1efCTXFr6dzFTvmf4G
	 y7HsaCbfkJHF6uW2GaS4ouJ/vr0ZJ6hhiUZ4hZLhXhz2J9y8gz/GpACd5hygdX9KOc
	 SOuG3xde40rXzLz1d93xLI0MMIJxXmc1C4dasNvI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 28 Oct 2025 10:02:55 +0100
Subject: [PATCH] um: Avoid circular dependency on asm-offsets in pgtable.h
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251028-uml-offsets-circular-v1-1-601c363cfaaa@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAL6GAGkC/x3MSQqAMAxA0atI1gba4oRXERdaUw04kagI4t0tL
 t/i/weUhEmhTh4Qulh5WyNsmoCfunUk5CEanHG5Na7Cc5lxC0HpUPQs/pw7wSLrhyzvDdnSQUx
 3ocD3v23a9/0A7IcIwGYAAAA=
X-Change-ID: 20251028-uml-offsets-circular-64bd45b0e172
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Tiwei Bie <tiwei.btw@antgroup.com>
Cc: Johannes Berg <johannes.berg@intel.com>, linux-um@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761642198; l=2009;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oa18QKX0l9/zrNbFelaAjri3Nu2ogEOJV9SkekhMHUQ=;
 b=OVVJ6XiAIwfOGNjqdKBxkJURJ81/moXtAdeO8yQBzBW9u2Vin6xW5z2/tz1VDO6XEWJVxEWXD
 Bb29WTwZKlaCE5h6M6dh02jtSGHRJIP2IiSXVbUvLiuAtiNBmGGCE38
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Recent changes have added an include of as-layout.h to pgtable.h.
However this introduces a circular dependency during asm-offsets
generation as as-layout.h depends on asm-offsets and pgtable.h is an
input for asm-offsets.

Building from a clean state results in the following error:

  CC      arch/um/kernel/asm-offsets.s
In file included from arch/um/include/asm/pgtable.h:48,
                 from include/linux/pgtable.h:6,
                 from include/linux/mm.h:31,
                 from include/linux/pid_namespace.h:7,
                 from include/linux/ptrace.h:10,
                 from include/linux/audit.h:13,
                 from arch/um/kernel/asm-offsets.c:8:
arch/um/include/shared/as-layout.h:9:10: fatal error: generated/asm-offsets.h: No such file or directory
    9 | #include <generated/asm-offsets.h>
      |          ^~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[4]: *** [scripts/Makefile.build:182: arch/um/kernel/asm-offsets.s] Error 1

As the inclusion of as-layout.h in pgtable.h is not yet needed while
asm-offsets are generated, break the dependency here.

Fixes: a7f7dbae94a5 ("um: Remove file-based iomem emulation support")
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 arch/um/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 1a0d7405e97c..3b42b0f45bf6 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -45,7 +45,9 @@ extern unsigned long *empty_zero_page;
  * area for the same reason. ;)
  */
 
+#ifndef COMPILE_OFFSETS
 #include <as-layout.h> /* for high_physmem */
+#endif
 
 #define VMALLOC_OFFSET	(__va_space)
 #define VMALLOC_START	((high_physmem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))

---
base-commit: aa3e6faf620b1091ae85b07c0106918d48fcce05
change-id: 20251028-uml-offsets-circular-64bd45b0e172

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


