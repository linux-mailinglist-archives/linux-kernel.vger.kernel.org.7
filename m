Return-Path: <linux-kernel+bounces-891679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56666C433D1
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35FA64E28B0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ACF26D4CD;
	Sat,  8 Nov 2025 19:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kD10iIxX"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29C5270542
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630942; cv=none; b=qsA892ELiu8XDXc0OKm6n3CZwkKwmJ5eaC31g+J7E+h6WgM5MVV+3EOAQLqKmCvb1AwjvTmpvDpXiK+Cd6dCfCiBizYRY1ibbJaB/SNONVxDGTULHuj34ieVhaijhWwx0WZeQn6aLPaeIfVYlW+TyB6THSTjycwC7cspXNrn46M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630942; c=relaxed/simple;
	bh=wqvT45qGYMuDuQ2nycCKDD1dsJd4Ss57Ns77t1WjGKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5IZP72VawZx8p1gqFBkNmjYuxeQiNdvssvgmn41z86uSXzulZELs0DqqNtYfsA6LALtIJJkcw3M4LotYkIFXPrZEOPpytF/4LRKHCjy34XtzPWZ1ZdGU7YZvu7PDOMBTmbP3Kbx9eRvKyo0ICDZJX6iz5Ewnucu5YNGJ0WUi/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kD10iIxX; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3717780ea70so17844851fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630939; x=1763235739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=kD10iIxX9rEVJmzZ3uZ0xowNdeIAX2lY7M5AA9URSYxqCcDLN3EEeScI8OexXBWvd5
         R8o19CH+srssn5guvdaFqApdQuk2ACS+zJoSGhk6mjDdb5RhTvDaykURrTy4vHBAKL6c
         bTeqDSNbLe1P0pQnkCxR5SiRjLKj88OA8dtgvmkdqr7IBr1EfyT3cOyVx6UFe4TiclS/
         TJ7aFo5SIYJ2lPZzeKv9X2TRWUXKfxQXNb063xrKfSsPcB2Po0DT7pObF5wwUgIklpz0
         rx/IN/pJ0fHuQO+5YDlJCklPVg9NbfMoz6J8OHAqcDY7xwbb17ObZ9CIttg3PewD04Wz
         p4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630939; x=1763235739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=pfV3S2a05oEcVd2fNLdcXBmVVhHemkaZ2iyO/fy9KY0NAwqCP6vYlyoAbokDJfjz3I
         A4t6fuF4bj5b3/+tlJLbnb5H7mFXCYJSE3xQPfeBrxv/gWXY0+ioOlSHhCEcGQWA1qPN
         Ms8IuWQFA7ZfMKygk9z4tAOtV2efpMDvAeIbsoHG/roqAw5vZpZ847aO3IfAUwgmb+6q
         rIemNiO7Mr1ntvqX/M4qGy5MkZRNNyTtqIoBW5CIhZCpqHcJZKmF7VuL1YgffIDT3Vyb
         dIwO+gqRmDNPTXHrbEgMw6P16qGjvtyUNx9XBCq7SZHvA8wS9lXTWyhObqaiFFph0/ji
         dGNg==
X-Forwarded-Encrypted: i=1; AJvYcCVf2NAt8MCRBromWkwAIElvZVrs6Ro9bOdMZ/C84tJWTb9QA6w4YyoX7foI/V69zmLNVd91GlKwUa11V6A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye8XtHwYkiDmpH8b+yGnV0QuMi3oQZY1FPITsUZOSeQsYbRLkY
	i/DcGvFReR1cm/4FNM/tc4+2WtcKzCvlCT4fPodmxzbWEnPyxGJZkEX2
X-Gm-Gg: ASbGncuykbooZQ92ckFtgpEV5fpZluuTfIr3jeQsIbcvWQaBe60KRHPdoL4UgoA+40c
	Wu4gei/Ugta7SrZHKFYqlDVcygQojlfHuTN/o/qIlQlKgMc0DuxNYkDlFDlSmQ63UToZWRCtvvm
	DPkI4MlCPWM37tO2zka6jdAMP/EFybc39Oa3BmGhMAbYa3cX63C9nnWojygjZGNAQFw7tg5CRDQ
	2COCX5TKPnPymUl8TMKPFDN9+hLtcUjuu902SxaChO/GMQGNzZ0qWOPPbKtyZcxuDI4cXTcmeta
	A/Q8k+Ce4lSDCd6aYv0lAumdQ4aftweEPmsdftrn5rqqu7nSScpA97aEJMTpXTvhvfeudf2v+Ri
	IX0KeNh19xmCIqhyMuCNCFRWmFOz8tz7VPifCnTlo2fQXhiN4QOV3zaWlfKciwuIV38M=
X-Google-Smtp-Source: AGHT+IF3y7EhnrI50/eOKBcDvbA1ZdP19crRLl5icMKNiFVT61otI/EZ1TlvdKRA1oAFy9eUXhK/mw==
X-Received: by 2002:a2e:8796:0:b0:37a:2dfa:c774 with SMTP id 38308e7fff4ca-37a7b1f475bmr6593681fa.31.1762630938599;
        Sat, 08 Nov 2025 11:42:18 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:16 -0800 (PST)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Thomas Huth <thuth@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Andy Chiu <andybnac@gmail.com>,
	Samuel Holland <samuel.holland@sifive.com>,
	Joel Granados <joel.granados@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v4 1/9] selftests: riscv: test ptrace vector interface
Date: Sat,  8 Nov 2025 22:41:40 +0300
Message-ID: <20251108194207.1257866-2-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251108194207.1257866-1-geomatsi@gmail.com>
References: <20251108194207.1257866-1-geomatsi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case to check ptrace behavior in the case when vector
extension is supported by the system, but vector context is not
yet enabled for the traced process.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/.gitignore |  1 +
 tools/testing/selftests/riscv/vector/Makefile |  5 +-
 .../testing/selftests/riscv/vector/v_ptrace.c | 85 +++++++++++++++++++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/vector/v_ptrace.c

diff --git a/tools/testing/selftests/riscv/vector/.gitignore b/tools/testing/selftests/riscv/vector/.gitignore
index 7d9c87cd0649..d21c03c3ee0e 100644
--- a/tools/testing/selftests/riscv/vector/.gitignore
+++ b/tools/testing/selftests/riscv/vector/.gitignore
@@ -2,3 +2,4 @@ vstate_exec_nolibc
 vstate_prctl
 v_initval
 v_exec_initval_nolibc
+v_ptrace
diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
index 6f7497f4e7b3..c14ad127e7fb 100644
--- a/tools/testing/selftests/riscv/vector/Makefile
+++ b/tools/testing/selftests/riscv/vector/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2021 ARM Limited
 # Originally tools/testing/arm64/abi/Makefile
 
-TEST_GEN_PROGS := v_initval vstate_prctl
+TEST_GEN_PROGS := v_initval vstate_prctl v_ptrace
 TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc
 
 include ../../lib.mk
@@ -26,3 +26,6 @@ $(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
 $(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
 	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
 		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
+
+$(OUTPUT)/v_ptrace: v_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
new file mode 100644
index 000000000000..6a4b5a2ab4a2
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include <linux/ptrace.h>
+#include <linux/elf.h>
+
+#include "../../kselftest_harness.h"
+#include "v_helpers.h"
+
+volatile unsigned long chld_lock;
+
+TEST(ptrace_v_not_enabled)
+{
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	chld_lock = 1;
+	pid = fork();
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		asm volatile ("ebreak" : : : );
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		unsigned long vlenb;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
+		int ret;
+
+		asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+
+		ASSERT_GT(vlenb, 0)
+			TH_LOG("vlenb is not valid: %lu\n", vlenb);
+
+		/* attach */
+
+		ASSERT_EQ(0, ptrace(PTRACE_ATTACH, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* unlock */
+
+		ASSERT_EQ(0, ptrace(PTRACE_POKEDATA, pid, &chld_lock, 0));
+
+		/* resume and wait for ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* try to read vector registers from the tracee */
+
+		regset_size = sizeof(*regset_data) + vlenb * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		/* V extension is available, but not yet enabled for the tracee */
+
+		errno = 0;
+		ret = ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov);
+		ASSERT_EQ(ENODATA, errno);
+		ASSERT_EQ(-1, ret);
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
+TEST_HARNESS_MAIN
-- 
2.51.0


