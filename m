Return-Path: <linux-kernel+bounces-767437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 432FAB25437
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 22:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D8E1C84C95
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 20:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9966828FFD2;
	Wed, 13 Aug 2025 20:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WZukYOpH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95C42741CD;
	Wed, 13 Aug 2025 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755115542; cv=none; b=pzG/kCUYUazIckrtUqCADV5k/X0JeuuzLR7zvvgs5TC4otEdKgr880eGJ9+6nt192My7Lzi75IVH9p3rhSfOkuRJEL6Ipou8lAlrHcxswqDWJ0GyKCexXE1FeLj8z5UneT/pLTPrMBpn00TCJrHefGo/XtRLNvgZB+Ah0hT6UkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755115542; c=relaxed/simple;
	bh=k1+6XJbQmJAorDgceaYJHUu/WClXZOLjnrpNKYfsUUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzrphc/w8uQ7QMDAeHhW7+ewYt6Y9Hw7AYE7tmswCrGEzmdjHhzJhK1hSiQMfn0JdQIjroUtgMVjFYlPFEpUaHOfzzSxhDbDFQDEnP1fJ7X5G1uuuL6OUpxfooP7/UrE7mpAlWIgjJQ+1W0n5/bX4jpoYRQLl4ifrJtz/pjueOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WZukYOpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B195C4CEEB;
	Wed, 13 Aug 2025 20:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755115542;
	bh=k1+6XJbQmJAorDgceaYJHUu/WClXZOLjnrpNKYfsUUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WZukYOpH3OzoYg5InRaitr+FIOnb1HyBWQNfCwUccBFJ9ETKMjx6kbJs0h1/WxfBg
	 tvppHGOKYO+Vt5ozKxE2LMXy8NevzBS9y4ICqOmRdWbmjjdvGOoU8UCFtixCMdHuiP
	 napN9BpQxnPZ4h0tUGUPupqNkBHDhDKTC0abnm+pFy0F/wAct1CJUPe2cOXYbnLWaW
	 MoWGcN0t7J0nKfiq4hAjJvMZfQiejuZc5VnCxPxZO4WpxY6w6O6TEgXsmKAbhDsrHq
	 PEZ79J8I4n6v3sPcsUaV4wOa5Ez3THHb5bzB44PoPft+U6c8wDe0e9MUa5/xeD6TTi
	 79QULbrRm7G8Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 4/9] Documentation: Fix core-api typos
Date: Wed, 13 Aug 2025 15:05:00 -0500
Message-ID: <20250813200526.290420-5-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813200526.290420-1-helgaas@kernel.org>
References: <20250813200526.290420-1-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

Fix typos.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/core-api/irq/irq-affinity.rst |  6 ++--
 Documentation/core-api/irq/irq-domain.rst   | 38 ++++++++++-----------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/core-api/irq/irq-affinity.rst b/Documentation/core-api/irq/irq-affinity.rst
index 29da5000836a..9cb460cf60b6 100644
--- a/Documentation/core-api/irq/irq-affinity.rst
+++ b/Documentation/core-api/irq/irq-affinity.rst
@@ -9,9 +9,9 @@ ChangeLog:
 
 /proc/irq/IRQ#/smp_affinity and /proc/irq/IRQ#/smp_affinity_list specify
 which target CPUs are permitted for a given IRQ source.  It's a bitmask
-(smp_affinity) or cpu list (smp_affinity_list) of allowed CPUs.  It's not
+(smp_affinity) or CPU list (smp_affinity_list) of allowed CPUs.  It's not
 allowed to turn off all CPUs, and if an IRQ controller does not support
-IRQ affinity then the value will not change from the default of all cpus.
+IRQ affinity then the value will not change from the default of all CPUs.
 
 /proc/irq/default_smp_affinity specifies default affinity mask that applies
 to all non-active IRQs. Once IRQ is allocated/activated its affinity bitmask
@@ -60,7 +60,7 @@ Now lets restrict that IRQ to CPU(4-7).
 This time around IRQ44 was delivered only to the last four processors.
 i.e counters for the CPU0-3 did not change.
 
-Here is an example of limiting that same irq (44) to cpus 1024 to 1031::
+Here is an example of limiting that same IRQ (44) to CPUs 1024 to 1031::
 
 	[root@moon 44]# echo 1024-1031 > smp_affinity_list
 	[root@moon 44]# cat smp_affinity_list
diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index a01c6ead1bc0..68eb2612e8a4 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -18,8 +18,8 @@ handlers as irqchips. I.e. in effect cascading interrupt controllers.
 So in the past, IRQ numbers could be chosen so that they match the
 hardware IRQ line into the root interrupt controller (i.e. the
 component actually firing the interrupt line to the CPU). Nowadays,
-this number is just a number and the number loose all kind of
-correspondence to hardware interrupt numbers.
+this number is just a number and the number has no
+relationship to hardware interrupt numbers.
 
 For this reason, we need a mechanism to separate controller-local
 interrupt numbers, called hardware IRQs, from Linux IRQ numbers.
@@ -77,15 +77,15 @@ Once a mapping has been established, it can be retrieved or used via a
 variety of methods:
 
 - irq_resolve_mapping() returns a pointer to the irq_desc structure
-  for a given domain and hwirq number, and NULL if there was no
+  for a given domain and hwirq number, or NULL if there was no
   mapping.
 - irq_find_mapping() returns a Linux IRQ number for a given domain and
-  hwirq number, and 0 if there was no mapping
+  hwirq number, or 0 if there was no mapping
 - generic_handle_domain_irq() handles an interrupt described by a
   domain and a hwirq number
 
-Note that irq domain lookups must happen in contexts that are
-compatible with a RCU read-side critical section.
+Note that irq_domain lookups must happen in contexts that are
+compatible with an RCU read-side critical section.
 
 The irq_create_mapping() function must be called *at least once*
 before any call to irq_find_mapping(), lest the descriptor will not
@@ -100,7 +100,7 @@ Types of irq_domain Mappings
 ============================
 
 There are several mechanisms available for reverse mapping from hwirq
-to Linux irq, and each mechanism uses a different allocation function.
+to Linux IRQ, and each mechanism uses a different allocation function.
 Which reverse map type should be used depends on the use case.  Each
 of the reverse map types are described below:
 
@@ -111,13 +111,13 @@ Linear
 
 	irq_domain_create_linear()
 
-The linear reverse map maintains a fixed size table indexed by the
+The linear reverse map maintains a fixed-size table indexed by the
 hwirq number.  When a hwirq is mapped, an irq_desc is allocated for
 the hwirq, and the IRQ number is stored in the table.
 
 The Linear map is a good choice when the maximum number of hwirqs is
 fixed and a relatively small number (~ < 256).  The advantages of this
-map are fixed time lookup for IRQ numbers, and irq_descs are only
+map are fixed-time lookup for IRQ numbers, and irq_descs are only
 allocated for in-use IRQs.  The disadvantage is that the table must be
 as large as the largest possible hwirq number.
 
@@ -134,7 +134,7 @@ The irq_domain maintains a radix tree map from hwirq numbers to Linux
 IRQs.  When an hwirq is mapped, an irq_desc is allocated and the
 hwirq is used as the lookup key for the radix tree.
 
-The tree map is a good choice if the hwirq number can be very large
+The Tree map is a good choice if the hwirq number can be very large
 since it doesn't need to allocate a table as large as the largest
 hwirq number.  The disadvantage is that hwirq to IRQ number lookup is
 dependent on how many entries are in the table.
@@ -169,10 +169,10 @@ Legacy
 
 The Legacy mapping is a special case for drivers that already have a
 range of irq_descs allocated for the hwirqs.  It is used when the
-driver cannot be immediately converted to use the linear mapping.  For
+driver cannot be immediately converted to use the Linear mapping.  For
 example, many embedded system board support files use a set of #defines
 for IRQ numbers that are passed to struct device registrations.  In that
-case the Linux IRQ numbers cannot be dynamically assigned and the legacy
+case the Linux IRQ numbers cannot be dynamically assigned and the Legacy
 mapping should be used.
 
 As the name implies, the \*_legacy() functions are deprecated and only
@@ -180,15 +180,15 @@ exist to ease the support of ancient platforms. No new users should be
 added. Same goes for the \*_simple() functions when their use results
 in the legacy behaviour.
 
-The legacy map assumes a contiguous range of IRQ numbers has already
+The Legacy map assumes a contiguous range of IRQ numbers has already
 been allocated for the controller and that the IRQ number can be
 calculated by adding a fixed offset to the hwirq number, and
 visa-versa.  The disadvantage is that it requires the interrupt
 controller to manage IRQ allocations and it requires an irq_desc to be
 allocated for every hwirq, even if it is unused.
 
-The legacy map should only be used if fixed IRQ mappings must be
-supported.  For example, ISA controllers would use the legacy map for
+The Legacy map should only be used if fixed IRQ mappings must be
+supported.  For example, ISA controllers would use the Legacy map for
 mapping Linux IRQs 0-15 so that existing ISA drivers get the correct IRQ
 numbers.
 
@@ -197,7 +197,7 @@ which will use a legacy domain only if an IRQ range is supplied by the
 system and will otherwise use a linear domain mapping. The semantics of
 this call are such that if an IRQ range is specified then descriptors
 will be allocated on-the-fly for it, and if no range is specified it
-will fall through to irq_domain_create_linear() which means *no* irq
+will fall through to irq_domain_create_linear() which means *no* IRQ
 descriptors will be allocated.
 
 A typical use case for simple domains is where an irqchip provider
@@ -214,7 +214,7 @@ Hierarchy IRQ Domain
 
 On some architectures, there may be multiple interrupt controllers
 involved in delivering an interrupt from the device to the target CPU.
-Let's look at a typical interrupt delivering path on x86 platforms::
+Let's look at a typical interrupt delivery path on x86 platforms::
 
   Device --> IOAPIC -> Interrupt remapping Controller -> Local APIC -> CPU
 
@@ -227,8 +227,8 @@ There are three interrupt controllers involved:
 To support such a hardware topology and make software architecture match
 hardware architecture, an irq_domain data structure is built for each
 interrupt controller and those irq_domains are organized into hierarchy.
-When building irq_domain hierarchy, the irq_domain near to the device is
-child and the irq_domain near to CPU is parent. So a hierarchy structure
+When building irq_domain hierarchy, the irq_domain nearest the device is
+child and the irq_domain nearest the CPU is parent. So a hierarchy structure
 as below will be built for the example above::
 
 	CPU Vector irq_domain (root irq_domain to manage CPU vectors)
-- 
2.43.0


