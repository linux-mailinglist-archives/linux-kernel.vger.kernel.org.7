Return-Path: <linux-kernel+bounces-740213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A448DB0D172
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 07:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F893AA073
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 05:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44DD294A06;
	Tue, 22 Jul 2025 05:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htsuDxOK"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD2728FFE6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 05:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753163454; cv=none; b=EckkRX04tWAJgbCFcpmHS12yzPIA+TzcVhFr73WcEsU9cREVGRIGLPbvU3gF8hoB438JxUPe9YBaJ679vCKR7mhzCce16N0+Qa8dL/uJboSyeazcvlDJ2lzCX0puNHp4LNpXPExkOP2QKgvD1DzV1R9r0Ash4n/EqlX0Fw/7fJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753163454; c=relaxed/simple;
	bh=f2app9m1XBJQAi6+4l94hDgNDXkVwP8W7DjMeboFeKs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=bITqmnTeo5wCvVAR4Dkbaj7shApwgpY+Rp8TiBmjLlG44maGUprjSnMe3u4XvSuNXaAsllwm2O3AMOb0lN3c6R+Ue99pJQuRTA5/6vEgcnVoFG5ICSiHNsdTBGY6TBSJAlrn9wHJ7RxfCsZ0FlpGrHYfpeX22Ebsb3bQ9UH1PEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=htsuDxOK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e8bcab61882so7291956276.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 22:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753163452; x=1753768252; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XJUgLDdqD5HwEkqjp4kNT3CMaMib66Jd7rSrX/S2lMg=;
        b=htsuDxOKLWcDTconWdgbl/hKNsA0naehu5CU7AULw6+bDQKkOYq9qBU9Ujh86rAbvk
         DmlmJC/Ug30WCVV7ZDiyvwnVmogwDHQTEm2H0unTzK6jLjtrjNtul1aNi66NCNnaXM3E
         Vdvob3bv1/3bJQ7JqJgPGdYjFTv2tQ+KzxB0GjGSIzPr/bc/cdFUW4bZlnzk0YykEyJc
         MPzGzI8WgL3eotqkdwbTic3aMpA8IJBCHcrM9bi/0mKl+KG/jpYAdwr0ntIrV9oEN3Dt
         RYy8ad78XQjOE4zV6sJjhKg8FxRVBxxmGpr2RXsdB4vpCXPBHzvm6tiqCMSPOFq8pcBM
         yyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753163452; x=1753768252;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XJUgLDdqD5HwEkqjp4kNT3CMaMib66Jd7rSrX/S2lMg=;
        b=FUNSTtFKqHG4LY3qtexs8dx5jgonlZa3ygbqcclUT8QPWg1hpmoXbgBRElIHeaNpLE
         Tqw1zS1m41FgOLdLDnL3DPwFJl1eED+P80/LdV2Aw0/aOY5W94uSLV30lCUdPyQf5hgk
         Lnsgj2VtkQAmNbcvVo2Im9b/cY0HF9yaIjRiLJo/iSSQwMCpj06ZUaAQ4JlBUIzIRoPe
         0FxoBXmmKAMjxxTAptEgtfOxTO4dZgkifrapU45NtaYKMn1z58L2YtnZVM6ya3VVDXr8
         bv9lqsf25iZHmLkEAL3h3sXpctIZ8YToQCooR35e93rEc8lY8pAvniaqbL8iqOuur299
         /CtA==
X-Forwarded-Encrypted: i=1; AJvYcCWhO/CQUvjfRw/osX5+NW4sPMMFJqft8puZJVxoB4qFA1F7uHwi25kadAIsjq1SviAT+/ZdLrx3wPH326I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+Y+ypvc4aHN3w7xqG49KDdQEMrzlAbCE2Oa9RQ6NQOX8tX+O
	8KnBs2rY+yyXYbF/QgrrJcu0xkXdSssgGWzAGXHrVUFiiDDKopj8/1jVPC/zEQWFthsW0nC9tTs
	Q9AX3IeryeFmd5A==
X-Google-Smtp-Source: AGHT+IEzH5es+owsbGwJIgWMHUn6KwbtBgGKdaJcZ2YsHKNxdG3f/gO+Qi3qLfXbsU9+QlhJpAwtZwURqNvhQw==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:eafa:b5d9:dc1:d7b1])
 (user=suleiman job=sendgmr) by 2002:a25:a02a:0:b0:e8b:68e0:a7f4 with SMTP id
 3f1490d57ef6-e8bc252f6afmr2612276.4.1753163451131; Mon, 21 Jul 2025 22:50:51
 -0700 (PDT)
Date: Tue, 22 Jul 2025 14:50:30 +0900
In-Reply-To: <20250722055030.3126772-1-suleiman@google.com>
Message-Id: <20250722055030.3126772-4-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250722055030.3126772-1-suleiman@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Subject: [PATCH v8 3/3] KVM: x86: Add "suspendsteal" cmdline to request host
 to add suspend duration in steal time
From: Suleiman Souhlal <suleiman@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Chao Gao <chao.gao@intel.com>, 
	David Woodhouse <dwmw2@infradead.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	John Stultz <jstultz@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ssouhlal@freebsd.org, Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce a new command line parameter, "suspendsteal", enabling the
guest to use MSR_KVM_SUSPEND_STEAL, which tells the host that it would
like host suspend duration to be included in steal time.

Signed-off-by: Suleiman Souhlal <suleiman@google.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/x86/kernel/kvm.c                           | 15 +++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 07e22ba5bfe3..9a5490539bb2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7074,6 +7074,11 @@
 			improve throughput, but will also increase the
 			amount of memory reserved for use by the client.
 
+	suspendsteal
+			[X86,PV_OPS]
+			Enable requesting the host to include the duration the
+			host was suspended in steal time. Disabled by default.
+
 	suspend.pm_test_delay=
 			[SUSPEND]
 			Sets the number of seconds to remain in a suspend test
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 921c1c783bc1..35d1bb2283c2 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -320,6 +320,18 @@ static void __init paravirt_ops_setup(void)
 #endif
 }
 
+static bool suspend_steal;
+
+static int __init suspendsteal_setup(char *s)
+{
+	if (kvm_para_has_feature(KVM_FEATURE_SUSPEND_STEAL))
+		suspend_steal = true;
+
+	return 0;
+}
+
+early_param("suspendsteal", suspendsteal_setup);
+
 static void kvm_register_steal_time(void)
 {
 	int cpu = smp_processor_id();
@@ -331,6 +343,9 @@ static void kvm_register_steal_time(void)
 	wrmsrq(MSR_KVM_STEAL_TIME, (slow_virt_to_phys(st) | KVM_MSR_ENABLED));
 	pr_debug("stealtime: cpu %d, msr %llx\n", cpu,
 		(unsigned long long) slow_virt_to_phys(st));
+
+	if (suspend_steal)
+		wrmsrl(MSR_KVM_SUSPEND_STEAL, KVM_MSR_ENABLED);
 }
 
 static DEFINE_PER_CPU_DECRYPTED(unsigned long, kvm_apic_eoi) = KVM_PV_EOI_DISABLED;
-- 
2.50.0.727.gbf7dc18ff4-goog


