Return-Path: <linux-kernel+bounces-720935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D4AFC248
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161831AA6905
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 05:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4D3219A79;
	Tue,  8 Jul 2025 05:53:15 +0000 (UTC)
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461E22153D2
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751953994; cv=none; b=bHuTxIHYzWiF5s0VDhGifPp6EvmY4Q9fqcVETN/DWwFxi75QBr6lq2p2wlXgj2BnPYrZ1wHBZe5nCGsL3E3GSRtBrNhlSe+bBJFsXfY7ciHwEUb2ILADMivSU84mPG97fA8gb1G7TJC5WKwfvHU/FqXddVCliDk41eml05W7FLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751953994; c=relaxed/simple;
	bh=1mpNSbTAWMAyLh+bfwz3BZsuheMJr11MCOYu8BDp9L0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bw4bkqz/iukE/64+t+325B2dtTxFRGNjwcdWoUsOyb3zXFXNNnlftMVfuuq5rcKR1cctWwM+DaXDWCO4vR9iru5yjenX33G6dk91O0wlL9NtghDuaJ6Mb2ePsEP+nHTFTNl/efm3sr1Dv8vCJFnKKoR8W6mNwzev1tRcRrni5cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: 7ycCWM/jRzea/f89tGv4TQ==
X-CSE-MsgGUID: mwyw/qn6TRSMqdhjDZ8maQ==
X-IronPort-AV: E=Sophos;i="6.16,296,1744041600"; 
   d="scan'208";a="145532342"
From: weilinghan <weilinghan@xiaomi.com>
To: <helgaas@kernel.org>
CC: <bhelgaas@google.com>, <hulingchen@xiaomi.com>,
	<linux-kernel@vger.kernel.org>, <vidyas@nvidia.com>, <weilinghan@xiaomi.com>,
	<weipengliang@xiaomi.com>
Subject: Re: [PATCH] PCI: remove call pci_save_aspm_l1ss_state() from pci_save_pcie_state()
Date: Tue, 8 Jul 2025 13:53:07 +0800
Message-ID: <20250708055307.4555-1-weilinghan@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707194903.GA2096996@bhelgaas>
References: <20250707194903.GA2096996@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX19.mioffice.cn (10.237.8.139) To BJ-MBX03.mioffice.cn
 (10.237.8.123)

On Mon, 7 Jul 2025 14:49:03 -0500, Bjorn Helgaas wrote:
>On Mon, Jul 07, 2025 at 07:52:36PM +0800, weilinghan wrote:
>> During the suspend-resume process, PCIe resumes by enabling L1.2 in 
>> the pci_restore_state function due to patch 4ff116d0d5fd.
>> However, in the following scenario, the resume process becomes very 
>> time-consuming:
>>
>> 1.The platform has multiple PCI buses.
>> 2.The link transition time from L1.2 to L0 exceeds 100 microseconds by 
>> accessing the configuration space of the EP.
>> 3.The PCI framework has async_suspend enabled (by calling 
>> device_enable_async_suspend(&dev->dev)
>> in pci_pm_init(struct pci_dev *dev)).
>> 4.On ARM platforms, CONFIG_PCI_LOCKLESS_CONFIG is not enabled, which 
>> means the pci_bus_read_config_##size interfaces contain locks (spinlock).
>>
>> Practical measurements show that enabling L1.2 during the resume 
>> process introduces an additional delay of approximately 150ms in the 
>> pci_pm_resume_noirq() function for platforms with two PCI buses, 
>> compared to when L1.2 is disabled.

>We really need an argument for why this change would be correct, not just the fact that it makes resume faster.  Vidya made the change in 4ff116d0d5fd to fix a problem, and it looks like this patch would reintroduce the problem.

Ok, I'm seeing lock contention issues when multiple PCI devices call pci_restore_state() during the resume_noirq phase.

This problem arises due to commit a1e4d72cd ("PM: Allow PCI devices to suspend/resume asynchronously"), which changed the noirq phase of PCI devices to be executed asynchronously. As a result, multiple PCI devices may attempt to restore configuration space concurrently, leading to contention on the PCI configuration lock.

Additionally, commit 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume") by Vidya enables L1.2 state handling, which increases the time spent in the critical section, thereby further exacerbating the lock contention and increasing resume latency.

Currently, I'm considering a few possible approaches to address this:

1.In the driver, call device_disable_async_suspend() to prevent asynchronous suspend/resume for specific devices that are known to have contention issues.
2.Enable CONFIG_PCI_LOCKLESS_CONFIG on the ARM platform
3.Make dev_pm_skip_resume() return true for certain devices, skipping pci_restore_state() in the PCI core during resume. 
4.revert commit a1e4d72cd ("PM: Allow PCI devices to suspend/resume asynchronously")
I'd appreciate any insights or recommendations from the community on the best way to proceed. Are there any preferred approaches for handling?

Thanks,
weilinghan

