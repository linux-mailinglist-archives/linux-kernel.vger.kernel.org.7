Return-Path: <linux-kernel+bounces-844202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679D3BC14AE
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 233543C4C91
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606402DCBF7;
	Tue,  7 Oct 2025 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blikrU/q"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903002DEA90
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759838336; cv=none; b=VJWmFQs9b3+GUxB5P50IyABwHOwv7yjFI6B6wwam8rcZQyoBjdkra0uoKPPJntgmmfWhhMoZTtqH+Tk2d13DD14jh04/lpvJtkSKt28eX5/JSS9q8VXjepVP3tz1Ua1Lnte6j5toWkumtAAo6Jdpr4b5aCJq4kixtd7LIMKOc1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759838336; c=relaxed/simple;
	bh=2Hli3rnQU0ee/Z+SJdrdeUeLAzI1KOmmrB4NougJ9ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZK57OKrbX2F08T5Fa9y2l20pjO+IDzEOtUcAkwrJuoTYdj103fyAiepI2bJPTEAhC2oTg6nRqGu8/35SGzmmLGaw0TbqYssu/uQEm9Bh5M5CHcEpIoXrlZ2+uHh97orFVNq7klC0O253jSZCw+fWT1oYaOr8IAin8plwY0YPZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blikrU/q; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57a604fecb4so7948706e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759838333; x=1760443133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHT1PRp2JY0IGazIqjL1tLWH/amjUJ0aFr/0p5QGBFQ=;
        b=blikrU/qFPnnGGF6At++q78isAOP+VO71zfsqlULZozidVa36g7NQxT4Hrpew0fRYF
         r0dK80cmx3tn1HATfyFHJC1kvTtRL0cWji4iVNA3Ye9TM9tBXFdecx4EHDA8dn6PYE3W
         USN0IVp0VjGdYJDUxXADjMQy/89rcx6RKCpiV72tvw19PrZPkB6EhrPGyzerc6tQxTRY
         IEKAsdbKUPPQ3elSyn/Ea3NjEXIDkY7zPXNVRibAZR8P/25Wf83swD0/8+ucEI44fHIC
         fBCOh3PlUT5kabaK2rrMhy24f+DciRBRG5GUeAabjG9PiUUwSy1GNg9rnpHLAaTXagMe
         OoxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759838333; x=1760443133;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DHT1PRp2JY0IGazIqjL1tLWH/amjUJ0aFr/0p5QGBFQ=;
        b=cKuHV9571xGMRI3k7yTina38XWXCVnl9iCcs8Mjy+r7RFxWXL9Xm/7Xqc89AnPEZMY
         Jm2QhbOhDhU94Q0z5LxgMKDGwxA9HsNSAIEzQERgefD5ljOZRT/gnsZsi2C0v8vIRwVk
         dS+XWUNJUTrooYgBCi4pib1IB5m2YvVFwkwHjO2LsuHUoslRjZ3vCfipDbX8tZp9so9F
         UQrYhRHb16yGZIbT960iTi92oa1ueQlUNbQ3lNO8G9X0V0pfxzyd/fHUUnU2fG6cZjmE
         6jQNkpexe/kQ/pBGHKPgBICz6XeI3TpWoHQ77vLzY8xVDXLYpq9+4RCxuIbyet6QRNvA
         c+BA==
X-Gm-Message-State: AOJu0YzizdrI4P0tedH9Kyu2uXhl/rxh2Uv+aJFiYJJVr+QU1OqyxXHM
	Q0z8T1E3kAr5P+urTBaaQobvRguvgM9uyk60dm3kj/6YOCSfVltuJ2kD
X-Gm-Gg: ASbGnctL+9zVqXt0NmFODqoHhy00ENsZKN8cPgMjUdJliMWsCXc7dLQtzzd0HCOKhHc
	P3xGfCTBEkSQ2VbN5kUlxJhkKfxE8FcyztnvA9ahlzPE+uPyZ883RrMxQaXbK0nbUwr5PCSU1au
	kA1iM6AceZNG+9Cjt2ougYcJA2tCfiIt3tA/dGqcGXNJbo/gARSHLz/yVwmVsnhZA9+hsMdnOGB
	jgJjEfsyPiQwjQCAu0YqpPHZv+J95oUvynDrcrpnrasDfrjc3Yi1qroy709Fb/gnznyx3V1KoY+
	9CYU51fZV+TNfUlr99NqYsTxEkVvM/93JF78bLI1TGlDwacNaUfmLMUgNNnraPW8VdU8Lm9gfx1
	9Xiy47QMG/m2NZRTWI6lL4HGjBXbI05tzqu4L0F0+wI27aRBK
X-Google-Smtp-Source: AGHT+IEzN3zS6xGqVRO8VCU7zICi7Cd8TK0JwH77VbJyPE7udYDtblpgFcyovJkjgfD5sCBUy3Ty/w==
X-Received: by 2002:ac2:4e0e:0:b0:570:daa5:de18 with SMTP id 2adb3069b0e04-58cbbbeee5dmr5043998e87.33.1759838332383;
        Tue, 07 Oct 2025 04:58:52 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-58b011a8941sm6043339e87.114.2025.10.07.04.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 04:58:51 -0700 (PDT)
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
Subject: [PATCH v2 5/6] selftests: riscv: verify initial vector state with ptrace
Date: Tue,  7 Oct 2025 14:58:21 +0300
Message-ID: <20251007115840.2320557-6-geomatsi@gmail.com>
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

Add a test case that attaches to a traced process immediately after its
first vector instructions to verify the initial vector context state.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index ccda8a4dc49b..f452e04629ea 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -196,4 +196,107 @@ TEST(ptrace_rvv_invalid_vtype)
 	}
 }
 
+TEST(ptrace_rvv_early_access)
+{
+	static volatile unsigned long vstart;
+	static volatile unsigned long vtype;
+	static volatile unsigned long vlenb;
+	static volatile unsigned long vcsr;
+	static volatile unsigned long vl;
+	pid_t pid;
+
+	if (!is_vector_supported())
+		SKIP(return, "Vector not supported");
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
+		asm volatile("csrr %[vstart], vstart" : [vstart] "=r"(vstart));
+		asm volatile("csrr %[vl], vl" : [vl] "=r"(vl));
+		asm volatile("csrr %[vtype], vtype" : [vtype] "=r"(vtype));
+		asm volatile("csrr %[vcsr], vcsr" : [vcsr] "=r"(vcsr));
+		asm volatile("csrr %[vlenb], vlenb" : [vlenb] "=r"(vlenb));
+
+		asm volatile ("ebreak" : : : );
+	} else {
+		struct __riscv_v_regset_state *regset_data;
+		unsigned long vstart_csr;
+		unsigned long vl_csr;
+		unsigned long vtype_csr;
+		unsigned long vcsr_csr;
+		unsigned long vlenb_csr;
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
+		/* resume and wait for ebreak */
+
+		ASSERT_EQ(0, ptrace(PTRACE_CONT, pid, NULL, NULL));
+		ASSERT_EQ(pid, waitpid(pid, &status, 0));
+		ASSERT_TRUE(WIFSTOPPED(status));
+
+		/* read tracee vector csr regs using ptrace PEEKDATA */
+
+		errno = 0;
+		vstart_csr = ptrace(PTRACE_PEEKDATA, pid, &vstart, NULL);
+		ASSERT_FALSE((errno != 0) && (vstart_csr == -1));
+
+		errno = 0;
+		vl_csr = ptrace(PTRACE_PEEKDATA, pid, &vl, NULL);
+		ASSERT_FALSE((errno != 0) && (vl_csr == -1));
+
+		errno = 0;
+		vtype_csr = ptrace(PTRACE_PEEKDATA, pid, &vtype, NULL);
+		ASSERT_FALSE((errno != 0) && (vtype_csr == -1));
+
+		errno = 0;
+		vcsr_csr = ptrace(PTRACE_PEEKDATA, pid, &vcsr, NULL);
+		ASSERT_FALSE((errno != 0) && (vcsr_csr == -1));
+
+		errno = 0;
+		vlenb_csr = ptrace(PTRACE_PEEKDATA, pid, &vlenb, NULL);
+		ASSERT_FALSE((errno != 0) && (vlenb_csr == -1));
+
+		/* read tracee csr regs using ptrace GETREGSET */
+
+		regset_size = sizeof(*regset_data) + vlenb_csr * 32;
+		regset_data = calloc(1, regset_size);
+
+		iov.iov_base = regset_data;
+		iov.iov_len = regset_size;
+
+		ASSERT_EQ(0, ptrace(PTRACE_GETREGSET, pid, NT_RISCV_VECTOR, &iov));
+
+		/* compare */
+
+		EXPECT_EQ(vstart_csr, regset_data->vstart);
+		EXPECT_EQ(vtype_csr, regset_data->vtype);
+		EXPECT_EQ(vlenb_csr, regset_data->vlenb);
+		EXPECT_EQ(vcsr_csr, regset_data->vcsr);
+		EXPECT_EQ(vl_csr, regset_data->vl);
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


