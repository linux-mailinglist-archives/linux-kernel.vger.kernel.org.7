Return-Path: <linux-kernel+bounces-818376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A12D8B590D6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1CC4860BD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 08:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F285277C96;
	Tue, 16 Sep 2025 08:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pt8bbZmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BB47464
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011801; cv=none; b=gMKw3SztvtX2LwnhC+JY9jce1Y3+ekbbGbX9UBoUcCWrY9BnyZNdeDXubZHoWi0acewwSZzQonbtJztS74K7UJoUp+m1OKNjfYOAJvNtZRVL2zBLdzUwU3VEJH7C4Xx1PrHY06hhQctvgVUXA6G3PF+riWaXEOsCdXn0GHaNd8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011801; c=relaxed/simple;
	bh=ju8Mp54XDQsMzYe6AB6PoaNYWvcfvkiaCUodkLma9cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jbvyqnwo0J5YOgRUqR84swpKNIH8g9rZer7EhYjxD1I6vg12EssniDmHlQICDSUjfoC9ybiC9kX5hBlmNPooTnyJ2sVAzmvheV2aa9DrkCTKC+/+nBq+mZ4rMKoWlJzj43c8s7KuKhotk6jgdKo0zbQoh8uoDI0kIXVIoFQlAcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pt8bbZmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7073C4CEEB;
	Tue, 16 Sep 2025 08:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758011801;
	bh=ju8Mp54XDQsMzYe6AB6PoaNYWvcfvkiaCUodkLma9cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pt8bbZmGvUfWIBZ+AGUxpr76hPK96q+l8iXXE7S/ooxMLvxbqQywF9Reot4ZBXnmY
	 Xkc2qwlTQ87ADsPUa/y+gN8vmX3CulsfWwjCoeziViGqNB3gzgmH2hl9Dq0LNKoRqn
	 EF7jnEZUktuwMi8ATAVGtLEXgfZzCzOJGiS5xpWg=
Date: Tue, 16 Sep 2025 10:36:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Juergen Gross <jgross@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2023-53283: xen/virtio: Fix NULL deref when a bridge of PCI
 root bus has no parent
Message-ID: <2025091624-reluctant-earphone-21a8@gregkh>
References: <2025091624-CVE-2023-53283-674c@gregkh>
 <46cc57c6-bb57-4423-9fb2-37b5563c4dee@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46cc57c6-bb57-4423-9fb2-37b5563c4dee@suse.com>

On Tue, Sep 16, 2025 at 10:29:26AM +0200, Juergen Gross wrote:
> On 16.09.25 10:11, Greg Kroah-Hartman wrote:
> > From: Greg Kroah-Hartman <gregkh@kernel.org>
> > 
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > xen/virtio: Fix NULL deref when a bridge of PCI root bus has no parent
> > 
> > When attempting to run Xen on a QEMU/KVM virtual machine with virtio
> > devices (all x86_64), function xen_dt_get_node() crashes on accessing
> > bus->bridge->parent->of_node because a bridge of the PCI root bus has no
> > parent set:
> > 
> > [    1.694192][    T1] BUG: kernel NULL pointer dereference, address: 0000000000000288
> > [    1.695688][    T1] #PF: supervisor read access in kernel mode
> > [    1.696297][    T1] #PF: error_code(0x0000) - not-present page
> > [    1.696297][    T1] PGD 0 P4D 0
> > [    1.696297][    T1] Oops: 0000 [#1] PREEMPT SMP NOPTI
> > [    1.696297][    T1] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.3.7-1-default #1 openSUSE Tumbleweed a577eae57964bb7e83477b5a5645a1781df990f0
> > [    1.696297][    T1] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.15.0-0-g2dd4b9b-rebuilt.opensuse.org 04/01/2014
> > [    1.696297][    T1] RIP: e030:xen_virtio_restricted_mem_acc+0xd9/0x1c0
> > [    1.696297][    T1] Code: 45 0c 83 e8 c9 a3 ea ff 31 c0 eb d7 48 8b 87 40 ff ff ff 48 89 c2 48 8b 40 10 48 85 c0 75 f4 48 8b 82 10 01 00 00 48 8b 40 40 <48> 83 b8 88 02 00 00 00 0f 84 45 ff ff ff 66 90 31 c0 eb a5 48 89
> > [    1.696297][    T1] RSP: e02b:ffffc90040013cc8 EFLAGS: 00010246
> > [    1.696297][    T1] RAX: 0000000000000000 RBX: ffff888006c75000 RCX: 0000000000000029
> > [    1.696297][    T1] RDX: ffff888005ed1000 RSI: ffffc900400f100c RDI: ffff888005ee30d0
> > [    1.696297][    T1] RBP: ffff888006c75010 R08: 0000000000000001 R09: 0000000330000006
> > [    1.696297][    T1] R10: ffff888005850028 R11: 0000000000000002 R12: ffffffff830439a0
> > [    1.696297][    T1] R13: 0000000000000000 R14: ffff888005657900 R15: ffff888006e3e1e8
> > [    1.696297][    T1] FS:  0000000000000000(0000) GS:ffff88804a000000(0000) knlGS:0000000000000000
> > [    1.696297][    T1] CS:  e030 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [    1.696297][    T1] CR2: 0000000000000288 CR3: 0000000002e36000 CR4: 0000000000050660
> > [    1.696297][    T1] Call Trace:
> > [    1.696297][    T1]  <TASK>
> > [    1.696297][    T1]  virtio_features_ok+0x1b/0xd0
> > [    1.696297][    T1]  virtio_dev_probe+0x19c/0x270
> > [    1.696297][    T1]  really_probe+0x19b/0x3e0
> > [    1.696297][    T1]  __driver_probe_device+0x78/0x160
> > [    1.696297][    T1]  driver_probe_device+0x1f/0x90
> > [    1.696297][    T1]  __driver_attach+0xd2/0x1c0
> > [    1.696297][    T1]  bus_for_each_dev+0x74/0xc0
> > [    1.696297][    T1]  bus_add_driver+0x116/0x220
> > [    1.696297][    T1]  driver_register+0x59/0x100
> > [    1.696297][    T1]  virtio_console_init+0x7f/0x110
> > [    1.696297][    T1]  do_one_initcall+0x47/0x220
> > [    1.696297][    T1]  kernel_init_freeable+0x328/0x480
> > [    1.696297][    T1]  kernel_init+0x1a/0x1c0
> > [    1.696297][    T1]  ret_from_fork+0x29/0x50
> > [    1.696297][    T1]  </TASK>
> > [    1.696297][    T1] Modules linked in:
> > [    1.696297][    T1] CR2: 0000000000000288
> > [    1.696297][    T1] ---[ end trace 0000000000000000 ]---
> > 
> > The PCI root bus is in this case created from ACPI description via
> > acpi_pci_root_add() -> pci_acpi_scan_root() -> acpi_pci_root_create() ->
> > pci_create_root_bus() where the last function is called with
> > parent=NULL. It indicates that no parent is present and then
> > bus->bridge->parent is NULL too.
> > 
> > Fix the problem by checking bus->bridge->parent in xen_dt_get_node() for
> > NULL first.
> > 
> > The Linux kernel CVE team has assigned CVE-2023-53283 to this issue.
> 
> Please revoke this CVE. There is no way an unprivileged user could trigger
> this issue.

Normal users can't spin up qemu instances?  How does someone "start Xen"
like this?  I thought any user could do that, or is this restricted to
only root users somehow?  And if "somehow", what is that?

thanks,

greg k-h

