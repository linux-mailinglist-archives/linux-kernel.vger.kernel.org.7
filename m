Return-Path: <linux-kernel+bounces-784684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9943BB33F9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 005F77B0141
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E133327511C;
	Mon, 25 Aug 2025 12:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="bKMmZ6Pt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148CE270EBB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 12:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756125226; cv=none; b=dUhmhCzZzRTCKztWSsttV7zS81PBkjNIRYWu8R59ZdE1YNOxVdSLVqFvAqvJF2fi1uZW0KDNCMQEMiafueqghF/QkgGDIWOmEwSWQu0cnmAYOMUXhnkL1rmgJbF2KRl5bBHpaPu6/fqybVaZkdMb8YHO81z9ObqnOmC84WSKSiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756125226; c=relaxed/simple;
	bh=QMa0sNT4NpnfTs2DMhQhpq+HGKGuYO3BppK8Vwl/ce0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ITKk7L2oRVT5/zzCXkdunNQw19nGg599ewm6mbIuedlSfpL7TTJNWBAYE9hLCmoXdzRib8b56dWK/+WshwXBdPMYwWgpvuqo//U0B0MhssRWRXdf1lhB0S9+5/n7kWeOTSDrIzO1vpbxAOkGM6nGJNk/pF/OgiEvz4ukiXPL4Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=bKMmZ6Pt; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1756125224; x=1787661224;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QMa0sNT4NpnfTs2DMhQhpq+HGKGuYO3BppK8Vwl/ce0=;
  b=bKMmZ6PtGp2d4Z1JzyHDFK/aeOaNPXAjYqPxf7dBqY02y1Fxf42vOyIP
   WJaF5xWLw6sDDy5164DCwKZfVfAIIWI1dhLax2zow6C2SPgUExIjHs2OD
   9nkaY8vjlbvJ1XvyHfcY3sF0TgjgoLJjOayL335OxJbP10dOEcXySYbqp
   O9NomexuIrOdq7qT3Xh+YWVcdYlbotIsNtyiEwYhX818wLbCViwg5sAtg
   GYslZ9/EZfBxQ/3j5NFo1V7gafNpqJCucKGgqGrAOiXzYvHVSI/DUu+cb
   HPTdpj66TM4+0yYdBO28ID2AbjsekyBIi3PusQya/Qjwd7kaV9rM0Rt6F
   Q==;
X-CSE-ConnectionGUID: vD+TRnYoSjSOrL/NjTIUCQ==
X-CSE-MsgGUID: ey6BbwdvSVuh5Lt0QApCQA==
X-IronPort-AV: E=Sophos;i="6.18,213,1751266800"; 
   d="scan'208";a="46187988"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Aug 2025 05:33:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 25 Aug 2025 05:33:18 -0700
Received: from [10.159.245.205] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.44 via Frontend
 Transport; Mon, 25 Aug 2025 05:33:17 -0700
Message-ID: <0173f6c5-b50e-499d-8c6c-cba236b42336@microchip.com>
Date: Mon, 25 Aug 2025 14:33:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ISSUE + PATCH] Interrupts were enabled early by spinlock guard
To: Edgar Bonet <bonet@grenoble.cnrs.fr>, Thomas Gleixner
	<tglx@linutronix.de>, Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>
CC: <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
References: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
From: Nicolas Ferre <nicolas.ferre@microchip.com>
Content-Language: en-US, fr
Organization: microchip
In-Reply-To: <280dd506-e1fc-4d2e-bdc4-98dd9dca6138@grenoble.cnrs.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit

On 14/08/2025 at 14:59, Edgar Bonet wrote:
> Hello everybody!
> 
> I am facing an "Interrupts were enabled early" kernel warning which, as
> far as I can tell, is caused by a spinlock guard in an ARM/Microchip
> IRQCHIP driver. I think I solved the issue, and I am proposing a patch
> below, after the scissor. But I must first disclose that:
> 
>    * I am completely new to Linux internals and its development process.
>      This is why I chose to err on the side of providing too much
>      information on my issue. It is not unlikely that I am doing
>      something very wrong.
> 
>    * I am not subscribed to either of the linux-{,arm-}kernel mailing
>      lists
> 
>    * I will be far from the Internet in the few days to come. I should be
>      connected an responsive starting from 2025-08-24.

Edgar,

Thanks a lot for having investigated this.


> ## Context
> 
> I am playing with an Acmesystems Acqua[1] system on module, which is
> based on a SAMA5D31 SoC (single core Cortex-A5). I maintain the
> Buildroot defconfig for this board,[2] which is currently based on a
> vanilla Linux kernel v6.12.41.
> 
> As I wanted to check that the board runs fine on newer kernels, I built
> a v6.16 for it using gcc 14, binutils 2.43, the in-tree sama5_defconfig
> merged with this fragment:
> 
>      # CONFIG_BRIDGE is not set
>      # CONFIG_MODULES is not set
>      # CONFIG_NET_DSA is not set
>      # CONFIG_WIRELESS is not set
>      # CONFIG_USB_NET_DRIVERS is not set
>      # CONFIG_WLAN is not set
>      # CONFIG_MEDIA_SUPPORT is not set
>      # CONFIG_SOUND is not set
>      # CONFIG_AUTOFS_FS is not set
> 
> and the Buildroot-provided device tree, patched for compatibility with
> Linux commit 510a6190cf5e ("ARM: dts: microchip: fix faulty ohci/ehci
> node names").
> 
> The defconfig fragment above is meant to remove module support (with
> some unused drivers along the way), which makes testing easier for me.
> 
> 
> ## Issue
> 
> While booting, Linux v6.16 printed this message on the serial console:
> 
>      ------------[ cut here ]------------
>      WARNING: CPU: 0 PID: 0 at init/main.c:1024 start_kernel+0x4d0/0x5dc
>      Interrupts were enabled early
>      CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.16.0 #1 NONE
>      Hardware name: Atmel SAMA5
>      Call trace:
>       unwind_backtrace from show_stack+0x10/0x14
>       show_stack from dump_stack_lvl+0x38/0x48
>       dump_stack_lvl from __warn+0x78/0xd4
>       __warn from warn_slowpath_fmt+0x98/0xc8
>       warn_slowpath_fmt from start_kernel+0x4d0/0x5dc
>       start_kernel from 0x0
>      ---[ end trace 0000000000000000 ]---

Indeed, reproduced on sam9x75 (which has AIC5), on 6.17.0-rc3.

> The board seemed to work fine, so maybe this warning is completely
> harmless. It looked, however, scary enough to deserve some
> investigation.
> 
> 
> ## Bug hunting
> 
> I could not reproduce the issue on a qemu virtual machine. All tests
> were then done on the real hardware.
> 
> I looked for the Linux commit that introduced the issue. ‘git bisect’
> told me this was 195298c3b116 ("genirq/generic-chip: Convert core code
> to lock guards"). I then checked out a recent mainline kernel, namely
> v6.17-rc1, and tried to revert that commit. For this, I first had to
> revert two follow-up commits, namely 7ae844a6650c ("genirq/generic-chip:
> Remove unused lock wrappers") and 771487050f83 ("genirq/generic-chip:
> Fix incorrect lock guard conversions"). This was unsuccessful: I still
> had the warning.
> 
> I went back to a clean v6.17-rc1 and tried to find the thing that was
> enabling interrupts early. After lots of printk() debugging, I
> discovered it was a guard(raw_spinlock_irq) destructor. The call chain
> is this (line numbers are for v6.17-rc1):
> 
>      start_kernel (init/main.c:1011)
>      -> time_init (arch/arm/kernel/time.c:96)
>      -> timer_probe (drivers/clocksource/timer-probe.c:30)
>      => tcb_clksrc_init (drivers/clocksource/timer-atmel-tcb.c:413)
>      -> of_irq_get (drivers/of/irq.c:474)
>      -> irq_create_of_mapping (kernel/irq/irqdomain.c:980)
>      -> irq_create_fwspec_mapping (kernel/irq/irqdomain.c:848)
>      => aic5_irq_domain_xlate (drivers/irqchip/irq-atmel-aic5.c:287)
>      -> guard destructor (raw_spin_unlock_irq?)
> 
> where (=>) is an indirect call through a function pointer.
> 
> 
> ## Tentative fix
> 
> Commit 771487050f83 gave me the inspiration. The guard in question was
> introduced by b00bee8afaca ("irqchip: Convert generic irqchip locking to
> guards"), which replaced calls to irq_gc_lock_irq{save,restore}() by
> guard(raw_spinlock_irq) (with no “save” in the name). The commit log
> states that this is “intended and correct”, but I could not make sense
> of the explanation. My (possibly faulty) understanding is that the guard
> constructor disables interrupts, and the destructor either
> unconditionally enables them (raw_spinlock_irq), or restores the
> previous interrupt state (raw_spinlock_irqsave).
> 
> I then replaced guard(raw_spinlock_irq) with guard(raw_spinlock_irqsave)
> and that seemed to do the job: the warning is gone. See the patch below
> the scissors.
> 
> Best regards, and thank-you for reading so far.
> 
> Edgar Bonet.
> 
> [1] https://www.acmesystems.it/acqua
> [2] https://gitlab.com/buildroot.org/buildroot/-/blob/2025.08-rc1/configs/acmesystems_acqua_a5_512mb_defconfig
> 
> ------------------------------------------------------------------ >8 --
> Subject: [PATCH] irqchip/atmel-aic5: Fix incorrect lock guard conversion
> 
> Commit b00bee8afaca ("irqchip: Convert generic irqchip locking to guards")
> replaced calls to irq_gc_lock_irq{save,restore}() with
> guard(raw_spinlock_irq). However, in irq-atmel-aic5.c, one such guard is
> created early in the boot process, before interrupts are initially enabled.
> As its destructor enables interrupts, this results in the following warning
> on a SAMA5D31-based system:
> 
>      ------------[ cut here ]------------
>      WARNING: CPU: 0 PID: 0 at init/main.c:1024 start_kernel+0x4d0/0x5dc
>      Interrupts were enabled early
>      CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.16.0 #1 NONE
>      Hardware name: Atmel SAMA5
>      Call trace:
>       unwind_backtrace from show_stack+0x10/0x14
>       show_stack from dump_stack_lvl+0x38/0x48
>       dump_stack_lvl from __warn+0x78/0xd4
>       __warn from warn_slowpath_fmt+0x98/0xc8
>       warn_slowpath_fmt from start_kernel+0x4d0/0x5dc
>       start_kernel from 0x0
>      ---[ end trace 0000000000000000 ]---
> 
> Fix this by using guard(raw_spinlock_irqsave) instead.
> 
> Fixes: b00bee8afaca ("irqchip: Convert generic irqchip locking to guards")
> Signed-off-by: Edgar Bonet <bonet@grenoble.cnrs.fr>

Indeed. Thanks for the detailed explanation and the patch:

Tested-by: Nicolas Ferre <nicolas.ferre@microchip.com> # on sam9x75
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com> (if needed)

Best regards,
   Nicolas

> ---
>   drivers/irqchip/irq-atmel-aic5.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
> index 60b00d2c3d7a..1f14b401f71d 100644
> --- a/drivers/irqchip/irq-atmel-aic5.c
> +++ b/drivers/irqchip/irq-atmel-aic5.c
> @@ -279,7 +279,7 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
>          if (ret)
>                  return ret;
> 
> -       guard(raw_spinlock_irq)(&bgc->lock);
> +       guard(raw_spinlock_irqsave)(&bgc->lock);
>          irq_reg_writel(bgc, *out_hwirq, AT91_AIC5_SSR);
>          smr = irq_reg_readl(bgc, AT91_AIC5_SMR);
>          aic_common_set_priority(intspec[2], &smr);
> --
> 2.43.0


