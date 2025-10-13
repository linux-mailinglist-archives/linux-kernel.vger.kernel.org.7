Return-Path: <linux-kernel+bounces-849908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F182DBD1433
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 04:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 49BB84E7B0B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 02:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6621E26A1B9;
	Mon, 13 Oct 2025 02:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="arIPAr01"
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128D57263B
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760324200; cv=none; b=JuO0ibZvANmU9p6MGFTDraIGSz0LC2sKsIrICBxTZ6ZepwaVewRqAkLQTWPHGdm+zKkXB1K3Xcdd/3zUNKwxQNrbSvk5Utao/t+/RSbsVIVIg1QExeWdyZJsYuXskpPr6WMS38SJ8eokWsOsnwZTrEouQ8xV2m8sjchi5mzxkOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760324200; c=relaxed/simple;
	bh=jKt4+iHfdBNfPmIrcMIzqqblpMw9IlGf9upTULyZpFk=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:CC:Content-Type; b=O+Doxk3AhR7RzydveB0bp+j1MoUil0ASjV/hTYuRJHPdo4PeHXOQfRggY/gHsX1aW9OEWcnDkNM4EPInT9oxeqD0scKKxbQvvwYaHXR03nYVxX7rI5STdUkoJt0v9vORb+lQihcXnoTLJdd77LcHIGtvHOz7KAEHjFmwZMzdPt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=arIPAr01; arc=none smtp.client-ip=113.46.200.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=de6xzwds0PpdJLjxfLnFji0StK0sVKKBeV9nOZya29Y=;
	b=arIPAr01816wgOkxmb80SsbQVMKqFohsrrWeyReRdRXj24SClEQzBJB/6QjdAKXqD8zMBM+wT
	FKwqHFVsagHk/UnHXTbGOJcCMIk1MSPrcxtJWKnpML4I66c0JDMdcHGaWgmomujccyLkhH0RuLX
	PWANODXQF7nyQFTpnf+TP/0=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4clMRt4FnTz1K97v;
	Mon, 13 Oct 2025 10:56:10 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id CCF1014010D;
	Mon, 13 Oct 2025 10:56:28 +0800 (CST)
Received: from [10.67.121.183] (10.67.121.183) by
 dggpemf500013.china.huawei.com (7.185.36.188) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 13 Oct 2025 10:56:28 +0800
Message-ID: <5269ecde-be8e-4920-a76f-882da1475d5d@huawei.com>
Date: Mon, 13 Oct 2025 10:56:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Marc Zyngier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Zenghui Yu <yuzenghui@huawei.com>
From: Jinqian Yang <yangjinqian1@huawei.com>
Subject: [Question] QEMU VM fails to restart repeatedly with VFIO passthrough
 on GICv4.1
CC: jiangkunkun <jiangkunkun@huawei.com>, Zhou Wang <wangzhou1@hisilicon.com>,
	liuyonglong <liuyonglong@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi, all

On a GICv4.1 environment running kernel 6.16, when launching VMs with
QEMU and passing through VF devices, after repeatedly booting and
killing the VMs hundreds of times, the host reports call traces and the
VMs become unresponsive. The call traces show VFIO call stacks.

[14201.974880] BUG: Bad page map in process qemu-system-aar 
pte:fefefefefefefefe pmd:8000820b1ba0403
[14201.974895] addr:0000fffdd7400000 vm_flags:80240644bb 
anon_vma:0000000000000000 mapping:ffff08208e9b7758 index:401eed6a
[14201.974905] file:[vfio-device] fault:vfio_pci_mmap_page_fault 
[vfio_pci_core] mmap:vfio_device_fops_mmap [vfio] mmap_prepare: 0x0 
read_folio:0x0
[14201.974923] CPU: 2 UID: 0 PID: 50408 Comm: qemu-system-aar Kdump: 
loaded Tainted: G           O        6.16.0-rc4+ #1 PREEMPT
[14201.974926] Tainted: [O]=OOT_MODULE
[14201.974927] Hardware name: To be filled by O.E.M. To be filled by 
O.E.M./To be filled by O.E.M., BIOS HixxxxEVB V3.4.7 09/04/2025
[14201.974928] Call trace:
[14201.974929]  show_stack+0x20/0x38 (C)
[14201.974934]  dump_stack_lvl+0x80/0xf8
[14201.974938]  dump_stack+0x18/0x28
[14201.974940]  print_bad_pte+0x138/0x1d8
[14201.974943]  vm_normal_page+0xa4/0xd0
[14201.974945]  unmap_page_range+0x648/0x1110
[14201.974947]  unmap_single_vma.constprop.0+0x90/0x118
[14201.974948]  zap_page_range_single_batched+0xbc/0x180
[14201.974950]  zap_page_range_single+0x60/0xa0
[14201.974952]  unmap_mapping_range+0x114/0x140
[14201.974953]  vfio_pci_zap_and_down_write_memory_lock+0x3c/0x58 
[vfio_pci_core]
[14201.974957]  vfio_basic_config_write+0x214/0x2d8 [vfio_pci_core]
[14201.974959]  vfio_pci_config_rw+0x1d8/0x1290 [vfio_pci_core]
[14201.974962]  vfio_pci_rw+0x118/0x200 [vfio_pci_core]
[14201.974965]  vfio_pci_core_write+0x28/0x40 [vfio_pci_core]
[14201.974968]  vfio_device_fops_write+0x3c/0x58 [vfio]
[14201.974971]  vfs_write+0xd8/0x400
[14201.974973]  __arm64_sys_pwrite64+0xac/0xe0
[14201.974974]  invoke_syscall+0x50/0x120
[14201.974976]  el0_svc_common.constprop.0+0xc8/0xf0
[14201.974978]  do_el0_svc+0x24/0x38
[14201.974979]  el0_svc+0x38/0x130
[14201.974982]  el0t_64_sync_handler+0xc8/0xd0
[14201.974984]  el0t_64_sync+0x1ac/0x1b0
[14201.975025] Disabling lock debugging due to kernel taint

This value (0xfefefefefefefefe) is very special - it's a "poison" value.
QEMU or the VFIO driver may have attempted to access or manipulate a
page that has already been freed.

Thanks in advance for any insights!
Jinqian



