Return-Path: <linux-kernel+bounces-844199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60214BC1490
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3469119A0315
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C642DCF7C;
	Tue,  7 Oct 2025 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eo+SCg32"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734182DC336
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838332; cv=none; b=leHhPbmjVBWhjzVJ9DPX/eu8RRnAJ47/XcsZrKcsztO+w9O8ZcoUK/FS7zEX01OdWFDuexcjBCgzELQGXxXvTftf+upqK6vAYbwXS9L9lCTBmlBF+HIUZzlktbIUfyxuDId6v6SHb4syoDcCYy0J/VYDTwox97Ov4lHpNlwYy64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838332; c=relaxed/simple;
	bh=gmEQJf5Bo7Ywu22iwV79iM0TcDkDXIsr2veWZZhyazc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZJ/lxFx3m+n+oM71ibgwcorepG42DBM/cSAxxtFfnwk9bN7EA40cTBr7cJ04bbH7FZHOX7BdGdZluPJaZTr36VNHk7j/le9Etkih7rQkl0VW66flcSc+x+M3jCCPBWpmwv3B27W1SmmG4ZHdDDYp5VuHqzXXJzlSx+FV95z8v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eo+SCg32; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-58af7f8b79dso6701904e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838327; x=1760443127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eN/m6BO/PR+KoZSa3zwPl5m9cqExBgUP+sv/+YAYIuM=;
        b=eo+SCg32Ai4gE6lg9gVQbimabJtPkAgLcBso9sI3L3wjrofRj3h5BsKKuZ4zF9SDsW
         RCY82MlJOwZUAkyryZvY8uRJG6rUpjU4V1RRgva/2VNZj9DABsN+jMpt219FJCrKTDlT
         NsCoA5G3kn71blotUssjypZXyM9NxL7yE5ZELA/bFTpuRO9VRAzNcOMUy+GRmiEwHUla
         4pvEMtpWzVX8r2rGMRowzVy6/d64DluNwab5cgTbkOodPJSk9Jk8WfEjjfNyfKU/skOg
         qW6pbzp3DIkfDVc3b/KpJ0meZ6IlS3A/ZI1oL6gaPi/4hnjH69zZv7MfgKk7AIBr1wtA
         F6xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838327; x=1760443127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eN/m6BO/PR+KoZSa3zwPl5m9cqExBgUP+sv/+YAYIuM=;
        b=UkxmvMpBLVjGM1E//ZVqyZuS8y0CFpkLc81wWC9AS+LNZw8jX3LYnjoDBhbmbHuReV
         IkemZ8toI2OWEB7SiQRsq4XO77AN0/N2QDZ/zPtsIvE4BLcuRe9PbHaHA7KZxYChic9Y
         12ppSdQMwZvaRYQxMKgiATkCyMvEmgMknGKUEhaIBsYUz1QFh1rNx9O8lS0lMc6Yw2GQ
         xb6OlJxoe1O8h8hVxhKXxKpXo99ptopXdgeTnmZ/et/zmkSM2FU29pmh5NN/OUjfk2t1
         GZt9Odw779+FWl86wKuwPm8gpXATKePfM2iI8mHLnotE0qXr6zAw54dU4+tnf1JQiehD
         mh6w==
X-Gm-Message-State: AOJu0YwjaSB1bmbmKtEyk/ry1kqsJDokWxZdBjfkjomOh+hhs84ifu91
	ksEl2ys2q1O7JJRjESKQwyym7xlXXrs9SVYsoTklvXI+qjJuvkL+N9l0Kb3Ep+iK
X-Gm-Gg: ASbGncu7nXQp0robKiYfut2zqe2rRpghPFvF5oFwoP0UQoQU1KLlR6YkaEAifj61Ux+
	PppktPdF0xdiLhuBSleDGDmrq/DmBw3Vpuk4rA4gdQTLd6APF813OrFpPaFPHxiZEpIXT3G23Jt
	C+ihGJzeeUXj6Ks7r4IFw771gAhpHEQ/GvkODJMmhX4i9qgaWl5UUGWV5IRJHt5uDyHkiePoV5E
	pxt2Xj1QKgW4mq0251FYqpFpHgdbT8uyMmCgvTqUpC35jaP8AiDspNGcZ1aY7EutazCh/ozqc9i
	KiK++goxiAXwA4uO4B6+txM9hLUMDfzwoGErrDJq3o8t9Oc9ibtquSH8T2E0NTb7SBp2m4F6hEQ
	7zJQd5wgG8slM+AyV9qjs4xwra6+b6BhPZyMXSA==
X-Google-Smtp-Source: AGHT+IGVHCBDB2QZW+h1zkAX/sQcZXgkJGGPhYHu9ZuoYVYoNE7EgWv7rs3lrzmRXlTtUhHrJYj2Sg==
X-Received: by 2002:a05:6512:10d0:b0:57b:8675:e430 with SMTP id 2adb3069b0e04-58cb9a3907cmr4186418e87.13.1759838327224;
        Tue, 07 Oct 2025 04:58:47 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:46 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Nam Cao <namcao@linutronix.de>,
	Joel Granados <joel.granados@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Sergey Matyukevich <geomatsi@gmail.com>,
	Ilya Mamay <mmamayka01@gmail.com>
Subject: [PATCH v2 2/6] riscv: ptrace: return ENODATA for inactive vector extension
Date: Tue,  7 Oct 2025 14:58:18 +0300
Message-ID: <20251007115840.2320557-3-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007115840.2320557-1-geomatsi@gmail.com>
References: <20251007115840.2320557-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Mamay <mmamayka01@gmail.com>

Currently, ptrace returns EINVAL when the vector extension is supported
but not yet activated for the traced process. This error code is
inappropriate since all the ptrace arguments are valid.

Debug tools like gdbserver expect ENODATA when the requested register
set is not active, e.g. see [1]. This expectation seems to be more
appropriate, so modify the vector ptrace implementation to return:
- EINVAL when V extension is not supported
- ENODATA when V extension is supported but not active

[1] https://github.com/bminor/binutils-gdb/blob/637f25e88675fa47e47f9cc5e2cf37384836b8a2/gdbserver/linux-low.cc#L5020

Signed-off-by: Ilya Mamay <mmamayka01@gmail.com>
---
 arch/riscv/kernel/ptrace.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 8e86305831ea..906cf1197edc 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -95,9 +95,12 @@ static int riscv_vr_get(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
-	if (!riscv_v_vstate_query(task_pt_regs(target)))
+	if (!has_vector())
 		return -EINVAL;
 
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -ENODATA;
+
 	/*
 	 * Ensure the vector registers have been saved to the memory before
 	 * copying them to membuf.
@@ -130,9 +133,12 @@ static int riscv_vr_set(struct task_struct *target,
 	struct __riscv_v_ext_state *vstate = &target->thread.vstate;
 	struct __riscv_v_regset_state ptrace_vstate;
 
-	if (!riscv_v_vstate_query(task_pt_regs(target)))
+	if (!has_vector())
 		return -EINVAL;
 
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return -ENODATA;
+
 	/* Copy rest of the vstate except datap */
 	ret = user_regset_copyin(&pos, &count, &kbuf, &ubuf, &ptrace_vstate, 0,
 				 sizeof(struct __riscv_v_regset_state));
-- 
2.51.0


