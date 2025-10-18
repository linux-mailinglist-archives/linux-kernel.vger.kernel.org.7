Return-Path: <linux-kernel+bounces-859229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 066DBBED138
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 052FA19A5ED5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB122868A6;
	Sat, 18 Oct 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtyLwIdN"
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE988286D60
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797304; cv=none; b=bIS9nE8zVFpnXu3yfHRMgsQsUGrQirBj9huiPd9SWiU5amTsq1lzOZKEpYt/t7IV67pHzSPzagMW94B7sc38SjmbsAxtg8hMC9fN4dE9jXuyFU7G12l15LZ0FF/PsVf7cs+ntFmQDFyJymjZR+7zWxkcv621gTIrczQd2EPC3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797304; c=relaxed/simple;
	bh=j4FoV6+5qJQDy+qnJ1ZhU8GvU8qSxrOVwW4PgSBB4+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVDFQO+rJvYraBtWT+u8NtSWIe4tPTnBuwDClQLK9Se8b8hLCmGQENWCj7S0jy59c4oO06SHfgmxf9nfKupwaX7/uzaL9oJUAjcHcMib2/WMhf+Yp9VmUxkdulTajOxhaXu1/1s6mUzuM2Ak9eBk/9VwFDdKXjlfD1eRDwImNKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtyLwIdN; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso2778488b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797302; x=1761402102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFo/rBG24KK8EblRFPIaZrGm9X7amIHu1zrb5RTdJ5g=;
        b=dtyLwIdN9U8nVF4z0tGhCtvJrdRRQZe1n/uuiWlDVIhFY8hT8Jj/FSnq39tddB614X
         jI+DwfzT9IR4OUDgB2/DvPQ/mqzf8Uu3ObBxbYxzxb/2u9zPUv1rNySxBbBOcy2l4r9/
         FCAhqyR88Rii3AZw+T3haaxagm6ur6gzhNimE9/K1jfOsg1vsGh7WNkwZC/IwQy8TwQt
         aoryyCjzdB+0Vp1wYS6ElfS2toupfy41GPOnnPpgn1vLGQIpuYOjNVZNJr/6/TEEbFNp
         2zeyRpoZUL09c1li2npLP+s8vYAQF+wTg6xUunohbG6uah8xOwCWSlMGNpHRhR1VU7km
         tQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797302; x=1761402102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KFo/rBG24KK8EblRFPIaZrGm9X7amIHu1zrb5RTdJ5g=;
        b=LEuzRyouH+1uFXYrv1KenoNcdLW+bD4Dwj0rKr+WzahzvpBgShDsnGgpi244y+Uykp
         qqNM0aHN3VB+gMk/H/7UGJQHcpcf5KeBxVf38mVl9m2TG5RZIFht+rul+3IWxlYpKG7M
         nIiNuBbeGfn5aumEzF8fslHmONseUtqJdzz6TZVP6q1YITcH2Ki/6dho0D9kImmMDF7D
         3Eys/LKpWWtz6sracY84h9hqr4oi/s1d3hiC/UuTiCziSuPHizSiwhK258SXtbQCq6u4
         /LZnFJkT9ItcjB5dVw2nmeI+0GVPQmJRVKw3JTJADsPc5eCh+DScsIk91VKc1yXCxbxm
         Yaww==
X-Forwarded-Encrypted: i=1; AJvYcCV7OC6X9i8EyNez5IOq93n4w7+qdryPIsGnXY9LPujWIxcOIqYecXTfwAla9knwqsOazksrsdVQzAft1wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1CNv2lOd2BjHfUwuH8i5Szy31KBNVVe0DlfRkUR7tjmfMsZV
	HhH9mqB7MgVhX+hr8yuU1H88dh1uYBkdHBDeuY5tSqFg4HFdjX7CfH9w
X-Gm-Gg: ASbGncs1PN+CutzMCbMO0Pkf/JZK2JzrRf34ZzUnoFxkxVCeRHIE/axR7VH9fwbb3dY
	j3tp66987PeAUMSSQDwGdWhJTFkJt1DcftQkK/Whb3y5vlxxw00EQRrf/am+7P7WY8yc8XdKBPq
	qve4ZeMLlUL5oIGemsVMs1X5r4dphC8iq4gNdq1ECSJEb8zlxwyYkJ5gmFLaD+/EZrrKbg+q5Rj
	Qxf2lp5IbaASDuzAy8T+rzdLkfUn6yXEOIgz/TmfYjlqNw0Huqgjiyg7/nW8W2U8mSrsF6VtH1Q
	1BWXd/SvesnvLjK8JiBsMdMUMLarMXFWM2gSfpAcCHRmEqDk5I/UkixjFhqb3Pd6XzeaJuPuXKl
	aFBQ/kLZcHbyQPFMa6W32cVIfggDD8dXwLdz4nw47Ri07CG3J0c8pc2KkHUnT2kPuxR0WLRHeRM
	XBasPMpToyUFo=
X-Google-Smtp-Source: AGHT+IFRhX3XY3uOEHTyrIWY0QhaxXyizShmzTfEyYUzW7jXb7ZaXfHCLMSHap1oXfphklzQDRm5Ig==
X-Received: by 2002:a05:6a00:4602:b0:77f:324a:6037 with SMTP id d2e1a72fcca58-7a220a59102mr7392649b3a.7.1760797302078;
        Sat, 18 Oct 2025 07:21:42 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:21:41 -0700 (PDT)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 1/5] bpf: add tracing session support
Date: Sat, 18 Oct 2025 22:21:20 +0800
Message-ID: <20251018142124.783206-2-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018142124.783206-1-dongml2@chinatelecom.cn>
References: <20251018142124.783206-1-dongml2@chinatelecom.cn>
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
 arch/arm64/net/bpf_jit_comp.c   |  3 +++
 arch/loongarch/net/bpf_jit.c    |  3 +++
 arch/powerpc/net/bpf_jit_comp.c |  3 +++
 arch/riscv/net/bpf_jit_comp64.c |  3 +++
 arch/s390/net/bpf_jit_comp.c    |  3 +++
 include/linux/bpf.h             |  1 +
 include/uapi/linux/bpf.h        |  1 +
 kernel/bpf/btf.c                |  2 ++
 kernel/bpf/syscall.c            |  2 ++
 kernel/bpf/trampoline.c         |  5 ++++-
 kernel/bpf/verifier.c           | 12 +++++++++---
 net/bpf/test_run.c              |  1 +
 net/core/bpf_sk_storage.c       |  1 +
 tools/include/uapi/linux/bpf.h  |  1 +
 14 files changed, 37 insertions(+), 4 deletions(-)

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
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 86afd9ac6848..aa9f02b56edd 100644
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
index 2a9456a3e730..15ce86b19ca4 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3549,6 +3549,7 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	case BPF_PROG_TYPE_TRACING:
 		if (prog->expected_attach_type != BPF_TRACE_FENTRY &&
 		    prog->expected_attach_type != BPF_TRACE_FEXIT &&
+		    prog->expected_attach_type != BPF_TRACE_SESSION &&
 		    prog->expected_attach_type != BPF_MODIFY_RETURN) {
 			err = -EINVAL;
 			goto out_put_prog;
@@ -4322,6 +4323,7 @@ attach_type_to_prog_type(enum bpf_attach_type attach_type)
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
index c908015b2d34..40e3274e8bc2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17272,6 +17272,7 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 			break;
 		case BPF_TRACE_RAW_TP:
 		case BPF_MODIFY_RETURN:
+		case BPF_TRACE_SESSION:
 			return 0;
 		case BPF_TRACE_ITER:
 			break;
@@ -22727,6 +22728,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		if (prog_type == BPF_PROG_TYPE_TRACING &&
 		    insn->imm == BPF_FUNC_get_func_ret) {
 			if (eatype == BPF_TRACE_FEXIT ||
+			    eatype == BPF_TRACE_SESSION ||
 			    eatype == BPF_MODIFY_RETURN) {
 				/* Load nr_args from ctx - 8 */
 				insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_1, -8);
@@ -23668,7 +23670,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 		if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
 		    prog_extension &&
 		    (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
-		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT)) {
+		     tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
+		     tgt_prog->expected_attach_type == BPF_TRACE_SESSION)) {
 			/* Program extensions can extend all program types
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
@@ -23683,7 +23686,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * beyond reasonable stack size. Hence extending fentry
 			 * is not allowed.
 			 */
-			bpf_log(log, "Cannot extend fentry/fexit\n");
+			bpf_log(log, "Cannot extend fentry/fexit/session\n");
 			return -EINVAL;
 		}
 	} else {
@@ -23767,6 +23770,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 	case BPF_LSM_CGROUP:
 	case BPF_TRACE_FENTRY:
 	case BPF_TRACE_FEXIT:
+	case BPF_TRACE_SESSION:
 		if (!btf_type_is_func(t)) {
 			bpf_log(log, "attach_btf_id %u is not a function\n",
 				btf_id);
@@ -23933,6 +23937,7 @@ static bool can_be_sleepable(struct bpf_prog *prog)
 		case BPF_TRACE_FEXIT:
 		case BPF_MODIFY_RETURN:
 		case BPF_TRACE_ITER:
+		case BPF_TRACE_SESSION:
 			return true;
 		default:
 			return false;
@@ -24014,9 +24019,10 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
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
index 05e30ff5b6f9..aa2b5b17a7c7 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -696,6 +696,7 @@ int bpf_prog_test_run_tracing(struct bpf_prog *prog,
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
 
-- 
2.51.0


