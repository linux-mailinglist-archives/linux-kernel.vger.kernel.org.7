Return-Path: <linux-kernel+bounces-784463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8392BB33C37
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38331178E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 420FA235041;
	Mon, 25 Aug 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b="StxPP5S0"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C714EC62
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116631; cv=none; b=tAK910LinEFgNOHRkiTbxXiR9IHeWRbXiaEZn6oEi7CkJRmUAP0s30xbXpILtRnjBGDA5L2UlmluMkctwIzXCtcT44y2nR5VV9oDzlmg7KhPtMMoHdeI/ZPIppkgiJXz+PLTlqMCTOukFp5Enb0r2upTInjo25sbWC9OIUwoqLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116631; c=relaxed/simple;
	bh=RkW1/PtgZt5XQuwMW5DRWPFu+neCHpj1FR2SPbTAWYg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EtxuTexC4wk99Uh6jesW1/bd9rzJ4Y7b5dx1Rw8m1CjuMS61ANEAZZzS2gCzff33AadVWnaBB30bCj6e4ZdB4706WMU/HHNB1bTwzNOAHsV0ntpHsEZcNCqWu8EzLOnSzUW8x+vkqtiq1uzbMlAY9Eq0aC0FZqgb07xOoLN8UHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=efault@gmx.de header.b=StxPP5S0; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756116621; x=1756721421; i=efault@gmx.de;
	bh=MLkccgtnXhsx+LVL/k60B8ytUjVy7nx21G+8lA3NgVc=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=StxPP5S0WPKSTGhOmuoeEBYfnhNy8yekpL6iI9LRO3uu0XYd2/9INKSaJCb6c/My
	 9aAvC4xjW0dFBnETVrccvxi3joKUHlAOi7c2rgymv55fnWzxd7kfuoNz5wUR9O98i
	 nidpRiAX47M1KTx5mNopPhQXx0E2n1aQ/vDDlTqM54uu9hSVu3WWj6wxXiYi/SYtz
	 DOPBQQ91VnEJbqDETGXwIS/RrP3Yg9GgE03cr9+OansgflzxVBXFrNhA/3I1Bf3Pn
	 xZWrd59f/4fywLWuJqG8bJ1nl8HOisTue6eUlMKqD/QOTMOxNZ5ugkC/wW0sPlPtN
	 K0UWY/0S2UxuG96LvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.50.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M2f9b-1uo0uY2tHb-00AAyE; Mon, 25
 Aug 2025 12:10:21 +0200
Message-ID: <de02114842041993402e3e774bcd84020e06e828.camel@gmx.de>
Subject: Re: netpoll:  raspberrypi [4 5]  driver locking woes
From: Mike Galbraith <efault@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Robert Hancock <robert.hancock@calian.com>, Doug Berger
 <opendmb@gmail.com>,  Florian Fainelli <florian.fainelli@broadcom.com>,
 Breno Leitao <leitao@debian.org>
Date: Mon, 25 Aug 2025 12:10:21 +0200
In-Reply-To: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
References: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
Autocrypt: addr=efault@gmx.de;
 keydata=mQGiBE/h0fkRBACJWa+2g5r12ej5DQZEpm0cgmzjpwc9mo6Jz7PFSkDQGeNG8wGwFzFPKQrLk1JRdqNSq37FgtFDDYlYOzVyO/6rKp0Iar2Oel4tbzlUewaYWUWTTAtJoTC0vf4p9Aybyo9wjor+XNvPehtdiPvCWdONKZuGJHKFpemjXXj7lb9ifwCg7PLKdz/VMBFlvbIEDsweR0olMykD/0uSutpvD3tcTItitX230Z849Wue3cA1wsOFD3N6uTg3GmDZDz7IZF+jJ0kKt9xL8AedZGMHPmYNWD3Hwh2gxLjendZlcakFfCizgjLZF3O7k/xIj7Hr7YqBSUj5Whkbrn06CqXSRE0oCsA/rBitUHGAPguJfgETbtDNqx8RYJA2A/9PnmyAoqH33hMYO+k8pafEgXUXwxWbhx2hlWEgwFovcBPLtukH6mMVKXS4iik9obfPEKLwW1mmz0eoHzbNE3tS1AaagHDhOqnSMGDOjogsUACZjCJEe1ET4JHZWFM7iszyolEhuHbnz2ajwLL9Ge8uJrLATreszJd57u+NhAyEW7QeTWlrZSBHYWxicmFpdGggPGVmYXVsdEBnbXguZGU+iGIEExECACIFAk/h0fkCGyMGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEMYmACnGfbb41A4AnjscsLm5ep+DSi7Bv8BmmoBGTCRnAJ9oXX0KtnBDttPkgUbaiDX56Z1+crkBDQRP4dH5EAQAtYCgoXJvq8VqoleWvqcNScHLrN4LkFxfGkDdqTyQe/79rDWr8su+8TH1ATZ/k+lC6W+vg7ygrdyOK7egA5u+T/GBA1VN+KqcqGqAEZqCLvjorKVQ6mgb5FfXouSGvtsblbRMireEEhJqIQPndq3DvZbKXHVkKrUBcco4MMGDVucABAsEAKXKCwGVEVuYcM/KdT2htDpziRH4JfUn3Ts2EC6F7rXIQ4NaIA6gAvL6HdD3q
	y6yrWaxyqUg8CnZF/J5HR+IvRK+vu85xxwSLQsrVONH0Ita1jg2nhUW7yLZer8xrhxIuYCqrMgreo5BAA3+irHy37rmqiAFZcnDnCNDtJ4sz48tiEkEGBECAAkFAk/h0fkCGwwACgkQxiYAKcZ9tvgIMQCeIcgjSxwbGiGn2q/cv8IvHf1r/DIAnivw+bGITqTU7rhgfwe07dhBoIdz
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:3of/kmLZgaIPIAfrpub/WZj4mHiS1kmMBLwu59fFhqHmnTMQJ6Y
 qMxsy9eRt8BXh1+UR7eAiLPbbsIzSIv+EqZf7HfWoPiAMfTLx7Dw7G94cyOrpnBTm0ASsa2
 gOVEE9rClqYrEISob3bCWrx/pwwYRfwUPNgARxFjvVn5rz8XtKx0k61CDCZJzL8LYOSwkBl
 390fvbwm6UsRhwrwy+tHw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sBKR3z5Ib70=;08NEYXI9n5fXtl/Wr83xeQ1/pMH
 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
 151LS6NhRTzN6rRAieiT7CkzEYMn

On Mon, 2025-08-25 at 07:53 +0200, Mike Galbraith wrote:
>=20
> On the pi4, lockdep muttered about ring->lock in bcmgenet_xmit() and
> bcmgenet_tx_poll() - switching to irqsave/restore spinlock variants
> there silenced it.

The deadlock splat below.

[   90.529661] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
[   90.535817] WARNING: HARDIRQ-safe -> HARDIRQ-unsafe lock order detected
[   90.542508] 6.17.0-rc2-v8-lockdep #529 Tainted: G         C        =20
[   90.548929] -----------------------------------------------------
[   90.555092] swapper/0/0 [HC0[0]:SC1[1]:HE0:SE0] is trying to acquire:
[   90.561605] ffffff8102518d48 (&ring->lock){+.-.}-{3:3}, at: bcmgenet_xmi=
t+0x78/0x860
[   90.569439]=20
[   90.569439] and this task is already holding:
[   90.575341] ffffffd6357c3298 (target_list_lock){..-.}-{3:3}, at: write_m=
sg+0x60/0x1b0 [netconsole]
[   90.584408] which would create a new lock dependency:
[   90.589507]  (target_list_lock){..-.}-{3:3} -> (&ring->lock){+.-.}-{3:3}
[   90.596283]=20
[   90.596283] but this new dependency connects a HARDIRQ-irq-safe lock:
[   90.604305]  (&host->lock){-.-.}-{3:3}
[   90.604322]=20
[   90.604322] ... which became HARDIRQ-irq-safe at:
[   90.614339]   lock_acquire+0x1d4/0x368
[   90.618124]   _raw_spin_lock+0x50/0x70
[   90.621899]   bcm2835_mmc_irq+0x28/0x8c8
[   90.625870]   __handle_irq_event_percpu+0x94/0x318
[   90.630699]   handle_irq_event+0x54/0xb8
[   90.634668]   handle_fasteoi_irq+0x12c/0x270
[   90.638980]   handle_irq_desc+0x48/0x68
[   90.642846]   generic_handle_domain_irq+0x24/0x38
[   90.647603]   gic_handle_irq+0x48/0xd8
[   90.651391]   call_on_irq_stack+0x30/0x70
[   90.655435]   do_interrupt_handler+0xdc/0xe8
[   90.659762]   el1_interrupt+0x34/0x68
[   90.663450]   el1h_64_irq_handler+0x18/0x28
[   90.667674]   el1h_64_irq+0x6c/0x70
[   90.671195]   d_alloc_parallel+0x3dc/0x9e8
[   90.675332]   __lookup_slow+0x98/0x188
[   90.679112]   lookup_noperm+0x74/0x88
[   90.682810]   simple_start_creating+0x70/0xe8
[   90.687209]   start_creating+0x7c/0x110
[   90.691082]   __debugfs_create_file+0x54/0x230
[   90.695577]   debugfs_create_file_unsafe+0x28/0x40
[   90.700413]   debugfs_create_u32+0x78/0x90
[   90.704562]   link_and_create_debugfs+0x78/0xf8
[   90.709127]   _regulator_get_common+0x14c/0x398
[   90.713716]   _regulator_get+0x48/0xa0
[   90.717489]   _devm_regulator_get+0x60/0xb0
[   90.721720]   devm_regulator_get_optional+0x1c/0x30
[   90.726649]   mmc_regulator_get_supply+0x48/0x1c8
[   90.731402]   sdhci_setup_host+0x904/0xd30
[   90.735534]   sdhci_add_host+0x20/0x60
[   90.739325]   sdhci_iproc_probe+0xc8/0x108
[   90.743462]   platform_probe+0x64/0xa8
[   90.747246]   really_probe+0xc4/0x2a8
[   90.750937]   __driver_probe_device+0x80/0x140
[   90.755432]   driver_probe_device+0xe0/0x170
[   90.759739]   __device_attach_driver+0xc0/0x148
[   90.764322]   bus_for_each_drv+0x88/0xf0
[   90.768282]   __device_attach_async_helper+0xb8/0xe8
[   90.773300]   async_run_entry_fn+0x3c/0xf0
[   90.777436]   process_one_work+0x20c/0x5e8
[   90.781573]   worker_thread+0x1c8/0x378
[   90.785448]   kthread+0x168/0x230
[   90.788792]   ret_from_fork+0x10/0x20
[   90.792488]=20
[   90.792488] to a HARDIRQ-irq-unsafe lock:
[   90.798033]  (&ring->lock){+.-.}-{3:3}
[   90.798051]=20
[   90.798051] ... which became HARDIRQ-irq-unsafe at:
[   90.808240] ...
[   90.808245]   lock_acquire+0x1d4/0x368
[   90.813784]   _raw_spin_lock+0x50/0x70
[   90.817570]   bcmgenet_xmit+0x78/0x860
[   90.821359]   dev_hard_start_xmit+0xc0/0x2d0
[   90.825671]   sch_direct_xmit+0x98/0x1e8
[   90.829633]   __dev_queue_xmit+0x5a0/0x13a8
[   90.833856]   packet_xmit+0xcc/0x150
[   90.837465]   packet_sendmsg+0x8e8/0x1328
[   90.841515]   __sock_sendmsg+0x64/0xc0
[   90.845295]   ____sys_sendmsg+0x270/0x2b0
[   90.849343]   ___sys_sendmsg+0x88/0xf0
[   90.853133]   __sys_sendmsg+0x88/0x100
[   90.856913]   __arm64_sys_sendmsg+0x2c/0x40
[   90.861138]   invoke_syscall+0x50/0x120
[   90.865011]   el0_svc_common.constprop.0+0x48/0xf0
[   90.869851]   do_el0_svc+0x24/0x38
[   90.873290]   el0_svc+0x4c/0x178
[   90.876543]   el0t_64_sync_handler+0xa0/0xe8
[   90.880858]   el0t_64_sync+0x198/0x1a0
[   90.884644]=20
[   90.884644] other info that might help us debug this:
[   90.884644]=20
[   90.892742] Chain exists of:
[   90.892742]   &host->lock --> target_list_lock --> &ring->lock
[   90.892742]=20
[   90.903035]  Possible interrupt unsafe locking scenario:
[   90.903035]=20
[   90.909901]        CPU0                    CPU1
[   90.914482]        ----                    ----
[   90.919060]   lock(&ring->lock);
[   90.922311]                                local_irq_disable();
[   90.928297]                                lock(&host->lock);
[   90.934107]                                lock(target_list_lock);
[   90.940356]   <Interrupt>
[   90.943001]     lock(&host->lock);
[   90.946430]=20
[   90.946430]  *** DEADLOCK ***
[   90.946430]=20
[   90.952419] 12 locks held by swapper/0/0:
[   90.956468]  #0: ffffff8100049948 ((wq_completion)events_bh_highpri){+.-=
.}-{0:0}, at: process_one_work+0x190/0x5e8
[   90.966944]  #1: ffffffc080003e60 ((work_completion)(&bh->bh)){+.-.}-{0:=
0}, at: process_one_work+0x1b8/0x5e8
[   90.976885]  #2: ffffff81082f2230 (&dev->event_lock){..-.}-{3:3}, at: in=
put_event+0x50/0xb8
[   90.985339]  #3: ffffffd6a169c3c8 (rcu_read_lock){....}-{1:3}, at: input=
_pass_values+0x38/0x2e8
[   90.994141]  #4: ffffffd6a169c3c8 (rcu_read_lock){....}-{1:3}, at: __han=
dle_sysrq+0x8/0x308
[   91.002591]  #5: ffffffd6a162a8e8 (console_lock){+.+.}-{0:0}, at: vprint=
k_default+0x40/0x58
[   91.011041]  #6: ffffffd6a162a940 (console_srcu){....}-{0:0}, at: consol=
e_flush_all+0x88/0x4a8
[   91.019751]  #7: ffffffd6a162ab00 (console_owner){..-.}-{0:0}, at: conso=
le_lock_spinning_enable+0x50/0x90
[   91.029437]  #8: ffffffd6a162ab28 (printk_legacy_map-wait-type-override)=
{....}-{4:4}, at: console_flush_all+0x2a0/0x4a8
[   91.040346]  #9: ffffffd6357c3298 (target_list_lock){..-.}-{3:3}, at: wr=
ite_msg+0x60/0x1b0 [netconsole]
[   91.049854]  #10: ffffffd6a169c3c8 (rcu_read_lock){....}-{1:3}, at: netp=
oll_send_skb+0x4c/0x4b0
[   91.058655]  #11: ffffff8108050118 (_xmit_ETHER#2){+.-.}-{3:3}, at: netp=
oll_send_skb+0x3e4/0x4b0
[   91.067545]=20
[   91.067545] the dependencies between HARDIRQ-irq-safe lock and the holdi=
ng lock:
[   91.076524]   -> (&host->lock){-.-.}-{3:3} {
[   91.080836]      IN-HARDIRQ-W at:
[   91.084181]                         lock_acquire+0x1d4/0x368
[   91.089907]                         _raw_spin_lock+0x50/0x70
[   91.095623]                         bcm2835_mmc_irq+0x28/0x8c8
[   91.101520]                         __handle_irq_event_percpu+0x94/0x318
[   91.108301]                         handle_irq_event+0x54/0xb8
[   91.114198]                         handle_fasteoi_irq+0x12c/0x270
[   91.120450]                         handle_irq_desc+0x48/0x68
[   91.126259]                         generic_handle_domain_irq+0x24/0x38
[   91.132944]                         gic_handle_irq+0x48/0xd8
[   91.138669]                         call_on_irq_stack+0x30/0x70
[   91.144655]                         do_interrupt_handler+0xdc/0xe8
[   91.150904]                         el1_interrupt+0x34/0x68
[   91.156538]                         el1h_64_irq_handler+0x18/0x28
[   91.162699]                         el1h_64_irq+0x6c/0x70
[   91.168156]                         d_alloc_parallel+0x3dc/0x9e8
[   91.174230]                         __lookup_slow+0x98/0x188
[   91.179951]                         lookup_noperm+0x74/0x88
[   91.185582]                         simple_start_creating+0x70/0xe8
[   91.191919]                         start_creating+0x7c/0x110
[   91.197739]                         __debugfs_create_file+0x54/0x230
[   91.204164]                         debugfs_create_file_unsafe+0x28/0x40
[   91.210927]                         debugfs_create_u32+0x78/0x90
[   91.217009]                         link_and_create_debugfs+0x78/0xf8
[   91.223517]                         _regulator_get_common+0x14c/0x398
[   91.230028]                         _regulator_get+0x48/0xa0
[   91.235752]                         _devm_regulator_get+0x60/0xb0
[   91.241910]                         devm_regulator_get_optional+0x1c/0x3=
0
[   91.248773]                         mmc_regulator_get_supply+0x48/0x1c8
[   91.255461]                         sdhci_setup_host+0x904/0xd30
[   91.261535]                         sdhci_add_host+0x20/0x60
[   91.267260]                         sdhci_iproc_probe+0xc8/0x108
[   91.273330]                         platform_probe+0x64/0xa8
[   91.279058]                         really_probe+0xc4/0x2a8
[   91.284684]                         __driver_probe_device+0x80/0x140
[   91.291118]                         driver_probe_device+0xe0/0x170
[   91.297367]                         __device_attach_driver+0xc0/0x148
[   91.303881]                         bus_for_each_drv+0x88/0xf0
[   91.309781]                         __device_attach_async_helper+0xb8/0x=
e8
[   91.316734]                         async_run_entry_fn+0x3c/0xf0
[   91.322804]                         process_one_work+0x20c/0x5e8
[   91.328878]                         worker_thread+0x1c8/0x378
[   91.334686]                         kthread+0x168/0x230
[   91.339969]                         ret_from_fork+0x10/0x20
[   91.345605]      IN-SOFTIRQ-W at:
[   91.348943]                         lock_acquire+0x1d4/0x368
[   91.354671]                         _raw_spin_lock_irqsave+0x60/0x90
[   91.361097]                         bcm2835_mmc_tasklet_finish+0x20/0x10=
0
[   91.367962]                         tasklet_action_common+0x1a4/0x1c8
[   91.374476]                         tasklet_action+0x48/0x60
[   91.380187]                         handle_softirqs+0x144/0x528
[   91.386175]                         __do_softirq+0x1c/0x28
[   91.391725]                         ____do_softirq+0x18/0x30
[   91.397444]                         call_on_irq_stack+0x30/0x70
[   91.403434]                         do_softirq_own_stack+0x24/0x38
[   91.409679]                         __irq_exit_rcu+0x100/0x1f8
[   91.415580]                         irq_exit_rcu+0x18/0x58
[   91.421126]                         el1_interrupt+0x38/0x68
[   91.426759]                         el1h_64_irq_handler+0x18/0x28
[   91.432921]                         el1h_64_irq+0x6c/0x70
[   91.438377]                         _raw_spin_unlock_irqrestore+0x6c/0xa=
0
[   91.445237]                         bcm2835_mmc_request+0x64/0xc8
[   91.451405]                         __mmc_start_request+0x7c/0x158
[   91.457654]                         mmc_start_request+0xa0/0xf0
[   91.463640]                         mmc_wait_for_req+0x78/0x110
[   91.469620]                         mmc_wait_for_cmd+0x6c/0xb0
[   91.475522]                         sdio_reset+0x60/0x138
[   91.480972]                         mmc_rescan+0x2bc/0x338
[   91.486518]                         process_one_work+0x20c/0x5e8
[   91.492594]                         worker_thread+0x1c8/0x378
[   91.498402]                         kthread+0x168/0x230
[   91.503683]                         ret_from_fork+0x10/0x20
[   91.509316]      INITIAL USE at:
[   91.512586]                        lock_acquire+0x1d4/0x368
[   91.518205]                        _raw_spin_lock_irqsave+0x60/0x90
[   91.524557]                        bcm2835_mmc_reset+0x34/0x238
[   91.530529]                        bcm2835_mmc_probe+0x1a0/0x730
[   91.536616]                        platform_probe+0x64/0xa8
[   91.542248]                        really_probe+0xc4/0x2a8
[   91.547794]                        __driver_probe_device+0x80/0x140
[   91.554131]                        driver_probe_device+0xe0/0x170
[   91.560293]                        __device_attach_driver+0xc0/0x148
[   91.566719]                        bus_for_each_drv+0x88/0xf0
[   91.572514]                        __device_attach+0xa4/0x198
[   91.578336]                        device_initial_probe+0x1c/0x30
[   91.584498]                        bus_probe_device+0xb4/0xc0
[   91.590308]                        deferred_probe_work_func+0x90/0xd8
[   91.596822]                        process_one_work+0x20c/0x5e8
[   91.602793]                        worker_thread+0x1c8/0x378
[   91.608528]                        kthread+0x168/0x230
[   91.613721]                        ret_from_fork+0x10/0x20
[   91.619253]    }
[   91.621101]    ... key      at: [<ffffffd6a234d8d8>] __key.2+0x0/0x10
[   91.627629]  -> (console_owner){..-.}-{0:0} {
[   91.632029]     IN-SOFTIRQ-W at:
[   91.635272]                       lock_acquire+0x1d4/0x368
[   91.640831]                       console_lock_spinning_enable+0x74/0x90
[   91.647609]                       console_flush_all+0x2ac/0x4a8
[   91.653594]                       console_unlock+0x84/0x188
[   91.659228]                       vprintk_emit+0x24c/0x450
[   91.664772]                       vprintk_default+0x40/0x58
[   91.670406]                       vprintk+0x3c/0x80
[   91.675335]                       _printk+0x64/0x98
[   91.680264]                       __handle_sysrq+0x1ec/0x308
[   91.685985]                       sysrq_filter+0xcc/0x518
[   91.691442]                       input_handle_events_filter+0x58/0xc0
[   91.698030]                       input_pass_values+0x1fc/0x2e8
[   91.704029]                       input_handle_event+0x450/0x558
[   91.710090]                       input_event+0x6c/0xb8
[   91.715384]                       hidinput_report_event+0x4c/0x78
[   91.721545]                       hid_report_raw_event+0xb4/0x418
[   91.727707]                       hid_input_report+0x138/0x1a0
[   91.733604]                       hid_irq_in+0x180/0x308
[   91.738959]                       __usb_hcd_giveback_urb+0x98/0x160
[   91.745310]                       usb_giveback_urb_bh+0xb0/0x150
[   91.751371]                       process_one_work+0x20c/0x5e8
[   91.757281]                       bh_worker+0x1b0/0x218
[   91.762563]                       workqueue_softirq_action+0x80/0x98
[   91.768988]                       tasklet_hi_action+0x20/0x60
[   91.774784]                       handle_softirqs+0x144/0x528
[   91.780607]                       __do_softirq+0x1c/0x28
[   91.785976]                       ____do_softirq+0x18/0x30
[   91.791522]                       call_on_irq_stack+0x30/0x70
[   91.797331]                       do_softirq_own_stack+0x24/0x38
[   91.803404]                       __irq_exit_rcu+0x100/0x1f8
[   91.809113]                       irq_exit_rcu+0x18/0x58
[   91.814494]                       el1_interrupt+0x38/0x68
[   91.819951]                       el1h_64_irq_handler+0x18/0x28
[   91.825938]                       el1h_64_irq+0x6c/0x70
[   91.831219]                       default_idle_call+0x84/0x140
[   91.837104]                       do_idle+0x22c/0x298
[   91.842208]                       cpu_startup_entry+0x3c/0x50
[   91.848030]                       rest_init+0x108/0x1a0
[   91.853312]                       start_kernel+0x760/0x8c8
[   91.858856]                       __primary_switched+0x88/0x98
[   91.864742]     INITIAL USE at:
[   91.867923]                      lock_acquire+0x1d4/0x368
[   91.873368]                      console_lock_spinning_enable+0x74/0x90
[   91.880063]                      console_flush_all+0x2ac/0x4a8
[   91.885955]                      console_unlock+0x84/0x188
[   91.891506]                      vprintk_emit+0x24c/0x450
[   91.896963]                      vprintk_default+0x40/0x58
[   91.902508]                      vprintk+0x3c/0x80
[   91.907349]                      _printk+0x64/0x98
[   91.912191]                      register_console+0x3a8/0x4e0
[   91.918000]                      con_init+0x1c8/0x270
[   91.923106]                      console_init+0x98/0x2a0
[   91.928474]                      start_kernel+0x4e8/0x8c8
[   91.933931]                      __primary_switched+0x88/0x98
[   91.939741]   }
[   91.941495]   ... key      at: [<ffffffd6a162ab00>] console_owner_dep_ma=
p+0x0/0x28
[   91.949158]   ... acquired at:
[   91.952233]    console_lock_spinning_enable+0x74/0x90
[   91.957345]    console_flush_all+0x2ac/0x4a8
[   91.961664]    console_unlock+0x84/0x188
[   91.965625]    vprintk_emit+0x24c/0x450
[   91.969485]    vprintk_default+0x40/0x58
[   91.973447]    vprintk+0x3c/0x80
[   91.976703]    _printk+0x64/0x98
[   91.979964]    bcm2835_mmc_send_command+0x944/0xa08
[   91.984894]    bcm2835_mmc_request+0x58/0xc8
[   91.989207]    __mmc_start_request+0x7c/0x158
[   91.993603]    mmc_start_request+0xa0/0xf0
[   91.997745]    mmc_wait_for_req+0x78/0x110
[   92.001876]    mmc_wait_for_cmd+0x6c/0xb0
[   92.005931]    sdio_reset+0x60/0x138
[   92.009547]    mmc_rescan+0x2bc/0x338
[   92.013231]    process_one_work+0x20c/0x5e8
[   92.017461]    worker_thread+0x1c8/0x378
[   92.021421]    kthread+0x168/0x230
[   92.024855]    ret_from_fork+0x10/0x20
[   92.028640]=20
[   92.030136] -> (target_list_lock){..-.}-{3:3} {
[   92.034720]    IN-SOFTIRQ-W at:
[   92.037882]                     lock_acquire+0x1d4/0x368
[   92.043251]                     _raw_spin_lock_irqsave+0x60/0x90
[   92.049324]                     write_msg+0x60/0x1b0 [netconsole]
[   92.055486]                     console_flush_all+0x2e4/0x4a8
[   92.061296]                     console_unlock+0x84/0x188
[   92.066753]                     vprintk_emit+0x24c/0x450
[   92.072122]                     vprintk_default+0x40/0x58
[   92.077579]                     vprintk+0x3c/0x80
[   92.082332]                     _printk+0x64/0x98
[   92.087091]                     __handle_sysrq+0x1ec/0x308
[   92.092636]                     sysrq_filter+0xcc/0x518
[   92.097911]                     input_handle_events_filter+0x58/0xc0
[   92.104337]                     input_pass_values+0x1fc/0x2e8
[   92.110152]                     input_handle_event+0x450/0x558
[   92.116044]                     input_event+0x6c/0xb8
[   92.121144]                     hidinput_report_event+0x4c/0x78
[   92.127129]                     hid_report_raw_event+0xb4/0x418
[   92.133120]                     hid_input_report+0x138/0x1a0
[   92.138835]                     hid_irq_in+0x180/0x308
[   92.144034]                     __usb_hcd_giveback_urb+0x98/0x160
[   92.150189]                     usb_giveback_urb_bh+0xb0/0x150
[   92.156093]                     process_one_work+0x20c/0x5e8
[   92.161815]                     bh_worker+0x1b0/0x218
[   92.166919]                     workqueue_softirq_action+0x80/0x98
[   92.173168]                     tasklet_hi_action+0x20/0x60
[   92.178802]                     handle_softirqs+0x144/0x528
[   92.184435]                     __do_softirq+0x1c/0x28
[   92.189629]                     ____do_softirq+0x18/0x30
[   92.194993]                     call_on_irq_stack+0x30/0x70
[   92.200630]                     do_softirq_own_stack+0x24/0x38
[   92.206529]                     __irq_exit_rcu+0x100/0x1f8
[   92.212074]                     irq_exit_rcu+0x18/0x58
[   92.217267]                     el1_interrupt+0x38/0x68
[   92.222548]                     el1h_64_irq_handler+0x18/0x28
[   92.228357]                     el1h_64_irq+0x6c/0x70
[   92.233462]                     default_idle_call+0x84/0x140
[   92.239184]                     do_idle+0x22c/0x298
[   92.244112]                     cpu_startup_entry+0x3c/0x50
[   92.249746]                     rest_init+0x108/0x1a0
[   92.254852]                     start_kernel+0x760/0x8c8
[   92.260221]                     __primary_switched+0x88/0x98
[   92.265942]    INITIAL USE at:
[   92.269022]                    lock_acquire+0x1d4/0x368
[   92.274303]                    _raw_spin_lock_irqsave+0x60/0x90
[   92.280289]                    make_netconsole_target+0xe4/0x1d0 [netcon=
sole]
[   92.287507]                    configfs_mkdir+0x184/0x4c0
[   92.292964]                    vfs_mkdir+0x1a8/0x280
[   92.297981]                    do_mkdirat+0x140/0x180
[   92.303086]                    __arm64_sys_mkdirat+0x38/0x58
[   92.308807]                    invoke_syscall+0x50/0x120
[   92.314173]                    el0_svc_common.constprop.0+0x48/0xf0
[   92.320514]                    do_el0_svc+0x24/0x38
[   92.325444]                    el0_svc+0x4c/0x178
[   92.330195]                    el0t_64_sync_handler+0xa0/0xe8
[   92.336005]                    el0t_64_sync+0x198/0x1a0
[   92.341282]  }
[   92.342961]  ... key      at: [<ffffffd6357c3298>] target_list_lock+0x18=
/0xffffffffffffed80 [netconsole]
[   92.352553]  ... acquired at:
[   92.355542]    _raw_spin_lock_irqsave+0x60/0x90
[   92.360123]    write_msg+0x60/0x1b0 [netconsole]
[   92.364789]    console_flush_all+0x2e4/0x4a8
[   92.369099]    console_unlock+0x84/0x188
[   92.373062]    vprintk_emit+0x24c/0x450
[   92.376932]    vprintk_default+0x40/0x58
[   92.380894]    vprintk+0x3c/0x80
[   92.384150]    _printk+0x64/0x98
[   92.387407]    __handle_sysrq+0x1ec/0x308
[   92.391458]    sysrq_filter+0xcc/0x518
[   92.395242]    input_handle_events_filter+0x58/0xc0
[   92.400172]    input_pass_values+0x1fc/0x2e8
[   92.404486]    input_handle_event+0x450/0x558
[   92.408885]    input_event+0x6c/0xb8
[   92.412495]    hidinput_report_event+0x4c/0x78
[   92.416984]    hid_report_raw_event+0xb4/0x418
[   92.421471]    hid_input_report+0x138/0x1a0
[   92.425697]    hid_irq_in+0x180/0x308
[   92.429394]    __usb_hcd_giveback_urb+0x98/0x160
[   92.434059]    usb_giveback_urb_bh+0xb0/0x150
[   92.438461]    process_one_work+0x20c/0x5e8
[   92.442687]    bh_worker+0x1b0/0x218
[   92.446294]    workqueue_softirq_action+0x80/0x98
[   92.451050]    tasklet_hi_action+0x20/0x60
[   92.455185]    handle_softirqs+0x144/0x528
[   92.459322]    __do_softirq+0x1c/0x28
[   92.463020]    ____do_softirq+0x18/0x30
[   92.466892]    call_on_irq_stack+0x30/0x70
[   92.471030]    do_softirq_own_stack+0x24/0x38
[   92.475429]    __irq_exit_rcu+0x100/0x1f8
[   92.479478]    irq_exit_rcu+0x18/0x58
[   92.483177]    el1_interrupt+0x38/0x68
[   92.486960]    el1h_64_irq_handler+0x18/0x28
[   92.491273]    el1h_64_irq+0x6c/0x70
[   92.494882]    default_idle_call+0x84/0x140
[   92.499107]    do_idle+0x22c/0x298
[   92.502541]    cpu_startup_entry+0x3c/0x50
[   92.506677]    rest_init+0x108/0x1a0
[   92.510287]    start_kernel+0x760/0x8c8
[   92.514160]    __primary_switched+0x88/0x98
[   92.518383]=20
[   92.519881]=20
[   92.519881] the dependencies between the lock to be acquired
[   92.519887]  and HARDIRQ-irq-unsafe lock:
[   92.531155] -> (&ring->lock){+.-.}-{3:3} {
[   92.535283]    HARDIRQ-ON-W at:
[   92.538452]                     lock_acquire+0x1d4/0x368
[   92.543821]                     _raw_spin_lock+0x50/0x70
[   92.549190]                     bcmgenet_xmit+0x78/0x860
[   92.554559]                     dev_hard_start_xmit+0xc0/0x2d0
[   92.560458]                     sch_direct_xmit+0x98/0x1e8
[   92.566001]                     __dev_queue_xmit+0x5a0/0x13a8
[   92.571813]                     packet_xmit+0xcc/0x150
[   92.577004]                     packet_sendmsg+0x8e8/0x1328
[   92.582637]                     __sock_sendmsg+0x64/0xc0
[   92.588006]                     ____sys_sendmsg+0x270/0x2b0
[   92.593640]                     ___sys_sendmsg+0x88/0xf0
[   92.599009]                     __sys_sendmsg+0x88/0x100
[   92.604380]                     __arm64_sys_sendmsg+0x2c/0x40
[   92.610188]                     invoke_syscall+0x50/0x120
[   92.615644]                     el0_svc_common.constprop.0+0x48/0xf0
[   92.622072]                     do_el0_svc+0x24/0x38
[   92.627088]                     el0_svc+0x4c/0x178
[   92.631929]                     el0t_64_sync_handler+0xa0/0xe8
[   92.637827]                     el0t_64_sync+0x198/0x1a0
[   92.643195]    IN-SOFTIRQ-W at:
[   92.646364]                     lock_acquire+0x1d4/0x368
[   92.651733]                     _raw_spin_lock+0x50/0x70
[   92.657104]                     bcmgenet_tx_poll+0x30/0xe8
[   92.662647]                     __napi_poll.constprop.0+0x44/0x268
[   92.668898]                     net_rx_action+0x320/0x390
[   92.674355]                     handle_softirqs+0x144/0x528
[   92.679987]                     __do_softirq+0x1c/0x28
[   92.685178]                     ____do_softirq+0x18/0x30
[   92.690549]                     call_on_irq_stack+0x30/0x70
[   92.696183]                     do_softirq_own_stack+0x24/0x38
[   92.702079]                     __irq_exit_rcu+0x100/0x1f8
[   92.707625]                     irq_exit_rcu+0x18/0x58
[   92.712818]                     el0_interrupt+0x60/0x138
[   92.718195]                     __el0_irq_handler_common+0x18/0x28
[   92.724438]                     el0t_64_irq_handler+0x10/0x20
[   92.730254]                     el0t_64_irq+0x198/0x1a0
[   92.735529]    INITIAL USE at:
[   92.738608]                    lock_acquire+0x1d4/0x368
[   92.743890]                    _raw_spin_lock+0x50/0x70
[   92.749171]                    bcmgenet_xmit+0x78/0x860
[   92.754452]                    dev_hard_start_xmit+0xc0/0x2d0
[   92.760262]                    sch_direct_xmit+0x98/0x1e8
[   92.765720]                    __dev_queue_xmit+0x5a0/0x13a8
[   92.771440]                    packet_xmit+0xcc/0x150
[   92.776552]                    packet_sendmsg+0x8e8/0x1328
[   92.782091]                    __sock_sendmsg+0x64/0xc0
[   92.787374]                    ____sys_sendmsg+0x270/0x2b0
[   92.792918]                    ___sys_sendmsg+0x88/0xf0
[   92.798198]                    __sys_sendmsg+0x88/0x100
[   92.803479]                    __arm64_sys_sendmsg+0x2c/0x40
[   92.809201]                    invoke_syscall+0x50/0x120
[   92.814570]                    el0_svc_common.constprop.0+0x48/0xf0
[   92.820908]                    do_el0_svc+0x24/0x38
[   92.825837]                    el0_svc+0x4c/0x178
[   92.830591]                    el0t_64_sync_handler+0xa0/0xe8
[   92.836399]                    el0t_64_sync+0x198/0x1a0
[   92.841681]  }
[   92.843353]  ... key      at: [<ffffffd6a2347b30>] __key.6+0x0/0x10
[   92.849690]  ... acquired at:
[   92.852685]    lock_acquire+0x1d4/0x368
[   92.856555]    _raw_spin_lock+0x50/0x70
[   92.860428]    bcmgenet_xmit+0x78/0x860
[   92.864301]    netpoll_start_xmit+0x118/0x1b0
[   92.868702]    netpoll_send_skb+0x3a8/0x4b0
[   92.872928]    netpoll_send_udp+0x2ac/0x418
[   92.877153]    write_msg+0x124/0x1b0 [netconsole]
[   92.881907]    console_flush_all+0x2e4/0x4a8
[   92.886220]    console_unlock+0x84/0x188
[   92.890181]    vprintk_emit+0x24c/0x450
[   92.894052]    vprintk_default+0x40/0x58
[   92.898013]    vprintk+0x3c/0x80
[   92.901270]    _printk+0x64/0x98
[   92.904527]    __handle_sysrq+0x1ec/0x308
[   92.908576]    sysrq_filter+0xcc/0x518
[   92.912363]    input_handle_events_filter+0x58/0xc0
[   92.917289]    input_pass_values+0x1fc/0x2e8
[   92.921604]    input_handle_event+0x450/0x558
[   92.926003]    input_event+0x6c/0xb8
[   92.929612]    hidinput_report_event+0x4c/0x78
[   92.934103]    hid_report_raw_event+0xb4/0x418
[   92.938592]    hid_input_report+0x138/0x1a0
[   92.942816]    hid_irq_in+0x180/0x308
[   92.946513]    __usb_hcd_giveback_urb+0x98/0x160
[   92.951179]    usb_giveback_urb_bh+0xb0/0x150
[   92.955580]    process_one_work+0x20c/0x5e8
[   92.959803]    bh_worker+0x1b0/0x218
[   92.963413]    workqueue_softirq_action+0x80/0x98
[   92.968166]    tasklet_hi_action+0x20/0x60
[   92.972304]    handle_softirqs+0x144/0x528
[   92.976438]    __do_softirq+0x1c/0x28
[   92.980142]    ____do_softirq+0x18/0x30
[   92.984008]    call_on_irq_stack+0x30/0x70
[   92.988145]    do_softirq_own_stack+0x24/0x38
[   92.992547]    __irq_exit_rcu+0x100/0x1f8
[   92.996595]    irq_exit_rcu+0x18/0x58
[   93.000293]    el1_interrupt+0x38/0x68
[   93.004077]    el1h_64_irq_handler+0x18/0x28
[   93.008390]    el1h_64_irq+0x6c/0x70
[   93.012005]    default_idle_call+0x84/0x140
[   93.016230]    do_idle+0x22c/0x298
[   93.019657]    cpu_startup_entry+0x3c/0x50
[   93.023794]    rest_init+0x108/0x1a0
[   93.027403]    start_kernel+0x760/0x8c8
[   93.031274]    __primary_switched+0x88/0x98
[   93.035500]=20
[   93.036995]=20
[   93.036995] stack backtrace:
[   93.041406] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G         C   =
       6.17.0-rc2-v8-lockdep #529 PREEMPTLAZY=20
[   93.052226] Tainted: [C]=3DCRAP
[   93.055218] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
[   93.061114] Call trace:
[   93.063580]  show_stack+0x20/0x38 (C)
[   93.067276]  dump_stack_lvl+0x90/0xd0
[   93.070973]  dump_stack+0x18/0x28
[   93.074317]  check_irq_usage+0x720/0x9e8
[   93.078277]  __lock_acquire+0x1388/0x1fa0
[   93.082327]  lock_acquire+0x1d4/0x368
[   93.086023]  _raw_spin_lock+0x50/0x70
[   93.089720]  bcmgenet_xmit+0x78/0x860
[   93.093418]  netpoll_start_xmit+0x118/0x1b0
[   93.097642]  netpoll_send_skb+0x3a8/0x4b0
[   93.101691]  netpoll_send_udp+0x2ac/0x418
[   93.105741]  write_msg+0x124/0x1b0 [netconsole]
[   93.110320]  console_flush_all+0x2e4/0x4a8
[   93.114455]  console_unlock+0x84/0x188
[   93.118240]  vprintk_emit+0x24c/0x450
[   93.121935]  vprintk_default+0x40/0x58
[   93.125723]  vprintk+0x3c/0x80
[   93.128802]  _printk+0x64/0x98
[   93.131882]  __handle_sysrq+0x1ec/0x308
[   93.135756]  sysrq_filter+0xcc/0x518
[   93.139363]  input_handle_events_filter+0x58/0xc0
[   93.144118]  input_pass_values+0x1fc/0x2e8
[   93.148255]  input_handle_event+0x450/0x558
[   93.152478]  input_event+0x6c/0xb8
[   93.155912]  hidinput_report_event+0x4c/0x78
[   93.160225]  hid_report_raw_event+0xb4/0x418
[   93.164539]  hid_input_report+0x138/0x1a0
[   93.168586]  hid_irq_in+0x180/0x308
[   93.172107]  __usb_hcd_giveback_urb+0x98/0x160
[   93.176596]  usb_giveback_urb_bh+0xb0/0x150
[   93.180822]  process_one_work+0x20c/0x5e8
[   93.184870]  bh_worker+0x1b0/0x218
[   93.188303]  workqueue_softirq_action+0x80/0x98
[   93.192881]  tasklet_hi_action+0x20/0x60
[   93.196841]  handle_softirqs+0x144/0x528
[   93.200808]  __do_softirq+0x1c/0x28
[   93.204325]  ____do_softirq+0x18/0x30
[   93.208019]  call_on_irq_stack+0x30/0x70
[   93.211983]  do_softirq_own_stack+0x24/0x38
[   93.216205]  __irq_exit_rcu+0x100/0x1f8
[   93.220078]  irq_exit_rcu+0x18/0x58
[   93.223600]  el1_interrupt+0x38/0x68
[   93.227208]  el1h_64_irq_handler+0x18/0x28
[   93.231345]  el1h_64_irq+0x6c/0x70
[   93.234778]  default_idle_call+0x84/0x140 (P)
[   93.239179]  do_idle+0x22c/0x298
[   93.242436]  cpu_startup_entry+0x3c/0x50
[   93.246403]  rest_init+0x108/0x1a0
[   93.249830]  start_kernel+0x760/0x8c8
[   93.253525]  __primary_switched+0x88/0x98


