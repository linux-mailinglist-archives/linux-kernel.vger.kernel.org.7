Return-Path: <linux-kernel+bounces-727090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B936B014D9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AAA51C22B67
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 07:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72C11F0985;
	Fri, 11 Jul 2025 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="ARKJ6c//"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4A71EE7A1
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219574; cv=none; b=gxzPtZkp/C/qXQoe+UnfBUbO2laHaSQ2Icid/g2NNwD9ZYcG1s+nbE6Ki2UGbvyppk0Vuw0Js8KNr1tQqmOfSB8pcx+huWinDP7GOCouAW5yP/+xhWyL4fS+wl/3cGzaYTFAi9d5mLUSUFkmqUEfgE8FGPFUlbU02Tv1iQuC/58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219574; c=relaxed/simple;
	bh=rf1z35LuFpIcwwrdg0a0joiQZY/6t6ATU32MYjjFF8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=sXbukpDwvV2t9WkPH6HaP4tV+A81qTCMxBFtis4aXUNgeYoPc7K+yDIClXDUYoMkdY2/pjvovsvCP44Jz6EYbbhamlbTQVqb7qe46EjOBG/Wsc0WuX11Pm4p+EtUqfPHQRQTQRWwDFAh7MfUc+ufRdjalTEIJJVm2Yk3H2igCgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=ARKJ6c//; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-748e378ba4fso2195107b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1752219571; x=1752824371; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=icGySjDU0odmX/U7ekk4ZfpCmBZqh0luwzxQdlarWuA=;
        b=ARKJ6c//CjzeoQ/92tYCq7BbDdqdC/Ho2aToudd9oE/HwdrW6C+edUsKXJgahgmx23
         eiX00QNEoCQnbhow9rsNDO9eJa9NnOdFRCc+0+P6qEZmNf9H8c2CWlANd3f+4udxD10L
         9UaqPMgHUmxCqWAr5OwR02NwjoeiZ69tQIYwUk8/YVb0zF2UhVN5LGwzhsWYLSvHCwsb
         a8eb6nKy1U3yzNJbPwN5DsCJsulicZak8Cp6VbCxvFb/ik6xSwsA/J0rsO0jbcLOULqh
         DymA7jf0Dux4gOjIgw2wHUok2uzlUn08EVSwIJiFMzcpnsoA91AfPZLly7hHgZlzG46K
         xwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752219571; x=1752824371;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icGySjDU0odmX/U7ekk4ZfpCmBZqh0luwzxQdlarWuA=;
        b=Jk8wywW3G2OSNSkb0Uv+drC3+Jmz4rwY5YFaouxdy51zXcxI2ASQdBAMyuUapZUsbk
         KqHbvvF9qh9Tn+kx0W/UcVzscNlj36WNj7Q03ktGvThNwMhBWNUx4NeVg+eIYGkl2OPV
         ly2ED00hEgl/hg22/2F5wuolLrYXNpOjmmJAq5+moblcgVkCFewPw5aj86a3pdqWQLa/
         CyF0ygw7mLZyB2ZFwsYDysKDSIpgrbvN/eIoCSrmDkRs2fuAxQUemyDA7iqvVAtkiynH
         l9Pxznh0fdPFuA4o2tbWZFHyjA8/3HdHfBrT1xoe96wgjUml5kJTLwITnFmLiNEroZT2
         MOJw==
X-Gm-Message-State: AOJu0YwUWwTrrCO6d86dQgez9PzQAnE+G8fwzmvhoW9c+aN+UFCs0eOV
	sIJ11l1ch2yTasSSK80OVSfS3LkP+B3xUo6oAHOlaztFGXOY0E9odRdBYxwq/+eNWQI=
X-Gm-Gg: ASbGncu86K20X1n2I6Kor1H4YPSppMMVvrwuPixlrEreR1Un4//4XLwj1kMGfv5Lxl3
	waegcgHGDZUK6Ddh5GNaOFPr+x18f/gpoGQYTrgKOae0qZratpqg/goUKdMWsYW1xxwj9b22ldU
	31H+T+Rgep6g5bO7zUNpkBcruV2YvkfX74+JGrb2hrOtziG8gjjbIbWkvvoyHp7nkyUxe2O4nAL
	eahu6AB+opua68MseeSlzFchGf6j1U67ySJHJT+POWj1n05squjBNBR8Xx3RAbywDNQvWNQb9wT
	DQdmwVoIl1VJtBCfjrAVzBWphksA8ljhHmo2JsdWHoP6VxssEBmQrySolMFDcyKYUpn5un7dGW+
	TqIrF1BzczUbMxTkWc0IRk/tQUVg3tqBh5mQjBJ131wtr28LANkjxEGr4srl4zsNzJScEWg==
X-Google-Smtp-Source: AGHT+IGAD1oYswz2b5g5yjNWYTA4pStllZFKTjpeoy3Rj2V0QGXl8jH1O0ZouUKD9usbWZFWXN0Etg==
X-Received: by 2002:a05:6a00:1945:b0:746:3040:4da2 with SMTP id d2e1a72fcca58-74ee109a194mr3200497b3a.8.1752219570837;
        Fri, 11 Jul 2025 00:39:30 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4d3fbsm4597588b3a.127.2025.07.11.00.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 00:39:30 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Fri, 11 Jul 2025 07:38:38 +0000
Subject: [PATCH v2] riscv: ftrace: Properly acquire text_mutex to fix a
 race condition
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-alex-fixes-v2-1-d85a5438da6c@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAH2/cGgC/22MTQ7CIBBGr9LMWgxQm4Ir72G6aGGwk2hpGENqG
 u4udu3yfT9vB8ZEyHBtdkiYiSkuFfSpATePywMF+cqgpe5kL40Yn7iJQBuyUNgrO1ljbWihHta
 ER1H396HyTPyO6XO4s/qlfzVZCSW6SUrj23Dx0t0S5ci0uLOLLxhKKV/fgXqQpwAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2543;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=rf1z35LuFpIcwwrdg0a0joiQZY/6t6ATU32MYjjFF8g=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDIK9q9TPuVvfPhXjiC3ZHXzlNTb7uesORRlJFdUrX18N
 eLSHhmLjlIWBjEOBlkxRRYF84SuFvuz9bP/XHoPM4eVCWQIAxenAExEOZDhf9W34x+dMxbEXPBd
 z/Rk/cylV0WU3+yKYbIJVpuZW3bNlIHhf6HdJbe7H+98mFR8WEf1CPOP63zPjom77no6efak3D/
 fzNgB
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
Tested-by: Han Gao <rabenda.cn@gmail.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
Changes in v2:
- Add __acquires/__releases annotations (Masami)
- Add TB/RB (Masami, Han)
- Link to v1: https://lore.kernel.org/r/20250708-alex-fixes-v1-1-5b008d3f4d0c@rivosinc.com
---
 arch/riscv/kernel/ftrace.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 4c6c24380cfd9d6c51f0e4340cd674160b83a610..8d18d6727f0fc8fa17d8f651b9e3a00c779cec85 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -14,6 +14,18 @@
 #include <asm/text-patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+void ftrace_arch_code_modify_prepare(void)
+	__acquires(&text_mutex)
+{
+	mutex_lock(&text_mutex);
+}
+
+void ftrace_arch_code_modify_post_process(void)
+	__releases(&text_mutex)
+{
+	mutex_unlock(&text_mutex);
+}
+
 unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS))
@@ -29,10 +41,8 @@ unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
 
 void arch_ftrace_update_code(int command)
 {
-	mutex_lock(&text_mutex);
 	command |= FTRACE_MAY_SLEEP;
 	ftrace_modify_all_code(command);
-	mutex_unlock(&text_mutex);
 	flush_icache_all();
 }
 
@@ -149,6 +159,8 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	unsigned int nops[2], offset;
 	int ret;
 
+	guard(mutex)(&text_mutex);
+
 	ret = ftrace_rec_set_nop_ops(rec);
 	if (ret)
 		return ret;
@@ -157,9 +169,7 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
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


