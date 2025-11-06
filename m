Return-Path: <linux-kernel+bounces-888531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8A6C3B123
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64FA41AA70E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992D5341654;
	Thu,  6 Nov 2025 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izDvscUI"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26933BBBE
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433631; cv=none; b=A0uKs3fv/iaX2TQDwoATpjeFom6dyyS0f952fd0hNSx+GE8AYfy+C5FgUyOcRlYDjLSaG+cGJQHub9aBPr093APBFveEVOltECX0mfFllHUHh0cYU8eT6LY4uCOIKR2TglXYZQ79AQgNGRgsO7aERL0l7cnSSI3EMbNRZptTxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433631; c=relaxed/simple;
	bh=qInMAmfp5FBsELWSL3ofmHPfHebykt5zIrz8u5DETCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j6mr+mG0ifUM+KGygCFVRyQCvUWA0C9fxTr1eLyAU9ScnhywsdydM1ANodiC297CGVP8zsaGQwfuX6LalccveaA+6Em3wwnaVkltwLZX0z5lqd5X2S7NscrqftA2dDHO3Hb0mmtPWlwiDdwJQ4bQn85c8CKnXBvwcjDplEPyC9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izDvscUI; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ecdf2b1751so643313f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433626; x=1763038426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmD8sr/SvUW/y+PfwDxdl2359E+UebPVfjOgIaOsoAE=;
        b=izDvscUIo7bl/OvIVq/CQzteAy/I4XXrsIU5zZKdo9LVpayA0NYJetHIJprSXniQMZ
         X6NfApGAcX9u55wS+08N36FvXQysFcKD4ImiInlGxBUCH3n/9+I9YLP1yyC0za8E7yDA
         zQPevBPSrw6C1yRtNK258Q+vyWdN0tQb4WIVP0doh5fze7hjY8QyTr4Wblvj3S7U5L0U
         DoXWQnKIaVzu3mJ48fcdppxJk61aY6wJifjYPaZA+r7T9JNuCpcD8USZ/qhNxFwnqtRP
         utf4jyYVyt+MoaQjLfTyCSbe6o92ByJBRaKUb/4rFCuCZeJnrvHUpff6V2FY4ZDZplPA
         yBjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433626; x=1763038426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmD8sr/SvUW/y+PfwDxdl2359E+UebPVfjOgIaOsoAE=;
        b=ta0CisTQrwtCgMrY+TIjaMXZ8SmqvCKlxIhxUcOl5ueVQ3+w7iljGdoENy8XejyhFd
         Y7WbehfWq/0WQ/xi5q45posmnggTEUraxE0sLJ33+bL1b4oqOpxBAIP5bGppMaS82pjO
         uhbU1WG07S8L86gZ/Xmdknc6P5/Eop14HdSZCUepePd3vif1BUGmNAp/OfqEMz7ghG8o
         WNgisWxkj11/PYKop5ztGhj+14uBqae6N6BPqzl6YjTizdbwH2nzsHXEJQbzaODQAF15
         b8anNM4NoiqnwpEOHKVZjbPm1vjWiPscXIoqTmC7wpqtRyAPa7L4vn/FYpxTlsekcoEw
         1fbw==
X-Forwarded-Encrypted: i=1; AJvYcCUpgKT5RBqELLdfXDUxURjckyAtfIWaTDDcYNu3U/8Y7j/f9Op9Ljlv4lMVkfEe9OQw/NpdALVwXaOpuwI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7gVLSDtChOrqvmVo2F7zxxgGWQTOH7h4RCMZ6BJzW9uxhzS38
	O+ZMdtljLF/hH5+yW4LifFHOyvTNxHnB1XMAFgKQxG+VEKhuzqt5/FA=
X-Gm-Gg: ASbGnctMsOTNVUxAtjE8YPrpLkObS83D2oKga8Cz+6kOLxlpkOYUPfynaBPt/D+feeN
	I/z4mDsslT5kRc6v6VPc07rJeApihhmMw5aEpU6yDS+Yq4/OiyG8AbjJnJxXz2INzF/b6W4iRZH
	rXI3YgVIIP8/FOizXaJtSFcG5HH6xyMSpH66FkWNDoz/LgjCCy4akQGiZ4CGH5zNDgmzbx/s7w5
	D1DhfHKNui8J42OtJ9h86L38NYKo7Pgf5MTO9wJNrsDdbD/1jMzIsmsws4KDkrzdwM7BnZLeJSk
	U8gDB0JQYeabC2dx39AlDhMnqcWClP8VVKaocipGoL6Ts1UbOBgW0B47a6JGnkWzh8lCHb0hHeB
	UESxdrM2TmkW0byEWK+yYpKo2QDT3T7+jK7vNa3qNZw9ETOzEhTENMdcWvqjFochYKpplS9ykub
	2zRnFHt47DW4IfxA3KvVIsfsB/ZFY85kw3FxERsOb9wfzknG4DnPvVMlo=
X-Google-Smtp-Source: AGHT+IEmfj4wy0P0dsEkb1239creqUmNtDLxyKLwH37BcSlr9kI7/6yx6uoWgXO96nP471KsPLuTeA==
X-Received: by 2002:a05:6000:2083:b0:429:c4bb:fbbb with SMTP id ffacd0b85a97d-429e32c82bdmr7170308f8f.13.1762433625515;
        Thu, 06 Nov 2025 04:53:45 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:45 -0800 (PST)
From: Hao Sun <sunhao.th@gmail.com>
X-Google-Original-From: Hao Sun <hao.sun@inf.ethz.ch>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	linux-kernel@vger.kernel.org,
	sunhao.th@gmail.com,
	Hao Sun <hao.sun@inf.ethz.ch>
Subject: [PATCH RFC 16/17] bpf: Resume verifier env and check proof
Date: Thu,  6 Nov 2025 13:52:54 +0100
Message-Id: <20251106125255.1969938-17-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the resume path for proof-based refinement and integrate proof check
into the verifier flow.

- Userspace sets `BCF_F_PROOF_PROVIDED`, passes the saved `bcf_fd` and a proof
  in `bcf_buf`. bpf_prog_load() detects resume, swaps to verifier path without
  building a new prog, and calls bpf_check() with `prog = NULL`.

- In bpf_check(), fetch the saved env from `bcf_fd`, ensure it’s a BCF file and
  not already in use (`bcf.in_use`), and mark it in-use.

- `resume_env()`: determine which condition to check (default `refine_cond`; if
  `BCF_F_PROOF_PATH_UNREACHABLE` is set, use `path_cond` and mark
  `path_unreachable` to skip to exit on the next insn). Copy the proof from
  userspace and call `bcf_check_proof()` with the saved expression arena and
  condition id.

- Resume verification: skip re-initialization if `env->cur_state` exists;
  analyze only the subprog recorded at request time; continue with the refined
  `cur_state` and finish normal verification.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/linux/bpf_verifier.h |  2 +
 kernel/bpf/syscall.c         |  6 ++-
 kernel/bpf/verifier.c        | 94 +++++++++++++++++++++++++++++++++---
 3 files changed, 94 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 67eac7b2778e..219e211195fc 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -745,6 +745,7 @@ struct bcf_refine_state {
 
 	bool available; /* if bcf_buf is provided. */
 	bool tracking; /* In bcf_track(). */
+	atomic_t in_use; /* The current env is in use. */
 	struct bcf_expr *exprs;
 	u32 expr_size;
 	u32 expr_cnt;
@@ -758,6 +759,7 @@ struct bcf_refine_state {
 	int checked_off;
 	int checked_sz;
 	bool access_checked;
+	bool path_unreachable;
 };
 
 /* single container for all structs
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 97914494bd18..53ed868aa20c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2881,7 +2881,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			return -EINVAL;
 		/* The resumed analysis must only uses the old, first attr. */
 		memset(attr, 0, offsetof(union bpf_attr, bcf_buf));
-		return -ENOTSUPP;
+		prog = NULL;
+		goto verifier_check;
 	}
 
 	if (attr->bcf_fd || attr->bcf_buf_true_size || attr->bcf_flags)
@@ -3094,9 +3095,10 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 	if (err)
 		goto free_prog_sec;
 
+verifier_check:
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, uattr_size);
-	if (prog->aux->bcf_requested)
+	if (!prog || prog->aux->bcf_requested)
 		return err;
 	if (err < 0)
 		goto free_used_maps;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3b631cea827e..fb672c9cc7cd 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -33,6 +33,7 @@
 #include <net/xdp.h>
 #include <linux/trace_events.h>
 #include <linux/kallsyms.h>
+#include <linux/bcf_checker.h>
 
 #include "disasm.h"
 
@@ -20927,6 +20928,11 @@ static int do_check(struct bpf_verifier_env *env)
 		insn = &insns[env->insn_idx];
 		insn_aux = &env->insn_aux_data[env->insn_idx];
 
+		if (env->bcf.path_unreachable) {
+			env->bcf.path_unreachable = false;
+			goto process_bpf_exit;
+		}
+
 		if (++env->insn_processed > BPF_COMPLEXITY_LIMIT_INSNS) {
 			verbose(env,
 				"BPF program is too large. Processed %d insn\n",
@@ -24123,6 +24129,9 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	struct bpf_reg_state *regs;
 	int ret, i;
 
+	if (env->cur_state)
+		goto skip_init;
+
 	env->prev_insn_idx = -1;
 	env->prev_linfo = NULL;
 	env->pass_cnt++;
@@ -24236,6 +24245,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 							  acquire_reference(env, 0) : 0;
 	}
 
+skip_init:
 	ret = do_check(env);
 
 	/* Invoked by bcf_track(), just return. */
@@ -24571,7 +24581,9 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 
 again:
 	new_cnt = 0;
-	for (i = 1; i < env->subprog_cnt; i++) {
+	/* env->cur_state indicates the resume mode, check the last subprog */
+	i = env->cur_state ? env->subprog : 1;
+	for (; i < env->subprog_cnt; i++) {
 		if (!subprog_is_global(env, i))
 			continue;
 
@@ -24580,8 +24592,10 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 			continue;
 
 		env->subprog = i;
-		env->insn_idx = env->subprog_info[i].start;
-		WARN_ON_ONCE(env->insn_idx == 0);
+		if (!env->cur_state) {
+			env->insn_idx = env->subprog_info[i].start;
+			WARN_ON_ONCE(env->insn_idx == 0);
+		}
 		ret = do_check_common(env, i);
 		if (ret) {
 			return ret;
@@ -24611,7 +24625,10 @@ static int do_check_main(struct bpf_verifier_env *env)
 {
 	int ret;
 
-	env->insn_idx = 0;
+	if (env->subprog)
+		return 0;
+	if (!env->cur_state)
+		env->insn_idx = 0;
 	ret = do_check_common(env, 0);
 	if (!ret)
 		env->prog->aux->stack_depth = env->subprog_info[0].stack_depth;
@@ -25852,13 +25869,45 @@ static int do_request_bcf(struct bpf_verifier_env *env, union bpf_attr *attr,
 	return 0;
 }
 
+static int resume_env(struct bpf_verifier_env *env, union bpf_attr *attr,
+		      bpfptr_t uattr)
+{
+	bpfptr_t proof;
+	int cond, err;
+
+	unmark_bcf_requested(env);
+
+	cond = env->bcf.refine_cond;
+	if (attr->bcf_flags & BCF_F_PROOF_PATH_UNREACHABLE) {
+		cond = env->bcf.path_cond;
+		env->bcf.path_unreachable = true;
+	}
+	if (cond < 0)
+		return -EINVAL;
+
+	proof = make_bpfptr(attr->bcf_buf, uattr.is_kernel);
+	err = bcf_check_proof(env->bcf.exprs, cond, proof,
+			      attr->bcf_buf_true_size,
+			      (void *)bpf_verifier_vlog, env->log.level,
+			      &env->log);
+	if (err)
+		return err;
+
+	/* Drop the last history entry */
+	if (is_jmp_point(env, env->insn_idx))
+		env->cur_state->jmp_history_cnt--;
+
+	return 0;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
 	struct bpf_verifier_env *env;
 	int i, len, ret = -EINVAL, err;
 	u32 log_true_size;
-	bool is_priv;
+	bool is_priv, resume;
+	struct fd bcf_fd;
 
 	BTF_TYPE_EMIT(enum bpf_features);
 
@@ -25866,6 +25915,24 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ARRAY_SIZE(bpf_verifier_ops) == 0)
 		return -EINVAL;
 
+	resume = !!(attr->bcf_flags & BCF_F_PROOF_PROVIDED);
+	if (resume) {
+		struct file *f;
+
+		bcf_fd = fdget(attr->bcf_fd);
+		f = fd_file(bcf_fd);
+		if (!f)
+			return -EBADF;
+		env = f->private_data;
+		if (f->f_op != &bcf_fops ||
+		    atomic_cmpxchg(&env->bcf.in_use, 0, 1)) {
+			fdput(bcf_fd);
+			return -EINVAL;
+		}
+		is_priv = env->bpf_capable;
+		goto verifier_check;
+	}
+
 	/* 'struct bpf_verifier_env' can be global, but since it's not small,
 	 * allocate/free it every time bpf_check() is called
 	 */
@@ -25999,6 +26066,12 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret < 0)
 		goto skip_full_check;
 
+verifier_check:
+	if (resume) {
+		ret = resume_env(env, attr, uattr);
+		if (ret)
+			goto skip_full_check;
+	}
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
 
@@ -26006,8 +26079,13 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		u64 vtime = ktime_get_ns() - start_time;
 
 		env->verification_time += vtime;
-		if (do_request_bcf(env, attr, uattr) == 0)
+		if (do_request_bcf(env, attr, uattr) == 0) {
+			if (resume) {
+				atomic_set(&env->bcf.in_use, 0);
+				fdput(bcf_fd);
+			}
 			return ret;
+		}
 
 		unmark_bcf_requested(env);
 		env->verification_time -= vtime;
@@ -26017,6 +26095,10 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 		ret = bpf_prog_offload_finalize(env);
 
 skip_full_check:
+	if (resume) {
+		fd_file(bcf_fd)->private_data = NULL;
+		fdput(bcf_fd);
+	}
 	/* If bcf_requested(), the last state is preserved, free now. */
 	if (env->cur_state)
 		free_states(env);
-- 
2.34.1


