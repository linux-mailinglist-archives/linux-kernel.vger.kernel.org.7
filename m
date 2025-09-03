Return-Path: <linux-kernel+bounces-799348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC78B42A55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D6741B26CB7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE436999A;
	Wed,  3 Sep 2025 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="BFDPE4K8"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6E8369976
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 19:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756929302; cv=none; b=t9Q7DXEIHYQEpJt3nyWh8PD1qLGaFgfxxMwfXwo9rGLaSZuPbRkU/U+XQbhq0lI7jxMIBehZ4B52JtxidCansuqpPS3yIENAO7966++mJttB2MfXAF4e2nZRnL+nILCb70p0LEoio4qMVDS06pVal+i7bEmcG+1uWarwnDdjko0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756929302; c=relaxed/simple;
	bh=ep2ByU6Sp3PUGleU/SkPJKB1vnJZEKwUxxPzvfc2zHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z4sYUBKsDnl0WiEZYjuDuzYpI9W3kg2Menk6K8oQn+CVIk+qc3L4VkloAWF3xxc3PhP0sQparPMsGVrYOkakUegzYu/5xCDqtZU3gPzkqR4IKee8ogLfIsMmPweiGTNspowAc0yWSlcYXwx4MID/ApmLHGLzj5bd33ikR5ySqzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=BFDPE4K8; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45b804ed966so477935e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 12:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1756929298; x=1757534098; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WemNBSJgvSeExxk4SwgXWO6xPmX/LP/uVncZJ5kxq9E=;
        b=BFDPE4K8xVUXXC8Gx2hbOM8zU5TTPFUdWYAptHTWz8Yvrch7OX2kghUo/PgBAuvG2q
         8SAAXklVb3rFhxrdsTlbuNoJVVfsIiho5owfVQCvBtbcJtvO/3357YX3rMv5DvHPaIKk
         foVdKDLhYlhggvLi3pn9mn4b+aE6ZwZwpL8AX6PByewzQRyCiO7IirTDm8ZieRYirgR7
         muQ4iK/baLbsZyt9PVSr9fGneYgIzMddMrAggJ8uihi6PhmqNxJOIU1gXu9ZTVbNXS6U
         X+yCWVD0QNDeNcSAJajza0MFfJqaNfz1HANKipCzKP5PjgZog7l4P2zK5+GwyktMARuk
         jaRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756929298; x=1757534098;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WemNBSJgvSeExxk4SwgXWO6xPmX/LP/uVncZJ5kxq9E=;
        b=ap20qbUsvDIbBGQpEkQ3XcgjemRylyRoV0tFraOKtOCeQjGx4tXDnCaYLgSGlRFeKz
         C5KrDcLGNIYrrVxDtTLHDSPGHj1uAG6/d+sK916/W0RKBU/ueOheDf/KI67oDYTEpVF3
         7JrrHUyWyT+Yg+ki87Oe9YWeK7aOkLgVt3Vo2XJZL7ZHWsdWREb7+aZcgGv3aiJ+u8KI
         cK0HS2VI9dxzYDBsN6AR/8gwj9aSUK9RVLBlmbyoJoA/g8nqO0l8bTcwkJBtgPhEd6br
         W6NL5FeG2FfK8O1nxr1OshF7IkmPEKuZfjocZmb/sdsejMI01tnjfehPe6RC4pPYZFWU
         U3ig==
X-Forwarded-Encrypted: i=1; AJvYcCUiNcRps2xbLAljwZGnvtaBeZcoXUdo3HCBfGxrPT0v1OQZTTWm2WOGbOjtWZcn6fv4S8kp8RkruqFmGWI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGQy7pfkPL3OM+dJ1rANvmZ/aqKe+4nLup0umcgbcIErvwX4kQ
	6oYIu9X04mR0FmNSgvXJcWzoH6Gc0mkGy3WQN3H7jHuTws4kdY/r4utLvjvfwoduP+Y=
X-Gm-Gg: ASbGnctpTKVnIVwlIo3eRJOT1pb7OaWlPxrXC0OW71djQjing+DnHRWjer1t41IewIJ
	pZ1kV8Zcg0nolFOLRycpZoeaOfl0/S/F6j0Gj5O7HbstLocBA56RNdbBhHq8bv6a3eiTBqLrG/G
	N9Hfds21EYg3UFMYchwaypYo8bYZOMuPC0+K+voVh5ZfvBoC6Fpak41+ceMBzVr+p08MrYWQkgb
	66Di2KiRLf7H9NDxxUH6J/PPTdN7hbV04iXq6OiEaLscYGXRq8b8MtyoA49j6bEQ0MNNUnyF1Jq
	IReSKi3MdJaLTdx2K6sFkYV+jekIDwID6dwEqR6C1GdDvFuA/b/jwY66eE/Mf9NBaMpqcGBYUWm
	S+zEnd2/7Zt5w/asnAqpPPxkj9X6JA55Gyr/lggmVWUc707KLQ52elnoMMCvGTlm33Pojd7rbCI
	9aSUHw
X-Google-Smtp-Source: AGHT+IFJLqX9lWt48uvYEkJALLRR5ugjPDz4Bm8zdqTvK5mO3zXyFw6a/hUpgKW7TWri5+ZASWKjNQ==
X-Received: by 2002:a05:600c:3153:b0:458:bda4:43df with SMTP id 5b1f17b1804b1-45b85570996mr172993485e9.17.1756929298246;
        Wed, 03 Sep 2025 12:54:58 -0700 (PDT)
Received: from alexghiti.eu.rivosinc.com (alexghiti.eu.rivosinc.com. [141.95.202.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d95df59e50sm9504812f8f.23.2025.09.03.12.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 12:54:57 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
Date: Wed, 03 Sep 2025 19:54:29 +0000
Subject: [PATCH RFC] riscv: Do not handle break traps from kernel as nmi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-dev-alex-break_nmi_v1-v1-1-4a3d81c29598@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAPScuGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNj3ZTUMt3EnNQK3aSi1MTs+LzczPgyQ11T82RTYyPDNONUCwMloN6
 CotS0zAqwudFKQW7OSrG1tQDR4C8EbAAAAA==
X-Change-ID: 20250903-dev-alex-break_nmi_v1-57c5321f3e80
To: Peter Zijlstra <peterz@infradead.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, Guo Ren <guoren@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Alexandre Ghiti <alexghiti@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1916;
 i=alexghiti@rivosinc.com; h=from:subject:message-id;
 bh=ep2ByU6Sp3PUGleU/SkPJKB1vnJZEKwUxxPzvfc2zHY=;
 b=owGbwMvMwCGWYr9pz6TW912Mp9WSGDJ2zOUQju2NeZLt/efBtlSDKNmvc3VLoqScb2v/XMt29
 an+IY39HaUsDGIcDLJiiiwK5gldLfZn62f/ufQeZg4rE8gQBi5OAZhItxPD/zq+v5/fzr6bXrSu
 ZMPx6vftCVu/bNnvsdBf8ceyozc26KUx/M99/HGOKsOcDa2nZq0prmblyUi9l8nxo1j6aJNWYvK
 bZi4A
X-Developer-Key: i=alexghiti@rivosinc.com; a=openpgp;
 fpr=DC049C97114ED82152FE79A783E4BA75438E93E3

kprobe has been broken on riscv for quite some time. There is an attempt
[1] to fix that which actually works. This patch works because it enables
ARCH_HAVE_NMI_SAFE_CMPXCHG and that makes the ring buffer allocation
succeed when handling a kprobe because we handle *all* kprobes in nmi
context. We do so because Peter advised us to treat all kernel traps as
nmi [2].

But that does not seem right for kprobe handling, so instead, treat
break traps from kernel as non-nmi.

Link: https://lore.kernel.org/linux-riscv/20250711090443.1688404-1-pulehui@huaweicloud.com/ [1]
Link: https://lore.kernel.org/linux-riscv/20250422094419.GC14170@noisy.programming.kicks-ass.net/ [2]
Fixes: f0bddf50586d ("riscv: entry: Convert to generic entry")
Cc: stable@vger.kernel.org
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
This is clearly an RFC and this is likely not the right way to go, it is
just a way to trigger a discussion about if handling kprobes in an nmi 
context is the right way or not.
---
 arch/riscv/kernel/traps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
index 80230de167def3c33db5bc190347ec5f87dbb6e3..90f36bb9b12d4ba0db0f084f87899156e3c7dc6f 100644
--- a/arch/riscv/kernel/traps.c
+++ b/arch/riscv/kernel/traps.c
@@ -315,11 +315,11 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
 		local_irq_disable();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		irqentry_state_t state = irqentry_nmi_enter(regs);
+		irqentry_state_t state = irqentry_enter(regs);
 
 		handle_break(regs);
 
-		irqentry_nmi_exit(regs, state);
+		irqentry_exit(regs, state);
 	}
 }
 

---
base-commit: ae9a687664d965b13eeab276111b2f97dd02e090
change-id: 20250903-dev-alex-break_nmi_v1-57c5321f3e80

Best regards,
-- 
Alexandre Ghiti <alexghiti@rivosinc.com>


