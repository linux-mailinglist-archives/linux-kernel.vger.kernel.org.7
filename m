Return-Path: <linux-kernel+bounces-869911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777BC08FB6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 13:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A471B284B6
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 11:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606F42FABF6;
	Sat, 25 Oct 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ARTykcmD"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6F9299944
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 11:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761392935; cv=none; b=rSF/M13/k45icpuz927VCMGhy8lZYScvsfwcMgZvgSaq1usLZuFZkMByJGZp+c+BNyWP5IMs/dflaD7IvaxceUIMK8+G+jQp8SujvXcrJK1jxT5K6DFHSbm7Y/XQhioTCLriVAu89EB50Xgx+D/hU7lvPej97nwuHaLZOaspF0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761392935; c=relaxed/simple;
	bh=iZVuYfH4hYc+4AR/w/vU3pUxfRCUP+gpgi8JOyxYGgM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G1JB/bn2XFNkzgIwE+ASxhU6rjUSf6J7kHtxcGLcClCrnSBC3J1hQT5gNWAVYC6Rr5qg3IRviwJ/V9PcliWY0Mi/PwcII7QJiiud+FX7aOQcSWpX5eWNMfgK9E1MTcmtVEkISah7FK/py082UclZV/QLy2oV3rbSU5/WYn3gbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ARTykcmD; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so2415374a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 04:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761392930; x=1761997730; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DioyQO1KUrt9ce8a8VHsnwSE6BId+ZKu+DxqxAd87oY=;
        b=ARTykcmDM2FWhnaLKJtAazMtYExLEhpNp8BkVWKaT17IYsmHWf++Mmhxkc2L+Y0ZtQ
         aDh8ItF/yoOyOrueIjh1iISI7494RZbUsdYmxthUUEJkh4ReOfnlWfhgJQa/37DWNVKs
         tnLW4s5dDYJUzKfjZiV1rqeO/8ZuISGNKsRplVLm3TO9qyJDgUk6jiHHoeDUVS34WVz1
         b2MAnrpjZrezNirC/D1CApl8zyDaueXwQ4XAMuj6xCWcRp0du5lX5ZeucrXt+haUXk+L
         lUrsVXuH2VA32/aof6g1Y1WvAQckEx/zUVWSIMWUeTP9orSh5Da3SQueNBGo35teK4t4
         C1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761392930; x=1761997730;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DioyQO1KUrt9ce8a8VHsnwSE6BId+ZKu+DxqxAd87oY=;
        b=eS6fr0wUM+ky4VgKDFQMea7clu36dXlG/KDwIHDqci3Q1bW3j5VNc9fCC/oRAWQzfX
         5opb8YsnnKgjM7uGqqOJ+Z4oVsepY0V7fOUa0p5u58wLMN16FhJCfW8NEzR9551l3Myc
         tyIGThH6wjZyPKcsx4Rps3DBkFIbjvXLfkVlTboSPkvro9Tj0v/U6u48FUGwVTL98TkK
         lfM4cF29UUwlgb+z4omPSUrWnuqPd/z36hsPguen/oY9Q7ogipsw3oGbl3UtxcNguiax
         knWUcKZsIbgSG6SG+DeefAi/AyKR2BE9YeeGvd16a/anhzd0sxuPQZNyc+h0xagd8q8M
         qNcA==
X-Forwarded-Encrypted: i=1; AJvYcCUBuDv0Sa4s4id/M2DdiNWzZhNXL4xMspw+sDj68CJmlG4Dw+0Z4eO1GLD9g7RBXt798Tz6mG4g/w8Ae+k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBH6tSy9C/J6DXbLqaKHQpgf0F1U1Jg/JoZ9NWOh4v8KIG6gOK
	dMm4vnYMS38NgxkFhurSlGhFGNhAJramz8KO+kUedgLRVNAxgP3vWxav
X-Gm-Gg: ASbGncsa9W2AU1zSSUWbxlN6fIYfEdAiKTrhTq3mj2SEeZK1uvf4t5sHEZzEUmm4eoz
	A47Zvi7PC83W5wZ4zs4V8hDGLSlw4d7F3JEt+6UArKs0N4NWDetGq+O4a9JmW6KbAx99xvPCFVI
	u5qr/Rd+R79r7Buu3YyMDWUG9IvwkFZu3qzwhAPdNTXnW9i0YtEtb8+wzgs3ek3NBZNPPNCUgrI
	fAh75LUUA4IJii0iHjAA9YYsjJPK/NW7bDE37RE5ahGomXAkQ6z7uxNm7NVQmR5udpQKH+zZtpH
	Ov4KkPzzW4huwyp+3GGjT5g3aUyROBpHi9mR7zAWIP9u0H7HerzZ3Xre/Afi+P/MT8qByGRBej5
	FPyBKB5dw42cArPRPHnVWYSj6Kkdb9ICqijRpox1aFyvKWUP02rbTA8mA3JegWUVptIPkNFNrGb
	HkUx+ueg==
X-Google-Smtp-Source: AGHT+IE1x6dAP86rdq/1HQbLjt9/tlVbBoHhQxU5//+sAmyIaFIB+kdfNhT0erCBU2THkUsG6QlDQg==
X-Received: by 2002:a17:902:e543:b0:267:99bf:6724 with SMTP id d9443c01a7336-290caf830f9mr448001235ad.31.1761392929839;
        Sat, 25 Oct 2025 04:48:49 -0700 (PDT)
Received: from fedora ([27.63.19.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d40a7esm21635515ad.70.2025.10.25.04.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 04:48:49 -0700 (PDT)
From: Shi Hao <i.shihao.999@gmail.com>
To: tglx@linutronix.de
Cc: mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	reinette.chatre@intel.com,
	david.kaplan@amd.com,
	james.morse@arm.com,
	linux-kernel@vger.kernel.org,
	Shi Hao <i.shihao.999@gmail.com>
Subject: [PATCH] x86 :kernel :rethook: fix possbile memory corruption
Date: Sat, 25 Oct 2025 17:18:30 +0530
Message-ID: <20251025114830.295042-1-i.shihao.999@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Smatch reported potential memory corruption in rethook
arch_rethook_trampoline_callback() function.

The warning points to a potential memory corruption in function
arch_rethook_trampoline_callback where struct pt_regs *regs->ss was
being casted to *(unsigned long*) although it is working fine with
architecture x86_64 however it may not work with x86_32 since it is
casting regs->ss to unsigned long. Its comment says it is copying
regs->flag into ss but i don't understand why it is copying it to
a unsigned short which is corrupting memory on 32 bit arch.

Regarding this i needed some advice on finding its solution
because if we need to copy all bytes of flags we need 4 or
8 byte memory but regs->ss is only 2 bytes which is not storing all bytes
of flags in 32 bit arch and also on 64 byte arch it is just relying
on cpu alignment for storing the flags which is also werid so,
far i just added some if def condition so that it only copies 2bytes
if the architecture is 32 bit and cast to unsigned long if it is 64
bit arch.

Signed-off-by: Shi Hao <i.shihao.999@gmail.com>
---
 arch/x86/kernel/rethook.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/rethook.c b/arch/x86/kernel/rethook.c
index 8a1c0111ae79..5f6ecd6deb4a 100644
--- a/arch/x86/kernel/rethook.c
+++ b/arch/x86/kernel/rethook.c
@@ -89,8 +89,13 @@ __used __visible void arch_rethook_trampoline_callback(struct pt_regs *regs)
 	 * Copy FLAGS to 'pt_regs::ss' so that arch_rethook_trapmoline()
 	 * can do RET right after POPF.
 	 */
+#ifdef CONFIG_X86_32
+	regs->ss = (unsigned short)regs->flags;
+#else
 	*(unsigned long *)&regs->ss = regs->flags;
+#endif
 }
+
 NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);

 /*
--
2.51.0


