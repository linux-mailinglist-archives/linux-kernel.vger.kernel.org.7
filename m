Return-Path: <linux-kernel+bounces-843739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FF0BC01D7
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 05:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC3DC3A15F7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 03:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3511E217F33;
	Tue,  7 Oct 2025 03:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LREWyy4v"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E444020322
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 03:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759809019; cv=none; b=TdQtp3nHQQ91sq6c2G00tXdiipsrsIOiWpK6z2+MPwJYriMilVbkov0RousT957QRDBkzDYerTgxQ7tDf3Dq5+s/UisqSr/L5Zggt/t0NqUCOUPN+S2KE4DGVTeter0WDJiC2X4B0YXFKZaKQ4IwXSKY9jwUAq1DEYM342AFgTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759809019; c=relaxed/simple;
	bh=+N4gtziafAY4WD1brFYmW50W1a/ix1jY2Uo1fbt1pYg=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:Date:References; b=eizYPij3C1P5LZsG4EvsaPL3SPNbJrvgXcPL/T6vSP4wGgNxf0Bk7XnonrGhF4GKDZG7xekDKD1UVHHo7HV1hcxPYKJqo7/til6NMaglBLibRZcp0fpZ8BH7NsnJls/Lub8qBCCtT5bvh+kB34xAej0vm9JCemKfTspWmtiub2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LREWyy4v; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b5515eaefceso5401505a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 20:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759809017; x=1760413817; darn=vger.kernel.org;
        h=references:date:in-reply-to:subject:cc:to:from:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DLvTrnlB6pwG2/hP8cgIWiHqyjOpePcOnpbnsgYKsys=;
        b=LREWyy4vQI51YZWeCpbtsZbkLAvq4ipRRtricIo1TNvQc/ceSxEaM0ebriIJuqQ9BQ
         W2FDnhdR6/ijFqb7gnQARwp/1+NNQ8oiCWhU2nEVGmw3eAJ2+gbW6Dx+J13WnaemtCJL
         fE9oAHW8PXtvt5ml3mp2+AGtOaroD6qrDpNRi/buLGQBaHMWgC705Pagq7+BVwZd6DlV
         ngJev/eEFMamnBcne2531YjqN3ayu73khO6IbKW++JOXTbc4L6eKcw8RjIqdLLb19FBX
         /P2h3vYC/Tu9fNFDAcvSEZPa6wMkFyi4vJSBMPj/KfVvacfymus7S06s6bB6Kh8kgRGx
         A9Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759809017; x=1760413817;
        h=references:date:in-reply-to:subject:cc:to:from:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLvTrnlB6pwG2/hP8cgIWiHqyjOpePcOnpbnsgYKsys=;
        b=LxxoExikqh5jXdllCF1CHlRH1p1LJpVRnSnqLnyvDhIh74a0qV5GRQP4du0l94iRfb
         1X+A+/mCZTbFIjSkg7eef+37TmUF64+aspE+rj4xzugoEaA7m7BikcqxI8lzi8n2HLwd
         5DBR4z/vUlDixg02e9yVMHf4esa5fYkaFCLEc2Y8C6T4wGnH3nbyUiSTqofoj5/Kf4Sv
         fblvbPj/+fVbQStfoJNI9YC5hWFrXP0hwvhRJjwpD48xkSyOKIwB0rIA3bMlfb3VIdRe
         v1pKbfDzdPtd+WTIFxlBDDRo/Y4+E4u1OwdKt63UB76sUPbpch7hFLMlnvlXAlHSLzGu
         tN3A==
X-Forwarded-Encrypted: i=1; AJvYcCVXyhCYwHIYjzZA7l9g/8zNMAToa8NzbBFjR/cmhMUIYdmaQqth95VxSTwddjIGH0nK1nFU368EnU2BZtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzovL6UjyXyPUvgeWl6o+0sJJbi5uIpxvxctWzkJ8pAbDXbTWoW
	o/n7X9ibOb/mPL+OSuV7t/wf5TX7wT0+tl13OzHnI7XnlkwuJskW1XRZ
X-Gm-Gg: ASbGnctDrF6tXUFHVBBdGIwMz+ERTjI0Hb5u1Ygx+1NeWEuohRQeEIFw3omGOuUPClu
	Rxpt7UkiglBBS4NzAPYueoa31jz+bOjDurPwPxScHG1lmEWvCPFIMcU5QzgCBV2HU5gL+kGXJWE
	17sHChuLRW3vianN9LUu+mvtWrr6ew68+B5eKTDg0lG+JlAWPxa3nIMI883Pa9VmTMCUagFQ/DQ
	NbJonMtMJqFfbh5n2z60T1B7GIKzuwW2l9A88TbnCLroWP4U6fUwzXh/jU2nLt51OjLWxU7rd/W
	9hZdZkx9QlnHMIon1B5TxmPIdxs2iobG8RrQmj/xX0hiJoNcKfUcECTmSw57GRFF0P0/GVnY6BT
	q9O6M1svOl8vi9MMnNztdsn2uupoqRL1MqwZPdaLaN60OGnZC6Q==
X-Google-Smtp-Source: AGHT+IFmjVvttIfnEZ9exjxiEqJx+Nnc0IZMPVpG/NyeFL1NUXZsFyXzVDAXJzYFsL6KxP1hXcUViw==
X-Received: by 2002:a17:903:38d0:b0:269:8f2e:e38 with SMTP id d9443c01a7336-28e9a565f18mr186783675ad.6.1759809016924;
        Mon, 06 Oct 2025 20:50:16 -0700 (PDT)
Received: from dw-tp ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d1b8444sm149114645ad.86.2025.10.06.20.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 20:50:16 -0700 (PDT)
Message-ID: <68e48df8.170a0220.4b4b0.217d@mx.google.com>
X-Google-Original-Message-ID: <875xcrgzs2.fsf@ritesh.list@gmail.com>
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Nam Cao <namcao@linutronix.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>, Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH v2 1/3] powerpc/xive: Untangle xive from child interrupt controller drivers
In-Reply-To: <83968073022a4cc211dcbd0faccd20ec05e58c3e.1754903590.git.namcao@linutronix.de>
Date: Tue, 07 Oct 2025 08:54:13 +0530
References: <cover.1754903590.git.namcao@linutronix.de> <83968073022a4cc211dcbd0faccd20ec05e58c3e.1754903590.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Nam Cao <namcao@linutronix.de> writes:

> xive-specific data is stored in handler_data. This creates a mess, as xive
> has to rely on child interrupt controller drivers to clean up this data, as
> was done by 9a014f45688 ("powerpc/pseries/pci: Add a msi_free() handler to
> clear XIVE data").
>
> Instead, store xive-specific data in chip_data and untangle the child
> drivers.
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v2: no change
> ---
>  arch/powerpc/include/asm/xive.h           |  1 -
>  arch/powerpc/platforms/powernv/pci-ioda.c | 21 +-------
>  arch/powerpc/platforms/pseries/msi.c      | 18 +------
>  arch/powerpc/sysdev/xive/common.c         | 63 +++++++++++------------
>  4 files changed, 33 insertions(+), 70 deletions(-)


Hi Nam, 

I am facing kernel crash on host when trying to run kvm pseries guest on
powernv host. Looking it a bit more closely, I see that we are missing
conversion of xxx_irq_handler_data()) to xxx_irq_chip_data() at few other
places, including in powerpc KVM code. 

<Crash signature>

BUG: Kernel NULL pointer dereference on read at 0x00000010
Faulting instruction address: 0xc0000000001c0704
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=64K MMU=Radix  SMP NR_CPUS=2048 NUMA PowerNV
CPU: 103 UID: 0 PID: 2742 Comm: qemu-system-ppc Not tainted 6.17.0-01737-g50c19e20ed2e #1 NONE
<...>
NIP:  c0000000001c0704 LR: c0000000001c06f8 CTR: 0000000000000000
REGS: c0000000627476a0 TRAP: 0300   Not tainted  (6.17.0-01737-g50c19e20ed2e)
MSR:  9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>  CR: 88044488  XER: 00000036
CFAR: c0000000002c20d8 DAR: 0000000000000010 DSISR: 40000000 IRQMASK: 0 
<...>
NIP [c0000000001c0704] kvmppc_xive_attach_escalation+0x174/0x240
LR [c0000000001c06f8] kvmppc_xive_attach_escalation+0x168/0x240
Call Trace:
  kvmppc_xive_attach_escalation+0x168/0x240 (unreliable)
  kvmppc_xive_connect_vcpu+0x2a0/0x4c0
  kvm_arch_vcpu_ioctl+0x354/0x470
  kvm_vcpu_ioctl+0x488/0x9a0
  sys_ioctl+0x4ec/0x1030
  system_call_exception+0x104/0x2b0
  system_call_vectored_common+0x15c/0x2ec



Here is the diff which fixed this.. 

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 1302b5ac5672..c029c6cc82ef 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -917,7 +917,7 @@ int kvmppc_xive_attach_escalation(struct kvm_vcpu *vcpu, u8 prio,
         */
        if (single_escalation) {
                struct irq_data *d = irq_get_irq_data(xc->esc_virq[prio]);
-               struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
+               struct xive_irq_data *xd = irq_data_get_irq_chip_data(d);

                xive_vm_esb_load(xd, XIVE_ESB_SET_PQ_01);
                vcpu->arch.xive_esc_raddr = xd->eoi_page;
@@ -1612,7 +1612,7 @@ int kvmppc_xive_set_mapped(struct kvm *kvm, unsigned long guest_irq,

        /* Grab info about irq */
        state->pt_number = hw_irq;
-       state->pt_data = irq_data_get_irq_handler_data(host_data);
+       state->pt_data = irq_data_get_irq_chip_data(host_data);

        /*
         * Configure the IRQ to match the existing configuration of
@@ -1788,7 +1788,7 @@ void kvmppc_xive_disable_vcpu_interrupts(struct kvm_vcpu *vcpu)
 void xive_cleanup_single_escalation(struct kvm_vcpu *vcpu, int irq)
 {
        struct irq_data *d = irq_get_irq_data(irq);
-       struct xive_irq_data *xd = irq_data_get_irq_handler_data(d);
+       struct xive_irq_data *xd = irq_data_get_irq_chip_data(d);

        /*
         * This slightly odd sequence gives the right result
@@ -2829,7 +2829,7 @@ int kvmppc_xive_debug_show_queues(struct seq_file *m, struct kvm_vcpu *vcpu)
                if (xc->esc_virq[i]) {
                        struct irq_data *d = irq_get_irq_data(xc->esc_virq[i]);
                        struct xive_irq_data *xd =
-                               irq_data_get_irq_handler_data(d);
+                               irq_data_get_irq_chip_data(d);
                        u64 pq = xive_vm_esb_load(xd, XIVE_ESB_GET);

                        seq_printf(m, "    ESC %d %c%c EOI @%llx",


... However grepping for "handler_data" in arch/powerpc I see there is
atleast one more place where we may still need the fix.. There are few
more places which grep returned - but I am not sure if they all really need
the fix. But I guess VAS should be fixed i.e :

arch/powerpc/platforms/powernv/vas.c:   xd = irq_get_handler_data(vinst->virq);


Would you like to submit an official patch for converting these other places too?


Thanks!
-ritesh


