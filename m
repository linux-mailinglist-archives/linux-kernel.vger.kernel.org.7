Return-Path: <linux-kernel+bounces-898043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E488C54261
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4DA00342E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B8A350D45;
	Wed, 12 Nov 2025 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="aTwvNscC"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20652350A16
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762975799; cv=none; b=OnRaAs67uDPSPWco2O/EvJSzJ35kL58V/j70tPjdi7D87odipTfvO4QP9ykHnb5JmTYHNg4bkGCWA4HuUF3HDhM0xmyd9+6K9+5FGD5TT/q7amkqFPuDGSDo+0/obW9XWX81rrtpGDLq+l8Z//em9vCNXrn0cOxld6qMRLPaG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762975799; c=relaxed/simple;
	bh=0RDVQa7L0OnIu08nxQH3yL1ogWBg2dkj/2taZUo7yjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoUOkGuO3W8N5Lrky4Ocmrznxxv7RLpyUmg6o3xrli137Z0zacwsQmOAxo7sP7oXeEG9GuC393Dkt/6mTV0obv9jdO3KnSHFv+HUYab9xowavvTgWEyn1w+prgB27hh+l8Ahb54haEiJvv1WR+vtcXtHA2sPS+ty7FHal/KLzR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=aTwvNscC; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b28f983333so4543385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 11:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762975797; x=1763580597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nze/QytclSTH4fFVa9JSQZznz6m85tFFzurTQmWSt3g=;
        b=aTwvNscCNINUUy1Sifr92j+E6x4+KZxRLycf5i1o5rm86Fqd3MYahZywGTryVCqANs
         ZUh/JKvGp51yrCxyyTH1h1BVLSO3PGnTCADcDxHrSkHefQPVgrMpwbvjFzLfAmWVmr8f
         AL9LXgZO8hEzfx6eMenGwYlIgsi+HdAyIXQQgj3jO6Y1iJ3KwAAXHT77R3WF3yl0Bf9b
         G4UsVoMj+AaF52ZeLKLOv8QfmCyOxAaY8gBebVoQx5BeDkIhvt94Kmx6vOdBnPCY5a6c
         WSGTM34laehVBAoFnzTTNYmEYFKvsRveLuUbhpF8Kj+ReI4jl1tB8wa/toeD3Ok0f64l
         /btg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762975797; x=1763580597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Nze/QytclSTH4fFVa9JSQZznz6m85tFFzurTQmWSt3g=;
        b=aO6wMs3bACjYQPkfsVRitFmOY1iUw9gizzbmEkOVw9pcOUBZXHVpsBhi8j20OfAoRu
         knEfn98MY0FOVEk8deXRRh6Yt0XmVusNyDFFTRQU8PbO9AnvocShLuUyvGh+ZXokE6nC
         6KaF8oGcyi0gbwP+Vx4spfqRBsTeABJdJfUnArPyAz5pmWMyMWu1cjbkFr4+J5D+yD7P
         eiglU+EkHpRC9a0xQg18ryLBGd3bfQNM3+87fUT38TZENOJFERahPyd4b2IlGbhDEAwV
         SmUxwlmOZNgNZlhqJVGz9XTjIwfFY4zEWTyruOpa7R9OYNwk+CHXNZ6rATrWSfirIy5j
         JNAA==
X-Forwarded-Encrypted: i=1; AJvYcCVRzaIe6haqcTu5lwrkBKcrYKWaLTHcnZVIf3yzmV194vyNrJ5KI0RFGfDh8+QcCPNdi+47LzrlTVd0XKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB17MQ5cgLNOUVqUluM3EW6glrm9P+mzuFyjSN56YfNr9Pf+8R
	u8TyCm5v6FyD05UHeFBRp2XP3YN8lCCQu0YX4IRcb/W1G36jkxR11LOv3sJZDwff8A0=
X-Gm-Gg: ASbGncvp1O8RpHhsVG1cEN3s9ABcX3qymSMEdK5FGgkR7MLYK71/4HH+a+yQEDEpQGB
	KbaWjHe87KzkxdvfMfxdFtgoauOVfRY49G61EyCiJVVy+eXdsIAGOB6sJr+U5s1iWlcGnNCTSWN
	2xipOrvGbZB6e/KIfqrEFKlrQoQxFWgfeQnu25yiHllRGuGdGXBBNtlkIDWUXM+XBVCyuhZqnQL
	ic8L33pOtY0Sa9kiByttikBW1pOo7jWhdIyztql12dXu1fAfZp8BPh6N5oVMl3qIll9yclPA0qy
	IKLdmsPjYzLkfXA0ygMYfDkwFutVUoOxrdmz7IBCMJByuaBpyh/UK7qWytk5NhBiCnA1B3A0302
	10DOWqoquoxHWtfwzVB/qzfyyeGkjYIu+LtL+HFEyMls4MYZ593Gbi0ZuQN9vECXUUqcE5P8aEY
	bi4eLY/g0xGDHuqkYrkMEaNNhpiG5YjgvfCwowWmhqVUbvXflIMta3UPPNvZVC+StE
X-Google-Smtp-Source: AGHT+IH1lDcByGDzgs1svKTRXfQs8NRaQexk4Q0+NImfdOthU+jf0vqFA5hw/PqFsiRTGmnVj1m8eQ==
X-Received: by 2002:a05:620a:1a0f:b0:890:2e24:a543 with SMTP id af79cd13be357-8b29b77b3c0mr590594985a.34.1762975796840;
        Wed, 12 Nov 2025 11:29:56 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F.lan (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa0082esm243922885a.50.2025.11.12.11.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 11:29:56 -0800 (PST)
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
Subject: [RFC PATCH v2 03/11] gfp: Add GFP_SPM_NODE for Specific Purpose Memory (SPM) allocations
Date: Wed, 12 Nov 2025 14:29:19 -0500
Message-ID: <20251112192936.2574429-4-gourry@gourry.net>
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

GFP_SPM_NODE changes the nodemask checks in the page allocator to include
the full set memory nodes, rather than just SysRAM nodes.

Signed-off-by: Gregory Price <gourry@gourry.net>
---
 include/linux/gfp_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/gfp_types.h b/include/linux/gfp_types.h
index 65db9349f905..525ae891420e 100644
--- a/include/linux/gfp_types.h
+++ b/include/linux/gfp_types.h
@@ -58,6 +58,7 @@ enum {
 #ifdef CONFIG_SLAB_OBJ_EXT
 	___GFP_NO_OBJ_EXT_BIT,
 #endif
+	___GFP_SPM_NODE_BIT,
 	___GFP_LAST_BIT
 };
 
@@ -103,6 +104,7 @@ enum {
 #else
 #define ___GFP_NO_OBJ_EXT       0
 #endif
+#define ___GFP_SPM_NODE		BIT(___GFP_SPM_NODE_BIT)
 
 /*
  * Physical address zone modifiers (see linux/mmzone.h - low four bits)
@@ -145,6 +147,8 @@ enum {
  * %__GFP_ACCOUNT causes the allocation to be accounted to kmemcg.
  *
  * %__GFP_NO_OBJ_EXT causes slab allocation to have no object extension.
+ *
+ * %__GFP_SPM_NODE allows the use of Specific Purpose Memory Nodes
  */
 #define __GFP_RECLAIMABLE ((__force gfp_t)___GFP_RECLAIMABLE)
 #define __GFP_WRITE	((__force gfp_t)___GFP_WRITE)
@@ -152,6 +156,7 @@ enum {
 #define __GFP_THISNODE	((__force gfp_t)___GFP_THISNODE)
 #define __GFP_ACCOUNT	((__force gfp_t)___GFP_ACCOUNT)
 #define __GFP_NO_OBJ_EXT   ((__force gfp_t)___GFP_NO_OBJ_EXT)
+#define __GFP_SPM_NODE	((__force gfp_t)___GFP_SPM_NODE)
 
 /**
  * DOC: Watermark modifiers
-- 
2.51.1


