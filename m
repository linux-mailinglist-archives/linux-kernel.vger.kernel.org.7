Return-Path: <linux-kernel+bounces-888519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643D8C3B142
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 14:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB752463C61
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026363375D3;
	Thu,  6 Nov 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaojCmQB"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28C332E739
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433622; cv=none; b=Q70IbWLgKo/PX61n3qsJFkFQC3EYGoRoXBNR/2vNqwCcGVvZdywsrehstu5LeHzirScpnaZdCVuQ3HqpWdKZ5AGoLSNXC0p+nM/0Yj/nyWMh1StjSa1Ll2rX/NicTvK3AHLrN6wEuG1sETWw6hS0rx65nrmydkbDCU/nGlfb+uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433622; c=relaxed/simple;
	bh=EnSIiRq6VHyzg36EE4lisdtnJkdNAd019Xn1/RbfzCI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MXoFC2OsHFZG7D6Qj+M18/oO/GQdHQv7SKaQvfKlozNLcpchONK4aJh6pn8IkwuzZuM5C3fOH4c2Bj11xfKxmpXDat9n7RXPC8BLG7JTLbG4d9tpEuT4YNTM7TFYfyVS/EXG2xfFjvBEoR+x12vEXnfUMkIEiJZsxedUdXQxHB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaojCmQB; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-429eb7fafc7so651274f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762433618; x=1763038418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5UtbFN3SeUqWauxQUFhPcEKoaIiq/3X5SZjNQXVMzY=;
        b=YaojCmQB0Fg3OgZso8vv+nvyabzPAmSaWeZXdFQoQpHXACpMIxuVDBFMyyDfYFN8in
         fVTRbo6/Acqj30Qio+HFABgeffUKSQzl5qvVdpRq8h4o7a3guo3QAw6RxWMPuY84wAuK
         RWQaAHBdnDSkdsvs9N7ejWKx2coqRHezQkK3w4+2KESWJ7nOiZcAADXORDo8lqFCeQxa
         DhQg2n3H3ERtmz6niWqEKNmCGUUHfFc3yUk63v3hfDbVOne8cvjRWV3KEELgRJ2Min+h
         4ZDJU7sAsUJnc6VIXw8R4IKVdcFUf7c0VP47gN3RFpcJwqUkShrm8jcVeGL8PxVPIt1m
         1EoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762433618; x=1763038418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J5UtbFN3SeUqWauxQUFhPcEKoaIiq/3X5SZjNQXVMzY=;
        b=mqxpYxZLo6rlbXxMFp5+KTVZEB/drqBawdQku8+syMrNQP7qd46QrEq38WAoEP5VIP
         S0mY+bexts+oFFzHsMYMudwA8TXLeGx9kCr9zeCZ5Zn1BDdsK0Wv+vAkq7yASUohqh/N
         UVBuwhg53bU14GeIimXBlCRbaLMZA0wndNZ2prUx5OyqgED2G3UTTXmT3+qVTUyI7Ilc
         Pt7kfI/Vb2u6Hm0Gd7GuldjIpRtElrNw2f6Kwa5bIX+RPxe6CeToRThWL/UGTj9aHH+P
         AVd4mJJqkKU82iUpGf8tZjk4+wXE5LQ/2xZZhjhR6384r4pIl9SczmcYHuOUYqhK5/eO
         3XeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZgMFObs8vTi6bwncphNbZAXCfxrHbbP7P5KP7P22Cx7SmFLzpHsRaDrz7lV5LNu+2xRc6RYY3N2uICP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq0vbEQ46ck3kl5irIABNqlMRYSSLK9vZHi2kXqRIjxxekjVB0
	pvgq3u0BWQ2ZcYl//Ux0Avr6jQQdPpPd8zu7RzDCQJjLZXx5R9jX0to=
X-Gm-Gg: ASbGncv4StgXl9LqD6CtORsGPOJsPF4kk7Muu07DD9HIAB+D9ZmnUx5GT91jvavJCJS
	x3DAMYY+OeznZNJCgA0rF7JuqZayrxDmuqe3EhAGvukmUsXogAn3w3D7hjZIKpeUTTKAsp438Uc
	jpYPwUyifyRG/VT6FY8vxHwGSAjMbuf2CNPr8t7GMSWdtrAM4eTGshG2NaqFApRFxNaQlrg6h7w
	vMh98HGRjdUPkOK3u7M8X8JZUprURtbr7irJbWAsCVUACjFIZTAYJNKr8xP8BR1qTeGZzsjCJMx
	3+RecAA2VhEXcOMPSxbeCEyIP3SAy7/O7oUXa0c4VlinaYaP7rli0jho7YyBOBQm9/wPXH7lon7
	dnr3/oiYl606tZMDddNBa4oP+OHyDkYG1Wik/GbMdeYCgQQnOtrTtUmMqv40MVwy0H0/qbB33b+
	sTJUIVFykTcvVXSmjIgKtgxisjwbOhZb601unDtyexpQXs9s3Rj/+0i+g=
X-Google-Smtp-Source: AGHT+IETLShyKsHT25JdeNK9Sz1/yzYm3e12YwX3zT1yZFekr4gNRNP0A8afPQDiZ+0+kfpa/ZLupA==
X-Received: by 2002:adf:9d91:0:b0:429:ec94:67ec with SMTP id ffacd0b85a97d-429ec9469cbmr1719997f8f.1.1762433618072;
        Thu, 06 Nov 2025 04:53:38 -0800 (PST)
Received: from ast-epyc5.inf.ethz.ch (ast-epyc5.inf.ethz.ch. [129.132.161.180])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb40379esm4788856f8f.9.2025.11.06.04.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 04:53:37 -0800 (PST)
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
Subject: [PATCH RFC 04/17] bpf: Add top-level workflow of bcf_refine()
Date: Thu,  6 Nov 2025 13:52:42 +0100
Message-Id: <20251106125255.1969938-5-hao.sun@inf.ethz.ch>
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

Add the top-level refinement hook `bcf_refine()`:

- Add `struct bcf_refine_state` to `struct bpf_verifier_env`: stores the list
  of parent states forming the relevant path suffix (`parents`, `vstate_cnt`),
  and traversal cursors (`cur_vstate`, `cur_jmp_entry`). A boolean `available`
  marks whether BCF can be used in this verification.

- Implement `backtrack_states()`: walking parents with `backtrack_insn()` and
  recorded jump history and find a base state to start the symbolic
  tracking.

- Add a stub `bcf_track()` () and `bcf_refine()` routine that: (a) derives
  default `reg_masks` when not provided by selecting interesting regs,
  (b) backtracks parents, (c) runs `bcf_track()` and a refinement callback,
  and (d) marks the aux flag to request a proof when a condition is produced.

The actual symbolic tracking, condition build and concrete refinements
appear in subsequent patches.

Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
---
 include/linux/bpf.h          |   1 +
 include/linux/bpf_verifier.h |  13 +++
 kernel/bpf/verifier.c        | 156 +++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index a47d67db3be5..690b0b2b84ba 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1656,6 +1656,7 @@ struct bpf_prog_aux {
 	bool changes_pkt_data;
 	bool might_sleep;
 	bool kprobe_write_ctx;
+	bool bcf_requested;
 	u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
 	struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
 	struct bpf_arena *arena;
diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index c6eb68b6389c..090430168523 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -732,6 +732,18 @@ struct bpf_scc_info {
 
 struct bpf_liveness;
 
+struct bcf_refine_state {
+	/* The state list that decides the path suffix, on which bcf_track()
+	 * collects symbolic information for target registers.
+	 */
+	struct bpf_verifier_state **parents;
+	u32 vstate_cnt;
+	u32 cur_vstate;
+	u32 cur_jmp_entry;
+
+	bool available; /* if bcf_buf is provided. */
+};
+
 /* single container for all structs
  * one verifier_env per bpf_check() call
  */
@@ -838,6 +850,7 @@ struct bpf_verifier_env {
 	struct bpf_scc_info **scc_info;
 	u32 scc_cnt;
 	struct bpf_iarray *succ;
+	struct bcf_refine_state bcf;
 };
 
 static inline struct bpf_func_info_aux *subprog_aux(struct bpf_verifier_env *env, int subprog)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e4928846e763..7125f7434e6f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -608,6 +608,23 @@ static bool is_atomic_load_insn(const struct bpf_insn *insn)
 	       insn->imm == BPF_LOAD_ACQ;
 }
 
+typedef int (*refine_state_fn)(struct bpf_verifier_env *env,
+			       struct bpf_verifier_state *st, void *ctx);
+
+static int bcf_refine(struct bpf_verifier_env *env,
+		      struct bpf_verifier_state *st, u32 reg_masks,
+		      refine_state_fn refine_cb, void *ctx);
+
+static bool bcf_requested(const struct bpf_verifier_env *env)
+{
+	return env->prog->aux->bcf_requested;
+}
+
+static void mark_bcf_requested(struct bpf_verifier_env *env)
+{
+	env->prog->aux->bcf_requested = true;
+}
+
 static int __get_spi(s32 off)
 {
 	return (-off - 1) / BPF_REG_SIZE;
@@ -23378,6 +23395,145 @@ static int do_check_common(struct bpf_verifier_env *env, int subprog)
 	return ret;
 }
 
+static int bcf_track(struct bpf_verifier_env *env,
+		     struct bpf_verifier_state *st,
+		     struct bpf_verifier_state *base)
+{
+	return -EOPNOTSUPP;
+}
+
+/*
+ * Backtracks through parent verifier states to identify the suffix of the path
+ * that is relevant for register refinement in bcf_track(). Using backtrack_insn(),
+ * this routine locates the instructions that define the target registers and any
+ * registers that are transitively related. All states visited during this process
+ * collectively define the path suffix.
+ *
+ * Returns the parent state of the last visited state, which serves as the base
+ * state from which bcf_track() begins its analysis.
+ * The jump history from the collected states determines the suffix to follow.
+ */
+static struct bpf_verifier_state *
+backtrack_states(struct bpf_verifier_env *env, struct bpf_verifier_state *cur,
+		 u32 reg_masks)
+{
+	struct bpf_verifier_state *base = NULL, *st = cur;
+	struct backtrack_state *bt = &env->bt;
+	struct bcf_refine_state *bcf = &env->bcf;
+	int first_idx = cur->first_insn_idx;
+	int last_idx = cur->insn_idx;
+	int subseq_idx = -1;
+	bool skip_first = true;
+	int i, err, log_level = 0;
+	u32 vstate_cnt;
+
+	if (!reg_masks)
+		return ERR_PTR(-EFAULT);
+
+	bt_init(bt, st->curframe);
+	bt->reg_masks[bt->frame] = reg_masks;
+	swap(env->log.level, log_level); /* Disable backtrack_insn() log. */
+
+	for (;;) {
+		u32 history = st->jmp_history_cnt;
+		struct bpf_jmp_history_entry *hist;
+
+		if (last_idx < 0 || !st->parent)
+			break;
+
+		for (i = last_idx;;) {
+			if (skip_first) {
+				err = 0;
+				skip_first = false;
+			} else {
+				hist = get_jmp_hist_entry(st, history, i);
+				err = backtrack_insn(env, i, subseq_idx, hist, bt);
+			}
+			if (err) /* Track the entire path. */
+				goto out;
+			if (bt_empty(bt)) { /* Base state found. */
+				base = st->parent;
+				goto out;
+			}
+			subseq_idx = i;
+			i = get_prev_insn_idx(st, i, &history);
+			if (i == -ENOENT)
+				break;
+			if (i >= env->prog->len)
+				goto out;
+		}
+
+		st = st->parent;
+		subseq_idx = first_idx;
+		last_idx = st->last_insn_idx;
+		first_idx = st->first_insn_idx;
+	}
+
+out:
+	bt_reset(bt);
+	swap(env->log.level, log_level);
+
+	/* Collect parents and follow their jmp history. */
+	vstate_cnt = 1;
+	st = cur->parent;
+	while (st != base) {
+		vstate_cnt++;
+		st = st->parent;
+	}
+	bcf->parents = kmalloc_array(vstate_cnt, sizeof(st), GFP_KERNEL_ACCOUNT);
+	if (!bcf->parents)
+		return ERR_PTR(-ENOMEM);
+	bcf->vstate_cnt = vstate_cnt;
+	st = cur;
+	while (vstate_cnt) {
+		bcf->parents[--vstate_cnt] = st;
+		st = st->parent;
+	}
+	bcf->cur_vstate = 0;
+	bcf->cur_jmp_entry = 0;
+	return base;
+}
+
+static int __used bcf_refine(struct bpf_verifier_env *env,
+			     struct bpf_verifier_state *st, u32 reg_masks,
+			     refine_state_fn refine_cb, void *ctx)
+{
+	struct bpf_reg_state *regs = st->frame[st->curframe]->regs;
+	struct bpf_verifier_state *base;
+	int i, err;
+
+	if (!env->bcf.available || st->speculative)
+		return 0;
+	/* BCF requested multiple times in an error path. */
+	if (bcf_requested(env))
+		return -EFAULT;
+
+	if (!reg_masks) {
+		for (i = 0; i < BPF_REG_FP; i++) {
+			if (regs[i].type == NOT_INIT)
+				continue;
+			if (regs[i].type != SCALAR_VALUE &&
+			    tnum_is_const(regs[i].var_off))
+				continue;
+			reg_masks |= (1 << i);
+		}
+	}
+
+	base = backtrack_states(env, st, reg_masks);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	err = bcf_track(env, st, base);
+	if (!err && refine_cb)
+		err = refine_cb(env, st, ctx);
+
+	if (!err)
+		mark_bcf_requested(env);
+
+	kfree(env->bcf.parents);
+	return err ?: 1;
+}
+
 /* Lazily verify all global functions based on their BTF, if they are called
  * from main BPF program or any of subprograms transitively.
  * BPF global subprogs called from dead code are not validated.
-- 
2.34.1


