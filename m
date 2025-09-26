Return-Path: <linux-kernel+bounces-834517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C61BA4D91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6397BC3FC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F4230E856;
	Fri, 26 Sep 2025 18:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="EsJCKjw+"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FD130C626
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758910127; cv=none; b=LvFz1wZPO1VcyV4k6Brull9B7q25tM4ci0DWfabN0JMuKVAj/wnfpZ8Dd9mzo4bLLUGA/Z+smvNgSDrKntKeAuR9ZLAzNxpJJiftq8UbLB7HoKRvgFXqtWpTqtGDeoAdArmjq6Omi1kHCIL6Cb4cERfU+I1dMHwADJ9rtLikAHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758910127; c=relaxed/simple;
	bh=yQ6uxULy2wt26h1V0g5CV/+7PMYoWAfUMXHtEfBFNok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PheI1nFqjw7sxpmQXkgsETGYFNbY4+xHkkcoPmuyqstkq23H9xp7qBEF6dSgRVosnnO5cSI1O+HoJUKAI48Th8f/VM7KeKYYPnKGm4UEHPHC6Juq2CCUJ5cQIqy2bLkAndQZOUTyx2lLMFifj3LTrN/+e8OMAH8T/GjaqT+NxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=EsJCKjw+; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-63483420e3dso440042a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 11:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758910124; x=1759514924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A/O4vMHBPDM1vxmT0wJASM1D4z5xiXlF5sqaZaCau4w=;
        b=EsJCKjw+l4NSMSXcRP2TeLxQwm/BO4XOBP+KoE+YaaLFc/YVTUKv/T5xNLHzwRpcCs
         clFD7bbsKMcy/IjD5adc4ALYUvWXblUONcwMHIBvYnqaVFsY10CGKOBlpx7G1Y+NsZCO
         CXGjdW9qTiKIscsQHP/3w/8Gfq9V7ZmQil0SoJjd0h0jzYfsB3b88TqMJv886gPFchwq
         KCIc3m5fFlnxTjpUIFXDjYlojcGUJBDdjkFwXPKzITrcYrZ8oU1htz+udh+ZUXqrKFEY
         Kgmm0TOz6cU0FM8oF3t/pT+rBgKccaGbgBqdRntLGZULun+5G7SIuS+HdKecyvTC0h5c
         k9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758910124; x=1759514924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A/O4vMHBPDM1vxmT0wJASM1D4z5xiXlF5sqaZaCau4w=;
        b=jqvv/CLTAHC/H9+Ojfq60sMHuHMUF/WP8mfHtroOCwzMQwRydR8v9Vm3VElfqqviqC
         n876ccc9VBuupmLyBGPy2IclRK8e78pkMBqSvHVJxK1nYComvgVSIXz0wbYx4Tp4GouF
         KZuu5oP0fSvl/DlOjQHQm/2yv1DF38/jy5UusTl0PdXpzOVwt/6ih0TH5kZFizT81EvX
         HBuxMqdMr1q6KlIf9ZfA1BidjG2AjB/qKRFzcWy6Ri0cdzBUxEJcTozUH/hvjKCRRNMo
         TgBVRMwyhZKQbe5L8GbvtJJORNHlznBslbkjDlezQ3IHJHNbHPkAZEzS3XAgxpXIpk8/
         rvTQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6bHwhzJrIKxMtElSxAPn8ne07lnCg2F7PpaYNj0ccrvByp+J+6A8TMni6IA3hAs0RcWuYQ0DcZ/1ItyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypcl/kMTDr9ubxPsop/7cxFzK4VSRSvUIE6KeuJP2owTTPwZqr
	E4jT46xXAnPY8tMGfYcH/4KgfCsZlu+QjszdGgoHuPUzf+yiXNLfH9qIVsCZaQW1Xrc=
X-Gm-Gg: ASbGncsmHmlGRyiwl1CNfsoNZwO0XWChMvBdqRAVJMwhc4cubms1Cu3Hv2Bom3KRN8H
	SjLNxFxvwPlEfTD48HUy+t+pw5OGAOdAMNv8PBtGnvPSer7wFgcOKSDYKQ8tqaTvoJ9EzGi0X1S
	1cFByiHc6RiiAF8pMZO4gzCt1mycN3MUTtgEXGmVkG5OqfzW4DK67nuVHXcwvObuE1TwfylHky2
	9HQckKzNG4uAULKpJn8y3aeQcaJDaLQFJpX69GKJkdpn771mv6eV8b5OYm4u/bUc5xNzo2gs1il
	4q/JMpBOTQjzeChrB3215yL87jSgAgSJWAy4+T8RFR9lGl6VQhq8i/lVrjz2XwFHZyDWG7j9g3x
	DYe4FqqZ7rqT9/YUIrIqDSu6aLKF5VEaCR4EHDUfvf8qZH82BpsantWmz1NeWN5J5DCfGyHfTWL
	w3sValu28CjqPqtQ==
X-Google-Smtp-Source: AGHT+IEC/4NK0xEhofl4eSkgsE6EXEHSggLI1ncWazk+S7Rs5yicBQGmHOfEzTV6hVKlmojmttzlFA==
X-Received: by 2002:a17:907:2da7:b0:ad8:8c0c:bb3d with SMTP id a640c23a62f3a-b34ba93cac0mr504811166b.3.1758910123636;
        Fri, 26 Sep 2025 11:08:43 -0700 (PDT)
Received: from localhost (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz. [2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b353f772528sm404316866b.37.2025.09.26.11.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 11:08:43 -0700 (PDT)
From: Petr Tesarik <ptesarik@suse.com>
To: "H. Peter Anvin" <hpa@zytor.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	Petr Tesarik <ptesarik@suse.com>
Subject: [PATCH v2 1/2] x86/tsx: Make tsx_ctrl_state static
Date: Fri, 26 Sep 2025 20:01:01 +0200
Message-ID: <8b7d5f2baf55334a06da558afc7e12f3a78ae7ef.1758906115.git.ptesarik@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1758906115.git.ptesarik@suse.com>
References: <cover.1758906115.git.ptesarik@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move all definitions related to tsx_ctrl_state to tsx.c. They are
never referenced outside this file.

No functional change.

Signed-off-by: Petr Tesarik <ptesarik@suse.com>
---
 arch/x86/kernel/cpu/cpu.h |  9 ---------
 arch/x86/kernel/cpu/tsx.c | 10 +++++++++-
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index bc38b2d56f26a..5c7a3a71191a1 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -42,15 +42,6 @@ extern const struct cpu_dev *const __x86_cpu_dev_start[],
 			    *const __x86_cpu_dev_end[];
 
 #ifdef CONFIG_CPU_SUP_INTEL
-enum tsx_ctrl_states {
-	TSX_CTRL_ENABLE,
-	TSX_CTRL_DISABLE,
-	TSX_CTRL_RTM_ALWAYS_ABORT,
-	TSX_CTRL_NOT_SUPPORTED,
-};
-
-extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
-
 extern void __init tsx_init(void);
 void tsx_ap_init(void);
 void intel_unlock_cpuid_leafs(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index 49782724a9430..167dfd38b87a2 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -19,7 +19,15 @@
 #undef pr_fmt
 #define pr_fmt(fmt) "tsx: " fmt
 
-enum tsx_ctrl_states tsx_ctrl_state __ro_after_init = TSX_CTRL_NOT_SUPPORTED;
+enum tsx_ctrl_states {
+	TSX_CTRL_ENABLE,
+	TSX_CTRL_DISABLE,
+	TSX_CTRL_RTM_ALWAYS_ABORT,
+	TSX_CTRL_NOT_SUPPORTED,
+};
+
+static enum tsx_ctrl_states tsx_ctrl_state __ro_after_init =
+	TSX_CTRL_NOT_SUPPORTED;
 
 static void tsx_disable(void)
 {
-- 
2.50.1


