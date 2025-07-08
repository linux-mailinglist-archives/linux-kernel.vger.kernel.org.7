Return-Path: <linux-kernel+bounces-721176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF47AFC5CB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C39527A457C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D150A2BDC19;
	Tue,  8 Jul 2025 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JHlCq5M/"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9EF298258
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751963691; cv=none; b=ZFWTSPB2vkdHTI2/eUU+w6Zr5vmjgzFT0O7EqEtcNBZx7Kl+zdNHKKui4PIynKiDpMcGt5HW+P2AuARkzRZrLY/bkBf5PkcJTqNM0rE9Ol69CXwRE2OaaQe7CWI6+p0pfMyfdkYbpdW7Mlq9i5SEtzz+HxwyYp2G7VtURU7yhKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751963691; c=relaxed/simple;
	bh=3Ds2Sx45pnkMg7iaFweDgWNlUOwHGzX5GUkhgeYgbzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=D7A1GXtVLlo03cxWWkgQT9HjBYhgV3N/a8vKISuOVOgZ0GKRdqvJHn9Nv0mGLyxYWVB1HCqXTnNvwyxumAPsMq/pBbgTEMx+Vrk5/LysmOkhLLlnLDiUR2Fq2E2h0CyaZR9E8e6L0hCheWQgY8UWofX0LsLrbyKl2yToSrcVibA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JHlCq5M/; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74264d1832eso4864547b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 01:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1751963688; x=1752568488; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=km9alGI0XcL6Qvzjzja6icFIdbRKvCumIapJv3kvhgI=;
        b=JHlCq5M/IYsv507yOK/iTHer+g0MTpws79Wg84pR4YXLTi3g0xFVEfKBISBY5rXMjD
         LUTIddSIPHdwfK6WO+apj5EZSwotAg50PwzmzH2HSqkzWfrXpT516GTiut7iTpjZRtKL
         l9v4fIxBWQr6Yy4w1SWos/MRMZI96/8cNQmVce61rG7MxAIyopRTY4IezJsITs2viXj9
         KCoEKUBg0p7fBX2H9dL8Q3oyHS87R7nDSBxL5bGquZa2CXHBnXqDPFckMz2lkwcOJ4Ph
         pUoNTPZpoIf12pOtzdV+9teoDqAdU50FMaOwfAkYDEkXl08T45qTToEEhdSVNwx7ZnnU
         YrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751963688; x=1752568488;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=km9alGI0XcL6Qvzjzja6icFIdbRKvCumIapJv3kvhgI=;
        b=ba9aKa2j8A2eXyzKCZHthLIOnph43WopdEVWXjaT5jMsvXikvOQsbSTvWB+gUIS7No
         x5Fa08+yfYvOMK/7+X/tsrUiG2IEvUkPtE1jcUtYAsf6/cb21wTjCB/g0RiSpplQcWvb
         TCtvMZTIHskYvJUVI9dxvmr9zQy/D8SMlvrqUkagkrCCMGmI1Q/rBlLL9R3n2FheYHp+
         h88nc9NONJhZp9DzHQEROm1JBlPpyL7G/BaxmlJ+LTm9HTpRz49SMEZSgXnGfrzOluSP
         K2/pjIMP1tigjBlI5P7JaIrMSeX3FlRK7Yzske7ITuXDaa5TgOW+i3BcpBj1vJPxER/d
         YFNw==
X-Gm-Message-State: AOJu0YxHo5isUUB7mrHYXsmliABV+pPlbR2f5KgHjZRg+N0O0A0Lf09R
	Xtwlm/CY+H/LkPNSdaYuo3ihs10BGqC1nzuVKhS3QwlL5wexvP23V9UQ/ACqf/rW7u8=
X-Gm-Gg: ASbGncvo92zZ8Ir7754RUeLGPip++xDDYKDUx0y/8Y0AHYGvw7uAyfeQnHwR9VzwZp6
	0vwUhgG+DKE2sZ9420gWt/694osc33UFUe5cZhYDejeNU3DlNis+d2HwaPNN+daZ5RkRfgg2GEI
	TB9hPA2/64x7/IcATktMNF8pk2MqBAldDxlRMl0FPHBpwECuE4s6okkFcsK28tBZt61TBCvmsrg
	mGyOJ9h2YRLRJ385/wic5JS1W5q1NghSp7vZwO1LxUDmyBuB6SZLQE3sjLb86mtPIr7NH7R9Dw4
	ZtJNBKqwz/L+doBJsFSY7V61/9iIWdxKgMoOZKyCI2R9cPv73YX5qxuutxMFn4X6M0hfY4gOzAT
	7+bTz4HMhtyncX1wWgBAB6+hhxj1rW+59H4sgh8BxNF7v
X-Google-Smtp-Source: AGHT+IHRcwV/1/T5oymXkbwGRFIYuEsWNfVXVWrzLoP+RWTG54BAK6UpJOoefXueOfXgf20o6DvMKw==
X-Received: by 2002:a05:6a21:7a44:b0:215:efe1:a680 with SMTP id adf61e73a8af0-2260a795654mr20246310637.16.1751963688189;
        Tue, 08 Jul 2025 01:34:48 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d4f1asm10877511b3a.161.2025.07.08.01.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 01:34:47 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Tue, 08 Jul 2025 08:33:48 +0000
Subject: [PATCH] riscv: ftrace: Properly acquire text_mutex to fix a race
 condition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAOzXbGgC/x2LQQqAIBAAvyJ7TlAj1L4SHazWWggLF0II/550H
 GbmBcZMyDCKFzI+xHSlBroTsB4h7ShpawxGmUFZ5WQ4schIBVlqtNov3nkfe2jDnfEXrZ/mWj+
 cWU9oXAAAAA==
X-Change-ID: 20250708-alex-fixes-1e719b9899f3
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Han Gao <rabenda.cn@gmail.com>, 
 Vivian Wang <wangruikang@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2192;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=3Ds2Sx45pnkMg7iaFweDgWNlUOwHGzX5GUkhgeYgbzQ=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJybqi8ChN0klf9crq7b8aPt753f26W6d7Q/lf4XIly/
 tbNVWHHOkpZGMQ4GGTFFFkUzBO6WuzP1s/+c+k9zBxWJpAhDFycAjARhkcM/71fRb1avvPr6cDQ
 57eWZxy+GdJybW8Tt0THf0umRv+l5qsYGe4fuN+4spx9reHpB0yRSob6tk+dHI13b2m5sXtL/ql
 4LV4A
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

As reported by lockdep, some patching was done without acquiring
text_mutex, so there could be a race when mapping the page to patch
since we use the same fixmap entry.

Reported-by: Han Gao <rabenda.cn@gmail.com>
Reported-by: Vivian Wang <wangruikang@iscas.ac.cn>
Reported-by: Yao Zi <ziyao@disroot.org>
Closes: https://lore.kernel.org/linux-riscv/aGODMpq7TGINddzM@pie.lan/
Tested-by: Yao Zi <ziyao@disroot.org>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/ftrace.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4c6c24380cfd9d6c51f0e4340cd674160b83a610..22e7bdf8de2b6ca950cf2c8b734bc82ea46ba8bf 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -14,6 +14,16 @@
 #include <asm/text-patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+void ftrace_arch_code_modify_prepare(void)
+{
+	mutex_lock(&text_mutex);
+}
+
+void ftrace_arch_code_modify_post_process(void)
+{
+	mutex_unlock(&text_mutex);
+}
+
 unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
@@ -29,10 +39,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 
 void arch_ftrace_update_code(int command)
 {
-	mutex_lock(&text_mutex);
 	command |= FTRACE_MAY_SLEEP;
 	ftrace_modify_all_code(command);
-	mutex_unlock(&text_mutex);
 	flush_icache_all();
 }
 
@@ -149,6 +157,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	unsigned int nops[2], offset;
 	int ret;
 
+	guard(mutex)(&text_mutex);
+
 	ret = ftrace_rec_set_nop_ops(rec);
 	if (ret)
 		return ret;
@@ -157,9 +167,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	nops[0] = to_auipc_t0(offset);
 	nops[1] = RISCV_INSN_NOP4;
 
-	mutex_lock(&text_mutex);
 	ret = patch_insn_write((void *)pc, nops, 2 * MCOUNT_INSN_SIZE);
-	mutex_unlock(&text_mutex);
 
 	return ret;
 }

---
base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
change-id: 20250708-alex-fixes-1e719b9899f3

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


