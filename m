Return-Path: <linux-kernel+bounces-818428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40927B5919C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 11:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144C27A0FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95E2E8B81;
	Tue, 16 Sep 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qrAbF1AL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B048299AAA
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758013301; cv=none; b=E0wDEe1W/xRcnD1Up5+y5hLegf+5YbSU3OhSRJfeN5kkNzKWJHoDyKHuwuDvz06Xr8IlEF3IyS6wXMjwcbPYYT2trTbXhVG5X1Vx9ZUIp4TVjF+u6eZnqJ8SVa0zl1EuKaycPhvPT9sB+cqc1994Kkjm/JGcPztS5FX/PeCkxwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758013301; c=relaxed/simple;
	bh=Qgr+7e3MMYu3JwYl4awFTc14X9n9RznxE7tO2zj4BRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNuO8UBaeh/nLzLqfuR5vk2UtH3moWTAkt2yGwRUWRpoaz/N00BNqJg3trnyszk7jfejrwosKWhWOsRuBTddFQ5FfCwENW0YEE8FoY8jUno6qpxsolWVEQ33f1ELMwYCEeuJ4RY2Ab9nVKdGXYjESZb6b5m6ZWHgoezvyADjvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qrAbF1AL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41532C4CEF7;
	Tue, 16 Sep 2025 09:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758013300;
	bh=Qgr+7e3MMYu3JwYl4awFTc14X9n9RznxE7tO2zj4BRw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qrAbF1ALjcpBTEr/pEanhi1fE9+ojbmBTKiogAsiLPLRFOLEBuYm3YLpBPNYOHols
	 M890oJYMCB6AWeJgrk0dPtySXtQqxqg/xiAOO10qNrMwSGC7QWZDu+4JNURKudzuuY
	 s2u3uYD8k3ehKKuGpnMnTTUaKzRrgWt+/rcxyYc0=
Date: Tue, 16 Sep 2025 11:01:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-53283: xen/virtio: Fix NULL deref when a bridge of PCI
 root bus has no parent
Message-ID: <2025091610-esquire-jokester-b91c@gregkh>
References: <2025091624-CVE-2023-53283-674c@gregkh>
 <46cc57c6-bb57-4423-9fb2-37b5563c4dee@suse.com>
 <2025091624-reluctant-earphone-21a8@gregkh>
 <af378199-d525-4358-a2b5-0e5393756ff1@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <af378199-d525-4358-a2b5-0e5393756ff1@suse.com>

On Tue, Sep 16, 2025 at 10:51:51AM +0200, Jürgen Groß wrote:
> On 16.09.25 10:36, Greg KH wrote:
> > On Tue, Sep 16, 2025 at 10:29:26AM +0200, Juergen Gross wrote:
> > > On 16.09.25 10:11, Greg Kroah-Hartman wrote:
> > > > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > > > 
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > xen/virtio: Fix NULL deref when a bridge of PCI root bus has no parent
> > > > 
> > > > When attempting to run Xen on a QEMU/KVM virtual machine with virtio
> > > > devices (all x86_64), function xen_dt_get_node() crashes on accessing
> > > > bus->bridge->parent->of_node because a bridge of the PCI root bus has no
> > > > parent set:
> > > > 
> > > > [    1.694192][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000288
> > > > [    1.695688][    T1] #PF: supervisor read access in kernel mode
> > > > [    1.696297][    T1] #PF: error_code(0x0000) - not-present page
> > > > [    1.696297][    T1] PGD 0 P4D 0
> > > > [    1.696297][    T1] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > > > [    1.696297][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.7-1-default #1 openSUSE Tumbleweed a577eae57964bb7e83477b5a5645a1781df990f0
> > > > [    1.696297][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> > > > [    1.696297][    T1] RIP: e030:xen_virtio_restricted_mem_acc+0xd9/0x1c0
> > > > [    1.696297][    T1] Code: 45 0c 83 e8 c9 a3 ea ff 31 c0 eb d7 48 8b 87 40 ff ff ff 48 89 c2 48 8b 40 10 48 85 c0 75 f4 48 8b 82 10 01 00 00 48 8b 40 40 <48> 83 b8 88 02 00 00 00 0f 84 45 ff ff ff 66 90 31 c0 eb a5 48 89
> > > > [    1.696297][    T1] RSP: e02b:ffffc90040013cc8 EFLAGS: 00010246
> > > > [    1.696297][    T1] RAX: 0000000000000000 RBX: ffff888006c75000 RCX: 0000000000000029
> > > > [    1.696297][    T1] RDX: ffff888005ed1000 RSI: ffffc900400f100c RDI: ffff888005ee30d0
> > > > [    1.696297][    T1] RBP: ffff888006c75010 R08: 0000000000000001 R09: 0000000330000006
> > > > [    1.696297][    T1] R10: ffff888005850028 R11: 0000000000000002 R12: ffffffff830439a0
> > > > [    1.696297][    T1] R13: 0000000000000000 R14: ffff888005657900 R15: ffff888006e3e1e8
> > > > [    1.696297][    T1] FS:  0000000000000000(0000) GS:ffff88804a000000(0000) knlGS:0000000000000000
> > > > [    1.696297][    T1] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [    1.696297][    T1] CR2: 0000000000000288 CR3: 0000000002e36000 CR4: 0000000000050660
> > > > [    1.696297][    T1] Call Trace:
> > > > [    1.696297][    T1]  <TASK>
> > > > [    1.696297][    T1]  virtio_features_ok+0x1b/0xd0
> > > > [    1.696297][    T1]  virtio_dev_probe+0x19c/0x270
> > > > [    1.696297][    T1]  really_probe+0x19b/0x3e0
> > > > [    1.696297][    T1]  __driver_probe_device+0x78/0x160
> > > > [    1.696297][    T1]  driver_probe_device+0x1f/0x90
> > > > [    1.696297][    T1]  __driver_attach+0xd2/0x1c0
> > > > [    1.696297][    T1]  bus_for_each_dev+0x74/0xc0
> > > > [    1.696297][    T1]  bus_add_driver+0x116/0x220
> > > > [    1.696297][    T1]  driver_register+0x59/0x100
> > > > [    1.696297][    T1]  virtio_console_init+0x7f/0x110
> > > > [    1.696297][    T1]  do_one_initcall+0x47/0x220
> > > > [    1.696297][    T1]  kernel_init_freeable+0x328/0x480
> > > > [    1.696297][    T1]  kernel_init+0x1a/0x1c0
> > > > [    1.696297][    T1]  ret_from_fork+0x29/0x50
> > > > [    1.696297][    T1]  </TASK>
> > > > [    1.696297][    T1] Modules linked in:
> > > > [    1.696297][    T1] CR2: 0000000000000288
> > > > [    1.696297][    T1] ---[ end trace 0000000000000000 ]---
> > > > 
> > > > The PCI root bus is in this case created from ACPI description via
> > > > acpi_pci_root_add() -> pci_acpi_scan_root() -> acpi_pci_root_create() ->
> > > > pci_create_root_bus() where the last function is called with
> > > > parent=NULL. It indicates that no parent is present and then
> > > > bus->bridge->parent is NULL too.
> > > > 
> > > > Fix the problem by checking bus->bridge->parent in xen_dt_get_node() for
> > > > NULL first.
> > > > 
> > > > The Linux kernel CVE team has assigned CVE-2023-53283 to this issue.
> > > 
> > > Please revoke this CVE. There is no way an unprivileged user could trigger
> > > this issue.
> > 
> > Normal users can't spin up qemu instances?  How does someone "start Xen"
> > like this?  I thought any user could do that, or is this restricted to
> > only root users somehow?  And if "somehow", what is that?
> 
> This crash has been observed when running Xen inside a KVM guest. The crash
> happened in the dom0 of that Xen instance. So anyone being capable to start
> this KVM guest is able to cause this crash, but the same person can just
> terminate the KVM guest causing the same "damage". I don't think someone
> controlling the KVM guest can be called "unprivileged" regarding the guest.

Ah, I missed that it was just the guest that is crashing here, that
makes more sense, thank you.  I'll go revoke it now.

greg k-h

