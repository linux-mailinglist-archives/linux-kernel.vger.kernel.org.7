Return-Path: <linux-kernel+bounces-779197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01632B2F04B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 09:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7ACF7B11A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 07:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825172EAB83;
	Thu, 21 Aug 2025 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H+CnCdjd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VHD7/huP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604C2E9ECA
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755763014; cv=none; b=AJsWoH03acQ+4CkWar8lvJpIoGjK8WTxZqNfneoODav2BPDj2+cxEqaUGmPv9bJ+6aDRU7QOnsdn/kvCxh9ot/jX08qlwhY287wFTC6A9utNv/xREarfo2lB4XNcz6md7fZhxCG5TngVKOKc/aPfTZNoDpOXGqgLj1SuWTEsM2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755763014; c=relaxed/simple;
	bh=n2qRj27gMV9HtrK57nk2Kj0O4VPuGEHIaNui3njxil0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hCgOwvc24hL1oxrmTRlW7L8TdV42EgxcbFMx55IpK+NmyAsbJca2Jp0PLkn4rqB0Mt7ZL56oRZwGm4NhzMWXtwe+h8bwpOr6F7XxiefQ+ozd4HrAD5vLKy81gEoK7zl3SH4bfMhTpyWQVlK5szdUUA9E58rg3EFd5Cac8UzRD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H+CnCdjd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VHD7/huP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755763010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZDGVKXmK0DrP73XUwG7R5KbZVQj8LTgpIzpeD1RI90=;
	b=H+CnCdjd6lpe6sysQTEYx7JoBc7gUd7yqoTXHWwDnYDNWqHQWhJDZkF/7Z1m8eoooFoLIb
	4ONKeYMLeD1qZ7Vst5585Wv7xvy4+3zBoIIMORWMOhxQhmR76M44IA3JACSUKlGPXfszeX
	KpqDgEpkjD4bi6BPbyZ33u6EGkJP1nuIGbB8m/0YxIaJHhxFhrv5sPS1eORfzfF4JMFay0
	JRkqbSm938V6Kk7i3I45+/rT1MV8lodVQHeII3YwNu4wGIi3DVjlE3c2voDQPl3qgypvv0
	rth9HRa/EmVHYMjzhZy2YAK18v1fT8usqJ81B5K1R0hwLl35MFEXvWYdQ29gHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755763010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZDGVKXmK0DrP73XUwG7R5KbZVQj8LTgpIzpeD1RI90=;
	b=VHD7/huPGIBLHZ0WUatDCVttPmtxuhxsxAl13SRQ0PwP/Pr2K8Ev+hDU6Oq4X09R2YR23a
	YhKqHTUda3fecEBA==
Date: Thu, 21 Aug 2025 09:56:45 +0200
Subject: [PATCH 2/3] arm64: vdso32: Stop suppressing warnings
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250821-vdso-arm64-compat-bitsperlong-v1-2-700bcabe7732@linutronix.de>
References: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
In-Reply-To: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: John Stultz <jstultz@google.com>, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755763005; l=1932;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=n2qRj27gMV9HtrK57nk2Kj0O4VPuGEHIaNui3njxil0=;
 b=hrJA2V3Iy/r5NOoKeqjug/i0yJoFJEzzZgrEcad1UejfeMjHC3zloJ0dWqbWIKBsroLpH4YcF
 xf7nz6xP71MB5ixHNKa7ccT8sq+zwk4u1Q0/d6MiNmsDy9HbwqHt2H6
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

These warnings don't seem to trigger anymore. Probably due to the
introduction of the vdso/ header namespace. Nowadays these suppression
only hide real problems.

Re-enable the warnings.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/arm64/kernel/vdso32/Makefile | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Makefile
index f2dfdc7dc8185bc045907283b68ab18fed980312..fd80123bc8e620d868040a61244e83575d855e35 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -21,8 +21,6 @@ endif
 
 cc32-option = $(call try-run,\
         $(CC_COMPAT) $(1) -c -x c /dev/null -o "$$TMP",$(1),$(2))
-cc32-disable-warning = $(call try-run,\
-	$(CC_COMPAT) -W$(strip $(1)) -c -x c /dev/null -o "$$TMP",-Wno-$(strip $(1)))
 
 # We cannot use the global flags to compile the vDSO files, the main reason
 # being that the 32-bit compiler may be older than the main (64-bit) compiler
@@ -74,16 +72,6 @@ VDSO_CFLAGS += $(call cc32-option,-Werror=strict-prototypes)
 VDSO_CFLAGS += -Werror=date-time
 VDSO_CFLAGS += $(call cc32-option,-Werror=incompatible-pointer-types)
 
-# The 32-bit compiler does not provide 128-bit integers, which are used in
-# some headers that are indirectly included from the vDSO code.
-# This hack makes the compiler happy and should trigger a warning/error if
-# variables of such type are referenced.
-VDSO_CFLAGS += -D__uint128_t='void*'
-# Silence some warnings coming from headers that operate on long's
-# (on GCC 4.8 or older, there is unfortunately no way to silence this warning)
-VDSO_CFLAGS += $(call cc32-disable-warning,shift-count-overflow)
-VDSO_CFLAGS += -Wno-int-to-pointer-cast
-
 # Compile as THUMB2 or ARM. Unwinding via frame-pointers in THUMB2 is
 # unreliable.
 ifeq ($(CONFIG_THUMB2_COMPAT_VDSO), y)

-- 
2.50.1


