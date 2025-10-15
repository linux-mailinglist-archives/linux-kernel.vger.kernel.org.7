Return-Path: <linux-kernel+bounces-853563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A71EDBDBFCC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:32:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9C66B4E1F03
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04877223DF1;
	Wed, 15 Oct 2025 01:32:29 +0000 (UTC)
Received: from vps.thesusis.net (vps.thesusis.net [34.202.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B1118024
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760491948; cv=none; b=AFjDZ7iXJ8oR4QKbe75AYTS9yw3DFW8GUZIjuBaRmccTkFRJUzgNpD95EIS3sT27RJ6YS1V3NwT7Zjk0FDv6rYnwf3QIztSvqqv5HgwrJ/524IoClevWrOz+LVwMdrWuBJgfr2Ld2wG5y2uRPP2Ri2TtrGbzJ0JVkQts1lAB64o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760491948; c=relaxed/simple;
	bh=MQesz4Y9pPUgeDHQgGlnKXTkwEj2Kkzga3lWDS72h+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tg8cMeIg4iJZ/TC0NNv41X9ueJYW9R9svtD8MEJG7X5LvyriAR3P/TDQJYVAhlvvdLpZwvbNLKt/29WV2x0QeqznIiU2DpnhoxKDjrF2FsdYclmwEESK64SfaW3F3IS5yAW8pQUngi2Fcj7sDsHuEeC58KIT2EsFboxvnETal20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net; spf=pass smtp.mailfrom=thesusis.net; arc=none smtp.client-ip=34.202.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thesusis.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thesusis.net
Received: by vps.thesusis.net (Postfix, from userid 1000)
	id 01522B823B; Tue, 14 Oct 2025 21:22:53 -0400 (EDT)
From: Phillip Susi <phill@thesusis.net>
To: linux-kernel@vger.kernel.org
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>, Mathias Nyman
 <mathias.nyman@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Subject: Suspend regression in v6.18-rc1
Date: Tue, 14 Oct 2025 21:22:53 -0400
Message-ID: <871pn5j6vm.fsf@vps.thesusis.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I have a suspend regression in v6.18-rc1 that results in this in my
dmesg when I try to suspend:

[   36.739259] Freezing remaining freezable tasks
[   36.740378] Freezing remaining freezable tasks completed (elapsed 0.001 seconds)
[   36.740414] printk: Suspending console(s) (use no_console_suspend to debug)
[   36.783363] xhci_hcd 0000:51:00.0: Root hub is not suspended
[   36.783366] xhci_hcd 0000:51:00.0: PM: pci_pm_suspend(): hcd_pci_suspend [usbcore] returns -16
[   36.783378] xhci_hcd 0000:51:00.0: PM: dpm_run_callback(): pci_pm_suspend returns -16
[   36.783383] xhci_hcd 0000:51:00.0: PM: failed to suspend async: error
-16

I have bisected it to this commit:

commit 719de070f764e079cdcb4ddeeb5b19b3ddddf9c1 (HEAD)
Author: Niklas Neronin <niklas.neronin@linux.intel.com>
Date:   Thu Sep 18 00:07:22 2025 +0300

    usb: xhci-pci: add support for hosts with zero USB3 ports
    
    Add xhci support for PCI hosts that have zero USB3 ports.
    Avoid creating a shared Host Controller Driver (HCD) when there is only
    one root hub. Additionally, all references to 'xhci->shared_hcd' are now
    checked before use.
    
    Only xhci-pci.c requires modification to accommodate this change, as the
    xhci core already supports configurations with zero USB3 ports. This
    capability was introduced when xHCI Platform and MediaTek added support
    for zero USB3 ports.
    
    Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220181
    Tested-by: Nick Nielsen <nick.kainielsen@free.fr>
    Tested-by: grm1 <grm1@mailbox.org>
    Signed-off-by: Niklas Neronin <niklas.neronin@linux.intel.com>
    Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
    Link: https://lore.kernel.org/r/20250917210726.97100-4-mathias.nyman@linux.intel.com
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It sounds like it may be related to these errors that I have had on this
system since I built it last year:

Oct 14 20:55:36 faldara kernel: hub 10-0:1.0: USB hub found
Oct 14 20:55:36 faldara kernel: hub 10-0:1.0: config failed, hub doesn't
have any ports! (err -19)

I believe this system has a usb hub with "zero ports" that this patch
was meant to fix, but up until now, has only resulted in this beign
dmesg error.  I no longer see this error after this commit.

This is an ASrock 650E Taichi Lite motherboard I built last year.

What additional information can I provide?

