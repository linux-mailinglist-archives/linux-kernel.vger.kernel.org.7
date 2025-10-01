Return-Path: <linux-kernel+bounces-839517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 561BDBB1C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 23:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCEF419C4ADA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 21:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF96130F956;
	Wed,  1 Oct 2025 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbRmD57i"
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B326313520
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759352657; cv=none; b=RJhQmVBw1NjZedfDz2scjQ/j/l0bZztIznVDEWDdIiFHCKLZxymQrUadVTW08XaTM+En83kTs/QWl+aIPF1Q5uXUsc7O8GJW+7g0D7/NVx//k34E2LIAKEKzV6KpMlVRKl0pkGrnjGwlnTQ/R06FoU4Qhb5RaGNHw6XdogZjsck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759352657; c=relaxed/simple;
	bh=ZkL7LWnWXcINBIYfTYLOVlnT/4NvtyeplD+CvXeMct4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bDBCdFY0bbLLv5YutNLESU/u1Nmo7Cm1dFPVpi1gh0yLbYCfVfujuYK2JfA4KRd7UJdxHoDC1QcyyajY/IHnq3AkHgQjny/m4+C599tt+G10z/TLx6JuScTkZnphZKSWKhyplO+uAe+qr9euQH+MIygwj7GWSXZGhyzfEDxPkoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbRmD57i; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-63798d4b7caso248239a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 14:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759352653; x=1759957453; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ROUK26yKaM3+r4gp21QNYLzmmtvtE/oyrWIw8ssAYWA=;
        b=bbRmD57iuICNHsucBuggOmjTOlkbnD3+D3p8+3542Ndt2kzEjXC0r9iHE+RPyaK4yA
         jw0zeEr9rQ2aigkcRYvCSml0DPH9pFZWcpEm2YJKZU2VaLtJ+roceOleYTLbgR1xLGgL
         pdWiAWO5kDLr/u6RgbdohwZt+kGerI/esnAI57cva60o9vb8gsEyQ0DgzpSU4tUOY6D1
         VIXnDlJ8qmcbWlmsP4B8XFJnEtasjurtLF67hXkFDGUey7OeHYsshkBg8PZi2jF/dD4a
         gc0Y4A3CVbhPnRkdWLCxcj6g9uY986XXGDo5rBE0x5S3io4sjTSkzTMK2EvCFKKKhDwL
         cpEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759352653; x=1759957453;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ROUK26yKaM3+r4gp21QNYLzmmtvtE/oyrWIw8ssAYWA=;
        b=xTOqHmPTOnQpoCX1Be/+D5CULGn/548lHZCzinkibvJBjUyIaUtlVmgJIhYKVUyN/M
         BmdAOWdH79Zt0Fi4SWnDMMWcWM+AbCgPhyey1bTFZ7sf/s+UoE5fZBoJ2vaW1JbkwONS
         vAy4+mY82UF8aLPsCgs9F+TANvXO9A3DwxgFzTAHb1ENM7YAYqwO5rQbZHueoOvJz6Ks
         3K52s306JAezEMHvAHwVB7Z+YMaH4g1IMiS9laOzTFwiqGSMsMI5zOVRvFKnY5n2lt1G
         pg9FdfprEPTLoF/B3uwlLnn6m9Sq41Eq88tauTDD8JJXp+zhyDMwXBl7gXWpfILb7tSp
         BCAA==
X-Forwarded-Encrypted: i=1; AJvYcCUDBsDiZHhEMOX6GpCldjsLdDTjCB8MSJs2gmAooJrzNLq573NiR/ODLs/7K3kv5Pflzx2wmzO+NSQ2gBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRDx5U9N3VWan5lNHaR8QX/FJ2u9ac5QYwSsGkmTUn7iGLIGYu
	53Ro1NAmItll40q8koZhTyS9OZurOEj79PYZPqfqRG9NFwf42X3n0KGbIC2ZJd+AeGC2Yinzew=
	=
X-Google-Smtp-Source: AGHT+IHdBwWuloMVUG2aiVvBgPmXkgGhEuo55jA45O9PblNGid5/E1qaOmRe7tj9K1otJi7AohsCgKdN
X-Received: from edrj9.prod.google.com ([2002:aa7:c349:0:b0:633:3402:d21b])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:31eb:b0:634:cb54:810e
 with SMTP id 4fb4d7f45d1cf-63678c7b7f1mr4089985a12.31.1759352653423; Wed, 01
 Oct 2025 14:04:13 -0700 (PDT)
Date: Wed,  1 Oct 2025 23:02:21 +0200
In-Reply-To: <20251001210201.838686-22-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251001210201.838686-22-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2026; i=ardb@kernel.org;
 h=from:subject; bh=L5/WB9FoNS6vxFGUhS8qwMQNq/irqgYzuB5f44a5Viw=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIePudMkvCx4bO1zc0Py8oIBBvm1d5YOu6Ibcg0YiLeezT
 j1IXbymo5SFQYyLQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEzEfQPDPxvRymVXmZzqHHqE
 H76zk41vn7d4zkU39zc2Hz9Jr/Q8nMzI8KM/3Ek1telkGIvnq2JXr7y+npyFfaHl/y8FMn/7MfE IGwA=
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251001210201.838686-41-ardb+git@google.com>
Subject: [PATCH v2 19/20] arm64/xorblocks:  Switch to 'ksimd' scoped guard API
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, linux@armlinux.org.uk, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>, 
	Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/include/asm/xor.h | 22 ++++++++------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index befcd8a7abc9..c38e3d017a79 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -9,7 +9,7 @@
 #include <linux/hardirq.h>
 #include <asm-generic/xor.h>
 #include <asm/hwcap.h>
-#include <asm/neon.h>
+#include <asm/simd.h>
 
 #ifdef CONFIG_KERNEL_MODE_NEON
 
@@ -19,9 +19,8 @@ static void
 xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p2)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_2(bytes, p1, p2);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_2(bytes, p1, p2);
 }
 
 static void
@@ -29,9 +28,8 @@ xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p2,
 	   const unsigned long * __restrict p3)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_3(bytes, p1, p2, p3);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_3(bytes, p1, p2, p3);
 }
 
 static void
@@ -40,9 +38,8 @@ xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p3,
 	   const unsigned long * __restrict p4)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
 }
 
 static void
@@ -52,9 +49,8 @@ xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
 	   const unsigned long * __restrict p4,
 	   const unsigned long * __restrict p5)
 {
-	kernel_neon_begin();
-	xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
-	kernel_neon_end();
+	scoped_ksimd()
+		xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
 }
 
 static struct xor_block_template xor_block_arm64 = {
-- 
2.51.0.618.g983fd99d29-goog


