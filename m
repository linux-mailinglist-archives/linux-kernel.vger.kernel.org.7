Return-Path: <linux-kernel+bounces-865303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56606BFCBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EC661A6062D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737A534C995;
	Wed, 22 Oct 2025 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crd0p7DR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C934C138
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761145309; cv=none; b=hnWvZY0gvotfdr4mS2c7ZiWeamDDOk6Kf1FmsaBvdsPsN3q3HTfaVM8x48GwbWSJSRh6Wip0kmpc3fXXX9wxiYI0rZrePIYcJYNGgD0onPTPFcbpVZvWAkz5U0EMHMgrhhFdJjltSEEkQas/7Mr2d+28ce5OzN3fP/gmbiygTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761145309; c=relaxed/simple;
	bh=E3MjY4wrFQgs0Ey0M7VbCGgbgx+qYCvJq22nI6SsagA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PRuYTBphz5GMFucFKPZoy+oHnjownZznUSKGFYpgrJhWTWErB2chDc1SEQgrTHHPtUVW1UwA6Xn6JwJTFLH8dZqs6++3WniCQizeo01sE1PVKpqK2IkaAITjEEdqJxu5c9nDsBTm4DcIKsxpTXnMKTloJhPkoYmlas+anSykOps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crd0p7DR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-782a77b5ec7so6492526b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 08:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761145307; x=1761750107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAEfyzLs6ZfNZyLJabqtuJouEJtYNe8jJBcru5DQddE=;
        b=crd0p7DRC1Tng3tEWub76YtCUDAkij09uw+6KcBEEkvGAyt95fZX4T4MwDnqId/2BA
         R0qu1+8lPLRhhJykLhmzG37BTYPsd1GWfuxyyEhNqgLoTF2utlUYf2te7P+Yb5Hj0DB6
         XihhBFt8p4MDpA2hZpiksc8FVGfagOk5hVAL6w5MTAss3GvynTqBdWgYvW80TVyPzka2
         2YZhxVhaEG4rlBdwaMhRlYYAJVtvMDh4/HFEdA4vG8taJ7gGQ+rDYktVCLeEeny+m8cz
         pe8YZ/CQRxGnv8RGikPgUS3WH5JSGyRMVv6wD2VQPMMIMv6ahmOdCCsrxZfbKNMo3kf5
         gmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761145307; x=1761750107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GAEfyzLs6ZfNZyLJabqtuJouEJtYNe8jJBcru5DQddE=;
        b=tLTZRnsQJg/tXN9GW8ads/wroRjly3ZCwcfQ5UOj2rw0nbOGWSABt0jrCaH/cdqhy8
         Qeofqnl2DVUADQJVEsOnn+NrUwwk0NgoU+X7i2ZpuBvVOe8JX2HN7GWeOy0SDLGXRCB6
         1q6m3X4RuIb0StPR/Czwgjg7g1ljC1Qi085Dh3BHdISwAY41tN8SLYifyp71rNSXG5Tu
         KuRO+vAh0D3C6upK8E2MAN1K03v+rA/Na9W5W6kaOffSkz94FxBafr4sfJH5kkJEcMHB
         wV7u1cwRMaKcXc38O+bwRJGCeHjSrC67HU5oVDV2TtI/013GOqTSnioj0vfSl/+VfGMt
         2K9A==
X-Forwarded-Encrypted: i=1; AJvYcCWSTw+XoZXq3nFt6Ky10YymbjBrZoeftvIdKZW0dB7rPWye/LO+8gj5RhbdlE9yvfNlhvk9Xwk0wGIGUMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzROoxFZg7uPMcbvudhQamxfxHCt7CYYogK2h2ASpNTDIsq0Mx6
	MiPbe1cwYBxWskjz4vvU+AayXJjcOS3VTRw7YH7+yklpyMpho2kyWI3mAvXNInG4wnM=
X-Gm-Gg: ASbGnctmZTidfom+SMAQwjFALfWbFX0Vqpmgw9RbjMswB6k/Mw8LvPjZChg8Zf5Gh0m
	NwMtZAOFGuMSaC+ZPjOeifYsQQI76hkSmExSeQMfA0Jw9tmh6ZSLdr0BMAYoHXqotsqo+AG2lp2
	HYUHrLqMDCISxnYtetVZGAhaHtljLBwrzgcROwONklPs2OWFuLec15WP/CuMau1S5UwSZ3P8emV
	g1OYemyg2vT11dEmxf1dDuYgnum8IxvrwHqO0KJO6nhuMyuJuUNHlJuVIVg4Grlw8csxq/b95AE
	7Qnqj/JBcq2DgaIxDmTIxHO5Wz5JysSr1R+Z+Od1xwqQbZrf8p7k/VYKXh0PXn7VCEWAfuzTF8g
	R7xUHHx9NNqdn6eVoj4KGxTMkMSe8ZfVXiM6lW+Cxfyar6RP3Jd5eZaaxpgp3krOwgAAQLclZYw
	3YqSbJDclI67UvGSZL4ap2sg+TSNSCCXDiZPbTIz2BZsfUMjXG+TB/u2fIIA==
X-Google-Smtp-Source: AGHT+IGrUnu0OE0MYMOGdRgAiyJXuUcaG4uPEeJasZ3TUiI7e1KAHvPHOFWaSXc9Do7+EcDyuK5f7Q==
X-Received: by 2002:a17:902:e5cf:b0:290:a32b:9095 with SMTP id d9443c01a7336-290cb7567fdmr293829075ad.54.1761145306436;
        Wed, 22 Oct 2025 08:01:46 -0700 (PDT)
Received: from localhost.localdomain ([2408:80e0:41fc:0:8685:174d:2a07:e639])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e3125a3afsm1973624a91.6.2025.10.22.08.01.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 22 Oct 2025 08:01:45 -0700 (PDT)
From: fuqiang wang <fuqiang.wng@gmail.com>
To: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Maxim Levitsky <mlevitsk@redhat.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: fuqiang wang <fuqiang.wng@gmail.com>,
	yu chen <33988979@163.com>,
	dongxu zhang <xu910121@sina.com>
Subject: [PATCH v3 2/2] fix hardlockup when waking VM after long suspend
Date: Wed, 22 Oct 2025 23:00:55 +0800
Message-ID: <20251022150055.2531-3-fuqiang.wng@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20251022150055.2531-1-fuqiang.wng@gmail.com>
References: <20251022150055.2531-1-fuqiang.wng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a virtual machine uses the HV timer during suspend, the KVM timer does
not advance. Upon waking after a long period, there may be a significant
gap between target_expiration and the current time. Since each timer
expiration only advances target_expiration by one period, the expiration
handler can be invoked repeatedly to catch up.

Prior to the previous patch, if the advanced target_expiration remained
less than the current time, tscdeadline could be set to a negative value.
This would cause HV timer setup to fail and fallback to the SW timer. After
switching to SW timer, apic_timer_fn could be repeatedly executed within a
single clock interrupt handler, resulting in a hardlockup:

  NMI watchdog: Watchdog detected hard LOCKUP on cpu 45
  ...
  RIP: 0010:advance_periodic_target_expiration+0x4d/0x80 [kvm]
  ...
  RSP: 0018:ff4f88f5d98d8ef0 EFLAGS: 00000046
  RAX: fff0103f91be678e RBX: fff0103f91be678e RCX: 00843a7d9e127bcc
  RDX: 0000000000000002 RSI: 0052ca4003697505 RDI: ff440d5bfbdbd500
  RBP: ff440d5956f99200 R08: ff2ff2a42deb6a84 R09: 000000000002a6c0
  R10: 0122d794016332b3 R11: 0000000000000000 R12: ff440db1af39cfc0
  R13: ff440db1af39cfc0 R14: ffffffffc0d4a560 R15: ff440db1af39d0f8
  FS:  00007f04a6ffd700(0000) GS:ff440db1af380000(0000) knlGS:000000e38a3b8000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000d5651feff8 CR3: 000000684e038002 CR4: 0000000000773ee0
  PKRU: 55555554
  Call Trace:
   <IRQ>
   apic_timer_fn+0x31/0x50 [kvm]
   __hrtimer_run_queues+0x100/0x280
   hrtimer_interrupt+0x100/0x210
   ? ttwu_do_wakeup+0x19/0x160
   smp_apic_timer_interrupt+0x6a/0x130
   apic_timer_interrupt+0xf/0x20
   </IRQ>

With the previous patch applied, HV timer no longer falls back to SW timer.
Additionally, while target_expiration is catching up to the current time,
the VMX-preemption timer is set to 0 before each VM entry. According to
Intel SDM 27.7.4 ("VMX-Preemption Timer"), if the timer has already expired
at VM entry, a VM exit occurs before any guest instruction executes. As a
result, the guest cannot run instructions during this period and cannot
reach vcpu_block() to switch to the SW timer, preventing hardlockup.

However, unnecessary repeated catch-ups should still be avoided. Therefore,
if the advanced target_expiration is still less than the current time, we
immediately catch up to the current time in the handler.

Signed-off-by: fuqiang wang <fuqiang.wng@gmail.com>
---
 arch/x86/kvm/lapic.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index fa07a303767c..307e2d6c3450 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -2140,17 +2140,25 @@ static void advance_periodic_target_expiration(struct kvm_lapic *apic)
 	apic->lapic_timer.target_expiration =
 		ktime_add_ns(apic->lapic_timer.target_expiration,
 				apic->lapic_timer.period);
-	delta = ktime_sub(apic->lapic_timer.target_expiration, now);
 
 	/*
-	 * Don't adjust the tscdeadline if the next period has already expired,
-	 * e.g. due to software overhead resulting in delays larger than the
-	 * period.  Blindly adding a negative delta could cause the deadline to
-	 * become excessively large due to the deadline being an unsigned value.
+	 * When the vm is suspend, the hv timer also stops advancing. After it
+	 * is resumed, this may result in a large delta. If the
+	 * target_expiration only advances by one period each time, it will
+	 * cause KVM to frequently handle timer expirations.
 	 */
+	if (apic->lapic_timer.period > 0 &&
+	    ktime_before(apic->lapic_timer.target_expiration, now))
+		apic->lapic_timer.target_expiration = now;
+
+	delta = ktime_sub(apic->lapic_timer.target_expiration, now);
 	apic->lapic_timer.tscdeadline = kvm_read_l1_tsc(apic->vcpu, tscl);
-	if (delta > 0)
-		apic->lapic_timer.tscdeadline += nsec_to_cycles(apic->vcpu, delta);
+	/*
+	 * Note: delta must not be negative. Otherwise, blindly adding a
+	 * negative delta could cause the deadline to become excessively large
+	 * due to the deadline being an unsigned value.
+	 */
+	apic->lapic_timer.tscdeadline += nsec_to_cycles(apic->vcpu, delta);
 }
 
 static void start_sw_period(struct kvm_lapic *apic)
@@ -2980,7 +2988,7 @@ static enum hrtimer_restart apic_timer_fn(struct hrtimer *data)
 
 	if (lapic_is_periodic(apic)) {
 		advance_periodic_target_expiration(apic);
-		hrtimer_add_expires_ns(&ktimer->timer, ktimer->period);
+		hrtimer_set_expires(&ktimer->timer, ktimer->target_expiration);
 		return HRTIMER_RESTART;
 	} else
 		return HRTIMER_NORESTART;
-- 
2.47.0


