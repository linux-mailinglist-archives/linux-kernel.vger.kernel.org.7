Return-Path: <linux-kernel+bounces-864418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB54BFAC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C8918C694D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4430170C;
	Wed, 22 Oct 2025 08:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C51GemWG"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12332FFF80
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120139; cv=none; b=rnAXFTb1by4A3XWec2NsrGwI28EZ6Et8/EGoBPIgdn4qjkrX8jb8n6VYfvMtAk9BqHuAORBapSU+sJBUH2Z6VBIG40/Krnseof7XzUn4ZwPYiMnf8Awb71rxsIYMZ2SI2v3JyiJ/3qC/FIxLGKpqFgH0NDSWEaKNyMOuIu504yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120139; c=relaxed/simple;
	bh=exu1mvnQm0kIn1FVfpxwss/HOq/X3Jlmc2D+MxgxLiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDD0npV2RsHtLA8RT6aixxHAwQpNBKKjgO8Zwp2Ibw9hx9iTwmIzw++fjhl2kq7UOemW/BAZ6R8NsJQdwqjCQObPU7pjV1NKzXNEqulPj0/y4+vuCgQp9NSNNhW/weogyzRxdmXotWfyMDVwkgKgVa8e0wFg9h+GfVYdjXA59x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C51GemWG; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-290ab379d48so60199205ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120135; x=1761724935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cyLcSwWt/RyeJ0fqwSXrGKxxaJ4cRG7bePVSrf3PDAg=;
        b=C51GemWGDO69r2ujKvp85HGNaLMjub/Hml33nCioN+ohEZyJMOnD7f1IdROO8mKzo+
         DW4BdhLtZ0JwZqPyw8WTazPVwuUAXOMocPx8mDGBD2hJ8VT6fv+2qs1lvWZSavuYRUsz
         f+jGrgiuXgYYDyc9iBD4+2lCYkeJ+otOCzvbKBU9uoV/1SGguqg/yvv9kjtaYiVHGzFo
         fSl5KuoorvaVZ7rsH3amTsBhl99G2k2qrf+tVJ0C5LBLwbVwT9UCTlLSgkOGPOk4dKCU
         uVjBMzmZnjlK7xM2/LHk6fgeLNEShCuD3FBmkdMjGQ8EwmUuqNUNRuoxS9nKFnWOwtAS
         hzcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120135; x=1761724935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cyLcSwWt/RyeJ0fqwSXrGKxxaJ4cRG7bePVSrf3PDAg=;
        b=i+3JmzTdGqwhirPFK1LVbC8RrqHv/iQCSIbpFL7Y1aclXqa/yfcWp5qGf55BmzdaCr
         8vLxeLQyGwT5G1jNRQ7rX3wxLhIQq3UvgTtYOY/rg9SvdaA4AyYrz0Xea3qIn8DMbjlj
         XoKzU+eQa5gQBlCbdGoVV/KeMZvsoodmbJwm+ETZYw3i7eP5QM8DnaxLqVHgDDpl8OQA
         VPneHSFaVU0vhcU4KrDO5dU+4RvQPY1ZIV53eDkjYgoMJL/eY4arcOfEZBkBbaHqx/Zf
         kN/wy32adZtSqq2ZAOvKcSGfl4mqLbcpee3qevKEafw1nnA5EO+TFMSfc0A/3Ud2oEqN
         4mpg==
X-Forwarded-Encrypted: i=1; AJvYcCW0XKSqLI62iPnJsiW4uWTwlOMqtqc043GWBz8GDJQdnuM52No8XST3VmD1U9O2HkXDuLczPHbmIeY41pc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuis+dYDUZo2++6i6ARi0d2csz/I50p8ZyU+6jJo3jmyLxhhdS
	oVIKMD10NP4nK5xJfkGcSkR997W6OSd20QWxb/HI1weJnstlWIF6ZigO
X-Gm-Gg: ASbGncvUK3oOdQsKyu1GHkhbEJlJsvahKoSMS05/JNTsw7k1XoglhF9M/rkbHWRb0a8
	ar9DRJx4uzgzVw+xBSWv4rDhp2LhZPmtQph6Um4Qz4mqEfKet4+lRNcYyosw7pdM/MjIpUBq02M
	Z2WNgycImdpcKSIkhjK8xAs9384qAaQzw7U0ueemNS7EEoRwUyPnVcSokpLBLFNUi5svG/dqc2l
	MY0Ho/nlqS3CqTv5sl2t7T+EceKwsLLhEbiVW1qTnG453rQ23sQlfjqfB3YUkhpRa4pYJNIMQXL
	NsSba99GCZuEsFf/XImlp1kYgc124JjbOdUhvIT35iMFMINyI385qhW9CRrxQx4n7GDKLS2EE7+
	7fe+4Nt5bma+a0uC9QUtdaJGZjqGPJvX8rA/HgAUhDHeTzFfxfdo0kEOZqloPmqn2eCM+eAj5HI
	Obzba6kC4=
X-Google-Smtp-Source: AGHT+IFX/jM0vnbQUgGJ/nXZFkQeysbaBfwzLdTss7L4EJDRkAcM12qHXUwOvdatEqwNfLv5tXDGmQ==
X-Received: by 2002:a17:903:b90:b0:290:bd15:24a8 with SMTP id d9443c01a7336-290c9c89fa6mr247202645ad.11.1761120134699;
        Wed, 22 Oct 2025 01:02:14 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:14 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	jolsa@kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	mattbobrowski@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	leon.hwang@linux.dev,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 01/10] bpf: add tracing session support
Date: Wed, 22 Oct 2025 16:01:50 +0800
Message-ID: <20251022080159.553805-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251022080159.553805-1-dongml2@chinatelecom.cn>
References: <20251022080159.553805-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tracing session is something that similar to kprobe session. It allow
to attach a single BPF program to both the entry and the exit of the
target functions.

While a non-zero value is returned by the fentry, the fexit will be
skipped, which is similar to kprobe session.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/arm64/net/bpf_jit_comp.c                        |  3 +++
 arch/loongarch/net/bpf_jit.c                         |  3 +++
 arch/powerpc/net/bpf_jit_comp.c                      |  3 +++
 arch/riscv/net/bpf_jit_comp64.c                      |  3 +++
 arch/s390/net/bpf_jit_comp.c                         |  3 +++
 arch/x86/net/bpf_jit_comp.c                          |  3 +++
 include/linux/bpf.h                                  |  1 +
 include/uapi/linux/bpf.h                             |  1 +
 kernel/bpf/btf.c                                     |  2 ++
 kernel/bpf/syscall.c                                 |  2 ++
 kernel/bpf/trampoline.c                              |  5 ++++-
 kernel/bpf/verifier.c                                | 12 +++++++++---
 net/bpf/test_run.c                                   |  1 +
 net/core/bpf_sk_storage.c                            |  1 +
 tools/include/uapi/linux/bpf.h                       |  1 +
 .../selftests/bpf/prog_tests/tracing_failure.c       |  2 +-
 16 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index ab83089c3d8f..06f4bd6c6755 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2788,6 +2788,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	void *image, *tmp;
 	int ret;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/* image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
 	 */
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index cbe53d0b7fb0..ad596341658a 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -1739,6 +1739,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	void *image, *tmp;
 	struct jit_ctx ctx;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	size = ro_image_end - ro_image;
 	image = kvmalloc(size, GFP_KERNEL);
 	if (!image)
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 88ad5ba7b87f..bcc0ce09f6fa 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -1017,6 +1017,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	void *rw_image, *tmp;
 	int ret;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/*
 	 * rw_image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
diff --git a/arch/riscv/net/bpf_jit_comp64.c b/arch/riscv/net/bpf_jit_comp64.c
index 45cbc7c6fe49..55b0284bf177 100644
--- a/arch/riscv/net/bpf_jit_comp64.c
+++ b/arch/riscv/net/bpf_jit_comp64.c
@@ -1286,6 +1286,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *ro_image,
 	struct rv_jit_context ctx;
 	u32 size = ro_image_end - ro_image;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	image = kvmalloc(size, GFP_KERNEL);
 	if (!image)
 		return -ENOMEM;
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index cf461d76e9da..3f25bf55b150 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -2924,6 +2924,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image,
 	struct bpf_tramp_jit tjit;
 	int ret;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/* Compute offsets, check whether the code fits. */
 	memset(&tjit, 0, sizeof(tjit));
 	ret = __arch_prepare_bpf_trampoline(im, &tjit, m, flags,
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e4..389c3a96e2b8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3478,6 +3478,9 @@ int arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *image, void *i
 	int ret;
 	u32 size = image_end - image;
 
+	if (tlinks[BPF_TRAMP_SESSION].nr_links)
+		return -EOPNOTSUPP;
+
 	/* rw_image doesn't need to be in module memory range, so we can
 	 * use kvmalloc.
 	 */
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 204f9c759a41..3f6cad5df2db 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1270,6 +1270,7 @@ enum bpf_tramp_prog_type {
 	BPF_TRAMP_FENTRY,
 	BPF_TRAMP_FEXIT,
 	BPF_TRAMP_MODIFY_RETURN,
+	BPF_TRAMP_SESSION,
 	BPF_TRAMP_MAX,
 	BPF_TRAMP_REPLACE, /* more than MAX */
 };
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6829936d33f5..79ba3023e8be 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 0de8fc8a0e0b..2c1c3e0caff8 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -6107,6 +6107,7 @@ static int btf_validate_prog_ctx_type(struct bpf_verifier_log *log, const struct
 		case BPF_TRACE_FENTRY:
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_SESSION:
 			/* allow u64* as ctx */
 			if (btf_is_int(t) && t->size == 8)
 				return 0;
@@ -6704,6 +6705,7 @@ bool btf_ctx_access(int off, int size, enum bpf_access_type type,
 			fallthrough;
 		case BPF_LSM_CGROUP:
 		case BPF_TRACE_FEXIT:
+		case BPF_TRACE_SESSION:
 			/* When LSM programs are attached to void LSM hooks
 			 * they use FEXIT trampolines and when attached to
 			 * int LSM hooks, they use MODIFY_RETURN trampolines.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8a129746bd6c..cb483701fe39 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3564,6 +3564,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_SESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -4337,6 +4338,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
 	case BPF_TRACE_RAW_TP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 	case BPF_MODIFY_RETURN:
 		return BPF_PROG_TYPE_TRACING;
 	case BPF_LSM_MAC:
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 5949095e51c3..f6d4dea3461e 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -111,7 +111,7 @@ bool bpf_prog_has_trampoline(const struct bpf_prog *prog)
 
 	return (ptype == BPF_PROG_TYPE_TRACING &&
 		(eatype == BPF_TRACE_FENTRY || eatype == BPF_TRACE_FEXIT ||
-		 eatype == BPF_MODIFY_RETURN)) ||
+		 eatype == BPF_MODIFY_RETURN || eatype == BPF_TRACE_SESSION)) ||
 		(ptype == BPF_PROG_TYPE_LSM && eatype == BPF_LSM_MAC);
 }
 
@@ -418,6 +418,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	tr->flags &= (BPF_TRAMP_F_SHARE_IPMODIFY | BPF_TRAMP_F_TAIL_CALL_CTX);
 
 	if (tlinks[BPF_TRAMP_FEXIT].nr_links ||
+	    tlinks[BPF_TRAMP_SESSION].nr_links ||
 	    tlinks[BPF_TRAMP_MODIFY_RETURN].nr_links) {
 		/* NOTE: BPF_TRAMP_F_RESTORE_REGS and BPF_TRAMP_F_SKIP_FRAME
 		 * should not be set together.
@@ -515,6 +516,8 @@ static enum bpf_tramp_prog_type bpf_attach_type_to_tramp(struct bpf_prog *prog)
 		return BPF_TRAMP_MODIFY_RETURN;
 	case BPF_TRACE_FEXIT:
 		return BPF_TRAMP_FEXIT;
+	case BPF_TRACE_SESSION:
+		return BPF_TRAMP_SESSION;
 	case BPF_LSM_MAC:
 		if (!prog->aux->attach_func_proto->type)
 			/* The function returns void, we cannot modify its
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9b4f6920f79b..3ffdf2143f16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17281,6 +17281,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_SESSION:
 			return 0;
 		case BPF_TRACE_ITER:
 			break;
@@ -22736,6 +22737,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_SESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -23677,7 +23679,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_SESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -23692,7 +23695,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/session\n");
 			return -EINVAL;
 		}
 	} else {
@@ -23776,6 +23779,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -23942,6 +23946,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_SESSION:
 			return true;
 		default:
 			return false;
@@ -24023,9 +24028,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 			tgt_info.tgt_name);
 		return -EINVAL;
 	} else if ((prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		   prog->expected_attach_type == BPF_TRACE_SESSION ||
 		   prog->expected_attach_type == BPF_MODIFY_RETURN) &&
 		   btf_id_set_contains(&noreturn_deny, btf_id)) {
-		verbose(env, "Attaching fexit/fmod_ret to __noreturn function '%s' is rejected.\n",
+		verbose(env, "Attaching fexit/session/fmod_ret to __noreturn function '%s' is rejected.\n",
 			tgt_info.tgt_name);
 		return -EINVAL;
 	}
diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 73d5f0d9f5f4..f7f0fd5383c4 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -685,6 +685,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
 	switch (prog->expected_attach_type) {
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		if (bpf_fentry_test1(1) != 2 ||
 		    bpf_fentry_test2(2, 3) != 5 ||
 		    bpf_fentry_test3(4, 5, 6) != 15 ||
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index d3fbaf89a698..8da8834aa134 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -365,6 +365,7 @@ static bool bpf_sk_storage_tracing_allowed(const struct bpf_prog *prog)
 		return true;
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		return !!strncmp(prog->aux->attach_func_name, "bpf_sk_storage",
 				 strlen("bpf_sk_storage"));
 	default:
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 6829936d33f5..79ba3023e8be 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1133,6 +1133,7 @@ enum bpf_attach_type {
 	BPF_NETKIT_PEER,
 	BPF_TRACE_KPROBE_SESSION,
 	BPF_TRACE_UPROBE_SESSION,
+	BPF_TRACE_SESSION,
 	__MAX_BPF_ATTACH_TYPE
 };
 
diff --git a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
index 10e231965589..58b02552507d 100644
--- a/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
+++ b/tools/testing/selftests/bpf/prog_tests/tracing_failure.c
@@ -73,7 +73,7 @@ static void test_tracing_deny(void)
 static void test_fexit_noreturns(void)
 {
 	test_tracing_fail_prog("fexit_noreturns",
-			       "Attaching fexit/fmod_ret to __noreturn function 'do_exit' is rejected.");
+			       "Attaching fexit/session/fmod_ret to __noreturn function 'do_exit' is rejected.");
 }
 
 void test_tracing_failure(void)
-- 
2.51.1.dirty


