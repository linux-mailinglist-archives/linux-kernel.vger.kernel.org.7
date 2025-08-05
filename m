Return-Path: <linux-kernel+bounces-756376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F87B1B343
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:24:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C8B170B03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FF526FDBF;
	Tue,  5 Aug 2025 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgSynJO3"
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DB825DCF0
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754396654; cv=none; b=knAfK+A4xAnuURNqMEfc44RSbJVM9blHCkt2GEqnMgwmJ8b8ZK5B2iC2R3ZshzCF6dzvmuCqwonJaTnVhvcWu+QdOqm0MpuXM++kdUUeqWuV+W4yWqRdf7okLXPcYNmPzFqZfq8qXXUhiV9MQNGBBA1H9kFGCmrY/hSzcg9dooo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754396654; c=relaxed/simple;
	bh=yvp5U04n0jvo1yNaHCaLsVbnwDDph28jqtMNeGwTkDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQ7TORe6WA6/LPNaf53zFI0xAmMHlMrvUxVCFAjTsZc0YIyOt3PhyAVHAd3/wTOPiCbHbm21ISfjaCNjp3XmFhwjdGmpHsZNSlbmSJxykNPrAcLeMxhuBIX18W8Rr+EHaW90eqoAwdhap24EMxgp1fGBQCDc5S9T2QhGLxFCPTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgSynJO3; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-24014cd385bso51701275ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 05:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754396650; x=1755001450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9X/pThqzNQYDq90zAlS4WiASs6LDDtrmHueR6IBK/4=;
        b=MgSynJO34GuiyHhSw/lV6VZ1SKNCYJe3migrSZqyjNi5SAnrbpSiJ90K1jQkJ7l1L9
         qxC6kUcbVOKVmOpSWu0u/R/0/RqAJ4+9/uHOeVM3BNCXjlsf2FO+E+owUhjz3tvJDfP6
         9yC8vjZVEQGK5xypKY4+F+de/lCFnqzvymf4Uj0xUzUi4/qhizPx0eJ3jHCalSkBK8Ez
         v2suzQqgGZdiiAV6R1qoYvmUBieYL5Em6bF8nDxmAaD7J40S4mlZy709Aq9GgSInEt7N
         ZH4djOWsBODRme9QZ2qr9ybElxdiqjqS8vKA4yfGAvCgv/E94WAaXYubMWPK9sKBG2zr
         DdYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754396650; x=1755001450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p9X/pThqzNQYDq90zAlS4WiASs6LDDtrmHueR6IBK/4=;
        b=g+enwXkKCMr43Bb4QWqgQQDQfuetTubNcn3+BEvDxbq3LiPIezhO08HoLB+tTBbbQs
         ngIa0Ywzp4FOgA9VkX3s0mnhko4y4EEAkjqrUX2rhHdEWD0iXwDfEEriKxEkyCm/vwsT
         JVS2nRIb7CncGI+eD5QisohdKZL84N+wE2tBwUjxIoBTSbWnCjgD7h4lDRmubyRr+UvA
         ALblx0VJ8lt1+It65CN8n3DVvsS3RcczirLjGKcGT9o3rWpWNVVhooBGNmgQquGBMZom
         Se65UnR/Ff7WBiAo/DEaqC/G6xKaCduNT7vT9WPr+D1u8rNMjXyO8ltAWmEY/XfdgOtd
         se9A==
X-Gm-Message-State: AOJu0YxRpwlkvwXts1uP1pw2v3u2DQXytAc2pwWMUy06NsDge2wkcdDi
	SevtHr7ObKlu3MY6REBiiWG5+jCy9+tByC6ZVS/k9YxWO3NtXG/2Vr3eTKF8PtIJzHF4Yw==
X-Gm-Gg: ASbGnctbC9ihLkTkG+jBrlkTMWzYFI59k4/VlQAaPVWIvEDPR8uPrifTUPVTLhjB3/b
	CEnpir433KdZW3ZNw1xb+RPrJYL+5IPQfXjQVKXJfqGnBiQQ2hCwPPKLjCxw5Drzd0n1aWiYXUO
	lmItV0wNLKap5WiNn0r+AJPhGp3V8C3tvYymxPgs7JgNdj4EuurXBynOudWi1Rz84khQCTGwf+Y
	izfXhql+JPcgC0zRa2sCTk6BZ4wbnk2WBeCeKa5/CrFGwzx8IfoAoPpOg6R3XR9SK//9kW7lgOb
	RhA9v/tNTlKYq2qoT9oLXAKDm6k1+FrIU4NPxqrLE5RZbA0/EoC4AAbZg2iQl24N0rGt/GqxQK9
	yEXU3RkD1fTGtvrpalTVGlyFw3TEVeXwblpMyHMoqvDXuEFyPzPftBNzHkbU=
X-Google-Smtp-Source: AGHT+IGsCG7ertkHUwO8410TydcZ1Ut9c6vS7qYkM60Ya/2eA0gx+GQuajEiLPgw9aXaU/Vzyf850A==
X-Received: by 2002:a17:903:2d1:b0:240:8cda:9ca1 with SMTP id d9443c01a7336-24247059772mr151475535ad.50.1754396650272;
        Tue, 05 Aug 2025 05:24:10 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8aaaf1bsm134145795ad.159.2025.08.05.05.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 05:24:09 -0700 (PDT)
From: bsdhenrymartin@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To: huntazhang@tencent.com,
	jitxie@tencent.com,
	landonsun@tencent.com,
	parthiban.veerasooran@microchip.com,
	christian.gromm@microchip.com
Cc: linux-kernel@vger.kernel.org,
	bsdhenrymartin@gmail.com,
	Henry Martin <bsdhenryma@tencent.com>
Subject: [PATCH v2] Staging: most: fix UAF in hdm_disconnect
Date: Tue,  5 Aug 2025 20:24:02 +0800
Message-ID: <20250805122402.1990670-1-tcs_kernel@tencent.com>
X-Mailer: git-send-email 2.41.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Henry Martin <bsdhenryma@tencent.com>

The hdm_disconnect() function calls most_deregister_interface(), which
internally invokes device_unregister(iface->dev). Since iface->dev is
assigned to &mdev->dev, device_unregister already drops the last
reference to mdev->dev, triggering its release.

However, hdm_disconnect() later performs kfree(mdev->busy_urbs), causing
a Use-After-Free read and KASAN kernel crash.

Fix this by removing the redundant put_device(&mdev->dev) and moving the
most_deregister_interface() to the end of the function.

[   87.212943][  T507] usb 1-1: USB disconnect, device number 2
[   87.221698][  T507] ==================================================================
[   87.222364][  T507] BUG: KASAN: slab-use-after-free in hdm_disconnect+0x227/0x250
[   87.222998][  T507] Read of size 8 at addr ffff88810dcf5890 by task kworker/0:2/507
[   87.223737][  T507]
[   87.223989][  T507] CPU: 0 UID: 0 PID: 507 Comm: kworker/0:2 Not tainted 6.16.0-rc4-00013-g
[   87.224005][  T507] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-4
[   87.224014][  T507] Workqueue: usb_hub_wq hub_event
[   87.224029][  T507] Call Trace:
[   87.224033][  T507]  <TASK>
[   87.224038][  T507]  dump_stack_lvl+0x116/0x1f0
[   87.224060][  T507]  print_report+0xcd/0x680
[   87.224074][  T507]  ? __virt_addr_valid+0x81/0x610
[   87.224090][  T507]  ? __phys_addr+0xe8/0x180
[   87.224105][  T507]  ? hdm_disconnect+0x227/0x250
[   87.224115][  T507]  kasan_report+0xe0/0x110
[   87.224129][  T507]  ? hdm_disconnect+0x227/0x250
[   87.224141][  T507]  hdm_disconnect+0x227/0x250
[   87.224153][  T507]  usb_unbind_interface+0x1da/0x9a0
[   87.224167][  T507]  ? kernfs_remove_by_name_ns+0xbe/0x110
[   87.224186][  T507]  ? __pfx_usb_unbind_interface+0x10/0x10
[   87.224199][  T507]  device_remove+0x122/0x170
[   87.224212][  T507]  device_release_driver_internal+0x44b/0x620
[   87.224228][  T507]  bus_remove_device+0x22f/0x420
[   87.224241][  T507]  device_del+0x396/0x9f0
[   87.224254][  T507]  ? __pfx_device_del+0x10/0x10
[   87.224266][  T507]  ? __pfx___mutex_lock+0x10/0x10
[   87.224283][  T507]  ? __pfx___pm_runtime_barrier+0x10/0x10
[   87.224297][  T507]  ? do_raw_spin_lock+0x12c/0x2b0
[   87.224312][  T507]  usb_disable_device+0x355/0x7d0
[   87.224333][  T507]  usb_disconnect+0x2e1/0x920
[   87.224352][  T507]  hub_event+0x1aa0/0x5030
[   87.224368][  T507]  ? __lock_acquire+0xb8a/0x1c90
[   87.224379][  T507]  ? __pfx_hub_event+0x10/0x10
[   87.224389][  T507]  ? __free_object+0xc0/0x400
[   87.224404][  T507]  ? rcu_is_watching+0x12/0xc0
[   87.224421][  T507]  process_one_work+0x9cf/0x1b70
[   87.224437][  T507]  ? __pfx_hub_event+0x10/0x10
[   87.224448][  T507]  ? __pfx_process_one_work+0x10/0x10
[   87.224464][  T507]  ? assign_work+0x1a0/0x250
[   87.224477][  T507]  worker_thread+0x6c8/0xf10
[   87.224492][  T507]  ? __kthread_parkme+0x19e/0x250
[   87.224511][  T507]  ? __pfx_worker_thread+0x10/0x10
[   87.224525][  T507]  kthread+0x3c5/0x780
[   87.224538][  T507]  ? __pfx_kthread+0x10/0x10
[   87.224550][  T507]  ? rcu_is_watching+0x12/0xc0
[   87.224565][  T507]  ? __pfx_kthread+0x10/0x10
[   87.224578][  T507]  ret_from_fork+0x5b6/0x6c0
[   87.224596][  T507]  ? __pfx_kthread+0x10/0x10
[   87.224608][  T507]  ret_from_fork_asm+0x1a/0x30
[   87.224627][  T507]  </TASK>
[   87.224631][  T507]
[   87.246849][  T507] Allocated by task 507:
[   87.247253][  T507]  kasan_save_stack+0x33/0x60
[   87.247707][  T507]  kasan_save_track+0x14/0x30
[   87.248171][  T507]  __kasan_kmalloc+0x8f/0xa0
[   87.248618][  T507]  hdm_probe+0xb3/0x19a0
[   87.249034][  T507]  usb_probe_interface+0x303/0x9c0
[   87.249522][  T507]  really_probe+0x241/0xa90
[   87.249973][  T507]  __driver_probe_device+0x1de/0x440
[   87.250482][  T507]  driver_probe_device+0x4c/0x1b0
[   87.250984][  T507]  __device_attach_driver+0x1df/0x310
[   87.251504][  T507]  bus_for_each_drv+0x159/0x1e0
[   87.251982][  T507]  __device_attach+0x1e4/0x4b0
[   87.252443][  T507]  bus_probe_device+0x17f/0x1c0
[   87.252915][  T507]  device_add+0x1148/0x1a70
[   87.253358][  T507]  usb_set_configuration+0x1187/0x1e20
[   87.253886][  T507]  usb_generic_driver_probe+0xb1/0x110
[   87.254415][  T507]  usb_probe_device+0xef/0x3e0
[   87.254883][  T507]  really_probe+0x241/0xa90
[   87.255322][  T507]  __driver_probe_device+0x1de/0x440
[   87.255842][  T507]  driver_probe_device+0x4c/0x1b0
[   87.256328][  T507]  __device_attach_driver+0x1df/0x310
[   87.256853][  T507]  bus_for_each_drv+0x159/0x1e0
[   87.257333][  T507]  __device_attach+0x1e4/0x4b0
[   87.257797][  T507]  bus_probe_device+0x17f/0x1c0
[   87.258268][  T507]  device_add+0x1148/0x1a70
[   87.258711][  T507]  usb_new_device+0xd07/0x19d0
[   87.259176][  T507]  hub_event+0x2f85/0x5030
[   87.259604][  T507]  process_one_work+0x9cf/0x1b70
[   87.260095][  T507]  worker_thread+0x6c8/0xf10
[   87.260546][  T507]  kthread+0x3c5/0x780
[   87.260947][  T507]  ret_from_fork+0x5b6/0x6c0
[   87.261398][  T507]  ret_from_fork_asm+0x1a/0x30
[   87.261867][  T507]
[   87.262098][  T507] Freed by task 507:
[   87.262477][  T507]  kasan_save_stack+0x33/0x60
[   87.262934][  T507]  kasan_save_track+0x14/0x30
[   87.263389][  T507]  kasan_save_free_info+0x3b/0x60
[   87.263881][  T507]  __kasan_slab_free+0x37/0x50
[   87.264276][  T507]  kfree+0x283/0x470
[   87.264593][  T507]  device_release+0xa1/0x240
[   87.264979][  T507]  kobject_put+0x1e7/0x5a0
[   87.265345][  T507]  device_unregister+0x2f/0xc0
[   87.265733][  T507]  hdm_disconnect+0x10b/0x250
[   87.266119][  T507]  usb_unbind_interface+0x1da/0x9a0
[   87.266539][  T507]  device_remove+0x122/0x170
[   87.266921][  T507]  device_release_driver_internal+0x44b/0x620
[   87.267410][  T507]  bus_remove_device+0x22f/0x420
[   87.267808][  T507]  device_del+0x396/0x9f0
[   87.268162][  T507]  usb_disable_device+0x355/0x7d0
[   87.268634][  T507]  usb_disconnect+0x2e1/0x920
[   87.269105][  T507]  hub_event+0x1aa0/0x5030
[   87.269536][  T507]  process_one_work+0x9cf/0x1b70
[   87.270020][  T507]  worker_thread+0x6c8/0xf10
[   87.270466][  T507]  kthread+0x3c5/0x780
[   87.270867][  T507]  ret_from_fork+0x5b6/0x6c0
[   87.271322][  T507]  ret_from_fork_asm+0x1a/0x30
[   87.271782][  T507]
[   87.272015][  T507] The buggy address belongs to the object at ffff88810dcf4000
[   87.272015][  T507]  which belongs to the cache kmalloc-8k of size 8192
[   87.273337][  T507] The buggy address is located 6288 bytes inside of
[   87.273337][  T507]  freed 8192-byte region [ffff88810dcf4000, ffff88810dcf6000)
[   87.274661][  T507]
[   87.274899][  T507] The buggy address belongs to the physical page:
[   87.275512][  T507] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x100
[   87.276359][  T507] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[   87.277159][  T507] anon flags: 0x200000000000040(head|node=0|zone=2)
[   87.277799][  T507] page_type: f5(slab)
[   87.278200][  T507] raw: 0200000000000040 ffff888100042280 ffffea00043f3800 0000000000000003
[   87.279015][  T507] raw: 0000000000000000 0000000080020002 00000000f5000000 0000000000000000
[   87.279826][  T507] head: 0200000000000040 ffff888100042280 ffffea00043f3800 000000000000003
[   87.280654][  T507] head: 0000000000000000 0000000080020002 00000000f5000000 000000000000000
[   87.281480][  T507] head: 0200000000000003 ffffea0004373c01 00000000ffffffff 00000000fffffff
[   87.282301][  T507] head: 0000000000000000 0000000000000000 00000000ffffffff 000000000000008
[   87.283136][  T507] page dumped because: kasan: bad access detected
[   87.283747][  T507] page_owner tracks the page as allocated
[   87.284297][  T507] page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd28c5
[   87.286266][  T507]  post_alloc_hook+0x1c0/0x230
[   87.286727][  T507]  get_page_from_freelist+0xf98/0x2ce0
[   87.287259][  T507]  __alloc_frozen_pages_noprof+0x259/0x21e0
[   87.287835][  T507]  alloc_pages_mpol+0xe4/0x410
[   87.288312][  T507]  new_slab+0x23b/0x330
[   87.288714][  T507]  ___slab_alloc+0xda5/0x1940
[   87.289175][  T507]  __slab_alloc.constprop.0+0x56/0xb0
[   87.289691][  T507]  __kmalloc_node_track_caller_noprof+0x15e/0x4c0
[   87.290319][  T507]  kmalloc_reserve+0xef/0x2c0
[   87.290783][  T507]  __alloc_skb+0x166/0x380
[   87.291224][  T507]  netlink_dump+0x292/0x11c0
[   87.291676][  T507]  __netlink_dump_start+0x6d6/0x990
[   87.292185][  T507]  rtnetlink_rcv_msg+0xb3e/0xe90
[   87.292674][  T507]  netlink_rcv_skb+0x155/0x420
[   87.293144][  T507]  netlink_unicast+0x53d/0x7f0
[   87.293603][  T507]  netlink_sendmsg+0x8d1/0xdd0
[   87.294068][  T507] page last free pid 2820 tgid 2820 stack trace:
[   87.294668][  T507]  __free_frozen_pages+0x78a/0x1040
[   87.295178][  T507]  __put_partials+0x16d/0x1c0
[   87.295631][  T507]  qlist_free_all+0x4d/0x120
[   87.296086][  T507]  kasan_quarantine_reduce+0x195/0x1e0
[   87.296611][  T507]  __kasan_slab_alloc+0x4e/0x70
[   87.297086][  T507]  kmem_cache_alloc_noprof+0x14f/0x3b0
[   87.297614][  T507]  getname_flags.part.0+0x4c/0x550
[   87.298116][  T507]  getname_flags+0x93/0xf0
[   87.298550][  T507]  user_path_at+0x24/0x60
[   87.298983][  T507]  do_faccessat+0x139/0xba0
[   87.299431][  T507]  __x64_sys_access+0x5b/0x80
[   87.299899][  T507]  do_syscall_64+0xcd/0x4b0
[   87.300340][  T507]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   87.300909][  T507]
[   87.301139][  T507] Memory state around the buggy address:
[   87.301670][  T507]  ffff88810dcf5780: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   87.302433][  T507]  ffff88810dcf5800: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   87.303198][  T507] >ffff88810dcf5880: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   87.303969][  T507]                          ^
[   87.304407][  T507]  ffff88810dcf5900: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   87.305164][  T507]  ffff88810dcf5980: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[   87.305924][  T507] ==================================================================

Fixes: a4198cdf0c34 ("Staging: most: add MOST driver's hdm-usb module")
Signed-off-by: Henry Martin <bsdhenryma@tencent.com>
---
V1->V2:
  There are no observable changes. This patch is a reminder to the
  maintainer to fix the issue.

 drivers/most/most_usb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/most/most_usb.c b/drivers/most/most_usb.c
index cf5be9c449a5..4a7100ef373b 100644
--- a/drivers/most/most_usb.c
+++ b/drivers/most/most_usb.c
@@ -1120,14 +1120,13 @@ static void hdm_disconnect(struct usb_interface *interface)
 
 	if (mdev->dci)
 		device_unregister(&mdev->dci->dev);
-	most_deregister_interface(&mdev->iface);
 
 	kfree(mdev->busy_urbs);
 	kfree(mdev->cap);
 	kfree(mdev->conf);
 	kfree(mdev->ep_address);
 	put_device(&mdev->dci->dev);
-	put_device(&mdev->dev);
+	most_deregister_interface(&mdev->iface);
 }
 
 static int hdm_suspend(struct usb_interface *interface, pm_message_t message)
-- 
2.41.3


