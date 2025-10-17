Return-Path: <linux-kernel+bounces-857840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2363BE80B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8FC5E11BD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D16F3128A7;
	Fri, 17 Oct 2025 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kQOBRHK1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BB23126A4;
	Fri, 17 Oct 2025 10:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760696562; cv=none; b=VIHXMZ60wIrid1ctWcspYvvRqNfOS4NqBc+I6ECabLu8mbefolM9ynk5lSXofDwUT8aUCuugb4obrPnBvp+v1sPaS4+z0lYwUJd/AlWIq9akCXUiETbnbuWCl8z6ySyQjmPKOLguyOvk+2b3QUO7WKDESJ1+EJnYEEMQ3F0nXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760696562; c=relaxed/simple;
	bh=J29C7qGllFOjIrumxRv5kQ5Hz9onW9gxNjMpoF/Jgfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsUzORZlXVNmTP+EboqNFWH+CqTFFB2YykW8dAPx+m0LfCJDkjcZoJRCEMzRj4jqZRuwlnmZVbZsDIlNHNKIibN7PtPoWGLnDvq0EWzVCFyBOzD/ISzmLU5O0UN3sFjig3utczdst7Y/9+nVr4rR3uPC2ixf6hwhJPMjwCe+TE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kQOBRHK1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB05C4CEE7;
	Fri, 17 Oct 2025 10:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760696562;
	bh=J29C7qGllFOjIrumxRv5kQ5Hz9onW9gxNjMpoF/Jgfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kQOBRHK1OSNrB62bkqVugg49AHboGqZ8JWaF4DHTXTgE1hPeRz4t6bpOgr7YA2rQp
	 fQpARbPfRc+U45bYVInwmIZ5bmtlYH49Yqd+u5NbBI4dpOyBv9DYMQ97rnhGvXRan5
	 hOH1J7cQJB/YhGPtEEB41/mDxR3mpMJkpblqu9H4YNf3Apy1gwIb0qUeYO0bGYTfmN
	 H7CIB06qKLQcJ8yycmbiDrRunR0K2fqPANwcotBiJVklVg+iIoUbvWS/8biktdQBl7
	 3IOQfj/xJTo7kT8U1c4O12DM1ArRS2SOu5ieciRhqLE42hzmBr5sSZjiDMeak7rhQK
	 3DQCcPK91Ph1g==
From: Michael Walle <mwalle@kernel.org>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH v1 2/2] arm64: dts: ti: k3-j722s-main: fix the audio refclk source
Date: Fri, 17 Oct 2025 12:22:22 +0200
Message-ID: <20251017102228.530517-2-mwalle@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017102228.530517-1-mwalle@kernel.org>
References: <20251017102228.530517-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

At the moment the clock parent of the audio extclk output is PLL1_HSDIV6
of the main domain. This very clock output is also used among various IP
cores, for example for the USB1 LPM clock. The audio extclock being an
external clock output with a variable frequency, it is likely that a
user of this clock will try to set it's frequency to a different value,
i.e. an audio codec. Because that clock output is used also for other IP
cores, bad things will happen.

Instead of using PLL1_HSDIV6 use the PLL2_HSDIV8 as a sane default, as
this output is exclusively used among other audio peripherals.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---
The original abort happens when sound is played and the codec will try
to change the clock frequency of the audio_extclk. In that case, there
will be a synchronous external abort in the xhci irq handler on our
board. This error only happens on board variants with an attached
on-board USB hub (TUSB8043A) probably because of USB traffic.

This can also reduced to just run k3conf to set the clock manually:
  k3conf set clock 157 15 12000000

That will then produce the following splat:

    Internal error: synchronous external abort: 0000000096000010 [#1]  SMP
    Modules linked in:
    CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G   M                6.18.0-rc1-next-20251016-00042-gde32b6002bba #3076 NONE
    Tainted: [M]=MACHINE_CHECK
    Hardware name: Kontron SMARC-sAM67 (DT)
    pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
    pc : xhci_handle_events.isra.0+0x278/0x14e8
    lr : xhci_irq+0xa4/0x140
    sp : ffff800080003e00
    x29: ffff800080003e60 x28: ffff0008043cc000 x27: 0000000000000000
    x26: ffff000804513a78 x25: ffffbdbfa3b5df40 x24: ffff0008043c9c48
    x23: ffff000803234c60 x22: ffff800081410490 x21: 0000000000000000
    x20: 0000000000000000 x19: ffff0008043c9240 x18: 0000000000000004
    x17: ffff4249db4d5000 x16: ffff800080000000 x15: ffff00097ee690e0
    x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
    x11: 0000000000000040 x10: ffff0008000146f0 x9 : ffffbdbfa240937c
    x8 : ffff000802679fb0 x7 : 0000000000000000 x6 : 0000000000000000
    x5 : ffff000802679f88 x4 : ffff0008043c9284 x3 : 0000000000000078
    x2 : ffff0008043cc000 x1 : ffff000804513a00 x0 : 0000000000000078
    Call trace:
     xhci_handle_events.isra.0+0x278/0x14e8 (P)
     xhci_irq+0xa4/0x140
     usb_hcd_irq+0x38/0x60
     __handle_irq_event_percpu+0x64/0x278
     handle_irq_event+0x4c/0x110
     handle_fasteoi_irq+0x14c/0x270
     handle_irq_desc+0x3c/0x68
     generic_handle_domain_irq+0x24/0x40
     gic_handle_irq+0x138/0x280
     call_on_irq_stack+0x30/0x48
     do_interrupt_handler+0x88/0xa0
     el1_interrupt+0x4c/0xb8
     el1h_64_irq_handler+0x18/0x30
     el1h_64_irq+0x80/0x88
     default_idle_call+0x38/0xf0 (P)
     do_idle+0x22c/0x290
     cpu_startup_entry+0x40/0x50
     rest_init+0xc8/0xd0
     start_kernel+0x8d0/0x8d8
     __primary_switched+0x88/0x98
    Code: eb02031f 54000e80 f8606836 f9400b1c (b94002d6)
    ---[ end trace 0000000000000000 ]---
    Kernel panic - not syncing: synchronous external abort: Fatal exception in interrupt
---
 arch/arm64/boot/dts/ti/k3-j722s-main.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
index 11a1a42e12b1..04de29da40f1 100644
--- a/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j722s-main.dtsi
@@ -468,7 +468,7 @@ audio_refclk0: clock@82e0 {
 		reg = <0x82e0 0x4>;
 		clocks = <&k3_clks 157 0>;
 		assigned-clocks = <&k3_clks 157 0>;
-		assigned-clock-parents = <&k3_clks 157 15>;
+		assigned-clock-parents = <&k3_clks 157 16>;
 		#clock-cells = <0>;
 	};
 
@@ -477,7 +477,7 @@ audio_refclk1: clock@82e4 {
 		reg = <0x82e4 0x4>;
 		clocks = <&k3_clks 157 18>;
 		assigned-clocks = <&k3_clks 157 18>;
-		assigned-clock-parents = <&k3_clks 157 33>;
+		assigned-clock-parents = <&k3_clks 157 34>;
 		#clock-cells = <0>;
 	};
 };
-- 
2.47.3


