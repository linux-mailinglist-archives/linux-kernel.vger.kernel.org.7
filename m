Return-Path: <linux-kernel+bounces-756920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC4B1BB0B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 21:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F3847AFDE3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DC15ECCC;
	Tue,  5 Aug 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="WcrIQikb"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E66126CE12
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 19:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754422808; cv=none; b=BhEVbilHZQG4Jgb+4iafZOOyc4y/TYYrgcgi0pALYuQamEgQ//S8kRoWJdthAnXvjUVRPUvsJ6aq+s+NfGyqk2KxQI5lVlWMT1zqh98X0rzM0RlzgpI65dKV90Xlh/cu/u/7qGD87sU5sHnjCGPFZYNuIOeET2RoWZWQbN15BfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754422808; c=relaxed/simple;
	bh=Mw1HF+WYqrZH50B60QETN97Z6Qf9c2O3cgvwGI4nSFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z4N3MzQkHCBO6p84qJkzzXo+P9Ahi9IfkbaEKik4t/GgrcYpUDZxNs80i1ubIWow9BfWx3g8tXQe0ocuTbXk6hEZgK2/YVqGuVqgpTAc3/IQCldb6Qt3w94fNcZOFEXySEXGy3PrfM8ZEGyxVW7ZDWFJGtjc8YhE0rF6D77weuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=WcrIQikb; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e7f940a386so171992985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 12:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1754422805; x=1755027605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMI5Xwq0SqGXnmGRw5QTZMv+U2y6SNaFWej8c2zdngA=;
        b=WcrIQikb0VFMCoabuN1q9WZT2QVr9aFu9ytV5kdo8aLXFxoGSoJjFuEyYWaR9xt3NB
         ATrDEOAqwAaPCdLac/salE7Fmq73mMHJbpjHOaOL07Es7c9cVWGiWm+WZRvmbf7elDzF
         BA8E7SOpTN58Qnpph6STZtRFPR64WNZxS/GsU8nuGdUuWDEm4HD1pbYlI+TjbwRY265F
         CHO1yCnCbD2Eb/baWc/w2RTX5bElFPucouOGBDlyyFilTH14BdYJHZagOFWpmeX3QhOU
         nEBkxH+SdVdvPEMxBXfiodL5gB8fR4voQmEzr92H6FjisvLdpvZ44cDSvfjztiP15wR9
         /fxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754422805; x=1755027605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMI5Xwq0SqGXnmGRw5QTZMv+U2y6SNaFWej8c2zdngA=;
        b=E2tKSveeRi5hy0VSNiTHYKrit3tuKaZWrkc+L65NWaKpQYjY/DJy4vQaZCJNbhZjtB
         aiWkhYuhzDAXGAi5YN4wTspZL8/YdonkIMVBsZGA2X14/j+MxRnS+9vOzfnTYBxce1Ob
         K9TztSDSEmAaI+ts/DQGc5+jy4XgXrnLG+spCEv8wKk0xgKmLfBmv+UBq9R82rAt68ER
         ByiaSK8jykZyk3DxRMkRkKY8LDD9Q2GNw3puSmjAhasRxhRC9/Qozm++MQJjEk4ELPN7
         ybNaJ+IjPGvKG9V44goiNUainNH/h0fKi2vRQDATDRbj9TXgGymRVjGZEYcoZcfcEgrq
         cJtw==
X-Forwarded-Encrypted: i=1; AJvYcCXCJg+z7tkWOOdJ4tp98qynvkcedVT8olQBxaJr9BARLdN4i6aJKu+LSwXeSomfGGLNYE9genCIk7Qha00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7iVpBYCLg8Lz9+a1Xv4wanGU9nfj23ANsB8Hsvq96uzfQtzH0
	L/yO7C8htY1GaVH4WLEZUxP3855CC0IKNXK+phw6YAcV07XrlixYkTkea6bnP5Hh090=
X-Gm-Gg: ASbGncuq6zqlOpbTxx8X+D3tIXmzsPXQzuqmnt2LST5qxISDSweGxvP6R+7t4whLJIh
	xTOTa5sDZpzkZVqh2ueKiqinY/Xzx0lIQBMF3SVd9OfS9/w+Wcu7bkrhyb7pf4pQ5s5mFemjGiU
	sDmb0C/sXq3KAAOnl6RBZ4LbDmgfBDwEoyL8RYFfJ/RXEK39xDyX8O7sRx6/4FSXng6IAHCysxu
	GTggdnZNgr1ijNlNLlFIodLPFKtlD2PufPvroemzwvDQ+C4iG7r9N/e33r6svBXpS35jcqrXZBf
	fHh+Zeibdc9REeqDX+aUR1c5yC4yQss4pLeuGiqAFEQ4ywrTR+FYAnx9ruuwmK7W5VqBCXBM7vd
	0I9QPf5ZrpEKzYHTl1xtMqghgU1ixEgLSxDApY8aVbTbUW4FaQXc0xDS2JxkjcTjqS8jSon6Hjq
	cI5rKfTg==
X-Google-Smtp-Source: AGHT+IGslZriZ3OsEZBWmVfkk5oCBsMISvqP0jsnyJuJf09cg7efSarv3MBZUu5//ACqxd//7g3UxQ==
X-Received: by 2002:a05:620a:430a:b0:7e8:2e5:feb3 with SMTP id af79cd13be357-7e814cf9504mr90508985a.1.1754422804849;
        Tue, 05 Aug 2025 12:40:04 -0700 (PDT)
Received: from jesse-lt.jtp-bos.lab (pool-108-26-215-125.bstnma.fios.verizon.net. [108.26.215.125])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f7064b0sm717855685a.54.2025.08.05.12.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 12:40:04 -0700 (PDT)
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
Subject: [PATCH 3/8] riscv: insn: Add get_insn_nofault
Date: Tue,  5 Aug 2025 12:39:50 -0700
Message-ID: <20250805193955.798277-4-jesse@rivosinc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805193955.798277-1-jesse@rivosinc.com>
References: <20250805193955.798277-1-jesse@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_insn_nofault uses get_insn with pagefaults dissabled, allowing it to
be called in an atomic context.

Signed-off-by: Jesse Taube <jesse@rivosinc.com>
---
Unsure if copy_from_kernel_nofault is an acceptable replacement for
direct dereference in __read_insn.

RFC -> V1:
 - Add new function instead of using copy_from_user_nofault
---
 arch/riscv/include/asm/insn.h |  1 +
 arch/riscv/kernel/insn.c      | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
index ba74e5b8262c..f87e0a48f786 100644
--- a/arch/riscv/include/asm/insn.h
+++ b/arch/riscv/include/asm/insn.h
@@ -553,6 +553,7 @@ static inline void riscv_insn_insert_utype_itype_imm(u32 *utype_insn, u32 *itype
 #include <asm/ptrace.h>
 
 int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn);
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn);
 unsigned long get_step_address(struct pt_regs *regs, u32 code);
 
 #endif /* _ASM_RISCV_INSN_H */
diff --git a/arch/riscv/kernel/insn.c b/arch/riscv/kernel/insn.c
index dd2a6ef9fd25..c8f77c0093c9 100644
--- a/arch/riscv/kernel/insn.c
+++ b/arch/riscv/kernel/insn.c
@@ -2,6 +2,9 @@
 /*
  * Copyright 2025 Rivos, Inc
  */
+
+#include <linux/uaccess.h>
+
 #include <asm/insn.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
@@ -74,6 +77,17 @@ int get_insn(struct pt_regs *regs, ulong epc, ulong *r_insn)
 	}
 }
 
+int get_insn_nofault(struct pt_regs *regs, ulong epc, ulong *r_insn)
+{
+	int ret;
+
+	pagefault_disable();
+	ret = get_insn(regs, epc, r_insn);
+	pagefault_enable();
+
+	return ret;
+}
+
 /* Calculate the new address for after a step */
 unsigned long get_step_address(struct pt_regs *regs, u32 code)
 {
-- 
2.43.0


