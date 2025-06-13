Return-Path: <linux-kernel+bounces-684927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 342C4AD81F8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 05:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4CCC3B004E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jun 2025 03:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5921FE44C;
	Fri, 13 Jun 2025 03:46:03 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A559C1ACEAF;
	Fri, 13 Jun 2025 03:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749786362; cv=none; b=WUPK4lqzo4plhgV48W7fdddtLJIOhPFg1oURb9IqH/gxMm7q7C4Ci0KxgrobmIhxQwSNokXJMXiC6PkJ59o4UfvCXmoB4FgoCvDT/ZYJhQ0LWcVIKSarcPIh/fpjfqA1/DRxcl6fNgz1UN1dPIb512rM/HqxZis4B2diOUFRnls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749786362; c=relaxed/simple;
	bh=x91+dO4U2XcSaSQxxnhakjLCHZdGXqRS81O4cpkMzRA=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=iDhLI69Df8lUZsOeUQSgTM9DIzTXhIFpDghpDBbpEqPBdulJ4yXQRoWI7XUAAr4Xb63Id1l+Yvpfbn++aA0limlywqMSr8L9cG/kYJDWy1dowli8ddvbIdi6pkNwb9nMftkt7C/FuDQvHqo6JkxyQWt5ZWRbd16ukBIP3niLZEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4bJQKb1v7nz8RV6H;
	Fri, 13 Jun 2025 11:45:55 +0800 (CST)
Received: from njb2app06.zte.com.cn ([10.55.23.119])
	by mse-fl2.zte.com.cn with SMTP id 55D3jmd1001870;
	Fri, 13 Jun 2025 11:45:48 +0800 (+08)
	(envelope-from jiang.kun2@zte.com.cn)
Received: from mapi (njb2app05[null])
	by mapi (Zmail) with MAPI id mid204;
	Fri, 13 Jun 2025 11:45:50 +0800 (CST)
Date: Fri, 13 Jun 2025 11:45:50 +0800 (CST)
X-Zmail-TransId: 2afd684b9eee46e-cb709
X-Mailer: Zmail v1.0
Message-ID: <20250613114550088852be6WxL6p3X0fBpGw7h@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <jiang.kun2@zte.com.cn>
To: <alexs@kernel.org>, <si.yanteng@linux.dev>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Cc: <xu.xin16@zte.com.cn>, <yang.yang29@zte.com.cn>, <wang.yaxin@zte.com.cn>,
        <fan.yu9@zte.com.cn>, <he.peilin@zte.com.cn>, <tu.qiang35@zte.com.cn>,
        <qiu.yutan@zte.com.cn>, <zhang.yunkai@zte.com.cn>,
        <ye.xingchen@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIwqBsaW51eCBuZXh0IDMvM10gRG9jcy96aF9DTjogVHJhbnNsYXRlIG5ldG1lbS5yc3QKIHRvIFNpbXBsaWZpZWQgQ2hpbmVzZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 55D3jmd1001870
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 684B9EF3.000/4bJQKb1v7nz8RV6H

From: Wang Yaxin <wang.yaxin@zte.com.cn>

translate the "netmem.rst" into Simplified Chinese.

Update to commit 383faec0fd64("net: enable driver support for
 netmem TX")

Signed-off-by: Wang Yaxin <wang.yaxin@zte.com.cn>
Signed-off-by: Jiang Kun <jiang.kun2@zte.com.cn>
---
 .../translations/zh_CN/networking/index.rst   |  2 +-
 .../translations/zh_CN/networking/netmem.rst  | 92 +++++++++++++++++++
 2 files changed, 93 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/networking/netmem.rst

diff --git a/Documentation/translations/zh_CN/networking/index.rst b/Documentation/translations/zh_CN/networking/index.rst
index 4cf09b60b3f0..e646b019598c 100644
--- a/Documentation/translations/zh_CN/networking/index.rst
+++ b/Documentation/translations/zh_CN/networking/index.rst
@@ -24,6 +24,7 @@
    napi.rst
    netif-msg
    xfrm_proc
+   netmem

 Todolist:

@@ -102,7 +103,6 @@ Todolist:
 *   netdev-features
 *   netdevices
 *   netfilter-sysctl
-*   netmem
 *   nexthop-group-resilient
 *   nf_conntrack-sysctl
 *   nf_flowtable
diff --git a/Documentation/translations/zh_CN/networking/netmem.rst b/Documentation/translations/zh_CN/networking/netmem.rst
new file mode 100644
index 000000000000..fe351a240f02
--- /dev/null
+++ b/Documentation/translations/zh_CN/networking/netmem.rst
@@ -0,0 +1,92 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: Documentation/networking/netmem.rst
+
+:翻译:
+
+   王亚鑫 Wang Yaxin <wang.yaxin@zte.com.cn>
+
+==================
+网络驱动支持Netmem
+==================
+
+本文档概述了网络驱动支持netmem（一种抽象内存类型）的要求，该内存类型
+支持设备内存 TCP 等功能。通过支持netmem，驱动可以灵活适配不同底层内
+存类型（如设备内存TCP），且无需或仅需少量修改。
+
+Netmem的优势：
+
+* 灵活性：netmem 可由不同内存类型（如 struct page、DMA-buf）支持，
+  使驱动程序能够支持设备内存 TCP 等各种用例。
+* 前瞻性：支持netmem的驱动可无缝适配未来依赖此功能的新特性。
+* 简化开发：驱动通过统一API与netmem交互，无需关注底层内存的实现差异。
+
+驱动RX要求
+==========
+
+1. 驱动必须支持page_pool。
+
+2. 驱动必须支持tcp-data-split ethtool选项。
+
+3. 驱动必须使用page_pool netmem API处理有效载荷内存。当前netmem API
+   与page API一一对应。转换时需要将page API替换为netmem API，并用驱动
+   中的netmem_refs跟踪内存而非 `struct page *`：
+
+   - page_pool_alloc -> page_pool_alloc_netmem
+   - page_pool_get_dma_addr -> page_pool_get_dma_addr_netmem
+   - page_pool_put_page -> page_pool_put_netmem
+
+   目前并非所有页 pageAPI 都有对应的 netmem 等效接口。如果你的驱动程序
+   依赖某个尚未实现的 netmem API，请直接实现并提交至 netdev@邮件列表，
+   或联系维护者及 almasrymina@google.com 协助添加该 netmem API。
+
+4. 驱动必须设置以下PP_FLAGS：
+
+   - PP_FLAG_DMA_MAP：驱动程序无法对 netmem 执行 DMA 映射。此时驱动
+     程序必须将 DMA 映射操作委托给 page_pool，由其判断何时适合（或不适合）
+     进行 DMA 映射。
+   - PP_FLAG_DMA_SYNC_DEV：驱动程序无法保证 netmem 的 DMA 地址一定能
+     完成 DMA 同步。此时驱动程序必须将 DMA 同步操作委托给 page_pool，由
+     其判断何时适合（或不适合）进行 DMA 同步。
+   - PP_FLAG_ALLOW_UNREADABLE_NETMEM：仅当启用 tcp-data-split 时，
+     驱动程序必须显式设置此标志。
+
+5. 驱动不得假设netmem可读或基于页。当netmem_address()返回NULL时，表示
+内存不可读。驱动需正确处理不可读的netmem，例如，当netmem_address()返回
+NULL时，避免访问内容。
+
+    理想情况下，驱动程序不应通过netmem_is_net_iov()等辅助函数检查底层
+    netmem 类型，也不应通过netmem_to_page()或netmem_to_net_iov()将
+    netmem 转换为其底层类型。在大多数情况下，系统会提供抽象这些复杂性的
+    netmem 或 page_pool 辅助函数（并可根据需要添加更多）。
+
+6. 驱动程序必须使用page_pool_dma_sync_netmem_for_cpu()代替dma_sync_single_range_for_cpu()。
+对于某些内存提供者，CPU 的 DMA 同步将由 page_pool 完成；而对于其他提供者
+（特别是 dmabuf 内存提供者），CPU 的 DMA 同步由使用 dmabuf API 的用户空
+间负责。驱动程序必须将整个 DMA 同步操作委托给 page_pool，以确保操作正确执行。
+
+7. 避免在 page_pool 之上实现特定于驱动程序内存回收机制。由于 netmem 可能
+不由struct page支持，驱动程序不能保留struct page来进行自定义回收。不过，
+可为此目的通过page_pool_fragment_netmem()或page_pool_ref_netmem()保留
+page_pool 引用，但需注意某些 netmem 类型的循环时间可能更长（例如零拷贝场景
+下用户空间持有引用的情况）。
+
+驱动TX要求
+==========
+
+1. 驱动程序绝对不能直接把 netmem 的 dma_addr 传递给任何 dma-mapping API。这
+是由于 netmem 的 dma_addr 可能源自 dma-buf 这类和 dma-mapping API 不兼容的
+源头。
+
+应当使用netmem_dma_unmap_page_attrs()和netmem_dma_unmap_addr_set()等辅助
+函数来替代dma_unmap_page[_attrs]()、dma_unmap_addr_set()。不管 dma_addr
+来源如何，netmem 的这些变体都能正确处理 netmem dma_addr，在合适的时候会委托给
+dma-mapping API 去处理。
+
+目前，并非所有的 dma-mapping API 都有对应的 netmem 版本。要是你的驱动程序需要
+使用某个还不存在的 netmem API，你可以自行添加并提交到 netdev@，也可以联系维护
+人员或者发送邮件至 almasrymina@google.com 寻求帮助。
+
+2. 驱动程序应通过设置 netdev->netmem_tx = true 来表明自身支持 netmem 功能。
-- 
2.25.1

