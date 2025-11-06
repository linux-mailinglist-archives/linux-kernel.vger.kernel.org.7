Return-Path: <linux-kernel+bounces-888528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EDBC3B1C5
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64D04224FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826ED33EB0D;
	Thu,  6 Nov 2025 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F9peU7j/"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58198339B5E
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433629; cv=none; b=otsYnUp4tvWE13K+Pfh7s2zTSLxsDKJxy8xgN5/wdL0zZk8o6j4qHi0nWVlzYHd553d7mWSxMvX1cp5TM91nKaFhICRGDXDhvlUQG6OddQhqaN7bcguiA7Lqll+JFl8u8Qo37CzF7+ZWj2CHCOyUM0L0dYP+W9duCATx/s/mkGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433629; c=relaxed/simple;
	bh=iirOyCTuTQLJ3WXnG2LSSYaVBZRAqVL6cetgZbBefoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ATC5cmjSH2T32aHCfKzlq1Z+gBhEWIbn3otfBmw3uTW550v00ombnOn4SjUHfli12biGTDK6wk19cQe0I1mUn4sadhImQoEpWgC4ogvyr8RMKDlA5Z7TxwieZ/quRdXdt4y4jDf1Ko5tiSFEAyToay/UjZeGM1WKpF1+13x5LiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F9peU7j/; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4298b865f84so477500f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433625; x=1763038425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHdOj7ulNF+ppmOqwLHhoqhx0zKTa30/mx/RkkRF4T4=;
        b=F9peU7j/LJf12xpr7FY/mnI179c3tq01yD3RhwaksDOaKZor8nmpRw1krEUm9AEexq
         iToYd8b58+9+lE8T5DEEFbp+nNxD5PirlXivmm4neGNwFBHnTlrkwqQ7jbTEt7nhLs8P
         g2WRG8nDXQvjPVckzUnVZ9uwLd96pcZQQ7iXRSkvGNHquhan50arh1znNxP0lSKlS+zD
         E8L/Vtes4357TAn1I+6nT1AUHDAJOLCwL787bhNwvmao9827ZeS3qqxcnEt0Lg7pixXf
         vCHLoPnr3UX4RF0zcbvDt0bH6z2rSsToPuecTWozAqqWY7c4ebfIWhwoY8YEKBm1SkeH
         IPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433625; x=1763038425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JHdOj7ulNF+ppmOqwLHhoqhx0zKTa30/mx/RkkRF4T4=;
        b=XLt7w2mJg9ejbnyFvw2j7UayOpDF401uhh4XxgSS6Q4phblx6qgl2llz/udRS+8InF
         hTandx5qyPcuH/+6/LULNchl22GZepm9HPtZLFRFDv7sCXOKMCCJS6Eelg0eVlI4zyxH
         JTRbBe0buzkQ98Hra/qIxyykHqL9y0SvQtct31WRi7fjLHoYK5ID0hMaZDh7ad3BUvhd
         fZA2CFhuos9R2yWFkwCml4WhfvwLgWRpG5j2sF09kAVNzJWa9Jj6vfBgeOZyBQh/OgSQ
         UyruF2HoEg+dYjZKwkAYV8syy7KhtzW8Z5uED3flHTJN6O8C9LumlOOmi/FQKGkN8M38
         fwqA==
X-Forwarded-Encrypted: i=1; AJvYcCVKfalD+kDMFhzFR8Nk1ou7ALHnsYSzcOYovBQZNd4PP/RTIRx2Djwfxx9k8jvsqtZ66YLpxJWm1oRwMdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg9yJSqKkPVNb7Fo3ZjeC4xSt/NN6DfykLwsobwAJKDru93GtK
	Bnb/AJ6+I1dUd/NneCxw+rsKaxntE4xlWxN2wupklx6qkMQ7SZeuzl0=
X-Gm-Gg: ASbGnctXlTsvg5L115lG17vBBdArOeVM7M71Bo7QHBrf1YaoyCcVurEXqEQeUfSBW1C
	dftykWEC29+s88fSQ2MCErUBxnvBhw8pMtiQz3I+Ze4H+/adgDVdzG+8fl6LTKKjVbC2OyHtRq1
	eGDIdtzNgsTb1MpiCf3mE+N1CQQReZxMhbt027xYIY+iBJlVrKb+rlhBHmB8xQ9oqv5n+nvFkzy
	OEaQk3sDoQMWT0qw7k350n95j/V2k+gYWP4i6V5rpdQJJpUO5Unc9OIIIPZ4jNAuFt1hpnCVuX+
	gFde2fb8hei1BJJSpqlOQeC2s0QQ6vaE201K3k5qQu7y9d7W8jQHvBBXhRORSfpf9Z2vKAqTETH
	WJpphToMO74puTv9QVbi30ySeZYGFtpO/4O2ndpl48s2b+DimHaraWnaPp9SqKrHmDorgzA3wg+
	oPFAbs1JG1W65qe5agu4ciG674C1NklrF9SFPTD6Ush/rd0fs4d+1bYbM=
X-Google-Smtp-Source: AGHT+IGbcSvgyDIFX104hFsyRqUmMxP5IxutnYiC8uPKnRyoOUjx0mknhZI8QlEUnUDIp6u8s+HmRQ==
X-Received: by 2002:a05:6000:25c2:b0:429:cda2:a01d with SMTP id ffacd0b85a97d-429e32edf87mr7231081f8f.26.1762433624675;
        Thu, 06 Nov 2025 04:53:44 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:44 -0800 (PST)
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
Subject: [PATCH RFC 15/17] bpf: Preserve verifier_env and request BCF
Date: Thu,  6 Nov 2025 13:52:53 +0100
Message-Id: <20251106125255.1969938-16-hao.sun@inf.ethz.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
References: <20251106125255.1969938-1-hao.sun@inf.ethz.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preserve the verifier environment when a refinement request is issued and
export the expression arena and condition to userspace, so that the analysis
can resume later with a proof.

- Track the currently analyzed subprog (`env->subprog`) so resume can pick up
  where the request occurred. 
- In `do_check_common()`, if a request is pending, return early without
  freeing states (bcf/tracking-aware). In `bpf_prog_load()`, if the request was
  issued, return the verifier error immediately to userspace.
- Add anon-fd : create an anon inode (`bcf_fops`) that owns the `verifier_env`.
  On fd release, free verifier state, release maps/btfs/prog.
- Implement `do_request_bcf()`: copy conditions into `bcf_buf`; set
  `bcf_flags = BCF_F_PROOF_REQUESTED`; allocate and return
  `bcf_fd` if this is the first request.
- Adjust verifier time accounting to multi-rounds analysis.
- Minor cleanups: make zext/hi32 optimization read flags from `env`.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/linux/bpf_verifier.h |   3 +
 kernel/bpf/syscall.c         |   2 +
 kernel/bpf/verifier.c        | 113 +++++++++++++++++++++++++++++++++--
 3 files changed, 112 insertions(+), 6 deletions(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 05e8e3feea30..67eac7b2778e 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -774,6 +774,7 @@ struct bpf_verifier_env {
 	bool strict_alignment;		/* perform strict pointer alignment checks */
 	bool test_state_freq;		/* test verifier with different pruning frequency */
 	bool test_reg_invariants;	/* fail verification on register invariants violations */
+	bool test_rnd_hi32;		/* randomize high 32-bit to test subreg def/use */
 	struct bpf_verifier_state *cur_state; /* current verifier state */
 	/* Search pruning optimization, array of list_heads for
 	 * lists of struct bpf_verifier_state_list.
@@ -867,6 +868,8 @@ struct bpf_verifier_env {
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
 	struct bcf_refine_state bcf;
+	/* The subprog being verified. */
+	u32 subprog;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5968b74ed7b2..97914494bd18 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3096,6 +3096,8 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 
 	/* run eBPF verifier */
 	err = bpf_check(&prog, attr, uattr, uattr_size);
+	if (prog->aux->bcf_requested)
+		return err;
 	if (err < 0)
 		goto free_used_maps;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 22a068bfd0f2..3b631cea827e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -15,6 +15,8 @@
 #include <linux/filter.h>
 #include <net/netlink.h>
 #include <linux/file.h>
+#include <linux/anon_inodes.h>
+#include <linux/fdtable.h>
 #include <linux/vmalloc.h>
 #include <linux/stringify.h>
 #include <linux/bsearch.h>
@@ -636,6 +638,11 @@ static void mark_bcf_requested(struct bpf_verifier_env *env)
 	env->prog->aux->bcf_requested = true;
 }
 
+static void unmark_bcf_requested(struct bpf_verifier_env *env)
+{
+	env->prog->aux->bcf_requested = false;
+}
+
 static int bcf_alloc_expr(struct bpf_verifier_env *env, u32 cnt)
 {
 	struct bcf_refine_state *bcf = &env->bcf;
@@ -22036,8 +22043,7 @@ static int opt_remove_nops(struct bpf_verifier_env *env)
 	return 0;
 }
 
-static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
-					 const union bpf_attr *attr)
+static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env)
 {
 	struct bpf_insn *patch;
 	/* use env->insn_buf as two independent buffers */
@@ -22049,7 +22055,7 @@ static int opt_subreg_zext_lo32_rnd_hi32(struct bpf_verifier_env *env,
 	struct bpf_prog *new_prog;
 	bool rnd_hi32;
 
-	rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
+	rnd_hi32 = env->test_rnd_hi32;
 	zext_patch[1] = BPF_ZEXT_REG(0);
 	rnd_hi32_patch[1] = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, 0);
 	rnd_hi32_patch[2] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_AX, 32);
@@ -24233,7 +24239,7 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	ret = do_check(env);
 
 	/* Invoked by bcf_track(), just return. */
-	if (env->bcf.tracking)
+	if (env->bcf.tracking || bcf_requested(env))
 		return ret;
 out:
 	if (!ret && pop_log)
@@ -24573,6 +24579,7 @@ static int do_check_subprogs(struct bpf_verifier_env *env)
 		if (!sub_aux->called || sub_aux->verified)
 			continue;
 
+		env->subprog = i;
 		env->insn_idx = env->subprog_info[i].start;
 		WARN_ON_ONCE(env->insn_idx == 0);
 		ret = do_check_common(env, i);
@@ -25766,6 +25773,85 @@ static int compute_scc(struct bpf_verifier_env *env)
 	return err;
 }
 
+static int bcf_release(struct inode *inode, struct file *filp)
+{
+	struct bpf_verifier_env *env = filp->private_data;
+
+	if (!env)
+		return 0;
+
+	free_states(env);
+	kvfree(env->explored_states);
+
+	if (!env->prog->aux->used_maps)
+		release_maps(env);
+	if (!env->prog->aux->used_btfs)
+		release_btfs(env);
+	bpf_prog_put(env->prog);
+
+	module_put(env->attach_btf_mod);
+	vfree(env->insn_aux_data);
+	bpf_stack_liveness_free(env);
+	kvfree(env->cfg.insn_postorder);
+	kvfree(env->scc_info);
+	kvfree(env->succ);
+	kvfree(env->bcf.exprs);
+	kvfree(env);
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations bcf_fops = {
+	.release = bcf_release,
+};
+
+static int do_request_bcf(struct bpf_verifier_env *env, union bpf_attr *attr,
+			  bpfptr_t uattr)
+{
+	bpfptr_t bcf_buf = make_bpfptr(attr->bcf_buf, uattr.is_kernel);
+	int ret, bcf_fd = -1, flags = BCF_F_PROOF_REQUESTED;
+	struct bcf_refine_state *bcf = &env->bcf;
+	u32 sz, sz_off, expr_sz;
+
+	/* All exprs, followed by path_cond and refine_cond. */
+	expr_sz = bcf->expr_cnt * sizeof(struct bcf_expr);
+	sz = expr_sz + sizeof(bcf->path_cond) + sizeof(bcf->refine_cond);
+	sz_off = offsetof(union bpf_attr, bcf_buf_true_size);
+
+	ret = -EFAULT;
+	if (copy_to_bpfptr_offset(uattr, sz_off, &sz, sizeof(sz)))
+		return ret;
+	if (sz > attr->bcf_buf_size)
+		return -ENOSPC;
+
+	if (copy_to_bpfptr_offset(bcf_buf, 0, bcf->exprs, expr_sz) ||
+	    copy_to_bpfptr_offset(bcf_buf, expr_sz, &bcf->path_cond,
+				  sizeof(u32)) ||
+	    copy_to_bpfptr_offset(bcf_buf, expr_sz + sizeof(u32),
+				  &bcf->refine_cond, sizeof(u32)))
+		return ret;
+
+	if (copy_to_bpfptr_offset(uattr, offsetof(union bpf_attr, bcf_flags),
+				  &flags, sizeof(flags)))
+		return ret;
+
+	/* Allocate fd if first request. */
+	if (!(attr->bcf_flags & BCF_F_PROOF_PROVIDED)) {
+		bcf_fd = anon_inode_getfd("bcf", &bcf_fops, env,
+					  O_RDONLY | O_CLOEXEC);
+		if (bcf_fd < 0)
+			return bcf_fd;
+		if (copy_to_bpfptr_offset(uattr,
+					  offsetof(union bpf_attr, bcf_fd),
+					  &bcf_fd, sizeof(bcf_fd))) {
+			close_fd(bcf_fd);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u32 uattr_size)
 {
 	u64 start_time = ktime_get_ns();
@@ -25846,6 +25932,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (is_priv)
 		env->test_state_freq = attr->prog_flags & BPF_F_TEST_STATE_FREQ;
 	env->test_reg_invariants = attr->prog_flags & BPF_F_TEST_REG_INVARIANTS;
+	env->test_rnd_hi32 = attr->prog_flags & BPF_F_TEST_RND_HI32;
 
 	env->explored_states = kvcalloc(state_htab_size(env),
 				       sizeof(struct list_head),
@@ -25915,10 +26002,24 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	ret = do_check_main(env);
 	ret = ret ?: do_check_subprogs(env);
 
+	if (ret && bcf_requested(env)) {
+		u64 vtime = ktime_get_ns() - start_time;
+
+		env->verification_time += vtime;
+		if (do_request_bcf(env, attr, uattr) == 0)
+			return ret;
+
+		unmark_bcf_requested(env);
+		env->verification_time -= vtime;
+	}
+
 	if (ret == 0 && bpf_prog_is_offloaded(env->prog->aux))
 		ret = bpf_prog_offload_finalize(env);
 
 skip_full_check:
+	/* If bcf_requested(), the last state is preserved, free now. */
+	if (env->cur_state)
+		free_states(env);
 	kvfree(env->explored_states);
 
 	/* might decrease stack depth, keep it before passes that
@@ -25957,7 +26058,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	 * insns could be handled correctly.
 	 */
 	if (ret == 0 && !bpf_prog_is_offloaded(env->prog->aux)) {
-		ret = opt_subreg_zext_lo32_rnd_hi32(env, attr);
+		ret = opt_subreg_zext_lo32_rnd_hi32(env);
 		env->prog->aux->verifier_zext = bpf_jit_needs_zext() ? !ret
 								     : false;
 	}
@@ -25965,7 +26066,7 @@ int bpf_check(struct bpf_prog **prog, union bpf_attr *attr, bpfptr_t uattr, __u3
 	if (ret == 0)
 		ret = fixup_call_args(env);
 
-	env->verification_time = ktime_get_ns() - start_time;
+	env->verification_time += ktime_get_ns() - start_time;
 	print_verification_stats(env);
 	env->prog->aux->verified_insns = env->insn_processed;
 
-- 
2.34.1


