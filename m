Return-Path: <linux-kernel+bounces-778086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A6CB2E158
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489B14E26DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6A2C17B6;
	Wed, 20 Aug 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OyliFDlN"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D12BEC28
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755703410; cv=none; b=Xeog8I3jfaTw6qjJmFwWPmMXTagaDQvtOrG6+JhbQsywcKBhjrcK3y1ymyxhH/pOy0nTKkp2Q1NzfHqrqpND71k6LVU4neIXNI3XXgcfA9BorPRYT3+KpMXmK+UdYG/0z+gTRuy3qBQ86Zbv9tqweLBl+ySxfqDr0aG3FXYYEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755703410; c=relaxed/simple;
	bh=gr71oIJIZMTZu2HvFc7RWbu1QBD6asBm+eblDBZOttk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAvZdeNlj4FVJph8XYeb9MozEdm2Ed7tqYwhZ2tUhyV6ZJEFAkbN7hl4LvDQvP05Nqxyd95UZ3EHAzUHfuje1Q8Jup/+swedPhOegASlTOd/IU+1p4l1QwULrZdZ4Io71e46PRE9vadGcBEIdr7zvOmJn3shciEhJxsA3iYtKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OyliFDlN; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-323266cdf64so51829a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1755703408; x=1756308208; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fgfeAIl9y/jXqZZohjgzAmcbebe2tB8QsVyXyo5QN9E=;
        b=OyliFDlN1JTvZ3Ro0Yky/EnzLT6IJ2d+njkMGnpZGQQfy3dO7hNyRqu9vahv528RuS
         3yv0s0G2rIkGICCQLqsCD2VOgGAwY9pqVt4rh+IbxQ4UMHnHyDR650l4lIQNfsVdPrEc
         NPK+6Hzx5TAIn7oieqc9Gub166rribkBMqVkazb7Op6B1tOBT8g1ayxJTSeADeyErRx0
         PRq+Gxt7uzyUAbIReV/x9PzSlGc9hY5KtAUEyuq9HmmqIvEVox85GFB/MfpGDtdfqcne
         9o1GdMw2+trEn/JgdrD8HIuNC26FYoQutups1SL4vusHZUcV3aRXMo9d2qiXbM6pGfK6
         8rYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755703408; x=1756308208;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgfeAIl9y/jXqZZohjgzAmcbebe2tB8QsVyXyo5QN9E=;
        b=Ejdta6zkd2fzpp4B2wtNUMRONq3oVu+WLHCM1qzL6og08yvU3iAAqkdZ2+an4qS1Jw
         qvRXbpp87aGtmipxAKtQcJ/9SXMIPzluD2BQs5z9pVGcad7DZ47j7RcQRNpMm9D75+6T
         GyUMUb4ygcJZk0dVtQEkDhvFuWfhq/flra79WGVwlbgzO3IHyDFNRIbkCz4bEYwdJMsM
         OrZTC16T+Afrbi5QlJ7ekPn6WWhoG9FQ9MeZSto15uZn3mpW82b8JcksqA1IKf/Ojlsa
         gMHGJnJJPnk8bYdFUH9fFvpgtDQ84wY9lx9P0FKkQXmeB2pkqEN9YwALASQ5rPSVq8xU
         BDtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfU7dWMIV+xsYnB55W1/r2v0CLUEIs84QrzdwClAyojVTMNgrsyiIY81gyItqJnSMc8T3icgKUj1x+zzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLdn0GAZWjbrKYy/0pnwbGTweeZbcybMTh2+2KrqYW3/CAb2FZ
	n5E7O0+O9ay9fWvfFm0OUJMx1nQeXABRfNUIgnmAj9nszdeVg3mm9E9Rv5DiWnckkoQ25UU2pFD
	tBSec
X-Gm-Gg: ASbGncsvi3nlXqHkOqBfUwAzFKQOPRStnPZFj+87DNZUREKyyNiaoc8cNwRiLJhSEKy
	xMsMPcd4YPNzYZ2TkF5iNmlqF8/aqN55/YanfFJX+IlgF3qEdLjjn/kLsGzgQOL7YKVFeMaU1Pb
	m4pf+JMVdJxdvCXWXfXECX58/cOO+/TQutgBzGLNAiWAD5crZzGWt057KNhb867CsHbVVmY0U74
	HCYar3xlupeVh0JATu9ECbOVyJOJ/R8jjVXFscyG+xLD1X/85VCtf6UFEjMBWVgyg7IYnsvvEO0
	Vz9/x8l5sC8O/4vnJiJh80Z+XKVVHR4ZhqLp0YTFKemYhIewoN260WGazr+mPO5aIB7b054iAmi
	tPd4hq0PcDVjKPQYaLFrMH30gLYW6xoJDdkNwIh960bezjfKEy04AxY4Loa5b5w==
X-Google-Smtp-Source: AGHT+IHm9VcX0JB5QQASYW7fbLTywDvuuwEyBtgVN17jvgGI1TvIKfWIoHfTmY/OqRH50W5c11Od6Q==
X-Received: by 2002:a17:90b:58cd:b0:321:74d8:b95 with SMTP id 98e67ed59e1d1-324e143ee97mr4972876a91.19.1755703407577;
        Wed, 20 Aug 2025 08:23:27 -0700 (PDT)
Received: from anup-ubuntu-vm.localdomain ([103.97.166.196])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e26259b6sm2638689a91.17.2025.08.20.08.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 08:23:26 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>
Cc: Alexandre Ghiti <alex@ghiti.fr>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH] RISC-V: Define pgprot_dmacoherent() for non-coherent devices
Date: Wed, 20 Aug 2025 20:53:16 +0530
Message-ID: <20250820152316.1012757-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The pgprot_dmacoherent() is used when allocating memory for
non-coherent devices and by default pgprot_dmacoherent() is
same as pgprot_noncached() unless architecture overrides it.

Currently, there is no pgprot_dmacoherent() definition for
RISC-V hence non-coherent device memory is being mapped as
IO thereby making CPU access to such memory slow.

Define pgprot_dmacoherent() to be same as pgprot_writecombine()
for RISC-V so that CPU access non-coherent device memory as
NOCACHE which is better than accessing it as IO.

Fixes: ff689fd21cb1 ("riscv: add RISC-V Svpbmt extension support")
Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/pgtable.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 91697fbf1f90..00d8bdaf1e8d 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -653,6 +653,8 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _prot)
 	return __pgprot(prot);
 }
 
+#define pgprot_dmacoherent pgprot_writecombine
+
 /*
  * Both Svade and Svadu control the hardware behavior when the PTE A/D bits need to be set. By
  * default the M-mode firmware enables the hardware updating scheme when only Svadu is present in
-- 
2.43.0


