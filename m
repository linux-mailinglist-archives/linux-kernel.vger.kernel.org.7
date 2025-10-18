Return-Path: <linux-kernel+bounces-859231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC489BED150
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFDA5427C44
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADA52882A9;
	Sat, 18 Oct 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PpDE45Jm"
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937F1F63D9
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797317; cv=none; b=KdBAaO23+XovCunElhGq0yeArpp4rAupsbt3DpjNhmvMSI7gChdO6yKGOLBKLujD2hbUOxZ6jngTHkLuLA2CTSWivTdiYIuBqO3xVjnz1Cr7/iVqhK2V3WxotobCrMjmrOIqpNPKitJqFJm5/c6xRj9PJp/QBUzfYD5iFDHUuFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797317; c=relaxed/simple;
	bh=WcS0cISeU0EB2e5zpIl+V1jFsW9ukANz44z7QELkexs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV/yymWzLAT8Um6OPBijGSPp8GBVG3q5R9MbrA6K8m9iAqte8wrSF4YnRcAeHmBm5MJhfHY2Rdp3wolbwnhU3LzXeXX/PBu19qiUdmH2DLCwf5GUZ6gTIRgVKRbK49QukgY5LynRQCAQPFIqK93gSWmsR06p3ugJcXgJPcMKLLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PpDE45Jm; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-781206cce18so2984871b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797315; x=1761402115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTklFQfNZ228hGLJV/pCwVZEy0WyML+yDbo3ZhiifPY=;
        b=PpDE45JmMmmUTPya2JZTuw41jIv82iJSEZ86rrmkh+NIGfaPcRrhlUhN+BD9L12zDJ
         Xgs9V+ecE8lO7Jj4n2wAPzGw753FGyOztl3egILzneEQOcGul8bs5onZJEODqcvLjVLI
         pGgF5eXnKcNWJxZPxK1m1m6eIJZKxCxcb6KkiG6DMaqF7OjrbN7quvmZBy9jpOTBNhtW
         Sc39ZsOSNoNtm/rQ6twEGIm9WFceHrGo6PB0VbdiPB1eyQseUTJmXZnTNeiw6ePgruJM
         BxGaxPQD1DLB9A3gs60+uivmCpVC4Alyvxas7ErMg5W1vmhXkCpmRjSo7DHmnSJre4Ku
         bgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797315; x=1761402115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YTklFQfNZ228hGLJV/pCwVZEy0WyML+yDbo3ZhiifPY=;
        b=tE3Up581u70qXu/Ed9iyKqDUZWByKCPj+uaUEFaFHzgNOYRh15VP13NMcCPHTLhLQy
         FbCV0jRWGL6ccLYlvkFQkcLd4wDGb97T0jnMcsjwIS8ZZvVsAaG8ZRLACDuZ2zvDJBgh
         hPQQGvBoNZzEVnlIDSX6bGE4zA0pjLEI2IrrCx1fSYnPSlmx1ANa73hWvggQ+t/WTJdz
         7gE+Pd34W99OAj9iZPU2HjfK/4QiGCECQrAe4tvU3y3sE4k+93MtXwo9G0XA+qy2ig+/
         Thb8dYlE5Cl42ejyQo/WHenzNsPAbLyf1nQQvQi8K+AODTuTycY74Cnr65XbhCPT3jmP
         7IjA==
X-Forwarded-Encrypted: i=1; AJvYcCWUHPEF7c1frYwM/RBWF+8xVd69wlJ/AZLF+ZXoasZlLjh5RpDNXvOTA18qsl3pDQlEv9XeH/fTIc3XDOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMnjKYNKCyqD54QXhYxe63QPAP4TolPaSlJ5HIa1agz8WIzCB
	VKRmUq4GuGrbN2PYFb6WYuvVL8DI2yt0M+nM1pbCuDG5rVud8gfNn00w
X-Gm-Gg: ASbGnctWvdt/cnRxWR4KiIw6gl9OYU2o+3iLeoB5vw5NJhJUz/Vb70SAUKOkbqvB/IG
	6e/dM8giZJniQYGd2mAO8Ckuh68CEnouDmGyCtW+YqntP66z9TvKQlK4FN6dJ7W1auVU0bPxBqZ
	gf03ePteIFRfiUFnmk8n/jaHo/oPHExKHGZylwdMxc0jmoLv2vqqQZquU0pGIP7gNHFx/z6XrsA
	32Y9LGeTGOY0KHD2uWP4EVYFAdt1WSFGuhhkhhzLfOK/gxiLh//Bc6TE+SGO4dhfuhVJPypqwoT
	nH43nHmdu3gATwNzsUIfJ1Wbhm1Jp1bmSwsIWjqwQ2jDQm4xyHsD1b4AiDoVTVM2130RsBlxPfk
	zBdKHQmUZVgEGbwgNUQX5nCkqt6XEtNzkftRcSJB8Y8I0eOH2ZTWL9jVI4khreHyLDqqGF9VA6t
	xzUWhWTJ/+pLQ=
X-Google-Smtp-Source: AGHT+IFiyeFV4ZjR0KYrd7quycgpOQAPP9ZCPLUVqrumP5YZutEAczLmSZCJGuRx899rUbbRobXMFQ==
X-Received: by 2002:a05:6a20:9149:b0:309:48d8:cf1d with SMTP id adf61e73a8af0-334a78fdda8mr10451087637.18.1760797315482;
        Sat, 18 Oct 2025 07:21:55 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:21:55 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next 3/5] bpf,x86: add tracing session supporting for x86_64
Date: Sat, 18 Oct 2025 22:21:22 +0800
Message-ID: <20251018142124.783206-4-dongml2@chinatelecom.cn>
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

Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry and
invoke_bpf_session_exit is introduced for this purpose.

In invoke_bpf_session_entry(), we will check if the return value of the
fentry is 0, and clear the corresponding flag if not. And in
invoke_bpf_session_exit(), we will check if the corresponding flag is
set. If not set, the fexit will be skipped.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 arch/x86/net/bpf_jit_comp.c | 115 +++++++++++++++++++++++++++++++++++-
 1 file changed, 114 insertions(+), 1 deletion(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index d4c93d9e73e4..0586b96ed529 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3108,6 +3108,97 @@ static int invoke_bpf_mod_ret(const struct btf_func_model *m, u8 **pprog,
 	return 0;
 }
 
+static int invoke_bpf_session_entry(const struct btf_func_model *m, u8 **pprog,
+				    struct bpf_tramp_links *tl, int stack_size,
+				    int run_ctx_off, int session_off,
+				    void *image, void *rw_image)
+{
+	u64 session_flags;
+	u8 *prog = *pprog;
+	u8 *jmp_insn;
+	int i;
+
+	/* clear the session flags:
+	 *
+	 *   xor rax, rax
+	 *   mov QWORD PTR [rbp - session_off], rax
+	 */
+	EMIT3(0x48, 0x31, 0xC0);
+	emit_stx(&prog, BPF_DW, BPF_REG_FP, BPF_REG_0, -session_off);
+
+	for (i = 0; i < tl->nr_links; i++) {
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, true,
+				    image, rw_image))
+			return -EINVAL;
+
+		/* fentry prog stored return value into [rbp - 8]. Emit:
+		 * if (*(u64 *)(rbp - 8) !=  0)
+		 *	*(u64 *)(rbp - session_off) |= (1 << (i + 1));
+		 */
+		/* cmp QWORD PTR [rbp - 0x8], 0x0 */
+		EMIT4(0x48, 0x83, 0x7d, 0xf8); EMIT1(0x00);
+		/* emit 2 nops that will be replaced with JE insn */
+		jmp_insn = prog;
+		emit_nops(&prog, 2);
+
+		session_flags = (1ULL << (i + 1));
+		/* mov rax, $session_flags */
+		emit_mov_imm64(&prog, BPF_REG_0, session_flags >> 32, (u32) session_flags);
+		/* or QWORD PTR [rbp - session_off], rax */
+		EMIT2(0x48, 0x09);
+		emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_0, -session_off);
+
+		jmp_insn[0] = X86_JE;
+		jmp_insn[1] = prog - jmp_insn - 2;
+	}
+
+	*pprog = prog;
+	return 0;
+}
+
+static int invoke_bpf_session_exit(const struct btf_func_model *m, u8 **pprog,
+				   struct bpf_tramp_links *tl, int stack_size,
+				   int run_ctx_off, int session_off,
+				   void *image, void *rw_image)
+{
+	u64 session_flags;
+	u8 *prog = *pprog;
+	u8 *jmp_insn;
+	int i;
+
+	/* set the bpf_trace_is_exit flag to the session flags */
+	/* mov rax, 1 */
+	emit_mov_imm32(&prog, false, BPF_REG_0, 1);
+	/* or QWORD PTR [rbp - session_off], rax */
+	EMIT2(0x48, 0x09);
+	emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_0, -session_off);
+
+	for (i = 0; i < tl->nr_links; i++) {
+		/* check if (1 << (i+1)) is set in the session flags, and
+		 * skip the execution of the fexit program if it is.
+		 */
+		session_flags = 1ULL << (i + 1);
+		/* mov rax, $session_flags */
+		emit_mov_imm64(&prog, BPF_REG_1, session_flags >> 32, (u32) session_flags);
+		/* test QWORD PTR [rbp - session_off], rax */
+		EMIT2(0x48, 0x85);
+		emit_insn_suffix(&prog, BPF_REG_FP, BPF_REG_1, -session_off);
+		/* emit 2 nops that will be replaced with JE insn */
+		jmp_insn = prog;
+		emit_nops(&prog, 2);
+
+		if (invoke_bpf_prog(m, &prog, tl->links[i], stack_size, run_ctx_off, false,
+				    image, rw_image))
+			return -EINVAL;
+
+		jmp_insn[0] = X86_JNE;
+		jmp_insn[1] = prog - jmp_insn - 2;
+	}
+
+	*pprog = prog;
+	return 0;
+}
+
 /* mov rax, qword ptr [rbp - rounded_stack_depth - 8] */
 #define LOAD_TRAMP_TAIL_CALL_CNT_PTR(stack)	\
 	__LOAD_TCC_PTR(-round_up(stack, 8) - 8)
@@ -3179,8 +3270,10 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 					 void *func_addr)
 {
 	int i, ret, nr_regs = m->nr_args, stack_size = 0;
-	int regs_off, nregs_off, ip_off, run_ctx_off, arg_stack_off, rbx_off;
+	int regs_off, nregs_off, session_off, ip_off, run_ctx_off,
+	    arg_stack_off, rbx_off;
 	struct bpf_tramp_links *fentry = &tlinks[BPF_TRAMP_FENTRY];
+	struct bpf_tramp_links *session = &tlinks[BPF_TRAMP_SESSION];
 	struct bpf_tramp_links *fexit = &tlinks[BPF_TRAMP_FEXIT];
 	struct bpf_tramp_links *fmod_ret = &tlinks[BPF_TRAMP_MODIFY_RETURN];
 	void *orig_call = func_addr;
@@ -3222,6 +3315,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	 *
 	 * RBP - nregs_off [ regs count	     ]  always
 	 *
+	 * RBP - session_off [ session flags ] tracing session
+	 *
 	 * RBP - ip_off    [ traced function ]  BPF_TRAMP_F_IP_ARG flag
 	 *
 	 * RBP - rbx_off   [ rbx value       ]  always
@@ -3246,6 +3341,8 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	/* regs count  */
 	stack_size += 8;
 	nregs_off = stack_size;
+	stack_size += 8;
+	session_off = stack_size;
 
 	if (flags & BPF_TRAMP_F_IP_ARG)
 		stack_size += 8; /* room for IP address argument */
@@ -3345,6 +3442,13 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 			return -EINVAL;
 	}
 
+	if (session->nr_links) {
+		if (invoke_bpf_session_entry(m, &prog, session, regs_off,
+					     run_ctx_off, session_off,
+					     image, rw_image))
+			return -EINVAL;
+	}
+
 	if (fmod_ret->nr_links) {
 		branches = kcalloc(fmod_ret->nr_links, sizeof(u8 *),
 				   GFP_KERNEL);
@@ -3409,6 +3513,15 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 		}
 	}
 
+	if (session->nr_links) {
+		if (invoke_bpf_session_exit(m, &prog, session, regs_off,
+					    run_ctx_off, session_off,
+					    image, rw_image)) {
+			ret = -EINVAL;
+			goto cleanup;
+		}
+	}
+
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
 		restore_regs(m, &prog, regs_off);
 
-- 
2.51.0


