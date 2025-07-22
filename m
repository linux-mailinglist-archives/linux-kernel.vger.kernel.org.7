Return-Path: <linux-kernel+bounces-741196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82672B0E153
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E3517D1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D200127A930;
	Tue, 22 Jul 2025 16:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="d3F6G5zd"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8EE1DC9BB
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200598; cv=none; b=tgD9trUYdgCJtDQ5JWhKdjXtUZg+xIGg4tr+gFlIYDbpLSCpvFxwNIKifG+IdSM+Hu7Y+F6j0hY5v/1XZeiDS1eaGtkZ0vciSH8yAW1MfxSt2XqwZ8FquR3zcG6VXm7Jz/bfzlmsJEfLCQzkkr0U4/0OjI01vGwq1tiq0iEuDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200598; c=relaxed/simple;
	bh=nCw+7FL8gL6JYK/43daQJi0qJyB4vyEjDwnHebjT1fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nf3feBuAYpkxwLQ5AgW93U50Fny1PGFbYQtILmIB6+m5enzzgw1enx4buwaKufN/NnbGEKm2tyXNNImKcnzRqFSSyPCV7rGyISa6LTqHfqh9x0WpISoLaYDlOyGwP0sPnGrDz/+G46t/WIn64wt+xWi6IqMohuweWPuB8FdVKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=d3F6G5zd; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4535fc0485dso10115435e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753200595; x=1753805395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHn0RK1bDtnQTih55k+PE+Oh/xAeSlFKCAvFjBlOT6o=;
        b=d3F6G5zd4NrMrj7UGyZfRcW0poJ6MKl2aAOeVg+jkpMDWjvjIy1e/XD9g8tm4/vP+O
         N9y0o5PWkGYFpVBzcBjfKoS028eXIge+0PWs9nHDIREU/MM8ZiJo9IfPOcvDNaA65BZD
         c3WsjaiaqL+vvRVevm2wkuKKk+kSgi0qIg3NccP+wgHTkK/x/4qqXzPeJEQ97kjo7tBd
         4Mg3fmfnkiBxJ1vhflJqvmc7mONLrIRZ2s9VbZ7Wo+gVsmZK3PLYXCOwpaX5MyPksO5I
         2yzMxdnTJGvqrfTcLqY3fxaOMoW64uFYprIMG+FwwnIskw9cnxOSlG4pH3OKx7iWByTU
         Y2Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200595; x=1753805395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yHn0RK1bDtnQTih55k+PE+Oh/xAeSlFKCAvFjBlOT6o=;
        b=d7FcZ1rxvIt5i6t+ZYIIFaPJDQIs1HBwt3pgxzU0IRFtCigeSYY24KFHRo+nwJHK7z
         8MmFALhEXRGalifXf/lwot0A2b2szwmA9wk52FE+D7goglKzomnzA4dKlovZq8TZmBsm
         ZNLTg2LzjIWv0XSM6Q2lRYPlVygRbLGYQuuWDTt0Awo3ZRCDm3wAfBK9LRxGX2i5URty
         YizA0AKH18p4IZHELhu78BncM8iR12DFvtujqhBjQA6r4u5Cnr8xoPJY0UK7v/ZOb1na
         6pbjfrPmaJnWE5cczd9f2xaGh3iu4byplB04v77QNLzX+7U3XWctGIYIun6OvAt6nI1F
         63Cw==
X-Gm-Message-State: AOJu0YwUoxuEbnnOrWTLprW2iB9yKdGlSqNYXXqKoAOwGN233bM9OvP7
	PFX8Q8nKi+8oifj5kMVWQmjkOGoB524WJkM6AAjhc695W4TaQnoC567kFWIpSN3i/VU=
X-Gm-Gg: ASbGnctexNMs6o0igz2vB1Ss+7d6XHBaWQEicbNuwBzifmnERVsvSuOM1WaVwih/ih7
	KeHOo5oIdGbkOAucj7isibks13EtvnJiBFNb3Fw76pbb6aqX7x4p4wDyctykkbNDMHFuZiWGcTD
	zQq9+u4sSf9eoo2884zsgoq9pSSNpAz0XXeniP6szQDvuArhBQSj0R0gumz5g+pwtAo26omHVNA
	Oe9fxBVhySU9Zlh0NWWR2epw619MfSm7S4RPyRziKMw9pni8qSitxbHKEYeZrwfPTvoFkBoR0mB
	kNaanhCiJxODiC/erZ2O0FRyqdTMMKUYpuKGmuY4E6ogfPe9o6ziAI8p//Eohhlr/vuhHrkUPz6
	MvrgfQD5vxKBLPReBT5Ygp5mOUhH+KlYsUvU6xp33
X-Google-Smtp-Source: AGHT+IFOOj2pCZuzkvgcI2e++izR9WZ44Bo7bX1ttKedDTZ/7/TUO4123SUu0NVdtBBwikHGaWbn/w==
X-Received: by 2002:a05:600c:548b:b0:43b:c844:a4ba with SMTP id 5b1f17b1804b1-4562e047a0amr104331465e9.3.1753200594690;
        Tue, 22 Jul 2025 09:09:54 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:30d6:4986:8040:bb0a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca4c754sm13900391f8f.59.2025.07.22.09.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:09:53 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 2/3] riscv: use lw instead of REG_L when reading int cpu
Date: Tue, 22 Jul 2025 18:05:56 +0200
Message-ID: <20250722160556.2216925-4-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
References: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

REG_L is wrong, because thread_info.cpu is 32-bit, not xlen-bit wide.
The struct currently has a hole after cpu, so little endian accesses
seemed fine.

Fixes: be97d0db5f44 ("riscv: VMAP_STACK overflow detection thread-safe")
Fixes: 503638e0babf ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
 arch/riscv/include/asm/asm.h | 2 +-
 arch/riscv/kernel/entry.S    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index b3022bc224ec..93b1e4ce34d1 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -91,7 +91,7 @@
 #endif
 
 .macro asm_per_cpu dst sym tmp
-	REG_L \tmp, TASK_TI_CPU(tp)
+	lw    \tmp, TASK_TI_CPU(tp)
 	slli  \tmp, \tmp, PER_CPU_OFFSET_SHIFT
 	la    \dst, __per_cpu_offset
 	add   \dst, \dst, \tmp
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 75656afa2d6b..4fdf187a62bf 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -46,7 +46,7 @@
 	 * a0 = &new_vmalloc[BIT_WORD(cpu)]
 	 * a1 = BIT_MASK(cpu)
 	 */
-	REG_L 	a2, TASK_TI_CPU(tp)
+	lw	a2, TASK_TI_CPU(tp)
 	/*
 	 * Compute the new_vmalloc element position:
 	 * (cpu / 64) * 8 = (cpu >> 6) << 3
-- 
2.50.0


