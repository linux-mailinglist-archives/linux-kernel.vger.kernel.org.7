Return-Path: <linux-kernel+bounces-729329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A254BB03505
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 05:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B023B23A2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 03:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA9B204588;
	Mon, 14 Jul 2025 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilgu4MnR"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CED11FE47B
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 03:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752464246; cv=none; b=FU6TwOXOSsydoF8b3RQRI+nz2BxcgeB5P6D1KfCi/zcfNp4z7LWwGoW//V5GO6XhUvJU+TN6wH53qs/BmxU4q0Fw++yXvzIuu0/yonvzzTKWb5m19gujRnCFNqGjAeeTJLJHm7LI5cUGqNc6qYny6ynShbJxlwALE4qsz2LMGrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752464246; c=relaxed/simple;
	bh=Iw8UgECeSh4MOBXDjEL7rz+cVwwQWB07OSoxUeNK10o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=rtWf7Fo2xeH7kraA2XnhvDTz+0qgNN63SBcAGdvZqwCKMp8NDRn5KZ6c7XySMG0gvc4FYqzk2/NQ+qWeuhW/b6ZZdUH8unZjW/s6cYU7GjeEaAlvqHiksJDzdxgTNT6CsCtlN0iUTTSgRsqRiR2DE3IctjJRlj7olVNE6olDcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ilgu4MnR; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--suleiman.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-236725af87fso64848085ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jul 2025 20:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752464243; x=1753069043; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IuCOV0BBhXpldFkF7SjoypukvpXxsnclSm2cFgamVis=;
        b=ilgu4MnRFiqrR5o4Iqtwhst7MJsLhRAyzNxSu13FLX/rFXwEPKqM7NqvPyaGjHofnp
         DBxn8O2ezQ7X/azijNos0qUcezREd/2BKcx1tLA3nWSE5rfjGarxB8BGZoWPRvWv5FJx
         yqgKIvpLgRPb4W/b3YqHI1886i6M3pU51VAhTOO8pUtBuNBGi4Zt3f1JK+Ak+eGTcv4K
         Wp8iBTCAvsHQM1ykdd0ZUv95MPG2ciIEa2LRrE6eT1nZ9+XcvvcYZoxIYfKPRLiz/OL8
         ajbDnfDyi3i2Zl8LfrCk/Ag2ov6GPAHsAmzCL42vfZtZ4m/sxcYNGHY3uL30PBxYzBI7
         gXaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752464243; x=1753069043;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IuCOV0BBhXpldFkF7SjoypukvpXxsnclSm2cFgamVis=;
        b=GR+1BucLrN62vlotTBxgCoSnHZBmG1M9EQZPZ9g+ogaAr/3GukJNQHLZaN/QV3FsmA
         kfX/AbmsRDu4GwFwsIrgrEQL3PZTQDGApugqv4bkGjE/HopTuMJApwtCNSfNOf/55gR1
         0bYhWWauQJ5/5AAftejjgC+kw4o+VEFmMtNiaLH355fLDoVwQ2OT1TNPFAhfsd9lwA3k
         KpHRcodEo5/dxkaAiWoxvgffegnunkDm2++RUBq+eEWjIivw+eTGrvNSW0yNhRby25jv
         CUNz+x1Au4TYr/WwwH58ZkA8rZgyoGuqbTUXTOnzHUkaSdY5YBFm2qY9iBBfQt+uYd53
         0Wbg==
X-Forwarded-Encrypted: i=1; AJvYcCVBXOAzt17VYFUXhVQgO1ASTgdNOU+IDkMx/CBavAGsAaocYONxJuXq+e8Bu9tS5wWPWIghKdsdgxxSDbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUeA6xfGudC/vcdfNURa8tynJHE/vQxtFdW0Ma4Eh28Eg2kwa
	JmjWnF4Yi6YGMcZcihLOsp13FIHH24R8f9MMfN7y7KOGbZSs/5bB93jDyIrknc4QTAR99UZ5Nxh
	312mH3XOt9FmLCQ==
X-Google-Smtp-Source: AGHT+IFrBZOkLURtmxf4lvSzOVmE0ai7SJHbgn0xbbIb3ggEOAP+Yzu5GmOIjRZRMCD8thfwgdWkLGsD3AzRyw==
X-Received: from suleiman1.tok.corp.google.com ([2401:fa00:8f:203:4f90:1ee3:198b:1fe4])
 (user=suleiman job=sendgmr) by 2002:a17:903:348d:b0:234:ddd7:5c16 with SMTP
 id d9443c01a7336-23dede708ddmr9195ad.4.1752464242498; Sun, 13 Jul 2025
 20:37:22 -0700 (PDT)
Date: Mon, 14 Jul 2025 12:36:49 +0900
In-Reply-To: <20250714033649.4024311-1-suleiman@google.com>
Message-Id: <20250714033649.4024311-4-suleiman@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250714033649.4024311-1-suleiman@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Subject: [PATCH v7 3/3] KVM: x86: Add "suspendsteal" cmdline to request host
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
index f1f2c0874da9..9f5758ca8fad 100644
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


