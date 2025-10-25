Return-Path: <linux-kernel+bounces-870139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D1EC0A04A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3623BB5DB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB35C2FE58E;
	Sat, 25 Oct 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkIWzGlK"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 361D830ACE1
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426451; cv=none; b=HrsFmWTNJEjKm3NbRKJgJDHyMtTymCQ6SPyG4oGZzzFnRsRURE7CcPchse4HBzvydAtpfhkSoZKNA9qSr94MDbO2WSV5tHRRi4l6Cp12uzNJcN7Cl4MRVNSKyXk+1c1MB2OohAq5cJXqWz4dcydEFk3HH9nXHUeww76uoRaVqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426451; c=relaxed/simple;
	bh=bz4AVTDuToeNKL+LjIYRiFpz7c4y7G6iLzEWh8yM5O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaD1p5jVB1qgk3LkI4GA3PCGeVNY9sZ76dlGROaQ69Mv8aDpxWCHETD3HI6qd/bv5d7h3BbF+md+E+v6WM2/zeecyT96E7nA+8vR3q4pcpXeqo1mR7New43G8eAkODqS16iAc7l+O4f9v4T1SAdo6yLxH+587/GfoW+2ZrUJC6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkIWzGlK; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-592f098f7adso3998242e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426447; x=1762031247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U/WytJDhcml/wh8CfWvtXKArp//bBeFRbcjbh31QcQ0=;
        b=YkIWzGlKADxCL92Rd4eJ/PtvovvbTeC0KC4+GX/W1iEAQHJG5JnjEGzSI91ezg0aDg
         3Ftd0+KnVyC8Z90kKclSoqH2Ghc/sFLBuELt4XlH9iD0hSOSczGKD44WoPhYDffWHoyg
         hmLwtOQe7Z13ac9Ozspb7NgyYr3KaQTDzru/erevfYkEMvJ3rSKVsdw+Q4oTHtdFMuU9
         7HUQTvAwjfu53g5Mq1VhS3AqS/30rOfFZKUYxICM9XAZIMMMpoyObMrU9/hBvFHxP0q3
         gm6Wx4i/ILGC2B28Vh8A4equkXXtJ6e7zBGXtLJ1Wc7FGbAbiv7OX1G/IB6ZTDhFXvTb
         tsRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426447; x=1762031247;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U/WytJDhcml/wh8CfWvtXKArp//bBeFRbcjbh31QcQ0=;
        b=U9UCM2SnRHzm5TshR/79ziEjtipVEb1h8sJGJgYgy+3HSgsgHYqgapIxIU673Z0hTx
         Xre/pNv8hh/ITelN6OJ39gcqYE17paZ/856LhGG1c1DiLcnXoeuq+zN1ShnA46KwTFkB
         PApfzRO2Rv9N7hxSg3xXzD2N2aHgVA2oVnn5WNKHMlck4Zp+ik2j71wOiqjrDz7rGZ9O
         eslLLk6/kuq69BdfhnT0lQRYW4AMwCclRbS40So1rGF+ewqSE2vuYss6RS4Pwmcq0qSV
         Uxp8PKRnZnNOy2wW+mUtYLtf6Hc+v88fPTRqJbicxxCwpuEbYfWyUskniSJLhePu4ody
         QFLw==
X-Forwarded-Encrypted: i=1; AJvYcCVMwhOL6NRik0XGIZXnZp0lcUiGxJvDRMJZQp89aA3bSnEY5ZIiW+OzWppYaXXUaqJgD2Y2t0xdXNVeMmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHWJOw9Lw8u1TLV/3YkI6/6Dnw14wCKlc2TGOMVxIrf5ithnw
	nSgQUiQAvh9Gknk1pi+QXCQUtHSP0v8+8y20bcbugfEkBOlDcmlD1N8z
X-Gm-Gg: ASbGnctJMi6Zbdpi53HTPYA1is8M70eZPakfwvw+N64pmiuCdRRYyTyeIxilJZcRvJz
	96esJEvFa+qfpuj/pCc1Iloe/hzi2iRMiJ1Y9Ia5YKheAGMiOsorN/2b+2O4sA2qeZaaaFp4a4D
	ujm+cqNSUm6AzoJzmfrEKtwcQXQbYIFFlF00A4IOmZ64vBSxmivNbsR5gkamyMZeBfD65EXxl0c
	njYYs1ZSOfl96oErgOxhNVwpSQAd766PbVVuorGIJSsOQnZKU30sCM5I9IRyYYzKBq8zjo3LLU5
	XQSOp2wnn/PhR9HUnDR/C5KPh77nAgnCmd5z/vOAS6Fc1PHXzX6VqlnsTicvYtBloBPUma1sCtK
	xKhc7YWr+ehvchxcCr4p7r2NX+7FCNndSQS50JxaHgaZSoP/diToz/B4KfQs1BU8XpTs=
X-Google-Smtp-Source: AGHT+IE1sREq3fH/oWR2aWw32GwHAGJvm4v2GsuZh2SMIXAA5/VrvNypw0BdSZVh8ZDIWto+ctm6iw==
X-Received: by 2002:a05:6512:3a8e:b0:590:656c:d116 with SMTP id 2adb3069b0e04-592fc9f7f21mr2234095e87.17.1761426447221;
        Sat, 25 Oct 2025 14:07:27 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:26 -0700 (PDT)
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
Subject: [PATCH v3 8/9] selftests: riscv: verify ptrace accepts valid vector csr values
Date: Sun, 26 Oct 2025 00:06:41 +0300
Message-ID: <20251025210655.43099-9-geomatsi@gmail.com>
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

Add a test to v_ptrace test suite to verify that ptrace accepts the
valid input combinations of vector csr registers. Use kselftest
fixture variants to create multiple inputs for the test.

The test simulates a debug scenario with three breakpoints:
1. init: let the tracee set up its initial vector configuration
2. 1st bp:  modify the tracee's vector csr registers from the debugger
  - resume the tracee to execute a block without vector instructions
3. 2nd bp: read back the tracees's vector csr registers from the debugger
  - compare with values set by the debugger
  - resume the tracee to execute a block with vector instructions
4. 3rd bp: read back the tracess's vector csr registers again
  - compare with values set by the debugger

The last check helps to confirm that ptrace validation check for vector
csr registers input values works properly and maintains an accurate view
of the tracee's vector context in debugger.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 217 ++++++++++++++++++
 1 file changed, 217 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 6f3f228c0954..7e8fdebded07 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -415,4 +415,221 @@ TEST_F(v_csr_invalid, ptrace_v_invalid_values)
 	}
 }
 
+FIXTURE(v_csr_valid)
+{
+};
+
+FIXTURE_SETUP(v_csr_valid)
+{
+}
+
+FIXTURE_TEARDOWN(v_csr_valid)
+{
+}
+
+/* modifications of the initial 'vsetvli x0, x0, e8, m8, tu, mu' settings */
+FIXTURE_VARIANT(v_csr_valid)
+{
+	unsigned long vstart;
+	unsigned long vl;
+	unsigned long vtype;
+	unsigned long vcsr;
+	unsigned long vlenb_mul;
+	unsigned long vlenb_min;
+	unsigned long vlenb_max;
+};
+
+/* valid for VLEN >= 128: LMUL= 1/4, SEW = 32 */
+FIXTURE_VARIANT_ADD(v_csr_valid, frac_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x16,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x10,
+	.vlenb_max = 0x0,
+};
+
+/* valid for VLEN >= 16: LMUL= 2, SEW = 32 */
+FIXTURE_VARIANT_ADD(v_csr_valid, int_lmul1)
+{
+	.vstart = 0x0,
+	.vl = 0x0,
+	.vtype = 0x11,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x2,
+	.vlenb_max = 0x0,
+};
+
+/* valid for VLEN >= 32: LMUL= 2, SEW = 32, VL = 2 */
+FIXTURE_VARIANT_ADD(v_csr_valid, int_lmul2)
+{
+	.vstart = 0x0,
+	.vl = 0x2,
+	.vtype = 0x11,
+	.vcsr = 0x0,
+	.vlenb_mul = 0x1,
+	.vlenb_min = 0x4,
+	.vlenb_max = 0x0,
+};
+
+TEST_F(v_csr_valid, ptrace_v_valid_values)
+{
+	unsigned long vlenb;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+	if (variant->vlenb_min) {
+		if (vlenb < variant->vlenb_min)
+			SKIP(return, "This test does not support VLEN < %lu\n",
+			     variant->vlenb_min * 8);
+	}
+	if (variant->vlenb_max) {
+		if (vlenb > variant->vlenb_max)
+			SKIP(return, "This test does not support VLEN > %lu\n",
+			     variant->vlenb_max * 8);
+	}
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
+		asm(".option arch, +zve32x\n");
+		asm(".option arch, +c\n");
+		asm volatile("vsetvli x0, x0, e8, m8, tu, mu\n");
+
+		while (1) {
+			asm volatile ("c.ebreak");
+			asm volatile ("c.nop");
+			/* V state clean: context will not be saved */
+			asm volatile ("c.ebreak");
+			asm volatile("vmv.v.i v0, -1");
+			/* V state dirty: context will be saved */
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
+		/* verify initial vsetvli x0, x0, e8, m8, tu, mu settings */
+
+		EXPECT_EQ(vlenb, regset_data->vlenb);
+		EXPECT_EQ(3UL, regset_data->vtype);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(0UL, regset_data->vcsr);
+		EXPECT_EQ(0UL, regset_data->vl);
+
+		/* apply valid settings from fixture variants */
+
+		regset_data->vlenb *= variant->vlenb_mul;
+		regset_data->vstart = variant->vstart;
+		regset_data->vtype = variant->vtype;
+		regset_data->vcsr = variant->vcsr;
+		regset_data->vl = variant->vl;
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
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
+		/* read tracee vector csr regs using ptrace GETREGSET */
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify vector csr regs from tracee context */
+
+		EXPECT_EQ(regset_data->vstart, variant->vstart);
+		EXPECT_EQ(regset_data->vtype, variant->vtype);
+		EXPECT_EQ(regset_data->vcsr, variant->vcsr);
+		EXPECT_EQ(regset_data->vl, variant->vl);
+		EXPECT_EQ(regset_data->vlenb, vlenb);
+
+		/* skip 2nd c.ebreak, then resume and wait for the 3rd c.ebreak */
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
+		/* read tracee vector csr regs using ptrace GETREGSET */
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify vector csr regs from tracee context */
+
+		EXPECT_EQ(regset_data->vstart, variant->vstart);
+		EXPECT_EQ(regset_data->vtype, variant->vtype);
+		EXPECT_EQ(regset_data->vcsr, variant->vcsr);
+		EXPECT_EQ(regset_data->vl, variant->vl);
+		EXPECT_EQ(regset_data->vlenb, vlenb);
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


