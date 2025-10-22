Return-Path: <linux-kernel+bounces-864422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6976BFAC33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81DDE19A1E9B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C09B304BCB;
	Wed, 22 Oct 2025 08:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+Ixmedz"
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5030303C85
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120156; cv=none; b=PVmBeRZLxRbJRcRHeZD60b68RhsjWkUqTXfQJhlY7De/ou1JEw9LgTGMkGRMubRsM+B3cp152t8ktIR6s6BzTGP0J0xALvLDKezxAmQn1e8KzbbNtA/E0QeZrlrVHtWOTxvfb7QqqQThVgigTbCfHDatlLKQqwg9ywRyUNsHppE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120156; c=relaxed/simple;
	bh=ge4RKcTL9mwWJ/8YcU4iA3Hebcqf1IXM5VAR/s9Qs0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f/xVEuD0jHm9Tx/ivaO8ibmdORv9c8KiDP/WwzfcDg58oZtBZh2iScnz+/awW3kRrWxjXkmv5zgI9w/qlglzct+QQLrLrPI1L40RaX54ISOP0ekQK2AaKZAl9n6pu5lzySOZ760y2I+P3A8GL81cpRx0hUaeOCWzt5oFSyF8oGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+Ixmedz; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b4fb8d3a2dbso4579923a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 01:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761120151; x=1761724951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfXwmoObYIYRyTIzn9fIn8LwwiT3RUaRjh3izqidMDI=;
        b=b+IxmedzdgbsmoRLVXa0XAbMGAh8g5xDGn50Y1g9PfO8V2qkNSNxisWMc9uZppg4UU
         ztIob0Rso2jeeSeY6hCMw27aaz2jdxOS2N4ryoJ5XpAEse/C2qP+sneFxqpX0+bEHo5M
         BuQ1qKR3qe3uGxObRB9yeiaPnEaCveUYBfCBNNN/jR6rVZP/Eg0SsDdM9M34PVwILVrA
         y0+pu5urP+R8vI34PDJMvtjYNevqAk/6gH2uV0UvbvsKv/5OxNQPYagmYi9KZNySbk9U
         RGE1kXwGwVCMT4OPVRg9cDwRc8JhYAJ9FCGrMjf95BH4TBa0HG2SpCfzZDPdImjltZ7s
         NatA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761120151; x=1761724951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jfXwmoObYIYRyTIzn9fIn8LwwiT3RUaRjh3izqidMDI=;
        b=D90n4LaFpBb8NwH/yhI/x4CWcEGAKP/d4JZG1CIq4lSgJHMvL8KXNMZmJPL6cP5Uty
         e/nATZ6GB65rTA41NAyZ1s4A+xvYrASWmcsnOjrpAwBmjCHK61tvZScwK20g1o+HaX0R
         kwW7p85rYkD78qnEeIEv8ig2fzRQ0yEZlqu+ybjEoHUmG0H/KVleB4HPfdZ8AwNLxQME
         CTHvF2WA9HMbkWrqXnr8+I+WExVHkzI+lxTwCQy6vYxsgDLMR0BR3eg2qXVCDRKSp2up
         k/GUwpdlPKq65bLeJjjvaH9wi599jtlG6yN67vR+L1kNE6rAdTn1W1IXb5gkaho1vMkS
         usmA==
X-Forwarded-Encrypted: i=1; AJvYcCV1yhXd90GThwQWt/N8HJlfqZlPQTN4a7qv973ub5fIuAngUyYY3DiJMJPyMWPrsS9TytkhP8v29FtLdIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygYmnHDnZJ87nC1Y1JcLGgFFcDhibjGaYex5T6R/BmQAxNxbHN
	+oTSVi2C+R8lMyF7OtjL+CVrnDc5VYMCRJ+B491kCk9HPF8ZCvgu5PxP
X-Gm-Gg: ASbGncuCbbiBS93DVlv2cr3wH/zOnDT2PhYT0DIri2jYDoRB8X7A4tMaiEvE2Zjgffx
	xnW+6ZMdm7VMMdlor3kWG4VII9PA2tAIMp/NOVnmObXWRERtkgO56wdCUxZrVlujimcJCOJC0JG
	XDQGrgWk8O5/PxKyCk8kpdWmdGU4LZRhmz7i8mbHevSsntb47sEN9SfAC43YEQNEP/KifXO3WAF
	TSRTCDEwr5+CdVkSIbBZeB70bqAbj/nKwk1X9ElmajsmmAeKSTbMvRc+ZuI1QBdDPEsBKkD+3y3
	8NpU2yexjSbzGlRL9v8HvfSLn38wu097fNShAd9KeqOn8uNCm7CxqLpylhVeOIzeTxUMU4bluNr
	EvPyh9sEzcoh8PPqNeNaYQ/ljvdcuUKsybamz8T6oiPZ1jQJ5L/Tw2oFIQur4Qbr7rfEv+0xk9g
	niugBYwHg=
X-Google-Smtp-Source: AGHT+IHcRP/+rFsLy2RENva1Jsb8xo2NqJEfdzP+xic7X2vYpKPlauqBCppFkorSXIkJjpXUbP1Srw==
X-Received: by 2002:a17:902:dac2:b0:275:2328:5d3e with SMTP id d9443c01a7336-290c9ca32f9mr265453375ad.18.1761120151286;
        Wed, 22 Oct 2025 01:02:31 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471d7e41sm131947785ad.57.2025.10.22.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 01:02:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 04/10] bpf,x86: add ret_off to invoke_bpf()
Date: Wed, 22 Oct 2025 16:01:53 +0800
Message-ID: <20251022080159.553805-5-dongml2@chinatelecom.cn>
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

For now, the offset of the return value in trampoline is fixed 8-bytes.
In this commit, we introduce the variable "ret_off" to represent the
offset of the return value. For now, the "ret_off" is just 8. And in the
following patch, we will make it something else to use the room after it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 41 +++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 389c3a96e2b8..7a604ee9713f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2940,7 +2940,7 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 
 static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 			   struct bpf_tramp_link *l, int stack_size,
-			   int run_ctx_off, bool save_ret,
+			   int run_ctx_off, bool save_ret, int ret_off,
 			   void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
@@ -3005,7 +3005,7 @@ static int invoke_bpf_prog(const struct btf_func_model *m, u8 **pprog,
 	 * value of BPF_PROG_TYPE_STRUCT_OPS prog.
 	 */
 	if (save_ret)
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ret_off);
 
 	/* replace 2 nops with JE insn, since jmp target is known */
 	jmp_insn[0] = X86_JE;
@@ -3055,7 +3055,7 @@ static int emit_cond_near_jump(u8 **pprog, void *func, void *ip, u8 jmp_cond)
 
 static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 		      struct bpf_tramp_links *tl, int stack_size,
-		      int run_ctx_off, bool save_ret,
+		      int run_ctx_off, bool save_ret, int ret_off,
 		      void *image, void *rw_image)
 {
 	int i;
@@ -3063,7 +3063,8 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 
 	for (i = 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size,
-				    run_ctx_off, save_ret, image, rw_image))
+				    run_ctx_off, save_ret, ret_off, image,
+				    rw_image))
 			return -EINVAL;
 	}
 	*pprog = prog;
@@ -3072,7 +3073,7 @@ static int invoke_bpf(const struct btf_func_model *m, u8 **pprog,
 
 static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 			      struct bpf_tramp_links *tl, int stack_size,
-			      int run_ctx_off, u8 **branches,
+			      int run_ctx_off, int ret_off, u8 **branches,
 			      void *image, void *rw_image)
 {
 	u8 *prog = *pprog;
@@ -3082,18 +3083,18 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	 * Set this to 0 to avoid confusing the program.
 	 */
 	emit_mov_imm32(&prog, false, BPF_REG_0, 0);
-	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ret_off);
 	for (i = 0; i < tl->nr_links; i++) {
 		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
-				    image, rw_image))
+				    ret_off, image, rw_image))
 			return -EINVAL;
 
-		/* mod_ret prog stored return value into [rbp - 8]. Emit:
-		 * if (*(u64 *)(rbp - 8) !=  0)
+		/* mod_ret prog stored return value into [rbp - ret_off]. Emit:
+		 * if (*(u64 *)(rbp - ret_off) !=  0)
 		 *	goto do_fexit;
 		 */
-		/* cmp QWORD PTR [rbp - 0x8], 0x0 */
-		EMIT4(0x48, 0x83, 0x7d, 0xf8); EMIT1(0x00);
+		/* cmp QWORD PTR [rbp - ret_off], 0x0 */
+		EMIT4(0x48, 0x83, 0x7d, -ret_off); EMIT1(0x00);
 
 		/* Save the location of the branch and Generate 6 nops
 		 * (4 bytes for an offset and 2 bytes for the jump) These nops
@@ -3179,7 +3180,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
+	int ret_off, regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off,
+	    rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
@@ -3213,7 +3215,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 * RBP + 8         [ return address  ]
 	 * RBP + 0         [ RBP             ]
 	 *
-	 * RBP - 8         [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
+	 * RBP - ret_off   [ return value    ]  BPF_TRAMP_F_CALL_ORIG or
 	 *                                      BPF_TRAMP_F_RET_FENTRY_RET flags
 	 *
 	 *                 [ reg_argN        ]  always
@@ -3239,6 +3241,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	save_ret = flags & (BPF_TRAMP_F_CALL_ORIG | BPF_TRAMP_F_RET_FENTRY_RET);
 	if (save_ret)
 		stack_size += 8;
+	ret_off = stack_size;
 
 	stack_size += nr_regs * 8;
 	regs_off = stack_size;
@@ -3341,7 +3344,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (fentry->nr_links) {
 		if (invoke_bpf(m, &prog, fentry, regs_off, run_ctx_off,
-			       flags & BPF_TRAMP_F_RET_FENTRY_RET, image, rw_image))
+			       flags & BPF_TRAMP_F_RET_FENTRY_RET, ret_off,
+			       image, rw_image))
 			return -EINVAL;
 	}
 
@@ -3352,7 +3356,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			return -ENOMEM;
 
 		if (invoke_bpf_mod_ret(m, &prog, fmod_ret, regs_off,
-				       run_ctx_off, branches, image, rw_image)) {
+				       run_ctx_off, ret_off, branches,
+				       image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -3380,7 +3385,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			}
 		}
 		/* remember return value in a stack for bpf prog to access */
-		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -8);
+		emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -ret_off);
 		im->ip_after_call = image + (prog - (u8 *)rw_image);
 		emit_nops(&prog, X86_PATCH_SIZE);
 	}
@@ -3403,7 +3408,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	if (fexit->nr_links) {
 		if (invoke_bpf(m, &prog, fexit, regs_off, run_ctx_off,
-			       false, image, rw_image)) {
+			       false, ret_off, image, rw_image)) {
 			ret = -EINVAL;
 			goto cleanup;
 		}
@@ -3433,7 +3438,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 
 	/* restore return value of orig_call or fentry prog back into RAX */
 	if (save_ret)
-		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -8);
+		emit_ldx(&prog, BPF_DW, BPF_REG_0, BPF_REG_FP, -ret_off);
 
 	emit_ldx(&prog, BPF_DW, BPF_REG_6, BPF_REG_FP, -rbx_off);
 	EMIT1(0xC9); /* leave */
-- 
2.51.1.dirty


