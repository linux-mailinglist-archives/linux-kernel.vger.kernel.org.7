Return-Path: <linux-kernel+bounces-741310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B54B0E2AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 19:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B06167647
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617D327FB26;
	Tue, 22 Jul 2025 17:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="w9L6/ijq"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9A6AA7
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 17:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753205914; cv=none; b=pb4CtMIxm5VbVSij4GTnDbyNv/8vXCB9qO492m/XGi/5ySSFKvjxCnY4D1Aw8ZVHzk5NBU8jZsaW0jgEeXhbnCy+Yil1eQu9D6nssEj9TGSzV/jT/S+bvmNKhYvl0RrSCFoL3bv7dJMav4U7LY4XH3y7bEUFr7A7ipgdix2UGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753205914; c=relaxed/simple;
	bh=2OFaNteDhjen+Yl/stVEpLcRSUt3x+zp3PGp+xSTyUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tTu/NVdklfqn2Ns9fRFiN8DnneHSc4ygWz3MMXLVsqxSaHtTenrZfy5ziSh8e0KXDTlU5B/72vBL6LPA0VeHHSAQ5Eastt77YPhjoiH7nXDWOwy6HSoZ6IyWZH4VgoTEZXuNEK0Hhw6kBaB52vn2hz2zpt8+bhJU3Jaf8DVkFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=w9L6/ijq; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-704c5464aecso52525036d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1753205912; x=1753810712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZhoYjXYf0iMiladjWcP1otkdqstK1tSrtdf33PqhK5I=;
        b=w9L6/ijqwczOMkwxJ5KD8pzv2C1PmFVhgwk8RTza/Ra7gTaPwEkZRAcexZjJEUyGHC
         lW8OVXcPzx88a88YYIEtoQ+0gj2KTYJPgAINjfC7YBq38VjlyQwlkENuYbKuFkAIoven
         GqDucM7Xq2Z9nMOqja0x8N2wOZ4QOxb8Wf+RUvFL3J6XMKmEWtiOuO9LTMd1oXW43PDv
         wEEygkEUAAn125ttrEuCd74JAb+WPqh4emNJ4O9eTYXVassnAMQ5Gyy+4TiHMHZF30W4
         DdIaSkGkX5JBU98NAac2WgYTSmQh7pnMwBuCWgBwx+IhKsSD42WhF68AOZiKXkm9lC7S
         iCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753205912; x=1753810712;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZhoYjXYf0iMiladjWcP1otkdqstK1tSrtdf33PqhK5I=;
        b=EIdJqtQ3Rmx6jMFt7Wbi+Nclf2Qze5Jof1aY2SaGtBBhOq8oMF/Rrd4G5V5UPkQUsr
         oUQ4o0bscc1LbwXhw5DJD/Rhb+ZSVKGc05nR9bGx/rRb75+90PlYuvqGLBzwv50cvVHr
         BuDk5c2jp217SVqOEQX6QAO1bP39ElNYmC3w6nV18VC5Ql+/Wj6E1zMNengCoJAkb/8+
         qImZFkkWCcOMq5qw/CW824c6ewdW4bHZ+774wRy5LRh9/wZ2jHaKbOfQ5PnVIBTqk5SH
         5c/E+LRMP57KHKU2W0Oq6/RtuSuQYZqb9Zdp5QPN+peXtRRMM8zxphzO0Xiz8AutZH5H
         5xxg==
X-Forwarded-Encrypted: i=1; AJvYcCX6zMqvstAUD1F/uQcItZ3sjlxA7qoPZsz37nnzi6Uh8vCpU9gXFJA45QRnmMgilXyCuWX3Qo55hSQ6eV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhigfqZBlz7X6ahAu+1MJi98CzS9Y1mgixDY3DDfSsVdjVsVXh
	fJ5qStHdDtMj+z+HpEFFIlMUPx1/0lK/LtBOO794OkuINr2OWxNr69xzxBPOGT5eqWg=
X-Gm-Gg: ASbGncuKaJpH/FroL6gcyKCPC5TmnEZTtM9dplYDmQ0GdONCfdDiGI+uENSATtp8Trn
	m9mJ+oeg2KqRpZ+gPouy3R8WZDNoe3a3OzwYOxW10S/YjSrwMNyFHjbvJN+a9oGu4oAwHzr955z
	R0iwBVErthqXTABUklb3HNj4n9n3a1Sot58n3zVheJxiVJ104A2UF2ka+5kz+/PTqIzEgrw6Y8W
	m5GKiGgxmqRju5cCBMconjfe2tQBnRVoOXCWs2zR8HDsSqArH0jN6JPQ+56/xpDoZ1FtOy+GJg1
	PHHrokl0A+JCKBkGHzldMSPzm6PFspgI2hzkJbcCinQg17UUK3TuzGkTp7ZKyjZgE5AKxp6hk0/
	Vzuykadc3XAUtD94RNg2sA2yIHj5vOvLNj/JfBuUCK4zZMO8yFxUlWp17QZQpAtSHAXhWEEk8GL
	EhUSQ2/p5SDDQ=
X-Google-Smtp-Source: AGHT+IHb247+BK9soAtrcDng/vPgXXKCMuuenRPeYBN+V315g9KM5gGz27XtmWbtqKQII4y1fdhGTA==
X-Received: by 2002:a05:6214:f26:b0:6ea:d6e1:f3f8 with SMTP id 6a1803df08f44-704f6b37f26mr386502286d6.45.1753205911626;
        Tue, 22 Jul 2025 10:38:31 -0700 (PDT)
Received: from jesse-lt.ba.rivosinc.com (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051ba6b783sm54184536d6.73.2025.07.22.10.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 10:38:31 -0700 (PDT)
From: Jesse Taube <jesse@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Himanshu Chauhan <hchauhan@ventanamicro.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Deepak Gupta <debug@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Atish Patra <atishp@rivosinc.com>,
	Anup Patel <apatel@ventanamicro.com>,
	Mayuresh Chitale <mchitale@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	WangYuli <wangyuli@uniontech.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Nam Cao <namcao@linutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yunhui Cui <cuiyunhui@bytedance.com>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Celeste Liu <coelacanthushex@gmail.com>,
	Evan Green <evan@rivosinc.com>,
	Nylon Chen <nylon.chen@sifive.com>
Subject: [RFC PATCH 0/6] riscv: add initial support for hardware breakpoints
Date: Tue, 22 Jul 2025 10:38:23 -0700
Message-ID: <20250722173829.984082-1-jesse@rivosinc.com>
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
 - Ptrace regset support
 - Virtualization of debug triggers

The SBI debug trigger extension can be found at:
https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/src/ext-debug-triggers.adoc

The Sdtrig ISA is part of RISC-V debug specification which can be
found at:
https://github.com/riscv/riscv-debug-spec

based off the original RFC by Himanshu Chauhan here:
https://lore.kernel.org/lkml/20240222125059.13331-1-hchauhan@ventanamicro.com/

Himanshu Chauhan (2):
  riscv: Add SBI debug trigger extension and function ids
  riscv: Introduce support for hardware break/watchpoints

Jesse Taube (4):
  riscv: Add insn.c, consolidate instruction decoding
  riscv: insn: __read_insn use copy_from_X_nofault
  riscv: hw_breakpoint: Use icount for single stepping
  riscv: ptrace: Add hw breakpoint support

 arch/riscv/Kconfig                     |  12 +
 arch/riscv/include/asm/bug.h           |  12 -
 arch/riscv/include/asm/hw_breakpoint.h |  60 +++
 arch/riscv/include/asm/insn.h          | 131 ++++-
 arch/riscv/include/asm/kdebug.h        |   3 +-
 arch/riscv/include/asm/processor.h     |   4 +
 arch/riscv/include/asm/sbi.h           |  33 +-
 arch/riscv/include/uapi/asm/ptrace.h   |   3 +-
 arch/riscv/kernel/Makefile             |   2 +
 arch/riscv/kernel/hw_breakpoint.c      | 681 +++++++++++++++++++++++++
 arch/riscv/kernel/insn.c               | 153 ++++++
 arch/riscv/kernel/kgdb.c               | 102 +---
 arch/riscv/kernel/probes/kprobes.c     |   1 +
 arch/riscv/kernel/process.c            |   4 +
 arch/riscv/kernel/ptrace.c             |  93 ++++
 arch/riscv/kernel/traps.c              |  11 +-
 arch/riscv/kernel/traps_misaligned.c   |  93 +---
 17 files changed, 1208 insertions(+), 190 deletions(-)
 create mode 100644 arch/riscv/include/asm/hw_breakpoint.h
 create mode 100644 arch/riscv/kernel/hw_breakpoint.c
 create mode 100644 arch/riscv/kernel/insn.c

-- 
2.43.0


