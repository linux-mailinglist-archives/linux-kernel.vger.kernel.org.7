Return-Path: <linux-kernel+bounces-722539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F439AFDBCD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:23:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474C71AA31F3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB0A235067;
	Tue,  8 Jul 2025 23:23:13 +0000 (UTC)
Received: from audible.transient.net (audible.transient.net [24.143.126.66])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 061A41E3769
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=24.143.126.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752016992; cv=none; b=HgiCU8z2cfrKy80/Nk4gTMfJ176alypIJESaxDpKEHkasTuQ/H5dVzzOcIoO/IpLL4C1fiArgOZ4Svq+mX6y6hSSqsDwP+8RvchYo2knh1JU7eKjRWH7Yth/v+f0gWaffl3QqQTFXuxjUbg8xYgQZOSW9KkEkK9kQekTHiVndwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752016992; c=relaxed/simple;
	bh=TZAhQpEiBafFvR2IUq9keG5YazIKkFbgepqwBHKWmsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRtmRk5ZvfRVCOo+NMnGTUmEwfRfYsd2ZaNuZFQWdN4p2A2DcogE1X4nBFPMiWhrx+ZTXd7YN17XNn04ibIuCn41KplvG6HnRBLC8RrJj87fA3gexnsayHAQxQ17e7JJpq7mbhNquCSZjHAgBx5ddRDG9lkae3qcPpkkshaC+KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=audible.transient.net; spf=pass smtp.mailfrom=audible.transient.net; arc=none smtp.client-ip=24.143.126.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=audible.transient.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=audible.transient.net
Received: (qmail 4351 invoked from network); 8 Jul 2025 23:16:28 -0000
Received: from cucamonga.audible.transient.net (192.168.2.5)
  by canarsie.audible.transient.net with QMQP; 8 Jul 2025 23:16:28 -0000
Received: (nullmailer pid 16665 invoked by uid 1000);
	Tue, 08 Jul 2025 23:16:28 -0000
Date: Tue, 8 Jul 2025 23:16:28 +0000
From: Jamie Heilman <jamie@audible.transient.net>
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: bskeggs@nvidia.com, airlied@gmail.com, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] NVIDIA ION graphics broken with Linux 6.16-rc*
Message-ID: <aG2mzB58k3tkxvK-@audible.transient.net>
Mail-Followup-To: Rui Salvaterra <rsalvaterra@gmail.com>,
	bskeggs@nvidia.com, airlied@gmail.com,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
References: <CALjTZvZgH0N43rMTcZiDVSX93PFL680hsYPwtp8=Ja1OWPvZ1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALjTZvZgH0N43rMTcZiDVSX93PFL680hsYPwtp8=Ja1OWPvZ1A@mail.gmail.com>

Rui Salvaterra wrote:
> Hi,
> 
> 
> The machine (Atom 330 CPU, ION chipset, GeForce 9400M graphics) works,
> but graphics are dead. Dmesg shows the following (Linux 6.16-rc5):
>
> [   34.408331] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   34.408351] #PF: supervisor instruction fetch in kernel mode
> [   34.408358] #PF: error_code(0x0010) - not-present page
> [   34.408364] PGD 0 P4D 0
> [   34.408373] Oops: Oops: 0010 [#1] SMP
> [   34.408383] CPU: 2 UID: 0 PID: 583 Comm: Xorg Not tainted
> 6.16.0-rc5-dbg+ #187 PREEMPTLAZY
> [   34.408393] Hardware name: To Be Filled By O.E.M. To Be Filled By
> O.E.M./To be filled by O.E.M., BIOS 080015  08/13/2009
> [   34.408399] RIP: 0010:0x0
> [   34.408414] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   34.408420] RSP: 0018:ffff88800378bc08 EFLAGS: 00010202
> [   34.408428] RAX: ffffffff82071c60 RBX: ffff888008e6f000 RCX: 0000000000000978
> [   34.408434] RDX: 0000000000000020 RSI: 0000000000000002 RDI: ffff888008e6f000
> [   34.408440] RBP: ffff88800378bd18 R08: 0000000000000000 R09: 00000000000003ff
> [   34.408445] R10: 0000000000000000 R11: ffff88800378bcc0 R12: ffff88800378bdb8
> [   34.408451] R13: ffff888007dad9c0 R14: ffff888004285680 R15: ffff888007e671c0
> [   34.408457] FS:  00007f2cc7b2eb00(0000) GS:ffff888149ecf000(0000)
> knlGS:0000000000000000
> [   34.408464] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   34.408469] CR2: ffffffffffffffd6 CR3: 0000000008a08000 CR4: 00000000000006f0
> [   34.408475] Call Trace:
> [   34.408482]  <TASK>
> [   34.408486]  nouveau_gem_ioctl_pushbuf+0x10d8/0x1240
> [   34.408504]  ? nouveau_gem_ioctl_new+0x160/0x160
> [   34.408513]  drm_ioctl_kernel+0x7a/0xe0
> [   34.408524]  drm_ioctl+0x1ef/0x490
> [   34.408532]  ? nouveau_gem_ioctl_new+0x160/0x160
> [   34.408541]  ? __handle_mm_fault+0xff2/0x1510
> [   34.408552]  nouveau_drm_ioctl+0x50/0xa0
> [   34.408560]  __x64_sys_ioctl+0x4be/0xa90
> [   34.408570]  ? handle_mm_fault+0xb5/0x1a0
> [   34.408578]  ? lock_mm_and_find_vma+0x34/0x170
> [   34.408587]  do_syscall_64+0x51/0x1d0
> [   34.408596]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
> [   34.408605] RIP: 0033:0x7f2cc7d2f9dd
> [   34.408612] Code: 04 25 28 00 00 00 48 89 45 c8 31 c0 48 8d 45 10
> c7 45 b0 10 00 00 00 48 89 45 b8 48 8d 45 d0 48 89 45 c0 b8 10 00 00
> 00 0f 05 <89> c2 3d 00 f0 ff ff 77 1a 48 8b 45 c8 64 48 2b 04 25 28 00
> 00 00
> [   34.408620] RSP: 002b:00007fff6a501ee0 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000010
> [   34.408628] RAX: ffffffffffffffda RBX: 000055c7792b3f78 RCX: 00007f2cc7d2f9dd
> [   34.408634] RDX: 00007fff6a501fa0 RSI: 00000000c0406481 RDI: 0000000000000011
> [   34.408640] RBP: 00007fff6a501f30 R08: 0000000000000978 R09: 000055c7792af740
> [   34.408645] R10: 0000000000000002 R11: 0000000000000246 R12: 00007fff6a501fa0
> [   34.408651] R13: 00000000c0406481 R14: 0000000000000011 R15: 000055c7792ac700
> [   34.408660]  </TASK>
> [   34.408664] Modules linked in:
> [   34.408671] CR2: 0000000000000000
> [   34.408678] ---[ end trace 0000000000000000 ]---
> [   34.408682] RIP: 0010:0x0
> [   34.408691] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
> [   34.408696] RSP: 0018:ffff88800378bc08 EFLAGS: 00010202
> [   34.408703] RAX: ffffffff82071c60 RBX: ffff888008e6f000 RCX: 0000000000000978
> [   34.408709] RDX: 0000000000000020 RSI: 0000000000000002 RDI: ffff888008e6f000
> [   34.408715] RBP: ffff88800378bd18 R08: 0000000000000000 R09: 00000000000003ff
> [   34.408720] R10: 0000000000000000 R11: ffff88800378bcc0 R12: ffff88800378bdb8
> [   34.408726] R13: ffff888007dad9c0 R14: ffff888004285680 R15: ffff888007e671c0
> [   34.408731] FS:  00007f2cc7b2eb00(0000) GS:ffff888149ecf000(0000)
> knlGS:0000000000000000
> [   34.408738] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   34.408743] CR2: ffffffffffffffd6 CR3: 0000000008a08000 CR4: 00000000000006f0
> [   34.408750] note: Xorg[583] exited with irqs disabled
> 
> Unfortunately, bisecting is not feasible for me.

That looks pretty similar to the problem I posted
(https://lore.kernel.org/lkml/aElJIo9_Se6tAR1a@audible.transient.net/)
that I bisected to 862450a85b85 ("drm/nouveau/gf100-: track chan
progress with non-WFI semaphore release").  It still reverts cleanly
as of v6.16-rc5 so you might want to give that a shot.

-- 
Jamie Heilman                     http://audible.transient.net/~jamie/

