Return-Path: <linux-kernel+bounces-789001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD825B38F83
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7533220899F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2D1E8324;
	Thu, 28 Aug 2025 00:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FwGjinL6"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0618FC92
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339329; cv=none; b=bH8sC0mmYET/gFxEvfXcHue6FNmDHo1U7ORgUaKFy77+6YghQ6cs5IMu2q0rVEhywYnPNnOrsXsgddqszvI1YX9/KhvkGujCRM2fMpu61AmpXNoaas83CiRgtFaVYIOOfDluCo+wvuoSqMTzvubdHdAvUFa7ZK6TnyB3XibLT/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339329; c=relaxed/simple;
	bh=TvCX+8FkP7MFHYKfg/0KhAOHMZdZcfiHEdWLUolI1Zo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sDsz+fLaSBuSrJUCxST1j3EOHemcdTgLTHixQ6u2JNMHbPzqYSeXhFGSyoaAus2DOjBzuqG+FUlbfQvl7u2EvdI1xCKTjRCHnlz4xizOpAL3RmvNPSWrdTFROK9SczG0KyBMPIybOeYPycQTa07WnRrlCIPpfVqDtrClNvgtJeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FwGjinL6; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-770593ba14fso519163b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756339327; x=1756944127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=vhbQgqknyAyVeKaXs8kP6grJ1hrwQUkSmJiE25IRpuQ=;
        b=FwGjinL6djn0iX+mCxZgJ6VgeV7qBbQopg+f1tDftimoOdpxj0PE1cGZiTSMRRw8Z4
         bsRWFdiReGjHjjopEPvTo+25kWh2mZ4u6aFcZYEGcC+Nmhtxko3ZIGCaMf/iqh0FuS9Z
         7RlAjao2y4po8a6a/DfbW38NOdniScT5kUdoRmDH/UVwTTLM0PmaKTNDlZGs9inTQbU7
         82iOF6OVv73twgxpHgP6raLu6kw2J8MpCQui73xwaIj9RxdWX1OTBMLwP2tBizWnQpY4
         zmdvSDiF/+ZLqrCr+oqyRDYlp47T7+7/i0/sfonud1ThTK1460RajvcywdvQbvTPl596
         +cYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756339327; x=1756944127;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vhbQgqknyAyVeKaXs8kP6grJ1hrwQUkSmJiE25IRpuQ=;
        b=vIL+eiA8j+aOZGNLkAN9270BtwKOxsfgR7VH6t5X062Ti1cvax24gcBcGKQ5Dv/thE
         /Nl2B59PYM0dft66YVOESNmuCW6yt3uUhe1BDG81FPZctUyiR4uUL91zyGTZK/qSd1WW
         GeV1teOjbWnvXBqNxo0Z9UCqFSe1YXBRJUKg/dCi8gEGFc1fq/t4Ojao29/z0eKbHbj8
         hvsAtZxGy3X7yNIDDfHN/NV/o2jWBL+nene83uhb4oLi5qXQosO6l7ddbrxD3YF6T3tF
         KLcOh+Gfb7gGguSaYG/Ft2ATpILhYtV0ESS7IcJMj3904o4sZJdSKwqtXDyxLssCLehF
         ksCQ==
X-Gm-Message-State: AOJu0YwVAuuh/TId9bKsaL31VHuyTt+1/mMmCSm/XSlajB82S9h0VnaH
	PYSZzC4lcg3dMVPHXUh0BWy+6n2atZ221Qo6vCEz+xYJbaTFxfsV/tSu5eE6ypGQO2Y1UGwbDl4
	zq66bCw==
X-Google-Smtp-Source: AGHT+IFSTSPK462uYm9CJ0EAHOKjQ8TiWstiYBGpgePwdPA6VvAffLDDZpu/ZHt6d1MsFofssMNf6pVc4TI=
X-Received: from pfbdr10.prod.google.com ([2002:a05:6a00:4a8a:b0:772:a5a:298b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b46:b0:76e:885a:c1c9
 with SMTP id d2e1a72fcca58-7702fc24f39mr26347774b3a.27.1756339327187; Wed, 27
 Aug 2025 17:02:07 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 17:01:52 -0700
In-Reply-To: <20250828000156.23389-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828000156.23389-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828000156.23389-4-seanjc@google.com>
Subject: [PATCH v2 3/7] Drivers: hv: Disable IRQs only after handling pending
 work before VTL return
From: Sean Christopherson <seanjc@google.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Anup Patel <anup@brainfault.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andy Lutomirski <luto@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Uladzislau Rezki <urezki@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, rcu@vger.kernel.org, 
	Nuno Das Neves <nunodasneves@linux.microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"

Swap the order of checking for TIF-based work and cancellation, and disable
IRQs only after checking and processing TIF-based work; checking TIF with
IRQs enabled is a-ok, e.g. IRQs and preemption _must_ be enabled before
handling the pending work.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/hv/mshv_vtl_main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index aa09a76f0eff..4ca13c54c0a0 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -735,16 +735,8 @@ static int mshv_vtl_ioctl_return_to_lower_vtl(void)
 		struct hv_vp_assist_page *hvp;
 		int ret;
 
-		local_irq_save(irq_flags);
-		if (READ_ONCE(mshv_vtl_this_run()->cancel)) {
-			local_irq_restore(irq_flags);
-			preempt_enable();
-			return -EINTR;
-		}
-
 		ti_work = READ_ONCE(current_thread_info()->flags);
 		if (unlikely(ti_work & VTL0_WORK)) {
-			local_irq_restore(irq_flags);
 			preempt_enable();
 			ret = mshv_do_pre_guest_mode_work(ti_work);
 			if (ret)
@@ -753,6 +745,13 @@ static int mshv_vtl_ioctl_return_to_lower_vtl(void)
 			continue;
 		}
 
+		local_irq_save(irq_flags);
+		if (READ_ONCE(mshv_vtl_this_run()->cancel)) {
+			local_irq_restore(irq_flags);
+			preempt_enable();
+			return -EINTR;
+		}
+
 		mshv_vtl_return(&mshv_vtl_this_run()->cpu_context);
 		local_irq_restore(irq_flags);
 
-- 
2.51.0.268.g9569e192d0-goog


