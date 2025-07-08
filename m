Return-Path: <linux-kernel+bounces-722216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB3EAFD68B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 20:37:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850B0560C49
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 18:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7305C2E542E;
	Tue,  8 Jul 2025 18:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JzJzAK+h"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1AB21CC74
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 18:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751999852; cv=none; b=BWHaXl7eDzgHS5RjkoOgW12hmnZxEp7drwGw/qoUKZ8eMxMuPrzMp8xGrpLRgBXAxihgCKbDJgttnvisi92l/TkEGNkGjiY53/O9rF3kwbsV6bWxcELETHialpbcJBWd2F2iTO/+wOsEdzB8nhHHqO2E9iTcaaX5YpcsuKEWZj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751999852; c=relaxed/simple;
	bh=vg+uQCJ+lSN99jIomcmUQZbwXNmXTfe07jNsopO6k20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=alGu/OQa8AWKyXIRwlAAZYqvsnUEQ/qJEisoUCWRit/wqGUG3fni4uWViidGSVRVWPDRSH9AiFkjzY2/dNy3a9PqvSBfI+sKpDDI3wR1EkpNJdLUzseE0N7AC0PY57Xgxc9Vg11+f9388QOwfepVG7byp9s6UsvWyZA6LCx7EmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JzJzAK+h; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-748f3d4c7e7so3450152b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 11:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751999850; x=1752604650; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuihDo1m5FyoRrxBA7eIdTW1eQsHNBGooJAzPvs8+c8=;
        b=JzJzAK+hOjajiXZF2foPPNeEcg8NgJEqFaw4SXnoVwtt0Ow0MQ0Yym5Si4xM5OxKJ7
         uJAn0hwGne/geNeEqPkBj8iyu7wdQddTjdOiqm79OrNacRCk8suq3s5gig9hTqmcqMOc
         JEjtcThza8JjMKihIp/QgskQYRuRS+266BXwFjU0u7FTHV67aDkBD85TrQVM2t+I5sZl
         sVifKdzVCNtabPIkbY01vab2YCX0NXVp0XiaFs4CYylp4LJPzl0TryWQ9VI/bLeGw2ul
         Yv/M/3kpBi2Wlc6bwQ7Alo+wFYYNO0FloWHprl5ARmoob82Jhhr9xUfuA6/rSGG58VhF
         qCkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751999850; x=1752604650;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yuihDo1m5FyoRrxBA7eIdTW1eQsHNBGooJAzPvs8+c8=;
        b=ZbA86cEsMCn+SxoSilQr1znJsw7VNLpYglymm904rwn1cymf4bpCTnF657CvHZbMzw
         uN5Nq1P6uaz4j0z2xgt+V9IVqc0rXQ43ygd8dFbo9gV6+5nEYVxchnz153mAOiloGh1u
         SF7xzU037vs8dq9ZeDMq/LpLgNqSzZnBVzSR3m8nbBAXikck9frYdbJeTAioHkd906vK
         vdiclGcyuXfUG8An/DM+NmPtp1T+UPC0LVXOMPvmjaAS8ry5vgxtEBRy80WFqHaaju5X
         quYKsOhgaY1htIpl4mY120wTBSpLZ6Qh8Q/XDR2KrTi65y+7qrT72SDf0welLLk6dvEk
         HYhQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzBCfWa2IeyramnfkM6skxtovGjlZwt/8Xk8kL34aXSn/76ypsb3+h8CulaJOuS8u5FTVxWsVuT606Aqo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZO1vHEs/o7/wE2CJ3l4lJnTHbLOVd1vLT4cnSumao4+cnXkiW
	Wld5Et5rJZOAJ5KdXXlg5plMfvn4wNPDbiKiiQs0+WSINXrl/PqvrBlphjr3mKwS2trWwVYVG30
	psbzL9Q==
X-Google-Smtp-Source: AGHT+IE0jOeDJGjqyFwQLwFs8IMKVlBUzhMwAfpeufc6A4eZa0THyR4cN5PjdVCjvg8e5KCGp+se29EjQ+4=
X-Received: from pfbjw38.prod.google.com ([2002:a05:6a00:92a6:b0:74c:ee73:4859])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:856:b0:748:e1e4:71e7
 with SMTP id d2e1a72fcca58-74ea498dc91mr157508b3a.23.1751999850363; Tue, 08
 Jul 2025 11:37:30 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:37:28 -0700
In-Reply-To: <20250612214849.3950094-9-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250612214849.3950094-1-sohil.mehta@intel.com> <20250612214849.3950094-9-sohil.mehta@intel.com>
Message-ID: <aG1laKXYu7Uc4Tsb@google.com>
Subject: Re: [PATCH v7 08/10] x86/nmi: Enable NMI-source for IPIs delivered as NMIs
From: Sean Christopherson <seanjc@google.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Xin Li <xin@zytor.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Tony Luck <tony.luck@intel.com>, Zhang Rui <rui.zhang@intel.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Andrew Cooper <andrew.cooper3@citrix.com>, 
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Jacob Pan <jacob.pan@linux.microsoft.com>, 
	Andi Kleen <ak@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sandipan Das <sandipan.das@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-edac@vger.kernel.org, kvm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Jun 12, 2025, Sohil Mehta wrote:
> With the IPI handling APIs ready to support the new NMI encoding, encode
> the NMI delivery mode directly with the NMI-source vectors to trigger
> NMIs.
> 
> Move most of the existing NMI-based IPIs to use the new NMI-source
> vectors, except for the microcode rendezvous NMI and the crash reboot
> NMI. NMI handling for them is special-cased in exc_nmi() and does not
> need NMI-source reporting.
> 
> However, in the future, it might be useful to assign a source vector to
> all NMI sources to improve isolation and debuggability.
> 
> Originally-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Co-developed-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Xin Li (Intel) <xin@zytor.com>
> Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
> ---
> v7: No change.
> 
> v6: Include asm/nmi.h to avoid compile errors. (LKP)
> 
> v5: Encode APIC_DM_NMI directly with the NMI-source vector.
> ---
>  arch/x86/include/asm/apic.h      | 8 ++++++++
>  arch/x86/kernel/apic/hw_nmi.c    | 2 +-
>  arch/x86/kernel/cpu/mce/inject.c | 2 +-
>  arch/x86/kernel/kgdb.c           | 2 +-
>  arch/x86/kernel/nmi_selftest.c   | 2 +-
>  arch/x86/kernel/smp.c            | 2 +-
>  6 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
> index 32cdd81e5e45..5789df1708bd 100644
> --- a/arch/x86/include/asm/apic.h
> +++ b/arch/x86/include/asm/apic.h
> @@ -14,6 +14,7 @@
>  #include <asm/msr.h>
>  #include <asm/hardirq.h>
>  #include <asm/io.h>
> +#include <asm/nmi.h>
>  #include <asm/posted_intr.h>
>  
>  #define ARCH_APICTIMER_STOPS_ON_C3	1
> @@ -23,6 +24,13 @@
>  #define APIC_EXTNMI_ALL		1
>  #define APIC_EXTNMI_NONE	2
>  
> +/* Trigger NMIs with source information */
> +#define TEST_NMI		(APIC_DM_NMI | NMIS_VECTOR_TEST)
> +#define SMP_STOP_NMI		(APIC_DM_NMI | NMIS_VECTOR_SMP_STOP)
> +#define BT_NMI			(APIC_DM_NMI | NMIS_VECTOR_BT)

s/BT/BACKTRACE?

> +#define KGDB_NMI		(APIC_DM_NMI | NMIS_VECTOR_KGDB)
> +#define MCE_NMI			(APIC_DM_NMI | NMIS_VECTOR_MCE)

IMO, NMI_xxx reads better, e.g. it's easier to see that code is sending an NMI
at the call sites.

> +
>  /*
>   * Debugging macros
>   */
> diff --git a/arch/x86/kernel/apic/hw_nmi.c b/arch/x86/kernel/apic/hw_nmi.c
> index 4e04f13d2de9..586f4b25feae 100644
> --- a/arch/x86/kernel/apic/hw_nmi.c
> +++ b/arch/x86/kernel/apic/hw_nmi.c
> @@ -33,7 +33,7 @@ u64 hw_nmi_get_sample_period(int watchdog_thresh)
>  #ifdef arch_trigger_cpumask_backtrace
>  static void nmi_raise_cpu_backtrace(cpumask_t *mask)
>  {
> -	__apic_send_IPI_mask(mask, NMI_VECTOR);
> +	__apic_send_IPI_mask(mask, BT_NMI);

This patch is buggy.  There are at least two implementations of ->send_IPI_mask()
that this breaks:

  uv_send_IPI_mask() = > uv_send_IPI_one():

	if (vector == NMI_VECTOR)
		dmode = APIC_DELIVERY_MODE_NMI;
	else
		dmode = APIC_DELIVERY_MODE_FIXED;


and xen_send_IPI_mask() => xen_map_vector():

	switch (vector) {
	case RESCHEDULE_VECTOR:
		xen_vector = XEN_RESCHEDULE_VECTOR;
		break;
	case CALL_FUNCTION_VECTOR:
		xen_vector = XEN_CALL_FUNCTION_VECTOR;
		break;
	case CALL_FUNCTION_SINGLE_VECTOR:
		xen_vector = XEN_CALL_FUNCTION_SINGLE_VECTOR;
		break;
	case IRQ_WORK_VECTOR:
		xen_vector = XEN_IRQ_WORK_VECTOR;
		break;
#ifdef CONFIG_X86_64
	case NMI_VECTOR:
	case APIC_DM_NMI: /* Some use that instead of NMI_VECTOR */
		xen_vector = XEN_NMI_VECTOR;
		break;
#endif
	default:
		xen_vector = -1;
		printk(KERN_ERR "xen: vector 0x%x is not implemented\n",
			vector);
	}

	return xen_vector;

Looking at all of this again, shoving the NMI source information into the @vector
is quite brittle.  Nothing forces implementations to handle embedded delivery
mode information.

One thought would be to pass a small struct (by value), and then provide macros
to generate the structure for a specific vector.  That provides some amount of
type safety and should make it a bit harder to pass in garbage, without making
the callers any less readable.

struct apic_ipi {
	u8 vector;
	u8 type;
};

#define APIC_IPI(v, t) ({ struct apic_ipi i = { .vector = v, .type = t }; i; })
#define APIC_IPI_IRQ(vector) APIC_IPI(vector, APIC_DELIVERY_MODE_FIXED)
#define APIC_IPI_NMI(vector) APIC_IPI(vector, APIC_DELIVERY_MODE_NMI)

#define IPI_IRQ_WORK		APIC_IPI_IRQ(IRQ_WORK_VECTOR)
#define IPI_POSTED_INTR_WAKEUP	APIC_IPI_IRQ(POSTED_INTR_WAKEUP_VECTOR)

#define IPI_NMI_BACKTRACE	APIC_IPI_NMI(NMI_BACKTRACE_VECTOR)

static __always_inline void __apic_send_IPI_self(struct apic_ipi ipi)

