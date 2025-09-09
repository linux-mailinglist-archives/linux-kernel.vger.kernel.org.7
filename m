Return-Path: <linux-kernel+bounces-808981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2429B50717
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F3F1C65D8C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D3D36932B;
	Tue,  9 Sep 2025 20:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KcckoLpY"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DF436299D
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449726; cv=none; b=L6DvFelEy5o0B7WZSQZA0GfAS47GSoSPvBFlZu1xWi+25N5/aJp0wvkscBijP7WSj364QNiATTlCqnW+xeiQlwYjd+TxrLckSZ8Nfeg2T43d9FU4SlCS99AfK0ieI5BEoGHJlaZQlo46KWpmK8lxuFRCtZI9/0fKvcZUBn2LIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449726; c=relaxed/simple;
	bh=vtdJbK7wreG5s5RioxYrcTeNIZaeOWo9M19O9uJimxs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T4PVwZO692oArdMn1Fg5aY63zXAOus7yA2cIPoeNDyrbucx+FYvoef3IdyEAnxppFwjrHmGjg43bqJHNqDdidVAyFLxgmYCoS2rexSFWmDtz+FtnqKJ7KRk+sz/J1xuNHKjy0TCeWCbs0AJT02tE5vYN8690IDxZqokyIMKMtmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KcckoLpY; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b52047b3f21so2991948a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757449724; x=1758054524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=CMiFM11/UgOTiqujCsfr58bBaclwwZCG3bf7Rw+V6nY=;
        b=KcckoLpYDUPBtj1YzWWlCH2w03HGbPWxrGwAWPZRQPaw/AYeEY6SwdzPC+VneTyAPF
         lp/QVrbHRNflioj3BsppEVwieBc6vL0DMXu0ebS2wp9HFf2CsnJiqVoKCoL7Uu+Qowu/
         I2wInPl8IFQux3XoyQN4S7bmgnIOgxb5Pc+epMIHKVyqP2DdMNyi+TNidvckf7eafXJ9
         /0KDc/oAMPJVaiLzrq/gfpT5GJA/YbE+yqPWAirr7NrnMlYVQAMfQefiWf2F6ykyJRc3
         UuhiVSEeD4HBDHDdnz5qMgBFh1ibDg/7IjwzkexVhkK4askRtGrAqiwXxTJMXVOn8/6y
         5WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449724; x=1758054524;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CMiFM11/UgOTiqujCsfr58bBaclwwZCG3bf7Rw+V6nY=;
        b=KMQIt7WAH/o3wmW+d/WIdxQGzmOY17eQRzTBeEgj04u2nholZvfb3jqxG9g+GvJ8FZ
         5uzGj0Dj2WEgYZxGc/HijHew53VlPJt5Q6CZQ1TQV27MZIifXVhvf7rbeEWy1HzhRY3P
         1xo5y5p/MT5ezzBYKmrnmRetyZMuow0OnKYAZlJGN87Y+kw1D3troPx2bvPgdx+h/3mc
         UqkK9CZQTX0UJFx9LBzqygFmZHT+C8jLKWGCZP96YSlbAjbjfkGPqhWkUX88rYg2IMVQ
         fQYrjCrK7+5xnoxjON6aEKd2PBGPBdLNY7Mw02ncjnIplp6Jk7uM+qhuZE3Av1q1Dwcn
         NAMA==
X-Forwarded-Encrypted: i=1; AJvYcCW+fcw0fZJs5Nmhkzn6tO2NabxRbHF8xnULq+AoNx4bGQb9mj23aBXaZ/2ljBhyApvv60X02gnTYJy+fZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6XuecwPHyZQXWSpt9etOXlRVbLjdljx+S34x2C++cwlB4h0c
	GAMXuss5gcDw7meLGLrz5aynydMwraNW+VG38IpCgUVy+F+8F9bG3XZTalLMVstudtKLKMsYtSb
	4XWk9TQ==
X-Google-Smtp-Source: AGHT+IGtmVKP/LwQkTqqYTi72JKKi44xEFgNIfHXbNe2MHRDjv1vB5/IxJ0ew/FNcnhQLmQE78maXbxcXAk=
X-Received: from pjx15.prod.google.com ([2002:a17:90b:568f:b0:329:7040:8862])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f78f:b0:240:3eb9:5363
 with SMTP id d9443c01a7336-2516e69aedamr155274045ad.27.1757449723965; Tue, 09
 Sep 2025 13:28:43 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Tue,  9 Sep 2025 13:28:34 -0700
In-Reply-To: <20250909202835.333554-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909202835.333554-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <20250909202835.333554-4-seanjc@google.com>
Subject: [PATCH 3/4] KVM: selftests: Dedup the gnarly constraints of the
 fastops tests (more macros!)
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a fastop() macro along with macros to define its required constraints,
and use the macros to dedup the innermost guts of the fastop testcases.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../testing/selftests/kvm/x86/fastops_test.c  | 36 +++++++++----------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/fastops_test.c b/tools/testing/selftests/kvm/x86/fastops_test.c
index 6c9a2dbf6365..26a381c8303a 100644
--- a/tools/testing/selftests/kvm/x86/fastops_test.c
+++ b/tools/testing/selftests/kvm/x86/fastops_test.c
@@ -8,14 +8,20 @@
  * to set RFLAGS.CF based on whether or not the input is even or odd, so that
  * instructions like ADC and SBB are deterministic.
  */
+#define fastop(__insn)									\
+	"bt $0, %[bt_val]\n\t"								\
+	__insn "\n\t"									\
+	"pushfq\n\t"									\
+	"pop %[flags]\n\t"
+
+#define flags_constraint(flags_val) [flags]"=r"(flags_val)
+#define bt_constraint(__bt_val) [bt_val]"rm"((uint32_t)__bt_val)
+
 #define guest_execute_fastop_1(FEP, insn, __val, __flags)				\
 ({											\
-	__asm__ __volatile__("bt $0, %[ro_val]\n\t"					\
-			     FEP insn " %[val]\n\t"					\
-			     "pushfq\n\t"						\
-			     "pop %[flags]\n\t"						\
-			     : [val]"+r"(__val), [flags]"=r"(__flags)			\
-			     : [ro_val]"rm"((uint32_t)__val)				\
+	__asm__ __volatile__(fastop(FEP insn " %[val]")					\
+			     : [val]"+r"(__val), flags_constraint(__flags)		\
+			     : bt_constraint(__val)					\
 			     : "cc", "memory");						\
 })
 
@@ -37,12 +43,9 @@
 
 #define guest_execute_fastop_2(FEP, insn, __input, __output, __flags)			\
 ({											\
-	__asm__ __volatile__("bt $0, %[ro_val]\n\t"					\
-			     FEP insn " %[input], %[output]\n\t"			\
-			     "pushfq\n\t"						\
-			     "pop %[flags]\n\t"						\
-			     : [output]"+r"(__output), [flags]"=r"(__flags)		\
-			     : [input]"r"(__input), [ro_val]"rm"((uint32_t)__output)	\
+	__asm__ __volatile__(fastop(FEP insn " %[input], %[output]")			\
+			     : [output]"+r"(__output), flags_constraint(__flags)	\
+			     : [input]"r"(__input), bt_constraint(__output)		\
 			     : "cc", "memory");						\
 })
 
@@ -65,12 +68,9 @@
 
 #define guest_execute_fastop_cl(FEP, insn, __shift, __output, __flags)			\
 ({											\
-	__asm__ __volatile__("bt $0, %[ro_val]\n\t"					\
-			     FEP insn " %%cl, %[output]\n\t"				\
-			     "pushfq\n\t"						\
-			     "pop %[flags]\n\t"						\
-			     : [output]"+r"(__output), [flags]"=r"(__flags)		\
-			     : "c"(__shift), [ro_val]"rm"((uint32_t)__output)		\
+	__asm__ __volatile__(fastop(FEP insn " %%cl, %[output]")			\
+			     : [output]"+r"(__output), flags_constraint(__flags)	\
+			     : "c"(__shift), bt_constraint(__output)			\
 			     : "cc", "memory");						\
 })
 
-- 
2.51.0.384.g4c02a37b29-goog


