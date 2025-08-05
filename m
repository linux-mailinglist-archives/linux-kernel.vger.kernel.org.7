Return-Path: <linux-kernel+bounces-756917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B59B1BB05
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6626248FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4E721C18C;
	Tue,  5 Aug 2025 19:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="gS5q6bHH"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454F220A5EC
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422800; cv=none; b=MLKW89p/OyLxqQ52xvvZzpGm72F3hkJVHRAgi8TE3Hw75njxKwBdeQmViryc/jaZhryOasrnQ/i69H/8nxtgFdVHE4EmrESMsZtTEDIOHMkniLRMKflslpXHe/rZrP2FZ+iwwqVFG9Ldg0Npee0/OCxpoK8xb1jxxwdVRSS0Lm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422800; c=relaxed/simple;
	bh=+qlcnySMX8H8r8qM3Fwa6oKB8CHMdlILBs2oyCCdlVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFqJOxjssRr4ES7c4A34brpTjbaxWODsl4HlG7QqWlpH4Mg3/TAzlUDCtxXQ529nYEqdEc3aQTemZYMz6ctwH3EebxBWmdnvU+aPjdcYwK9BSQGeYeCMQ4RigOsnpYUaNngqlmR9UubMXPgLUe1yhJFgMU850hlLMCm8T5LkPkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=gS5q6bHH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7e806613af8so229451785a.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422798; x=1755027598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Av9ulXUYq8yypH92LgefCWXE0SBG4q/HDQdjt7nKwbs=;
        b=gS5q6bHHwwqgpwrJhZNvQG/XEsuG5cccTu8L091bJqboPLHuExlcxVjdz7tIheybqi
         8cIap9noWifxDLoB65B7TBWgdLKDBflBZfxgmQoL5OlR4Z+EStzVXHTi7MwTUHPrdYj+
         oUWxgLWrt1PNk70r7TyXz6kwuYASvBQfZUkugyXqTpnTzChq6Z1qHobD1qr/KANWJhOd
         H4cRBgnL3fasaoTAI4xSgQYf8AhrnZ4g3O6Lh0oHoPrL/p4oPuiOur84xJLB817ezYYW
         29Bi/JC5T2fDDvl9QwSKqZqJs9J64b57QtzIVt2yQW3tMKvfreoH6Js/5e77EHv/ogQl
         GD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422798; x=1755027598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Av9ulXUYq8yypH92LgefCWXE0SBG4q/HDQdjt7nKwbs=;
        b=IzXXdAoLJSJ+lG8DVMcHi9xx/eVAS5u8CPHaCJbcXJg3q1fwsABP7oJEEpRPrDDOG/
         osCfbjKNHtrqS4AulB7rXgBgMHtHUwD5G4rZZYoA58+LwxPCFzCu3RDBPFqI8ARYwbvL
         tb3kZFRlBOYntuWRIwF5hI8Yz3zL7yZzQssWq7IIqzWDIJViHvQwaI1sE62S8CsQwEQj
         zG6oSjBOYOfERoXFvawwYd7zXXk1Kx8Abo497Cz1JJXwFtiBqkqGZrn8u51GwOuOk8ev
         RKo2TvE2lP8e9rTU6QwirEtzi5+GUtc28i3emUuhIIopGKUCl3TZAm6aE28uVFSfM1oC
         YXiA==
X-Forwarded-Encrypted: i=1; AJvYcCVcH0xyrUQvdrCPFJVHAuVHyQD8q1KIFnWrio4hRfBGDXlSn02pSgpLkru/C+5MMlr5d11iPSiToND/2y4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPk2eSNwtb2C1YjruJEiDM56R750Sooe3K+7d7WQaiCfgAr4D/
	6izrGneuRzJRchZ7S2n0xNh0WqY9eAI8/mqmX8qMOkyPJcDUmR/dOoiUTtumgHO3lrc=
X-Gm-Gg: ASbGncst1xZUmH2f9oZOz8YCi2xx5mqFFcUSFABBIDEXgL6ERjPOP4HKiy9d9Yr/lYb
	OoE5a72WDaCknRt8f/pbbIjHguUwMbNKa+y7ak9tG7FQ2Px/btq3FujVwza4w2jnpGxc7mZWweH
	hzOUFVe5z4dORJwYdvhRsSJaXQj2TzIx4IesAdpadnXgfeZSob7aJUJFTuRxtaccGsMNXZ9lqYA
	ryn3CjXtBUnButUlsTIDx4pVzPb+0QzbWeWQN2vQtnO6UJww/nBtpWVJ9bi+I8scUA6/7sUf7Jd
	n6XUsD99qPYETeJZmjlfPR/DfFsA3KeABwwuq/4iN0jGmsjI8SzuTmJfqoQPROD/Y8Vgh/cXi7i
	z6iVbm+m3DeKkFCh3zEEJCVqmKO6HJKlLneFOtGOXavrIbxhgcHVr1TYbSLagEAhZ3AmqEVr/SA
	dWBnZJiw==
X-Google-Smtp-Source: AGHT+IGaYz9rbHDaluNVvJAMepELkYucyj+ueO/efwJAG+Ld5Sktyl2JYCmbLDUiGqnvS0NmhNn2LQ==
X-Received: by 2002:a05:620a:370f:b0:7e6:67b3:ebf2 with SMTP id af79cd13be357-7e814d1a1e2mr85393985a.27.1754422798022;
        Tue, 05 Aug 2025 12:39:58 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:39:57 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Kees Cook <kees@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Conor Dooley  <conor.dooley@microchip.com>,
	Deepak Gupta  <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Evan Green <evan@rivosinc.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Chunyan Zhang <zhangchunyan@iscas.ac.cn>,
	Nylon Chen <nylon.chen@sifive.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 0/8] riscv: add initial support for hardware breakpoints
Date: Tue,  5 Aug 2025 12:39:47 -0700
Message-ID: <20250805193955.798277-1-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset adds initial support for hardware breakpoints and
watchpoints to the  RISC-V architecture. The framework is built on
top of perf subsystem and SBI debug trigger extension.

Currently following features are not supported and are in works:
 - icount for single stepping
 - Virtualization of debug triggers
 - kernel space debug triggers

The SBI debug trigger extension can be found at:
https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-debug-triggers.adoc

The Sdtrig ISA is part of RISC-V debug specification which can be
found at:
https://github.com/riscv/riscv-debug-spec

based off the original RFC by Himanshu Chauhan here:
https://lore.kernel.org/lkml/20240222125059.13331-1-hchauhan@ventanamicro.com/

Second RFC by Jesse Taube here:
https://lore.kernel.org/lkml/20250722173829.984082-1-jesse@rivosinc.com/

Himanshu Chauhan (2):
  riscv: Add SBI debug trigger extension and function ids
  riscv: Introduce support for hardware break/watchpoints

Jesse Taube (6):
  riscv: Add insn.c, consolidate instruction decoding
  riscv: insn: Add get_insn_nofault
  riscv: hw_breakpoint: Use icount for single stepping
  riscv: ptrace: Add hw breakpoint support
  riscv: ptrace: Add hw breakpoint regset
  selftests: riscv: Add test for hardware breakpoints

 arch/riscv/Kconfig                            |  13 +
 arch/riscv/include/asm/bug.h                  |  12 -
 arch/riscv/include/asm/hw_breakpoint.h        |  59 ++
 arch/riscv/include/asm/insn.h                 | 132 ++-
 arch/riscv/include/asm/kdebug.h               |   3 +-
 arch/riscv/include/asm/processor.h            |   4 +
 arch/riscv/include/asm/sbi.h                  |  33 +-
 arch/riscv/include/uapi/asm/ptrace.h          |   9 +
 arch/riscv/kernel/Makefile                    |   2 +
 arch/riscv/kernel/hw_breakpoint.c             | 769 ++++++++++++++++++
 arch/riscv/kernel/insn.c                      | 165 ++++
 arch/riscv/kernel/kgdb.c                      | 102 +--
 arch/riscv/kernel/probes/kprobes.c            |   1 +
 arch/riscv/kernel/process.c                   |   4 +
 arch/riscv/kernel/ptrace.c                    | 169 ++++
 arch/riscv/kernel/traps.c                     |  11 +-
 arch/riscv/kernel/traps_misaligned.c          |  93 +--
 include/uapi/linux/elf.h                      |   2 +
 tools/include/uapi/linux/elf.h                |   1 +
 tools/perf/tests/tests.h                      |   3 +-
 tools/testing/selftests/riscv/Makefile        |   2 +-
 .../selftests/riscv/breakpoints/.gitignore    |   1 +
 .../selftests/riscv/breakpoints/Makefile      |  12 +
 .../riscv/breakpoints/breakpoint_test.c       | 246 ++++++
 24 files changed, 1657 insertions(+), 191 deletions(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c
 create mode 100644 arch/riscv/kernel/insn.c
 create mode 100644 tools/testing/selftests/riscv/breakpoints/.gitignore
 create mode 100644 tools/testing/selftests/riscv/breakpoints/Makefile
 create mode 100644 tools/testing/selftests/riscv/breakpoints/breakpoint_test.c

-- 
2.43.0


