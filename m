Return-Path: <linux-kernel+bounces-852715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61193BD9B67
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDEC188F8D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF839314A67;
	Tue, 14 Oct 2025 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="jD0Gd3ds"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961192F066A
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 13:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760448082; cv=none; b=Hoi0MamDzOYIXvC7k6uOLWYbEdCVtDvvfINqp5WrATZkC5V6QQoUo6cJe6Gu6BmTTqaAQLvzHWyf6Drw2AvFnT+jRhjdzS2VM5otOy1SAOv+NN6GnUQTpNk66aOjNKB6k5IsNSxZkNkugDwHETR/+DSESZTPAOE390EDMCrwNk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760448082; c=relaxed/simple;
	bh=My5HomZWKvxduE6n3PHRd+8RyM8EUC+3BbmfbP/nP40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJowkmJgADEXoJDu53DIlcHifzlGipBCB9uqhEYOihM6ifcPRG0FfNvJrRvKCX9QmAXk/2RZPWTOkYadHzf3JOdPjww5x5Ij/XZkRp6DD1NJSquTED4BAKxjAo/GRr3bIWdeLUpi+w+MaoUMDzjp7UufCx2fz9JSLPc4Q8lTiJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=jD0Gd3ds; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-27eceb38eb1so60989105ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 06:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760448080; x=1761052880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w63d3iN1NxniFWTpRTs5PQTHc3ix0F8ilLg1M56GOwQ=;
        b=jD0Gd3dsc8w3uPt8t0lIGuNFgl/AryVN33W3XgGiYm9gQbueBHMqueMrd42Hq7IqNS
         Sqc+HMpwQcvwITDubW3Q6Gv5/31vEYid1soSSJfYAjLo9rS4ouyAtwp6UivPakXCeybQ
         oEssZhbfgYJEHulYeuMb3pMehXbPDC4vglbzH85e9AOZ3el9y4m3fIWYwlf+Bs1dXuZ1
         B2mtu8tdIkLLHiKlDIqyAEHfM272FO0FmUHLxK5NR36sdw85+D4a3sIDBmn+f7pHRyF/
         RLqGIfUbp/5kWBlOUSps/3hl6FbK4huK/0kyjJqdm5lZdD+nC54xAswiN2O3aXw4ZLQl
         IqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760448080; x=1761052880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w63d3iN1NxniFWTpRTs5PQTHc3ix0F8ilLg1M56GOwQ=;
        b=iAKgazP/TFJvn616wqG6BVnqS2XWBpXEeDOqPE3VOJKyhvjIXTpu4nUnE7wRGx+cat
         cqkYbFL6RmgYOZLBxCIiZTwRQWTS38tcrwZW9jgFI1/ZjjA6SDBBarTZ4M0HptBO6/Ju
         i9U7Ajr9qQ7VNyOG2AKPIZOLwyl726yOpc19KPJmLEzrtJ/mV0U+0qT62IoCV/okiDxX
         U46GUWnTG4WwDGxUewnSxRQHhA52VC/2Vja3MzSszPRaPkdigQ0WXoSnToxPPmkBhYGG
         8tz+6qipEOpWccbSputwn+1Cer4xTStZSuJyinnTYqYVf7oyz3Cfa9bHloUPz27sLMhI
         ikLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdrQChtSsvB3KemwCYhfreFqkVzsYv30SZIsChrRjLRnWX78lZzNjK0FFvU8D8uKULQDk7oLB3IkN6cdU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4OyEUNgS2kS7zI5dvQ1w2CHCtSDCPweylmCGeUGCb5tuabaCT
	G2JASjcdThF9b70hkm8FDnr0WaFZqnvuvCPH8ZSVAnlh2UL7K2SglKzlO2+G2xaN2XU=
X-Gm-Gg: ASbGnctImzX+SP/ShbEdz4TvFRdc1Q3N/mblGFjpxA0I9Cy/qlEpf0MtiTl07DfETRl
	+UXynq9DsrYX9DA3GvTyeFfa0lkhmw3nHrnY7pCc8rxBL3CZXTv18W1OkI5IFKjtsqXwYaAZ23S
	HNfSOAJPiDwutUSKGj7h8BW6tSDUl3WipxsPE2Od239ALFyLl9rTN0pN7vw6PyvQ1UgyMxwHsxy
	mu6cB53xV0t4LolKixKpgM/tNc6nJ863rc6AyZnFeu2HAA5kcJl+Ldg+miXM0+efVseWBUZgd3/
	zZYSd09s8YoxWVr2g+WuDNJ34UnMeLu4htxpn6QHyAUUyURS+m4yLZQchU+V+s+eeFVuIYkAPGZ
	RqyForo3jqJErQH93mekr+5TibfdpJhViYWrO/1uxzLnbZl5BNnYMWC+YttHC3pGHXGLLranC
X-Google-Smtp-Source: AGHT+IF7s3fLFOl9rdJb0wt/YGaCzHyGdkNVTxLw2zcP1cyGfw127m9LZ83PtoZ1nbrWcMLKHR37aA==
X-Received: by 2002:a17:902:f64d:b0:26c:e270:6dad with SMTP id d9443c01a7336-2902741e4a0mr268523345ad.60.1760448079692;
        Tue, 14 Oct 2025 06:21:19 -0700 (PDT)
Received: from localhost.localdomain ([122.171.20.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de6f08sm164387635ad.26.2025.10.14.06.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 06:21:19 -0700 (PDT)
From: Anup Patel <apatel@ventanamicro.com>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Len Brown <lenb@kernel.org>,
	Atish Patra <atish.patra@linux.dev>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 0/1] Common csr_read_num() and csr_write_num() for RISC-V
Date: Tue, 14 Oct 2025 18:51:05 +0530
Message-ID: <20251014132106.181155-1-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of the RISC-V drivers (such as RISC-V PMU and ACPI CPPC) need to
access CSR based on CSR number discovered from somewhere. Add common
RISC-V csr_read_num() and csr_write_num() functions under arch/riscv
for such drivers.

These patches can be found in the riscv_csr_read_num_v3 branch at:
https://github.com/avpatel/linux.git

Changes since v2:
 - Rebase on Linux-6.18-rc1
 - Added reviewed-by tags

Changes since v1:
 - Make "out_err" mandatory for csr_read_num() and csr_write_num()
   in PATCH2 as suggested by Sunil and Drew. This also helps further
   simplify csr_read_num() and csr_write_num().

Anup Patel (1):
  RISC-V: Add common csr_read_num() and csr_write_num() functions

 arch/riscv/include/asm/csr.h |   3 +
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
 drivers/acpi/riscv/cppc.c    |  17 ++--
 drivers/perf/riscv_pmu.c     |  54 ++----------
 5 files changed, 184 insertions(+), 56 deletions(-)
 create mode 100644 arch/riscv/kernel/csr.c

-- 
2.43.0


