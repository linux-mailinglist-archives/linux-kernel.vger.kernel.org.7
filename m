Return-Path: <linux-kernel+bounces-891681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C208C433E1
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90C6188D56A
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9672853F1;
	Sat,  8 Nov 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2vKKFne"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2A5288C3F
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630950; cv=none; b=ZfBMXqG8pZohdHe7nyKSTAnWL4AFRXPonYMdrkY+Vx28F0zyMoxzj+nDWwtzIHFD4a0jOVDRAO48zbvcLiInqpRXMntyQTBBI6XWHSXS7piMecskt+lcyZ6g2ojeDLFXssJ/TYO6a3pmS9gId1MEz+k+FzfJgFPaCAXq0pkrQJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630950; c=relaxed/simple;
	bh=I+Jx6xBgH2zAab9TpH14gkeCgnP49zZ44qWiAaJu1NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YauQddvWSoRMJ74K4MN3ASSkOEXyqOX6h8SYmpPKUBRYb1RkwmIBD+CP+7NCRJsc8qzcDs/Uy9E5ulj4LetkSw/+omsp34k/LWuXriDlixNvv1aSD+OZDtF8aDzCXIlCTqNQ2zmetFtimEvimV4RTAXrbAzgHgIxoFmDHo2QYB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2vKKFne; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-36295d53a10so14509911fa.0
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630946; x=1763235746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=b2vKKFneSGDs+7qrbALd1DAUlRC+Owueuzvpzk/ueipWEdCTs71yESThyImYtx4vHQ
         ol4MbnVoNVBKeN34rSQ8CBCgOB00thACryQ/+/EUsfU2ZiI7Zag/6jhbn5dPjbuwwKtF
         PiooNSBj/YEGEkDBpZQKeP3lwgUaNT/rUf+GYMOEYO5KmhdPLCLxDFswR1ni0j7Cx3p3
         GT/eJ2HF3Sa3h2sakm9ORen3KsdiyrOEi/k66Dx/CSms9ZjCDclMZxydSlSY2eA41TYI
         P+VnvAa7mp8Mbk0m8VPjA7nB7mHwfBg+xAtLgbPC3e55lkbKseRcGcDsbzwhCjMswUVC
         fpfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630946; x=1763235746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=RLxQNmLn3bMIoMNbHFsAJNqFKkof5zS2+ARsw62gw5rLkr9b8VhaquU+7oqu8WSjbq
         wjkKbLZ+OxTFy7Bvk/MyXGN36PzTTrZE5EVdJFHMAypvI4ghvbLQMPVa3MFoN5QEgrW+
         30YOuiPNW9WVSYfcKhpbjzz580fYV065v9hUI9+fmgfygOa2jCjs83i2bXwjytxDKFHz
         WF1nNFRBrQp6o1MVHh8staRX74qEs2oJNeH0ulQmUEvZv1fcUaRsJ7rqTgPYkhkI3etT
         MgvKovFZNdzXWxr2qk3neZ0c+GdjO4v2QRKth2OdseIxcbNDz15uei7/JvJbObDx5Emn
         ffvA==
X-Forwarded-Encrypted: i=1; AJvYcCVY5QEQlIc4P8J1Yg/JSkHB2gRry82FOzlUm5/10r3j2R9EHT/obhq80ec9C4+XqEVbm7zx3woCLOGbNYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrxfHcqhVnak0hyv11jbnKsJ7YHz2iC2GMYSMlf9NIucYUD8pR
	bS2mxnh6Ymmh/KG6mMP4balk88Po0/altxbGvM2ZXVQgkNe4KTRq+46Vcq39KAW6S9k=
X-Gm-Gg: ASbGnctVAleO56VLOBAO/I7ShW+EV9S7OJC1RJUmT2MoGTEjmIQb8IuDM60uuRpE6zH
	O26BRYKAomxuxm8XaqC82HwUvRdKAoTHQI+LgkmWW9WTQyQB6SrZkoCNuyLj7PO6MLdpk5Q6tzN
	UFo48LaiPCzqXd3ZGPlo5ztVSm0EFZ0VXbr6rrmhSabYMMle58PxZ0q1NH6abVxlhRyK8KJt1xm
	I1rBoB726s4Wm7SDXRdFdXemSMWnKwBCpnd++NpL0LGuW6zHpfLmswVEv+ZYGxExsSr0paXxx4i
	d0vNRdQaA8G5Em8q7TFAscMqH96/JssWzu7vpXf23PhH4qPWF8qGJyLCdBqmaj84bKggTjKLRXy
	IXdMCA0YNTOQXt/BG3xb7BK+/36IIkFr+4BAIjiHge7BtrkzDpHwoeyP3U1DPRMeb39VE9fPJZp
	jl7Q==
X-Google-Smtp-Source: AGHT+IFqruWPxQcVE5BSlkkAYUO3qtnystNc9jQjX4jqelXJHwKhoZh5DbK28uyPKpvnw5kWkw7ZbQ==
X-Received: by 2002:a2e:8653:0:b0:37a:36be:7282 with SMTP id 38308e7fff4ca-37a7b23fac5mr7888391fa.41.1762630946307;
        Sat, 08 Nov 2025 11:42:26 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:24 -0800 (PST)
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
Subject: [PATCH v4 3/9] selftests: riscv: verify initial vector state with ptrace
Date: Sat,  8 Nov 2025 22:41:42 +0300
Message-ID: <20251108194207.1257866-4-geomatsi@gmail.com>
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

Add a test case that attaches to a traced process immediately after its
first executed vector instructions to verify the initial vector context.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 101 ++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index 6a4b5a2ab4a2..9fea29f7b686 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -82,4 +82,105 @@ TEST(ptrace_v_not_enabled)
 	}
 }
 
+TEST(ptrace_v_early_debug)
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
+	pid = fork();
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
+		unsigned long vlenb_csr;
+		unsigned long vtype_csr;
+		unsigned long vcsr_csr;
+		unsigned long vl_csr;
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


