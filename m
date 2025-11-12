Return-Path: <linux-kernel+bounces-898048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3ADEC5428E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0342D34A7EC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEB934F495;
	Wed, 12 Nov 2025 19:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="pmyCQB+I"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DC352F8D
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975815; cv=none; b=rTj/APBqVDO89ENA/6z/8BIFEzmZ682ptmZhb1QrrbPYELBWY26DKFFOuJPLSqgWQrQv/PhW9hjIb1KY2S9TEEdub2tSGaMje7hBjKFSyl/a2IKQKR08LokaiThH56Z9KWYROn4Wmve6E/GfS5xP3uEAIiATDUVVFZxVwblIMWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975815; c=relaxed/simple;
	bh=CCv29ioHuBPEaztDjypCZpSL1ZEuoaIx0rBLzpHAvqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbKS6vqUCK1hHbuV/L6g1gs6LaQkDoQWgAfhztGeF/psfBmwNS5Dd/Mm85m9OeZKVhL4MqmrDs0XXNsY2oBJHXgx9kwsNvYzzLCozZND8peAQsiRFv16Pj7gKONui4AoD4Qhqk5SInbP3AnSVYj1uETk8Kk60VF/B2CVfb4S338=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=pmyCQB+I; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-88e51cf965dso4383685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975812; x=1763580612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nmy6EhUdgU0DNpQaVrJpBZ6lZ48+dr4nIpOCH6X0C1w=;
        b=pmyCQB+Ik15ItccoSBlwNS2FTNxFwsEeYFliMScoNTWXSxdC20VqNEKlWbBuJlgbK+
         bmjs5VcEGpJJvAWqhlzgvX55be1Dn5/UL47vanr9YF292sJ+5lpDVdNRvc4Y896vrVQf
         rJemvkqVbEc8WLvoRCYiXRHMj+ET6hG883YJaus4EOTukTQK5NWRNrxjAPqdb2/3uk7d
         XZKgkbAmyJhRDF+eJ78sUGWdLtjnNW/VFMXNlpxnrhgX21V4/u+c+Q8hiTgI1XRwOyzH
         B8A5bVfGZvq3U6zj/6eT8Hksw8be2UolaWSddsTRHPxNTyejpLooxk8DsYhO21SB0/60
         8C2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975812; x=1763580612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nmy6EhUdgU0DNpQaVrJpBZ6lZ48+dr4nIpOCH6X0C1w=;
        b=mLU0wUb5Z8F2+/HLT2eJgq00aLzIkTl06JMcnffaiBuODtJJnU0dwNLaVoNTvOx1z4
         cG1sbqDHpql0vtlt0vdoM4XiJfa3hCNPMjrRipZ0JDuL7syc9Wz4je9i8f0WE9nFz6kt
         nvzJp1OUiJ3fP6oDUpGLE5ik6gxqd3toENI2+RCdga8uWKZc+EAIzM2oi5JlBswrQwzj
         2acFCkte4Vmc9US/FYedglckfRaVTeBmVYL/CeZz3B/b7zWtEXyofJJ+7RastdqP8WoE
         37qjRARcqIQS1FcXQnfUHYQgRmMO8eascbtziaHoaLkk2abkuaXhhkmQ6cPgeeCtzupL
         OYLw==
X-Forwarded-Encrypted: i=1; AJvYcCXeLN5Ewm8ffEhNE+xH5ERSD+HwLFSqGn11/9N+1aLdsZh1mIjP9hywhd27irU+EUXEQkEtQZx73FEFNcc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+bH0FOk0gZlzFmSxyvHsLhULhhoADy+a5V6bxodbmFKoci5R/
	mDL6fdHocE9Dkb4XQDXG+g/hJLZ+qO3KdR8HNEpdoSxIn0LTG1T0FdlQ4ocAKoEgTKY=
X-Gm-Gg: ASbGncuTRVthtn1IAVZl9wedtfw8Z4/IrNaSCMfMZw1yUGU6B+5+eDu2jG4TiYcT60I
	CYX5GLvPam5FvxXNJpL3Gs7PDOUtGX/gPjpC4xw8EByV1xOfxPuZNK6H7CXnU9KQFmfhXeR53dQ
	EN4TGvQq1K/ffDuSXPOGIM2vTobVxxPDAjKDPxjlkTuiXBAFRc8pAvudeIWKgH1XKkcln4fSbfs
	/Iad2XGIwk6fKbdLPx2gOIwtpq+iLJnW0TEotqNNuy+HELCF0w5HlTRzklXJTcB7eljQi8FrGNC
	dQbSnxyaXC/ZE0SAdFNGyvgt0aUpBAmbmvVwznQ+bDtg+H3FsGiA7YdFWd3cK1p2yhFcCNBTdzc
	HbspVMpN8tDfMy0TiPsWeQl3ezhMB1NqFmjifIfXzW+U2BsN2VsvzMQWNKcoX8gG8QhNG/J6Zxx
	3ASltU5srUg9kKQ2UDrjLFsP1SOCT1gKmfKadqcyJzU7preQQgFXWqJR+YS9bf5nL9
X-Google-Smtp-Source: AGHT+IHrguqekTBYRBdFA9dxH70A9CcZsL7BjLOY758kp78A0w22ToZorWvEFBPVQ4lklZwp+U9JIA==
X-Received: by 2002:a05:620a:29ca:b0:8a3:d644:6944 with SMTP id af79cd13be357-8b29b74d7c0mr602392885a.5.1762975812194;
        Wed, 12 Nov 2025 11:30:12 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:30:11 -0800 (PST)
From: Gregory Price <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: kernel-team@meta.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	cgroups@vger.kernel.org,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	longman@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	osalvador@suse.de,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	kees@kernel.org,
	muchun.song@linux.dev,
	roman.gushchin@linux.dev,
	shakeel.butt@linux.dev,
	rientjes@google.com,
	jackmanb@google.com,
	cl@gentwo.org,
	harry.yoo@oracle.com,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	zhengqi.arch@bytedance.com,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	fabio.m.de.francesco@linux.intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com,
	usamaarif642@gmail.com,
	brauner@kernel.org,
	oleg@redhat.com,
	namcao@linutronix.de,
	escape@linux.alibaba.com,
	dongjoo.seo1@samsung.com
Subject: [RFC PATCH v2 08/11] mm/memory_hotplug: add MHP_SPM_NODE flag
Date: Wed, 12 Nov 2025 14:29:24 -0500
Message-ID: <20251112192936.2574429-9-gourry@gourry.net>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251112192936.2574429-1-gourry@gourry.net>
References: <20251112192936.2574429-1-gourry@gourry.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for Specific Purpose Memory (SPM) NUMA nodes.

A SPM node is managed by the page allocator, but can only allocated
by using the __GFP_SP_NODE flag with an appropriate nodemask.

Check/Set the node type (SysRAM vs SPM) at hotplug time.
Disallow SPM from being added to SysRAM nodes and vice-versa.

This prevents normal allocation paths (page faults, kmalloc, etc)
from being directly exposed to these memories, and provides a clear
integration point for buddy-allocation of SPM memory.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/memory_hotplug.h | 10 ++++++++++
 mm/memory_hotplug.c            |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 23f038a16231..a50c467951ba 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -74,6 +74,16 @@ typedef int __bitwise mhp_t;
  * helpful in low-memory situations.
  */
 #define MHP_OFFLINE_INACCESSIBLE	((__force mhp_t)BIT(3))
+/*
+ * The hotplugged memory can only be added to a "Specific Purpose Memory"
+ * NUMA node.  SPM Nodes are not generally accessible by the page allocator
+ * by way of userland configuration - as most nodemask interfaces
+ * (mempolicy, cpusets) restrict nodes to SysRAM nodes.
+ *
+ * Hotplugging SPM into a SysRAM Node results in -EINVAL.
+ * Hotplugging SysRAM into a SPM Node results in -EINVAL.
+ */
+#define MHP_SPM_NODE	((__force mhp_t)BIT(4))
 
 /*
  * Extended parameters for memory hotplug:
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 0be83039c3b5..488cdd8e5f6f 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -20,6 +20,7 @@
 #include <linux/memory.h>
 #include <linux/memremap.h>
 #include <linux/memory_hotplug.h>
+#include <linux/memory-tiers.h>
 #include <linux/vmalloc.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
@@ -1529,6 +1530,12 @@ int add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 
 	mem_hotplug_begin();
 
+	/* Set the NUMA node type and bail out if the type is wrong */
+	ret = mt_set_node_type(nid, (mhp_flags & MHP_SPM_NODE) ?
+				    MT_NODE_TYPE_SPM : MT_NODE_TYPE_SYSRAM);
+	if (ret)
+		goto error_mem_hotplug_end;
+
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
 		if (res->flags & IORESOURCE_SYSRAM_DRIVER_MANAGED)
 			memblock_flags = MEMBLOCK_DRIVER_MANAGED;
-- 
2.51.1


