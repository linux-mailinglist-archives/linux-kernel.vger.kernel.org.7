Return-Path: <linux-kernel+bounces-753764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E3CB1878A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 766DE7B2313
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C9527A931;
	Fri,  1 Aug 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAOpa9su"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A3713A3ED
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754074898; cv=none; b=F47sr3m29J9/p9wQ8BrdgGinoTpRgJJWzuKf8wAI8eFyWotxHqfr5Vvj3qRYaVMx+sNFkPhYRTgGDZSyGHl9Ju9EqUiS/R3JE3jKAlTErTCXqbINRrvfr+1d0v+SlCOQEouRdGEhi37NNpU0y/Tx522Hz1foVtvcYIkezuXQ3G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754074898; c=relaxed/simple;
	bh=K2PCEWcTTRr5kyzNUGdOZScLlopfI+j63yPH3oy1sY4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=SJzjEhnYF0Nhb57l4M0A8Wep/f/y4K5Ds3Ir+pr2k+Kar8lCt+ug2wJseuMjHEPT2cZWvJlyzXGJvjzjzHoghmL3jZohTSvksB+2/3ooBRGxulw0tFR5O9TvwU+4HJJczR0QOnQOpt3YadI5HZQDWAExaV/AKlXIAkdU3lQWgSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAOpa9su; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4aef11cc90cso24370011cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 12:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754074894; x=1754679694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1ezwLl1+vXvikQR8K7pNjFsjCMN7m4LhMEGNpKdGr48=;
        b=WAOpa9sublWJ6rQixV0zgmOkvYACiJneU/XI3lwYiE6jgyXhQSop46gog59kM7uI6d
         FXeU4z2bGfQaOdOVZ6izMgucaw+L7VLEg166bz6OqCuztc8cylRXMPmp75aPDiqeYEFx
         XNmqzbMH4BXwjEPAiS95WsWhz9ZXA0oOkbqNthhSTgx5q4VlBpMyzM4LBIr953/0aIuy
         PNhD0cz3P5ErvXlbTUebvKKgvor7ZHBTPuqOCvwDUDJwUGrVy4rNBpLqXsdv88ZHc26t
         5ljad2awetwCDnb0cTAoLNyvG/ftqux6oxMa/aPEkBgFTp3ImVUT1eq0VjM49yzzXaW5
         ufgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754074894; x=1754679694;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1ezwLl1+vXvikQR8K7pNjFsjCMN7m4LhMEGNpKdGr48=;
        b=WlWuoVSjDEClgXAXf31PEaWRZijc5R6BpTq72wEuRY8QhPYrgG1Dgqe6dhePpozzYj
         /42LDPzMTat7goSAjuYUSy+A37UcsP/5h/88vWyuEQLkR7BlF3Eu4sbiWkcGfbNpapSP
         rENff8GRQTljJJ+PNDJWNg6dcdo9CCNbGQOqCnHEa5CxTn4eJPK0h/ybjcoS/nmJ+czc
         SWU7LQrK254GQADz47Bw7Dm/MxRFhwgogEo0gJEXnJ8lM0voM0LCS+os82Q6GstP3kR6
         15lcZ+yp2WbhkgEETraw6GRTYVBDJBTBOnpcxQD3GLFEL4i2PY9KMpONhozDf6GBsSEB
         IC1A==
X-Gm-Message-State: AOJu0Yxxsr+bSjVUyX1NR5jFfWUFWWLBDWjbM2WFnC7N5Fyz7BxDGkk3
	uVOo5Zp031J0Dr6x6lnmW7i7StqnYNtM0PZ2M3/Tfg0sZl0AzBh21c55/tEhZ0spo+2HX65EFpD
	j4Ivka9oGnUIz49BvPhgtw6FVaCxpx/eCVlzEIKc=
X-Gm-Gg: ASbGncsWAYs9Kwq5PK40VzTcX1s2DGBWhd+t+7ZImVLq6HmTJNAq8/EjswqEJec3pJe
	wXJ/XN3oFBzHn+zU3Y6ICjexUmlnOGf2SBnaDaNiAArHu0bJ5tLCbwuY/RJbGh3D68xCbIZXxQm
	TbhCGGXGs/0yAgAu6up0aKvt+OZ8ao8jQt/hmF3fupD7cwrfoQgHbTiEx7r1UxEizLrDEHw8bOh
	MfNHzvp3XwytBB5zJmqGDgMm8kOzLc5bReL6se7
X-Google-Smtp-Source: AGHT+IGH3Bx+tAemKvoRUjEtffHlmr5BgwvcUBrWpCe+lvoXRIbjqgQnIq+2JfgQWASjlBp1gSkt8UFkhTDmqpSN5d0=
X-Received: by 2002:a05:6214:2a4c:b0:707:4cba:124c with SMTP id
 6a1803df08f44-70935f77609mr13184236d6.15.1754074893680; Fri, 01 Aug 2025
 12:01:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 1 Aug 2025 14:01:22 -0500
X-Gm-Features: Ac12FXzgtUxk7SJW312J8fYNh3u72tGn3Z5JgBRZs36LhxRYOHQhENRMcN2khoM
Message-ID: <CAH2r5muJ4raSHGUh4Rk1jDuvBsEmkJ4aFd3BYGA9V5hUY9CxmA@mail.gmail.com>
Subject: [BUG] soft lockup in psi_avgs_work() / collect_percpu_times() on 6.17-rc
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org
Content-Type: text/plain; charset="UTF-8"

Running xfstests against current mainline from yesterday I see the
following soft lockup during xfstest generic/211

[Fri Aug 1 13:33:48 2025] watchdog: BUG: soft lockup - CPU#6 stuck for
22s! [kworker/6:5:58759]
[Fri Aug 1 13:33:48 2025] Modules linked in: cifs(E) cmac(E)
nls_utf8(E) cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E)
rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E)
lockd(E) grace(E) netfs(E) nf_conntrack_netbios_ns(E)
nf_conntrack_broadcast(E) nft_fib_inet(E) nft_fib_ipv4(E)
nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E)
ip_set(E) sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
net_failover(E) failover(E) virtio_balloon(E) loop(E) fuse(E)
dm_multipath(E) nfnetlink(E) zram(E) xfs(E) bochs(E) drm_client_lib(E)
drm_shmem_helper(E) drm_kms_helper(E) virtio_blk(E)
ghash_clmulni_intel(E) drm(E) floppy(E) qemu_fw_cfg(E)
virtio_console(E) [last unloaded: cifs(E)]
[Fri Aug 1 13:33:48 2025] irq event stamp: 275924
[Fri Aug 1 13:33:48 2025] hardirqs last enabled at (275923):
[<ffffffff950015ca>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
[Fri Aug 1 13:33:48 2025] hardirqs last disabled at (275924):
[<ffffffff969a7fef>] sysvec_apic_timer_interrupt+0xf/0x90
[Fri Aug 1 13:33:48 2025] softirqs last enabled at (275922):
[<ffffffff95325785>] __irq_exit_rcu+0x135/0x160
[Fri Aug 1 13:33:48 2025] softirqs last disabled at (275905):
[<ffffffff95325785>] __irq_exit_rcu+0x135/0x160
[Fri Aug 1 13:33:48 2025] CPU: 6 UID: 0 PID: 58759 Comm: kworker/6:5
Tainted: G E 6.16.0 #1 PREEMPT(voluntary)
[Fri Aug 1 13:33:48 2025] Tainted: [E]=UNSIGNED_MODULE
[Fri Aug 1 13:33:48 2025] Hardware name: Red Hat KVM, BIOS
1.16.3-4.el9 04/01/2014
[Fri Aug 1 13:33:48 2025] Workqueue: events psi_avgs_work
[Fri Aug 1 13:33:48 2025] RIP: 0010:collect_percpu_times+0x4c7/0x540
[Fri Aug 1 13:33:48 2025] Code: 00 00 00 c7 40 0c 00 00 00 00 48 c7 40
14 00 00 00 00 48 81 c4 68 01 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3
cc cc cc cc f3 90 <4c> 89 ef e8 91 3b 49 00 48 8b 44 24 08 4c 8b 74 24
20 e9 15 fd ff
[Fri Aug 1 13:33:48 2025] RSP: 0018:ff110001370a7ae8 EFLAGS: 00000202
[Fri Aug 1 13:33:48 2025] RAX: 0000000000000000 RBX: ffd1ffffffd1f740
RCX: dffffc0000000000
[Fri Aug 1 13:33:48 2025] RDX: 0000000000000003 RSI: 0000000000000000
RDI: ff110004cb32cec0
[Fri Aug 1 13:33:48 2025] RBP: ffffffff98e09ec0 R08: ffffffff953e5db3
R09: 0000000000000001
[Fri Aug 1 13:33:48 2025] R10: ffffffff97fe80e7 R11: 0000000000000000
R12: 0000000000000006
[Fri Aug 1 13:33:48 2025] R13: ffffffff97479050 R14: 000000000001e72b
R15: ff110001370a7bb0
[Fri Aug 1 13:33:48 2025] FS: 0000000000000000(0000)
GS:ff11000532523000(0000) knlGS:0000000000000000
[Fri Aug 1 13:33:48 2025] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Fri Aug 1 13:33:48 2025] CR2: 00007fd174c8cc58 CR3: 0000000119668001
CR4: 0000000000373ef0
[Fri Aug 1 13:33:48 2025] Call Trace:
[Fri Aug 1 13:33:48 2025] <TASK>
[Fri Aug 1 13:33:48 2025] ? __pfx_collect_percpu_times+0x10/0x10
[Fri Aug 1 13:33:48 2025] psi_avgs_work+0x89/0x140
[Fri Aug 1 13:33:48 2025] ? __pfx_psi_avgs_work+0x10/0x10
[Fri Aug 1 13:33:48 2025] ? lock_release+0xc4/0x270
[Fri Aug 1 13:33:48 2025] ? rcu_is_watching+0x20/0x50
[Fri Aug 1 13:33:48 2025] process_one_work+0x4bf/0xb40
[Fri Aug 1 13:33:48 2025] ? lock_acquire+0x143/0x2d0
[Fri Aug 1 13:33:48 2025] ? __pfx_process_one_work+0x10/0x10
[Fri Aug 1 13:33:48 2025] ? assign_work+0xd6/0x110
[Fri Aug 1 13:33:48 2025] worker_thread+0x2c9/0x550
[Fri Aug 1 13:33:48 2025] ? __pfx_worker_thread+0x10/0x10
[Fri Aug 1 13:33:48 2025] kthread+0x216/0x3e0
[Fri Aug 1 13:33:48 2025] ? __pfx_kthread+0x10/0x10
[Fri Aug 1 13:33:48 2025] ? __pfx_kthread+0x10/0x10
[Fri Aug 1 13:33:48 2025] ? lock_release+0xc4/0x270
[Fri Aug 1 13:33:48 2025] ? rcu_is_watching+0x20/0x50
[Fri Aug 1 13:33:48 2025] ? __pfx_kthread+0x10/0x10
[Fri Aug 1 13:33:48 2025] ret_from_fork+0x23a/0x2e0
[Fri Aug 1 13:33:48 2025] ? __pfx_kthread+0x10/0x10
[Fri Aug 1 13:33:48 2025] ret_from_fork_asm+0x1a/0x30
[Fri Aug 1 13:33:48 2025] </TASK>

-- 
Thanks,

Steve

