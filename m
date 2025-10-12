Return-Path: <linux-kernel+bounces-849419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAD2BD011E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 13:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D28B04E2CFA
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 11:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA5E25487C;
	Sun, 12 Oct 2025 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UGty87Tj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2792206BF;
	Sun, 12 Oct 2025 11:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760267897; cv=none; b=RgvYLfr8ln8WDny9VSn3Z84kKZprSsj/33ZsmjKOX7C8kjeQxPAXrur3gT68WytVTDoeBDqa9/uWiUwb1GhpA9ugBAABIJMImEiNtROfwr0j7dFFRuRpxgThvZw4vkQkCnvjcijZv+Cf8yUnNZrFUYa0YEAIOq+OJJ0UCDQNyjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760267897; c=relaxed/simple;
	bh=WwjM/NVDwCnN6H65ZRXmemBzec+LMNHK+A15tAIrQBo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXOyQLZYBntkNluBUZmsy2i63uMCSSVBRuhoYTdOcj5ufFvD6RY0Dg3Wi3tPVE7IRkHzTa6u5J3XDJyRZfHg3uadDfL4Zi/cZmnKdRvoa2Xs6MLAIPlzbnTV76Kxre7rmIFxopITRkfDM2INx4W4FE/vJeOEiQ0Zx0azC/VlrGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UGty87Tj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6218C4CEE7;
	Sun, 12 Oct 2025 11:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760267896;
	bh=WwjM/NVDwCnN6H65ZRXmemBzec+LMNHK+A15tAIrQBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UGty87Tj2mJ5MimSuFVtrliAG4l6qg7uY2Dzx2rEuGh55VhH3c9UIVZWTK81cY84v
	 6W9bJMKLNxyKoqyVgy81EzIZAw0y+D1/UR9P27vf82nAWgCGLxnQNLtMMO1a5v6//y
	 22bAoopCZiF0eErTEmQ3CZBQHZtoVh3xztOW+8wU=
Date: Sun, 12 Oct 2025 13:18:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: linux-sound@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
	broonie@kernel.org, cryolitia@uniontech.com,
	linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.dev,
	quic_wcheng@quicinc.com, syzkaller@googlegroups.com
Subject: Re: [Linux Kernel Bug] general protection fault in
 try_to_register_card
Message-ID: <2025101225-lisp-monkhood-af34@gregkh>
References: <CANypQFYtQxHL5ghREs-BujZG413RPJGnO5TH=xjFBKpPts33tA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANypQFYtQxHL5ghREs-BujZG413RPJGnO5TH=xjFBKpPts33tA@mail.gmail.com>

On Sun, Oct 12, 2025 at 07:11:53PM +0800, Jiaming Zhang wrote:
> Dear Linux kernel developers and maintainers:
> 
> We are writing to report a general protection fault discovered in the
> kernel with our modified syzkaller. This bug is reproducible on the
> latest version (commit 67029a49db6c1f21106a1b5fcdd0ea234a6e0711).
> 
> The kernel console output, kernel config, syzkaller reproducer, and C
> reproducer are attached to this email to help analysis. The KASAN
> report from kernel (commit 67029a49), formatted by syz-symbolize, is
> listed below:
> 
> ==================================================================
> e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
> usb 1-1: new full-speed USB device number 2 using dummy_hcd
> usb 1-1: not running at top speed; connect to a high speed hub
> usb 1-1: config 2 has an invalid interface number: 131 but max is 3
> usb 1-1: config 2 has an invalid interface number: 160 but max is 3
> usb 1-1: config 2 has an invalid descriptor of length 0, skipping
> remainder of the config
> usb 1-1: config 2 has 2 interfaces, different from the descriptor's value: 4
> usb 1-1: config 2 has no interface number 0
> usb 1-1: config 2 has no interface number 1
> usb 1-1: config 2 interface 160 altsetting 9 has an invalid descriptor
> for endpoint zero, skipping
> usb 1-1: config 2 interface 160 altsetting 9 has 2 endpoint
> descriptors, different from the interface descriptor's value: 16
> usb 1-1: config 2 interface 131 has no altsetting 0
> usb 1-1: config 2 interface 160 has no altsetting 0
> usb 1-1: New USB device found, idVendor=0dba, idProduct=5000, bcdDevice=3a.c9
> usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> usb 1-1: Product: syz
> usb 1-1: Manufacturer: syz
> usb 1-1: SerialNumber: syz
> usb 1-1: MBOX3: Initialized.
> Oops: general protection fault, probably for non-canonical address
> 0xdffffc000000001c: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x00000000000000e0-0x00000000000000e7]
> CPU: 1 UID: 0 PID: 793 Comm: kworker/1:2 Not tainted
> 6.17.0-12904-g67029a49db6c #1 PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Workqueue: usb_hub_wq hub_event
> RIP: 0010:usb_interface_claimed include/linux/usb.h:918 [inline]
> RIP: 0010:try_to_register_card+0x248/0x300 sound/usb/card.c:896
> Code: de cd 30 f9 49 8b 3f 44 89 f6 e8 43 e5 fa fd 49 89 c6 49 81 c6
> e0 00 00 00 4c 89 f0 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c
> 08 00 74 08 4c 89 f7 e8 aa cd 30 f9 49 83 3e 00 74 73 e8 ff
> RSP: 0018:ffffc9000462eb80 EFLAGS: 00010202
> RAX: 000000000000001c RBX: ffff888049b02a30 RCX: dffffc0000000000
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000000a0
> RBP: ffffc9000462ec30 R08: ffffc9000462e9e7 R09: 1ffff920008c5d3c
> R10: dffffc0000000000 R11: ffffffff88f59950 R12: 00000000000000f8
> R13: 1ffff11009360559 R14: 00000000000000e0 R15: ffff888049b02a38
> FS:  0000000000000000(0000) GS:ffff8880ec976000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f86fb0e16f8 CR3: 0000000028a6b000 CR4: 0000000000752ef0
> PKRU: 55555554
> Call Trace:
>  <TASK>
>  usb_audio_probe+0x143f/0x1e60 sound/usb/card.c:1039


So you are probably creating an invalid usb audio device without a
proper interface here, right?  Care to make up a simple patch for this
so that you get the credit for fixing the issue as you can test it
easily?

thanks,

greg k-h

