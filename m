Return-Path: <linux-kernel+bounces-870140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E658C0A032
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68E9B4E8505
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E37930BB94;
	Sat, 25 Oct 2025 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Do8VN5io"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910D30B511
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426453; cv=none; b=Mokka5Y91jjF0yN0uF/BOrVMlbu0sCeNCb01mV6CeIQvfX4bZIsjvKCews7nnC/6NnM+HZ3dcJITCn6p9HP4lAsRnxaniopHrIL6BogiUoZ2O2pHH0hCluO28EPMiH26046P+ZtfSOpelQgiMRmCyPboAxoMU3YhpW+pqUoLOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426453; c=relaxed/simple;
	bh=2E3Fo1znPlzaabZKXzSWEg4Z8coek9HOIOj+q4wvYWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pOJ5PsvPZj6UqJpuoBXk0h2yFVPB/rZL/avbnhmJNs6u9uBerf2+WmgEMRKrjlC4kGSfyKRKG1vY4HGSmwClcdpywIOBFe1qTtlHk9zvTuDXQAYs7NWAkVAFqAUiOmUHCi+4d16MkbOGg+WoyddKWyHYAz09Xnee2nPX4lganAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Do8VN5io; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57bb7ee3142so3949333e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426450; x=1762031250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFxB+FMNooBfOd2zLjcq46e2Dj/CD31Cyo7lUKy84vI=;
        b=Do8VN5ioaNOWS4a0lJKbTZXM4HBIM57HRFoUvovOoH/Kr9MdFeHLwjpzy1jnHzeq4m
         CyuRXe0oBJeitLMSSnUpu+SrhdYy85Qw0ld1gId3Qkd98xEd6GdiQ9Qy+xMZmaFIlyx2
         Zer8QLG+lIhqX9wl+5YxnZcreHzTY8Qc1PaFUbdpk8cUpTEQphKEexumrfh8+ytujYnd
         rgFlIa+L9MxHzE7rQjp9w2aJV5u24DX+l8FIN+JlPhmCh9LiSTfj+oC5fARBCwDRUS7R
         9XJrfTPVWKc/VzoB1tKn0HyfNcxy7iQNpoYA5/4wWn8/bp6HTd+6zaypV64ykXl01Zgw
         DWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426450; x=1762031250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFxB+FMNooBfOd2zLjcq46e2Dj/CD31Cyo7lUKy84vI=;
        b=StqX0uEd+bfI1qrWHpdVq2NPvsjFWDU8v2yDraxRvXsVGKW7sNGKd07OcXnIlMTw9C
         JfX+RVlP8XIQ6Z+aUdpjfNL2iVz5MIunA5m4NIcs2vLOHNr6WH6Skzmo+t9BN2OwOxWL
         uXZ4I/NAcULYNnyJ4QyujeeALyHwD1cEqjxVzKb8xbwIDMh3QcTp3Z9mdy5so74/9G+O
         8j1QWk9WghEwcNGE9RJcAhduJ6tD1icsgEDsnHbMWjcVH81S0BpVGLObMJ5k27YpL3Mz
         BDE2bTKdgoqREd9Zt14Baa45h6YH2mFgeWb7As79DdR5v29aXZUeEGujlYiRrludCx09
         6IIg==
X-Forwarded-Encrypted: i=1; AJvYcCXjv2QvaFEV4psqUtoqZFQvdbamBXrdTVtaIux3RDmb3JJn3+aS06OwBF0+JtY32Ha53eX60UAR2LiEg44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHnHgtTcjpMnBcNfLewgitkFW/0pKZgYDZ5co4nQd22KWBNiJP
	WQOy/5E0lTaJg/9N4ro5GeK7x2b670wopW9q1PBvOI7Ct3aTdIFYieZv
X-Gm-Gg: ASbGncsWfZOYT6h2vRPNytxkDgX/GUmfmbzYZ7MFjcWBJQnWv6VkAo9VpnFQYBV4Mol
	FAVf0L+BTmDqQLp8f0QwduA+q/etyTLEZ77LZeSr1n+mNLWpqggyZA1l9UudiHJS8HG8T7kvdEy
	WBahDlSa9uyrl4womDDBM4MnvvYAThi6Z0p5z/nawhFZE+RzkPYHn9WsLKTCPQeqgyko6YMpYwV
	iqqDCuBsF1fWW9sXiGzZZjgXm/KmzVo3cMQcg2UEIas8xgJ8pJPZIX9niQ1qQ72mkmvwePoS62K
	QJEPrgdPyG0aeNWO6IDgFuv9nxBwo7Va0fxVDLi4oP64TmosYBhMVakkczJT+elMM6flYuuEg33
	sFiQX5BIWy7R2g8QPJhdoX/KFgpTcIrOiFMLEDqC8HPdffdmAezoN9ihr5d5rVTmeza/FNonsxh
	1S8A==
X-Google-Smtp-Source: AGHT+IGWWrc4WdF7FX7lRQrDMuhwqAOXh5C+jquwBNySEwQCE3G1DQMT0DRSQnyd9anBGi35RkN5AQ==
X-Received: by 2002:a05:6512:308d:b0:571:8fad:ecee with SMTP id 2adb3069b0e04-591d850c0efmr10901687e87.21.1761426449935;
        Sat, 25 Oct 2025 14:07:29 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:29 -0700 (PDT)
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
Subject: [PATCH v3 9/9] selftests: riscv: verify syscalls discard vector context
Date: Sun, 26 Oct 2025 00:06:42 +0300
Message-ID: <20251025210655.43099-10-geomatsi@gmail.com>
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

Add a test to v_ptrace test suite to verify that vector csr registers
are clobbered on syscalls.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 102 ++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 7e8fdebded07..51a7cc71b2be 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -183,6 +183,108 @@ TEST(ptrace_v_early_debug)
 	}
 }
 
+TEST(ptrace_v_syscall_clobbering)
+{
+	unsigned long vlenb;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
+
+	asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
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
+			sleep(0);
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
+		EXPECT_EQ(3UL, regset_data->vtype);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(16UL, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vcsr);
+		EXPECT_EQ(0UL, regset_data->vl);
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
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* verify that V state is illegal after syscall */
+
+		EXPECT_EQ((1UL << (__riscv_xlen - 1)), regset_data->vtype);
+		EXPECT_EQ(vlenb, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(0UL, regset_data->vcsr);
+		EXPECT_EQ(0UL, regset_data->vl);
+
+		/* cleanup */
+
+		ASSERT_EQ(0, kill(pid, SIGKILL));
+	}
+}
+
 FIXTURE(v_csr_invalid)
 {
 };
-- 
2.51.0


