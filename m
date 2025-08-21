Return-Path: <linux-kernel+bounces-779195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D15B2F049
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DECD7B0FF1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E41C2EA16C;
	Thu, 21 Aug 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OM7h2I3y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jax6QL6L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E76F2E92D6
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763012; cv=none; b=NL0ziGOXleHGO4ooLjovMzgQwgwWZn64Mr584o0/NuIBQpPXVuMcW0UtpkiDXWmAwjlOJiWIHohf76tUwMjggBJT5dQ57aD3B5tdYNwbEu1kI8jzjKI04Xf3bBEZiGqOmveRF8buycTPsA4mKrZ4LqmfldzGvlZLLkzBj0IlEZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763012; c=relaxed/simple;
	bh=CPvrFNkZy39LJ/1qgKk+040oslCnw6l8oUx7U4UhgrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fx50RgB8jNkiQTR4d9+x7ljJSeN2O4tr0Crlh1P0LI82S2LInxbfdixJuNfalOZYja1j6w0WJNQ0uPLQmJXv8HdW0gKhD47TBsFxiCCHXwwOKQDQeXZ2UwUJh++ioZzfUE57APOsINY7t+WXQWRkZ/6SGeDcCVxO1oxeXA1no9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OM7h2I3y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jax6QL6L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755763009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdUDX/GrjPHmpkOj/PiRCkrMG28qz0YSUiJOCwDTrUc=;
	b=OM7h2I3yPoHWiAlU/8iJbV05MyFHH2CA2JDGLNf6olHGE9trv93VhDGVjBIiHfkFM4TPW9
	if3Uy5WPdfEgZM9+kylqj6wFB7x/YfzGEKJKk3lKvDng4glIfmb09zln0KaAH07xfCE3EQ
	PtjPPICi7anc7BuTzgXqRt9+Mf3BXn7nOzgi0jTRnSv2Qe7Am49kDKL4FAcT4stM5Gbh4t
	cUvwViA/OvtI4L6DWWvfpN7pzH+asWov0S4K5zqp9vbbf8DNbZAAl2++KAeEaIxg5Yqrwi
	rQnySe4U5qPp3UDXnm/Bnpt1EV7JGMQNYRDyxR5FCc65vU3l6vZCS07r7prlQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755763009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RdUDX/GrjPHmpkOj/PiRCkrMG28qz0YSUiJOCwDTrUc=;
	b=Jax6QL6LWo4yYn9sfRGf6Bg+4vl/swqgZlwvI1GV+Idj+r0Pr2s6+c8S1juQsDBLzODl9X
	LPqq0cYcRqT8jMBA==
Date: Thu, 21 Aug 2025 09:56:44 +0200
Subject: [PATCH 1/3] arm64: uapi: Provide correct __BITS_PER_LONG for the
 compat vDSO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-vdso-arm64-compat-bitsperlong-v1-1-700bcabe7732@linutronix.de>
References: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
In-Reply-To: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: John Stultz <jstultz@google.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755763005; l=1342;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=CPvrFNkZy39LJ/1qgKk+040oslCnw6l8oUx7U4UhgrE=;
 b=NkBFFQGs2Gl66H5k5IJI1BOxRJy+DwLwXfPQyxDfKIJHuMIm3m6GjjUNwMXPkx9JqfNqgzbuE
 Nu/I5TPfzydCJWh+yWXMDfYTwgncTA7dW20eskh4qspCC1iFmLPIiZf
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic vDSO library uses the UAPI headers. On arm64 __BITS_PER_LONG is
always '64' even when used from the compat vDSO. In that case __GENMASK()
does an illegal bitshift, invoking undefined behaviour.

Change __BITS_PER_LONG to also work when used from the comapt vDSO.
To not confuse real userspace, only do this when building the kernel.

Reported-by: John Stultz <jstultz@google.com>
Closes: https://lore.kernel.org/lkml/CANDhNCqvKOc9JgphQwr0eDyJiyG4oLFS9R8rSFvU0fpurrJFDg@mail.gmail.com/
Fixes: cd3557a7618b ("vdso/gettimeofday: Add support for auxiliary clocks")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/include/uapi/asm/bitsperlong.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/bitsperlong.h b/arch/arm64/include/uapi/asm/bitsperlong.h
index 485d60bee26ca313ad15797f230efe10072befc9..d59730975f30c0764577ec20dfafa33373311e21 100644
--- a/arch/arm64/include/uapi/asm/bitsperlong.h
+++ b/arch/arm64/include/uapi/asm/bitsperlong.h
@@ -17,7 +17,12 @@
 #ifndef __ASM_BITSPERLONG_H
 #define __ASM_BITSPERLONG_H
 
+#if defined(__KERNEL__) && !defined(__aarch64__)
+/* Used by the compat vDSO */
+#define __BITS_PER_LONG 32
+#else
 #define __BITS_PER_LONG 64
+#endif
 
 #include <asm-generic/bitsperlong.h>
 

-- 
2.50.1


