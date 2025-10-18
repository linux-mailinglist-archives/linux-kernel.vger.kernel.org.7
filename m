Return-Path: <linux-kernel+bounces-859230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1F2BED141
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 16:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EF13420FBE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C953427F72C;
	Sat, 18 Oct 2025 14:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhk061bR"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DC1B4247
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 14:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760797312; cv=none; b=GvEiXNpqt7WYFqMKZNWi1ZOZ4TmKjU8O/7MbhcuFVnet1lMOVNIPmzgS3fiVCtuNfp59jSLYkv61g1RZIH/wYcce/YcUvelsh0jEmSSGCUSH9gjWa4LJvtgRkzOocIP/jJSkKFQ6Flcy8RhTl1Q34JOcE6FDprGBpF96Zj/uUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760797312; c=relaxed/simple;
	bh=c99jLCl4oK0lYbHL6l7ZVaK/eHqsZKgxrs6O+Xjt2Ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyU4/ZS3riGmqg1QjOdaaPJuqOkwQfzYN0NT0P3xc6Oi0CugZBs3fSd2RtH841CNUldmeWt4C0WnC4cA4n+LKJ0fu+pHa8VzFCqqzqEz6kgCj0msgWg56GDjlDK+tE6/k6ebWAVS/pmnq3FIXsJqdS3Tdw3/F9kI79nBtF+e82k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhk061bR; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-78af743c232so2503551b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 07:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760797310; x=1761402110; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NYwvvMkNsizkLkVR3lZyOmzWt267ljepeEAqISwgDss=;
        b=hhk061bR+uw2b/fjfGSSxs2NgEfBA3i/2BjMPWD4K4YGGrDtKRipuD+F2mS58iT5PO
         sufWTv1GBXwxjahpsL/1Ut3FsgiQ34iTfXQ3ZUaD8tbarSZ9j/wt3I18xA4VJ+OcFE3z
         woBY9UxLzJPQLp9vxh6oWS4YCZ4WG7eZTj93Cd/TiaaiY7BolYpBxliIXOP8shWny1yE
         wJwJVxxdIFV5+dSCK/YZAGZtUBTSluj89gW0u3qFTSF0goxkdrQzEctBFQ9k47zC7/E8
         E4I2esZ8dLyYtq9c9H8Q3qGmkfnMeJa2fMqz2vJl8TW5ek22Y9r/taZyrWrkQFRMgaJe
         4CQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760797310; x=1761402110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NYwvvMkNsizkLkVR3lZyOmzWt267ljepeEAqISwgDss=;
        b=Pakw+6Vi0IPQ+HTnC5iDuptdEo17j5ZmUmHGu8she1/yzxVltdwE/RoOF3mEwwwKTL
         eOO3xqPjPIKZfW3Q8TgaJdIXYhagEPEK9tnJ1YLjKsMS4stbxY46voNWBMhWGdF1mRPg
         RdNWCuBvCsJulh+gFXx/y0g+LR/A5YOs3lzwzzp/7Xb1WchI3THuuGDg53SWSmstplSM
         fZFdI6VyDWLNDE2R45vjaHc825q2idufWfKFcGWLK4WL9EUulIIS14y0/0CUEjdMVLoS
         Gx7D/lsRr7caB9SQ5lbmI85mHiqahv5VfOGRK9kmLYLSFbzmMvThLy3OOf/qsd+NNCBt
         CknA==
X-Forwarded-Encrypted: i=1; AJvYcCV9QhnvBsmyUnquHvXwmKlnNg6uGjjMfug05vluAErL5A42SV/C67Un230ccw8mUn1YP06P3eojpJEKdFc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7K32wXDVoeL+Q+xBDjp+wvHwiUzWYfBZW3N1zWvCiCYRSl9qy
	XrmX2GBH4nK/6m1nmtInSjcaHjOQypJbgHXkAV1ClbniX8j7tGfJkZ4w
X-Gm-Gg: ASbGnct8qioS17YaDTrxPNJYceqPAUyWUUhz8VasIufQafoFn+Gu32H+2E99NWeufyK
	nHZqwzouaYCFErUKKV8k+vRV11XN/345Hdvg95YphG1t8eVa3bp6OWfuvcOZ2FmufSVD2kHTJ1+
	hGsudMb+Y393Y+PuTyEgcNzSpRRqXyJdPP1RtdJ1dlJi2FF6fwMfQP8rucYypgPH24D8lLktVSO
	oFgToc98w0NjXPa4KEAQ+1gAYGlyjmyEOQqyTwNeyOvduPLIgPIOPHXGkKShYy9wIkUdSwwmHcs
	+tK/ZBYaOK3/jHpIxlkOCxHIyj205ces7oW+R6syQ+zBm2Isxpj5u5Ti4aNWYmpEuZb/446X65p
	ytv5JQDDTtlcm+KYmRR1o+qMv9ZShhSjakFAxcoClABrxNY3oH8eTClvMVduOXZyCK6WZKrtuPj
	NrA9vUYqqQXKk=
X-Google-Smtp-Source: AGHT+IE88gDZ5ZuEI9rRpvXV/ekTZy+PSm2f/QXfC+JY64iWLG600+Hr2zdXGf21CmwOwy+JFCe24w==
X-Received: by 2002:a05:6a00:2e99:b0:781:c54:4d24 with SMTP id d2e1a72fcca58-7a220ab6c7bmr7997114b3a.21.1760797309777;
        Sat, 18 Oct 2025 07:21:49 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010d818sm2913589b3a.53.2025.10.18.07.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 07:21:49 -0700 (PDT)
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
Subject: [PATCH RFC bpf-next 2/5] bpf: add kfunc bpf_tracing_is_exit for TRACE_SESSION
Date: Sat, 18 Oct 2025 22:21:21 +0800
Message-ID: <20251018142124.783206-3-dongml2@chinatelecom.cn>
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

If TRACE_SESSION exists, we will use extra 8-bytes in the stack of the
trampoline to store the flags that we needed, and the 8-bytes lie before
the function argument count, which means ctx[-2]. And we will store the
flag "is_exit" to the first bit of it.

Introduce the kfunc bpf_tracing_is_exit(), which is used to tell if it
is fexit currently.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
Co-developed-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c    |  5 ++++-
 kernel/trace/bpf_trace.c | 43 +++++++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 40e3274e8bc2..a1db11818d01 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12284,6 +12284,7 @@ enum special_kfunc_type {
 	KF___bpf_trap,
 	KF_bpf_task_work_schedule_signal,
 	KF_bpf_task_work_schedule_resume,
+	KF_bpf_tracing_is_exit,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12356,6 +12357,7 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, __bpf_trap)
 BTF_ID(func, bpf_task_work_schedule_signal)
 BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_tracing_is_exit)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
@@ -12410,7 +12412,8 @@ get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 	struct bpf_reg_state *reg = &regs[regno];
 	bool arg_mem_size = false;
 
-	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx])
+	if (meta->func_id == special_kfunc_list[KF_bpf_cast_to_kern_ctx] ||
+	    meta->func_id == special_kfunc_list[KF_bpf_tracing_is_exit])
 		return KF_ARG_PTR_TO_CTX;
 
 	/* In this function, we verify the kfunc's BTF as per the argument type,
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..6dde48b9d27f 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3356,12 +3356,49 @@ static const struct btf_kfunc_id_set bpf_kprobe_multi_kfunc_set = {
 	.filter = bpf_kprobe_multi_filter,
 };
 
-static int __init bpf_kprobe_multi_kfuncs_init(void)
+__bpf_kfunc_start_defs();
+
+__bpf_kfunc bool bpf_tracing_is_exit(void *ctx)
+{
+	/* ctx[-2] is the session flags, and the last bit is is_exit */
+	return ((u64 *)ctx)[-2] & 1;
+}
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(tracing_kfunc_set_ids)
+BTF_ID_FLAGS(func, bpf_tracing_is_exit)
+BTF_KFUNCS_END(tracing_kfunc_set_ids)
+
+static int bpf_tracing_filter(const struct bpf_prog *prog, u32 kfunc_id)
+{
+	if (!btf_id_set8_contains(&tracing_kfunc_set_ids, kfunc_id))
+		return 0;
+
+	if (prog->type != BPF_PROG_TYPE_TRACING ||
+	    prog->expected_attach_type != BPF_TRACE_SESSION)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct btf_kfunc_id_set bpf_tracing_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &tracing_kfunc_set_ids,
+	.filter = bpf_tracing_filter,
+};
+
+static int __init bpf_trace_kfuncs_init(void)
 {
-	return register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	int err = 0;
+
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_KPROBE, &bpf_kprobe_multi_kfunc_set);
+	err = err ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_tracing_kfunc_set);
+
+	return err;
 }
 
-late_initcall(bpf_kprobe_multi_kfuncs_init);
+late_initcall(bpf_trace_kfuncs_init);
 
 typedef int (*copy_fn_t)(void *dst, const void *src, u32 size, struct task_struct *tsk);
 
-- 
2.51.0


