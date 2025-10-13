Return-Path: <linux-kernel+bounces-850201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7032FBD2390
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 564DE3C101B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1EDA2FC00A;
	Mon, 13 Oct 2025 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="aSsoE2Kp"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479DB220F2A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760346822; cv=none; b=Ghtv3Tr1CxjvQW9OeBE6Y6w5pu4u6C5IY5/bTjNdhrA9tEa0eilSqSP8BHhqpdS+6RZb3OBZYLPrqkPObG67qK4R+QI/6qFMAx7KkWlpzBvCvatqmTOjNTQdVO3nF52IrQfNBPvB3zqr+FjNZLpPbAmGxZ4srgrLDoGwZiGTurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760346822; c=relaxed/simple;
	bh=VavxYdXP2iq8KqnG1lcGVLajXBDIkAsm5dC0mvp1sE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bBFAo1AYKKtxmqI0e3o/TTUXegAKLRJLYTB5ldol+ieuw0fsxCCN+TWRRmYzZ0XHUOO+eFqWnoJC+WGqyuDA3zcuqB+wz66ggh5grrrq/vdaRbYBG86+Q2DZjbU5DqLUMyGfp77hUhyrwld3f45xIPlkQZ970KT0ojlCiqfs7Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=aSsoE2Kp; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso3406053a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1760346820; x=1760951620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFj9xLi3LnEMGw6G3Wf4UB2AVyo9o54zpzf1a0v6M+U=;
        b=aSsoE2Kpcfs9Tr7pfMqJvyWCX9rACW3+BBwRyMW+m3RrToI8qtjPo2z+8COSeL7xdA
         2pnDehJ6zXRtxPtPThzsdL+x+0pIMoFwrseZc+wEMHADMAv946q1dM4eeJTKpNjfBZHu
         QldCp4iX5zjTShl8RGjvVPC4b8C1SEuZktzyhHJzHbfFa7UP7QAnrtVmakuhj4bHUVeJ
         gPH9UInVA2psqoQLRA9jZEYqcxsGkgE+P5n3v5EM+WtNKTUir9HbRJNtxmSV4rEPhPUp
         MqBb/y6KteoCBPI2WHW238ScTJPGXffawLo4XKA08BvuauulN+zBEtkV5rb9rUL42D4o
         VoGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760346820; x=1760951620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFj9xLi3LnEMGw6G3Wf4UB2AVyo9o54zpzf1a0v6M+U=;
        b=VTf3PrM2yLDiumho+nwHdgpXqVZJ2FuekMUAXsqN+xUQuTsuMZxvWUfxhTPiQ6fmBs
         rYSzQC+GFXEWZ9+A7mPtpXmdE/zjFbQnGY1T54K21I1osM7IyyzHsjDj9tdxI5mhhwR6
         UdM3Qiu/9IgzhgTLja4YALqn0/T3RzPlYqnhaTjHgKFIFrbcFh7onEoK7nZNE8N5E11z
         nCP9U6DIcsH2ykXZNUc4SjqImJt2K8Eq+GMelr++ICPl8UCtsGj47npj01Aw6S4xEhb1
         GpXFJaWMmmHRf6gp15WunImSEJwd76iojgnWBd1e3bE/zHbCD/Hw/Lv6O22shou/PbBX
         Qh6w==
X-Gm-Message-State: AOJu0Yw+g6sdKSCstu0ZyVQu9VO0glFf9n1xycMlDdaPj/tL4EGnOsN5
	9YtbubxPnE6wyxALHkc1aJ1zYfAa1WUBUwRbYllMyazS201FOstLuur6uq8szsX143BMgu+AFiQ
	a46wCUWs/BEjyTuYRGzlV8UukZiCQo8UePFLZsIVHSbpPaC5j7d+bxxF85gS+Bhxmk3jvjQGkWT
	9tDNI9/ldwsJFKZSGC+3inawhCheVt0AwBUfgD32Qt9cRnqLFc9AINjVg=
X-Gm-Gg: ASbGncvj/WVEtmWnJvC4z5JFg0fyZFk7wgdvj5bw6TrhjZT/2sxsV0ShVXW89WzVexW
	c3g2WRzGZeiTBvcF7uM00eo4LiLKPBPPdDdwsJHPwuj4XMM5VfYFoRLGhC60W1JVho8F1jH3AeK
	Z3XTCYFsMPSplxSnEgwzookklMVpnpirQ9QdjrNgtWsBGVPXvRx2rNmyPjfWGx0dCzFYwQSLiYe
	sMWrSbAXrOFD8LtycS90C7oBhGQ5rSizWi0/n27RpXrE/JlijVuKJV40c3Y+80FGgtBIHuUdMfp
	NVjZN4YvKmBNt8sinVYzqFuTlD9zIw/nrsEBXIQA0Pr4PEw6vuyd4H3Ns+b4tJSHzoInVzYkfcY
	wwVZPDW8+UFW3vZzqgvlV8dDjI4xE/T6rJUq2rkA5nDYG1vTQjqD4rOAOhvSRb7DM9IJfHKOP+8
	agSocJVQ==
X-Google-Smtp-Source: AGHT+IGGBerV5gmEz5nYLELIKBvPRrxwSj1xMSUUrx0dWROhh+mbZDQA2qGI9XfUfIzxPBi0TqZxcA==
X-Received: by 2002:a17:90b:3843:b0:334:18f9:8008 with SMTP id 98e67ed59e1d1-33b511174e6mr29432495a91.8.1760346820010;
        Mon, 13 Oct 2025 02:13:40 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b61a3cc0dsm11727220a91.9.2025.10.13.02.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:13:39 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Shuah Khan <shuah@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v2 2/2] selftests: riscv: Add test for the Vector ptrace interface
Date: Mon, 13 Oct 2025 17:12:32 +0800
Message-ID: <20251013091318.467864-3-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013091318.467864-1-yongxuan.wang@sifive.com>
References: <20251013091318.467864-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case that does some basic verification of the Vector ptrace
interface. This forks a child process then using ptrace to inspect and
manipulate the v31 register of the child.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Andy Chiu <andybnac@gmail.com>
---
 tools/testing/selftests/riscv/vector/Makefile |   5 +-
 .../selftests/riscv/vector/vstate_ptrace.c    | 134 ++++++++++++++++++
 2 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/vector/vstate_ptrace.c

diff --git a/tools/testing/selftests/riscv/vector/Makefile b/tools/testing/selftests/riscv/vector/Makefile
index 6f7497f4e7b3..2c2a33fc083e 100644
--- a/tools/testing/selftests/riscv/vector/Makefile
+++ b/tools/testing/selftests/riscv/vector/Makefile
@@ -2,7 +2,7 @@
 # Copyright (C) 2021 ARM Limited
 # Originally tools/testing/arm64/abi/Makefile
 
-TEST_GEN_PROGS := v_initval vstate_prctl
+TEST_GEN_PROGS := v_initval vstate_prctl vstate_ptrace
 TEST_GEN_PROGS_EXTENDED := vstate_exec_nolibc v_exec_initval_nolibc
 
 include ../../lib.mk
@@ -26,3 +26,6 @@ $(OUTPUT)/v_initval: v_initval.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
 $(OUTPUT)/v_exec_initval_nolibc: v_exec_initval_nolibc.c
 	$(CC) -nostdlib -static -include ../../../../include/nolibc/nolibc.h \
 		-Wall $(CFLAGS) $(LDFLAGS) $^ -o $@ -lgcc
+
+$(OUTPUT)/vstate_ptrace: vstate_ptrace.c $(OUTPUT)/sys_hwprobe.o $(OUTPUT)/v_helpers.o
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/vector/vstate_ptrace.c b/tools/testing/selftests/riscv/vector/vstate_ptrace.c
new file mode 100644
index 000000000000..1479abc0c9cb
--- /dev/null
+++ b/tools/testing/selftests/riscv/vector/vstate_ptrace.c
@@ -0,0 +1,134 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <stdlib.h>
+#include <asm/ptrace.h>
+#include <linux/elf.h>
+#include <sys/ptrace.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include "../../kselftest.h"
+#include "v_helpers.h"
+
+int parent_set_val, child_set_val;
+
+static long do_ptrace(enum __ptrace_request op, pid_t pid, long type, size_t size, void *data)
+{
+	struct iovec v_iovec = {
+		.iov_len = size,
+		.iov_base = data
+	};
+
+	return ptrace(op, pid, type, &v_iovec);
+}
+
+static int do_child(void)
+{
+	int out;
+
+	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL)) {
+		ksft_perror("PTRACE_TRACEME failed\n");
+		return EXIT_FAILURE;
+	}
+
+	asm volatile (".option push\n\t"
+		".option	arch, +v\n\t"
+		".option	norvc\n\t"
+		"vsetivli	x0, 1, e32, m1, ta, ma\n\t"
+		"vmv.s.x	v31, %[in]\n\t"
+		"ebreak\n\t"
+		"vmv.x.s	%[out], v31\n\t"
+		".option pop\n\t"
+		: [out] "=r" (out)
+		: [in] "r" (child_set_val));
+
+	if (out != parent_set_val)
+		return EXIT_FAILURE;
+
+	return EXIT_SUCCESS;
+}
+
+static void do_parent(pid_t child)
+{
+	int status;
+	void *data = NULL;
+
+	/* Attach to the child */
+	while (waitpid(child, &status, 0)) {
+		if (WIFEXITED(status)) {
+			ksft_test_result(WEXITSTATUS(status) == 0, "SETREGSET vector\n");
+			goto out;
+		} else if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP)) {
+			size_t size;
+			void *data, *v31;
+			struct __riscv_v_regset_state *v_regset_hdr;
+			struct user_regs_struct *gpreg;
+
+			size = sizeof(*v_regset_hdr);
+			data = malloc(size);
+			if (!data)
+				goto out;
+			v_regset_hdr = (struct __riscv_v_regset_state *)data;
+
+			if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_VECTOR, size, data))
+				goto out;
+
+			ksft_print_msg("vlenb %ld\n", v_regset_hdr->vlenb);
+			data = realloc(data, size + v_regset_hdr->vlenb * 32);
+			if (!data)
+				goto out;
+			v_regset_hdr = (struct __riscv_v_regset_state *)data;
+			v31 = (void *)(data + size + v_regset_hdr->vlenb * 31);
+			size += v_regset_hdr->vlenb * 32;
+
+			if (do_ptrace(PTRACE_GETREGSET, child, NT_RISCV_VECTOR, size, data))
+				goto out;
+
+			ksft_test_result(*(int *)v31 == child_set_val, "GETREGSET vector\n");
+
+			*(int *)v31 = parent_set_val;
+			if (do_ptrace(PTRACE_SETREGSET, child, NT_RISCV_VECTOR, size, data))
+				goto out;
+
+			/* move the pc forward */
+			size = sizeof(*gpreg);
+			data = realloc(data, size);
+			gpreg = (struct user_regs_struct *)data;
+
+			if (do_ptrace(PTRACE_GETREGSET, child, NT_PRSTATUS, size, data))
+				goto out;
+
+			gpreg->pc += 4;
+			if (do_ptrace(PTRACE_SETREGSET, child, NT_PRSTATUS, size, data))
+				goto out;
+		}
+
+		ptrace(PTRACE_CONT, child, NULL, NULL);
+	}
+
+out:
+	free(data);
+}
+
+int main(void)
+{
+	pid_t child;
+
+	ksft_set_plan(2);
+	if (!is_vector_supported() && !is_xtheadvector_supported())
+		ksft_exit_skip("Vector not supported\n");
+
+	srandom(getpid());
+	parent_set_val = rand();
+	child_set_val = rand();
+
+	child = fork();
+	if (child < 0)
+		ksft_exit_fail_msg("Fork failed %d\n", child);
+
+	if (!child)
+		return do_child();
+
+	do_parent(child);
+
+	ksft_finished();
+}
-- 
2.43.0


