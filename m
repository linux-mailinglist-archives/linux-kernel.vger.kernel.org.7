Return-Path: <linux-kernel+bounces-826541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B76B8EC12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E08C67AEDFA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA022F49E5;
	Mon, 22 Sep 2025 02:15:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACE616FF37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758507310; cv=none; b=NcHi9e7k/gU3/A6X68iv6PPXcblKFHl3rxzWRjKbe9ElX9I4eeRBa4eMJmAe29HO7ZOtUWjzSe6NOXBuit/VvkT5/zPpOkJhaafnvIG33J90XgRp8eUDLS5XEIqhdxNLFIKImmBtFR2rgEYDBbwEXd6kdj+Ca8RJy5Ej+OzB924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758507310; c=relaxed/simple;
	bh=kJBK8UL6kWijPSNz2JyUpLnwdlQYuYvBMuJzCgcFpBU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TAoedRPAZhO97TAvxUp7stn+ufap+6RtTTjFqvvdkoMQj/wuJrBb6hiTIN+Z3qF3U55mRBpUzJ/O7wFOD+iZgzJLKrpieUerFAifvS/BWuII5lmuSMJYZwsPwJvPcsp9PNz9FzXnlSyZclF9tUQzR0VprqGltdlXm6O7jsmuE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cVRWh4ccPz14MPw;
	Mon, 22 Sep 2025 10:14:40 +0800 (CST)
Received: from kwepemj100009.china.huawei.com (unknown [7.202.194.3])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E99C1401E9;
	Mon, 22 Sep 2025 10:14:59 +0800 (CST)
Received: from DESKTOP-A37P9LK.huawei.com (10.67.108.232) by
 kwepemj100009.china.huawei.com (7.202.194.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 22 Sep 2025 10:14:58 +0800
From: Xie Yuanbin <xieyuanbin1@huawei.com>
To: <linux@armlinux.org.uk>, <akpm@linux-foundation.org>, <david@redhat.com>,
	<lorenzo.stoakes@oracle.com>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<rppt@kernel.org>, <surenb@google.com>, <mhocko@suse.com>,
	<linmiaohe@huawei.com>, <nao.horiguchi@gmail.com>,
	<rmk+kernel@armlinux.org.uk>, <ardb@kernel.org>, <nathan@kernel.org>,
	<ebiggers@kernel.org>, <arnd@arndb.de>, <rostedt@goodmis.org>,
	<kees@kernel.org>, <dave@vasilevsky.ca>, <peterz@infradead.org>
CC: <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>, <liaohua4@huawei.com>,
	<lilinjie8@huawei.com>, <xieyuanbin1@huawei.com>
Subject: [RFC PATCH 1/2] ARM: mm: support memory-failure
Date: Mon, 22 Sep 2025 10:14:52 +0800
Message-ID: <20250922021453.3939-1-xieyuanbin1@huawei.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100009.china.huawei.com (7.202.194.3)

Memory failure provides the ability of soft offline pages,
which is very useful to handle the memory errors such as CE in ECC.

Although ARM does not have a user interface like
`/sys/devices/system/memory/soft_offline_page`, memory-failure still
provides some exported func that can be used by some module ko driver.

Memory-failure will use one page flag (PG_hwpoison). For historical
versions, this will cause the page flags to exceed the 32-bit limit
(when CONFIG_SPARSEMEM and CONFIG_HIGHMEM are both enabled),
and therefore it cannot be enabled.

The following commit:
commit 09022bc196d2 ("mm: remove PG_error")
removes a page flag, so memory-failure can now be launched on ARM now.

The core codes of memory-failure is architecture independent, in fact,
it has performed well in current testing. Perhaps it can also be enabled
on other 32-bit architectures(like x86, and it seems that it can already
be enabled on 32-bit parisc architecture), but I haven't tested it yet.

Signed-off-by: Xie Yuanbin <xieyuanbin1@huawei.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 5527935fd15a..b38c194a5cc4 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -149,20 +149,21 @@ config ARM
 	select PCI_SYSCALL if PCI
 	select PERF_USE_VMALLOC
 	select RTC_LIB
 	select SPARSE_IRQ if !(ARCH_FOOTBRIDGE || ARCH_RPC)
 	select SYS_SUPPORTS_APM_EMULATION
 	select THREAD_INFO_IN_TASK
 	select TIMER_OF if OF
 	select HAVE_ARCH_VMAP_STACK if MMU && ARM_HAS_GROUP_RELOCS
 	select TRACE_IRQFLAGS_SUPPORT if !CPU_V7M
 	select USE_OF if !(ARCH_FOOTBRIDGE || ARCH_RPC || ARCH_SA1100)
+	select ARCH_SUPPORTS_MEMORY_FAILURE
 	# Above selects are sorted alphabetically; please add new ones
 	# according to that.  Thanks.
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
 	  handhelds such as the Compaq IPAQ.  ARM-based PCs are no longer
 	  manufactured, but legacy ARM-based PC hardware remains popular in
 	  Europe.  There is an ARM Linux project with a web page at
 	  <http://www.arm.linux.org.uk/>.
 
-- 
2.48.1


