Return-Path: <linux-kernel+bounces-754536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B081AB196A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 00:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40A3418928DB
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 22:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DF31F582E;
	Sun,  3 Aug 2025 22:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzsjcHeV"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C871E51EF
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 22:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754259289; cv=none; b=f4ENuBwIx6rOOxmlQxYbwJxcN2LztJMRsdqiD0XfcunG0DxTcj+2jMafwg+PVOFZNk6FptPyNcsvx7i5Fh4g4bRN+IyLAdWYFg1GG/f3AcTH9oexQILOiQ+Fpl9Hxd9a+F6ypuJL2ZIurBc6QYOq+UC0T4tslJA1/Uv/crLuTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754259289; c=relaxed/simple;
	bh=jCA+B26yt4eBvjuQTruNUskC+lN1NcLE1p2jjRy77nw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JvM39CdRlJJJj48uVfY6f2eHfhdi7hONOM9czUa5CUD6xVnBqnxAYWI9kxsvBCOzyHE1nQQIE22LBRqEfLNcEIeKmFQXvv4pj4+2D9zH9jWZ27ckgDTNpvObkYP2aZX5gm9yqRFcYjjPHTvoVGVGDNwGcxsr6BkeawWPnI4if2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzsjcHeV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-459d62184c9so3549065e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 15:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754259285; x=1754864085; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xVGKF+K4gOfiuafZICbFNoZopzH0Rl1WckmY49p58Q=;
        b=NzsjcHeVkP+E9IaYREisp8W8CmIxLjLvKoggfr7lmIwq7cV//hf4I5UIrTNhvNtFcd
         8ogOuIvzVR0eEP/KU9/l/6m0kbXQ7QDGE6eXZVVVXmoAfyHeTjOIg042Fjwp1EyrfaHD
         eAD5BjNDJvz6nASy7/Q/ORFaR3C5XDdaGGnyiXVmVb+JEzqd9V6lEv1JenGDZW75725E
         N67zMZtZPIvgTsuzCrCknh6S1Gf2lZ9ng5gijIWzEPMowPPnqsOPjnHx+XHV7BKIBo/y
         WtBfohfXiy/WfJrAsW2MyrOb2UrSK0inFdLx/jk8usY4PDs94JAQ3aAbvkvBC7TOQAzZ
         eOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754259285; x=1754864085;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xVGKF+K4gOfiuafZICbFNoZopzH0Rl1WckmY49p58Q=;
        b=fhbMakFJH1xL83rR1KPO255MVhGNpeXEo+i5s8op6ZH5Rak7CiFomFTH9Q/PUpaeG/
         ZGmpgLTpoXAqDYiBTXIchYMpJnTSs3jNhj/t2+D5gAODX0SQ1atmw3rM0RJ0jof3x5gj
         wHsimusRJZY02zhbSJSSA+ShT7sUbJGoMt3Xa9QNP8QzlTzD9m8uX8ht8K0BnkiVF5dH
         MGOAXmGqb6JFiQxDCfkmRuvDaxrbXpsUSwsQxixZ4x/NeqWs9PKhkxg3GPUCgglzedzM
         ri6aLfRKNbcc8ONUXtGI37RVftXyQi82mVUMFg96LYcwWnrQ0akRP5FktYJlzsvQlzJ4
         l5Tw==
X-Gm-Message-State: AOJu0YxS/p5Tqha3QrRWXLUgC/Tu+j1pUbGH26v5XPTe1qri/t3ItGni
	UQzcWb2pmmjFyXYq5JtVMtiOGG65qtgdk9c4eKbMyTFf/QG5BsUBc8rdmMt/NfD+RKKuvdwa
X-Gm-Gg: ASbGncvdj5ur9EedLRGTr9Sa7MPtGqGLwlx5cXFWwx8iieE7BXvll2FfhievwtBRgDu
	SMZes6nYfvsJFSp9HNhvRHkXYQOTCxKY5fyM2YspWLl2csD9P3XqNI3gwhgF7j1yYjIYT5lSZri
	YdE5KST7G1w4clojyKvog+DQX/wModiZnKvEnHi2XRIpSoFJkfpMxBeFCV3f0+iGKfqOT6hNqEf
	aoPPI40lzeg9qp5cT5+F2m0NNMQKDlGAqsXq8E3aodoJEiQJunxKO1vD8W333C6iyvG/d9w2re+
	3VcohvhbvZn7/e0hTIfuBQfA8XLjxicTNYyERdK0IMzacYDXhsTjkEc0AgjAmYuRsQjW0kdsEEM
	IjT6/egWpWMVEEQibRAJgjl7aZV8oq2FwMQ==
X-Google-Smtp-Source: AGHT+IE597ZjLw0rLXTSN6O4+pECB+zeaGaGHlO+g4BENVFxXy3M0VanhjSvyGAWe8WaJ+T5bFfdDA==
X-Received: by 2002:a05:600c:c162:b0:456:eab:6344 with SMTP id 5b1f17b1804b1-458b69eb569mr62921335e9.15.1754259285260;
        Sun, 03 Aug 2025 15:14:45 -0700 (PDT)
Received: from debian.local ([90.252.123.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee5795esm145895925e9.25.2025.08.03.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 15:14:44 -0700 (PDT)
Date: Sun, 3 Aug 2025 23:14:42 +0100
From: Chris Bainbridge <chris.bainbridge@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: surenb@google.com, bsegall@google.com, dietmar.eggemann@arm.com,
	mingo@redhat.com, hannes@cmpxchg.org, juri.lelli@redhat.com,
	mgorman@suse.de, peterz@infradead.org, rostedt@goodmis.org,
	vschneid@redhat.com, vincent.guittot@linaro.org,
	regressions@lists.linux.dev
Subject: [REGRESSION] intermittent psi_avgs_work soft lockup
Message-ID: <aI_fUhpBrIBrJ073@debian.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

I'm getting intermittent soft lockups with recent kernel builds. This is
a new error that I haven't seen before.

An example lockup from 6.16.0-08685-g260f6f4fda93:

[39389.154516] iwlwifi 0000:01:00.0: Queue 3 is stuck 4977 5129
[39400.400429] watchdog: BUG: soft lockup - CPU#2 stuck for 22s! [kworker/2=
:1:1751316]
[39400.400433] Modules linked in: snd_seq_dummy snd_hrtimer snd_seq xt_conn=
track nft_chain_nat xt_MASQUERADE nf_nat nf_conntrack_netlink nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 xfrm_user xfrm_algo xt_addrtype nft_compat x_=
tables nf_tables br_netfilter bridge stp llc ccm overlay qrtr rfcomm cmac a=
lgif_hash algif_skcipher af_alg bnep binfmt_misc ext4 mbcache jbd2 nls_asci=
i nls_cp437 vfat fat snd_hda_codec_generic snd_hda_codec_hdmi intel_rapl_ms=
r intel_rapl_common iwlmvm snd_hda_intel snd_acp3x_pdm_dma snd_soc_dmic snd=
_acp3x_rn kvm_amd snd_hda_codec uvcvideo snd_soc_core mac80211 snd_usb_audi=
o btusb snd_intel_dspcfg snd_compress videobuf2_vmalloc snd_usbmidi_lib btr=
tl libarc4 videobuf2_memops kvm snd_rawmidi snd_hwdep snd_pci_acp6x btintel=
 uvc snd_seq_device snd_hda_core snd_pci_acp5x btbcm videobuf2_v4l2 irqbypa=
ss snd_pcm btmtk iwlwifi snd_rn_pci_acp3x sg videodev rapl snd_timer videob=
uf2_common wmi_bmof ee1004 snd_acp_config pcspkr bluetooth cfg80211 snd_soc=
_acpi k10temp snd mc snd_pci_acp3x soundcore ccp rfkill ac
[39400.400478]  battery acpi_tad amd_pmc joydev evdev msr parport_pc ppdev =
lp parport efi_pstore fuse nvme_fabrics configfs nfnetlink efivarfs autofs4=
 crc32c_cryptoapi btrfs blake2b_generic xor raid6_pq hid_microsoft ff_memle=
ss hid_cmedia r8153_ecm cdc_ether usbnet r8152 mii libphy mdio_bus usbhid d=
m_crypt dm_mod sd_mod uas usb_storage scsi_mod scsi_common amdgpu drm_clien=
t_lib i2c_algo_bit drm_ttm_helper ttm drm_panel_backlight_quirks drm_exec d=
rm_suballoc_helper amdxcp drm_buddy gpu_sched hid_multitouch drm_display_he=
lper ucsi_acpi hid_generic drm_kms_helper typec_ucsi sp5100_tco roles xhci_=
pci cec i2c_hid_acpi watchdog typec xhci_hcd amd_sfh i2c_hid rc_core nvme i=
2c_piix4 thunderbolt video usbcore ghash_clmulni_intel serio_raw hid crc16 =
nvme_core fan i2c_smbus usb_common button wmi drm aesni_intel
[39400.400514] irq event stamp: 28884
[39400.400515] hardirqs last  enabled at (28883): [<ffffffffb6200dc6>] asm_=
sysvec_apic_timer_interrupt+0x16/0x20
[39400.400521] hardirqs last disabled at (28884): [<ffffffffb71185fa>] sysv=
ec_apic_timer_interrupt+0xa/0xc0
[39400.400526] softirqs last  enabled at (28882): [<ffffffffb64f934d>] __ir=
q_exit_rcu+0xcd/0x140
[39400.400530] softirqs last disabled at (28877): [<ffffffffb64f934d>] __ir=
q_exit_rcu+0xcd/0x140
[39400.400533] CPU: 2 UID: 0 PID: 1751316 Comm: kworker/2:1 Not tainted 6.1=
6.0-08685-g260f6f4fda93 #489 PREEMPT(voluntary)
[39400.400535] Hardware name: HP HP Pavilion Aero Laptop 13-be0xxx/8916, BI=
OS F.17 12/18/2024
[39400.400537] Workqueue: events psi_avgs_work
[39400.400541] RIP: 0010:collect_percpu_times+0x2d5/0x440
[39400.400543] Code: 00 00 00 00 00 41 8b 0c 94 48 0f af c8 48 01 4c d5 00 =
48 83 c2 01 48 83 fa 06 75 e9 8d 53 01 e9 aa fd ff ff f3 90 48 8b 3c 24 <48=
> 8b 14 fd 20 d0 6d b7 48 01 c2 8b 12 f6 c2 01 0f 84 ab fe ff ff
[39400.400545] RSP: 0018:ffffc06b07823cf8 EFLAGS: 00000202
[39400.400546] RAX: ffffffffb82abc80 RBX: ffffe06aff48f440 RCX: 00000000000=
00006
[39400.400548] RDX: 00000000000014b7 RSI: ffffffffb76b7293 RDI: 00000000000=
0000d
[39400.400548] RBP: ffffc06b07823d70 R08: 0000000000000001 R09: 00000000000=
00000
[39400.400549] R10: 0000000000000001 R11: 0000000000000003 R12: ffffc06b078=
23d50
[39400.400550] R13: ffffe06aff48f454 R14: 000000000000000d R15: ffffffffb82=
abc80
[39400.400551] FS:  0000000000000000(0000) GS:ffff9d9f4e072000(0000) knlGS:=
0000000000000000
[39400.400552] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[39400.400553] CR2: 00000c2100382000 CR3: 0000000387c3b000 CR4: 00000000007=
50ef0
[39400.400554] PKRU: 55555554
[39400.400555] Call Trace:
[39400.400557]  <TASK>
[39400.400571]  psi_avgs_work+0x56/0xe0
[39400.400576]  process_one_work+0x22b/0x5b0
[39400.400588]  worker_thread+0x1d6/0x3c0
[39400.400592]  ? bh_worker+0x260/0x260
[39400.400594]  kthread+0x115/0x260
[39400.400599]  ? kthreads_online_cpu+0x120/0x120
[39400.400603]  ret_from_fork+0x231/0x2a0
[39400.400606]  ? kthreads_online_cpu+0x120/0x120
[39400.400610]  ret_from_fork_asm+0x11/0x20
[39400.400621]  </TASK>
[39400.404429] watchdog: BUG: soft lockup - CPU#4 stuck for 21s! [kworker/4=
:0:1751752]

It appears to happen randomly when I have been away from the laptop for
some time and return, or sometimes if I leave it overnight. It also
looks like it occurs on 2% of system boots. Bisecting with such a low
failure probability takes a long time. I haven't identified the bad
commit yet, but I think I have narrowed it down to between v6.16-rc6
(good) and v6.16-rc6-79-g44e4e0297c3c (bad). At this rate, I should have
a more exact bisect result within a week.

#regzbot introduced: v6.16-rc6..v6.16-rc6-79-g44e4e0297c3c

