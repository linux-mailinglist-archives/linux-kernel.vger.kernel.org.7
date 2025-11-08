Return-Path: <linux-kernel+bounces-891687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C03C43402
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:44:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FEC0188D745
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119572C029C;
	Sat,  8 Nov 2025 19:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7N+cVwj"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949102C08DC
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762630975; cv=none; b=aYvhJDyZlNikF26cP1VoogijO0P1sjVVK3jJJqWrPGpxixt+bIr+Ee8Msny9FIKXqNhDzb0pX1QydVLhN1bBmSGbEV8J+/iJsAFaL0oJ1OaxhEm3Vy3GpsXrT3L6MH3MRZUr/yOR7OySog+v7YVdZgjQX+B8OhBEINd3dY0W2kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762630975; c=relaxed/simple;
	bh=64Du9MW22FfTvN63C5fwZkWDNPLpH2Ur7/TuPEg0FcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WyNeIiysZfyphXDYY+KqylBV/KF2XRJxYRdJmdQYnyj19f9rnYlWbuET2ayJVzPyJS+2YNO0/w2bkUmgDlVW7kPDtUKrmldZ81Z+m3aTjvSfmdUNEvx+Dy0fvYmCrIq4XyJcnVjB7W38KP8UN+uuGf5lU7l//bVTf28EjRX9qXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7N+cVwj; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a3340391cso17514391fa.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762630970; x=1763235770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRJxeXvOiEogIO9xMq6Bi1gey4v1YC+eoeXUVhZk5pE=;
        b=i7N+cVwjFi5MEx7AHD8yGShaTnrVoMyKPWgZ2l8KZzNg2lnJuRUPP+o/Mg0JdFwQ70
         Scho5JTcv6mQb6G1UFvxFC5FO9P0uV5zamiiwLQTSFZVriMnmryrvUCpowPKZfA6JKBa
         ADnEUnLFONNPVDwzGe83qU3+FLryP4/ns5ZPDr/pH69gJ2vKzE3com2X0bMQu8mQ33n+
         V14ZieUf/CoFXdXeNH2t3sO1ALXPeHrbRY9DHvO+IddmK8BC0ZLWN6Et9c+PFcRin5gQ
         0SX478PUX7gexJvWojZwDRpJKh0uqqNUWkXS6mAqK/hrF2e6Sesx98UXn8ih+qE8sKmw
         ZPPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762630970; x=1763235770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YRJxeXvOiEogIO9xMq6Bi1gey4v1YC+eoeXUVhZk5pE=;
        b=Fasr7BYFWEC9O1GCLbBO1GZf/PD6A6FRF41L9sxcXgtxHOE3pKdMDoDeoOaNYu/PSW
         qguJGuKotC/POX4hgiAnKvjepBmn9Hwd0qsWYlMLAL4tVopTyKbPXeB/g9nesp6u6IgG
         iwYtn9ZuGcGraWDBReUiRZ0HFZciklbsVAI3duFIS8s8yXwXCU3WMFRc4Ho1A7NAqigA
         aVT7d2Y4vyGFZwHaWGg0QUAB7aZu6FQsxG5OwTkorVGbC3P0vQ09cs7lvNJqdTA9BXsI
         EfDlVlS+YHHWv7Vmc3V26tOX+bbbC+U8vsZaX+oU1fanA0xisFJf885ycZqGj6XF1//b
         8yKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOt0XxQ0t8BoT8pSvV/27tZzkvtD9NQL0YMuv9c/cQ9XcPROiG30UEndiUsnDcK1ceKiq/OC1wHPfYF4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOwRc9W/X+27JvpTxyN9MkkgkAroh/EzYsMQlfGUzBYCPy6FYS
	ad7VNe0+ruHei6EH/lFbkej2wdor9Coqhrh+Y+0nG7kGK4kJnUxUEsDp
X-Gm-Gg: ASbGncvhYrqCH8cLTuH5QTgbbj3/gNgKWH9LzQbBF8jzUdv0+fgB0veKWqUmIU75rwt
	2PqgmbL/JrKwadLDG6+vqqTjwYTSa/u1JOjq+I6IMbncBsbDCISsexxFr7NBDpZtTVzeCXm8yID
	bDoRjblfdUFI96lJmBzEe7AEjmJZ6iMY9ETWbN5TB3UZf+svdVYmvY42ogVrgoo1ZB0qzKKvZhI
	hV8modbH9fpygbapUPNe50L5fdHdAuts+USYjYp8Txdg5FjW8PC/Sm9leBXQwv2S+GKqv7uSN7C
	4m4dDMbVMQFupWOl+Aq2hYdE+DLg4oxPmOloFoiYWbBOX4srKyiNqv2ZfMUgetn6kmuG3eo+a08
	61DVzwB/4eVS5F+d7NlwqgiDVbfKETU7jRFq7r+sR36gEwdb3P1oXI4JYMWDERbYUfBE=
X-Google-Smtp-Source: AGHT+IHlXDkvQRgzPuEt7DV3+vhlIfC3x/SoxFZdZvSyimgEP+WQTvBDKtkfBp3OnBFK8ucxkWoPdg==
X-Received: by 2002:a2e:86d0:0:b0:378:cdf0:ad51 with SMTP id 38308e7fff4ca-37a7b233aa5mr7561051fa.24.1762630969620;
        Sat, 08 Nov 2025 11:42:49 -0800 (PST)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 38308e7fff4ca-37a5f0edac3sm22115421fa.38.2025.11.08.11.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:42:47 -0800 (PST)
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
Subject: [PATCH v4 9/9] selftests: riscv: verify syscalls discard vector context
Date: Sat,  8 Nov 2025 22:41:48 +0300
Message-ID: <20251108194207.1257866-10-geomatsi@gmail.com>
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

Add a test to v_ptrace test suite to verify that vector csr registers
are clobbered on syscalls.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 .../testing/selftests/riscv/vector/v_ptrace.c | 107 ++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/selftests/riscv/vector/v_ptrace.c b/tools/testing/selftests/riscv/vector/v_ptrace.c
index fb371a42de15..d4e947c33f75 100644
--- a/tools/testing/selftests/riscv/vector/v_ptrace.c
+++ b/tools/testing/selftests/riscv/vector/v_ptrace.c
@@ -183,6 +183,113 @@ TEST(ptrace_v_early_debug)
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
+		unsigned long vl;
+
+		while (chld_lock == 1)
+			asm volatile("" : : "g"(chld_lock) : "memory");
+
+		asm(".option arch, +zve32x\n");
+		asm(".option arch, +c\n");
+		asm volatile("vsetvli %[new_vl], x0, e16, m2, tu, mu\n"
+			     : [new_vl] "=r"(vl)
+			     :
+			     :);
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
+		/* verify initial vsetvli settings */
+
+		EXPECT_EQ(regset_data->vlenb, regset_data->vl);
+		EXPECT_EQ(9UL, regset_data->vtype);
+		EXPECT_EQ(vlenb, regset_data->vlenb);
+		EXPECT_EQ(0UL, regset_data->vstart);
+		EXPECT_EQ(0UL, regset_data->vcsr);
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


