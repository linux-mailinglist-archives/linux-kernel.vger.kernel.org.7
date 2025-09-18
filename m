Return-Path: <linux-kernel+bounces-808453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A51B4FFEA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7C241C622A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B4033A038;
	Tue,  9 Sep 2025 14:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ON4/x6p0"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEA2246788
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429204; cv=none; b=mDwEbfq7aq4wDfuvJ1JDe+gr5x4mP5+0iBTSGYN5+5qacFer4zOyH67veQgg7mHbsbEBfp3MjIGo6iLv3GUX8YWbJ9PAOtWcWIL0OWuhoYXvht13LeNfDnZive2BfmjMjO9Un/+EwlnCya9PXqBUxhfzp5AGag7aereLp7wj9Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429204; c=relaxed/simple;
	bh=UXg5y5nRxU1xuDGf6sUZCzfUjCUNgl/58lk8M+sKVZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkRwppOT0WOGI2/Ubth+vBejcutkoGPxA8zIYq01geGrXIuuhTlFJZrrkKLuCpVze1JvCzo+cXfZMItHC9qS12kxhzO/imEcMQFt1qbkiVG8NkdI/bdyksL5H8AXliVTeSwc9S9HOX/tYU/oc4U2o9yQVoX9ZOikn+BbiKH27/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ON4/x6p0; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757429199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bEj252Ht5RukI33VtFC/cLaIYPiHcqJ+mofdS5sPP50=;
	b=ON4/x6p0To0bRwDEwDQm7FuXrIKf5G2T3x+wId3pCp0JwPrezdPHTCkGAzJzuOAFPbR4QU
	ETfFDSEKMwgNgvNumMV/5t6UsaW9uaFYT+1T682SmkVmK0dcMZ4EWHW2Dvz9RWp3eXO2Gb
	zQV6TBVQv4u4tsdwPbAkkbyf+ggoTUM=
From: KaFai Wan <kafai.wan@linux.dev>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mrpre@163.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: KaFai Wan <kafai.wan@linux.dev>,
	Felix Fietkau <nbd@nbd.name>
Subject: [PATCH bpf v3 1/1] bpf: Allow fall back to interpreter for programs with stack size <= 512
Date: Tue,  9 Sep 2025 22:46:14 +0800
Message-ID: <20250909144614.2991253-1-kafai.wan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

OpenWRT users reported regression on ARMv6 devices after updating to latest
HEAD, where tcpdump filter:

tcpdump "not ether host 3c37121a2b3c and not ether host 184ecbca2a3a \
and not ether host 14130b4d3f47 and not ether host f0f61cf440b7 \
and not ether host a84b4dedf471 and not ether host d022be17e1d7 \
and not ether host 5c497967208b and not ether host 706655784d5b"

fails with warning: "Kernel filter failed: No error information"
when using config:
 # CONFIG_BPF_JIT_ALWAYS_ON is not set
 CONFIG_BPF_JIT_DEFAULT_ON=y

The issue arises because commits:
1. "bpf: Fix array bounds error with may_goto" changed default runtime to
   __bpf_prog_ret0_warn when jit_requested = 1
2. "bpf: Avoid __bpf_prog_ret0_warn when jit fails" returns error when
   jit_requested = 1 but jit fails

This change restores interpreter fallback capability for BPF programs with
stack size <= 512 bytes when jit fails.

Reported-by: Felix Fietkau <nbd@nbd.name>
Closes: https://lore.kernel.org/bpf/2e267b4b-0540-45d8-9310-e127bf95fc63@nbd.name/
Fixes: 6ebc5030e0c5 ("bpf: Fix array bounds error with may_goto")
Signed-off-by: KaFai Wan <kafai.wan@linux.dev>
---
changes:
v3:
- Remove the selftest (Puranjay and Eduard)

v2:
- Addressed comments from Alexei
- Add selftest
 https://lore.kernel.org/all/20250813152958.3107403-1-kafai.wan@linux.dev/

v1:
 https://lore.kernel.org/all/20250805115513.4018532-1-kafai.wan@linux.dev/
---
 kernel/bpf/core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index f8ac77d08ca7..e4568d44e827 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2366,8 +2366,7 @@ static unsigned int __bpf_prog_ret0_warn(const void *ctx,
 					 const struct bpf_insn *insn)
 {
 	/* If this handler ever gets executed, then BPF_JIT_ALWAYS_ON
-	 * is not working properly, or interpreter is being used when
-	 * prog->jit_requested is not 0, so warn about it!
+	 * is not working properly, so warn about it!
 	 */
 	WARN_ON_ONCE(1);
 	return 0;
@@ -2468,8 +2467,9 @@ static int bpf_check_tail_call(const struct bpf_prog *fp)
 	return ret;
 }
 
-static void bpf_prog_select_func(struct bpf_prog *fp)
+static bool bpf_prog_select_interpreter(struct bpf_prog *fp)
 {
+	bool select_interpreter = false;
 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
 	u32 stack_depth = max_t(u32, fp->aux->stack_depth, 1);
 	u32 idx = (round_up(stack_depth, 32) / 32) - 1;
@@ -2478,15 +2478,16 @@ static void bpf_prog_select_func(struct bpf_prog *fp)
 	 * But for non-JITed programs, we don't need bpf_func, so no bounds
 	 * check needed.
 	 */
-	if (!fp->jit_requested &&
-	    !WARN_ON_ONCE(idx >= ARRAY_SIZE(interpreters))) {
+	if (idx < ARRAY_SIZE(interpreters)) {
 		fp->bpf_func = interpreters[idx];
+		select_interpreter = true;
 	} else {
 		fp->bpf_func = __bpf_prog_ret0_warn;
 	}
 #else
 	fp->bpf_func = __bpf_prog_ret0_warn;
 #endif
+	return select_interpreter;
 }
 
 /**
@@ -2505,7 +2506,7 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	/* In case of BPF to BPF calls, verifier did all the prep
 	 * work with regards to JITing, etc.
 	 */
-	bool jit_needed = fp->jit_requested;
+	bool jit_needed = false;
 
 	if (fp->bpf_func)
 		goto finalize;
@@ -2514,7 +2515,8 @@ struct bpf_prog *bpf_prog_select_runtime(struct bpf_prog *fp, int *err)
 	    bpf_prog_has_kfunc_call(fp))
 		jit_needed = true;
 
-	bpf_prog_select_func(fp);
+	if (!bpf_prog_select_interpreter(fp))
+		jit_needed = true;
 
 	/* eBPF JITs can rewrite the program in case constant
 	 * blinding is active. However, in case of error during
-- 
2.43.0


