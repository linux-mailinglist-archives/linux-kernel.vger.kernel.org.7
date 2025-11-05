Return-Path: <linux-kernel+bounces-886470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E5C35B1B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 13:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 160B04F56B1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 12:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCA8315D57;
	Wed,  5 Nov 2025 12:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0EKGqBJ"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3647309EFA
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762346776; cv=none; b=qrJNVSHu9yNXNtlqiuodL/4GU+bYsE0a4simpMksTdMnIngxeN5qELfOhzpn9utXedDFr7BlZoQbi68c9vgvNpxCG2Db1B3xFNaObOyRX1OSKn8E7OBvTGgtRwRfuTIiZ60TmKStZpPe6apWip2KqsvRyiGSjRDBzdKRJiNspCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762346776; c=relaxed/simple;
	bh=nayGOxsK7QkuOgg3zJVcd6LNkN5kMXJ3SNX3eParEYM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=basw6dIjkI10afRzWxuAmICFBGVLqfalx7OTNDYztLAaSefhbTq9T6Csl7UT+tlk3XM1EN7+aWlWNWJKYVAiaVzl75KyU2snasL/c6IYmi4tyKZ2WFo4f8FXBsPDDKYVJsD8DF+uEwDfHzSRDIX3trMh5acWBYd2XJba1p6xPL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0EKGqBJ; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3408dd56b15so4077161a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 04:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762346774; x=1762951574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zdq4xlgAsz/GvQ8sKcmd6Q0LvOMqqxT1dlvIv7znvDw=;
        b=E0EKGqBJikFzZMxotH7aNtodKDzHdsPG3fWPQretZk4UX851bvVOtEbNCVe59/jZrG
         ys27gtoZZRzb14rCc2QK4DEMtOVKhEhZ19RZMVPW+IO8e3jnfPi+saoHlyxQkWwgbB3a
         s5MmI3KbfUR0qoTk3vIFlK2ByxbMEwt8p1kv/LKNKiPH76VTyRObQA2PcnDIRaXRyxwT
         CC5kS436+RvfYbeL7SCpS9U3vJ/F/eposorkYR5I7NI8fLPBndsAQC0ayesvkf6IeWci
         oCCW3AzuC53a4K1+QUUSCecz+y/srht0vPcx2DYmVDOCEgHm8VCyJdwE+TbPltdqop/o
         zdZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762346774; x=1762951574;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zdq4xlgAsz/GvQ8sKcmd6Q0LvOMqqxT1dlvIv7znvDw=;
        b=LOT7jw7zJxcy4qlNLSsJBpxyyvtW3IB/zvrAkaAlV1VyNUxG6fBk9qv+ImoO8+6rF4
         RiWim7EhHhB21ENRZ20cSeSvSf4WP1hPATBo24tdtkggbYQSrZccTMUTCoUZwGGBeo+o
         1s1tXqdP3LZ6Ydefhe5SeiNIPW/pjubRwZTcKm+YrvyKnLtnEdrfvliNpuCmSdfUNDiD
         tVAI6kCuoEVcVfHaLYnalJah2yLYHr3jAiMphPYTQJyI/U9WmhffU021GZ4TKAwxvuzh
         u8nXwOW5q+8+YdPX5sb3da7DPPoVd5p4hV4ZfxAGYipOJ/cwvUlb7d0k9yNMf1X/cjxV
         ePOw==
X-Forwarded-Encrypted: i=1; AJvYcCU1/dsbBXk3V5G4JhExoaZiuS7LHLSo/PAIZlb7QaRARTymCa70OzHSJ7A8kWPJVTYGnyjSF0v5Y6t7o/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2cUJUCEK/9AX4jw/MNWwrBzptQ6fCAs9/0nLDli1hOff9o8F
	dsPYQ0KYpnbdHaUwBxUHsnbl44AWjBb2cqxkQ9BZHBBsjG0yVWJB2smG
X-Gm-Gg: ASbGncukhF4zoEVQd8HNQvAA49Ee3Y+PZyAvhVKMdJFZGT3WAIm+DdGW6TVrvC8bAWS
	DBThswtLsY3iQ6ZG7uyceyk1tdFoum3A0ACA9nBbLTIBP2R/J5109P0ZCdahc5F2aN63BFwyDSj
	VIpdmEvtvybk/2P5ZAX6vdo8OkXTXC41AJsE5VTy8pg6TGSrZqLJXAb8VArlPW7hDAcuLOYwFUa
	RRYchkcLxeSjUha8m+zd0hGaMiH5yowJw4uCdQYDGVPtG4WOeCguctbA2U6F8BKBclPPyXNKn1z
	KitTMCxuZxMbnvycsr1HkGtLWq9Di3c58qMZ1t4dV78elzdglaDZ8RYQvsqccvZLLEbqm0FyesY
	AUDtEl8xygxIy+oVjgeV01HnVdlZcsLiLWBLjWScWDtHyYkUeSlcU9A9U6xY66FNBek+MI+fbTJ
	s+68q1REmaaZo=
X-Google-Smtp-Source: AGHT+IEzkbPUTWsUdbwrx8cF8glCItYLXMKn9S/r1/I1+u2rDjxseY8jv9jUrJG1td0YnlweDtYTyA==
X-Received: by 2002:a17:90b:1cc7:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-341a6c4b148mr3179401a91.12.1762346773806;
        Wed, 05 Nov 2025 04:46:13 -0800 (PST)
Received: from joaog-nb ([67.159.246.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3417bc8e9c2sm2658920a91.1.2025.11.05.04.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:46:13 -0800 (PST)
Date: Wed, 5 Nov 2025 09:46:08 -0300
From: 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Kishon Vijay Abraham I <kishon@ti.com>, Swapnil Jakhade <sjakhade@cadence.com>
Cc: Andrew Davis <afd@ti.com>, Francesco Dolcini <francesco@dolcini.it>, 
	=?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: TI K3 AM69 Kernel Panic when PCIe Controller is Enabled
Message-ID: <pod3anzbqdwl3l2zldz4sd47rtbruep72ehaf7kwcuh2bgflb2@y4ox65e66mkj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I was testing PCIe upstream support on TI AM69 with a NVMe Samsung SSD
to add upstream support for Toradex Aquila AM69 (sent upstream [1]) and
noticed that when enabling the PCIe controller (CONFIG_PCI_J721E_HOST=y)
on the arm64 defconfig, there is a kernel panic on nvme_pci_enable:

[    7.397838] pci 0000:00:00.0: PCI bridge to [bus 00]
[    7.402799] pci 0000:00:00.0:   bridge window [io  0x0000-0x0fff]
[    7.408887] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff]
[    7.415675] pci 0000:00:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
[    7.423501] pci 0000:00:00.0: supports D1
[    7.427509] pci 0000:00:00.0: PME# supported from D0 D1 D3hot
[    7.435887] pci 0000:00:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
[    7.444083] pci 0000:01:00.0: [144d:a808] type 00 class 0x010802 PCIe Endpoint
[    7.451449] pci 0000:01:00.0: BAR 0 [mem 0x00000000-0x00003fff 64bit]
[    7.458407] pci 0000:01:00.0: 15.752 Gb/s available PCIe bandwidth, limited by 8.0 GT/s PCIe x2 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe x4 link)
[    7.480637] pci 0000:01:00.0: ASPM: DT platform, enabling L0s-up L0s-dw L1 ASPM-L1.1 ASPM-L1.2 PCI-PM-L1.1 PCI-PM-L1.2

[    7.493685] pci 0000:01:00.0: ASPM: DT platform, enabling ClockPM
[    7.500002] pci_bus 0000:01: busn_res: [bus 01-ff] end is updated to 01
[    7.506679] pci 0000:00:00.0: bridge window [mem 0x4000200000-0x40002fffff]: assigned
[    7.514553] pci 0000:00:00.0: bridge window [mem 0x4000300000-0x40003fffff 64bit pref]: assigned
[    7.514562] pci 0000:00:00.0: bridge window [io  0x1000-0x1fff]: assigned
[    7.530134] pci 0000:01:00.0: BAR 0 [mem 0x4000200000-0x4000203fff 64bit]: assigned
         Starting Connection service...
[    7.537834] pci 0000:00:00.0: PCI bridge to [bus 01]
[    7.547531] pci 0000:00:00.0:   bridge window [io  0x1000-0x1fff]
[    7.553644] pci 0000:00:00.0:   bridge window [mem 0x4000200000-0x40002fffff]
[    7.553684] audit: type=1334 audit(1748569869.624:11): prog-id=15 op=LOAD
[    7.560814] pci 0000:00:00.0:   bridge window [mem 0x4000300000-0x40003fffff 64bit pref]
[    7.575695] pci_bus 0000:00: resource 4 [io  0x0000-0xfffff]
[    7.575702] pci_bus 0000:00: resource 5 [mem 0x4000101000-0x40ffffffff]
[    7.587971] pci_bus 0000:01: resource 0 [io  0x1000-0x1fff]
[    7.587976] pci_bus 0000:01: resource 1 [mem 0x4000200000-0x40002fffff]
[    7.587979] pci_bus 0000:01: resource 2 [mem 0x4000300000-0x40003fffff 64bit pref]

[    7.612848] pcieport 0000:00:00.0: of_irq_parse_pci: failed with rc=-22
[    7.619482] pcieport 0000:00:00.0: enabling device (0000 -> 0003)
[    7.635343] pcieport 0000:00:00.0: PME: Signaling with IRQ 600
         Starting Virtual Console Setup...
[    7.649648] pcieport 0000:00:00.0: AER: enabled with IRQ 600
[    7.660029] am65-cpsw-nuss c000000.ethernet eth1: PHY [gpio-0:04] driver [TI DP83867] (irq=379)
[    7.660666] nvme 0000:01:00.0: of_irq_parse_pci: failed with rc=-22
[    7.668777] j721e-pcie 2910000.pcie: host bridge /bus@100000/pcie@2910000 ranges:
[    7.669791] am65-cpsw-nuss c000000.ethernet eth1: configuring for phy/sgmii link mode
[    7.675751] nvme nvme0: pci function 0000:01:00.0
[    7.682528] j721e-pcie 2910000.pcie:       IO 0x4100001000..0x4100100fff -> 0x0000001000
[    7.690339] nvme 0000:01:00.0: enabling device (0000 -> 0002)
[    7.695034] j721e-pcie 2910000.pcie:      MEM 0x4100101000..0x41ffffffff -> 0x0000101000
[    7.703120] SError Interrupt on CPU7, code 0x00000000bf000000 -- SError
[    7.703127] CPU: 7 UID: 0 PID: 70 Comm: kworker/u32:3 Tainted: G   M                6.18.0-rc1-00023-g417c89ae1522 #3 PREEMPT
[    7.703133] Tainted: [M]=MACHINE_CHECK
[    7.703135] Hardware name: Toradex Aquila AM69 V1.0 on Aquila Development Board (DT)
[    7.703139] Workqueue: async async_run_entry_fn
[    7.703155] pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    7.703159] pc : nvme_pci_enable+0x54/0x598 [nvme]
[    7.703178] lr : nvme_pci_enable+0x48/0x598 [nvme]
[    7.703183] sp : ffff80008130bad0
[    7.703184] x29: ffff80008130baf0 x28: 0000000000000000 x27: 0000000000000000
[    7.703189] x26: ffff000800028028 x25: ffff000800e211c0 x24: ffff00080d242260
[    7.703194] x23: ffffbfcbbb091150 x22: ffff0008081b50c8 x21: ffff0008081b5000
[    7.703199] x20: ffff0008081b5000 x19: ffff00080d242000 x18: 0000000000000006
[    7.703203] x17: 203e2d2066666630 x16: ffffbfcbeb0d1ca0 x15: 2e2e303030313030
[    7.703207] x14: 303031347830204f x13: 3030303130303030 x12: 30307830203e2d20
[    7.703211] x11: 6666663030313030 x10: 313478302e2e3030 x9 : 4920202020202020
[    7.703216] x8 : 3a656963702e3030 x7 : 205d383235323836 x6 : 362e37202020205b
[    7.703220] x5 : ffff00080834f000 x4 : 0000000000000006 x3 : ffff800092800000
[    7.703224] x2 : 0000000000000000 x1 : 0000000000000000 x0 : 0000000000000000
[    7.703229] Kernel panic - not syncing: Asynchronous SError Interrupt
[    7.703232] CPU: 7 UID: 0 PID: 70 Comm: kworker/u32:3 Tainted: G   M                6.18.0-rc1-00023-g417c89ae1522 #3 PREEMPT
[    7.703236] Tainted: [M]=MACHINE_CHECK
[    7.703238] Hardware name: Toradex Aquila AM69 V1.0 on Aquila Development Board (DT)
[    7.703239] Workqueue: async async_run_entry_fn
[    7.703244] Call trace:
[    7.703247]  show_stack+0x18/0x24 (C)
[    7.703254]  dump_stack_lvl+0x34/0x8c
[    7.703260]  dump_stack+0x18/0x24
[    7.703263]  vpanic+0x324/0x368
[    7.703270]  nmi_panic+0x0/0x64
[    7.703274]  add_taint+0x0/0xbc
[    7.703279]  arm64_serror_panic+0x70/0x80
[    7.703282]  do_serror+0x3c/0x70
[    7.703285]  el1h_64_error_handler+0x34/0x50
[    7.703290]  el1h_64_error+0x6c/0x70
[    7.703293]  nvme_pci_enable+0x54/0x598 [nvme] (P)
[    7.703299]  nvme_probe+0x358/0x77c [nvme]
[    7.703304]  local_pci_probe+0x40/0xa4
[    7.703311]  pci_device_probe+0xc0/0x240
[    7.703316]  really_probe+0xbc/0x29c
[    7.703324]  __driver_probe_device+0x78/0x12c
[    7.703329]  driver_probe_device+0xd8/0x15c
[    7.703334]  __device_attach_driver+0xb8/0x134
[    7.703339]  bus_for_each_drv+0x88/0xe8
[    7.703344]  __device_attach_async_helper+0xb4/0xd8
[    7.703349]  async_run_entry_fn+0x34/0xe0
[    7.703353]  process_one_work+0x148/0x28c
[    7.703360]  worker_thread+0x2d0/0x3d8
[    7.703364]  kthread+0x12c/0x204
[    7.703369]  ret_from_fork+0x10/0x20
[    7.703374] SMP: stopping secondary CPUs
[    7.708837] Kernel Offset: 0x3fcb6aa00000 from 0xffff800080000000
[    7.708840] PHYS_OFFSET: 0xfff1000080000000
[    7.708842] CPU features: 0x080000,04025000,40004001,0400421b
[    7.708845] Memory Limit: none
[    7.996038] ---[ end Kernel panic - not syncing: Asynchronous SError Interrupt ]---


The issue seems to be related to the Serdes PHY
(CONFIG_PHY_CADENCE_TORRENT and CONFIG_PHY_J721E_WIZ) being enabled as a
module on the arm64 defconfig. Enabling these configs as built-in, at
least on my system, makes the PCIe work.

Toradex already reported this to TI for the downstream kernel [2], but
it seems that it is also happening on upstream.

[1] https://lore.kernel.org/lkml/20251104144915.60445-1-francesco@dolcini.it/
[2] https://e2e.ti.com/support/processors-group/processors/f/processors-forum/1406797/am69-nvme-pcie-and-kernel-panic

Best Regards,
João Paulo Gonçalves


