Return-Path: <linux-kernel+bounces-648182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5E3AB731C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 19:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AABB1BA4EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 14 May 2025 17:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044B2286D70;
	Wed, 14 May 2025 17:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b88Ke3xx"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9638285409
	for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 17:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747244646; cv=none; b=R6ru33AwQuzYdaeZuTeF3vG2i5+w5B3m4FeOR29Sh1lyb5+55f+r7pwBY3HQK0s10crvm1riNfnSnaYKMTFV1kiYJw+Yl6ZGPdvdFeyqMD81cfiC+nVJZ0/Out5wBSamtl75D9Qz5eycDhAQI5a5C2m16tZ9fPAJpo78iC38w7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747244646; c=relaxed/simple;
	bh=QCcKltXdUiS6ZvAwHQnUpG+n3tVeHgTvAF4dJYxbvu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tkXGxQiiybmT6LBGB8k+e7RwODogjZ/tv4YzcTcHzvy7J0g5CxW3tUlVGM8Vzkk88qRI6Gwf7d22WTmS1WSXO4aLVb+b/0SUzDUoR7rKuRl9QsFTwBa+G/sNbodZJzlHS4AeIepKFiCAm1MOaJFtFoiwJrZGHMnqVG7ojhpsls4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b88Ke3xx; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-442dc702850so477245e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 May 2025 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747244643; x=1747849443; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D3joKKQQeIZmQE4kJSA51zMSWECAKvTydbD+tuMEGFg=;
        b=b88Ke3xxCNTe82Z3RoZjUOoLZY+4W5sXVY9mD7oGDeudxLES1VqB1nht6+6CaS/f/A
         P+wrmA1QAIVAb1oODE05mkQBuTNJ0PQQcKDmY55Kh/7KH9xKCSNqBi5GOVrd62N92V+i
         1dVSbJ8t7ljsa/PiVtet2dauQ8Ky/o8A49a3DIFiilas88pHKU6vNswU9LA2e6+hwPa4
         QOOHCL3NBDuoyEirTUHZwKdB+ZPvMkbHiAfmEZDmBm809SExB3r+9pML6wdzfY12h9TA
         2qQhJEffpIVlxBEdS8b0dUtZvKqUbBu5zwxakoQR6xNLkeerp8D8vSaJQiBUFt/UzdQR
         Jizw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747244643; x=1747849443;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D3joKKQQeIZmQE4kJSA51zMSWECAKvTydbD+tuMEGFg=;
        b=Qyu8ZJ8M6FpfY1t43wclVk7WoIdrEA9LASn5u3oegbqpx4QOgQL8S6J0tD/IimQvbr
         K0uGPuIb4YvwVLAtRRQL6EVWazOU40nprf/0KPfnlWloHjLE7TmMZZ26g3jaOeW5OuNU
         KIYhQDyayUszTxhV5g1Fs5WKkmpgZjtoYaJP383FCffPnJf9LVQU7ni8zw2FBUlpIX0Z
         bhoKuUn3Qcsd/dEGsZcY4jcvUTpfBT9FDCNYBI1WsU3E+qqtTybllFSm+wVeC3wzYrIp
         s/+4H33V3O0zPNDk7P+hll8NBh6ZzKfPH2lW32U3zXgCExMhSxZon6jav36FEBbyFkER
         ETXg==
X-Gm-Message-State: AOJu0Yxrt5VF5vbYIEoVz9IR16gCnLHM0wYzan4/a7z/NNeBCPVjKhpK
	Q+AAtRGmQ4QXWqgkA9HgqL6yEXqjYhJrdqTrg8kyNtNCmtbXf4fKWC6yVde69NNtKem4eQ==
X-Google-Smtp-Source: AGHT+IEb+8/c9BiVGl1VreAZ1QbOIrYHfFd06gIJ4WYvdQgg+dQ9aQ2nVaMRaSnJ1H83VLXljFnK3HOA
X-Received: from wrgb2.prod.google.com ([2002:a05:6000:3c2:b0:39d:7be5:b8fa])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:420c:b0:3a1:fcd9:f300
 with SMTP id ffacd0b85a97d-3a3499224cbmr4177122f8f.39.1747244643209; Wed, 14
 May 2025 10:44:03 -0700 (PDT)
Date: Wed, 14 May 2025 19:43:44 +0200
In-Reply-To: <20250514174339.1834871-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250514174339.1834871-9-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; i=ardb@kernel.org;
 h=from:subject; bh=B/kHgdOpjuIm/yGgjP0zTXGcP6XnGaz+vciWyr3djVs=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIUPlWkj9BO3u3gnr2ypE5E2uvsxuvTddxnHDnQ7TowlXD
 uj/FmPqKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZo83wT9ddzsGtYhv3rz/7
 NOWs9zVYcR/I3iEhJNXOMquLS2aWN8P/rHDfI4ztPNuVmsOTZFLuFfz8f7KhK/XA42jhh4384g+ ZAQ==
X-Mailer: git-send-email 2.49.0.1101.gccaa498523-goog
Message-ID: <20250514174339.1834871-13-ardb+git@google.com>
Subject: [RFC PATCH 4/7] arm64/fpsimd: Don't warn when EFI execution context
 is preemptible
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Ard Biesheuvel <ardb@kernel.org>, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Kernel mode FP/SIMD no longer requires preemption to be disabled, so
only warn on uses of FP/SIMD from preemptible context if the fallback
path is taken for cases where kernel mode NEON would not be allowed
otherwise.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index ae2ea0196030..47a8706e26b7 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -1975,11 +1975,11 @@ void __efi_fpsimd_begin(void)
 	if (!system_supports_fpsimd())
 		return;
 
-	WARN_ON(preemptible());
-
 	if (may_use_simd()) {
 		kernel_neon_begin();
 	} else {
+		WARN_ON(preemptible());
+
 		/*
 		 * If !efi_sve_state, SVE can't be in use yet and doesn't need
 		 * preserving:
-- 
2.49.0.1101.gccaa498523-goog


