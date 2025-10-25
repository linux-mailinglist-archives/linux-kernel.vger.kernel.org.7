Return-Path: <linux-kernel+bounces-870134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AEDC0A01A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 23:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D68624E67FE
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 21:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096CA30505E;
	Sat, 25 Oct 2025 21:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhAxPh9C"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941593009F0
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 21:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761426437; cv=none; b=aU+udvG1P1zi9jcblLaYqBYoDa3oNO7g6hDwo8AZK6ZVai8YiRjeopjMWEx0wWvyjm1J4fIiQhMUFxYkL2uMsHuRd4g1znWx6QlCgXVcIkRENpUrLJzINabn08wCcxameBHx3AD30zG8MXxCjGz7CZtmSwwslzbApd4uUO+2EGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761426437; c=relaxed/simple;
	bh=I+Jx6xBgH2zAab9TpH14gkeCgnP49zZ44qWiAaJu1NQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwT3VdxQ35I35x/MsdhCTtoO6wBvDzmyS+Un9bUsVNCRNVIEFElnZM7Hz9JBlAceCzTxtUG6SOPuRAGtKxBAQbFvNNRKxUSOJTT4AiVQDRzWbEyJn9obKm3ealIvVxcxgdbwEXAAsmOgUAO+t/VIVUyocAulBQqiutiAOwZD1FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhAxPh9C; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-591c9934e0cso4823767e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 14:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761426434; x=1762031234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=OhAxPh9CeQiheGaYloZ6IRUb+catFwutGsmHdNHmoTgvVvS5AtYq8oPBuy5nctpWGD
         92BmI84RAXZT9wEdDUR+iQZfD2RWS8bwxW+x4sDN4bWgKjy6DCW1UJm3luGo+2pGWbft
         7alW7MqeOMrv7OVEOqM8gbHL0WMshkqlsGenvb/ouf9Mn1ya75zL7DlZJpLTAXiyjqOu
         Cxqe6AxmINwXTucB6+dVhMtNjnciD72+zOmrr+u78K4wjiFPEWrMXf/urQlhI4VI959a
         ATksxX4u4NnTKdI+S4aIxzkaUyTMZyDbOKroKZ+T7S53Z4woYlXIbkT9naKZyeVb40ww
         vUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761426434; x=1762031234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1z9oJMGhMkRuSJL42xb+stRjYj/XQC2rSAWX+erznoA=;
        b=jQ5g2kTFUV9O+BEEgoUqPXUHlvgSNpr1xLDZHky8DRjsp92nRGu9qf45Cpz2a7nke1
         ioF4V+GV+WLve7oy4J8BtN/R6LqMzTqEFANnKUuwJ1YrcjjtezojhWPKraSOdY1GeW/O
         B3IehqZoo3K5bTHUPCVXW7MD37WB7SzBt65ZqbdQ1ne6K7rvy2sQ8GtqZMMNb6clxP3h
         XrMZmXkuN2NQfkVOQLTEM3io2VVjEq3SNdomMK6SjoLgYi9y/146Gzd3CAKtt+Icn+Jm
         CDLlTaHhSq9DTXvWbSS4H9XZZFx+kMBQRkoESgIjCuUbyhNBbQAaSPTMw+M/oOT1G3eG
         algA==
X-Forwarded-Encrypted: i=1; AJvYcCWpgU/dJ7eJb3ldMemPBrgN4UL5E4CaQEqzBrFFf9onTz0gLI5Soygf/HR5UWaH/5ZxrUC4BAWe63xk7wo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWJlO6X1Df/ns/auEzCPr4dkv1MtXgye8T4qTzee2OyVOqFSP0
	wm0ZEeZW6Zc9a/w3+SQ7rufZPx7tyTUSsOPzhLCM6Ceed7CpneCDTXOQ
X-Gm-Gg: ASbGncsIusrrCqqjciGrUNEmlGaaYdTJetqK3KFfphNU9yN5hk476YPxK5ts6GF8wLS
	NHCDsu+zcaUitBwjkImU4wMJ7lDIDisxNI1743IZAzVacDXMKsHoB0E3REI8fQMLgwzzldyXGqV
	8EL1PZ25cftKEgGeWdJVV7AYTa11HFP1SoWkkm8M29+bgsM0YQbCC3V/pDlfcOOx54e8u6YOVUY
	IDOqhsN/OVNaTGyNUj4uVs5WBe92lQ9eV3bzck1g24YY7fCyQFdMBPOCt58Ng8mlmfRaledv9kp
	fCd+cgZ2u5TC0LKT0AAsL8LhnqP/bU/fPGg79bZMm/jcv1tzy09QlxzsbI7G/RoWmE0DOViKX8A
	tgOJaT6HGu/r9Z4Zdn1ACHzyzSyTJgvD6pDsgeuMGuj0O99yA+AfGWnHTWu4JKgKKHgQ=
X-Google-Smtp-Source: AGHT+IFUdDmSd26EpJsO+EiP5G0k+Ebq3VVdqt8KbLEbTXtWf6GeHir1tww1xGP4PmC4wQzC5b6wjw==
X-Received: by 2002:a05:6512:32c5:b0:57e:ad46:b0a0 with SMTP id 2adb3069b0e04-591d84cf5ecmr11675494e87.6.1761426433528;
        Sat, 25 Oct 2025 14:07:13 -0700 (PDT)
Received: from curiosity ([5.188.167.4])
        by smtp.googlemail.com with ESMTPSA id 2adb3069b0e04-59301f840dfsm953644e87.104.2025.10.25.14.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 14:07:12 -0700 (PDT)
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
Subject: [PATCH v3 3/9] selftests: riscv: verify initial vector state with ptrace
Date: Sun, 26 Oct 2025 00:06:36 +0300
Message-ID: <20251025210655.43099-4-geomatsi@gmail.com>
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


