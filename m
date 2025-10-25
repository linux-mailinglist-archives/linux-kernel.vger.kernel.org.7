Return-Path: <linux-kernel+bounces-870132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230CFC0A020
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620A63B51ED
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C487B2DEA7E;
	Sat, 25 Oct 2025 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVFJPAUg"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EEC285C85
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426432; cv=none; b=KHwXWBooO5ah48Djc5/JM+A7V3pS8WT3aRaynZV2KGpyi2Kg/71pBXC0BcYs53SyKj2lY37yNEG6U25kiwrJv2iLAZEVWjnj0xIoJ2QLlvYXs5QZdiAtpJT4WeeTfM2oz/5WNze6DzIR9OwG8jhOzRPXzAZATd+LPktGNPOqLEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426432; c=relaxed/simple;
	bh=wqvT45qGYMuDuQ2nycCKDD1dsJd4Ss57Ns77t1WjGKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGU+YYWAyjE1E9Hx+Pt2Q7pOfJ8QOdhQT80pLA/VpsJgDad4RYjD6CY9wAtCqUoPkW0SpkJWccLYwyd4c0d6GtcktgM8Crc1lQTv5jOBkgo9G0ajlsbvHVuGFw4hiZ1lc5TnWzKV7nHLEN6EaL7s3zKfnc5H5Khg7EGa2MgqKoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVFJPAUg; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-592f7e50da2so3548889e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426428; x=1762031228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=VVFJPAUgHIYA3eLziEu29EshQcGP5tvr/67LUGUx5/Q17aBJIaCKBDYj7EkVXVyUdu
         8pd3KZs66BfsImgZIpaU7b83fdv+bq5+gHBAP5UtkKb2SI8inHCWPMIQL2qFTriTpXeV
         mNCvJGOYdfCqv9HW5TTANhBH7AXw5C9QHji8C73R9VhimyTNOIoaKnUcSu1BaqteSKne
         H+myX7YlChHcFW/lQIEYM2lJtC1a6++e7qeDbNOoVI5g5PJZwdJe5ekqoly1taeFq5FH
         FQvHt+ziiU4IjZ70EaMsqEfJ3yornb39PbnpbmRiCM9YvMnRyaGC1r7fU0vUmOgfCQQu
         ExHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426428; x=1762031228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LHbmnK8ZAa3ArCtkCS3Paq/G1lnDqjyPBKtwjuhO/MQ=;
        b=X4eqAKqrvzTOtR5oPhXAsxJWtmyfjbpGKJfa2HuZhfxtk+TSfhNbZls4l8b2RhJ4Df
         hEgQ1dY49iaISFMRSuTNfpywJMCRKNLiSzuii+8/FQCgGbD4Zepj3GT65AkXJlQnL+EG
         3HQc7csQ5WcWE8bsETYZCSxO9w3QME+469d0+sYXmOm4Uj+xthnfLbH4LMfCB+F3K/W+
         hYIjSZ0wsY447jal9nlhMlmfcl8kGngeSIMYcPCSdFzpLZRZITJgG8sNL/Xwpt/7TcEC
         N0lo1dY0OE/RKYU+eZdOYGqxOKc5YNXlVGq/jCTNMTZQbs3HLXAvpDSFxGdshK5RbDhY
         3jww==
X-Forwarded-Encrypted: i=1; AJvYcCXtGiMxDbVAQW9wf3HZt7/PWSCLBqtPwzRqy8YQXPsdcIaMTv/rxbl4Ybl7rlknfkINGsfxIp+YBaqb4Go=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX1RZEoRgu74WF5MK4VQgph2/XvdMhcyOW1+LL1LhrKuggCCj4
	827iiDUUHGXg44Na+w3lxTaENgQK0bLxmbUOZM0TiSOpLEdqDfQgUVTf
X-Gm-Gg: ASbGncsaR6+4NBgOFihD5LxJo1cX+yvOONqusOcryi1DunKBQLAF+Q55D6cDJ6rb/Gn
	lTT65AUdRq/t+fA4bLI3UAFakBAtf3VeAi45j3vlyphTaHXZXxqdx7ISzxDTVd6F3HrcLrMy0tX
	kc00MuOd322n9jC67tQuJ3nFLgh/6ekWmGwvygaprmKSXYmD9bbpWvXv6lmxowLPxGEzwheeQOh
	OBq0CKbPRSAXnK1pToNwXjU3Uqg3CZ7wDnC/ZGYBdzVXPVLFmGXOaUUdKR0fEOqdWqK+csrLV2l
	GcUcXb7zBrkmPkdSpQxMIc0lccbFZ38rV/EoylRtZ8l4ZyAL85yKNuUHLeBOM298C5rmrBT+4BF
	l+wOXku93JneYNuQwT5KvL+47PRoq5O/1f3Tk9RHoGUxWXA/YHxr7PXWkYifN+mJvOKE9ePr2tE
	uoyQ==
X-Google-Smtp-Source: AGHT+IEDTnYlHsHbxYTMbvTclp6aBf8KAfq0acQrqiIvksnO+SXu5n9y6cipJAxh49NWH/q/DLQsKw==
X-Received: by 2002:a05:6512:ad0:b0:592:fab3:9b1a with SMTP id 2adb3069b0e04-592fc11e15dmr2357987e87.14.1761426427877;
        Sat, 25 Oct 2025 14:07:07 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:07 -0700 (PDT)
From: Sergey Matyukevich <geomatsi@gmail.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
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
Subject: [PATCH v3 1/9] selftests: riscv: test ptrace vector interface
Date: Sun, 26 Oct 2025 00:06:34 +0300
Message-ID: <20251025210655.43099-2-geomatsi@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025210655.43099-1-geomatsi@gmail.com>
References: <20251025210655.43099-1-geomatsi@gmail.com>
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


