Return-Path: <linux-kernel+bounces-822142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB45B8327D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F5011C80089
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 06:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186D41E51E0;
	Thu, 18 Sep 2025 06:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dWPm2voH"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77AEF2D8DA3
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758177371; cv=none; b=uKOiEwsIpztFxly1bRwoihnWrwsx3UFl6Ctl1bp2xrOkj0rmiiAm1/ZNeHG2u7YqyYS9nzFETn+VtuD1cxXBYzGsSXid4oDfC0yZKNSOt8RmaWd0fPKF/i3xy1UbiSa22yi9FiTdvSKv0hPULZtEv9uX/qx2uUo4CfkX1rHY8ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758177371; c=relaxed/simple;
	bh=6V9uNq83XXSYotxaF5gDZpQuTwairQF/oZADfO3/sw4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=sCmaLS9IJBbY9r5C8ZMUSE/BKLDROk1ri2gk/4/pZAxGYTrb0jWqTgbSeoKffSukPpySUx8AuvHpmEcDlgyIwl9UY6LPBjR5k27Fei8tBaYH/E0N0BjMoCcgKIMeg5Fia3kS6Y2bF42BQk2HJa9FajvzFejqXnGidwZWyK97sWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dWPm2voH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45b467f5173so4692635e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758177367; x=1758782167; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VFjH+4iKezMx9taew/P2Pp2wCahAKn7daFaD40BNcwI=;
        b=dWPm2voH0f603vPYQX77aQqLkQwj1gccurUP3xm1C/utJaqfk50DrRytdrmmiyQJfg
         Ycv4tPwrswZeOpCt4GBicXAxbm62qcDyG0SIvYXMBlZAPcn7/yv0kg7d561BhHzlUocL
         vXuHJevK3ZD6fDDJM2ygdtHImzccAXDBSCj/P/1DTfPXDuCvmnZZ+AHtWzy21aq+MpNW
         As7FIotfnDc8YfSYp8eCugw0KlJrZIcTzlwCpyvbmZ8Vuuro5MEUH7cayCez0pX2JdKD
         Zvt1xxtMkc/p+RRUyyX5EdoPZROIlDNWvVk7e3pMead98VErbqqpr0B4KEYaeJL9p0K4
         2YhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758177367; x=1758782167;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFjH+4iKezMx9taew/P2Pp2wCahAKn7daFaD40BNcwI=;
        b=ttZbcE6DCw1zDtm4xjZNFn52lYQG0aGenyo9lkbs5+WQ1z9JSJoZh1uQBnyDlB4XA5
         CD0fmDRTMIOvuyZqoQVcDd7QVsyp6Sryf6u+kb72i0hrs4RECNwHXzb3EXUJLK7wyDK0
         RuN5q7VK4lN5P9U3TVp5GiR2z0oHV8OA1NFvsAB0wGgLlKk22h31JfsWTltsP8ocy2v/
         bncPitRW2460dSf9XR4NtLKH7qlzZGJqe45x7RzkHmcWwGmo7iJ7ME1vUz1pFIZ4JPNR
         Z4rFXjWLthXFnqsfDdLiSI6R4EQiffHLRfkCFFvzlWJ60jCfQL1udSImi8HF6eWsa6s/
         xUTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs62wUlBV4YDVtnCwXa7+qRyy8hXsgPXwMGmisjI/rR5mIgopbNvDsKcgcCLuNoJDnHSP8LMGicMIryak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFKJrSZ1kKhJUD7bLQ5sNlj7OpRqldWaPZ1+pJscW3L6tYHNk/
	pKm+5iEYbJFc0wxJoxoXaIPb6LfhdvlgYhnckFDBNekM+vtZp76VTegHOQHHFjhZnUxNiVEqBg=
	=
X-Google-Smtp-Source: AGHT+IH2UgG37umNMoeACtGTZ7/9BuSZf5nN5MC+UZpNd1hrMGzyvC/NPJGsd1QclVocKHX2GkTc/eq3
X-Received: from wmbjg18.prod.google.com ([2002:a05:600c:a012:b0:45f:28d1:7681])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:19d4:b0:45b:8f5e:529a
 with SMTP id 5b1f17b1804b1-462031b1dfdmr44345345e9.14.1758177367559; Wed, 17
 Sep 2025 23:36:07 -0700 (PDT)
Date: Thu, 18 Sep 2025 08:35:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1640; i=ardb@kernel.org;
 h=from:subject; bh=rNO7lD/OuznN/elc7/2TihvZkB/fdGPOYNhJzbseLp0=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIeP0CpsE7vV2ez+u1zTqWvlm66PI7v2vzq858OP34VDlH
 RdSd7CEdJSyMIhxMciKKbIIzP77bufpiVK1zrNkYeawMoEMYeDiFICJXNZgZJi8acHsj1ffLuVk
 fL/bXFd9jZnTm39O0idV/Nf9jMhU6bJm+Ge14c5izX+7hNeL3t5mGNO5U2iZoqlY/rFJqrp8UkJ t+dwA
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250918063539.2640512-7-ardb+git@google.com>
Subject: [PATCH 0/5] arm64: Move kernel mode FPSIMD buffer to the stack
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	herbert@gondor.apana.org.au, ebiggers@kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Kees Cook <keescook@chromium.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Move the buffer for preserving/restoring the kernel mode FPSIMD state on a
context switch out of struct thread_struct, and onto the stack, so that
the memory cost is not imposed needlessly on all tasks in the system.

Patches #1 - #3 contains some prepwork so that patch #4 can tighten the
rules around permitted usage patterns of kernel_neon_begin() and
kernel_neon_end(). This permits #5 to provide a stack buffer to
kernel_neon_begin() transparently, in a manner that ensures that it will
remain available until after the associated call to kernel_neon_end()
returns.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Mark Brown <broonie@kernel.org>

Ard Biesheuvel (5):
  crypto/arm64: aes-ce-ccm - Avoid pointless yield of the NEON unit
  crypto/arm64: sm4-ce-ccm - Avoid pointless yield of the NEON unit
  crypto/arm64: sm4-ce-gcm - Avoid pointless yield of the NEON unit
  arm64/fpsimd: Require kernel NEON begin/end calls from the same scope
  arm64/fpsimd: Allocate kernel mode FP/SIMD buffers on the stack

 arch/arm64/crypto/aes-ce-ccm-glue.c |  5 +--
 arch/arm64/crypto/sm4-ce-ccm-glue.c | 10 ++----
 arch/arm64/crypto/sm4-ce-gcm-glue.c | 10 ++----
 arch/arm64/include/asm/neon.h       |  7 ++--
 arch/arm64/include/asm/processor.h  |  2 +-
 arch/arm64/kernel/fpsimd.c          | 34 +++++++++++++-------
 6 files changed, 34 insertions(+), 34 deletions(-)


base-commit: f83ec76bf285bea5727f478a68b894f5543ca76e
-- 
2.51.0.384.g4c02a37b29-goog


