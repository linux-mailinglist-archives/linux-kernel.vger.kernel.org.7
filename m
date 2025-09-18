Return-Path: <linux-kernel+bounces-789000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA95B38F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 02:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76CBA981436
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436031AC44D;
	Thu, 28 Aug 2025 00:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yo+AOOCE"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2633512FF6F
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 00:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756339327; cv=none; b=bpj4dw4CMk5ghKAARKnghSo4jbsgOc0JEe0gfLSgATSVx/GMqWh10m81edGI5oYDlQTSzxYtH4Q6AqeGJq2/5cu3UFdTWFbnhAcfkvxi45ba33trJ/OZImXFKIsdnr2E4vQJcaIZWT0GlNg7wOuy9X606UaEWQk2P4Qbr8nvf1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756339327; c=relaxed/simple;
	bh=8tZ83PeYs29SmFwlLYawA90+tGBTxdUNJGqvgVUYI08=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W1BVJ6GpM9r2sODxKthvJZ2Chn0tvSx3/ibOe+HlfY/P6oGZsBnteLVBGwf11HwiyedlftbOYQmcfx9IFjkpewBp6dlZTniCKm2J2kWe337oMhLd+h6MfozpX+McD1Vn3sw7JvnE99NuM9zgA286yDNi187f4048mpxB+qUyrQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yo+AOOCE; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-324e4c3af5fso368143a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 17:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756339325; x=1756944125; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=hDymskQNp6wG2uiiMHxVPzsL1nAJPxy4zRxFOrP95kA=;
        b=yo+AOOCEgQsPtXsvEZ3HLVcsX1TmXb2v7Tx+yKYWB17Taupoci1mHoBlWVe28a4bs2
         AsY+GUQDG1/883XQ1o4nO+jPq0xLEyraGBiG40dNPFuzgziGLXNIkOfMQSyTcXohftCe
         h09d91Rq2CcH4LY16snMRZa12iL9z9kOD/D+IoXX/waF3iGnXfqulzx7IHl8igthuTyl
         Z8ZIwoN1Ub8S9PovdB9eTq6QHzlcYByPjvhk32rvT87HJBhNKqzv4lV7Zt28QP4B3bck
         P0JDPtsS5c+8H3vMjven3/YyoNrd2Sdnz9fXfParttV3jgLhuu7PhwMyVjFMwy8YYYSL
         YcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756339325; x=1756944125;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDymskQNp6wG2uiiMHxVPzsL1nAJPxy4zRxFOrP95kA=;
        b=IqhyqEHz8V9MeP5tMK/eiToXL0ox8YzKvD9U/5GUsO1tTVfQ+zaJPfSs5kzAvdke9T
         ugfJoei7xco5klaSQokFeT1bDTpWpm4nYX3Hlk+UtEkL+q936qTn/CNdyv81iY/j25Xt
         Q0ZtFAUHbyeB92Ka+fCMAbT0q/V2wW+IQ6QjP/FfuOoEc+e8WhllOwoZsW955zQAm1OC
         mubFveNYYfrSH5gG1fbxYy7/BFR5eYOkU9zm1ZgcbLMWnJAkYAyF3JAgZ7kn/F4b4mGp
         qtZGZzNRp+mPZCCVzc18ORw8XUADNYNUxrgH2k/NkO7Z0bavTafN1MDBCIu0xpoajUEU
         F/Jw==
X-Gm-Message-State: AOJu0YzIheEPH1Og3N1dklHb2qHHGu3W0CF1PLCvUUnuD4bUyIWF7XkG
	DMhmVAVJZ6vA8aBuCv2xYBpz5YaQWrcsFG+oelmksbQULCd2PR2/IS+gHrCDyp1z2k/Z4+xHrQh
	vPXQL4A==
X-Google-Smtp-Source: AGHT+IEpldWCysonYjdHETjodWyZtDlIBYcwDxX/6JZFBAIAnGNdK+zSnqMrfXxPLk2m5pFyKQhTG4/yaKw=
X-Received: from pjj15.prod.google.com ([2002:a17:90b:554f:b0:325:833b:6f27])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:55c4:b0:327:aaeb:e814
 with SMTP id 98e67ed59e1d1-327aaebf1b1mr940666a91.23.1756339325323; Wed, 27
 Aug 2025 17:02:05 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed, 27 Aug 2025 17:01:51 -0700
In-Reply-To: <20250828000156.23389-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828000156.23389-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828000156.23389-3-seanjc@google.com>
Subject: [PATCH v2 2/7] Drivers: hv: Disentangle VTL return cancellation from SIGPENDING
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

Check for return to a lower VTL being cancelled separately from handling
pending TIF-based work, as there is no need to immediately process pending
work; the kernel will immediately exit to userspace (ignoring preemption)
and handle the pending work at that time.

Disentangling cancellation from the TIF-based work will allow switching to
common virtualization APIs for detecting and processing pending work.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 drivers/hv/mshv_vtl_main.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 12f5e77b7095..aa09a76f0eff 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -731,19 +731,21 @@ static int mshv_vtl_ioctl_return_to_lower_vtl(void)
 						_TIF_NOTIFY_RESUME | _TIF_NOTIFY_SIGNAL |
 						_TIF_NEED_RESCHED_LAZY;
 		unsigned long ti_work;
-		u32 cancel;
 		unsigned long irq_flags;
 		struct hv_vp_assist_page *hvp;
 		int ret;
 
 		local_irq_save(irq_flags);
+		if (READ_ONCE(mshv_vtl_this_run()->cancel)) {
+			local_irq_restore(irq_flags);
+			preempt_enable();
+			return -EINTR;
+		}
+
 		ti_work = READ_ONCE(current_thread_info()->flags);
-		cancel = READ_ONCE(mshv_vtl_this_run()->cancel);
-		if (unlikely((ti_work & VTL0_WORK) || cancel)) {
+		if (unlikely(ti_work & VTL0_WORK)) {
 			local_irq_restore(irq_flags);
 			preempt_enable();
-			if (cancel)
-				ti_work |= _TIF_SIGPENDING;
 			ret = mshv_do_pre_guest_mode_work(ti_work);
 			if (ret)
 				return ret;
-- 
2.51.0.268.g9569e192d0-goog


