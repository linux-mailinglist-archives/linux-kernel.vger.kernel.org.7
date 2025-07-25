Return-Path: <linux-kernel+bounces-746051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E83C0B1226B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74ECB1CC584B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BCA2EF9A2;
	Fri, 25 Jul 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="HiWwRHBW"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E672EF2BF
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 16:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753462624; cv=none; b=KCw/S2eNtB1CiRFw71edWOdAtEvay69Vn81Mq9vgye74OeStie6+fgqMLAGW6QHO0vDgvJu/tDTL97s7VqX52rS1pbkfo+fO5aTqNROPywP/mv8zLwSHWrt7AHQkMHLHJlpViQV1kRiHh6a/6gFZoswCfPwZ2a8YRP5HG4XSu+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753462624; c=relaxed/simple;
	bh=o8PGWrA3RMhqLDmbTJpWQAnuM32YJpgK1W2keKuVRSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ga+BJ5u+MaR9SKRLhz560MvMFGZicsv6utZwy3qjmH0ChJ8zRdvvZIzTlO1OkUBXV9F9j03KzIX3aRmV5TPUly1KLdqFOvAHR+YnxVxuwjU4X33/xyUEC+uskzzrHGiftuhibAcNKKPXyVg2MKc/Oh7HLIvjetSXhePpdSZQry0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=HiWwRHBW; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a4f64cdc2dso181183f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 09:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753462621; x=1754067421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5wCo50uCFgJpMI7LbHbH8s69mNDIY7eBkEPfxQyUMI=;
        b=HiWwRHBW+hpdpA/pzahHHaAlEyphlkjc7DLvt+zVZTO15WuTTfhNln/U1W20mluXBI
         ibWOs7vFhfADgNPAcKtkC/qTlyPE0Q2fOlT4tG/ExL+SHTH7oUko17EEgc8uFrenuaXB
         pYEsPVSMUfGSYTEV6cPHu9XxzjvfdJNUB2WRe792P9v8RPD2jSFF9D/qQFjyaRl+2tPD
         AvPndjozGOb7RozM+2XNvpkdV40EYHWO6m46ca2Fj5+3mTp6205e6XOoNesc7P9NrKtR
         Jl/T1DnXhlkd1gcAn/MKWw82FyXyGC7dBfLUECNRnciGZZybBPHvl00Uu58mR5QLuQPI
         igPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753462621; x=1754067421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G5wCo50uCFgJpMI7LbHbH8s69mNDIY7eBkEPfxQyUMI=;
        b=ubH3XLhbtFoqMnnosRglddotT2ZGjoJOgmWmLipvyERgMghxSi1Y7jzDnOPsrlCeZ2
         HXTCqG4fZdlX9WNqacA3AEJTRncg+bJtx0nBXSJ/kaRuUXdTXHb6WUPkNn/L4lTD0I5I
         uKCfDo/OZTP6mYNg8Sq58TkMs6fdiGqvUh+K/jS5dsVX5Kx8UUNyA8wsZw6P3Vy0VIUA
         CpIVyqiaC5lk2yDoJEmCI0HytNPDTZ7TjH+4SUKF2SfwBb7a2lZiUl0PmUKjBftmIqxS
         ehjWuwvMPrJsxSOCGBkT9XEzuZPVmhVb4GY1Y++EKcp/mn64cShHsF9NGYRkW/puRSQU
         pq9w==
X-Gm-Message-State: AOJu0YyGKlwcD5SsuKAePoY8KVOAGxpQlm79jLHNSRc9nFQZ/2m0FV+K
	dNjdXgmTe7oW3zNqX3dtnVTJA76s9bjo0zFg4B3FViIOrDJSwiR9YzlMzpQG1wifC3tTTbpxl3Z
	zcm6U
X-Gm-Gg: ASbGnctqCXrRo1DIZKNF5Eer6ZkZtlV9U6RwFn3iArklwGlox5vVrFbO22PrmkkBYeK
	kCYj0eMw2h4fX13tq+V+BlqxuOzWgZZcAu1p+JRm/CcJ3H4MSfeHLPx4ZfrS9QgKfYHcmpae+ap
	4Z4AmudPjer96lNdFlRAn51smnknHazexxGG3qZTNe1sBlhMnf4C6uKnf4drR4HCipAbG/r1nHp
	BGyb2Izg/9HQD0A0/4besdfdc2Bqofid9bmH/bJl9FhyHGgCDs31Q8OwMRnA54/xnEMZ4/tA0I3
	xXuHzzSQE7dJmUKe3ZpNWPuqbNESJZZuKxHDqvvWrEe+fYfyIAZCg8gS1EgrkmeMQavR43LZAy9
	M+svviHVi0Zva3hXWW4bDamNqUVVi9Q==
X-Google-Smtp-Source: AGHT+IFE0VwAz2zEeGx2Qzxk8E6WuBhcU7HaGl2wpgJlNEjaoTX1yD9xeYguw1eB6wx5XJ8Oij5/AQ==
X-Received: by 2002:a5d:5f92:0:b0:3a5:3369:391c with SMTP id ffacd0b85a97d-3b7766d2d43mr701824f8f.1.1753462620875;
        Fri, 25 Jul 2025 09:57:00 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:8c15:2281:5347:b367])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b778eb9eaasm401817f8f.24.2025.07.25.09.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 09:57:00 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>,
	stable@vger.kernel.org,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH v2 1/4] riscv: use lw when reading int cpu in new_vmalloc_check
Date: Fri, 25 Jul 2025 18:54:09 +0200
Message-ID: <20250725165410.2896641-4-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
References: <20250725165410.2896641-3-rkrcmar@ventanamicro.com>
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

Fixes: 503638e0babf ("riscv: Stop emitting preventive sfence.vma for new vmalloc mappings")
Cc: <stable@vger.kernel.org>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
---
v2: split for stable [Alex]
---
 arch/riscv/kernel/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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


