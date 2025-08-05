Return-Path: <linux-kernel+bounces-756774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189ABB1B906
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 19:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA71517C61C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 17:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FFB6291C39;
	Tue,  5 Aug 2025 17:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ax8N8lFW"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A34275B02
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 17:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754413870; cv=none; b=NugLa6vu/xdK6noOsfxri9PgUdkLZ9JTuDQN75UCeMl1L5swpHDFpRX/XTB2kx+cp1VW2LJYZZkESszlx4am8KKaoMHdkFYPQPlHl3Lf6ehLEebH1D+4YNWEXA6Jg6fA3RSj1PDM0SDUpO7DE+ZcQfJb1ihKULF56E9HX4VX800=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754413870; c=relaxed/simple;
	bh=7GvB8e+gz+eaLhDyVsr6LMgFS6JkyppTmOMQNtF04lM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=i+XgSmKEkxRH8H91HMv7OpY10lXhttOSRFwO0hb8qehIEVWsG4hbeeJDGjUinoszf0tzSfu1zCaRljUwzNTG7NnxxShoMhA3Ao0tB3FrTBTYHimN++P+tzpi4YuGjBu44tmW1fq3Y+b5HUlNHeWX0eRJmE24zgYSfNHzVvG5AnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ax8N8lFW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-70749eac23dso37815596d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 10:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754413867; x=1755018667; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RcHSgzfcza92FOlnRl6VNHs9GhPij/d2+ckBxrJAB/s=;
        b=Ax8N8lFWB6LIgKtgfEnvbMGaeJKX1MFstJFL24Uw8sFLbqisBQQGChmwcEcBZc2UGe
         2I9ao6CEFI/0ZdWGQP26KVKqK3wZUiHqs5TZy0wBsTE5ZLabFWGBA0SHbKIqod3y2xgw
         XFRjTSfXaID34XqsWyK4HgJUHWOpo7xZLrPmzVqwg8NIi56ttIdiUIvmC93S17zzDeLH
         arChmHG95kjXxCHJnzn3JCEwh3TocOU1Hda/0l4l5y2VttzXsKvJULxODG3orHFlVcfS
         r8lVZGTLGqyCKMf8w3e7SOiS9E9+SCgEyTW3qHPuU7u4xpnKLV00RzVmnM3e41YS07at
         6Okw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754413867; x=1755018667;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcHSgzfcza92FOlnRl6VNHs9GhPij/d2+ckBxrJAB/s=;
        b=jQ45xIpR8GLBAoMgBuP6XUHoXowGNUPlv0Lkst7L57muPqQfnZDB1WDvLmQygXGyGh
         GK+dRmVMau5f7/pOYjl4bYhgbqDFalKSK6aGj5kR+Eia+byysGSyeP4JBaQRUTQQ0Ny6
         6tBZPJNcm3DvsLd22vpcA3LNg6ASw58u94jcmjOQJwcdIV15QD4ZLOYUgCQ6p7WSBlzg
         0Hza1CjWshymWOerdm9ItwNyaMcsCaq0c03vx2SpzF7fhJc95WEmj8zmLCPyH55nMcfN
         Hv0MhXxQu4DeydTQ+ywrN6t+/v/5Q1s9P3xgOFwpANN8f6LGxdOO8edMZ7xYpFYZDtLv
         1jhQ==
X-Gm-Message-State: AOJu0YyoL1oAoUsuAbaFTu8XLn8PDjdUPl/HJPelAFVxfRzOGha/9U0U
	aTaPVF4GrQ2/S4LCW+mWVuUx05i7LiDbo46h7We4FHnGAnLa2j864eyvqy7WCA0+vtphAQHk0Ui
	1FFa/YxvMsbL+U411rQr4H6lHhAhKsG24P9J6
X-Gm-Gg: ASbGncv+KizFPFOzsptdzI3kHhSUxaInixAy9pFWkBza/qP4FdJWzGnRSLW0byRLfvg
	aOMm2pm5JaLTS2XQM76t7dk3V02TkpeJMziSLB5l+ikNhDzFOhtH/f3geAgso9rzAw0iOUidtao
	XPY48wUCX7E75wRZgMo57iq/Z8YJ92QMdzjlMvjsDNsAD4JrTHRq9eTurHk9dF8Tiy65vQcBqnb
	hzVIiqaZNd0hWyk6cc3J7M/fvIO8SERMD555Ku1
X-Google-Smtp-Source: AGHT+IEePQG45Tg4TcpYH9NzvZ/FQWqybJPUgDsVor/dBM68RDClGJM6sn9TD+nEv/i7hzN5PyjRV4AYetHzaBod9Us=
X-Received: by 2002:ad4:5e88:0:b0:707:5ccb:6c4 with SMTP id
 6a1803df08f44-7093633522bmr193537286d6.49.1754413866852; Tue, 05 Aug 2025
 10:11:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 5 Aug 2025 12:10:54 -0500
X-Gm-Features: Ac12FXxiSF8-rjS0Rbw1JAJUtfgGQAOG5m9DwW2xjpoRnp7HiadhEYB1BxLZ9rk
Message-ID: <CAH2r5mtHeuo609uom0QFFv_YJZteLgGnSZUr+7_87iKGxPhvQA@mail.gmail.com>
Subject: RIP with collect_percpu-times() in 6.17-rc
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Anyone seeing this RIP in collect_percpu_times() with current mainline
(6.17-rc) from a few days ago?  Has it been fixed in the last couple
days?  I saw this running xfstest generic/007.

[Tue Aug 5 11:31:54 2025] RIP: 0010:collect_percpu_times+0x4c7/0x540
[Tue Aug 5 11:31:54 2025] Code: 00 00 00 c7 40 0c 00 00 00 00 48 c7 40
14 00 00 00 00 48 81 c4 68 01 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3
cc cc cc cc f3 90 <4c> 89 ef e8 91 3b 49 00 48 8b 44 24 08 4c 8b 74 24
20 e9 15 fd ff
[Tue Aug 5 11:31:54 2025] RSP: 0018:ff1100010a8cfae8 EFLAGS: 00000202
[Tue Aug 5 11:31:54 2025] RAX: 0000000000000000 RBX: ffd1ffffffc1f0c0
RCX: dffffc0000000000
[Tue Aug 5 11:31:54 2025] RDX: 0000000000000003 RSI: 0000000000000000
RDI: ff110004cb22cec0
[Tue Aug 5 11:31:54 2025] RBP: ffffffffa3e09ec0 R08: ffffffffa03e5db3
R09: 0000000000000001
[Tue Aug 5 11:31:54 2025] R10: ffffffffa2fe80e7 R11: 0000000000000000
R12: 0000000000000004
[Tue Aug 5 11:31:54 2025] R13: ffffffffa2479040 R14: 0000000000015b31
R15: ff1100010a8cfbb0
[Tue Aug 5 11:31:54 2025] FS: 0000000000000000(0000)
GS:ff11000527423000(0000) knlGS:0000000000000000
[Tue Aug 5 11:31:54 2025] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Tue Aug 5 11:31:54 2025] CR2: 00007f667ca4d050 CR3: 000000013596e003
CR4: 0000000000373ef0
[Tue Aug 5 11:31:54 2025] Call Trace:
[Tue Aug 5 11:31:54 2025] <TASK>
[Tue Aug 5 11:31:54 2025] ? __pfx_collect_percpu_times+0x10/0x10
[Tue Aug 5 11:31:54 2025] psi_avgs_work+0x89/0x140
[Tue Aug 5 11:31:54 2025] ? __pfx_psi_avgs_work+0x10/0x10
[Tue Aug 5 11:31:54 2025] ? lock_release+0xc4/0x270
[Tue Aug 5 11:31:54 2025] ? rcu_is_watching+0x20/0x50
[Tue Aug 5 11:31:54 2025] process_one_work+0x4bf/0xb40
[Tue Aug 5 11:31:54 2025] ? __pfx_process_one_work+0x10/0x10
[Tue Aug 5 11:31:54 2025] ? assign_work+0xd6/0x110
[Tue Aug 5 11:31:54 2025] worker_thread+0x2c9/0x550
[Tue Aug 5 11:31:54 2025] ? __pfx_worker_thread+0x10/0x10
[Tue Aug 5 11:31:54 2025] kthread+0x216/0x3e0
[Tue Aug 5 11:31:54 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:31:54 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:31:54 2025] ? lock_release+0xc4/0x270
[Tue Aug 5 11:31:54 2025] ? rcu_is_watching+0x20/0x50
[Tue Aug 5 11:31:54 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:31:54 2025] ret_from_fork+0x23a/0x2e0
[Tue Aug 5 11:31:54 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:31:54 2025] ret_from_fork_asm+0x1a/0x30
[Tue Aug 5 11:31:54 2025] </TASK>
[Tue Aug 5 11:33:14 2025] watchdog: BUG: soft lockup - CPU#4 stuck for
24s! [kworker/4:26:39273]
[Tue Aug 5 11:33:14 2025] Modules linked in: cifs(E) ccm(E) cmac(E)
nls_utf8(E) cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E)
rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E)
lockd(E) grace(E) netfs(E) nf_conntrack_netbios_ns(E)
nf_conntrack_broadcast(E) nft_fib_inet(E) nft_fib_ipv4(E)
nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E)
ip_set(E) sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failover(E) failover(E) dm_multipath(E) loop(E)
fuse(E) nfnetlink(E) zram(E) xfs(E) bochs(E) drm_client_lib(E)
drm_shmem_helper(E) drm_kms_helper(E) floppy(E) ghash_clmulni_intel(E)
drm(E) virtio_blk(E) qemu_fw_cfg(E) virtio_console(E) [last unloaded:
cifs(E)]
[Tue Aug 5 11:33:14 2025] irq event stamp: 69288
[Tue Aug 5 11:33:14 2025] hardirqs last enabled at (69287):
[<ffffffffa00015ca>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
[Tue Aug 5 11:33:14 2025] hardirqs last disabled at (69288):
[<ffffffffa19a7fef>] sysvec_apic_timer_interrupt+0xf/0x90
[Tue Aug 5 11:33:14 2025] softirqs last enabled at (69194):
[<ffffffffa0325785>] __irq_exit_rcu+0x135/0x160
[Tue Aug 5 11:33:14 2025] softirqs last disabled at (69189):
[<ffffffffa0325785>] __irq_exit_rcu+0x135/0x160
[Tue Aug 5 11:33:14 2025] CPU: 4 UID: 0 PID: 39273 Comm: kworker/4:26
Tainted: G EL 6.16.0 #1 PREEMPT(voluntary)
[Tue Aug 5 11:33:14 2025] Tainted: [E]=UNSIGNED_MODULE, [L]=SOFTLOCKUP
[Tue Aug 5 11:33:14 2025] Hardware name: Red Hat KVM, BIOS
1.16.3-4.el9 04/01/2014
[Tue Aug 5 11:33:14 2025] Workqueue: events psi_avgs_work
[Tue Aug 5 11:33:14 2025] RIP: 0010:collect_percpu_times+0x4c7/0x540
[Tue Aug 5 11:33:14 2025] Code: 00 00 00 c7 40 0c 00 00 00 00 48 c7 40
14 00 00 00 00 48 81 c4 68 01 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3
cc cc cc cc f3 90 <4c> 89 ef e8 91 3b 49 00 48 8b 44 24 08 4c 8b 74 24
20 e9 15 fd ff
[Tue Aug 5 11:33:14 2025] RSP: 0018:ff1100012d167ae8 EFLAGS: 00000202
[Tue Aug 5 11:33:14 2025] RAX: 0000000000000000 RBX: ffd1ffffffc252c0
RCX: dffffc0000000000
[Tue Aug 5 11:33:14 2025] RDX: 0000000000000003 RSI: 0000000000000000
RDI: ff110004cb22cec0
[Tue Aug 5 11:33:14 2025] RBP: ffffffffa3e09ec0 R08: ffffffffa03e5db3
R09: 0000000000000001
[Tue Aug 5 11:33:14 2025] R10: ffffffffa2fe80e7 R11: 0000000000000000
R12: 0000000000000004
[Tue Aug 5 11:33:14 2025] R13: ffffffffa2479040 R14: 000000000003ccdf
R15: ff1100012d167bb0
[Tue Aug 5 11:33:14 2025] FS: 0000000000000000(0000)
GS:ff11000527423000(0000) knlGS:0000000000000000
[Tue Aug 5 11:33:14 2025] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Tue Aug 5 11:33:14 2025] CR2: 00007f667ca4d050 CR3: 00000001ff668005
CR4: 0000000000373ef0
[Tue Aug 5 11:33:14 2025] Call Trace:
[Tue Aug 5 11:33:14 2025] <TASK>
[Tue Aug 5 11:33:14 2025] ? __pfx_collect_percpu_times+0x10/0x10
[Tue Aug 5 11:33:14 2025] psi_avgs_work+0x89/0x140
[Tue Aug 5 11:33:14 2025] ? __pfx_psi_avgs_work+0x10/0x10
[Tue Aug 5 11:33:14 2025] ? lock_release+0xc4/0x270
[Tue Aug 5 11:33:14 2025] ? rcu_is_watching+0x20/0x50
[Tue Aug 5 11:33:14 2025] process_one_work+0x4bf/0xb40
[Tue Aug 5 11:33:14 2025] ? __pfx_process_one_work+0x10/0x10
[Tue Aug 5 11:33:14 2025] ? assign_work+0xd6/0x110
[Tue Aug 5 11:33:14 2025] worker_thread+0x2c9/0x550
[Tue Aug 5 11:33:14 2025] ? __pfx_worker_thread+0x10/0x10
[Tue Aug 5 11:33:14 2025] kthread+0x216/0x3e0
[Tue Aug 5 11:33:14 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:33:14 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:33:14 2025] ? lock_release+0xc4/0x270
[Tue Aug 5 11:33:14 2025] ? rcu_is_watching+0x20/0x50
[Tue Aug 5 11:33:14 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:33:14 2025] ret_from_fork+0x23a/0x2e0
[Tue Aug 5 11:33:14 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:33:14 2025] ret_from_fork_asm+0x1a/0x30
[Tue Aug 5 11:33:14 2025] </TASK>
[Tue Aug 5 11:34:34 2025] watchdog: BUG: soft lockup - CPU#4 stuck for
24s! [kworker/4:9:39164]
[Tue Aug 5 11:34:34 2025] Modules linked in: cifs(E) ccm(E) cmac(E)
nls_utf8(E) cifs_arc4(E) nls_ucs2_utils(E) cifs_md4(E)
rpcsec_gss_krb5(E) auth_rpcgss(E) nfsv4(E) dns_resolver(E) nfs(E)
lockd(E) grace(E) netfs(E) nf_conntrack_netbios_ns(E)
nf_conntrack_broadcast(E) nft_fib_inet(E) nft_fib_ipv4(E)
nft_fib_ipv6(E) nft_fib(E) nft_reject_inet(E) nf_reject_ipv4(E)
nf_reject_ipv6(E) nft_reject(E) nft_ct(E) nft_chain_nat(E) nf_nat(E)
nf_conntrack(E) nf_defrag_ipv6(E) nf_defrag_ipv4(E) nf_tables(E)
ip_set(E) sunrpc(E) kvm_intel(E) kvm(E) irqbypass(E) virtio_net(E)
virtio_balloon(E) net_failover(E) failover(E) dm_multipath(E) loop(E)
fuse(E) nfnetlink(E) zram(E) xfs(E) bochs(E) drm_client_lib(E)
drm_shmem_helper(E) drm_kms_helper(E) floppy(E) ghash_clmulni_intel(E)
drm(E) virtio_blk(E) qemu_fw_cfg(E) virtio_console(E) [last unloaded:
cifs(E)]
[Tue Aug 5 11:34:34 2025] irq event stamp: 209596
[Tue Aug 5 11:34:34 2025] hardirqs last enabled at (209595):
[<ffffffffa00015ca>] asm_sysvec_apic_timer_interrupt+0x1a/0x20
[Tue Aug 5 11:34:34 2025] hardirqs last disabled at (209596):
[<ffffffffa19a7fef>] sysvec_apic_timer_interrupt+0xf/0x90
[Tue Aug 5 11:34:34 2025] softirqs last enabled at (209542):
[<ffffffffa0325785>] __irq_exit_rcu+0x135/0x160
[Tue Aug 5 11:34:34 2025] softirqs last disabled at (209521):
[<ffffffffa0325785>] __irq_exit_rcu+0x135/0x160
[Tue Aug 5 11:34:34 2025] CPU: 4 UID: 0 PID: 39164 Comm: kworker/4:9
Tainted: G EL 6.16.0 #1 PREEMPT(voluntary)
[Tue Aug 5 11:34:34 2025] Tainted: [E]=UNSIGNED_MODULE, [L]=SOFTLOCKUP
[Tue Aug 5 11:34:34 2025] Hardware name: Red Hat KVM, BIOS
1.16.3-4.el9 04/01/2014
[Tue Aug 5 11:34:34 2025] Workqueue: events psi_avgs_work
[Tue Aug 5 11:34:34 2025] RIP: 0010:collect_percpu_times+0x4c7/0x540
[Tue Aug 5 11:34:34 2025] Code: 00 00 00 c7 40 0c 00 00 00 00 48 c7 40
14 00 00 00 00 48 81 c4 68 01 00 00 5b 5d 41 5c 41 5d 41 5e 41 5f c3
cc cc cc cc f3 90 <4c> 89 ef e8 91 3b 49 00 48 8b 44 24 08 4c 8b 74 24
20 e9 15 fd ff
[Tue Aug 5 11:34:34 2025] RSP: 0018:ff1100012f61fae8 EFLAGS: 00000202
[Tue Aug 5 11:34:34 2025] RAX: 0000000000000000 RBX: ffd1ffffffc2da80
RCX: dffffc0000000000
[Tue Aug 5 11:34:34 2025] RDX: 0000000000000003 RSI: 0000000000000000
RDI: ff110004cb22cec0
[Tue Aug 5 11:34:34 2025] RBP: ffffffffa3e09ec0 R08: ffffffffa03e5db3
R09: 0000000000000001
[Tue Aug 5 11:34:34 2025] R10: ffffffffa2fe80e7 R11: 0000000000000000
R12: 0000000000000004
[Tue Aug 5 11:34:34 2025] R13: ffffffffa2479040 R14: 0000000000063e7d
R15: ff1100012f61fbb0
[Tue Aug 5 11:34:34 2025] FS: 0000000000000000(0000)
GS:ff11000527423000(0000) knlGS:0000000000000000
[Tue Aug 5 11:34:34 2025] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[Tue Aug 5 11:34:34 2025] CR2: 00007f667ca4d050 CR3: 00000001ff668005
CR4: 0000000000373ef0
[Tue Aug 5 11:34:34 2025] Call Trace:
[Tue Aug 5 11:34:34 2025] <TASK>
[Tue Aug 5 11:34:34 2025] ? __pfx_collect_percpu_times+0x10/0x10
[Tue Aug 5 11:34:34 2025] psi_avgs_work+0x89/0x140
[Tue Aug 5 11:34:34 2025] ? __pfx_psi_avgs_work+0x10/0x10
[Tue Aug 5 11:34:34 2025] ? lock_release+0xc4/0x270
[Tue Aug 5 11:34:34 2025] ? rcu_is_watching+0x20/0x50
[Tue Aug 5 11:34:34 2025] process_one_work+0x4bf/0xb40
[Tue Aug 5 11:34:34 2025] ? __pfx_process_one_work+0x10/0x10
[Tue Aug 5 11:34:34 2025] ? assign_work+0xd6/0x110
[Tue Aug 5 11:34:34 2025] worker_thread+0x2c9/0x550
[Tue Aug 5 11:34:34 2025] ? __pfx_worker_thread+0x10/0x10
[Tue Aug 5 11:34:34 2025] kthread+0x216/0x3e0
[Tue Aug 5 11:34:34 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:34:34 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:34:34 2025] ? lock_release+0xc4/0x270
[Tue Aug 5 11:34:34 2025] ? rcu_is_watching+0x20/0x50
[Tue Aug 5 11:34:34 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:34:34 2025] ret_from_fork+0x23a/0x2e0
[Tue Aug 5 11:34:34 2025] ? __pfx_kthread+0x10/0x10
[Tue Aug 5 11:34:34 2025] ret_from_fork_asm+0x1a/0x30
[Tue Aug 5 11:34:34 2025] </TASK>

-- 
Thanks,

Steve

