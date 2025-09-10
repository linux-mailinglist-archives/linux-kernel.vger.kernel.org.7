Return-Path: <linux-kernel+bounces-809852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C6B512CD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 11:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE974189B544
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF506314A64;
	Wed, 10 Sep 2025 09:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QNhEv9vG"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839643148D6
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757497219; cv=none; b=ZW7tACmwATQvOqoDhBg0nbaRhbITEeopIN/dhBiSFWOVKsr6vT9mPVHC6/0r8K1tV9p59W9A+7LN59uYandT/wQd+XX9rc8ACpbLyKNOEabYuXdEMTqcJbYekcxeoth8wPXH15BePYHhQ9ErqcGCIowlXTnKA9ePlzlZ3ZX9pIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757497219; c=relaxed/simple;
	bh=yy/j27wt5j3Fq7s1cLfzdClECpaEYo3uX0UvHw3cPvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCpWX7NgMYoDF/k+VkXiJEXyWZ528A5ucF/OXRDdJi3P+WUzih2D0c79s7LriYmhoxNM5zkQwGwBDLbwt10Juk5U6Geqjebyta/kSpHScIzCf8TdK2xGVWMtuI92uxnKILaBRzoYtpp8Hy+8PlBC9GL2Df7gyWutKMYYf6ZI+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QNhEv9vG; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77238cb3cbbso6939536b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757497217; x=1758102017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w+pqYMSs4N866RiVb5rwqnQGAKdcJ5TNLGW1E9wVfcs=;
        b=QNhEv9vGbsWlry+HULqmzrefnvaeBqF5pjPs4XWpztzL0OmeaaxiPCQ0EjfFLpCeKZ
         7ZdJY5fRTjNUnbo2KsS+25I1qg5RzKW1pIgbJhpr2eKsfrnwR/IFjwnihGCrz/9Rwejm
         Zrb/3ZJwdzZFwD/1MQpFqRxN2JOkduzgijQuzTnq7H36zHzkDxCVHQbHIlrb5waNVPaZ
         kPflySnCIpMPEn0Ww8aynJrw3yFp053UI3AVf0o0LZlo7NA8MgdzKJGueeZ3MIZPPJMy
         HYgyqaB0x/R3Q84hv4uB8u6gPlVobggm9c+ygscQTGyjbnpYxLYvebjUSCqNRnIis0tT
         fqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757497217; x=1758102017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+pqYMSs4N866RiVb5rwqnQGAKdcJ5TNLGW1E9wVfcs=;
        b=heDHzl2Vq0jbge7jD5xIanI+L1bXBe1A1R7Fp36HsXmshGcacgWkLa1+rroB23wquv
         /qND6VyVxq/+B3wAoj89pNgarQZclFUz+LUYum/XfkcNJQ0NzayhYwypkoatYLvYD3QZ
         tGrmgcRsgdyjgiRKm9/CAhGL4F4hFwQm0AtxA0zRH/c0P9EYNudritYiUluiqJpUrUQv
         JeghAxX3d0yNFsqzV+ek2de3LsWFwcSFtVL1Wa1gHnUns3mXcGXE6P0Wsl/SZ0ZzceJO
         z/E26N2raaxuG7yyu98gfVfKBsTmMIJZ6s2ifNDOkc7zYVaQduBJjUgm42br9G68Lo9z
         kysg==
X-Gm-Message-State: AOJu0YzHqneNcuvj/RuAJG7bAJcx2weJ+bKXXTZSkKuGraZXFdrZ4ESj
	dN+qcn5lws65s9Y1lPlhqwpiCrQlmnz2gvB5IAUiTvQzvFT2BroouaJW
X-Gm-Gg: ASbGncs+927wZhqiT3NCxfeHWl3AdobLZV7vVpCl4aUDkGASqXoLFJu6B/F5LRNxckw
	EjmKb8Ca++pS4032oXoqn5idrMpTsoVpSc7HNRv/wZq7do5HeVtkLwT5vKTUBx/kEmjiz1AyhBY
	grLYR8q76QyiZdXKSaCkW/m2jdBQkrpV6qqWywqr02LnTuICU3XRnX03ieZ/0YR56Bop6A/Mp+1
	nT/x8YCDblRhRACEC6PHiaVhtb9KKJbfScVxc6/mdI2KWP0fQLZHqQQjOkQzkEP3s6yIPr6bjCS
	1M/GfgtNsO90FgKWu7Y7iFGLUOWW64ATRSsswTLGJ1O2Xf03h7WS7rjK3GD7Wv1pZSI3jZByoOX
	GH+GkjlfSi2hpYj8+c6MiP6q5Vy4L5N6eMiT6U8+jMw==
X-Google-Smtp-Source: AGHT+IFxfQUSufnf2d7W8iscIoRArB05v+1dzzXcxPwXldgH/JEANowOrxpEypKXQr1aQ5aJb26uVQ==
X-Received: by 2002:a05:6a21:3397:b0:248:4d59:93e6 with SMTP id adf61e73a8af0-2533fab2204mr20066016637.19.1757497216729;
        Wed, 10 Sep 2025 02:40:16 -0700 (PDT)
Received: from localhost ([103.121.208.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77466121eaesm4507087b3a.25.2025.09.10.02.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 02:40:16 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jinchao Wang <wangjinchao600@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Wed, 10 Sep 2025 17:39:35 +0800
Message-ID: <20250910093951.1330637-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910093951.1330637-1-wangjinchao600@gmail.com>
References: <20250910093951.1330637-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new `arch_reinstall_hw_breakpoint` function can be used in an
atomic context, unlike the more expensive free and re-allocation path.

This patch adds `BP_SLOT_ACTION_REINSTALL` to the `enum` and updates the
`manage_bp_slot` helper to correctly handle the action. This allows
callers to efficiently re-establish an existing breakpoint.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |  2 ++
 arch/x86/kernel/hw_breakpoint.c      | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index bd437a30dbf2..d1cc6db8a59f 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -20,6 +20,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -64,6 +65,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 1736063a82b7..99223695cee8 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -94,6 +94,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -192,6 +196,23 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+/*
+ * Reinstall a hardware breakpoint on the current CPU.
+ *
+ * This function is used to re-establish a perf counter hardware breakpoint.
+ * It finds the debug address register slot previously allocated for the
+ * breakpoint and re-enables it by writing the address to the debug register
+ * and setting the corresponding bits in the debug control register (DR7).
+ *
+ * It is expected that the breakpoint's event context lock is already held
+ * and interrupts are disabled, ensuring atomicity and safety from other
+ * event handlers.
+ */
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *
-- 
2.43.0


