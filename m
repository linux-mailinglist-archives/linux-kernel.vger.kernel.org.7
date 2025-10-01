Return-Path: <linux-kernel+bounces-838774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68CBB01BC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 13:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C6C116A760
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 11:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EA72C3247;
	Wed,  1 Oct 2025 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="c63z0YSi"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045322C3250
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 11:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759317318; cv=none; b=Q5gaCYTr9YGrJJvBjIXcu3q9ggwQgeos/mruVY7hmLo3bxieRV7IXJJ4X02fbhlCmEna6TTY7VPF1LtFKhGvN5NCdHzAHqptdjApBJV/Do/fhLSeY9rbMx+ukfhl1wkIEf9WucvRWP5XQFH9+i+Mirp8I5FPesp7fvWh0ecx3To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759317318; c=relaxed/simple;
	bh=Y7t6cJGU+J6rvKsTQfIOiLnLBq6FtZ4pUGeAOfjuods=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UqhjGlo1rPf7GuI4gLUljmbDLMP6FTbSzytJTsLVE7YAfcQ9rLibxM9OmOtsrKp4sXJZiQPE9pcgEnloXcCDBDlI4UnNxRVrcq1DqONyteF6fneuQ5EGBqX7pVq75jg0q82yoXIAXdtWvWdc8378M+HT0ESKI0UhChSynrjXFdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=c63z0YSi; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b54a74f9150so6245248a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 04:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1759317316; x=1759922116; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=duIDlBd6DWondZbhFgBkxnIom+/wxjruSnguKN5DCTE=;
        b=c63z0YSiqwo777FdtHz2MfoEe1wiEmuGAz9hM3lA9yIrSKoblJEJaYjsAj0GGGjSA0
         3NunKfMlMjO4FarrSATDVat+eRdk0JRw7xlsSQ1NpAyXU9pDpRSz3inF/D2hYa0+LKEB
         U+e857iNiXwGTG3KLMNXFUYk0SfG72FS3qVe8xrbAyUrZI4NmOIF7l4/aTa+lxlSXwVk
         cEcT5+agUm95jJg4LcDY05XyYAjkbNYKHSv37fiNlkggc+brJgGOSRssE7DodfWUBAxr
         l/dtmXZFafPElO2QQJuj/JiDyqMlE0UJ209nNWx/u+URI4Ld6YwSkWNpNH6jEzqjg8Uy
         a8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759317316; x=1759922116;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=duIDlBd6DWondZbhFgBkxnIom+/wxjruSnguKN5DCTE=;
        b=AtvMtYE5txrSXehGB0KE8JkWlW+K/HimT2pXrTls9ExhT43r562x2RfNONOETTCrpH
         qzni+Quz79Jluz+6kzyeBS4FLTPqLXk7moiB3tAHen8pUTd1REg0wZaPJBnhP+YBeJbh
         wsY3hk26uLgUs9vOYsC8acAVXcccSqwZeAXbfcoyBOSJzAR3qFi2YXNOSm5uQRw3jiDl
         DTOUdhpkT6qJbh68iHRFlKWH5QV7hbkKt7bzs7MKrgh3sTvS9Dajm3drai1uRrd/H903
         aVM7vAZAXVJq+yI4H1BjBgNBBHv1BCf6W3R8VXvbS8AEPUkOLqf/Wx4HgMC6T4vq9SsZ
         Zisw==
X-Gm-Message-State: AOJu0YyhBWAaX0Kujy0qVGYxaN6aobBOH8qMv8jeHcp9wVMPqs3E+ivq
	OWQns1k7JV/+oCmB15uTXBUYA+b9VM9P6613jfvBJMwdWKLe4Zg7W90fgZa+tfVps6iOo9hRRhm
	qzEUN1CHdKQ2uSBdasFEwUIGysIVOWIkXDgU+WrlPZAW2mSZxJOzHqfdTTl9VsiNcAoP54tye3y
	vQZDt0inkOxVDTfyaOlbn9wOTeUM+WEqdlOfpq+0WYq7avYtYd/weNp/Y=
X-Gm-Gg: ASbGncusvncVJ2G6C46swKASqc/tcII0zEB0hisfXs4ApEkGKy7QgIRDBlsiP5ylsvU
	LxF/b22j0jMGkvXjtM160ViQWJDv+KSPZilqt1Xt1xL/un6yUUzNc3SOA3daZlPLXoM8azSut0I
	HXyJrhYMMAt4MzHRjHBtRZbdD4D4UxX6uN57T37F5o8bYEePq8GEXHtN8x3SJzZZTuchjfPFzIZ
	avXA3n+G1IIROXlubCJpervdmFAd+hvUxiWa/u47z0afhfA15eqKH57LXqYvaysvIFAZo45jgfK
	5yMhoxBg0F1jcpljphxkmUnZhzt0WVgZwbTBLlpmDamcTfIBW3R3JxzhRR+Vu+of68s7tSqrBHD
	JqEPSlUZjPI/fLMs5EiIQKrVbBXdOIOvw8nHzowBMquwQAcKcwycWIf5MPsmSKyWq/03sdC3iLG
	HU/SNjKolSvrU=
X-Google-Smtp-Source: AGHT+IHjVNODYRhSl9w8wTzY7/4OarsvAh7QM7qsu5LY7xOefbG8sewwIMg0Z1M/bBWd3fTkCwMIyA==
X-Received: by 2002:a17:903:17c5:b0:26e:62c9:1cc4 with SMTP id d9443c01a7336-28e7f26f791mr35301405ad.4.1759317315540;
        Wed, 01 Oct 2025 04:15:15 -0700 (PDT)
Received: from hsinchu26.internal.sifive.com ([210.176.154.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27eeb9a8ebfsm155163455ad.67.2025.10.01.04.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 04:15:15 -0700 (PDT)
From: Yong-Xuan Wang <yongxuan.wang@sifive.com>
To: linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: greentime.hu@sifive.com,
	vincent.chen@sifive.com,
	andybnac@gmail.com,
	Yong-Xuan Wang <yongxuan.wang@sifive.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Oleg Nesterov <oleg@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Jesse Taube <jesse@rivosinc.com>,
	Han Gao <rabenda.cn@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Bill O'Donnell" <bodonnel@redhat.com>,
	Joel Granados <joel.granados@kernel.org>
Subject: [PATCH v 1/2] riscv: ptrace: Optimize the allocation of vector regset
Date: Wed,  1 Oct 2025 19:14:26 +0800
Message-ID: <20251001111451.299163-2-yongxuan.wang@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001111451.299163-1-yongxuan.wang@sifive.com>
References: <20251001111451.299163-1-yongxuan.wang@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vector regset uses the maximum possible vlen value to estimate the
.n field. But not all the hardwares support the maximum vlen. Linux
might wastes time to prepare a large memory buffer(about 2^6 pages) for
the vector regset.

The regset can only copy vector registers when the process are using
vector. Add .active callback and determine the n field of vector regset
in riscv_v_setup_ctx_cache() doesn't affect the ptrace syscall and
coredump. It can avoid oversized allocations and better matches real
hardware limits.

Signed-off-by: Yong-Xuan Wang <yongxuan.wang@sifive.com>
Reviewed-by: Greentime Hu <greentime.hu@sifive.com>
---
 arch/riscv/include/asm/vector.h |  1 +
 arch/riscv/kernel/ptrace.c      | 24 +++++++++++++++++++++---
 arch/riscv/kernel/vector.c      |  2 ++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/vector.h b/arch/riscv/include/asm/vector.h
index b61786d43c20..e7aa449368ad 100644
--- a/arch/riscv/include/asm/vector.h
+++ b/arch/riscv/include/asm/vector.h
@@ -51,6 +51,7 @@ void put_cpu_vector_context(void);
 void riscv_v_thread_free(struct task_struct *tsk);
 void __init riscv_v_setup_ctx_cache(void);
 void riscv_v_thread_alloc(struct task_struct *tsk);
+void __init update_regset_vector_info(unsigned long size);
 
 static inline u32 riscv_v_flags(void)
 {
diff --git a/arch/riscv/kernel/ptrace.c b/arch/riscv/kernel/ptrace.c
index 8e86305831ea..e6272d74572f 100644
--- a/arch/riscv/kernel/ptrace.c
+++ b/arch/riscv/kernel/ptrace.c
@@ -153,6 +153,17 @@ static int riscv_vr_set(struct task_struct *target,
 				 0, riscv_v_vsize);
 	return ret;
 }
+
+static int riscv_vr_active(struct task_struct *target, const struct user_regset *regset)
+{
+	if (!(has_vector() || has_xtheadvector()))
+		return -ENODEV;
+
+	if (!riscv_v_vstate_query(task_pt_regs(target)))
+		return 0;
+
+	return regset->n;
+}
 #endif
 
 #ifdef CONFIG_RISCV_ISA_SUPM
@@ -184,7 +195,7 @@ static int tagged_addr_ctrl_set(struct task_struct *target,
 }
 #endif
 
-static const struct user_regset riscv_user_regset[] = {
+static struct user_regset riscv_user_regset[] __ro_after_init = {
 	[REGSET_X] = {
 		USER_REGSET_NOTE_TYPE(PRSTATUS),
 		.n = ELF_NGREG,
@@ -207,11 +218,10 @@ static const struct user_regset riscv_user_regset[] = {
 	[REGSET_V] = {
 		USER_REGSET_NOTE_TYPE(RISCV_VECTOR),
 		.align = 16,
-		.n = ((32 * RISCV_MAX_VLENB) +
-		      sizeof(struct __riscv_v_regset_state)) / sizeof(__u32),
 		.size = sizeof(__u32),
 		.regset_get = riscv_vr_get,
 		.set = riscv_vr_set,
+		.active = riscv_vr_active,
 	},
 #endif
 #ifdef CONFIG_RISCV_ISA_SUPM
@@ -233,6 +243,14 @@ static const struct user_regset_view riscv_user_native_view = {
 	.n = ARRAY_SIZE(riscv_user_regset),
 };
 
+#ifdef CONFIG_RISCV_ISA_V
+void __init update_regset_vector_info(unsigned long size)
+{
+	riscv_user_regset[REGSET_V].n = (size + sizeof(struct __riscv_v_regset_state)) /
+					sizeof(__u32);
+}
+#endif
+
 struct pt_regs_offset {
 	const char *name;
 	int offset;
diff --git a/arch/riscv/kernel/vector.c b/arch/riscv/kernel/vector.c
index 901e67adf576..3ed071dab9d8 100644
--- a/arch/riscv/kernel/vector.c
+++ b/arch/riscv/kernel/vector.c
@@ -66,6 +66,8 @@ void __init riscv_v_setup_ctx_cache(void)
 	if (!(has_vector() || has_xtheadvector()))
 		return;
 
+	update_regset_vector_info(riscv_v_vsize);
+
 	riscv_v_user_cachep = kmem_cache_create_usercopy("riscv_vector_ctx",
 							 riscv_v_vsize, 16, SLAB_PANIC,
 							 0, riscv_v_vsize, NULL);
-- 
2.43.0


