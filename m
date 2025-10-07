Return-Path: <linux-kernel+bounces-844200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 82781BC1493
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69BAE4F44FE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD922DE6FC;
	Tue,  7 Oct 2025 11:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnLh4ocE"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CED82DCBF7
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838332; cv=none; b=dIJhufe58N8fDUNO/JSx9HszctE/UFqczqFXbkvwjxEA6gt/hpIcBxwhJM1opGTVmkF7uzM4dg0HXhul3IVf5LigtaMMt4z8Y1OKjj/zKTJDjBRnqmE9jj8yiOP3itX5TqOcGUbFTz0Fv0Um/9AznBUkNuAkd0n+56NHHRTrPjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838332; c=relaxed/simple;
	bh=zd5hjY5wrx8YKzPB1AK38z5RyQ2MEvFwF1ylhr4VaWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C06aIeJ5ryAT6JHKfjmQJwvS7y6qR7WfcZcYOv0izjHSHlWRuB8ZdKSmZqhMrMOOHwiYl9L0/CZL0Ta3ennzYZlaybnnYbLDn3GAc/YAJdfO1SH+w23GyC7qhouVpJ0qSPGEHchOqzMqLTnuDb1QbrSDHFBJpSlxuKAKti2l8Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnLh4ocE; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so6093561e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838329; x=1760443129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bz5jQRJFoVK4+PdvzI4TMgPHFnuOpO8O5iQSmwwrcRs=;
        b=ZnLh4ocEsiWx9HnYpFno2Xrtw5XgS0zT+0zwbCC53FLz/tTJSfnHxsgqlqIv4egwua
         zOPV38Ls7RTiT2J888hmsjvx1D8HTuFSuueu04TLQM2KO27f2Hfch7s/RxLCUaMSashX
         YLPgye9VO4Y77JN7cNFXNYCWB7KhCK3ZswRdeUB1n6ni2bMJQkLQ0bbPTXpweAMnVrOV
         R6B63K0BsT2d7vSulQLNxhUrzwkcnoYc3RpariUDXab4fpiT2LZ42+CcAiMBieYs6tnn
         eLP575srDcrRiMpocO2iVf+vDYhvdLaE1tS2xMhv4dXzYgJ3c/uj1IWJjCDYRHO/+tSp
         uaSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838329; x=1760443129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bz5jQRJFoVK4+PdvzI4TMgPHFnuOpO8O5iQSmwwrcRs=;
        b=v0tfAZGMSPdaD6uq4A5bs1YDX5aKtjwtco8YMQ93Kj1Zy380EAuXgast54dOk4ZUbW
         cKT5jDqk100knMjwssRIdnM7jPmc2VB/dNVZ5Kf0OIzkpQ1RHbUEHNQiSEyRjHS5zASY
         35paFohnklSWkL3CMEmIHSxfXkJh5tfQf67p4nIIyEP50pQsXM31BVeSf2dFTPvZCLcy
         z3EiIcmcXvcZSyBiPHDYZiGv+xmz2SCByuvtoj120FJLsNt8rLRC0gq/WZqbnvwWTSjK
         /DQDB18TiHxyZpdyJz9/EZqNVjNdCM+3YSTidj3cq/+O+S31AtCR07yrHcQEKA91+52u
         HS5g==
X-Gm-Message-State: AOJu0YyPv9PtSpdHZoY5pGCvOY3z+f9keovRr1Eaaz+bTgiQOANuia+Y
	mhSMYfO6jwyPEteJGLoinuWFkBofwfPwWomdeDFMtmoOMThhpEeCkHtW
X-Gm-Gg: ASbGncuvWywVRAF23KUtcUQclt+LQr9aGTH3nB8Azs1wtDT/YAYrhrd4jKwTjpCNcK0
	QWi+Vgz8WShpVoNwopaxSnILAzpDMpfKKdyerjXiO2okQl4hgksc6v2PyOZBthV8nCTZo8tUgik
	xliQEw/HWFQ5eSfmNW2iYlYpyg1yvkbhR0C4s3NK+8Ut/c0ui7YHlxqbsULNhxLWclPsuI+/Ps7
	bXVYWfCVts5g06iS2aiEGkhnR2X45mMogjHDnRjfbqGo6oV/KpYMTEj+42/RldZ+scNPOHGtklZ
	+6FsXFJKUYvuZDg2CBtNRka4GeD4yKgjLOSVTnn7PiBhBM00M7YOvnDI8HbpV2ShSCEA9V5OzRR
	rTdiTAlOVZg6j3IMXyRF9KM6rZypky/AcPmjrVQ==
X-Google-Smtp-Source: AGHT+IHybbaDTUuq3OR2dTh3PRjAv16cf+ofk/HgCXjX/Glsz8ylZkJGopHKGG11y1fc7qEDafksGA==
X-Received: by 2002:ac2:5bcc:0:b0:590:6119:6b73 with SMTP id 2adb3069b0e04-59061196f21mr616166e87.48.1759838328903;
        Tue, 07 Oct 2025 04:58:48 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:48 -0700 (PDT)
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
	Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 3/6] selftests: riscv: set invalid vtype using ptrace
Date: Tue,  7 Oct 2025 14:58:19 +0300
Message-ID: <20251007115840.2320557-4-geomatsi@gmail.com>
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

Add a test case that attempts to set invalid vtype value using ptrace
and verifies that the 'vill' bit is set as required by the RISC-V
Vector specification v1.0, Section 3.4.1.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 112 ++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 6a8d56a5c4f4..ccda8a4dc49b 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -84,4 +84,116 @@ TEST(ptrace_rvv_not_enabled)
 	}
 }
 
+TEST(ptrace_rvv_invalid_vtype)
+{
+	static volatile unsigned long vtype;
+	unsigned long vlenb;
+	unsigned long reg;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+
+	if (vlenb > 16)
+		SKIP(return, "This test does not support VLEN > 128");
+
+	chld_lock = 1;
+
+	pid = fork();
+
+	ASSERT_LE(0, pid)
+		TH_LOG("fork: %m");
+
+	if (pid == 0) {
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		asm(".option arch, +v\n");
+		asm(".option arch, +c\n");
+		asm volatile("vsetvli x0, x0, e8, m8, tu, mu\n");
+
+		while (1) {
+			asm volatile ("c.ebreak");
+			asm volatile("csrr %[vtype], vtype" : [vtype] "=r"(vtype) : :);
+			asm volatile ("c.ebreak");
+		}
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		struct user_regs_struct regs;
+		size_t regset_size;
+		struct iovec iov;
+		int status;
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
+		/* resume and wait for the 1st c.ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace GETREGSET */
+
+		regset_size = sizeof(*regset_data) + vlenb * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* set invalid vtype 0x1d = (5 | 3 << 3):
+		 * - LMUL: 1/8
+		 * - SEW:  64
+		 *   - invalid configuration for VLENB <= 128
+		 */
+		regset_data->vtype = 0x1d;
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* skip 1st c.ebreak, then resume and wait for the 2nd c.ebreak */
+
+		iov.iov_base = &regs;
+		iov.iov_len = sizeof(regs);
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov));
+		regs.pc += 2;
+		ASSERT_EQ(0, ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov));
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vtype using ptrace GETREGSET */
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* read tracee vtype ptrace PEEKDATA */
+
+		errno = 0;
+		reg = ptrace(PTRACE_PEEKDATA, pid, &vtype, NULL);
+		ASSERT_FALSE((errno != 0) && (reg == -1));
+
+		/* verify that V state is illegal */
+
+		EXPECT_EQ(reg, regset_data->vtype);
+		EXPECT_EQ(1UL, (regset_data->vtype >> (__riscv_xlen - 1)));
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
 TEST_HARNESS_MAIN
-- 
2.51.0


